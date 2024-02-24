Return-Path: <linux-pci+bounces-3978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A243B8627B4
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 22:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586EB2823A7
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E04644F;
	Sat, 24 Feb 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJbschzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732C4DA0B;
	Sat, 24 Feb 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808742; cv=none; b=pzl2ID1YNrttAqggPyTQpuJnT0fWNQSzwiG5G5aeTqAKA0K6WM4w5Hljby8A8IDV2lmkX/mCM+J6ETOxrrgUTRBWv4HnYqJhfo2RXIgwd9KIjXYOYlM8aSdoEr2btZIVZSDBjTwAlMf7vVT7B6cTLCTOqrqhx09voE1E82NQqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808742; c=relaxed/simple;
	bh=9LCiheedWWR/YrZmxsHYpRF2N9EM/Lfc8NTWBOerl1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfUEun4nWdU8ABdOqbqJ+YkCBED0Wpz422HyjL+y5nYwe7ISQxZX3VVswcBwDPZvaCBZF99Isp4aE2PkRmWJ64dj8alUcqqnUgX6LnEQTTI3h+dkosifniwGGE9dHZx9q/DWroTgAXy3OV8g4MBxPs9ztCHWGeN5hEhrK5DO4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJbschzy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3eafbcb1c5so238674866b.0;
        Sat, 24 Feb 2024 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708808738; x=1709413538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l//QcA4/Hl0mQh6VsI3xUgmxdkJcRt/SG6HC7Yfb1W0=;
        b=FJbschzy1+2/efeyTiSThjsofVKFSDxamR5TJJjhMLx0F3wuFzP8qr0u979LTyaMdX
         YD9tNQl3/XLNEq/4lyoFO+jvD5J1TKDkxr7J7kS4N1vR9ZPY3k5BC36STuEC4+FvGBK3
         XweF/v8DRaDeFc/EKsSttJEzVFR6xzZa7AvKDUZGDytPK9yelDfdCDlYfYSj5RdPFybk
         +UWBfri9edfoFbLRhpDlKHkam5J3RAO2emnqmmB5XxeDfi2ZiSHqyg5aiBbRlBcoyfMD
         sk5g9zr/5TrzpgWdQVPn/b4XXy+lrViWR1uVuTd8bRfLNYtU+MYIjHuc2vwP+pNTjePV
         F9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808738; x=1709413538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l//QcA4/Hl0mQh6VsI3xUgmxdkJcRt/SG6HC7Yfb1W0=;
        b=eRDvw2JenqlB/Y4Wgu0fgsT2bfy6St9a4nuSeCSsIMG50cSsVmv9GMEjEIaI8II8Ry
         BbdG2r8fNPqigKNvuy7re6Gss9xv/fTWk1jZ/nTY58POag1DIIpF3O1s+9i87s4HGpn3
         XorLg0lFdJ1kCumPwle8nE17iT+tXLfoZLevY4b/xWQQCgAKgcc8wKJaKqkt0blazP02
         b93LJPZvkY9us6ZzPs9zzJFcb8bxy8iZZ0Ns+AZv2bfyRYeQSioVIND85J3fR0VFtDUy
         /lANsd8Q33WYBsJweWYo4dfmx//HNMPHAwlb1+UtKPDcpDnDpbZyFmCTONlVKzdBd4sE
         S2qg==
X-Forwarded-Encrypted: i=1; AJvYcCWcEBNjBfrAXlAgeqo7YlUTAZ3t4OibicH9MYblIC5av12bel13UAKti88CtPtlBmMVr6JJ2bYXm8plRtjQlFS/On9tjY9In0Lr3qEjQLWD+MbhGe4isY3n8WXYWKa1FqI/ddAnIOiOrUdhiMjwUGM5KHBME4OA/P+GVLRUOPJDYTStocFPlZCBjsJimbBp2XFw7qhI3T4hxATweTjdN54=
X-Gm-Message-State: AOJu0YxEYZC37OTqOHaXWwBgELDs89pNqZNlzi9ce9a2h612q/C2e1zu
	EnxCVJgPkRCt49wV8FcJQArgFzxZsl6Fr3ymEU5R2RbLvmWuV/9j
