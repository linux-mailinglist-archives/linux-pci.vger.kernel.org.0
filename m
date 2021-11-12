Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273F344EAD9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 16:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhKLPxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKLPxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 10:53:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88AFC061766
        for <linux-pci@vger.kernel.org>; Fri, 12 Nov 2021 07:50:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso7930041pjb.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Nov 2021 07:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DCWZZt+29iFq2clUVEkIce4UIy65VvnoQe1jb6uOUjo=;
        b=s3tIWZxUjkAzG2iHdwY5MaTFz6pETE8M5QNPQtxRDnwPZZStrdJbgL5xZhc3p+pm5+
         ecKt3OK4SgDW4osKrjZmk5K/cY6aF7qe/wKSPckTJn24DQzRRLr6C/eXXk79QitU+yUJ
         1S3YpZ65ebX4/S1Ss4nBma7YJyuoZoerwjAQazbMpijLvgBqjchfOxo1XBSwxqeOgmb3
         xveNsWvXM1VXUHQ5BF3wMK92IyynQtyW3BoWkPi1DadDiyRJFDFuPA6Ox7QNN++zmhqM
         N7KRJAhT/ypNEyM+/XfXenMlO21Y+k7fNKsBrvncD6onZlQ8YFNXAgLn7nrSssc4I6CV
         ItrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DCWZZt+29iFq2clUVEkIce4UIy65VvnoQe1jb6uOUjo=;
        b=1/DVfU4iuJ0JYfBT/gmHNO14ztvMXDE/ieCA0ig/m2T3lgE2+S86b2J3cuYkMVzypO
         Nbs8m3GmqqCMAhTZbUfTil6FzwEEewssjPDiUm5q2gmNHNcekOn/YQYzn4RS0Nhfuf6h
         9vHN3OFqkywPf5gVR5l9yv/ZTmTU+Fe21sLiFPWzUJ1qFsKFGk35LHq22bufVKxWVUEN
         QgoXfK1oThxiAFSjXVy2tpK9Ho+FSBO8w5cBLEJ0f2L99a7HPfGFGWkBfbrIvWQAn9C7
         KVkMQIkU+A4qQDfBU+40iXyV5UjEjyXCzTp4zb+bMVbsSHeT5dz1TGmYC7wsSgPcjyc5
         negw==
X-Gm-Message-State: AOAM532Xxn4LBb4Ym7Y3wuh/OvVFS4uL5B8Vgvki+n7/z9CXYUiXrsrr
        AArJjpFK+TZhGKKV+WSc107A84GHOD7JAjyg5X7I1A==
X-Google-Smtp-Source: ABdhPJyLQjmAuJV19dGU8dwQFSbUGrttSxZgJaKAfKRU3NSJPMufAX/Kfs8BaSxcXhL9tkbUo6k7bRuj0WdLhxM6ers=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr18540492pjb.93.1636732239274;
 Fri, 12 Nov 2021 07:50:39 -0800 (PST)
MIME-Version: 1.0
References: <202111121836.Oiqcphv0-lkp@intel.com> <YY5v0wzW192k1fG+@rocinante>
In-Reply-To: <YY5v0wzW192k1fG+@rocinante>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Nov 2021 07:50:27 -0800
Message-ID: <CAPcyv4g403nTri81CFYBdnw7E9mno94zE9ntEsafs6_QRuxGJA@mail.gmail.com>
Subject: Re: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/guest.c:34:29:
 sparse: sparse: incorrect type in assignment (different modifiers)
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 5:45 AM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> [+CC Adding Jonathan, Dan, Frederic and Andrew for visibility]

Note that drivers/misc/cxl/ !=3D drivers/cxl/

The former is CAPI Accelerator Link (?), and the latter is Compute Express =
Link.

>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git=
 pci/driver
