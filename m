Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94910605171
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 22:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJSUlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 16:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJSUlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 16:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B2424970;
        Wed, 19 Oct 2022 13:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 238A2619D2;
        Wed, 19 Oct 2022 20:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579A7C433C1;
        Wed, 19 Oct 2022 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666212094;
        bh=Bf+ussmrPLKODLInTtQn2XGEe9MvhvHx0iPkoYcSZr4=;
        h=From:To:Cc:Subject:Date:From;
        b=YkXjB6+mH96kG8UoVtrE4Yq+vDgm3JDelDTPhL+omA7Oy60pnl69MXVE8LcmEcF4L
         nvfNsgwzaVmL+Na3ttb+fOmX2dt0+2Q6vD8V8CTVpVctDz1nYICq8B79L9bLlTvHz+
         j6n2MMFmsoO6sYDVIZZsAfDcUvecXVUOawNgVy7bR0ln08UqxbNyPUtDeEWYi85xI/
         UtnHLOmVvKKPKD5NKzu9ccdJvFVN2bD1tgEd7eh9yEqmKF4kv/+53ByygNz3RQOrfL
         /p/8kO7cAGVProPhBCj75UNc51DK8fuSVXNnzxv+Ykt250aT9bsn9il531ZkP2s8f3
         L8ppJ2BPxc0zA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/portdrv: Squash into portdrv.c
Date:   Wed, 19 Oct 2022 15:41:24 -0500
Message-Id: <20221019204127.44463-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The PCIe portdrv is split across portdrv_core.c and portdrv_pci.c, but
neither is very big and it's a hassle to figure out which to look at.

Squash them into a single portdrv.c file.  Make functions static and
non-exported when possible, and move some private things out of portdrv.h.

Please comment.

Bjorn Helgaas (3):
  PCI/portdrv: Squash into portdrv.c
  PCI/portdrv: Move private things to portdrv.c
  PCI/portdrv: Unexport pcie_port_service_register(),
    pcie_port_service_unregister()

 drivers/pci/pcie/Makefile                     |   2 +-
 .../pci/pcie/{portdrv_core.c => portdrv.c}    | 263 +++++++++++++++++-
 drivers/pci/pcie/portdrv.h                    |  19 --
 drivers/pci/pcie/portdrv_pci.c                | 252 -----------------
 4 files changed, 253 insertions(+), 283 deletions(-)
 rename drivers/pci/pcie/{portdrv_core.c => portdrv.c} (69%)
 delete mode 100644 drivers/pci/pcie/portdrv_pci.c

-- 
2.25.1

