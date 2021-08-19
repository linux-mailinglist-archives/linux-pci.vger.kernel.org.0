Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8923F1BBA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhHSOjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 10:39:37 -0400
Received: from foss.arm.com ([217.140.110.172]:39848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240264AbhHSOjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 10:39:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B878113E;
        Thu, 19 Aug 2021 07:39:00 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.42.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A7D3F66F;
        Thu, 19 Aug 2021 07:38:57 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, nadeem@cadence.com,
        linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 0/5] PCI: Add support for J7200 and AM64
Date:   Thu, 19 Aug 2021 15:38:52 +0100
Message-Id: <162938392214.29875.12508742461574225755.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210811123336.31357-1-kishon@ti.com>
References: <20210811123336.31357-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Aug 2021 18:03:31 +0530, Kishon Vijay Abraham I wrote:
> This series adds the compatible specific to J7200 and AM64 and
> applies the erratas and configuration specific to them.
> 
> This series also includes Nadeem's patch that adds a quirk in
> Cadence driver which is used by J7200 [1].
> 
> The DT binding for both J7200 and AM64 is already merged.
> 
> [...]

Applied to pci/cadence, thanks!

[1/5] PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
      https://git.kernel.org/lpieralisi/pci/c/f4455748b2
[2/5] PCI: cadence: Add quirk flag to set minimum delay in LTSSM Detect.Quiet state
      https://git.kernel.org/lpieralisi/pci/c/09c24094b2
[3/5] PCI: j721e: Add PCIe support for J7200
      https://git.kernel.org/lpieralisi/pci/c/f1de58802f
[4/5] PCI: j721e: Add PCIe support for AM64
      https://git.kernel.org/lpieralisi/pci/c/c8a375a8e1
[5/5] misc: pci_endpoint_test: Add deviceID for AM64 and J7200
      https://git.kernel.org/lpieralisi/pci/c/7c52009d94

Thanks,
Lorenzo
