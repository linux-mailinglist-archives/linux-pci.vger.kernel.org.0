Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990512BC06F
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 17:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgKUQN3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Nov 2020 11:13:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:39553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgKUQN2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Nov 2020 11:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605975168;
        bh=5XWucgV8E35bUAw4aZcK+RdQSdGH0BbK0144kscnzcI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WQolZIuuxEiDb/4MIogv7qWitrEDh9yZwc21+uMJ8+WIOE/ed1OKqJoypw6F/kbvl
         39WotD6bjU87mQ5cmeTjoXAKZPL+PjeUve69J1kCDVxTd/HqW77CA2MEvSXyNrz9AR
         /cCVn5tv+VYz93V1lWMNOrSuYpy4Y2N4jnQOLp24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.75.72.182] ([185.75.72.182]) by web-mail.gmx.net
 (3c-app-gmx-bs42.server.lan [172.19.170.94]) (via HTTP); Sat, 21 Nov 2020
 17:12:48 +0100
MIME-Version: 1.0
Message-ID: <trinity-79472418-bec7-4097-9612-fa7a79c27620-1605975168396@3c-app-gmx-bs42>
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
Date:   Sat, 21 Nov 2020 17:12:48 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <c63d8d7d966c1dda82884f361d4691c3@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
 <1604253261.22363.0.camel@mtkswgap22>
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
 <87blgbl887.fsf@nanos.tec.linutronix.de>
 <c63d8d7d966c1dda82884f361d4691c3@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:0WIPfXZNx+COWrzO6EWqhIOYRhYsuaEetPZRHGICmDa5l4cTCVnVnw0NbFHdi/ukfb57B
 6Lxz2OgLXMSr5/sLZ9j0KeqQe9najHHMVgLiJavcBw1i28PIl+j0IgRbSTL8Th60ZpqaRZYhyRIK
 QjWgVE5drMTBYjDwVBLFA4kAa/3ZuKPVy1/qTV/Hh7g5rsFwX6y5eGEE+zxoF6Sv9oDXvsEC2oDj
 DZkqXXREa2aW5ClACLGG2C2cD7q4q7NS0LHGaoTWc8wnipzl4h9m3r17XTbZcvlS5ciH6UT3Hxwp
 Cc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eADDipfb3v0=:KBRN9L8eDneVATspJUwmja
 XPTN2pmGNuR+KRj/6s7kAKPPo6YhEbChm8G0MtP+rjsnpBZCOXSjBbTUS+gE0zLVh3XhqGHRs
 gwQopYWXCPmE+LUThjau41VJI8mrH9VyebUy2hiWKLfCkoZiqQNAWiGi4X49zFS9+pY3pABs2
 FF1ikYXvw90kdUxYZnc1V0vli/ebkvfnAvX3Hy07dUbXZMoANVO8le7DL5x4jdLS3SR8Ffrcz
 x9DNglGD0SdwwoOWazBCLvBDD6Tiyk4a38OYvjStb777J3XegwXEBO/YCgKCLJK6W+LTtkIJZ
 TClV2KG0egtTMd5P0Wg7IsyHPvMd9+38wAcHJFTMnfC9u6pLpWZU1z4OY970dhJfTJFC1aGAK
 Caxwvu8Wp0aQ06xJdPvocBRh88WAOum2QjOQKnILjCi95/KaSZoWuCLKCDQAPVRbGADYhgPKh
 w7fpVLoH9BI4ThFZQ0Rdt5uro74R4XbRP8YtNonBHiND+KoLYdOBBRKVKZL8CZyrHC5+VGjGj
 cqRIhWV/R92vXLQcpvkuI+irJc576bjainFPKd+C6+xouBNIvH7my3NiJF+CRBwvegJ5kekcT
 7LSM9o73dxXyw=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

any new state here?

last fix works, but i have not seen it approved by anyone for merge or sent as separate Patch

regards Frank
