Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1649543FA2
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 01:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiFHXAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiFHXAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 19:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B830AB58;
        Wed,  8 Jun 2022 16:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5104B82A37;
        Wed,  8 Jun 2022 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F93C34116;
        Wed,  8 Jun 2022 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654729212;
        bh=JZmu1SU0V7QTJVGAH6DytmdJ+Pdq1qgCXSsZHp2+VrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxkKU2M+F1uHGb88/xUI3l2cG2eaZbSugK6S2ZLDZgBR04f1POAM5WriFpil6k1m5
         vWsdLd0ogrmYqVquWWc0LbfhbnEgJ4ZIilcmq1odq1oR49b32xtGOvjOOunClU3V1d
         YoTp9EKrdo2/CWayu/YtvWfrIdk9A5qPUK/OwMl7BIPNF4F+qiwIW+4i1o4IKGHTYX
         sD9rxvKl1K+OW+XfzSVeLoZAYGoJaJbp3yPC5iYDKEuIWoTRroVbcqOog3x4KsEvpm
         WGMWgVFrjIR35XCg0ilfsBFCKzvWxwxhaFKfGxwkdZPKZlFsaqqLwcbsI6PKzxr/CL
         vZtZTcLENaGOw==
Received: by pali.im (Postfix)
        id E913D2191; Thu,  9 Jun 2022 01:00:08 +0200 (CEST)
Date:   Thu, 9 Jun 2022 01:00:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 2/3] PCI: qcom: Define slot capabilities using
 PCI_EXP_SLTCAP_*
Message-ID: <20220608230008.acp6lwu6xjin62ql@pali>
References: <cover.1644234441.git.baruch@tkos.co.il>
 <f452d0d28482462557485805d708b9adb9e0f6c0.1644234441.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f452d0d28482462557485805d708b9adb9e0f6c0.1644234441.git.baruch@tkos.co.il>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 07 February 2022 16:51:25 Baruch Siach wrote:
> From: Baruch Siach <baruch.siach@siklu.com>
> 
> The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
> PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
> describe its meaning.
> 
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c19cd506ed3f..01e58b057d2a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -69,7 +69,18 @@
>  #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
>  #define CFG_BRIDGE_SB_INIT			BIT(0)
>  
> -#define PCIE_CAP_LINK1_VAL			0x2FD7F
> +#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		0x7D00
> +#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		0x8000

Hello!

Please do not use hardcoded values for slot power limit value and scale
numbers. There are macros PCI_EXP_SLTCAP_SPLV and PCI_EXP_SLTCAP_SPLS
for composing mask:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h?h=v5.19-rc1#n593
Which could be used together with FIELD_PREP(). See e.g. aardvark commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d5b8c298545c827ca9f2461b2655277ce0aef79

And the important information: Slot power limit is board specific and
depends on how power supply and power regulators are designed. So slot
power limit **cannot** be hardcoded in driver. Instead this value should
be read from device tree file for the current board.

There is a new kernel function of_pci_get_slot_power_limit() which reads
it and compose PCIe slot power limit value and scale numbers. See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of.c?h=v5.19-rc1#n631

> +#define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
> +						PCI_EXP_SLTCAP_PCP | \
> +						PCI_EXP_SLTCAP_MRLSP | \
> +						PCI_EXP_SLTCAP_AIP | \
> +						PCI_EXP_SLTCAP_PIP | \
> +						PCI_EXP_SLTCAP_HPS | \
> +						PCI_EXP_SLTCAP_HPC | \
> +						PCI_EXP_SLTCAP_EIP | \
> +						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
> +						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
>  
>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>  
> @@ -1111,7 +1122,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  
>  	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
>  	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
> -	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>  
>  	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
>  	val &= ~PCI_EXP_LNKCAP_ASPMS;
> -- 
> 2.34.1
> 
