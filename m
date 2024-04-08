Return-Path: <linux-pci+bounces-5904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48389CD9A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 23:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE0D1C21504
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AA14831C;
	Mon,  8 Apr 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZMy2n+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553E495CB;
	Mon,  8 Apr 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611982; cv=none; b=fEfcO8FDIiC8L/VrNRTmBjmbmrcw+Oo5dJw4RdzyXasCrVkChl5nzqaT6HfY4eEao7S1dzTxioEiKXSEnSf4XSYjfZgToPIQVOODtPCF144klecFEPWjw2AZiksDo4UG1sOqA4TgwLb9FL2zVBHuouh2aYI/r5XPFfTg4cIf17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611982; c=relaxed/simple;
	bh=mwRTi4XLlXucynotn4g/edLHZpB5pWNY4Czev1haibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX6X8BL8hNPaXb7YHmBn05tpPrV9aFHaYYh/rSPFQP5jTDpfKycplVKvA59QC5epMXtmVga6NS3IngDn6D31UdFDsT9Fa5Pr/FOMGyOXfZyq2jwyK3BvE7JVFe3hg9+fF1RyGILxixKDCAoT5FBX6L9Imb+ezCOjsMqeb+Pj2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZMy2n+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77165C433F1;
	Mon,  8 Apr 2024 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712611981;
	bh=mwRTi4XLlXucynotn4g/edLHZpB5pWNY4Czev1haibM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZMy2n+VMuef++33DwGlI9WE8AG4yAzc2dlojvFSIoRd0DqqlBzVyIxfjaZtDKz8W
	 QRknm8+f2eqVCdhpaOlPfQ0+rvyT6u4iiIiB6uGfFI38jDre7vlA7CYgz6jkLfHYxU
	 E+NaY9gFF5lelWhz5bnn7MRUibAR0iI00ua9Amzl4TqD0n4DKXderNttF21GOEP/nU
	 8uRIdLNzUQAHzVaJvJfB1iUqwSBrtT/gtNIhXbxJd6HPFkjIMiAnKgNSZW7TJDu8/V
	 zJCZ/M5hKjzc8p4nu1ZYxkL/YMPQWI2uYqv0Kw3rXlHuWaVA3VmXqMzfBmXkEpNHdp
	 KRB7YL7i7bY2Q==
Date: Mon, 8 Apr 2024 14:32:59 -0700
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <ZhRii1BAg86gccWM@snoopy>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
 <ZhMP-NBMb387KD4Y@wunner.de>
 <ZhNQa8wAflycciNA@snoopy>
 <20240408093422.000062d9@Huawei.com>
 <ZhRFsUiDieY+HhfV@snoopy>
 <6614575a1c15c_2583ad29476@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6614575a1c15c_2583ad29476@dwillia2-xfh.jf.intel.com.notmuch>

On 24/04/08 01:45PM, Dan Williams wrote:
> PJ Waskiewicz wrote:
> [..]
> > > Other than that seems reasonable to hint it is probably a bios
> > > bug - however I wonder how many other cases we should do this for and
> > > whether it is worth the effort of marking them all?
> > 
> > I can confirm this was definitely a BIOS bug in this particular case.
> > The vendor spun a quick test BIOS for us to test on an EMR and SPR host,
> > and the _UID's were finally correct.  I could successfully walk the CEDT
> > and get to the CAPS structs I was after (link speed, bus width, etc.).
> 
> Oh, in that case I think there's no need to worry about a Linux quirk.

Copy that.
 
> I do think cxl_acpi has multiple overlapping failure cases when what you
> really want to know is whether:
> 
>    "CXL host bridge can be found in CEDT.CHBS"

Yes.
 
