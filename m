Return-Path: <linux-pci+bounces-10015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20F92C26D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 19:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AB428107B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C561B86CC;
	Tue,  9 Jul 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBVksDRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3D1B86C5;
	Tue,  9 Jul 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546115; cv=none; b=Pxpi+wiP8VbDS2kzsYsjaTjgRl+SX6SMb/YSocYHPU0dh0w+5lYzKwaHPzqTu8FqYi/P47UE1NVwVGC9IUsYlGDSvC0oEUh8ueJbaCjlMTm5jdkU6m3brEQ3Xe4O3Bb1iX3Qjv+iV/lPrn0XVPlkgXKvz2/r8w1w2wyPtrNWjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546115; c=relaxed/simple;
	bh=CF7iRNLUbqTRlkdskyXE1Q60wOI/P/d4aSG739lrtWw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=juav18E/woqhstCe0cqu9Y5AyaIapRFsOZHXI3rmIN3/0G5yYcXSv+iDJF0rMLx0W7kAHEc6ik53U7WS8mBinGq8zUBXJMl4q7HQ8p7ynDCdQlgxiBG5kso/ekBnFc6ywqW770LpHqu+Jibn4T93BPyAMNlF6pI1cIVTEe9l9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBVksDRE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b1207bc22so3181663b3a.3;
        Tue, 09 Jul 2024 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546113; x=1721150913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=HiwhHvjY+Bfe4SY2Z/m8yhr0qm6n9XBr38UIqxZUzBQ=;
        b=TBVksDREe+r9DqPmAyrPWVACieW+UhnV6U/49fTbl2pK2jjvWbCfmD/cNkKgMfAaKK
         hR6ygueQTBQURCgQURrTwEdKYapYlL29161HOVrNeEaEjeBOgoLXAOr8aSNmH/vkK62x
         V2S775caB8bJO2op8YBx0fjPuGzIoCBj+2rKHe84tUGZF3YhKeWyFgs4Hlrwhrr4xQB+
         ngmaahAPRUVPkPFWYhB7YbEaLDmb/2VJs0QVmN886lzIfMXtPp2rKf85HefeM3lk6wTb
         5PXxtU+ipPg6SKmyyn6Pr5fRDpAzWenPO8DkcbD3/q3zJfbzp337VMrfkEaYMEK2iM+y
         IACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546113; x=1721150913;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiwhHvjY+Bfe4SY2Z/m8yhr0qm6n9XBr38UIqxZUzBQ=;
        b=BsNGpg7Y9N7HrwhLjXl2LLC5QPYDeG0kWhd98n2ivu2uilSYgXhRfaNf43CgeQ1yah
         yvJiYaZBDmjBULWi77lX6yCkwiZJSylEQQKgUg21waBLaUshgjw9wFa1odi3M7qQGwVY
         UAoMEE4d5mFVjOPlmfY1+KC2/UKEllwyMKHimgfwql1QgdpjF6Awug14VK+6QegFeYdL
         xqOLLOl8U3GEiMNqJR/Sb95hqGv0+KvNGEC2k+CHU6uIC1LTcJh9/wB4v0d6xmzIPfsp
         p9jjOTUdBHoqGPQllPaDF1XznaJ7kKGCmI1sCU620jD2svTjAhc+PMU4p4aM0/zwXY0p
         6OLg==
X-Forwarded-Encrypted: i=1; AJvYcCVoYhGvS/jO4mt8wfAdx/qzhoHMRIyvbZf2HZWWlH7rz+HM0oGk4Ou63wFcGJeL3363WdnsGUbnvuaXDu23M7yqvOPcXty3dzH3
X-Gm-Message-State: AOJu0Yy0TA9PMmE7HlCSqG4ao9/oyObfobJIfNH2T8XKQAgN0nzUYr16
	WdDg25L91e96td1HLdY4HdMHv5xkdvMqdWC/zjUW/wzpvYUF3fd/
X-Google-Smtp-Source: AGHT+IGqUyMgXIuI5XfKjcpeRUv5WBuGVb8kiT/RXL/SnYy0Pb0UgoF+JMtjJ8RdT/v7Vk+B0fZ2wQ==
X-Received: by 2002:a05:6a00:2347:b0:706:750c:8dda with SMTP id d2e1a72fcca58-70b434f3501mr4362930b3a.6.1720546112606;
        Tue, 09 Jul 2024 10:28:32 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43984adcsm2082293b3a.162.2024.07.09.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:28:32 -0700 (PDT)
Subject: [net-next PATCH v4 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Sanman Pradhan <sanmanpradhan@meta.com>, Andrew Lunn <andrew@lunn.ch>,
 Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Tue, 09 Jul 2024 10:28:30 -0700
Message-ID: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
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

v4:
- Removed _pause variables from fbnic_net
- Removed link_state variable
- Make link_direction an enum from fbnic_pcs_get_link_event_asic
- Switched to using phylink_resume/suspend to avoid blocking BMC traffic
- Always pass "false" to phylink_pcs_change
- Added "TBD:" comments to call out temporary workarounds for phylink code
- moved fbnic_fill to Rx enablement patch to address several issues
- Refactored BMC MAC address configuration to avoid MACDA reads

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
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  210 ++
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
 26 files changed, 7879 insertions(+)
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


