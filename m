Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9FE3B1B07
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFWNZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhFWNZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 09:25:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46469C061766
        for <linux-pci@vger.kernel.org>; Wed, 23 Jun 2021 06:23:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s6so3421635edu.10
        for <linux-pci@vger.kernel.org>; Wed, 23 Jun 2021 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ipe1UfyfsMz5Tp2uesrFumfBRfdDn/SKw07Neys5JM=;
        b=AzFflTP1qrMoV15yRgQe4efB9nQLGcaq0JHTiiE1LBFD9T5+3rtRtI+jbHIUdxz2Vb
         OZEOEPnXEzlr+lc34zq1PcKGR/7dK+NW7YlJuxlLd3AGjozZEK9x6qqsjQjt9KN4Mnw4
         JFK/sYZrcXykaQLWL23owFgYkkH4KJfV0n5Ks1fQDU1xzDjmSAiyegOuPow7sPwTCmRm
         k/GXKbxVFMC6FarfBhBvX0wKXAaQfhVAGyYx921qJXVov232q1CUomzOScA9PRijyjbr
         ZROxgGtaJeI6NryELu/igf3jT4gUDm6N83GxoauM8Nbqii+EXGZjaQ5S01AAdRFFE+0c
         Rz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1Ipe1UfyfsMz5Tp2uesrFumfBRfdDn/SKw07Neys5JM=;
        b=iO10Px88RHI5AjeDh2zImhthO17fUdyRkXFkijKdY1RphcbDCvAXmMHZ9v8up4VpIv
         WV/qwm6Exem8hEBZN3J2Fn3v9yGZzG/FPrjCj1opufpyPIoi2E2JXHMqz3bv1MKR7aME
         LoFDPVHkBBqz9cT866r/f/eHYKgTJeZbCG+v9m9R7ASUoTSl72Atq9W01meCjI+xHxFd
         IYJuDm5IOFn4SdGQz4OB/hdg8e76tcm8Fx4JQ+KYds5LSxyincATLLfcejLCeSeCyZHt
         lNniRF4BkRFVi3Krn7ctCWuLND8pGj5ZlOPhax1NYIByNJ9Az8nhJRu3RcrvIW7KDg6w
         jpVw==
X-Gm-Message-State: AOAM5301gWOl2V59Wuynq7vcHVx7y/q/Au7+hQoBYeZPfZuQszO8//Vi
        WeuzVq513dabCatNLXIfiyA6qg==
X-Google-Smtp-Source: ABdhPJwTCUMKJmH6C+6CtpDyxmNysxEbBh63HTOIE+uQYOcxZSyhQqqamHWgCC/vqGUEjGnJSrSc3Q==
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr12485708edb.366.1624454613833;
        Wed, 23 Jun 2021 06:23:33 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id q15sm3273edr.84.2021.06.23.06.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 06:23:33 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        bharat.kumar.gogada@xilinx.com, kw@linux.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pci: xilinx-nwl: Document optional clock property
Date:   Wed, 23 Jun 2021 15:23:29 +0200
Message-Id: <67aa2c189337181bb2d7721fb616db5640587d2a.1624454607.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1624454607.git.michal.simek@xilinx.com>
References: <cover.1624454607.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clock property hasn't been documented in binding document but it is used
for quite a long time where clock was specified by commit 9c8a47b484ed
("arm64: dts: xilinx: Add the clock nodes for zynqmp").

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- new patch in this series because I found that it has never been sent

Bharat: Can you please start to work on converting it to yaml?

---
 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
index 2d677e90a7e2..f56f8c58c5d9 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
@@ -35,6 +35,7 @@ Required properties:
 
 Optional properties:
 - dma-coherent: present if DMA operations are coherent
+- clocks: Input clock specifier. Refer to common clock bindings
 
 Example:
 ++++++++
-- 
2.32.0

