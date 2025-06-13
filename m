Return-Path: <linux-pci+bounces-29749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA25DAD9155
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E33BB422
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C981B424F;
	Fri, 13 Jun 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT8Pr90a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE072E11C6;
	Fri, 13 Jun 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828786; cv=none; b=C8umc/6FqM38BVY0qlVRbUhUgM3uihCoMU4b7fnRgLKA+wlyIjyUaNKt+1i+8jnmOCx/UP5xh7thblNyZczwY3wXqxoSfBFAJfqIPy4TTmrvD2NywdFYBkfa5DcrPSB1m6nzTN0lX6KbPiKFObgeTuo5rBUyuIuMo6F2Zfgcj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828786; c=relaxed/simple;
	bh=TxSx9uI/el5NQN7lNloQxdE5TP1Wr5TQHhVJmFCBOG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bfQ5ghqhMPQI6EfK19nn5zbVLCG23duGWDDIp0Jouu195wcb9i+xvPVNIiZqH2C7mJ2CHe174B2dR2jwUI3vzB57+wcQCWuwjQvo9rcX5wTsoPPLRUSlbOUClqHLpfm124obs9Cu6ukE7Bw3KOYtmMXDsGz1v28zRJNfn7qWH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT8Pr90a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D731AC4CEE3;
	Fri, 13 Jun 2025 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749828786;
	bh=TxSx9uI/el5NQN7lNloQxdE5TP1Wr5TQHhVJmFCBOG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rT8Pr90a3Y+G7AJRhxHZ+op0+llAi2hzmxKOc4Pxx/9kkgcGFb94XiTUXYxqlM4vj
	 f6F/gacH/EzBxBGIxPnDDY8khbnhXoEN8uVRvEG3yOrdX8qndBus4qAO1VHF6h9QO3
	 rc4AB/jJUlLA+oXWsDmiMzuJZe0kBXmUNizbrMVoAESY7SkuR3YQyAW8Isyb8a4mHF
	 TtSyXpgiC+U0QFlNDcW3jOZuve69bcKXZSzbWLbkI3NeJ0EjqwVmX6uOdpldMX0RsA
	 kNzvC9v97WUqSKKRhKE7Wa53RwBS6OLMRxkmoJPQQRZkDlz8F77Sxuyx8bdLyVFcC1
	 IsMk34Ki5+ATw==
Date: Fri, 13 Jun 2025 10:33:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Graham Whyte <grwhyte@linux.microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <20250613153304.GA959741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ad1095-89ba-4044-91ce-1ab37bcc79dd@linux.microsoft.com>

On Thu, Jun 12, 2025 at 09:41:45AM -0700, Graham Whyte wrote:
> On 6/11/2025 11:31 PM, Christoph Hellwig wrote:
> > On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
> >> We can ask our HW engineers to implement function readiness but we need
> >> to be able to support exiting products, hence why posting it as a quirk.
> > 
> > Your report sounds like it works perfectly fine, it's just that you
> > want to reduce the delay.  For that you'll need to stick to the standard
> > methods instead of adding quirks, which are for buggy hardware that does
> > not otherwise work.
> 
> Bjorn, what would you recommend as next steps here?

This is a tough call and I don't pretend to have an obvious answer.  I
understand the desire to improve performance.  On the other hand, PCI
has been successful over the long term because devices adhere to
standardized ways of doing things, which makes generic software
possible.  Quirks degrade that story, of course, especially when there
is an existing standardized solution that isn't being used.  I'm not
at all happy about vendors that decide against the standard solution
and then ask OS folks to do extra work to compensate.

Bjorn

