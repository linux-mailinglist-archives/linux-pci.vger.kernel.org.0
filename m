Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3809B3127D0
	for <lists+linux-pci@lfdr.de>; Sun,  7 Feb 2021 23:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGWQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Feb 2021 17:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGWQw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Feb 2021 17:16:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DAC06174A;
        Sun,  7 Feb 2021 14:16:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d3so19420063lfg.10;
        Sun, 07 Feb 2021 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amw+arajV2h5jip6V0/FYm9nsxnyFJgWfDun4yL2hWo=;
        b=Qxz3qIx4N/K/ylzxBOh9LpEAJVJER0i3fj5x5/b4eYTiPdgZowWin7i0TJhL3YBGYX
         nqUU4rin5JIo4EF9yw/Ct4YDapLRWVueBm8FZguVaNpmhpn+GUSOGOmHQfmxdEFFuC8Q
         813WjLZU5WM+3YdNjdP3GZc3hhKDoeAQ+3MLzwtsQuRjmFv8VXnCZ9LMS87ggn6rN8XO
         a10sgapTHYd7EqRAsKEysMqnlXuw5Tq4yMN53oCC8rKkoZ5naGSafn231Ih80kr3ro0R
         QjVuXaiMF5Rp3GSxU1lln7BDoxWUMov4gzapyFc+Rl2Tgj+MrexZG5WmBVVlMKGqGCQX
         UtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amw+arajV2h5jip6V0/FYm9nsxnyFJgWfDun4yL2hWo=;
        b=Je20lzumsezgDfAP2CJ6rJRtNzPAReP+L5hWVT0CXJEakDpJAyNPq2LaBCmPSadMZL
         IzibS6DFGC2QM6Hh0nADWVwVhRCT08n9QxILyhFEq0GE/L0gfzVe4bWOIKXX1M0NzV5O
         EYm01xcnW8WvrhWstClcgNppP7eZpN1ZmPMh6rQrBwLMG2RP7ZSmQrXJwrtEfP5TbiQk
         OBoKN6smJA/tDk75dkf8xCSUFOQ0vaJ91l0WOKHWJuZVax5gU8+wSKomlaZ5Hmy60BB7
         GTokmZDgVOFitI4E4xeY0mM7iVWujaE78uQGgUKqy64DDDsbHhmeeh/cpUDrq7Vti3dq
         ZJ1g==
X-Gm-Message-State: AOAM531XX5ecHHQ/yRN0s2DE3fntsPHD6RGBHgczPrTOk7mxzIRk2cix
        AlwSKP9ALLnyym8thhEgOS++lgJq58BchQ==
X-Google-Smtp-Source: ABdhPJyjaJRB143WhUN8+rLijJv2/iICLgKR/rcd245VCxOBQw4+5emTlBYz3D77P7u2f2YLo877sg==
X-Received: by 2002:ac2:5639:: with SMTP id b25mr8348018lff.370.1612736170304;
        Sun, 07 Feb 2021 14:16:10 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id y25sm1873866lfe.20.2021.02.07.14.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 14:16:09 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] PCI: tegra: Constify static structs
Date:   Sun,  7 Feb 2021 23:16:04 +0100
Message-Id: <20210207221604.48910-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The only usage of them is to assign their address to the 'ops' field in
the pcie_port and the dw_pcie_ep structs, both which are pointers to
const. Make them const to allow the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6fa216e52d14..18acd48e8e9b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1019,7 +1019,7 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 	.stop_link = tegra_pcie_dw_stop_link,
 };
 
-static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
+static const struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
 	.host_init = tegra_pcie_dw_host_init,
 };
 
@@ -1881,7 +1881,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 	return &tegra_pcie_epc_features;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
-- 
2.30.0

