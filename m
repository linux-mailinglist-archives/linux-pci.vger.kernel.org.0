Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67720108872
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 06:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYFnz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 00:43:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53362 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfKYFnz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 00:43:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAP5hmhX114395;
        Sun, 24 Nov 2019 23:43:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574660628;
        bh=Wu4sSylZl1QmEnC2I8oh+yJncz0ASdR5nQvgihvXUbc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E394W5geLM/X0fQlfTnQ67LxFD5ddRX8ff+Kwq6tZjEn+5nJK+uL8P0Ujn1o1tXzV
         iYAwOXZccNJKyvSjI6aSWtuFLzpV+71st4/3uyHotutXKr4B6TT4wHFl78MwD4K5yt
         ZGX/mq7dWkKbmGmurjWZaCA8m8OrUiydfYnrNUr8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAP5hmih071351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 24 Nov 2019 23:43:48 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 24
 Nov 2019 23:43:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 24 Nov 2019 23:43:48 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAP5hjeE000545;
        Sun, 24 Nov 2019 23:43:46 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20191115130654.GA3414@lst.de> <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
 <20191116163528.GE23951@lst.de>
 <872a502c-5921-2b2e-de65-afc524f156c7@arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7bf16dc1-6f39-771c-cfb4-090c2a87e859@ti.com>
Date:   Mon, 25 Nov 2019 11:13:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <872a502c-5921-2b2e-de65-afc524f156c7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 18/11/19 10:51 PM, Robin Murphy wrote:
> On 16/11/2019 4:35 pm, Christoph Hellwig wrote:
>> On Fri, Nov 15, 2019 at 07:48:23PM +0530, Kishon Vijay Abraham I wrote:
>>> I think the fix on 5.3 was useful for platform drivers (where the platform
>>> driver will set dma_set_mask as 32bits) even when the system itself supports
>>> LPAE.
>>
>> Well, we can also use the bus_dma_mask for PCI(e) root port quirks,
>> as we do that for the VIA ones on x86.  But I think the OF parsing code
>> is missing something here, and Robin did plan to look into that.
> 
> Right, the correct way to describe this is with "dma-ranges" on the host bridge
> node, and there are patches queued in linux-next to (finally) handle that
> properly for the way we bodge dynamically-discovered endpoints through
> of_dma_configure().

Tried linux-next after adding dma-ranges property to the DRA7 RC dt node and
don't see the issue anymore.

Thanks
Kishon

> 
> Robin.
> 
>>> We should find a way to set the DMA mask of of the PCI device based on the DMA
>>> mask of the PCI controller in the SoC. One option would be to change the
>>> pci_drivers all over the kernel to set DMA mask to be based on the DMA mask of
>>> the PCI controller (the PCI device hierarchy should get a reference to the
>>> device pointer of the PCI controller). Or is there a better way to handle this?
>>
>> No.  The driver sets the device capabilities.  bus_dma_mask handles
>> the system limitations.
>>
