Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE3A171D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfH2KxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36313 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfH2KxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so3583849edu.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJGcjL5ZNns9h6GpIRf6+d7vQnIL7TBDz+MPWo53oqE=;
        b=o3V+YEckCKwM/4WBC/Cutnb/IfOFSYYe0SdxFL4D6weMyDvR8ZuTzoALNQCbk4oSJV
         0YB4YfVxTAO8QYm6IHwymiNmWDWclSFv4TikB4uCtUu7c0U2pVhd9KTz+6lWCeIFSeTl
         vHChwGYb2BD1Laa0Y4tD+8pknspYTuW38yypbuhTgDFw8Fr/8BNYoB1ZZV01uCp1FDk4
         ZWLmUY6u5E2sAFYS+OegkPE87VUH+x24dMtr8wldDbAjjSTWaNciMBfN71KcZf+iM1hw
         36cNirvzpwTzAh3n+w7yJqACmOXCzIozYnp8swkI5dSBAlJDArTTIXQ2MHeP4s8kbZtS
         wGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJGcjL5ZNns9h6GpIRf6+d7vQnIL7TBDz+MPWo53oqE=;
        b=UVLiirFcHPwxRrV1rM9L0aXTubqsR+Nhod/yKDH7VPkfVwonzdBDP9TNHPTKJoe3hm
         v8nins8EDb4iWuMbWyzgPZEijhkqmaNy8Go5guOe2srhKjKKwC4lT02vfZ8glLS0nkXq
         WHY9vOSGR0kztZ3FsBI3LlU4ZNlz8BfhZKHQOHPozTP54wS3xWJAVLUshOhn3jidK+yn
         WbVmwVGAqLpyMeIwu1WfrltFy6a1smnTlKMVs/jEGwyXKCm9m5z8QtQKszlCCSM7RK/0
         D7EHEeUgU4Bq1JG5JVz9LD0NPXvDyDATS5SvIeutIY2cBmfCVPmJNsyVvx5VwM8uCe3G
         AyRg==
X-Gm-Message-State: APjAAAVCo/haKc/GkPQbkRGq02hywsWx8WlXIz2V0TMfhdPQ/JESgalX
        XM6NQOZf9xHIYu+Lvo4kqZJTJ+Nl
X-Google-Smtp-Source: APXvYqxjp+UcHMecB5I71gGCXWvjWVXFN3bgJOPKcGl8zGm31guGEAau0Tj6s4UdRJVODFfVDPU0Ew==
X-Received: by 2002:aa7:c897:: with SMTP id p23mr8852405eds.220.1567076000994;
        Thu, 29 Aug 2019 03:53:20 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id c1sm376924edn.62.2019.08.29.03.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/6] PCI: Propagate errors for optional resources
Date:   Thu, 29 Aug 2019 12:53:13 +0200
Message-Id: <20190829105319.14836-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

A common pattern exists among several PCI host controller drivers. Some
of the resources that they support are optional, and the way that the
drivers handle these resources is by propagating -EPROBE_DEFER and keep
going without the resource otherwise. However, there can be several
reasons for failing to obtain a resource (e.g. out of memory). Currently
all of these reasons will cause the drivers to consider the optional
resource to not be there. However, if the resource was in fact required
in the specific case and requesting it failed because of some other
reason, the drivers would still happily continue and cause potentially
hard to find problems.

Instead of rolling all error codes into one, reverse the check and only
handle -ENODEV as meaning "resource was not specified". Fatal errors in
that case will cause the driver to fail to probe rather than continuing
as if nothing had happened.

Changes in v2:
- add Rockchip PCI patch which was previously separate
- addressed Bjorn's comments regarding commit message
- collected Reviewed-by, Tested-by and Acked-by tags

Thierry

Thierry Reding (6):
  PCI: rockchip: Propagate errors for optional regulators
  PCI: exynos: Propagate errors for optional PHYs
  PCI: imx6: Propagate errors for optional regulators
  PCI: armada8x: Propagate errors for optional PHYs
  PCI: histb: Propagate errors for optional regulators
  PCI: iproc: Propagate errors for optional PHYs

 drivers/pci/controller/dwc/pci-exynos.c      |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c        |  4 ++--
 drivers/pci/controller/dwc/pcie-armada8k.c   |  7 +++----
 drivers/pci/controller/dwc/pcie-histb.c      |  4 ++--
 drivers/pci/controller/pcie-iproc-platform.c |  9 +++------
 drivers/pci/controller/pcie-rockchip-host.c  | 16 ++++++++--------
 6 files changed, 19 insertions(+), 23 deletions(-)

-- 
2.22.0

