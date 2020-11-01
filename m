Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7247B2A1CD9
	for <lists+linux-pci@lfdr.de>; Sun,  1 Nov 2020 10:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKAJZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Nov 2020 04:25:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:46615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgKAJZg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Nov 2020 04:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604222710;
        bh=JIBHuKWhwwmsOaLOSFETE8/UYlSNB3NgVVXdwGZnc6M=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=k8LTIGIckeMVV8gBX7N/5nNed+O7Q8AFXvGE5QGs37yBb423avg1qzzaB7wwsOEbq
         ouV4Qt5rp61kNApvz8tXA+v7dRRKLchEAGc+gt6doRM0bDn34wfEKccSqb19HFhW+5
         RMp+EgSZshMC8Gw3imwZrPSirY+db2gsbZIlwgAM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.144.204]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1kukuz1JXn-00ViHR; Sun, 01
 Nov 2020 10:25:10 +0100
Date:   Sun, 01 Nov 2020 10:25:04 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <878sbm9icl.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pci: mediatek: fix warning in msi.h
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org
CC:     Ryder Lee <ryder.lee@mediatek.com>, Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
X-Provags-ID: V03:K1:W6EnW92w+ArEgBh+BB8a6rj90e8Gy6EqneVfb46i9qAv1hNwajV
 lkdUk84Ms3SRyCqv2RCerc0vyi0poyoXgKgGddY79UnQ1ce9nC/d/aXtLH3ij7Ei7s25FFs
 rkYCr8HpBS22b1rMdOt6CL/GfdAJTPlxM5P249uJEacL3h/GIk0aL6RahkjzPrUcDXj3/hg
 qEfP5bTB0aUiSDKKn5ZjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qt5NkYmRQRc=:+NAP1v9GNfIFoarELyaFs2
 UVl+6Mfw0F8+u9XxzC0fvTlmLvTdBX/c+qu7yVu9n+xCSsGDbvJrookTiAKlfVkaY5ZRCIn9Y
 wGA7o4zf0nA5BVfGemZiyvZsLeDgMQlHtShqatsdKygSZfMMkh6hXVWUsXnE1lwKgOo3SWp8Q
 jNBE9K6S7wbCZG2CgnZINv7rN6083A0vl3UUr/JoTkXjuujaCn9LABNem2emjgcUR/tYRb5bu
 05S/B5I3Whfz0nahEZ2vQUiAtCZxAp6QtxJ3QN/HiAuqan7V+cYAB3Ru4xX9bJvfp+aPb4i5z
 F9ipAjX/yIn4OHK2fpvHWftqYtLyC6v0xRjUCGVPa7vKqFQI2xE+UUdswwMFiG5f68wkFQh+L
 fcsMrhVnrE6EAi9dQPfE8BMknvqnFMOPGEhnD5NE2iTqqJAudNw6km3WD7UbRRbdkl8ub9+Do
 vKP1LS00A1V3KYkxWDOv6dW/9GrboXb1/aRn3ls3kNxdR0+80Dgv4YOrNFyPTQbrAE2YpPTZY
 RJ4FDSvyCI7i2yRR8nIhbWFrTn/7ghc1c9Uv+JiOPg3PvA9jaT4PQYBmIY9soqlWiQQvfddCi
 FYT9QHl4eMhoLNvEoXf1RUeleq17KCAk6E/h2J983xejXNTyXgr/s+ymhcqSYC7ZM+G6zCDVZ
 UDv2Nz5SdJOjT7oJTHW/jxXa0gtCJ4jnT2pE4XJQ2xT6p5kx8bZpQz7o3UbYFlybhcm8qD1bk
 L6gZn6tzQQHTkBwsH+I0kjlH7PsC1JXv9vYCQlclhcEJeRE1dSiYSZtOnxa5NiZ+WxUfbN7V4
 cBSo7S4DUzKeCBoG5SNnulA5FKHMA01zhdBc964CkIbCa7NjnRDaQ+ANz0hxAjEq5boVXosjz
 SIRVUdII2GArg0O9zrmK6uNBcRi1o2kcSdGwXXNoE=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 31=2E Oktober 2020 22:49:14 MEZ schrieb Thomas Gleixner <tglx@linutronix=
=2Ede>:

>That's not a fix=2E It's just supressing the warning=2E

Ok sorry

>So it needs to be figured out why the domain association is not there=2E

It looks like for mt7623 there is no msi domain setup (done via mtk_pcie_s=
etup_irq callback + mtk_pcie_init_irq_domain) in mtk pcie driver=2E

https://elixir=2Ebootlin=2Ecom/linux/v5=2E10-rc1/source/drivers/pci/contro=
ller/pcie-mediatek=2Ec#L1204

regards Frank
