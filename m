Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE692C0275
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgKWJph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 04:45:37 -0500
Received: from foss.arm.com ([217.140.110.172]:38816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgKWJpg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 04:45:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BCE2101E;
        Mon, 23 Nov 2020 01:45:36 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.62.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC393F70D;
        Mon, 23 Nov 2020 01:45:34 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4] PCI: vmd: Offset Client VMD MSI-X vectors
Date:   Mon, 23 Nov 2020 09:45:27 +0000
Message-Id: <160612459746.16670.14903163148356907830.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201102222223.92978-1-jonathan.derrick@intel.com>
References: <20201102222223.92978-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2 Nov 2020 15:22:23 -0700, Jon Derrick wrote:
> Client VMD platforms have a software-triggered MSI-X vector 0 that will
> not forward hardware-remapped MSI from the sub-device domain. This
> causes an issue with VMD platforms that use AHCI behind VMD and have a
> single MSI-X vector remapped to VMD vector 0. Add a VMD MSI-X vector
> offset for these platforms.

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Offset Client VMD MSI-X vectors
      https://git.kernel.org/lpieralisi/pci/c/f6b7bb847c

Thanks,
Lorenzo
