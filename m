Return-Path: <linux-pci+bounces-11555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E294D65B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA31EB21801
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9213C8F4;
	Fri,  9 Aug 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/DJZjRX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B72F41;
	Fri,  9 Aug 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228674; cv=none; b=ilL0008mIbXeMFVDd/lx8eGewgkKGNYhj7CQBICEVUmNx2/IM7ZMdiz6r3lY0yaegE2VBAg6U7oVdLPuuxMQigGAMXajATHKjYJubm5DWdxyDeTpYqIiWi2GJ9R0FP2+Dr6TVVgstiyCvLsbIpI5IrkOt3ACwITDefoKGF8EUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228674; c=relaxed/simple;
	bh=8OsU5V0BAvJ7UokhiBE8bGkStUtnywP253cG7I6ir7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kummxkwS8JJVfLmhr5fD2ArtVgKjz3o/c1GmL9JpD/RyWJhX2c3C8J+JA+DbWrEuqdOEfIMvcFy+H9svkxtjjkH+JbPVxinWliKCm/zkdY/2mnzLftmhBP66TR1+HzYxtxb/7NfRXn5GoyispeOsQj2GKkQ3e7URhP6wg8RedWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/DJZjRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F2CC32782;
	Fri,  9 Aug 2024 18:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723228674;
	bh=8OsU5V0BAvJ7UokhiBE8bGkStUtnywP253cG7I6ir7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E/DJZjRXotYZ+G5JOrMTJ/4OcmgAcSIrZzPRdpLHvaH5fN5yGQ9ggt2/1GrB5zyzM
	 T3865yaXmZCC1zoNghwQhdu3FVrX2Kc2HotKJyY54Ifu1CkwvkpeJWOBZ+5/RNNmoX
	 83Z+cxnP68z1O1OzKxzJmxEpymiX5d94I/P+tS8ahriwobDbRoyaFwCUCZNC4Yz22p
	 wQCfwYY6E3sslw0ejaThYwg6fl+QE/dLch1BPSqWkQqgvSZmZ+VVbY2wFPlo5oLu6S
	 CiP6MqtypMRzxoJtbSQx54GOmT6Utqi3sWVEz/gMwTVICvC4rYJbKpw6rjTgUH8Ydm
	 Ql4vOyvlLoXlQ==
Date: Fri, 9 Aug 2024 13:37:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] Documentation: devres: fix error about PCI devres
Message-ID: <20240809183751.GA205131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809095248.14220-2-pstanner@redhat.com>

On Fri, Aug 09, 2024 at 11:52:48AM +0200, Philipp Stanner wrote:
> The documentation states that pcim_enable_device() will make "all PCI
> ops" managed. This is totally false, only a small subset of PCI
> functions become managed that way. Implicating otherwise has caused at
> least one bug so far, namely in commit 8558de401b5f ("drm/vboxvideo: use
> managed pci functions").
> 
> Change the function summary so the functions dangerous behavior becomes
> obvious.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

s/Implicating/Suggesting/
s/functions dangerous/function's dangerous/

> ---
> +CC PCI and Bjorn.
> 
> Bjorn, btw. neither PCI nor you are printed by getmaintainers for the
> touched document. Possibly one might want to think about fixing that
> somehow.
> But I don't think it's a huge deal.
> ---
>  Documentation/driver-api/driver-model/devres.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index ac9ee7441887..5f2ee8d717b1 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -391,7 +391,7 @@ PCI
>    devm_pci_remap_cfgspace()	: ioremap PCI configuration space
>    devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
>  
> -  pcim_enable_device()		: after success, all PCI ops become managed
> +  pcim_enable_device()		: after success, some PCI ops become managed
>    pcim_iomap()			: do iomap() on a single BAR
>    pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
>    pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
> -- 
> 2.45.2
> 

