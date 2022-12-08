Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5A6474FA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 18:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLHR00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 12:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLHR0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 12:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D05537CE
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670520331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E71Bhw/FO0T2S1rVc4Z9xmEAUXbwHIkJXUEVUPOidwc=;
        b=RrXzT75OA8Q9jKRJmvsy6dbhXbNyn5T2CekrH9VPdPMltCTQ2+GPsjzesJHjVzZdi8/Oeh
        txOGxj4a+yvlOEiji8WREN1ayUe+OW1KkfOrZlhreq+rnUs9EWymZZCQk6NQiW6xbE5f4W
        dpk3riu1Tt7Dwp4SjypHRiZ6trcrWpk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-aefAy-j6Np27PYz6wHzBvg-1; Thu, 08 Dec 2022 12:25:29 -0500
X-MC-Unique: aefAy-j6Np27PYz6wHzBvg-1
Received: by mail-il1-f199.google.com with SMTP id z10-20020a921a4a000000b0030349fa9653so1937057ill.7
        for <linux-pci@vger.kernel.org>; Thu, 08 Dec 2022 09:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E71Bhw/FO0T2S1rVc4Z9xmEAUXbwHIkJXUEVUPOidwc=;
        b=hkbQ6O8iJEt6MAt/qAR2mRfSqxnC5+y/16+H8ZGUASasVLoqrkgelYyEomtTsl2DMe
         9Eao/S7bYzInj+7CR6i0AP9jwD1r1Us+jUtR6Aqwo+yrxKR8xMMWAYu4CgPX4+jbSfs9
         822wcgyId8KnRC4TmckTNvfd2chLmrCKgMNJHv2WWotKwbW/3e8k5wQuEY3cD213a+3b
         Z0cT4+vaLktPTpTL4V1yiZA5kXY70/rHdDZAClqVQbDEqzHag3fAsTIIlFFtngYSinrY
         yajEsz8+CLtOtoEAUtJM8hzheGZ8sh+5SlLpLTeFqMT7sMNeMB/1QddVDCSKtwppa8lU
         /vyQ==
X-Gm-Message-State: ANoB5pm7A9gBKPm6k1jOSwunYiL8qqPAni/QQHCfXaIzblR7+tkGMkfv
        jufiVa3+JyiRO0cX4dPev0SuVns2+dhlHk0QONgqU8rFJMHo10aTsKxb9LQOugnGN930e+BksZP
        cEcqs0FGBAZnl/JtVmNmI
X-Received: by 2002:a05:6602:2495:b0:6ca:d145:93 with SMTP id g21-20020a056602249500b006cad1450093mr36674283ioe.71.1670520329047;
        Thu, 08 Dec 2022 09:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6NWsKoYU+tBxwYj4F/NAmzAmG9ziUTJ4tCCB5/cJ6F7yZO1Fy5Ia8MSW1AfE9ico+pnmEefQ==
X-Received: by 2002:a05:6602:2495:b0:6ca:d145:93 with SMTP id g21-20020a056602249500b006cad1450093mr36674274ioe.71.1670520328816;
        Thu, 08 Dec 2022 09:25:28 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b30-20020a026f5e000000b0038a590b8cb4sm3170383jae.179.2022.12.08.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 09:25:28 -0800 (PST)
Date:   Thu, 8 Dec 2022 10:25:27 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Major Saheb <majosaheb@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: vfio-pci rejects binding to devices having same pcie vendor id
 and device id
Message-ID: <20221208102527.33917ff9.alex.williamson@redhat.com>
In-Reply-To: <20221208165008.GA1547952@bhelgaas>
References: <CANBBZXPWe56VYJtzXdimEnkFgF+A=G15TXrd8Z5kBcUOGgHeRw@mail.gmail.com>
        <20221208165008.GA1547952@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Dec 2022 10:50:08 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc VFIO folks and Zhenzhong (author of the commit you mention)]
> 
> On Thu, Dec 08, 2022 at 09:24:31PM +0530, Major Saheb wrote:
> > I have a linux system running in kvm, with 6 qemu emulated NVMe
> > drives, as expected all of them have the same PCIe Vendor ID and
> > Device ID(VID: 0x1b36 DID: 0x0010).
> >
> > When I try to unbind them from the kernel NVMe driver and bind it to
> > vfio-pci one by one, I am getting "write error: File exists" when I
> > try to bind the 2nd(and other) drive to vfio-pci.
> > 
> > Kernel version
> > 
> > 5.15.0-56-generic #62-Ubuntu SMP Tue Nov 22 19:54:14 UTC 2022 x86_64
> > x86_64 x86_64 GNU/Linux
> > 
> > lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme0n1 -> ../devices/pci0000:00/0000:00:03.0/nvme/nvme0/nvme0n1
> > lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme1n1 -> ../devices/pci0000:00/0000:00:04.0/nvme/nvme1/nvme1n1
> > lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme2n1 -> ../devices/pci0000:00/0000:00:05.0/nvme/nvme2/nvme2n1
> > lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme3n1 -> ../devices/pci0000:00/0000:00:06.0/nvme/nvme3/nvme3n1
> > lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme4n1 -> ../devices/pci0000:00/0000:00:07.0/nvme/nvme4/nvme4n1
> > lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme5n1 -> ../devices/pci0000:00/0000:00:08.0/nvme/nvme5/nvme5n1
> > 
> > Steps for repro
> > ubind nvme2 from kernel NVMe driver and bind it to vfio
> > $ ls -l /sys/bus/pci/drivers/vfio-pci/
> > lrwxrwxrwx 1 root root    0 Dec  8 13:04 0000:00:05.0 -> ../../../../devices/pci0000:00/0000:00:05.0
> > --w------- 1 root root 4096 Dec  8 13:07 bind
> > lrwxrwxrwx 1 root root    0 Dec  8 13:07 module -> ../../../../module/vfio_pci
> > --w------- 1 root root 4096 Dec  8 13:04 new_id
> > --w------- 1 root root 4096 Dec  8 13:07 remove_id
> > --w------- 1 root root 4096 Dec  8 11:32 uevent
> > --w------- 1 root root 4096 Dec  8 13:07 unbind
> > 
> > Unbind nvme3 from  kernel NVMe driver
> > Try binding to vfio-pci
> > # echo "0x1b36  0x0010" >  /sys/bus/pci/drivers/vfio-pci/new_id
> > -bash: echo: write error: File exists

Presumably you already wrote this same ID to the dynamic ID table from
the first device, so yes, it's going to rightfully complain that this
ID already exists.  The new_id interface has numerous problems, which
is why we added the driver_override interface, which is used by tools
like libvirt and driverctl in place of this old interface.

I'd recommend something like:

# driverctl --nosave set-override 0000:00:03.0 vfio-pci
# driverctl --nosave set-override 0000:00:04.0 vfio-pci
# driverctl --nosave set-override 0000:00:05.0 vfio-pci
...

Or if vfio-pci is generally the preferred driver for these devices, you
could remove the --nosave option to have them automatically bound at
boot.  You could also make use of pre-filling the vfio device table
using vfio-pci.ids=1b36:0010 on the kernel command line and making sure
the vfio-pci driver is loaded before the nvme driver.  In general, for
dynamic binding of devices, driver_override is the recommended solution.
Thanks,

Alex

