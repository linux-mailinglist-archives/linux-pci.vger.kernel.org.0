Return-Path: <linux-pci+bounces-10208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02892FDD4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A921C2275A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A37407B;
	Fri, 12 Jul 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Tt3M3b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAD440C;
	Fri, 12 Jul 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799353; cv=none; b=CZDu7RigPUPx2GcNxvdeWdH6aG/AiMDzO7FODTitwo4KsLIXSmqWKl682kLIgSzp9kGBNWhklDh67IuctZ0CzQcgGKNHDekCFsKbM6iJOlUxeBh2htIbxugGSGiXXenrFD+7/5IZjVWp2W0rAVCbRWWje7u1LZEMXGQjn/aqHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799353; c=relaxed/simple;
	bh=g1er5zB3UAFTH4lX5fNuFAOLI9apgTGC1UiZhvyXbRM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mIWH76/RQLbZERvIMNrPZOISxYl4FTuW7krjoJLFKZwWUNn9+7zCKf1eLreC7XM8l9+8oWthGPtNv1k3DSGiUL1IgIm5FVWUfWUTqEHhn5iKZ16ZZfYUcX2bPX6sILX1HjA6DucuU3yPOiQTKA18nADKNMmgksKu/pcwUVbGDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Tt3M3b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso15497105ad.1;
        Fri, 12 Jul 2024 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720799351; x=1721404151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=JaS6RpQt+MamVjsgff8AGDxYYt3AH7aJY3AIKOLyOL8=;
        b=E5Tt3M3biLq+rZBlh10Ru4v1vQCS5KbEqJKeXZ1oh6sCQ/3Im7kdZY/OlXCWgPxcog
         ben6N+w6pdkcVxP2hCpc64MueegGswwQGXOtmLi4JbPAM/IhoSz8M6kPceBPHKUANfqc
         dBNwdf5X7W1KJuRQl1+pYK9Orb7+KYIygfy8JmsGd0fsV7e7YZk6kJcIxgufX917asYf
         +haFVLItRdiju4dqc35LjTEOWEYS+RthKoL00164bxZj+3Y7JgUoFcnmcDEe3MRyv9Ql
         GF/p6ZcoCBAttNJoBK7nlRqB7aMEr6MLVwHXGFKp4utfgJyMriNtbNn97VYG5YHpELZ4
         LqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799351; x=1721404151;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaS6RpQt+MamVjsgff8AGDxYYt3AH7aJY3AIKOLyOL8=;
        b=flkRKXAvAH8zCQKOd7YabPpR8em9rVkMLkniQSZHkyHUmdYnZ/V5yQG2pcK0nN3mNm
         b11+YqM4tziAC1NTAlv1HeLDOmC2pu8CthyD3aP7cPSSq01oUfZRCRhCK25vVVXWWrJp
         ayRUHrcD7fd8YC+qhQnE7aOhsxKe1CftqztHo+0vQ0nP4q/MIEdqUphXIJAIF0JwcCCt
         XjOMSk+ozCapDBpcBeaDUfgaTgV+e2eZVzbLUqgQxAR4YAuo5Zmul6apIIIyQNuPiT0Z
         hcgogha03kMhFPVd7+4bUZXhlk6M3WpQi6ZFxDc0fD0XKOKszVgwClJvVGMyHb2yJFgk
         7Rqg==
X-Forwarded-Encrypted: i=1; AJvYcCVOaTSwdri7E9y60V6M65RxDsb7oXye8GrCHtMUKI8ExqBluUJVpUG0+zqrqQqxTtrYf4ylyavzR+Ua+RypoV92NprSuBjI/Pj1
X-Gm-Message-State: AOJu0YwAw+vXeZpHeSVEZM9Sf7NVyGR+fUCPBY5VE+YSqfQrvpK2JKPw
	vVpXkJ7BfsT1LuzWN73u12EWaXwocEQTZF3NVjHiPLBH1etE+j6e
X-Google-Smtp-Source: AGHT+IFSqmR0leuCe0IizcK7N+eyo2wzUnolI72x2l87lggQk3I13Vt86DY7vf8tKyZwiZ/jevzRDg==
X-Received: by 2002:a17:902:ec8a:b0:1f7:123e:2c6f with SMTP id d9443c01a7336-1fbb6d4de4emr111279555ad.37.1720799350535;
        Fri, 12 Jul 2024 08:49:10 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbd34694a5sm45178325ad.7.2024.07.12.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:49:10 -0700 (PDT)
Subject: [net-next PATCH v5 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, Andrew Lunn <andrew@lunn.ch>,
 Sanman Pradhan <sanmanpradhan@meta.com>,
 Russell King <linux@armlinux.org.uk>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Date: Fri, 12 Jul 2024 08:49:08 -0700
Message-ID: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch set includes the necessary patches to enable basic Tx and Rx
over the Meta Platforms Host Network Interface. To do this we introduce a
new driver and driver directories in the form of
"drivers/net/ethernet/meta/fbnic".

The NIC itself is fairly simplistic. As far as speeds we support 25Gb,
50Gb, and 100Gb and we are mostly focused on speeds and feeds. As far as
future patch sets we will be supporting the basic Rx/Tx offloads such as
header/payload data split, TSO, checksum, and timestamp offloads. We have
access to the MAC and PCS from the NIC, however the PHY and QSFP are hidden
behind a FW layer as it is shared between 4 slices and the BMC.

Due to submission limits the general plan to submit a minimal driver for
now almost equivalent to a UEFI driver in functionality, and then follow up
over the coming months enabling additional offloads and enabling more
features for the device.

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

v4:
- Removed _pause variables from fbnic_net
- Removed link_state variable
- Make link_direction an enum from fbnic_pcs_get_link_event_asic
- Switched to using phylink_resume/suspend to avoid blocking BMC traffic
- Always pass "false" to phylink_pcs_change
- Added "TBD:" comments to call out temporary workarounds for phylink code
- moved fbnic_fill to Rx enablement patch to address several issues
- Refactored BMC MAC address configuration to avoid MACDA reads

v5:
- Added IRQF_ONESHOT to mailbox IRQ request to document behavioral expectation
- Fixed a few typos in comments

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
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  144 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  838 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   88 +
 .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  791 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  124 ++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  208 ++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  666 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   86 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  488 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   63 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  564 +++++
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |  161 ++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  651 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1913 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  127 ++
 include/linux/pci_ids.h                       |    2 +
 26 files changed, 7877 insertions(+)
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


