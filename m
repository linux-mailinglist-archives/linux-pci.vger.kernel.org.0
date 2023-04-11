Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE356DD2C6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDKG33 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKG32 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 02:29:28 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C51BCA;
        Mon, 10 Apr 2023 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1681194566; x=1712730566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDPwvbZddsMQqHiFbjq6MhSDUHWhKCccQrR4GgDJL9A=;
  b=IUVav+FTYt6yTcJpHvNgwxz3U7hYwZ0Ivj24jdplZAKL2IM6+9QNOKD9
   lPfCAv8nRnNxNGTlx/P3yEInNI0iVZq2iFp8pepmeBeZh/bkQpYK3a6d9
   izOVR57tMmveANufq+L6B1wcexS4KQTNg/ZH92nCNfNNuuYV5vXauBzmg
   qfWEwx23Y0H0nd9djByScpNFvyTiL2ix+APxtDtDKBxTfyQGNFdiYyG2F
   z5xE5aaUT4kICFuNrxL5zT6lqWTbXXsvFlKeVcZb4afuyjrWpVqOeyUOf
   YymlqDg7qY1WUpyrJtyAA1fy7fwDiIyZpmFBSp7WyCc+nNstCOOPEFx0E
   w==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="30235337"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Apr 2023 08:29:21 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 11 Apr 2023 08:29:21 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 11 Apr 2023 08:29:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1681194561; x=1712730561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDPwvbZddsMQqHiFbjq6MhSDUHWhKCccQrR4GgDJL9A=;
  b=MKP7mP9j3lvPDbEFgdh3ydxjFdgmfegYPcmjZQueYvCuqTNMbPz2vpMr
   dWzyz2U43nti1Sx75NqJnWuBVtoTI8Xbx0/u1WunXx48vDkFPLQAiW5MN
   Ax0bqJNhTITfdb9ibTdrT3EiZWqTLiogPgXJalvc1jt6/MWpEV+7KwN/i
   ZYwUMUSnLYNEs97VdoWc7LtpxJ88cUYxdzZbiFaB2yyc7+g4qXyoYFZAI
   jcTYKOw2/a3RllA0clzkW4hi7rSLkTxS7f68f+UsoT9L2toxL+4dsUr0T
   tIIqhuJ0jP67/lTCFuU7+OAmMwmMKCK2SlcYIotXnOj3jNBdnj426CsJP
   A==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="30235336"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Apr 2023 08:29:21 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3F737280056;
        Tue, 11 Apr 2023 08:29:21 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "You-Sheng Yang (vicamo)" <vicamo.yang@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>
Subject: Re: [PATCH] PCI: vmd: guard device addition and removal
Date:   Tue, 11 Apr 2023 08:29:20 +0200
Message-ID: <5930238.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230407235829.GA3834716@bhelgaas>
References: <20230407235829.GA3834716@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Samstag, 8. April 2023, 01:58:29 CEST schrieb Bjorn Helgaas:
> [+cc Korneliusz, Alexander]
>=20
> On Tue, Mar 14, 2023 at 01:37:33AM +0800, You-Sheng Yang (vicamo) wrote:
> > VMD may fail to create sysfs entries while `pci_rescan_bus()` called in
> >=20
> > some other drivers like t7xx wwan driver:
> >   sysfs: cannot create duplicate filename '/devices/.../resource0'
> >  =20
> >   Call Trace:
> >    <TASK>
> >    sysfs_warn_dup.cold+0x17/0x34
> >    sysfs_add_bin_file_mode_ns+0xc0/0xf0
> >    sysfs_create_bin_file+0x6d/0xb0
> >    pci_create_attr+0x117/0x260
> >    pci_create_resource_files+0x6b/0x150
> >    pci_create_sysfs_dev_files+0x18/0x30
> >    pci_bus_add_device+0x30/0x80
> >    pci_bus_add_devices+0x31/0x80
> >    pci_bus_add_devices+0x5b/0x80
> >    vmd_enable_domain.constprop.0+0x6b7/0x880 [vmd]
> >    vmd_probe+0x16d/0x193 [vmd]
>=20
> This is a long-standing issue, and I would *love* to nail it, but this
> doesn't feel like the right solution to me.  What's unique about vmd
> here?
>=20
> I guess maybe it's similar to the situation Korneliusz and Alexander
> ran into at [1]?

What's the other path creating those sysfs files? Also vmd seems to be buil=
t=20
as a module in this case. So that's a different issue. pci-imx6 is racing=20
against an initcall when being built into the kernel. The probe_type=20
PROBE_PREFER_ASYNCHRONOUS is also important.
Being built as a module this race is essentially impossible.

Best regards,
Alexander

> And why is t7xx called out specifically here?  This is a pretty
> generic sysfs attribute issue and it doesn't *seem* like t7xx should
> be special in that respect.  Oooh, maybe it's the fact that there's a
> t7xx patch [2] coming that adds pci_rescan_bus() there?
>=20
> Krzysztof has converted a lot of the sysfs files to static attributes,
> e.g.,
>=20
>   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to sta=
tic
> attributes") d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
>   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
>   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
>   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")
>=20
> I think that's the *best* approach since the sysfs infrastructure
> already prevents races here.  But these last few files are more
> difficult to convert, so we've been kind of stalled on them.
>=20
> Bjorn
>=20
> [1]
> https://lore.kernel.org/r/20230316091540.494366-1-alexander.stein@ew.tq-g=
ro
> up.com [2]
> https://lore.kernel.org/linux-pci/20230124204543.550d88e3@kernel.org/
> > Fixes: 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management
> > Device (VMD)") Signed-off-by: You-Sheng Yang (vicamo)
> > <vicamo.yang@canonical.com> ---
> >=20
> >  drivers/pci/controller/vmd.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 769eedeb8802..f050991bd1e9 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -838,9 +838,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features)>=20
> >  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> >  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
> >=20
> > +	pci_lock_rescan_remove();
> > +
> >=20
> >  	vmd->bus =3D pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
> >  =09
> >  				       &vmd_ops, sd, &resources);
> >  =09
> >  	if (!vmd->bus) {
> >=20
> > +		pci_unlock_rescan_remove();
> > +
> >=20
> >  		pci_free_resource_list(&resources);
> >  		vmd_remove_irq_domain(vmd);
> >  		return -ENODEV;
> >=20
> > @@ -893,6 +897,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features)>=20
> >  	vmd_acpi_end();
> >=20
> > +	pci_unlock_rescan_remove();
> > +
> >=20
> >  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> >  =09
> >  			       "domain"), "Can't create symlink to=20
domain\n");
> >  =09
> >  	return 0;


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


