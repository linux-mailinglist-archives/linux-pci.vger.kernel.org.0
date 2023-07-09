Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C637E74C457
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGIN11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGIN11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 09:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71301B3
        for <linux-pci@vger.kernel.org>; Sun,  9 Jul 2023 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688909196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saPUZom1S7Vq5poJ/JT7lclgtW5GwCJfHALTIcQlO6M=;
        b=VaufHE5yPOJyPSyL1mH7Gvy00IW6WSOi3yRa6c+20GDWjOOZ3U0nhS774bJY1mcbQr0TKn
        9rX601PquBr+nNUoX7Ee7rKO+WYpmWMG3WATal+1gdA0ovGcF96nQUkJk4QuJAktLupUb5
        0smE4wxzQXB+tc1t0uTcP3m6CBIT6u0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-sPfQMakQP1y75u6xe3RAZw-1; Sun, 09 Jul 2023 09:26:35 -0400
X-MC-Unique: sPfQMakQP1y75u6xe3RAZw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-345ceee5a68so12584495ab.3
        for <linux-pci@vger.kernel.org>; Sun, 09 Jul 2023 06:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688909194; x=1691501194;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saPUZom1S7Vq5poJ/JT7lclgtW5GwCJfHALTIcQlO6M=;
        b=fFJKoK4mt1ME0r+Tht3OiGabIx0kxrp3E6zv84d8qViVTCw1tO3yryxuHekjxUNxTd
         flI5BF0TXPgcXA1jBaGWClVLsACxBzPVQQRvgEQt5PgVofMhp1dZkCKGS9KE8TUoPrKZ
         ilRdf8Zh15MEegrqdAPMQkqrnYp+CPKTI5anYFcPPgyv2HpMJBgqi77dMmk9Md6WOm4p
         E+9i0a6WPcSJPwaI6rd/5SgQ35lsgReoamWCYGWabfpA21BULKIp5LIM6nPPzJGEOUPj
         DtSRlUI91ruerdnHamGw1xjZ5IYFQOibPU2i4dcI+MPuOOWfe70Xx1g5Etd2IbbfnujO
         0K4w==
X-Gm-Message-State: ABy/qLbEPRX9axkBFemaKKUPcZISdBwFn9CW6nXBQ1AsUHJMPLAy233q
        TvLzY95qkpTnve7UJxZWUFs7vy2cbf6nCeZ8U/6eoZjGncUtoHDsU5v9mYhkby5eLL0T6hzAkwl
        mVWuSGThCVHJoyu2zMINy
X-Received: by 2002:a6b:fb09:0:b0:783:31bf:7d8b with SMTP id h9-20020a6bfb09000000b0078331bf7d8bmr9730708iog.4.1688909194247;
        Sun, 09 Jul 2023 06:26:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFTCQi1N/cvDza7CRE0btiw06JUcKoaJmK+rRo1cRrC8EJ7hNFO1MGmLKR1u/z+2Wz+rVuqKQ==
X-Received: by 2002:a6b:fb09:0:b0:783:31bf:7d8b with SMTP id h9-20020a6bfb09000000b0078331bf7d8bmr9730699iog.4.1688909193993;
        Sun, 09 Jul 2023 06:26:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id em23-20020a0566384db700b0042b1dd89b0bsm2586233jab.155.2023.07.09.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 06:26:33 -0700 (PDT)
Date:   Sun, 9 Jul 2023 07:26:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VPD: Add runtime power management to sysfs
 interface
Message-ID: <20230709072632.30c09f1e.alex.williamson@redhat.com>
In-Reply-To: <08e455b0-31a6-b379-ba8b-b9a2c0962e22@redhat.com>
References: <20230707151044.1311544-1-alex.williamson@redhat.com>
        <08e455b0-31a6-b379-ba8b-b9a2c0962e22@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 9 Jul 2023 13:50:35 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Alex,
>=20
> On 7/7/23 17:10, Alex Williamson wrote:
> > Unlike default access to config space through sysfs, the vpd read and
> > write function don't actively manage the runtime power management state
> > of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
> > the unused device into low power state with runtime PM"), the vfio-pci
> > driver will use runtime power management and release unused devices to
> > make use of low power states.  Attempting to access VPD information in
> > this low power state can result in incorrect information or kernel
> > crashes depending on the system behavior.
> >
> > Wrap the vpd read/write bin attribute handlers in runtime PM and take
> > into account the potential quirk to select the correct device to wake. =
=20
>=20
> This much improved the situation as it is more difficult to hit the
> issue. Unfortunately after tens of attempts I was still able to hit a
> kernel crash. The console output does not mention the VPD anymore but
> PCI power management events (PME).

