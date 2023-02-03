Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADD6894B7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjBCKEl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 05:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjBCKEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 05:04:39 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8018E4AB
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 02:04:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so3261920pga.13
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 02:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0kv5a1Ouh4vMX7sPloZ+hR6D+hnPzE8im5HYlS+lZI=;
        b=jYZv7OSx2S7yMJbkHfCV77RF52CkgBJ1CZT1B7jlWWDi4vMEwhmbumM4yR1lV1WBGV
         uYrQFiTlQqJ/pIzlwUlpG8sr50USWBB2cMIYdZ9HVMZTafuYeX0GAAilnLHA0j3ogfnq
         N2VUnoMqPEvoch2LcQndc/FwyssrOA8jdIRnYdPn+gNQIJFNjr+ftaYhTDfWGTPhOC5y
         9SNi2GyM+Lbbx3/YJrTH8TIOzGPSmZPk0H6BbU4NNL8aVxeWJSuwyG9vFTuXXSJ/nf92
         7ny27vqPu6RgtyD8+2y/ZgfsY2RpPZuSRtz5d+0LcB5Dx64s23YawaFGV9o0TyoChRIt
         lVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0kv5a1Ouh4vMX7sPloZ+hR6D+hnPzE8im5HYlS+lZI=;
        b=Pq78q2xlVhE8aOExNdyBSKUVygud4YYqyLtJXPpPgNMhg8Hl6wFhB4c0KkbGSkA8Em
         ptS20PPjgO+6w6oXL4k7fMUADqQ2meV5U9MEe42PGfnLq/JAQyYv3DpM4n28yGWdPdHK
         +sdzwdb/Xou25NP1QaAkZxEUSU/m2TNuikQq/pEcbmmudGa14qWQJvyEQ8K/UuiCrf1T
         U/PwARJ5Ps9ZQPxgmzFQUncoIiyxCmv8oBB2rTQ3C3aaCASauLQbf/5A/9TyHBy31qkW
         +56dTsgOiVWLNB23aulET/UuoXFiaVQvffYi70X2ebgcu9nn1o4ypW7+fpaACkKkx0HB
         UfHw==
X-Gm-Message-State: AO0yUKU4DOM0ruYc8PaKhn9nacIAvsked55HNWkzME4ziouM3koPNAO5
        ObEpwakDb1LWXmgFQNnT5Fbj4w==
X-Google-Smtp-Source: AK7set+wQNrnsgsVt2bCm9zX7QS3qmNX8U8vzPZvi2YGH3d4er1Kf8Z6gVN47DMi4Mi1GdlkcoXugA==
X-Received: by 2002:aa7:96ac:0:b0:58d:9ad4:adaa with SMTP id g12-20020aa796ac000000b0058d9ad4adaamr9100553pfk.17.1675418667936;
        Fri, 03 Feb 2023 02:04:27 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:04:27 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
Date:   Fri,  3 Feb 2023 19:04:14 +0900
Message-Id: <20230203100418.2981144-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset introduce a virtio-net EP device function. It provides a
new option to communiate between PCIe host and endpoint over IP.
Advantage of this option is that the driver fully uses a PCIe embedded DMA.
It is used to transport data between virtio ring directly each other. It
can be expected to better throughput.

To realize the function, this patchset has few changes and introduces a
new APIs to PCI EP framework related to virtio. Furthermore, it device
depends on the some patchtes that is discussing. Those depended patchset
are following:
- [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
link: https://lore.kernel.org/dmaengine/20221223022608.550697-1-mie@igel.co.jp/
- [RFC PATCH 0/3] Deal with alignment restriction on EP side
link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@igel.co.jp/
- [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
link: https://lore.kernel.org/virtualization/20230202090934.549556-1-mie@igel.co.jp/

About this patchset has 4 patches. The first of two patch is little changes
to virtio. The third patch add APIs to easily access virtio data structure
on PCIe Host side memory. The last one introduce a virtio-net EP device
function. Details are in commit respectively.

Currently those network devices are testd using ping only. I'll add a
result of performance evaluation using iperf and etc to the future version
of this patchset.

Shunsuke Mie (4):
  virtio_pci: add a definition of queue flag in ISR
  virtio_ring: remove const from vring getter
  PCI: endpoint: Introduce virtio library for EP functions
  PCI: endpoint: function: Add EP function driver to provide virtio net
    device

 drivers/pci/endpoint/Kconfig                  |   7 +
 drivers/pci/endpoint/Makefile                 |   1 +
 drivers/pci/endpoint/functions/Kconfig        |  12 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
 .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
 drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
 drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
 drivers/virtio/virtio_ring.c                  |   2 +-
 include/linux/pci-epf-virtio.h                |  25 +
 include/linux/virtio.h                        |   2 +-
 include/uapi/linux/virtio_pci.h               |   2 +
 13 files changed, 1590 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
 create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
 create mode 100644 include/linux/pci-epf-virtio.h

-- 
2.25.1

