Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D543374E229
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 01:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGJXVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 19:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJXVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 19:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8D9E;
        Mon, 10 Jul 2023 16:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5456B61236;
        Mon, 10 Jul 2023 23:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F3C433C7;
        Mon, 10 Jul 2023 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689031302;
        bh=0ZZzAlML7PigSYIRwkyWGmOeNW5UQGLxmRIiOlnen3o=;
        h=From:To:Cc:Subject:Date:From;
        b=bIL6XKUt8RG31HcS15ahZRfdOQmvVbNkmtd2+Cx3ezDsVLDdgPBiJuF9+YEVlfea5
         VzI4BSqQaVNU+uatKjMcOXzW/rCiNI87ipZJw6EyWooMDB/lRO5BxFjDQuMjyT+UDd
         /KJM7qXX42KlIIUtjwU2w4bhaPtYL/gjsi4kFJII4jqalchP/2BA56dToHdqrY60Xx
         14XdoZ0+6mO5P1H+xDjUcirb5LWlMTsq5O10a9XIXPGr8SFsj/BE5PMvu7SNWHTWmr
         vs0igRzgiAjyG98DMzT7raGU+8qDsqcg+WuqDRDqYg5UX9j3mCJ0tyozp5xB4oz1Py
         S8RpdFcFwOZGA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/AER: Remove/unexport error reporting enable/disable
Date:   Mon, 10 Jul 2023 18:21:34 -0500
Message-Id: <20230710232136.233034-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
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

From: Bjorn Helgaas <bhelgaas@google.com>

pci_disable_pcie_error_reporting() is unused; remove it.
pci_enable_pcie_error_reporting() is used only inside aer.c; make it
static.

Bjorn Helgaas (2):
  PCI/AER: Drop unused pci_disable_pcie_error_reporting()
  PCI/AER: Unexport pci_enable_pcie_error_reporting()

 drivers/pci/pcie/aer.c | 15 +--------------
 include/linux/aer.h    | 11 -----------
 2 files changed, 1 insertion(+), 25 deletions(-)

-- 
2.34.1

