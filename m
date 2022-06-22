Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28255540AD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 04:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356150AbiFVC5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 22:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVC5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 22:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B033A32;
        Tue, 21 Jun 2022 19:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF7A618B6;
        Wed, 22 Jun 2022 02:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A98C3411C;
        Wed, 22 Jun 2022 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655866661;
        bh=TwJbfCG3QkeLFdFw+UVwMEwq05ji1f5xz9jFWDYKFQA=;
        h=From:To:Cc:Subject:Date:From;
        b=CA91kZBap+ZkQ0Gpl+9+zwlZ+8YT3/WYq99YQSHS3UWFBkwNFX0n5+gvF3Rkdgc6P
         15CBhyu5qSMAVyS/+2a6maudkVA9AykX3mvdYgEKqXYSWfhEDQYDSl5P0hQ19nC7pG
         Ugxnn6UsQUpzk24NO2kxnBAaOaD36GmR4KnCsg52AHL8mHMAHhhXyfCm0pdbDMZrS/
         m8kqUJXEQfNt4rX7SAXAkj/ylHIU4WOPimfnbrIAsNMSMlrK8OwWhW6MkuxuZ8iGaT
         eG9044r8s3YcfF+XiDqNgZ4kuK3mHWaVmEhyYeUAv0cCU1yP7pnujuGCg0RBkjsXul
         vKPBIV57YL88Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Liang He <windhl@126.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: rcar: Fix of_find_matching_node() reference leak
Date:   Tue, 21 Jun 2022 21:57:30 -0500
Message-Id: <20220622025732.1359389-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Alternate proposal for Liang's patch [1].

This is a bulkier fix, but removes the redundant
rcar_pcie_abort_handler_of_match[] table.

It also simplifies the unusual device_initcall()/builtin_platform_driver() 
construct, which seems unnecessary as far as I can tell.

Compile-tested only.

[1] https://lore.kernel.org/r/20220621070145.4080147-1-windhl@126.com

Bjorn Helgaas (2):
  PCI: rcar: Add dev struct for of_device_get_match_data()
  PCI: rcar: Resolve of_find_matching_node() reference leak

 drivers/pci/controller/pcie-rcar-host.c | 113 +++++++++++++-----------
 1 file changed, 60 insertions(+), 53 deletions(-)

-- 
2.25.1

