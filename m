Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA76D4C7A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjDCPuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjDCPuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 11:50:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED94171D
        for <linux-pci@vger.kernel.org>; Mon,  3 Apr 2023 08:49:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d13so27645777pjh.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Apr 2023 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680536969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjdpEr1kbdCek7+Xx4AMcpWMybctv63LfhzPtH0NYpI=;
        b=Ffq+9Ao/yKeSVo9K+0CQxyz3aN64b8sLF8aki0lQyNqP3Rgvqt9paDWEKXq4gLoA8V
         fMVGj5THzkvpBXY4DRwYufLgtmUtpDtU9iIha2pb3Wo3TmV+eIQiCgMVs4AW1F1cDJcK
         D1pYHuFEnxhgSCTelEMYMQPBC3FGdEH1npol0woxbt/T9ry1dGMOb4/2h0zKbHTapFYE
         2t8lFHKv7CUA6SqYfFMBKHwaKx3r84BAHtskBADkGyPBt5XWaJZ5uZs0c7kPT4tLyW9Z
         5N6ezanrfYsWpNFrvPZjKFv8iGQWaZumMCnnChY7UNmbOkPqT6maiV5SMpldBD7U5gO0
         UMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjdpEr1kbdCek7+Xx4AMcpWMybctv63LfhzPtH0NYpI=;
        b=AGMhJNehkKMKR226+nhXkOvCM3xyFWzlXFwmfJG+HRXv9rmVSRkdceyXjADLz79p0w
         mHCQlPZtCNPInsJ4ZhjFDt6dXU1tZYDLwlTnqSTaCUN+gpcRK026xsTnB4jDjpG8qrDZ
         omtiCvteRx2PrHwr4HSirw+TXJ755r9eJ5RJ6GeVq2rbBYZRBkLq0OtFs44m5I8ioJi7
         rmImv1++an3XMSH4w0vXr/E+/JuyOVQ9pCfzHJ3Vwel32gJ0hdovXe9CzuxnsmZ93zSY
         aTHEQWiba1s9wUJPTtbLRoHueJAcOIHOGHmKwcixnzddLy+qFIRBfg9bDmUt/9iKK+6v
         tbxw==
X-Gm-Message-State: AAQBX9c7M+8L1v52qyxMTfRpf5fxBzpqnznPM0dZI916cvO4G4XSv0Ry
        SQL/q6xx1gCJnz242HOiPnAp
X-Google-Smtp-Source: AKy350bLVLkvH5+SJ7RuR133hSaDHPSe+UDoAzkm/zI1o2vRWweDiIcYX69H5D4GqOcdySwY0DDySQ==
X-Received: by 2002:a17:90b:1b48:b0:23d:2532:ae34 with SMTP id nv8-20020a17090b1b4800b0023d2532ae34mr18497287pjb.2.1680536968965;
        Mon, 03 Apr 2023 08:49:28 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.109])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0023af4eb597csm9621534pjc.52.2023.04.03.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:49:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/1] PCI: qcom: Add support for system suspend and resume
Date:   Mon,  3 Apr 2023 21:19:21 +0530
Message-Id: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series (a single patch) adds the system suspend and resume support
to the Qualcomm PCIe RC controller.

Background
==========

There were previous attempts [1][2] to add system suspend and resume
support to this driver.

In previous versions, the controller was put into low power mode by turning
OFF the resources even if there were active PCIe devices connected. Thanks
to Qualcomm's internal power topology, the link did not enter L2/L3 state
and the devices were still powered ON. But during very late end of suspend
cycle, kernel tried to disable MSIs of the PCIe devices. This caused access
violations as the resources needed to access the PCIe devices config space
were turned OFF. Series [1] worked around this issue by not accessing the
PCIe config space if the link was down in dw_msi_{un}mask_irq() functions.
But that approach was not accepted.

Then, series [2] implemented the suspend and resume operations using the
syscore framework that disabled the resources at the end of the suspend
cycle. But that approach also did not get much acceptance.

Proposal
========

So the proposal here is to just vote for minimal interconnect bandwidth to
keep the interconnect path active and not turn OFF the resources if there
are active PCIe devices connected to the controllers. This avoids the
access violation issue during suspend and also saves some power due to the
lower interconnect bandwidth used.

Then if there are no active PCIe devices connected to the controller,
the resources are turned OFF completely and brought back during resume.
This also saves power if there are controllers in a system without any
devices connected.

Testing
=======

This series has been tested on Lenovo Thinkpad X13s.

Thanks,
Mani

[1] https://lore.kernel.org/linux-pci/1656055682-18817-1-git-send-email-quic_krichai@quicinc.com/
[2] https://lore.kernel.org/linux-pci/1663669347-29308-1-git-send-email-quic_krichai@quicinc.com/

Changes in v4:

* Used 1KiB interconnect bandwidth during suspend

Changes in v3:

* Limited comments to 80 column
* Added error handling in resume_noirq()

Changes in v2:

* Used minimum icc vote to keep data path functional during suspend
* Collected Ack

Manivannan Sadhasivam (1):
  PCI: qcom: Add support for system suspend and resume

 drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

-- 
2.25.1

