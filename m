Return-Path: <linux-pci+bounces-43173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B5CC84F9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250F9309CBB5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121BB37A3F5;
	Wed, 17 Dec 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4dNZ21m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5Nzx1ma"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30A33A6FC
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983178; cv=none; b=KrKAqQCco/itKNsP0yR5qwqTZoMlNyL5y8T/d6YO1Obh4pOREvrpdQjR2lkWamYFlD/uwh9Usa4E9lo4ujvw2rG/TdGGPW83LtxDEXChfQ1lq8LyJPWrT+nxPx5c2u73WIqvkxXnQ0mjscnCSJ+13fmnsoGyv2ayCCtEfsEZu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983178; c=relaxed/simple;
	bh=bpn6PnaPqjW9QoU4/thXPDyr0QvWsFZ2GeYnd3BcwnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tMrdU0gcG/d21h4clrc7cHV9LyJ1Om5X5VbJsjtg7yDLALQhdW/e8gH2J5eMd///4+KVXo0mVeEWCS3yBQPj6U2fnm+qAnhC0YgsPMg4KZgUHXmvjnXP35qUguEe0941Z9jPe23L4B94HDKiZpOnqUTbOuoZC/NWc4f3ZAoXv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4dNZ21m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5Nzx1ma; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765983175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qwTEyD7EyX3W8awcOGf5hUhLWAjEt5Iu/15FJwOP12c=;
	b=A4dNZ21m+5gLrX2dPYzrFJNQcquQGTLnYRCGjIm6qOKFKDL+KFRlPsWKQ2lz4qVOomFwG8
	lBSf3ZldlCoKvLbHEw/Xo15EBfBmBenUOBQwgDk1/U5f6dcC9MLwCDee+u6dlknANfkqdr
	Xw06xhcyN53m7UwNpcG0RKZGtb18+x0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-GkknLfdtPACm4ot9TScOtg-1; Wed, 17 Dec 2025 09:52:54 -0500
X-MC-Unique: GkknLfdtPACm4ot9TScOtg-1
X-Mimecast-MFC-AGG-ID: GkknLfdtPACm4ot9TScOtg_1765983173
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcf10280so2404520f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765983172; x=1766587972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwTEyD7EyX3W8awcOGf5hUhLWAjEt5Iu/15FJwOP12c=;
        b=C5Nzx1maGLs5yDsk7rp14VAr2xazEckdDnMCe3/WhVl5h0TffB+3OvRcX33QsZXfAe
         UrmYkp6BTztJ1b4F7C9pgNPK9gyQkrxYF1WWPxFIrgXVIRzz/LqftSpU6dhlQ9p0M/Wt
         97WkWZDiv6A10ECD7OscrtwREwiiLAg7cgyVJfuSCMQIXHOP2G6dtK3GAzQXZ4QKl3J0
         4VKQcAf/ulVSoYF4P8bMMDUIhhasg+A1hqulCZbMrBZ32bESm7JW/q+XcBJs/sCBo67p
         FTwezMZM8nIKOf8xmFgN3sJmChd6iQTLXN1Jg87MoMX76FZrryKWgG1Gbd0GmMrP9Fs0
         bjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765983172; x=1766587972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwTEyD7EyX3W8awcOGf5hUhLWAjEt5Iu/15FJwOP12c=;
        b=wPDGhSFkTae6hC0DISedyoRROtEUcpLQLPYhtERTY7oolpdd7RFmJ+670qxMtiuXWU
         TR+sgpYe6iZfD6AArqZlQi8y78vBWOrGMV4c66UbXQIh11sLhkFXaQKDvHROwPlsf2Qd
         4SM83JZQK7g/p43PXZHNMPyk/4DRZNYTd0mZM35tMQ+/F0YZcEdAvjJsbSRaTs9Sk3Eq
         kEBRCJweMu341kIFB719D/LkgJg2U6u+JfkgX72/+29xgsQjULIRPYA6wuCnmjfAdWPj
         pWhVk14qONzSuAMS2Rl+eXeM+z7pjLgtYp/R04BHfdQ1ZQUlPzoIXOb8eIgxXWBUoL3T
         96OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL0wmCFwXpDJ5fQbcMAXC0dAFSscaO0tO+K/XyKmKxKnfsxsF93al4kaaeU7GuVeNTKEazNvXfoss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncAsGdR4SIrf5qnt8Om0XfcLeAsj+hOxY4u0xl0jY6EZlEDnz
	MM3JZePE4wdyM92lN6A3UglupbcGoEMnJ7TK5/giGYq9ilSrLzxaj87x8X8gkLCtkgV/sjVuCGT
	l+8/mgQOZwuR/+oOyDP5aZ57fqx1akXW6EqrAvXDRgH9Jq4TlxiJ5+xrStrq8YXpTUv3BaA==
X-Gm-Gg: AY/fxX5xcvPwk1p2Ti1CsENAKUtDh3L6uhkAj127COj4I3XaLD/U5ODc8SmjFdbDZez
	/P4tdYBb00LmwmDDO5RjBooJXkOQ9j0wHNYF0u/RFbSMC0asZu18OeJCCBfD0wiihnSv/gkIcvI
	8gr/cZhHLMu6pxX/wLywowEgQE95dMCWxjr9wLVM8U61lmP+9eV1hFJhxnIbiI+UirMOWZa+H55
	6JinZzVTjtg54Obd85SMjwKpCsD6U3ku2PVwLmTgKNazcLI70Jo5i4HWEV6ODXTqTQQynaPWcBW
	XnogupdoJk/m3WVoxl65LXlL+aaMPJHNrsScnyNc+sudRvDn01/jB441hFmls/gwmT9jwieHTsD
	3GbIMyKi2H9tEzn0XBoQe1KjG2KAgCOJNLZr37SCr
X-Received: by 2002:a5d:5d0e:0:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-430f3ab5950mr16820299f8f.48.1765983172375;
        Wed, 17 Dec 2025 06:52:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLP/5gl/yOSrne+8o7qzbeeGelDz1lhEWbsMui55R/X+/B6Wtdik9SdMqV5CH1CuwyFBA5SQ==
X-Received: by 2002:a5d:5d0e:0:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-430f3ab5950mr16820278f8f.48.1765983171865;
        Wed, 17 Dec 2025 06:52:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ada846bsm5103573f8f.9.2025.12.17.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:52:51 -0800 (PST)
Date: Wed, 17 Dec 2025 15:52:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 VIII edition (OSPM-summit 2026)
Message-ID: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII
edition

April 14-16, 2026 - Arm, Cambridge (UK)

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

To submit a topic/presentation use the form available at
https://forms.gle/dR5FuzQRFNXZEQBb8.

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract

The deadline for submitting topics/presentations is January 30, 2026.
Notifications for accepted topics/presentations will be sent out
February 6, 2026.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on February 6, 2025.

To register, fill in the registration form available at
https://forms.gle/TZwvdg7196G5CWyH6.

While it is not strictly required to submit a topic/presentation,
registrations with a topic/presentation proposal will take precedence.

.:: VENUE

OSPM26 is hosted at the Arm Cambridge campus (in Cambridge, UK), in the
lecture theater and breakout area. We appreciate Arm's generous support
in providing the venue.

Although the event takes place on Arm's premises, it is fully
independent of Arm's business operations. The summit is organized by and
for the open-source community, and everyone is welcome to take part in
an open, collaborative environment.

.:: ORGANIZERS

Juri Lelli (Red Hat)
Dietmar Eggemann (Arm)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)

http://retis.sssup.it/ospm-summit/


