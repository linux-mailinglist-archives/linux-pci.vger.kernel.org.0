Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AB4065DB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 04:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhIJC7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 22:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJC7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 22:59:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EBC061574
        for <linux-pci@vger.kernel.org>; Thu,  9 Sep 2021 19:58:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so517454pgr.11
        for <linux-pci@vger.kernel.org>; Thu, 09 Sep 2021 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=sfB7DoPV412OCGnSLv4G5fGHOEs2sAXIi+PxMXRJg8A=;
        b=GT/CTKQsP6UWVABdf5vcsGYB6mWirEMsHDhrCAV1Ps/AcU3SVgvwy75WfTrO9rfDjO
         cA12yg1GD1nRE5pkwZDqCsLAJ7O9wYVG7VjzF9VFPk2o+X6S+4fO7QtBy+DXMPWITSNo
         YaYNlMurNHprwgQUrQxobwa2kA5G/zNUvHOv803JythTdFxnY42GxDA6D1H2TYx92yyr
         gIHjAqs9yNd4v9tyR1BYnUguidqz8MvYkqkzMhNhNBBmyL4bd3V8EQYW/Uw+gfmjJSVT
         UbDdl6pp1aKbTsnX6kkdOFvxaGlHhxsZmGWfHqQjFr+XwisCoS2L4mXjvWVnSD0Hn6DU
         pPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=sfB7DoPV412OCGnSLv4G5fGHOEs2sAXIi+PxMXRJg8A=;
        b=S7KO6e7LilCwO6SgE/vrT3m3jbsG+P6P2aTq1Nv2rGFGJvHJjx8XbOD1owY20vNTh6
         zkuqp6LaaJKeHKkxtRZjpI3ZXQOpyJ7Vwbt0gqnUGKOdkh5eZMbVT2DwoSXmafFciq42
         jC1Z+oG3G0vgalAs5IVvBYK4FKVL5KAG3BPb4XmY2+uF9UZru6aXZ+OlItVc36yZBfh9
         7OE6s9DQ0Ey+Hu2SPXhBMbPfEI7Q5Bxq8gVNWI606b/DxjKeRAQNZ9YYneWemxvEmQ3B
         GwT16FCzUXnd1a+NCzfaGhgMlQJdqr2rbmR+XZL8TYYXZCsXsyZVnYOJbxkjFJNDPuWB
         3JDQ==
X-Gm-Message-State: AOAM532KU5eoFQp06FxMLciYMb5B8D7DztuBypTHHg3ESOpaF1SQdDyD
        nGISJkmkC4EAY57IRKWIbzxyoOsbCtTQ8w==
X-Google-Smtp-Source: ABdhPJz/3z4zkXXlSgAiyqkmThqgs3OW8QALorLidcDeOT1YKp5jwvYuuLj2zf8GpXjBcFfmoPuFHQ==
X-Received: by 2002:a05:6a00:1255:b0:3f5:26ee:ca2c with SMTP id u21-20020a056a00125500b003f526eeca2cmr6052474pfi.62.1631242714853;
        Thu, 09 Sep 2021 19:58:34 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id q18sm3627308pfj.46.2021.09.09.19.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 19:58:34 -0700 (PDT)
Date:   Fri, 10 Sep 2021 02:58:23 +0000
Message-Id: <20210910025823.196508-1-nathan@nathanrossi.com>
In-Reply-To: <20210909080927.164709-1-nathan@nathanrossi.com>
References: <20210909080927.164709-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-pci@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3] PCI: Add ACS errata for Pericom PI7C9X2G switches
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

The Pericom PI7C9X2G404/PI7C9X2G304/PI7C9X2G303 PCIe switches have an
errata for ACS P2P Request Redirect behaviour when used in the
cut-through forwarding mode. The recommended work around for this issue
is to use the switch in store and forward mode. The errata results in
packets being queued and not being delivered upstream, this can be
observed as very poor downstream device performance and/or dropped
device generated data/interrupts.

This change adds a fixup specific to this switch that when enabling or
resuming the downstream port it checks if it has enabled ACS P2P Request
Redirect, and if so changes the device (via the upstream port) to use
the store and forward operating mode.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=177471
Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes in v2:
- Added DECLARE_PCI_FIXUP_RESUME to handle applying fixup upon resume as
  switch operation may have been reset or ACS configuration may have
  changed
Changes in v3:
- Apply fixup to PI7C9X2G303 and PI7C9X2G304 switch models, these models
  are also covered by the errata, although have not been validated
- Rename PI7C9X2G404 defines to more generic PI7C9X2Gxxx
---
 drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e5089af8ad..f7cbc4fa40 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5790,3 +5790,59 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * Pericom PI7C9X2G404/PI7C9X2G304/PI7C9X2G303 switch errata E5 - ACS P2P Request
+ * Redirect is not functional
+ *
+ * When ACS P2P Request Redirect is enabled and bandwidth is not balanced
+ * between upstream and downstream ports, packets are queued in an internal
+ * buffer until CPLD packet. The workaround is to use the switch in store and
+ * forward mode.
+ */
+#define PI7C9X2Gxxx_MODE_REG		0x74
+#define PI7C9X2Gxxx_STORE_FORWARD_MODE	BIT(0)
+static void pci_fixup_pericom_acs_store_forward(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+	u16 val;
+
+	/* Downstream ports only */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	/* Check for ACS P2P Request Redirect use */
+	if (!pdev->acs_cap)
+		return;
+	pci_read_config_word(pdev, pdev->acs_cap + PCI_ACS_CTRL, &val);
+	if (!(val & PCI_ACS_RR))
+		return;
+
+	upstream = pci_upstream_bridge(pdev);
+	if (!upstream)
+		return;
+
+	pci_read_config_word(upstream, PI7C9X2Gxxx_MODE_REG, &val);
+	if (!(val & PI7C9X2Gxxx_STORE_FORWARD_MODE)) {
+		pci_info(upstream, "Setting PI7C9X2Gxxx store-forward mode\n");
+		/* Enable store-foward mode */
+		pci_write_config_word(upstream, PI7C9X2Gxxx_MODE_REG, val |
+				      PI7C9X2Gxxx_STORE_FORWARD_MODE);
+	}
+}
+/*
+ * Apply fixup on enable and on resume, in order to apply the fix up whenever
+ * ACS configuration changes or switch mode is reset
+ */
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2404,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2304,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2304,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
+			 pci_fixup_pericom_acs_store_forward);
---
2.33.0
