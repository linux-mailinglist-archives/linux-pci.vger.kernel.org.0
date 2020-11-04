Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28BC2A6AE6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgKDQxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 11:53:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:43387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731496AbgKDQtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 11:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604508572;
        bh=itzpSSQZMzHTOjFQwaEjOIn3NoQnKY3T93SB2E0JxlU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gsge5Zyc+RmE8Sl9apnpDqbBJ8G8EAQ/AP19g1QVh5rXrd+ZejDwLdDUnxKeIAWr1
         IOACslAO3KuY9TuywV5nYTeOmXvP2Z5YJNyhDqHKu/q1jSSiviPw6GSaZCV9uakHG9
         VhZTPhfyNdY0FrgMQ+DAI4UVtZIPc4KzxShuNETw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.75.74.195] ([185.75.74.195]) by web-mail.gmx.net
 (3c-app-gmx-bs02.server.lan [172.19.170.51]) (via HTTP); Wed, 4 Nov 2020
 17:49:31 +0100
MIME-Version: 1.0
Message-ID: <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 4 Nov 2020 17:49:31 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <87o8ke7njb.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
 <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
 <87o8ke7njb.fsf@nanos.tec.linutronix.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ICfh3WtogdrpOnkT/gXuEFWIaM4DIXYnB6COgVA3DMs2B7BYKR0IimJCA1wNt80BnphrN
 b6RXx+FWw4J8CmDkM5SfE7XkSYj865O3iXpD8zOrKFKQQqApmFLgevMu7mlJT4rnIK9z9x2oZa2z
 9DigQch4XDeQoGUPG2OqhId4i0Jnzsfy6wHJoNc+0Mforeye4AWbl52RfriMaCuKpmXFmI0VoUfd
 f2khjJaTHIqxyagSS2C02FdjMC/t0s1y+KM6EZ2dNDyPMNbs0472YDr+il/FD/BM742DBSYF69XY
 po=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o7DDce+FsRY=:fDyjahd9aVh+82I0GoJ23v
 JW5+QemSWiUMZJTMvMGE5axjm1sY0mpUNeNy2Ls20p1D41mAOaBH32Kbeb/my7WAj2pSslnKC
 WOaCrq2NBU0ha6lQDJY1cHo4SyOoRYMGeUabvOZSpx9+al3OjhsWw6Mris1ZSZ8lbJuKIIUMK
 KG+0TNWpKWfgLbdcVX3mMWfnQhujuKATPJKp2yAnLAOe/faUjQ0/sueVoNNYWPrapgyrKjS3V
 BjN8/WNf5716FWqhQQoSRvlq/CUNHcGH0GPAhs0dtpPYT5onSAZavK1GUem8V7jFSy02T33d9
 pcZuybC/8DRT5Uerg5CtZzO7nZovo8ywB/p6Qf/CDlogLdijHzmxkwW3RbJITA6hM52QoOd2G
 j8XSBWqQkzONvW3Rwo3zsV0dsj1HyfIqWu/k0B6FjYiI+Qbr88xrQcTmJE41nV61ke10wVeIh
 PY62GVe8ezVCfwXxmGUr7F/J+KPh9dHc7CEuuyW46jGj02eAJsWEMknFkvZkP4uOY3ZpIlDwc
 JuJjpAuNiPBJo+3S0xSWNO8TGdezBXupyMNf3W//PYGIQtcB+jejYmoHpPIz20AQOiylrxCcH
 qTa/iS9HJTi/Q=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> Gesendet: Dienstag, 03. November 2020 um 11:16 Uhr
> Von: "Thomas Gleixner" <tglx@linutronix.de>
> Any architecture which selects PCI_MSI_ARCH_FALLBACKS and does not have
> irqdomain support runs into:
>
> 	if (!d)
> 		bus->bus_flags |=3D PCI_BUS_FLAGS_NO_MSI;
>
> which in turn makes pci_msi_supported() return 0 and consequently makes
> pci_enable_msi[x]() fail.

i'm not that deep into this, but just my thoughts...you are the experts :)

checking for PCI_MSI_ARCH_FALLBACKS here does not help?

something like this:

#ifndef PCI_MSI_ARCH_FALLBACKS
	if (!d)
		bus->bus_flags |=3D PCI_BUS_FLAGS_NO_MSI;
#endif

imho pci_enable_msi[x]() does not do anything if there is no msi-support (=
or does not get called), so maybe check the PCI_BUS_FLAGS_NO_MSI before th=
e call (if this is inside core) or inside the enable-function (if called f=
rom outside)....

or is this the issue marc talkes about (called before flag is set)?

regards Frank

