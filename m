Return-Path: <linux-pci+bounces-9592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A009241A6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447F7B259AA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60E19AD86;
	Tue,  2 Jul 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRB2yDfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D951BC068;
	Tue,  2 Jul 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932384; cv=none; b=ojVTd9kxykq5Kcgjlcgd8HBqQfIHD0dst7/58XWZ+UpBgKdFiWYoj9ptcYq/P/63h5auByM6ILlX+5CQ610C6SgSlQ870FP2tpKLlk4kdQ05nwWMxxsaNuXiY9P7lN3eTyV6o2RZ1h86i8g78IvTXhAEvDqPy4Po3iQj0wqqk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932384; c=relaxed/simple;
	bh=TJIGMt1T6zRWBcw0Q/jiTB4i/RhYXVWtAA0MhKrxOtY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=szsBovOPZ/SNsiDv8xSU7m1hof0wXqu0H8H5bJZKFDyyT1GxGxEEXYGsYpRfGRbbBiBgu1PAsIEzvI23SDqQKebzQtrbsogDG+3hpFgdT9swgo5/i6V/+lbU1mITWoQcRPM81IOr5EHtuOoF8H2naD0FlABtCQd+sEm8OiZUrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRB2yDfO; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25d8ab4f279so2449024fac.3;
        Tue, 02 Jul 2024 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932382; x=1720537182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=/uPRjOXxn9YxevY0WND4fOofoeAkjKWJJMMlBdKENco=;
        b=IRB2yDfOlG23T8g2nwsnQKbP3FZrY9XSuCoOy5UdgBON+SULlH35a2RxVv4WUsZ5I8
         tT6LVds2mknNNjcUxZT9sdV+ztOVcUeqo7WLJTZpIxIkIrJO+fSODdnZ7BCT+6O4C30X
         iWwvrH0ZV2Wm0oPPxVFQqySL1vQcnDw/0xFGCUB/CJyuHsWokoS6S+lK5IdfzQV6IRGr
         I4N4wYXcqZ9Qg5QbJ8Trnzl/CHilRijqmxDjg2xRAbz+a9KeaFMC6G0EqU9XbBZSwGt9
         tjIIAXzDhH4iq8tcjur/pp16+T7KgDQ6ZDwTW+UgKppOCXrzI/eqfjJc1HJg/bdf6OOW
         RS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932382; x=1720537182;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uPRjOXxn9YxevY0WND4fOofoeAkjKWJJMMlBdKENco=;
        b=mwpn/8j7RXERUD5hvQZZAY6lhJy4f8SJqnB9nRmcy66KzMA7+o4BuWkO1AtfUZwO1x
         XjP+sAgObJce96Aze/7ckhHDHAjDMP4baVYd0UNZOW4Pyq//OFUAy0uzuyM+JhGiEsvu
         ZgCrj96Ecu21XyUvD8+kjL2LzngE7S3hIbDA1wRr3cOgbLtGbOqp/mXeFKR65F+cl0AH
         eP2BwDsg/tyTkyKA/LvDBlh/B0TTQyqi3Rl8erQIYRIVbk3sU3dC2mE3457hQ9bQcZqm
         9p1GEY6A0jnaYaFOpsZvbv+2m5bqFf+iDSXu2x+dEfo+UozPlYBM1GoVTDZfEEfbF1zY
         tmeg==
X-Forwarded-Encrypted: i=1; AJvYcCXCtpm1vdXXyQ/yA11nU76iU0LGnu2sGmTnvveRJqgzXGaT3DdN0ttFeWLQdPPZuEBF6DSaRTcjwxSvZTV2CRq5sA4ALXGsdKob
X-Gm-Message-State: AOJu0YzqKDEBhIj0d6JeSXBoZjHigzOit5xQ/9Z0QAQ7LOTNhtuTtXoZ
	JAIOR7NSKHky9Q57k5Nq4iKT4D08kY9Ho802hsP+5uwkrbAcj77S
