Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B31DE5B7
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgEVLmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 07:42:25 -0400
Received: from foss.arm.com ([217.140.110.172]:33846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgEVLmZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 07:42:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D49B55D;
        Fri, 22 May 2020 04:42:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C7673F305;
        Fri, 22 May 2020 04:42:22 -0700 (PDT)
Date:   Fri, 22 May 2020 12:42:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Align PCI Emul Bridge to PCIe 5.0
Message-ID: <20200522114220.GD11785@e121166-lin.cambridge.arm.com>
References: <20200511162117.6674-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511162117.6674-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 11, 2020 at 12:21:13PM -0400, Jon Derrick wrote:
> This set updates pci-bridge-emul for PCIe 4.0 and 5.0. It fixes a few
> bit conflicts and comments, and updates a few missing 4.0 and 5.0
> definitions. Additionally it eliminates the 'reserved' member by
> assuming that ro, rw, and w1c bits are valid and non-conflicting, and
> using the inversion of those fields.
> 
> v2 changes:
> Removed GENMASK/BIT conversion. Existing named fields are left as-is.
> Added Rob's acks for unchanged patches 1 & 2
> 
> v1: https://lore.kernel.org/linux-pci/20200414203005.5166-1-jonathan.derrick@intel.com/T/#t
> 
> Jon Derrick (4):
>   PCI: pci-bridge-emul: Fix PCIe bit conflicts
>   PCI: pci-bridge-emul: Fix Root Cap/Status comment
>   PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
>   PCI: pci-bridge-emul: Eliminate the 'reserved' member
> 
>  drivers/pci/pci-bridge-emul.c | 61 ++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 30 deletions(-)

Applied to pci/pci-bridge-emul, thanks !

Lorenzo
