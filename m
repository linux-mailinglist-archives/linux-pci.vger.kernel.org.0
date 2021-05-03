Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2F371534
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhECMYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 08:24:37 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhECMYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 08:24:37 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoOMq-1lFBEF0XXs-00oqS5; Mon, 03 May 2021 14:23:43 +0200
Received: by mail-wm1-f48.google.com with SMTP id n84so3214099wma.0;
        Mon, 03 May 2021 05:23:42 -0700 (PDT)
X-Gm-Message-State: AOAM532NwSq0D+aEyIxLMg9dn5d6OWQSgaF5k5uTffxH/k48X/4oacd5
        TOXvCphPR9OuRTRbdgfLMyoKQaey57mSSHQod0s=
X-Google-Smtp-Source: ABdhPJzgZnWYW+fOuChQUPyL8ctUyHMhpQ7+njGfdV1G5yVqSA4zSIMSXjfnegUMZYYWLAeOIA1tvONv3koPAKICOxk=
X-Received: by 2002:a7b:c846:: with SMTP id c6mr31174650wml.75.1620044622642;
 Mon, 03 May 2021 05:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210430153225.3366000-1-robh@kernel.org>
In-Reply-To: <20210430153225.3366000-1-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 May 2021 14:22:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a16ZRoisiQeubTJz6E=w-=34BPHtPRYiwwnFWiEUnew2Q@mail.gmail.com>
Message-ID: <CAK8P3a16ZRoisiQeubTJz6E=w-=34BPHtPRYiwwnFWiEUnew2Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove unused Sigma Designs Tango bindings
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0TxYnDn7eQxPX//6HofUo4blLorfJxjtBEFLegC1X9h8nknrAuA
 J6gJCzDJuQZqxzSQT+GnO5YCPyLA1/7UjIOoYQfdgx3Wm+sNh9kBy6XXyT3drx2y3TJlCzm
 scyQXB5k+R6J1mZQ95F+ghAfvt8dEtqeqJAWBjLKGol4H1VTcOdHLEyM4CB+L4aDuHiggfc
 lg185+ohLXPmNko6TvY0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KeW5nA4WIdM=:9C58HFElrTXlhUn97m8kCw
 OKe7/amK75bTKqHbbjbfximjdlgcRwMwBacYl5wbT/rZe6hGQQ5BqNnlM1mATWAPCDCH4oKTz
 nUTFSRCTwbKYRIB/r1OzYAD9iJOsFVygV9XRrXIl7vY9bd81XNs+aamPE+CJANqdJuVc45ygl
 XFjrh/W2f1nSMQZPLrlMXA3c2CuTFfuZ8HbXoYwQRVUcSVU1b4Tkpz4koqLSvRD9XKRDIGnyZ
 slL0XhD4n9ZON8w3mHMPn7zSRrdGJQJLxnJ7nspkKwes3HrmFJNEQ5BCun+0WV5qgYPqwFMLJ
 9ybrMS1Yzf0p6PBXAbLW2qepcerXrYz0JesC/IDrakN35i2TSb3rkirnG1EMhzovqzDricAC5
 oomy2C1dufvdoC+NZSPna+8Zek879+6gg0tx2JSBhcpOiIVbJmmFo2NjIGDYt1OomFrlGqYV+
 CA2pEGIzHyZq+zN8/KIcKL5eVy+h1NcD4oJUBx4JEdyiITzDhoc6c5BO4Vnp2vnL4SinbFybr
 sx2vG0hz6vZIEhjqWaU0T8aWblRHhdGbiGbyT+4ERLNw1vqcbChnb9ZzTamL5KsSF7Ua6lnTl
 5n4Uzp3QtVlDBcL8VmMmJ2DbSls5B+vLBzZxGXQd9VCIIG2IQefa8RS53J9z2eCQTnaA7tfYz
 VaEc=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 5:33 PM Rob Herring <robh@kernel.org> wrote:
>
> The Sigma Designs Tango support has been removed, but 2 binding docs
> for NAND and PCIe were missed. Remove them.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
