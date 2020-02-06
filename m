Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC98D1545BE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 15:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgBFOJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 09:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFOJQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 09:09:16 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AFCD2082E;
        Thu,  6 Feb 2020 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580998156;
        bh=deex20fvTNfi1JN0BvdneLFwSQ0ubFngkNiBUmz2bAY=;
        h=Date:From:To:Cc:Subject:From;
        b=BESN8LSSdF/3WrpATFFzi5HpbC60wvnr/FJydtZfdtTiholoSb7cszi4xjSLU5yE7
         JIqxOhPgLWuQIDkyis+murk0bSJgy1q4rOLvG6mTKYUeFbVtadvu8OTw75w95zerEH
         kvevY971eVtM0l0vjSqJnI0qGD6ZNTLQA+QRJUFw=
Date:   Thu, 6 Feb 2020 08:09:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] PCI fixes for v5.6
Message-ID: <20200206140915.GA124818@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Define to_pci_sysdata() always to fix build breakage when
    !CONFIG_PCI (Jason A. Donenfeld)

  - Use PF PASID for VFs to fix VF IOMMU bind failures (Kuppuswamy
    Sathyanarayanan)


The following changes since commit d4e9056daedca3891414fe3c91de3449a5dad0f2:

  initramfs: do not show compression mode choice if INITRAMFS_SOURCE is empty (2020-02-03 17:31:43 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.6-fixes-1

for you to fetch changes up to 2e34673be0bd6bb0c6c496a861cbc3f7431e7ce3:

  PCI/ATS: Use PF PASID for VFs (2020-02-05 11:58:08 -0600)

----------------------------------------------------------------
pci-v5.6-fixes-1

----------------------------------------------------------------
Jason A. Donenfeld (1):
      x86/PCI: Define to_pci_sysdata() even when !CONFIG_PCI

Kuppuswamy Sathyanarayanan (1):
      PCI/ATS: Use PF PASID for VFs

 arch/x86/include/asm/pci.h | 4 ++--
 drivers/pci/ats.c          | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)
