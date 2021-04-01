Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1BA350EB5
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 08:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDAGBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhDAGBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 02:01:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664BC061788
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d8so460822plh.11
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QOCh/TS5wxbMixJ7U1RoahsowYw6MPj7syv0qXToETI=;
        b=iPjWyKtkwhzUHTxPcjnT4icYgXJ7zeDUmfzg9v5YkSf5p3CwKPx6bI7A7SoN6Syojb
         +X/YcY+mMV2reL7FiisXXKwUCnCFbegv+dR+mgozFG9QthGF/cvRGbx4ItscX/pzmjSr
         YdbNQIUOdkiZRfFVSyX/4vhaHdDRmeClwLKm5jF38Bg9Qh6oQWsn3wuwt2HjMpzI2teg
         XligTyJSVmA/gqRO4F3zNX/TjnOr+h7Iqv5vJaQSsxNnWsyDRJqxd9sd+35b2VkgwnDC
         1ox57sHJ1mYlfIf7EduwYwidHRP+6Rw4en/UcSGLsJ1HHBChwm1dc2jcws0hzVnRp1PB
         sKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOCh/TS5wxbMixJ7U1RoahsowYw6MPj7syv0qXToETI=;
        b=JDjnQimKI8C8ENeicfvVIF47XHadwMptk5fxOEGu8oxHZJE8UQUSj81MamQHL8oPQm
         LxPsOWGvVlbxDmZYURj7t4wMhasuaDgPN11OB+FUUeoDMy/M2UK5iJhzZOd8iyHLpvtr
         Uq8F1XVCBhioKiFtdQQGGnGuZ03Ko+GDe09BX9z3RnXLhcHGSOksPE1mfBm2CbTiKRQy
         VppO0C6aFjKJzZmqszJwCEt3q2bvOK2YuTC0A2c+wL176/XvVNhj0hJ/IkRGbwzzQhwV
         cTYVtmiybeRdUNYXFlu981Gba17xF3nxBIwAalpuNZQaLCqC5GYPfXYvYXA4mi4H/eQN
         0APA==
X-Gm-Message-State: AOAM531YGdNPbJhtESTF/crULtdzP+L/fse6EAyBZMW+mgFMFfMTuMm6
        4RYAlf8fYz6/fukRvgN2QG3/Sg==
X-Google-Smtp-Source: ABdhPJy4PCdLb+qz9XgaXNOzMe05wTqJNbB/uYxc86af5nogDmNs+NbnIcxuL9wZclBB8UWU1DpfJQ==
X-Received: by 2002:a17:90b:3551:: with SMTP id lt17mr7247531pjb.1.1617256872902;
        Wed, 31 Mar 2021 23:01:12 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id a6sm4037328pfc.61.2021.03.31.23.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:01:12 -0700 (PDT)
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
Subject: [PATCH v4 3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
Date:   Thu,  1 Apr 2021 14:00:51 +0800
Message-Id: <20210401060054.40788-4-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401060054.40788-1-greentime.hu@sifive.com>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
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
index bfc1b86e3e73..4da888be6e80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13592,6 +13592,14 @@ S:	Maintained
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
2.30.2

