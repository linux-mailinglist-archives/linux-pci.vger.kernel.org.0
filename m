Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DDE48447E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiADP0t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:26:49 -0500
Received: from foss.arm.com ([217.140.110.172]:60794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbiADP0t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jan 2022 10:26:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8956F13A1;
        Tue,  4 Jan 2022 07:26:48 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99EAA3F774;
        Tue,  4 Jan 2022 07:26:46 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Date:   Tue,  4 Jan 2022 15:26:40 +0000
Message-Id: <164130998680.26818.6364463233506760132.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
References: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Dec 2021 11:15:41 +0800, Kai-Heng Feng wrote:
> When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> combination causes AER message flood and drags the system performance
> down.
> 
> The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> is enabled regardless of _OSC:
> [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> ...
> [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Honor ACPI _OSC on PCIe features
      https://git.kernel.org/lpieralisi/pci/c/04b12ef163

Thanks,
Lorenzo
