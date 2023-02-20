Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908D69D293
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 19:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjBTSKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 13:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBTSKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 13:10:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641720D27
        for <linux-pci@vger.kernel.org>; Mon, 20 Feb 2023 10:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10CB3B80DB0
        for <linux-pci@vger.kernel.org>; Mon, 20 Feb 2023 18:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6B3C433EF;
        Mon, 20 Feb 2023 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676916638;
        bh=xw6rNy1w9tQ/5Fyu0QJB4tOVRWJrG6kX6To8ynDx0Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQKDPJe/SDsGsIJNMf7iXPQPEw+pzBQKHcFjvDnN8z2JR6Ps/wRRM7J1RT5NPwuzG
         EnrfvrRBRMS5cYCVECZGNN7vC2idZQU8Ik5DQzub+tn6q2FFx1iGr6gdnC2WkqD1CQ
         h//tSzP0nBFad/WY0ARu9ifPdMnU0LmXlQEsCrcXLCkTE5WyRkdHlnI0E21wpcAJ/X
         nYP7/4bzb9uI76712PtqHDwhGQqDO98Xiafm2e8Ub8kOD/X2FbRarLWyU9NOya1o/i
         zsra8QTIxiFDUIxwFvfnMC6G9tt8l1mD2RGn5sJYYkujz2vn8ATqr2jUaKAtjIVoJ2
         C8Isg+1PvPtXA==
Date:   Mon, 20 Feb 2023 18:10:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
Message-ID: <Y/O3mXPe5zAQvMOz@sirena.org.uk>
References: <63f141b2.170a0220.57e67.6c7c@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eTRkipbTfAVWpHls"
Content-Disposition: inline
In-Reply-To: <63f141b2.170a0220.57e67.6c7c@mx.google.com>
X-Cookie: Adapt.  Enjoy.  Survive.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--eTRkipbTfAVWpHls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2023 at 01:22:58PM -0800, KernelCI bot wrote:

