Return-Path: <linux-pci+bounces-8766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01801907E96
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A637A1F22F12
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C5F14A623;
	Thu, 13 Jun 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwvp66QT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A391311B6;
	Thu, 13 Jun 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316485; cv=none; b=OEyxsZ3bjUC2TZipEk1aIA0n4n+UbEiRpjVXckKdfjaszt4DTYKV7oTPoYik1GbaOp3odgafgbWI0WdQvU9Zd7W2nAVQjBEI15y3QEN/Kw9Drry34EL6+qqNNg5s6/LPfdtRRSb1SiwV1TYFXscrCFYXyZRbI7UcI6/BbGXJj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316485; c=relaxed/simple;
	bh=fJMp4yW8tX/ZxoW/dcrwwsdkXCXb1Y/2P8xMjIFvow8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LUtJ9uGWPf4vGjkhy70iQKe2pL2gBDZs/1LHjeSZWTQLWySzR6B0gI3lqxoaz1KJvdN3d5ZdyLDLakytJaaeIHIKthmH08iKGFUlF9hHNaGh1HtdBunTdUfiDaGtvHfR2LZGMwEHlhlEzp0X7cDEXMwDLeqFBWYYyZ1ycta1Q2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwvp66QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B6C2BBFC;
	Thu, 13 Jun 2024 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718316484;
	bh=fJMp4yW8tX/ZxoW/dcrwwsdkXCXb1Y/2P8xMjIFvow8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gwvp66QTryv5yvPIyg64tGt1tkwzSYJB0aJ34O/EuJV4iqyfRtrikU7C0TRsVc/Lp
	 mLO8DPgZvzMVFjWyblS7ZkvEUGNuGVBvdITyrzxFuNu9HLZoW0q1ujYSzVVtbis05Y
	 ubNOtAhU3z2puVDdXAmHOD1LA26A/L/RI3vS4DOyxYZzzam93w0oIT8H2GRyqGjNXy
	 3EsdIFLUIYiYRIHxZY+40zwWICZJY2uvMFtjE0nfTpQCxmGlGKBKBHggB3CiBL3Drt
	 bHd5f2KAFvWHZsdek+Yz94E+BBguOb4TOXMEhWys2rUiauteT88a+d1dfmpMkkEXW4
	 LVVTWebY0DwYw==
Date: Thu, 13 Jun 2024 17:08:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240613220802.GA1086403@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-md-drivers-pci-hotplug-v1-1-2b30d14d783d@quicinc.com>

On Wed, Jun 12, 2024 at 10:45:23PM -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/hotplug/acpiphp_ampere_altra.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied to pci/hotplug for v6.11, thanks!

> ---
>  drivers/pci/hotplug/acpiphp_ampere_altra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> index 3fddd04851b6..f5c9e741c1d4 100644
> --- a/drivers/pci/hotplug/acpiphp_ampere_altra.c
> +++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> @@ -124,4 +124,5 @@ static struct platform_driver altra_led_driver = {
>  module_platform_driver(altra_led_driver);
>  
>  MODULE_AUTHOR("D Scott Phillips <scott@os.amperecomputing.com>");
> +MODULE_DESCRIPTION("ACPI PCI Hot Plug Extension for Ampere Altra");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240612-md-drivers-pci-hotplug-62a6e918e180
> 

