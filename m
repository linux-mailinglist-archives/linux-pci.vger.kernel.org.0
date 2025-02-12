Return-Path: <linux-pci+bounces-21297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E16A32E0D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140003A7D40
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C922586F7;
	Wed, 12 Feb 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGtzyqkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1F2BD10;
	Wed, 12 Feb 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383217; cv=none; b=EMY7pfLKBrisadSyccNV7/VvFYdbStiF1uGQaJ9GHGPsO01j5BUWY/SJVhqvDNHqcmST2+IRc5CnBPtdi1SeLnXyGg/owP2eGWV/CDXKS3KktX4MINVke8rlP7+kjj1WS/5sI42juY3pr5aDjXpdx/bLkR33Des3ENg9irjHD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383217; c=relaxed/simple;
	bh=hsK/ij+5FFV9WezWD6dLNN9TbHcCGeKOn7f2QjrIAkk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pl02uj4GgOyjzK2dF+i8GLzZN6P5Ygn7ojY0M61yoRt2fupri8uDR1dM1oGoEMspZou9D04mKgirP9zOMhYUYHgLWpbtATrEouPnaElN528kkeQuBKPMhLjM0Sfmft91qZi76bsVqJ5fzhZuUmIjv8TRB92bk9Vo2aPCwET6kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGtzyqkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10FEC4CEDF;
	Wed, 12 Feb 2025 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383217;
	bh=hsK/ij+5FFV9WezWD6dLNN9TbHcCGeKOn7f2QjrIAkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AGtzyqkY5Co/VF4YcoGd4mbPW4K3DlF88Nn+KcbRZZYwfHbIAU/PtcmPqp6Lzi+pK
	 BKmMjpBsoSlGwVNt9VUOF12rix04O9ZwrPNys5fomIAgHGX17hPA8EW+oLHFTdhxym
	 uF61M3wy/GQIRASKaWWcjpknlJK96XSga60FsKG1t2FsPtqrABGF/oBpmvbUJkmlD5
	 P6/Hr14Gh2j4Tsukl/XTN8qwfc32Lime8GfUzAb/90QZKvxOwg0odz6HvFp2mdxRzO
	 nE+t2k/51g1ziUM5tfp/LQETQycXrI/fHtbTDnDbIt/nJoonjhY9QJyQGNUVP+PO7N
	 JxGVUxvAcsJ/A==
Date: Wed, 12 Feb 2025 12:00:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 05/11] PCI: brcmstb: Expand inbound window size
 up to 64GB
Message-ID: <20250212180009.GA85559@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-6-svarbanov@suse.de>

On Mon, Jan 20, 2025 at 03:01:13PM +0200, Stanimir Varbanov wrote:
> BCM2712 memory map can support up to 64GB of system memory, thus expand
> the inbound window size in calculation helper function.
> 
> The change is save for the currently supported SoCs that has smaller
> inbound window sizes.

If you repost:

s/save/safe/
s/that has/that have/

Otherwise we can fix these when merging.

> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> v4 -> v5:
>  - No changes.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 48b2747d8c98..59190d8be0fb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -304,8 +304,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
>  	if (log2_in >= 12 && log2_in <= 15)
>  		/* Covers 4KB to 32KB (inclusive) */
>  		return (log2_in - 12) + 0x1c;
> -	else if (log2_in >= 16 && log2_in <= 35)
> -		/* Covers 64KB to 32GB, (inclusive) */
> +	else if (log2_in >= 16 && log2_in <= 36)
> +		/* Covers 64KB to 64GB, (inclusive) */
>  		return log2_in - 15;
>  	/* Something is awry so disable */
>  	return 0;
> -- 
> 2.47.0
> 

