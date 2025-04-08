Return-Path: <linux-pci+bounces-25501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9EA80F8B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 17:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697973A061F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC0B1DA612;
	Tue,  8 Apr 2025 15:11:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041B1E0DE8
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125114; cv=none; b=GzRCX1YjuzK4mu1J4ShvpxDSvjtG/rAwVPTt5DW+eKwmLpEc+1VRK5yTtxa3cPBViHdZquQ3mphWbz55935obUO016+uRCvimr/jS6pZPzCBlu1GTFH/QbVTBtGc4n9g6xlIUE5OkDvvMDlfUeApNE0baMojTL9Y1YsNzKCTyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125114; c=relaxed/simple;
	bh=vcBf1F3m7nMSuASpNIz+Iswhrm3OT9YaFOpgZaKLgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLDyXYuymOnAKPjjsKTe8i/CgW5pO/QDIlZq4sA96b7maROXUeqlldnBcWekDJG+JzAWX8zbxeJ+nMm6dG2NYxLA39EAfmf+yv9JtT70LRLyDQj4dDtHwa6IVjiQptKPPQvyyAPsvwvpz09VZCFZnl2FaEa+CtHyONl/78KT0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1F44C2C05245;
	Tue,  8 Apr 2025 17:11:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1861736632; Tue,  8 Apr 2025 17:11:43 +0200 (CEST)
Date: Tue, 8 Apr 2025 17:11:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Damir Chanyshev <conflict342@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: P2PDMA support status for the sappire rapids+
Message-ID: <Z_U8r19u9rdPzXDh@wunner.de>
References: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>

On Tue, Apr 08, 2025 at 05:48:16PM +0300, Damir Chanyshev wrote:
> I have a question regarding p2pdma support, I am not an expert in the
> kernel subsystems, please pardon my stupidity.
> While investigating performance opportunities, I stumbled with dma
> between cpu root complex and pcie switch root complex. And found white
> list for the Intel platforms [1]
> 
> Typical topology looks like this rdma nic<>cpu<>pcie switch<>gpu/xpu,
> for each socket.
> Questions:
> List not updated because new hardware doesn't support this feature?
> (For example abandoned for the CXL3+ )
> Or just not tested for the new platforms?

Basically just lack of resources to do proper testing and amend the list
on a regular basis.

Feel free to submit a patch amending the list for newer platforms if
you got p2pdma working on them.

> Pardon my tone, if it sounds harsh, don't mind it, unfortunately
> English is my third language.

That's fine but it would help us if you could clarify whether you're
associated with an OFAC sanctioned entity.  Unfortunately we're now
forced to perform background checks on contributors before interacting
with them:

https://www.linuxfoundation.org/blog/navigating-global-regulations-and-open-source-us-ofac-sanctions

I note that there's a developer with your name based in Serbia.
If that's you, you're probably not associated with a sanctioned entity:

https://rs.linkedin.com/in/damir-chanyshev

However there is another person based in Saint Petersberg and the
situation is less clear in their case:

https://ru.linkedin.com/in/chanyshv
https://github.com/chanyshv

I am very sorry it has come to this.

Thanks,

Lukas

