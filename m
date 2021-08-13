Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E823EB9B4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhHMQD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 12:03:26 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:41592 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhHMQDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 12:03:25 -0400
Received: by mail-oo1-f44.google.com with SMTP id f33-20020a4a89240000b029027c19426fbeso2936316ooi.8
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 09:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igXLnd1eISg2P0hGoYZnUOJKTMPuxVIxAZpu/coMklo=;
        b=pZ0WgpOHNFQq4FOyZqRHtUkNDX9ujEUjkEr/mURGVci1dppTENYrumfy60l4HLFL/w
         UNMEiGBAuGuxmU/4yfWqhzK80UtK7UC/buYI7YqrUt+qn6xEuY7CQyOpmp/Zc3MwZ+Sy
         15OJaKWkZEY5WOGIQTcceIJajAA5fqMrvGqsY192hEvrcqP2Qhy+55nb828ybwKXgvAt
         dbRON2/yuLJ8sYKF6V1iZim9fhi/T+KU2iEL5SN+rwhjmwXiaR3SmWLTHFFrgORdh+T/
         dSQpCoKbkR+icrg2F1TUPLq0rrrTotx0nNSP1b/pWV5s9h0/CYQl1AosLjonF/bjVszC
         zKYA==
X-Gm-Message-State: AOAM5333HLzmON3HRaIliihzKtRtMWteVlRbLLsNi9xVoiJELEjXC1I6
        lON3B/GT72NVIrWVx3JBsw==
X-Google-Smtp-Source: ABdhPJxiB3tr1hTNXtMRt4s0i4ZTXw15nplCz2EbiuxYKNJ3IXT2f+h5fbf6BhiK8/w5RqphdsmTIA==
X-Received: by 2002:a05:6820:305:: with SMTP id l5mr2347123ooe.21.1628870578477;
        Fri, 13 Aug 2021 09:02:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w13sm389995otl.41.2021.08.13.09.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:02:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] PCI: of: Fix MSI domain lookup with child bus nodes
Date:   Fri, 13 Aug 2021 11:02:57 -0500
Message-Id: <20210813160257.3570515-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a DT contains PCI child bus nodes, lookup of the MSI domain on PCI
buses fails resulting in the following warnings:

WARNING: CPU: 4 PID: 7 at include/linux/msi.h:256 __pci_enable_msi_range+0x398/0x59c

The issue is that pci_host_bridge_of_msi_domain() will check the DT node of
the passed in bus even if it's not the host bridge's bus. Based on the
name of the function, that's clearly not what we want. Fix this by
walking the bus parents to the root bus.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only. Mauro, Can you see if this fixes your issue.

 drivers/pci/of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a143b02b2dcd..ea70aede054c 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -84,6 +84,10 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 	if (!bus->dev.of_node)
 		return NULL;
 
+	/* Find the host bridge bus */
+	while (!pci_is_root_bus(bus))
+		bus = bus->parent;
+
 	/* Start looking for a phandle to an MSI controller. */
 	d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
 	if (d)
-- 
2.30.2

