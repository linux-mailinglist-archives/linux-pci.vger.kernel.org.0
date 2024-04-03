Return-Path: <linux-pci+bounces-5632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF1897991
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FED41C217F0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB6155729;
	Wed,  3 Apr 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8//3/31"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D56B70;
	Wed,  3 Apr 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174908; cv=none; b=FE4bhyJWRBgtsbXnULDUZJGAJbDsZ8svu0DU8/CxCSNwkYT43QqKi7ad0Udb8e1H0v+WnwsrXf06Wi2K94TiX5HI6HF5E4IqwmFm8QbxbokObS3Q3Baoetn86UuRN1oLHydNVL4arTKcBgMWAvfNL72KW73OrUswBaLdwmY6exE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174908; c=relaxed/simple;
	bh=2fsOkro6mk88l61A5MxD7dZRNxkixb8SwYgMSoixRnA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=CbtVeXIgYH+Iungt3e4TJCr3K21kAy73jluGIvHu2gF5k1TvBcq1mspHgKd7M3PdDAu5fCuWQmZZlw41BLz+Bp76xpcWOn2AjbzO5ksKNjEuf3YCSRWBYmAiBmnefFu41OZZONyxuZGuXRb0iBOAfQXev5/CF7oluGkTSCZlzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8//3/31; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0411c0a52so1957215ad.0;
        Wed, 03 Apr 2024 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174906; x=1712779706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=CpqvPj9IczF/kXEpAbnNfvd83r6sEAX+HET3G8c0e6U=;
        b=F8//3/3161Ktv3bq5BBp9H8JmXtclK83uXI245IdgWam47aBOTLWVee4d54Z91wOLU
         1LLXrJRAByOebuHh50IVryh5wL0+kcD61mgNrtXkbITctq/Qg54cL5JT41d9H3cX7nDf
         2r/Whv694YmxV82HcxrSdDQvoIwYcUiR0gmZVSW0b3qdu2XPI5rjf+O1hiUA+iHW3NFM
         ceQkfAboUgHM1OKCgmuuky76btvcalVbkybUpwTJAUq9RYrx9erBCVUHH5klcMhP1TgC
         2CpFEUMRt50+1gp/lTf1OYQgpWzcM54lEJl1b1viFOif/KgDAC+sLrbwk0QUTXGHOlJe
         1fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174906; x=1712779706;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpqvPj9IczF/kXEpAbnNfvd83r6sEAX+HET3G8c0e6U=;
        b=jQ3wBvrbefizeYZrC5MNLeNM/qk/jDc4Aql73jnL1sHymfDA5I7eeQOPVomRvZBS6z
         S3Bn5irTD06lolaAC/h6qJW2SZZ4MhS3KsbJJEzGWgnZNqxCyUnUTPzjHeZDE+CH2xn1
         1STKAbSIMPYaTdcEbpouQUbGy/ZEWLKjgcaebk6GFCVFO0kf9VYmrSU/QIYuMqtc1rzs
         pU5OjynRIWHdaN32Z/pycVeKio65RvDC339HSfSFRRKUj1aYT5YcKZX4pkpYkvJBH0Z6
         2Q8W1ZltYqXK3+rkJ8nX5r97HN4kY1N4deonIQ/B91lTPADcYoV41182odoc65ulhZwg
         1S4A==
X-Forwarded-Encrypted: i=1; AJvYcCU1U/ya5TN1rrfsTM12mSwFsrYSBMsrhPBsfgHNwdtSQ18QTIZoKFzpQbVGC34EccgyAeZ5jPEIoRN2AlpuHr1S5dyCWjEotDlV
X-Gm-Message-State: AOJu0Yyktpmqqhb0yS+hjzamJrHW2asucMjLvdegaffK3SyJi0ZPCA1X
	6DsBIZA7EklP3m0waRoIt2+iafOexMFIG6AuYWzmk+AC90WCs+oW
X-Google-Smtp-Source: AGHT+IEDFqKKQvqrHq6Ih8Rlo7xAgPUwdoTi8TAETqogDfOA6T+xp19FZJ9Gr5MPBeWOjrij6PZ8CQ==
X-Received: by 2002:a17:903:32d0:b0:1dc:de65:623b with SMTP id i16-20020a17090332d000b001dcde65623bmr329810plr.60.1712174906178;
        Wed, 03 Apr 2024 13:08:26 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902b94100b001dd0c5d5227sm13649956pls.193.2024.04.03.13.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:08:25 -0700 (PDT)
Subject: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:08:24 -0700
Message-ID: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
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
new driver and driver and directories in the form of
"drivers/net/ethernet/meta/fbnic".

Due to submission limits the general plan to submit a minimal driver for
now almost equivalent to a UEFI driver in functionality, and then follow up
over the coming weeks enabling additional offloads and more features for
the device.

The general plan is to look at adding support for ethtool, statistics, and
start work on offloads in the next set of patches.

---

Alexander Duyck (15):
      PCI: Add Meta Platforms vendor ID
      eth: fbnic: add scaffolding for Meta's NIC driver
      eth: fbnic: Allocate core device specific structures and devlink interface
      eth: fbnic: Add register init to set PCIe/Ethernet device config
      eth: fbnic: add message parsing for FW messages
      eth: fbnic: add FW communication mechanism
      eth: fbnic: allocate a netdevice and napi vectors with queues
      eth: fbnic: implement Tx queue alloc/start/stop/free
      eth: fbnic: implement Rx queue alloc/start/stop/free
      eth: fbnic: Add initial messaging to notify FW of our presence
      eth: fbnic: Enable Ethernet link setup
      eth: fbnic: add basic Tx handling
      eth: fbnic: add basic Rx handling
      eth: fbnic: add L2 address programming
      eth: fbnic: write the TCAM tables used for RSS control and Rx to host


 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/meta/Kconfig             |   29 +
 drivers/net/ethernet/meta/Makefile            |    6 +
 drivers/net/ethernet/meta/fbnic/Makefile      |   18 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  148 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  912 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   86 +
 .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  823 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  133 ++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  251 +++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 1025 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   83 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  470 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   59 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  633 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  709 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1873 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  125 ++
 include/linux/pci_ids.h                       |    2 +
 25 files changed, 8292 insertions(+)
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
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h

--


