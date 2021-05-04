Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C496E372955
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhEDLBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhEDLBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 07:01:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C3C061348
        for <linux-pci@vger.kernel.org>; Tue,  4 May 2021 04:00:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 10so7076817pfl.1
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/8pWgDAkL2aH5HxBeFWnGEqaMXG/w/n3EThO0NrEYI8=;
        b=gh/OHnpKwH6RKRNye83k3AGygPaflR2nHxihaD22pHgHno+5ENGuL+zrFTPIwwWA98
         nL8BHptQYSNKHAE1o3NFCdjBjxI8atrCq8dXOqROOh2jm/P5ecP6+nNfFrQwqhXDWqy+
         3sY8dVrZUnxoZhUIpgcwywXdSfEJUSNTTlxTeUz0bJ60nA78imSm9nBSvDSSdN34Gqnk
         2kgs3IeR0RKW4PsUudP/BYAGX9tofthv7T/Q8BNTKkgSnMFUsgM5FppWFp590FCbKqLW
         kS5S2jsLcIpLQcVsmSpP0vfDwVz66dXbE8BRwXeHRwYoK7lsolbpnAG+w31+flZpTc8/
         FAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8pWgDAkL2aH5HxBeFWnGEqaMXG/w/n3EThO0NrEYI8=;
        b=IX4R052uo+Rb5+YdXu3aj8uBXzWyKxfpIfmd7F6abPnForvklG+EfTovbjoWur4bOc
         Y2anacZvYGue2HSLJji9NFtBtn/W/BJzS+jMIC0X9V+tgxBE7hszS/1onzczRJopE+GK
         Zi4hP07+g8aQA78TmUsDhx7Pj132fYgLxRkYhF9qQyfCnQAIb0rGmw9AGTiEj4Gh2eCU
         lsdMth+bODcl4Vt55yuSC7zeyIo0cKG1m1uh5i7hk+XYI3p4A7U1Q/DElxahw2MRK9P5
         gXZFx5mtKm4qhf6g1JSDpgvI+sQONhfXqWShTGwO1apKaKqqIIN5IXeNwTwueZLF8gid
         UwuQ==
X-Gm-Message-State: AOAM530qcT6Kht+0pWQ+BVYYnGF7jnMtKJskpJfenAnCgVjdlAcJxRGg
        c67A8EvDjKrsOFnCXa4HyTP5SQ==
X-Google-Smtp-Source: ABdhPJzx7MRK7z4DjDkyawneHjJP95Uic1KfKF3GSUDWjeuLP93J/B6bqQwBntv0ppCaTb0kt4n3mw==
X-Received: by 2002:a63:e63:: with SMTP id 35mr22406556pgo.27.1620126025696;
        Tue, 04 May 2021 04:00:25 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id k17sm11762529pfa.68.2021.05.04.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:00:25 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v6 3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
Date:   Tue,  4 May 2021 18:59:37 +0800
Message-Id: <20210504105940.100004-4-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504105940.100004-1-greentime.hu@sifive.com>
References: <20210504105940.100004-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here add maintainer information for SiFive FU740 PCIe driver.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..295711c81bef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13699,6 +13699,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 F:	drivers/pci/controller/dwc/*imx6*
 
+PCI DRIVER FOR FU740
+M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Greentime Hu <greentime.hu@sifive.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-fu740.c
+
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
 L:	linux-pci@vger.kernel.org
-- 
2.31.1

