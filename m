Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FD27A78
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfEWK0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 06:26:32 -0400
Received: from verein.lst.de ([213.95.11.211]:45811 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWK0b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 06:26:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9B4D868AFE; Thu, 23 May 2019 12:26:08 +0200 (CEST)
Date:   Thu, 23 May 2019 12:26:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply
 when an IOMMU is present
Message-ID: <20190523102608.GA15800@lst.de>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com> <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com> <b9e94126-8686-4306-77c3-bd0b96680775@amd.com> <20190523094322.GA14986@lst.de> <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com> <20190523095057.GA15185@lst.de> <b09d61f0-cc6d-5043-1cb3-6891e589a872@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09d61f0-cc6d-5043-1cb3-6891e589a872@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 10:06:28AM +0000, Koenig, Christian wrote:
> Ok, we certainly don't have a system which exercise this user case. 
> Could ask around if we have an ARM SOC with that properties somewhere.
> 
> But asking the other way around: Where is the right place to start 
> fixing all this? dma_map_resource()?

That is the the big gorrilla in the room.  The offset applies to the
device whos BARs/resources we map.  The current dma_map_resource API
does not even have the right information.  So I think we need to
enhance the API to pass a second struct device and we could fix it
there and then in the next steps add a map_sg version of
dma_map_resource and eventually also convert the PCIe P2P map_sg
over to that.
