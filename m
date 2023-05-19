Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F347099C0
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjESOb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjESOb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:31:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED7187
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:31:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-253570deb8dso1881946a91.1
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506687; x=1687098687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2i+4jZMYyJOuLHa5p2LrqOp9rYboDhqgn1MB/sFP3Yk=;
        b=NGH3s5VWcjCYJ467VCymIG56S/3e59VN9TouKrORlz1kUH9pDmPg+OhKrB7IREV6Rp
         kyfAqSlCnfHExdp468iMVrISs6R+GMlbQ1CNIlcI1H05fV8MvYoZ8rVO2Mb4OV5wKw3v
         I2bZ7wlj/bmDqIN8+0fwdCIE2/PYo+5mu5RzVhFiJ2YiTMpKd4F2lH6Vtg6aFyRA4ILl
         rv7jDg/JBqRVP9kP83q9iGSkkC1pc5qJ8m3npI278unfvFayw6rzteHKvQ45jeEz1yel
         WiqQADrAXSBPKyRx3xMRGcyYlXSv51Ab5b6XCaKL0GFBrwacjOCTB2sJDic4lu1vexJt
         qkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506687; x=1687098687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i+4jZMYyJOuLHa5p2LrqOp9rYboDhqgn1MB/sFP3Yk=;
        b=ex+Wdna1ABkobb36HxsCkSqelYKk9FTNTeuJXcQ8UuJSP7dLfMSmFcEy3PrWjrprmi
         mgGhM29rpXF/UKQ1YmzkuFM9DzK6Y/2oOtPpvgPMwhu0KiEu/WSZRM1i3Zo3icGylyYR
         2A+4rlUxgYKiKCIrtyDHIOXn1ALIaJCiatyJ5yPVVoIrQ/bjUmZEeXXNt0BdvRBanO9I
         RuXlaHNJgr/EF2x7Wf/UfxQTQhtnemNn+CrM9YMJh6eDlg2+AH6B5zF2jebXsafrzVZu
         Ng7SSNkpbHaarRDM89dU28OLEr3/txkfFypWL3KuBjgqANRm18YpC5KReUgzwxOwifPA
         hCQg==
X-Gm-Message-State: AC+VfDwDY5atdilIdTO3DLJVfn2vW319l51180udNXG9+7a+to2WDLse
        tAZJ80iizehvOUdCzphO+e/M
X-Google-Smtp-Source: ACHHUZ4YSPrAcDxn1zJ2i51SAYCP+PWm804ct+HEEvUvMD4g7cLt1qC2faNpG6gOsV6P1sjOQukimg==
X-Received: by 2002:a17:90a:c712:b0:250:2192:1bff with SMTP id o18-20020a17090ac71200b0025021921bffmr2556538pjt.23.1684506686731;
        Fri, 19 May 2023 07:31:26 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00250d908a771sm1634845pjo.50.2023.05.19.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:31:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/8] PCI: qcom: Do not advertise hotplug capability
Date:   Fri, 19 May 2023 20:01:09 +0530
Message-Id: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

The SoCs making use of Qualcomm PCIe controllers do not support the PCIe hotplug
functionality. But the hotplug capability bit is set by default in the hardware.
This causes the kernel PCI core to register hotplug service for the controller
and send hotplug commands to it. But those commands will timeout generating
messages as below during boot and suspend/resume.
    
[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
    
This not only spams the console output but also induces a delay of a couple of
seconds. To fix this issue, this series clears the HPC bit in PCI_EXP_SLTCAP
register as a part of the post init sequence for all IP versions to not
advertise the hotplug capability for the controller.

Testing
=======

This series has been tested on DB845c (SDM845 SoC) and Lenovo Thinkpad X13s
(SC8280XP SoC).

Thanks,
Mani

Changes in v2:

* Collected tags
* Moved the HPC clearing to a separate function and reused across different
  configs

Manivannan Sadhasivam (8):
  PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
  PCI: qcom: Disable write access to read only registers for IP v2.9.0
  PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and
    v1.9.0
  PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and
    v2.9.0
  PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
  PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
  PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
  PCI: qcom: Do not advertise hotplug capability for IP v2.1.0

 drivers/pci/controller/dwc/pcie-qcom.c | 73 ++++++++++++++------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.25.1

