Return-Path: <linux-pci+bounces-11020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE594100C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D51C22255
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DB1953A3;
	Tue, 30 Jul 2024 10:56:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D91DA32;
	Tue, 30 Jul 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336974; cv=none; b=XqVwjcBCgOj2Y7URnvnvz962pT5mwQFQSGY4VwY0et6n67/ha7ajrfetjmxUwiWqjGt8zKIu9IpjWmq1E76+u/TB0dJCD8wh2Fv3qG01oTb2QI7K0EmgE/4v+1G9Ii84bbYHo7QX0HXQ0I7WKp1ie+HlENp0nFRgUt/QvSTCWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336974; c=relaxed/simple;
	bh=LWkqXbpJPzQ1iJyfPF6IqW1+UWKTyl4FjmF8qqq7+8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvDPhPkjH1WV7w9DXdHQW9lMjMhFN7dxdIR2+0CQfiNYfoOjC3dAQ69eySsnyfreyn00l2iyF0QeUAnSMCaNDj6/bd8LuxfnWg2wm7zziwljWwtUP0UrzTdBU+KGmOXXC20ZkXWc15cnsaxgpdmcJnIs0JELi3E9mRyk3NYe+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 47D45100FC263;
	Tue, 30 Jul 2024 12:56:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1BD2439C012; Tue, 30 Jul 2024 12:56:03 +0200 (CEST)
Date: Tue, 30 Jul 2024 12:56:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5.10-stable 1/3] locking: Introduce __cleanup() based
 infrastructure
Message-ID: <ZqjGwy2Yo9QJx0RV@wunner.de>
References: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>
 <2024073039-palace-savings-1849@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024073039-palace-savings-1849@gregkh>

On Tue, Jul 30, 2024 at 11:40:28AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 30, 2024 at 11:30:51AM +0200, Lukas Wunner wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > commit 54da6a0924311c7cf5015533991e44fb8eb12773 upstream.
> > 
> > Use __attribute__((__cleanup__(func))) to build:
> > 
> >  - simple auto-release pointers using __free()
> > 
> >  - 'classes' with constructor and destructor semantics for
> >    scope-based resource management.
> > 
> >  - lock guards based on the above classes.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Link: https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org
> 
> Do we really want this in 5.10?

I think so because we may have to apply a lot more patches between now
and Dec 2026 which use __cleanup variable attributes.

(Dec 2026 is EOL for 5.10 and 5.15.)


> Are there any compiler versions that
> 5.10 still has to support that will break with this?

No, apparently not.

5.10 requires gcc >= 4.9 or clang >= 10.0.1
5.15 requires gcc >= 5.1 or clang >= 10.0.1

I've looked through gcc docs and the first version mentioning __cleanup
is gcc 3.3.6.

The situation around clang seems odd:  __cleanup isn't mentioned in their
docs before 15.0.0, yet we're only requiring 13.0.1 in the just-released
v6.10.


> Same for 5.15.y, I'm loath to apply this to older kernels without loads
> of testing.

I'm sorry, I don't have the resources to perform that amount of testing.
I've sent you a backport of the PCI/DPC patch instead which avoids
__cleanup.

Thanks,

Lukas

