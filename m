Return-Path: <linux-pci+bounces-42068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB1C86138
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 18:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C35E3B2A77
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF432D0EA;
	Tue, 25 Nov 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaPtcXQR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNS8YvUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737232BF26
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089954; cv=none; b=OU+T/w9j0izizdGgiFC0V3gUIExWsOug/3+9TO1S24RPAXO3Pt/9QhxMwBv/vNFsOVaNtAIFZvrM4dcT5bqGwfdbhgsE3jiftXCJLIXVT8sN2Hic1VE638Z2nHDnKvbQvB95NHhAw4H16EnFEQ7yjS0kAmexAfIO2R5Q22chLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089954; c=relaxed/simple;
	bh=QrCXwTVbTY2L/QXOdA+AJKifzsbPegD16vH5IBkdGJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NhODZRyvgBcWmd6ep3mPETCH4UF1br75ghMJho6XW0vmpktnbRiaZ69qrC3Hj+LQXA/yLQJSAHs5mbddRIqsV+a0nQgquELTKMzSyj0t7O3WK7ydEKGsCee+aC4FqQPb+vMs4q2EJ1+bbH/0Hn8e3glm1GCEBSG85gh/gcSawBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaPtcXQR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNS8YvUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
	b=SaPtcXQR0VaKNNBRINXwu65wu1vltsX1K9n9mGace1eixwA6EhqSBB6J5IqYYn0riuZIJN
	mIr6XYY9+n9WQDncSLwsBSDDNDV/HEsFANEJqtARi+rvu0vpsfKpugyrsTaAax1P/f9hip
	MVNXxwuqcJjYm7Ro+SMzLH8B+ytaVtQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-A_CEPeL9OvmwdCHrXzaMfA-1; Tue, 25 Nov 2025 11:59:08 -0500
X-MC-Unique: A_CEPeL9OvmwdCHrXzaMfA-1
X-Mimecast-MFC-AGG-ID: A_CEPeL9OvmwdCHrXzaMfA_1764089947
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso5163533f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764089947; x=1764694747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
        b=UNS8YvUHTYtcrPkW7zJRWp51Oirzp785bbqqoJdf66vfc7LAIXwMDDERXK43YgaZ+q
         Q6UbfgLcebAsxTTQ6KjtzqZ2EP5UlcBvyuRhze9rp2S5X2yVYseYtgvzeObkrVDogsPN
         m7OEZF1AS3Kuqk35U0YXLfnXfG+OnH6YnIXsuVxRPuQT26C/TwE5zG/NGt0pq7oynTEy
         Q7RiW3L/bM48PrGDUW7GutP39roAW+BvizuyVL6jIx9KnU1sDGu0VwGed6o0kveWEPHg
         ZRjsPjd9OmpsHZ+5kZUogt6iu6xt1mDrliNCRrZNI3ZBs6tO/RHR6B5xYHahVEzVMKv4
         QZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089947; x=1764694747;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
        b=jWBirlsCUCzH27aUufU/jPvY1zWHi600BuFyP36+RN+W6sBvY0nwmAdkRH2D8lweOu
         sp63wmZC3ix/C3UqIMWoB8EaFriuENFoOncwO5ACNKAJ+c5mWCDWGiDxrGTs28dTrxwN
         L4R7QcFL01d0mtbZBJaFtRCpHJcQ0hMyrCvPy7Y63g6gW4ppFjiBMQxAv1IfJElruSp/
         NmZZF5Wv7NlZL7WXnc5McbE32apNMZmTOKiZgJTQ26n8RUPId5PryUhGE+T5BCGe+9js
         A5P6MDdkGJY4e970Y/mxwuNArkomJDkc8Hd4aqx0FO4SxiiYcXpRI2KIdw6nhAkpvUzr
         vKXw==
X-Forwarded-Encrypted: i=1; AJvYcCUB76++B2DSeRgv/IBeE8RFb2bcA6Ktx+TLSkQKOAqvrYFG0zr2BfMSCtTYVmMR0zODr5IK/AkAUn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBc/wQr3SViZEsvjyNJKPWuDmt2UlUA4Iwq+2soYn2YRamrClG
	dUnzS6jraWDZjuXbISL6ugNnxru4IGDAtmbTPiO29mQ6cqW5dgZL73XSyN1miHWr4QiYDIN7wY7
	9aZiPBiBV8cAmmYvlWNkt3ahSWkDm3YvQhtrliN5tCAmQfpk+z6tAaxiTElXi3g==
