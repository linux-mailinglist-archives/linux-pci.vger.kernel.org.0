Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33C279B5
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfEWJvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 05:51:21 -0400
Received: from verein.lst.de ([213.95.11.211]:45578 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfEWJvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 05:51:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1B04968B05; Thu, 23 May 2019 11:50:58 +0200 (CEST)
Date:   Thu, 23 May 2019 11:50:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply
 when an IOMMU is present
Message-ID: <20190523095057.GA15185@lst.de>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com> <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com> <b9e94126-8686-4306-77c3-bd0b96680775@amd.com> <20190523094322.GA14986@lst.de> <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 09:48:40AM +0000, Koenig, Christian wrote:
> I don't adjust the address manually anywhere. I just call 
> dma_map_resource() and use the resulting DMA address to access the other 
> devices PCI BAR.
> 
> At least on my test system (AMD CPU + AMD GPUs) this seems to work 
> totally fine. Currently trying to find time and an Intel box to test it 
> there as well.

The problem shows up if pci_bus_address() returns a different address
than pci_resource_start(), should be easy to check if that happens.
IIRC it is something mostly seen on embedded SOCs.
