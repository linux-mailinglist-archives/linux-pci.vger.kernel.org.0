Return-Path: <linux-pci+bounces-21033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4307A2D8CD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58491887D3A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 21:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10281487D5;
	Sat,  8 Feb 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="tjzm2BHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51244243958;
	Sat,  8 Feb 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049372; cv=none; b=k6IWpwHDNv5qtld/WgP9OPMlj4A5+Erv6b1QJmlvHX4tR+tEiquC6CoIHYu4cevTQGFipbgHdLrn+PdrGBydqKpu0ciNRzJLNK/7n7UkgqT2AjS9QgBS+SrqaP5fFTF7QH/r7PJzTwxnUnqtPNQ9pDz+tDg6G3DrViac/b27Avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049372; c=relaxed/simple;
	bh=QAx3DJbttXJF1ohIkOtfT+IS1wikum4VIrxMVrd/MsE=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=KZo3U0inQ4MUAF0aOqmBFroAAl3Hk6MVd3FGTVpxGLZNq4INCsvwGObuuGwMdsrRwmcsFcO7hrBFkqH2GmxRGi0OqMbg0j/ag4wr7iW2yMUTtjxRWn5ycuj6W8UyR9D35fI6BDRFvuos0dGJ2mI+uBWNTyAxFth87VpoLWBHl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=tjzm2BHw; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4Yr36k1tX0zDQy;
	Sat,  8 Feb 2025 15:56:46 -0500 (EST)
Received: from [192.168.55.17] (ip174-65-98-148.sd.sd.cox.net [174.65.98.148])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Yr36Z1xYJz4NKn;
	Sat,  8 Feb 2025 15:56:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1739048199; bh=QAx3DJbttXJF1ohIkOtfT+IS1wikum4VIrxMVrd/MsE=;
	h=Date:To:Cc:From:Subject;
	b=tjzm2BHw+yMEegrYmyX73EjCymG+VozUWWskxIxbBVhje5moUJ4qQzVa2FuhgAqXW
	 bsaUjezYv3+nkeVZ54A8Gu7SOI3KeEx/0AW+nOiS4PUk8FYyKZ61sBMGm/ONLMCr20
	 NORZbEXAPkAqihpwXqmD3fSMCjV90GYPKTX7/vsM=
Content-Type: multipart/mixed; boundary="------------YIMbz0pMXiTCBiRenPfhHlS2"
Message-ID: <04091f53-3c94-4533-ab48-e9296e6e2841@panix.com>
Date: Sat, 8 Feb 2025 12:56:35 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ilpo.jarvinen@linux.intel.com
Cc: Me <kenny@panix.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?B?Q2M6ICJJbHBvIErDpHJ2aW5lbiI=?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>
From: Kenneth Crudup <kenny@panix.com>
Subject: Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac)

This is a multi-part message in MIME format.
--------------YIMbz0pMXiTCBiRenPfhHlS2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Guys, I don't think this commit is right; I've had 2 out of three resume 
failures since this change went into Linus' master. I've attached a 
pstore dump of the latest crash, and while it appears to be coming from 
the Intel XE driver, 95% of my (s0ix) resumes worked previously[1] 
before this change.

LMK if you need more information.

-Kenny

[1] - unless I forget to detach my NVMe USB4 external drive before 
suspending, which is a breakage that appears to have gone in sometime 
around the 6.10 series, but I haven't been able to bisect it
-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------YIMbz0pMXiTCBiRenPfhHlS2
Content-Type: application/gzip; name="kernel-crash.tar.gz"
Content-Disposition: attachment; filename="kernel-crash.tar.gz"
Content-Transfer-Encoding: base64

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

--------------YIMbz0pMXiTCBiRenPfhHlS2--

