Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25C560D5A1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiJYUjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 16:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiJYUjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 16:39:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8412AC4B9;
        Tue, 25 Oct 2022 13:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 532D6CE1C10;
        Tue, 25 Oct 2022 20:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1190BC433C1;
        Tue, 25 Oct 2022 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666730339;
        bh=pNxIekC28wfpOc5Ypgdt8TBFN8v88QrFVDS9wqoB4fk=;
        h=From:To:Cc:Subject:Date:From;
        b=RqSfv94sp39rY9R6dfnKNtA2yzyyL+taF+AKAbt1StMoVeHrtOmoZ8ZmMBXJ3krGy
         M280K4bsUBIoOIHOGnsOcYDpHG4zzHCwDB2UlH1lj9XqKQQ/c59IeIWCxRi/So+So1
         9YdUIZBVduYEZ2X9LjSbAmi+lV5q17+kcrwyC8SYNJdPS5iw4NwroUyds1T3C6z0Cj
         8dGKvrKF3RoP70esMxj9xNR3mEfVfRJFsKoSZ2eei4mESQfW7/WTW8UllreUfuXm2l
         n3F06FCCOIHuqCd4/nW8IrlGIyY/pdfabLlj4WNAyoXrpyK0r8S/p+trjChtqiu1fm
         Dar8mob5nL9SA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@redhat.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/8] agp: Convert to generic power management
Date:   Tue, 25 Oct 2022 15:38:44 -0500
Message-Id: <20221025203852.681822-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Vaibhav converted several AGP drivers from legacy PCI power management to
generic power management [1].  This series converts the rest of them.

v1 posted at [2].

Changes from v1 to v2:
  - Convert from SIMPLE_DEV_PM_OPS() (which is deprecated) to
    DEFINE_SIMPLE_DEV_PM_OPS() and remove __maybe_unused annotations.

[1] https://lore.kernel.org/all/20210112080924.1038907-1-vaibhavgupta40@gmail.com/#t
[2] https://lore.kernel.org/all/20220607034340.307318-1-helgaas@kernel.org/

Bjorn Helgaas (8):
  agp/efficeon: Convert to generic power management
  agp/intel: Convert to generic power management
  agp/amd-k7: Convert to generic power management
  agp/ati: Convert to generic power management
  agp/nvidia: Convert to generic power management
  agp/amd64: Update to DEFINE_SIMPLE_DEV_PM_OPS()
  agp/sis: Update to DEFINE_SIMPLE_DEV_PM_OPS()
  agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()

 drivers/char/agp/amd-k7-agp.c   | 24 ++++--------------------
 drivers/char/agp/amd64-agp.c    |  6 ++----
 drivers/char/agp/ati-agp.c      | 22 ++++------------------
 drivers/char/agp/efficeon-agp.c | 16 ++++------------
 drivers/char/agp/intel-agp.c    | 11 +++++------
 drivers/char/agp/nvidia-agp.c   | 24 ++++--------------------
 drivers/char/agp/sis-agp.c      |  7 ++-----
 drivers/char/agp/via-agp.c      |  6 ++----
 8 files changed, 27 insertions(+), 89 deletions(-)

-- 
2.25.1

