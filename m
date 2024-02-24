Return-Path: <linux-pci+bounces-3975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D98627A9
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D120828231C
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF033F9DE;
	Sat, 24 Feb 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcCnlgX0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6913FEE;
	Sat, 24 Feb 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808709; cv=none; b=SiTq0QHe/UYjEf6lUTsJXLwoNynHXdCw57OuZAaAmRkFwsNibDC+kULqWkFWRibLBxkU2SdQfP/KvQmFnIFGVL0WdN3BzoyDZRNFOWxA8hvd8lyAY/dRe24REr1zX8A4U/lpE5pmeXJ2gYDUCBDKX46XC1/vzyXl2GVWBNyvNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808709; c=relaxed/simple;
	bh=/iLUFu2cyMFc+xcXmYpXe4j9gnUijS+nCA/RXDBwlRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dJBAbKkQI3tb2Ig7lzJcYlrYBXyhOGxn3hrzVyBAO4RQ+MubX2lFITaygv8sMr5EQuAYtyiwc6q81DVssVTZ2MkdpyflPI77/YppY8gcGEPhW5R7MUNpLhdG3wLLFRjFCMYhAthdg0Fyns1JT79RBCorQ+YDpy7iuAIZAtUSYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcCnlgX0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d228a132acso21017181fa.0;
        Sat, 24 Feb 2024 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708808706; x=1709413506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0zJcQ8ouGTUzzD7+nYmZbHgKeywOxwfz2KNwg9sLWI=;
        b=JcCnlgX0d0SLQCRd+WWMDHcAms9G9MkvTEThxJv29UzIUE3DE/AlT36KR88S1XmHgH
         xVhEq1sksIcuxDVvKrNDcDK7o/6Chq7OGNukbZ5Xkj0XaOUKkHaqHOZ1/7fenit/ktOD
         SSRWKCb/Jxpfgcw6EM2aBhZ1U4bOWaNoC/WDqznvJCW9ObfkpotqQ+Ya2IG8J9fw+VhL
         0J6zuVTn2mz7LLth6R/EoXakDUeOxmtXDxV/tHnMWmRbdil3jIytSosKKFfvKqtBktt2
         HPkbxHQ/CspeThUH/OaAJJLiex63uPWqhz3fIT+Vl55OW5iS2y3Ai0XhNp/HwxIQ07WZ
         CXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808706; x=1709413506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0zJcQ8ouGTUzzD7+nYmZbHgKeywOxwfz2KNwg9sLWI=;
        b=I3Qy8pgFqJ+hOIM01BKm/H87JsiX/ssx8evCfkeSelMVioGxW6xGgoEWfy35/NzltV
         yYlCzMFsle6bXAzo23z7bO3Z/Wztk9+Uecw7HnL86RI6AXmwvEoVRNQ0XT2BqCOk5pBM
         GRwCiszqinwDKrkrT+7bU4JAYjEgM66WBU1Xaam0pF5IRtg6TLDdlqK57dXdXii9QrON
         NOlk0nKobijA5r5fodVLyf3eutSvIFfz+s05HaACHdcQaC5aUiG4m+qWyXK5YdIDf+qG
         2rfrPgF2P2rrDQ32xA+OLsKufN18t2AEvUaLXSORCXwP6iaOL47VnecdRy0sQnAim/g+
         sulw==
X-Forwarded-Encrypted: i=1; AJvYcCWXTpDjw26/j8G71erx2bLMS3pm2gVTYXpqcdn6wsUkkJEe8Mprkvzfu+44DuiIjH7BWtmYA6KGFpVwsSGyMOKAd8XMIb1uSpK6kpL7IcWGL/9VsoyQWOXipKBDKzvs4ER+IYSyfC16gNiuUkNy0CwNv9GUKyxSY4VLKvTfETtkhPOBN8AVIVjAdggv1wJLZR6L0VFFK8a4b/aFwIBFUMo=
X-Gm-Message-State: AOJu0YyhloYJT9FFBMLDxMHGjhdXI2LrtIlnrbIeI13psEoUJHMz3hd7
	RVvjCkgBXtdjAWraG+e+hxxny1Sy5XCJhCKAFTMclUTpoahUGZm7vh+Ptl+GQ8Q=
