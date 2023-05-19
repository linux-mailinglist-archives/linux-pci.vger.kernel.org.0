Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DC709EED
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjESSLV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 14:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjESSLU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 14:11:20 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC9107;
        Fri, 19 May 2023 11:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuAZed9kngvsKDOKBX2noLIPIRhsx4QLDIuYRWZFrtXCguWogIN8ol0Nruz3dPQU9ejpvPZ6SfYPlepitr2NVoCsw2WjGXiCLEUCQDiUm6xnjWiA6Z6Ag0mgadeFsa72xZ7t3WO2qscwmT4qjk934NH21eWWdwZRbN0MDYDUn7rj57CV1hIjtUvJAklRApo71124uzGGoHlQs3AFoVf+lKUf1O9W9zHW9tohsYOOCV2nxvyIyIqxdHDZZrfVc4g/JxjuyzDZuVJavdZnXiEw7AsHt1K03vkBymbNklBhZU/WG2a5J76gSHeBAGRz8DvYm+dKeG44NOKaKwlyt1Nu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dno+yQ3BLU9lelCV0EN2pTClOVltqc1H8gNOM56mByI=;
 b=ZNpmnTKPAfGQrBga/9Sne5hf3ZtE+vp416W29t1w0FaUes5bjtjTb5Kfkrjs+MAiLHz5MtlEy4CEk3OSV6BE4Vs1uA7BEoEc3MZzCDcRTIyEN8CYbfKSPqB3LBYMknCSkpKpPE9VjzgrI0Wjnjx7gwY+Real2tAOL82j3X9eVCBVIJu1Vh2YxG2/FB32uHcBUOXgiDoXzX2hwbnD9L3QOTXRmGhsBDRbjiY4JqLyvM36DELpvn9IzplfmlEqGo/DlT6xumLccfENrqS9H9gSNC0XXPHcJFXsDFDZ8p9a8zLAZzcH224980yr8lvriRgQaBe30L3jUS8rwMb4Py2b2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dno+yQ3BLU9lelCV0EN2pTClOVltqc1H8gNOM56mByI=;
 b=IaPbqZBM8oBbeaZ6aJrSsCAFB9qR5aFChBEas5XfiZ1C1gdJLp5VnWszj6ynYJm3LunLbLzTSETV6EDjofhavBfpIszcXT38cPXkxMoZQim1vQNSjUh//Qk77kz+7nT36201s0vWxm4yw++Q+MMh/NXV+6sf7+Hl2ThHFZedlPE=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 18:11:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:11:15 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>
CC:     "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [EXT] [PATCH v4 1/7] PCI: endpoint: Pass EPF device ID to the
 probe function
Thread-Topic: [EXT] [PATCH v4 1/7] PCI: endpoint: Pass EPF device ID to the
 probe function
