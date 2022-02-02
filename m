Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A484E4A69C6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 03:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiBBCBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 21:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243747AbiBBCBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 21:01:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313C0C061714
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 18:01:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v70-20020a25c549000000b006130de5790aso37062427ybe.4
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 18:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q1oi/RXvkD8Dq7uJmeyWkylsnr5bf/ofiDPgwV3XBxs=;
        b=HxhJFx8m1xXWPSkOOlyIHZ6TrBS88zHq/VAT9Azm8OrGOXPZ9brzpZt4GDmYgOJy5d
         ynIOdFCljbEHCcUOgSq9oY6YBG5ym7KHqVPEvqeLPOvSDDelPg+wpmLbl7w+c1e1tUfz
         zzoKk/HVz+AOO/D8kD1g0E3cghS3LbDh588/FaPOBvMytF3sr93ri6+p0AEEHJexUu2q
         hIQT6OliOYVL+oHVbUo1X8dX3Cwh744nCTUT30tFFRnxC5XkOVyX9VOjZcNPmqFSMiCi
         C3A4uhN+FsT2AEv6udiM3Cib0xVhFo7fiC74QvwT5yC88rcxCP4xT4vwK63dV4piNsaq
         roVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q1oi/RXvkD8Dq7uJmeyWkylsnr5bf/ofiDPgwV3XBxs=;
        b=QgulxgPFT598FjMxlOE4XLLIYU7OOSeqU0wQxLddfPlbjw07GCB+OFeJIEAIchJNIx
         6+a3VDOWkHUorqAx8xniCHEP113eInDeZ3WV7CMEWtjzMCu6kkcO2zOxG7ZxpDc83mVB
         jT8UesDLT3/duOOyd5ukohW4SSP4df25GiKPBbdE7J8gZxN9U63v88FIWgoFm90BUL2t
         iNsHeISBW9KbvD2RyP5oN411VZwh2WWe8Q15yCi3MQNShlsjvn9HniYjRp04IMTI65x1
         4ABxfRWgDQBHVM5h62P6FwGSEH4lqwqxjBJQlPaOizo0TX+JaHFKLpJveAPXFVXS1gdn
         yZxw==
X-Gm-Message-State: AOAM533U+BLT7A+8GjCLeH3fJbetA3tfJFFts+nf6/cBvv8/NT27BmZg
        LbjOx56ziD32kqcUgvejPL8Znr4NYKux
X-Google-Smtp-Source: ABdhPJwEpwwsb0wPv1uBzyjNY2EpARcBgOMHZ0zvO/DbYf2KSjn9bDzFDRksVosNRbsKOee80RK5err37Kpz
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:57dc:f744:660d:72d])
 (user=rajatja job=sendgmr) by 2002:a25:e5c7:: with SMTP id
 c190mr29691167ybh.175.1643767270447; Tue, 01 Feb 2022 18:01:10 -0800 (PST)
Date:   Tue,  1 Feb 2022 18:01:03 -0800
In-Reply-To: <20220202020103.2149130-1-rajatja@google.com>
Message-Id: <20220202020103.2149130-2-rajatja@google.com>
Mime-Version: 1.0
References: <20220202020103.2149130-1-rajatja@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 2/2] dt-bindings: Document "UntrustedDevice" property for
 PCI devices
From:   Rajat Jain <rajatja@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the new "UntrustedDevice" property for PCI devices. This property
is optional and can be applied to any PCI device.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Initial version (added documentation based on comments)
v1: Does not exist.

 Documentation/devicetree/bindings/pci/pci.txt | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..bc1ba10f51e1 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -82,3 +82,38 @@ pcie@10000000 {
 		external-facing;
 	};
 };
+
+PCI Device Properties
+---------------------
+Following optional properties may be present for any PCI device:
+
+- UntrustedDevice:
+   When present, this property is an indicator that this PCI device (and
+   any downstream devices) are to be treated as untrusted by the kernel.
+   The kernel can, for example, use this information to isolate such
+   devices using a strict DMA protection via the IOMMU.
+
+   Example device tree node:
+	pcie@0008 {
+		/* PCI device 00:01.0 is an untrusted device */
+		reg = <0x00000800 0 0 0 0>;
+		UntrustedDevice = <1>;
+	};
+
+   Example ACPI node:
+	Scope (\_SB.PCI0.WFA3)
+	    {
+	        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
+	        {
+	            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
+	Properties for _DSD */,
+	            Package (0x01)
+	            {
+	                Package (0x02)
+	                {
+	                    "UntrustedDevice",
+	                    One
+	                }
+	            }
+	        })
+	    }
-- 
2.35.0.rc2.247.g8bbb082509-goog

