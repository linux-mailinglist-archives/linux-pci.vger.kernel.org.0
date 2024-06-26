Return-Path: <linux-pci+bounces-9278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FF917C88
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8EB1F20ECD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E816E88D;
	Wed, 26 Jun 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="mu4nQV4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5916CD06
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394209; cv=none; b=OM4iBCmF7Ls8hKpxq2jWIAXSSr385VXJq2a5OCYwmZ3QVfoCWNl1HSMXbALLVbiXZAwZ7cusQUEcE/Sr7Sz36qFy3Y9iWBVVWvWNNxY2Ky9MgVPKraFKjLptIWKD6rDGaLtX1oix8Y4R2bfHNQl6bRYwPCkg23tJI8uf4Zxq810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394209; c=relaxed/simple;
	bh=lDBfcXo4MYncJX2tMzyeD2qNceFjdFH7FKwnlwisHi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rxw/pKOKUWLPKCe4m0ORSx67pSGj6RMTrrg0tOUuwczFZof2VX1N3uOBMpqM69ziejUePzlGmJi2Y0rXt5zsoMVHE1LFpLjStl0d6e+Aj8WgrEn/vq1HChzdfAV/N/ES6ukrQw/cw6KzM9PwByasLM/GCystsbCGG09S4H9zYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=mu4nQV4T; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-711b1512aeaso5045712a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719394207; x=1719999007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxer964xgyXPeOfcKPwyWSpEHZF7G93F+GF2s3GrJcU=;
        b=mu4nQV4Tu5vgqYN51F72WtzmyXMOjUGx1ufkjaTtgoPBCP37pehdWywZK2ssqYFMIJ
         rYokYk0XJl+NucxIiTs5TXoOH+Qr6qWas6jOQ+GmqWOlQV7o57olznMxi5CsYZXAlKS4
         BPrRbRZdrXyBRK1G78z//EipbblrCwbeyEIug3qCUw6Z7TDWuugmaJFr9aesc/1p9UnL
         beu0bdrkmLWVxOzTJezN9/Xh1uy85NIoeSiqOl68C0WxX09mfKvX+XcxOELeMB0NLyKp
         OgvM0q+dNJBccAHSR7pT7t31mRyn0ICaJr0hUsecMWfmg+gWhQ+LblUrvx8imsGr6AvN
         mprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394207; x=1719999007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kxer964xgyXPeOfcKPwyWSpEHZF7G93F+GF2s3GrJcU=;
        b=xPVwfpIU06XZkc6BN0TtjZn+Pl+RUeGRKjf8R3XZ485Ac4KqY3GfK5n9ue6uwzU+Br
         2MlOAq1N9RzNST25NcnQT7XSL33n0C1lny1eaKqpsijCGBO8MVVam/m9ZDCNqR51orXI
         R5NRYOf7iQgpCXpoAK1RqrC/d0hpFnCWGg9mfBA7wRbWLp8b5qTIMF3IOzJLcQuOgmlH
         Vf8r7i86xiE6+pj9F6O08u7XCFKhF6Xcd0sK1APAMc/yddszooF0l5jSYXzjzD6CjVLj
         /WpPtaBKNskSzXUq8tfdREskG1TJK/47BvQsl1Fb07J52Yq/SkRJtMi9/T6b7gfzdEEt
         DvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0R/h3ODtEX+W6VNUotyDc2iqkmvi0cQbdqb1HA731IdS24/7G1TP62em2ZCG2xfiS7hQfdLX3ZhxgfNEIpR41xJUxDqkE4aqc
X-Gm-Message-State: AOJu0YytR0/JDs+9VEdsc6qY31+ZhbLkL1CO15HXOn+u7EJUba9lZ8GK
	BK1Y/fFFS7MKbXAE3pMVN7F/JMf80m+BZuIEzFm0TB3kNM9DSkRnCMnCdFPI9UQ=
X-Google-Smtp-Source: AGHT+IGRzPevjU9Paw4Ge6XiaKZ6yUz3NHOTZ7GhcEPpP37dPvI7RAdoZRNUCqJpp8J86vlRiioX4A==
X-Received: by 2002:a05:6a20:341b:b0:1be:b30d:3b37 with SMTP id adf61e73a8af0-1beb30d3ca6mr899340637.36.1719394206912;
        Wed, 26 Jun 2024 02:30:06 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c6ecdsm95257395ad.136.2024.06.26.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:30:06 -0700 (PDT)
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
Subject: [PATCH v7 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed, 26 Jun 2024 17:28:22 +0800
Message-ID: <20240626092821.14158-2-jhp@endlessos.org>
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

 drivers/pci/controller/vmd.c | 13 ++++++++----
 drivers/pci/pcie/aspm.c      | 40 ++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.45.2


