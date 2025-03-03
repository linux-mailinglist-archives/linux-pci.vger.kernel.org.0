Return-Path: <linux-pci+bounces-22764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9187A4C4D0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B70172FF2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E221422F;
	Mon,  3 Mar 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WffYIJEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B116FF37;
	Mon,  3 Mar 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015102; cv=none; b=pED+J9v1fYC7lr67H9hMvqRXnIE9eLVBssH0qCQewe4YMkXbTXBDg3V3CcDYCDWXaY7lYUbXsxDZfkMEKjhbPK5C1SokezTuBgkHRL6/aWI4QCzeyLeIdOza45ZGs9595kznbvyOjtBy0wK/oIPrSzlDeUDkFW473S6DNPyFqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015102; c=relaxed/simple;
	bh=D0+FXlcuV+yOr3/H+UuVxlIRGqsGebAqyeko/mmJCt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4PTdMLH8sSRyHcQogUm5ncvqzCvwd78FE9qORjeJc+K80k74SkBPyeXbo3AMfNTUZ+QY6KAgxsaG3le8ykZNAcLzbgDbTvC2Rpksp45Fl+kYfvPqpV8PFALy7u6kIqC2cUHOoD38f16oGmUtvZIYvi8+TCT4Nzwb/E4PbFdXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WffYIJEE; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z62WW0hCnz9spt;
	Mon,  3 Mar 2025 16:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741015095; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXBhoxhYXKElGvOXz1cQ1lchZ7TxkiuLadm8Hqzl9AE=;
	b=WffYIJEE2uqSOUTiN+Ts4fJtFQbG8ZWN/InMLvbmJFPfP5bDKNG7OUtM6uklncwt40q69H
	RKaRLabBqhAJAsPy3JvbTMzWfa7urjUm+2pivPeYMg0a2+AUfMAHMvdi9yiMcmnfAD3jn7
	ojwPMj06J9r/UZ0UDrYpWt4/gJR26ScQo7Dmm64PQJzeIg1mQYES/AXy8F7jidtj28O4CI
	PwFlUgbWjjye+UUOeTgQICN9Gp+43c5xbwC/uVOTYU5+xj41WOXOoFZ6II6Lx50jPOATNz
	2rg3D4BP1MZAOQIG42vHgnvPbvunoTLpN1rYjgI0LScECAry9uV0vrKi0JoAIg==
Message-ID: <9054abd23925d829a76e85a8001b53af463d5e62.camel@mailbox.org>
Subject: Re: [RFC PATCH 2/7] media: ipu7: add Intel IPU7 PCI device driver
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, Bingbu Cao <bingbu.cao@linux.intel.com>, 
 bingbu.cao@intel.com, linux-media@vger.kernel.org,
 sakari.ailus@linux.intel.com,  hdegoede@redhat.com
Cc: hans@hansg.org, stanislaw.gruszka@linux.intel.com, jerry.w.hu@intel.com,
  tian.shu.qiu@intel.com, daxing.li@intel.com, hao.yao@intel.com, Bjorn
 Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Date: Mon, 03 Mar 2025 16:18:11 +0100
In-Reply-To: <128a070a296695d667c29fadfea797998a3508e5.camel@mailbox.org>
References: <20250221075252.3347582-1-bingbu.cao@intel.com>
	 <20250221075252.3347582-3-bingbu.cao@intel.com>
	 <873cbddbc43638c2564ce27e373c25fe2f3dc2e9.camel@mailbox.org>
	 <adb53b1f-29e1-3d14-0e61-351fd2d3ff0d@linux.intel.com>
	 <128a070a296695d667c29fadfea797998a3508e5.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: e571d78961494f0143b
X-MBO-RS-META: cj6ojsdn6cko3efj6z5afgu5bg3wsbop