X-Google-Smtp-Source: AGHT+IGbM8iA91H0OVE7mp/Z+OyMxENH/PEtHl3VrZVtzQccENTuw/NxQp9hNv7YRmC0mf4IL0/XBQ==
X-Received: by 2002:a17:907:37b:b0:a40:6e1:7f98 with SMTP id rs27-20020a170907037b00b00a4006e17f98mr1979398ejb.29.1708808737769;
        Sat, 24 Feb 2024 13:05:37 -0800 (PST)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0:2bc0:19d3:9979:8e10])
        by smtp.googlemail.com with ESMTPSA id c22-20020a170906171600b00a3e4efbfdacsm891148eje.225.2024.02.24.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:05:37 -0800 (PST)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/3] Documentation: PCI: Add documentation for the PCI Block Passthrough
Date: Sat, 24 Feb 2024 22:04:02 +0100
Message-Id: <20240224210409.112333-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224210409.112333-1-wafgo01@gmail.com>
References: <20240224210409.112333-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the PCI Block Passthrough function device. The endpoint function
driver and the host PCI driver should be configured based on this documentation.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../function/binding/pci-block-passthru.rst   |  24 ++
 Documentation/PCI/endpoint/index.rst          |   3 +
 .../pci-endpoint-block-passthru-function.rst  | 331 ++++++++++++++++++
 .../pci-endpoint-block-passthru-howto.rst     | 158 +++++++++
 MAINTAINERS                                   |   8 +
 5 files changed, 524 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst

diff --git a/Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst b/Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
new file mode 100644
index 000000000000..60820edce594
--- /dev/null
+++ b/Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+PCI Test Endpoint Function
+==========================
+
+name: Should be "pci_epf_blockpt" to bind to the pci_epf_blockpt driver.
+
+Configurable Fields:
+
+================   ===========================================================
+vendorid	   should be 0x0000
+deviceid	   should be 0xc402 for S32CC
+revid		   don't care
+progif_code	   don't care
+subclass_code	   don't care
+baseclass_code	   should be 0xff
+cache_line_size	   don't care
+subsys_vendor_id   don't care
+subsys_id	   don't care
+interrupt_pin	   don't care
+msi_interrupts	   don't care
+msix_interrupts	   don't care
+================   ===========================================================
diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 4d2333e7ae06..2e4e5ac114df 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,9 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-endpoint-block-passthru-function
+   pci-endpoint-block-passthru-howto
 
    function/binding/pci-test
    function/binding/pci-ntb
