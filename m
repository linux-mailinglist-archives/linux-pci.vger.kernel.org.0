Return-Path: <linux-pci+bounces-1486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD82B81F410
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 03:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287ED2815D4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 02:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FA10E6;
	Thu, 28 Dec 2023 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crc.id.au header.i=@crc.id.au header.b="ROBTMcwt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailfilter.crc.id.au (mailfilter.crc.id.au [202.172.99.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FB2904;
	Thu, 28 Dec 2023 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crc.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crc.id.au
Received: from mailfilter.crc.id.au (localhost.localdomain [127.0.0.1])
	by mailfilter.crc.id.au (Proxmox) with ESMTP id 73AE761488;
	Thu, 28 Dec 2023 13:03:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crc.id.au; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=default; bh=S9xGU1hFe1/o9hrCC4lEm4q+qvVZbAlcZqEbx5hf2kQ=; b=
	ROBTMcwtF2eYwwLv4NtWZMVvpJEZ4lYKaw5J5SXmiTBJPgqoKO6dZAnG29dQ4W6l
	p/Y91igHhSz5G5H0mm7RmRnC/Gpwkg6LZ1cvBibU7k/535Xb+gG8q/V9w6YBHkC0
	n2gyIzWnBhimCnmSR5LpVUWSKBz/N4GLn4Vg0rU9WleyaLnX5IG8jXXA4H7oTw2C
	b6VMGmAtIwh372TtJrKoEg/yIPBpsiOzjvPTNYc6pFJcO0Ahp2ccz/X9j1oA7rju
	v/AIPbuDqqScYcEg0zYsLVgkMtNZ7oSImTzs810YtIk8c+Q/mof4fyLjpkgqaDHC
	5DLJ2U1JXOXDg+ja4RSETE/bGudp/91c2X2avWKHzNyhVHldSlbWUFwqkThPdNkP
	3cxv2yaX8vxYnU5q6BtCEmhqPS6Tvx6ljHPItAPz5C2z79TnSX03yFys8+kvHstR
	LQ5HkGkGSc8h61brsCLupnuDEoZpoLmGWFggi0jAJIC2uSrEQKr//sihAtdwzIZa
	cMR8FKPZllPpQ0HfBVc8u1tEw+Y7lRjnF/ADZPX2T0bvnF+gFxr0/nmg0+k1G0L0
	ySGdZDuZBBVOJ6570KeE5xdjWPTOLse8RKMA0eG1GMUrxpyLUrJChUw792yeRICb
	OYxhIg0jYcQH5RlwQJ3k86GTwVlqNX+dFgNEwQetvZ8=
Message-ID: <3a7656ab-df4c-4d57-8866-661beffcddd7@crc.id.au>
Date: Thu, 28 Dec 2023 13:03:10 +1100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steven Haigh <netwiz@crc.id.au>
Subject: Qemu KVM thread spins at 100% CPU usage on scsi hot-unplug (kernel
 6.6.8 guest)
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, f.ebner@proxmox.com
Content-Language: en-AU
Autocrypt: addr=netwiz@crc.id.au; keydata=
 xjMEZYuvwhYJKwYBBAHaRw8BAQdAKpahulREd3FFQb6QJI7Oa1QG7i0y5GxpKWd/Pgz3bDHN
 H1N0ZXZlbiBIYWlnaCA8bmV0d2l6QGNyYy5pZC5hdT7CiQQTFggAMRYhBIB4i95REtt8lf8r
 5YPV5iDbUrwABQJli6/CAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQg9XmINtSvADhuAEAq5fb
 ocNh/FVsflYj8owAQlb3jez8GcMdZqBty8OAY2QBAK+xbsxaJ+KtOPFmmmzzLcf5LQFvOYZs
 o+Y3Ot5ublIIzjgEZYuvwhIKKwYBBAGXVQEFAQEHQH0ZpXIkJEoTdAhHcvEj417Bb55+wGsz
 07FgcbLaIl9AAwEIB8J4BBgWCAAgFiEEgHiL3lES23yV/yvlg9XmINtSvAAFAmWLr8ICGwwA
 CgkQg9XmINtSvABslgD8D7f1NX9bEu5mH8VF7Z58Orygx4Qc7w5qvM1qvQB8UfkBAID3m4bI
 0Y9hW5iuV4RfgH3SkrIp4diWii1facZPd4EC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I'm trying to summarise what I'm seeing - please feel free to contact me directly for any further information that I may 
