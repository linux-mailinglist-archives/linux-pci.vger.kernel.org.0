Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6FA659991
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 16:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiL3PGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 10:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiL3PGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 10:06:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A293926CD;
        Fri, 30 Dec 2022 07:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AD261645;
        Fri, 30 Dec 2022 15:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9214C433D2;
        Fri, 30 Dec 2022 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672412790;
        bh=3kPO/3wUG3NhS8YG/IDUutQVQrCByrd2HZYweEvJbb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AW+kwtdDdDwXE/189me/RYm6HzvCRK8e4hH+2w+WjGoABPZR3u4QmMVs0Xuh0CcML
         A51SvpXxRxgjYA+M8LfLHFsj49SHfIRHPWQqDuQ/0fiZZAYa6OAGrhEdDtMyl8Dc+Q
         jUVxA17UEkgQq12tLRzzY0fIzSmBeEMaMsMQDxQCDYKRPhT4NbC9Pz6D+jdf+V+rv6
         hJ5BkHQ67E4RZugdbNV9QoetJ+kUDS0mS0cs4jixhsCOnxq5jeERoW8d4iSqBacr+J
         DA0J+ZY1QtHMF2SPJlm74qJ8k9ZpCjRM4GoX9qqsl7iROIOJmAtLXYNVKgurpSLqSt
         pYPkBnhah6YBw==
Date:   Fri, 30 Dec 2022 16:06:24 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
 suspend and resume
Message-ID: <Y67+cH15frjqK2vA@lpieralisi>
References: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 02:05:34PM +0800, Richard Zhu wrote:
> The MSI Enable bit controls delivery of MSI interrupts from components
> below the Root Port. This bit might lost during the suspend, should be
> re-stored during resume.
> 
> Save the MSI control during suspend, and restore it in resume.

I believe that what Lucas and Bjorn asked on v1 is still not answered.

The root port is a PCI device, why do we need to save and restore the
MSI cap on top of what PCI core already does ? The RP should be
enumerated as a PCI device and therefore I expect the MSI cap to
be saved/restored in the suspend/resume execution.

I don't think there is anything iMX6 specific in this.

Would you mind investigating it please ?

Lorenzo

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> Changes v1-->v2:
> New create one save/restore function, used save the setting in suspend and
> restore the configuration in resume.
> v1 https://patchwork.kernel.org/project/linux-pci/patch/1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com/
> 
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1dde5c579edc..aa3096890c3b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -76,6 +76,7 @@ struct imx6_pcie {
>  	struct clk		*pcie;
>  	struct clk		*pcie_aux;
>  	struct regmap		*iomuxc_gpr;
> +	u16			msi_ctrl;
>  	u32			controller_id;
>  	struct reset_control	*pciephy_reset;
>  	struct reset_control	*apps_reset;
> @@ -1042,6 +1043,26 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> +static void imx6_pcie_msi_save_restore(struct imx6_pcie *imx6_pcie, bool save)
> +{
> +	u8 offset;
> +	u16 val;
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +
> +	if (pci_msi_enabled()) {
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +		if (save) {
> +			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> +			imx6_pcie->msi_ctrl = val;
> +		} else {
> +			dw_pcie_dbi_ro_wr_en(pci);
> +			val = imx6_pcie->msi_ctrl;
> +			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> +			dw_pcie_dbi_ro_wr_dis(pci);
> +		}
> +	}
> +}
> +
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> @@ -1050,6 +1071,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
> +	imx6_pcie_msi_save_restore(imx6_pcie, true);
>  	imx6_pcie_pm_turnoff(imx6_pcie);
>  	imx6_pcie_stop_link(imx6_pcie->pci);
>  	imx6_pcie_host_exit(pp);
> @@ -1069,6 +1091,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  	ret = imx6_pcie_host_init(pp);
>  	if (ret)
>  		return ret;
> +	imx6_pcie_msi_save_restore(imx6_pcie, false);
>  	dw_pcie_setup_rc(pp);
>  
>  	if (imx6_pcie->link_is_up)
> -- 
> 2.25.1
> 
