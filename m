Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488FF24CC6A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHUD4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37248 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgHUD4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:47 -0400
Received: by mail-io1-f67.google.com with SMTP id b16so484841ioj.4;
        Thu, 20 Aug 2020 20:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=977wihraQvLF0SPRRQJhF+YrG+p3/qEwPqMrKAY+nbQ=;
        b=QP6Ph6SxkKDtZbORRtfLMy3zhPOXoer1TZ4GkXKLxhjDd4oyTP/tBCQUjyG8U033C8
         yr6dg5p34tHYR7cGuVa3zNUWDDIFlyM6D7ICccvZelfakNKxMABjpxfFHiescP2hyqz+
         Gjx/gKRB2jAPn52dfrAv+QY0qOvGNyTPQIm/lzbdVAQDd20DD4CcDVdfc/gc51R/WfDH
         8Sk3QgMxH7btHOlNHM/MF4jaw78uYda9kCIK8ADENjarxiYm+ja83a/fg+ohDWZhUs3O
         sDnrhJS6Gp7YRMmvFOV4jalcN+irJWmK/9flL+237d1lo/HECj7zhvhzGVmwB7Uyqbx9
         1GOg==
X-Gm-Message-State: AOAM531CwISCsdsVPdcn+nDEi+q9dY26vHQPkrTTqCvvWtPtpmLxkqD8
        tDbQMgNKPOW2xSbXRU9oPA==
X-Google-Smtp-Source: ABdhPJw/uNByXN0aCl+4jyJ73JOY4dDBXCFrmTrhHNDlH5OMH+mWhGn9ESZSwCXXys59FN3TPFATHw==
X-Received: by 2002:a02:29ca:: with SMTP id p193mr859557jap.131.1597982205997;
        Thu, 20 Aug 2020 20:56:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:45 -0700 (PDT)
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
Subject: [PATCH v2 36/40] PCI: dwc/intel-gw: Drop unnecessary checking of DT 'device_type' property
Date:   Thu, 20 Aug 2020 21:54:16 -0600
Message-Id: <20200821035420.380495-37-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A driver doesn't need to check for DT 'device_type' property, so let's
remove the check.

Cc: Dilip Kota <eswara.kota@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index d15e49b8df2a..6b102197a1b6 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -268,12 +268,6 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = device_property_match_string(dev, "device_type", "pci");
-	if (ret) {
-		dev_err(dev, "Failed to find pci device type: %d\n", ret);
-		return ret;
-	}
-
 	ret = device_property_read_u32(dev, "reset-assert-ms",
 				       &lpp->rst_intrvl);
 	if (ret)
-- 
2.25.1

