Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D23703B6
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 00:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhD3Wut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 18:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhD3Wus (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 18:50:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF2C06138B
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 15:49:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k25so26189112iob.6
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fatalsyntax-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=2wqJHexqn8jcOOVd9wSat+g8MvAeP2fqTz/IY+99qj0=;
        b=KgPumcEuTrAXvBWlAFi43w0rjTeiVvUQf3cYemzccxZWhLifQXI/LmHA0TQY9098lu
         6/d84mb/wMGi3K0stSDzxD0KdR9a3JnnABlvgfK9WVYa3oFV2g/EmKUalCDcrffLX03W
         VMVIXUdgnyVavSZUAqCGDkyLkR/BC0iztLrW/NRReBWSuKVVeMEvyzNBmYJF5fyvcoHA
         5jxK1bF4V725RWPcOfiSvjn/fxdp/ge6Q3GXbmI1bpKztKqhAliCOLJepjoXB8mcFeg6
         STSlUiOuzQJNYTcj4FBFoaNhr4ij2zEi5MSRX1aWjeiwDxLAfkHsmWv6y/0BObWLUlJi
         2Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=2wqJHexqn8jcOOVd9wSat+g8MvAeP2fqTz/IY+99qj0=;
        b=Ktd11Y+4+6TxO1sTbXfFemHwLsqG3euGBFf61IvBw1ix1z618/u1HWHd/0CNom31EJ
         oEFNxCv+Ydy+5v3i0RF08NkOBIXYlZFchoh8WsxbywFhyrtc/GQe5wNyq6JobvIZ5Ikt
         6mAvR8Icw9EEqIkCcCO7R2CcUSC6AcwtlFBu4wkikj6OquToYR3K2QWfybkOf+Yp7kX5
         /EVNA/MUgYY2GGRBbYEIGb59dqobgMXuT2G7zArO8ObqSnPR2XZoVwm98IgrN+C9uz4o
         dNYFepzYN6YZAVDbkPQXM7KbMl73RRFCwh6JXvjie3a6GoNNa0sBKf5mDRBwGvAh6gHg
         mZGA==
X-Gm-Message-State: AOAM530yZjWJE8DfVs6zdOFWw5IXa5dRuBEcXfBspCB1WcxQnaOL3C8H
        AOhJm7J1nJ+B6aD8g3DTVafbUQ==
X-Google-Smtp-Source: ABdhPJwAggpk9lNg7ha/NBDPxA2bMISeFgXGI7HOGYv8+px+pc26fUIsrRaqZhii//jbFeTkIGghOQ==
X-Received: by 2002:a05:6602:15d4:: with SMTP id f20mr5572440iow.201.1619822999102;
        Fri, 30 Apr 2021 15:49:59 -0700 (PDT)
Received: from localhost (2603-6000-ca08-f320-6401-a7ff-fe72-256d.res6.spectrum.com. [2603:6000:ca08:f320:6401:a7ff:fe72:256d])
        by smtp.gmail.com with ESMTPSA id p5sm224554ilm.63.2021.04.30.15.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 15:49:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci: add NVMe FLR quirk to the SM951 SSD
From:   "Robert Straw" <drbawb@fatalsyntax.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Date:   Fri, 30 Apr 2021 17:34:24 -0500
Message-Id: <CB1EZZPPTR51.WQHO07UFCR93@nagato>
In-Reply-To: <20210430205105.GA683965@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri Apr 30, 2021 at 3:51 PM CDT, Bjorn Helgaas wrote:
> Please make your subject line match ffb0863426eb ("PCI: Disable
> Samsung SM961/PM961 NVMe before FLR")

Understood, I will send a revision ASAP.

> There's always the possibility that we are doing something wrong in
> Linux *after* the FLR, e.g., not waiting long enough, not
> reinitializing something correctly, etc.

In my experience I was not able to get my particular drive to enter this
state while issuing various types of resets purely from the Linux host.=20
The issue only appeared when I pass the device to a KVM guest *and allow
that guest to cleanly shut-down.* The last part is crucial: if the guest=20
is forcibly powered off Linux was able to reset the drive just fine.

So I suspect the issue here is related to the interaction between
whatever state the guest leaves the NVMe drive in, and the Linux kernel's=
=20
own reset code triggering some pathological behavior in the controller.

FWIW even a remove/rescan, with an interim suspend to RAM, was not
enough to unfreeze the controller. The only way I've found to get the
device back (apart from this patch) was a full reboot.
