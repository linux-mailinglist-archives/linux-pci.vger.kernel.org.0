Return-Path: <linux-pci+bounces-12785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9996C820
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D521C21B35
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C001E8B60;
	Wed,  4 Sep 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q01ja3FZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C41E7679;
	Wed,  4 Sep 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480207; cv=none; b=gQ5+ZRJSSrCIbG4ZOQBhCk+BP5LwO1WcuLEy9wG5f5Rd489BpIVBdrzh7L/YY7ZaWhFIdA2VcwLQti9oUgZzsR/Oe21g94CzZf6sdH/MEJ7J81OJEBsM6As87Crc7LnfIvOCv/W9WRaUvTgRfxCDrlLi0HO+S0rvqtdYYdcXbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480207; c=relaxed/simple;
	bh=452uQfOHfv8AR/sw7e1cTOC7fXQ6+vOclJz7xxoWuyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pla8PmL0c4POENrMGJVb/W3eaNioCTsT4JxyX3gtP7/2fVdqT7XmCEwZelUA8LyUC+Bodwss1Pfv66HR1dPZ8ZOBShNG/JxtxH3AZY32FhH55alxkOM/ynkXFgDc4xTbSL0oYLCa2gcTKwT/P17oK7vO/fO3MoDdYc5YhaAxjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q01ja3FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D78C4CEC8;
	Wed,  4 Sep 2024 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725480207;
	bh=452uQfOHfv8AR/sw7e1cTOC7fXQ6+vOclJz7xxoWuyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q01ja3FZznhXfUE66AhgIuIgugmO79Kru7RQFJglD2KoeSde09xK11awheMq+x9/F
	 03AY8/M3Mrx9dmqCGACKGqMizvqmc1eY+q0rgfZq5awFkc1VdjJo8qp7A1LhqR62jl
	 a51N+GXIzoxWO5YPma93E4sQ4LYyfbRseX3K+ISMnReV6H6W8WGhQCdXgdfY37HwDc
	 olmxSUVz6PCXzohs7SinC0jmO2EIauLR/JAHRpIXz3TBp0r5Z7PVBp3FQYtu8xuTai
	 WyG5xXG7yMCUgPEMDyZ5qnbRJOqfFJCwI8EOWR+YimqkzrBCgtZIACJllQx2GDKVM1
	 hDr3kikFJrmVA==
Date: Wed, 4 Sep 2024 15:03:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
Message-ID: <20240904200325.GA345254@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1459350-f458-470b-a288-a92e2085f93a@amd.com>

On Wed, Sep 04, 2024 at 02:48:30PM -0500, Wei Huang wrote:
> On 9/4/24 13:49, Bjorn Helgaas wrote:
> > On Thu, Aug 22, 2024 at 03:41:08PM -0500, Wei Huang wrote:
> >> Hi All,
> >>
> >> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
> >> devices to provide optimization hints for requests that target memory
> >> space. These hints, in a format called steering tag (ST), are provided
> >> in the requester's TLP headers and allow the system hardware, including
> >> the Root Complex, to optimize the utilization of platform resources
> >> for the requests.
> >>
> >> Upcoming AMD hardware implement a new Cache Injection feature that
> >> leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
> >> Coherent DMA writes directly into an L2 within the CCX (core complex)
> >> closest to the CPU core that will consume it. This technology is aimed
> >> at applications requiring high performance and low latency, such as
> >> networking and storage applications.
> > 
> > Thanks for this example, it's a great intro.  Suggest adding something
> > similar to a patch commit log, since the cover letter is harder to
> > find after this appears in git.
> 
> I'll incorporate some of these descriptions into the TPH patches where
> relevant. Additionally, I'll enhance the commit log for bnxt.c (patch
> 11) with examples of the benefits.

Sounds good.

Another confusing point that would be helpful to mention is that TPH
includes two pieces: Processing Hints and Steering Tags.

As far as I can see, the only architected control of Processing Hints
(bi-directional, requester, target, target w/ priority) is to
enable/disable TPH or Extended TPH.

But we *do* have significant software control over the Steering Tags.

