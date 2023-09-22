Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5727AA77E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 06:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjIVEI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 00:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVEI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 00:08:27 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F9F1;
        Thu, 21 Sep 2023 21:08:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59e77e4f707so20471117b3.0;
        Thu, 21 Sep 2023 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695355701; x=1695960501; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pS0vFjLEeynWuo5eyZ4Lt8qmI3NL/UzOQsJs0PGGLxA=;
        b=IEjCPe5Mgh4mIxvJVE8+v+eAfda7ng13CWoqrjOsRJBuaeX3K4DTqUcVOnRSifEVK2
         GVwUuO+zq3Idg+Ea8q/XAUMd9W8BeCjWdpsz2orCWLkiBtZavfHf9LTiSxg52dpZVqn8
         ECtle4SZT2G70DCWez77wpx66xD2eQ+C4APle/9huIe6DNN8N9vViwxN2UPBqesm6TyT
         6RkJcxocFVFp4sGl8MMpLNiB9EywTD+7bZ73LRan87i38XL348y2TXnPCb57lXEyRIQ/
         HcYV0zUKvSYcad3HUomD6Q4FH1rT5PbbNWa0PDJbBcLwDt+ATXIPFhHHXxmRwY0JJnGH
         nwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695355701; x=1695960501;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pS0vFjLEeynWuo5eyZ4Lt8qmI3NL/UzOQsJs0PGGLxA=;
        b=aY8gzGPzX+fVsqaWVz2fj2NSLPlYvxSR937PRt4mS2SC3zV7dzlbpwFl46YMwFys4L
         ngd0Ck9TlBjOnjxunAbB+Xn6gljtytCJopFV+yVLbP3Ln2/Hkn3dTMnagCovq0QaLt5/
         poaMdKdsfN0xEyzexo4jRZwh6rJwS26XrQRzrJfK5Bebqf6uVVTBusxsFXMQ1VDPuR/v
         jZCUdzvpsFlEosGOH4PQ5ujnG6IsgjVMC0lGz6XrfOW9QJ6zhmkS3MF1hn5wQ/e4FPqR
         HnLefweOjkcr/2PlWB+rA4DBI3f1LKslazIcFgS/1+5lgvsZwC8Cclf7kHARgRirC2rr
         n6qw==
X-Gm-Message-State: AOJu0YzwRr7Q6IST06j3WAPIza1cLQp7ZMgjIEehGncKGr/MnIaJR+IQ
        zn8/5uC3ruRWdiub+B4bQmwxQxIVKEgp64RRSTgjKHsK60o=
X-Google-Smtp-Source: AGHT+IGcGFK3u+XlwUkOXMhFa2xfKD0T5AOAyPtA1kKDncrTwc4zcxQ+bVpMITzb9cwx2hVc4uTerBGLOZNZQY69yAA=
X-Received: by 2002:a81:4f85:0:b0:589:e7ab:d4e5 with SMTP id
 d127-20020a814f85000000b00589e7abd4e5mr7459187ywb.0.1695355700724; Thu, 21
 Sep 2023 21:08:20 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Fri, 22 Sep 2023 12:08:09 +0800
Message-ID: <CAGnHSE=KP8rArKmNbgo3iG489PXrwjqWXLTmUp+nCOPd4VVRhA@mail.gmail.com>
Subject: [BUG?] Weird battery detection issue triggered by extra PCIe slot/port
To:     rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

So I have a laptop with two M.2 slot / PCIe port:

00:06.0 PCI bridge: Intel Corporation 12th Gen Core Processor PCI
Express x4 Controller #0 (rev 04)
00:1d.0 PCI bridge: Intel Corporation Device 51b0 (rev 01)

Apparently 00:06.0 is wired to the CPU directly and the 00:1d.0 is
weird to the PCH. Both of them can be disabled independently in UEFI
settings, and both have an NVMe drive installed.

Currently only the drive on the "CPU slot" is used, with both Windows
and Linux installed. The other drive has been wiped and remains unused
for now due to the issue I'm reporting here.

The problem I am having is that for some reason, when the "PCH slot"
is enabled, Linux has estimatedly only < 50% chance to detect the
battery. If it has failed to do so, seemingly I have to "cold reboot"
(I mean like, shutdown normally and power on again, but not just
reboot or S3 suspend) to get it back, in which case the successful
rate is the same.

I track it down to have the following sysfs findings:

[tom@corebook ~]$ ls -Al '/sys/devices/pci0000:00/0000:00:1f.0/PNP0C09:00/'
total 0
-rw-r--r-- 1 root root 4096 Sep 17 11:01 driver_override
lrwxrwxrwx 1 root root    0 Sep 17 11:01 firmware_node ->
../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0b/PNP0C09:00
drwxr-xr-x 3 root root    0 Sep 17 11:01 INT33D3:00
drwxr-xr-x 3 root root    0 Sep 17 11:01 INT33D4:00
drwxr-xr-x 3 root root    0 Sep 17 11:01 INTC1046:01
drwxr-xr-x 3 root root    0 Sep 17 11:01 INTC1046:02
drwxr-xr-x 3 root root    0 Sep 17 11:01 INTC1046:03
drwxr-xr-x 3 root root    0 Sep 17 11:01 INTC1048:00
-r--r--r-- 1 root root 4096 Sep 17 11:01 modalias
drwxr-xr-x 3 root root    0 Sep 17 11:01 PNP0C0D:00
drwxr-xr-x 2 root root    0 Sep 17 11:01 power
lrwxrwxrwx 1 root root    0 Sep 17 11:01 subsystem -> ../../../../bus/platform
-rw-r--r-- 1 root root 4096 Sep 17 11:01 uevent
-r--r--r-- 1 root root 4096 Sep 17 11:01 waiting_for_supplier
[tom@corebook ~]$ ls -Al
'/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0b/PNP0C09:00/PNP0C0A:00/'
total 0
-r--r--r-- 1 root root 4096 Sep 17 11:02 hid
-r--r--r-- 1 root root 4096 Sep 17 11:02 modalias
-r--r--r-- 1 root root 4096 Sep 17 11:02 path
drwxr-xr-x 2 root root    0 Sep 17 11:02 power
-r--r--r-- 1 root root 4096 Sep 17 11:02 status
lrwxrwxrwx 1 root root    0 Sep 17 11:01 subsystem ->
../../../../../../../bus/acpi
-rw-r--r-- 1 root root 4096 Sep 17 11:01 uevent
-r--r--r-- 1 root root 4096 Sep 17 11:02 uid

