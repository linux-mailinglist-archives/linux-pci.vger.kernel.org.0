Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EFA597116
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiHQOad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 10:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiHQOaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 10:30:18 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024685AA3;
        Wed, 17 Aug 2022 07:30:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VMVqJud_1660746611;
Received: from localhost(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VMVqJud_1660746611)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 22:30:12 +0800
From:   Yang Su <yang.su@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] PCI: Use pci_bridge_wait_for_secondary_bus after SBR instead of ssleep(1)
Date:   Wed, 17 Aug 2022 22:30:10 +0800
Message-Id: <cover.1660746147.git.yang.su@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pci_reset_secondary_bus(), ssleep(1) is too long for PCIe.
So use pci_bridge_wait_for_secondary_bus after SBR.

Yang Su (1):
  PCI: Use pci_bridge_wait_for_secondary_bus after SBR instead of
    ssleep(1)

 drivers/pci/pci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
2.19.1.6.gb485710b

