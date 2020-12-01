Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627A82CA72C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391827AbgLAPfH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 10:35:07 -0500
Received: from foss.arm.com ([217.140.110.172]:44998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391825AbgLAPfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 10:35:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A7430E;
        Tue,  1 Dec 2020 07:34:20 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.32.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46CB63F575;
        Tue,  1 Dec 2020 07:34:12 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ray Jui <rjui@broadcom.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rpi-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-rockchip@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Branden <sbranden@broadcom.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Mackerras <paulus@samba.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rrichter@marvell.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express drivers
Date:   Tue,  1 Dec 2020 15:34:00 +0000
Message-Id: <160683676668.20365.13565676178464743008.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201129230743.3006978-1-kw@linux.com>
References: <20201129230743.3006978-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 29 Nov 2020 23:07:38 +0000, Krzysztof Wilczyński wrote:
> Unify ECAM-related constants into a single set of standard constants
> defining memory address shift values for the byte-level address that can
> be used when accessing the PCI Express Configuration Space, and then
> move native PCI Express controller drivers to use newly introduced
> definitions retiring any driver-specific ones.
> 
> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> PCI Express specification (see PCI Express Base Specification, Revision
> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> implement it the same way.
> 
> [...]

Applied to pci/ecam, thanks!

[1/5] PCI: Unify ECAM constants in native PCI Express drivers
      https://git.kernel.org/lpieralisi/pci/c/f3c07cf692
[2/5] PCI: thunder-pem: Add constant for custom ".bus_shift" initialiser
      https://git.kernel.org/lpieralisi/pci/c/3c38579263
[3/5] PCI: iproc: Convert to use the new ECAM constants
      https://git.kernel.org/lpieralisi/pci/c/333ec9d3cc
[4/5] PCI: vmd: Update type of the __iomem pointers
      https://git.kernel.org/lpieralisi/pci/c/89094c12ea
[5/5] PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c
      https://git.kernel.org/lpieralisi/pci/c/3dc62532a5

Thanks,
Lorenzo
