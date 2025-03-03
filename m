Return-Path: <linux-pci+bounces-22789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F1A4CD1B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2EB3AC6D5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA4823717E;
	Mon,  3 Mar 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ekIOcJeh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB16215041;
	Mon,  3 Mar 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035428; cv=none; b=Po1UvbL/IzzrM/qdhgQHAA3uUCSoKgtk7PNg6d6vBaDyBJnq89wvHLRATgMBUAJaSnNmxLdCCja5yMw3mxvp42F/zA4oqkaF8aVfuMFcTPgX8M+JponcNKVk7FxJUPwDnDApgEiJAPf57bnKxZEdiatv1ADsdJa8wsCo9SJaInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035428; c=relaxed/simple;
	bh=LkpixxwH6q6MHKb7xRRxpFfYub1ipaUt6GP6QhkgSrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0pKVQ5sVs/i2kJP+OnS9lCKgBA247BBGzKSYomDrQf2Qkb6KuwkPWYDYICkoKZnkfwCWlrsOwVRPLgfTrQM74DFZdZuy6gAOdMRCvt00lUrLLGsPXYwVDwV5QMhsd2Td3LgBFYruOvWsqx3KpaMlZhCAL72KUYCmx8+JY9YACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ekIOcJeh; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z6B2R25V4z4MR5;
	Mon,  3 Mar 2025 15:57:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1741035424; bh=LkpixxwH6q6MHKb7xRRxpFfYub1ipaUt6GP6QhkgSrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ekIOcJeh9Ssoc58bfP6BAuJI++uyeUDXpV4vuBSDEoCk2flD2+mfNgFrNFOWVQbf/
	 +R4upKBgfknLtEOmDcdt2dTHAh8ZfYdD/bYRgToNuHIFvJqXQO7p+tQlkh0jLSn+fT
	 xo8uS+sRefvvy/FB8GSMtH1DO3pGNfG4/GsF2wac=
Message-ID: <244806e5-f8f9-4fad-a4aa-bf031c84748e@panix.com>
Date: Mon, 3 Mar 2025 12:57:01 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
To: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com> <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com> <Z8YKXC1IXYXctQrZ@wunner.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <Z8YKXC1IXYXctQrZ@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/25 12:00, Lukas Wunner wrote:

> Does the below fix the issue?

So far, so good! But, part of why it was so hard for me to bisect to the 
Subject: commit was 'cause it didn't always OOPS; but I'll continue to 
test on the most-likely failure mode (CalDigit TS4 to TB NVMe adaptor 
connected at suspend, then nothing (or USB-C dock) on resume).

But if this does indeed fix it, this will make TWO crash bugs on resume 
squashed in less than 12 hours- gotta love Open Source Software!

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


