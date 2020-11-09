Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280B02AB3B2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgKIJhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 04:37:05 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:25159
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbgKIJhF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 04:37:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuvsebJ/PYWzfM3QF6l3Ci345AbbYQmo++l2z9vorbFV3YzdpfEU7eqrcgCpjurMcUq6Fr5SNv659HOFHFGITW4ewsNwP7rzsRFnwnH1g0Ig2HJPgvnTqso5iiosBjaKI+NC0B8/CQZTd0Q60F+FLanwX/DbIqlIiRSo/uoqhaU6fv1ctgdnnEfbDgh4JNzyhPdoMiqxNi5gLTegu/vwKAxYxCIfx+6lcELpid5H7zHEgI4ZEKiyDauT6qqsMReNARLNCRs+1LYvlwyEbpmbdxVi1ejgJGHRv7voURfeHl6lHvdTRWCQMRaNjgtAIil1ZlJn2yZT/aIxv4mX0JGdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxrWAyiMHZgQQQkYet2icFnuA7R2U9+OW2VwdeWzCGE=;
 b=Kpu0gQD9xnITcFFLXXazBy1OM6KcZ++B4AdYpYZmjTdYFFdVVqsv2uI3RZgc1zpGicDA05O52t5lsfnKtmunjt6HCL2OO0k8Wamkw3rDgIgE9IFfhQ8ewpdy0SE2an/ntbrQm7pwoXbdWzA4JVfdgrcJqQHWECUR2w7E0z5IOsjP9fFsukkCYWkaSlzxU7/w77JHIwX70CUk2TnNdKegkhiK9FaoH5+Q/pWb3zGKNUukH10zx5u1MC67NZUpvbR5tJR4Grq1yc0qCIOuPY/GPGrPC6v7ANyIxh90Ou4t4AwWSQ5W3Tl5SEbXPr2cFIl29TsqveAWqhtkGTXIJ5BB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxrWAyiMHZgQQQkYet2icFnuA7R2U9+OW2VwdeWzCGE=;
 b=J5YthuSvtULu+HXuTZRWCDyVlOdnNP6Y2woKqwqyAc5VaBFpcJvFe2mKcoMW1/bcTMx5KkF1fJyusJwbTiGpKYEkr4oDnXYIUZEPUmuqIPr59YxjuuecAOWN7ONLB+VQcUgdn3Ln9P+vZmmwyJzhqyeDtuh+Xys6MO6pBsJS72g=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VE1PR04MB6654.eurprd04.prod.outlook.com (2603:10a6:803:129::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 09:37:00 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:37:00 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "kishon@ti.com" <kishon@ti.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Thread-Topic: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Thread-Index: AQHWtnmf1Fe2qKyugUaToCGM3cma6am/hnbQ
Date:   Mon, 9 Nov 2020 09:37:00 +0000
Message-ID: <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200930153519.7282-16-kishon@ti.com>
In-Reply-To: <20200930153519.7282-16-kishon@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a611e049-655b-40a5-ff71-08d884930202
x-ms-traffictypediagnostic: VE1PR04MB6654:
x-microsoft-antispam-prvs: <VE1PR04MB6654EAC39463FF35BF7DF69B92EA0@VE1PR04MB6654.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yl7SNtCqUdnWcBUQzAH1lQmASPK32t70Ezaq992rgK3mrpH6SnXKgdgN4J75S7FfF+v8jsNSmhOPES35zFRRR67nQc9EE2amlKsNcFiN/7jHB17gPl3RTLU678OdRGXeHZf7fziAw0mXyzs/bYucaf9MSXCXL+mAKyMC+IHq1pX2nwuhB/VKPtqPsMgNUv1ufm943U8WNT7mKBYLTUhQmJCYisQCTZHk98HTJhlluwzo1bulNONEKJS520Mu185jPZdUnz29Fr2rOxWAkhf7F30E4imlJ4lWSb43CKu26WzXnc1/LPqDrXJ2dvaOMhMn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(9686003)(6916009)(55016002)(4326008)(52536014)(8676002)(7416002)(6506007)(2906002)(8936002)(83380400001)(44832011)(71200400001)(54906003)(7696005)(186003)(316002)(478600001)(66946007)(76116006)(66446008)(26005)(33656002)(66476007)(66556008)(64756008)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tBLiEWDmeHRzglIhcKYosGyOnT9mtfTY3bRM67oZzCI3o8P/gp8IaomDxC4tEMqkpNU9oPEpqtkzC1JM1Eu/Fx+JHH3XrFgGVJQhdCls9LAQHKjQT6GH3ogMna+ZfONdVdVWXThz6qjZd4RoAkkzMOkr+mzit5pTjYORIScoFt+pYuvZPryNE/66QbvrdJrshQD5+iMbshP+JeN5jE7cesPlRe67z3Gf+SL64n0MMBoAhOz84l+G8gQzBVh/VyAQewynYcLe+pRQ3bnYlkAvP2cyAdRaqh9LUJzDbhL4QeqpkVHSZPprnDDKGd2Bxs0+rTtWCKExZddPev8CBwb0aN+C4Mj15lvGhEO6WjK3POlS6dKDquIxONSZ96BED4W94zYROdyCz+YNGKAcrkq7cCvDg8+2sr/hKJzItLGsTg9BcwZHefIOeCKpBNt4QsKVmL/SrHlB/8kSO4J/DW/PJ2y2wGGxrUkG6lKS+fKzixt4D8/DRJTY/YGAtVJs6kVQGhu8IRAKSOMkowED3yTjD54gqUvZTL+jcrCbINsRx5W/JXZT9E4V4JRHfRo+i513q0Kulyobhx5Zkwg1f5lvXwd3jEgX/itcMi0sSHb+XIz74DfD1/itJOWLiQvNV9A1JoMTAYgkOKtQkwGTRibzZw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a611e049-655b-40a5-ff71-08d884930202
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 09:37:00.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvq0lK5hcrQa+WYQBN8RvXLk5kaJ9bq7kOFk66Q2qsfsfzCntWo6HygdjeCzvwLYgLR5qBZr9e+Chu4uyGB7vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6654
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

> Subject: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express Non-
> Transparent Bridge
>=20
> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Add support for EPF PCI-Express Non-Transparent Bridge (NTB) device.
> This driver is platform independent and could be used by any platform whi=
ch
> have multiple PCIe endpoint instances configured using the pci-epf-ntb dr=
iver.
> The driver connnects to the standard NTB sub-system interface. The EPF NT=
B
> device has configurable number of memory windows (Max 4), configurable
> number of doorbell (Max 32), and configurable number of scratch-pad
> registers.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/ntb/hw/Kconfig          |   1 +
>  drivers/ntb/hw/Makefile         |   1 +
>  drivers/ntb/hw/epf/Kconfig      |   6 +
>  drivers/ntb/hw/epf/Makefile     |   1 +
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 755
> ++++++++++++++++++++++++++++++++
>  5 files changed, 764 insertions(+)
>  create mode 100644 drivers/ntb/hw/epf/Kconfig  create mode 100644
> drivers/ntb/hw/epf/Makefile  create mode 100644
> drivers/ntb/hw/epf/ntb_hw_epf.c
>=20
> diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig index
> e77c587060ff..c325be526b80 100644
> --- a/drivers/ntb/hw/Kconfig
> +++ b/drivers/ntb/hw/Kconfig
> @@ -2,4 +2,5 @@
>  source "drivers/ntb/hw/amd/Kconfig"
>  source "drivers/ntb/hw/idt/Kconfig"
>  source "drivers/ntb/hw/intel/Kconfig"
> +source "drivers/ntb/hw/epf/Kconfig"
>  source "drivers/ntb/hw/mscc/Kconfig"
> diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile index
> 4714d6238845..223ca592b5f9 100644
> --- a/drivers/ntb/hw/Makefile
> +++ b/drivers/ntb/hw/Makefile
> @@ -2,4 +2,5 @@
>  obj-$(CONFIG_NTB_AMD)	+=3D amd/
>  obj-$(CONFIG_NTB_IDT)	+=3D idt/
>  obj-$(CONFIG_NTB_INTEL)	+=3D intel/
> +obj-$(CONFIG_NTB_EPF)	+=3D epf/
>  obj-$(CONFIG_NTB_SWITCHTEC) +=3D mscc/
> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig new
> file mode 100644 index 000000000000..6197d1aab344
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/Kconfig
> @@ -0,0 +1,6 @@
> +config NTB_EPF
> +	tristate "Generic EPF Non-Transparent Bridge support"
> +	depends on m
> +	help
> +	  This driver supports EPF NTB on configurable endpoint.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/epf/Makefile b/drivers/ntb/hw/epf/Makefile ne=
w
> file mode 100644 index 000000000000..2f560a422bc6
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_NTB_EPF) +=3D ntb_hw_epf.o
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c
> b/drivers/ntb/hw/epf/ntb_hw_epf.c new file mode 100644 index
> 000000000000..0a144987851a
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -0,0 +1,755 @@
......
> +static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
> +			    struct pci_dev *pdev)
> +{
> +	struct device *dev =3D ndev->dev;
> +	int ret;
> +
> +	pci_set_drvdata(pdev, ndev);
> +
> +	ret =3D pci_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable PCI device\n");
> +		goto err_pci_enable;
> +	}
> +
> +	ret =3D pci_request_regions(pdev, "ntb");
> +	if (ret) {
> +		dev_err(dev, "Cannot obtain PCI resources\n");
> +		goto err_pci_regions;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		ret =3D dma_set_mask_and_coherent(dev,
> DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(dev, "Cannot set DMA mask\n");
> +			goto err_dma_mask;
> +		}
> +		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
> +	}
> +
> +	ndev->ctrl_reg =3D pci_iomap(pdev, 0, 0);

The second parameter of pci_iomap should be ndev->ctrl_reg_bar instead of t=
he hardcode value 0, right?

> +	if (!ndev->ctrl_reg) {
> +		ret =3D -EIO;
> +		goto err_dma_mask;
> +	}
> +
> +	ndev->peer_spad_reg =3D pci_iomap(pdev, 1, 0);

pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);

> +	if (!ndev->peer_spad_reg) {
> +		ret =3D -EIO;
> +		goto err_dma_mask;
> +	}
> +
> +	ndev->db_reg =3D pci_iomap(pdev, 2, 0);

pci_iomap(pdev, ndev->db_reg_bar, 0);

Best Regards
Sherry