X-Gm-Gg: ASbGncvjotnZL/ydfemxYJfgl7ZKBEyPcUfUrdCBIBwzJeBSaMXJOAANOgB1KexgpXE
	s8p0N68wPzdceJcrVOsd8aj4iXaULb6VaJ1+zazoNsqGFgI82I3jwppEe80D8Vgv/k4cU4shSSs
	sG8iCqFiYdfYrH1VF+k/mdLXS2mawGM6yzP/B13fKRn9eaxMdodJ5/zTUzWSyt7v2oNOJft7zTD
	63hIJczbwOqyUuMKNLZIO0h7gsPwUBBOF0w9A+s1/ojtGvzl3NYzG6ulPN0ntCAUbC8i+CoayLo
	j3Kn1GZ2gjQXlnxAA4KQc2DICSZCqj0M+fUvB2X3daDhFlqW3G3HIS63RRmzJ5pt94W0GmBq5T0
	T+7iLWB09KPfNoudnijsDNFjCjjqtHnbhSBm91BQcY30Y2yWsKjgzpKM=
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr33441225e9.28.1764089946764;
        Tue, 25 Nov 2025 08:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfZ6NgVrVjPGwjj83mk0cuZy70V+eAj/GkF9EsNDbbjKbkEF6o0Lstb1Ac7PYBzJ0qoAHtSg==
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr33441015e9.28.1764089946293;
        Tue, 25 Nov 2025 08:59:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-99-207-158.as13285.net. [2.99.207.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790552c3c9sm21068055e9.0.2025.11.25.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:05 -0800 (PST)
Date: Tue, 25 Nov 2025 16:59:04 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE] Power Management and Scheduling in the Linux Kernel VIII
 edition (OSPM-summit 2026) - save the date
Message-ID: <aSXgWOmJZnvEFYaH@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII edition

April 14-16, 2026 - Arm, Cambridge (UK)

.:: SAVE THE DATE

OSPM is moving to the UK!

Please note that this is a “save the date” announcement only.

Given that the Linux Plumbers Conference 2025 (LPC25) is scheduled for
December 2025, the call for topics and registrations will open in early
2026, after LPC25 has concluded.

More communication and further details will follow. Stay tuned!

.:: FOCUS

The VIII edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. The summit will be held at Arm in
Cambridge (UK) on April 14-16, 2026.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

I   edition - https://lwn.net/Articles/721573/
II  edition - https://lwn.net/Articles/754923/
III edition - https://lwn.net/Articles/793281/
IV  edition - https://lwn.net/Articles/820337/ (online)
V   edition - https://lwn.net/Articles/934142/
              https://lwn.net/Articles/934459/
              https://lwn.net/Articles/935180/
VI  edition - https://lwn.net/Articles/981371/
VII edition - https://lwn.net/Articles/1020596/
              https://lwn.net/Articles/1021332/
              https://lwn.net/Articles/1022054/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 - Power management techniques
 - Scheduling techniques (real-time and non real-time)
 - Energy consumption and CPU capacity aware scheduling
 - Real-time virtualization
 - Mobile/Server power management real-world use cases (successes and
   failures)
 - Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 - Tracing
 - Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: SUBMIT A TOPIC/PRESENTATION

Please consider this a "save the date" notification only. Information
regarding important dates and how to submit topics will be announced in
early 2026.

.:: ATTENDING

Attending OSPM-summit is free of charge, but registration to the event
is mandatory. The event can allow a maximum of 50 people (so, be sure to
register early!).

Registration is scheduled to open in early 2026.

While it is not strictly required to submit a topic/presentation,
registrations with a topic/presentation proposal will take precedence.

.:: VENUE

OSPM26 is hosted at the Arm Cambridge campus (in Cambridge, UK), in the
lecture theatre and breakout area. We appreciate Arm's generous support
in providing the venue.

Although the event takes place on Arm's premises, it is fully
independent of Arm's business operations. The summit is organised by and
for the open-source community, and everyone is welcome to take part in
an open, collaborative environment.

.:: ORGANIZERS

Juri Lelli (Red Hat)
Dietmar Eggemann (Arm)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)

http://retis.sssup.it/ospm-summit/


