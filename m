Return-Path: <linux-pci+bounces-3986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E545862D71
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 23:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06A8B20D6C
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182DF1B947;
	Sun, 25 Feb 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juuB+J1k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067A1804E;
	Sun, 25 Feb 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708900733; cv=none; b=FvvkqLnIE1Y/KglvHClYas//mdBOv4fkyu2lEepkTMiG/GS09IYNppPot7P8MPzVr4Yx+F+YiaU9S1okxL3QC8X4VH8PS9+V+DJ8W3loZ/UGXJeq8NiOx3KzJNbo1zjFrsQlZL196T1zlFhvH8GVF3OWe9aLqRt79H+Me+lGAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708900733; c=relaxed/simple;
	bh=PR+IZDSfqUSBCPNz19oXpW6UUoA8pXUqZs+6Ripr/Cs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F2IrYCbyLy5asp/M71XColG143e3nhe+2nrjhkZpA9/prf2+OHM5bp5Cx7jy6f4grH8glqXs6PeolbRpkoQu2ay/L8of2gZYl+W+hvaNfLovJki9gtd3trYYZOmMHGUShrI6maWH7m334fxQCIViUA9i91MY1ovfmFLS9yy2xdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juuB+J1k; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso2324872a12.2;
        Sun, 25 Feb 2024 14:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708900729; x=1709505529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PR+IZDSfqUSBCPNz19oXpW6UUoA8pXUqZs+6Ripr/Cs=;
        b=juuB+J1koZpLtIWSMtf3Fb1fkwXY4gKY+fOde8sb9AJBU+smZwSjjG7k4Au3k+36c+
         q5T+E8YP59KLzIiQE+SLsSUlwaSl82DgGcXhBydlbfLZvGD5Njyop+e3w+MDt7HKq6+M
         33y0w8DJn6glitdtjFq7a59aKJlkHWwscaCOSHiVmn/gqfqmRnV7Sn3vww2MwfEiWumq
         v2+T6Pan/ztQF6MD31sOP/T7EnpKXMKTjYLoG1Lpccqn9B5ONso3b8XwYTyB+iwTQ+id
         P/YKLSV/3+l8JVnRJ5QqFHkSXOyXXlrWGpgmvuvJtRA98tpE1vPcUf4NLGqWyE9vf8RB
         dEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708900729; x=1709505529;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PR+IZDSfqUSBCPNz19oXpW6UUoA8pXUqZs+6Ripr/Cs=;
        b=dlNV1QBxsCVvEjHfkRO228q+g1GanmR9cn5PFvR/mqp/4WGxDWwVn5x5BaB4uekdRS
         Z0JNTaRS5wH7jyi/ZCNxMAST5DvIdux38j8m3OObFbfSiMdv+oBst0PJBpAgT7l5kma8
         dsicbdRSWk+H/u+tvDxM+II4sITu9YsUZ7gfpN4O3VdnT7JQzSj/fN/qtSt2sGfedBPQ
         K8EbzZkwXkpFwb3YXbxd3byZMYKULVqiLHJrjkRZCZkoXtBbpNLVQT8RJIaMr5DmB4UK
         n5w8Zr5S1Q5/7fKH+9wOqqMnGXEyRUQuL0USHaFC2hHtm/EZFyLoJf2QSvL/b1E0JzaB
         Nz+g==
X-Forwarded-Encrypted: i=1; AJvYcCXqXof7QecsWb2A1gUUAwTRS7eXS12G09v6T/yDRKobHE8LPLZFRtHYvVS+2bplw32wOcwsUg3nXBIB9t3mqs/QwS02MobMWCcgmwUKpnclEbhehsbmP6G/XCHgfws+Gu36NQI=
X-Gm-Message-State: AOJu0YyqBiKyaKRYTMqxfDrrUWsdM0aO3HfwYKZj2q3YIGObwVcbjKX7
	jX+UPyY5iLc+EOBcFZKpcT9IGVmCbCIyKnuqP7gOp+S+vpM/M2g+MkiM816ERTkPm2o/C5GXfUG
	BGKkxo8sts0714HeHJMTN6HHbffIZDbCCDU6J5w==
X-Google-Smtp-Source: AGHT+IGDrISNhji0pKXOP9n/HtWQ96yuk9PgWz+OHA6yT3NJmqdV8axDY6WCEtuEoIeZrI/JYe7PSILy6/2P27Nh/3Q=
X-Received: by 2002:a05:6402:b2d:b0:563:e047:cb9f with SMTP id
 bo13-20020a0564020b2d00b00563e047cb9fmr3163334edb.19.1708900729128; Sun, 25
 Feb 2024 14:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mathias De Weerdt <mathias.de.weerdt@gmail.com>
Date: Sun, 25 Feb 2024 23:38:35 +0100
Message-ID: <CAKfmkPKW=cD88D-cYJUaoN0A6i91C5ukiy6AYYWpNbW8VBQaGA@mail.gmail.com>
Subject: Bug Report: Delayed Wake from Suspend with Genesys Logic GL9755 SD
 Host Controller
To: ben.chuang@genesyslogic.com.tw, johnsonm@danlj.org
Cc: linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I am writing to report a potential bug in the Linux kernel related to
waking from suspend on a system(Laptop) with a Genesys Logic GL9755 SD
Host Controller. Below are the details of the issue:


Issue Description:
After suspending the system, waking it up takes an extended amount of
time, typically 1 to 2 minutes. The delay occurs consistently and is
observed in the dmesg logs.


System Information:
- OS: Arch Linux x86_64
- Kernel: 6.7.5-arch1-1 and 6.7.6-arch1-1
- SD Host Controller: Genesys Logic GL9755 SD Host Controller (PCI ID:
17a0:9755)


