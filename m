Return-Path: <linux-pci+bounces-37487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 187B0BB5AFF
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 02:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1737F4E241C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097F1A38F9;
	Fri,  3 Oct 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFoPod4b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA899DF72
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452826; cv=none; b=rupv7RiFfYHlSICgO380FRbE3Uxpi9QZ7V7L6SvcxVZq2A17zVinw6VBcOxGy7UWygXj532xLb7SiDl8p34aoP1YvZ8uCK2og8kwAaTWZEwSkoifG2LoxGc1T+U9JQfwSQZQcKDpU9Vs6B5U4p4U2aGzrS7r5M+JqeXdk18hMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452826; c=relaxed/simple;
	bh=B220hJ25PUFK7FBdbYTH0TjO4X/r2HPn7ZpHiAioGf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvPV+eXxsK4OfexgYcWge7U9gb8CKM3U4bmbNhnT+ZR2uV2aw2+VdcRHAbnisnTcpa1rQb1XJpUoDmcOnD11PeENBMGTn14E5rfIZ9ML1HdCC5FnW+pHNafmFE98rLsf64AtO4LLjd0iqcesPlb98STAvM44xabs38TOIeqscAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFoPod4b; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b553412a19bso1197609a12.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 17:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759452824; x=1760057624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5uyOHpI2Au3C0gDg4sk6CizGa6egbK3UkaPqAi7z9Q=;
        b=bFoPod4be0kjyUNF5AiyF+uZ9hs2eZBiKcxiLbmVIT2zyazhzm39220bFTRAGDgBWU
         eofcWmQj9k6bEZtFb6nvpYZzIv4FP81GcsRdVbcjFyIQ6Tki1thE3+ikPIx/xOkKofe6
         1BkpZ/8RFEK8GxHzSOU/ImQMrL4hasUGayXVVup9KSUXQb648eKaA5hNptdVVSjh0o+T
         aa45iCVuBvpJwez0f8sr2UTFPe0vrgnh5Bi8iEedV0fxO86gH4VF6jojiyjTjc7rjU+o
         4Fnq/l4EXyR1nwpzuUkPDHU1wA7M9zKRfD3r3XRzpKGAJb3s241dfisew6SdIGHdMage
         7itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452824; x=1760057624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5uyOHpI2Au3C0gDg4sk6CizGa6egbK3UkaPqAi7z9Q=;
        b=WqeH3Z6cJkAjqqmFW/2d1sa3MO1FhDWyqEadggfrFisIaHYMTVy1akW1P3P05NLGnw
         m45XmTLcHrtr8FvnCk3jb5E4X055b03T+oxBq68+6G8uBSP1r7bklfJPmBM2ul0JJoR3
         jammzg/lIZSSXVWo6CdMV9LFoUiIZsZa5Pz6xOo7DhEP9S0l3UxpjGpduXSKSGPjgh/H
         OMeDPbTkqdh+YyuFuuIWkXs7bQCew5RpvfmI1sNrv2szGrPCZVt5EzrATPBwKfG2oj72
         8If3rqmydoHmAH+4ml2TIi2T7OG7ErDdkIweWMwxOX6H96dRmrFyVd9Eo/in7ICU0dct
         QaIg==
X-Forwarded-Encrypted: i=1; AJvYcCUvqhMtrzm5BhuO+ttgJcZ/aJulwsaISWZhD1AYttNWH7BQBKfjA1GbetCqvPk0FsxwvednJawKTqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyfV8Onu98sMlxzWa6bdZpQnUziRhOOLdaI2pNjoxIzcG2KOiK
	6KQf6MnIFDHPrvGYoppksKemTTDJvWDhkuVNSN3qeL7Z2PKEye6DwycX
