Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D286E52BC5B
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiERNTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiERNTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 09:19:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4F81157E1
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 06:19:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c22so2136163pgu.2
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKZB/6RoNEosL1ZhhmdbCbJfaDZXTaYhcWk4wRoTqMQ=;
        b=TiZdooj/E3kGV+m+IxCHD//i1RFktljM4yI8thLxPLyttdCBD2pBRVy7gdWTxNfkdY
         MIjn5bmaUDce3ZkI4A8aN4Pdl+3MRqua4jF5FHfFXsiofGpZwDYiLJyNSNsdqMKrLAVm
         /qYtqby/etpEIQQub4ftdleYWh+d3048sBGe63NY9+ficUbuADiprl137BLlintNcq2v
         A802YuD/nvdQCEodGIgt2Lxdd6aAO90Penhum1XMmJXCCci0/hwAK1evFeqpxOh1mky1
         3We60ppHBCx+SUjtjg30CX6iBDLw3IwowCK+TuqDKyOR9GjLaPqG8eIZHAjHkbVmW5D/
         PhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKZB/6RoNEosL1ZhhmdbCbJfaDZXTaYhcWk4wRoTqMQ=;
        b=QSrlDDkhmBi6OqcAwp6kp2K3tDavtn7wylVFI5kw6otkwccMqCDYhYRXg78fJNecAB
         5tcD9rX9nzd/QfWXVwJekZ+owCK8tVUlR7JCDvllSyOumVy2v1Xm2BeDfeX7pUEwc9Gh
         p7Pt3fRy5PTctxDHtfGypiln60Bdmb32+f2r+kvMQG4UIwfDQ2qEFPdb3B12AA+8Mtxk
         XOhv6n3pZ+IhICbSfW0dcE1yx6FQF5xzRi5Zx1Fd/Qz81n+2yQQcNX3WJxU3+1Wyhpte
         2vEd5iMCPoyNh+k9u/OsHF11Z5L9uy0UxbTOdoHSGekfMv79j5eZHqd+dImeHR0H251H
         unvg==
X-Gm-Message-State: AOAM533e39E3WR/b+d7zBZBk+Dv4QoPScEueyHwHFZo6Y47MMAMUTZkK
        poAfEWPwneUL1JFPboEDVhaP
X-Google-Smtp-Source: ABdhPJzzQNNyHE5cV8P7ycPwOWKLxudFG57eELbtV3RDyDz7x8L67cxSujGCQ0pczbQTtKmXHHLCpg==
X-Received: by 2002:a05:6a00:f8b:b0:518:137a:112c with SMTP id ct11-20020a056a000f8b00b00518137a112cmr5629794pfb.8.1652879971672;
        Wed, 18 May 2022 06:19:31 -0700 (PDT)
Received: from localhost.localdomain ([117.217.181.192])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b0015e8d4eb27esm1663908plh.200.2022.05.18.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 06:19:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] PCI: Notify PCI drivers about powerdown during suspend
Date:   Wed, 18 May 2022 18:49:10 +0530
Message-Id: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

On Qcom SC7280 based Chrome platforms, the RPMh will turn off the power to all
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

In this series, the system suspend/resume support is also added to the Qcom
PCIe RC driver for SC7280. During the suspend time, the RC driver will put the
device into D3cold and recover it during resume. So even though RPMh is cutting
off the power to PCIe domain, it is necessary to put the device in D3cold by
the PCIe RC driver for proper working.

Testing
-------

This series has been tested on SC7280 IDP board connected to a NVMe PCI device.

Thanks,
Mani

Manivannan Sadhasivam (2):
  PCI: Add a flag to notify PCI drivers about powerdown during suspend
  nvme-pci: Make use of "suspend_poweroff" flag during system suspend

Prasad Malisetty (1):
  PCI: qcom: Add system PM support

 drivers/nvme/host/pci.c                |   3 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 108 +++++++++++++++++++++++++
 include/linux/pci.h                    |   2 +
 3 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.25.1

