Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B81B6224
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgDWRj5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 13:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbgDWRj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 13:39:57 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E87020736;
        Thu, 23 Apr 2020 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587663597;
        bh=t+8gzm7oQkFYPTBkc7SLcyDzCH3gxXb6wsyucu95k4I=;
        h=Date:From:To:Cc:Subject:From;
        b=UT4uRdUw+vb89bWol3RjgRLWDHVCC8QC8lWaNIEdDGqkiVdGNBuH68r2N+oAooq5F
         KO+GTpqQw66OrcpSWBoiyWN+Cfjqv4fEUemL9EyJHqw/guLuCu+UTTeELVn6QpCBNH
         co959Nk3vtcCFSulJjIQY5xiXbCRIZGmmJlWlMnQ=
Date:   Thu, 23 Apr 2020 12:39:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [GIT PULL] PCI fixes for v5.7
Message-ID: <20200423173955.GA193359@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Workaround Apex TPU class code issue that prevents resource
    assignment (Bjorn Helgaas)

  - Update MAINTAINERS to add Rob Herring for native PCI controller
    drivers (Lorenzo Pieralisi)


The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.7-fixes-1

for you to fetch changes up to ef46738cc47adb6f70d548c03bd44508f18e14a5:

  MAINTAINERS: Add Rob Herring and remove Andy Murray as PCI reviewers (2020-04-22 10:53:37 -0500)

----------------------------------------------------------------
pci-v5.7-fixes-1

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI: Move Apex Edge TPU class quirk to fix BAR assignment

Lorenzo Pieralisi (1):
      MAINTAINERS: Add Rob Herring and remove Andy Murray as PCI reviewers

 MAINTAINERS                          | 2 +-
 drivers/pci/quirks.c                 | 7 +++++++
 drivers/staging/gasket/apex_driver.c | 7 -------
 3 files changed, 8 insertions(+), 8 deletions(-)
