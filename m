Return-Path: <linux-pci+bounces-6617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DC8B07D6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B97028234D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20F159908;
	Wed, 24 Apr 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="hYjytBgs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDD13DBB6
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956324; cv=none; b=eIxITEuoPI7hYJZdBSYGAblKpVT9n76zikoz+dZb7LmK5TvSE0CzeX+h+PDu05pSeE3dndtgJwh+Knah0irij5Tr1vGXFXOSKOkLHw8jQOTVxORSrhA8rqwyBrX7xcLfcYXgV4SMSAhVjT7yvngjgQVLkeckCp0udV0uqdrWoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956324; c=relaxed/simple;
	bh=kD/apsZpQUjTX7GTpEZPSs6owgYA8C9LjrS5GfwTJcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiK7RxsIoTM7EmVVVObT6nyfHUvkQyCMLKNgDmsaLLfPqtS+Quc8wrudjdk53lTiEYUAWJoRzerLzq0UGFl2dgffS4BWCC38NpN/IaI+4gEWWIIgYU4fdO7adt5Pw6fpdwQvAjJY9c+VdKq3hbuQ/dV3cj8pBSda5Dq35cnbhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=hYjytBgs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso4496556a91.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956321; x=1714561121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRfjSJt5RkWOkpKr1nWCFYWHFIH729SNz+JrUUaI0rQ=;
        b=hYjytBgsUxKlNk/qnPTBZX40M22NkvcFBcmI8ueiotcO2917/SDH7T9FpBcp+zn+e0
         Wxw//VpBsJ5JEO0ETnBF0S55ZkbClQbdW3jTEO2o5bnAXECLS8hiORKvlcU7a6UUGs0R
         CB0PieFb50sA9MEgutret3WmRn9gqxyQr6tZvo3RZRrQ0q437Gmep4Y3I5T9vPBYkvtW
         CuC2TLrpCa8Z1BMdFcAW4dPBMYYbQa8kGLWpVV9NgI2CJrOGQ5fduQl945i9zskUed1i
         0iHwXJsm3aRbBh1Z3U+AAYbtG+HiQq12aX33VrqzSYjCltDTUU+hj/Rx2Be1ILsAoZzA
         a/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956321; x=1714561121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRfjSJt5RkWOkpKr1nWCFYWHFIH729SNz+JrUUaI0rQ=;
        b=WI/Po2Q5V+WEShXBMyhbBEA7/6dirb/1xE/S6PsysBzmQX4m4a5DqcvrwDPKTFdlP9
         DCmhOaztEJ/8b7Y6rVvsSkZUVI0xekA2459lim4bfV2eNzqwKcLxaxTAFq4i2YzIvWNW
         BmiPd4JvUxMjEM4HLWmJt8jxK8PGy6izCEPDPoNz6E+HwkPsvKnzK+PYg7vOTMmisv0c
         hrLdd8NtX6232zCML6pA0wdzYQoGSy3JN4UqEMMmW4iSM2mFqZLpsciIRHyVZDFxwALI
         iDfOAKsq1ZF78wEGgONutxYBZ6mLz9WW6Wn/eUGHLdDh1+7qotWdWMUvPOdZQchniZdQ
         t/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWG4qReYKfdgw+Fi7roFNswb1sAnQzNm+H+tuIbpKtVup1bPm6dHUs+3vYRajQB5EBiiCcGcryxkd55KP2+hDCOh47aWs1BV3YU
X-Gm-Message-State: AOJu0YxJbCCY02hDwZnaJciRN30vTZcS9cASIOOzQXofj4tZ6vVj1z9Q
	fWjpGDXf2F9/L9Mkr00xkh0NiK0uwxhCeJQOJ2pkglNKbnzWIV8s/70zAZGdgpY=
X-Google-Smtp-Source: AGHT+IFKwBUnoOK2cd/JCwlF3MM8wqAOfAu2VAcCmWPnhbbCxfrg7Jje/eziYBdrDq8HoubQ0JQnoQ==
X-Received: by 2002:a17:90b:b14:b0:2a8:1fdf:b1b0 with SMTP id bf20-20020a17090b0b1400b002a81fdfb1b0mr1729628pjb.29.1713956321493;
        Wed, 24 Apr 2024 03:58:41 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id cu22-20020a17090afa9600b002ac5335f554sm957852pjb.1.2024.04.24.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:58:40 -0700 (PDT)
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
Subject: [PATCH v5 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed, 24 Apr 2024 18:58:15 +0800
Message-ID: <20240424105814.21690-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-send for the version information.

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


