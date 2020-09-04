Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59C425E1AA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIDS4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 14:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 14:56:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E0C061244;
        Fri,  4 Sep 2020 11:56:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so7131972wme.5;
        Fri, 04 Sep 2020 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqnchSBC4ce9kD+elBEN3iqVRw/a6f6MQUzRH1fFwtc=;
        b=tZZZMzrjjEL8v+mR735j/8/ps2TQQj/jEZVZZF2cGYWEuzCLOrEy6OTfbK+3sG1g8A
         tY/mhZsOCxVPODmH+fwIEZ2D0wfOcX/UOkU7iJi3JamsPR7X1lMH7WlovmjRlGCd5zgJ
         8YRW0eQrPu5uG86NQtQB5lIZa0+ryFcV9B/PwiT5ByHmi3c5u1lG3HZYC8T5HpylVszO
         G8UixO8Zfk33vhZVFUwraq2kpWnJPCI5/NDIWe7wHcFUs/uP67GPvK/jovKr1LwJmfrB
         Vdc2Xd9ThJMOqlFrzDXLBLmi3kKm2RXIRma2dtKP7y1LtoWQITgJSQuzU604AgErMVRq
         T8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqnchSBC4ce9kD+elBEN3iqVRw/a6f6MQUzRH1fFwtc=;
        b=tSX5NxbwxUfLQ0OgH+cZuiKKlpPxVfpXryyX4pMx2PwxUXtNePkuoj5sNGc1ICbljK
         BfRUqIDmUvFkCymqvXUA/WNHcVFK0y/r3DVz4UlZGKYf34CNX0GsWzKPhxmNjQUyNRVz
         BReyM0nS9Lj9FRUfLJnK2VhWJjn/nFmgA+l8Amn/ctw3d8MhifGIqeMQpJwJ4pMUZkub
         YEcUw2bCojGRPvu9N1ptDLDwcrI9UnxSwBOhrjAbztl1Ts8XscjKVNgC6ru721mT54d8
         W2doQBA6okgvlVlvv9823MSMBv+xUL0qDKi3/krzEsQUjha2cr26kPvDKgnrE4LTH0ER
         nfLA==
X-Gm-Message-State: AOAM532Oz/3fhB8RH1a91f5DwS6CFTTshDWsBEOY4grHA9basPX47kds
        bvZDeRRMVUdZUWH9wHZuBuI=
X-Google-Smtp-Source: ABdhPJxgM6f1WE13230F3a3T6BDFrVbbjErwvzWA8pwo99jUWDoEmKbIR1ZxSXjqXBh7FSk5TW3onQ==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr3663106wmb.142.1599245791497;
        Fri, 04 Sep 2020 11:56:31 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id b76sm12892229wme.45.2020.09.04.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:56:30 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: keystone: Enable compile-testing on !ARM
Date:   Fri,  4 Sep 2020 19:56:09 +0100
Message-Id: <20200904185609.171636-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the Keystone driver can only be compile-tested on ARM, but
this restriction seems unnecessary. Get rid of it to increase test
coverage.

Build-tested on x86 with allyesconfig.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a3761c44f..ca36691314ed 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -107,7 +107,7 @@ config PCI_KEYSTONE
 
 config PCI_KEYSTONE_HOST
 	bool "PCI Keystone Host Mode"
-	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_KEYSTONE
@@ -119,7 +119,7 @@ config PCI_KEYSTONE_HOST
 
 config PCI_KEYSTONE_EP
 	bool "PCI Keystone Endpoint Mode"
-	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCI_KEYSTONE
-- 
2.28.0

