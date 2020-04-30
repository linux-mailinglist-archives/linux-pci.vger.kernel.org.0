Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671AB1C09DF
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgD3WGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgD3WGe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E8C035494;
        Thu, 30 Apr 2020 15:06:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k22so5854122eds.6;
        Thu, 30 Apr 2020 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+mkxNtTPZhi/LAJrBV1pwlKLJ9IVJIPihcu3p+f0f4=;
        b=kLPGrpSDFXWcNc6EbBhYJxYWfjkLjQ7+maWsFJYWNSkObt+rcEeJ4YHfJ4srEPLr59
         u9GoVC2YIHoGYphA8DHPpj0ik+WK/rfttyR7UuR3r21N9YO4lEmOq+ApSkv4fSt86vUD
         L8pEXipDq1l3OXSBIcpf61geLhqO31d7ruLqGAa8u5Wlwv73OgaxTrt9xfHFqnUMuztX
         SLYd0WkNO9/nPwxusMvXelK03QcKPcokvJdvso/snVDF2GfshMeFtXK0wMVn2CLYX0Vq
         UNfdGFof4f0Jwd+KXQ6VhPUCWZ+VMn6LwMb/gkf4Mnddq/2K6jJdV9VgN3RPVjyKpGnj
         vSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+mkxNtTPZhi/LAJrBV1pwlKLJ9IVJIPihcu3p+f0f4=;
        b=hy3qxFBIMVrkMNpsJlmxdaEF44uAx9T3FqFKAxt8yRkC8yxPv1P6VjB8cOCZnj7WTs
         gpgn8RrqjJuNYbAnxBiUGdU3MMpekF2sVMdxOqhuSstfBlJZIqTxQEchdwIuOPsmbXF3
         ea2oibGmsSHNIo8kMEVivcKvcdh42mLLvrMaGMbzQ3QUc3dBB23akc3ZdiIIT50rHZpx
         1XSO/z0orXrmWEtCNK5j8oxUUj/6Zx+j8CH0CRiBiFDXw3NNMtoVKUm7M+Eqz1D1Pw9x
         /+7aGiPisijtz6OhEElfMCGFYR31STOA0lsoGSNm7gj60hgk59iMpO6yfxvgZAW+TBje
         WpFQ==
X-Gm-Message-State: AGi0PuY+k2prM2X2xR6K3zrBeVzK9dnJqqpxhLQbc8rrWFU2WQU3GSA0
        bNYp4/7VlASrmr7rg06aqCY=
X-Google-Smtp-Source: APiQypIgPFzSk+gRylgl6RZkkZgJyX6/kqkDDLtTXeaQ/UD4SIAItyRDStoTO2fc2ZgBpRYFfqAeZg==
X-Received: by 2002:a05:6402:712:: with SMTP id w18mr1101986edx.386.1588284392192;
        Thu, 30 Apr 2020 15:06:32 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:31 -0700 (PDT)
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
Subject: [PATCH v3 00/11] Multiple fixes in PCIe qcom driver
Date:   Fri,  1 May 2020 00:06:07 +0200
Message-Id: <20200430220619.3169-1-ansuelsmth@gmail.com>
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

v3:
* Fix check reported by checkpatch --strict
* Rename force_gen1 to gen
* Fix spelling error
* Better describe qcom_clear_and_set_dword
* Make PARF deemph and equalization configurable

v2:
* Drop iATU programming (already done in pcie init)
* Use max-link-speed instead of force-gen1 custom definition
* Drop MRRS to 256B (Can't find a realy reason why this was suggested)
* Introduce a new variant for different revision of ipq8064

Abhishek Sahu (1):
  PCI: qcom: change duplicate PCI reset to phy reset

Ansuel Smith (8):
  PCI: qcom: add missing ipq806x clocks in PCIe driver
  devicetree: bindings: pci: add missing clks to qcom,pcie
  PCI: qcom: add missing reset for ipq806x
  devicetree: bindings: pci: add ext reset to qcom,pcie
  PCI: qcom: introduce qcom_clear_and_set_dword
  PCI: qcom: add support for defining some PARF params
  devicetree: bindings: pci: document PARF params bindings
  devicetree: bindings: pci: add ipq8064 rev 2 variant to qcom,pcie

Sham Muthayyan (2):
  PCI: qcom: add ipq8064 rev2 variant and set tx term offset
  PCI: qcom: add Force GEN1 support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  51 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 241 ++++++++++++------
 2 files changed, 211 insertions(+), 81 deletions(-)

-- 
2.25.1

