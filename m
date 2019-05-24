Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5D299D1
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbfEXOMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 10:12:39 -0400
Received: from verein.lst.de ([213.95.11.211]:54200 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403895AbfEXOMj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 10:12:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 95BBC227A81; Fri, 24 May 2019 16:12:15 +0200 (CEST)
Date:   Fri, 24 May 2019 16:12:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply
 when an IOMMU is present
Message-ID: <20190524141215.GB23514@lst.de>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com> <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com> <b9e94126-8686-4306-77c3-bd0b96680775@amd.com> <20190523094322.GA14986@lst.de> <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com> <20190523095057.GA15185@lst.de> <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com> <20190523155922.GA21552@lst.de> <c5b050f4-0584-8262-9285-f1c628ed4e27@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b050f4-0584-8262-9285-f1c628ed4e27@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 12:40:57PM +0000, Koenig, Christian wrote:
> Sounds sane to me as well.
> 
> But since I don't have a struct pages backing my PCI BAR I won't be able 
> to use pci_p2pdma_map_sg.
> 
> How should we work around that?

I think we've got two escalation levels here:

 (1) fix the NVMe/RDMA p2p breakage for 5.2-rc - for that we just need
     the above fix in the p2p map_sg routine (and add an unmap_sg
     routine there)
 (2) figure out how to handle the switched case for your code.  I'm not
     sure about that yet, and without a struct page we'd have to somehow
     track the relationship explicitly.
