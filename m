Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80485354FD3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhDFJ1F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhDFJ1B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 05:27:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD68C06175F
        for <linux-pci@vger.kernel.org>; Tue,  6 Apr 2021 02:26:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h20so7152145plr.4
        for <linux-pci@vger.kernel.org>; Tue, 06 Apr 2021 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QOCh/TS5wxbMixJ7U1RoahsowYw6MPj7syv0qXToETI=;
        b=lI5tVV2yDAzz7e1tnKcgvqSovfgVxfD18FAIeJjDz//r87E3zOaeTmrRK7bahyDyQH
         R9X+WHgEkguRKH29Zxorkw52MLCmvabrmYPy1rQ0ftmCD2ObkZsSNEiNSgVWbx/zghF8
         sxRSs0p8CU4E95PQvYQwcjVQZQlurTNLIgFDDWqhz+zPt33MRPebvbA4gqur571xoKBy
         7pXLxP3AyxiQqHGwehW4i/MCjWgUYSB8LuSSpQv5zqfRtOueMOLv5AdJjPjDSe9hWNwf
         wQr6oLmmS4pOok88qt7IKd8nUIPJQlWgcUA6FFzjAukUrxaWrC7SvRdl+PygbxiNTq4H
         QqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOCh/TS5wxbMixJ7U1RoahsowYw6MPj7syv0qXToETI=;
        b=kUtjYJAscdEu6l05j9+c5XuOTSuu7e3PjmTtP4UWF+sqDoX9zRPuc2n9z4YbGM+FeY
         +QFhQHK3NbiV7btMEi4aJukukkWy0hZqRB8kYYQtbTfqvhrPh1LLpKiCXuu5r26DRb6c
         4/DjXqSypZr3hh0kE6qqHQfz/bhHpjkQy0FUVwvFDFC/qeERCku4O3N0w+bGFbPPqDPi
         gtn9SNQS9KFnyXNKyJ5eXDM/+zzTOvmXSOVD3FuoH1/GVZhSnczwSNe1XnaaKMayWBoK
         pMnWy+Sesg6hhFsYXuNEvzXOst3E3c65Oo8nWICxuL0OzwE0c5PqNRyY2rDJ7hB/LWEN
         5nSw==
X-Gm-Message-State: AOAM530Gpo81+ZDps72eq9oYqtOHaHlZzLk2JC49x7hzMZes/X3mqOoh
        rv2RzRf93NTrlpOOlyztpJmoww==
X-Google-Smtp-Source: ABdhPJyR+AncM1qKHlAzc7v8aepcx01Ey2zQhnySckLmGADxiw7G6zWwQDXO0ndDTD9JDdv9Twnm/w==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr3469120pjy.133.1617701213304;
        Tue, 06 Apr 2021 02:26:53 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w7sm13685589pff.208.2021.04.06.02.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:26:52 -0700 (PDT)
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
Subject: [PATCH v5 3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
Date:   Tue,  6 Apr 2021 17:26:31 +0800
Message-Id: <20210406092634.50465-4-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406092634.50465-1-greentime.hu@sifive.com>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
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