Observed Logs (dmesg):
[ 642.483972] sdhci-pci 0000:2f:00.0: not ready 1023ms after resume; waiting
[ 643.537370] sdhci-pci 0000:2f:00.0: not ready 2047ms after resume; waiting
[ 645.724028] sdhci-pci 0000:2f:00.0: not ready 4095ms after resume; waiting
[ 649.990655] sdhci-pci 0000:2f:00.0: not ready 8191ms after resume; waiting
[ 658.310658] sdhci-pci 0000:2f:00.0: not ready 16383ms after resume; waiting
[ 675.590673] sdhci-pci 0000:2f:00.0: not ready 32767ms after resume; waiting
[ 709.723965] sdhci-pci 0000:2f:00.0: not ready 65535ms after resume; giving up
[ 709.724183] sdhci-pci 0000:2f:00.0: Unable to change power state
from D3cold to D0, device inaccessible
[ 709.931501] mmc0: enable PCI MSI failed, error=-22
[ 710.031516] mmc0: Reset 0x1 never completed.
[ 710.031519] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 710.031522] mmc0: sdhci: Sys addr: 0xffffffff | Version: 0x0000ffff
[ 710.031525] mmc0: sdhci: Blk size: 0x0000ffff | Blk cnt: 0x0000ffff
[ 710.031527] mmc0: sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
[ 710.031529] mmc0: sdhci: Present: 0xffffffff | Host ctl: 0x000000ff
[ 710.031532] mmc0: sdhci: Power: 0x000000ff | Blk gap: 0x000000ff
[ 710.031534] mmc0: sdhci: Wake-up: 0x000000ff | Clock: 0x0000ffff
[ 710.031536] mmc0: sdhci: Timeout: 0x000000ff | Int stat: 0xffffffff
[ 710.031539] mmc0: sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
[ 710.031541] mmc0: sdhci: ACmd stat: 0x0000ffff | Slot int: 0x0000ffff
[ 710.031543] mmc0: sdhci: Caps: 0xffffffff | Caps_1: 0xffffffff
[ 710.031545] mmc0: sdhci: Cmd: 0x0000ffff | Max curr: 0xffffffff
[ 710.031547] mmc0: sdhci: Resp[0]: 0xffffffff | Resp[1]: 0xffffffff
[ 710.031549] mmc0: sdhci: Resp[2]: 0xffffffff | Resp[3]: 0xffffffff
[ 710.031551] mmc0: sdhci: Host ctl2: 0x0000ffff
[ 710.031554] mmc0: sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffffffffffff
[ 710.031555] mmc0: sdhci: ============================================
[ 710.031558] sdhci-pci 0000:2f:00.0: PM: dpm_run_callback():
pci_pm_resume+0x0/0xf0 returns -22
[ 710.031567] sdhci-pci 0000:2f:00.0: PM: failed to resume async: error -22
...
[ 710.823719] random: crng reseeded on system resumption
[ 710.829332] mmc0: 3.3V regulator output did not become stable
[ 710.860354] PM: suspend exit
[ 710.974677] mmc0: Controller never released inhibit bit(s).
[ 710.974690] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 710.974698] mmc0: sdhci: Sys addr: 0xffffffff | Version: 0x0000ffff
[ 710.974709] mmc0: sdhci: Blk size: 0x0000ffff | Blk cnt: 0x0000ffff
[ 710.974712] mmc0: sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
[ 710.974715] mmc0: sdhci: Present: 0xffffffff | Host ctl: 0x000000ff
[ 710.974717] mmc0: sdhci: Power: 0x000000ff | Blk gap: 0x000000ff
[ 710.974720] mmc0: sdhci: Wake-up: 0x000000ff | Clock: 0x0000ffff
[ 710.974723] mmc0: sdhci: Timeout: 0x000000ff | Int stat: 0xffffffff
[ 710.974725] mmc0: sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
[ 710.974728] mmc0: sdhci: ACmd stat: 0x0000ffff | Slot int: 0x0000ffff
[ 710.974731] mmc0: sdhci: Caps: 0xffffffff | Caps_1: 0xffffffff
[ 710.974733] mmc0: sdhci: Cmd: 0x0000ffff | Max curr: 0xffffffff
[ 710.974736] mmc0: sdhci: Resp[0]: 0xffffffff | Resp[1]: 0xffffffff
[ 710.974738] mmc0: sdhci: Resp[2]: 0xffffffff | Resp[3]: 0xffffffff
[ 710.974740] mmc0: sdhci: Host ctl2: 0x0000ffff
[ 710.974743] mmc0: sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffffffffffff
[ 710.974744] mmc0: sdhci: ============================================
[ 711.074847] mmc0: Reset 0x2 never completed.
...


Additional Information:
- The delay persists even after attempting to blacklist the driver
(sdhci_pci). Using modprobe or kernel parameters.
- Secure boot and fast boot are disabled.
- There are no additional sleep state or configuration options in the BIOS.
- Output of `cat /sys/power/mem_sleep`: [s2idle] deep


Hardware Details:
2f:00.0 SD Host controller [0805]: Genesys Logic, Inc GL9755 SD Host
Controller [17a0:9755] (rev 01)
Subsystem: ASUSTeK Computer Inc. GL9755 SD Host Controller [1043:202f]
Kernel driver in use: sdhci-pci
Kernel modules: sdhci_pci


Please let me know if there is any additional information needed from
my side to diagnose or resolve this issue. I am willing to provide any
log files or assist in testing patches.

Thank you for your attention to this matter.


Sincerely,
Mathias

