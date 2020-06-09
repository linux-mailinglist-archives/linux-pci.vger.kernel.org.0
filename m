Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5000E1F4102
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgFIQgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:36:01 -0400
Received: from ts18-13.vcr.istar.ca ([204.191.154.188]:42288 "EHLO
        ale.deltatee.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgFIQgB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=47m4c67NQmMGP0uYxblsl5MMn1YEfYJqTmyXbRAMT6Q=; b=MMjuTPcO6mYInDTkMJo18+PE5E
        xNPOksnpi7UCnZ+KEUz5Cj5dgNur+uHjs9DZanlO0a5KD6Pd9vIRDqa6a2JYVOVMu7H84hQiKs1QX
        0wIsOu1CsJZvMVITJ6+y2wLIY033ic6d6JK4VGJdZWXHEcx63J9r6tK0RMXn2MQ2XCR5ShlEgCB53
        jrAwDj2Vx0lEDyDelg3CGZrJYcSQWskr/aNvabeLRJal9fHn0TB7sV4WzE9L9C4UNUiI1KCdxYyIV
        2CEnMqqQKNqKvBpdXtr6rQV+NYQjWTVYC047MqBXl5Im3+bBCdFY/+L25PvIjUs+u8YFHGbl/C501
        cBOVTrhw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jihE7-0006xw-6u; Tue, 09 Jun 2020 10:35:52 -0600
To:     Christoph Hellwig <hch@infradead.org>,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091650.801-1-piotr.stankiewicz@intel.com>
 <20200609155124.GB2597@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7ffab57-424d-e149-05b4-0a377f31b83d@deltatee.com>
Date:   Tue, 9 Jun 2020 10:35:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609155124.GB2597@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, bigeasy@linutronix.de, kw@linux.com, peterz@infradead.org, wesley.sheng@microchip.com, kelvin.cao@microchip.com, sathyanarayanan.kuppuswamy@linux.intel.com, olof@lixom.net, andriy.shevchenko@intel.com, rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, bhelgaas@google.com, piotr.stankiewicz@intel.com, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 03/15] PCI: Use PCI_IRQ_MSI_TYPES where appropriate
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-06-09 9:51 a.m., Christoph Hellwig wrote:
> On Tue, Jun 09, 2020 at 11:16:46AM +0200, Piotr Stankiewicz wrote:
>> Seeing as there is shorthand available to use when asking for any type
>> of interrupt, or any type of message signalled interrupt, leverage it.
>>
>> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> The patch actually adding PCI_IRQ_MSI_TYPES still didn't show up on
> linux-pci.
> 
> But from the person who added PCI_IRQ_*:
> 
> NAK to the whole concept of PCI_IRQ_MSI_TYPES, I think this just makes
> the code a lot more confusing.  Especially with the new IMS interrupt
> type, which really is a MSI-like interrupt but certainly shouldn't be
> added to this mask.

Yes, after cleaning up the first patch to not require the long messy
conditional, this change doesn't seems like a win. I agree we should
drop these patches.

Logan
