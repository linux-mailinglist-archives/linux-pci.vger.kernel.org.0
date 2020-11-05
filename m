Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6132A803C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgKEOAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 09:00:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:56087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKEOAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 09:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604584786;
        bh=voomDKjD1D7OFb6dvnpVpguZn8+/Bj7qz4MAi/lSVa8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MFZUPIDDrlAcNE6Rc1XottMcZR3BIl3VWMREoMZVBWH0IsvMeS9A+16vnKKAYvUiq
         23Qhhc8hKaF0iet+XuY9/U/VyVIAmmsN2+i9Np5S6HiW6Z6nZCs4ySVrk29xTHab2X
         ZJbISFJre4VhSipDkcc77yxe7vVfV6aowBO+aoyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.34] ([217.61.147.34]) by web-mail.gmx.net
 (3c-app-gmx-bap66.server.lan [172.19.172.66]) (via HTTP); Thu, 5 Nov 2020
 14:59:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-6e877df5-d3f5-434c-9723-20a1257ec1ca-1604584786441@3c-app-gmx-bap66>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Aw: Re:  Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 5 Nov 2020 14:59:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <074d057910c3e834f4bd58821e8583b1@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
 <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
 <87o8ke7njb.fsf@nanos.tec.linutronix.de>
 <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
 <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
 <074d057910c3e834f4bd58821e8583b1@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:GLUO7D/wO+tb37W5SZ5xe0Eu0qDFWwHPzFWW24p1mEWACj/z/qcwnTSCcoEwSXaB+14Nk
 7wDTbnUHHVNZo6VPxDewR2/8VXujIgH030nqAs/Itv5DX4F5F0sSMTblaQKV7qZQ8z/VLkSrU7e8
 3eDKoY//ms/KCmlzkD+IylD/pK5tSaw41J7P22MIif12lj2dpYAuAua3/Z0S4bUv1phFS/DP/vKa
 +1NLuzhw2pmKKW4I1R2ohLzqWDqKm/hfzeBr7nqZ6H5QYJaIH8GFl3tfh8d8j+vvVI9Acu0rAWfn
 rs=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Va1155uyhes=:jW7Xw99631EbAyN4YqXhUt
 A6kc1A3xBXmyhPvQWp5gTojcxYr+l9OKQaAa6F6hSGlKGJKK3IjsbWH/E4QFrfO8QuZYk5l3t
 KTckb1BlI5CA64ULsOAzDQSjvA1Iq14Yvnj/U3gHVRqfy0xd1ZmGLAjOqw8Rh/Ut+p8dSC0bh
 ZFm+70EIqZxK0ifwlN8kAyedXD4dV7mycTDGSFEqcun7sFngFoILQkeMKuks53AbRv6WdnA6l
 78v7pJp5nFIUP1iEMDIMA9YhIfUOwac5OQyhlLzEKEnHjoVp6aLKazAGVJPMy2N9DmO/7PaSX
 8RHlg1YR14kS5H0x0Np6TcD19t6hopBGofdD7xrPwYFvAt61482BexBT1cBAZtnJ7ha0AZe77
 Mmb28JhVBD811f1D9N7Aq4N2s+jFI0NwU+zn/RexHbps4OQNDxAL60qD3xtznq0r3Y1NB9LBz
 M7Tqyomhxm1g7+3GskBthMsw3b9PfOH6d7YwiL5ZHJ3Q0gqCj1dwmTnY6oE62YPN+RxJZfa5x
 ynPITwwdy66fJyUtD0r5EK1IskA3LonAq1xWuVmM6Yd1NFW0g3Aihhopfl4CzmAEypjTM8Vjq
 MZfbHhvwEBs0w=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marc's Patch based on thomas' last one also seems to work well for r2, again no warning, PCI and AHCI (connected to pcie bus) working

regards Frank
