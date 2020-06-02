Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B01EBAE2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBLyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBLyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26FEC061A0E;
        Tue,  2 Jun 2020 04:54:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p5so3079889wrw.9;
        Tue, 02 Jun 2020 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4GhpoBoNLBeUpwllImkgBSNzkFnKg8SBMrnjFl2x3Y=;
        b=hpf7C2gdMUGyiEN0FclcGEeRKBmhCuoe2NnjOc4f6dRVHvUA/RvISJ9QslZE7MbyYt
         usf6lr0eit4SO8UKx3508BQ527pvuJf4qNyEdggg6KXbgDz1N3JjjCKO3sSMGs/N99Az
         cIo9Ld0KNHKHTiAzj1eWcJI27gV6nAWnrGdWaHH94DUVDaTMb6BoE4CMpFrBL0mEj1oX
         1xn4bjyN9eN6IjZsVtw+nty3UQ7aKoW60x35SuoIo+ta68WGmlUNuATWXoTpk2qdDan6
         qM6DN3xpmplkVhbScVowcazmVDD+saBuIbnlQLgvbS8PnAt3ZGRff009tzkA8seNBkm1
         QmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4GhpoBoNLBeUpwllImkgBSNzkFnKg8SBMrnjFl2x3Y=;
        b=ETsa5r0loM4SkquwkzZBOwocEMlJTo/QwhHMHfwgAW+AyKtP0N8hrL/Psdm2pVkwUk
         lTYRI/KdJ7kIwnRbXYret1IAS7sH/HeDuSJnRGXPrL0VkRbV8rF9ulXlcYpOjqm0RU2b
         DIFKDKoIV5Wdt3Z+ThTK2qM4PlWkzMeGy0Zv5y+sG5eA2ZFIz433zlYhtKY7+nC4brjW
         OZUqBGGoMaFOvVb1fawqS/ete59hAVvUxw9yMTsJvhot4S+AqAmxCDXKz8jwhlygHhUd
         Tb85cvwjgwynEilsP4v7/Fg8muSjvIfQuFsMNfP53e5rA1B3e6XrClKCJ6SuawTNmMcK
         gG2A==
X-Gm-Message-State: AOAM530NXuGr3nlnw9RVNlJDhLknJToM4lgNFs0s8oiDNX30d/N4PVLN
        ucOyJA12NhHTR8MaJG0uFKk=
X-Google-Smtp-Source: ABdhPJxP3FyWsBI9gIlo4+U5p0EScvJkbflfxGVo/M6RK/qEgDIu7WW8t7/9uHd82v/hoOmjoiMgdA==
X-Received: by 2002:a5d:4009:: with SMTP id n9mr6711027wrp.97.1591098858162;
        Tue, 02 Jun 2020 04:54:18 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:17 -0700 (PDT)
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
Subject: [PATCH v5 00/11] Multiple fixes in PCIe qcom driver
Date:   Tue,  2 Jun 2020 13:53:41 +0200
Message-Id: <20200602115353.20143-1-ansuelsmth@gmail.com>
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

Ansuel Smith (9):
  PCI: qcom: Add missing ipq806x clocks in PCIe driver
  dt-bindings: PCI: qcom: Add missing clks
  PCI: qcom: Add missing reset for ipq806x
  dt-bindings: PCI: qcom: Add ext reset
  PCI: qcom: Use bulk clk api and assert on error
  PCI: qcom: Define some PARF params needed for ipq8064 SoC
  PCI: qcom: Add support for tx term offset for rev 2.1.0
  PCI: qcom: Add ipq8064 rev2 variant
  dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant

Sham Muthayyan (1):
  PCI: qcom: Add Force GEN1 support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 171 ++++++++++++------
 2 files changed, 123 insertions(+), 63 deletions(-)

-- 
2.25.1

