Return-Path: <linux-pci+bounces-4213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331886BAB8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 23:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DF31C22144
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E51361DB;
	Wed, 28 Feb 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNLD2+Q3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8601361C7;
	Wed, 28 Feb 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159163; cv=none; b=fFAQkAIgCPDGtaSRtKHEZd8HiJxa6BqVpuYwioqpLQaRcqnxMbMn8H051hWSriU9CdQBDLZ58EE1lFql//ORitYbCtXiQ1R31sxFuWF9AsTC+M+3JrZeaRDOAtvyd3JyfG8O7G7ZbJRenek2V299Dmm+G/XTqe4IU/b+PmCeLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159163; c=relaxed/simple;
	bh=qMdsiFcrkQxDpSIkDbKgrGb6ge3rWsOYQtLwEYq+96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XPJdf3hXuUyOJsoUywZQGugg00WY/Bd74O1rOl0oNVZK9Tdg6Qc190nDBXfMOV8Q7zYfXzcrcKGnkHcx5AS5b00PPJhkQ/t33rvzA1AGpedEvzTyux3GZpnRVWqfEFHXx13UtiUpIbgYSBPx0Z6sRE1OydzSE9TToKKMH65Wx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNLD2+Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809DDC433C7;
	Wed, 28 Feb 2024 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709159162;
	bh=qMdsiFcrkQxDpSIkDbKgrGb6ge3rWsOYQtLwEYq+96Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aNLD2+Q3L/qbx5kq8BFulNFuIjUecoFTuaxd7xJ7UhNJLwxiK5oJuJWtY24Rw9OZm
	 QawhRaVZYAmkbF2iPIZJAn9QivrtM9TSTnqkPMTNITRa/CB9Tb4u06tKhUiv8J1YOG
	 CXbqR1GsfjPUW7CNqci5HwpM6RYhlAtmCu7D1B37O7ZI8x/DxjC+fRv+kVISluZMkg
	 cMn72eXuym0Xe+SzEymb/qJnX0s9ZTYfXTOFRGJpI5Rwhqygo7rxoLFL8QG2Jjinqt
	 L/94o5Y4YbaMlSsbd2qdUDPTGy9AMEwohVn+T9PezC2+BAEur8AO5dqN9gQjnDRJm4
	 mgdnbVveJGgiQ==
Date: Wed, 28 Feb 2024 16:26:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Drake <drake@endlessos.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, david.e.box@linux.intel.com,
	mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [PATCH v3 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
Message-ID: <20240228222601.GA310596@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228075316.7404-2-drake@endlessos.org>

[+to Rafael]

On Wed, Feb 28, 2024 at 08:53:16AM +0100, Daniel Drake wrote:
> This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
> was originally put in place to work around a s2idle failure on this
> platform where the NVMe device was inaccessible upon resume.
> 
> After extended testing, we found that the firmware's implementation of
> S3 is buggy and intermittently fails to wake up the system. We need
> to revert to s2idle mode.
> 
> The NVMe issue has now been solved more precisely in the commit titled
> "PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
> Acked-by: Jian-Hong Pan <jhp@endlessos.org>
> Signed-off-by: Daniel Drake <drake@endlessos.org>

Rafael, if you're OK with this, I can queue both patches for v6.9.

> ---
>  drivers/acpi/sleep.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 808484d112097..728acfeb774d8 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
>  		},
>  	},
> -	/*
> -	 * ASUS B1400CEAE hangs on resume from suspend (see
> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
> -	 */
> -	{
> -	.callback = init_default_s3,
> -	.ident = "ASUS B1400CEAE",
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
> -		},
> -	},
>  	{},
>  };
>  
> -- 
> 2.39.2
> 

