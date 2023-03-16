Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10B76BC85D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCPILn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCPILm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:11:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB21A591B
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p6so458092pga.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Eav/oAmJq7++65cUHMGIBG7P16aXoRr06VncT/cPA=;
        b=LLQMzBCn7bNMEiEz7dBQ0oXXCRYOcZ0jXobLEaKxSia7TzUYMeyA85zYN43hczA0jG
         b8kQ2IMizEY09EnSjYmH7f/tqI7r9Et47KH52Bb6JIAUd/qVYJYc18x1g8D7LDejjYbf
         sFnEbJ7b37f32gPziyciXwL8V7/8Xls4BpxBD7RmQyaRLFAPbXrWXnZVxH9mKs/ipY4n
         DYq5CFbKYHV8ZGRKkyy08Tszju2u+LVgpVWi0R4Uz8aQh4mgrD/eVUtMQeOod9yCGwE1
         xCXQ2WLgOB77nAJ2PKQaJ6kT2+37ABES7HpEUKGyF5ZpjbjHRTswWYUPvp+5Yhw25Bgz
         ahlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1Eav/oAmJq7++65cUHMGIBG7P16aXoRr06VncT/cPA=;
        b=22OKqEJ5s9qbQdTlWQhYwgOoDOwl8ZG/Fo7sCpX6zF+dTs8IJvouBTOQtoAz0odtTz
         s6AzKLh3bk4LccLcpXg8jqxsNAoXXiGcMeaSFsT+k4dR3dcLIckMhPjrKDiJ54PFKHWt
         7mLddxbRLtMQsXVRShkoD4jbjBe/UAKDiMZFuX8eOgCGSLnDj/nf6NayctB//rzsnPfW
         tVLMVoya5LhI6b04z+INzVye5PbpUhcpQSAiTJLQB4LnWufs364abprB1Cy1Zy/piENo
         LCyByKjgrNbBNMbbqwBBCnMJQQnyfGiX6ByJ730/SqIalQANxLOHBuUSfNkVzneWeWJi
         UCpg==
X-Gm-Message-State: AO0yUKUHLS1jt/zESZhMbNbwog+ZjgtKWEGeWZv2dkUXNKQyCFfmnGsG
        2+H0dh715XJe914+w6Tr9rAr
X-Google-Smtp-Source: AK7set8qfktCpq6pLH72bdHlC8cQoC3t8oOkYGlbJhdbXnZXlWwt2bVL0i0p8f97J2ctxFGr2zG1HQ==
X-Received: by 2002:a62:8491:0:b0:625:db7a:da08 with SMTP id k139-20020a628491000000b00625db7ada08mr2645671pfd.9.1678954291820;
        Thu, 16 Mar 2023 01:11:31 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:11:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 00/19] Qcom PCIe cleanups and improvements
Date:   Thu, 16 Mar 2023 13:40:58 +0530
Message-Id: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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
and resets. The improvement part adds the debugfs entries to track link
transition counts in RC driver.

Testing
-------

This series has been tested on SDM845, SM8250, SC8280XP, IPQ4019 based
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

Changes in v5:

* Added a new patch to fix an incorrect register usage in config v2.7.0
* Added Reviewed-by tag to the binding which got missed in v4.

Changes in v4:

* Dropped the debugfs patch for v2.4.0 as the registers only expose the status
  and not the transition count which is not useful
* Modified the existing debugfs patch to be applicable for all SoCs that define
  "mhi" region

Changes in v3:

* Introduced init_debugfs callback for defining the debugfs interface specific
  to IP versions
* Added a debugfs patch for v2.4.0
* Added a patch to rename qcom_pcie_config_sid_sm8250() function
* Added tested-by for patch 11/19

Changes in v2:

* Moved the "mhi" region to last in the binding and dtsi's
* Dropped the patches renaming the "mmio" region

Manivannan Sadhasivam (19):
  PCI: qcom: Fix the incorrect register usage in v2.7.0 config
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
  PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
  dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
  arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
  PCI: qcom: Expose link transition counts via debugfs

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   12 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   25 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   10 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 1158 +++++++----------
 5 files changed, 476 insertions(+), 744 deletions(-)

-- 
2.25.1

