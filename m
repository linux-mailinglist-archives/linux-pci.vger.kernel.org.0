Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260FF2A20C4
	for <lists+linux-pci@lfdr.de>; Sun,  1 Nov 2020 19:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgKAS1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Nov 2020 13:27:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:50207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgKAS1g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Nov 2020 13:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604255233;
        bh=/L+w0lrholo1kMZ1eJSk7XoUYmf7kf9uAE6zDybJJI0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L5KAIuUO81PNWC/Xk++LpHjA76nZTilRpxasjMgiFnoG4Su6U1tSvfMEy0KdVqud5
         g3SZMC37zFZc0FNanqRetBNkJ/Yi0oi/9hbBXGMd5zm1tGKOoS29gQhRfA+YRuIagh
         H3o3wGEu5Hg2FMSyc7rHn0FXASNgPygzCQTM1IBo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.204] ([217.61.144.204]) by web-mail.gmx.net
 (3c-app-gmx-bap08.server.lan [172.19.172.78]) (via HTTP); Sun, 1 Nov 2020
 19:27:13 +0100
MIME-Version: 1.0
Message-ID: <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 1 Nov 2020 19:27:13 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1604253261.22363.0.camel@mtkswgap22>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:A5wNCGAfPYLBaq4vJipjLleYOK2TEelZNZEUKtqbujq6fXPEHUJyM0Zu35pMgzDT25BbJ
 kpk2ZzBEXrgUPaVYwzUFA76f/1LV5/Bs+JrDAKdYH1bawVRT0MRsFyFVZdPcyeOsXSn9L7fExOIX
 XxEjXxz+ZWo+j9fTFqBBUgwTjiYhn0iA6S+PyNuqe9r0f1zyFVmTHe8NJl8eI2SGUnp0efee215W
 fa+BfNjD90nPZ7fAaHBqJcyJXTp2UarxGHzesQBU3Vp/1ipKQFfGvwgXifsrRfjVbOxitOaY/ner
 Kc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JVV58eDgfxM=:/UUrFFmGUI3vP5RJJLYjN8
 pNg+2F2WvIn0Ncgs6ZUNr0CrtEBo2UsgT2dn8AJiU2MnPwq0gtO7Q6ftfcUsCrPxMr64TVUBB
 RW8cS1lQu1bt1aARV3Z60mRWOANmWMrfIoNnflSUMSBNEs5edbygyaznaCYVqXWXioE2W52je
 oiFvBYQQEH3hVas6XS6P/airpdo3oe8QbA/T9cBktYSV4v7BzGe8GaVBrowkVc9ZtJuyYNzsf
 mR/ZfkisM0M4H8FVNySlHBS7FCVfMllPYAJ5eb14yiU48eL6gfxHmMiTNsgU29v+VLSGOFDsK
 mwtfnWljdb2gO3ClZ9kLDbDlmLOLpa1bJ6h6whyEpIa3ViBxsdzcvWTEJAPCSoFGsLWT8lV+P
 AxTbYmyQl+aBr5EcoZm1ohkiMkIUC/DMU+1pEhp1LgwZR4352FeMemQpbhV1wz71kTKh46sxy
 hQg9Ck0F/smm5ajfAs5DrxjwHrs/ftt1XSQ99Dc5qc7aHC0SD6Wm0efd0+AR5wcrhq9wTXixw
 mPRfgdB6qN0FZhCkNzsmn1fvXGtBR7HuW7P515dAQ/O71Xe+bx7gMGu20P61hd0aJ4T3OY51V
 X8HznK3PbfN5w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Sonntag, 01. November 2020 um 18:54 Uhr
> Von: "Ryder Lee" <ryder.lee@mediatek.com>

> Yea, mt7623 (mtk_pcie_soc_v1) does not support MSI, so that's a way to
> handle it.
>
> @Frank, could you help to test it?
>
> Ryder

compiles clean for mt7623/armhf and mt7622/aarch64 so far

at least bananapi-r2/mt7623 booting is clean now - no warning
pcie and sata/ahci seems still working as expected. I have a mt7615 card i=
n pcie-slot (firmware-load and init without errors) and hdd connected to o=
uter sata port (can access partitions witout errors)

booted r64 too, still see no warning, but have not yet connected hdd/pcie-=
device, but i guess this should not break anything here

so Marc, if you post the patch separately, you can add my tested-by ;) tha=
nk you for this

regards Frank

