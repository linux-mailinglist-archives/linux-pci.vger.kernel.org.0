Return-Path: <linux-pci+bounces-13594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBF988293
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 12:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B52BB22EC8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5A17A597;
	Fri, 27 Sep 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="TVX6ArO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427D154C0A
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433221; cv=none; b=Y0AV2igGZGyBfXhTjV0xcWuYU2PaeDZCaTRcopVRk9qWmV6lOmTVmxcW6kJNb0U1IyxfeSl+1J2iKWSKHBphMTa2812DdtXj6ImKyis9idl5Vprlxpyh5GOWP8cMSKNgIeRjFy1XmK53J+tVjwFbtblS9U/IYPP0uJb85V6pyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433221; c=relaxed/simple;
	bh=jvmEomY0Hp/ILK66ANKCMNaC0jWBActS4+ftVmPCWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+gJXnFcGlOMPeaTx+e2TtwM1nFzg1lVmgFBrOasDSJxdk6BdvNuXGn8Qje/9UOmpNndP7Y6QB8s0NxurA0ifFkUEYZsKoaM/dZEcWioTUitDfeQffb4FDgnEt/56TlOgT38aNq2XytHuxNeZUch4Spa1k19vrEDIYWzIK0mWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=TVX6ArO8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7178df70f28so1660397b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433217; x=1728038017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3T2LL56WRUoCrnPPbMQXHKo2gYqUc6Xl1Uhj3Rvhbjc=;
        b=TVX6ArO89L5+CfIURfPOU0duJ5kBCWmqL6h2Mq7gpAuiszKLMt/h7ZSH/Cwmte9Yjo
         eDwcxy2q7GvB1pB5sswt8+7PaCVLoN2AfjaEaAYfPlMECE0YLBRJ1Oz1iIHWu05FXGkx
         mALVryRTnwNZl1DVxC2AoBL1MKdWjnpfdPAbKSFHjxsn1/D+dtR4zSKz4OP07Tm/W5g+
         ksUAJ46WKsKmJO+DaLJVgmE0Cr0PmqaZljR39Fxb9Tjdj6eUXUMLh4kmRK362fFK168A
         6wnTVHj1lu3taVStRsmSGGx5NlZDxSrWiu7KUnrBxY/FQS0e57uF2ZGNxra5zTtKQ9za
         8Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433217; x=1728038017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T2LL56WRUoCrnPPbMQXHKo2gYqUc6Xl1Uhj3Rvhbjc=;
        b=iGTcMrag+WvP3LJIgUoATA9zkHK3ImhiZFZTvhunpxiYM/JT0R1RuCYwHqeF5m7kfF
         jKKl32kLP+Nkox2lV8BKXTRFdIoU4diTZoobsWYiLoyNJkMmexXrt5cjP9i17Cg2lVfM
         lawm4BjTHTMC9PMWNuL3TCiwJxVuqPiC8AiGDJM5fWfeO4OO4T9BfkceO8Lki3xYdkWl
         6R8+LcwURba9Rn30qkOwmIK9z7WKyCXKXVtouSeEmv2gMT3pxMwIrw0WKdF52Mm7/Wq5
         Sj0DN7JRwsjT7vLLVwljTrT4sc28rMl2ezAEWMUOnGgfus7rocOzHZmocYrqAC0/deK1
         3R+g==
X-Forwarded-Encrypted: i=1; AJvYcCUvHX7YG7EpWsIES3Lu6B2jtxQhYCDaWo+yVcCOiD9BH0sXoQVcx6PuFOuDFZVD9p4ILaxNHvguf9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOQOZIM71yBAKkSy1F0Zf3P44fX39FTNOHr3bZ10w9wU70bin
	/yQkvQbVDd/vp7vsFNooWdzD4M8UOvfWHlx4uCibSZsg+T9lSyaex9hZ0luHWds=
X-Google-Smtp-Source: AGHT+IF0zNjfWEDae/br0X7b1tX8Ys2XUZW1pqq4nWxX+EJ/ZMpO2obVuiNEzXm2wGp5BTWq0Y+Z4Q==
X-Received: by 2002:a05:6a21:3a96:b0:1d3:4675:fc06 with SMTP id adf61e73a8af0-1d4fa6212c8mr4009385637.10.1727433217215;
        Fri, 27 Sep 2024 03:33:37 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e6db2b3e22sm1352768a12.30.2024.09.27.03.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:33:36 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v10 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Fri, 27 Sep 2024 18:32:32 +0800
Message-ID: <20240927103231.24244-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notice the VMD remapped PCIe Root Port and NVMe have PCI PM L1 substates
capability, but they are disabled originally.

Here is a failed example on ASUS B1400CEAE with enabled VMD:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=0us

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

According to "PCIe r6.0, sec 5.5.4", to config the link between the PCIe
Root Port and the child device correctly:
* Ensure both devices are in D0 before enabling PCI-PM L1 PM Substates.
* Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
  LTR_L1.2_THRESHOLD are programmed properly on both devices before enable
  bits for L1.2.

Prepare this series to fix that.

Jian-Hong Pan (3):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to
    pci_enable_link_state(_locked)
  PCI: ASPM: Make pci_save_aspm_l1ss_state save both child and parent's
    L1SS configuration

 drivers/pci/controller/vmd.c | 13 +++++++----
 drivers/pci/pcie/aspm.c      | 45 +++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.46.2


