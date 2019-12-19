Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D070125F1F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSKfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 05:35:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37754 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfLSKfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 05:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576751708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=grytLlF1DJ8ixVXUMMRXrV+hvL2jNyAGRxO10pwO3Kk=;
        b=hmzieCX3AmU79KHeblEB7o0cNfKizFm8NtBMXNuENjKts2biAm6oSASpRyUsX/HpaMcgFI
        70iSvc3ujHihXW8/GNUdCHv0U1Fidr1Q5rFwZYx5EpxDQBFpK/ww8gpvT0dJQsi08p3s5U
        +Hfb4JXOWU1or41QzaYNZksunEYSDlc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-V1NvEs7VN4iHHI7EToTMPA-1; Thu, 19 Dec 2019 05:35:06 -0500
X-MC-Unique: V1NvEs7VN4iHHI7EToTMPA-1
Received: by mail-wr1-f72.google.com with SMTP id o6so2182125wrp.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 02:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=grytLlF1DJ8ixVXUMMRXrV+hvL2jNyAGRxO10pwO3Kk=;
        b=R0vC+Ze8+MA2oClIOcD0TM/LZYq/gWyMUJA9RZ9mRxWu5F2oYpbOJrEoTmKPeBqa/l
         q5LEX4+uM5H3W2lSSx0SgLE2Bu0q1SOzMTWOdpD4Ztsv66tlXJR7vNGeCv0AUQYnFPeM
         QtRgCsmgI3NsbyFSCnOOVL86B9ZzNVF4DJDh2kejiCWnav2MvYMIjAdXBRu9/JQUq6vV
         0rJd5dS0AfXwrIRdMjB4hIvTvZl8Hs4L/ouKgRMD2P7o2Jnz/RhS+7i3I5WvYwThXbMw
         C/QRF1SO/Qy2l1eVhQ9Bo28nZfPb3JbDQEDWFtGpktumj0F+xZh1hsxZjRJy/CbJOAsd
         i2Pg==
X-Gm-Message-State: APjAAAV9Hdg9J7cYmoWyc7s+mJebtTMIWPg1KURS+s6jFuAOnr6QE0Ae
        WAGIUk6bYxe4cqZSRxjNokQlgUXmA6lmJf66RiPSwB9LCjv4RUImzE1I/PzMjP3NCZxADJSfv7u
        xR5aNeciklfdDyIBwp/a6
X-Received: by 2002:a5d:690e:: with SMTP id t14mr8532972wru.65.1576751704392;
        Thu, 19 Dec 2019 02:35:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRIN6jrjB2zwl/YVEf01195wmi63mQXP7jnb1nOJ++QqxEfgXl6pGOygsE+eeyF7zb41K3zQ==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr8532922wru.65.1576751703925;
        Thu, 19 Dec 2019 02:35:03 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id o7sm5513625wmh.11.2019.12.19.02.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 02:35:03 -0800 (PST)
Date:   Thu, 19 Dec 2019 11:35:00 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 IV edition (OSPM-summit 2020)
Message-ID: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition

May 11-13, 2019
Scuola Superiore Sant'Anna
Pisa, Italy

---

.:: FOCUS

The IV edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. Summit will be held in Pisa
(Italy) on May 11-13, 2020.

Although scheduler techniques for reducing energy consumption while
meeting performance and latency requirements are the prime interest of
the summit, we welcome anybody interested in having discussions on the
broader scope of real-time systems, real-time and non-real-time
scheduling, tooling, debugging and tracing.

Feel free to have a look at what happened previous years:

 I   edition - https://lwn.net/Articles/721573/
 II  edition - https://lwn.net/Articles/754923/
 III edition - https://lwn.net/Articles/793281/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Real-time and non real-time scheduling techniques
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations can cover recently developed technologies, ongoing work
and new ideas. Please understand that this workshop is not intended for
presenting sales and marketing pitches.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!). Registrations open on February 24th, 2020.

To register fill in the registration form available at
https://forms.gle/7LfFY8oNyRxV1wuQ7

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation add its details to this list:
https://docs.google.com/spreadsheets/d/1pPU2ybHHoQjqicYLTaNanPz9H5fv6mQTtrzOqwP9uHs/edit?usp=sharing

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract
- 30min or 50min slot

Deadline for submitting topics/presentations is 10th of February 2019.
Notifications for accepted topics/presentations will be sent out on 24th
of February 2019.

.:: VENUE

The workshop will take place at ReTiS Lab*, Scuola Superiore Sant'Anna,
Pisa, Italy. Pisa is a small town, walking distance from the city center
to the venue is 20 minutes, walking distance from the airport to the
city center is 30 minutes. More details are available from the summit
web page: http://retis.sssup.it/ospm-summit/#site

* https://goo.gl/maps/2pPXG2v7Lfp

.:: ORGANIZERS (in alphabetical order)

Luca Abeni (SSSA)
Tommaso Cucinotta (SSSA)
Dietmar Eggemann (Arm)
Sudeep Holla (Arm)
Juri Lelli (Red Hat)
Lorenzo Pieralisi (Arm)
Morten Rasmussen (Arm)
Claudio Scordino (Evidence SRL)

