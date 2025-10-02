Return-Path: <linux-pci+bounces-37448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FDBB49D9
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A9C3B38B9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803D19992C;
	Thu,  2 Oct 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ekTjCOTF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4072F872
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424668; cv=none; b=ZQwdI10DwB+pGhCwbHCyoE9Iqfv9BVJDlYt6Oy4Wf5jndME8pizJ+ZquwL9XH56D/PSaPglPXCLekkwiNf6pvLYQTf9AQKUU1VWqiivc41WJhf39QMNZk1f0/zWkDFODH43hUZ1QNat2iHWil8202cx/If5aawtIhW6WGv0j4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424668; c=relaxed/simple;
	bh=9U3yKM+D3fmFazXwrZT5rqb/bJdhzG/21rrqO5A83hc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=R/bb7jJmKJbS1gwO2aq390yl4S+Q8m8fxoEijRaBPKLMYKAEnuRPn7T5FiZA3iB28Ogngq9sBcbcCVcijaCpTPYzfg8s95ELUiRIf9dZz41E2FaVMppKVWg8EzD78oU7ldhsW5xRetrFFls5e1L+e42N5hppffYaYQ9eqdSMK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ekTjCOTF; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4ccynZ1fX1z4WDD;
	Thu,  2 Oct 2025 13:04:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759424658; bh=9U3yKM+D3fmFazXwrZT5rqb/bJdhzG/21rrqO5A83hc=;
	h=Date:To:Cc:From:Subject;
	b=ekTjCOTFdH8oke6PmCVpcDf805kT1GDDIEzYYYr9LPr+cDVAdRLkVNuWx+9FMaqPq
	 2TwcJAgchN5KnQW8EMZ7k6RsHk95SFXUYN1Gtn3ytb5Dx6PPbUg12SYYmEBcNYnvpT
	 yBhPKLJuEukZtamRHfpKpP3TcqDeFOlByTH1tx2I=
Message-ID: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
Date: Thu, 2 Oct 2025 10:04:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: inochiama@gmail.com
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org, Me <kenny@panix.com>
From: Kenneth Crudup <kenny@panix.com>
Subject: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I'm running Linus' master (as of 7f7072574).

I bisected it to the above named commit (but had to back out ba9d484ed3 
(""PCI/MSI: Remove the conditional parent [un]mask logic") and then 
727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in 
cond_[startup|shutdown]_parent()") first for a clean revert.)

I have a Dell XPS-9320 laptop, and booting would hang before it switched 
to the xe video driver from the EFI FB driver (not sure if this is a 
symptom or partial cause) and I'd see a message akin to "not being able 
to set up DP tunnels, destroying" as the last thing printed before it 
hangs. (If it's important to see those messages I believe I can force a 
pstore crash to get them where they can be saved off, let me know).

LMK if you need further info,

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


