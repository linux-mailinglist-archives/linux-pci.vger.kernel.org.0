Return-Path: <linux-pci+bounces-19681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34753A0BE0C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B511883C29
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE851CAA87;
	Mon, 13 Jan 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixZImuDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D13A8D0;
	Mon, 13 Jan 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787204; cv=none; b=ZFjbpqCg97LS035EZfBRD16StXIbrzutIpY04v96+BZlTjxstbC8CfieYqptxwB1tzTLMWkG7ZwfOepSXduHN2n9Wwl1RorC6TxbEvbRYPGAu3tkWmcrev+Q9KiY2VzA7NgfyEoOKyEcChkzoK4dmVwfdzuH1LLA1p9puJKl72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787204; c=relaxed/simple;
	bh=kkEPT9SH6eZSxMTtRu61LCsuirVhaWyNAb0QZt2aTH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyiCoeP8f+dUfSRxWO3Wv217fGNanZ3Fs803FbDTX4TnquMNAGPYR6KmAuD+GCOr0z3pFbdvIp60FlqBdd+qE0s6MEdgCBJBLLOHi99ha6r0gClfgccXpC3Pz4TPFDpUVAcKG8wXEODKq8nqrlOrQ4WkT2FmToFb4/VOuQ1qxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixZImuDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E09C4CED6;
	Mon, 13 Jan 2025 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736787204;
	bh=kkEPT9SH6eZSxMTtRu61LCsuirVhaWyNAb0QZt2aTH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixZImuDhU4eqfLD1GOd+Zjv7VLJ7M/YVfr7gwJJHegOQeLRM933U4Vosc3YGea+4A
	 45gdLXXOqX5j1GsOYkQ3LdmYnLHuN6iuaUmB4QlFen3TbmizNgV2FdDbaKaHPxe6sd
	 NDcUsXQcn2G5RGFCC3sljs2Cj2js4Lh9o46OwU7uBkvmdR4TN6SzYp0WGhzuQF1P+8
	 A+Us5l3aw/CRsM5IOedIcUFk1AGYlx0ttQcuw8OPyVDlteDSP7X5DdpfqjsxUdiE5o
	 30+X5COU7WXCuaQKr8MgLEDIMIj6Zht56ZubuKHq/Agkb9dtaPNsx3ggXwHWXiichS
	 X/6HWeXngkBZQ==
Date: Mon, 13 Jan 2025 09:53:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <Z4VFAZnQ_09cdexm@kbusch-mbp>
References: <20250110140152.27624-3-roger.pau@citrix.com>
 <20250110222525.GA318386@bhelgaas>
 <Z4TlDhBNn8TMipdB@macbook.local>
 <Z4UtF737b3QFGnY0@kbusch-mbp>
 <Z4VDIPorOWD-FY-9@macbook.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4VDIPorOWD-FY-9@macbook.local>

On Mon, Jan 13, 2025 at 05:45:20PM +0100, Roger Pau Monné wrote:
> On Mon, Jan 13, 2025 at 08:11:19AM -0700, Keith Busch wrote:
> > On Mon, Jan 13, 2025 at 11:03:58AM +0100, Roger Pau Monné wrote:
> > > 
> > > Hm, OK, but isn't the limit 80 columns according to the kernel coding
> > > style (Documentation/process/coding-style.rst)?
> > 
> > That's the coding style. The commit message style is described in a
> > different doc:
> > 
> >   https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
> 
> It's quite confusing to have different line length for code vs commit
> messages, but my fault for not reading those. Will adjust to 75
> columns them.

The output of 'git log' prepends spaces to the subject and body of the
listed commits. The lower limit for commit messages vs. code makes the
change log look readable in an 80-char terminal.

