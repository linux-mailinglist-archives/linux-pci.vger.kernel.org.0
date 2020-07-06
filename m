Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91175215570
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgGFKWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:22:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFKWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:22:36 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOAr1-1kGlgB1kqH-00Oa3m; Mon, 06 Jul 2020 12:22:34 +0200
Received: by mail-qk1-f173.google.com with SMTP id e11so34265600qkm.3;
        Mon, 06 Jul 2020 03:22:34 -0700 (PDT)
X-Gm-Message-State: AOAM530MgDirLOiWHLUDcilfkaKz/gw5j8i67BJpxyeWmq8ljCalEAuQ
        eCToEo2hnmN//p9oWK8kVAgiL4sO1blAupdncD8=
X-Google-Smtp-Source: ABdhPJwfccsMavAEuOwPnZc5nlPwwAbRxA+LRFVk2Ze6EPLxLwoPZgaxnZdS7cDtAne9ISoMCR1TRoPiXSUYSIzVeB8=
X-Received: by 2002:a37:b484:: with SMTP id d126mr46501282qkf.394.1594030953207;
 Mon, 06 Jul 2020 03:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com>
 <CAFmMkTHrQ4LZk4+-3kdJ+dc47MXR1Jd76AXbO-ceT2zsfDRFGQ@mail.gmail.com>
 <CAK8P3a1bbpmD0wJkhkjqW9YttBpMmdn8Z5oTLm0cr-0gjyU2zA@mail.gmail.com> <CAFmMkTE3z6OZQ_v3jx-4MzMr8v+4qcF2uLn0ASGydj5oqDnfjg@mail.gmail.com>
In-Reply-To: <CAFmMkTE3z6OZQ_v3jx-4MzMr8v+4qcF2uLn0ASGydj5oqDnfjg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 12:22:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rkiBMB55HJGi8T4Nw4gUrG2M=BAq+w=WMbS8DzwnPqw@mail.gmail.com>
Message-ID: <CAK8P3a3rkiBMB55HJGi8T4Nw4gUrG2M=BAq+w=WMbS8DzwnPqw@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xAHZFbDFiis48mgI7mbogK8K/Dw5XVQKztXbK7rDQy43AeZdjiH
 Py2HQ//3YJC+ATKS4vqUszoMLXlvbCRT9DSV3qya/19Qyqm3WQmu6F6x60CnGiTGrnqaWSZ
 kB7eD0/PHmLwKOoB3cbEJpqClVsV2ZKczOy4uKOGz3iez6r9og6Kxod1+h6rKQNF/Aouxi4
 /gOGmZM/MZsXnPDyYPzqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uBWNFIPmyZ0=:e8gzHP87+Mhr5exEWhs1oR
 hoL1yee5u3KjnVA4j94nWBPQZWqHE/K2VRYZZfB8GHWjAJg7aRESALZB+N+pVx6X+PJNZPG5z
 yc+hYqeooeLoMnHZG5rUrvgZ9ENV6QaaWFYCFzqffkpFC3V+9qmXPdY+5ANchA+ZNfGrP+3Gt
 o9C0UmjslQqfq8x/LVUCO/un7u6NfnNC3WAMw5M34yOmub59eO9d1ufMg9oe+TqNDLK/q8mC0
 OdpSp2XlOSOO+wHdQatm4CaSeOLUMgH9Lgukty0/JB7LzYuLct6/aW/XJ9Wqwxs54Tq9za0tx
 EQus+c5MlUxng1pRhu/h2ej9u687gAD9t/nrh2+EYs72b5yYfBHc7l+cynr2SscdPkQZ/4zGz
 GbyD/CHQ299DRMMIF6dbklVyszHTtq/lU9a4jMj0t3XcTjZvP2RiqUcK7ToekSfQSbdDfS2FZ
 Ylck4YO1bWUBza4/Ad/s3qrljQdX2ZiHyXlJJNkjn1LmNDaLZeNXIo4SBSh6GrWRZAOFIeOUG
 4+jE9jOXh60OyXfau6Z3qAZz82WGvDIf/tllFUl/D8lJHspWS47cD04Jusvn9nT7Cz9DoCTUk
 K28IXjNFGLZyBLyLaZAalq+m94cpM/+5KpXm1Zg0eTcZvH2UioOOcF8sob67tGWfFuX1AkWlS
 18LbQ7h8Q/2YbdJpWqmGPYamyDKTw7mHao6+jU6+N+LseI7M9zA3m53RE5lCy+aJe36MCxFcf
 NI0yarEF5S3qmmhThTvlJ2fbuvJp7QkjH+rIvfJx+8Tu2Ku40u8REEmiIhJ+Yny+T/VbYrNPn
 PSIUb4J7TnnSwdYgOUQvc3Gt9xNL6Jf/aF/M4/FtVXvspqfFRbMc8iUzbKJMU20l21S7WML5j
 TcZEQfnTBe5YogsbXwjLTkdh04Ak0wHmzxbQWVv91Mx1wv1QAPoGHyD2qM1WjyZDgUvOsSmoR
 57qQEHX5lO1P5TsbDLB+KF8iqL+COGrPYdyWGktmwoLatJdoSd887
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 3, 2020 at 10:43 PM Daniel Gutson <daniel@eclypsium.com> wrote:

> After analyzing the intel-spi driver, I came up to these observations that led me conclude that it is not what I need to use:
>
> * Some SPI Controllers have 0xFFFF as their VID DID bytes in the PCI config space. This causes that the PCI devices enumeration doesn't include them,
> and thus a PCI device driver won't be probed even despite listing the DID that the datasheet specifies. I effectively confirmed this by doing a PCI device driver and
> trying the intel-spi in systems with this characteristic. In short, the intel-spi driver doesn't work with these systems.

Maybe this part can be handled with a fixup in drivers/pci that
changes the effective
PCI device ID on the systems that do need to access the device.

Adding the PCI mailing list for other ideas. Basically it sounds like
the BIOS has
intentionally configured the SPI-NOR device to be hidden from PCI probing to
prevent operating systems from accessing it, but you want to ignore that and
access it anyway, correct?

      Arnd
