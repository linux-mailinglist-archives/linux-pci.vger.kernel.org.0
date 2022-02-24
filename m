Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857954C3649
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiBXT4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 14:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiBXT4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 14:56:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A625D6F2;
        Thu, 24 Feb 2022 11:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A8DFB82928;
        Thu, 24 Feb 2022 19:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE690C340F3;
        Thu, 24 Feb 2022 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645732573;
        bh=0HnlIL853B1xUMl8KCDADbVuNeDJ62TZ+d6tR2IxZ1k=;
        h=Date:From:To:Cc:Subject:From;
        b=GTT3ao6IIwNE2HdYz0tAok0Szt6NmyR+KTXpH7HnQtMKKtvq3M5Tc1Cqd4/em/k4X
         cuNcIhbXq74yuJi9bOCYESKc9Yyk5txomn+4pH6cEPL1H3e82XB43v9VXe0YTW19+H
         0mkd+o85pp8KL2IYVTltcSDFkCqrpWjla7I6Zfn/3XZwQ5Aw6i96rUNTSf52mIAN5b
         M+BupFcNj6F0nnoIUTgsIKSvVcoC5i+VyG22+I4ZovjIqWuNK7lxwtSp3wLgJS4cVT
         WdXiqVlzmY73PUQn6zF/yxy7v5h04KCkJOpHpdyxAO9zVo4c0qRiSLONeT4AOdkfM+
         YyX9sEzoNYosA==
Date:   Thu, 24 Feb 2022 13:56:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jan Palus <jpalus@fastmail.com>, Marcel Menzel <mail@mcl.gg>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] PCI fixes for v5.17
Message-ID: <20220224195611.GA289605@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-5

for you to fetch changes up to 3f1271b54edcc692da5a3663f2aa2a64781f9bc3:

  PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken (2022-02-23 12:33:32 -0600)

----------------------------------------------------------------
PCI fixes:

  - Fix a merge error that broke PCI device enumeration on mvebu platforms,
    including Turris Omnia (Armada 385) (Pali Rohár)

  - Avoid using ATS on all AMD Navi10 and Navi14 GPUs because some VBIOSes
    don't account for "harvested" (disabled) parts of the chip when
    initializing caches (Alex Deucher)

----------------------------------------------------------------
Alex Deucher (1):
      PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken

Pali Rohár (1):
      PCI: mvebu: Fix device enumeration regression

 drivers/pci/controller/pci-mvebu.c |  3 ++-
 drivers/pci/quirks.c               | 14 +++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)