X-Gm-Gg: ASbGncvoyfL5LEB9RK7r9vk1z+WEa3V7elUA3wimF1iRSlQig12m98w1TG+k0bCTy9w
	bc3N57kjNfYDSUpI5i6L1JAz30EqWXHNIQ/IDLs6gKeXe29n/73FWjK4crH1PT3bPmLTxEpJQ4S
	QWmmuKX76t9RwcQh83PYWNHl0NG3zelC64CzJuDDrzSksYv574MRiDJ1rqQB6G7SSOHDAPzdanp
	sVJbXFxaGSQTt1W9Z2EiwqvOLOoaLOS1ND94sbgGkGR5So/EMofkYBKoROxG0B56NvyhR+L+Umy
	SNfiF08whciSr9q0PDyZ1daTOdOwD6z305iTUv1C4mruTm+cRvWadB72+2g8VsYXT/maRDwhFj/
	pocKcCEf6+KgVuN+66P0q+zTVulhc4jPT+r5Y6b+y2SPQm2/XswAFQ6nd
X-Google-Smtp-Source: AGHT+IGdxtFt+56PiTL282mlbn7E9q06odMFjzXKAWEcpqB67cy6Wg2N2QZUSTfY1sLAvl2nVxaWKA==
X-Received: by 2002:a17:903:2f4c:b0:270:4964:ad82 with SMTP id d9443c01a7336-28e9a6292bfmr12750695ad.38.1759452823807;
        Thu, 02 Oct 2025 17:53:43 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d12b4d8sm33058045ad.54.2025.10.02.17.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 17:53:43 -0700 (PDT)
Date: Fri, 3 Oct 2025 08:53:10 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Kenneth R. Crudup" <kenny@panix.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per
 device?  domains") causing boot hangs on my laptop
Message-ID: <b2yvi26tcyctaqjk55iym3wt2gmp7sdr6h5ptay6w7dzgk5zy6@vwn2uiqcgyjb>
References: <lhrbiugb4o0da3rtcvl0aduk.1759451570558@email.android.com>
 <68df1c05.050a0220.31415.096bSMTPIN_ADDED_MISSING@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68df1c05.050a0220.31415.096bSMTPIN_ADDED_MISSING@mx.google.com>

On Thu, Oct 02, 2025 at 05:42:44PM -0700, Kenneth R. Crudup wrote:
> Yeah, it's definitely IRQ/NVMe related (this is a Google Lens transcription of a camera picture, but it's close enough):----1206] thunderbolt 0000:00:00.3: 0:5 <-> 1:13 (DP): not active, tearing down T167] thunderbolt 0000:00:00.3: 0:6 <-> 1:13 (DP): not active, tearing down199] nume nume0: 1/0 tag 20 (1014) QID O timeout, completion polled11511 nume nume0: 20/0/0 default/read/poll queues-----... and it does limp forward and continues a bit, then oops in an IRQ routine somewhere (getting that next).So, anything I can try to solve this? (I've since updated to Linus' master as of a few mins ago, FWIW).Thanks, Kenny--Sent from my Tab S9+
> -------- Original message --------From: Inochi Amaoto <inochiama@gmail.com> Date: 10/2/25  16:46  (GMT-08:00) To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com> Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, linux-pci@vger.kernel.org Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
>   domains") causing boot hangs on my laptop On Thu, Oct 02, 2025 at 04:42:40PM -0700, Kenneth Crudup wrote:> > On 10/2/25 16:37, Inochi Amaoto wrote:> > > I think it is good to have some more information like call trace to know> > whether is caused by this change, or the side effect from other commit.> > Yeah, let me make a branch with the commits back in place, then see if I can> get the traces in pstore.> > > I also suggest adding someone related to the xe driver ...> Nah, I honestly think it may be related to VMD or my NVMe; it's like it does> everything it can except do disk I/O.> If this is related to the NVMe, I think you can check dmesg to see if there issome log like "nvme nvme0: I/O tag XXX (XXX) QID XX timeout, completion polled",which indicate the NVMe is broken.Regards,Inochi

I think the first thing is to figure out the whole trigger
path for this interrupt. So we can check whether there is
something missed.

I suggest rebuilding a workable kernel with config
"CONFIG_GENERIC_IRQ_DEBUGFS" set, then check the related
debugfs entry of the NVMe irqs. I am happy if you can post
it as I can know which driver is used by checking it.

Regards,
Inochi

