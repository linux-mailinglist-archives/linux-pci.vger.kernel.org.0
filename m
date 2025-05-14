Return-Path: <linux-pci+bounces-27716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B0AB6BC5
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15644C1426
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847F278E7E;
	Wed, 14 May 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IxF6vlFn"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977E278E7F
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227046; cv=none; b=fX7IM5RoL0FWoe9QZ3V+TAoQ9XufR47iAigrjuCD21F8BuRKl0xJJVBhTQ0pxJTIHzW1pa3xKBBU5vAdx1UfRtnZ0rWuUkAUO+KkRbKgsqrDbbu7i9zT20JQvslLv4hw25kGF4YqsQ2AtcUrikoaQ8EA+D6E1EmbZhJw454k8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227046; c=relaxed/simple;
	bh=xsaMT00b8k+kMS92GkXskE2nqsn/Ux50QSzH+gf3Ovo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHJi8pITHf1sSCjVpWRTa71zkYtGobDsM1N8a6JLme4dxQyrwm1iNH+wOUrNaF2ymr3qh6jzzY4yzRKaQS8RkwYW+iW1A1Tybtxcm6W+uclMpH9IGBWbHGIz0mIezQm/LYzYrxlRMqAbeaeQiZz4qKpS4x8wWCEUeW7ddBAsgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IxF6vlFn; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f3b2d28-38d0-482c-b79a-5aabed6b6ea8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747227032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFMBLaoGq6dnZ92tVmPA4doF5MtxaUxNygUazLGOe80=;
	b=IxF6vlFnNK9TlkLzq4WOLGy63ODcKJMYA/IIvpCTPwu/fBjK5WK8TTHAGOF6v+qB0vnR97
	uUTDJCtEx44YEiXQUIXEyviZq9aG9EhZiiR2iKnD09Ef0ESpsIxRX/+eq1RCiDh0fA+/dg
	K4GjRwhqaItrLct6Yi7JQaft4ojDsTM=
Date: Wed, 14 May 2025 14:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <0b01a3ae-4766-490e-939d-1d16c2748644@linux.dev>
 <bfb8e9a6-92c1-4079-aec0-b1ad2b245c70@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <bfb8e9a6-92c1-4079-aec0-b1ad2b245c70@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/13/25 08:23, Péter Ujfalusi wrote:
> 
> 
> On 12/05/2025 15:59, Pierre-Louis Bossart wrote:
>>
>>> The audio IP in Wildcat Lake (WCL) is largely identical to the one in
>>> Panther Lake, the main difference is the number of DSP cores, memory
>>> and clocking.
>>> It is based on the same ACE3 architecture.
>>>
>>> In SOF the PTL topologies can be re-used for WCL to reduce duplication
>>> of code and topology files. 
>>
>> Is this really true? I thought topology files are precisely the place where a specific pipeline is assigned to a specific core. If the number of cores is lower, then a PTL topology could fail when used on a WCL DSP, no?
> 
> Yes, that is true, however for generic (sdw, HDA) topologies this is not
> an issue as we don't spread the modules (there is no customization per
> platform).
> When it comes to product topologies, they can still be named as PTL/WCL
> if needed and have tailored core use.
> 
> It might be that WCL will not use audio configs common with PTL, in that
> case we still can have sof-wcl-* topologies if desired.

Right, so the topologies can be used except when they cannot :-)

> Fwiw, in case of soundwire we are moving to a even more generic function
> topology split, where all SDW device can us generic function fragments
> stitched together to create a complete topology.
> Those will have to be compatible with all platforms, so wide swing of
> core use cannot be possible anymore.

I couldn't follow this explanation, or I am missing some context. My expectation is that as soon as someone starts inserting a 3rd party module all bets on core assignment are off, I am not sure how rules could be generic without adding restrictions on where 3rd party modules are added.


