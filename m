Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7946CA8F9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC0P37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjC0P36 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 11:29:58 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F46018F;
        Mon, 27 Mar 2023 08:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM748rUV6WAKMZCVHtVXl000g9Zm5jx5L0+Sd3t05UxgTjIRhG1QJLJEWiRHENq2Fz9VGq9mOIGGvgu0tSguG8qRWe92iqRl5nKt5oictlT4/VKWTn4ZnYOCCGL42NuEqPDLbBCJUoYDUeJalbL2BZ/JGeQHKpY7Xb+kvKdYB41h3obgUwqhPKjKV7LCckcHbMr94aP0wgDb8ujIxj0nPnVhAXOhWrE38cwYdkzxnqR1rQeZjW6AtPUh56r6QrVtSQ3gnERp/f2PE43CorNmIFJ/y4IAPoRpSd3ax1t2erEavX05Bjym6Jlv7SpuShqW0QowrRyqkaA5Hlylcc42eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntu2DkPDEHuSUpxRFd/akuIdBS/agCeC2lYcMqNI6Ik=;
 b=oM/tYy6+nVeug9UjvSVF5zqULdJORw1OhGYpD6icZmZYI2HNl1wL5RMDyLzWd8IFYC5Mi+1Nn5jnR112EKJJdE7jA5cAgJi4Wu+W6QMisuyq9KdOJ2l6Fg30QPv1H9Ja7hLjscmUcxR6VdP5JEvQtIPqDlyjEV6fRND+jYPDVB2snpSBkFnA9qkCmSKi3WsnzEvcvq559GricXa9NKAYTfk9W+bOc9aXwwhjNGejJ3RKbpn1HuIkqrBUMGi82Bh6VVuyPdQMxTpIF5bq/qggcuO0yLMCCD1+kDRZRmdPmIxgJsOdB+9bM5qIvDESgq+TALhp0jXhGSRRPZmbASIshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntu2DkPDEHuSUpxRFd/akuIdBS/agCeC2lYcMqNI6Ik=;
 b=agIIG4bk7lJ3G5BkiyELu1+2/+TpB9isA/t9nq6sv0he64hDVceI/cACxcVVNek+QBqGvjf5Bzxi/FevukN8qFRCyJvzxJ5fAKpt45hdwq5m6nzlwTx61C0HISITvVlVziLioj4w0P/2hAFdZFufCK2ftGXrSkuW0nhgD9NW7/c=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7009.eurprd04.prod.outlook.com (2603:10a6:208:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 15:29:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 15:29:54 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_krichai@quicinc.com" <quic_krichai@quicinc.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "steev@kali.org" <steev@kali.org>,
        "mka@chromium.org" <mka@chromium.org>, Dhruva Gole <d-gole@ti.com>
Subject: RE: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
 and resume
Thread-Topic: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
 and resume
Thread-Index: AQHZYLF+mMMfa+oi40SnGUc9tSektK8Ovhog
Date:   Mon, 27 Mar 2023 15:29:54 +0000
Message-ID: <AM6PR04MB4838C84574BE534DDB0428D0888B9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM0PR04MB7009:EE_
x-ms-office365-filtering-correlation-id: 793dbaa9-5792-40c4-bef0-08db2ed81d7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHeLd3/UdqWU6JIW/7LqDc5IHExpzfWkdqy4/3sG486toRZg9gFaSfpVMqseHEVbam76z2V8VYv7Pl2DJut6gh512ZDf80AkzQCfiW7xxYlSVGx8fb9zUyc+P3CyIPgYMxOcJaSi0fXP2VPYG5HKeKeqiGj066nqrKj8dCNk6Hn/kLH7Bz2xqAhgCrSWt5NwAylsCosM2ZzdlinqOmzfpI4PYkgHmRN0NaP+VKH5Hd4gZHnk3uTNT6mYaEBrWT9zECkiqj7u0XeEO5eTX3GSZSxlvngdh9BCp+SqNKntj125/XbLn51mRFAowm377yfNJaEeeSz5cIFfoicJFkWIYYwFojv420iMS+Ks9j1gP2OC3fwJOmkePhHIPMh4SFW9PpsJYKZyqrY0/sqwmoRHoDIQanGnleG1DSSNXMgWuAjXs+VX36OphmWrE7OSB0YIeYzDjB86ByVsnXCzBG6o/Ft/Rwc2vSGWSdrZnCN48LlCA8Tn3nDlQTVTwlxWDGMhJWTVcGoepXZ2mJuPoEiv82kw28TgIsj6NFAasAa5j6LboQD7L2h0wzAKw4B/JNqjqEri8LZWbuD6s9+EsrnExS5+tswi+DwlarJLn7//yQHcmGt0PcPk6xWzSyujvN2F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(110136005)(76116006)(66946007)(38100700002)(41300700001)(478600001)(54906003)(66446008)(66476007)(64756008)(4326008)(66556008)(8676002)(316002)(8936002)(52536014)(38070700005)(5660300002)(71200400001)(7696005)(122000001)(7416002)(44832011)(186003)(83380400001)(55016003)(53546011)(26005)(15650500001)(2906002)(9686003)(6506007)(55236004)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?thZ0F6qpLApCwL/d16eYUciwiVh8VQCTlcUSkXpEgA0FCybEIEBUBLM1dEz+?=
 =?us-ascii?Q?TNSySWTvHMwyYFjAB75NMGy6TIPPWP8W4pwdZNeSvDuL0JtdO6K9I8c6khwL?=
 =?us-ascii?Q?cPCO+NvIEovGgZfl1SxmAiIV3aicQmmZoojVzZbhaNougKA0821IF7XbgLf+?=
 =?us-ascii?Q?HYHu2L8lE2PzDo+bXsj5D7/8cC2FAzCVRLqFk4mWcUog/vemdpJZkQ503UMD?=
 =?us-ascii?Q?x3SMnMEMSK8D7hlgnlaZE2eeyb3rK87Dtw2bJ9hpgOkuG9J1r5OkP/Pcu0gL?=
 =?us-ascii?Q?nU0stAPWZobr3Iy5Q34YQNucSAzn3UzL+m6UT+nC6QMlwq+THC9WQXykyVDM?=
 =?us-ascii?Q?VoghM4wUXrdgKgaq/dYjLcdrC7P56SJWaQiKwlyRBW/XsWo9EH/yRksM9Yi6?=
 =?us-ascii?Q?I1KpMcTkCZlI3up7ip6JP4lsvAxNd3wewoO3utJNmjO+58OOV3IWB5pXDzMl?=
 =?us-ascii?Q?D2SY0+iYIpVKUfL5nxekGn2GGu58OglaoWscRvOhEfN/OgnssVWsDavGleGr?=
 =?us-ascii?Q?0x2zo4EkcGFQn0gbpHVHrvSRPIsfEgiqXmD6JVdpHpULrmw7c52mnbu47TSi?=
 =?us-ascii?Q?gahquzufmjzqA/tbMS8/2lh4nOi5GwgSCGdq7lVLjuC8zd+qAcZKtSM3wFHl?=
 =?us-ascii?Q?1w7Loxh/BykLGAubUgYM5W2+8ViJ4RlK3lb3s3hxOd1qLOA5HZ0KaLmKgsNH?=
 =?us-ascii?Q?0P8nQdYRHfrMkaXJjYXhZ19viGGofBme3iRfJdhsGW3Puh51K/bOqFGRbTxh?=
 =?us-ascii?Q?w54/oKrr5l2zkTA5xB0eL9qKOqqEfg+ZMlXvUty+OUZf2LvKMnb6z2YPUigp?=
 =?us-ascii?Q?PXSSoJPFs7W2PAoOC+12lryuCCzSGSJEossXRnGAxmD1KzfjTbb2CoP4eeMv?=
 =?us-ascii?Q?rdmc56Qht+1CG5cxz/O0TECjkSlXTjKY2FEUC0epTrbubnLHZvsroav7ZZPa?=
 =?us-ascii?Q?V1C1JRmtl6dG+XdK36sYfaiKuQh1hJFKkmYfz823NbZf7iWob/I98yhb8V+R?=
 =?us-ascii?Q?LDTiAx57DgDvwSz1N+syeTe4+PjFBARfxJOBunsLNoc2rl2i7dJo001ICbJc?=
 =?us-ascii?Q?CzBTW4m3HU24QU2DvZbYoFpKs1Tqbe4I0c2Wj7QRwcgTiQbMY1Ml6vMeJnfC?=
 =?us-ascii?Q?C1sYolUG4cVSeDMHLuAf4pcTL/ISOf09kXOCu6KdCPQEuY+3lzaY9639qBwt?=
 =?us-ascii?Q?4vtsq+x5ve0tIb4Y6BygFbGrhe2nv4wV5db9CiTJnBYyRlgTQc8u7LWJPyvM?=
 =?us-ascii?Q?hkAvLW/Xuk2ZIeQFRuTtLejA8hW0PT+dH3JYAw/rxSlSn/EVNxdhYYzPB51n?=
 =?us-ascii?Q?Va0lvomJWYUPU8aLb6FH37cZAtGtDrZfnPEVz/LG4eSttv8nTbBlomvvucXJ?=
 =?us-ascii?Q?Q4XCKmUci6Ae7AGWIUCrp8VoALX3mzoDDTx761De7FYIkRxcPX2H40gPx2A1?=
 =?us-ascii?Q?jd64YiYXkNb1VrOfr04JoUbEnnyiKXkF6DEVgqkE/1a/+1UeNCEVKzMngviC?=
 =?us-ascii?Q?eyMZ+u/2v844D/DQdFFBIaPSZIoJYHv9Nl2CvR2b9u4KpBF6W5Qvbr7EjFra?=
 =?us-ascii?Q?lL83CUvsZCYfSU+qsYA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793dbaa9-5792-40c4-bef0-08db2ed81d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 15:29:54.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDh4Ci/qOw6qYt02RrH5y5VsYCyCZPUcDoHwkrSeINRDv38hHMC3QasqBh1fcAak7wW70b4hTCGbkwRbaJpgSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7009
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Sent: Monday, March 27, 2023 8:38 AM
> To: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org
> Cc: andersson@kernel.org; konrad.dybcio@linaro.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; linux-kernel@vger.kernel.org;
> quic_krichai@quicinc.com; johan+linaro@kernel.org; steev@kali.org;
> mka@chromium.org; Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>; Dhruva Gole <d-gole@ti.com>
> Subject: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
> and resume
>=20
> Caution: EXT Email
>=20
> During the system suspend, vote for minimal interconnect bandwidth and
> also turn OFF the resources like clock and PHY if there are no active
> devices connected to the controller. For the controllers with active
> devices, the resources are kept ON as removing the resources will
> trigger access violation during the late end of suspend cycle as kernel
> tries to access the config space of PCIe devices to mask the MSIs.

I remember I met similar problem before. It is relate ASPM settings of NVME=
.
NVME try to use L1.2 at suspend to save restore time.=20

It should be user decided if PCI enter L1.2( for better resume time) or L2
For batter power saving.  If NVME disable ASPM,  NVME driver will free
Msi irq before enter suspend,  so not issue access config space by MSI
Irq disable function.=20

This is just general comment. It is not specific for this patches.  Many pl=
atform
Will face the similar problem.  Maybe need better solution to handle
L2/L3 for better power saving in future.=20

Frank Li
=20
>=20
> Also, it is not desirable to put the link into L2/L3 state as that
> implies VDD supply will be removed and the devices may go into powerdown
> state. This will affect the lifetime of storage devices like NVMe.
>=20
> And finally, during resume, turn ON the resources if the controller was
> truly suspended (resources OFF) and update the interconnect bandwidth
> based on PCIe Gen speed.
>=20
> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Acked-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..f33df536d9be 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -227,6 +227,7 @@ struct qcom_pcie {
>         struct gpio_desc *reset;
>         struct icc_path *icc_mem;
>         const struct qcom_pcie_cfg *cfg;
> +       bool suspended;
>  };
>=20
>  #define to_qcom_pcie(x)                dev_get_drvdata((x)->dev)
> @@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct
> platform_device *pdev)
>         return ret;
>  }
>=20
> +static int qcom_pcie_suspend_noirq(struct device *dev)
> +{
> +       struct qcom_pcie *pcie =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       /*
> +        * Set minimum bandwidth required to keep data path functional du=
ring
> +        * suspend.
> +        */
> +       ret =3D icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> +       if (ret) {
> +               dev_err(dev, "Failed to set interconnect bandwidth: %d\n"=
, ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * Turn OFF the resources only for controllers without active PCI=
e
> +        * devices. For controllers with active devices, the resources ar=
e kept
> +        * ON and the link is expected to be in L0/L1 (sub)states.
> +        *
> +        * Turning OFF the resources for controllers with active PCIe dev=
ices
> +        * will trigger access violation during the end of the suspend cy=
cle,
> +        * as kernel tries to access the PCIe devices config space for ma=
sking
> +        * MSIs.
> +        *
> +        * Also, it is not desirable to put the link into L2/L3 state as =
that
> +        * implies VDD supply will be removed and the devices may go into
> +        * powerdown state. This will affect the lifetime of the storage =
devices
> +        * like NVMe.
> +        */
> +       if (!dw_pcie_link_up(pcie->pci)) {
> +               qcom_pcie_host_deinit(&pcie->pci->pp);
> +               pcie->suspended =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_pcie_resume_noirq(struct device *dev)
> +{
> +       struct qcom_pcie *pcie =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       if (pcie->suspended) {
> +               ret =3D qcom_pcie_host_init(&pcie->pci->pp);
> +               if (ret)
> +                       return ret;
> +
> +               pcie->suspended =3D false;
> +       }
> +
> +       qcom_pcie_icc_update(pcie);
> +
> +       return 0;
> +}
> +
>  static const struct of_device_id qcom_pcie_match[] =3D {
>         { .compatible =3D "qcom,pcie-apq8064", .data =3D &cfg_2_1_0 },
>         { .compatible =3D "qcom,pcie-apq8084", .data =3D &cfg_1_0_0 },
> @@ -1856,12 +1913,17 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302,
> qcom_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000,
> qcom_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001,
> qcom_fixup_class);
>=20
> +static const struct dev_pm_ops qcom_pcie_pm_ops =3D {
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq,
> qcom_pcie_resume_noirq)
> +};
> +
>  static struct platform_driver qcom_pcie_driver =3D {
>         .probe =3D qcom_pcie_probe,
>         .driver =3D {
>                 .name =3D "qcom-pcie",
>                 .suppress_bind_attrs =3D true,
>                 .of_match_table =3D qcom_pcie_match,
> +               .pm =3D &qcom_pcie_pm_ops,
>         },
>  };
>  builtin_platform_driver(qcom_pcie_driver);
> --
> 2.25.1

