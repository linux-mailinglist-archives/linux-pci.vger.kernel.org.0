Return-Path: <linux-pci+bounces-9169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1191444D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97069B2211B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25104964D;
	Mon, 24 Jun 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="NFNVrUh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A04963B
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216701; cv=none; b=ef5/HaaWWuRiBcPVra6gynUnaSxW1mHF6xzx+7G73LXb7cvUUB8KU2E0ClqAVhPt+loi/cHMCC5a5UkmGB7y/WDFEM5cTCFFkvSKEmpe0fVCmvOwjXg4/6lBBxW3N6XeVf2j+Iajy1lEBrOWmKGP8UbOA3ouGasd8gng9ck742Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216701; c=relaxed/simple;
	bh=7ksf9aEJgz40hmVhyKxMXv3XhkOYeMUS0Ab3WjDTLl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J64f9y/AO7eNYqksU1xLnbIbk7GSlYHnI8YsQCv+FfNbBsyasedrXwW76bM2Nql42ccUEXfCwuH3brQFWuvh0VFJ2QD8AYIlV/7n7Qi3ojmZT/3PFgwByPBsQkm6WxyUNNxd3joonxkP3FgVzJTZ771Mj1rJ2tV1OSwVNlxsW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=NFNVrUh8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so2212078a34.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719216698; x=1719821498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bWqdbh6piHPKQhakpLxXBJ7wWL09Ug+BBJfp1dagVs=;
        b=NFNVrUh8ypK+nqVCM4JPo/TGpR/ZF+XoFwVfcFvmESi08p7X7UHBMPyl4ZHggRjCGw
         3W2vN4Wu/bmnJrPnfZYq6sCg+JjoTtGsPc+4H56ebOrJ4DokJvlbjb9qX+KV8ijFbkxK
         Q8mBBId7nyyzM55g6E7DQWQYl9S1z/4at98m6oUuJlSl4oXemFV96Nsgy3Q4PUuFhF5M
         fXPVAlMqSeo5gHPrRebmWcyZTilf/PnWTseUE9/9/HT7SP7hwfp10fIm4cyN74UcQthN
         GuE5Y87p6Q5WMK7+8KBMfyDg9L1P2MG7GrctahdeTYvgCqGc41jV0IzSb0okk+9tagvR
         7iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216698; x=1719821498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bWqdbh6piHPKQhakpLxXBJ7wWL09Ug+BBJfp1dagVs=;
        b=dW0V79Zhpb5J4lNqSFYXjpVePmp/CTZQEIVcoxtAV8I923AO1sxFJw7veWsEOGo4FR
         NwH82HxKpc4MLIevcCPPEYX34BdaZ86HBzrQgh1OVx+x2pXhDdvhpnNGU0jUsWAAnSnx
         bzdiP+nAO1yKsPq+iPYAbsne2WmX8N6aqUZbphPlauiyhEm2ycXj5Vt4sIT3Oa4og7S4
         FZBSUICtt9p8gpx492rH/g6ntFxh9P32hbddvQ6iOdiFaFnNjIL+MSyiKHbH3YauZzeB
         FI8Vc4gKJMTObapVmDWpZhHALQTt6uEIczZKHG9Otiu/sOhor1gXLefAPmqpTItVkHkA
         Qx4A==
X-Forwarded-Encrypted: i=1; AJvYcCU+KyO8UHy2CliRiz4qrsh7XcDbAo9JVQ11m+uO72pAa5sUPbw98SHuelTbZdKm/wm/X/os0ICljWbwfKVk9Br58t2ruhH2jp/0
X-Gm-Message-State: AOJu0YzQQ6phfL9VdVfoKdZnYULcf3YByJlpwUbOPSaJFfODmw8dlD2t
	LY0xguYW8oEvybpcYde/3b1iRpKMzzNVFJWOt3aSjnv1849WPuoDj56ZPmZBF9I=
X-Google-Smtp-Source: AGHT+IEaD5GBtPT/cw1JX323PXaFx8ViNSmytQEEvMG0JYhColsoY+4Z2lL2dbJKPQGt8NpfTxHGNw==
X-Received: by 2002:a9d:5e19:0:b0:6f9:5e9b:66e4 with SMTP id 46e09a7af769-700b11d1d80mr4261590a34.15.1719216698044;
        Mon, 24 Jun 2024 01:11:38 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-716bb22dffesm5029841a12.83.2024.06.24.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:11:37 -0700 (PDT)
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
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v6 0/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Mon, 24 Jun 2024 16:11:09 +0800
Message-ID: <20240624081108.10143-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
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

Jian-Hong Pan (3):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to
    pci_enable_link_state(_locked)
  PCI: vmd: Drop resetting PCI bus action after scan mapped PCI child
    bus

 drivers/pci/controller/vmd.c | 33 +++++++++------------------------
 drivers/pci/pcie/aspm.c      |  6 ++++++
 2 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.45.2


