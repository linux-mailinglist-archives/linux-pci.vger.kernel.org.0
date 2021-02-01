Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2430B259
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 22:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBAVxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 16:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBAVxw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 16:53:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3295C06174A
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 13:53:06 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my11so595372pjb.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 13:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=N6tU/hkqNUMYsHM0IUqTnCXIZDB8nb2QJ5YhEZMP+tE=;
        b=WZi+UCs9TIbCUorANOZIg1lacKJyrLAcxNgjqYv2hNfd0YCcWVUr7BGsWFb1LJIeln
         UelOikGZSyHtnr85jilxjPtGr9ZrM138I2fxLqj7VzG8BUYH/s6nx67rVjthtycndIQX
         L3fGAZD1a7UEf5TUkzE8WDjRzAznsbPZomOWfxve4P0qqnIX7Kb2xvvbK6O5gtVEHUqw
         vBxXHHfsMMe0vFxzNCHdspQP6sYm6XDirkDgPU/KcOLz+prvZoNhzG2Py/aSLNALyU/E
         3RqDEnEBvUa0+i2+s4SRsa3p3nhYWglPsFE5vBFTZtM/lOExGpoLoTxaNVZstQlDpviD
         6EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=N6tU/hkqNUMYsHM0IUqTnCXIZDB8nb2QJ5YhEZMP+tE=;
        b=jvNn5cicku9tHdSkuqSrZlIoiJNSUWN0cxpfEFTRfO/+2r8VlJCrT78BIiXN7pNP4p
         0Cg1sDX2kH1lHetKqqpfKZR6ZMiagAZaOOPuK0hyoi8I1+0VN6VuGxaQmrbnkzJvp4q5
         lsvv6We2mtTpZpeoF1lB1HjD/WOJ0A2UY+DkUQ5nCnjPZ2qG/2MOKZXPiY6F6qEwJ9RE
         8y5DGhdrTJM1O5smL7Q1/5WFdsKxqBnfWZrjOy5/z7XBY/3nvbkDEHUDqhxuVCsrD9MF
         2Sq8b67niVsLMFey8/AzzbpBbmKcxyMupEJ/8m+1yjZOf8R7zfQKiGIZZyl2Qn7k/rTU
         +Ugw==
X-Gm-Message-State: AOAM531HKTy7xoqlC6j5MZ5xI+d40R7f4DD1TC+zW6wI2GLLSrv5x+xT
        hAhv+fOdZ0pX1BFezSOsaGgLXQ==
X-Google-Smtp-Source: ABdhPJycALujIbA4WvZUkZggYo0Ocv7rTw3rYtZTgJzBXpeooffmD1f4WnTwFRQBCWLZpToH49e2uA==
X-Received: by 2002:a17:902:c106:b029:de:af88:80ed with SMTP id 6-20020a170902c106b02900deaf8880edmr19001691pli.35.1612216386313;
        Mon, 01 Feb 2021 13:53:06 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id k128sm18715106pfd.137.2021.02.01.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:53:05 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:53:03 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
In-Reply-To: <20210201171051.m3cbr3udczxwghqh@intel.com>
Message-ID: <4d62a125-91e1-d32-66d3-1216d751f9b8@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-6-ben.widawsky@intel.com> <ecd93422-b272-2b76-1ec-cf6af744ae@google.com> <20210201171051.m3cbr3udczxwghqh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > new file mode 100644
> > > index 000000000000..fe7b87eba988
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -0,0 +1,26 @@
> > > +What:		/sys/bus/cxl/devices/memX/firmware_version
> > > +Date:		December, 2020
> > > +KernelVersion:	v5.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) "FW Revision" string as reported by the Identify
> > > +		Memory Device Output Payload in the CXL-2.0
> > > +		specification.
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/ram/size
> > > +Date:		December, 2020
> > > +KernelVersion:	v5.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) "Volatile Only Capacity" as reported by the
> > > +		Identify Memory Device Output Payload in the CXL-2.0
> > > +		specification.
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/pmem/size
> > > +Date:		December, 2020
> > > +KernelVersion:	v5.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) "Persistent Only Capacity" as reported by the
> > > +		Identify Memory Device Output Payload in the CXL-2.0
> > > +		specification.
> > 
> > Aren't volatile and persistent capacities expressed in multiples of 256MB?
> 
> As of the spec today, volatile and persistent capacities are required to be
> in multiples of 256MB, however, future specs may not have such a requirement and
> I think keeping sysfs ABI easily forward portable makes sense.
> 

Makes sense, can we add that these are expressed in bytes or is that 
already implied?
