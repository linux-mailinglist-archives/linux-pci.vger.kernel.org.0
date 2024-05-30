Return-Path: <linux-pci+bounces-8071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B4B8D4664
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 09:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640A11C20EE3
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE17405C;
	Thu, 30 May 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7KT9rvZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67583947E;
	Thu, 30 May 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055317; cv=none; b=uvP5iCqK3WSfe8krYxJR8b6I7A6uUTYcgjkVCb1z9iCi0W+Nl27A+nkDYY2K+SW+sD6DQUZlkbiUP4GZgknlgKeMRE9WhC33sGVBs+64mI+lcphKeIRTLMgtlELt/DIr4DqBcJmLYR8N9w6LtWSg1b0Mp+D7R5DOUCcm7g8DQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055317; c=relaxed/simple;
	bh=KrIXXGCyYoQepPvoPZ939b4c91CImdKHjnysOffQO0g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LnS2bSaoLL6RUHDujj95+JTBVn8kdE6qZpZZTuNZuUmCX43mSbY1TcRUZNj1g7HVLFiTkGikobUwRz7GxgSs8B2WWcViiZPPf+nub04IuA6wL5YQ6wrmOXET1oF8hblpnkORG8eVV6t4tVcnKyIPeYrLRkdeK7NHzfi2kDLZa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7KT9rvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C5DC3277B;
	Thu, 30 May 2024 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717055316;
	bh=KrIXXGCyYoQepPvoPZ939b4c91CImdKHjnysOffQO0g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=a7KT9rvZi8dNyYFnxxT7cmUPUzHD+e1+BG+wsH0h1+uBaZYeG+zU7+Aa58/0PfXLF
	 zwExgtoyc41YtzO93xVOVvFBcnIB/XJ5QVn2nS+dBjb4fckSeit7HdYec88Aaipf5p
	 wB3k4JOnV0a8QG30hGeKRFvKVPjidCZB6AEeEgWya57b/3aDHgI3+Krn3WqbHrAGs1
	 A8mZoGQcmHtdOTSXzvojw7Ge63LZRYrKU8JkPcdrjPw8iCt23kMikf4m3jclJ6JAwv
	 AegyuNCXdSqh9/vSretBA9Nun7b1g7ASPxr3SdDfcwQgts5SEhWpdgEYZQ6HWOwGWR
	 yKPw4U52dAd3w==
From: Kalle Valo <kvalo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  <linux-wireless@vger.kernel.org>,  <ath11k@lists.infradead.org>,
  <regressions@lists.linux.dev>,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,
  <linux-pci@vger.kernel.org>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
References: <87v82y6wvi.fsf@kernel.org> <87wmncwqxf.fsf@kernel.org>
	<87sexzx02f.fsf@kernel.org>
	<66582bee45da8_6ec329496@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Thu, 30 May 2024 10:48:32 +0300
In-Reply-To: <66582bee45da8_6ec329496@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Thu, 30 May 2024 00:34:06 -0700")
Message-ID: <87jzjbwxin.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Kalle Valo wrote:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>> > Kalle Valo <kvalo@kernel.org> writes:
>> >
>> >> Yesterday I run our ath11k regression tests with v6.10-rc1 and our
>> >> simple ath11k module reload stress started failing reliably with various
>> >> KASAN errors. The test removes and inserts ath11k and other wireless
>> >> modules in a loop. Usually I run it at least 100 times, some times even
>> >> more, and no issues until yesterday.
>> >>
>> >> I have verified that the last wireless-next pull request (tag
>> >> wireless-next-2024-05-08) works without issues and v6.10-rc1 fails
>> >> always, usually within 50 module reload loops. From this I'm _guessing_
>> >> that we have a regression outside wireless, most probably introduced
>> >> between v6.9 and v6.10-rc1. But of course I cannot be sure of anything
>> >> yet.
>> >>
>> >> I see different KASAN warnings and lockdep seems to be always visible in
>> >> the stack traces. I think I can reproduce the issue within 15 minutes or
>> >> so. Before I start bisecting has anyone else seen anything similar? Or
>> >> any suggestions how to debug this further?
>> >>
>> >> I have included some crash logs below, they are retrieved using
>> >> netconsole. Here's a summary of the errors:
>> >>
>> >> [ 159.970765] KASAN: maybe wild-memory-access in range
>> >> [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
>> >> [  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
>> >> [  224.695821] BUG: KASAN: slab-out-of-bounds in lockdep_register_key+0x755/0x8f0
>> >> [ 259.666542] BUG: KASAN: slab-use-after-free in
>> >> lockdep_register_key+0x755/0x8f0
>
> The proposed fix for that is here:
>
> http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch

I get "Not Found" from that link, is there a typo?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

