Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E9462CEE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 07:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhK3Gpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 01:45:38 -0500
Received: from verein.lst.de ([213.95.11.211]:57122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233500AbhK3Gpi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 01:45:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A2E668B05; Tue, 30 Nov 2021 07:42:17 +0100 (CET)
Date:   Tue, 30 Nov 2021 07:42:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211130064217.GA10312@lst.de>
References: <20211117122335.00000b35@Huawei.com> <20211117221536.GA1778765@bhelgaas> <20211119064830.GA15425@lst.de> <CAPcyv4g+=fkMyzoKtRbJfFyM=hq3B=RMJotNWyGoJDZk0d38uQ@mail.gmail.com> <CAPcyv4gYBpx6Anw__gW-3xZfbcTaVv5eUR6wuxt_Ert1N6hDZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gYBpx6Anw__gW-3xZfbcTaVv5eUR6wuxt_Ert1N6hDZA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 03:59:25PM -0800, Dan Williams wrote:
> DOE negotiates security features like SPDM and IDE. I think it is
> important for the kernel to be able to control access to DOE instances
> even though it has not cared about protecting itself from userspace
> initiated configuration writes in the past.

I think DOE is pretty much a kernel only feature and we can't allow
userspace access to it at all.