X-Google-Smtp-Source: AGHT+IHXz+Y7vjO2Rc8Lh/ENnMh94PusIcnBbgtoLaalbI1TNJ7fJQ5N0MPyiI5B1QX7vnyZs206YA==
X-Received: by 2002:ac2:5d24:0:b0:512:e4f4:b562 with SMTP id i4-20020ac25d24000000b00512e4f4b562mr1754607lfb.31.1708808705778;
        Sat, 24 Feb 2024 13:05:05 -0800 (PST)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0:2bc0:19d3:9979:8e10])
        by smtp.googlemail.com with ESMTPSA id c22-20020a170906171600b00a3e4efbfdacsm891148eje.225.2024.02.24.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:05:05 -0800 (PST)
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
Subject: [PATCH 0/3] Add support for Block Passthrough Endpoint function driver
Date: Sat, 24 Feb 2024 22:03:59 +0100
Message-Id: <20240224210409.112333-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds support for the Block Passthrough PCI(e) Endpoint functionality.
PCI Block Device Passthrough allows one Linux Device running in EP mode to expose its Block devices to the PCI(e) host (RC). The device can export either the full disk or just certain partitions.
Also an export in readonly mode is possible. This is useful if you want to share the same blockdevice between different SoCs, providing each SoC its own partition(s).


Block Passthrough
==================
The PCI Block Passthrough can be a useful feature if you have multiple SoCs in your system connected
through a PCI(e) link, one running in RC mode, the other in EP mode.
If the block devices are connected to one SoC (SoC2 in EP Mode from the diagramm below) and you want to access
those from the other SoC (SoC1 in RC mode below), without having any direct connection to
those block devices (e.g. if you want to share an NVMe between two SoCs). An simple example of such a configurationis is shown below:


                                                           +-------------+
                                                           |             |
                                                           |   SD Card   |
                                                           |             |
                                                           +------^------+
                                                                  |
                                                                  |
    +--------------------------+                +-----------------v----------------+
    |                          |      PCI(e)    |                                  |
    |         SoC1 (RC)        |<-------------->|            SoC2 (EP)             |
    | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)|
    |                          |                |                                  |
    +--------------------------+                +-----------------^----------------+
                                                                  |
                                                                  |
                                                           +------v------+
                                                           |             |
                                                           |    NVMe     |
                                                           |             |
                                                           +-------------+


This is to a certain extent a similar functionality which NBD exposes over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framework.

The Endpoint Function driver creates parallel Queues which run on seperate CPU Cores using percpu structures. The number of parallel queues is limited
by the number of CPUs on the EP device. The actual number of queues is configurable (as all other features of the driver) through CONFIGFS.

A documentation about the functional description as well as a user guide showing how both drivers can be configured is part of this series.

Test setup
==========

This series has been tested on an NXP S32G2 SoC running in Endpoint mode with a direct connection to an ARM64 host machine.

A performance measurement on the described setup shows good performance metrics. The S32G2 SoC has a 2xGen3 link which has a maximum Bandwidth of ~2GiB/s.
With the explained setup a Read Datarate of 1.3GiB/s (with DMA ... without DMA the speed saturated at ~200MiB/s) was achieved using an 512GiB Kingston NVMe
when accessing the NVMe from the ARM64 (SoC1) Host. The local Read Datarate accessing the NVMe dirctly from the S32G2 (SoC2) was around 1.5GiB.

The measurement was done through the FIO tool [1] with 4kiB Blocks.

[1] https://linux.die.net/man/1/fio

Wadim Mueller (3):
  PCI: Add PCI Endpoint function driver for Block-device passthrough
  PCI: Add PCI driver for a PCI EP remote Blockdevice
  Documentation: PCI: Add documentation for the PCI Block Passthrough

 .../function/binding/pci-block-passthru.rst   |   24 +
 Documentation/PCI/endpoint/index.rst          |    3 +
 .../pci-endpoint-block-passthru-function.rst  |  331 ++++
 .../pci-endpoint-block-passthru-howto.rst     |  158 ++
 MAINTAINERS                                   |    8 +
 drivers/block/Kconfig                         |   14 +
 drivers/block/Makefile                        |    1 +
 drivers/block/pci-remote-disk.c               | 1047 +++++++++++++
 drivers/pci/endpoint/functions/Kconfig        |   12 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 .../functions/pci-epf-block-passthru.c        | 1393 +++++++++++++++++
 include/linux/pci-epf-block-passthru.h        |   77 +
 12 files changed, 3069 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
 create mode 100644 drivers/block/pci-remote-disk.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-passthru.c
 create mode 100644 include/linux/pci-epf-block-passthru.h

-- 
2.25.1


