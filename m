Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5B109444
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKYTdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 14:33:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42103 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYTde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 14:33:34 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so17578572ioa.9;
        Mon, 25 Nov 2019 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mFQ2uM8eUtm7aXuPr+Kb3DaM5rrKzlYcHWCzrXEycX0=;
        b=Zw9j86qFuPevjYi0ihc8XvzGHrD05DrfER6842rNQNqpxSuA8WqWsmuCbfItCVN93N
         Nh9NVIP9heq2SLfFzagLEH27KEVfl1FGH+pCCp+s9zV5bM3O+BVMni2NcHJuWHIleijj
         yvOBRgIgewRvZ0yLcT4M+E4yAVy/e+VSnptinkxauv3B3Bymagp9815LqiAtV2QZDZNL
         e2ry5DYsvdLRuYxw7wIX6mob0SOy5eSAKcIBy4WWPBpF9E7EhSpZ+hEkI7DKCAJR688z
         GzPZ3UDfzENjrnlHHexFALiDHRADU+1JmPTR0uygNv0SWqVKM60yW0T+FM9E38Fxc13p
         29eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mFQ2uM8eUtm7aXuPr+Kb3DaM5rrKzlYcHWCzrXEycX0=;
        b=LwM/AU0T4L0At0kc7AiKzstsR1pvwKnnaxFpAbA0v/jafSn70uQeqz/6ZFJNvNzWZX
         ffyd8ttLLyUYHD57rpUCxxu3Yn2z6gtl8wPuxXY16zroBtblRKytBEDpm8FogoIi6BzF
         786TWavi0xSpHnS7swCzn1GdK4LMuCvGZePLmj02jDIOXeze6svLFhuuHTXoWnfarqdJ
         nRJ3Skb+kpUp4DZk9Um74/WiVNtzdWPa5fIoMbcdPNvw8Dkvl+FYoqAlpy+yAGK/ZeHW
         bTtH4CbO9hbfFS8bXPDjRE0eip78r2vOnkqWT/Arb5VGcCqgiQgKDc9Te7HKrQC5Wv+9
         0q/A==
X-Gm-Message-State: APjAAAW7qFvNyZz2ILIGDDWgYek4zXXZEuboDds2SFXn7eOx0Eum1Fc0
        RQNGkkTJHFGzwUuirRJERz1rtn1/f5FTYlSuBIU=
X-Google-Smtp-Source: APXvYqxUu2A01pKxdFcqtyts2vqbYHzTEz9tI2Gc3rEcG2oSUiUAKLBByPJCDzcVFNZtjIKoDD7Of8sHhGV5LSDk6io=
X-Received: by 2002:a6b:8d09:: with SMTP id p9mr28965302iod.227.1574710413296;
 Mon, 25 Nov 2019 11:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20191122193138.19278-1-navid.emamdoost@gmail.com> <20191125180448.GA39139@ubuntu-x2-xlarge-x86>
In-Reply-To: <20191125180448.GA39139@ubuntu-x2-xlarge-x86>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 25 Nov 2019 13:33:21 -0600
Message-ID: <CAEkB2EQP-bMOcF0MmrtaV4dYrrMxyjMj+y3vgdaKJafeEW9ypw@mail.gmail.com>
Subject: Re: [PATCH] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nathan,

On Mon, Nov 25, 2019 at 12:04 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Nov 22, 2019 at 01:31:36PM -0600, Navid Emamdoost wrote:
> > In the implementation of pci_iov_add_virtfn() the allocated virtfn is
> > leaked if pci_setup_device() fails. The error handling is not calling
> > pci_stop_and_remove_bus_device(). Change the goto label to failed2.
> >
> > Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_=
iov_add_virtfn()")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/pci/iov.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index b3f972e8cfed..713660482feb 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -164,7 +164,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> >
> >       rc =3D pci_setup_device(virtfn);
> >       if (rc)
> > -             goto failed1;
> > +             goto failed2;
> >
> >       virtfn->dev.parent =3D dev->dev.parent;
> >       virtfn->multifunction =3D 0;
> > --
> > 2.17.1
> >
>
> Hi Navid,
>
> This patch causes a Clang warning about failed1 no longer being a used
> label, as shown by this 0day build report. Would you please look into it
> and address it in the same patch so there is not a warning regression?
>

Sure I will prepare a v2.

