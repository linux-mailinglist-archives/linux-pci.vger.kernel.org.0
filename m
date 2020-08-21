Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E093924CBF8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgHUDz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:28 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42910 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgHUDzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:23 -0400
Received: by mail-il1-f193.google.com with SMTP id t13so325099ile.9;
        Thu, 20 Aug 2020 20:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdbUqaHlOxpNwKxtKQG+iMJdH7wgWqKuZeq7kbv/krA=;
        b=kmV2xK/BLLTPhH15I9jfXaPiyJmB00p1SW+FQs57LskvZ7TnwJ/p2FPIl1YxBnuVFJ
         hHqKcrIetHIo7XJHR49cMin2PAB5KFMlsY4j4JZhilvrbVQZpymDynEU7PQ8Kb3LzY3j
         A551rOshu7FlkKdH++7SLNaBQ/sXzp13h4LVt7LRMHte+T2AMi68n8gP2dcGOFAcEJcE
         AmZuYA9LKbSLecdmVQkET+Y6ZiKA0XuDLjCm9IauDy7gSg3uQR5udTZ6sx0DE8LxggnG
         HY3nRwklzQWoD9JdN9K1ZmxDyInoo/+wg7CeIqGk5KQbwdMWzGqv9htxt6N6mkYfvpVJ
         bQpA==
X-Gm-Message-State: AOAM532MwvaKziVSdgroWY7TAt/rlbVr48mo/OFNr7GT/ABKOqZv/jfd
        rkUGA+Kkql2inzE4yw+iaw==
X-Google-Smtp-Source: ABdhPJwE4917c5+NGuqLlyA9JDGlrpGe+mH9Eho+5KNlJKwz9WZvaxODvXKvQEAkENi0q4FM4lOqPw==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr941662ilh.218.1597982121701;
        Thu, 20 Aug 2020 20:55:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 14/40] PCI: Also call .add_bus() callback for root bus
Date:   Thu, 20 Aug 2020 21:53:54 -0600
Message-Id: <20200821035420.380495-15-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to pcibios_add_bus(), call pci_ops.add_bus() when the root bus
is added. This allows host bridge drivers to do any setup requiring a
bus pointer.

There are currently no .add_bus() callbacks, so this is safe to do.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0c9ebc72532e..d8bf3fe8dacd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -941,6 +941,12 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	pcibios_add_bus(bus);
 
+	if (bus->ops->add_bus) {
+		err = bus->ops->add_bus(bus);
+		if (WARN_ON(err < 0))
+			dev_err(&bus->dev, "failed to add bus: %d\n", err);
+	}
+
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
 
-- 
2.25.1