X-Google-Smtp-Source: AGHT+IE08i06eGaTcQ86/QpxEHKblmZLHOnEGS1HxS0mXNpj1rdjdTgTiOOrXznmm4vUXOXy3yCmaA==
X-Received: by 2002:a05:6871:7412:b0:254:8d5a:f9f5 with SMTP id 586e51a60fabf-25db34daf80mr7315263fac.30.1719932382188;
        Tue, 02 Jul 2024 07:59:42 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf5b5sm8637316b3a.116.2024.07.02.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:59:41 -0700 (PDT)
Subject: [net-next PATCH v3 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Date: Tue, 02 Jul 2024 07:59:39 -0700
Message-ID: 
 <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patchest includes the necessary patches to enable basic Tx and Rx over
the Meta Platforms Host Network Interface. To do this we introduce a new
driver and driver directories in the form of
"drivers/net/ethernet/meta/fbnic".

The NIC itself is fairly simplistic. As far as speeds we support 25Gb,
50Gb, and 100Gb and we are mostly focused on speeds and feeds. As far as
future patch sets we will be supporting the basic Rx/Tx offloads such as
header/payload data split, TSO, checksum, and timestamp offloads. We have
access to the MAC and PCS from the NIC, however the PHY and QSFP are hidden
behind a FW layer as it is shared between 4 slices and the BMC.

Due to submission limits the the general plan to submit a minimal driver
for now almost equivilent to a UEFI driver in functionality, and then
follow up over the coming months enabling additional offloads and enabling
more features for the device.

v2:
- Pulled out most of the link logic leaving minimal phylink link interface
- Added support for up to 64K pages by spanning multiple descriptors
- Limited driver load message to only display on successful loading
- Removed LED configuration, will add back in follow-on patch
- Replaced pci_enable_msix_range with pci_alloc_irq_vectors
- Updated comments to start with a capital letter
- Limited architectures to x86_64 for now
- Updated to "Return:" tag for kernel-doc
- Added fbd to read/write CSR macros

v3:
- Fixed resource issues due to not calling pci_disable_device
- Addressed sparse errors for !x | y
- CCed Eric Dumazet and Kernel Team at meta to submission
- Cleaned up kdoc to include missing Return: and formatting issues
- Removed unneeded inlines from fbnic_txrx.c
- Added support for setting queue to NAPI mapping
- Added support for setting NAPI to IRQ mapping
- Updated phylink to make use of rx_pause, tx_pause in mac_link_up function

---

Alexander Duyck (15):
      PCI: Add Meta Platforms vendor ID
      eth: fbnic: Add scaffolding for Meta's NIC driver
      eth: fbnic: Allocate core device specific structures and devlink interface
      eth: fbnic: Add register init to set PCIe/Ethernet device config
      eth: fbnic: Add message parsing for FW messages
      eth: fbnic: Add FW communication mechanism
      eth: fbnic: Allocate a netdevice and napi vectors with queues
      eth: fbnic: Implement Tx queue alloc/start/stop/free
      eth: fbnic: Implement Rx queue alloc/start/stop/free
      eth: fbnic: Add initial messaging to notify FW of our presence
      eth: fbnic: Add link detection
      eth: fbnic: Add basic Tx handling
      eth: fbnic: Add basic Rx handling
      eth: fbnic: Add L2 address programming
      eth: fbnic: Write the TCAM tables used for RSS control and Rx to host


 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/meta/Kconfig             |   31 +
 drivers/net/ethernet/meta/Makefile            |    6 +
 drivers/net/ethernet/meta/fbnic/Makefile      |   19 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  156 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  838 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   88 +
 .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  791 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  124 ++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  229 ++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  698 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   87 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  483 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   64 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  564 +++++
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |  166 ++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  709 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1913 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  127 ++
 include/linux/pci_ids.h                       |    2 +
 26 files changed, 8002 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/Kconfig
 create mode 100644 drivers/net/ethernet/meta/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_irq.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_pci.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h

--


