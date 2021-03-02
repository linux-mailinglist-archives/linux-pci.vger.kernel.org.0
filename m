Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E440232B1B3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhCCBzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349673AbhCBLDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 06:03:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED120C06121E
        for <linux-pci@vger.kernel.org>; Tue,  2 Mar 2021 02:59:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s23so1731670pji.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Mar 2021 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/USle6rtqTPO64EisM9sX8IiqldHS5gOFIC7i3hO5BU=;
        b=LRtiAF9kbHh5VuCDJBNTBZRw0JqzCn2GorHa0OaGv3KuZF0ituHBFJPADTShwCpl9d
         6yigVY58onm1SZPyKwdir7rH63l99cfavgctu8xlWQoInrPFd1Fy8f2Creu4aJ4EDifF
         Ch4ZhnW9Ob1S+QS7KViyOQI1HKr+DJwKQ7kj0R2x7rtNHrEkndwu55//0+kP5FR/JKy6
         iNqOLo9t8C8yCSj7wQulxbUQJN71aYe8XHD0dSvE6s+Kl+u5n1oNj7sn8DAqcsRQtLmD
         CJR0zapJ3GDCfSbmHPExNCc1/czX5L1vXOXS46gDkagjf+JVz7VvMe0BIrbvP1CMpXgV
         XpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/USle6rtqTPO64EisM9sX8IiqldHS5gOFIC7i3hO5BU=;
        b=d6uyueSjquajyzgNWtIp3D/+5ZwKZPxOW7SBVlfBrmdu0pIIWHeqbciLklv/BbPHDQ
         ye910i4ifDlSIwxPmwPqdEp2Zk6IDA2NKozZEpX/tvfAwgYywEEFu5uJYzJv5VdqBeXP
         bQGz/faUOvmVTErajwIbxJcYR1abOg2rqhjmi8Ct+a/mlyX54v9PnsEOa86ncMPUBne2
         0F5w99KUygj7zd2UcGKWMbb2sLjpNHKx0XhJ5KB1OuMjFMzyBuWKsb66sfi875tmvP9B
         cWmE3DmbctRNz4P+oPAWRw/CnJTp6MEpmrKmKlm2aNDq9EbrAfnES3HVrY38HGOKT9Nj
         ZjlA==
X-Gm-Message-State: AOAM533CLNDG6NKm5jfbhDq4df26ZcTm6tUwSeBqtFxOhuvRJH2XhxoW
        gc40ydfo0dOAr7b9O8KdOaIMig==
X-Google-Smtp-Source: ABdhPJzq5rLhprXNE/gziWlHFB0NKMzepHExLCYtN0zDKq662/9ZKusst83fZ3/drY3VyKZUYTvTjA==
X-Received: by 2002:a17:902:d893:b029:e3:f3ce:cc6a with SMTP id b19-20020a170902d893b02900e3f3cecc6amr3293615plz.28.1614682779630;
        Tue, 02 Mar 2021 02:59:39 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t26sm19500451pfq.208.2021.03.02.02.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:59:39 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
Date:   Tue,  2 Mar 2021 18:59:14 +0800
Message-Id: <ee829f3f47cd15a2d91a0090b4b6d6746c2e4ec7.1614681831.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614681831.git.greentime.hu@sifive.com>
References: <cover.1614681831.git.greentime.hu@sifive.com>
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
2.30.0

