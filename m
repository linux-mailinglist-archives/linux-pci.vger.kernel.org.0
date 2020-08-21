Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004CB24CBB4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHUDyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:31 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39625 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgHUDyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:31 -0400
Received: by mail-il1-f193.google.com with SMTP id f12so331954ils.6;
        Thu, 20 Aug 2020 20:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRJMVMF9r7qXs+QDp+bx+ovjwoVdm4UDqS7o+cHIDVk=;
        b=YbormMP/lSdNwJ1/TGmk4yojdQkhCyNpGLMD+Jr5lg3zR+Q9fwqexuoQPQj/3FE9Dy
         03c9/95uAE1HsVogVHs0wMYMX4gHn1+FzlMRSIQuvtjNCJ3ssKM+xpT6U9dOFD+1lzsh
         HE8L1ziEAR61MI4Vuk4arz/UoEgdF6E2UeRI1SBBS3HybW2A5N1fCh4RXWQOpK+8kYMc
         pJZ/fYJ+GrQelTD1XehG8FBIfMQaqP6cgwSWmpvcQrjFxQd8Z1oFZTx3zUAgjrx9Ddcb
         YuPFOZC7vjPdgJs5sHZJb3nLB5D/zQuiSnsMJ0PDAUKs48QznXbTRP9Tj75loljC4PeK
         NTaA==
X-Gm-Message-State: AOAM531j69Xs/rdj8ZX6k4IAJXdUS2u8YZfDIpCvjh80jY6qs7PtbgzV
        dz1NXGZF9Sw/HIbZ56cm7w==
X-Google-Smtp-Source: ABdhPJwRNaZICDow1OKY9hk3FD5LXGPW+N8Amx9fFJ/qk2fSUYYNRaZO952kdfGlBWIGO25JKRrzVA==
X-Received: by 2002:a92:c081:: with SMTP id h1mr1021694ile.41.1597982069449;
        Thu, 20 Aug 2020 20:54:29 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:28 -0700 (PDT)
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
Subject: [PATCH v2 01/40] PCI: Allow root and child buses to have different pci_ops
Date:   Thu, 20 Aug 2020 21:53:41 -0600
Message-Id: <20200821035420.380495-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host bridges often have different ways to access the root and child
bus config spaces. The host bridge drivers have invented their own
abstractions to handle this. Let's support having different root and
child bus pci_ops so these per driver abstractions can be removed.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/probe.c | 8 +++++++-
 include/linux/pci.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..0c9ebc72532e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1036,6 +1036,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
 {
 	struct pci_bus *child;
+	struct pci_host_bridge *host;
 	int i;
 	int ret;
 
@@ -1045,11 +1046,16 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 		return NULL;
 
 	child->parent = parent;
-	child->ops = parent->ops;
 	child->msi = parent->msi;
 	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
 
+	host = pci_find_host_bridge(parent);
+	if (host->child_ops)
+		child->ops = host->child_ops;
+	else
+		child->ops = parent->ops;
+
 	/*
 	 * Initialize some portions of the bus device, but don't register
 	 * it now as the parent is not properly set up yet.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..1fbe95a7d386 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -523,6 +523,7 @@ struct pci_host_bridge {
 	struct device	dev;
 	struct pci_bus	*bus;		/* Root bus */
 	struct pci_ops	*ops;
+	struct pci_ops	*child_ops;
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
-- 
2.25.1

