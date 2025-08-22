Return-Path: <linux-pci+bounces-34516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE3B30DCC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 07:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8D4AC0C76
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 05:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3C1917D6;
	Fri, 22 Aug 2025 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="lLv2XI6s"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43241C62;
	Fri, 22 Aug 2025 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838836; cv=none; b=VcXKjQXwQUuYpB2GwXzewcFwqcl1p/+z267XZRKKVzXBpxyofPG2XnROlva4uRrl9LVtXKBC0613FaN0aqh5oPfaLgjClZsh8y8vrcnGI6Eh4+VzvtbQ4vJL2lfseXmbu5N/P8Vtfxa2Fmr5D6ENMfe78vQYLMH7rmkiGD/CBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838836; c=relaxed/simple;
	bh=km+Yjv1Qc2NqY6UOWUuhM012tqWuvW+EgsjZ4mNjXxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgjIjbFpBmVl8qPQ4ZMQwNxH504R+iN93Uv1/zREvlmkgIm866tHiS3ypqt004HK24loHyDqJoQXCILWZdifXrJiL9LCPiLUpAWIt8FIdiNKWiB/7TRjb+Z0hQx22PYe7UIJMCkjrmboVcKUMrtwO9bv7fRhTd1lmxo9LO43DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=lLv2XI6s; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4c7SF30blPzDQJ;
	Fri, 22 Aug 2025 00:41:11 -0400 (EDT)
Received: from [192.168.123.3] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4c7SDt2GYRz4c96;
	Fri, 22 Aug 2025 00:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1755837663; bh=km+Yjv1Qc2NqY6UOWUuhM012tqWuvW+EgsjZ4mNjXxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lLv2XI6sAtnLKqWrOHmGmek7bRd78FRpzTsmZfUYzntQqdifRki3B3Mk5obAwc4rV
	 4O6iL6KgF30nEf2NQZSQMeTVQtfsSMcpLcsbhTwmNcejRKDV9QbU5IwJ5huSftoUNZ
	 96MFNggYw8ZlNfWplucwsYJ4Bkn/hSLDWZSv1RbQ=
Message-ID: <60cc3bc5-b8b3-4b40-81e9-72b3154e8a46@panix.com>
Date: Thu, 21 Aug 2025 21:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
To: David Box <david.e.box@linux.intel.com>, rafael@kernel.org,
 bhelgaas@google.com, vicamo.yang@canonical.com,
 ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, mani@kernel.org
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <20250822031159.4005529-1-david.e.box@linux.intel.com>
 <5t2ekrhtixmzo7we2ylfys22fzbxkue2fsjoimgpn2wijme5o5@sudgicai3fjc>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <5t2ekrhtixmzo7we2ylfys22fzbxkue2fsjoimgpn2wijme5o5@sudgicai3fjc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/25 20:30, David Box wrote:
> Besides the review I'd appreciate a Tested-by on this patch. Thanks.

Oh, don't worry! :)

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


