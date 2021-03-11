Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C065336882
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCKARn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:43 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:42519 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhCKARf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:35 -0500
Received: by mail-lf1-f52.google.com with SMTP id v2so23688793lft.9
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOaZ9L90hSCMz6oZGX1bbSsAE8thLW/EO9o9W5+QirQ=;
        b=b4uDjrutkHmie/hTvLvL88rVFvKmpVyoX3n3VvaApzvHLjahvXds5WIUZ8RxESZVrt
         xM7siBrz1CY9Zs3gh3KPM96LMEuDR8S6hqYlF31fkSAMXjqDjf6CwZOPSg4iF6uo52RV
         MpnCV6oCSc96mY3anOVVYPX1/tz0WDNwYTYa1GEAk+9FPUyA1WGA4M8mv+bYAp8wOgML
         iN2q5bf50wVMJHoDilCQB5r4Xq/mN7TfbvuVVKpsnrkKy75bCB0TeGl0jLbXQ0D8GG1A
         01pVU7MfR01Aj9ISRQ63E/69HdWFiBwKqoPJ/VTr4ZYqgIPd1mt5NLOZhwztnsOHKT5r
         H1rg==
X-Gm-Message-State: AOAM531scZ/YT1CrWrUFT3+bWl1cvmH1QotiDEYW/6e58hByuaJJpuf+
        FtwE+zyJOzONVgBe+mFwunQ=
X-Google-Smtp-Source: ABdhPJyIHIUKWITbj+6M9WCWXYHfQKp2laz5VSCEBSOg4vL/S+jWouIS61nsZuzW7UzCYhbjI0Wk1Q==
X-Received: by 2002:a19:f510:: with SMTP id j16mr635398lfb.301.1615421854491;
        Wed, 10 Mar 2021 16:17:34 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:34 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jay Fang <f.fangjian@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 8/8] PCI: of: Fix kernel-doc formatting and add missing documentation
Date:   Thu, 11 Mar 2021 00:17:24 +0000
Message-Id: <20210311001724.423356-8-kw@linux.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
References: <20210311001724.423356-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting and add missing documentation for the "node"
parameter of the of_get_pci_domain_nr() and of_pci_get_max_link_speed()
functions, and resolve build time warnings related to kernel-doc:

  drivers/pci/of.c:202: warning: expecting prototype for This function
  will try to obtain the host bridge domain number by(). Prototype was
  for of_get_pci_domain_nr() instead

  drivers/pci/of.c:597: warning: expecting prototype for This function
  will try to find the limitation of link speed by finding(). Prototype
  was for of_pci_get_max_link_speed() instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/of.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 5ea472ae22ac..da5b414d585a 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -190,10 +190,18 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
 
 /**
- * This function will try to obtain the host bridge domain number by
- * finding a property called "linux,pci-domain" of the given device node.
+ * of_get_pci_domain_nr - Find the host bridge domain number
+ *			  of the given device node.
+ * @node: Device tree node with the domain information.
  *
- * @node: device tree node with the domain information
+ * This function will try to obtain the host bridge domain number by finding
+ * a property called "linux,pci-domain" of the given device node.
+ *
+ * Return:
+ * * > 0	- On success, an associated domain number.
+ * * -EINVAL	- The property "linux,pci-domain" does not exist.
+ * * -ENODATA	- The linux,pci-domain" property does not have value.
+ * * -EOVERFLOW	- Invalid "linux,pci-domain" property value.
  *
  * Returns the associated domain number from DT in the range [0-0xffff], or
  * a negative value if the required property is not found.
@@ -585,10 +593,16 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 #endif /* CONFIG_PCI */
 
 /**
+ * of_pci_get_max_link_speed - Find the maximum link speed of the given device node.
+ * @node: Device tree node with the maximum link speed information.
+ *
  * This function will try to find the limitation of link speed by finding
  * a property called "max-link-speed" of the given device node.
  *
- * @node: device tree node with the max link speed information
+ * Return:
+ * * > 0	- On success, a maximum link speed.
+ * * -EINVAL	- Invalid "max-link-speed" property value, or failure to access
+ *		  the property of the device tree node.
  *
  * Returns the associated max link speed from DT, or a negative value if the
  * required property is not found or is invalid.
-- 
2.30.1

