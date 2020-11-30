Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81D52C8CD4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgK3Sa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 13:30:59 -0500
Received: from foss.arm.com ([217.140.110.172]:59498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgK3Sa7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 13:30:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F93E30E;
        Mon, 30 Nov 2020 10:30:13 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.32.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12C9C3F66B;
        Mon, 30 Nov 2020 10:30:10 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: iproc: Add fixes to pcie iproc
Date:   Mon, 30 Nov 2020 18:30:04 +0000
Message-Id: <160676096573.23754.4959991308771072098.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201001060054.6616-1-srinath.mannam@broadcom.com>
References: <20201001060054.6616-1-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Oct 2020 11:30:51 +0530, Srinath Mannam wrote:
> This patch series contains fixes and improvements to pcie iproc driver.
> 
> This patch set is based on Linux-5.9.0-rc2.
> 
> Changes from v2:
>   - Addressed Bjorn's review comments
>      - Corrected subject line and commit message of Patches 1 and 2.
> 
> [...]

Applied to pci/iproc, thanks!

[1/3] PCI: iproc: Fix out-of-bound array accesses
      https://git.kernel.org/lpieralisi/pci/c/a3ff529f5d
[2/3] PCI: iproc: Invalidate correct PAXB inbound windows
      https://git.kernel.org/lpieralisi/pci/c/89bbcaac3d
[3/3] PCI: iproc: Enhance PCIe Link information display
      https://git.kernel.org/lpieralisi/pci/c/7698c0f155

Thanks,
Lorenzo
