Return-Path: <linux-pci+bounces-37495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A4BB5C4F
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 03:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 474DF4E1B4B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC3283C8E;
	Fri,  3 Oct 2025 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="jbyOOMaw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF32882AC
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456289; cv=none; b=pyBIJ/HrARERBAPm6k37coEDhzvyfLqeRymLJwSbo+Zx9vVqPhfHOOX6pOfcSCUWkR/hjudV1F4f6Pr0mmfq+Bqh76umJF6Z5atNByx78B0ZO/8UeCpYyjS4ARKbwA0q/FbwSzMqbfnASItvCiFlUJIGUfxTxbipKLvZmYBugC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456289; c=relaxed/simple;
	bh=wR3S5W/+/fuufcxVfgKSXWWSitkyev0QS9F6J626CAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuD+/uCfX/TLLIlQZcS7XPIk2vi55EP+Eg9/r37ULowBIpg30+hr95h96quCpK9zJkv7uNgEVSb42mRja8QuGW1BXBS9fyqBRkTdROaq7+tLKjOeky9Tmwt9Hbhy3Ha+uHGzmTEzbcHmwSR/O/2euQDRgqN9qSls0pCl82WyqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=jbyOOMaw; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cdBTV5B1sz17Xg;
	Thu,  2 Oct 2025 21:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759456271; bh=wR3S5W/+/fuufcxVfgKSXWWSitkyev0QS9F6J626CAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jbyOOMawXEbDsOFR7uHPxbXDxSp/EFYfb4Jx7q0euaCXN9e2L/gVzTNv1W5QxPDiG
	 uIi412KMY9NN01TCAawE29J8qOh4J1NtNzWas4SJYtoe77v17m+ZXCLsyPStDQJDI8
	 UZuzP4SI/LmiVUgB/yvEzpEVUQYL+wnbihtPGlqs=
Message-ID: <b955d5a6-5553-4659-b02a-a763993fcd82@panix.com>
Date: Thu, 2 Oct 2025 18:51:09 -0700
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
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
 <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
 <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/25 18:30, Inochi Amaoto wrote:

> Can you have a try on this fix?

Bootloops, unfortunately, and very early on (in fact, so early ISTR we'd 
had a conversation previously about the first iteration of these efforts).

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


