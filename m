Return-Path: <linux-pci+bounces-13329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71C97D4D7
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13291284400
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782E143738;
	Fri, 20 Sep 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1wJm+ku"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA58139D19;
	Fri, 20 Sep 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831834; cv=none; b=lfISxsCyYu0kIZ4VAArx32iqE7iJiRmQfHn1uM498Ehe4qA6s+FOwgDLnKUz5y70piAwc+uSGHi4668GZJuliwvfwiyByVVeBUTCQX8bebnzZyJMmfUdTdC5xEu/7tCAW5WTInxbvPpRq0at9YKF0B1cedxdsgBUIfcfDB5QTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831834; c=relaxed/simple;
	bh=MBU00sVsCEMU0AebXweDm01isV9nV9GtgkBT8MQkZSk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gBpCpZaWnjMfv5NA9HrJAnFMVJD9MOT8FjE0ELJdBewKiwMsV6CSQVMxhZcN1wn7Jgnw50+MsKGIipSL58Hx2N74y77e8jaYu3LP8RQPbQhLMgfB0SYp9OqI0+WAPIUUZ+70Szl2bmKSNiKkeCGKrPW4UNkGglJE81pe08nrhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1wJm+ku; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726831833; x=1758367833;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MBU00sVsCEMU0AebXweDm01isV9nV9GtgkBT8MQkZSk=;
  b=n1wJm+kuHgxOnN4M7mElQ9RFX1jYbhVCQa+IiNqSox/ZHLJ4617/2Cby
   G3ibf7nMqF9yjO3juI0k6YTKuMDFGnVeiI7hzE03n7Ah/u2+wy+1XZJrd
   wdwUXE+ynYkyiQDzaFODnm+LZJx4LciObhNUEpcd/Rc05m+kv8kwrFsoj
   baFMHPPiAbO1D4xDoUiVfTUdhYm5PWcGuO9zrG2wdlPNWIM1kQuTyz40O
   3x/sTwOlHWk77okOLY6OQaRSWrkBgnls4LFQj3LoIHxGsz7IIV0iSk8DW
   Yb2BzPQx4YmHO6dFhUvgOmNmVn/y2sV9y3+zlbGgDT5kJCCLFtHODpHmw
   A==;
X-CSE-ConnectionGUID: AdqMn7W7R0KZu3sXsiCXyg==
X-CSE-MsgGUID: rqICL5FWTo+QRyIW9qZBag==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43302802"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="43302802"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:30:12 -0700
X-CSE-ConnectionGUID: aRuVDJ4tROORtPbH5kunaQ==
X-CSE-MsgGUID: 6Z0LM0PTSoeQqfiRlzFFSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="71115747"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:30:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Sep 2024 14:30:00 +0300 (EEST)
To: =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>
cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Michal Wajdeczko <michal.wajdeczko@intel.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v2 2/3] PCI: Allow extending VF BAR within original
 resource boundary
In-Reply-To: <20240919223557.1897608-3-michal.winiarski@intel.com>
Message-ID: <90235e12-1c0e-d952-8d09-fef2bc8ed942@linux.intel.com>
References: <20240919223557.1897608-1-michal.winiarski@intel.com> <20240919223557.1897608-3-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-366647005-1726831800=:950"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-366647005-1726831800=:950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Sep 2024, Micha=C5=82 Winiarski wrote:

