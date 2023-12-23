Return-Path: <linux-pci+bounces-1321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8ED81D699
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2541F21708
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE66115EBD;
	Sat, 23 Dec 2023 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FcVtCQXD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D718B19
	for <linux-pci@vger.kernel.org>; Sat, 23 Dec 2023 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35fea35c432so8975995ab.0
        for <linux-pci@vger.kernel.org>; Sat, 23 Dec 2023 13:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1703366568; x=1703971368; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7lmKsHU82zrwNWQQ1pGRfuym9Y1WgQ/pwv2dR/0OG8=;
        b=FcVtCQXDJ3iDhMK/IolMyUjckuYJYgpD9DCBVL+dsDa88goHRH6WKx5dxe6E8nalS1
         AUu2atclbL2RN+LqSq28mIqKX8D5jLcwVOQA3YHTIH1mLQ3POfJvCs5XhA5VMcD+8g3Z
         cqSHTwqBw7agUI17zMpxmLCyiL5RO4bqHhX9P3R6Fax7Mr9bvWWzCjOH5zoQgO1i3Ygc
         G+3TlFies2Z2E0oPjyne/PqKig+0rkKqRbAoODJ4JyntKyGp4Y0WKu9qE4eoDbeuz2FI
         /26su3qhFXfolw73E0AIQpCmBZhzdnA2uLKKlJLVeCv4sKrL0OHBUZ/+f9VTQRRXB9TA
         XnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703366568; x=1703971368;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7lmKsHU82zrwNWQQ1pGRfuym9Y1WgQ/pwv2dR/0OG8=;
        b=Q34WFsF//oZLW3N8KnMIdSLpe5kMkKhV/W5ayLentATHR2SZyxDLuAzNLTLj1fGeY8
         MkrVM55ohMT0lc8xfOuLGUtz2DC+wCWuVnUte8CH+qS+rkDhY8Nt9UHRWVRUKRX+tXk5
         PH1G1EJPIx6Nzhg4w37U+HxXk1RVFQv5fIrXAVFXTaQLo+iYIHtQpztMCvQvAl+NEhgP
         l78jh6cIz/g2qszMK+Tyw1UGE7Srob8lk+k7wUq3+QieqLz+ZoVoS4M1dBtINCvAtOlW
         SbUeV8DWOS/ZXQgN7MH4jHj1u0bEBY5PcLedRMpGevmIvcTRk38ItRjU7QlRdMCa34Uv
         Yarw==
X-Gm-Message-State: AOJu0YzWrpzXqCmXPjZllM2JuK5u4f9J0PMKDNOTdcwmjP0hclqUlkI2
	fRWhiai1Dbt3NApOolTZK0juj61TN0seO6ICfmaZH+p5QKA=
X-Google-Smtp-Source: AGHT+IFlLeIs/iEkpPooaeEp+02k81cDHr/bf+NvU1W5uCOcaCFfw45drgM2wNaFPj0cMI3aZZrq5Q==
X-Received: by 2002:a05:6e02:2144:b0:35f:d8f3:10ca with SMTP id d4-20020a056e02214400b0035fd8f310camr5240470ilv.23.1703366568067;
        Sat, 23 Dec 2023 13:22:48 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id pt13-20020a17090b3d0d00b002858ac5e401sm3603775pjb.45.2023.12.23.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 13:22:47 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org,
	mika.westerberg@linux.intel.com
Cc: Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
Date: Sat, 23 Dec 2023 14:22:34 -0700
Message-Id: <20231223212235.34293-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

During our kernel version migration we encountered an issue preventing DPC
from being used by the kernel on the downstream ports of PCIe switches.
After some review of the patch history & code we found that the kernel
now required pcie_ports=dpc-native command line argument for such devices.
This came after we picked up:
    "PCI/portdrv: Allow AER service only for Root Ports & RCECs"

Belief is that the above patch is 'more correct' on the AER side, but perhaps
'less correct' on DPC. I initially reached out in the patch's email
thread to see whether others had thoughts & whether this change might be
desireable after which I was asked if I would submit a patch. Took a little
time to read some of the ACPI/PCIe specifications which are the basis of my
beliefs about the correctness of this patch. That being, if a user builds the
kernel with DPC/AER & the kernel receives OS control over AER, then it should
automatically use AER & DPC where applicable in the PCIe hierarchy.

Matthew W Carlis (1):
  PCI/portdrv: Allow DPC if the OS controls AER natively.

 drivers/pci/pcie/portdrv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
-- 
2.17.1


