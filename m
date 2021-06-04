Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDB39C10D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFDUOX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 16:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDUOX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 16:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A03610E7;
        Fri,  4 Jun 2021 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622837557;
        bh=+E5f444FXO74SrVxpmgPjqsEm8CjgWiy4sXFqlkCNhg=;
        h=Date:From:To:Cc:Subject:From;
        b=SLIeKCUTKxgSj4zdtpHeLnhKjcCUJre5xNgQlyTICMvKctVO5QLPHCf46UFT6mrqh
         l37MDu4vUcw3VQu4S8GE5QQIOoi61QQ91vTd3rT4e4fpcmTUA2xXNifqhqjdY9A7hE
         Q4tj1Xn4sYBDzUpBjnG5EMPqECBxvQYIpotWbpxdxKlXNmAzs65n5bm7AN/AmBC/zq
         FadriSGMk+Ff5NvnCoSWWobQi1ljfavIJYCpXZJHyFsDTNeudEQ9iOIVuNA3Ezf8Tk
         vsRqcF7ounWGDwEuMpRGYPsIjNHjVxCL5MqoRTdAxtAco30vRvL7tl26Zzk3uclfuG
         0AXLmQCCyWVHg==
Date:   Fri, 4 Jun 2021 15:12:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: [GIT PULL] PCI fixes for v5.13
Message-ID: <20210604201235.GA2233426@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-fixes-1

for you to fetch changes up to 85aabbd7b315c65673084b6227bee92c00405239:

  PCI/MSI: Fix MSIs for generic hosts that use device-tree's "msi-map" (2021-05-25 18:37:37 -0500)

----------------------------------------------------------------
PCI fixes:

  - Fix MSIs for platforms with "msi-map" device-tree property, which we
    broke in v5.13-rc1 (Jean-Philippe Brucker)

  - Add Krzysztof Wilczyński as PCI reviewer (Lorenzo Pieralisi)

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      PCI/MSI: Fix MSIs for generic hosts that use device-tree's "msi-map"

Lorenzo Pieralisi (1):
      MAINTAINERS: Add Krzysztof as PCI host/endpoint controllers reviewer

 MAINTAINERS         | 2 ++
 drivers/pci/of.c    | 7 +++++++
 drivers/pci/probe.c | 3 ++-
 include/linux/pci.h | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)
