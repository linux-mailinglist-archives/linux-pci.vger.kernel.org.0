Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B20601886
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJQUGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJQUGr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 16:06:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8242974E3F;
        Mon, 17 Oct 2022 13:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzlhch1a3Htl5mbAnIWLxz9eVsLTkDgCyyzQSPqIttrIzXTGjUUfPW0u3wcEVTa0p/XLBBwSDbnvGYmvN/Omf1NazSIApofGocR3eYsO5LsPbgkrMcE4bXLI/RFhnx4Efb7XToHXU+CEXmpvfl2XanXt90gK1nauc2vIln/MpQooPSlqVMACKThEP0X8oWsCSEhe82WqGhZ2wpAEdyILd71+0fn4UTP8YeMyJMl/SSy7GSb7fnY/+1J4RzN1eqsg3SmyrSuUq2YTfi9TFvH1nDqA8iws1ReOa/fiGLvdnHBi26/hVoXGQTiJaBWCyuvPIyvwM1I5f59GpYgzXLicwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbgrMawjgA5nKSTuND6LY+d8zOKLx/moRD7897Ye1M8=;
 b=i7hGEwn6NzHTPCHF1k6OG090d6y3D0Ht0He/orrELqQNHhbDsm3sqX5ONogfUAQd48pZmt2hNRwIvBm7lpJJRx35JYGmTabx7HavSb6hGNnHotKlosFlf93AgRh0eVMCE0ewvcNJDHMmpCNc7itMZHEAl0mNu6MrqQ7PPxp7a7OGO74VOW38TQ5a51TphpdWX/Wd8t1a/xCPAr/0WZyQAQlN8BxoGq2eRddGj41k2qMMMcxzZLte/HMcP4oR2rQb5kXfUl/wKpRWtY1JPzvIm8qezQUbu+K77cuS6TYfhHZrF1+KJBUbaMSwBhdSHnY8wHGepieScCR4OymkBXnpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbgrMawjgA5nKSTuND6LY+d8zOKLx/moRD7897Ye1M8=;
 b=i++kH2q3E67d5/5NJSSl+iCTsqwRUJXwVJr2Mlru6r+d8/xGcsxfM9OOV8qdoSwU3CaUkYdabu0RjAlZ8kJTH9S7jGfQSXk8Lxvd7Qit24nHPvLAC10g+dZmPup1jouknFK+OrwSUvdZ9ZrfZkO3iS/Yc96wWDAeYurNmmd8o6k=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:06:42 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.033; Mon, 17 Oct
 2022 20:06:42 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc
 warning
Thread-Topic: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc
 warning
Thread-Index: AQHY2oD4qq+oUIXVdEWBXF1BfLJvx64TErXQ
Date:   Mon, 17 Oct 2022 20:06:42 +0000
Message-ID: <HE1PR0401MB2331096ADF6354AEEC09D56888299@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
 <20221007191326.193079-3-Frank.Li@nxp.com>
