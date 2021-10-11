Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2D429614
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJKRxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhJKRxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:53:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A2C061570;
        Mon, 11 Oct 2021 10:51:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q19so14991198pfl.4;
        Mon, 11 Oct 2021 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/eCkgBabqgzZMoeU3aBzDcQBc9kpvi2Lrj2FSZUU1HE=;
        b=YHh9+t/+VTBC4s3ntJ//sJ/3/IIr2caH4VqARETHgUCXzk5AJvktpuzm9dE1uaz8JR
         xfjTOD7aZUQWRjbKXiGclanTMy8FIrFMav39XmnhURFykou9MBA41/JZBhSM+7F4oHLA
         SP02gBaRgAi+oh7QRziQfMLDPOty5vvLh/RP3ivWQn6Y2sB6qtOy64EiNbYPGwDrncay
         C+mDaqnykJqY0eIAz2Iz0OW+V+GdMg/ZeNJtD5NKeLGRVzSxqJEP1uOfrPqA3jU0492d
         fW5eUzfXmMfoZsHp372XsnmCWx3xGZMWZOUwL0mzcXIQAAPaFvY1njIycCdWRu30XZ95
         C7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/eCkgBabqgzZMoeU3aBzDcQBc9kpvi2Lrj2FSZUU1HE=;
        b=2EzmkW5e0Wjo2up4hPJxQl1f8YTqMTzkj1T44w7uv8k2sPb/lB+F9wvbfdBAvfSZSo
         Oo0tE/Kur79YHY2+0fhfxJBnIm9NSn6Xwy25w0/yTZZLORYOF0kT+LQIPNtQ/WJGp2kY
         q6aSBo02Zn/dO1JVwJvaQJhNRc+QhO7XnOzkN0RHJQ83Ctvk6jQ3kqwAfABDK1JvQpcK
         IXqY4D/DZTXrIXVNWkrW12mB18W1ymoBLPFpf6LcD3ZJ3lq6ONr2+RvoNVHi69ssaCjG
         ujJSfUrrDR6GA4Nv/Ra+Ut9UJl1DJoGBD7zZiJKjQRaN+d2iDF9VkZiOr9e3kX6uXHFT
         Qivg==
X-Gm-Message-State: AOAM53363BD9YJAuliIpzQI+4nLUHhS471fWLmS+TEy3RqFWlCtzOK+1
        EkzZVXDW5kFfP5UUcEiiGZQ=
X-Google-Smtp-Source: ABdhPJyoiL1u1vbuIv3pXSKqdKMc5JLSJ9ySrHxMnxgboUVF/xihVga0exmAZwG6n8zy5S27LTM1tA==
X-Received: by 2002:aa7:93ca:0:b0:44c:da51:38ac with SMTP id y10-20020aa793ca000000b0044cda5138acmr21437391pff.67.1633974698694;
        Mon, 11 Oct 2021 10:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id y6sm124618pjw.2.2021.10.11.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:51:38 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (open list:PCIE DRIVER FOR MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 05/22] PCI: mediatek: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:21:22 +0530
Message-Id: <01f0c358e3ea05510e04384c3fb5edc577523430.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2f3f974977a3..aa744ccd1a2a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -369,13 +369,13 @@ static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	port = mtk_pcie_find_port(bus, devfn);
 	if (!port) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
 	ret = mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
 	if (ret)
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 
 	return ret;
 }
-- 
2.25.1

