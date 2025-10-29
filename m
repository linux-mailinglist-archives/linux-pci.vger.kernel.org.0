Return-Path: <linux-pci+bounces-39698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2628DC1CA75
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAAF623453
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF8328B64;
	Wed, 29 Oct 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K22XA1Hj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE42F60AC;
	Wed, 29 Oct 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760016; cv=none; b=WpxLa0NE/VdgKIpTEzMfrS7caNQ0OpnYWvXhxC6k6fVioUa++bLLLc4hzij4jf65llZePZW48tq+ZaUR/9IreRIVIEPVvdyea4lV6BkdHe/okn+G93aK3reUtV9sjtK1k5COHj2sGjmQaNpzAiuURd/YoGHwu9d8v6PhhVDdOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760016; c=relaxed/simple;
	bh=KsXdySkGiHmSzsuy7Pi+sVL7aoIePP+MEpnzF2GEcmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NqhaS9F9UI678ciFff1q1qBvGV5IS1IvZUUzYQYhpW/HrrDfr1L4zXEKV+dxL3quK5mqmxOGQdw+fcdT6aj+D6XRlygdFIlUbf9OLEwyMQHGneI/0yETh11OMk4+Cv1AiK5N4WdZstpHYapMFIz0Quch12Kxg5G0GMTYUqfPcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K22XA1Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202B1C4CEF7;
	Wed, 29 Oct 2025 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760016;
	bh=KsXdySkGiHmSzsuy7Pi+sVL7aoIePP+MEpnzF2GEcmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K22XA1Hjw8uOX95mhKKhhconnRdms2qQD/Nbq0dqkODo/qoasd98i4iGIns2To5K7
	 9LCQCwxZ++SdZB2vSAuCJYW4paAjVRKTA4iWkPcqn9ss6ygExiQXqHziIwzmyr+rkW
	 +lIxJgcLxAivPEpWGXWHSqI8/7xdlQzr7QsViTjJuJzP8+wsaPDKG5m+0ZtIalIr/k
	 OungqAalRYCEVyKSHVo57GafE546/x+UVS5pGNUIRUiKo7vIQBPHzK6tyDCTfyy+Hp
	 yAXyomKjaPtaqAImWTBqtWHwQxnW7/jlC878FpiIrVJhNq87HlEksKBMqgKgcyoNJG
	 qk2DTbEtU/sOQ==
Date: Wed, 29 Oct 2025 12:46:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] MIPS: PCI: Use contextual data instead of global
 variable
Message-ID: <20251029174654.GA1571737@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163336.2785270-3-thierry.reding@gmail.com>

On Wed, Oct 29, 2025 at 05:33:31PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Pass the driver-specific data via the syscore struct and use it in the
> syscore ops.

Would be nice to include the "instead of global variable" part here so
the commit log includes the benefit and can stand alone even without
the subject.

Awesome to get rid of another global variable!  More comments below.

> +++ b/arch/mips/pci/pci-alchemy.c
> @@ -33,6 +33,7 @@
>  
>  struct alchemy_pci_context {
>  	struct pci_controller alchemy_pci_ctrl; /* leave as first member! */
> +	struct syscore syscore;
>  	void __iomem *regs;			/* ctrl base */
>  	/* tools for wired entry for config space access */
>  	unsigned long last_elo0;
> @@ -46,12 +47,6 @@ struct alchemy_pci_context {
>  	int (*board_pci_idsel)(unsigned int devsel, int assert);
>  };
>  
> -/* for syscore_ops. There's only one PCI controller on Alchemy chips, so this
> - * should suffice for now.
> - */
> -static struct alchemy_pci_context *__alchemy_pci_ctx;
> -
> -
>  /* IO/MEM resources for PCI. Keep the memres in sync with fixup_bigphys_addr
>   * in arch/mips/alchemy/common/setup.c
>   */
> @@ -306,9 +301,7 @@ static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
>  /* save PCI controller register contents. */
>  static int alchemy_pci_suspend(void *data)
>  {
> -	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
> -	if (!ctx)
> -		return 0;
> +	struct alchemy_pci_context *ctx = data;
>  
>  	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
>  	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
> @@ -328,9 +321,7 @@ static int alchemy_pci_suspend(void *data)
>  
>  static void alchemy_pci_resume(void *data)
>  {
> -	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
> -	if (!ctx)
> -		return;
> +	struct alchemy_pci_context *ctx = data;
>  
>  	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
>  	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
> @@ -359,10 +350,6 @@ static const struct syscore_ops alchemy_pci_syscore_ops = {
>  	.resume = alchemy_pci_resume,
>  };
>  
> -static struct syscore alchemy_pci_syscore = {
> -	.ops = &alchemy_pci_syscore_ops,
> -};
> -
>  static int alchemy_pci_probe(struct platform_device *pdev)
>  {
>  	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
> @@ -480,9 +467,10 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>  	__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
>  	wmb();
>  
> -	__alchemy_pci_ctx = ctx;
>  	platform_set_drvdata(pdev, ctx);
> -	register_syscore(&alchemy_pci_syscore);
> +	ctx->syscore.ops = &alchemy_pci_syscore_ops;
> +	ctx->syscore.data = ctx;
> +	register_syscore(&ctx->syscore);

As far as I can tell, the only use of syscore in this driver is for
suspend/resume.

This is a regular platform_device driver, so instead of syscore, I
think it should use generic power management like other PCI host
controller drivers do, something like this:

  static int alchemy_pci_suspend_noirq(struct device *dev)
  ...

  static int alchemy_pci_resume_noirq(struct device *dev)
  ...

  static DEFINE_NOIRQ_DEV_PM_OPS(alchemy_pci_pm_ops,
                                 alchemy_pci_suspend_noirq,
                                 alchemy_pci_resume_noirq);

  static struct platform_driver alchemy_pcictl_driver = {
          .probe          = alchemy_pci_probe,
          .driver = {
                  .name   = "alchemy-pci",
                  .pm     = pm_sleep_ptr(&alchemy_pci_pm_ops),
          },
  };

Here's a sample in another driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/cadence/pci-j721e.c?id=v6.17#n663

>  	register_pci_controller(&ctx->alchemy_pci_ctrl);
>  
>  	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
> -- 
> 2.51.0
> 

