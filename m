Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835AD23AED6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgHCVBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34288 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgHCVBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:23 -0400
Received: by mail-io1-f65.google.com with SMTP id q75so31848823iod.1;
        Mon, 03 Aug 2020 14:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKskqR1BQLcQkRJa4jVCjBb26v/8ydnan9t1CfXlQP0=;
        b=F3I5h+1s3UcJuJQIeVbdou8/lAyhnUMlEhtMa1/w69LqALXHoY4ZNvEqEZ8I7v1E4b
         2jNorcDEgjjTASJg9DPX9XhGvMvRZK44Y7EHm00YQCDJ99YYZ3nYiKIKRMnhrRfj1cAR
         uZv7WY5kUeNPzuJOy3HgdGN261vglpbF6hCEd8f/R0gPmI6/7Cv7ueRiqOEgllHS75Ks
         J8u6RYTVWDsKnl6L6ECuQiOvJzm0qpFSZC0/IIjTrNZMPJO0uuZ3oP8hyfoFxL16n8xS
         7pqLANaQt55//SdPd5NxH9pt31J4i7B6G+0hxwTZnbCNQ7qyWWtbGKMNK/oB7cPOJD1c
         veuQ==
X-Gm-Message-State: AOAM533y/m1MgN+Lfli8vdjoQidgdVwd3BzWF9Zq0d/6fMSOkfvVC/RZ
        6yAZDex/edq+AqGKKbyugQ==
X-Google-Smtp-Source: ABdhPJy4qG4p8bfrwbYSt3lvEPjhQpXlxLgUy+tuEvf+7Lf39Luq/OZA9TVNwuc57X3DpMVIygnSPw==
X-Received: by 2002:a05:6638:2601:: with SMTP id m1mr1810484jat.141.1596488481653;
        Mon, 03 Aug 2020 14:01:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 01/27] PCI: Allow root and child buses to have different pci_ops
Date:   Mon,  3 Aug 2020 15:00:50 -0600
Message-Id: <20200803210116.3132633-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
index 2f66988cea25..8712e595174d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1030,6 +1030,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
 {
 	struct pci_bus *child;
+	struct pci_host_bridge *host;
 	int i;
 	int ret;
 
@@ -1039,11 +1040,16 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
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
index c79d83304e52..cec789a0437e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -516,6 +516,7 @@ struct pci_host_bridge {
 	struct device	dev;
 	struct pci_bus	*bus;		/* Root bus */
 	struct pci_ops	*ops;
+	struct pci_ops	*child_ops;
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
-- 
2.25.1

