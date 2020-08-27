Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B141254B20
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgH0Qua (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgH0Qu3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 12:50:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07FC061264;
        Thu, 27 Aug 2020 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Suq6RmjK6UVv4ul6GVoPMckCVMrlCWnO71fryQ+CL5U=; b=WJIIbkQPdfo+0fSSyFE/rSQ1PA
        OueuGza6VrwoIxjP2FjBHxX3+IW0zd6cb/uBG3QsQc1ONLpSV/d1aJR2IIysD8SGNQglrHXvxyKm8
        CWheUSTkKiIVQBmrZXQAUAkDd8NjYEYrIUv8Qi70dEZmIrG786nQ4FkUfFitvW/f87OgtGMZ4tHuP
        t7D+bLauDjSHv/ammitLvqjNO48U7YkTe4PKbNG7gLkduUR8sJK5xBNE25/zvuHuXKOi1TEMJb3uR
        lUf0IyrHRzWmMkS7Rs4DumwxyLhw1H1miz1Ubu2/0rcMrsaHD2LTqqj8WfbGqiNI9JrfJXktrab3W
        Kq53tmbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBL6R-0003jz-4m; Thu, 27 Aug 2020 16:50:19 +0000
Date:   Thu, 27 Aug 2020 17:50:19 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200827165019.GA13414@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
 <20200827063406.GA13738@infradead.org>
 <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
 <20200827162333.GA6822@infradead.org>
 <eb45485d9107440a667e598da99ad949320b77b1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb45485d9107440a667e598da99ad949320b77b1.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 27, 2020 at 04:45:53PM +0000, Derrick, Jonathan wrote:
> Just a few benefits and there are other users with unique use cases:
> 1. Passthrough of the endpoint to OSes which don't natively support
> hotplug can enable hotplug for that OS using the guest VMD driver

Or they could just write a hotplug driver, which would be more useful
than writing a hotplug driver.

> 2. Some hypervisors have a limit on the number of devices that can be
> passed through. VMD endpoint is a single device that expands to many.

Or you just fix the hypervisor.  Never mind that this is so much
less likely than wanting to pass an individual device or VF to a guest,
which VMD makes impossible (at least without tons of hacks specifically
for it).

> 3. Expansion of possible bus numbers beyond 256 by using other
> segments.

Which we can trivially to with PCI domains.

> 4. Custom RAID LED patterns driven by ledctl

Which you can also do by any other vendor specific way.

> 
> I'm not trying to market this. Just pointing out that this isn't
> "bringing zero actual benefits" to many users.

Which of those are a benefit to a Linux user?  Serious, I really don't
care if Intel wants to sell VMD as a value add to those that have
a perceived or in rare cases even real need.  Just let Linux opt out
of it instead of needing special quirks all over.
