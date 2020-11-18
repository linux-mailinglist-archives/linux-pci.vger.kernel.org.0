Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17242B8219
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgKRQoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 11:44:24 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:34014 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgKRQoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 11:44:24 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kfQZB-0005r4-6S; Wed, 18 Nov 2020 16:44:21 +0000
Subject: Re: [PATCH v17 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Daire.McNamara@microchip.com, linux-pci@vger.kernel.org,
        Sam Bishop <sam.bishop@codethink.co.uk>,
        =?UTF-8?Q?Javier_Jard=c3=b3n?= <javier.jardon@codethink.co.uk>
References: <20201022132223.17789-4-daire.mcnamara@microchip.com>
 <587df2af-c59e-371a-230c-9c7a614824bd@codethink.co.uk>
 <MN2PR11MB426909C2B84E95AF301C404B96100@MN2PR11MB4269.namprd11.prod.outlook.com>
 <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <a1d73fd6-e4d5-4c3c-d0ec-f8dabd269f6c@codethink.co.uk>
Date:   Wed, 18 Nov 2020 16:44:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/11/2020 11:15, Ben Dooks wrote:
> On 02/11/2020 10:39, Daire.McNamara@microchip.com wrote:
>> Hi Ben,
>>
>> Yes, we've become aware of an issue that's cropped up with latest 
>> design file on Icicle with PCIe.  We're working through it and we'll 
>> update once we have resolved it.
> 
> Thanks for looking at this.

Any updates on the Icicle PCIe issue? We'd love to get some work
done with PCIe on these boards but are rather stuck at the moment.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
