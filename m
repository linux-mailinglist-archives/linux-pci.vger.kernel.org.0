Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0469F3AEB93
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUOn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 10:43:27 -0400
Received: from foss.arm.com ([217.140.110.172]:35668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhFUOn1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 10:43:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE10CD6E;
        Mon, 21 Jun 2021 07:41:12 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C7883F694;
        Mon, 21 Jun 2021 07:41:11 -0700 (PDT)
Date:   Mon, 21 Jun 2021 15:41:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2 0/4] PCI: dwc: pci-dra7xx: miscellaneous improvements
Message-ID: <20210621144109.GC27516@lpieralisi>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531085934.2662457-1-luca@lucaceresoli.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 31, 2021 at 10:59:30AM +0200, Luca Ceresoli wrote:
> This is an series of mixed improvements to the DRA7 PCI controller driver:
> allow building as a loadabel module, allow to get and enable a clock and a
> small cleanup.
> 
> Luca
> 
> Luca Ceresoli (4):
>   PCI: dwc: Export more symbols to allow modular drivers
>   PCI: dra7xx: Make it a kernel module
>   PCI: dra7xx: Remove unused include
>   PCI: dra7xx: Get an optional clock
> 
>  drivers/pci/controller/dwc/Kconfig            |  6 ++---
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 22 +++++++++++++++++--
>  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
>  drivers/pci/controller/dwc/pcie-designware.c  |  1 +
>  4 files changed, 25 insertions(+), 5 deletions(-)

Hi Kishon,

I'd need your ACK to proceed with this series that looks like it
is ready to go, please let me know.

Thanks,
Lorenzo
