Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825082FB883
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbhASM5U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:57:20 -0500
Received: from foss.arm.com ([217.140.110.172]:52144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbhASLbF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 06:31:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F01DE1042;
        Tue, 19 Jan 2021 03:30:05 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06263F719;
        Tue, 19 Jan 2021 03:30:03 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>,
        Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/17] Implement NTB Controller using multiple PCI EP
Date:   Tue, 19 Jan 2021 11:29:55 +0000
Message-Id: <161105563975.29969.4677344444174224884.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210104152909.22038-1-kishon@ti.com>
References: <20210104152909.22038-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 Jan 2021 20:58:52 +0530, Kishon Vijay Abraham I wrote:
> This series is about implementing SW defined Non-Transparent Bridge (NTB)
> using multiple endpoint (EP) instances. This series has been tested using
> 2 endpoint instances in J7 connected to J7 board on one end and DRA7 board
> on the other end. However there is nothing platform specific for the NTB
> functionality.
> 
> This was presented in Linux Plumbers Conference. Link to presentation
> and video can be found @ [1]
> Created a video demo @ [9]
> 
> [...]

Applied to pci/ntb to give it more visibility and testing, aiming
for v5.12.

[01/17] Documentation: PCI: Add specification for the *PCI NTB* function device
        https://git.kernel.org/lpieralisi/pci/c/75e6ac86ca
[02/17] PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit BAR
        https://git.kernel.org/lpieralisi/pci/c/b6c7a2a2b5
[03/17] PCI: endpoint: Add helper API to get the 'next' unreserved BAR
        https://git.kernel.org/lpieralisi/pci/c/43e293914d
[04/17] PCI: endpoint: Make *_free_bar() to return error codes on failure
        https://git.kernel.org/lpieralisi/pci/c/293e2c258c
[05/17] PCI: endpoint: Remove unused pci_epf_match_device()
        https://git.kernel.org/lpieralisi/pci/c/9a25bdab98
[06/17] PCI: endpoint: Add support to associate secondary EPC with EPF
        https://git.kernel.org/lpieralisi/pci/c/868fe90ea4
[07/17] PCI: endpoint: Add support in configfs to associate two EPCs with EPF
        https://git.kernel.org/lpieralisi/pci/c/632c92ec12
[08/17] PCI: endpoint: Add pci_epc_ops to map MSI irq
        https://git.kernel.org/lpieralisi/pci/c/310511a301
[09/17] PCI: endpoint: Add pci_epf_ops for epf drivers to expose function specific attrs
        https://git.kernel.org/lpieralisi/pci/c/34fb8ab2e3
[10/17] PCI: endpoint: Allow user to create sub-directory of 'EPF Device' directory
        https://git.kernel.org/lpieralisi/pci/c/3a5c112c7a
[11/17] PCI: cadence: Implement ->msi_map_irq() ops
        https://git.kernel.org/lpieralisi/pci/c/d5c3d2ae7c
[12/17] PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
        https://git.kernel.org/lpieralisi/pci/c/d3f4973104
[13/17] PCI: endpoint: Add EP function driver to provide NTB functionality
        https://git.kernel.org/lpieralisi/pci/c/7dc64244f9
[14/17] PCI: Add TI J721E device to pci ids
        https://git.kernel.org/lpieralisi/pci/c/17d49876c3
[15/17] NTB: Add support for EPF PCI-Express Non-Transparent Bridge
        https://git.kernel.org/lpieralisi/pci/c/5d0db3f429
[16/17] Documentation: PCI: Add configfs binding documentation for pci-ntb endpoint function
        https://git.kernel.org/lpieralisi/pci/c/099f07051e
[17/17] Documentation: PCI: Add userguide for PCI endpoint NTB function
        https://git.kernel.org/lpieralisi/pci/c/27f22f76c3

Thanks,
Lorenzo
