Return-Path: <linux-pci+bounces-43746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA4CDF1E3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 00:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1410F3007977
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595618E1F;
	Fri, 26 Dec 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFzdRvYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8E14A8B;
	Fri, 26 Dec 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766792398; cv=none; b=fcqV6dWUOImvCno6dEfpINZAPRIdC+W1fiS3CdRVBXwKRIANogi4zRWnDzzBejMSXGoS5DLZq+vr05eGcZU1vbT2ZvZ1equwm3EZCjmLHeDGF1x/lK79iuuL27V/0wm1EID4W5Q2CxCLXVXPpwRy1i3HGm6h0xeiRg6x4Ar99Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766792398; c=relaxed/simple;
	bh=IGzW9PeTCyainO8f564kG2zb360TkJrmgORhB/orDec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DBDKMaZvMoN1+77+E740cXn6vsBW+8yK9tfmH3JOgykkFoO+5AL/1CFhicnW1WsYruKuRSRNIf+2B8u6RXypTZcd1easXVpIiPhzgnWyQCwRuSclCeQB5cfV3zHwvLXiRElQa6vv0ulvovem5FR7jOeBM5G5/x8b4obg+6eCJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFzdRvYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6842EC4CEF7;
	Fri, 26 Dec 2025 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766792397;
	bh=IGzW9PeTCyainO8f564kG2zb360TkJrmgORhB/orDec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qFzdRvYsJTIRsxQkZYOci1taoJdf7zEuZYI0EIWTF5KPM2rfDA+3O4kMk47e2Twj9
	 WUAoQTzftwqAeMGjTDMqUQSFnEcUHdZHEQBDqy3mluONDZlJKFbfd4SGRqk+w++NDj
	 ucSUxV66rIbyBUJcfAfPzE6oOMqD4NPBClKQZltcYOtH04wKOrBf0h4msbOiYZVuZM
	 XBaY69nZ8ic0eca2jtKGdJ9JFvQ0ptN838fLZjUzzFYii/rXMgYZW4ow13VkJNDOs6
	 avOUZ9TxUQbxaZPULMCfYX9IYZP+uiF53YWpqIHSNo2DqVvgxzyWQgdCU+cxfbKTqe
	 2qHtH86gxUz7Q==
Date: Fri, 26 Dec 2025 17:39:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Val Packett <val@packett.cool>
Subject: Re: [PATCH] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
Message-ID: <20251226233955.GA4148273@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126081718.8239-1-mani@kernel.org>

[+cc Val]

On Wed, Nov 26, 2025 at 01:47:18PM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Though I couldn't confirm the ASPM L0s support with the Qcom hardware team,
> bug report from Dmitry suggests that L0s is broken on this legacy SoC.
> Hence, clear the L0s CAP for the Root Ports in this SoC.

I'm squinting a little bit about a Qcom engineer not being able to
confirm whether L0s is known to work on a Qcom part :)

This looks like possible v6.19 material since it's a regression and
Dmitry reported random resets that are impossible to debug?

For now I moved this to the beginning of pci/controller/dwc-qcom since
it sounds like the PERST# series will be updated.

> Since qcom_pcie_clear_aspm_l0s() is now used by more than one SoC config,
> call it from qcom_pcie_host_init() instead.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pci/4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eb..25399d47fc40 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1088,7 +1088,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
>  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
>  
> -	qcom_pcie_clear_aspm_l0s(pcie->pci);
>  	qcom_pcie_clear_hpc(pcie->pci);
>  
>  	return 0;
> @@ -1350,6 +1349,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_disable_phy;
>  	}
>  
> +	qcom_pcie_clear_aspm_l0s(pcie->pci);
> +
>  	qcom_ep_reset_deassert(pcie);
>  
>  	if (pcie->cfg->ops->config_sid) {
> @@ -1486,6 +1487,7 @@ static const struct qcom_pcie_cfg cfg_2_1_0 = {
>  
>  static const struct qcom_pcie_cfg cfg_2_3_2 = {
>  	.ops = &ops_2_3_2,
> +	.no_l0s = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_2_3_3 = {
> -- 
> 2.48.1
> 

