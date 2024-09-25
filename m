Return-Path: <linux-pci+bounces-13526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABF98657B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2701F2110A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BAA43AA4;
	Wed, 25 Sep 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="RH94mpxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC095134BD;
	Wed, 25 Sep 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284487; cv=none; b=cr4PmVaoeigCym/UyOSnjrNBwxBLF7FnytZoP52YSWZZ5QwiuRQeyEeG3mt7vI6G5IyZtnCTAUzPRLm/9M6DkNc7bSWOa8JrY3qyNymG/R1nNKVK/Mss5aYZYkkrBX3aYNkWzaI34P3u8gjI2szhekhntvMvESwYAOQTY+gxWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284487; c=relaxed/simple;
	bh=aIW1QfRYwvuDJbIY3ZHeD9wGhOVohwX859RGPoS1nQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dywOxllQSWM8XJMKuBsp6rfNmdPmmxfUZzvTEHlC4haTMlL6F2On/0MkyxcpMrUqxaY3fTIwNl718yw6L2nwwIlrbAm1baBYmejDYxzcn3dny2QZRgUw9yN/06pNa12pUbSkirJQfAFYAIu85uwaIwggVigyE8uqzwNoxJwrNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=RH94mpxk; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4XDNCF2nF7zDQj;
	Wed, 25 Sep 2024 12:55:37 -0400 (EDT)
Received: from [192.168.80.67] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4XDNC55w34zl2J;
	Wed, 25 Sep 2024 12:55:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1727283330; bh=aIW1QfRYwvuDJbIY3ZHeD9wGhOVohwX859RGPoS1nQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RH94mpxk3EVikiQBZ1bjTttZbakCa8GRtM46BdWBji+xmCV9HMcCnb9vv83DEjwca
	 fl1W/jyqYBWNmmw7RlpXdEIW/qQ6/sOgA2YAVXrHf/gOa/E2YD241Cuc4hv472ZfDq
	 q7GRkY2Q8ZhpPmGrhhgNuksq8nQhzXTg2IP1ujdM=
Message-ID: <985893c0-ade3-4b23-b452-6f416e7ff2a1@panix.com>
Date: Wed, 25 Sep 2024 09:55:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 linux-pci@vger.kernel.org
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de> <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
 <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>
 <20240913052540.GN275077@black.fi.intel.com>
 <7ac9a400-fdb2-4d78-bacf-2e502c7338e8@panix.com>
 <ad0458ee-b75c-46f9-a012-1e0615aecf53@panix.com>
 <b29b8750-5235-4097-a880-d8620da2520a@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <b29b8750-5235-4097-a880-d8620da2520a@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/15/24 17:14, Kenneth Crudup wrote:

> ... and it turns out that my crashes on the CalDigit TB4 dock are 
> probably related to a Thunderbolt-to-NVMe enclosure that was always 
> plugged into to the dock; apparently when resuming "something" was 
> waiting for the now-disconnected NVMe drive to come back, leading to the 
> hangs. Disconnecting the enclosure from the dock seems to prevent the 
> resume crashes.
> 
> I may try and root-cause that issue later, if I have time.

So I've determined this problem happened somewhere between 6.10.8 and 
6.10.9; I don't always have the affected hardware so it'll take me a 
couple of days to bisect the issue, but at least I have an idea on where 
the problem is.

What's interesting is testing using the NVMe-to-TB adaptor directly into 
the laptop isn't enough to trigger the crashes, it has to be plugged 
into the CalDigit TB4 dock at suspend time to trigger a hang on resume 
if the CalDigit dock is disconnected in between.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


