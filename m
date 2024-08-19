Return-Path: <linux-pci+bounces-11815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DD9570F0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1A51F22884
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C383179953;
	Mon, 19 Aug 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxfo23yQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BE179956
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086355; cv=none; b=keK7cj1z3zY1SCrgCDeZlD/2JVi93FMfhoDXV64h/pJdYuvEP4GAk8c2VAydNEdSO0jmW1eO9f8klTheSeqomHiyk0svFosa6nHtleMcTeR9ryMbWicb+e09ibiz1ZyvOOsYB8xtUwkOUztrr/z+d3S99B36V2YAh91EM4tHGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086355; c=relaxed/simple;
	bh=StzfX7D+b5jZ3LVEyPb0XmRGLTAQPRkMUDb8wVYSh3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaK/9eJ3nZNp/CcLvTM+zmB0IWg4klvyIgGg8UlCVR+ZDXU1k3dN5wmQtqOf8u/u/Vs+5yni3DverQl7jAPU/3/dVprKX+1t++KEF4jqrxjw58QMoTo5JILt1WQfrBDyZWJUCiL4KozV7k7waE8JV4lspRTo65+OO87499R/z/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxfo23yQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oDgCmWXPsT/ByKSJo2B5hdxGUNecM9yTJg3LqwyPBvM=;
	b=Xxfo23yQ0nYOA/N2Y8IbZpb9fgzE0BwTc3vrpbg+d/vjGa1oZJJvJGPbYjU6muPXtS1ERg
	WY2bbIBgpTIC7Jr8bXvIcXxm7vAcqe462tYv5Jd/qawbuTZnF1+qzxw1XOKpVDLwHdY4LK
	7PvBWaJoknlVrtsrXp1rI/r9Ry9imps=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-FqBy8aH3MrC9uFTfePHlJQ-1; Mon, 19 Aug 2024 12:52:30 -0400
X-MC-Unique: FqBy8aH3MrC9uFTfePHlJQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7093890e502so855800a34.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 09:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086350; x=1724691150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDgCmWXPsT/ByKSJo2B5hdxGUNecM9yTJg3LqwyPBvM=;
        b=L1RuNJgpgnGWH8noZOH8vUmmu+M5w4IO0Lj6Qj/bo9xipBe831jzw4qbT31u4APlOp
         XmCK6LOo5+TSzg3c6Et4RTY/lfCbKafTIiOV1xdwdJXA43gGXn4DdJi4htcMbMORC06y
         HPZBCZb3EdMEIxxKPm4Om8JXZf9C9rcXq/eQka+05KX4pYk7y4zagd2Wlxpqmx4Oh/AL
         mVZ5YSTDaD4tIwXFQgV5CQ2qTaFGCQf/b9XcXHNhpL9fHE+JdTQw529buA4NXZ7maNNH
         BcExU+TTAQXjPvJSORW1QQg+yqYwu1v1ro77Afe+ph/F0mNU397EBfuh/MqOe2xZnsvH
         jAXw==
X-Forwarded-Encrypted: i=1; AJvYcCWrAdugzPkoUHQDLZLCPbBglJeMxkfnrdGcpjhd1CKUQEpIr/s9+kN3oU1z+VYaBdoVPnCw0Q7TMrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDULUKumsWX7D14By4iMT6CEmesBMZpt26CIuL/Is4l3BK4XL
	0vlgBbi0x742CT3h4Yo43H2DGJlI/KM/16KOuMCGH9+irA6W16zDoetmaMy3eD2vy9mm+W+2uz7
	EkCyyvFuhae5z8772PQRRm6qq6zgTld4ohplHbUVzHCy1FZf9+Q/J72mKpQ==
X-Received: by 2002:a05:6359:4c87:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1b39333e0c1mr737788755d.4.1724086349984;
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEksR+Cpw2eRNuHRkEIfwdvURGCWFxAEIEKM8Aw05iYSBMnqj3x39V0KKigIE6pVo5nSVtsiQ==
X-Received: by 2002:a05:6359:4c87:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1b39333e0c1mr737785755d.4.1724086349577;
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 0/9] PCI: Remove pcim_iounmap_regions()
Date: Mon, 19 Aug 2024 18:51:40 +0200
Message-ID: <20240819165148.58201-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (9):
  PCI: Make pcim_release_region() a public function
  PCI: Make pcim_iounmap_region() a public function
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  ethernet: stmicro: Simplify PCI devres usage
  vdap: solidrun: Replace deprecated PCI functions
  PCI: Remove pcim_iounmap_regions()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/block/mtip32xx/mtip32xx.c             | 11 +++--
 drivers/fpga/dfl-pci.c                        |  9 ++--
 drivers/gpio/gpio-merrifield.c                | 14 +++---
 .../net/ethernet/cavium/common/cavium_ptp.c   | 10 ++--
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 +++-------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 +++----
 drivers/pci/devres.c                          | 25 ++--------
 drivers/pci/pci.h                             |  1 -
 drivers/vdpa/solidrun/snet_main.c             | 47 +++++++------------
 include/linux/pci.h                           |  3 +-
 11 files changed, 57 insertions(+), 107 deletions(-)

-- 
2.46.0


