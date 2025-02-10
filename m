Return-Path: <linux-pci+bounces-21118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA1CA2F9C4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 21:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F343A3A4660
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F024E4B0;
	Mon, 10 Feb 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U61+4GpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19824C688
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218398; cv=none; b=n/61+wU+pVLE7yyylJFK+6b7t7S31vQ248AX+ZLWbVyQwgEENohq+hCbA59Bx43wcOyHuQP5QZaJVzLigNvUUqMwxoUSZlQqb+9OyHvQG2ZycW3c21j083i2lj4PepHKfgGTp6bb4iC2wKGgOf3gwDkP6Bued59nE7okp1nZfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218398; c=relaxed/simple;
	bh=1c4M5xL5N+ZqW32clpzVCbTlEl8XeyMzw4K37//6rlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noZqvDAQ6pWRBPqmKryDijSRrVwHKqCYXLGi2E1EYck+wwu7Z6us6UDnOv5d1jUMNUS9sIWP3ljTGkvZRsx6bkcZE448KxY+wFoEfIbiElPw6TdcaYZlkVSkfSmnt6ieCVxvfr81jOtm1PONgqb1ZopjY2mfVGcciX0NZhX9u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U61+4GpY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e4565be0e0so23700046d6.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739218396; x=1739823196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsA2D7RWwZNKkZanu5txIKeWQkXNdP5BKkyfvi0dKOg=;
        b=U61+4GpYCHcufU8AZAbuPtapiX4t0ewrhRzeN8y9+0sFeWUvy+slSXPW6umtFe0Y/J
         543HLMudwMqDgNHSVWqtn1IVM/4YqSbaGjXbG4QcMCS+5lho7+gU6M+Ai+/mGLFpC4Uw
         /P0hxuHX7g1zw8o/lRq2m0VatouvDewW9vD17EHG/8yKPOyDyfCxXL8muiP1Y9gVx8pc
         W7D8URb9RAwKHc9j8kO30sJBJFZ65Rs++/tzgc0KliD0rmzn3o+uNPVBGxA4/7Jk927j
         uYAW2EJAHNJHTM2A9/xo+WqUV/rEH6QTdpWqziZkowU8b3QKQ6lHtBrVZA4EVRm2xBfV
         Za1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739218396; x=1739823196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsA2D7RWwZNKkZanu5txIKeWQkXNdP5BKkyfvi0dKOg=;
        b=l0PpeaSUm+bm0zIVKLjkjkWVlbjtfEwjqW1VZXeN3aN0ITiuu2YmPMf4B0y5EaGgNe
         Z5SbtT8a2mj41mqjf69zyhxu0zQqJ1hcElrOobzLYEnZbQKtBKXyVcEk+lIGrTqbmzpi
         JQqbO9C71f2pavb0uymcCn4Y/1Lq6ibC/2qc4ixwoq2BA+DFBWgauMoN2TL9e27BA7R0
         ZlTYtZBjyWH1MA6gNIc0GeNQ3ia+Qq9nPF3dnyCZrmpSZkaWBdghlZGZ6D91vzQudbXb
         O4azVPkyNrqQbBz2KvIa4nStqtKcHjwfRAQtIGlNrUruMu62uUDy1wen3mvWJSnM9EnH
         mY+w==
X-Forwarded-Encrypted: i=1; AJvYcCVk4C3HjMLQe8bwHdWfnunI91MH8k3BTnlbchRNhYsR5kYJzaYTBOqIfXGNT4xx41c5SNd1mXnJRT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+bwLKME+TiRhlHkkykNWNC8g1cs2xkFhVpynKZjjmDsbvUAR
	v2/2s7G1dgzp4IbtMd6zvX4p6ebrrhJKWjlr/X46LvgL4jkYTgGMEhFZ1k8nzbc=
X-Gm-Gg: ASbGnctH3CszffS6BxKbGRkRBPWf5ry0seyCyLTJCLGGgK3+PTGMclkisof2gF8xDH5
	oOrOe6ROmQbaPGNBk6UaZlxoymw1n18UatdWQsNNByUNNGiXsde7Mci9Lh+gzrL0evrPUIVxjPN
	c3BIAvbrUTWhnGifEV43KGNpx4jdGwYls3tth7xKsGrBf7CfaiCEbCptswqL1mSJq2zYpbfsMOu
	QLAd2ZDXqx38visypnmSwN5YcGDePhQWtWi5KpbmvLezxKHzXO1RUl2sqOZ/l74uHLkUjliOcFk
	3A5bt3nHVnnpf0mCqTIpHmNiG7NVlLHzJh6VlDHwXBfTK9DOf/5sIRQjB0fQKnQXxDvgescYYQ=
	=
X-Google-Smtp-Source: AGHT+IHUip5YMADfXv9mqUnuwstRyUZVEWa8wwzCcohodaY75zHwttm/vgjHcKoIUdbSid7/1TXa5A==
X-Received: by 2002:ad4:5dea:0:b0:6d8:a946:eee5 with SMTP id 6a1803df08f44-6e445692b85mr232828896d6.23.1739218395869;
        Mon, 10 Feb 2025 12:13:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e456893843sm25923626d6.59.2025.02.10.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:13:15 -0800 (PST)
Date: Mon, 10 Feb 2025 15:13:13 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v6 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <Z6pd2QYTfRFxadey@gourry-fedora-PF4VCD3F>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
 <20250208002941.4135321-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208002941.4135321-7-terry.bowman@amd.com>

On Fri, Feb 07, 2025 at 06:29:30PM -0600, Terry Bowman wrote:
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..eda532f7440c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -661,10 +661,16 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
> +		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
> +		return;
>  	}
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(cxl_dev))
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(cxl_dev), status);
> +	else if (is_cxl_port(cxl_dev))
> +		trace_cxl_port_aer_correctable_error(cxl_dev, pcie_dev, status);
>  }

Build errors here - after looking into it a little more, seems like these changes
are actually meant for a later commit. I dropped this and let the later
commits pick it up and it seems to build more cleanly.

~Gregory