have missed. I'm also not subscribed to either kernel.org mailing list, so please CC me in any replies.

History:
At some point in kernel 6.6.x, SCSI hotplug in qemu VMs broke. This was mostly fixed in the following commit to release 
6.6.8:
	commit 5cc8d88a1b94b900fd74abda744c29ff5845430b
	Author: Bjorn Helgaas <bhelgaas@google.com>
	Date:   Thu Dec 14 09:08:56 2023 -0600
	Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

After this commit, the SCSI block device is hotplugged correctly, and a device node as /dev/sdX appears within the qemu VM.

New problem:

When the same SCSI block device is hot-unplugged, the QEMU KVM process will spin at 100% CPU usage. The guest shows no 
CPU being used via top, but the host will continue to spin in the KVM thread until the VM is rebooted.

Further information:

Guest: Fedora 39 with kernel 6.6.8 packages from:
           https://koji.fedoraproject.org/koji/buildinfo?buildID=2336239

Host: Proxmox 8.1.3 with kernel 6.5.11-7-pve

Messages when a drive is hot-plugged to the guest via:
           # qm set 104 -scsi1 /dev/sde

Dec 21 19:44:02 kernel: pci 0000:09:02.0: [1af4:1004] type 00 class 0x010000
Dec 21 19:44:02 kernel: pci 0000:09:02.0: reg 0x10: [io  0x0000-0x003f]
Dec 21 19:44:02 kernel: pci 0000:09:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
Dec 21 19:44:02 kernel: pci 0000:09:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
Dec 21 19:44:02 kernel: pci 0000:09:02.0: BAR 4: assigned [mem 0xc080004000-0xc080007fff 64bit pref]
Dec 21 19:44:02 kernel: pci 0000:09:02.0: BAR 1: assigned [mem 0xc1801000-0xc1801fff]
Dec 21 19:44:02 kernel: pci 0000:09:02.0: BAR 0: assigned [io 0x6040-0x607f]
Dec 21 19:44:02 kernel: virtio-pci 0000:09:02.0: enabling device (0000 -> 0003)
Dec 21 19:44:02 kernel: scsi host7: Virtio SCSI HBA
Dec 21 19:44:02 kernel: scsi 7:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
Dec 21 19:44:02 kernel: sd 7:0:0:1: Power-on or device reset occurred
Dec 21 19:44:02 kernel: sd 7:0:0:1: Attached scsi generic sg1 type 0
Dec 21 19:44:02 kernel: sd 7:0:0:1: LUN assignments on this target have changed. The Linux SCSI layer does not 
automatically remap LUN assignments.
Dec 21 19:44:02 kernel: sd 7:0:0:1: [sdb] 3906994318 512-byte logical blocks: (2.00 TB/1.82 TiB)
Dec 21 19:44:02 kernel: sd 7:0:0:1: [sdb] Write Protect is off
Dec 21 19:44:02 kernel: sd 7:0:0:1: [sdb] Mode Sense: 63 00 00 08
Dec 21 19:44:02 kernel: sd 7:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 21 19:44:02 kernel: sd 7:0:0:1: [sdb] Attached SCSI disk

Device node is then available as /dev/sdb as expected.

Hot-unplugging the device in proxmox is done via:
	# /usr/sbin/qm set 104 --delete scsi1

where 104 is the VM ID within the proxmox host. I have been trying to trawl through the perl code for the `qm` util to 
see how that translates to a qemu command, but haven't nailed anything down yet. The code for the qm util is here:
	https://git.proxmox.com/?p=qemu-server.git;a=tree;h=refs/heads/master;hb=refs/heads/master

After the qm command is executed the device node disappears correctly from the running VM, and the VM seems to operate 
as normal. The spinning withing the KVM thread seems to only affect the host.

-- 
Steven Haigh

📧 netwiz@crc.id.au
💻 https://crc.id.au