On Mon, 2025-03-03 at 16:01 +0100, Philipp Stanner wrote:
> +Cc Bjorn, PCI
>=20
> On Thu, 2025-02-27 at 12:06 +0800, Bingbu Cao wrote:
> >=20
> >=20
> > On 2/24/25 10:38 PM, Philipp Stanner wrote:
> > > Hi,
> > >=20
> > > see below
> > >=20
> > > On Fri, 2025-02-21 at 15:52 +0800, bingbu.cao@intel.com=C2=A0wrote:
> > > > From: Bingbu Cao <bingbu.cao@intel.com>
> > > >=20
> > > > Intel Image Processing Unit 7th Gen includes input and
> > > > processing
> > > > systems
> > > > and the hardware presents itself as a single PCI device in
> > > > system
> > > > same
> > > > as IPU6.
> > > >=20
> > > > The IPU7 PCI device driver basically does PCI configurations,
> > > > basic
> > > > hardware configuration by its buttress interfaces, loads the
> > > > firmware binary, register the auxiliary device which serve for
> > > > the
> > > > ISYS
> > > > device driver.
> > > >=20
> > > > Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> > > > ---
> > > > =C2=A0drivers/media/pci/intel/ipu7/ipu7-bus.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 158 +
> > > > =C2=A0drivers/media/pci/intel/ipu7/ipu7-bus.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 69 +
> > > > =C2=A0.../media/pci/intel/ipu7/ipu7-buttress-regs.h |=C2=A0 465 +++
> > > > =C2=A0drivers/media/pci/intel/ipu7/ipu7-buttress.c=C2=A0 | 1187 +++=
++++
> > > > =C2=A0drivers/media/pci/intel/ipu7/ipu7-buttress.h=C2=A0 |=C2=A0=C2=
=A0 84 +
> > > > =C2=A0.../media/pci/intel/ipu7/ipu7-platform-regs.h |=C2=A0 146 +
> > > > =C2=A0drivers/media/pci/intel/ipu7/ipu7.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2791
> > > > +++++++++++++++++
> > > > =C2=A0drivers/media/pci/intel/ipu7/ipu7.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 244 ++
> > > > =C2=A08 files changed, 5144 insertions(+)
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7-bus.c
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7-bus.h
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7-buttress=
-
> > > > regs.h
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7-
> > > > buttress.c
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7-
> > > > buttress.h
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7-platform=
-
> > > > regs.h
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7.c
> > > > =C2=A0create mode 100644 drivers/media/pci/intel/ipu7/ipu7.h
> > > >=20
> >=20
> > ---snip---
> >=20
> > > > +static int ipu7_pci_probe(struct pci_dev *pdev, const struct
> > > > pci_device_id *id)
> > > > +{
> > > > +	struct ipu_buttress_ctrl *isys_ctrl =3D NULL, *psys_ctrl
> > > > =3D
> > > > NULL;
> > > > +	struct fwnode_handle *fwnode =3D dev_fwnode(&pdev->dev);
> > > > +	const struct ipu_buttress_ctrl *isys_buttress_ctrl;
> > > > +	const struct ipu_buttress_ctrl *psys_buttress_ctrl;
> > > > +	struct ipu_isys_internal_pdata *isys_ipdata;
> > > > +	struct ipu_psys_internal_pdata *psys_ipdata;
> > > > +	unsigned int dma_mask =3D IPU_DMA_MASK;
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	void __iomem *isys_base =3D NULL;
> > > > +	void __iomem *psys_base =3D NULL;
> > > > +	void __iomem *const *iomap;
> > > > +	phys_addr_t phys, pb_phys;
> > > > +	struct ipu7_device *isp;
> > > > +	u32 is_es;
> > > > +	int ret;
> > > > +
> > > > +	if (!fwnode || fwnode_property_read_u32(fwnode,
> > > > "is_es",
> > > > &is_es))
> > > > +		is_es =3D 0;
> > > > +
> > > > +	isp =3D devm_kzalloc(dev, sizeof(*isp), GFP_KERNEL);
> > > > +	if (!isp)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	dev_set_name(dev, "intel-ipu7");
> > > > +	isp->pdev =3D pdev;
> > > > +	INIT_LIST_HEAD(&isp->devices);
> > > > +
> > > > +	ret =3D pcim_enable_device(pdev);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Enable PCI
> > > > device
> > > > failed\n");
> > > > +
> > > > +	dev_info(dev, "Device 0x%x (rev: 0x%x)\n",
> > > > +		 pdev->device, pdev->revision);
> > > > +
> > > > +	phys =3D pci_resource_start(pdev, IPU_PCI_BAR);
> > > > +	pb_phys =3D pci_resource_start(pdev, IPU_PCI_PBBAR);
> > > > +	dev_info(dev, "IPU7 PCI BAR0 base %llx BAR2 base
> > > > %llx\n",
> > > > +		 phys, pb_phys);
> > > > +
> > > > +	ret =3D pcim_iomap_regions(pdev, BIT(IPU_PCI_BAR) |
> > > > BIT(IPU_PCI_PBBAR),
> > > > +				 pci_name(pdev));
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to I/O memory
> > > > remapping
> > > > (%d)\n",
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 ret);
> > > > +
> > > > +	iomap =3D pcim_iomap_table(pdev);
> > >=20
> > > pcim_iomap_table() and pcim_iomap_regions() have been deprecated
> > > last
> > > year. That's also documented in those functions' docstrings.
> > > Please
> > > don't use them anymore.
> > >=20
> > > You can achieve all you need with the simpler pcim_iomap_region()
> >=20
> > Philipp,
> >=20
> > I see that pcim_iomap_regions() and
> > pcim_add_mapping_to_legacy_table()
> > have simple 'bar' checking, how does pcim_iomap_region() check
> > that?
>=20
> You mean the BAR index range check I suppose.
>=20
> That's a good question. It seems to me that the ultimately used
> pci_resource_start() will just overflow the device's array and you
> get
> UB =E2=80=93 again.
>=20
> He.
> Damn.
>=20
> We might wanna fix that. But we can ask ourselves: where. At the
> lowest
> point in those PCI region accessor macros which then bubble an EINVAL
> or similar upwards, or at the higher point, as in
> pcim_iomap_region().
>=20
> This seems a PCI-wide problem. It seems to me that pci_iomap() &
> partners are also not safeguarded against overflowing.
>=20
> Bjorn, shall we solve that? How? do you have a preference?

I took a first look and it seems that many drivers directly use
pci_resource_start() and assign its value to an unsigned integer.

So we have no way to have it check for the BAR index range and return -
EINVAL.

