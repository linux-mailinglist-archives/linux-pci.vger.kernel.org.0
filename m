Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED6A7E535A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjKHK3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 05:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjKHK3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 05:29:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A271A1BD9
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 02:29:51 -0800 (PST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 32EC5409D8
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699439388;
        bh=JPnUP2dhK6rq2OT2zp59qDXCzcw2C/MeNwbO6irKsM8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QxjeHl3HuUYSKwAg8nm/gLIGxyOT/SuAWmmnzT2SXQh3+eSE56aRVttDXBF5jmP0b
         OZnFnOabjENcix6k6Nl/lpcxoU193Vk9RoE5LkOhDoQR58KOBGpYgrWjx88p6VOioZ
         gg426JUdKOSnxWqXB1Buuq0JWQoOmP+0ep87Hiklt1IzPlwlfPmGgy2HZrw0RGiINh
         XQ4zuoOzp5PxWIGaBcDYswLPc/IWO6Fr01SayMmEMvV2iDNcwNjdh5yUqlkcMuEOar
         lE2gXRLZQNx+dQBr2bKygIcecePq8lyHoaJ4FgLjMweLcfFawyTiSSWuN5v4RHgzE6
         ZkB95gQZo4sQA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6bcefd3b248so6703764b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2023 02:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439387; x=1700044187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPnUP2dhK6rq2OT2zp59qDXCzcw2C/MeNwbO6irKsM8=;
        b=qrLzSrrfRpoubZEdFlMVBARrTIDmg9WXE51BiHiXZOjt4e5OHyHWvuBLAduynlXHlR
         MFvJAgzH2BKSa6Uqz2TvZgrDZ4fFb45dxtJEOXAvznmg5SmsWvpHEGTrNL0PLzBHH26l
         2Ht9+1QFXuSgLrUv/Gz6U2nn2pCgowz1ShZuCI8ELm9QsAKRKxfUhIAf3HiJMxAavdRY
         c/8Mj/hAlX+MF/nDAqG7ZvnnURNnjyDfzn2eCSoITKdtHKLGkMbE/6O5DUbCBA3ZnNx2
         6dzZLQNjPngPqzfpEIAFJGBkdGXobNX137HVzpEP2NA465xZTmxjiwIvWM/Ojh0JMHOV
         03KA==
X-Gm-Message-State: AOJu0Yy236t0aGsmEVS4swXY9Pmi8QhDD916FmtvfTe0f3NjfcRUIpJT
        p8IsOglzJhMXP1zCyB6Kh9o512Q0g+Q5AUWl45t7A8XLVCw/+MH7YnEjhGZBPevt6/mnxX6F67u
        WKKFZiVNcuijbqsvn4EjRZUE+6yKvDRuhqHCh3n6bv+bHFFTaDwsTYg==
X-Received: by 2002:a05:6a20:441d:b0:14c:c393:692 with SMTP id ce29-20020a056a20441d00b0014cc3930692mr2027849pzb.7.1699439386904;
        Wed, 08 Nov 2023 02:29:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFboe2yTK4xo9PqvpxUzC3jlXy/epT3vmB6XsIMqWHzujx8gpq9+ZMU6Xblm9e+XufQk7xJ3brIYpcN30jCvUY=
X-Received: by 2002:a05:6a20:441d:b0:14c:c393:692 with SMTP id
 ce29-20020a056a20441d00b0014cc3930692mr2027833pzb.7.1699439386603; Wed, 08
 Nov 2023 02:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de> <263982e90fc046cf977ecb8727003690@realtek.com>
 <20231018094435.GA21090@wunner.de> <02ee7e47166a463d8d4e491b61cdd33f@realtek.com>
 <20231019143504.GA25140@wunner.de>
In-Reply-To: <20231019143504.GA25140@wunner.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 8 Nov 2023 12:29:34 +0200
Message-ID: <CAAd53p7jx=_Yh8sPwdsu-6Bc-hNgiExscMNGhgcbH=rzOBMOXQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe
 Link Down
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ricky WU <ricky_wu@realtek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas and Ricky,

On Thu, Oct 19, 2023 at 5:35=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Thu, Oct 19, 2023 at 01:49:50AM +0000, Ricky WU wrote:
> > [    0.267813] pci 0000:00:1c.0: [8086:a33c] type 01 class 0x060400
>
> Cannon Lake PCH Root Port
>
> > [    0.275241] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
> > [    0.275315] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
> > [    0.275782] pci 0000:01:00.0: supports D1 D2
> > [    0.275784] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
> > [    0.276490] pci 0000:00:1c.0: PCI bridge to [bus 01]
>
> Device below Root Port is initially a Realtek RTS5261 card reader.
>
> > [    0.395968] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> > [    0.396009] pcieport 0000:00:1c.0: pciehp: Slot #8 AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LL=
ActRep+
>
> Root Port is hotplug-capable.
>
> > [   43.180701] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   43.180709] pcieport 0000:00:1c.0: pciehp: Slot(8): Card not present
> > [   44.403768] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> > [   44.403772] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> > [   44.540631] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802
>
> Card reader is unplugged and replaced by SanDisk SN530 NVMe SSD.
>
> > [   51.682628] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   51.716800] nvme0n1: detected capacity change from 495050752 to 0
> > [   51.793382] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> > [   51.793392] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> > [   51.928633] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
>
> NVMe SSD replaced by the card reader again.
>
> > [   54.872928] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   56.146581] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> > [   56.146584] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> > [   56.284632] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802
>
> Card reader replaced by NVMe SSD, second time.
>
> > [   60.635845] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   60.676842] nvme0n1: detected capacity change from 495050752 to 0
> > [   60.748953] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> > [   60.748958] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> > [   60.884619] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
>
> NVMe SSD replaced by the card reader, second time.
>
> > [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   63.912118] BUG: unable to handle page fault for address: ffffb24d40=
3e5010
>
> Card reader replaced with NVMe SSD, third time.
>
> So it took three tries to reproduce the page fault.
>
> Thanks for the log, the issue is a little less murky now.
> But it's still unclear what the root cause is and thus
> what the proper solution is.  I think this needs more
> in-depth debugging, see my previous e-mail.
>
> Hope that helps!  Thanks,

I think the following approach should cover all the cases?
Ricky, can you please give it a try?

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..907d60587227 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include "pci.h"

 static void pci_free_resources(struct pci_dev *dev)
@@ -89,6 +90,8 @@ static void pci_remove_bus_device(struct pci_dev *dev)
        struct pci_bus *bus =3D dev->subordinate;
        struct pci_dev *child, *tmp;

+       pm_runtime_barrier(&dev->dev);
+
        if (bus) {
                list_for_each_entry_safe(child, tmp,
                                         &bus->devices, bus_list)


>
> Lukas
