Return-Path: <linux-pci+bounces-15188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16629AE01E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 11:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26131C2205C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE2757FC;
	Thu, 24 Oct 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKwa/7xo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673823CB;
	Thu, 24 Oct 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760802; cv=none; b=eh+cfxPub+YDAfIYhx/fB/jPQ5f492kR8hNLT9MOputj40oYaRg0Z4RRMx6TdrYQfEtEFJwTU9fat4bEbz0m5F+kPQ51HTHMRPUJ8R5ITuD+V8U9rKcB3AU2MwUVarH4iJqzIoi5mkF10TcS+KciX5AjQcuUjXqocC1k0P75VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760802; c=relaxed/simple;
	bh=TPgnv4Jvv6YLw54D9uhWHUaz2XEBir0T5CcHTTI9fpU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EODDqLAKqt3yN+u/uC0IcEnDML8J+R5I4++h04FgxGE8LNiIlVcapMDTypGkbtSGi1wLB/h3Ls4gvM7DeuXuCNjKKACUlW33reB/zOTIBDhQpB7CjtrZPvOYEsNjM/KYgHH+rxFMK7bWUOGZZrMakU5XevyXml9npgk1gvngKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKwa/7xo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729760801; x=1761296801;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TPgnv4Jvv6YLw54D9uhWHUaz2XEBir0T5CcHTTI9fpU=;
  b=cKwa/7xoJT7bBjoVhSQoBP6h4ZccN6ExQvkFOT7IGBbugd8YqT9zICZb
   GfJTlOvccOuhFtAj+usFvzFAU5L/bj5eIw6Xr9+t8wv5HjxSKJn0JUF0C
   hmLKjQWFQoaWMkMghj5zfkpbPW0nFXq0lx96Ds7A3gljbs4EmVSeM50rR
   URZxP8j2OhKoEvuDaF2rPCd1RjYOVd42p6DBfmcmYwr4pAXpaX+OamVdu
   FBwsdbWThTGuu0IuCDwRK3oqQDBG9Ewj1zx5jLg+jK83XWF5gibZLTerJ
   qthiaqJ34RocOSu5T/aClkuuzI59A42+EL1igF/Yq7RtO11o1PLD+qvZ5
   Q==;
X-CSE-ConnectionGUID: b+gz9RcCTie6aZcW7d6n9w==
X-CSE-MsgGUID: rt8tMDTZQ9K5PJ0KvuV0Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29600161"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="29600161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:06:40 -0700
X-CSE-ConnectionGUID: RmzCAQGtT4Cj7Y05wqUuzQ==
X-CSE-MsgGUID: js3TqFB2T322E0iMyIHJvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="85141746"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:06:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Oct 2024 12:06:33 +0300 (EEST)
To: Paul Menzel <pmenzel@molgen.mpg.de>, 
    ChandraShekar <chandrashekar.devegowda@intel.com>
cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
    ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support
 added
In-Reply-To: <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
Message-ID: <472e30e8-a886-a268-3105-75379f722ce4@linux.intel.com>
References: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com> <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-338810278-1729760793=:1315"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-338810278-1729760793=:1315
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Oct 2024, Paul Menzel wrote:

> [Cc: +Bjorn, +linux-pci]
>=20
> Dear Chandra,
>=20
>=20
> Thank you for the patch.
>=20
> First something minor: Should there be a space in your name?
>=20
> ChandraShekar =E2=86=92 Chandra Shekar
>=20
> `git config --global user.name "=E2=80=A6"` can configure this for your g=
it setup.
>=20
> Also for the summary/title, it=E2=80=99d be great if you used a statement=
 by using a