> > head:   0508b6f72f055b88df518db4f3811bda9bb35da4
> > commit: 115c9d41e58388415f4956d0a988c90fb48663b9 [17/24] cxl: Factor ou=
t common dev->driver expressions
> > config: powerpc64-randconfig-s032-20211025 (attached as .config)
> > compiler: powerpc64-linux-gcc (GCC) 11.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-dirty
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.g=
it/commit/?id=3D115c9d41e58388415f4956d0a988c90fb48663b9
> >         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux=
/kernel/git/helgaas/pci.git
> >         git fetch --no-tags helgaas-pci pci/driver
> >         git checkout 115c9d41e58388415f4956d0a988c90fb48663b9
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.c=
ross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dpowerpc64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/misc/cxl/guest.c:34:29: sparse: sparse: incorrect type in as=
signment (different modifiers) @@     expected struct pci_error_handlers *e=
rr_handler @@     got struct pci_error_handlers const *err_handler @@
> >    drivers/misc/cxl/guest.c:34:29: sparse:     expected struct pci_erro=
r_handlers *err_handler
> >    drivers/misc/cxl/guest.c:34:29: sparse:     got struct pci_error_han=
dlers const *err_handler
> >    drivers/misc/cxl/guest.c:108:33: sparse: sparse: incorrect type in a=
ssignment (different base types) @@     expected unsigned long long [userty=
pe] phys_addr @@     got restricted __be64 [usertype] @@
> >    drivers/misc/cxl/guest.c:108:33: sparse:     expected unsigned long =
long [usertype] phys_addr
> >    drivers/misc/cxl/guest.c:108:33: sparse:     got restricted __be64 [=
usertype]
> >    drivers/misc/cxl/guest.c:109:27: sparse: sparse: incorrect type in a=
ssignment (different base types) @@     expected unsigned long long [userty=
pe] len @@     got restricted __be64 [usertype] @@
> >    drivers/misc/cxl/guest.c:109:27: sparse:     expected unsigned long =
long [usertype] len
> >    drivers/misc/cxl/guest.c:109:27: sparse:     got restricted __be64 [=
usertype]
> >    drivers/misc/cxl/guest.c:111:35: sparse: sparse: incorrect type in a=
ssignment (different base types) @@     expected unsigned long long [userty=
pe] len @@     got restricted __be64 [usertype] @@
> >    drivers/misc/cxl/guest.c:111:35: sparse:     expected unsigned long =
long [usertype] len
> >    drivers/misc/cxl/guest.c:111:35: sparse:     got restricted __be64 [=
usertype]
> >    drivers/misc/cxl/guest.c:443:33: sparse: sparse: incorrect type in a=
rgument 1 (different address spaces) @@     expected unsigned short const v=
olatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usert=
ype] * @@
> >    drivers/misc/cxl/guest.c:443:33: sparse:     expected unsigned short=
 const volatile [noderef] [usertype] __iomem *addr
> >    drivers/misc/cxl/guest.c:443:33: sparse:     got unsigned short [use=
rtype] *
> >    drivers/misc/cxl/guest.c:446:33: sparse: sparse: incorrect type in a=
rgument 1 (different address spaces) @@     expected unsigned int const vol=
atile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
> >    drivers/misc/cxl/guest.c:446:33: sparse:     expected unsigned int c=
onst volatile [noderef] [usertype] __iomem *addr
> >    drivers/misc/cxl/guest.c:446:33: sparse:     got unsigned int *
> >    drivers/misc/cxl/guest.c:449:33: sparse: sparse: incorrect type in a=
rgument 1 (different address spaces) @@     expected unsigned long long con=
st volatile [noderef] [usertype] __iomem *addr @@     got unsigned long lon=
g [usertype] * @@
> >    drivers/misc/cxl/guest.c:449:33: sparse:     expected unsigned long =
long const volatile [noderef] [usertype] __iomem *addr
> >    drivers/misc/cxl/guest.c:449:33: sparse:     got unsigned long long =
[usertype] *
> >    drivers/misc/cxl/guest.c:537:23: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:537:23: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:537:23: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:538:23: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:538:23: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:538:23: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:540:31: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:540:31: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:540:31: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:543:23: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:543:23: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:543:23: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:544:23: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:544:23: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:544:23: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:546:31: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:546:31: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:546:31: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:549:31: sparse: sparse: invalid assignment:=
 |=3D
