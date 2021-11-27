Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4C45FF01
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhK0OKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355184AbhK0OIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:08:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D3C061574
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:04:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i12so10442345wmq.4
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCdeKtahZuwgihEDa3jpfYcCx7XYaTIuoBcydH+txEk=;
        b=F4bJFyAsGhHIeb+0+KV4Og3mjVoWXeCxJKDIwA8t0tWJv6IXUqVVmpZG9mUKkKbAL1
         WAv7F36XwUQZxxpET/QIx4qm89qB5WBO31Asgw4WuN4yvrDzLypIBWm98+RAzJFBKSAi
         JygQIRtWCfsHoUC8y7VVrZUvN+zaBu+e64pk2QYFuiJxB9F3xJ5bGw8gbSu6U10INawz
         2Mvigjq7drcfMw6Sjmwb4F9U+uJp+EemMVKqnX/3uB7ln3FnzLE3ryxSerw2xIEuExez
         V/Pr6qyya0O+3EZ3bxTjT6cNaWTk4kDwSYuKjd0r8Y5x3M4uelwbf3bh1FrkCaLwsi41
         o6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCdeKtahZuwgihEDa3jpfYcCx7XYaTIuoBcydH+txEk=;
        b=rw0eDi3e2U0uvyin/Ev84+4a66QJvIV/M2v9yhEU2sr+/OW/QmGcf4sRcbdFP1USAP
         WF5fgSQlfbYQA+/TpLC0mOB6U+5qbKvLOy8Tx8NAf7JwzI3ir2ipj7z6PYy2pdEPguNG
         fBOfuEawX19olxsLSPbUzLC1Gr6YCVY2MqDw6Z5wCga2dvaysaEsrIFhLLb8Ej+IaDUs
         dpqwfPP21riXFRycgpEb2pd5t+bgFn0Imsd0LegcRUbQLGL6YwLmQnItqf93Gy2GrFND
         7LygTIUFJSKg1T6uYf0n0SPvrd2lXGIt/fFqQGw62cTlxCv5+1fqPmeas44ZXzNO7YgX
         kZ9Q==
X-Gm-Message-State: AOAM533RSpO9Z81ci2ymCsRz7T1hBnvCVhA+fsvnq9Hsa6Uz7DTsG8ca
        QSnzv6Xsp3PoTspkAgQF3H4=
X-Google-Smtp-Source: ABdhPJxEKHdIrhCMti8Ie7wRoqrGDZq0WyAWLHbXtGsxCSRFWD26RSFJ88eP+5xN+kVWz/NNkTIs0g==
X-Received: by 2002:a05:600c:3c8a:: with SMTP id bg10mr23236279wmb.106.1638021893916;
        Sat, 27 Nov 2021 06:04:53 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id w7sm8447071wru.51.2021.11.27.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:04:53 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/6] Unify controller structure name 
Date:   Sat, 27 Nov 2021 15:04:37 +0100
Message-Id: <cover.1638021831.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Controllrt structure name of some PCI drivers does not match the convention
struct of other PCI driver, namely <driver>_pcie, e.g. xgene_pcie_port,
intel_pcie_port, xilinx_pcie_port, uniphier_pcie_priv, tegra_pcie_dw,
mk_pcie_dw. Unify them to the convetion. Some instantiation name of the
struct name, e.g. port, priv,  are also unified to 'pcie'.


Fan Fei (6):
  PCI: xgene: Rename struct xgene_pcie_port to xgene_pcie
  PCI: intel-gw: Rename struct intel_pcie_port to intel_pcie
  PCI: uniphier: Rename struct uniphier_pcie_priv to uniphier_pcie
  PCI: tegra194: Rename struct tegra_pcie_dw to tegra194_pcie
  PCI: xilinx: Rename struct xilinx_pcie_port to xilinx_pcie
  PCI: mediatek-gen3: Rename struct mtk_pcie_port to mtk_gen_pcie

 drivers/pci/controller/dwc/pcie-intel-gw.c  | 204 +++++------
 drivers/pci/controller/dwc/pcie-tegra194.c  | 120 +++----
 drivers/pci/controller/dwc/pcie-uniphier.c  | 159 +++++----
 drivers/pci/controller/pci-xgene.c          |  46 +--
 drivers/pci/controller/pcie-mediatek-gen3.c | 370 ++++++++++----------
 drivers/pci/controller/pcie-xilinx.c        | 154 ++++----
 6 files changed, 534 insertions(+), 519 deletions(-)

-- 
2.25.1