> verb (in imperative mood):
>=20
> Add device suspend-resume support
>=20
> or shorter
>=20
> Support suspend-resume
>=20
> Am 23.10.24 um 13:46 schrieb ChandraShekar:
> > This patch contains the changes in driver to support the suspend and
> > resume i.e move the controller to D3 state when the platform is enterin=
g
> > into suspend and move the controller to D0 on resume.
>=20
> It=E2=80=99d be great if you elaborated. Please start by the history, sin=
ce when Intel
> Bluetooth PCIe have been there, and why until now this support was missin=
g.
>=20
> Then please describe, what is needed, and what documentation you used to
> implement the support.
>=20
> Also, please document, how you tested this, including the log messages, a=
nd
> also the time it takes to resume.
>=20
> Is it also possible to use Bluetooth as a wakeup source from suspend?
>=20
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: ChandraShekar <chandrashekar.devegowda@intel.com>
> > ---
> >   drivers/bluetooth/btintel_pcie.c | 52 +++++++++++++++++++++++++++++++=
+
> >   drivers/bluetooth/btintel_pcie.h |  4 +++
> >   2 files changed, 56 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/btintel_pcie.c
> > b/drivers/bluetooth/btintel_pcie.c
> > index fd4a8bd056fa..f2c44b9d7328 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct
> > btintel_pcie_data *data)
> >   =09return reg =3D=3D 0 ? 0 : -ENODEV;
> >   }
> >   +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_da=
ta
> > *data)
> > +{
> > +=09btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> > +=09=09=09=09  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> > +}
> > +
> >   /* This function enables BT function by setting
> > BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
> >    * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
> >    * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> > @@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct
> > btintel_pcie_data *data)
> >   =09 */
> >   =09data->boot_stage_cache =3D 0x0;
> >   +=09btintel_pcie_set_persistence_mode(data);
> > +
> >   =09/* Set MAC_INIT bit to start primary bootloader */
> >   =09reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG=
);
> >   =09reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> > @@ -1653,11 +1661,55 @@ static void btintel_pcie_remove(struct pci_dev
> > *pdev)
> >   =09pci_set_drvdata(pdev, NULL);
> >   }
> >   +static int btintel_pcie_suspend(struct device *dev)
> > +{
> > +=09struct btintel_pcie_data *data;
> > +=09int err;
> > +=09struct  pci_dev *pdev =3D to_pci_dev(dev);

Extra space.

> > +
> > +=09data =3D pci_get_drvdata(pdev);
> > +=09btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> > +=09data->gp0_received =3D false;
> > +=09err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > +
> > msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> > +=09if (!err) {
> > +=09=09bt_dev_err(data->hdev, "failed to receive gp0 interrupt for
> > suspend");
>=20
> Please include the timeout in the message.
>=20
> > +=09=09goto fail;
> > +=09}
> > +=09return 0;
> > +fail:
> > +=09return -EBUSY;
> > +}
> > +
> > +static int btintel_pcie_resume(struct device *dev)
> > +{
> > +=09struct btintel_pcie_data *data;
> > +=09struct  pci_dev *pdev =3D to_pci_dev(dev);

Ditto.

> > +=09int err;

Why's the order inconsistent compared with suspend func local vars?

> > +
> > +=09data =3D pci_get_drvdata(pdev);
> > +=09btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> > +=09data->gp0_received =3D false;
> > +=09err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > +
> > msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> > +=09if (!err) {
> > +=09=09bt_dev_err(data->hdev, "failed to receive gp0 interrupt for
> > resume");
>=20
> Ditto.
>=20
> > +=09=09goto fail;
> > +=09}
> > +=09return 0;
> > +fail:
> > +=09return -EBUSY;

Quite much common code here compared with the suspend side. Perhaps a=20
helper function would be useful?

> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> > +=09=09btintel_pcie_resume);
> > +
> >   static struct pci_driver btintel_pcie_driver =3D {
> >   =09.name =3D KBUILD_MODNAME,
> >   =09.id_table =3D btintel_pcie_table,
> >   =09.probe =3D btintel_pcie_probe,
> >   =09.remove =3D btintel_pcie_remove,
> > +=09.driver.pm =3D &btintel_pcie_pm_ops,
> >   };
> >   module_pci_driver(btintel_pcie_driver);
> >   diff --git a/drivers/bluetooth/btintel_pcie.h
> > b/drivers/bluetooth/btintel_pcie.h
> > index f9aada0543c4..38d0c8ea2b6f 100644
> > --- a/drivers/bluetooth/btintel_pcie.h
> > +++ b/drivers/bluetooth/btintel_pcie.h
> > @@ -8,6 +8,7 @@
> >     /* Control and Status Register(BTINTEL_PCIE_CSR) */
> >   #define BTINTEL_PCIE_CSR_BASE=09=09=09(0x000)
> > +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG=09=09(BTINTEL_PCIE_CSR_BASE
> > + 0x000)
> >   #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG=09=09(BTINTEL_PCIE_CSR_BASE
> > + 0x024)
> >   #define BTINTEL_PCIE_CSR_HW_REV_REG=09=09(BTINTEL_PCIE_CSR_BASE +
> > 0x028)
> >   #define BTINTEL_PCIE_CSR_RF_ID_REG=09=09(BTINTEL_PCIE_CSR_BASE +
> > 0x09C)
> > @@ -48,6 +49,9 @@
> >   #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE
> > (BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
> >   #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)
> > (BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
> >   +/* CSR HW BOOT CONFIG Register */
> > +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON=09=09(BIT(31))

Extra parenthesis.

--=20
 i.


> > +
> >   /* Causes for the FH register interrupts */
> >   enum msix_fh_int_causes {
> >   =09BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0=09=3D BIT(0),=09/* cause 0 */
--8323328-338810278-1729760793=:1315--

