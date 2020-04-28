Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF51BC10F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD1OWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 10:22:52 -0400
Received: from verein.lst.de ([213.95.11.211]:56550 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgD1OWw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 10:22:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D68AF68CFE; Tue, 28 Apr 2020 16:22:47 +0200 (CEST)
Date:   Tue, 28 Apr 2020 16:22:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Message-ID: <20200428142247.GB5439@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com> <20200428051312.GB17146@lst.de> <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > I'm not sure who came up with the idea to put this into ACPI, but it
> > belongs into NVMe.  Please talk to the NVMe technical working group
> > instead of trying to overrules them in an unrelated group that
> > doesn't
> > apply to all of PCIe.
> 
> Agreed that this is not ideal since it does not apply to all of PCIe.
> But as the property already exists on shipping systems, we need to be
> able to read it in the NVMe driver and the patch is consitent with the
> way properties under PCI ports are read.

The point is that it is not the BIOSes job do decide how Linux does
power management.  For example D3 has really horrible entry and exit
latencies in many cases, and will lead to higher power usage.
