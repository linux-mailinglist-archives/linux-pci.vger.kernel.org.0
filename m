Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA753F7725
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbhHYOYl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 10:24:41 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43884 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241546AbhHYOY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 10:24:28 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id CE408440E88;
        Wed, 25 Aug 2021 17:23:29 +0300 (IDT)
References: <cover.1620203062.git.baruch@tkos.co.il>
 <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
 <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com>
 <87o89lahqp.fsf@tarshish>
 <CAL_Jsq+wkTbGjyk_i-_1Sad80xcJwAFdf5gBTGBR_TORRA-AoQ@mail.gmail.com>
User-agent: mu4e 1.6.3; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
Date:   Wed, 25 Aug 2021 17:09:49 +0300
In-reply-to: <CAL_Jsq+wkTbGjyk_i-_1Sad80xcJwAFdf5gBTGBR_TORRA-AoQ@mail.gmail.com>
Message-ID: <87lf4pa9i0.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Wed, Aug 25 2021, Rob Herring wrote:
> On Wed, Aug 25, 2021 at 6:25 AM Baruch Siach <baruch@tkos.co.il> wrote:
>> On Fri, Aug 06 2021, Rob Herring wrote:
>> > On Wed, May 5, 2021 at 3:18 AM Baruch Siach <baruch@tkos.co.il> wrote:
>> >> +       writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
>> >> +                       PCI_EXP_DEVCTL2);
>> >> +
>> >> +       writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
>> >> +                       pci->dbi_base + offset + PCI_EXP_DEVCTL2);
>> >
>> > Doesn't this overwrite the prior register write?
>>
>> It does. There are two mistakes here. The writel() above should set
>> PCIE20_DEVICE_CONTROL2_STATUS2 (offset 0x98).
>
> No. Did you check what 'offset' is? PCIE20_DEVICE_CONTROL2_STATUS2 is
> PCI_EXP_DEVCTL2 plus the status reg. What's wrong is it should be a
> 16-bit write.

Thanks for enlightening me. 'offset' is 0x70 here. So PCI_EXP_DEVCTL2 is
at 0x98, and PCI_EXP_LNKCTL2 is at 0xa0. Only the second writel() is
wrong. But since generic code handles speed, I can drop it entirely.

I see that dw_pcie_link_set_max_speed() uses dw_pcie_writel_dbi() to
write to PCI_EXP_LNKCTL2. Is that 16-bit write?

Why are pci_regs.h register offsets in decimal?

>> This writel() should set
>> PCIE20_LNK_CONTROL2_LINK_STATUS2 (offset 0xa0). So both are wrong.

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
