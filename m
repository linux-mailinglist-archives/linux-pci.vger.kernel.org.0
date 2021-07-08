Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC23BF83E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhGHKSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 06:18:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59714 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhGHKSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 06:18:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 168AFpE4107724;
        Thu, 8 Jul 2021 05:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625739351;
        bh=5a3BKnK7lYiyXGJcRwidh7H42acoE1IAk2HdeMQnsLw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a825WKD49fyWKNOIvmHvv7c6aCoajJeN+hZey8/4AYPtf8kBldgO18Qbem+hFTpfx
         vl7LjNggboRMVW+tSpAVMlPXU+96S+rR+KNTNRGNn9Kky62+7h2nOzpR817WSsz338
         vaK0QEZPuYuzDgUEEPSHAvOdLRM1JOEDJARFgGwQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 168AFpfG116379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Jul 2021 05:15:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 8 Jul
 2021 05:15:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 8 Jul 2021 05:15:51 -0500
Received: from [10.250.234.71] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 168AFlUL003643;
        Thu, 8 Jul 2021 05:15:48 -0500
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <kernel@pengutronix.de>, <linux-pci@vger.kernel.org>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
 <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
 <20210705154650.roeaqika5ptknrnt@pengutronix.de>
 <20210708092318.zksrx77fx53y45bt@pengutronix.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7f656f13-225f-eef1-01d7-8a599c093d2c@ti.com>
Date:   Thu, 8 Jul 2021 15:45:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210708092318.zksrx77fx53y45bt@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 08/07/21 2:53 pm, Uwe Kleine-König wrote:
> On Mon, Jul 05, 2021 at 05:46:50PM +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Tue, Jun 22, 2021 at 03:29:27PM +0530, Kishon Vijay Abraham I wrote:
>>> On 23/02/21 2:37 pm, Uwe Kleine-König wrote:
>>>> The driver core ignores the return value of pci_epf_device_remove()
>>>> (because there is only little it can do when a device disappears) and
>>>> there are no pci_epf_drivers with a remove callback.
>>>>
>>>> So make it impossible for future drivers to return an unused error code
>>>> by changing the remove prototype to return void.
>>>>
>>>> The real motivation for this change is the quest to make struct
>>>> bus_type::remove return void, too.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>
>>> Fine with this change!
>>>
>>> FWIW:
>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Thanks for the ack. How can I expect this patch to go into mainline now?
>> Will Bjorn pick it up now that you acked?
> 
> There is a series[1] that I'd like to get into mainline during the next
> merge window and that depends on this patch. Ideally it would go in
> for v5.14-rc1, otherwise I'd like to add it to the series changing
> bus_type::remove that it goes in together. Would be sad if I had to
> delay this cleanup for this dependency not going in.

Can you pick this change in the -rc cycle?

Thank You,
Kishon

> 
> Best regards
> Uwe
> 
> [1] https://lore.kernel.org/lkml/20210706154803.1631813-1-u.kleine-koenig@pengutronix.de
> 
> 
