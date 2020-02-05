Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0476215278C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 09:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBEI3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 03:29:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgBEI3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2020 03:29:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0158TLex011830;
        Wed, 5 Feb 2020 02:29:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580891361;
        bh=4oK9YdhqZWluCHwyBCGvW+a+C9BUXc1zb6pM3j/qtsc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QBGgSXL4NEvqL3KDpD8Bri+gh840FxyqIrE3bQSUKfDeeqv6ZLH2M3dRA9ndwrpAI
         dyFYe5+zUPEsTpm0nnsNDID6f9zY4spch/xaWezgSB+pFkNSOY83k+cBrqaf4MnNmu
         pUvFN2XhvJWlnaBq6NrMJDBSE+r/9ZMlefHbAlCw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0158TLJF119163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Feb 2020 02:29:21 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 02:29:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 02:29:21 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0158TJW5120032;
        Wed, 5 Feb 2020 02:29:20 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com>
 <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
 <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
 <20200205074719.GA22701@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com>
Date:   Wed, 5 Feb 2020 14:02:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200205074719.GA22701@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph,

On 05/02/20 1:17 PM, Christoph Hellwig wrote:
> On Wed, Feb 05, 2020 at 10:45:24AM +0530, Kishon Vijay Abraham I wrote:
>>> Ok, this mostly like means we allocate a swiotlb buffer that isn't
>>> actually addressable.  To verify that can you post the output with the
>>> first attached patch?  If it shows the overflow message added there,
>>> please try if the second patch fixes it.
>>
>> I'm seeing some sort of busy loop after applying your 1st patch. I sent
>> a SysRq to see where it is stuck
> 
> And that shows up just with the patch?  Really strange as it doesn't
> change any blockig points.  What also is strange is that I don't see
> any of the warnings that should be there.  FYI, the slightly updated
> version of the patch that went through my testing it here:
> 
>     git://git.infradead.org/users/hch/misc.git swiotlb-debug
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-debug
> 
> this also includes what was the second patch in the previous mail.  Can
> you try that branch?

I see data mismatch with that branch.

Kernel log: https://pastebin.ubuntu.com/p/9g9cm7GzRh/
Kernel Config: https://pastebin.ubuntu.com/p/gYfpRDdVry/
Repo: https://github.com/kishon/linux-wip.git swiotlb-debug (Added an
additional patch for fixing a interrupt issue over your branch).

Thanks
Kishon
