Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51C76929AC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 22:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjBJV5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 16:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjBJV5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 16:57:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B947E024;
        Fri, 10 Feb 2023 13:57:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90DE261EAA;
        Fri, 10 Feb 2023 21:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80E7C433D2;
        Fri, 10 Feb 2023 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676066257;
        bh=sv6DygF5Kp2NuSObIl2kxR75XaKT//khl2CGKPjZ4g8=;
        h=Date:From:To:Cc:Subject:From;
        b=ldqV5946XHOlN3Nw7C2PC0Znj7xln9WNVyfar/V5HvhrvyXecNb2y2Tun/j3Ek6Fs
         BTZuwoDSf/ERKd+QvkJKoRI53qLAxSXb0SiK09YPIuNKOhO/CgOQXLyFxb4DWTNPAg
         DO0bbLi0sv88OWtsQDqrX+Azt/qMQUsC8AvJnpvmY45Mn+/DTyOf3JeP9DZu3R2ANt
         QViiBng9kkPStW3eb9sMfCks8Wi95c0SKhGNiNJ5TcRgO/GaM90snjc9eDcpRTUEtl
         v1aA2fESdgothuOh3/iprnCOMglEr/O5muQmucG6y5hOH4iBIi1EBbX5HhHkh280Ek
         IXHxJYxc3xQ4A==
Date:   Fri, 10 Feb 2023 15:57:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Witt <kernel@witt.link>,
        Vidya Sagar <vidyas@nvidia.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.2
Message-ID: <20230210215735.GA2700622@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Note that we're moving PCI development to a shared git tree, so this
pull request refers to the new tree.

The reverts fix suspend/resume issues that appeared in v6.1.  They've
been in linux-next since Feb 6, but I updated the commit logs today to
add more details.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.2-fixes-2

for you to fetch changes up to ff209ecc376a2ea8dd106a1f594427a5d94b7dd3:

  Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming" (2023-02-10 15:30:24 -0600)

----------------------------------------------------------------
- Move to a shared PCI git tree (Bjorn Helgaas)

- Add Krzysztof Wilczyński as another PCI maintainer (Lorenzo Pieralisi)

- Revert a couple ASPM patches to fix suspend/resume regressions (Bjorn
  Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (3):
      MAINTAINERS: Move to shared PCI tree
      Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"
      Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"

Lorenzo Pieralisi (1):
      MAINTAINERS: Promote Krzysztof to PCI controller maintainer

 MAINTAINERS             |  12 +++---
 drivers/pci/pci.c       |   7 ----
 drivers/pci/pci.h       |   4 --
 drivers/pci/pcie/aspm.c | 109 +++++++++++++++---------------------------------
 4 files changed, 39 insertions(+), 93 deletions(-)
