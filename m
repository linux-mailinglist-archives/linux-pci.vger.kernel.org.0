Return-Path: <linux-pci+bounces-6298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AAA8A5DC0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 00:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF908282990
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19B745FD;
	Mon, 15 Apr 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ey4fZt+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD112E852
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220453; cv=none; b=AESbyiLGOUalTbC4UeM/R9n7qZTrOUfRs/3ZCCWaKjA2hJnbH66u17jV4ApHmA/eOXnOkaMBBgGy4BQxmN0k8YU7usniHrhvZLuRTQIEMw0ZroTsb+IbRQOXlDheM9qq/A3D12fH9GrhSt+XQWULX/KQod3a/rQXTnnO2XPWvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220453; c=relaxed/simple;
	bh=7acQjHE0FRAyHEHJVTS5Zrtc4ySTWdRrmVh7RnffPDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEl5mG8a9KCAYqblnPsSP4jU1ptZXj6xRu6FA5Yg3MxmhTRW+O6tgl3Qq5icwqeI+ODfVFHg/SrQRUlg9Qu/cRPG+eKH6ufCOxRgd4QKIQxOilqM3Y9+09xl6T8dTLzTJjOmJCuuVolqG2qUhGHQKOun87bkUY5+ulDAqFSXGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ey4fZt+M; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-479dc603962so1182439137.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713220451; x=1713825251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=67AIpHDTzJHchwF056bG2a4yzdGbydIfluO3yoiihTI=;
        b=Ey4fZt+M7JKFa6z6Qd9AfmoTUBBk88hfBQvsJp/u6jmMprcqrm9xoU+MdI++KxNxBn
         VnZclu1L1uBq4JKCwF6pkh3NWQIcx2yvIwLA3ba9jAnKp+2CxgnIdZk+SVXbgkBSldK/
         swth6RpVjVhiJ0chKL52BWT86c4ofy10whPjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713220451; x=1713825251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67AIpHDTzJHchwF056bG2a4yzdGbydIfluO3yoiihTI=;
        b=thFh3UrzagNxnStqCEgKTs+34mbsEsRTPZBIALk0xyAs+59s/EqrVyF6Q9aOMEbJ3w
         NVwufBAa/MR4H32tv0uNhxyd4WYEtcZwlobee44Ih8chy3Tv8DexuNoxiJObOOSOK4eP
         rnUC5DZ9sz8Gq6vMDEY7D0MlnlVec+2DL1dZDgvo/MKRKYMJn5VoC8jlc+S+gQf0joni
         DzGgNckBKHO9v9jCyMs/e4vi0DG37BFqx985IHU6uHMu3RQ0JDDYEv+/1vXzncW+Y+uc
         6lY/yPZRdF7nVqW28NQrT6Zebq/YrtQe2lZijb05hb+0eAku26aKy82pKORJIciFzNBS
         201w==
X-Forwarded-Encrypted: i=1; AJvYcCVCf0q5YvOqodSFXZgLf2i1D23kqf276/Ihte7OL6o87noih9zI8PK0o4gg0K8dh/A27i/rZ8KZ863aaSwbBsr93b2Nrpqn2RKo
X-Gm-Message-State: AOJu0YzLMXfaOyQV6CITkvlRUflbtSbmYu0KDgbnCo2E+ulL5Rsjde3m
	MC2CR8X8dPFwmrO1NuHT05khaPHr6Bs12clzbOCntxNPRiJV+kcoOSmRXVqst+xMo5XW29aS64+
	BnwOMly3MWLEBB0FDLg/mrbDFSy6dVfOLCh1g
X-Google-Smtp-Source: AGHT+IE9wMrayCQ//dB3BHrVi3zj6zncCfJH35JYbhYekkl7tuDKaZ6sfL0DUpsQ6gPR7Y83low3zp4CddX8xeGHGe0=
X-Received: by 2002:a05:6102:3c89:b0:47b:8c4b:1054 with SMTP id
 c9-20020a0561023c8900b0047b8c4b1054mr3085718vsv.3.1713220450916; Mon, 15 Apr
 2024 15:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228132517.GA12586@wunner.de> <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com> <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com> <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
In-Reply-To: <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 15 Apr 2024 18:34:00 -0400
Message-ID: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

