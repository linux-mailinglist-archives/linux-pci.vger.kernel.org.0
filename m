Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950F1100A20
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfKRRVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 12:21:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfKRRVl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 12:21:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30221FB;
        Mon, 18 Nov 2019 09:21:40 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 405F23F703;
        Mon, 18 Nov 2019 09:21:40 -0800 (PST)
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20191115130654.GA3414@lst.de> <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
 <20191116163528.GE23951@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <872a502c-5921-2b2e-de65-afc524f156c7@arm.com>
Date:   Mon, 18 Nov 2019 17:21:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116163528.GE23951@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/11/2019 4:35 pm, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 07:48:23PM +0530, Kishon Vijay Abraham I wrote:
>> I think the fix on 5.3 was useful for platform drivers (where the platform
>> driver will set dma_set_mask as 32bits) even when the system itself supports LPAE.
> 
> Well, we can also use the bus_dma_mask for PCI(e) root port quirks,
> as we do that for the VIA ones on x86.  But I think the OF parsing code
> is missing something here, and Robin did plan to look into that.

Right, the correct way to describe this is with "dma-ranges" on the host 
bridge node, and there are patches queued in linux-next to (finally) 
handle that properly for the way we bodge dynamically-discovered 
endpoints through of_dma_configure().

Robin.

>> We should find a way to set the DMA mask of of the PCI device based on the DMA
>> mask of the PCI controller in the SoC. One option would be to change the
>> pci_drivers all over the kernel to set DMA mask to be based on the DMA mask of
>> the PCI controller (the PCI device hierarchy should get a reference to the
>> device pointer of the PCI controller). Or is there a better way to handle this?
> 
> No.  The driver sets the device capabilities.  bus_dma_mask handles
> the system limitations.
> 
