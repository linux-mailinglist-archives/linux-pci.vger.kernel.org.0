Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C56E6B3F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDRRnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjDRRnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA67A85;
        Tue, 18 Apr 2023 10:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B00B63773;
        Tue, 18 Apr 2023 17:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D385C433EF;
        Tue, 18 Apr 2023 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839827;
        bh=28MQFRdEYI6lunlC25xCoTHoC2cSiA703/aFrk6rYYM=;
        h=From:To:Cc:Subject:Date:From;
        b=C9v3ADxXmBoPJMqW75QV1c/8+6oYsN32DIUOjLqMMIQPJRfNlu4+5SxP0VY05o3ui
         qA7yb6z+U3ClhBumjIu2VIzOVMCBWNdUKaJRBXrVhD/x2i+wI4zBvC0A3pMlapVdrQ
         ImGxsO4EdYwp3UrciLpLa2BK5An4o8YvE0BLEoJARH1dXFquPU7pxrhu0oYcSRjjhg
         z1w0U2ZgT4YHYe4xkleIlhTh5eeqZ6kvaGeHrSTxYgJiFusX6kezYj8XxS/3MFGr6V
         DsxRBhR5+U92WVEIqqgNJoW66Kj7jHv3DD6W17kf+Kno6zTLwG2QyT1xdcvrWaxfVf
         fN8VWmHl3hghA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/7] PCI: Tidy controller Kconfig
Date:   Tue, 18 Apr 2023 12:43:29 -0500
Message-Id: <20230418174336.145585-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use vendor name in all native controller Kconfig entries.  Use consistent
prompt language.  Sort entries by vendor name so they appear in alpha order
in menuconfig.

Bjorn Helgaas (7):
  PCI: meson: Add 'Amlogic' to Kconfig prompt
  PCI: hv: Add 'Microsoft' to Kconfig prompt
  PCI: xilinx-nwl: Add 'Xilinx' to Kconfig prompt
  PCI: Use consistent controller Kconfig menu entry language
  PCI: Sort controller Kconfig entries by vendor
  PCI: dwc: Sort Kconfig entries by vendor
  PCI: mobiveil: Sort Kconfig entries by vendor

 drivers/pci/controller/Kconfig          | 463 ++++++++++-----------
 drivers/pci/controller/cadence/Kconfig  |  10 +-
 drivers/pci/controller/dwc/Kconfig      | 518 ++++++++++++------------
 drivers/pci/controller/mobiveil/Kconfig |  19 +-
 4 files changed, 506 insertions(+), 504 deletions(-)

-- 
2.25.1

