Return-Path: <linux-pci+bounces-8767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA51907EC4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1711F2218D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E02B14B94C;
	Thu, 13 Jun 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxDtPe8+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABD13B580;
	Thu, 13 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317234; cv=none; b=R2lF2DOweH11Acx/FKqbNquX4nG01U7ETOnOpKA5uKMq0dDRGfakeVeGTeCZTgzouZGan8impMwNCTOez2J9YmRj76IB+rG9PJCDrVXoeQosNnbCxacciCwygIQiAjTurOlbwRMrlw+Orn3Kj8jj1W1aIZ32L/MSbhnjsiMrTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317234; c=relaxed/simple;
	bh=wwgS7BLjpzG6hi+6zIt/cIywG0J6TFTrUTm5rK5YdOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h+GU+87WlNA0pJSgeqf+mNbbDwpGQVFF6LmfqOR2p3Kw8M4cpMNfC9J+lE6hkXc/KDxeBpfySfBV3U2VFTddfsExoRTFaLCaBL8IRHjFmMGHiCv1MQ0yoDgXStKSDHm9Q+DMPkIfqVK4dgW1LvbDbFh6yJgXslIVo1fZSpM0L3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxDtPe8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F28EC2BBFC;
	Thu, 13 Jun 2024 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718317234;
	bh=wwgS7BLjpzG6hi+6zIt/cIywG0J6TFTrUTm5rK5YdOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PxDtPe8+Mcf6ELxYe+RDvaaJTj3XX0/OpRdnNbdPvzVGT1JohJOPxOS/gh+BY0U6H
	 EvuWWtdInXKi1ADO0GcHdvDPj1tpz2q9j4DXits2a2wlrHETYp1GDXMbt3fQpHrwFJ
	 Y8p+1CGjZ6yB/uKqmWH1mGdNnbp/uu8gPWOti+4Bpni7llA3cnFba+XsxUg8Uvlpbx
	 IjiO8Vy/sXc72BbRBgYMeoG+e/NpaHhaimxGujqYAywMxJb0h1ZygSZe1g0u9cLnbz
	 VxZ3e3BQxIATZIlv+KwWy+Lt3T13JnpvPr9Xs3EDjyFC5u6WKavrPeRQT48/afmfjV
	 fxabme+/LjthQ==
Date: Thu, 13 Jun 2024 17:20:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240613222032.GA1087213@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-md-drivers-pci-v1-1-139c135853ea@quicinc.com>

On Mon, Jun 10, 2024 at 06:21:16PM -0700, Jeff Johnson wrote:
> When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-stub.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-pf-stub.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied to pci/misc for v6.11, with updates to the text:

> ---
>  drivers/pci/pci-pf-stub.c | 1 +
>  drivers/pci/pci-stub.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
> index 45855a5e9fca..04815fcb0ce7 100644
> --- a/drivers/pci/pci-pf-stub.c
> +++ b/drivers/pci/pci-pf-stub.c
> @@ -39,4 +39,5 @@ static struct pci_driver pf_stub_driver = {
>  };
>  module_pci_driver(pf_stub_driver);
>  
> +MODULE_DESCRIPTION("Simple stub driver for PCI SR-IOV PF device");

+MODULE_DESCRIPTION("SR-IOV PF stub driver with no functionality");

>  MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index d1f4c1ce7bd1..d4fec791b321 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -92,5 +92,6 @@ static void __exit pci_stub_exit(void)
>  module_init(pci_stub_init);
>  module_exit(pci_stub_exit);
>  
> +MODULE_DESCRIPTION("Simple stub driver to reserve a PCI device");

+MODULE_DESCRIPTION("VM device assignment stub driver");

>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Chris Wright <chrisw@sous-sol.org>");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-pci-831cb8f308a9
> 

