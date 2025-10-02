Return-Path: <linux-pci+bounces-37484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD4BB5A09
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D4519C72FA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 23:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BB8239E9A;
	Thu,  2 Oct 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="QLp+xCrd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A339186E2E
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448566; cv=none; b=oG/omU8RSL9zRMdFBezUHJnYoSN90mEgY6W7MYaYxQ/fyhjENJhCRIEu2JeYRi6VbflYom+qbRxJZa7qXpJTZVaNN9DpyOCeHS6hv3oRlhdskQB4uj56ZepT8VeDrP4KI5iXZ3F3iPOxUBfcU7T/A0hgocc1ut1TckUSHJZMz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448566; c=relaxed/simple;
	bh=7JKDuH0qaPP453FQ9YmrRHbPxULgSIHgpnYbFB5KzwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq2wT7OzoeQXY8DW720JGmqQUZeerCaDYl+3W5ukpUt07WQeKkYh0oF/t+2q3RpjjMZJHcwWHoUwK+cbmF9Q5ScVq53RWrbellOQ0+ywKSzZyGrtbabS3XCc4w2d/yaY9Gk2IqkqX2MWIYSYyMu67r6ExSX2Yr5VIk17lGsyonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=QLp+xCrd; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cd7dF0N0rz12hn;
	Thu,  2 Oct 2025 19:42:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759448562; bh=7JKDuH0qaPP453FQ9YmrRHbPxULgSIHgpnYbFB5KzwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QLp+xCrdScFRT49K2kD9IVE9uxHXuSfwOHK13y3iJrw+rydXwUfj0/YzNXSYkujYC
	 ch+HBNiZOQBqERvcRuL8J3yD4b/mWrxHV6PDxUQSLtkPbzzxDqxnbpaKY2rGKYw+rb
	 Qq7ckOOctjFkXRvJq/VxGzLPwahBbg32SB0WYhAA=
Message-ID: <5ccc1030-96e3-4a36-8900-91a057698472@panix.com>
Date: Thu, 2 Oct 2025 16:42:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>, Kenneth C <kenny@panix.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
 <c6yky4m3ziocmvgblepbdr33j4irwlzew7z4ch2hnhj44otpwf@n2yo5sselj73>
 <e5c6756b-898e-475a-a390-391edfdc0943@panix.com>
 <rmfs32rqwiwergekmikednlm2zikakhvdtjnx54b4q3neznghl@3pqvqralvofd>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <rmfs32rqwiwergekmikednlm2zikakhvdtjnx54b4q3neznghl@3pqvqralvofd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/2/25 16:37, Inochi Amaoto wrote:

> I think it is good to have some more information like call trace to know
> whether is caused by this change, or the side effect from other commit.

Yeah, let me make a branch with the commits back in place, then see if I 
can get the traces in pstore.

> I also suggest adding someone related to the xe driver ...
Nah, I honestly think it may be related to VMD or my NVMe; it's like it 
does everything it can except do disk I/O.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


