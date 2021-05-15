Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353FB381A2D
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhEORgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhEORgr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 13:36:47 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B97C061573
        for <linux-pci@vger.kernel.org>; Sat, 15 May 2021 10:35:33 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id z1so2542520ils.0
        for <linux-pci@vger.kernel.org>; Sat, 15 May 2021 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fatalsyntax-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=ECsAuXqf15dWO568NVSzYv1EWPK7FJKl+lqtYqv4WjM=;
        b=GhrWtqA8WDo7J3ALnnGSbuE/f12hP55xaLn6+j7nn3Cg7IRHFEqAYOsTrqlIOL3B+A
         BW4WGTmXPEVTBMcFU/8bqMkk2k1K8d36JYEXQLhG3dMGP24RhvVxjNmjpCGW8Iix59qK
         sXHJM/9vDWIp72wcVfzgiEy6KypVswQI8jmrsQxbIytWWLGsUGhRMiqg14eWYaL1tLKf
         VttMt9bT8uCw4W9ekKVHwAlHyqCCST6FuNHoHno4eUoMhOsL+DboOk77UQs/uaRWOUfQ
         rFiIgzrgTTMynVSlAF9f/ECILVazpAIYu9ITUCxODQhUmeUDgXKUNRj4gDkNyjfeFyfI
         u9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=ECsAuXqf15dWO568NVSzYv1EWPK7FJKl+lqtYqv4WjM=;
        b=DWzXiP9CWPly0KM/C5d6127a3zyERPT8SYmFAiyO24KRby8iUpYFmbTaZo9v8ywWHe
         vlpBy+28z9UrI1AZX2j1qlZ9X9kOgvqDa5o83r7ocp+DZe5leQteqO4eRedwgavbuG++
         pwh+SQApQ9n9OD8WEowg3YcBjrmxo7tN6Fl1ZhRlDEdmrJTAk3HO66CNV+tWU1R3PF7V
         xClyf0E1tlnhg39wrygDPYouNYzIJEmjFVUYsWQ4gamSSQh4/v1no0voC34OxQBasQ2K
         d4M79Y/NndF83E1KCs9ENl+B5+a+AlLSEWgZj3NZbcFMH7UY0/MjQ02JcLiVKxbg0jPm
         Hyhg==
X-Gm-Message-State: AOAM531fGWLap5MPnbe1Cp7ftNLbn4N3FFlMt5hh+iSWf7o/CLUmxkB7
        c8sdRoAmoxYXP0Tu6ppu9/6fXLuPWKe/cSwnDVSeXA==
X-Google-Smtp-Source: ABdhPJy/rRDwwTjfwk0ae19NzmdLr9zilL3sOKeRp8K5fwv74zFSxDNvdqMJmKJktvMAonHm7jH03Q==
X-Received: by 2002:a05:6e02:168f:: with SMTP id f15mr48359921ila.264.1621100133041;
        Sat, 15 May 2021 10:35:33 -0700 (PDT)
Received: from localhost (2603-6000-ca08-f320-6401-a7ff-fe72-256d.res6.spectrum.com. [2603:6000:ca08:f320:6401:a7ff:fe72:256d])
        by smtp.gmail.com with ESMTPSA id x13sm4977602ilv.88.2021.05.15.10.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 10:35:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci: add NVMe FLR quirk to the SM951 SSD
From:   "Robert Straw" <drbawb@fatalsyntax.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Date:   Sat, 15 May 2021 12:20:05 -0500
Message-Id: <CBDZPI1DXKMS.88UVUXVIGC5V@nagato>
In-Reply-To: <20210430205105.GA683965@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri Apr 30, 2021 at 3:51 PM CDT, Bjorn Helgaas wrote:

> Please make your subject line match ffb0863426eb ("PCI: Disable
> Samsung SM961/PM961 NVMe before FLR")

I had done this in a V2 of this patch, but after some additional
research I'm thinking the behavior of this quirk might be in-line=20
w/ the NVMe specification more generally, I'll elaborate more below.

> I don't see anything in the PCIe spec about software being required to
> do something special before initiating an FLR, so I assume this is a
> hardware defect in the Samsung 950 PRO? Has Samsung published an
> erratum or at least acknowledged it?
>
> There's always the possibility that we are doing something wrong in
> Linux *after* the FLR, e.g., not waiting long enough, not
> reinitializing something correctly, etc.

I did some dumping of registers both with and without this patch, and
determined the following to be true in my use-case:

1. My guest VM leaves the device in a state where SHN (shutdown
notification) is set to 0b01 (normal shutdown)

2. The guest also leaves CC.EN (controller enable) set to 0b1

3. vfio-pci attempts to issue an FLR while the device is in this state.


On page 40, sec 3.1.6 of the NVMe 1.1 spec, the documentation on SHST=20
states the following:

> To start executing commands on the controller after a shutdown=20
> operation (CSTS.SHST set to 10b), a reset (CC.EN cleared to =E2=80=980=E2=
=80=99)=20
> is required. If host software submits commands to the controller=20
> without issuing a reset, the behavior is undefined.

In the case of the SM951/SM961 it appears the undefined behavior is that
they stop responding to attempts to change their configuration if you do
an FLR while the device is in this state. The reason this patch
resolved the issue I was seeing is because the toggle of the CC.EN flag=20
puts the drive in a known-good state after the guest's shutdown=20
notification.

Knowing this I would suspect we'd actually want to treat most NVMe
drives in this manner *if the kernel sees the SHN/SHST has been set
prior.* Perhaps other NVMe devices are more tolerant of not doing this?

~ robert straw
