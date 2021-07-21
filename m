Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F9E3D1260
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbhGUOru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbhGUOrt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 10:47:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A176C061575;
        Wed, 21 Jul 2021 08:28:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n4so1578196wms.1;
        Wed, 21 Jul 2021 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShmnrtYGbhLvt22QXVCWVyM3Ev7W7+sJbBBqrGHgNQQ=;
        b=rKxZB1pvS/SvuENep/NcTB0hlQLeTtAsfDdhBfWv9zZDUYMJgP9XosuhZD+dUtfYRC
         3MagxQonVNhKfjtqfIMQI8CfFgaJsx+dAnvnlPiGKndkxmjGY5/teW36DS+BhOEZdXQ7
         NUgPEkwnVxwQKDjQthRcKjZnAy26sBfDO0HQuyKcpx7wdUFz6L+GnmYfsxvtH2B7gubZ
         CgjjjK07gUA8PrSFXA1gSzVygwhxXo/EaNst+9eo/BEWxE5C0Soub1ij+SfVy7uJL7Qq
         XF9GGMjHH55BtOb8KOC060G7uSI3IBCHgjBSKTzuR5pPEBjvSAiuq9w5taINfQ7NciUK
         0bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShmnrtYGbhLvt22QXVCWVyM3Ev7W7+sJbBBqrGHgNQQ=;
        b=a89WpQI/xXfOoaSuJmgrMGtRFHInQY6XDf6QjMrG2m3ypuGP9OnvjR3e7aC/s0Xny8
         JoLyEoggNvBaIIWMwn7d0pasBqP3vXUlTMRmq2WFagpccEyU1oHS+rhLw9cgUurS64fH
         aqidUxZ/vJG/lUdVKBmUoyy/RSjzBnDE87tOIKF3CHJQtanA5FHBa225hFvhR96CtWhK
         G4wwrrbccyG8rV//ERRvKBNqIUXI/aL0n4SB5u/1OMGLiTdYgbEwSTbuhx0MVRLa1wRM
         OIvr9zbGAB50iB4Arf1VXJFUEVEB1FYvsJQbJbr9WbCzli4cBKkhmAzZzBWdtAqEeaye
         bSYw==
X-Gm-Message-State: AOAM5301JnRW6HOp28ncA7qZ/K8EOPeTPd+6uqjVWuLDwFlSCacLbLAk
        X7ld9br1bz2zsa/0ukqFQbA=
X-Google-Smtp-Source: ABdhPJxq6WnJ0ScT/U0gui5UDZtIP0bWtXf1gkONTpXPOq6fx3yZGEZjlicl8D48BY3ZwFtJuYMn7A==
X-Received: by 2002:a1c:7e53:: with SMTP id z80mr1675182wmc.153.1626881303722;
        Wed, 21 Jul 2021 08:28:23 -0700 (PDT)
Received: from chgm-pc-linux.bachmann.at ([185.67.228.2])
        by smtp.gmail.com with ESMTPSA id y16sm246913wmq.1.2021.07.21.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 08:28:23 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: do not ignore link errors
Date:   Wed, 21 Jul 2021 17:28:21 +0200
Message-Id: <20210721152821.2967356-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This fixes long boot delays of about 10 seconds.

I am working on a device powered by an TI am65 SoC where
we have a PCIe expansion slot. If there is no PCIe device
connected I see boot delays caused by pci_host_probe(..).

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---

V2: fix compile

---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a608ae1fad57..ce7d3a6f9a03 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -408,8 +408,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			goto err_free_msi;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		goto err_free_msi;
 
 	bridge->sysdata = pp;
 
-- 
2.31.1

