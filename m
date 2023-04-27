Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0726F0457
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjD0Koj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 06:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbjD0Koj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 06:44:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DD2103
        for <linux-pci@vger.kernel.org>; Thu, 27 Apr 2023 03:44:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso6494007b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Apr 2023 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682592277; x=1685184277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPjgq3zlWYQFj7c/g/9N/OxqaeG5Njw/y80poNIzu/A=;
        b=MXoqBeEes7wZrkLALkHP5t+W1nwEgOd2Hsq+KKGx3YGVx3bZZbzO+3lAUhe13VKgNu
         ZZobnrBUZH1XrJOgVhERqBCThWEyc5bx/rNJOXZMWIKoUUa+LbSS4sMNvaaH6GSMGBQY
         wgu9WgHdDiH+VL22wrhyazR7yNxzimoxcDyIv0L+JFcLZdRUbvy8N8ANCNDlnZVrvJon
         KDpKI9bPWiF6oJkJ+1fb2a8WXGPMJTAZIAL/mZyoEPb8d3wuyihrdnovBnk6C8QBbaTV
         AlgXZi1l9LJXwifEKUcs9KBgM0mzHDQ30TAAxt5h7Zbpq6YYgAOpLcyN4LFDrAw9ZVMD
         nQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592277; x=1685184277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPjgq3zlWYQFj7c/g/9N/OxqaeG5Njw/y80poNIzu/A=;
        b=a7dLl1UefnLClE2JdF8sK49bIups+BWreUM5uIezNrPuHsJkXzDsxYG6xiBhFUVFk5
         Ct+Ac3IdKNZk58OKTYPwl6rAS9kZprbF0KD7u0cqVA5FjMsPic+4UttoWHj1GBvlTZiI
         /X2jN8xVTtEPc8fkfBm2qerVYFGTXLH61FDdeunprLQpmJtsEI/YFzZ2wqhM2Ca0/HKY
         T1nxNY9XU8qqS0YuPx4D0JEpAcr7GH3hdhIe59S9Yo7DKpOff+dJGBYUy9h+n0jUBusb
         TFwyes51kXIRKts5YBz1qTx5yc0y0EjwZLgfeLv1CsaKgF1ID/lxHKa3KDPJw6CdgYqL
         /dSQ==
X-Gm-Message-State: AC+VfDwiwSLXJ/YS5oFd6hab4BJ1fSULhLQAiYneVkPs+GWilsRUQVh4
        hT/t93ffsm9Yy7kXCe83xthk/HjGoXsLbJIe6wBzGg==
X-Google-Smtp-Source: ACHHUZ6uU2L9eISIY6VmEOhsO9zwuUAYLUCc/j7JkEeY/3QW0LLDLHvBK0O2sX46EQbhgMALIkR9Cw==
X-Received: by 2002:a05:6a20:8402:b0:ef:ef0d:7dd9 with SMTP id c2-20020a056a20840200b000efef0d7dd9mr1174846pzd.51.1682592276646;
        Thu, 27 Apr 2023 03:44:36 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b0050f93a3586fsm11029042pgb.37.2023.04.27.03.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:44:36 -0700 (PDT)
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
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 0/3] Introduce a PCIe endpoint virtio console
Date:   Thu, 27 Apr 2023 19:44:25 +0900
Message-Id: <20230427104428.862643-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe endpoint framework provides APIs to implement PCIe endpoint function.
This framework allows defining various PCIe endpoint function behaviors in
software. This patch extend the framework for virtio pci device. The
virtio is defined to communicate guest on virtual machine and host side.
Advantage of the virtio is the efficiency of data transfer and the conciseness
of implementation device using software. It also be applied to PCIe
endpoint function.

We designed and implemented a PCIe EP virtio console function driver using
the extended PCIe endpoint framework for virtio. It can be communicate
host and endpoint over virtio as console.

An architecture of the function driver is following:

 ┌────────────┐         ┌──────────────────────┬────────────┐
 │virtio      │         │                      │virtio      │
 │console drv │         ├───────────────┐      │console drv │
 ├────────────┤         │(virtio console│      ├────────────┤
 │ virtio bus │         │ device)       │◄────►│ virtio bus │
 ├────────────┤         ├---------------┤      └────────────┤
 │            │         │ pci ep virtio │                   │
 │  pci bus   │         │  console drv  │                   │
 │            │  pcie   ├───────────────┤                   │
 │            │ ◄─────► │  pci ep Bus   │                   │
 └────────────┘         └───────────────┴───────────────────┘
   PCIe Root              PCIe Endpoint

Introduced driver is `pci ep virtio console drv` in the figure. It works
as ep function for PCIe root and virtual virtio console device for PCIe
endpoint. Each side of virtio console driver has virtqueue, and
introduced driver transfers data on the virtqueue to each other. A data
on root tx queue is transfered to endpoint rx queue and vice versa.

This patchset is depend follwing patches which are under discussion.

- [RFC PATCH 0/3] Deal with alignment restriction on EP side
link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@igel.co.jp/
- [PATCH v3] vringh: IOMEM support
link: https://lore.kernel.org/virtualization/CACGkMEumt4p7jU+H+T-b9My0buhdS8a-1GCSnWjnCwMAM=wo1Q@mail.gmail.com/T/#t

First of this patchset is introduce a helper function to realize pci
virtio function using PCIe endpoint framework. The second one is adding
a missing definition for virtio pci header. The last one is for PCIe
endpoint virtio console driver.

This is tested on next-20230416 and RCar S4 board as PCIe endpoint.

Shunsuke Mie (3):
  PCI: endpoint: introduce a helper to implement pci ep virtio function
  virtio_pci: add a definition of queue flag in ISR
  PCI: endpoint: Add EP function driver to provide virtio-console
    functionality

 drivers/pci/endpoint/functions/Kconfig        |  19 +
 drivers/pci/endpoint/functions/Makefile       |   2 +
 drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 ++++++++++++++++++
 .../pci/endpoint/functions/pci-epf-virtio.c   | 458 ++++++++++++++
 .../pci/endpoint/functions/pci-epf-virtio.h   | 126 ++++
 include/uapi/linux/virtio_pci.h               |   3 +
 6 files changed, 1204 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.h

-- 
2.25.1