Does combining this with an extended D3hot wakeup for the device make
any difference, such as a5a6dd262469 ("PCI/PM: Extend D3hot delay for
NVIDIA HDA controllers")?  Thanks,

Alex

=20
> [=C2=A0 168.616700] CPU: 0 PID: 1409 Comm: kworker/0:5 Not tainted
> 6.4.0-vpd-upstream+ #56
> [=C2=A0 168.624257] Hardware name: GIGABYTE R181-T90-00/MT91-FS1-00, BIOS=
 F34
> 08/13/2020
> [=C2=A0 168.631639] Workqueue: events_freezable pci_pme_list_scan
> [=C2=A0 168.637032] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [=C2=A0 168.643982] pc : pci_generic_config_read+0x64/0xd8
> [=C2=A0 168.648763] lr : pci_generic_config_read+0x28/0xd8
> [=C2=A0 168.653542] sp : ffff80008caebcb0
> [=C2=A0 168.656844] x29: ffff80008caebcb0 x28: 0000000000000000 x27:
> 0000000000000000
> [=C2=A0 168.663969] x26: 0000000000000000 x25: 0000000000000000 x24:
> ffff80008caebd76
> [=C2=A0 168.671094] x23: ffff0008063fd800 x22: 0000000000000044 x21:
> ffff80008232d4c8
> [=C2=A0 168.678218] x20: ffff80008caebd24 x19: 0000000000000002 x18:
> 00000000000040fc
> [=C2=A0 168.685342] x17: 00000000000040f8 x16: 0000000000000000 x15:
> 0000000000000001
> [=C2=A0 168.692466] x14: ffffffffffffffff x13: 0000000000000000 x12:
> 0101010101010101
> [=C2=A0 168.699590] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 :
> ffff8000807b3938
> [=C2=A0 168.706714] x8 : fefefefefefefeff x7 : 0000000000000018 x6 :
> 000000000000007f
> [=C2=A0 168.713838] x5 : 0000000000000000 x4 : ffff800090000000 x3 :
> 0000000000000000
> [=C2=A0 168.720962] x2 : 0000000000000044 x1 : 0000000000c00044 x0 :
> ffff800090c00044
> [=C2=A0 168.728086] Call trace:
> [=C2=A0 168.730520]=C2=A0 pci_generic_config_read+0x64/0xd8
> [=C2=A0 168.734953]=C2=A0 pci_bus_read_config_word+0x84/0xe8
> [=C2=A0 168.739471]=C2=A0 pci_read_config_word+0x30/0x50
> [=C2=A0 168.743642]=C2=A0 pci_check_pme_status+0x70/0xa8
> [=C2=A0 168.747813]=C2=A0 pci_pme_list_scan+0x84/0x158
> [=C2=A0 168.751811]=C2=A0 process_one_work+0x1ec/0x488
> [=C2=A0 168.755810]=C2=A0 worker_thread+0x48/0x400
> [=C2=A0 168.759461]=C2=A0 kthread+0x10c/0x120
> [=C2=A0 168.762678]=C2=A0 ret_from_fork+0x10/0x20
> [=C2=A0 168.766245] Code: 52800000 a94153f3 a8c27bfd d65f03c0 (79400000)
> [=C2=A0 168.772326] ---[ end trace 0000000000000000 ]---
> [=C2=A0 168.776931] Kernel panic - not syncing: synchronous external abor=
t:
> Fatal exception
> [=C2=A0 168.784574] SMP: stopping secondary CPUs
> [=C2=A0 169.831001] SMP: failed to stop secondary CPUs 0,199
> [=C2=A0 169.835955] Kernel Offset: 0x190000 from 0xffff800080000000
>=20
>=20
> Thanks
>=20
> Eric
> >
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index a4fc4d0690fe..81217dd4789f 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct =
kobject *kobj,
> >  			size_t count)
> >  {
> >  	struct pci_dev *dev =3D to_pci_dev(kobj_to_dev(kobj));
> > +	struct pci_dev *vpd_dev =3D dev;
> > +	ssize_t ret;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> > +		vpd_dev =3D pci_get_func0_dev(dev);
> > +		if (!vpd_dev)
> > +			return -ENODEV;
> > +	}
> > +
> > +	pci_config_pm_runtime_get(vpd_dev);
> > +	ret =3D pci_read_vpd(vpd_dev, off, count, buf);
> > +	pci_config_pm_runtime_put(vpd_dev);
> > +
> > +	if (dev !=3D vpd_dev)
> > +		pci_dev_put(vpd_dev);
> > =20
> > -	return pci_read_vpd(dev, off, count, buf);
> > +	return ret;
> >  }
> > =20
> >  static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> > @@ -284,8 +299,23 @@ static ssize_t vpd_write(struct file *filp, struct=
 kobject *kobj,
> >  			 size_t count)
> >  {
> >  	struct pci_dev *dev =3D to_pci_dev(kobj_to_dev(kobj));
> > +	struct pci_dev *vpd_dev =3D dev;
> > +	ssize_t ret;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> > +		vpd_dev =3D pci_get_func0_dev(dev);
> > +		if (!vpd_dev)
> > +			return -ENODEV;
> > +	}
> > +
> > +	pci_config_pm_runtime_get(vpd_dev);
> > +	ret =3D pci_write_vpd(vpd_dev, off, count, buf);
> > +	pci_config_pm_runtime_put(vpd_dev);
> > +
> > +	if (dev !=3D vpd_dev)
> > +		pci_dev_put(vpd_dev);
> > =20
> > -	return pci_write_vpd(dev, off, count, buf);
> > +	return ret;
> >  }
> >  static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> >   =20
>=20

