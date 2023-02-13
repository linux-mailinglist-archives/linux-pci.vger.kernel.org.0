Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFBF694895
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 15:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBMOtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 09:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjBMOtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 09:49:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F813D70
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 06:49:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m2so13728551plg.4
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 06:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJcmar1XfdQfAuwhv/PsTLQlXNOUd4PyupZMvaHFGP8=;
        b=ApAmzMNC+RTfpQ9DxngSn2lEm3E3W+H2GAXYRLVXisVc2eojwW6xNivx61x00/ZuAx
         LQjxUNRkjjrujCkiHexqjcWHiFaDtFJ9hf2eJlzMd2R2P28Rfaau/V41TKJuVenFgrXt
         GY6iv6uUwos5hPPH6FOeuvxN7D0YdbMt0u33H3YiutoeH28viFCHo2MgnR95BWQZzr9H
         CiBPqlHjA9mreffQZGSsqOOoLt2ZkVCGMwSCcgRjri+L1gG8FZ45UpoHxO0TznZMDnMw
         uyMRK94QuvKPPbFe0/SXJ1N4MNbWZQTxJ6DMhg7jFxWyd0Q9eRosfl8GHYYb+TkJABSZ
         J2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJcmar1XfdQfAuwhv/PsTLQlXNOUd4PyupZMvaHFGP8=;
        b=mEdqrKhDY1H+NTwctsMW5QiCz9JJNORWIfozSQLhIQ9BZP6WkWIDVguogwsoj3oZoh
         /pDgU6xu4Tr7C2cdTCwjxqGX5rj2Zpa6EjZ5rpN88978oPVEbJB2DwY9znhNTOpFs7C2
         C/u+4Lr/KaME0C5tdD9atG73flWa6DElq+Agq5SPS6YdRZ9Oqu8HAj82CIfFgRalOjk4
         7LPQe9N9uCIWZr+pr2i2cy9NHypMz4JgyLiDhzEN+lFr9vxAt8rvtNtpy8IpnOYt5Hac
         lF3yT8jaR2HdFJyY4FzzfddNgzaMB+7kFLCtMURcfZGYIBtUxiyFgOxhYDP96YIqyBhh
         mTrQ==
X-Gm-Message-State: AO0yUKX9AlyDvktuDFmMu/O2R8EttRBARtbzfXlffXTALVeLO7C2mMft
        t6RUmnkofrd9codDp6NB1itT
X-Google-Smtp-Source: AK7set+NEty8peAxq0G+9uI9ZJAK6hGLczhnr6zzR86FFHTxH/MEL8gyrBHrHfcRvwdC/PXm5h0dkA==
X-Received: by 2002:a05:6a21:6210:b0:bf:c1c3:4179 with SMTP id wm16-20020a056a21621000b000bfc1c34179mr20132975pzb.22.1676299773722;
        Mon, 13 Feb 2023 06:49:33 -0800 (PST)
Received: from localhost.localdomain ([117.217.182.252])
        by smtp.gmail.com with ESMTPSA id o23-20020a63fb17000000b004fb1310c1c3sm7293567pgh.69.2023.02.13.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:49:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: pciehp: Add Qualcomm quirk for Command Completed erratum
Date:   Mon, 13 Feb 2023 20:19:22 +0530
Message-Id: <20230213144922.89982-1-manivannan.sadhasivam@linaro.org>
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

The Qualcomm PCI bridge device (Device ID 0x010e) found in chipsets such as
SC8280XP used in Lenovo Thinkpad X13s, does not set the Command Completed
bit unless writes to the Slot Command register change "Control" bits.

This results in timeouts like below during boot and resume from suspend:

    pcieport 0002:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
    ...
    pcieport 0002:00:00.0: pciehp: Timeout on hotplug command 0x13f1 (issued 107724 msec ago)

Add the device to the Command Completed quirk to mark commands "completed"
immediately unless they change the "Control" bits.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Bjorn, during the review of a similar patch adding the quirk for device id
0x0110, you asked me whether we should mark all Qcom bridge devices as
quirky like Intel bridges. I tried asking this question to Qualcomm but
found no answer yet. So I just went with adding one more entry.

 drivers/pci/hotplug/pciehp_hpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 10e9670eea0b..f8c70115b691 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1088,6 +1088,8 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x010e,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0110,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
-- 
2.25.1

