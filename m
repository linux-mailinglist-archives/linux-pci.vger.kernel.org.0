Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9316A502
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 12:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXLhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 06:37:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXLhU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 06:37:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15EF930E;
        Mon, 24 Feb 2020 03:37:20 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F006A3F703;
        Mon, 24 Feb 2020 03:37:18 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:37:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use pci_parse_request_of_pci_ranges()
Message-ID: <20200224113716.GB11120@e121166-lin.cambridge.arm.com>
References: <20191028225136.22289-1-robh@kernel.org>
 <20200221142051.GB15440@e121166-lin.cambridge.arm.com>
 <c7392952-929a-5be4-ab06-9cf04810290f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7392952-929a-5be4-ab06-9cf04810290f@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 22, 2020 at 11:06:18PM +0530, Vidya Sagar wrote:
> 
> 
> On 2/21/2020 7:50 PM, Lorenzo Pieralisi wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Oct 28, 2019 at 05:51:36PM -0500, Rob Herring wrote:
> > > Convert Tegra PCI host driver to use the common
> > > pci_parse_request_of_pci_ranges().
> > > 
> > > This allows removing the DT ranges parsing, PCI resource handling, and
> > > private storage of resources from the driver.
> > > 
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Andrew Murray <andrew.murray@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > > Cc: linux-tegra@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Here's one more conversion to use pci_parse_request_of_pci_ranges. It's
> > > dependent on my prior series, specifically this patch[1].
> > > 
> > > Compile tested only.
> > > 
> > > Rob
> > > 
> > > [1] https://patchwork.ozlabs.org/patch/1185555/
> > > 
> > >   drivers/pci/controller/pci-tegra.c | 187 +++++++----------------------
> > >   1 file changed, 46 insertions(+), 141 deletions(-)
> > 
> > Patch still applies, I need testing and ACK from Tegra maintainers
> > please.
> I tested this patch on Jetson-TX1 with NVMe drive connected to it.
> Verified basic enumeration and functionality of the drive.
> 
> Tested-by: Vidya Sagar <vidyas@nvidia.com>

Thanks a lot, I need Thierry's ACK to merge it, thanks.

Lorenzo
