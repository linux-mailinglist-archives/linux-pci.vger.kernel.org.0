Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E118702644
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjEOHoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjEOHn4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D8EFC
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC8062053
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 07:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C527C433D2;
        Mon, 15 May 2023 07:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684136630;
        bh=XbVx6N8CrY3NIkLMzVeIBQrsWJj75ARIP4pmRo43+kw=;
        h=From:To:Subject:Date:From;
        b=Q10VLbBJo2rH3EPMH3v2xLzQqq+GA0FkRbBwKmFRc8429VDiOtA/fiBZayo9FkxW6
         DS7PHEqpc9m1UzGkzJT2AeLBL/jufFihFrvLI0oYxP9Hwxzmgcv9U8I2zuK5/WZQVS
         85RwMMNGwHVsWfWkxWcYkvsYJtgOnF373iTOfZcJZvWUuqHGyFJLugM6SSWT1y2M+s
         NgmiFZg+IRfB52fotOjMGpxSPErYW0Zk4N3eGU4n3ZXqhZK+AcEc0fy6WoOYk5avCU
         qP0m2cAFfSDOULLtgQIMfTG+NaLsYgEW4e02YH2chieiqLSS0DF2iBEkT2uIt67iH/
         tKI9xoQMhiC7g==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Fixup changes to pci_epf_type_add_cfs()
Date:   Mon, 15 May 2023 16:43:46 +0900
Message-Id: <20230515074348.595704-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A couple of patches to improve and document the changes to
pci_epf_type_add_cfs() done with patch
893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").

Changes from v1:
 - Changed error from EINVAL to ENODEV in patch 1
 - Removed spurious line in kdoc comment in patch 2

Damien Le Moal (2):
  PCI: endpoint: Improve pci_epf_type_add_cfs()
  PCI: endpoint: Add kdoc description of pci_epf_type_add_cfs()

 drivers/pci/endpoint/pci-ep-cfs.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.40.1