> Turns out that straightforward message is aleady a driver message, but
> it gets skipped in this case. So, I am thinking of cleanup /
> clarification along the following lines:
> 
> 1/ Lean on the existing cxl_get_chbs() validation paths to report on
> errors
> 
> 2/ Include the device-name rather than the UID since if UID is
> unreliable it does not help you communicate with your BIOS vendor. I.e.
> give a breadcrumb for the BIOS engineer to match the AML device name
> with the CEDT content.
> 
> 3/ Do not fail driver load on a single host-bridge parsing failure
> 
> 4/ These are all cxl_acpi driver init events, so consistently use the
> ACPI0017 device, and the cxl_acpi driver, as the originator of the error
> message.
> 
> Would this clarification have saved you time with the debug?

Inline below, but yes, this would have helped sped up the debug quite a
bit.  Since the initial debug was happening on SPR, and I couldn't use
the host drivers, I was pulling the logic from the CXL host drivers into
my drivers to skip the need for ACPI0017.
 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 32091379a97b..5a70d7312c64 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -511,29 +511,26 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  	return 0;
>  }
>  
> -static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> -			struct cxl_chbs_context *ctx)
> +static void cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> +			 struct cxl_chbs_context *ctx)
>  {
> -	unsigned long long uid;
>  	int rc;
>  
> -	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> -	if (rc != AE_OK) {
> -		dev_err(dev, "unable to retrieve _UID\n");
> -		return -ENOENT;
> -	}
> -
> -	dev_dbg(dev, "UID found: %lld\n", uid);
> -	*ctx = (struct cxl_chbs_context) {
> +	*ctx = (struct cxl_chbs_context){
>  		.dev = dev,
> -		.uid = uid,
>  		.base = CXL_RESOURCE_NONE,
>  		.cxl_version = UINT_MAX,
>  	};
>  
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
> +	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL,
> +				   &ctx->uid);
> +	if (rc != AE_OK) {
> +		dev_dbg(dev, "unable to retrieve _UID\n");
> +		return;
> +	}

Before I read the changes below, I didn't see why this was still
useful...but I do see it now in full context.

>  
> -	return 0;
> +	dev_dbg(dev, "UID found: %lld\n", ctx->uid);
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
>  }
>  
>  static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
> @@ -561,7 +558,6 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
>  static int add_host_bridge_dport(struct device *match, void *arg)
>  {
>  	int ret;
> -	acpi_status rc;
>  	struct device *bridge;
>  	struct cxl_dport *dport;
>  	struct cxl_chbs_context ctx;
> @@ -573,19 +569,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	if (!hb)
>  		return 0;
>  
> -	rc = cxl_get_chbs(match, hb, &ctx);
> -	if (rc)
> -		return rc;
> -
> +	cxl_get_chbs(match, hb, &ctx);
>  	if (ctx.cxl_version == UINT_MAX) {
> -		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
> -			 ctx.uid);
> +		dev_err(host, FW_BUG "No CHBS found for Host Bridge (%s)\n",
> +			dev_name(match));
>  		return 0;
>  	}

This would have been more obvious that the lookup failed for "reasons"
instead of AE_BUFFER_OVERFLOW (which led to the fun Alice-style LXR
spelunking).

>  
>  	if (ctx.base == CXL_RESOURCE_NONE) {
> -		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
> -			 ctx.uid);
> +		dev_err(host, FW_BUG "CHBS invalid for Host Bridge (%s)\n",
> +			dev_name(match));

I think this is a good catch-all too in case the lookup is good, but the
vendor borked filling it in properly.

>  		return 0;
>  	}
>  
> @@ -650,13 +643,11 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> -	rc = cxl_get_chbs(match, hb, &ctx);
> -	if (rc)
> -		return rc;
> -
> +	cxl_get_chbs(match, hb, &ctx);
>  	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
> -		dev_warn(bridge,
> -			 "CXL CHBS version mismatch, skip port registration\n");
> +		dev_err(host,
> +			FW_BUG "CXL CHBS version mismatch, skip port registration for %s\n",
> +			dev_name(match));
>  		return 0;
>  	}

I like your version here much better than mine.  If you want to merge
that, then:

Reviewed-by: PJ Waskiewicz <ppwaskie@kernel.org>

