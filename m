Return-Path: <linux-pci+bounces-9237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555F916A8D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB22284C40
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942153BB23;
	Tue, 25 Jun 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJxH6yoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1A1BC57;
	Tue, 25 Jun 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326140; cv=none; b=Kt6c5JX173qWsDX8EylfK0HMwOLkGq73QsXKfvzLatNeA7jwAhxbkuTNAdnD4fE1EevfwdcsU3Bb9QZ0Y5/sdma5uDGXNbJMPzuCx3a/0JSMjWveVeJL/jN2Y70elZ5AQhjkghHasMRNIvgU26N0POVW+B24EJpbaMZGAhFHGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326140; c=relaxed/simple;
	bh=SkHpI1zd8SNo3gK+qgFniwBjaIDqT9u24PGuFAi7HQk=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=rc3qXEI5H79L7lYTWk++Lsuqi4VtSkmS30u1QByjb2O/KjRicOspNdnTSz2fm8cwxyKSGrz425OLyxHRFKl736+MNtZb5wCO+v+kxsZKDdvmOqZv3XC5dQavyMpOLAVz8ZIKYnRMB9roaybL7mQ0JkCXf10vX32dYCCxbZM7n38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJxH6yoW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70666aceb5bso2578451b3a.1;
        Tue, 25 Jun 2024 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326138; x=1719930938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=EX0O6UgYajkDhWepXD4nSgwP45HITAz1UJqIYnpckeo=;
        b=aJxH6yoW0I41dP69AO1lxOzpq5m6VVPjEjbz+Oybbi3zQ83AE75/bobMcgli+B0SsY
         3zIqUSrPHMmROjtKTcwQgVl4zcKa70Q0BBUo94e7OqeRYrjj3aOQi5u0cRpQ8AYrZoXc
         kGs8zbqLuvHoU3QXqw8t2N5x9aGDtfi+tJ5M0NeGWAByLvx8XuNBYb/dSqCbKssUUi3m
         A55ZvctKZ9b2uPLwU6WoSIqvKQdxEGcdkvEebl8xihVmgEtYEYu6B3Ak2GKdn9Ny8urv
         rQBUpfCfxhEMOy5rfsLEfRSFAK6+QyGc1JTXXwTES7aBv49qH8e775aU3O18l4K0wHjp
         UcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326138; x=1719930938;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX0O6UgYajkDhWepXD4nSgwP45HITAz1UJqIYnpckeo=;
        b=FzhllgSos/gXb/Iu+V6mSp2ZaPi9YJVCD1CwKyIn+lbkFb7XTIP1k99KliqvJh2Ast
         TqAiE86SdjzlXHNEAzdG94mLfEr28cZgOLYjZq34uU4pMhsKQLP/LLst/FiUL6k2POwH
         oL02IVs9Fz1nkiDFJEfmrJ3+vhiK0YcUVjHMIMB9KMXohA/weCBDeghFwFUgeJfCLBsv
         5CZCWnHxX7YPMjG+651aN1606+BVC9xonxWnmrPKEiyJPwOJAs5Xd7w6YL7ZXr927DyH
         db8sZvxemX7wEIpE22mJnQ4OXOwGNYoPR2jodw1glsfFwAACwqgjd0mPGp9bpFbkMbf+
         WNYA==
X-Forwarded-Encrypted: i=1; AJvYcCWQw41mUUhL84/ieewXRHVB9KEOFoseAxy6BKqpl7Ub9XlWzHMt1vhPPPJcU7BW7gTcSwadH+UsigOSWtG8zwMKRy3hqZUNXZ4n
X-Gm-Message-State: AOJu0YyPaj4su9zXgH+1eaYbhLo1BhFD0k6oqlFfANVQw7gZwUAthlRM
	9dSG7NvYb2ue+CAp5Am2uMJLnVCgpjavkPWhfThIKNURiOpXUwNu
X-Google-Smtp-Source: AGHT+IEWl3T9oPyLpqI5ChWVHzmqi7/jz84rmaU7/aFJ0a4l0pOnZnLSiMEwP4KMD3oGi3Ya6uaI1g==
X-Received: by 2002:a05:6a20:4707:b0:1b8:6ed5:a70 with SMTP id adf61e73a8af0-1bcf7fd11d5mr7755715637.49.1719326138161;
        Tue, 25 Jun 2024 07:35:38 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511b137csm8180480b3a.86.2024.06.25.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:35:37 -0700 (PDT)
Subject: [net-next PATCH v2 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexander Duyck <alexanderduyck@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:35:36 -0700
Message-ID: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patchset includes the necessary patches to enable basic Tx and Rx over
the Meta Platforms Host Network Interface. To do this we introduce a new
driver and driver directories in the form of
"drivers/net/ethernet/meta/fbnic".

The NIC itself is fairly simplistic. As far as speeds we support 25Gb,
50Gb, and 100Gb and we are mostly focused on speeds and feeds. As far as
future patch sets we will be supporting the basic Rx/Tx offloads such as
header/payload data split, TSO, checksum, and timestamp offloads. We have
access to the MAC and PCS from the NIC, however the PHY and QSFP are hidden
behind a FW layer as it is shared between 4 slices and the BMC.

Due to submission limits the general plan to submit a minimal driver for
now almost equivalent to a UEFI driver in functionality, and then follow up
over the coming months enabling additional offloads and features for the
device.

v2:
- Pulled out most of the link logic leaving minimal phylink link interface
- Added support for up to 64K pages by spanning multiple descriptors
- Limited driver load message to only display on successful loading
- Removed LED configuration, will reimplement in follow-on patch
- Replaced pci_enable_msix_range with pci_alloc_irq_vectors
- Updated comments to start with a capital letter
- Limited architectures to x86_64 for now
- Updated to "Return:" tag for kernel-doc
- Added fbd to read/write CSR macros

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
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   86 +
 .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  791 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  124 ++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  226 ++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  694 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   86 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  484 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   65 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  563 +++++
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |  159 ++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  709 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1879 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  127 ++
 include/linux/pci_ids.h                       |    2 +
 26 files changed, 7952 insertions(+)
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


