Return-Path: <linux-pci+bounces-10540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18973937491
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95B4281FD2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70122C80;
	Fri, 19 Jul 2024 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="pg0YvKPy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591B4AEEA
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375553; cv=none; b=bAucSYsBleFkox6K7REQNK9NJT9IkM9iDqZHxomMQnlEagCi9Wdf84PXhmWBogI+RIy5S3IIUSitf0r0mZljfsLmb90Xbg6LZPO8SH8LnPLejrQyghGb2UhhuEVx1O5yhMhRmarvCgTMY/Js8dtiPhOTwmVHbd+lA9+0lbA+ZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375553; c=relaxed/simple;
	bh=qP6PS8j+5yMOFD4CbCQZisOY5HUz99JCpst3NMXxIhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqq5LWYLjaaMmsW7RZaykbDI/mp/YxmP4/rxikKLa3P+WvF0ohmjgzfkAiS3UHEiLNbJIy7b7HY6TDZX2dZR+OxEZxyvjD9TSGTp4XiYueo2EEqRjUNFce9nzDdZppRLTk5aNg9etocKZ6//PaVskAmDrH/yFIWBUKpK/rev7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=pg0YvKPy; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so1693624276.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721375550; x=1721980350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55aXfChwRcmllhGH8VjIHFF0gPthm76qm4vIrxGKr+I=;
        b=pg0YvKPyXVYpACTRg6GdUHfIf3moMja8XFenxtfsPEtg9el4V5F0RFGf0rbHXqFjVD
         Mf9p7FSYAB76hTDaaC6KHe5nTgwVDucEW8dsVyiE35UvUgWKx/kkbojw78GIA8o0YF3k
         T046qv7BO9m+N2+ERbaqZz/KHSj6DqSdTJAulO+tw2+0ziguqDvLuhBSZh0Rq0FDzAGy
         ot3C2tzR75sZqdEhtGO0PrWD5C64GdJ4o1Oswipk4tjQnrdG1x+jhWJSlBVMKKMz9H9s
         MNBxVxnoNNt3IMAMHgggA2TW+T26gGzOJ6avJyHquloHbTi5byOz29durTfJmJXfBH6u
         sR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375550; x=1721980350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55aXfChwRcmllhGH8VjIHFF0gPthm76qm4vIrxGKr+I=;
        b=g15MUAmXXEm3y5YirtP2GaZdOf++SzYdxee9dbvOUtITsXo+7x+XlH+atV5AsjJyag
         nI9wK6J2aG7KZomXnlBmwfuNdJvbdUuU4+aZ/CJY9tDEs7K+tnzbH9w/+QUHTLdQwrLG
         pqSYRLYgBQtk2vZAEoLM8xVOgDXrOcA+RTMn+t0h35TVICPG4yOStOud0zH4e1GmBnU6
         As2nVipPNy05y/HlDrRj6S52GXHaypwMAp/xZpdVMcP1vpN5ZGPPfX0X2uHDKAp7QU89
         B1NQDUCPYsEasae896cCn82LTPk3T0b07Xj5BD6Q0fC8esDZiAnfWdq7K5ONINT9BUti
         n0QA==
X-Forwarded-Encrypted: i=1; AJvYcCUiYcyxZZ0Mtmz+spqFdJh6vz5O/RNgLDPzqF2sYoV+34G7aHTWUVFJ7JXYM+j9kSR60sp0j5VXO122pvG/kJ8sRtFcM3r+MBH7
X-Gm-Message-State: AOJu0Yyg49NG7xXCmkutyKuNNcaT1jBFWfOUEBv3GxHZzmKEyeYVexMl
	csz8WL9wIgHGNMB4gGzgIQnCEc5X5+XZq/VgkrJj05Ty80i18Jfr65McpA3hn4s=
X-Google-Smtp-Source: AGHT+IGmB1lgAWBoLGChS81Kvh4nHyCJovCQaeGnWYLxM/BVslhDq5ar7EVQGbKHOwQE0Um/ZCVzmA==
X-Received: by 2002:a05:6902:a85:b0:dfb:6ff:403e with SMTP id 3f1490d57ef6-e05feadc1b5mr6417137276.13.1721375550471;
        Fri, 19 Jul 2024 00:52:30 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-79db6cba71bsm577428a12.40.2024.07.19.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:52:30 -0700 (PDT)
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
Subject: [PATCH v8 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Fri, 19 Jul 2024 15:52:01 +0800
Message-ID: <20240719075200.10717-2-jhp@endlessos.org>
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

Jian-Hong Pan (4):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to
    pci_enable_link_state(_locked)
  PCI/ASPM: Introduce aspm_get_l1ss_cap()
  PCI/ASPM: Fix L1.2 parameters when enable link state

 drivers/pci/controller/vmd.c | 13 +++++++----
 drivers/pci/pcie/aspm.c      | 44 ++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.45.2


