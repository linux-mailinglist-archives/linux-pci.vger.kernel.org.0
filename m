Return-Path: <linux-pci+bounces-5938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F389DBC2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589131F2310A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99E7F7D0;
	Tue,  9 Apr 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1H9kzIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77707F7CB;
	Tue,  9 Apr 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671740; cv=none; b=j8IkOvfFoxAA6UGWjbIdN7x0HipMoxfWZlINGNpPzuxiFIDvr/V3S76TX273qhYk7USjgtTga7Dq1BDnrYyGA7KnTyYUK5u+cqH319IplFAVkD8WG/TEsIv7eRj/s7dvYKD26DsbM13uVRymvJmu4MQiHovsBUrmgibqhcxy6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671740; c=relaxed/simple;
	bh=5HWWF5hCPe5YsSIRdcvkqpNfkPs/Gp5QtptUKd9BSxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ6aVKewhnnPtJpON1hobpRkUYnvPKZtivvrii5mpgb5EIRP0M8PnGVqTmugDdRrUEZTsu9iLR6BHRPC0Ce+ugnaTOSqi7ifJkI/9gPtlzjOEl0o3hxrRoYgn5wX096j6uJPQ2oGrmv5AGF+ffX7cM83DTh5kVC8BD8Jwq7Oe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1H9kzIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21FCC433C7;
	Tue,  9 Apr 2024 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671740;
	bh=5HWWF5hCPe5YsSIRdcvkqpNfkPs/Gp5QtptUKd9BSxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S1H9kzIoBBGS7wg7W43o8A5fvPJbCIu8mMlQbuAP7r15vqC+eZGokxKPbkktPd5qf
	 VEUJqwpHco4NUWKiKeIjQFPhG8T/MO+H9TLB5j8U+w8rIiHjORNi7wF4Smw1DFHUfR
	 fT+jLMj4Mhtw828NAdBp18ZfW+hnom6EHOrpyRSEvayh6JrO6s/aFqN8PXOsoSeDwz
	 aIxd2efAKdCp0E2C84UqxXwwzQA7Qb5q+NdvGmh889jShkaBZ3V59sb+RsPHqCtbnu
	 5Ul6JFkj51ax1//EBXK8VtIdVGb7Uvs8CbBrxoxWS/S7LfX3s1tNLPISfJFVitIpzs
	 eTpcmpCxqjDYQ==
Date: Tue, 9 Apr 2024 07:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, John Fastabend
 <john.fastabend@gmail.com>, Alexander Duyck <alexander.duyck@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, <davem@davemloft.net>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409070858.41560b1c@kernel.org>
In-Reply-To: <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
References: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
	<678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
	<20240405122646.GA166551@nvidia.com>
	<CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
	<20240405151703.GF5383@nvidia.com>
	<CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
	<ZhPaIjlGKe4qcfh_@nanopsycho>
	<CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
	<ZhQgmrH-QGu6HP-k@nanopsycho>
	<66142a4b402d5_2cb7208ec@john.notmuch>
	<ZhUgH9_beWrKbwwg@nanopsycho>
	<9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 15:11:21 +0200 Alexander Lobakin wrote:
> BTW idpf is also not something you can go and buy in a store, but it's
> here in the kernel. Anyway, see below.

For some definition of "a store" :)

> > Could you please describe in details and examples what exactly is we
> > are about to loose? I don't see it.  
> 
> As long as driver A introduces new features / improvements / API /
> whatever to the core kernel, we benefit from this no matter whether I'm
> actually able to run this driver on my system.
> 
> Some drivers even give us benefit by that they are of good quality (I
> don't speak for this driver, just some hypothetical) and/or have
> interesting design / code / API / etc. choices. The drivers I work on
> did gain a lot just from that I was reading new commits / lore threads
> and look at changes in other drivers.

Another point along these lines is worth bringing up. Companies which
build their own kernels probably have little reason to distribute
drivers out of tree. Vendors unfortunately are forced by some of their
customers and/or sales department to provide out of tree drivers. Which
in turn distinctiveness them from implementing shared core
infrastructure. The queue API is a good example of that. Number of
vendors implement pre-allocate and swap for reconfiguration but it's
not controlled by the core. So after 5+ years (look at netconf 2019
slides) of violently agreeing that we need queue alloc we made little
progress :( I don't think that it's a coincidence that it's Mina
(Google) and David (Meta) who picked up this work. And it's really hard
to implement that in an "off the shelf device", where queues are fully
controlled by FW (no documentation available), and without breaking
something (no access to vendor's CI/tests). IOW while modifying core
for a single private driver is a concern there's also a ton of work
we all agree needs to be done in the core, that we need help with.

