Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE86F9003
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEFHbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 03:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 03:31:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A59D5FF5
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 00:31:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so1802724b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 06 May 2023 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358308; x=1685950308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWU7+3l9MN86IsyDHTUEnafJOEk6Gbhr7uhiM01UMBI=;
        b=zpnHt2Fk931G4JgIg29mWsXwuXBLqfecJPsLVdZbEWj60hUF0ipA+Ha2jQw8FJ0GeM
         zkWZfQJJkFJ3lT5gsrplSAaaDDNxKT31Uo63FJko1xmkLhCO433j/8d0qEF07Etr8lQn
         Gh71qD/gEqOtXI+Wzn5FQkPYc2hKdvEM2iGn3fmjxOA8uqhPTXRK/n0K4RZrc7/JV5Ah
         cdqQNKs5C7FhvRIe/M0OsUdzd//pjo5CweN6cqjwZXv7Y56jboXja0MoCrkAZKo51wRZ
         FYpr9HJaozjOtzpc50ZOIxk7viGu37YqIRwVWUHj4ejwJe5j6Me6xHy0kETXAs0EcJk5
         iTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358308; x=1685950308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWU7+3l9MN86IsyDHTUEnafJOEk6Gbhr7uhiM01UMBI=;
        b=CgrzCD2jIi+jZC2k68RvUlJ4aNruiIob+AosXAf+QCYDX6ouLpZEiyNrQ8MEjDBWMr
         XSnqr5b1TX1BaOqPSNnOMqCfD2r0qBEA5iAcWj3SCt6jCYhefYzQvshTOlSf8ol4zTCu
         sqyMdZj07FfNFU0fO9iDhIvtLhAL23G2w9tboXydU47sXWyR3RiyS0NReUPQ3ihNOpwa
         u2CPVaNdCro9MnRljOfiTgq5m/kBoqAA3dshNsb0K9tDjbVnpVx16SyTSRBTO44kYozI
         0V2QIGyy264rIGMA6MUrVkN02IU0XCOT2CTIMaV+ah582mlFU+gMRO5uNubMOHfEMAqM
         k5aA==
X-Gm-Message-State: AC+VfDxbCKFqkHNQ2JpUa7GWFvdolKU9IyBSORa+RCBkcTsuv99id916
        pfyiELX7p1TKNZcwGtuF8nqo
X-Google-Smtp-Source: ACHHUZ65d5V+Jqxabv8rKD5glj0EJUE/2Bu6isc1uK/W7BUVySAipuSFuG2RBvz+4QmMoaU292AZEg==
X-Received: by 2002:a05:6a00:23c3:b0:637:f1ae:d3e with SMTP id g3-20020a056a0023c300b00637f1ae0d3emr5736555pfc.25.1683358308446;
        Sat, 06 May 2023 00:31:48 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0062a56e51fd7sm2627373pfn.188.2023.05.06.00.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:31:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/8] PCI: qcom: Do not advertise hotplug capability
Date:   Sat,  6 May 2023 13:01:31 +0530
Message-Id: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++----------
 1 file changed, 60 insertions(+), 37 deletions(-)

-- 
2.25.1

