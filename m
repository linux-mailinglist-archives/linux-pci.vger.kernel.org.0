Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD439AF61
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 03:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFDBMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 21:12:19 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34321 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFDBMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 21:12:19 -0400
Received: by mail-wr1-f52.google.com with SMTP id q5so7620759wrm.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 18:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Nmbei4uA8OnM5XBv8Oex2cvYl5dxGhfryS+hmzH6uQ=;
        b=sw/EXgqQK+9JB757jV0Bl86mFSuc9R87pVlmZxM98MZWuny9oXwCDH6DZ6fP4Si0XD
         jxzufvOxjm4JEbkdQsGmkn5ppXetBjfhLoioO8y1q1BIjjZPLImTyCZFH0j/zdwno7og
         QA5pySvp5EydenrwQmvOJzvdH/CamqaTrGZoP5En9n5Z34ZqpqGUyciTtT5diNOhcVtl
         gDYD1l6qicT6yCGIo/en3/ST6DhxJAryOkFZkJcexg+qJQUsUpD0m7Da09l2GjhXyK6U
         VPjtWCR59dIXEQuo4/kkM4qVaZU002SnLCWGFsEtqAz+v9CCet3y/CHy2skBfFKmASg1
         OZOw==
X-Gm-Message-State: AOAM531iGvYu6qq6IYkR/zyiQ+qNAowsTgOEmpjmaWuFVTztP8u6VWGB
        RQnZZDoVNcUhXubsy7iRSC4=
X-Google-Smtp-Source: ABdhPJwpyjU0ByhzH0+Ayhn9pinRdxxxYK0WS5XDOiXwqyLkFWDdHKAvTsaQv7OUun+baYBHAONvEg==
X-Received: by 2002:adf:a353:: with SMTP id d19mr1057530wrb.363.1622769032915;
        Thu, 03 Jun 2021 18:10:32 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j7sm2355925wrm.93.2021.06.03.18.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:10:32 -0700 (PDT)
Date:   Fri, 4 Jun 2021 03:10:30 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override
 is not NULL
Message-ID: <20210604011030.GA414436@rocinante.localdomain>
References: <20210603000112.703037-6-kw@linux.com>
 <20210603232334.GA2153375@bjorn-Precision-5520>
 <20210603184759.45c51682.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210603184759.45c51682.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex and Bjorn,

[...]
> > This changes the attribute contents from "(null)" to an empty
> > (zero-length) file when no driver override has been set.
> > 
> > There are a few other driver_override_show() functions.  Most don't
> > check the pointer so they'll show "(null)".  One (spi.c) checks and
> > shows an empty string ("", file containing a single NULL character)
> > instead of an empty (zero-length) file.
> 
> Yeah, "(null)" was the expected output in this case.  It looks like
> this might break driverctl.  Thanks,
[...]

I had a look and it does, indeed, rely on explicitly checking whether
the value is "(null)", as per:

  https://gitlab.com/driverctl/driverctl/-/blob/master/driverctl#L96-131

I think, to avoid breaking this and other userspace tools that might
rely on this, we should drop this patch.

Having said that, I would love to be able to correct the behaviour we
have at the moment, but it seems that this ship has sail, so to speak.

	Krzysztof