> VF MMIO resource reservation, either created by system firmware and
> inherited by Linux PCI subsystem or created by the subsystem itself,
> contains enough space to fit the BAR of all SR-IOV Virtual Functions
> that can potentially be created (total VFs supported by the device).
> This can be leveraged when the device is exposing lower than optimal BAR
> size as a default, allowing access to the entire resource when lower
> number of VFs are created.
> It is achieved by dynamically resizing the BAR to largest possible value
> that allows to fit all newly created VFs within the original resource
> boundary.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c   | 92 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h   |  1 +
>  include/linux/pci.h |  3 ++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index e8ccd2ae0f024..d88efbfa70e42 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -181,6 +181,86 @@ bool pci_iov_memory_decoding_enabled(struct pci_dev =
*dev)
>  =09return cmd & PCI_SRIOV_CTRL_MSE;
>  }
> =20
> +static void pci_iov_resource_do_extend(struct pci_dev *dev, int resno, u=
16 num_vfs)
> +{
> +=09resource_size_t size;
> +=09int ret, old, i;
> +=09u32 sizes;
> +
> +=09pci_config_pm_runtime_get(dev);
> +
> +=09if (pci_iov_memory_decoding_enabled(dev)) {
> +=09=09ret =3D -EBUSY;
> +=09=09goto err;
> +=09}
> +
> +=09sizes =3D pci_rebar_get_possible_sizes(dev, resno);
> +=09if (!sizes) {
> +=09=09ret =3D -ENOTSUPP;
> +=09=09goto err;
> +=09}
> +
> +=09old =3D pci_rebar_get_current_size(dev, resno);
> +=09if (old < 0) {
> +=09=09ret =3D old;
> +=09=09goto err;
> +=09}
> +
> +=09while (sizes > 0) {
> +=09=09i =3D __fls(sizes);
> +=09=09size =3D pci_rebar_size_to_bytes(i);
> +=09=09if (size * num_vfs <=3D pci_resource_len(dev, resno)) {
> +=09=09=09if (i !=3D old) {
> +=09=09=09=09ret =3D pci_rebar_set_size(dev, resno, size);
> +=09=09=09=09if (ret)
> +=09=09=09=09=09goto err;
> +
> +=09=09=09=09pci_iov_resource_set_size(dev, resno, size);
> +=09=09=09=09pci_iov_update_resource(dev, resno);
> +=09=09=09}
> +=09=09=09break;
> +=09=09}
> +=09=09sizes &=3D ~BIT(i);
> +=09}
> +
> +=09pci_config_pm_runtime_put(dev);
> +
> +=09return;
> +
> +err:
> +=09dev_WARN(&dev->dev, "Failed to extend %s: %d\n",
> +=09=09 pci_resource_name(dev, resno), ret);

Why do you use dev_WARN()? (analoguous to WARN_ON() / friends).

I suppose you'd want to use pci_warn() instead.

> +=09pci_config_pm_runtime_put(dev);
> +}
> +
> +static void pci_iov_resource_do_restore(struct pci_dev *dev, int resno)
> +{
> +=09if (dev->sriov->rebar_extend[resno - PCI_IOV_RESOURCES])
> +=09=09pci_iov_resource_do_extend(dev, resno, dev->sriov->total_VFs);
> +}
> +
> +int pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable)
> +{
> +=09if (!pci_resource_is_iov(dev, resno)) {
> +=09=09dev_WARN(&dev->dev, "%s is not an IOV resource\n",
> +=09=09=09 pci_resource_name(dev, resno));

pci_warn() ?

--=20
 i.

> +
> +=09=09return -ENODEV;
> +=09}
> +
> +=09if (!pci_rebar_get_possible_sizes(dev, resno))
> +=09=09return -ENOTSUPP;
> +
> +=09if (!enable)
> +=09=09pci_iov_resource_do_restore(dev, resno);
> +
> +=09dev->sriov->rebar_extend[resno - PCI_IOV_RESOURCES] =3D enable;
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_iov_resource_extend);
> +
>  static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  {
>  =09struct pci_dev *physfn =3D virtfn->physfn;
> @@ -445,7 +525,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  =09=09=09=09  const char *buf, size_t count)
>  {
>  =09struct pci_dev *pdev =3D to_pci_dev(dev);
> -=09int ret =3D 0;
> +=09int i, ret =3D 0;
>  =09u16 num_vfs;
> =20
>  =09if (kstrtou16(buf, 0, &num_vfs) < 0)
> @@ -487,6 +567,11 @@ static ssize_t sriov_numvfs_store(struct device *dev=
,
>  =09=09goto exit;
>  =09}
> =20
> +=09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +=09=09if (pdev->sriov->rebar_extend[i])
> +=09=09=09pci_iov_resource_do_extend(pdev, i + PCI_IOV_RESOURCES, num_vfs=
);
> +=09}
> +
>  =09ret =3D pdev->driver->sriov_configure(pdev, num_vfs);
>  =09if (ret < 0)
>  =09=09goto exit;
> @@ -881,8 +966,13 @@ static int sriov_init(struct pci_dev *dev, int pos)
> =20
>  static void sriov_release(struct pci_dev *dev)
>  {
> +=09int i;
> +
>  =09BUG_ON(dev->sriov->num_VFs);
> =20
> +=09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++)
> +=09=09pci_iov_resource_do_restore(dev, i + PCI_IOV_RESOURCES);
> +
>  =09if (dev !=3D dev->sriov->dev)
>  =09=09pci_dev_put(dev->sriov->dev);
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e763b3fd4c7a2..47ed2633232aa 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -385,6 +385,7 @@ struct pci_sriov {
>  =09u16=09=09subsystem_vendor; /* VF subsystem vendor */
>  =09u16=09=09subsystem_device; /* VF subsystem device */
>  =09resource_size_t=09barsz[PCI_SRIOV_NUM_BARS];=09/* VF BAR size */
> +=09bool=09=09rebar_extend[PCI_SRIOV_NUM_BARS];=09/* Resize VF BAR */
>  =09bool=09=09drivers_autoprobe; /* Auto probing of VFs by driver */
>  };
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4cf89a4b4cbcf..c007119da7b3d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2364,6 +2364,7 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16=
 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>  int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
> +int pci_iov_resource_extend(struct pci_dev *dev, int resno, bool enable)=
;
>  void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
> =20
>  /* Arch may override these (weak) */
> @@ -2416,6 +2417,8 @@ static inline int pci_sriov_get_totalvfs(struct pci=
_dev *dev)
>  #define pci_sriov_configure_simple=09NULL
>  static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev,=
 int resno)
>  { return 0; }
> +static inline void pci_iov_resource_extend(struct pci_dev *dev, int resn=
o, bool enable)
> +{ return -ENODEV; }
>  static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool pr=
obe) { }
>  #endif
> =20
>=20
--8323328-366647005-1726831800=:950--

