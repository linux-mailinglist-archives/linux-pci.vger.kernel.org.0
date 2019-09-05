Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2954EAA5E2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfIEOcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 10:32:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfIEOcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 10:32:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F291728;
        Thu,  5 Sep 2019 07:32:18 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDCBC3F67D;
        Thu,  5 Sep 2019 07:32:17 -0700 (PDT)
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     John Garry <john.garry@huawei.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
 <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
 <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
 <8ac8e372-15a0-2f95-089c-c189b619ea62@huawei.com>
 <73c22eaa-172e-0fba-7a44-381106dee50d@kernel.org>
 <a73262e6-6ece-4946-896b-2dad5ca28417@huawei.com>
 <a90e6f99-cad3-8eda-dd08-0ab05ed9ca04@kernel.org>
 <ecdb638b-d5d3-efdc-becd-478ce6e6ff96@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e3a4a04a-4669-5a03-5115-84c6573b99e9@kernel.org>
Date:   Thu, 5 Sep 2019 15:32:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ecdb638b-d5d3-efdc-becd-478ce6e6ff96@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/09/2019 15:23, John Garry wrote:
> On 05/09/2019 14:50, Marc Zyngier wrote:
>> On 05/09/2019 14:26, John Garry wrote:
>>> On 05/09/2019 12:22, Marc Zyngier wrote:
>>>> OK, debug was slightly off, but it is interesting that the driver didn't
>>>> unmap the device, either because it is flagged as shared (with what?) or
>>>> that additional interrupts are allocated in the lpi_map for this
>>>> instance.
>>>>
>>>> Here's an updated debug patch. Can you please run the same thing again?
>>>>
>>>
>>> As requested:
>>>
>>> root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
>>>
>>> <snip>
>>>
>>> [   78.593897] Freed devid 7410 event 0 LPI 0
>>> [   78.597990] Freed devid 7410 event 1 LPI 0
>>> [   78.602080] Freed devid 7410 event 2 LPI 0
>>> [   78.606169] Freed devid 7410 event 3 LPI 0
>>> [   78.610253] Freed devid 7410 event 4 LPI 0
>>> [   78.614337] Freed devid 7410 event 5 LPI 0
>>> [   78.618422] Freed devid 7410 event 6 LPI 0
>>> [   78.622506] Freed devid 7410 event 7 LPI 0
>>> [   78.626590] Freed devid 7410 event 8 LPI 0
>>> [   78.630674] Freed devid 7410 event 9 LPI 0
>>> [   78.634758] Freed devid 7410 event 10 LPI 0
>>> [   78.638930] Freed devid 7410 event 11 LPI 0
>>> [   78.643101] Freed devid 7410 event 12 LPI 0
>>> [   78.647272] Freed devid 7410 event 13 LPI 0
>>> [   78.651445] Freed devid 7410 event 14 LPI 0
>>> [   78.655616] Freed devid 7410 event 15 LPI 0
>>> [   78.659787] Freed devid 7410 event 16 LPI 0
>>> [   78.663959] Unmap devid 7410 shared 0 lpi_map 17-31
>>
>> Bah. Try this for size...
>>
> 
> It fits:
> 
> root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
> 
> <snip>
> 
> [   34.806156] Freed devid 7410 LPI 0
> [   34.809555] Freed devid 7410 LPI 0
> [   34.812951] Freed devid 7410 LPI 0
> [   34.816344] Freed devid 7410 LPI 0
> [   34.819734] Freed devid 7410 LPI 0
> [   34.823122] Freed devid 7410 LPI 0
> [   34.826512] Freed devid 7410 LPI 0
> [   34.829901] Freed devid 7410 LPI 0
> [   34.833291] Freed devid 7410 LPI 0
> [   34.836680] Freed devid 7410 LPI 0
> [   34.840071] Freed devid 7410 LPI 0
> [   34.843461] Freed devid 7410 LPI 0
> [   34.846848] Freed devid 7410 LPI 0
> [   34.850238] Freed devid 7410 LPI 0
> [   34.853627] Freed devid 7410 LPI 0
> [   34.857017] Freed devid 7410 LPI 0
> [   34.860406] Freed devid 7410 LPI 0
> [   34.863797] Unmap devid 7410 shared 0 lpi_map
> [   34.868229] Unmap devid 7410
> root@(none)$
> root@(none)$
> root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
> [   39.158802] scsi host0: hisi_sas_v3_hw
> [   40.383384] ITS: alloc 9920:32
> [   40.386429] ITT 32 entries, 5 bits
> [   40.389970] ID:0 pID:9920 vID:23
> [   40.393188] ID:1 pID:9921 vID:24
> [   40.396404] ID:2 pID:9922 vID:25
> [   40.399621] ID:3 pID:9923 vID:26
> [   40.402836] ID:4 pID:9924 vID:27
> [   40.406053] ID:5 pID:9925 vID:28
> [   40.409269] ID:6 pID:9926 vID:29
> [   40.412485] ID:7 pID:9927 vID:30
> [   40.415702] ID:8 pID:9928 vID:31
> [   40.418916] ID:9 pID:9929 vID:32
> [   40.422132] ID:10 pID:9930 vID:33
> [   40.425435] ID:11 pID:9931 vID:34
> [   40.428739] ID:12 pID:9932 vID:35
> [   40.432042] ID:13 pID:9933 vID:36
> [   40.435345] ID:14 pID:9934 vID:37
> [   40.438648] ID:15 pID:9935 vID:38
> [   40.441951] ID:16 pID:9936 vID:39
> 
> 
> <snip>

Awesome. Can I take this as a Tested-by?

> Btw, I hacked the "Freed devid %x event %d LPI %ld\n" print to remove 
> the "event" value, as you may have noticed.

Yup, not meaningful for the problem at hand.

Thanks again for your help!

	M.
-- 
Jazz is not dead, it just smells funny...
