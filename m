Return-Path: <linux-pci+bounces-14519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3299E169
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D8EB21E72
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1F017335E;
	Tue, 15 Oct 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giDKSgSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE720EB
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981874; cv=none; b=C3GbljsktXSitIwQtiODn28PCR803q1UX+mPAPHLzqb66F+KTf+nam6UNCbuD5wvx9I95aWjx6QYVe56J2/5AbnVVCVFFKmQJVt6H3V/pmfI/7PkjjJV8eefkwzY5K+q4FsuRna9t+hObqMsh4xrQJMMhZSRyV/CTJQhgnDqnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981874; c=relaxed/simple;
	bh=j5WsRaFh897jmadK1YuA7gdX4HYeWmzFc2CXep5iFlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzBo/UWPATQQSzvxzISOS4mtndgJxe2KEImqbroaoyb6akSnWWVQZ8s0PPgNskQ77zYadKLVbUOUymsJ51GiXq7p9Nc05txzeoQwOQYIJTcEJhX2uvz4Q2Rj4C8k01ZhA/byrXy6OpQe3S5ciX4/6JliHf4tUdeTMzu1B1Ymtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giDKSgSg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2e41bd08bso52669047b3.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728981872; x=1729586672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CV/sELMrizY0LAaxVmZiIiYO2WTkFOHnkTeI6q1+hGo=;
        b=giDKSgSg/ny4k1QXLL37QKtjY9JxENs/DhWnpEFDArn7znIk9b+91fbd7aXugQczzk
         37nYzYBlF0nb4A4uWt+p2ANDqIaS/RSYjnafuw/G5B6knuuvwXB3RSsEzAa94a6yxEnV
         vDgaDwJmbYJaiv7MVvgxJys0XUP0yHQ40CQOtD8kDd3Q8TSKus1dJSPGHcCsDC3yyP5H
         2qc6WPfX3YVirxZ+8MGQCSgcHMB8MJeYQvCT671gh8bnv+sKTQKjFOGrYAC4aQeQXStH
         nIwfivQL0R3UxDCG8K7qml9eW9dhgQUwpCPni0CnOCZpgU5Dzk4jgrjhrKYM7yKBwRRG
         KBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981872; x=1729586672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CV/sELMrizY0LAaxVmZiIiYO2WTkFOHnkTeI6q1+hGo=;
        b=lrzGg29rsXUPTuvQVPNIGdY4+C48TD78W+mKIZNgiS3bdwAKcPTbldqnoFLO/znH5k
         QFi/jkrzUhwsKljNAeaIoAr/cMyptkWM1x89Yov/C6dzTPSKN3h23d9+CK/USBnBq9rf
         cAwDbWImQwIrnAEME5kZT38298+E4vlL52ib8Z9LqZJ0/u38+Hb3Yeg5HMucioz5fz4k
         2Sz9eUxfGHJgA2JwZZUT0eYQMJeFMKyBSRBXtWnXXkd5qglgt9RkHcFdWSvwP1FnJoME
         f87MzVWELVXtv7KJv5QOrzfG4KQGyd1HwdmB9o2KWNqLoyxwgbbD82hUFUe52fke0Uva
         9zjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd5n3TP47uE22jwnoIPxcxlhP+8YBSk4a9l9wfJYEySmA32YRg9KIoxRCo/MJKjgK/pt4BoQr+kDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykUWkH4W9ixgpcoLS54Fox0ptJ+l3bDI/pkXGdAjqvekYOhxcz
	dMjr713CaOae+u0jV5w8WWL71PlbTRiq22myvj255sdlqhNEvkDXwVnVpuuAuvmqfgKaSGIW6NA
	2V3Fk6yFk/BgSo8C7hT1LzFcCAy0=
X-Google-Smtp-Source: AGHT+IHp41ZUkuy8t7fW+V6Whg6mEvkLnWx7GtgpRR6diON7/DFFNPw9PcdirYwTH3qUiuNr6Bp3chZK6A07LJ5SjII=
X-Received: by 2002:a05:690c:6f88:b0:6e3:ed8:7f17 with SMTP id
 00721157ae682-6e36413ac6bmr92912517b3.16.1728981871826; Tue, 15 Oct 2024
 01:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTuhUcdBAQgKFhGP+9gMqEthA_dOE6V3RGn6HTZm7nNBYg@mail.gmail.com>
 <20241004215657.GA362992@bhelgaas> <CALfBBTtjXJiZBSfFTUAPsD+G15nPQQsn-2sCrAt1UwPsrNsqNg@mail.gmail.com>
