Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE313B41E5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFYKu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhFYKu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 06:50:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6BC061768
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 03:48:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hz1so14446716ejc.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEczI+XDhSurUjjMQxYZ5XHZvjXwC8D9bI8UZldm8s4=;
        b=H5374yea1w76ePI0Fhc/GxmGIOBTPZO4ORHmcJVAaCXAxfX6FalGgMETXaOyLKz814
         soOOOCBkiTSM91EQcDYOafe4d/NGp9YfvtDeMibmyM05rhoM/dEr3+XVpRVocyEF/snB
         j/h79tshpOrgWpXOfEM8DMMfOz14RIZu2GYG/95VhkcgxO8qGYkAm/4WeZk9AhJ/JP7r
         cud7Dml3O6/rVw6G5k0CkyDzC1DqIWNAOwdRtVPaVgthmGvHhcj2L81Ue1CNcVqpBZFf
         uQtCL3ugcPTqCCs+xbBtRAtP7C1zMbsI4TXTDKlsa4wHUR9H5PMnXeHfXGb6XJImDuKH
         S+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yEczI+XDhSurUjjMQxYZ5XHZvjXwC8D9bI8UZldm8s4=;
        b=Vuttb6i2g6LFFdgykQKQm4X0joC9e6scSCnZxt+vQ+OFyfXim4TiM7ZgdVH4lw8p4m
         LlhlyAUfSk03z0F0f5FqfAKCBaK1IefVdX3lBlGI4lJ2q89dN/nkS7tN4h6hRxW6WnCh
         agEBVOxpGmlU+xmG7vwSc/otbd4SJMgdkYG9nn6VDr4S4sUQDf8vI/OHBQwkz+3scbIh
         9p15UyJIqXsFhDV8JAoZ33MzksRIdebNoHDvcqL+htsoufPOQzJP73G8M3ai4ZM0QYOx
         DJgoWSLvK753aMOlZ+ZPef39JKofC1FyGq5MDu3Q91063DZpAYPZkGVzjoYmfThujjB1
         LNkQ==
X-Gm-Message-State: AOAM531c/7wQ70zN/3tgFhpRumYJpg/jIB5YHfM1s0SxudOIps3rUBUZ
        ZrE9OZumC7tn36M8ecR0UudmmQ==
X-Google-Smtp-Source: ABdhPJxeYgBZ/WcQE/JTHAdJlc0ZKJx9MuEDhGUZO3uISFWkWNnCFWxgpfZIDCEmNmXxcR8ABq5akQ==
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr10285205ejb.223.1624618113391;
        Fri, 25 Jun 2021 03:48:33 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id h7sm2551454ejl.8.2021.06.25.03.48.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jun 2021 03:48:33 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        bharat.kumar.gogada@xilinx.com, kw@linux.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: pci: xilinx-nwl: Document optional clock property
Date:   Fri, 25 Jun 2021 12:48:22 +0200
Message-Id: <67aa2c189337181bb2d7721fb616db5640587d2a.1624618100.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1624618100.git.michal.simek@xilinx.com>
References: <cover.1624618100.git.michal.simek@xilinx.com>
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

(no changes since v2)

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

