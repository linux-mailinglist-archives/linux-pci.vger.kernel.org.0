Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2F63656D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 17:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiKWQKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbiKWQKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 11:10:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D25C76BB;
        Wed, 23 Nov 2022 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669219796; x=1700755796;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=41Amlkh3nNXXy8dAcUXdlKhcq7idpet7xOPClTf5RII=;
  b=ioLNdzHN/4vRJQKS4hup4Bg24QU8kYQktqJU0/6SW3Y036oCQFdX/bS2
   OV6UHWmdGkS5jwdz+8Avou8tpNLdcs6uqaMFo2eM58+meR9kDDy5pBx6k
   5VxsFkNA+Qpjl70pJaMXqp/bK3oehRmeS5Y6JOUCr20yqF6UP1HDv6quc
   ZSviqMMlMyDW7SIZU2JmboOjAZBUIWR6z8vwVacpSs0+vMDUPWZSo5+NM
   rB5mc00bAq2vtFk2JINllWS/ant/9lPeAoAEbZDXyMStqDj67O453j0es
   jKhxMgnwYtDUD599Kz36cWZoCOarzMTeNUAVcwpv1q2G6NZH3bbB8awqy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311729547"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311729547"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 08:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="784293582"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="784293582"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 08:09:48 -0800
Received: from brpivitt-mobl1.amr.corp.intel.com (unknown [10.252.128.124])
        by linux.intel.com (Postfix) with ESMTP id 61E4E580AFF;
        Wed, 23 Nov 2022 08:09:48 -0800 (PST)
Message-ID: <17b05a72d2db1074cef9d5e9f85b347850f171d5.camel@linux.intel.com>
Subject: Re: [PATCH V8 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select
 hardware
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     You-Sheng Yang <vicamo.yang@canonical.com>
Cc:     michael.a.bottini@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@adhityamohan.in,
        rafael@kernel.org, hch@infradead.org, robh@kernel.org,
        bhelgaas@google.com, kw@linux.com, lorenzo.pieralisi@arm.com,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Date:   Wed, 23 Nov 2022 08:09:48 -0800
In-Reply-To: <5c766840-e092-45ea-0664-7bbdb78b933a@canonical.com>
References: <20221103021822.308586-1-david.e.box@linux.intel.com>
         <5c766840-e092-45ea-0664-7bbdb78b933a@canonical.com>
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

Hi You-Sheng,

On Wed, 2022-11-23 at 18:27 +0800, You-Sheng Yang wrote:
> Hi David,
>=20
> On 11/3/22 10:18, David E. Box wrote:
> > This series adds a work around for enabling PCIe ASPM and for setting P=
CIe
> > LTR values on VMD reserved root ports on select platforms. While
> > configuration of these capabilities is usually done by BIOS, on these
> > platforms these capabilities will not be configured because the ports a=
re
> > not visible to BIOS. This was part of an initial design that expected t=
he
> > driver to completely handle the ports, including power management. Howe=
ver
> > on Linux those ports are still managed by the PCIe core, which has the
> > expectation that they adhere to device standards including BIOS
> > configuration, leading to this problem.
> >=20
> > The target platforms are Tiger Lake, Alder Lake, and Raptor Lake though=
 the
> > latter has already implemented support for configuring the LTR values.
> > Meteor Lake is expected add BIOS ASPM support, eliminating the future n=
eed
> > for this work around.
>=20
>=20
> It appears to me that this patch series works only on Tiger Lake. We=20
> have tried to revert our current work-arounds in Ubuntu kernels=20
> generic-5.15/oem-5.17/oem-6.0/unstable-6.1 and apply this series, the=20
> prebuilt kernels can be found in:
>=20
> =C2=A0=C2=A0 https://launchpad.net/~vicamo/+archive/ubuntu/ppa-1996620
>=20
> However, only TGL can still enter PC10 as before.
>=20
>=20
> ADL-M, RPL platforms will stay in PC3 with vmd LTR set, but ASPM=20
> disabled.

For the patch to work BIOS must allow the OS to control ASPM. If this is no=
t the
case then you will see the message "ACPI FADT declares the system doesn't
support PCIe ASPM, so disable it". Please check for this on the systems tha=
t
don't work. If so the only option is a BIOS change to enable it.

David

>  i915 RC6 blocked, too:
>=20
> $ sudo cat /sys/kernel/debug/dri/
>=20
> 0/i915_dmc_info
> ...
> DC3CO count: 0
> DC3 -> DC5 count: 100
> DC5 -> DC6 count: 0
>=20
>=20
> > Note, the driver programs the LTRs because BIOS would also normally do =
this
> > for devices that do not set them by default. Without this, SoC power
> > management would be blocked on those platform. This SoC specific value =
is
> > the maximum latency required to allow the SoC to enter the deepest powe=
r
> > state.
> >=20
> > This patch addresses the following open bugzillas on VMD enabled laptop=
s
> > that cannot enter low power states.
> >=20
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D212355
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215063
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D213717
> >=20
> > David E. Box (3):
> > =C2=A0=C2=A0 PCI: vmd: Use PCI_VDEVICE in device list
> > =C2=A0=C2=A0 PCI: vmd: Create feature grouping for client products
> > =C2=A0=C2=A0 PCI: vmd: Add quirk to configure PCIe ASPM and LTR
> >=20
> > Michael Bottini (1):
> > =C2=A0=C2=A0 PCI/ASPM: Add pci_enable_link_state()
> >=20
> > =C2=A0 drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++----=
------
> > =C2=A0 drivers/pci/pcie/aspm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 54 +++++=
+++++++++++++++
> > =C2=A0 include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 7 +++
> > =C2=A0 3 files changed, 131 insertions(+), 26 deletions(-)
> >=20
> >=20
> > base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
>=20
>=20
> Regards,
> You-Sheng Yang
>=20