In-Reply-To: <CALfBBTtjXJiZBSfFTUAPsD+G15nPQQsn-2sCrAt1UwPsrNsqNg@mail.gmail.com>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Tue, 15 Oct 2024 14:14:20 +0530
Message-ID: <CALfBBTtfbriqSoffdU-cV-OkMbomX_1o8hosaBvA6EJvC+paQQ@mail.gmail.com>
Subject: Re: pcie hotplug driver probe is not getting called
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org, 
	Matthew W Carlis <mattc@purestorage.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

The freeze was a platform issue, it's fixed and things are working as expected.

Using this patch from "Matthew W Carlis <mattc@purestorage.com>", will
this patch be merged in future ?

https://patchwork.ozlabs.org/project/linux-pci/patch/20231223212235.34293-2-mattc@purestorage.com/

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..8e023aa97672 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -257,12 +257,19 @@  static int get_port_device_capability(struct
pci_dev *dev)
  }

  /*
+ * _OSC AER Control is required by the OS & requires OS to control AER,
+ * but _OSC DPC Control isn't required by the OS to control DPC; however
+ * it does require the OS to control DPC. _OSC DPC Control also requres
+ * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
+ * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
+ * platform fw or OS always link control of DPC to AER.
+ *
  * With dpc-native, allow Linux to use DPC even if it doesn't have
  * permission to use AER.
  */
  if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-    pci_aer_available() &&
-    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+    pci_aer_available() && (pcie_ports_dpc_native ||
+    (dev->aer_cap && host->native_aer)))
  services |= PCIE_PORT_SERVICE_DPC;

  if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||

On Mon, 7 Oct 2024 at 22:15, Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> Very helpful!
>
> Yes, bios doesn't support hotplug or dpc.
>
> I used the patches listed in previous mail to enable both dpc & pciehp with command line Param "pcie_port=native"
>
> Hotplug works fine, but dpc trigger after hotplug causes complete freeze, I suspect platform issue, may be issue with backdoor mechanism of hotplug is causing it, will inspect and come back.
>
>
> On Sat, 5 Oct 2024, 03:27 Bjorn Helgaas, <helgaas@kernel.org> wrote:
>>
>> On Fri, Oct 04, 2024 at 11:50:28PM +0530, Maverickk 78 wrote:
>> > The platform I am working on is rtl simulation of pcie switch(Gen6)
>> > with a backdoor mechanism to trigger the HotPlug event.
>> >
>> > Tried following patches independently to have both hotplug and dpc
>> > driver register and handle respective events.
>> >
>> > https://patchwork.ozlabs.org/project/linux-pci/patch/20231223212235.34293-2-mattc@purestorage.com/
>> > https://patchwork.kernel.org/project/linux-pci/patch/20240108194642.30460-1-mattc@purestorage.com/#25680870
>> >
>> > Tried following
>> >
>> > - Trigger hot removal and add, the event is triggered and respective
>> > msi in /proc/interrupt increments and kernel logs the event(dmesg)
>> > - Trigger hot removal and add, the event is triggered and respective
>> > msi in /proc/interrupt increments and kernel logs the event(dmesg)
>> > - Trigger DPC using "DPC software trigger" in DPC control register
>> >
>> > The kernel hangs, the console is non-responsive.
>> >
>> > Can dpc and pciehp co-exist and handle the events?
>>
>> Yes, they're intended to coexist.  Your platform firmware doesn't
>> advertise support for it, though:
>>
>> [    1.736168] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR DPC]
>>
>> I don't think there's a kernel parameter to force DPC usage if the
>> platform doesn't advertise it.  There should be a message like "DPC:
>> enabled with IRQ X" if the dpc driver is active.
>>
>> Even if the dpc driver isn't active, I don't think the kernel should
>> hang if you trigger DPC.  Since this is a QEMU guest, you should be
>> able to use a debugger to figure out why it's hung.
>>
>> Bjorn

