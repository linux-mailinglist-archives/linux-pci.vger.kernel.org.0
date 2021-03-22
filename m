Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2269F343C8C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 10:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCVJTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCVJTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 05:19:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4138C061574;
        Mon, 22 Mar 2021 02:19:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so10135700pjq.5;
        Mon, 22 Mar 2021 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efnAI/yjOr8RIomc8owdNJdevgWzmGgU4gh2frhOv2o=;
        b=t8m/O5lHWMgwE4tUwP1WvpTsq5MmCZDtk//MJfgi/f8EqRmRSjHbh/rxvUWD+029Uw
         cCUOslM2/DEcp8IrxoGwxrzUhUTHtuY2CUmApjf4Y/RWgg+9cAUAw+YLD3MSFqz8r/ON
         9pngDW+6mzpUDlDJkzW/odrgK2h/oo6LtjM/fOKwBlyeeydyWHA7tj2VOAwhddcW1R7X
         0tzNDfkliKcEVohjbekoOKvrEoWd4RkRvg0YsHjadmH9rwOVx3lEDRv6Ck8oj17mWYvt
         oHuEcYBbWNkB2+6sE4fc6g045w23sX4OBV5BEcMhWA3R9D5oaa+iyQ67rZG2O4IbvEgV
         VgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efnAI/yjOr8RIomc8owdNJdevgWzmGgU4gh2frhOv2o=;
        b=QKuVLZL5O10sD9weyi/jLNPmtXJahgh7pGs0ZnsDP/dCzP98NpuB/xp50mJwwH+erH
         I9tkxixEVZknzzcgoZiRQWYtoWbrEkwJheKm9PefzFlNq+lYfVbj17rO782p7RiAbi2+
         ITVMU8WgyjwQZm2q7v7KXRpl6z0p9cpRx5WQVKEazoQMEOcBfBlaPU0RFKG0iVRC7cIF
         Yxc5F3oI3MIVlL0yxKu5EnI0qNYWGWmgZaKJVhWZ9M9lv/lO9Ui0hC4hcSKBZ48uwwqy
         F9LvRUrEu78c8TjYOJvpMk0vgAfWsDBgfs2sg2a7BzVI72udbNO7KCWCGyVrZxsqUKU6
         Bz4w==
X-Gm-Message-State: AOAM530k6A/npzZqKd21dFLC3kPRHzArHxTV8SPd6zda5lUZTq3yhIey
        za5LM9Traqbh4CorViWr0WrET6i13oo=
X-Google-Smtp-Source: ABdhPJxNnN8m6o8eKyONGvib0sobLbwxgfGqE8Ikyuw3a2yFtsO7fh8grvc00Lx1qssSJyYLlVfBOw==
X-Received: by 2002:a17:90a:3809:: with SMTP id w9mr12125509pjb.79.1616404763206;
        Mon, 22 Mar 2021 02:19:23 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w17sm11987756pfu.29.2021.03.22.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:19:22 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Hongtao Wu <wuht06@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH V6 0/2] PCI: Add new Unisoc PCIe driver
Date:   Mon, 22 Mar 2021 17:18:29 +0800
Message-Id: <20210322091831.662279-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

This RESEND patch set V6 is based on v5.12-rc4.

Changes since v5:
* Change "GPL v2" to "GPL".
* Remove exit_p wrapper which used to define remove callback.

Changes since v4:
* Install 'yamllint' and upgrade dt-schema in order to solve the yamllint and
  dtschema/dtc warnings/errors:

Changes since v3:
* Split the property 'sprd,pcie-poweron-syscons' and
  'sprd,pcie-poweroff-syscons' into reset, power domains, phy and so on;
* Delete the function to get resource 'msi' and 'dbi' which were parsed by the
  DW core;
* Delete the function 'sprd_pcie_host_init', because the DW core has done it.

Changes since v2:
* Change RC mode to host mode in drivers/pci/controller/dwc/Kconfig;
* Change Signed-off-by from Billows Wu to Hongtao Wu

Changes since v1:
* Test this patch on top of Rob Herring's 40 part series of DWC clean-ups:
  https://lore.kernel.org/linux-pci/20200821035420.380495-1-robh@kernel.org/
* Delete empty function;
* Document property "sprd,pcie-poweron-syscons" and 'sprd,pcie-poweroff-syscons';
* Delete runtime suspend/resume function;
* Add COMPILE_TEST which CONFIG_PCIE_SPRD depends on.

Hongtao Wu (2):
  dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
  PCI: sprd: Add support for Unisoc SoCs' PCIe controller

 .../devicetree/bindings/pci/sprd-pcie.yaml    |  93 ++++++
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c        | 292 ++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

-- 
2.25.1

