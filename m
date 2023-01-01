Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3165A979
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jan 2023 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjAAJWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Jan 2023 04:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAJWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Jan 2023 04:22:39 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480460CC;
        Sun,  1 Jan 2023 01:22:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VYTz22E_1672564953;
Received: from localhost(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VYTz22E_1672564953)
          by smtp.aliyun-inc.com;
          Sun, 01 Jan 2023 17:22:34 +0800
From:   Yang Su <yang.su@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        matthew@wil.cx, jbarnes@virtuousgeek.org, rjw@sisk.pl,
        greg@kroah.com, patchwork-bot@kernel.org, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Tune pci sbr time
Date:   Sun,  1 Jan 2023 17:22:32 +0800
Message-Id: <cover.1672563632.git.yang.su@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pci_reset_secondary_bus, the waiting time is so long for PCIe devies.
As reference PCIe spec, this patch can handle different cases for PCI/PCIe devices
in pci_reset_secondary_bus.

Yang Su (1):
  PCI: Tune secondary bus reset time for PCIe

 drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

-- 
2.19.1.6.gb485710b

