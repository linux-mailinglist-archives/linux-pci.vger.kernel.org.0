Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7505645B44C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 07:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhKXGgc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 01:36:32 -0500
Received: from verein.lst.de ([213.95.11.211]:35794 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235213AbhKXGg3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 01:36:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0BBE968AFE; Wed, 24 Nov 2021 07:33:17 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:33:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211124063316.GA6792@lst.de>
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com> <20211123235557.GA2247853@bhelgaas> <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 04:40:06PM -0800, Dan Williams wrote:
> Let me ask a clarifying question coming from the other direction that
> resulted in the creation of the auxiliary bus architecture. Some
> background. RDMA is a protocol that may run on top of Ethernet.

No, RDMA is a concept.  Linux supports 2 and a half RDMA protocols
that run over ethernet (RoCE v1 and v2 and iWarp).

> Consider the case where you have multiple generations of Ethernet
> adapter devices, but they all support common RDMA functionality. You
> only have the one PCI device to attach a unique Ethernet driver. What
> is an idiomatic way to deploy a module that automatically loads and
> attaches to the exported common functionality across adapters that
> otherwise have a unique native driver for the hardware device?

The whole aux bus drama is mostly because the intel design for these
is really fucked up.  All the sane HCAs do not use this model.  All
this attchment crap really should not be there.

> Another example, the Native PCIe Enclosure Management (NPEM)
> specification defines a handful of registers that can appear anywhere
> in the PCIe hierarchy. How can you write a common driver that is
> generically applicable to any given NPEM instance?

Another totally messed up spec.  But then pretty much everything coming
from the PCIe SIG in terms of interface tends to be really, really
broken lately.
