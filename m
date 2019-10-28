Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA8E795B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 20:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfJ1ToN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 15:44:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41430 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfJ1ToN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 15:44:13 -0400
Received: by mail-io1-f65.google.com with SMTP id r144so12072643iod.8
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=F9yjJ4PFl32YvXwzODYyp252wDBRX1rheD8d1z4Ivvk=;
        b=FLW3qv+axbhaUOF5KRVjcLXa9JGxUy+9IycXLKL7ODOTLYlhILhziuly0fmS1JXB9B
         ckQkfiYzMr+3b8qfhcm9OvC8bFiXj7JktliGL/2W+svmhKKa7iFU0XsDlA3Nkrp08a1s
         tMh3VP8eANWWkI2rINNMzSFGlMGZVravPCleRmCkGmH7aCbRiL6U2xjX/jANLlu1Wgre
         5JjGs89gEJ2f+45wZT9rH/WpaPyYzzzom4kQ9xVd1EXVzjeVAqBpm7wZrGJAQaHUTlJ2
         de09puaNuKaezs/nWUB7i9VIKtb2i0GvyUFei4J+aMgBH9NcZKgn09BXvShM6ouvJ26f
         mpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=F9yjJ4PFl32YvXwzODYyp252wDBRX1rheD8d1z4Ivvk=;
        b=WL7Ec5U6WZk2i4yGdPyttbd4U6MJm7XsQz8km607Lbznb41EOpncUSwSniDFOBUlDk
         mf3QekSYeJ98NEMrJgnXTrRrw7NTlTbPwr+HkwjGUDnOqK1vfi8Tb0Xih7BdaoUIflnf
         FV3G7oKZWVUB11PCARezArjcPWFJmN2vnw2bm6STk1b8UKJaei0S1s8Ps1fP1SkvT5lF
         q0aakRUzEh4ZqABr3TCsVFm5q3ZonXpWy+K/UypLO3gWM94jeHFw7OH8xvZrTtCF5G0L
         7GTnJpwK4/f1zWthJrWNNUq0vebFRrpQfd1PQdaxSgJOSRllOtcQd8YknjMB2S9jQ9eo
         jxJw==
X-Gm-Message-State: APjAAAV6lnhpvAaX7s7SkwynlcqVMkAvBFwuURWe7VCzFToqWq9CKczN
        iMJ+I2DHeZHhOVv/J+9az9vHPbVRSdwc35PlWIt7Ug==
X-Google-Smtp-Source: APXvYqySbESYw0jrXv1RKys8KhfT2FtD5Li8WHbjCYkEkjMl311M8QHJqCW9S1vOTGU9U4QUeJxDWTYmJM6k3ZHQhSc=
X-Received: by 2002:a02:740a:: with SMTP id o10mr17482478jac.106.1572291852235;
 Mon, 28 Oct 2019 12:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
 <20191028171329.GA104845@google.com> <CA+QBN9DZyFynoUt+7sS_AcC-Wio-McJKCz8-RYfDWV0jv8iCzw@mail.gmail.com>
 <CABhMZUXADeHV+iUgFyDF+3BcQRFKDkMbwdkDAvBuYLd2XY=HCw@mail.gmail.com> <CA+QBN9Aj2he3RQMGaz21HD24gPk0R=bSX0cqVLj5PU4jK5Qrcg@mail.gmail.com>
In-Reply-To: <CA+QBN9Aj2he3RQMGaz21HD24gPk0R=bSX0cqVLj5PU4jK5Qrcg@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 28 Oct 2019 14:43:59 -0500
Message-ID: <CABhMZUWdeOQ_M0x8UwzmjGRj8Mrwfc49CqEdL_Tuejmrso8CAg@mail.gmail.com>
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 2:06 PM Carlo Pisani <carlojpisani@gmail.com> wrote:
>
> > What's your .config file?  The knowledge about the host bridge windows
> > must be compiled in somewhere.
>
> here it is
>
> http://www.downthebunker.com/chunk_of/stuff/public/projects/sonoko-x11/router-board/kernel/k4.4.197-rb532.config
>
> too long to be attached to this email
>
> > The UARTs do not have DMA enabled (BusMaster-) in the lspci output, so
> > they shouldn't be able to corrupt memory.  The NICs *do* have DMA
> > enabled.  Does the problem still happen if you turn off the NIC
> > drivers (via-rhine and ath9k, it looks like)?
>
> I will recompile the kernel and re-test the router. It's a 48 hours burn-in test

It looks like you're using a v4.4-based kernel, which is 3 1/2 years
old.  In general people are not very interested in debugging kernels
that old.  It's better if you can reproduce the problem on a current
kernel, then backport the fix if you need it in an older kernel.

Bjorn
