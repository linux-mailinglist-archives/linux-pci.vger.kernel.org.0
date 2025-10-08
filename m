Return-Path: <linux-pci+bounces-37736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB778BC6AA2
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D89E3AEC8F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078C1208994;
	Wed,  8 Oct 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="HEci22r1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B72D05D
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958444; cv=none; b=p+0ElH8daHGqQmbyB2ZWtgWgajnoskNnimBxeXTkug+70v8E8iaWVzwVvWsO17hz5M79q1agqEDMb052spUsOI8k7IgOQi33yIQjQyy8vXacdTglPA3TjhRLm5zJemkf9Zgm/WmT3Rz2m50k6hbhNkujeFtqC+Tr+1CbtA/AAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958444; c=relaxed/simple;
	bh=c78HkM+84oRnENFKTR8pSgurMjuHACctJhk0p2dIfws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDgOAOBhMIxLdtPjpRTVglXInnfKC2soBtMaZ7v3G6FhwjGJrUZpjFZgeWvanmUPncCxUV6low+3LsQLatAyjRzBfa6TVFz2knd1pLhbJcDONEEcW9CNVWdMRS7xPgWahXBNw1yWej8/TQViAPZjewpv9MhbsoiDWYACpVend5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=HEci22r1; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4chmBd4zxsz43W5;
	Wed,  8 Oct 2025 17:20:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759958442; bh=c78HkM+84oRnENFKTR8pSgurMjuHACctJhk0p2dIfws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HEci22r1RLxP0YyRDM+7zdiycjISPw36MB7n/ydYeqPeY7NXwWngG4dwnYi4ZqgYU
	 U5lFyGCOO5yqaTMIpyU4oBtXr9pU+h/itI589V0qauOvxiTGqU3voiXgmLp42bTi6I
	 OwImiZF5rCiKGX5uZOjl67Nv2QrKnEzXxaSGGLIE=
Message-ID: <2d82c77b-78a7-4eb8-8940-3d3d2cafc800@panix.com>
Date: Wed, 8 Oct 2025 14:20:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available memory
 to use loops") gives errors enumerating TBolt devices behind my TB dock
To: Bjorn Helgaas <helgaas@kernel.org>, Kenneth C <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20251008205812.GA641752@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251008205812.GA641752@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/25 13:58, Bjorn Helgaas wrote:

> This worked for me:
> 
>    $ b4 am https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com

TIL about "b4"! Going to get it now.

> Or I suppose you could use the "(raw)" link and save that.

I was looking for "raw", I guess it moved. Ctrl-F'ed it

>> I just "git remote"ed your tree, do you have a SHA? I'm not seeing it.
> 
> Should be 4230b93d836f
I must be using the wrong remote then, which should I be using?

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


