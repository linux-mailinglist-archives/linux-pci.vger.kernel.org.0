Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7C294028
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437100AbgJTQEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 12:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437099AbgJTQEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 12:04:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321DC061755;
        Tue, 20 Oct 2020 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MECigjgQ/weUzaLYQR4x9veFvTH5yieRfF6F9xLSQbQ=; b=Pff83xYYspyhuv+ihoFQXHIeZH
        HL8AqWVLK9kpIUXUGryLQv0UQNR1ksU8O20C6CXWkaP9VozJtHMKqxNXrr8WZ+dZq+IDlFIVD12c+
        otE7Rx/NuLnMWj9Pzq9sWwiP4lyr+D1bYXU3PS/t9qiw4MotAhX5K1l25j5FcE4lYyJlYmte7P/g/
        IV9NOLyncu9lmfQDcDZ+kEgfkNPK+bQRfoh5ZWTMJLm9VfKDGytuin2NbjB/ZD1pgWRKeLveXFIAA
        B5EaFMjUexbwTERDdt2TG6QWBzvqjXWOlL4UY+toTG3EtNRceyi4/lET5IEWHVIO/F+n6OV2GnaTT
        67i0Wq5Q==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUu7n-0005WU-7I; Tue, 20 Oct 2020 16:04:36 +0000
Subject: Re: [PATCH] PCI: export pci_find_host_bridge() to fix MFD build error
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
References: <20201019061453.32295-1-rdunlap@infradead.org>
 <20201020080219.GA21011@infradead.org>
 <45b16450-320b-86fd-603e-4fb311c6f4bd@infradead.org>
 <84b55881-21ba-aa5b-7b56-7d8e411771f9@infradead.org>
Message-ID: <2cdd59ba-4832-c25a-50e5-62766070675d@infradead.org>
Date:   Tue, 20 Oct 2020 09:04:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <84b55881-21ba-aa5b-7b56-7d8e411771f9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/20 8:51 AM, Randy Dunlap wrote:
> On 10/20/20 7:06 AM, Randy Dunlap wrote:
>> On 10/20/20 1:02 AM, Christoph Hellwig wrote:
>>> On Sun, Oct 18, 2020 at 11:14:53PM -0700, Randy Dunlap wrote:
>>>> Fix a build error in drivers/mfd/ioc.o by exporting
>>>> pci_find_host_bridge().
>>>>
>>>> ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!
>>>
>>> I think the mfd code should be fixed to not depend on such an internal
>>> symbol instead.
>>>
>>
>> Thanks for commenting. and I am not surprised.
>>
>> Adding Cc: for Thomas and Lee.
> 
> BTW, if someone wants to use the MFD ioc3 driver now,
> without any source code patches, they can just build it in
> (SGI_MFD_IOC3=y) instead of building it as a loadable module.
> 
> It builds successfully and can use pci_find_host_bridge().
> pci_find_host_bridge() just isn't exported for loadable modules.
> 
> So this could be useful (PCI=y):
> 
> config SGI_MFD_IOC3
> 	tristate "SGI IOC3 core driver"
> 	depends on PCI=y && MIPS && 64BIT
> 	select MFD_CORE

Wow. That's not correct at all. Need more coffee.

Just set SGI_MFD_IOC3=y and it will be fine.

-- 
~Randy

