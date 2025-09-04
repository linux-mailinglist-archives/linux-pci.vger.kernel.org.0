Return-Path: <linux-pci+bounces-35468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB2B44431
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 19:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA28C3B60D9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5E2F5484;
	Thu,  4 Sep 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="dnyhiNRY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE6223DFB;
	Thu,  4 Sep 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006222; cv=none; b=BF/u276K1ITWO/xR3WecOvUNxlF7n4VZlbkkdKBdlIB4aAsL5QpgNgMNKZi2TzGYqWr4j356onrkfEJxqPDy2fqJrp2ga6mqJGY+iOjk+X3HwXEZTMu+IUS6mfRlWRIHvySPXD6FRNzRE8qU2seIV/6hxA2ClT01v3EAd/VwU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006222; c=relaxed/simple;
	bh=PwEkw/L3lPTN7Vt5BEzJjtAPyOMvzL2GIs+DqSnYTJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVmwfExwK+OO62Yn57ezcYJNYBVvmeSOxJkEXmxu+1yfQUb4xCE9t+SjdIhOItOlEElLpSDo6HIncWInj9bGQOLN5uKCO7R88l/E1wjORf2hDk6cSWBAt+2KReos0z6jCgBHhPogQxcqMyrEmJVZdQgu6BR80BlNXMwINNa7T5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=dnyhiNRY; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.212] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cHmP44LtjzMcm;
	Thu,  4 Sep 2025 13:16:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1757006218; bh=PwEkw/L3lPTN7Vt5BEzJjtAPyOMvzL2GIs+DqSnYTJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dnyhiNRYvjxFegXGNMknsm0Bojq5TuflTKQaCEIbpYXO2xPOhMOPdtunq6zAKvN+x
	 O/yxRlPfY3e3uSZtD2xRZOZuTzljZ87yJebKRUrvSX+YUa/I/aIUpy+FBrSdOGInRN
	 VFHXwLpf8e1DDHU5glJiFxiy26bt82MaACQgtylQ=
Message-ID: <121a26de-b5d4-42a2-ae52-02b386f17109@panix.com>
Date: Thu, 4 Sep 2025 10:16:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org,
 bhelgaas@google.com, vicamo.yang@canonical.com,
 ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <20250904171158.GA1268495@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250904171158.GA1268495@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/4/25 10:11, Bjorn Helgaas wrote:

> but if we can get in -next for a bit now, that would be great.

Yes, please 🙂 Other than some my-hardware-specific gcc flags, this 
effort in its various forms is the only diff between Linus' master and 
what I run, and for nearly 3 years now; it'd be great to see it in 
mainline (and a hearty thank you all for getting us nearly there!)

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


