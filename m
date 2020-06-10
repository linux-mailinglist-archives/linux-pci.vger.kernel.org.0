Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EF1F5888
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgFJQHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFJQHJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC2C03E96B;
        Wed, 10 Jun 2020 09:07:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m21so1773104eds.13;
        Wed, 10 Jun 2020 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JY2Z05wEjT8R9Sg8HziVbw08CeVdBXBZ3omkpyDUIzA=;
        b=dnV4ZJgJdAsDZJy/TPbwjrsCspuam2T88UdIM3M6XgPm+h2Ttt+oZtBt/m4PI3c3zF
         JoxNomgqAf1ZkdsKW+heA/d5GPNxl9HeiOCy1VrIbYf8zxW0hnsohInNDqjrIPn3yKH9
         nT831LHonxnwqHRgvSyCKUfKbDWZ2R32qwtEutL4KWz4oHkadp7pjg/qgREVO9YNxrrr
         DUofDtrbAKkY0B4kwIg691RvVYMB2bjhRqNN9yd+swWuY4vr0g7BiLaJAj1ubFZ1JYQ2
         Vw+qDjNtm25yCxNrago1akR8LUODwg/x7KHD1VVWNdLUOgVy40EOBZZoHvvL8h+IBpk/
         yanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JY2Z05wEjT8R9Sg8HziVbw08CeVdBXBZ3omkpyDUIzA=;
        b=BrFNB4u+8K4EB+NAsWlC+ut2rHLzo5lpzlcVF7Oz+0fcmhaDMZbANytZGFFH6alEvK
         EdcGoRRMi9KvOTcsJipSOVOGsNhvGVIO3Lf9hpgnsAf7JY6ENcUUtnRhp5ZO9dbmwFOF
         xl/nOCJ/GFN4ldgk7KeZa8GktQuyFI0jxMJLMoYMYpFicjxsxYHzRcsHGEkAWZ6C9yTn
         70j++U4h6CR6aKRNSeyYPe+h02R3HgR1J9zMpTHf03zkdeai9eKfgicmWqs0I7HwwuFI
         QlQGMW+3VqhRNFu8HR6GQQu6V/pMAb14IhgpG5f5w315A8oI+MEzqZKeriwlwKg1O1ew
         zAag==
X-Gm-Message-State: AOAM533Klr7mslrq5AzGouTXDr5KLTRJPUAwtMjobVhwXk4QTw3zkoAC
        +QSCFtZ8lvgv0QEs1/xz17Q=
X-Google-Smtp-Source: ABdhPJznD/qmqCNCqlkejLt5TscQD+1ezVWRuD6Ejw2gkqK/isOjk1bLru4xuGEqt4Vn+Y46ApM3tg==
X-Received: by 2002:a50:aacc:: with SMTP id r12mr3044815edc.219.1591805226842;
        Wed, 10 Jun 2020 09:07:06 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:06 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/12] Multiple fixes in PCIe qcom driver
Date:   Wed, 10 Jun 2020 18:06:42 +0200
Message-Id: <20200610160655.27799-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This contains multiple fix for PCIe qcom driver.
Some optional reset and clocks were missing.
Fix a problem with no PARF programming that cause kernel lock on load.
Add support to force gen 1 speed if needed. (due to hardware limitation)
Add ipq8064 rev 2 support that use a different tx termination offset.

v6:
* Replace custom define
* Move define not used in 07 to 08

v5:
* Split PCI: qcom: Add ipq8064 rev2 variant and set tx term offset

v4:
* Fix grammar error across all patch subject
* Use bulk api for clks
* Program PARF only in ipq8064 SoC
* Program tx term only in ipq8064 SoC
* Drop configurable tx-dempth rx-eq
* Make added clk optional

v3:
* Fix check reported by checkpatch --strict
* Rename force_gen1 to gen

v2:
* Drop iATU programming (already done in pcie init)
* Use max-link-speed instead of force-gen1 custom definition
* Drop MRRS to 256B (Can't find a realy reason why this was suggested)
* Introduce a new variant for different revision of ipq8064

Abhishek Sahu (1):
  PCI: qcom: Change duplicate PCI reset to phy reset

Ansuel Smith (10):
  PCI: qcom: Add missing ipq806x clocks in PCIe driver
  dt-bindings: PCI: qcom: Add missing clks
  PCI: qcom: Add missing reset for ipq806x
  dt-bindings: PCI: qcom: Add ext reset
  PCI: qcom: Use bulk clk api and assert on error
  PCI: qcom: Define some PARF params needed for ipq8064 SoC
  PCI: qcom: Add support for tx term offset for rev 2.1.0
  PCI: qcom: Add ipq8064 rev2 variant
  dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
  PCI: qcom: Replace define with standard value

Sham Muthayyan (1):
  PCI: qcom: Add Force GEN1 support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 186 +++++++++++-------
 2 files changed, 128 insertions(+), 73 deletions(-)

-- 
2.25.1

