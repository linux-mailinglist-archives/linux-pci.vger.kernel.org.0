Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B88314389
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 00:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBHXMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 18:12:34 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41681 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBHXMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 18:12:32 -0500
Received: by mail-wr1-f44.google.com with SMTP id n6so6380398wrv.8;
        Mon, 08 Feb 2021 15:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bv0dTMtA9ppfQnSKtZdpg4E99WwWlpYYeDwveeo27y0=;
        b=LxDhnEcW8JWPlMYcFv7GH87onKgr1WqKMp5INUtY7U7zbwD1m09GasFSgnZIYbl8Vc
         yQ4QfJuI4+eznvMNeBlaLRMUTba8wOGkVd0GA28EyzssOTcy0dW7aA1/Wvbe8fvk+HBc
         1orxsvh08OC1kRlR4EeRW8EHyS1xIPUPQJSbjKjkcIgYQ+DSTInl2d3k2mYwe4GDSdgH
         gl+BH12WeaZ4M51VF0ZLLI/6J52Sl+Ru/jLBk6TepgKrIU0cGWTrxHkFryLKXlHn5iGh
         wPjznBo8nuVxfREuUhOooeb3xRhqd1XLdXuW10dy7gynuFuamquH7NvCqryDAX1K0g7n
         ihPA==
X-Gm-Message-State: AOAM533e22YuGfBJc/Vp7kzDgFH21OMHXfzNn2y/BmGTbBx4JgTSrEAa
        ybrebFDDn/yNfXA+PaQeGWgouJTjfsRCPJgi
X-Google-Smtp-Source: ABdhPJw6d4JBqgH/iMVqIVlgRbPTrlG64dTk/g4NiWLR01STGosEAkq245Tx8wPcoH9hNahYyOke9w==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr22702202wrv.1.1612825910658;
        Mon, 08 Feb 2021 15:11:50 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z63sm1255067wme.8.2021.02.08.15.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 15:11:50 -0800 (PST)
Date:   Tue, 9 Feb 2021 00:11:48 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 4/6] Documentation: misc-devices: Add Documentation
 for dw-xdata-pcie driver
Message-ID: <YCHFNKb5TcCYj5Uy@rocinante>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <2cc3a3a324d299a096f1d3e682b2039d3537b013.1612390291.git.gustavo.pimentel@synopsys.com>
 <YB8mwrhOZ2kPL3Oo@rocinante>
 <DM5PR12MB18357C5DF57458FD4ECA9E9BDA8F9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18357C5DF57458FD4ECA9E9BDA8F9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

[...]
> > When I do the following:
> > 
> >   # echo 1 > /sys/kernel/dw-xdata-pcie/write
> >   # echo 1 > /sys/kernel/dw-xdata-pcie/stop
> >   # cat /sys/kernel/dw-xdata-pcie/write
> > 
> > Would output from cat above simply show "0 MB/s" then?  I wonder how
> > someone using this new driver could tell whether "write" or "read"
> > traffic generation has been enabled aside of reading the sysfs files,
> > would adding "/sys/kernel/dw-xdata-pcie/active" be an overkill here?
> > 
> > What do you think?
> 
> Yes, it would display 0 MB/s. This driver is to be used mainly by the 
> Synopsys DesignWare HW prototyping team. I don't think the general public 
> will be interested or can use this driver, because requires a special HW 
> block available only for this prototype.

Got it.

> I tried to reduce to the minimal the interfaces, to avoid possible 
> confusion. For instance, even the /sys/kernel/dw-xdata-pcie/stop 
> interface could be avoided, because on the driver unloading or changing 
> the between write or read it calls the stop procedure.

Oh, OK.
 
> Due to the nature of the HW block, it only can allow the write or the 
> read at some given moment, therefore based on the last command enable 
> write or read, we know which mode is this driving working.
> This driver will be used by the testing team on their automation scripts, 
> thus they will know exactly the sequence input.
> 
> Anyway, thanks for your feedback.

Thank you for taking the time to add more details for me.  Much
appreciated.

Krzysztof
