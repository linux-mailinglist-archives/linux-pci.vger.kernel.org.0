Return-Path: <linux-pci+bounces-11200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBE94622F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569981F220C5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881E1537DF;
	Fri,  2 Aug 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucaUQzek"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92821537D4;
	Fri,  2 Aug 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618009; cv=none; b=Ros+Dnr1q0V6ChqR9qZoX2nlTnu7knBy5naDuYdMgoHOeb0a4kS8AX5BnF4bgFC13hsHxt647FaJFhUkLikKPZOqhjOUndc3FTe+F2XpALDpKxrXtsjFyp2p4sxwkRZxiGaEPNDOGXf8tMBz9vr3qpwoix4K9zmdkgARtn6QhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618009; c=relaxed/simple;
	bh=uv7HuMEHgapOFg3wbd0WciOnlZwZFFkU091eYJlLtyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H7aV6GL928K0tOIalrEZmoBX1UcI/uR1M8HNTjwdpswBQvtx0QVp0oydYU2klA0Kz7N9vIRCFW8FEL2HgfF+ydlb1pEbek8rRV8vEoXvvVLccW8DZPGFXnpuNQAIsgZrsB8bdKYo2LicBzgfg4FSxHj3BenopFb6fnaq86KVu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucaUQzek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1DBC32782;
	Fri,  2 Aug 2024 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722618008;
	bh=uv7HuMEHgapOFg3wbd0WciOnlZwZFFkU091eYJlLtyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ucaUQzekFEkmK1AZqkWD+mq4tujaOHtDTGsy5aDsDY58Mn0coqpKpOhAYhd7ura+8
	 i9nGtDvXVBmEG5TMJjL5ZOJto7B7szZMJDzpLPrbTbogdkvujcN4n0s7kawkDI+XnY
	 x4/Ifxf1AtD90GKewQp3vccoVjyHFcHBIvKW5WGlfVHkqr3e8aA2XFbcIg40c2L+kz
	 opRJ9rLuJntkTFIUOwc+h7YQen6oZ4+8cesIcSblE9HFqT0j5kgMHRZxZcdDLOOH07
	 hwLojcKA4MfzNJOMiKSHZTERAf/ZWpg+tHzRKHPO9iEUvVS/1V1Nvelc2JqqSV+apY
	 Nv4IWv6WGjCEw==
Date: Fri, 2 Aug 2024 12:00:06 -0500
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
	bhelgaas@google.com
Subject: Re: [PATCH V3 09/10] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240802170006.GA154301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a50d58-f9b3-4003-b694-6829c9bcb0a2@amd.com>

On Fri, Aug 02, 2024 at 12:44:07AM -0500, Wei Huang wrote:
> 
> 
> On 7/23/24 11:48, Bjorn Helgaas wrote:
> > On Wed, Jul 17, 2024 at 03:55:10PM -0500, Wei Huang wrote:
> > > From: Manoj Panicker <manoj.panicker2@amd.com>
> > > 
> > > Implement TPH support in Broadcom BNXT device driver by invoking
> > > pcie_tph_set_st() function when interrupt affinity is changed.
> > 
> > *and* invoking pcie_tph_set_st() when setting up the IRQ in the first
> > place, I guess?
> > 
> > I guess this gives a significant performance benefit?  The series
> > includes "pci=nostmode" so the benefit can be quantified, so now I'm
> > curious about what you measured :)
> 
> Using network benchmarks, three main metrics were measured: network latency,
> network bandwidth, and memory bandwidth saving.

I was hoping you could share actual percentage improvements to justify
the new code.  If there's no improvement, obviously there would be no
point in adding the code.  If there's significant improvement, it will
encourage using this in other drivers, which will improve the code and
testing for everybody.

Bjorn