Hey!
Asking for some help on implementation.
So I implemented most of this, and successfully tested the quirk on 6
different devices with various types of discrete fixed JHL Thunderbolt
chips.

However I want to add an additional check. A device wouldn't need this
quirk if it already has Thunderbolt functionality built in within its
Root Port.

I tried to use "is_thunderbolt" as an identifier for that type of
device--- but when I tested on a device with a thunderbolt root port,
"is_thunderbolt" was false for all the Thunderbolt PCI components
listed below.

~ # lspci -nn | grep Thunderbolt
00:07.0 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt
4 PCI Express Root Port #1 [8086:9a25] (rev 01)
00:07.2 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt
4 PCI Express Root Port #2 [8086:9a27] (rev 01)
00:0d.0 USB controller [0c03]: Intel Corporation Tiger Lake-LP
Thunderbolt 4 USB Controller [8086:9a13] (rev 01)
00:0d.2 USB controller [0c03]: Intel Corporation Tiger Lake-LP
Thunderbolt 4 NHI #0 [8086:9a1b] (rev 01)
00:0d.3 USB controller [0c03]: Intel Corporation Tiger Lake-LP
Thunderbolt 4 NHI #1 [8086:9a1d] (rev 01)

The device I tested was the Lenovo carbon X1 Gen 9. When
set_pcie_thunderbolt is run, the devices listed above return false on
the pci_find_next_ext_capability check.

I have spent some time trying to see if there are any ACPI values or
any alternative indicators to reliably know if a root port has
thunderbolt capabilities. I do see that ADBG is often set to TBT but
that looks like a debugging tool in ACPI.

I also looked through lspci -vvv and compared the output with a device
that has no Thunderbolt built into its CPU, which gave me nothing.

I also tried looking through values in /sys/bus and searching through
the kernel, looking through logs etc. The only option I see now is
figuring out how to get the string value returned by the lspci and
parsing it, but I'm not 100% sure if all Thunderbolt CPUs would have
Root ports specifically labeled as "Thunderbolt Root Port". I'm also
not sure if that value is supposed to be used in that way.

I was hoping that someone may have a suggestion here.


Just for reference, this is the fix I have so far. I don't want to
submit it as a new patch, until I resolve the above question.

+static bool get_pci_exp_upstream_port(struct pci_dev *dev,
+                                   struct pci_dev **upstream_port)
+{
+       struct pci_dev *parent = dev;
+
+       // If the dev is an upstream port, return itself
+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
+               *upstream_port = dev;
+               return true;
+       }
+
+       // Iterate through the dev's parents to find its upstream port
+       while ((parent = pci_upstream_bridge(parent))) {
+               if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+                       *upstream_port = parent;
+                       return true;
+               }
+       }
+       return false;
+}
+
+static void relabel_internal_thunderbolt_chip(struct pci_dev *dev)
+{
+       struct pci_dev *upstream_port;
+       struct pci_dev *upstream_ports_parent;
+
+       // Get the upstream port closest to the dev
+       if (!(get_pci_exp_upstream_port(dev, &upstream_port)))
+               return;
+
+       // Next, we confirm if the upstream port is directly behind a PCIe root
+       // port.
+       if (!(upstream_ports_parent == pci_upstream_bridge(upstream_port)))
+               return;
+       if (!(pci_pcie_type(upstream_ports_parent) == PCI_EXP_TYPE_ROOT_PORT))
+               return; // quirk does not apply
+
+       // If a device's root port already has thunderbolt capabilities, then
+       // it shouldn't be using this quirk.
+       // TODO: THIS CHECK DOES NOT WORK
+       // I ALSO TRIED USING pci_is_thunderbolt_attached WHICH DIDN'T
WORK EITHER
+       if (!(upstream_ports_parent->is_thunderbolt))
+               return; // thunderbolt functionality is built into root port
+
+       // Apply quirk
+       dev_set_removable(&dev->dev, DEVICE_FIXED);
+
+       // External facing bridges must be marked as such so that devices
+       // below them can correctly be labeled as REMOVABLE
+       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
+            && (dev->devfn == 0x08 | dev->devfn == 0x20))
+               dev->external_facing = true;
+}

