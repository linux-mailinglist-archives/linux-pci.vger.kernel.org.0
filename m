Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACF6BCAF4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCPJdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 05:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCPJds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 05:33:48 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EBCB856A;
        Thu, 16 Mar 2023 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678959224; x=1710495224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7UnOpCRtVxMC1YLy/djxks54MjsNALCx508mBTqGOw=;
  b=DILPNRapvG2FKeg9ER0vwn5qBsEblUv1tivo8U/aW6kNnZFoU1zc7UCq
   OXys9CRUz2Lp0xZ8HDBE9Gbz3MsO2z6hv6A77+fCRPVFdzHee++8c5BEL
   UzBDP2X/Ay0kb5JCqef4dZVXnSIDzHZmTtB0QNmBG/xIA5+tMxNJPWijN
   D1dnLo3a3dNuAROUOziPm+EO9Ze+rnPwyt5Mwva1O6wLATL2pImjAx83G
   kJhiG5QH87YEi5ZW5mR81/Ifr8usHJk4dBKZ9ZtenzHqhW2tXwrNIZdSF
   W5Xwc2eJh/6bkA/Oe9U+YX/tiJeGShYGkd8U65opmPZ8ozJlm06ay00O8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29731249"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 10:33:41 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 10:33:41 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 10:33:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678959221; x=1710495221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7UnOpCRtVxMC1YLy/djxks54MjsNALCx508mBTqGOw=;
  b=ZtxM30JDyKRelPUgwLqfTmiQPhezwMsE1kBIDg7fS9XYOaO/tClfAztH
   I5/tQBvJnLRk+CzZfq4pqoOr0EH4ZPpTe60ByegqvFubVbdK8zLNCK2k/
   QiqsBT4KCocCIYyCBjcq3nSbYOK4pyAh/gyWH5+xdjSRiG4qLg7IRcc19
   VLDVxc4xe0vjqe0kIse3ZxMY46m3ba3tqHj0D+RaPEoxPB16e1k8pyFuK
   IXDlpqZBSjL3DJVXLpkWth77qy8TnEoD740/e4KyPMWqe/jf4TbMvX51o
   37pBoELM6Ct/xRIr1IQ03F3FRzZUyleoMV8BjaQqReKRe7e1abCqWSUxb
   g==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29731247"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 10:33:40 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C6F74280056;
        Thu, 16 Mar 2023 10:33:40 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 16 Mar 2023 10:33:38 +0100
Message-ID: <6131694.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <106b5618-908f-becc-6eb3-75ef136a48e4@suse.com>
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com> <106b5618-908f-becc-6eb3-75ef136a48e4@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Oliver,

Am Donnerstag, 16. M=E4rz 2023, 10:23:54 CET schrieb Oliver Neukum:
> On 16.03.23 10:15, Alexander Stein wrote:
> > From: Korneliusz Osmenda <korneliuszo@gmail.com>
> >=20
> > On Gateworks Ventana there is a number of PCI devices and:
> >    - imx6_pcie_probe takes longer than start of late init
> >    - pci_sysfs_init sets up flag sysfs_initialized
> >    - pci_sysfs_init initializes already found devices
> >    - imx6_pcie_probe tries to reinitialize device
> >=20
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215515
> >=20
> > Signed-off-by: Korneliusz Osmenda <korneliuszo@gmail.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >   drivers/pci/pci-sysfs.c | 6 ++++++
> >   include/linux/pci.h     | 2 ++
> >   2 files changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index dd0d9d9bc509..998e44716b6f 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1497,6 +1497,9 @@ int __must_check pci_create_sysfs_dev_files(struct
> > pci_dev *pdev)>=20
> >   	if (!sysfs_initialized)
> >   =09
> >   		return -EACCES;
> >=20
> > +	if (atomic_cmpxchg(&pdev->sysfs_init_cnt, 0, 1) =3D=3D 1)
> > +		return 0;		/* already added */
> > +
> >=20
> >   	return pci_create_resource_files(pdev);
>=20
> This is very likely a bug. You are returning an error in the error
> case. Yet the flag stays.

Ah, you are right. This is something needed to address.

> And simply resetting it in the error case
> would be a race. There is something fishy in that design.

Admittedly=20
I would like to get rid of these two pathes for creating sysfs files in the=
=20
first place, but I do not know the pci subsystem very well.
IMHO for_each_pci_dev(pdev) in pci_sysfs_init is part of the problem as it=
=20
unconditionally iterates over the bus, without any locks, thus creating sys=
fs=20
files for each device added to the bus.
Any ideas?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


