Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4906A7CD5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 09:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCBIgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Mar 2023 03:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCBIgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 03:36:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123629E33
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 00:36:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso2070560pjr.5
        for <linux-pci@vger.kernel.org>; Thu, 02 Mar 2023 00:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzrqYLYLaVpd0UyrhZ0yR0aqCz0cuXCviR24aa0kuPw=;
        b=D43eGydreZR1VKVNvxdCLXaLMjZQGQzTS38Jo088r8l4Eepbu5JxDDCNecIGPi38Su
         Je57YvFacOR6isjgT/KYGTV+qijaz6DVD9kcCtAbbfJORvRabkcBs28mgi/cbR9t24rr
         RIz8+acB3dX6x8c03CjeFen3gCE3t4dHY20BH+LY3KybsYfa4XJ0lVTsDDKt2oSOf1sG
         HSx5utpv50HwHOGOnPimcYmU1oo7gPSrkwHHvukr4cc34DxI3Umw+1bjFkSx7UKZJymE
         jDHZ23+4P0UHnUZEthOHPNPHWh7bBsi71sZSBsI7MOqVgGz3yKIZoTloQV0i6X8MoFSn
         BvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzrqYLYLaVpd0UyrhZ0yR0aqCz0cuXCviR24aa0kuPw=;
        b=jYDgPfTP59NH7Duzh7CW9dCR2I0xnhpHrHE47prWjivyzNu+AdLUOoQAKmGTrPgHU3
         fAOyiWGxvcnX3BFZ8BVoBlDYeDmPPFDMjAOWSxTjI99cf3WVqatN/xSdS4AAc3cPVwNU
         1omYWJz0CMvlARCj3tfichrvVdlCXwBNNN1K6QcAoojZZnVCvUjB5RhMGNCjyNqzu8sN
         QEP5I2Ue3wRuEX7vn31/EOpAyWuR9OS9PsLm2D+gyidfRw+5U04SzjXJ8SUxpa1PmpoQ
         QlAo0mFyoSeWVdLvmiVdkoz2epiecylSMxyUd89ksPseYDXERc9PLylInCHd8YAqPm3G
         yc1Q==
X-Gm-Message-State: AO0yUKUEBsScgHSFoLzNsenu3IMlp7ZISl0RWqUuuLoDY9MKagd+dk/P
        7BZLUPr8Wqn8MI3sE12f3eL2
X-Google-Smtp-Source: AK7set+xaajcB0h5+hW2z33NsHRILEH9Ei8CBCfMkADOQc25cHl8/XAnaxyjni8gx1mPCvkbvVuKuw==
X-Received: by 2002:a17:902:8603:b0:19e:711b:83c with SMTP id f3-20020a170902860300b0019e711b083cmr878146plo.39.1677746194689;
        Thu, 02 Mar 2023 00:36:34 -0800 (PST)
Received: from localhost.localdomain ([59.97.53.52])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b00198ef93d556sm9791912plo.147.2023.03.02.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 00:36:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/1] PCI: qcom: Add support for system suspend and resume
Date:   Thu,  2 Mar 2023 14:06:24 +0530
Message-Id: <20230302083625.188482-1-manivannan.sadhasivam@linaro.org>
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

So the proposal here is to just vote for minimal interconnect bandwidth and
not turn OFF the resources if there are active PCIe devices connected to
the controllers. This avoids the access violation issue during suspend and
also saves some power due to the lower interconnect bandwidth used.

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

Changes in v2:

* Used minimum icc vote to keep data path functional during suspend
* Collected Ack

Manivannan Sadhasivam (1):
  PCI: qcom: Add support for system suspend and resume

 drivers/pci/controller/dwc/pcie-qcom.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

-- 
2.25.1

