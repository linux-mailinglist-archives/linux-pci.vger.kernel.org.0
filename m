Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC011FA246
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgFOVGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731170AbgFOVGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB6C061A0E;
        Mon, 15 Jun 2020 14:06:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q19so18970495eja.7;
        Mon, 15 Jun 2020 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iSLowAHzv5UppOJyHI841FgoCvnsGVwWK2jiBsg8Sc=;
        b=heZADYio+VugKLJ3RJdTYaCKmB2URa7TmmG3j11IkqVWnsEx368j7yMoKLDnF9wevv
         pa67zrCodwVjqpyebv+FXUIIKcW7D0HrwZkmx3qbHwtEIJhJ3yyrP/liZDNzg9SZDgR+
         Qe8dNYG+k2/EOp4FbvqVTaxJo37IoLILvPFk0/tmuA95qm3Er2RW8u/iqzUbBIx4e7MQ
         5xIvTXUMxMMB+dyUDWhSXygIMJouy5Q0PULIQp/YJfpUkd6RDvrF0gQAYI8hixfTwNkG
         7uegGxC9QVBtTMfqZwZr/4ZhgXCZfcZ2dTDXdC7Zse9bFSd0cBTBp994w+180yUtbYNL
         qUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iSLowAHzv5UppOJyHI841FgoCvnsGVwWK2jiBsg8Sc=;
        b=Wt0MJ+O89xtRzWCQILz5XvZKjLYxQ6tScoi74G0DuCyQbvfmBJX+BWpHSQoh5oIiTI
         /4Ca5fAUdLCjJgXSfpMvIQq0TdgmnntGHNi309i4TV3jBIrxzX23RvTwQyVRRxhDKvxS
         Hqbcp4E0ILoWLE46lerlSuWx9pWdXI8Gkq9HNjBhxUfHY3G9/y9rp/r0if2s1zxyO17a
         2fbIHlIJUiWQBQE5VK6RUColkP7jW8SvbFIkC1wwAboa1LuZL4HwFmThnI3ys1HWNgM+
         6rVg8bZdBZzA15T4UXxWndaP5TDUy5VQno4gdbAXQR9G/6znUTrhy2c+wBnf6ALcii3/
         yFZQ==
X-Gm-Message-State: AOAM530nHoh/GQrxUKQ+0c/SxDmRWFa7cNxEbub2R/wj1jeQ4OABGlT5
        FfgFzkTz7MkAmoU3XMnRJSA=
X-Google-Smtp-Source: ABdhPJy8CnJs/p2VFIpOHe+45Xsq/xWQqT4F9aKzNVFX/YEdaelKyfbpwZoa+jwrQ/2mKCSV8HSGaw==
X-Received: by 2002:a17:906:ce47:: with SMTP id se7mr27227331ejb.149.1592255173410;
        Mon, 15 Jun 2020 14:06:13 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v7 00/12] Multiple fixes in PCIe qcom driver
Date:   Mon, 15 Jun 2020 23:05:56 +0200
Message-Id: <20200615210608.21469-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
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

v7:
* Rework GEN1 patch

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
  PCI: qcom: Support pci speed set for ipq806x

 .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 186 +++++++++++-------
 2 files changed, 128 insertions(+), 73 deletions(-)

-- 
2.27.0.rc0

