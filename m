Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0396F4516F6
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbhKOV40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:56:26 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50873 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352023AbhKOVxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 16:53:47 -0500
Received: by mail-wm1-f46.google.com with SMTP id 133so15233208wme.0;
        Mon, 15 Nov 2021 13:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zpo2FcY0JFle+1sWMVU6xVo7WBKafm0rx46PVS7H5Og=;
        b=p1H5TsPszo6J0RWUpcwlqL2joGIRol38ZJPQ/mGnJLTHAqYX7XWW8+DLff+CAaK8he
         ap5bQTYPdw5i8DzsY92gMEoPmu0K4sdQOy7zvmiX8lkI97QrKgwb77XtKT0AsVQF+c+c
         rGgvTU/f5UkPCq4l1ljjJ+jo5WrgRadfytV7iPuKCAUcWXz2GcCwCGDgqGgOMzzQy/D/
         I22rszVBHDJS7XrzbaXhtF5xTvrFTT05KvVHA5QHeSO7MktXxGEqw/3QMAUA3zSC9ETV
         qeT8nkYDKnh5r6Y+KpFBBZtg9YuN0CSNIcJLmgDUz1TFyVnet1Ilwbj5EPgTIFq86kIU
         IwNA==
X-Gm-Message-State: AOAM5300WNFfUZvKA1Ro4q6Hxtgg43KbYVGEV1Djb5B1EvCToKNm8OZg
        1yS5oScHw5OPMNhwTVLVHAE=
X-Google-Smtp-Source: ABdhPJww7K1XBBi0PWxrQOFVuk8+zAGeety4qxeCcVFbci3CpQiU5u5cW5CXl2Fvmnjj75pJDUzBmA==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr15075288wmk.77.1637013050094;
        Mon, 15 Nov 2021 13:50:50 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q84sm887283wme.3.2021.11.15.13.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:50:49 -0800 (PST)
Date:   Mon, 15 Nov 2021 22:50:48 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()'
 definition
Message-ID: <YZLWOFGFs4g6gh5l@rocinante>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
 <20211115070809.15529-5-sergio.paracuellos@gmail.com>
 <YZJWM33dXqW1BsuV@rocinante>
 <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

[...]
> > >  builtin_platform_driver(mt7621_pci_driver);
> > > +
> > > +MODULE_LICENSE("GPL v2");
> >
> > A question here about the builtin_platform_driver() use in this driver,
> > especially since it's set as tristate in Kconfig, thus I am not sure if
> > using builtin_platform_driver() over module_platform_driver() is correct?
> >
> > Unless this is more because you need to reply on device_initcall() for the
> > driver to properly initialise?
> 
> builtin_platform_driver() does the right thing for loadable modules that
> have no module-unload and are not intended to be removable.
> 
> This is often use for PCI drivers, but after Rob reworked this code a while
> back, it should actually be possible to reliably remove and reload PCI
> host bridge drivers, and it would be good to eventually lift the restriction
> here as well.

Thank you for letting me know.  Much appreciated.  I assumed in the past
that with tristate in Kconfig the module_platform_driver() would be the
preferred route.

	Krzysztof
