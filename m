Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA6152854
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBEJ3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 04:29:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38802 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBEJ3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2020 04:29:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0159Thjg027354;
        Wed, 5 Feb 2020 03:29:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580894983;
        bh=xLEAFY0eInQuru5nfklQ/d2iYjGo3AFkM7A7McJzMNE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H9KQqFuRXnvtO/geTs39ucvriUQkr7Ho8bgjK0WdTX+HDR7b20/4S3pLlpznjZXpj
         VWcaPUKSxRt4wVB9mYE+RXmr07JgGQMDhxZC2IAzDRWwtz4yw+QWZ307kgTv+E17/G
         tkbUZ0lpcPz7anRfepw2jzPYasQTDVOtcvUwQHCk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0159Thv6067707;
        Wed, 5 Feb 2020 03:29:43 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 03:29:43 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 03:29:43 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0159TfTw097331;
        Wed, 5 Feb 2020 03:29:42 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20200130075833.GC30735@lst.de>
 <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com> <20200130164235.GA6705@lst.de>
 <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com> <20200203142155.GA16388@lst.de>
 <a5eb4f73-418a-6780-354f-175d08395e71@ti.com> <20200205074719.GA22701@lst.de>
 <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com> <20200205084844.GA23831@lst.de>
 <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com> <20200205091959.GA24413@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com>
Date:   Wed, 5 Feb 2020 15:03:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200205091959.GA24413@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph,

On 05/02/20 2:49 PM, Christoph Hellwig wrote:
> On Wed, Feb 05, 2020 at 02:48:17PM +0530, Kishon Vijay Abraham I wrote:
>> Christoph,
>>
>> On 05/02/20 2:18 PM, Christoph Hellwig wrote:
>>> On Wed, Feb 05, 2020 at 02:02:51PM +0530, Kishon Vijay Abraham I wrote:
>>>>> you try that branch?
>>>>
>>>> I see data mismatch with that branch.
>>>
>>> But previously it didn't work at all? If you disable LPAE and thus
>>> limit the available RAM, does it work without any fixes?
>>
>> Previously there was a warn dump and it gets stuck.
>>
>> With the branch you shared (with LPAE enabled), there was data mismatch.
>> With the branch you shared (with LPAE disabled), things work fine
>> (https://pastebin.ubuntu.com/p/kPNdsJd7ds/)
> 
> Does the miscompare still happen if you revert:
> 
>  "dma-direct: improve DMA mask overflow reporting"
> 
> and
> 
>  "dma-direct: improve swiotlb error reporting"
> 
> ?

Yes, I see the mismatch after reverting the above patches.

Thanks
Kishon