> Cheers,
> Nathan
>
> On Mon, Nov 25, 2019 at 07:20:46AM +0800, kbuild test robot wrote:
> > CC: kbuild-all@lists.01.org
> > In-Reply-To: <20191122193138.19278-1-navid.emamdoost@gmail.com>
> > References: <20191122193138.19278-1-navid.emamdoost@gmail.com>
> > TO: Navid Emamdoost <navid.emamdoost@gmail.com>
> > CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, lin=
ux-kernel@vger.kernel.org, emamd001@umn.edu, Navid Emamdoost <navid.emamdoo=
st@gmail.com>, emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com=
>
> > CC: emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
> >
> > Hi Navid,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on pci/next]
> > [also build test WARNING on v5.4-rc8 next-20191122]
> > [if your patch is applied to the wrong git tree, please drop us a note =
to help
> > improve the system. BTW, we also suggest to use '--base' option to spec=
ify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/3=
7406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Navid-Emamdoost/PCI-IO=
V-Fix-memory-leak-in-pci_iov_add_virtfn/20191125-020946
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git=
 next
> > config: arm64-defconfig (attached as .config)
> > compiler: clang version 10.0.0 (git://gitmirror/llvm_project 844d97f650=
a2d716e63e3be903c32a82f2f817b1)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=3Darm64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/pci/iov.c:204:1: warning: unused label 'failed1' [-Wunused-l=
abel]
> >    failed1:
> >    ^~~~~~~~
> >    1 warning generated.
> >
> > vim +/failed1 +204 drivers/pci/iov.c
> >
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  135
> > 753f612471819d3 Jan H. Sch=C3=B6nherr 2017-09-26  136  int pci_iov_add_=
virtfn(struct pci_dev *dev, int id)
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  137  {
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  138      int i;
> > dc087f2f6a2925e Jiang Liu        2013-05-25  139      int rc =3D -ENOME=
M;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  140      u64 size;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  141      char buf[VIRTFN_I=
D_LEN];
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  142      struct pci_dev *v=
irtfn;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  143      struct resource *=
res;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  144      struct pci_sriov =
*iov =3D dev->sriov;
> > 8b1fce04dc2a221 Gu Zheng         2013-05-25  145      struct pci_bus *b=
us;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  146
> > b07579c0924eee1 Wei Yang         2015-03-25  147      bus =3D virtfn_ad=
d_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
> > dc087f2f6a2925e Jiang Liu        2013-05-25  148      if (!bus)
> > dc087f2f6a2925e Jiang Liu        2013-05-25  149              goto fail=
ed;
> > dc087f2f6a2925e Jiang Liu        2013-05-25  150
> > dc087f2f6a2925e Jiang Liu        2013-05-25  151      virtfn =3D pci_al=
loc_dev(bus);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  152      if (!virtfn)
> > dc087f2f6a2925e Jiang Liu        2013-05-25  153              goto fail=
ed0;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  154
> > b07579c0924eee1 Wei Yang         2015-03-25  155      virtfn->devfn =3D=
 pci_iov_virtfn_devfn(dev, id);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  156      virtfn->vendor =
=3D dev->vendor;
> > 3142d832af10d8c Filippo Sironi   2017-08-28  157      virtfn->device =
=3D iov->vf_device;
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  158      virtfn->is_virtfn=
 =3D 1;
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  159      virtfn->physfn =
=3D pci_dev_get(dev);
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  160
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  161      if (id =3D=3D 0)
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  162              pci_read_=
vf_config_common(virtfn);
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  163
> > 156c55325d30261 Po Liu           2016-08-29  164      rc =3D pci_setup_=
device(virtfn);
> > 156c55325d30261 Po Liu           2016-08-29  165      if (rc)
> > 59fb9307eee20d6 Navid Emamdoost  2019-11-22  166              goto fail=
ed2;
> > 156c55325d30261 Po Liu           2016-08-29  167
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  168      virtfn->dev.paren=
t =3D dev->dev.parent;
> > aa9319773619c9d Alex Williamson  2014-01-09  169      virtfn->multifunc=
tion =3D 0;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  170
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  171      for (i =3D 0; i <=
 PCI_SRIOV_NUM_BARS; i++) {
> > c1fe1f96e30d31c Bjorn Helgaas    2015-03-25  172              res =3D &=
dev->resource[i + PCI_IOV_RESOURCES];
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  173              if (!res-=
>parent)
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  174                      c=
ontinue;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  175              virtfn->r=
esource[i].name =3D pci_name(virtfn);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  176              virtfn->r=
esource[i].flags =3D res->flags;
> > 0e6c9122a6ec96d Wei Yang         2015-03-25  177              size =3D =
pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  178              virtfn->r=
esource[i].start =3D res->start + size * id;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  179              virtfn->r=
esource[i].end =3D virtfn->resource[i].start + size - 1;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  180              rc =3D re=
quest_resource(res, &virtfn->resource[i]);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  181              BUG_ON(rc=
);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  182      }
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  183
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  184      pci_device_add(vi=
rtfn, virtfn->bus);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  185
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  186      sprintf(buf, "vir=
tfn%u", id);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  187      rc =3D sysfs_crea=
te_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  188      if (rc)
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  189              goto fail=
ed2;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  190      rc =3D sysfs_crea=
te_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  191      if (rc)
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  192              goto fail=
ed3;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  193
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  194      kobject_uevent(&v=
irtfn->dev.kobj, KOBJ_CHANGE);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  195
> > 27d6162944b9b34 Stuart Hayes     2017-10-04  196      pci_bus_add_devic=
e(virtfn);
> > 27d6162944b9b34 Stuart Hayes     2017-10-04  197
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  198      return 0;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  199
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  200  failed3:
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  201      sysfs_remove_link=
(&dev->dev.kobj, buf);
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  202  failed2:
> > cf0921bea66c556 KarimAllah Ahmed 2018-03-19  203      pci_stop_and_remo=
ve_bus_device(virtfn);
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20 @204  failed1:
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  205      pci_dev_put(dev);
> > dc087f2f6a2925e Jiang Liu        2013-05-25  206  failed0:
> > dc087f2f6a2925e Jiang Liu        2013-05-25  207      virtfn_remove_bus=
(dev->bus, bus);
> > dc087f2f6a2925e Jiang Liu        2013-05-25  208  failed:
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  209
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  210      return rc;
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  211  }
> > dd7cc44d0bcec5e Yu Zhao          2009-03-20  212
> >
> > :::::: The code at line 204 was first introduced by commit
> > :::::: dd7cc44d0bcec5e9c42fe52e88dc254ae62eac8d PCI: add SR-IOV API for=
 Physical Function driver
> >
> > :::::: TO: Yu Zhao <yu.zhao@intel.com>
> > :::::: CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> >
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology=
 Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corp=
oration



--=20
Navid.
