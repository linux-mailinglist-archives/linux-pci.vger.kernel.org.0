Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD57625F6BA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgIGJkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 05:40:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgIGJkg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 05:40:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E6630E;
        Mon,  7 Sep 2020 02:40:36 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6583F66E;
        Mon,  7 Sep 2020 02:40:34 -0700 (PDT)
Date:   Mon, 7 Sep 2020 10:40:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: Re: [PATCH v2 0/5] PCIe aardvark controller improvements
Message-ID: <20200907094032.GD6428@e121166-lin.cambridge.arm.com>
References: <20200804115747.7078-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804115747.7078-1-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 01:57:42PM +0200, Pali Rohár wrote:
> Hi,
> 
> we have some more improvements for PCIe aardvark controller (Armada 3720
> SOC - EspressoBIN and Turris MOX).
> 
> The main improvement is that with these patches the driver can be compiled
> as a module, and can be reloaded at runtime.
> 
> This series applies on top of Linus' master branch.

Hi,

can you rebase it on top of v5.9-rc1 and resend, thanks.

Lorenzo

> Marek & Pali
> 
> 
> Changes in V2 for patch 4/5:
> * Protect pci_stop_root_bus() and pci_remove_root_bus() function calls by
>   pci_lock_rescan_remove() and pci_unlock_rescan_remove()
> 
> 
> Pali Rohár (5):
>   PCI: aardvark: Fix compilation on s390
>   PCI: aardvark: Check for errors from pci_bridge_emul_init() call
>   PCI: pci-bridge-emul: Export API functions
>   PCI: aardvark: Implement driver 'remove' function and allow to build
>     it as module
>   PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()
> 
>  drivers/pci/controller/Kconfig        |   2 +-
>  drivers/pci/controller/pci-aardvark.c | 104 ++++++++++++++++----------
>  drivers/pci/pci-bridge-emul.c         |   4 +
>  3 files changed, 71 insertions(+), 39 deletions(-)
> 
> -- 
> 2.20.1
> 
