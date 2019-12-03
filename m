Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD05011014C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfLCPaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 10:30:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCPaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 10:30:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so4140988wrm.11
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNwFXPekhWv2eWzhcVjVYpipKkMgjKBl/x6cxxZotUw=;
        b=1xmyuh6Q4BEGz3DUn6Oygwz3dLh7jtOKkgYrwruEzDQIOyp/C02nFpj9llkoTJS1zy
         mKjWEeUpRzjUbBy4gvYwvCQcaFl4QGcScLRnryehvKnasb4ws4iHqrawvY/ss+9DHqqm
         UeTIQa+n69bQXmuHnr37kRIt8bPAN0YyMdbiTrYlOlErcgIHHmqsAEZciIn5tSkOUFzr
         nPnJ7/uEdvJj9TdcgHowkij+dPMTwU9cBQAwbzoNkHXM161pvrONEyPKp1wr5KddW1L3
         97Hkw8B67WLW9CgbUwk6Vh4nY7xpSw3+CZK03pCcwCe0sgYBJ9d4vUCaOVywuEdki0yZ
         R2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNwFXPekhWv2eWzhcVjVYpipKkMgjKBl/x6cxxZotUw=;
        b=q0EEtkrWh+h6fuGf9qtvHFeESsTb+zlKdDK5bTlDiCdcesr1cd/i3Tq9Xant+fm39c
         ky0+zvFRphAT+rPX1TuAvi3f/XrhRR3m4H8VvZLeX5DTxUNUd1k6qne4iqEuP6aUfIgV
         Pv0vELVAJJk0xqVLND2jYBt5qFp0LKKlpo1Nvqhyv0B3EgTulYxRbOQw4Q0fPR85dlP6
         5T3M6vISPUiPW9wFLOBGxXR8uNPk5qpX7DbnswJlyFi9dRRXUg+/atKJAm4yatmFuvvn
         xcZyHPLEprSN2ewZnlb8xWrPPIWazjFueXBuAQavzyfDx+U+afS2Dm4B+w6957VX4FQ+
         xDqw==
X-Gm-Message-State: APjAAAXzNwdhNGEK6Y/oOYGwZ3DIg81FDDrsaqmwPiojOAdqpURW+UkT
        aPOgxc0Ywyh2SBVzmFB+JWv9QYx3y4vQV+sXBUTBXg==
X-Google-Smtp-Source: APXvYqzvDZnEv6036rAJma5lg+xhVt5jTdEqZrDmi9t5h9+Wa4yrnaO9rZTh44tqf1dAMZx3SCpJw1xD4Yc4gepb1ls=
X-Received: by 2002:adf:f491:: with SMTP id l17mr5718407wro.149.1575387017828;
 Tue, 03 Dec 2019 07:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
In-Reply-To: <20191203004043.174977-1-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 3 Dec 2019 07:30:06 -0800
Message-ID: <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 2, 2019 at 4:41 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Add an option to disable the busmaster bit in the control register on
> all PCI bridges before calling ExitBootServices() and passing control to
> the runtime kernel. System firmware may configure the IOMMU to prevent
> malicious PCI devices from being able to attack the OS via DMA. However,
> since firmware can't guarantee that the OS is IOMMU-aware, it will tear
> down IOMMU configuration when ExitBootServices() is called. This leaves
> a window between where a hostile device could still cause damage before
> Linux configures the IOMMU again.
>
> If CONFIG_EFI_NO_BUSMASTER is enabled or the "disable_busmaster=1"
> commandline argument is passed, the EFI stub will clear the busmaster
> bit on all PCI bridges before ExitBootServices() is called. This will
> prevent any malicious PCI devices from being able to perform DMA until
> the kernel reenables busmastering after configuring the IOMMU.

I hate to be an obnoxious bikeshedder, but I really dislike the
"disable_busmaster" name.  I read this and $SUBJECT as "for some
reason, the admin wants to operate the system with busmastering off".
What you really want is something more like "disable busmastering
before IOMMU initialization".  Maybe
"iommu.disable_busmaster_before_init"?

Similarly, EFI_NO_BUSMASTER sounds like a permanent state of affairs.

Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
is busmastering on when the kernel is loaded?

--Andy
