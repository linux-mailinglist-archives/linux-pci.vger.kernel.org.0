Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3929834FCB2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhCaJ0y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhCaJ02 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 05:26:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B8BC06175F
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so847573pjb.4
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QOCh/TS5wxbMixJ7U1RoahsowYw6MPj7syv0qXToETI=;
        b=kL+LFecEvpt1KnO0v7agfvuIZrBj13v+hAA+7CfceITGe55bf3KtOVcimzjYJK0dda
         Z4Aonvl50vLfXY5i5d+FtNe2JGr4omn6nUaMQGPM4c2dwSyl79wowtft/Gs9p99OgIXm
         Yz8q/krlDeqdTiVJ4exlQgIq78MwpN+/b12fb+u7B3iPCqAcvyNY/SeqOQd3x8NggLB8
         0V0RP59sUSdLfYcT3VBQ43iWOP2ntr1e9P4P1GOa6Rc1/R/hEq0ao6OdLj34czAQentX
         IPwcSvyiNZcdFiLSTj5ArL51+APRzUishwPt8Tj1gbEI5yAQtd8BzEX9TIbMk+Z0hXoN
         2ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOCh/TS5wxbMixJ7U1RoahsowYw6MPj7syv0qXToETI=;
        b=qkNfEm6TWCvOStBZWGr3J7kSzrM+10u7Kg9HqWpX9wtDXc8zDYtZ19JsRruedfEzbo
         4GMq8xPhZmGxu4s7fjp1Nae7rywH/qhHnA/00XWzjU55C4dTCTIMl1vaV2/gqjUreQc1
         wNoRE2pAvOMeAVBMFZIf141rrX5pp3vJgwhxZ5o5t/t1NbMiTVZJUKPte+BdgP5OiAkM
         jDcQDiEZf7S6CUdx9PdcYQYopmm6BoWHMiLM+sfJF+PXTMTitwS134facZR2wjNDJa82
         xs4cKzOlLtaYgJ2jqIOTirWQamsFNhqYofH/3oDJVzfGRJ+Jh1Ei9v4KFNnt9FwdX1Av
         1sQw==
X-Gm-Message-State: AOAM532MdDu5Wf25kv/gWZCN6wVzamhFjM/h8zY0wWcxZplVb7zvva6d
        6MTIimL1zPkPuKt4QYp95trsjA==
X-Google-Smtp-Source: ABdhPJwJBUQO0GYolGBKmMb0PNwoCaaef/TcsoGeIGfVSm95dZI6h9RQTlL+53ZjBRDGM5MvZe40cQ==
X-Received: by 2002:a17:90a:c28a:: with SMTP id f10mr2724003pjt.15.1617182788140;
        Wed, 31 Mar 2021 02:26:28 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 143sm1726505pfx.144.2021.03.31.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:26:27 -0700 (PDT)
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
Subject: [PATCH v3 3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
Date:   Wed, 31 Mar 2021 17:26:02 +0800
Message-Id: <20210331092605.105909-4-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331092605.105909-1-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com>
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

