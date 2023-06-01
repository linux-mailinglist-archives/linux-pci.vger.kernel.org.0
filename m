Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552C71EF37
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFAQjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAQjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 12:39:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352A18D
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 09:39:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-652a45266dfso14633b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637554; x=1688229554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOOciFoH4cpEM1lcqTLO3ukPDE6ER2ndNsc0mysgwXc=;
        b=K0aslblqvpdTYqwkS4XYEl7gVij/GDApljQ8rkkcVbC10b2ClMbHVm3fLa5AlJcKY0
         ESsZW5Sfaw5W55g+20mplkeIWb04BxIq40oWqYGl+a5622EUxNjDbcqP4HR5Jxhc5hde
         06xaXqZCYud+S/5qX+Bpsr4iFUGfwH2rb8lNX/cOJRIuV7Rm2Ok2xvkYRVlOx+AbEDEa
         Mht+YSaXCNaDjObK1J/5lEEzqNKPnWaXM61ss6d+55y3Q0+dfLp+HrY2cMcK9x3StibI
         robd2eL/wWjjyb7KHT5OIUQ7OK9GFMEoqjmjDZNefM8CdQNxDYC5/hicj13ZNmGwIuF4
         7+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637554; x=1688229554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOOciFoH4cpEM1lcqTLO3ukPDE6ER2ndNsc0mysgwXc=;
        b=L0HSI8j/jAcB7cjjR1mmjErssud4CRVPm9dABRfxE+VhHW7a9eW6akC3bceGAouqgm
         1238tARs10fITGgmPTaycTTKjwXkJVP55HQaDcqPLRlkPl8RQWqlKzF3pIpZgXkee5Zq
         Xkt8dmcjRqG/xWWQswHk/DvoseJhPwt7bWZPqOVXWbW37oBx8hZkMD9WD1YDeOpoZlAy
         lC8nErKKJODQyoe/7l09N+GmeIQ4WzmOcIEiSGIL/QmKPwijMx18rSc42X35kW0EJElN
         t57yncJP6MdU3MttoqvgU5HrcPwo3XtFwAxR9JozLe6dlUodcUIaa6wBqA3IdDgYvjQF
         SvlA==
X-Gm-Message-State: AC+VfDwFUmLHa3Ur0PGM2o+halKx+UEgU9XKSCWK5/CYxrjkI7/xtku9
        U8LgujgJUQnMe/3sVo17W/ox
X-Google-Smtp-Source: ACHHUZ69860DO9v4Sa6prJ4OIPewxb4aEA42dlmX9ftkLqMZq96X1XrGVDAkguz08vsZtyV4Ddcarg==
X-Received: by 2002:a05:6a00:170b:b0:64d:1451:8233 with SMTP id h11-20020a056a00170b00b0064d14518233mr8621898pfc.21.1685637554416;
        Thu, 01 Jun 2023 09:39:14 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/8] PCI: qcom: Do not advertise hotplug capability
Date:   Thu,  1 Jun 2023 22:08:52 +0530
Message-Id: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes in v3:

* Dropped double signed-off tags
* Dropped Dmitry's gmail reviewed tag as per his request
* Mentioned the newline change in commit log of patch 2/8

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

