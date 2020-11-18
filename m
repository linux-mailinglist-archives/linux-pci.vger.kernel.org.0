Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED142B82A1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgKRREK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 12:04:10 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:34620 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbgKRREK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 12:04:10 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kfQsK-0006Rw-5c; Wed, 18 Nov 2020 17:04:08 +0000
Subject: Re: [PATCH v17 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Daire.McNamara@microchip.com, linux-pci@vger.kernel.org
References: <20201022132223.17789-4-daire.mcnamara@microchip.com>
 <587df2af-c59e-371a-230c-9c7a614824bd@codethink.co.uk>
 <MN2PR11MB426909C2B84E95AF301C404B96100@MN2PR11MB4269.namprd11.prod.outlook.com>
 <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
 <20201118163931.GB32004@e121166-lin.cambridge.arm.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <557a37d9-3694-ede1-d7b0-adfba4345fc0@codethink.co.uk>
Date:   Wed, 18 Nov 2020 17:04:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118163931.GB32004@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/11/2020 16:39, Lorenzo Pieralisi wrote:
> On Mon, Nov 02, 2020 at 11:15:25AM +0000, Ben Dooks wrote:
>> On 02/11/2020 10:39, Daire.McNamara@microchip.com wrote:
>>> Hi Ben,
>>>
>>> Yes, we've become aware of an issue that's cropped up with latest design file on Icicle with PCIe.  We're working through it and we'll update once we have resolved it.
>>
> 
> Message above did not make it to linux-pci (list rejects anything that
> is not plain text), this was a public discussion and must have stayed
> so, thanks to Ben for posting back.
> 
>> Thanks for looking at this.
>>
>> We could really do with this working as we need faster storage
>> and graphics options for what we want to do with these boards.
>>
>> I am happy to reinstall or rebuild images, i've got a v5.9 that
>> works to an extent on the icicles.
> 
> Where's the fix for this ? It would be good to merge the driver with
> no known regressions.

I don't know yet, I managed to get the icicle 5.6 up to 5.9 to allow
mering this series on. However it does not get to detect a PCIe card.

I can try and get some dmesg logs if that would be useful. The root
port seems to get seen and shows up in lspci.

I can't currently get to the boards physically due to the lockdown
and issues with getting to our offices.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
