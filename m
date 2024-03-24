Return-Path: <linux-pci+bounces-5040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBB4887C0D
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84E3B212D4
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571014AB7;
	Sun, 24 Mar 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="adm0li5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32C7F9;
	Sun, 24 Mar 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711271349; cv=none; b=dJNPf6XnVKOZiIyGgnLGE0QnPGj7V9+fc+cg+DZgyvGoYbt/b/5XOfui3htLapFn7Z7wvP3A36hV+DJ41Wi8/U15Ktrho6hWWPHt+weu7go1W6iFtJKh82gCMUIIhxc+Ko1Ho7k4gFPz76B/r6h+n0tALE9wBJ8+sCQ8FKNGUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711271349; c=relaxed/simple;
	bh=+Rf2sP5k+yxgykPJQTji8BK3SG1Mw51mUBOFY6xa+nY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GIfjxYXVuYdPbyjwaMiw+UAO9cCBEt7rN9YxtoTHbIyaSUDACxGGNV6riA6GizQ3UwHe+2lrAlM2UHaZTOts1t5YLo4x+oX3Q8G3Vs05b41v/cj02vT1pRnQhPJeUQcZy3Sp6OFZg7fH4x9tmbYtuMD63f6l2syCqzxz8ylpZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=adm0li5a; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E312045E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1711271338; bh=Rhs1loPtFsL5EIYRvgUlHECbLqphkffPY0MFBefhNnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=adm0li5aTWzfRI45SrW1qaWvHcYmJES1k9KLkhfBn+k6H1bKCODAOPjQeWqjo2sbn
	 vn1Kyx1r0cb3ltOQOYjyRCbuV7T/XOj/pSOf1/NHMvPz/JwL4cVNjxvHTi0vUrIsqx
	 YGfGTw/J3vEH6VO2QVX95J7k/8doGX+/83MwcxkkJzvkTPScr0CpwgpmbHdI2U9tRY
	 7i0rNY436KnSCKp5D1xe9O5g0I/F4cjiQx4WYHSfFSsLMDX/eX52eBiJV+RTqV314R
	 +7KiRI77xecl64M37DOcsgh+HmPCauxpSvG6ZVsyJqY0cNQ+6y9ShK6wrFSslfusjd
	 2uWTC0kJI/H+w==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E312045E37;
	Sun, 24 Mar 2024 09:08:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas.wunner@intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] cleanup: Add usage and style documentation
In-Reply-To: <65ff7a88e93fb_2690d29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322090630.GA40102@noisy.programming.kicks-ass.net>
 <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zf8_RYHW7QmCzl2-@casper.infradead.org>
 <65ff7a88e93fb_2690d29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Sun, 24 Mar 2024 03:08:54 -0600
Message-ID: <871q802dzt.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Matthew Wilcox wrote:
>> On Fri, Mar 22, 2024 at 12:10:38PM -0700, Dan Williams wrote:
>> > Peter Zijlstra wrote:
>> > > So I despise all that RST stuff. It makes what should be trivially
>> > > readable text into a trainwreck. We're coders, we use text editors to
>> > > read comments.
>> > 
>> > Ok, I will rip out the RST stuff and just make this a standalone comment.
>> 
>> I would rather you ignored Peter's persistent whining about RST and
>> kept the formatting.

Dealing with that is definitely the least pleasant part of trying to
maintain docs...

> Hmm, how about split the difference and teach scripts/kernel-doc to treat
> Peter's preferred markup for a C code example as a synonym, i.e.
> effectively a search and replace of a line with only:
>
> 	Ex.
>
> ...with:
>
> 	.. code-block:: c
>
> ...within a kernel-doc DOC: section?

I'm not convinced that "Ex." is a clearer or more readable syntax, and
I'd prefer to avoid adding to the regex hell that kernel-doc already is
or adding more special syntax of our own.  How about, as Lukas
suggested, just using the "::" notation?  You get a nice literal block,
albeit without the syntax highlighting -- a worthwhile tradeoff, IMO.

Thanks,

jon