The KernelCI bisection bot identified a failure to probe the Intel GBE
driver on kontron-pitx-imx8m as coming from commit 75c2f26da03f ("PCI:
imx6: Add i.MX PCIe EP mode support").  Looking at the commit it's
changed PCI_IMX6 to be selected by two new options PCI_IMX6_HOST and
PCI_IMX6_EP but there's been no corresponding update to defconfig so=20
the arm64 defconfig, it just has CONFIG_PCI_IMX6=3Dy which gets deselected
automatically.  This is going to affect all PCI on i.MX platforms.  I'll
send a patch.

The issue can be seen on today's -next with a plain defconfig:

   https://linux.kernelci.org/test/plan/id/63f32296682b9971318c8653/

The defconfig we generate is at:

   https://storage.kernelci.org/next/master/next-20230220/arm64/defconfig/c=
lang-17/config/kernel.config

Full details from the bot, including a tag for it and bisection log
below:

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> next/master bisection: baseline.bootrr.intel-igb-probed on kontron-pitx-i=
mx8m
>=20
> Summary:
>   Start:      9d9019bcea1a Add linux-next specific files for 20230215
>   Plain log:  https://storage.kernelci.org/next/master/next-20230215/arm6=
4/defconfig+videodec/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20230215/arm6=
4/defconfig+videodec/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
>   Result:     75c2f26da03f PCI: imx6: Add i.MX PCIe EP mode support
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
>   Branch:     master
>   Target:     kontron-pitx-imx8m
>   CPU arch:   arm64
>   Lab:        lab-kontron
>   Compiler:   gcc-10
>   Config:     defconfig+videodec
>   Test case:  baseline.bootrr.intel-igb-probed
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit 75c2f26da03f93e988cd7678722ea893a8c63796
> Author: Richard Zhu <hongxing.zhu@nxp.com>
> Date:   Mon Jan 16 13:41:21 2023 +0800
>=20
>     PCI: imx6: Add i.MX PCIe EP mode support
>    =20
>     i.MX PCIe is one dual mode PCIe controller.
>    =20
>     Add i.MX PCIe EP mode support here, and split the PCIe modes to the R=
oot
>     Complex mode and Endpoint mode.
>    =20
>     Link: https://lore.kernel.org/r/1673847684-31893-12-git-send-email-ho=
ngxing.zhu@nxp.com
>     Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>     Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index a0d2713f0e88..dffd7fbdfb98 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -92,10 +92,31 @@ config PCI_EXYNOS
>  	  functions to implement the driver.
> =20
>  config PCI_IMX6
> -	bool "Freescale i.MX6/7/8 PCIe controller"
> +	bool
> +
> +config PCI_IMX6_HOST
> +	bool "Freescale i.MX6/7/8 PCIe controller host mode"
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
> +	select PCI_IMX6
> +	help
> +	  Enables support for the PCIe controller in the i.MX SoCs to
> +	  work in Root Complex mode. The PCI controller on i.MX is based
> +	  on DesignWare hardware and therefore the driver re-uses the
> +	  DesignWare core functions to implement the driver.
> +
> +config PCI_IMX6_EP
> +	bool "Freescale i.MX6/7/8 PCIe controller endpoint mode"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCI_IMX6
> +	help
> +	  Enables support for the PCIe controller in the i.MX SoCs to
> +	  work in endpoint mode. The PCI controller on i.MX is based
> +	  on DesignWare hardware and therefore the driver re-uses the
> +	  DesignWare core functions to implement the driver.
> =20
>  config PCIE_SPEAR13XX
>  	bool "STMicroelectronics SPEAr PCIe controller"
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 1dde5c579edc..572faa91eea7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -60,6 +60,7 @@ enum imx6_pcie_variants {
> =20
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
> +	enum dw_pcie_device_mode mode;
>  	u32 flags;
>  	int dbi_length;
>  	const char *gpr;
> @@ -159,17 +160,20 @@ static unsigned int imx6_pcie_grp_offset(const stru=
ct imx6_pcie *imx6_pcie)
> =20
>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  {
> -	unsigned int mask, val;
> +	unsigned int mask, val, mode;
> +
> +	if (imx6_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE)
> +		mode =3D PCI_EXP_TYPE_ENDPOINT;
> +	else
> +		mode =3D PCI_EXP_TYPE_ROOT_PORT;
> =20
>  	if (imx6_pcie->drvdata->variant =3D=3D IMX8MQ &&
>  	    imx6_pcie->controller_id =3D=3D 1) {
>  		mask =3D IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
> -		val  =3D FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> -				  PCI_EXP_TYPE_ROOT_PORT);
> +		val  =3D FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE, mode);
>  	} else {
>  		mask =3D IMX6Q_GPR12_DEVICE_TYPE;
> -		val  =3D FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
> -				  PCI_EXP_TYPE_ROOT_PORT);
> +		val  =3D FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
>  	}
> =20
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> @@ -1003,8 +1007,99 @@ static const struct dw_pcie_host_ops imx6_pcie_hos=
t_ops =3D {
> =20
>  static const struct dw_pcie_ops dw_pcie_ops =3D {
>  	.start_link =3D imx6_pcie_start_link,
> +	.stop_link =3D imx6_pcie_stop_link,
> +};
> +
> +static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	enum pci_barno bar;
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +
> +	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				  enum pci_epc_irq_type type,
> +				  u16 interrupt_num)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features imx8m_pcie_epc_features =3D {
> +	.linkup_notifier =3D false,
> +	.msi_capable =3D true,
> +	.msix_capable =3D false,
> +	.reserved_bar =3D 1 << BAR_1 | 1 << BAR_3,
> +	.align =3D SZ_64K,
> +};
> +
> +static const struct pci_epc_features*
> +imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &imx8m_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> +	.ep_init =3D imx6_pcie_ep_init,
> +	.raise_irq =3D imx6_pcie_ep_raise_irq,
> +	.get_features =3D imx6_pcie_ep_get_features,
>  };
> =20
> +static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> +			   struct platform_device *pdev)
> +{
> +	int ret;
> +	unsigned int pcie_dbi2_offset;
> +	struct dw_pcie_ep *ep;
> +	struct resource *res;
> +	struct dw_pcie *pci =3D imx6_pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct device *dev =3D pci->dev;
> +
> +	imx6_pcie_host_init(pp);
> +	ep =3D &pci->ep;
> +	ep->ops =3D &pcie_ep_ops;
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	default:
> +		pcie_dbi2_offset =3D SZ_4K;
> +		break;
> +	}
> +	pci->dbi_base2 =3D pci->dbi_base + pcie_dbi2_offset;
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space"=
);
> +	if (!res)
> +		return -EINVAL;
> +
> +	ep->phys_base =3D res->start;
> +	ep->addr_size =3D resource_size(res);
> +	ep->page_size =3D SZ_64K;
> +
> +	ret =3D dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize endpoint\n");
> +		return ret;
> +	}
> +	/* Start LTSSM. */
> +	imx6_pcie_ltssm_enable(dev);
> +
> +	return 0;
> +}
> +
>  static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  {
>  	struct device *dev =3D imx6_pcie->pci->dev;
> @@ -1279,15 +1374,22 @@ static int imx6_pcie_probe(struct platform_device=
 *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D dw_pcie_host_init(&pci->pp);
> -	if (ret < 0)
> -		return ret;
> +	if (imx6_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE) {
> +		ret =3D imx6_add_pcie_ep(imx6_pcie, pdev);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret =3D dw_pcie_host_init(&pci->pp);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (pci_msi_enabled()) {
> +			u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> =20
> -	if (pci_msi_enabled()) {
> -		u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> -		val =3D dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> -		val |=3D PCI_MSI_FLAGS_ENABLE;
> -		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> +			val =3D dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> +			val |=3D PCI_MSI_FLAGS_ENABLE;
> +			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> +		}
>  	}
> =20
>  	return 0;
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [d5a1224aa68c8b124a4c5c390186e571815ed390] drm/i915/gen11: Wa_140=
8615072/Wa_1407596294 should be on GT list
> git bisect good d5a1224aa68c8b124a4c5c390186e571815ed390
> # bad: [9d9019bcea1aac7eed64a1a4966282b6b7b141c8] Add linux-next specific=
 files for 20230215
> git bisect bad 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
> # bad: [e8b85852ecfd21f4aca6456423c7e7eebd4de095] Merge branch 'master' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect bad e8b85852ecfd21f4aca6456423c7e7eebd4de095
> # good: [230c2111794b1c5547149a9378fede8407a5f585] Merge branch 'nfsd-nex=
t' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
> git bisect good 230c2111794b1c5547149a9378fede8407a5f585
> # good: [7cd8200555d4f01183f0b9071e0760c389a51816] wifi: rtw89: coex: Ref=
ine coexistence log
> git bisect good 7cd8200555d4f01183f0b9071e0760c389a51816
> # bad: [321bd02ae8d76684597db34f3a43bb39988f4e3e] Merge branch 'master' o=
f git://linuxtv.org/mchehab/media-next.git
> git bisect bad 321bd02ae8d76684597db34f3a43bb39988f4e3e
> # bad: [80c52d59cb5d51a2a1e10b2c4f4ef6adb92049cd] Merge branch 'i3c/next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
> git bisect bad 80c52d59cb5d51a2a1e10b2c4f4ef6adb92049cd
> # good: [32feb85935981e8cd3b44efa5d0e636f6000c29c] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
> git bisect good 32feb85935981e8cd3b44efa5d0e636f6000c29c
> # good: [760f504ec490c502a27b477089baecc5f3dab4db] Merge branch 'for-6.3/=
logitech' into for-next
> git bisect good 760f504ec490c502a27b477089baecc5f3dab4db
> # bad: [c51b1767b4df2c81270ab6942ab84675341c21ed] Merge branch 'pci/contr=
oller/mvebu'
> git bisect bad c51b1767b4df2c81270ab6942ab84675341c21ed
> # good: [0e159888fa3b75c8d9bddb1186552c5bd1496816] Merge branch 'pci/endp=
oint'
> git bisect good 0e159888fa3b75c8d9bddb1186552c5bd1496816
> # good: [7119685cf49033b777c559ae4da093be2a9b225c] dmaengine: dw-edma: Dr=
op DT-region allocation
> git bisect good 7119685cf49033b777c559ae4da093be2a9b225c
> # good: [87616c47e354eec4e64baffa1779ba2b30e51120] Merge branch 'pci/cont=
roller/dwc'
> git bisect good 87616c47e354eec4e64baffa1779ba2b30e51120
> # bad: [530ba41250b69db4b5beb9fc03bd7183881c5e7f] PCI: imx6: Add i.MX8MQ =
PCIe EP support
> git bisect bad 530ba41250b69db4b5beb9fc03bd7183881c5e7f
> # good: [2dd6dc57d2da459983ded133767d0389194f15b8] dt-bindings: imx6q-pci=
e: Add i.MX8MP PCIe EP mode compatible string
> git bisect good 2dd6dc57d2da459983ded133767d0389194f15b8
> # bad: [75c2f26da03f93e988cd7678722ea893a8c63796] PCI: imx6: Add i.MX PCI=
e EP mode support
> git bisect bad 75c2f26da03f93e988cd7678722ea893a8c63796
> # good: [01ea5ede419733fdc39e75875f0861d16a829fe6] misc: pci_endpoint_tes=
t: Add i.MX8 PCIe EP device support
> git bisect good 01ea5ede419733fdc39e75875f0861d16a829fe6
> # first bad commit: [75c2f26da03f93e988cd7678722ea893a8c63796] PCI: imx6:=
 Add i.MX PCIe EP mode support
> -------------------------------------------------------------------------=
------
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#38383): https://groups.io/g/kernelci-results/message/=
38383
> Mute This Topic: https://groups.io/mt/97056400/1131744
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.o=
rg]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--eTRkipbTfAVWpHls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPzt5gACgkQJNaLcl1U
h9BALQf/ZDSPca1+8G0//23/XqCEfyXaW9LbIsipXhqv4yVjMhPZzeg1ryF8KEeB
PQTHZdMRhbM/WJSR3xxz2kz8QCtp3xoFf1mDiNJzMXuzTf/jd4XTpepQ+RtBpPK0
5vCT3X3pINszEja/QXfFnkmT76/sU2PoJkPfk5CAdrNhJgPwKVSIoJUpFDT9WDVn
aO209+pKODB25nlqlx1r2xUC0i+VixP00Kv4OsNUsroc/3yD3voGTAzw+N5R+tVU
3dpPSbqCpi5+vpvrsNT7kkeRpgs9SjTVRrJZMgLNvx1t+rTux75U/i8nqluRTFKz
Xm0hqM4oiTbM/RQ1MMPGabHFh/onKA==
=UKVM
-----END PGP SIGNATURE-----

--eTRkipbTfAVWpHls--
