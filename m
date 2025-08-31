Return-Path: <linux-pci+bounces-35195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537EB3D35E
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 14:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507BB17E0E8
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8F25BEE5;
	Sun, 31 Aug 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM+sdTic"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CECC25333F;
	Sun, 31 Aug 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756644322; cv=none; b=I9WsnmdexksXrHL/YxnLAumY3GZPzHEt6YqrrumVqn3YZjAmiOs3V8XjRKu5xfPN3aNUCbGUprhJD2HwI09xAd63z7tEDSzHD+p9OMul8yxqzZhpIZ2hIGqauc8TTixe6u71QUNZPb3HmcO+3dlWACeu8OuMML7M0K0m6gPKTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756644322; c=relaxed/simple;
	bh=j8zEHiKo/duY7tUu4UrzzTl6RAMNLEJ5SUnWOsj1FVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAzw5HLAaOlZun1DGlyK/1DmA8+LxvLWAr+njT4UkZh0cR0JRSuSEctgST8yhLl2Is76e1z4Bk2s0pqOo2s4T3fNQoWZlKKGu9CE5fbCgzkafeuZc5FQy1Osl/SjbVEMMyy/YBwM/x5GAjcT7ddMvjXiP0C4cqJQBgPzG0fVj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM+sdTic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF89C4CEED;
	Sun, 31 Aug 2025 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756644322;
	bh=j8zEHiKo/duY7tUu4UrzzTl6RAMNLEJ5SUnWOsj1FVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DM+sdTicjOy2wpuEeqSXiwIXMY8RTOMLwWBAxknRduz174iodwPxTLQEV3OhYLS07
	 sqwk72JrTgJpXV+JE+IDtjyzrs/t3p1Pc2vqWpBZpO7Jd1mfEY6ZVjm+WVxGOoRFHC
	 Y3GrzBTOQSrEEaGe1qqpi+xzMIvPoyIvS3W8Li/aK58AAWfLcz2FD7drjF/T/fmxoO
	 cTrVldVxFWwAoJ4BNo/JSIflTqMcAPECue9lu7VHWa0P+zgzFX883B2asgpwRdwx9V
	 OohgznRUslYqvaNc5LzMNRHqQk33vuKV1emAQB/PWMt0cujaUzUMpgZm5g2zt3iZA3
	 pMsYVHgU6jQfg==
Date: Sun, 31 Aug 2025 18:15:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, helgaas@kernel.org, kishon@kernel.org, vigneshr@ti.com, 
	stable@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
References: <20250829091707.2990211-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829091707.2990211-1-s-vadapalli@ti.com>

On Fri, Aug 29, 2025 at 02:46:28PM GMT, Siddharth Vadapalli wrote:
> The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
> Root-Complex and Endpoint modes of operation. The Glue Layer allows
> "strapping" the Mode of operation of the Controller, the Link Speed
> and the Link Width. This is enabled by programming the "PCIEn_CTRL"
> register (n corresponds to the PCIe instance) within the CTRL_MMR
> memory-mapped register space. The "reset-values" of the registers are
> also different depending on the mode of operation.
> 
> Since the PCIe Controller latches onto the "reset-values" immediately
> after being powered on, if the Glue Layer configuration is not done while
> the PCIe Controller is off, it will result in the PCIe Controller latching
> onto the wrong "reset-values". In practice, this will show up as a wrong
> representation of the PCIe Controller's capability structures in the PCIe
> Configuration Space. Some such capabilities which are supported by the PCIe
> Controller in the Root-Complex mode but are incorrectly latched onto as
> being unsupported are:
> - Link Bandwidth Notification
> - Alternate Routing ID (ARI) Forwarding Support
> - Next capability offset within Advanced Error Reporting (AER) capability
> 
> Fix this by powering off the PCIe Controller before programming the "strap"
> settings and powering it on after that.
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08-27' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
> of Mainline Linux.
> 
> v2 of this patch is at:
> https://lore.kernel.org/r/20250819101336.292013-1-s-vadapalli@ti.com/
> Changes since v2:
> - Based on Bjorn's feedback at:
>   https://lore.kernel.org/r/20250819221748.GA598958@bhelgaas/
>   1) Commit message has been rephrased to summarize the issue and the
>   fix without elaborating too much on the details.
>   2) Description of the issue's symptoms noticeable by a user has been
>   added to the commit message.
>   3) Comment has been wrapped to fit within 80 columns.
>   4) The implementation has been simplified by moving the Controller
>   Power OFF and Power ON sequence into j721e_pcie_ctrl_init() as a
>   result of which the code reordering as well as function parameter
>   changes are no longer required.
> - Based on offline feedback from Vignesh, Runtime PM APIs are used
>   instead of PM DOMAIN APIs to power off and power on the PCIe
>   Controller.
> - Rebased patch on latest Mainline Linux.
> 
> Test Logs on J7200 EVM without the current patch applied show that the
> ARI Forwarding Capability incorrectly shows up as not being supported:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/768bca36025ed630c4e69bcc3d94501a
> 
> Test Logs on J7200 EVM with the current patch applied show that the
> ARI Forwarding Capability correctly shows up as being supported:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/fc1752d17140646c8fa57209eccd86ce
> 
> As explained in the commit message, this discrepancy is solely due to
> the PCIe Controller latching onto the incorrect reset-values which
> occurs when the strap settings are programmed after the PCIe Controller
> is powered on, at which point, the reset-values don't toggle anymore.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 6c93f39d0288..c178b117215a 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -284,6 +284,22 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  	if (!ret)
>  		offset = args.args[0];
>  
> +	/*
> +	 * The PCIe Controller's registers have different "reset-values"
> +	 * depending on the "strap" settings programmed into the PCIEn_CTRL
> +	 * register within the CTRL_MMR memory-mapped register space.
> +	 * The registers latch onto a "reset-value" based on the "strap"
> +	 * settings sampled after the PCIe Controller is powered on.
> +	 * To ensure that the "reset-values" are sampled accurately, power
> +	 * off the PCIe Controller before programming the "strap" settings
> +	 * and power it on after that.
> +	 */
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to power off PCIe Controller\n");
> +		return ret;
> +	}

How does the controller gets powered off after pm_runtime_put_sync() since you
do not have runtime PM callbacks? I believe the parent is turning off the power
domain?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

