Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8413A338
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 09:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANItU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 03:49:20 -0500
Received: from verein.lst.de ([213.95.11.211]:44853 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANItU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 03:49:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F22E068B20; Tue, 14 Jan 2020 09:49:16 +0100 (CET)
Date:   Tue, 14 Jan 2020 09:49:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 1/5] x86/pci: Add a to_pci_sysdata helper
Message-ID: <20200114084916.GA32024@lst.de>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com> <1578676873-6206-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578676873-6206-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 10, 2020 at 10:21:09AM -0700, Jon Derrick wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Various helpers need the pci_sysdata just to dereference a single field
> in it.  Add a little helper that returns the properly typed sysdata
> pointer to require a little less boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [jonathan.derrick: added un-const cast]

> +	return to_pci_sysdata((struct pci_bus *) bus)->node;

Instead of this case I think we'd be better off marking the bus
argument to to_pci_sysdata const.
