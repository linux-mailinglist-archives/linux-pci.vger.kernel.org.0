Return-Path: <linux-pci+bounces-28725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D49CAC9384
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2001C05017
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0583194124;
	Fri, 30 May 2025 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VImXXTJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C5258A;
	Fri, 30 May 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622379; cv=none; b=bpu9B6BvTPxsUcEzy0lex4Y3ASBHjZeWHBf7V1msKteV2Lve4Chr1j2lrGv0DGqdibqpmxcJ+ZSxfYmMLPvUnWrsoBpnPfT0+Z+26vFHafhw5CJm8Q2afkYu7LuunzIJQP9PbnKcY2PplAZTQpQ6Wtrn4oLfLLCwVEfGzROy0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622379; c=relaxed/simple;
	bh=4gl8dUCffxbWT74cO0c8qTqtcjsb/ZE1Evms0ln2jU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mtazwsvr22co9Bu+ftW7HtyaNMQ45kM1+uxaHG9PrQaDi0dRSL7YzbSJbXgnD3TxfE5Dyp55sYZMsiajwivdQp/IFgRNUyAd6pTI4og51tOBakmVk2pRnBWuxd1uTshPlRvk6TIs88ESpC6tT1hKP1//k+pKa1mDitVXgopT0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VImXXTJ4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.200.22] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id A16E2203EE17;
	Fri, 30 May 2025 09:26:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A16E2203EE17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748622376;
	bh=kKMCiJ564pe1xngnFVI97L6tQgSCXjivTIKDQLWSdJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VImXXTJ4G7YyU/cSHkqcyXm3pWm38kDsOdgfwLLmSjvicJeNqJdaHlIWmTUVSDKmD
	 VDsdPMh8v+Xbkxz9980XHrVbw+zA1qnqYLVMFmOIryt2f4/joJGpnu3SiNz5OdVGET
	 PrALftjTgvYIzv80I+q65qpkt74Wub6BQQUGK1w4=
Message-ID: <b23fb8f4-0da7-4403-8a2d-665d5675be9c@linux.microsoft.com>
Date: Fri, 30 May 2025 09:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Reduce delay after FLR of Microsoft MANA devices
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
 code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org
References: <20250528181047.1748794-1-grwhyte@linux.microsoft.com>
 <aDg4PE4Zbzwps71E@wunner.de>
Content-Language: en-US
From: Graham Whyte <grwhyte@linux.microsoft.com>
In-Reply-To: <aDg4PE4Zbzwps71E@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/2025 3:34 AM, Lukas Wunner wrote:
> On Wed, May 28, 2025 at 06:10:47PM +0000, grwhyte@linux.microsoft.com wrote:
>> Add a device-specific reset for Microsoft MANA devices with the FLR
>> delay reduced from 100ms to 10ms. While this is not compliant with the pci
>> spec, these devices safely complete the FLR much quicker than 100ms and
>> this can be reduced to optimize certain scenarios
> 
> How often do you reset these devices that 90 msec makes a difference?
> What are these "certain scenarios"?
> 
VF removal and rescan is the main scenario for runtime repairs and driver updates.
Doing this on scale with 100ms adds up to significant time across multiple VFs.

> There are already "d3hot_delay" and "d3cold_delay" members in
> struct pci_dev.  I'm wondering if it would make sense to add
> another one, say, "flr_delay".  That would allow other devices
> to reduce or lengthen the delay without each of them having to
> duplicate pcie_flr().  The code duplication makes this difficult
> to maintain long-term.
> 
This is a good suggestion, we can make this more generic.

> Thanks,
> 
> Lukas


