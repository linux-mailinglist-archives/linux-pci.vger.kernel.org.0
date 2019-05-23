Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CAB28208
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfEWP7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 11:59:23 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49754 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfEWP7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 11:59:23 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hTq7m-0007Se-4l; Thu, 23 May 2019 09:59:22 -0600
To:     Christoph Hellwig <hch@lst.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
 <20190523095057.GA15185@lst.de>
 <b09d61f0-cc6d-5043-1cb3-6891e589a872@amd.com>
 <20190523102608.GA15800@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9aa5753c-5b76-925f-3fc7-3d79b5aad5fd@deltatee.com>
Date:   Thu, 23 May 2019 09:59:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102608.GA15800@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, Christian.Koenig@amd.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-05-23 4:26 a.m., Christoph Hellwig wrote:
> On Thu, May 23, 2019 at 10:06:28AM +0000, Koenig, Christian wrote:
>> Ok, we certainly don't have a system which exercise this user case. 
>> Could ask around if we have an ARM SOC with that properties somewhere.
>>
>> But asking the other way around: Where is the right place to start 
>> fixing all this? dma_map_resource()?
> 
> That is the the big gorrilla in the room.  The offset applies to the
> device whos BARs/resources we map.  The current dma_map_resource API
> does not even have the right information.  So I think we need to
> enhance the API to pass a second struct device and we could fix it
> there and then in the next steps add a map_sg version of
> dma_map_resource and eventually also convert the PCIe P2P map_sg
> over to that.

IMO, this logic belongs in pci_p2pdma_map_* helpers that call dma_map_*
helpers when appropriate. Changing dma_map_resource() to take two
devices won't always make sense. For example, there are existing use
cases of dma_map_resource() that work with the Intel IOAT DMA engine and
thus it's known that those transactions will always go through the IOMMU
if it's enabled; and therefore the existing dma_map_resource() is
appropriate.

Logan

