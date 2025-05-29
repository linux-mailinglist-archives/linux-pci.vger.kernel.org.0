Return-Path: <linux-pci+bounces-28688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF37AC8426
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 00:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B83016DC81
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 22:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B5E21D011;
	Thu, 29 May 2025 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGliEGuf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C4219303;
	Thu, 29 May 2025 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557345; cv=none; b=Ol4wBBaAUbrdjyDKpOIAXC5ZLXIkxDXQ/PcFkeDc5GoCa9vPlAofrmr1usEPn5N7/tAQE8cUKB25hfhghupu6cFUxHbP/QRR0Rw7AmwySuUA0i0Tfn6C1cy+oTebLzwczJJCH4OGUaNNl3IqUugf/ra8dJ2s0+XgCf4xA0uPA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557345; c=relaxed/simple;
	bh=qiABFbsJcWyIhPq0FNeTctPGJf0KQJvA0uRNtOQkP0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=leisMT+74XsVX40alLIXEtIhqM4l98k7aA2TfZ+ZqLStv5iMFQCDGEjQUXO5nRxvTTYdtlYNz6ZrPdHQfuR5+k4qAWnCWDyigkOlQEQCAMjLOzCBK0mMf8QBinAe9+fXaTo0F+IeHkdtLagKquuxEFOZSH1F8OX7m4jzSqZ4NRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGliEGuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85753C4CEE7;
	Thu, 29 May 2025 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748557344;
	bh=qiABFbsJcWyIhPq0FNeTctPGJf0KQJvA0uRNtOQkP0A=;
	h=Date:From:To:Cc:Subject:From;
	b=aGliEGufqyb+DIOC8pTu31skuxGM1Z9/+SBkPULyPbr7nBDcxTbfxm5e2OUf5hw8Q
	 QvfhKaZWDrf+WxR0bBbtdSw4ly+IGFJlVwH0yuuoVWkXfDfdZgWq0tglZ66zaN1TXX
	 NLLHhx4s4PPmLeWSmxMN5eeH3mtObhhx5LGnKjSysl2JX+gnwni6m7HXwkvfBLqb+9
	 nZ0FVDBfrx2BRLfPAIgpjIRalxKEdgKsh2zSfdfVpTO34nmT7w9gTdK9bn33O9NOfP
	 lc9QNYhRqvj2kWX969thEjACIxvGrrqO0l/8li70WgBdyuUXaPYaO0kICEoHBeF7gy
	 +2dY6S4VzDr0Q==
Date: Thu, 29 May 2025 17:22:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-usb@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [bugzilla-daemon@kernel.org: [Bug 220175] New: NVMe SSD doesn't work
 via Thunderbolt enclosure on Framework 13 (Ryzen AI 300)]
Message-ID: <20250529222223.GA119209@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc pciehp, thunderbolt, nvme folks;
 +bcc Andrey (reporter)]

Andrey, sorry that you tripped over this, and thank you very much for
reporting it.  I'm forwarding this to the mailing lists because most
subsystems don't really pay attention to the bugzilla.

Obviously we don't want to have to use kernel args to make things
work, and we also don't want to have to use /sys/bus/pci/rescan after
a hot-add.

IIUC, if you boot while the SSD in the enclosure is already attached
to the USB 3.2 port, everything works fine?  Could you please attach a
complete dmesg log from such a boot to the bugzilla, just as a
baseline?

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=220175

           Summary: NVMe SSD doesn't work via Thunderbolt enclosure on
                    Framework 13 (Ryzen AI 300)

Created attachment 308180
  --> https://bugzilla.kernel.org/attachment.cgi?id=308180&action=edit
lspci -vvv

I have a Samsung 970 Evo Plus SSD installed in an ACASIS TBU401E USB4
enclosure. When I connect it to the USB 3.2 port, everything is fine, the SSD
is detected by the scsi driver and shows up in the system as /dev/sdb. But when
I plug it into the USB4 port, the device doesn't show up.

However, I can connect and use this disk by using kernel args
`nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off` and
doing `echo 1 | sudo tee /sys/bus/pci/rescan` after connecting the SSD.

Solution described in https://bugzilla.kernel.org/show_bug.cgi?id=216000#c65
doesn't help and breaks most of the PCIe devices in the system.

More info:

```
$ uname -r
6.14.6-300.fc42.x86_64
$ ls /dev/nvme*    
zsh: no matches found: /dev/nvme*
$ cat /sys/bus/thunderbolt/devices/1-2/vendor_name         
ACASIS
$ cat /sys/bus/thunderbolt/devices/1-2/authorized         
1
$ inxi -MC           
Machine:
  Type: Laptop System: Framework product: Laptop 13 (AMD Ryzen AI 300 Series)
    v: A9 serial: <superuser required>
  Mobo: Framework model: FRANMGCP09 v: A9 serial: <superuser required>
    UEFI: INSYDE v: 03.03 date: 03/10/2025
CPU:
  Info: 12-core model: AMD Ryzen AI 9 HX 370 w/ Radeon 890M bits: 64
```

