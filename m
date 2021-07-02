Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037723BA506
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 23:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhGBV30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 17:29:26 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37712 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhGBV3Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 17:29:25 -0400
Received: by mail-wm1-f49.google.com with SMTP id r9-20020a7bc0890000b02901f347b31d55so7048857wmh.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 14:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNRHGimSxBoy+1q0mlL9dusHS4KmdEIv9IpGZomHC08=;
        b=CBcVUR6aBsYWLbfGFAG6G3PEe5am4WH8uVQaYvqUil9LB78EcSXAmTYTTYY+KjFalU
         gaUVvV5jEZ0OzQrDddN3DPXW5v9YnqJ/qszdoBaFZ/BCD9z9K8PL1TMNmEOfyIHOgCXz
         j1pjt9Dr/IKLfqMdfXDmBavnLQR61ZrTrQ0URu8HTJK2XTkA/WQh0ng/xBMoFNRIdvGz
         E5jMcb+Cort67Owu0gQd/MCZGwqGu1de8Yl7ngZW511OV16e5runXt/CkhjJncD6zD4t
         +PKI1XFd9xbGVaDMmSg0u2CeSITBbn9ir+8VTTlE5G1++qReAU1rUsReWhxjl8VG2dvw
         3F+w==
X-Gm-Message-State: AOAM530GwwmKgmyhCqHdUYAirjGmta7PQgJhPoHiJ0utSRo6DlRzVUKU
        dVc+fD1Dd6zTGhP9xu6rCL0=
X-Google-Smtp-Source: ABdhPJx8OvpHzOJ7dMNS96mU5Z+EIP0ahKHhPM3BSIPAKjiEnZy/n0i/MdXKKc+c/Uat6cZQiy2Aaw==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr1845893wme.28.1625261212464;
        Fri, 02 Jul 2021 14:26:52 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a11sm4438949wrt.71.2021.07.02.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:26:51 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: cadence: Remove surplus and document missing struct members
Date:   Fri,  2 Jul 2021 21:26:50 +0000
Message-Id: <20210702212650.1661227-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing documentation for the members "dev", "phy_count", "phy" and
"link" of the struct cdns_pcie, and remove surplus member "bus".

Thus resolve build time warnings related to kernel-doc:

  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'dev' not described in 'cdns_pcie'
  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'phy_count' not described in 'cdns_pcie'
  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'phy' not described in 'cdns_pcie'
  drivers/pci/controller/cadence/pcie-cadence.h:281: warning: Function parameter or member 'link' not described in 'cdns_pcie'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 254d2570f8c9..5577fefce4f1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -260,13 +260,18 @@ struct cdns_pcie_ops {
 };
 
 /**
- * struct cdns_pcie - private data for Cadence PCIe controller drivers
- * @reg_base: IO mapped register base
- * @mem_res: start/end offsets in the physical system memory to map PCI accesses
- * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
- * @bus: In Root Complex mode, the bus number
- * @ops: Platform specific ops to control various inputs from Cadence PCIe
- *       wrapper
+ * struct cdns_pcie - Private data for Cadence PCIe controller drivers.
+ * @reg_base:	IO mapped register base.
+ * @mem_res:	Start/end offsets in the physical system memory to map PCI
+ *		accesses.
+ * @dev:	The PCI device.
+ * @is_rc:	Tell whether the PCIe controller mode is Root Complex or
+ *		Endpoint.
+ * @phy_count:	Number of supported PHY devices.
+ * @phy:	List of pointers to specific PHY control blocks.
+ * @link:	List of pointers to corresponding device link representations.
+ * @ops:	Platform specific ops to control various inputs from Cadence
+ *		PCIe wrapper.
  */
 struct cdns_pcie {
 	void __iomem		*reg_base;
-- 
2.32.0