+   function/binding/pci-block-passthru
diff --git a/Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst b/Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
new file mode 100644
index 000000000000..dc78d32d8cc2
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
@@ -0,0 +1,331 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+PCI Block Device Passthrough Function
+=====================================
+
+:Author: Wadim Mueller <wafgo01@gmail.com>
+
+PCI Block Device Passthrough allows one Linux Device to expose its Block devices to the PCI(e) host. The device can export either the full disk or just certain partitions. Also an export in readonly mode is possible.
+
+This feature is useful if you have a direct connection between two PCI capable SoC's, one running as Root Complex and the other in Endpoint mode, and you want to provide the RC device access to some (or all) Block devices attached to the SoC running is EP mode. This is to a certain extent a similar functionality which NBD exposes over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framework.
+
+The below diagram shows a possible setup with two SoCs, SoC1 working in RC mode, SoC2 in EP mode.
+SoC2 can now export the NVMe, eMMC and the SD Card attached to it (full Disks or some Partitions). For this
+the *pci-epf-block-passthru* driver (located at **drivers/pci/endpoint/functions/pci-epf-block-passthru.c**)
+must be loaded on SoC2. SoC1 requires the PCI Driver *pci-remote-disk* (located at **drivers/block/pci-remote-disk.c**)
+
+After both drivers are loaded SoC2 can configure which devices it wants to expose using ConfigFS.
+SoC1 can afterwards configure (also utilizing ConfigFS) on his side which exported devices it wants attach to.
+After attaching to it, the device will register a disk on SoC1 which can be accessed as a local disk.
+
+
+.. code-block:: text
+
+
+                                                           +-------------+
+                                                           |             |
+                                                           |   SD Card   |
+                                                           |             |
+                                                           +------^------+
+                                                                  |
+                                                                  |
+    +--------------------------+                +-----------------v----------------+
+    |                          |      PCI(e)    |                                  |
+    |         SoC1 (RC)        |<-------------->|            SoC2 (EP)             |
+    | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)|
+    |                          |                |                                  |
+    +--------------------------+                +-----------------^----------------+
+                                                                  |
+                                                                  |
+                                                           +------v------+
+                                                           |             |
+                                                           |    NVMe     |
+                                                           |             |
+                                                           +-------------+
+
+.. _register description:
+Registers
+---------
+
+The PCI Block Device Passthrough has the following registers:
+
+1) PCI_BLOCKPT_MAGIC               (offset 0x00)
+2) PCI_BLOCKPT_COMMAND             (offset 0x04)
+3) PCI_BLOCKPT_STATUS              (offset 0x08)
+4) PCI_BLOCKPT_QUEUE_BAR_OFFSET    (offset 0x0C)
+5) PCI_BLOCKPT_DRV_OFFSET          (offset 0x10)
+6) PCI_BLOCKPT_DEV_OFFSET          (offset 0x14)
+7) PCI_BLOCKPT_NUM_DESC            (offset 0x18)
+8) PCI_BLOCKPT_MAX_DEVS            (offset 0x1C)
+9) PCI_BLOCKPT_IRQ                 (offset 0x20)
+10) PCI_BLOCKPT_QSIZE              (offset 0x24)
+11) PCI_BLOCKPT_NUM_QUEUES         (offset 0x28)
+12) PCI_BLOCKPT_QUEUE_OFFSET       (offset 0x2C)
+13) PCI_BLOCKPT_AVAIL_QUEUE_SIZE   (offset 0x30)
+14) PCI_BLOCKPT_DEV_IDX            (offset 0x34)
+15) PCI_BLOCKPT_PERM               (offset 0x35)
+16) PCI_BLOCKPT_QUEUE_IDX          (offset 0x36)
+17) PCI_BLOCKPT_NUM_SECTORS        (offset 0x38)
+18) PCI_BLOCKPT_DEV_NAME           (offset 0x40)
+
+Registers Description
+---------------------
+
+* **PCI_BLOCKPT_MAGIC**
+
+This register is used to identify itself at the Host Driver as a BlockPT device. This 32-bit register must contain the value 0x636f6e74. Any other value will be rejected by the host driver. This Register
+is used to autodetect at which BAR the Registers are mapped by examining this Magic Register.
+
+* **PCI_BLOCKPT_COMMAND**
+
+This register will be used by the host driver to setup the EP device to export the desired block device. Any operation the Host will do in the ConfigFS will be translated to corresponding command values in this register.
+
+.. _command bitfield description:
+
+========        ================================================================
+Bitfield        Description
+========        ================================================================
+Bit 0           unused
+Bit 1           unused
+Bit 2           unused
+Bit 3           unused
+Bit 4           unused
+Bit 5           unused
+Bit 6           **SET_QUEUE**: This tells the Endpoint at which bus address the Queue
+                is in the BAR. This information is used by the EP to find the corresponding
+                Descriptor Queue for the device. The PCI_BLOCKPT_QUEUE_IDX register from `register description`_ identifies the Queue ID this command refers to, PCI_BLOCKPT_QSIZE identifies the BAR size to reserve for this queue and PCI_BLOCKPT_DEV_IDX the device id of this queue.
+Bit 7           **GET_DEVICES**: Through this command bit the host requests from the
+                EP all the available devices the EP Device want to export.
+                answer to this request is placed into Register PCI_BLOCKPT_DEV_NAME
+                where all exported devices are placed in a ';' separated list
+                of device names
+Bit 8           **START**: After configuring the corresponding device, this command
+                is used by the driver to attach to the device. On EP side worker
+                threads are generated to process the descriptors from the host
+                side
+Bit 9		**NUM_SECTORS**: Get number of sectors. The host issues this command to get the
+                size of the block device in number of 512 Byte sectors
+Bit 10          **STOP**: Send to detach from the block device. On reception all
+                worker threads are terminated.
+
+Bit 11          **SET_IRQ**: Sets the IRQ id for the device and Queue (identified by PCI_BLOCKPT_QUEUE_IDX and PCI_BLOCKPT_DEV_IDX from `register description`_)
+Bit 12          **GET_PERMISSION**: Gets the permission for the device, whether Readonly or Read-Write		
+========        ================================================================
+
+
+* **PCI_BLOCKPT_STATUS**
+
+This register reflects the status of the PCI Block Passthrough device.
+
+========       ==============================
+Bitfield       Description
+========       ==============================
+Bit 0          success
+Bit 1          unused
+Bit 2          unused
+Bit 3          unused
+Bit 4          unused
+Bit 5          unused
+Bit 6          unused
+Bit 7          unused
+Bit 8          error
+========       ==============================
+
+* **PCI_BLOCKPT_QUEUE_BAR_OFFSET**
+
+The EP sets this value to the offset from the BAR of the Device where the Descriptor Queues are located (identified by PCI_BLOCKPT_DEV_IDX from `register description`_).
+This Register is WO by EP and RO by RC.
+
+* **PCI_BLOCKPT_DRV_OFFSET**
+
+The descriptor queue which is located in the EP BAR memory region has
+the layout as described in `descriptor queue layout`_ . The Entry in this register contains the **Driver Offset**
+value from this diagram.
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_DRV_OFFSET**
+
+The descriptor queue which is located in the EP BAR memory region has
+the layout as described in `descriptor queue layout`_ . The Entry in this register contains the **Device Offset**
+value from this diagram.
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_NUM_DESC**
+
+This register contains the number of Descriptors in the Descriptor Queue. The minimum number which must be provided
+by the host is 16. Anything below will be rejected by the device
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_MAX_DEVS**
+
+This Register contains the maximum number of devices which can be exported by the EP. This Register is WO by EP and RO from RC.
+
+* **PCI_BLOCKPT_IRQ**
+
+This is the Device and Queue specific MSIX IRQ which will be raised/sent when a descriptor has been processed.
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_QSIZE**
+
+This Register contains the Queue Size in Bytes for the Device and Queue.
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_NUM_QUEUES**
+
+This Register contains the maximum number of Queues the Device supports.
+This Register is WO by EP and RO by RC.
+
+* **PCI_BLOCKPT_QUEUE_OFFSET**
+
+When the BPT_COMMAND_SET_QUEUE command is send, this register contains the Queue Offset of the corresponding queue (identified by PCI_BLOCKPT_QUEUE_IDX from `register description`_)
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_AVAIL_QUEUE_SIZE**
+
+The EP tells the RC with this Register about the amount of free space in the BAR for the descriptors.
+This Register is WO by EP and RO by RC.
+
+.. _blockpt_selector_idx:
+
+* **PCI_BLOCKPT_DEV_IDX**
+
+This register selects which device from the provided list which was requested with a command from `command bitfield description`_ 
+this request for. E.g. if you want to set the queue of the device /dev/mmcblk0 and the list which was delivered with
+from the command GET_DEVICES from `command bitfield description`_ is the following "/dev/nvme0n1p1;/dev/mmcblk0", than you
+set this register to 1 when issues the SET_QUEUE command. If you configure /dev/nvme0n1p1 than this register should be 0.
+This Register is RO by EP and WO by RC.
+
+.. _blockpt_queue_selector_idx:
+* **PCI_BLOCKPT_QUEUE_IDX**
+This register selects which queue from the device specified with PCI_BLOCKPT_DEV_IDX is requested with a command from `command bitfield description`_. This value is limited by PCI_BLOCKPT_NUM_QUEUES.
+This Register is RO by EP and WO by RC.
+
+* **PCI_BLOCKPT_NUM_SECTORS**
+
+The device puts the number of 512 Byte sectors of the device selected with blockpt_selector_idx_ if the command NUM_SECTORS from
+`command bitfield description`_ is send from the host.
+
+* **PCI_BLOCKPT_PERMISSION**
+
+This Register contains the Permission of this device. If the device can only be used in Read-Only mode the first bit is set, otherwise Read-Write mode is possible
+
+* **PCI_BLOCKPT_DEV_NAME**
+
+The device puts the names of all devices it wants to export into this register when it receives the GET_DEVICES command from `command bitfield description`_.
+This field is currently limited to (64 * 16 + 1) bytes.
+
+
+Data Transfer
+-------------
+
+The Data Transfer from the EP to the Host is using a fixed sized Descriptor Queue. This approach is inspired by the VirtIO Specification.
+
+A Descriptor Queue is part of the EP BAR memory region. The Descriptor Queue has a Layout as depicted in `descriptor queue layout`_.
+When the host wants to access data from the EP Disk, it first looks for a free descriptor in the Descriptor Ring. When one is found it
+sets up the Fields in this descriptor as shown in `descriptor layout`_, with the following description:
+
+ * **s_sector** containing the start sector from which the host wants to read from or write to
+ * **len** containing the number of bytes it wants to transfer
+ * **addr** field containing the bus address it wants the data transferred to or from (if you have an IOMMU on your SoC1 than this will be an IOVA, without an IOMMU it will usually be a PA).
+ * **opf** field tells about the operation (READ or WRITE),
+ * **status** field is written to by the EP to tell whether the transfer was successful or not.
+
+After those field are filled in by the Host driver it puts this descriptor index into the driver ring with the layout shown in `driver entry layout`_, and increments
+the **idx** field (using modulo NUM_DESCRIPTORS to implement the ring buffer functionality). When the EP detects that the **idx** field in the driver entry has changed
+it will pick up this descriptor, setup a Block-IO Request and submit it to the Block-IO layer. After the Block-IO layer has processed this request the Descriptor index will be transferred into
+the **Device Ring** as depicted in `device entry layout`_ and the **idx** field incremented there, additionally an MSIX IRQ is raised to the Host.  From there, the Host driver will know that the Request has been finished and will
+deliver it to whoever did the request on the Host side before it will free this descriptor for new transfers.
+
+
+
+
+.. _descriptor layout:
+
+Descriptor Layout
+-----------------------
+.. code-block:: text
+
+                                +--------------------------+
+                                |         s_sector         |
+                                |                          |
+                                +--------------------------+
+                                |           addr           |
+                                |                          |
+                                +--------------------------+
+                                |           len            |
+                                +--------------------------+
+                                | opf | stat | flags | res |
+                                +--------------------------+
+
+
+.. _driver entry layout:
+
+Driver Entry Layout
+-----------------------
+.. code-block:: text
+
+                                +------------------------+
+                                |          idx           |----+
+                                +------------------------+    |
+                                |     descriptor idx 0   |    |
+                                +------------------------+    |
+                                |     descriptor idx 1   |    |         +----------------+
+                                +------------------------+    |         |  Descriptor x  | 
+                                |            :           |    |         +----------------+ 
+                                +------------------------+<---+         | Descriptor x+1 | 
+                                |            :           |------------->+----------------+ 
+                                +------------------------+              | Descriptor x+2 | 
+                                |descriptor idx NUM_DESC |              +----------------+
+                                +------------------------+
+
+
+.. _device entry layout:
+
+Device Entry Layout
+-----------------------
+.. code-block:: text
+
+                                +------------------------+
+                                |          idx           |----+
+                                +------------------------+    |
+                                |     descriptor idx 0   |    |
+                                +------------------------+    |
+                                |     descriptor idx 1   |    |         +----------------+
+                                +------------------------+    |         |  Descriptor x  | 
+                                |            :           |    |         +----------------+ 
+                                +------------------------+<---+         | Descriptor x+1 | 
+                                |            :           |------------->+----------------+ 
+                                +------------------------+              | Descriptor x+2 | 
+                                |descriptor idx NUM_DESC |              +----------------+
+                                +------------------------+
+
+.. _descriptor queue layout:
+
+Descriptor Queue Layout
+-----------------------
+
+.. code-block:: text
+
+     Queue BAR offset ----->    +------------------------+
+                                |      1. Descriptor     |
+                                +------------------------+
+                                |      2. Descriptor     |
+                                +------------------------+
+                                |            :           |
+                                +------------------------+
+                                |            :           |
+                                +------------------------+
+                                |     Last Descriptor    |
+                                +------------------------+
+     Driver Offset ----->       +------------------------+
+                                |     Driver Ring        |
+                                |           :            |
+                                |           :            |
+                                +------------------------+
+     Device Offset ----->       +------------------------+
+                                |     Device Ring        |
+                                |           :            |
+                                |           :            |
+                                +------------------------+
+
diff --git a/Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst b/Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
new file mode 100644
index 000000000000..8e2b954b1199
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+PCI Block Passthrough User Guide
+================================
+
+:Author: Wadim Mueller <wafgo01@gmail.com>
+
+This document is a guide to help users use pci-epf-block-passthru function driver
+and pci-remote-disk host driver for accessing remote block-devices which are exported on the Endpoint from the Host. The list of steps to be followed on the host side and EP side is given below.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+	  44100000.pcie
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	  44100000.pcie
+
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	  pci_epf_blockpt
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	  pci_epf_blockpt
+
+
+Creating pci-epf-blockpt Device
+-------------------------------
+
+PCI endpoint function device can be created using the configfs. To create
+pci-epf-blockpt device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_blockpt/func1
+
+The "mkdir func1" above creates the pci-epf-blockpt function device that will
+be probed by pci_epf_blockpt driver.
+
+The PCI endpoint framework populates the directory with the following
+configurable fields::
+
+	# ls functions/pci_epf_blockpt/func1
+	  baseclass_code	interrupt_pin	progif_code	subsys_id
+	  cache_line_size	msi_interrupts	revid		subsys_vendorid
+	  deviceid          	msix_interrupts	subclass_code	vendorid
+
+
+Configuring pci-epf-blockpt Device
+----------------------------------
+
+The user can configure the pci-epf-blockpt device using configfs entry. In order
+to change the vendorid the following commands can be used::
+
+	# echo 0x0000 > functions/pci_epf_blockpt/func1/vendorid
+	# echo 0xc402 > functions/pci_epf_blockpt/func1/deviceid
+	# echo 16 > functions/pci_epf_test/func1/msi_interrupts
+	# echo 512 > functions/pci_epf_test/func1/msix_interrupts
+
+
+Binding pci-epf-blockpt Device to EP Controller
+-----------------------------------------------
+
+In order for the endpoint function device to be useful, it has to be bound to
+a PCI endpoint controller driver. Use the configfs to bind the function
+device to one of the controller driver present in the system::
+
+	# ln -s functions/pci_epf_blockpt/func1 controllers/44100000.pcie/
+
+Once the above step is completed, the PCI endpoint is ready to establish a link
+with the host.
+
+
+Export the Block Devices
+------------------------
+
+In order for the Block Passthrough function driver to be useful you first need to export
+some of the block devices to the Host. For this a new folder for each exported Block device has
+to be created inside of the blockpt folder. The following example shows how the full mmc device can be exported::
+
+	# cd /sys/kernel/config/pci_ep/functions/pci_epf_blockpt/func1
+	# mkdir mmc0
+	# echo -n /dev/mmcblk0 > mmc0/disc_name
+
+If you also have e.g. an nvme which you want to export you can continue like in the following::
+
+	# mkdir nvme
+	# echo -n /dev/nvme0n1 > nvme/disc_name
+
+Start the Link
+--------------
+
+In order for the endpoint device to establish a link with the host, the _start_
+field should be populated with '1'::
+
+	# echo 1 > controllers/44100000.pcie/start
+
+
+
+Thats it from the EP side. If you now load the pci-remote-disk driver on the RC side you should already see that /dev/mmcblk0 and /dev/nvme0n1 can be attached
+
+
+RootComplex Device
+==================
+
+lspci Output
+------------
+
+Note that the devices listed here correspond to the value populated in 1.4
+above::
+
+	0001:00:00.0 PCI bridge: Qualcomm Device 0115
+	0001:01:00.0 Unassigned class [ff00]: Device 0000:c402
+
+PCI driver
+----------
+
+If the driver was not loaded automatically after `Start the Link`_, you can load it manually by running e.g::
+
+         # insmod pci-remote-disk.ko
+           pci-remote-disk 0001:01:00.0: Found /dev/mmcblk0
+           pci-remote-disk 0001:01:00.0: Found /dev/nvme0n1
+           pci-remote-disk 0001:01:00.0: Found 2 devices
+
+This just shows you which Block devices are exported by the EP. You are not attached to any of them yet. If you e.g. want to attach to the nvme device. Run the following::
+
+         # echo 1 > /sys/kernel/config/pci_remote_disk/nvme0n1/attach 
+           pci-remote-disk 0001:01:00.0: nvme0n1: Setting queue addr. #Descriptors 1024 (28688 Bytes)
+           pci-remote-disk 0001:01:00.0: /dev/nvme0n1 capacity 0x3a386030
+
+After this the device is attached and can be used. By default the devices are exported by the original names with an **pci-rd-** prepended (this can be changed by using the */sys/kernel/config/pci_remote_disk/<DEVICE>/local_name* node). So in this case the output of 'lsblk' would look like the following::
+
+        # lsblk
+          ...
+          ...
+          pci-rd-nvme0n1 259:30   0 465.8G  0 disk 
+
+Thats it, the device should now be usable. You can try to mount it through::
+
+        # mount /dev/pci-rd-nvme0n1 <SOME_DIR> 
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c51a22cee93..f0ed873470f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17015,6 +17015,14 @@ F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
 F:	tools/pci/
 
+PCI ENDPOINT BLOCK PASSTHROUGH
+M:	Wadim Mueller <wafgo01@gmail.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	drivers/pci/endpoint/functions/pci-epf-block-passthru.c
+F:	drivers/block/pci-remote-disk.c
+F:	include/linux/pci-epf-block-passthru.h
+
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
 R:	Oliver O'Halloran <oohall@gmail.com>
-- 
2.25.1


