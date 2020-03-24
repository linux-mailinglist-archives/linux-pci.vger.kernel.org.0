Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588C819037A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 02:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCXB6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 21:58:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48382 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgCXB63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2020 21:58:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02O1wQvI077892;
        Mon, 23 Mar 2020 20:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585015106;
        bh=UGNdoO9PrQaL5eUpIkxf+ZPzJ0BOOpjYJn8zqTSFIRw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YjTI1lAP9bfZdMgC4hhfPnNkA5sylibZvvF2waWx4dw1RdW0/X72JVtl3dKvOgwqD
         llQiVeXc9TYhmvSeAGxlow5r+PzazEyyqsjKRIbJjLtTl3NgGSWbIgEbyg1L1Q2ZUT
         RCdhSvndYtR1pfprY6T2LS7kH9gM9KN12L0rHTpo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02O1wQjK040750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Mar 2020 20:58:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Mar 2020 20:58:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Mar 2020 20:58:26 -0500
Received: from [10.250.133.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02O1wMHQ120993;
        Mon, 23 Mar 2020 20:58:23 -0500
Subject: Re: PCIe EPF
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
 <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com>
Date:   Tue, 24 Mar 2020 07:28:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 3/22/2020 4:19 AM, Lad, Prabhakar wrote:
> Hi Kishon,
> 
> On Fri, Mar 20, 2020 at 5:28 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Prabhakar,
>>
>> On 3/18/2020 5:07 PM, Lad, Prabhakar wrote:
>>> Hi Kishon,
>>>
>>> I rebased my rcar-endpoint patches on endpoint branch, which has
>>> support for streaming DMA API support, with this  read/write/copy
>>> tests failed, to make sure nothing hasn't changed on my driver I
>>> reverted the streaming DMA API patch
>>> 74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
>>> streaming DMA APIs for buffer allocation" and tests began to pass
>>> again.
>>>
>>> If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
>>> for read/write/copy pass as expected.
>>>
>>> Could you please through some light why this could be happening.
>>
>> Do you see any differences in the address returned by dma_map_single() like is
>> it 32-bit address or 64-bit address?
>>
> Both return 32 bit address, debugging further I see that with
> GFP_KERNEL flag for small buffer
> sizes the read/write/copy tests pass(upto 4k), so I am suspecting its
> related to caching probably.
> Also adding wmb()/rmb() just with GFP_KERNEL flag didn't help. Note I
> am using PIO transfers.
> Any thoughts on how we tackle it ?
> 
> # With GFP_KERNEL flag
> root@hihope-rzg2m:~# pcitest -r
> [   46.210649] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff0004b4ae0000 dma:7e99d000 align:ffff0004b4ae0000
> READ ( 102400 bytes):           NOT OKAY
> root@hihope-rzg2m:~# pcitest -r
> [   51.880063] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff0004b4ae0000 dma:7e9c0000 align:ffff0004b4ae0000
> READ ( 102400 bytes):           OKAY

Here one of the read test is passing and the other is failing.
For the 1st case dma:7e99d000, address is aligned to 4K
For the 2nd case dma:7e9c0000, address is aligned to 256K

I'm suspecting this could be an alignment issue. Does the outbound ATU of your
EP has any restrictions? (like the address should be aligned to the size?).

Thanks
Kishon

> root@hihope-rzg2m:~# pcitest -r
> [   53.354830] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff0004b4ae0000 dma:7e9e2000 align:ffff0004b4ae0000
> READ ( 102400 bytes):           NOT OKAY
> root@hihope-rzg2m:~# pcitest -r
> [   55.307236] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff0004b4ae0000 dma:7ea04000 align:ffff0004b4ae0000
> READ ( 102400 bytes):           NOT OKAY
> root@hihope-rzg2m:~# pcitest -r
> [   57.098626] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff0004b4ae0000 dma:7ea23000 align:ffff0004b4ae0000
> READ ( 102400 bytes):           NOT OKAY
> 
> # GFP_KERNEL | GFP_DMA
> 
> root@hihope-rzg2m:~# pcitest -r -s 1024001
> [  174.562071] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff00003b900000 dma:7b900000 align:ffff00003b900000
> READ (1024001 bytes):           OKAY
> root@hihope-rzg2m:~# pcitest -r -s 16384
> [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
> READ (  16384 bytes):           OKAY
> root@hihope-rzg2m:~# pcitest -r -s 8192
> [  190.578335] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff00003b840000 dma:7b840000 align:ffff00003b840000
> READ (   8192 bytes):           OKAY
> root@hihope-rzg2m:~# pcitest -r -s 128
> [  199.428021] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff00003b800000 dma:7b800000 align:ffff00003b800000
> READ (    128 bytes):           OKAY
> root@hihope-rzg2m:~#
> 
> Cheers,
> --Prabhakar
> 
>> Thanks
>> Kishon
