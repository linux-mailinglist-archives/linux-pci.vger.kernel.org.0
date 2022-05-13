Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D929552607A
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377643AbiEMLAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357605AbiEMLAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 07:00:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0CE15A01
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 04:00:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i1so7590585plg.7
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNdOq8t7JPWMUm+zuKo42J05VFvuGcXIEWGUnieUQq8=;
        b=Aby8aznXD9r0cpduz4gPRNbEOwt3jnfmn1L1cpN5i+xaJnDLAKGpkNeSk/S+x0nHvA
         DtDAoalZtiCQUrNS6T/clwmhq1EARzkAX5hrLUaf4H6Js4uPhGkCNkdVWiHG4SEil1Ij
         SKB3qCz/woLhiCRxQ6q0NY9Ka6SiCGvPkqGXUvbJn4jSInXfNspfJ+wBICwF4igTAZFx
         uZ9pcc2cSPVuoo2jFRQrvseyy83Y3wrD/0YXISPrOM1gHtgosGY1e+v4sWLVfg5sdolw
         O7Jv2cao2Q4qvkCUoKOtLJxtr9bpqedg6fOwuzilqlRMi8t3Meg/lPFVODGOzUQ+E2R+
         vMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNdOq8t7JPWMUm+zuKo42J05VFvuGcXIEWGUnieUQq8=;
        b=De1IkUksvFBMKPRfnvB3SFoAHc/Ywn8kQtcMEUjCcPG/UfM370DuMca08rXYPaenNa
         drwQ1BFkbwKVZdEkM81YFg9JOe1wVb1galkmICLxwo6VeS+4SHHWixZGKRXEPgRwhTaz
         7VXJJ5uSVC+3Phze3iaNaDgTWvUSksZl6a1muLbBOt6zoVO4zzDPFZyU7p9EOQ+LikPv
         q9TLFJBWe/B34TfWj5jYhOn6tUY8CeIpnKIFWN4zf2KP8yprDiVrgOrDDDNeP009NMWM
         jinIzxXCQXvTN7y5OW+vTusxZZaYBdYINdBpttWYw0lV7aisD8NU49OWEzPFyyCwtcXL
         MI0Q==
X-Gm-Message-State: AOAM532tyH2OkElXj9GPsxZtzv/Zu5raRtyTFbu6ciwOivdIs81GMNR/
        VjgzXk6jyIVIPlzAjObJ7KFi
X-Google-Smtp-Source: ABdhPJx/lj+9GtKbU69bsELbuMcfzZNECYpmx52MJZ5Pm+xKR/MzE5L/DF1hY44DChJqj90mR3eIwA==
X-Received: by 2002:a17:903:11c7:b0:151:7290:ccc with SMTP id q7-20020a17090311c700b0015172900cccmr4386684plh.95.1652439648056;
        Fri, 13 May 2022 04:00:48 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 04:00:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] PCI: Notify PCI drivers about powerdown during suspend
Date:   Fri, 13 May 2022 16:30:24 +0530
Message-Id: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series adds support for notifying the PCI drivers like NVMe about the
transition of PCI devices into powerdown mode during system suspend.

Background
----------

On Qcom SC7280 based Chrome platforms, the OS will turn off the power to all
PCIe devices during system suspend for aggressive powersaving. Currently, there
is no way for the PCI device drivers to learn about this situation. Some of the
drivers assume that the power will be retained and some others assume that the
power may be taken down.

We faced the issue with NVMe PCI driver, where the driver expects the NVMe
device to be in APST (Autonomous Power State Transition) state for power saving
during system suspend. So when the power goes down, the NVMe driver fails to
bringup the device during resume.

Previous work
-------------

We tried to fix this issue in a couple of ways:

1. The NVMe PCI driver checks for the existence of "StorageD3Enable" ACPI
property in the suspend path. If the property is found, the driver assumes that
the device may go to poweroff state and shutdowns the device accordingly.

As like the ACPI based systems, we also tried to get the support in place for
DT based systems. But that didn't get accepted:
https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/

2. Keith Busch proposed a module params based approach. The parameter when set,
will allow the driver to support APST during suspend. Absence of that parameter
will let the driver shutdown the device.

This also did not get accepted:
https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/

Proposal
--------

Christoph suggested to add a notification in the PCI/PM core to let the NVMe
driver know that the device will go into powerdown state during suspend.
https://lore.kernel.org/all/Yg0wklcJ3ed76Jbk@infradead.org/ 

Hence in this series, a "suspend_poweroff" flag is introduced in the host bridge
struct. When this flag is set by the PCI RC drivers, the PCI device driver like
NVMe can shutdown the device during suspend.

In the coming days, the usage of this flag could be extended to other PCI
drivers as well.

Testing
-------

This series has been tested on SC7280 IDP board connected to a NVMe PCI device.

Thanks,
Mani

Manivannan Sadhasivam (3):
  PCI: Add a flag to notify PCI drivers about powerdown during suspend
  PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
  nvme-pci: Make use of "suspend_poweroff" flag during system suspend

 drivers/nvme/host/pci.c                | 3 ++-
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 include/linux/pci.h                    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1

