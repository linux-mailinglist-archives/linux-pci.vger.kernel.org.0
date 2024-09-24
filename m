Return-Path: <linux-pci+bounces-13416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8182983D97
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 09:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F2A1C21BF2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720152F870;
	Tue, 24 Sep 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="di5CXtYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB11BC3F
	for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161804; cv=none; b=mLn+LYBMBrrbEYtXv/qzToQ6uH0vFTAucwLQ6ce7YGyNYcCRrq2x9YX2a4TC5AYF/vsiS/jIEw5ooRGYvXxu4+P0aCf+JKidkNzmUxe0ROc1VOO4iHPMcuzX36e4Sq8vQZiFT7+GzYRRaZJz1Q7KJq9CImDbJc6zDn2Z/6gsFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161804; c=relaxed/simple;
	bh=QPajdV22rZnihgKAIkWl2EaW7aKjLgMWaHnc9ibIl/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLQcBTc+tP8LuK+HwaAYg9CzYHCWOrxDegx+5fX9xYHGgU58k81fTPe1REdgrmgFOewLwAaRiiTBbLOG26Zjzx4xCzmmiPsiYOA77kCbKfgZD85cxVZeYNt+/A40JzO94y44uQnxQD6JMUw0MQ+8dtZExKVP0u+wHamPlaocDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=di5CXtYJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so4235247a12.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727161802; x=1727766602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzo2H8d6ZWSTpRzfllRZ8YXEGlJS6NEXcuxM94LSSQE=;
        b=di5CXtYJ0taivy5wJzYEafdQ9Fqkc5CqyEvPSMmSp7U2hMAtk/GFetL+2yw6BHu8CB
         wigUkzJgJgRzQRF5Hga3NTRYmt7J3EMaMjOSw4gVaREXAXGJhsb81eiWa7cXl57H7w/9
         4p1Hh/7rogBQxyxEf3UFZhK5AEZ9JSK0BFrqnrOI7iWkgWcEQSOWLUSxRXNCmzgnvnZ9
         aAf35pjENAmsdqMsRdmTXKsJV0N5uQs4x1yIjHbF6rrZDHiju4KRf+jtFM9zDdc8nukf
         b/7C4gHSsVkswENh5MfmTJFsXcVGVCZyzOzVIuqEbZFgEArO9oi75gfnUNpTp9+3Qbai
         /9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161802; x=1727766602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzo2H8d6ZWSTpRzfllRZ8YXEGlJS6NEXcuxM94LSSQE=;
        b=WILFB38IymJg2FbXoOmoy+/vYP72kvW5Po6tozB/jNzR/O5kOHpUSJawHyDwKfyesu
         0MWcBa1bEZTSZP1XuIqbkC6jseFmCH+mdt4YP7SvetxpJ0xSOTep8PWS9hrC1usUaTSR
         VLIAx5mDepCS307KLKgaTrFkRrk0M7l5aBTfvIJkbsgp7YhCWBVEwVCopDGWaK/HUk4O
         mMUEzyu1GSkNng9d9c8h5Hr34dvDZ5unEkcwjPL2dxltj75qbjcal01TjYCWjo/yrbj5
         bSZB6rtHHdksTqstP1ryWlIQvNFeYD5omvkFTfE13BfMohFHb+LbJkOO3JjoyDMBs2cJ
         8HNA==
X-Forwarded-Encrypted: i=1; AJvYcCVUq0yK0vxwOEvMbPJv2yHurXWnsgBtWtwIxYW8NgTxmJkL4WcdZnQGqjcQBOLw7/8cp5W756gMY/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9007c5sRsftT2lGxbEwsoVgUTD34kgW8+mf/eDzX1kbY4Mp0T
	VvlksjEPV1SiXPUtUiHZ6srsquNHS1QrSIpOiNI5MiyOzikZIGsjD8hbfa1DPzw=
X-Google-Smtp-Source: AGHT+IGAFKrprsXiQuE02+8ygPUIUIiNGbBL7e1XZs0OIl0s6BrWWlUm2V1FPuDQvpu3rjJNUiLviQ==
X-Received: by 2002:a17:90a:8a8d:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2e05686e640mr3358513a91.15.1727161801847;
        Tue, 24 Sep 2024 00:10:01 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee98b8dsm10584472a91.16.2024.09.24.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:10:01 -0700 (PDT)
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
Subject: [PATCH v9 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Tue, 24 Sep 2024 15:05:52 +0800
Message-ID: <20240924070551.14976-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.1
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
  PCI: vmd: Save/restore PCIe bridge states before/after pci_reset_bus()

 drivers/pci/controller/vmd.c | 20 ++++++++++++++++----
 drivers/pci/pcie/aspm.c      |  6 ++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.46.1