In-Reply-To: <20221007191326.193079-3-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM0PR04MB7027:EE_
x-ms-office365-filtering-correlation-id: 34bb7ee0-7ce5-4d17-5c5b-08dab07b1be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+ngsbGJYYjTj8SU2ELgzeVlMnaVyJwwtLt1d2cf1N5HPCU0hsQviSLMOAZ6EhsNZK+tfVKivEDWKQB1FtyeNBUMIEs+fT6adzy6b2oLatohC+UN5wzeTbkAzXh1ljPjWPPMGCsYpp2UMhOIqwxR7RSBDWVE7umHwBaBmzyudigzCtQQ9ifNNiWV48vjuNEul2qanGBz52UXoliGV8XR46cwyjNgnkxmP947QT+DmydA5CpD5rzPoRqBC1BeDr9PdFiy/rH5/JMy0lSLjmcigdlW00GdSg48sL1AMDZk2WdtYOJJDJhOwH3dkj1O6UB3RSonFube05sxpJYpUp2lJkvnv2Exo1s9MwvDLGL0i9GQZW7Z1u56SRrImMwnmEzkfJvMorYZMJLW6HhqK3L0Bb/FhTolw7KFdpp3vEWw+qFo3dn+U3GL5YMZuj0vLW7h37H306f+EzxiSUjiSW5mQ7Az6td39Q8cN1kufK0TvpaEpgf3FuhbThNVd5MjIb4BNqCbcsuMN2jw5rq8Wxf1wtc+Bb5BfFTFCo+oRJOJLGbOcvi1NqC5/iqc2D3E4HcVcb4n9GGW89tFUJF48RBU5v/YUS1gy+bVMHvMxz0WvxhiLlYDK5joMgGHioZs+92fhWj4ccjnghMxU2n1cOw8svku80I+bw0utLaK+MU5am80tw6QAaMR67mB0jUP27TCb/6QobEddGCDQmWxBo2KhFG6Obx3vWAxPKBLBgIG6syAfNzt5H2J7KFaUsjrKs5Yw4nduDKO6aU1J10qiWcZ3TUZsN4BxnZewgRBIbzB4CA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(83380400001)(66574015)(33656002)(38070700005)(921005)(86362001)(8936002)(38100700002)(44832011)(122000001)(52536014)(30864003)(5660300002)(53546011)(66556008)(66946007)(76116006)(41300700001)(8676002)(66446008)(9686003)(66476007)(2906002)(7696005)(7416002)(55236004)(6506007)(186003)(26005)(110136005)(316002)(55016003)(478600001)(64756008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?cUhA1jKFJhkTu83QP7OFqlxzUypFmglvGTJt/lRTX+anbQcSXNLC+U+Es3?=
 =?iso-8859-2?Q?0NFRQpemq1gxosX4K8afrphSAygYzm3rnxA47S/0KiyZDGP8m50YbHia5Z?=
 =?iso-8859-2?Q?j8tpDHHry8rkcB61tMYGPtoIRMd7lkqqSMUjFTBA+yMUdljk9dAsT8sSMc?=
 =?iso-8859-2?Q?0h/kBdyBTjp5QasNs6nta4CCiooZrIbdwlEAOwVCePQCvgWzFLAk/nUrb6?=
 =?iso-8859-2?Q?Q5XYuE8C/fxLPS67N4d8WyIWaJiikzHwawOsB5MLJldvDb+aFgOx5hyqW0?=
 =?iso-8859-2?Q?L1hsDpVGSwULjvdx6GIJJtBqGY54WwEsmIGJ4zbySIIVD9cqFrpX1AOTFm?=
 =?iso-8859-2?Q?Wz/TntLw0DTGT3ZwLKovfy1dFfyapIX86cYva9uLBtIC5o+VW3D65r09n4?=
 =?iso-8859-2?Q?fCHfnNbmvFfAByg6VMu6k8hWsotqUX+rGZZ/h040XrSyVsSN+j01UYdeAH?=
 =?iso-8859-2?Q?XiH/WDFqwkprD2Fc2pMwQhsiTT94hphArHb8ikvwmsRcocZyzVIYbbPSsy?=
 =?iso-8859-2?Q?OGv0vrMKhM3q6WN0ncn34rwrvpMYYpUXWlaJaPTFzD7Pes5s7wJdi3pnlu?=
 =?iso-8859-2?Q?huzyvuwb0aE8xRbch7eFDKMYLDw2CpCNav574HkPjkpQAvVpuyb9A2xUlN?=
 =?iso-8859-2?Q?oALpYnZMZSSMEj/44N5PfeUzmG2YiLXaMJkYBAPALedMFkUwjPDdthuysD?=
 =?iso-8859-2?Q?Moq9vHgPAEop8vFejZPC1TZXeZRo9ntX+/q2IYRhs7ZZLsBjKrHhq9Dajk?=
 =?iso-8859-2?Q?erYe4uoHE/FVblsrHyqzEl3BWAAJpltGyOBJEsI/fIm6d0t7Y6PRB5EHsm?=
 =?iso-8859-2?Q?eO4ia6HySxFX8rMLtUJIpY1h/e3DxKvfaPS6J2LTq4bkl/5/+OT28jd/NF?=
 =?iso-8859-2?Q?8PToosTWcUtLxxmJmbWiosKS7mKebu219XWfvIoufkAVWN+AkifQzkKqx0?=
 =?iso-8859-2?Q?VSN3Q8/O8CCs1GoLimQY/NArOloFiADNChNlIrPBCO0ObPRznVqeej6DnV?=
 =?iso-8859-2?Q?mp2aP5RoUrMndNdu7I3cshXCk2TONx0JE4RLcMyape/y3yUE33ejuHW2zI?=
 =?iso-8859-2?Q?Q/iROaKjFATbgdT9mq7y7PwhuepLuw47taMOihxeR+zBRFPW053nWqKIUd?=
 =?iso-8859-2?Q?aRFxu34C8CbhZA0eBzAeyiRpr5ozJoJ7MkjvMkLmb91RwzwYgzwGTZoF2H?=
 =?iso-8859-2?Q?ebh6/nk47J6AWKbKYjlVF3FldAwHsW4lLWvP0+oqbKwvSrEHnzS58RB5Bv?=
 =?iso-8859-2?Q?t9/r3qzWPyqaNc3+IMK++r5+X47idUkv8KtkPnhv/0grz8wuGToyk2r8Vh?=
 =?iso-8859-2?Q?N/DgMR+nBCzgt8HILW4vSe6NsThz0N/Vr1MNQH9brzAPV6VzFvHDszBgno?=
 =?iso-8859-2?Q?CHPxVYA2/ztHQmUNG/cCw1VcO2L1ysrFut8rhucTD7b+5Bc+LX/223Pef4?=
 =?iso-8859-2?Q?ZOcyAoHny5heDjmY1CkFT7LumUVh+ETI9BeiNRWx0ECpZ8zTEqYLstQUbg?=
 =?iso-8859-2?Q?beIpuvBeCiaNoEV8S/PcnIM86gRbsEzHKchDWAiXwXJ6jnyogn4nTTmnRq?=
 =?iso-8859-2?Q?4Ags3PXqUEstz7Cwr26JDIZC+7uvql1WoHu5v18RGkNolZ1onWiBnsk55o?=
 =?iso-8859-2?Q?Y4LeyriX6oWSE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb7ee0-7ce5-4d17-5c5b-08dab07b1be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 20:06:42.1516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKiZPNGfTAzhmZy7Se85McoPoOydhptosZmSWp3VnCFyb7/En/knpKbMM5EBseOHVgwCtYz5JcCe6dGWZ3n7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Frank Li
> Sent: Friday, October 7, 2022 2:14 PM
> To: imx@lists.linux.dev; Jon Mason <jdmason@kudzu.us>; Dave Jiang
> <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>; Kishon Vijay
> Abraham I <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>;
> Krzysztof Wilczy=F1ski <kw@linux.com>; Manivannan Sadhasivam
> <mani@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; open list:NTB
> DRIVER CORE <ntb@lists.linux.dev>; open list:PCI ENDPOINT SUBSYSTEM
> <linux-pci@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc
> warning

[Frank Li] Friendly ping. =20

>=20
> From: Frank Li <frank.li@nxp.com>
>=20
> Cleanup warning found by scripts/kernel-doc
> Consolidate term
>     host, host1 to HOST
>     vhost, vHost, Vhost, VHOST2 to VHOST
>=20
> Signed-off-by: Frank Li <frank.li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 83 ++++++++++++-------
>  1 file changed, 54 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0ea85e1d292e..c0115bcb3b5e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -11,7 +11,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>=20
> -/**
> +/*
>   * +------------+         +---------------------------------------+
>   * |            |         |                                       |
>   * +------------+         |                        +--------------+
> @@ -156,12 +156,14 @@ static struct pci_epf_header epf_ntb_header =3D {
>  };
>=20
>  /**
> - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
> + * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
>   * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   * @link_up: true or false indicating Link is UP or Down
>   *
>   * Once NTB function in HOST invoke ntb_link_enable(),
> - * this NTB function driver will trigger a link event to vhost.
> + * this NTB function driver will trigger a link event to VHOST.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
> @@ -175,9 +177,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool
> link_up)
>  }
>=20
>  /**
> - * epf_ntb_configure_mw() - Configure the Outbound Address Space for
> vhost
> - *   to access the memory window of host
> - * @ntb: NTB device that facilitates communication between host and vhos=
t
> + * epf_ntb_configure_mw() - Configure the Outbound Address Space for
> VHOST
> + *   to access the memory window of HOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   * @mw: Index of the memory window (either 0, 1, 2 or 3)
>   *
>   *                          EP Outbound Window
> @@ -194,7 +196,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool
> link_up)
>   * |        |              |           |
>   * |        |              |           |
>   * +--------+              +-----------+
> - *  VHost                   PCI EP
> + *  VHOST                   PCI EP
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
>  {
> @@ -219,7 +223,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb,
> u32 mw)
>=20
>  /**
>   * epf_ntb_teardown_mw() - Teardown the configured OB ATU
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   * @mw: Index of the memory window (either 0, 1, 2 or 3)
>   *
>   * Teardown the configured OB ATU configured in epf_ntb_configure_mw()
> using
> @@ -234,12 +238,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb
> *ntb, u32 mw)
>  }
>=20
>  /**
> - * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
> + * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
>   * @work: work_struct for the epf_ntb_epc
>   *
>   * Workqueue function that gets invoked for the two epf_ntb_epc
>   * periodically (once every 5ms) to see if it has received any commands
> - * from NTB host. The host can send commands to configure doorbell or
> + * from NTB HOST. The HOST can send commands to configure doorbell or
>   * configure memory window or to update link status.
>   */
>  static void epf_ntb_cmd_handler(struct work_struct *work)
> @@ -321,8 +325,8 @@ static void epf_ntb_cmd_handler(struct work_struct
> *work)
>=20
>  /**
>   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> - * @ntb_epc: EPC associated with one of the HOST which holds peer's
> outbound
> - *	     address.
> + * @ntb: EPC associated with one of the HOST which holds peer's outbound
> + *	 address.
>   *
>   * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
>   * self scratchpad region (removes inbound ATU configuration). While BAR=
0
> is
> @@ -331,8 +335,10 @@ static void epf_ntb_cmd_handler(struct work_struct
> *work)
>   * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
>   *
>   * Please note the self scratchpad region and config region is combined =
to
> - * a single region and mapped using the same BAR. Also note HOST2's peer
> - * scratchpad is HOST1's self scratchpad.
> + * a single region and mapped using the same BAR. Also note VHOST's peer
> + * scratchpad is HOST's self scratchpad.
> + *
> + * Returns: void
>   */
>  static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -347,13 +353,15 @@ static void epf_ntb_config_sspad_bar_clear(struct
> epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
> - * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> + * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
>   * self scratchpad region.
>   *
>   * Please note the self scratchpad region and config region is combined =
to
>   * a single region and mapped using the same BAR.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
>  {
> @@ -380,7 +388,7 @@ static int epf_ntb_config_sspad_bar_set(struct
> epf_ntb *ntb)
>  /**
>   * epf_ntb_config_spad_bar_free() - Free the physical memory associated
> with
>   *   config + scratchpad region
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   */
>  static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>  {
> @@ -393,11 +401,13 @@ static void epf_ntb_config_spad_bar_free(struct
> epf_ntb *ntb)
>  /**
>   * epf_ntb_config_spad_bar_alloc() - Allocate memory for config +
> scratchpad
>   *   region
> - * @ntb: NTB device that facilitates communication between HOST1 and
> HOST2
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Allocate the Local Memory mentioned in the above diagram. The size of
>   * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD
> REGION
>   * is obtained from "spad-count" configfs entry.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  {
> @@ -465,11 +475,13 @@ static int epf_ntb_config_spad_bar_alloc(struct
> epf_ntb *ntb)
>  }
>=20
>  /**
> - * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Configure MSI/MSI-X capability for each interface with number of
>   * interrupts equal to "db_count" configfs entry.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
> @@ -511,7 +523,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb
> *ntb)
>=20
>  /**
>   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
> @@ -566,7 +580,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb
> *ntb, int num_mws);
>  /**
>   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
>   *   allocated in peer's outbound address space
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   */
>  static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -582,8 +596,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_mw_bar_init() - Configure Memory window BARs
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> @@ -639,7 +654,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_mw_bar_clear() - Clear Memory window BARs
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   */
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
> @@ -662,7 +677,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb
> *ntb, int num_mws)
>=20
>  /**
>   * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB
> interfaces
>   */
> @@ -675,7 +690,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  {
> @@ -716,11 +733,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb=
)
>=20
>  /**
>   * epf_ntb_epc_init() - Initialize NTB interface
> - * @ntb: NTB device that facilitates communication between HOST and
> vHOST2
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Wrapper to initialize a particular EPC interface and start the workqu=
eue
> - * to check for commands from host. This function will write to the
> + * to check for commands from HOST. This function will write to the
>   * EP controller HW for configuring it.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  {
> @@ -787,7 +806,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>=20
>  /**
>   * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
> - * @ntb: NTB device that facilitates communication between HOST1 and
> HOST2
> + * @ntb: NTB device that facilitates communication between HOST and
> VHOST
>   *
>   * Wrapper to cleanup all NTB interfaces.
>   */
> @@ -951,6 +970,8 @@ static const struct config_item_type ntb_group_type
> =3D {
>   *
>   * Add configfs directory specific to NTB. This directory will hold
>   * NTB specific properties like db_count, spad_count, num_mws etc.,
> + *
> + * Returns: Pointer to config_group
>   */
>  static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  					    struct config_group *group)
> @@ -1292,6 +1313,8 @@ static struct pci_driver vntb_pci_driver =3D {
>   * Invoked when a primary interface or secondary interface is bound to E=
PC
>   * device. This function will succeed only when EPC is bound to both the
>   * interfaces.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_bind(struct pci_epf *epf)
>  {
> @@ -1377,6 +1400,8 @@ static struct pci_epf_ops epf_ntb_ops =3D {
>   *
>   * Probe NTB function driver when endpoint function bus detects a NTB
>   * endpoint function.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_probe(struct pci_epf *epf)
>  {
> --
> 2.34.1

