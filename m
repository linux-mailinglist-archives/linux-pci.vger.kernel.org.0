Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696F449C5E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhKHT1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 14:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhKHT1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 14:27:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E4C061570;
        Mon,  8 Nov 2021 11:24:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso722619pjb.0;
        Mon, 08 Nov 2021 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCDEdClF4vdMDgnBHsoSmjaYIHWGF2A+Z4xn3NG9v1w=;
        b=HCGysrxXl1ER4zmhl9YPJJYdawYbs7ddTxFQ0i49WPW3BToO6e7u6gD9auVUC2BEdt
         YAM7o2kX2jCvLVUxtAcABc412VYQKt3026QiR6bxbaMoI7JUeA7lV1TpCbq2mT4evb+b
         1N8BxMo/m5qxnJjQ9dnuj83io3qhoQXOpL17rlxHOfK/DxqlHpQ3xK0/ooboogoLlnya
         NurgKyRMkcQLXBAOmrGDItL5vLAMtdIGK2DkewWJNa83nf+VI0wPAeuE5W1S9h9Y/rSp
         2+ciCXYako7tirgvyZcraaBXAId5SSMlXNalhHlGYc14OmSuIkc84DES61ma4mIRKpAU
         Yc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCDEdClF4vdMDgnBHsoSmjaYIHWGF2A+Z4xn3NG9v1w=;
        b=DdPQ8qxLVG2QUUGNuC05khb3ucw7d+Ky/9sVhNVoHD2+Mpa9cMxmBzTnxAuuJbGmtg
         iVeDrdmK2Zh6/h4E3aw5FEJwdPCnJihi0fPrPRFD9LIjqxJfifwu6cqhdneu2GCFpoyS
         rDI2W+83fT0rDnWu6j7TNqQj8CnNqGLodb6G4FjowlOzmiHhCnZWH+oIGIHp/NFd3dTr
         /SWhPX98qW3LnoeORUzFDyxRKUz0aqIFOf167dkAeI2vqsScAont+KD+1cHD23yf5mSZ
         Nc4cJcFG/mwn3ndR1j5CM/mkW+yITsy0T2Z4bZG+n8MNmBQWfm7diFeX2Mu1jXw99Nwg
         l9aw==
X-Gm-Message-State: AOAM533IOip4F8qjtcIy85WnP6SuM6u6phwMkgEH7vu8zEXXsCR7a4UG
        7ZjnS0YsefYDlJuPdHubB5RU0PlLe4w=
X-Google-Smtp-Source: ABdhPJypWm5RLBYiHwy6o/qZj4b0PqtVUzKvqqbYsQ4+OemIaz797fo+lfzOlXhjxcebcO0el2mwLA==
X-Received: by 2002:a17:902:b28b:b0:142:4abc:ac20 with SMTP id u11-20020a170902b28b00b001424abcac20mr1396214plr.88.1636399485869;
        Mon, 08 Nov 2021 11:24:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m3sm17573242pfk.190.2021.11.08.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:24:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org (open list:MIPS),
        linux-kernel@vger.kernel.org (open list),
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 0/2] Enable PCIE_BRCMSTB on MIPS
Date:   Mon,  8 Nov 2021 11:24:30 -0800
Message-Id: <20211108192432.1589507-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series allows building the PCIE_BRCMSTB driver for
BMIPS_GENERIC. This is preliminary work to actually adding support for
PCIe host bridge changes to the 7425/29/35 MIPS-based SoCs.

The two patches are largely independent, though it might make more sense
to merge them via the PCI drivers tree?

Florian Fainelli (2):
  MIPS: BMIPS: Enable PCI Kconfig
  PCI: brcmstb: Allow building for BMIPS_GENERIC

 arch/mips/Kconfig              | 2 ++
 drivers/pci/controller/Kconfig | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1