Thread-Index: AQHZimAtHZjexVD+d0eV/y9Kvbge7K9h5aiQ
Date:   Fri, 19 May 2023 18:11:15 +0000
Message-ID: <AM6PR04MB483851273EF610DE449B04FB887C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230519144215.25167-2-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB8623:EE_
x-ms-office365-filtering-correlation-id: 13d09555-ab87-4560-4258-08db58946f6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RmF+D8YwZ1wQMaV2N9SxQKVzPbPpH5ky1BgcGy0wI2U3YWkPHhoUp5dwX2Jx4MvWinfSkrqGcNYBJj5mTWLYI8t0pxlgncKTtg60PWYOfNT/HiFfsNgvVHzTkgSnqPLhacmirsqE2jQW5RkvsJuaty166CBXnsb3gmmdviPSO9LIb1S5yR46JFs6euPgOVt8XuJH0eTxmCHs1xMh4epWXQZeWpRt35sb1it90Ee5KuPXLeMVFd2dejRIDEB/9wE2jtWvcF4eD5duLsukmROy/HJOBvGUdRQnTLfHSo5WbGS81VnOnE9eu4fQ5L0fqBliLB+acFcmdHeyiab2yPJlTK7YtvfLfdMPwvsYklz+R/jC2xl564F4BBTgBUZvjtSvdX5rrdojo8m6tImK6mXGv/jGITH6Rgx21TzN0/RtOF3BWqsiijivx/3lXjfsLC2x04qSQv/aGKRIHwknMMufkLUXPeX5c95IiBUyCXHtmZYlNpTuVv/1Vbq12hnCvG5dtaAOpef2vRercot2+fohjqnLGRx6mOMLFG0AHHgr36WvoS3tOGx8rgLV6JsR44ZP17hGrowF9qpvBD2pLVBO33s+R698cnSSD0mT3tNikMstChCd3moYjw8psFo5/LN5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(66556008)(4744005)(64756008)(8676002)(2906002)(66446008)(66476007)(52536014)(44832011)(8936002)(4326008)(316002)(76116006)(66946007)(5660300002)(41300700001)(86362001)(478600001)(54906003)(110136005)(55016003)(7696005)(9686003)(55236004)(186003)(71200400001)(33656002)(6506007)(26005)(83380400001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZF5LRrZR2sqZz30Mj0wjZIunGfVs4cKZg7kPZ1i32ygnrLVJUFcYQLPxQ133?=
 =?us-ascii?Q?VToI18ZafIzdfRGRWGkYDX7Pxz8fDizX8h+4xg5k+lfVXZRYTjvNRcN9szcQ?=
 =?us-ascii?Q?veTYtK0I5hxX1tSwbmfNmefEWhL5kDE15SN9nVgxnI73jQLcyjD9XhOQ/F8n?=
 =?us-ascii?Q?1BsqhP0ufo+nxMYH3BwbI2+ty4aSSty+ntVkHk67T+ASiY2A0rhtI4CM+Wex?=
 =?us-ascii?Q?f43Cr/eK3J2l8Gtjq6/UVFDy/50SPDMIjePcFARVU4oHYu2xiIKrBE/K0UQD?=
 =?us-ascii?Q?VTJs6h/zidiINvLZVBLf0C6qBvTcCUxeNYuX+L/K0FhPVwPHGMA2oN6ykEYZ?=
 =?us-ascii?Q?i7QRvuOrMOjSMjOGufGMRWfXQIWB6SHlNjU5lnKOzJtd7qnULknAI9PmwjCi?=
 =?us-ascii?Q?SxErk6okRvBQUktSa8RuFypjvkvl8tb4l0lBO8br5Cb7CUpG7PoOVx5JmVQg?=
 =?us-ascii?Q?kxiynd0lx4x5VBnr7SABZS2Di3nYsAIF1Fi6KwaiiAwOElyR/dNhRbzrhe+c?=
 =?us-ascii?Q?Ptq7p1PnqPsaF49s12f9u7C+pw6Ee8SH1hiKITvj55XaAAOoYc16IJ1rpC8q?=
 =?us-ascii?Q?/Aef4LTfpWlr+MuaVAmBkv2nyRmIkNC/J+g4xPfP/18c5LrDRIF6IdmZ8H2B?=
 =?us-ascii?Q?i0DCw4MqFkHftpYtkZYwgPnaQrcz+xLI1mHDZnXWYZdvXIyPVe9ZviPXKkLo?=
 =?us-ascii?Q?RrmfHsPDr+GuG7bnwxN1LL4ILngNkcfjVdwpVUR6KIblZDMXGWXI9vbe7P70?=
 =?us-ascii?Q?EaUsfurHXlKgfiTwCO6DUmNlnAezv8/wKDSJbcuQ3/S+WEVTtDlk6Eeid7sA?=
 =?us-ascii?Q?0Rvk8a1eQ0px7QDRjsvU5LZGjLDwsjp+qkjQehZ4OoZWKkzasM2Q/zaKpaSJ?=
 =?us-ascii?Q?KsMOEXsjfvq/BcopdQFnM0kjPgmXbNHJad3uHvcGWsXuootypZFkqUthkjKj?=
 =?us-ascii?Q?zfBAp/u+x0TUw2vbo/6S8z/P3SgwPGWkMtQqkG5DLfiQmzEd3dxhHVqEc7kC?=
 =?us-ascii?Q?fv0Kcw2To+pJNRbnGWQuXG97oyUcmrRSg6/Ya8OBOHyhz8LXSNLGmZEnFTrp?=
 =?us-ascii?Q?9FhbLlZGXSDuAUPkmoPVleyTtd8NXSCI/x+fw/nEKX8OOUqXduATSoYUzoj5?=
 =?us-ascii?Q?Q0i5otWpdtkUid6ecyX8KnYfsgqNfPA3QJ3+mXx0udGXa9Rt6mnPb8BA3yUa?=
 =?us-ascii?Q?RxcLSyBB9cCWTvDA7UXL30JRidthDuPM2kyKKkhwmSQaGH1l0Yn4+IF9zEro?=
 =?us-ascii?Q?qH9VtbsowmnrYOImzx3ZKNBOlQHPCJ4RIQAYkf1vT5Ha8BLD67nQuAroTpbT?=
 =?us-ascii?Q?+hEZ8JZ0RJsxfv2PLNatEDujYOgduQIJvWZmGNp9qwHF1kRBYowZ35emAbrP?=
 =?us-ascii?Q?wYgPkjJlHjDae2ipBb6r1W+O4LC05/RhjwiTLSQxiREWJqTaHlaLWEktWx1s?=
 =?us-ascii?Q?C+vORxoc91dcuPZAwkWniEV31THOifwLyjRdf1vwhFGTB8+c6B59Hj1xGFV8?=
 =?us-ascii?Q?385owj1yhE5Tg12hkG1wI2Gtz5tDfXbenvJOGKSWofzF3HEVG+bFpVrZaAVH?=
 =?us-ascii?Q?Seh92JeLywBMH7+G3bg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d09555-ab87-4560-4258-08db58946f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 18:11:15.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9qO0X23rhprLgY7Hk7gRTW3q0/rOy04TQCqGLGBKd4TrRMzApcaYbK5wzTB/yxZVw7DPWm5Ny3JlLVIEuNVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> Currently, the EPF probe function doesn't get the device ID argument
> needed
> to correctly identify the device table ID of the EPF device.
>=20
> When multiple entries are added to the "struct pci_epf_device_id" table,
> the probe function needs to identify the correct one. And the only way to
> do so is by storing the correct device ID in "struct pci_epf" during
> "pci_epf_match_id()" and passing that to probe().
>=20
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 3 ++-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  drivers/pci/endpoint/pci-epf-core.c           | 8 +++++---
>  include/linux/pci-epf.h                       | 4 +++-
>  5 files changed, 12 insertions(+), 7 deletions(-)
>=20

