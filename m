Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08394955A0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 21:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347336AbiATUsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 15:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347106AbiATUsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 15:48:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A842C061574;
        Thu, 20 Jan 2022 12:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E8B61867;
        Thu, 20 Jan 2022 20:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B62C340E0;
        Thu, 20 Jan 2022 20:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642711699;
        bh=w4VcuI/3zhWQl6ui5BVYNLaRbVfgrW/jIa3EPwGsGew=;
        h=Date:From:To:Cc:Subject:From;
        b=RrYZEAwegilX/Cs6ioExmUZfcShhX2NrNRBY2sL8NAIPYklsEJrNwUI3Sqfft5uTn
         ca6if3JFve3hUDsKzwoYjyhyaU1sWSHYm3mP3H64vnZm8mswOlhHr4G9hbCH0DqpEY
         MvTeH5O8LUgBfkZeBbjNN3cWptyeHIFjd98sXYYsAt5cFMxhty2/j+CeZX6yMBpFlO
         E98WRCgY8ED+ljmB8pQKV2KluyeuQDln5slrdvyjuHktErnOWHa2A2dMyq9wJ5HDcH
         1DWIhpHczLVCQeM9l2bPaxewpFkO+Krzhnvk9g4gB3IB0ZH42sGAbFp8vDl44MPgC6
         9aQtoGOgc9M4Q==
Date:   Thu, 20 Jan 2022 14:48:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: [GIT PULL] PCI fixes for v5.17
Message-ID: <20220120204817.GA1065181@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-1

for you to fetch changes up to 9c494ca4d3a535f9ca11ad6af1813983c1c6cbdd:

  x86/gpu: Reserve stolen memory for first integrated Intel GPU (2022-01-18 14:19:06 -0600)

----------------------------------------------------------------
PCI fixes:

  - Reserve "stolen memory" for integrated Intel GPU, even if it's not
    the first GPU to be enumerated (Lucas De Marchi)

----------------------------------------------------------------
Lucas De Marchi (1):
      x86/gpu: Reserve stolen memory for first integrated Intel GPU

 arch/x86/kernel/early-quirks.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