whereas if the "PCH slot" is disabled, or if it succeeded in the
"detection trial":

[tom@corebook ~]$ ls -Al '/sys/devices/pci0000:00/0000:00:1f.0/PNP0C09:00/'
total 0
-rw-r--r-- 1 root root 4096 Sep 17 11:56 driver_override
lrwxrwxrwx 1 root root    0 Sep 17 11:56 firmware_node ->
../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0b/PNP0C09:00
drwxr-xr-x 3 root root    0 Sep 17 11:53 INT33D3:00
drwxr-xr-x 3 root root    0 Sep 17 11:53 INT33D4:00
drwxr-xr-x 3 root root    0 Sep 17 11:53 INTC1046:01
drwxr-xr-x 3 root root    0 Sep 17 11:53 INTC1046:02
drwxr-xr-x 3 root root    0 Sep 17 11:53 INTC1046:03
drwxr-xr-x 3 root root    0 Sep 17 11:53 INTC1048:00
-r--r--r-- 1 root root 4096 Sep 17 11:56 modalias
drwxr-xr-x 3 root root    0 Sep 17 11:53 PNP0C0A:00
drwxr-xr-x 3 root root    0 Sep 17 11:53 PNP0C0D:00
drwxr-xr-x 2 root root    0 Sep 17 11:56 power
lrwxrwxrwx 1 root root    0 Sep 17 11:53 subsystem -> ../../../../bus/platform
-rw-r--r-- 1 root root 4096 Sep 17 11:53 uevent
-r--r--r-- 1 root root 4096 Sep 17 11:56 waiting_for_supplier
[tom@corebook ~]$ ls -Al
'/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0b/PNP0C09:00/PNP0C0A:00/'
total 0
lrwxrwxrwx 1 root root    0 Sep 17 11:53 driver ->
../../../../../../../bus/acpi/drivers/battery
-r--r--r-- 1 root root 4096 Sep 17 11:56 hid
-r--r--r-- 1 root root 4096 Sep 17 11:56 modalias
-r--r--r-- 1 root root 4096 Sep 17 11:56 path
lrwxrwxrwx 1 root root    0 Sep 17 11:56 physical_node ->
../../../../../../pci0000:00/0000:00:1f.0/PNP0C09:00/PNP0C0A:00
drwxr-xr-x 2 root root    0 Sep 17 11:56 power
drwxr-xr-x 3 root root    0 Sep 17 11:53 power_supply
-r--r--r-- 1 root root 4096 Sep 17 11:56 status
lrwxrwxrwx 1 root root    0 Sep 17 11:53 subsystem ->
../../../../../../../bus/acpi
-rw-r--r-- 1 root root 4096 Sep 17 11:53 uevent
-r--r--r-- 1 root root 4096 Sep 17 11:56 uid
drwxr-xr-x 3 root root    0 Sep 17 11:53 wakeup

As you can see, the "physical node" `PNP0C0A:00` is gone in the
failing case and the "firmware node" of it hence has nothing to
"attach"(?) to, so the battery driver will therefore see nothing. (The
parent device `PNP0C09:00` is managed by the driver `ec`, for the
record.)

I don't know if this issue is caused by a certain bug or flaw in the
UEFI/EC firmware, but the problem does not seem to occur in Windows.
Either way, I'm writing to see if I can get any insight from you guys
on what might be the potential reason/rationale here. (Note that as
mentioned, it does not always occur in Linux either, so it looks like
some kind of "mapping race"(?) to me.)

P.S. While there are some ACPI errors (as it does for most laptops
these days), I don't see any potentially relevant difference in the
kernel log between the successful and failing cases. The only
difference is that in the successful case, there's the extra expected
line of "battery detected". Anyway, I'm adding the warnings/errors in
the kernel log that might be remotely relevant, but please do note
that I see them all in both cases:

ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.I2C0.TPD0],
AE_NOT_FOUND (20230331/dswload2-162)
ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230331/psobject-220)
pnp 00:02: disabling [mem 0xc0000000-0xcfffffff] because it overlaps
0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
hpet_acpi_add: no address or irqs in _CRS
i8042: PNP: PS/2 appears to have AUX port disabled, if this is
incorrect please boot with i8042.nopnp
ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20230331/psargs-330)
ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
previous error (AE_NOT_FOUND) (20230331/psparse-529)
ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20230331/psargs-330)
ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
previous error (AE_NOT_FOUND) (20230331/psparse-529)
intel-hid INTC1070:00: failed to enable HID power button
resource: resource sanity check: requesting [mem
0x00000000fedc0000-0x00000000fedcffff], which spans more than pnp
00:02 [mem 0xfedc0000-0xfedc7fff]
caller igen6_probe+0x1a0/0x8d0 [igen6_edac] mapping multiple BARs
i2c i2c-11: Systems with more than 4 memory slots not supported yet,
not instantiating SPD

Regards,
Tom
