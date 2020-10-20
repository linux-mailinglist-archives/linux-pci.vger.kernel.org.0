Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6CA293FEE
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436884AbgJTPvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436880AbgJTPvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 11:51:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670AC061755;
        Tue, 20 Oct 2020 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xVKeiMQ1XLylJ8rSbId/RCAy2iAQfbZGLGK+XA6rX94=; b=UtVJOPbFEz+23s9lduIazooL87
        wyK5qqwT/ZkhpfUlFSF2AenPee7/3CibKkGNLxmaIDAvl9lFhYiKR/r9hulwNnAQyYEHbTO12ApcL
        c2O4G2GaQtKYzJV6PSIJPUlzIeH+Agp8lsakx54ZRrVwopiPUi1oE8WpSRpATr1FekEHFVItUoRXQ
        2i4DZyaw/Wq43wBLN3/e9eANpJZ0V9P+cnxiapGgazXjb4cUXQS3a4bF418vEArFtI5hs5xl0QbNg
        h4JhiENXQjY7JIdWdcEK33KuDWKrn+mgr6btmjMs9YNVZLWGCK8FNuZ5YwByRjFfGU3SEMwPUBLLM
        ln7AjsxQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUtvF-0004kW-AN; Tue, 20 Oct 2020 15:51:37 +0000
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
Message-ID: <84b55881-21ba-aa5b-7b56-7d8e411771f9@infradead.org>
Date:   Tue, 20 Oct 2020 08:51:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <45b16450-320b-86fd-603e-4fb311c6f4bd@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/20 7:06 AM, Randy Dunlap wrote:
> On 10/20/20 1:02 AM, Christoph Hellwig wrote:
>> On Sun, Oct 18, 2020 at 11:14:53PM -0700, Randy Dunlap wrote:
>>> Fix a build error in drivers/mfd/ioc.o by exporting
>>> pci_find_host_bridge().
>>>
>>> ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!
>>
>> I think the mfd code should be fixed to not depend on such an internal
>> symbol instead.
>>
> 
> Thanks for commenting. and I am not surprised.
> 
> Adding Cc: for Thomas and Lee.

BTW, if someone wants to use the MFD ioc3 driver now,
without any source code patches, they can just build it in
(SGI_MFD_IOC3=y) instead of building it as a loadable module.

It builds successfully and can use pci_find_host_bridge().
pci_find_host_bridge() just isn't exported for loadable modules.

So this could be useful (PCI=y):

config SGI_MFD_IOC3
	tristate "SGI IOC3 core driver"
	depends on PCI=y && MIPS && 64BIT
	select MFD_CORE

-- 
~Randy