Hm, kind of bad. So my first instinct is that we have no other choice
but do such checks in the higher layers.

P.

>=20
>=20
> P.
>=20
>=20
> PS: That is actually embarrassing since I complained in my talk about
> pcim_iomap_table() having no possibility for bounds checking.
> Ah, let's hope no one will notice that I said that ^_^
>=20
> >=20
> > >=20
> > >=20
> > > > +	if (!iomap)
> > > > +		return dev_err_probe(dev, -ENODEV, "Failed to
> > > > iomap
> > > > table\n");
> > > > +
> > > > +	isp->base =3D iomap[IPU_PCI_BAR];
> > > > +	isp->pb_base =3D iomap[IPU_PCI_PBBAR];
> > > > +	dev_info(dev, "IPU7 PCI BAR0 mapped at %p\n BAR2
> > > > mapped
> > > > at
> > > > %p\n",
> > > > +		 isp->base, isp->pb_base);
> > > > +
> > > > +	pci_set_drvdata(pdev, isp);
> > > > +	pci_set_master(pdev);
> > > > +
> > > > +	switch (id->device) {
> > > > +	case IPU7_PCI_ID:
> > > > +		isp->hw_ver =3D IPU_VER_7;
> > > > +		isp->cpd_fw_name =3D IPU7_FIRMWARE_NAME;
> > > > +		isys_ipdata =3D &ipu7_isys_ipdata;
> > > > +		psys_ipdata =3D &ipu7_psys_ipdata;
> > > > +		isys_buttress_ctrl =3D &ipu7_isys_buttress_ctrl;
> > > > +		psys_buttress_ctrl =3D &ipu7_psys_buttress_ctrl;
> > > > +		break;
> > > > +	case IPU7P5_PCI_ID:
> > > > +		isp->hw_ver =3D IPU_VER_7P5;
> > > > +		isp->cpd_fw_name =3D IPU7P5_FIRMWARE_NAME;
> > > > +		isys_ipdata =3D &ipu7p5_isys_ipdata;
> > > > +		psys_ipdata =3D &ipu7p5_psys_ipdata;
> > > > +		isys_buttress_ctrl =3D &ipu7_isys_buttress_ctrl;
> > > > +		psys_buttress_ctrl =3D &ipu7_psys_buttress_ctrl;
> > > > +		break;
> > > > +	case IPU8_PCI_ID:
> > > > +		isp->hw_ver =3D IPU_VER_8;
> > > > +		isp->cpd_fw_name =3D IPU8_FIRMWARE_NAME;
> > > > +		isys_ipdata =3D &ipu8_isys_ipdata;
> > > > +		psys_ipdata =3D &ipu8_psys_ipdata;
> > > > +		isys_buttress_ctrl =3D &ipu8_isys_buttress_ctrl;
> > > > +		psys_buttress_ctrl =3D &ipu8_psys_buttress_ctrl;
> > > > +		break;
> > > > +	default:
> > > > +		WARN(1, "Unsupported IPU device");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	ipu_internal_pdata_init(isys_ipdata, psys_ipdata);
> > > > +
> > > > +	isys_base =3D isp->base + isys_ipdata-
> > > > >hw_variant.offset;
> > > > +	psys_base =3D isp->base + psys_ipdata-
> > > > >hw_variant.offset;
> > > > +
> > > > +	ret =3D dma_set_mask_and_coherent(dev,
> > > > DMA_BIT_MASK(dma_mask));
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to set
> > > > DMA
> > > > mask\n");
> > > > +
> > > > +	dma_set_max_seg_size(dev, UINT_MAX);
> > > > +
> > > > +	ret =3D ipu7_pci_config_setup(pdev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D ipu_buttress_init(isp);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	dev_info(dev, "firmware cpd file: %s\n", isp-
> > > > > cpd_fw_name);
> > > > +
> > > > +	ret =3D request_firmware(&isp->cpd_fw, isp->cpd_fw_name,
> > > > dev);
> > > > +	if (ret) {
> > > > +		dev_err_probe(dev, ret,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Requesting signed firmware %s
> > > > failed\n",
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isp->cpd_fw_name);
> > > > +		goto buttress_exit;
> > > > +	}
> > > > +
> > > > +	ret =3D ipu7_cpd_validate_cpd_file(isp, isp->cpd_fw-
> > > > >data,
> > > > +					 isp->cpd_fw->size);
> > > > +	if (ret) {
> > > > +		dev_err_probe(dev, ret, "Failed to validate
> > > > cpd\n");
> > > > +		goto out_ipu_bus_del_devices;
> > > > +	}
> > > > +
> > > > +	isys_ctrl =3D devm_kmemdup(dev, isys_buttress_ctrl,
> > > > +				 sizeof(*isys_buttress_ctrl),
> > > > GFP_KERNEL);
> > > > +	if (!isys_ctrl) {
> > > > +		ret =3D -ENOMEM;
> > > > +		goto out_ipu_bus_del_devices;
> > > > +	}
> > > > +
> > > > +	isp->isys =3D ipu7_isys_init(pdev, dev, isys_ctrl,
> > > > isys_base,
> > > > +				=C2=A0=C2=A0 isys_ipdata, 0);
> > > > +	if (IS_ERR(isp->isys)) {
> > > > +		ret =3D PTR_ERR(isp->isys);
> > > > +		goto out_ipu_bus_del_devices;
> > > > +	}
> > > > +
> > > > +	psys_ctrl =3D devm_kmemdup(dev, psys_buttress_ctrl,
> > > > +				 sizeof(*psys_buttress_ctrl),
> > > > GFP_KERNEL);
> > > > +	if (!psys_ctrl) {
> > > > +		ret =3D -ENOMEM;
> > > > +		goto out_ipu_bus_del_devices;
> > > > +	}
> > > > +
> > > > +	isp->psys =3D ipu7_psys_init(pdev, &isp->isys-
> > > > >auxdev.dev,
> > > > +				=C2=A0=C2=A0 psys_ctrl, psys_base,
> > > > +				=C2=A0=C2=A0 psys_ipdata, 0);
> > > > +	if (IS_ERR(isp->psys)) {
> > > > +		ret =3D PTR_ERR(isp->psys);
> > > > +		goto out_ipu_bus_del_devices;
> > > > +	}
> > > > +
> > > > +	ret =3D devm_request_threaded_irq(dev, pdev->irq,
> > > > +					ipu_buttress_isr,
> > > > +					ipu_buttress_isr_threa
> > > > de
> > > > d,
> > > > +					IRQF_SHARED, IPU_NAME,
> > > > isp);
> > > > +	if (ret)
> > > > +		goto out_ipu_bus_del_devices;
> > > > +
> > > > +	if (!isp->secure_mode) {
> > > > +		ret =3D ipu7_init_fw_code_region(isp);
> > > > +		if (ret)
> > > > +			goto out_ipu_bus_del_devices;
> > > > +	} else {
> > > > +		ret =3D pm_runtime_get_sync(&isp->psys-
> > > > > auxdev.dev);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&isp->psys->auxdev.dev,
> > > > +				"Failed to get runtime PM\n");
> > > > +			goto out_ipu_bus_del_devices;
> > > > +		}
> > > > +
> > > > +		ret =3D ipu7_mmu_hw_init(isp->psys->mmu);
> > > > +		if (ret) {
> > > > +			dev_err_probe(&isp->pdev->dev, ret,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to init MMU
> > > > hardware\n");
> > > > +			goto out_ipu_bus_del_devices;
> > > > +		}
> > > > +
> > > > +		ret =3D ipu7_map_fw_code_region(isp->psys,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)isp-
> > > > > cpd_fw-
> > > > > data,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isp->cpd_fw-
> > > > > size);
> > > > +		if (ret) {
> > > > +			dev_err_probe(&isp->pdev->dev, ret,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to map fw
> > > > image\n");
> > > > +			goto out_ipu_bus_del_devices;
> > > > +		}
> > > > +
> > > > +		ret =3D ipu_buttress_authenticate(isp);
> > > > +		if (ret) {
> > > > +			dev_err_probe(&isp->pdev->dev, ret,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "FW authentication
> > > > failed\n");
> > > > +			goto out_ipu_bus_del_devices;
> > > > +		}
> > > > +
> > > > +		ipu7_mmu_hw_cleanup(isp->psys->mmu);
> > > > +		pm_runtime_put(&isp->psys->auxdev.dev);
> > > > +	}
> > > > +
> > > > +	pm_runtime_put_noidle(dev);
> > > > +	pm_runtime_allow(dev);
> > > > +
> > > > +	isp->ipu7_bus_ready_to_probe =3D true;
> > > > +
> > > > +	return 0;
> > > > +
> > > > +out_ipu_bus_del_devices:
> > > > +	if (!IS_ERR_OR_NULL(isp->isys) && isp->isys-
> > > > > fw_sgt.nents)
> > > > +		ipu7_unmap_fw_code_region(isp->isys);
> > > > +	if (!IS_ERR_OR_NULL(isp->psys) && isp->psys-
> > > > > fw_sgt.nents)
> > > > +		ipu7_unmap_fw_code_region(isp->psys);
> > > > +	if (!IS_ERR_OR_NULL(isp->psys) && !IS_ERR_OR_NULL(isp-
> > > > > psys-
> > > > > mmu))
> > > > +		ipu7_mmu_cleanup(isp->psys->mmu);
> > > > +	if (!IS_ERR_OR_NULL(isp->isys) && !IS_ERR_OR_NULL(isp-
> > > > > isys-
> > > > > mmu))
> > > > +		ipu7_mmu_cleanup(isp->isys->mmu);
> > > > +	if (!IS_ERR_OR_NULL(isp->psys))
> > > > +		pm_runtime_put(&isp->psys->auxdev.dev);
> > > > +	ipu7_bus_del_devices(pdev);
> > > > +	release_firmware(isp->cpd_fw);
> > > > +buttress_exit:
> > > > +	ipu_buttress_exit(isp);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void ipu7_pci_remove(struct pci_dev *pdev)
> > > > +{
> > > > +	struct ipu7_device *isp =3D pci_get_drvdata(pdev);
> > > > +
> > > > +	if (!IS_ERR_OR_NULL(isp->isys) && isp->isys-
> > > > > fw_sgt.nents)
> > > > +		ipu7_unmap_fw_code_region(isp->isys);
> > > > +	if (!IS_ERR_OR_NULL(isp->psys) && isp->psys-
> > > > > fw_sgt.nents)
> > > > +		ipu7_unmap_fw_code_region(isp->psys);
> > > > +
> > > > +	if (!IS_ERR_OR_NULL(isp->fw_code_region))
> > > > +		vfree(isp->fw_code_region);
> > > > +
> > > > +	ipu7_bus_del_devices(pdev);
> > > > +
> > > > +	pm_runtime_forbid(&pdev->dev);
> > > > +	pm_runtime_get_noresume(&pdev->dev);
> > > > +
> > > > +	pci_release_regions(pdev);
> > >=20
> > > You don't need this if you request with a pcim_ function. The 'm'
> > > stands for "managed". Those are devres functions that will clean
> > > up
> > > automatically if probe() fails or once remove() is invoked.
> > >=20
> > > Furthermore, you should not mix pcim_ and pci_ functions; at
> > > least
> > > not
> > > those.
> > >=20
> > > And even if the pcim_ functions wouldn't do a cleanup, you would
> > > leak
> > > the IO mappings above, since pci_release_regions() just removes
> > > the
> > > region requests, but not the mapping cookies.
> > >=20
> > > I recommend taking a look to the PCI subystem's documentation.
> > >=20
> > > > +	pci_disable_device(pdev);
> > >=20
> > > You also don't need this since you used pcim_enable_device(),
> > > which
> > > will disable the device automatically on driver-detach.
> > >=20
> > >=20
> > > P.
> > >=20
> > > > +
> > > > +	ipu_buttress_exit(isp);
> > > > +
> > > > +	release_firmware(isp->cpd_fw);
> > > > +
> > > > +	ipu7_mmu_cleanup(isp->psys->mmu);
> > > > +	ipu7_mmu_cleanup(isp->isys->mmu);
> > > > +}
> > > > +
> > > > +static void ipu7_pci_reset_prepare(struct pci_dev *pdev)
> > > > +{
> > > > +	struct ipu7_device *isp =3D pci_get_drvdata(pdev);
> > > > +
> > > > +	dev_warn(&pdev->dev, "FLR prepare\n");
> > > > +	pm_runtime_forbid(&isp->pdev->dev);
> > > > +}
> > > > +
> > > > +static void ipu7_pci_reset_done(struct pci_dev *pdev)
> > > > +{
> > > > +	struct ipu7_device *isp =3D pci_get_drvdata(pdev);
> > > > +
> > > > +	ipu_buttress_restore(isp);
> > > > +	if (isp->secure_mode)
> > > > +		ipu_buttress_reset_authentication(isp);
> > > > +
> > > > +	isp->ipc_reinit =3D true;
> > > > +	pm_runtime_allow(&isp->pdev->dev);
> > > > +
> > > > +	dev_warn(&pdev->dev, "FLR completed\n");
> > > > +}
> > > > +
> > > > +/*
> > > > + * PCI base driver code requires driver to provide these to
> > > > enable
> > > > + * PCI device level PM state transitions (D0<->D3)
> > > > + */
> > > > +static int ipu7_suspend(struct device *dev)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ipu7_resume(struct device *dev)
> > > > +{
> > > > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > > > +	struct ipu7_device *isp =3D pci_get_drvdata(pdev);
> > > > +	struct ipu_buttress *b =3D &isp->buttress;
> > > > +	int ret;
> > > > +
> > > > +	isp->secure_mode =3D ipu_buttress_get_secure_mode(isp);
> > > > +	dev_info(dev, "IPU7 in %s mode\n",
> > > > +		 isp->secure_mode ? "secure" : "non-secure");
> > > > +
> > > > +	ipu_buttress_restore(isp);
> > > > +
> > > > +	ret =3D ipu_buttress_ipc_reset(isp, &b->cse);
> > > > +	if (ret)
> > > > +		dev_err(dev, "IPC reset protocol failed!\n");
> > > > +
> > > > +	ret =3D pm_runtime_get_sync(&isp->psys->auxdev.dev);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "Failed to get runtime PM\n");
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	ret =3D ipu_buttress_authenticate(isp);
> > > > +	if (ret)
> > > > +		dev_err(dev, "FW authentication failed(%d)\n",
> > > > ret);
> > > > +
> > > > +	pm_runtime_put(&isp->psys->auxdev.dev);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ipu7_runtime_resume(struct device *dev)
> > > > +{
> > > > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > > > +	struct ipu7_device *isp =3D pci_get_drvdata(pdev);
> > > > +	int ret;
> > > > +
> > > > +	ipu_buttress_restore(isp);
> > > > +
> > > > +	if (isp->ipc_reinit) {
> > > > +		struct ipu_buttress *b =3D &isp->buttress;
> > > > +
> > > > +		isp->ipc_reinit =3D false;
> > > > +		ret =3D ipu_buttress_ipc_reset(isp, &b->cse);
> > > > +		if (ret)
> > > > +			dev_err(dev, "IPC reset protocol
> > > > failed!\n");
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct dev_pm_ops ipu7_pm_ops =3D {
> > > > +	SET_SYSTEM_SLEEP_PM_OPS(&ipu7_suspend, &ipu7_resume)
> > > > +	SET_RUNTIME_PM_OPS(&ipu7_suspend,	/* Same as in
> > > > suspend flow */
> > > > +			=C2=A0=C2=A0 &ipu7_runtime_resume,
> > > > +			=C2=A0=C2=A0 NULL)
> > > > +};
> > > > +
> > > > +static const struct pci_device_id ipu7_pci_tbl[] =3D {
> > > > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, IPU7_PCI_ID)},
> > > > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, IPU7P5_PCI_ID)},
> > > > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, IPU8_PCI_ID)},
> > > > +	{0,}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(pci, ipu7_pci_tbl);
> > > > +
> > > > +static const struct pci_error_handlers pci_err_handlers =3D {
> > > > +	.reset_prepare =3D ipu7_pci_reset_prepare,
> > > > +	.reset_done =3D ipu7_pci_reset_done,
> > > > +};
> > > > +
> > > > +static struct pci_driver ipu7_pci_driver =3D {
> > > > +	.name =3D IPU_NAME,
> > > > +	.id_table =3D ipu7_pci_tbl,
> > > > +	.probe =3D ipu7_pci_probe,
> > > > +	.remove =3D ipu7_pci_remove,
> > > > +	.driver =3D {
> > > > +		.pm =3D &ipu7_pm_ops,
> > > > +	},
> > > > +	.err_handler =3D &pci_err_handlers,
> > > > +};
> > > > +
> > > > +module_pci_driver(ipu7_pci_driver);
> > > > +
> > > > +MODULE_IMPORT_NS("INTEL_IPU_BRIDGE");
> > > > +MODULE_AUTHOR("Bingbu Cao <bingbu.cao@intel.com>");
> > > > +MODULE_AUTHOR("Tianshu Qiu <tian.shu.qiu@intel.com>");
> > > > +MODULE_AUTHOR("Qingwu Zhang <qingwu.zhang@intel.com>");
> > > > +MODULE_AUTHOR("Intel");
> > > > +MODULE_LICENSE("GPL");
> > > > +MODULE_DESCRIPTION("Intel ipu7 pci driver");
> > > > diff --git a/drivers/media/pci/intel/ipu7/ipu7.h
> > > > b/drivers/media/pci/intel/ipu7/ipu7.h
> > > > new file mode 100644
> > > > index 000000000000..6f5705f403b7
> > > > --- /dev/null
> > > > +++ b/drivers/media/pci/intel/ipu7/ipu7.h
> > > > @@ -0,0 +1,244 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (C) 2013 - 2024 Intel Corporation
> > > > + */
> > > > +
> > > > +#ifndef IPU7_H
> > > > +#define IPU7_H
> > > > +
> > > > +#include <linux/list.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#include "ipu7-buttress.h"
> > > > +
> > > > +struct ipu7_bus_device;
> > > > +struct pci_dev;
> > > > +struct firmware;
> > > > +
> > > > +#define IPU_NAME			"intel-ipu7"
> > > > +#define IPU_MEDIA_DEV_MODEL_NAME	"ipu7"
> > > > +
> > > > +#define
> > > > IPU7_FIRMWARE_NAME		"intel/ipu/ipu7_fw.bin"
> > > > +#define
> > > > IPU7P5_FIRMWARE_NAME		"intel/ipu/ipu7ptl_fw.bin"
> > > > +#define
> > > > IPU8_FIRMWARE_NAME		"intel/ipu/ipu8_fw.bin"
> > > > +
> > > > +#define IPU7_ISYS_NUM_STREAMS		12
> > > > +
> > > > +#define IPU7_PCI_ID			0x645d
> > > > +#define IPU7P5_PCI_ID			0xb05d
> > > > +#define IPU8_PCI_ID			0xd719
> > > > +
> > > > +#define FW_LOG_BUF_SIZE			(2 * 1024 *
> > > > 1024)
> > > > +
> > > > +enum ipu_version {
> > > > +	IPU_VER_INVALID =3D 0,
> > > > +	IPU_VER_7 =3D 1,
> > > > +	IPU_VER_7P5 =3D 2,
> > > > +	IPU_VER_8 =3D 3,
> > > > +};
> > > > +
> > > > +static inline bool is_ipu7p5(u8 hw_ver)
> > > > +{
> > > > +	return hw_ver =3D=3D IPU_VER_7P5;
> > > > +}
> > > > +
> > > > +static inline bool is_ipu7(u8 hw_ver)
> > > > +{
> > > > +	return hw_ver =3D=3D IPU_VER_7;
> > > > +}
> > > > +
> > > > +static inline bool is_ipu8(u8 hw_ver)
> > > > +{
> > > > +	return hw_ver =3D=3D IPU_VER_8;
> > > > +}
> > > > +
> > > > +#define IPU_UNIFIED_OFFSET		0
> > > > +
> > > > +/*
> > > > + * ISYS DMA can overshoot. For higher resolutions over
> > > > allocation is
> > > > one line
> > > > + * but it must be at minimum 1024 bytes. Value could be
> > > > different in
> > > > + * different versions / generations thus provide it via
> > > > platform
> > > > data.
> > > > + */
> > > > +#define IPU_ISYS_OVERALLOC_MIN		1024
> > > > +
> > > > +#define IPU_FW_CODE_REGION_SIZE		0x1000000 /*
> > > > 16MB */
> > > > +#define IPU_FW_CODE_REGION_START	0x4000000 /* 64MB */
> > > > +#define
> > > > IPU_FW_CODE_REGION_END		(IPU_FW_CODE_REGION_START
> > > > +	\
> > > > +				=09
> > > > IPU_FW_CODE_REGION_SIZE) /*
> > > > 80MB */
> > > > +
> > > > +struct ipu7_device {
> > > > +	struct pci_dev *pdev;
> > > > +	struct list_head devices;
> > > > +	struct ipu7_bus_device *isys;
> > > > +	struct ipu7_bus_device *psys;
> > > > +	struct ipu_buttress buttress;
> > > > +
> > > > +	const struct firmware *cpd_fw;
> > > > +	const char *cpd_fw_name;
> > > > +	/* Only for non-secure mode. */
> > > > +	void *fw_code_region;
> > > > +
> > > > +	void __iomem *base;
> > > > +	void __iomem *pb_base;
> > > > +	u8 hw_ver;
> > > > +	bool ipc_reinit;
> > > > +	bool secure_mode;
> > > > +	bool ipu7_bus_ready_to_probe;
> > > > +};
> > > > +
> > > > +#define IPU_DMA_MASK			39
> > > > +#define IPU_LIB_CALL_TIMEOUT_MS		2000
> > > > +#define IPU_PSYS_CMD_TIMEOUT_MS		2000
> > > > +#define IPU_PSYS_OPEN_CLOSE_TIMEOUT_US	50
> > > > +#define IPU_PSYS_OPEN_CLOSE_RETRY	(10000 /
> > > > IPU_PSYS_OPEN_CLOSE_TIMEOUT_US)
> > > > +
> > > > +#define IPU_ISYS_NAME "isys"
> > > > +#define IPU_PSYS_NAME "psys"
> > > > +
> > > > +#define IPU_MMU_ADDR_BITS		32
> > > > +/* FW is accessible within the first 2 GiB only in non-secure
> > > > mode.
> > > > */
> > > > +#define IPU_MMU_ADDR_BITS_NON_SECURE	31
> > > > +
> > > > +#define IPU7_IS_MMU_NUM			4
> > > > +#define IPU7_PS_MMU_NUM			4
> > > > +#define IPU7P5_IS_MMU_NUM		4
> > > > +#define IPU7P5_PS_MMU_NUM		4
> > > > +#define IPU8_IS_MMU_NUM			5
> > > > +#define IPU8_PS_MMU_NUM			4
> > > > +#define IPU_MMU_MAX_NUM			5 /* max(IS,
> > > > PS)
> > > > */
> > > > +#define IPU_MMU_MAX_TLB_L1_STREAMS	40
> > > > +#define IPU_MMU_MAX_TLB_L2_STREAMS	40
> > > > +#define IPU_ZLX_MAX_NUM			32
> > > > +#define IPU_ZLX_POOL_NUM		8
> > > > +#define IPU_UAO_PLANE_MAX_NUM		64
> > > > +
> > > > +/*
> > > > + * To maximize the IOSF utlization, IPU need to send requests
> > > > in
> > > > bursts.
> > > > + * At the DMA interface with the buttress, there are CDC FIFOs
> > > > with
> > > > burst
> > > > + * collection capability. CDC FIFO burst collectors have a
> > > > configurable
> > > > + * threshold and is configured based on the outcome of
> > > > performance
> > > > measurements.
> > > > + *
> > > > + * isys has 3 ports with IOSF interface for VC0, VC1 and VC2
> > > > + * psys has 4 ports with IOSF interface for VC0, VC1w, VC1r
> > > > and
> > > > VC2
> > > > + *
> > > > + * Threshold values are pre-defined and are arrived at after
> > > > performance
> > > > + * evaluations on a type of IPU
> > > > + */
> > > > +#define IPU_MAX_VC_IOSF_PORTS		4
> > > > +
> > > > +/*
> > > > + * IPU must configure correct arbitration mechanism related to
> > > > the
> > > > IOSF VC
> > > > + * requests. There are two options per VC0 and VC1 - > 0 means
> > > > rearbitrate on
> > > > + * stall and 1 means stall until the request is completed.
> > > > + */
> > > > +#define IPU_BTRS_ARB_MODE_TYPE_REARB	0
> > > > +#define IPU_BTRS_ARB_MODE_TYPE_STALL	1
> > > > +
> > > > +/* Currently chosen arbitration mechanism for VC0 */
> > > > +#define
> > > > IPU_BTRS_ARB_STALL_MODE_VC0	IPU_BTRS_ARB_MODE_TYPE_REARB
> > > > +
> > > > +/* Currently chosen arbitration mechanism for VC1 */
> > > > +#define
> > > > IPU_BTRS_ARB_STALL_MODE_VC1	IPU_BTRS_ARB_MODE_TYPE_REARB
> > > > +
> > > > +struct ipu7_isys_subdev_pdata;
> > > > +
> > > > +/* One L2 entry maps 1024 L1 entries and one L1 entry per page
> > > > */
> > > > +#define IPU_MMUV2_L2_RANGE		(1024 * PAGE_SIZE)
> > > > +/* Max L2 blocks per stream */
> > > > +#define IPU_MMUV2_MAX_L2_BLOCKS		2
> > > > +/* Max L1 blocks per stream */
> > > > +#define IPU_MMUV2_MAX_L1_BLOCKS		16
> > > > +#define IPU_MMUV2_TRASH_RANGE		(IPU_MMUV2_L2_RANGE
> > > > *	\
> > > > +				=09
> > > > IPU_MMUV2_MAX_L2_BLOCKS)
> > > > +/* Entries per L1 block */
> > > > +#define MMUV2_ENTRIES_PER_L1_BLOCK	16
> > > > +#define
> > > > MMUV2_TRASH_L1_BLOCK_OFFSET	(MMUV2_ENTRIES_PER_L1_BLOCK
> > > > * PAGE_SIZE)
> > > > +#define MMUV2_TRASH_L2_BLOCK_OFFSET	IPU_MMUV2_L2_RANGE
> > > > +
> > > > +struct ipu7_mmu_hw {
> > > > +	char name[32];
> > > > +
> > > > +	void __iomem *base;
> > > > +	void __iomem *zlx_base;
> > > > +	void __iomem *uao_base;
> > > > +
> > > > +	u32 offset;
> > > > +	u32 zlx_offset;
> > > > +	u32 uao_offset;
> > > > +
> > > > +	u32 info_bits;
> > > > +	u32 refill;
> > > > +	u32 collapse_en_bitmap;
> > > > +	u32 at_sp_arb_cfg;
> > > > +
> > > > +	u32 l1_block;
> > > > +	u32 l2_block;
> > > > +
> > > > +	u8 nr_l1streams;
> > > > +	u8 nr_l2streams;
> > > > +	u32 l1_block_sz[IPU_MMU_MAX_TLB_L1_STREAMS];
> > > > +	u32 l2_block_sz[IPU_MMU_MAX_TLB_L2_STREAMS];
> > > > +
> > > > +	u8 zlx_nr;
> > > > +	u32 zlx_axi_pool[IPU_ZLX_POOL_NUM];
> > > > +	u32 zlx_en[IPU_ZLX_MAX_NUM];
> > > > +	u32 zlx_conf[IPU_ZLX_MAX_NUM];
> > > > +
> > > > +	u32 uao_p_num;
> > > > +	u32 uao_p2tlb[IPU_UAO_PLANE_MAX_NUM];
> > > > +};
> > > > +
> > > > +struct ipu7_mmu_pdata {
> > > > +	u32 nr_mmus;
> > > > +	struct ipu7_mmu_hw mmu_hw[IPU_MMU_MAX_NUM];
> > > > +	int mmid;
> > > > +};
> > > > +
> > > > +struct ipu7_isys_csi2_pdata {
> > > > +	void __iomem *base;
> > > > +};
> > > > +
> > > > +struct ipu7_isys_internal_csi2_pdata {
> > > > +	u32 nports;
> > > > +	u32 *offsets;
> > > > +	u32 gpreg;
> > > > +};
> > > > +
> > > > +struct ipu7_hw_variants {
> > > > +	unsigned long offset;
> > > > +	u32 nr_mmus;
> > > > +	struct ipu7_mmu_hw mmu_hw[IPU_MMU_MAX_NUM];
> > > > +	u8 cdc_fifos;
> > > > +	u8 cdc_fifo_threshold[IPU_MAX_VC_IOSF_PORTS];
> > > > +	u32 dmem_offset;
> > > > +	u32 spc_offset;	/* SPC offset from psys base
> > > > */
> > > > +};
> > > > +
> > > > +struct ipu_isys_internal_pdata {
> > > > +	struct ipu7_isys_internal_csi2_pdata csi2;
> > > > +	struct ipu7_hw_variants hw_variant;
> > > > +	u32 num_parallel_streams;
> > > > +	u32 isys_dma_overshoot;
> > > > +};
> > > > +
> > > > +struct ipu7_isys_pdata {
> > > > +	void __iomem *base;
> > > > +	const struct ipu_isys_internal_pdata *ipdata;
> > > > +};
> > > > +
> > > > +struct ipu_psys_internal_pdata {
> > > > +	struct ipu7_hw_variants hw_variant;
> > > > +};
> > > > +
> > > > +struct ipu7_psys_pdata {
> > > > +	void __iomem *base;
> > > > +	const struct ipu_psys_internal_pdata *ipdata;
> > > > +};
> > > > +
> > > > +int request_cpd_fw(const struct firmware **firmware_p, const
> > > > char
> > > > *name,
> > > > +		=C2=A0=C2=A0 struct device *device);
> > > > +void ipu_internal_pdata_init(struct ipu_isys_internal_pdata
> > > > *isys_ipdata,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct ipu_psys_internal_pdata
> > > > *psys_ipdata);
> > > > +void ipu7_dump_fw_error_log(const struct ipu7_bus_device
> > > > *adev);
> > > > +#endif /* IPU7_H */
> > >=20
> >=20
>=20


