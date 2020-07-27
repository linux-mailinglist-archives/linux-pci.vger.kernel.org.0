Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02322F392
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgG0POg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:14:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgG0POg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 11:14:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4956D6E;
        Mon, 27 Jul 2020 08:14:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3363F718;
        Mon, 27 Jul 2020 08:14:34 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:14:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Fix static checker warning
Message-ID: <20200727151426.GA17634@e121166-lin.cambridge.arm.com>
References: <20200727125932.8951-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727125932.8951-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 27, 2020 at 06:29:32PM +0530, Kishon Vijay Abraham I wrote:
> Fix the following static checker warning
> 
> drivers/pci/controller/cadence/pcie-cadence-host.c:322 cdns_pcie_host_map_dma_ranges()
> 	warn: ignoring unreachable code.
> 
> Fixes: 	82d8567259b1 ("PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Hi Lorenzo,
> 
> If possible can you squash this patch to "PCI: cadence: Use "dma-ranges" instead of
> "cdns,no-bar-match-nbits" property".

Done, thanks !

Lorenzo
