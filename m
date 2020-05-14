Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12521D3E7D
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgENUHa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENUHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2BC061A0C;
        Thu, 14 May 2020 13:07:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id se13so3870446ejb.9;
        Thu, 14 May 2020 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQmt30TFAqZp3yOvZIOG5QAMcRr8CjctI3ajbEh56NE=;
        b=ApMDbkPkRNIC/7RcXmpSwCcvYGJNF485BSW10W+PTcRPdHjRQRRnSgDZgC9dL4dLcZ
         JO5wK4BbdxmM2pyFjSSy6wjHui7t4pMqh9zGKL9gQFfuAppjsMceZAYYi/M0YJYPObEp
         DTXpB5VoTaSbeFi/T96dsKzdeXHuOrIhQ/ha4fOq8+9MmKSfP3GzfOExSzDBXD/Aqjfr
         FpLfUl72IjTNWr3lADuDZ3WRxfEpFdpvdS87vfPuXJB5oNZs9ePpW8x8N676aWYOjt8X
         Wb9sj3/B9GV0IqdjPbU/x4WmHD10OFpG5eiR0xKbWBoBn9hjAqjxJ4HjRcLY++/IUaNv
         jx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQmt30TFAqZp3yOvZIOG5QAMcRr8CjctI3ajbEh56NE=;
        b=jJVNdxJxcjK4jGgJ+Fl8oRGSvM7pSg/erUUCX7Z1/3V9Xv5c+YcjgW5ZErIfBck060
         vdtUj+reaTsssgVUNeyaJ+WHNfYsr3CoeDMEMN/zkdwqk31u7uEsX5NoZLGhOH1KiW3y
         RvEgWnjvqussp/cLN6NSZ+69iTF5IS6ZiMuQ6eYcCd2qqynsvYv+hgLAqQWpNX/pTzAM
         MnU6b77KXsW3MpVyrPC/v2E1OnQZpsOHdB0gNaZwP5cgVAnk8KMl+CSO7GewgMRE5LsV
         AheSMlNy/QWWrf/RdTyTHX+O36lS+6Je6gJKrkFQpQmH6BRHfxhmjIBQ7NisbUp3F4EP
         25oQ==
X-Gm-Message-State: AOAM531Fe5pYRwaXlubvdLPWWet2zMpG05Nn9xbMac9RidRWzbBNIlFi
        WQgZtT8qfaf1BEY1Vj/nrUo=
X-Google-Smtp-Source: ABdhPJyZAqVxxW4F6pijP3vARs0Mzl6g5yvW5S652fmezLr8yo1QqHC5CwiciahBVh46lbuFoEDTFg==
X-Received: by 2002:a17:906:5795:: with SMTP id k21mr5504825ejq.374.1589486848391;
        Thu, 14 May 2020 13:07:28 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:27 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] Multiple fixes in PCIe qcom driver
Date:   Thu, 14 May 2020 22:07:01 +0200
Message-Id: <20200514200712.12232-1-ansuelsmth@gmail.com>
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

Ansuel Smith (8):
  PCI: qcom: Add missing ipq806x clocks in PCIe driver
  dt-bindings: PCI: qcom: Add missing clks
  PCI: qcom: Add missing reset for ipq806x
  dt-bindings: PCI: qcom: Add ext reset
  PCI: qcom: Use bulk clk api and assert on error
  PCI: qcom: Define some PARF params needed for ipq8064 SoC
  PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
  dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant

Sham Muthayyan (1):
  PCI: qcom: Add Force GEN1 support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 171 ++++++++++++------
 2 files changed, 123 insertions(+), 63 deletions(-)

-- 
2.25.1

