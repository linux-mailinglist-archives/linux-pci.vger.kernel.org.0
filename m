Return-Path: <linux-pci+bounces-37489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40041BB5B23
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC16A18850EA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF5DF72;
	Fri,  3 Oct 2025 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="PSlD7V6T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C834BA3C
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453258; cv=none; b=E1gTtoUlfLZPl4Sn/t94isTQcz60D56Wgc/pDCVLUoyKiTb2iD33FYFBJDlNSXJ845I0K6417v/TmDqv3l6b+2bUecAMiMkPDfUtvUnMMGS+ojt/HTeBS5vHQ9p1VDtqqi8MjxOngNrxplvbEr1UJ9Vh8tP0GYOiywGaNmVnkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453258; c=relaxed/simple;
	bh=sjI1TDWD1uwa3yKjHJsvdwd6W1jAKRQBmEkOhif43O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnF4mmdzWW0+J9wPY86TSGHcdhCxoLrVxWrxXd2ohwHalpboqOu5+CN56J7WbOjw5E7Vhbd8jbDVDPLVWJS33HB3SnEkjbjCjV8js/LeM/I9HFWeWrd7djO1ieySNfnmaKtjWKGqEsbpQxNvPzFm7cwcKyw8mVARuMPP0+POw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=PSlD7V6T; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cd9MM6slYz15h9;
	Thu,  2 Oct 2025 21:00:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759453248; bh=sjI1TDWD1uwa3yKjHJsvdwd6W1jAKRQBmEkOhif43O0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PSlD7V6TCvBdJDbECI3TBaRugVqs0msTGQjdPGZdvx76RwFn9hhyCFUja3u3shDzB
	 /E0O3QPXmsfzwen6m6iZ7a0K3KMtxtAsqp8UwQs1UMbBPVQytazXJjR21zFOHbAFoy
	 83p4oDX491SxJz3U5GQraZ/Pq2SrkvmHbCMXUc1U=
Message-ID: <cfb62bb2-dc0c-496c-973d-34271f697d63@panix.com>
Date: Thu, 2 Oct 2025 18:00:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device?
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org
References: <lhrbiugb4o0da3rtcvl0aduk.1759451570558@email.android.com>
 <68df1c05.050a0220.31415.096bSMTPIN_ADDED_MISSING@mx.google.com>
 <b2yvi26tcyctaqjk55iym3wt2gmp7sdr6h5ptay6w7dzgk5zy6@vwn2uiqcgyjb>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <b2yvi26tcyctaqjk55iym3wt2gmp7sdr6h5ptay6w7dzgk5zy6@vwn2uiqcgyjb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/25 17:53, Inochi Amaoto wrote:

> I suggest rebuilding a workable kernel with config
> "CONFIG_GENERIC_IRQ_DEBUGFS" set, then check the related
> debugfs entry of the NVMe irqs.

I can never get far enough (even in single-user) to get a shell.

I'm gonna line-by-line it and see if I can figure out where the culprit is.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


