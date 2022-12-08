Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ED7646724
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 03:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLHClR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 21:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLHCkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 21:40:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F04950D8;
        Wed,  7 Dec 2022 18:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670467226; x=1702003226;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rgKXJv6opyDZ2Xf2woNRRDyis1PUsvqbEpmVPH8vHAA=;
  b=O4P2At4NY7CKfKIparaDyH0XN6h74qJTnncdJMtU3pcG6lio+IchBZE2
   DZ6E+6JEpfSRc42KosMjkrdrhJ0R24M6rhSwqd9btNicfVciPzhPNjXKA
   mD5c0R3fuqafBjCQ+2JKoH2hu0vH9OZ5jwbVB4PjqdH3ZI40KmAKy4Edo
   slISb2PDslORy18chf97va710psqOpkAAljm+/ZXdYFDfvHru/TZBtJ2t
   GeQE5+dBPWxeXtaat+Mh4aqaUyVf6lOvo/POOjQp2X67FQDCJ0PqlCB34
   zMBqwiNTqDLT4FIa5TUKu4bF1a5Iu+mxZf4wEhxCWuUsC1r0ncagiKRVa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="314702364"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="314702364"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975687056"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="975687056"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2022 18:40:24 -0800
Received: from plstone-mobl1.amr.corp.intel.com (unknown [10.212.164.201])
        by linux.intel.com (Postfix) with ESMTP id E159B580C4C;
        Wed,  7 Dec 2022 18:40:23 -0800 (PST)
Message-ID: <f277a3cf2e0c51d47c6af0a53547792d727a5a79.camel@linux.intel.com>
Subject: Re: [PATCH V8 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select
 hardware
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Luke Jones <luke@ljones.dev>, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Dec 2022 18:40:23 -0800
In-Reply-To: <8b8c7ae512291532ea227b8a1c3f87c460e11e2f.camel@ljones.dev>
References: <20221103021822.308586-1-david.e.box@linux.intel.com>
         <8b8c7ae512291532ea227b8a1c3f87c460e11e2f.camel@ljones.dev>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2022-12-07 at 22:05 +1300, Luke Jones wrote:
> On Wed, 2022-11-02 at 19:18 -0700, David E. Box wrote:
> > This series adds a work around for enabling PCIe ASPM and for setting
> > PCIe
> > LTR values on VMD reserved root ports on select platforms. While
> > configuration of these capabilities is usually done by BIOS, on these
> > platforms these capabilities will not be configured because the ports
> > are
> > not visible to BIOS. This was part of an initial design that expected
> > the
> > driver to completely handle the ports, including power management.
> > However
> > on Linux those ports are still managed by the PCIe core, which has
> > the
> > expectation that they adhere to device standards including BIOS
> > configuration, leading to this problem.
> >=20
> > The target platforms are Tiger Lake, Alder Lake, and Raptor Lake
> > though the
> > latter has already implemented support for configuring the LTR
> > values.
> > Meteor Lake is expected add BIOS ASPM support, eliminating the future
> > need
> > for this work around.
> >=20
> > Note, the driver programs the LTRs because BIOS would also normally
> > do this
> > for devices that do not set them by default. Without this, SoC power
> > management would be blocked on those platform. This SoC specific
> > value is
> > the maximum latency required to allow the SoC to enter the deepest
> > power
> > state.
> >=20
> > This patch addresses the following open bugzillas on VMD enabled
> > laptops
> > that cannot enter low power states.
> >=20
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D212355
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215063
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D213717
> >=20
> > David E. Box (3):
> > =C2=A0 PCI: vmd: Use PCI_VDEVICE in device list
> > =C2=A0 PCI: vmd: Create feature grouping for client products
> > =C2=A0 PCI: vmd: Add quirk to configure PCIe ASPM and LTR
> >=20
> > Michael Bottini (1):
> > =C2=A0 PCI/ASPM: Add pci_enable_link_state()
> >=20
> > =C2=A0drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++-----=
---
> > --
> > =C2=A0drivers/pci/pcie/aspm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 54 ++++++=
++++++++++++++
> > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 7 +++
> > =C2=A03 files changed, 131 insertions(+), 26 deletions(-)
> >=20
> >=20
> > base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
>=20
> I'd like to confirm that this patch series solves the VMD power issues
> present on the ASUS ROG M16 (GU603) laptop range (PCI dev ID =3D 467f).
>=20
> The difference is quite drastic.
>=20

Thanks for testing this Luke.

David