> >    drivers/misc/cxl/guest.c:549:31: sparse:    left side has type restr=
icted __be64
> >    drivers/misc/cxl/guest.c:549:31: sparse:    right side has type unsi=
gned long long
> >    drivers/misc/cxl/guest.c:552:31: sparse: sparse: cast from restricte=
d __be64
> > --
> > >> drivers/misc/cxl/pci.c:1816:29: sparse: sparse: incorrect type in as=
signment (different modifiers) @@     expected struct pci_error_handlers *e=
rr_handler @@     got struct pci_error_handlers const *err_handler @@
> >    drivers/misc/cxl/pci.c:1816:29: sparse:     expected struct pci_erro=
r_handlers *err_handler
> >    drivers/misc/cxl/pci.c:1816:29: sparse:     got struct pci_error_han=
dlers const *err_handler
> >    drivers/misc/cxl/pci.c:2041:37: sparse: sparse: incorrect type in as=
signment (different modifiers) @@     expected struct pci_error_handlers *e=
rr_handler @@     got struct pci_error_handlers const *err_handler @@
> >    drivers/misc/cxl/pci.c:2041:37: sparse:     expected struct pci_erro=
r_handlers *err_handler
> >    drivers/misc/cxl/pci.c:2041:37: sparse:     got struct pci_error_han=
dlers const *err_handler
> >    drivers/misc/cxl/pci.c:2090:37: sparse: sparse: incorrect type in as=
signment (different modifiers) @@     expected struct pci_error_handlers *e=
rr_handler @@     got struct pci_error_handlers const *err_handler @@
> >    drivers/misc/cxl/pci.c:2090:37: sparse:     expected struct pci_erro=
r_handlers *err_handler
> >    drivers/misc/cxl/pci.c:2090:37: sparse:     got struct pci_error_han=
dlers const *err_handler
> >
> > vim +34 drivers/misc/cxl/guest.c
> >
> >     17
> >     18        static void pci_error_handlers(struct cxl_afu *afu,
> >     19                                        int bus_error_event,
> >     20                                        pci_channel_state_t state=
)
> >     21        {
> >     22                struct pci_dev *afu_dev;
> >     23                struct pci_driver *afu_drv;
> >     24                struct pci_error_handlers *err_handler;
> >     25
> >     26                if (afu->phb =3D=3D NULL)
> >     27                        return;
> >     28
> >     29                list_for_each_entry(afu_dev, &afu->phb->bus->devi=
ces, bus_list) {
> >     30                        afu_drv =3D afu_dev->driver;
> >     31                        if (!afu_drv)
> >     32                                continue;
> >     33
> >   > 34                        err_handler =3D afu_drv->err_handler;
> >     35                        switch (bus_error_event) {
> >     36                        case CXL_ERROR_DETECTED_EVENT:
> >     37                                afu_dev->error_state =3D state;
> >     38
> >     39                                if (err_handler &&
> >     40                                    err_handler->error_detected)
> >     41                                        err_handler->error_detect=
ed(afu_dev, state);
> >     42                                break;
> >     43                        case CXL_SLOT_RESET_EVENT:
> >     44                                afu_dev->error_state =3D state;
> >     45
> >     46                                if (err_handler &&
> >     47                                    err_handler->slot_reset)
> >     48                                        err_handler->slot_reset(a=
fu_dev);
> >     49                                break;
> >     50                        case CXL_RESUME_EVENT:
> >     51                                if (err_handler &&
> >     52                                    err_handler->resume)
> >     53                                        err_handler->resume(afu_d=
ev);
> >     54                                break;
> >     55                        }
> >     56                }
> >     57        }
> >     58
>
>         Krzysztof
