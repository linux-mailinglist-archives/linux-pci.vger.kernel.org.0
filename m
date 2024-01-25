Return-Path: <linux-pci+bounces-2541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450683C109
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 12:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126401F26194
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC32C699;
	Thu, 25 Jan 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gR2Fz18k"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EE2C68F
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182537; cv=none; b=aKy33a3dHEQ/PjBLjut9pQjtIqY3nmMbYzmlrFmcuNmbdiBBY8YHfHzv6cIhLOKGGjXli5AqpP0bxGcIsf9O85+OkfNqMaA8ql7wd8fabz6dQPx7gcQ6QPgJIZIi8Sp6BqTJgq/ilUHwQEV0gVCjJ57YgjXItxTMb8KDm87JpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182537; c=relaxed/simple;
	bh=QkSifBmhNnh9J/ox6L1kLoVfm7f2dkDpGrgfAkkmiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O7pdWQGVoLxR7sUumjqW2scIZq2qkcXIoiLtnqd+zMRz6kBZ/GYWRq45hnWRNfhSt/RT46hmngLo8NnJH6+mfcYeN3kV5eOWcT9NmCVkYmNJObMseC4ufUllPu+YSfIusxYZZQSxMg9HxaDnzh/KnGxkSjhXesSEHwmyTdD3p44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gR2Fz18k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706182534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ND0M38vqg/f3DX4i2e40ekWPh2ueLITyqRBQvx6nxv0=;
	b=gR2Fz18kJ4yINuNndOQcm7OvQ1KfOxzJpJ5f7EHdrwjdP4kVCaU1R02JjPpFCaL7Em9j7z
	HatCM0UHfc/QfB65F8PhJvw11cTxrHh2kD5rdwhTOWWzVN7LnLYe+xB8yfqGRwDIU36QLC
	WtBgu9CZVpRBLSdSjNykq5hKvU53D9k=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-K4fKE0D9NpKXifSw-sf4sg-1; Thu, 25 Jan 2024 06:35:32 -0500
X-MC-Unique: K4fKE0D9NpKXifSw-sf4sg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5fc6463b0edso108736437b3.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 03:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182531; x=1706787331;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND0M38vqg/f3DX4i2e40ekWPh2ueLITyqRBQvx6nxv0=;
        b=QyvuRhiSH2NXLc14flZmII0fyA5t64qaHNcGB0VskwILoiJ7la5IIM/YcUyGQlUGm0
         iGTC7UeX/KOgqCTgUcb2SWx1xdqC/xc/tS4JXSMo53BGiGKItHU/jx2PPe+zvcwqnlkX
         x9eQlJ29DBQda0k0h/8v6GSXpDbd3uNq+BUIl5HVCGNkOuZtKP8GMeoXEZKRuMWU9vvX
         psNCXKpZz0nfAVJRlTZYNYsQdLasnL3WauSuXA0vmx7uleCUieCaTOcnkFHCfdMpMWAe
         KzsGHcwC9Lf2QlhFVZiOBnInfS2VzFOX6r117dbdFg7cqjkVmK0Q35jj09UDhM/bfgKF
         veBQ==
X-Gm-Message-State: AOJu0YyPBW4smjSw1tvRYeyEdE5BvlmT4lAJHa3iLratv7zOGVF7J5jY
	K1bFd68lZxPSYXMliKTa7Il1Neqix1asrhcfCV5tbK+jQg5fHx6CUABgaKbavmR5Qe+dHBFVIGl
	tesibXY008hm2WHMJZJPQawvEPMbgiyw0vjn49kxxW7NanGr4LLODpKH5ow==
X-Received: by 2002:a81:5702:0:b0:5ff:97d0:6535 with SMTP id l2-20020a815702000000b005ff97d06535mr552292ywb.83.1706182531058;
        Thu, 25 Jan 2024 03:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlpvmBp8xlQD5XCxbHNI/yAx/NEl7+aASAlI1TcIgGwaDJTRqIImA/z84168W/ZHhbcdOW+g==
X-Received: by 2002:a81:5702:0:b0:5ff:97d0:6535 with SMTP id l2-20020a815702000000b005ff97d06535mr552276ywb.83.1706182530618;
        Thu, 25 Jan 2024 03:35:30 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a05:9f01:cede:7b45:1f9d:67f])
        by smtp.gmail.com with ESMTPSA id bp31-20020a05620a459f00b007833c4dddfdsm4924094qkb.53.2024.01.25.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:35:30 -0800 (PST)
Date: Thu, 25 Jan 2024 11:35:26 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Georges Da Costa <georges.da-costa@irit.fr>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 VI edition (OSPM-summit 2024)
Message-ID: <ZbJHfiWnujLz2Pfm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VI
edition

May 30-31, 2024
Institut de Recherche en Informatique de Toulouse
Toulouse, France

---

.:: FOCUS

OSPM is moving to France!

The VI edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. Summit will be held in Toulouse
(France) on May 30-31, 2024.

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

.:: FORMAT

The summit is organized to cover two days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Scheduling techniques (real-time and non real-time)
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on February 26th, 2024.
To register fill in the registration form available at
https://forms.gle/SooSmYMChBcn5rmM8

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation add its details to this list:
https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract

Deadline for submitting topics/presentations is 19th of February 2024.
Notifications for accepted topics/presentations will be sent out 26th of
February 2024.

.:: VENUE

The workshop will take place at IRIT [1], University of Toulouse [2],
France.

The workshop venue is accessible [3] from downtown, where you can find
most of the hotels/accommodations suggested below, by metro (line B) in
30 minutes [4]. You can reach IRIT by the metro B (approx one every 2
minutes in rush hours) or by bus (several lines, between 40 and 60
minutes depending on the line and the traffic). Several buses arrive at
the metro station of the university. A map of the city center with the
venue, transportation and food/drinks places is provided here [5].

It is recommended to pick a hotel close to a “Ligne B” subway station,
anywhere between “Jean-Jaures” and “Les Carmes”.

From the station, choose “Ramonville” direction and get off at the
station “Université Paul Sabatier” [6]. The station is right inside the
university. From there follow the map [7] to reach the IRIT building
entrance. 

Toulouse airport, “Aéroport Toulouse-Blagnac (TLS), Blagnac”, has a lot
of direct flights from European airports like Paris, Amsterdam, London,
Munich among others. There is a shuttle “La Navette” [8], every 20
minutes, bringing you to downtown in more or less 30 minutes depending
on the traffic. 

A list of hotels on the metro line B (direct to the workshop location):
http://www.hotel-oursblanc.com/
https://www.athome-ah.com/
https://www.discoverasr.com/fr/citadines/france/citadines-wilson-toulouse
https://www.pullman-toulouse-centre-ramblas.fr

[1] https://www.irit.fr/
[2] https://www.univ-tlse3.fr/
[3] https://maps.app.goo.gl/rdcrKx6x8ntm4uij6
[4] https://maps.app.goo.gl/Y8UPRvHmbrjCSnvu5
[5] https://www.toulouse-visit.com/interactive-map
[6] https://metro-toulouse.com/ligne-B-metro-toulouse.php
[7] https://goo.gl/maps/ojiAeQoL5Ewgb2gp7
[8] https://www.toulouse.aeroport.fr/en/transports/public-transport?tabs4633=tab_4631

.:: ORGANIZERS

Juri Lelli (Red Hat)
Daniel Bristot de Oliveira (Red Hat)
Daniel Lezcano(Linaro)
Georges Da Costa (IRIT)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)


