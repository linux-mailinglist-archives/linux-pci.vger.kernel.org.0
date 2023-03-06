Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4985B6AC51F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCFPdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCFPdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:33:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F50528D11
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:32:41 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so11105221pjn.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt4PnJhS2YRcl1V5hJsj3yA+GagqVnLSKo0OGCRHctc=;
        b=CQnRbnfuwO2EE097d2GHPjRyr3PHyjthwep650jJ46Ud18aYxadBX7amPPsMMh38lb
         L8/pVM5WWPsSyVMfFzEnSThuzKt6ineBxxCG8zVFCkCfXxxhztQ08n7VZXDPBtvjF60y
         TYbhHBoG1v9tjhn82LymUPbXe5y0SBGZSiWQeh0ZiykIFizKwfbnJRXK2tWFqhBbd7Xs
         ySBgIg0WjGema48SQ0VMYS1a2s/1K4jmtP2YgsGSL9P+tHCXvtxOga/Zfm+mV8HHn+q8
         oCpqhQX6/cdYMvJEhMMwvHSAmWYT5iaEZt5sexDETg/WZC5ORwdM+o0NEuLGAiHrvYp6
         bAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mt4PnJhS2YRcl1V5hJsj3yA+GagqVnLSKo0OGCRHctc=;
        b=CvFU70b4GPvUkjbECQbUHxFySZVjmVB2kYBcYeqds5VMAnOyq7tLS7xTLN2mcFkPon
         YkXhEloN5VonL/amvVB0k/9RfIn6NVQlJsxB3hArK9R9olVSrZkeR0XFgEeyDD1LqN6R
         NXkjjNSmmRz1dh8F3/ZGnYlAViyLQrnUMRZ+nfnsBfj2EpUcZM0EEl2+zFP9xi0CJiu4
         XcPEhLhJ/i3pnhufQsAMVs9b92zg+FCELFF1fbEdSJQdX50Cua0FMx8mvoxKlOD45mr1
         LfsEN+rIn6Vq+IkGfjA8BRQnHA4UXVwX6gTxhOJ06mrYvhYdbbWtzSX7K0E1UG7JkANb
         ykEg==
X-Gm-Message-State: AO0yUKUnHekWKOLT671hMc9y5CyWzeG1I0UzfDLDlNnQ4R/sXKcNRZpU
        1qGZw4zu1Ff60x4DqJO/oS9Q
X-Google-Smtp-Source: AK7set+HjBdNIpsf8ef4VJSwEelL+jqIfP8yZmMfm7xzM1eTk7/8khH6kLRd036efOYER8cCvsN2DQ==
X-Received: by 2002:a17:902:d4cc:b0:19b:dbf7:f9ca with SMTP id o12-20020a170902d4cc00b0019bdbf7f9camr15257570plg.0.1678116759945;
        Mon, 06 Mar 2023 07:32:39 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:32:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/19] Qcom PCIe cleanups and improvements
Date:   Mon,  6 Mar 2023 21:02:03 +0530
Message-Id: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series brings in several code cleanups and improvements to the
Qualcomm PCIe controller drivers (RC and EP). The cleanup part mostly
cleans up the bitfield definitions and transitions to bulk APIs for clocks,
and resets. The improvement part renames the "mmio" region to "mhi" as per
Qualcomm's internal documentation EP driver and also adds the debugfs entry
to track link transition count in RC driver.

Testing
-------

I have tested this series on SDM845, SM8250 and SC8280XP based platforms.
However, I'm counting on Qualcomm folks CCed to do testing on older IPQ/APQ
platforms.

Merging Strategy
----------------

Binding and driver patches through PCI tree and DTS patches through Qcom
tree.

NOTE: For the sake of maintaining dependency, I've clubbed both cleanup and
improvement patches in the same series. If any of the maintainers prefer to
have them splitted, please let me know.

Thanks,
Mani


Manivannan Sadhasivam (19):
  PCI: qcom: Remove PCIE20_ prefix from register definitions
  PCI: qcom: Sort and group registers and bitfield definitions
  PCI: qcom: Use bitfield definitions for register fields
  PCI: qcom: Add missing macros for register fields
  PCI: qcom: Use lower case for hex
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
  PCI: qcom: Use macros for defining total no. of clocks & supplies
  dt-bindings: PCI: qcom-ep: Rename "mmio" region to "mhi"
  PCI: qcom-ep: Rename "mmio" region to "mhi"
  dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
  arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
  PCI: qcom: Expose link transition counts via debugfs

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml |    6 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |   12 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   15 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |    6 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |    9 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   38 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 1009 ++++++-----------
 7 files changed, 414 insertions(+), 681 deletions(-)

-- 
2.25.1

