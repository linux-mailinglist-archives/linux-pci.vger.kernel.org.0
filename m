Return-Path: <linux-pci+bounces-6615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E635D8B0796
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D72B20E79
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD713D530;
	Wed, 24 Apr 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="SnQOrS0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43F1428F9
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955413; cv=none; b=S2a4g1HYcmxeaw+tN/Wm3DLVcOCP38yUyXa3J6XO+Wj7abPu1lrxn2wzCRQeCNy0TAi2myIDE8B9dZnYSvhOiea8snDDKJ2r72jxuafYKPnmEk+iP5GjK/XoMgKP9DE2/6S9jYLlBZVIsPOhg0RbvhVdsUJlO4lUSNXDUNEOAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955413; c=relaxed/simple;
	bh=qG7vE0cpdGC+OMPSIq4vT5R2UpbBNARbgw4Nyy956/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohFLbKhPoOZfRk+IJXLMLDT75o1XAZreXcwS7w8g9Z8CUe4TzWV78aJAD3WfA8z5YTB2TacddSA/z+B1T8hdb/grvzHvaC1rSPEOOWRcAdVHjo0ti0BZeKgMNVKksgStMdj/QpRt7iQvvk14Nx6pRrmjQEsuJsGU+epnyNyN9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=SnQOrS0U; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed627829e6so7459258b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713955411; x=1714560211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7GXKm/F50dpXqSR3wFFpE7hOEZxPmmiur/MNv+jyDU=;
        b=SnQOrS0UZWnFAL9Ifh2cJRT7gUS5IMTxMwqUY4UGpLJfXimSAH8GuseBhuzm+Gmtgx
         ilaB1q1ofvsmAQBl4esy/v/Hx667H0xx+Nn7E5pqSraTsaReWcZiQa+u630jH97+MGNT
         YRKJ9xnu+VzeQR4mdzKWGjI2yhTLUqHZkwlUNlA8zKu5SkWb1+HtJDeSKib459NjoDh7
         AA7mSrK9HoVLAJiiySZIZlopLHZjjqA8qwRaLVaUNtwiCqnXHDMoCHkvZKZtQacjn5H+
         wqGTt9FUuCvmoKOrKYiAlcOZqxmH5zyRQUuWgRF7xeX+lmB+vk4MU15CtLEEtclKwdqy
         3THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955411; x=1714560211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7GXKm/F50dpXqSR3wFFpE7hOEZxPmmiur/MNv+jyDU=;
        b=t4Ct+WCi4Pznn6rc6UaKxOSZWuom5s0853Xd6YSeZbJM3wiRUyPV3YuEZbT3EGyq/O
         mkqBmvxXNgMHSeU4mKTATf71OQ3Z/LRBEihoLovin6wOvoJinGH/JPG/u7CTGCD+uwcf
         s8/8URRNBXN6s85GPcWHdJUanuZGrtvIgsGb3WVt4iSbBL9gQHVyHexhXuHqAwKri4Wz
         WdYwOIcwYjJ1nj2Lg9XUvpQATx38AyHzQXwnDSbjPDuaLEbCHaVbPWrzR8DhF3i0w9fl
         0OflR6zxsiHiCd9P794KLY2GdqCDmknQ3jwslkmCMDNtHWcChx7QOAxQp4R8pmIaPK9g
         xasA==
X-Forwarded-Encrypted: i=1; AJvYcCUv9hzBD0AAmEqKnEKK9yP8UKoQ+eGpjHwoYwvkzYJ1PnYRQ/+HK57yeB9L3MwbWPLu+r3dQSOftBrJ2sIkT8OGFLNAPanaWACf
X-Gm-Message-State: AOJu0YzT8TWvq5JgKE1ay/P0GZuzntrNRtSv+bcMviBBKKwP9TsP6Ohe
	FbTvUAfx0AJDPhQK8JRS4OHrzG9L7IOP13o0H06P7zPyAYIO9UhLD34G8AmxPgY=
X-Google-Smtp-Source: AGHT+IHarCn/CWqIeOgpp9ZyRtpkzC5doRHGLv9Uzwl6OoYw7LUx6GIJqAt12EaQ2K4eE8xlmYUU6w==
X-Received: by 2002:a05:6a21:78a4:b0:1ad:13d:5a44 with SMTP id bf36-20020a056a2178a400b001ad013d5a44mr2344542pzc.18.1713955410612;
        Wed, 24 Apr 2024 03:43:30 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id s13-20020a17090330cd00b001e60ae3da22sm11603002plc.245.2024.04.24.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:43:30 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed, 24 Apr 2024 18:43:13 +0800
Message-ID: <20240424104313.21011-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
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

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
        	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
        	   T_CommonMode=45us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

According to "PCIe r6.0, sec 5.5.4", to config the link between the PCIe
Root Port and the child device correctly:
* Ensure both devices are in D0 before enabling PCI-PM L1 PM Substates.
* Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
  LTR_L1.2_THRESHOLD are programmed properly on both devices before enable
  bits for L1.2.

Prepare this series to fix that.

Jian-Hong Pan (4):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
  PCI/ASPM: Introduce aspm_get_l1ss_cap()
  PCI/ASPM: Fix L1.2 parameters when enable link state

 drivers/pci/controller/vmd.c | 13 ++++++++----
 drivers/pci/pcie/aspm.c      | 41 ++++++++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.44.0


