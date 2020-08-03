Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10F23AF17
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHCVB5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46757 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHCVB4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:56 -0400
Received: by mail-io1-f68.google.com with SMTP id a5so24746443ioa.13;
        Mon, 03 Aug 2020 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFafu+8WFYxvnK2ZfkQMV1ef4S4ilss7PqKLS2/JE9Q=;
        b=ipXeKRH+xqu0EHK9jtgf5Niv5ypGpvAs060+j9cftbVi4H/bRDhG4/dVGwvVx5JEuZ
         DI8dw9dThv7cLhacTBNq92rxLY3Qqzoh7rfMF94qLt0ZxFvI+9CllvwmSmmOfiyxrbey
         XSR3bKBJrznxUu0TYsNwB3gPWLoYuOjwEfokUuErIleQ5er6evK2ZczBC0MhtDIcydGY
         0tpmW9/iqdtVlm5bhCpV4bTutf2+AyvM9vtv87nTcn9fLvkBTIoQNCSmY9hDepk/ZxV+
         rm/7YMm/SApcwCfSmiEbTa5V91g1z66Tlxjjaxc0/D9V1WAEmj8TKwUtzTmMogD6gSMs
         ZS0w==
X-Gm-Message-State: AOAM531oYEUOpJwzwHi58YBqEG0jGT3S7IVM90Y0Px592R0fgDjnsWv6
        3rF5j1EwrwocnDZnjOd3cA==
X-Google-Smtp-Source: ABdhPJwJ3HnlJnV2ngZJFyUd41+SK9bAY0gYR06YRKYq8NPItVwUmrMdWUTQ4AtFe1sC/npigxntYA==
X-Received: by 2002:a5d:87c9:: with SMTP id q9mr1812686ios.113.1596488515619;
        Mon, 03 Aug 2020 14:01:55 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:55 -0700 (PDT)
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
Subject: [RFC 14/27] PCI: Also call .add_bus() callback for root bus
Date:   Mon,  3 Aug 2020 15:01:03 -0600
Message-Id: <20200803210116.3132633-15-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
index 8712e595174d..337a3b7766ca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -935,6 +935,12 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
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

