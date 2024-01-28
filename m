Return-Path: <linux-pci+bounces-2630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE683F5F7
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B121C21B75
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1721E89D;
	Sun, 28 Jan 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwBFC0gJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E622F1D;
	Sun, 28 Jan 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706453598; cv=none; b=DcwWXWjEFjMneRiVXHubP2KNpCdTDJ3/xHm2OBiHjzn266LyF8AmTa2UuSP+K1WmSiHcZVFhm66n5548gnD4+/j5JqSAlRIlo2MAdyMwPt7L37JLzjn40K4UMPLEX8T8gmsDntlYlmHv2Y3/RqgzTgQdHOlXQodphDpzWWaiqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706453598; c=relaxed/simple;
	bh=X+8FkEZoC8PItaOFui9G+nO+r1xWuz0EZ2Fj5H7CVOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYS7qtj1b+NA5Lup9kNtHm7n10QboKxGa3i3RgEeOHeImMW9UMKWHGXHLSkP2g+dBrxImKb0itd+rXg5oRw5chD6Jz0Z9rjSrEX0XNkF5pAxTjJx0ZqssweN/5eLROyILVIwGfAQ5AlvzvmBqXnZBaZUgP2iNr2eg0ovcrwLRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwBFC0gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F52C433F1;
	Sun, 28 Jan 2024 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706453597;
	bh=X+8FkEZoC8PItaOFui9G+nO+r1xWuz0EZ2Fj5H7CVOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwBFC0gJ3F9MASW51QPtsNiaVIFzowQ3+OlJRJkf6iFRNwz9u712uue7mAnoJYoQI
	 7dinJv2gDRDZUIcZDvNl7pCOm7zAwmPSMJDmOrkrkTl7A4OSwXKVXkhYG84RebFHsX
	 kMNdDN+VvNV08eF7cRafX9bql9iYsFnXaIzsRiag=
Date: Sun, 28 Jan 2024 06:53:17 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <2024012855-limb-monument-cd86@gregkh>
References: <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
 <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <2024012631-removed-stuffed-ecc0@gregkh>
 <65b4112db4de0_51c7f2943a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b471ced39b_4e7f529431@dwillia2-xfh.jf.intel.com.notmuch>
 <2024012703-exclaim-ground-2b8b@gregkh>
 <65b5b11ed7af0_51c7f29463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b5b11ed7af0_51c7f29463@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Sat, Jan 27, 2024 at 05:42:54PM -0800, Dan Williams wrote:
> Here it is again without being beholden to keeping the old
> WARN()/pr_warn() regime when the group directory is not found.

Thanks for all of the response to my questions, much appreciated.  I
think this looks great, let me test it here and add it to the patch
series which caused me to want to do this in the first place and see how
it goes.  Give me a day or so, thanks so much I owe you a lot for
digging into this!

greg k-h

