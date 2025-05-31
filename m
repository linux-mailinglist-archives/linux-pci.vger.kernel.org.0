Return-Path: <linux-pci+bounces-28766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FFAC9B57
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9213BF772
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B123C50A;
	Sat, 31 May 2025 14:15:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365F1758B;
	Sat, 31 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748700946; cv=none; b=VBGNmfKoNlPGfqog5BLGdbSK3+5eToRFObNjy9UMFrvgScezi/KAAEOmLsf1rRVnhcK2nuzQfXkD0DmTLxbqtUuocLEi1HN9kA7MxFI98nbRirnmMW2hX29Y/86DMFWD1FonSG69fZ+XGSJo0ZDNteJ196wfLaIqcU1olrGj3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748700946; c=relaxed/simple;
	bh=+AbBPIg8jujjvnsIiFys7cvXSxsuoXKAm1dwhoDtFuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8/lA3T8wvZdMnEOqFPhHfKabgoFs0yo3cNI12n5i3PZOnNdvRO8GHwKX43oSW1SJTonWwpBN4U3y1e6n9AN+MW3duBH2rYWuoIJg14Bzx485FezyIblSfyq4hTwb1dDJyVrd1vodf/achVLxVp21lQr37ZT/L+mF1bu8ttRVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4B5182C000A5;
	Sat, 31 May 2025 16:15:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2251CC9C53; Sat, 31 May 2025 16:15:41 +0200 (CEST)
Date: Sat, 31 May 2025 16:15:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, rostedt@goodmis.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org, tony.luck@intel.com, bp@alien8.de,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <aDsPDTVkH5kkc_Fk@wunner.de>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
 <aCxdFm_BpgOTFFUv@wunner.de>
 <aCxxA-4HEnZ-O2W0@wunner.de>
 <9b46a12b-90e2-c1ba-9394-5caa23a5cad7@linux.intel.com>
 <aCx_aXy9MEs6XKZE@wunner.de>
 <6af283ea-bd36-44a7-949a-2ab8c80cf136@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af283ea-bd36-44a7-949a-2ab8c80cf136@linux.alibaba.com>

On Thu, May 22, 2025 at 05:50:05PM +0800, Shuai Xue wrote:
> As @Lukas points out, link speed changes and device plug/unplug events are
> orthogonal issues.
> 
> Based on this thread discussion, I believe we need additional tweaking to
> introduce a new tracepoint (perhaps named PCI_LINK_EVENT) to handle
> link speed changes separately.
> 
> Regarding our next steps, would it be acceptable to merge the
> PCI_HOTPLUG_EVENT to mainline first, and then work on implementing
> the new link event tracepoint afterward?

Yes I think so, I think this patch is ready to go in.

However I'm not part of the PCI maintainer team,
it would have to be applied by them (barring any objections).

We're now in the merge window and it may be too late to squeeze it
into the v6.16 pull request, but maybe it can be applied after
the merge window has closed (in 1 week).

Thanks,

Lukas

