Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45138544677
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiFIIvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbiFIIuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 04:50:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E7142A85;
        Thu,  9 Jun 2022 01:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A8E617E1;
        Thu,  9 Jun 2022 08:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DD8C34114;
        Thu,  9 Jun 2022 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764434;
        bh=a13ggRjGVBRX1EjOqKbLw/ekdwdTjL720ODOeBxI9BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUvVrkgPPd3Zj3VJPt+FGoRskkrsqai75NqtYEk54Pk/eq2JNCllJ97/SSmVXFqI5
         73KtLjL3mAhx5uJZjLurQ6612ktdWjnCAg8ez+kz8jPRGjroBADUCg51YmYi07ycCN
         SO1eoeEUc1DHqHRwwjVkIGij3dUfgbSIV2coIHMxazRf0OgpSXHOABf34aLgbAliev
         oibNN8XnkWzMK95H9jg1MraXMPYF9csvNpxLyJj7j2+RyxNhvblVKcPtDHQ24jUe6f
         A9/FAbUhU5q2KrUJZSn2Jh6AjaBzAzekDga+AmQJFC4LtRCVv1rmjOzq8iGlWD6gVZ
         +NqZSN3Z8zScA==
Received: by pali.im (Postfix)
        id E79682104; Thu,  9 Jun 2022 10:47:10 +0200 (CEST)
Date:   Thu, 9 Jun 2022 10:47:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v6 2/3] PCI: qcom: Define slot capabilities using
 PCI_EXP_SLTCAP_*
Message-ID: <20220609084710.qpqdaid56l6crdpq@pali>
References: <cover.1644234441.git.baruch@tkos.co.il>
 <f452d0d28482462557485805d708b9adb9e0f6c0.1644234441.git.baruch@tkos.co.il>
 <20220608230008.acp6lwu6xjin62ql@pali>
 <87r13ymrf2.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r13ymrf2.fsf@tarshish>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 09 June 2022 06:27:34 Baruch Siach wrote:
> Hi Pali,
> 
> On Thu, Jun 09 2022, Pali Rohár wrote:
> > On Monday 07 February 2022 16:51:25 Baruch Siach wrote:
> >> From: Baruch Siach <baruch.siach@siklu.com>
> >> 
> >> The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
> >> PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
> >> describe its meaning.
> >> 
> >> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++--
> >>  1 file changed, 13 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index c19cd506ed3f..01e58b057d2a 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -69,7 +69,18 @@
> >>  #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
> >>  #define CFG_BRIDGE_SB_INIT			BIT(0)
> >>  
> >> -#define PCIE_CAP_LINK1_VAL			0x2FD7F
> >> +#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		0x7D00
> >> +#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		0x8000
> >
> > Hello!
> >
> > Please do not use hardcoded values for slot power limit value and scale
> > numbers. There are macros PCI_EXP_SLTCAP_SPLV and PCI_EXP_SLTCAP_SPLS
> > for composing mask:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h?h=v5.19-rc1#n593
> > Which could be used together with FIELD_PREP(). See e.g. aardvark commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d5b8c298545c827ca9f2461b2655277ce0aef79
> 
> Thanks for the tip.
> 
> > And the important information: Slot power limit is board specific and
> > depends on how power supply and power regulators are designed. So slot
> > power limit **cannot** be hardcoded in driver. Instead this value should
> > be read from device tree file for the current board.
> >
> > There is a new kernel function of_pci_get_slot_power_limit() which reads
> > it and compose PCIe slot power limit value and scale numbers. See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of.c?h=v5.19-rc1#n631
> 
> The 'slot-power-limit-milliwatt' property appears to be undocumented as
> of v5.19-rc1.

slot-power-limit-milliwatt is already documented in DT scheme pci-bus, see:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus.yaml

> This patch should make no functional change. I guess we should keep the
> default hard-coded driver value for compatibility with existing DTs with
> no 'slot-power-limit-milliwatt'.
> 
> Thanks,
> baruch
> 
> >> +#define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
> >> +						PCI_EXP_SLTCAP_PCP | \
> >> +						PCI_EXP_SLTCAP_MRLSP | \
> >> +						PCI_EXP_SLTCAP_AIP | \
> >> +						PCI_EXP_SLTCAP_PIP | \
> >> +						PCI_EXP_SLTCAP_HPS | \
> >> +						PCI_EXP_SLTCAP_HPC | \
> >> +						PCI_EXP_SLTCAP_EIP | \
> >> +						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
> >> +						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
> >>  
> >>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
> >>  
> >> @@ -1111,7 +1122,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >>  
> >>  	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
> >>  	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
> >> -	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >> +	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >>  
> >>  	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> >>  	val &= ~PCI_EXP_LNKCAP_ASPMS;
> >> -- 
> >> 2.34.1
> >> 
> 
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
