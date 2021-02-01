Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47D30B287
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBAWFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 17:05:10 -0500
Received: from foss.arm.com ([217.140.110.172]:40040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhBAWEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 17:04:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B55D1042;
        Mon,  1 Feb 2021 14:03:19 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.46.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430183F718;
        Mon,  1 Feb 2021 14:03:16 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Rob Herring <robh@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 00/17] Implement NTB Controller using multiple PCI EP
Date:   Mon,  1 Feb 2021 22:03:09 +0000
Message-Id: <161221695543.9151.8142592721154575298.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210201195809.7342-1-kishon@ti.com>
References: <20210201195809.7342-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Feb 2021 01:27:52 +0530, Kishon Vijay Abraham I wrote:
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

Applied to pci/ntb, thanks!

[01/17] Documentation: PCI: Add specification for the *PCI NTB* function device
        https://git.kernel.org/lpieralisi/pci/c/051a6adf6e
[02/17] PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit BAR
        https://git.kernel.org/lpieralisi/pci/c/c0527dabcc
[03/17] PCI: endpoint: Add helper API to get the 'next' unreserved BAR
        https://git.kernel.org/lpieralisi/pci/c/d91d6ddfd2
[04/17] PCI: endpoint: Make *_free_bar() to return error codes on failure
        https://git.kernel.org/lpieralisi/pci/c/b9bdfa3da3
[05/17] PCI: endpoint: Remove unused pci_epf_match_device()
        https://git.kernel.org/lpieralisi/pci/c/2872f07cb0
[06/17] PCI: endpoint: Add support to associate secondary EPC with EPF
        https://git.kernel.org/lpieralisi/pci/c/6d0b4a7f2c
[07/17] PCI: endpoint: Add support in configfs to associate two EPCs with EPF
        https://git.kernel.org/lpieralisi/pci/c/c8e7d97270
[08/17] PCI: endpoint: Add pci_epc_ops to map MSI irq
        https://git.kernel.org/lpieralisi/pci/c/2bbb192338
[09/17] PCI: endpoint: Add pci_epf_ops for epf drivers to expose function specific attrs
        https://git.kernel.org/lpieralisi/pci/c/cea2edf604
[10/17] PCI: endpoint: Allow user to create sub-directory of 'EPF Device' directory
        https://git.kernel.org/lpieralisi/pci/c/1b0ef1c913
[11/17] PCI: cadence: Implement ->msi_map_irq() ops
        https://git.kernel.org/lpieralisi/pci/c/743a5d6309
[12/17] PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
        https://git.kernel.org/lpieralisi/pci/c/54e9e441b0
[13/17] PCI: endpoint: Add EP function driver to provide NTB functionality
        https://git.kernel.org/lpieralisi/pci/c/e9d7f4603e
[14/17] PCI: Add TI J721E device to pci ids
        https://git.kernel.org/lpieralisi/pci/c/7aac69682e
[15/17] NTB: Add support for EPF PCI-Express Non-Transparent Bridge
        https://git.kernel.org/lpieralisi/pci/c/363baf7d60
[16/17] Documentation: PCI: Add configfs binding documentation for pci-ntb endpoint function
        https://git.kernel.org/lpieralisi/pci/c/0456a9cd0a
[17/17] Documentation: PCI: Add userguide for PCI endpoint NTB function
        https://git.kernel.org/lpieralisi/pci/c/096ce75bf6

Thanks,
Lorenzo
