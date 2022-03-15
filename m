Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C54D9C5B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiCONh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 09:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCONh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 09:37:28 -0400
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 06:36:15 PDT
Received: from mail.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E552E30;
        Tue, 15 Mar 2022 06:36:15 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 4666F440F5D;
        Tue, 15 Mar 2022 15:30:16 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1647351016;
        bh=CY+SaTv7DiySVo1WF/fc6BtFxgmDymR8eVZ4mS1oh5Y=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=gOtJ0xeGrT6X4sG3OuUhtwFr4RC7qy0HKBzBxGRnChmoAKtJLujpBBBCIfsjJ2eSX
         ZVoceqcIQxEVaerH6WmxeOdj7ov425txeWr+/3DAzNILvM/qJcpPCA6Gvi/JPD9DeM
         S6OKPfDVAcDGKqgk9G72Vvh6a07zhlyM6PuGvevEIXlwdCT8ILlAGC7bL+/c0R6RNZ
         yOz0RtNGDov/C+CCspHQbbGvO+w0fYNr0Un/rq9Uxuwgksn+hh/tn0U7kHg1AxgnOS
         TVnUuOtsIYk0+0fUhQp1tQMtBoaiEXdLsGiDM6JlebA85lJkM31c5aDw+Rcmmp8KiA
         zt6WjBMa/HhYw==
References: <cover.1644234441.git.baruch@tkos.co.il>
 <20220211160645.GA448@lpieralisi>
 <CA+HBbNEham1bukiEv5Px2=fCnqnbBKWBy3xOKe89fioQWttoGg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: IPQ6018 platform support
Date:   Tue, 15 Mar 2022 15:20:54 +0200
In-reply-to: <CA+HBbNEham1bukiEv5Px2=fCnqnbBKWBy3xOKe89fioQWttoGg@mail.gmail.com>
Message-ID: <874k3zbaxc.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robert,

On Tue, Mar 15 2022, Robert Marko wrote:
> On Fri, Feb 11, 2022 at 5:06 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> On Mon, Feb 07, 2022 at 04:51:23PM +0200, Baruch Siach wrote:
>> > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is
>> > ported from downstream Codeaurora v5.4 kernel. The main difference from
>> > downstream code is the split of PCIe registers configuration from .init to
>> > .post_init, since it requires phy_power_on().
>> >
>> > Tested on IPQ6010 based hardware.
[snip]
>> >
>> > Baruch Siach (2):
>> >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
>> >   PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
>> >
>> > Selvam Sathappan Periakaruppan (1):
>> >   PCI: qcom: Add IPQ60xx support
>> >
>> >  drivers/pci/controller/dwc/pcie-designware.h |   7 +
>> >  drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
>> >  drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
>> >  3 files changed, 160 insertions(+), 8 deletions(-)
>>
>> Bjorn, Andy,
>>
>> Can you ACK please if this series is ready to be merged ?
>
> This would also help the IPQ8074 which has the same controller for the
> Gen3 port.
>
> I have been using this for OpenWrt for a while and it works.

Thanks for your test report.

It would be nice to have a formal Tested-by for the pcie-qcom.c
patch. It might help to push the patch forward.

Can you also share the device-tree part? I'll add it to this series in
case it needs a respin.

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
