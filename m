Return-Path: <linux-pci+bounces-27373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC464AAE26D
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC451527D2E
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFF28C01A;
	Wed,  7 May 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5n4/A/d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkUW54WS"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB72289807;
	Wed,  7 May 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626409; cv=none; b=lzfo6LyX9UdLrjgCSLSe2L+effZ+7tVxLAKRe0/UKDShbmUHnw/WEHhjZpces0R5jUj7MOw8OF01+tBeCtxGn20zn7LyybsaVqepGQ+YeiLsgf9Qql9CxlqC4PYfptQpShvxm+EIaRQGUSJHsSl4PWkmj0hjbBT/btwHQqSjBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626409; c=relaxed/simple;
	bh=LAHAYJ3ixLhijJlARnRfaoChG9KkxwNfeGvOAjZD1TE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cQXLJV5kgHFlRxgGjsr0TLH86wNFjAKacOKAQD3dnDc9FD1B0/Pm9B9JX8DZjkG5tIfcfzUTNULiIRS7BrQ46lJk9y9EKCbHt6oEisrHchm0fgWpAcuDJBfg2PNNH9UbgvqPB4bSehoJ2TwlSPHehq/Cp6kTtjug9Z/pKbI4yxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5n4/A/d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KkUW54WS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746626406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FzPFAIcop0UTJe1qVc592uXA0Wh/CJSHyqSxwp8faKo=;
	b=d5n4/A/d/4ebDft+yBBM2Ynm80MabiaVnjjt/r00WxXyF78/0tHOBOeSo/lfAweDeS5UJS
	fwOQKilJIrUpijGxSN8v/8RCbzsndPQIYtoRWX1sP4t6/3WiEhz+VCIBXbrFomYyu55JCZ
	TNi9Hb91+qw6K2vjrsY3GREYMe7cFk0cg4cY7ORSHeBzDP9+epArbOl/F3IMVcTfomL7H5
	BY2ERvUxmlnJxBuHRpNuVvUqZq0JfTFmzAZqhTQApBBB2p0f3SMovsfZlhyEs4uD7R2BSW
	9/Nhi36MIhO/lvPLr/1WtyEKbd1hbB4cYLHodEq7jTJtlO+juk+YGxBUVYBV7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746626406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FzPFAIcop0UTJe1qVc592uXA0Wh/CJSHyqSxwp8faKo=;
	b=KkUW54WSLCGDnC+r+/t8wQhOCxwLUf0G4wSB1JHIe9a3UBvug1YPAGbUEdqZ42vpmBEVps
	/c9N270asqIvY8Aw==
To: Zijiang Huang <huangzjsmile@gmail.com>, lukas@wunner.de
Cc: bhelgaas@google.com, flyingpeng@tencent.com, huangzjsmile@gmail.com,
 kerayhuang@tencent.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Using lockless config space accessors based on
In-Reply-To: <20250507090407.2146324-1-kerayhuang@tencent.com>
References: <aBsRXO6Us_wsdhji@wunner.de>
 <20250507090407.2146324-1-kerayhuang@tencent.com>
Date: Wed, 07 May 2025 16:00:06 +0200
Message-ID: <877c2smsgp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 07 2025 at 17:04, Zijiang Huang wrote:
> I think it's safe to make this change for user-space accessors as well,
> since user-space only reads from proc files.

Again. See pci_cfg_access_lock()

>> Why is performance of the user space accessors important?
>> Perhaps because of vfio?
>
> During stability testing on large-scale machines (384+ CPUs), we always                                             > observed that heavy concurrent user-space access to PCI config space triggers 
> kernel softlockups.
>  
> Reproduction method: stress-ng --pci 384 

This is not really interesting as stress-ng is not a real world work
load.

What's the actual real world use case which uses those interfaces so
that the lock becomes an issue?

Thanks,

        tglx

