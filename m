Return-Path: <linux-pci+bounces-21379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92931A34E5A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 20:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383D67A1AE4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595E245AF9;
	Thu, 13 Feb 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="fiUBWwPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF86F073;
	Thu, 13 Feb 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474387; cv=none; b=aLHvOnRZhVrq8rgHPrannj0b2jun7xyQCeo4FB9UJdOf9tOGzvBPeb/EVq6rjYqurn64iQg9pa7fuJGkuaTLzwAqf6Up5QVBDqG0n1jMD78xNQTL2jAEkMpzkejTe3B27bCHqf7BKi09wwWn7AArUkhu+NmLYccSs2DigJ/ca6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474387; c=relaxed/simple;
	bh=yWgneawFTUkVylTx3C92PJfhBRZPP/GzP5EOE4+znMo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mB+DwKXeNVNrC9lPgNQ7+sVOp/DQ5BTw9iRMhqv0VSMXdUBqd4u7cONLVFjsv600H6Cai4Ko8/Es1qsQ/9zS3G2T/ESHFDSeApgur0v60veFdDIr/GnVPk4wSSJNKYGHX7fkBu/eFw5N1YhAHjntZILNFxOyMreI2IDbzTLpZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=fiUBWwPF; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Yv4kJ3KDSz4kdt;
	Thu, 13 Feb 2025 14:19:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1739474377; bh=yWgneawFTUkVylTx3C92PJfhBRZPP/GzP5EOE4+znMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fiUBWwPF2PRMCPWvGELDwrZa3QhHxxE21Wy6vJcoirB7505nQ5LY9M+C0RPTAG4UN
	 fhCl8vKuJtKW5G+sB9gnkImCKlZ2laedyb8tzvGxzj5MxdMKGkPHdD6+TzdoA064ng
	 eAt9AwfN2feFPz1zfoxaziBmaeKcpvEVGhhuNnNc=
Content-Type: multipart/mixed; boundary="------------TgT648rzmM6leWiofVovIR7G"
Message-ID: <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
Date: Thu, 13 Feb 2025 11:19:35 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250213135911.GG3713119@black.fi.intel.com>

This is a multi-part message in MIME format.
--------------TgT648rzmM6leWiofVovIR7G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/13/25 05:59, Mika Westerberg wrote:

> Hi,

As Murphy's would have it, now my crashes are display-driver related 
(this is Xe, but I've also seen it with i915).

Attached here just for the heck of it, but I'll be better testing the 
NVMe enclosure-related failures this weekend. Stay tuned!

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------TgT648rzmM6leWiofVovIR7G
Content-Type: application/gzip; name="pstore-202502131049.tar.gz"
Content-Disposition: attachment; filename="pstore-202502131049.tar.gz"
Content-Transfer-Encoding: base64

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
YKaJZgDwAAA=

--------------TgT648rzmM6leWiofVovIR7G--

