Return-Path: <linux-pci+bounces-37494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD63BB5BEF
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 03:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BB1B4E314D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459A3BB44;
	Fri,  3 Oct 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="nHO82ek/"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362231A294
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455294; cv=none; b=jzw9CFaPwIDF6YblEfzPgkdmecS1GgOMq0mPfF/zHgP5nE2tukoLQjmIlJJRAypSUv+3OBFL0MIKrO7EDTfVat7qALKUc63bMvrL3vLdKYPlntyxlWksoXtumsj5Ujr8ahd5Mj9sIxrDLLYPo1dzGwrIPxDLG+OPCaoouTAaagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455294; c=relaxed/simple;
	bh=QXRImLRy9oSywKiR7BENIxwerMx7Sqcu+ntqwE/ssfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWbeGFLP4LHPymmEKoT7gxh6wKMyzMjdo7tYKtCF1sLWd3cuW6dwspXL6muZgtSk6gtXfXFuloIKElfvTm3io6MQkYr1+UFBYlxWGGxGHekc4UIqy+DlPTVeC5z4R7euv3J7Wbg61pAEUID6Wa5gctkD19lZ1AcnppW+nHkVkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=nHO82ek/; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4cd9dZ02lrzDPf
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 21:13:06 -0400 (EDT)
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cd9Wm2QL8z15Qc;
	Thu,  2 Oct 2025 21:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759453684; bh=QXRImLRy9oSywKiR7BENIxwerMx7Sqcu+ntqwE/ssfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nHO82ek/Et2IOGqlIMb3ueAl1nkJZNqE5OgGtv4wNWmSLySUc56YydL7zkvFwQOZh
	 JAQulzjItf4LuD53W0Yajfx11JV2EMHt8G8X+SBUizjVIlB4Mg9sYnneqcsPIMjiNa
	 cvvexEljaAgnoa18p1mNx3jGN5v9JtOkO0NegsZA=
Message-ID: <e9f17b5d-48d7-4540-9f91-cff3c631218b@panix.com>
Date: Thu, 2 Oct 2025 18:08:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


vmd

On 10/2/25 18:06, Inochi Amaoto wrote:
> On Thu, Oct 02, 2025 at 05:58:59PM -0700, Kenneth Crudup wrote:
>>
>> Resending to re-add linux-pci (Vger thinks my tablet's MUA is "Spammy")
>>
>> I'm going to figure out which line is is that's killing my NVMe IRQs.
>>
>> FWIW, my NVMe is behind a VMD bridge(? I guess that's what it is):
>>
> 
> I think so, can you do "lspci -k" for this bridge? So I can know the driver
> for it.
> 
> Regards,
> Inochi
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


