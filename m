Return-Path: <linux-pci+bounces-354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF98010A9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8333D2819FE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687588829;
	Fri,  1 Dec 2023 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DPEObF8X"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8638010D;
	Fri,  1 Dec 2023 09:00:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikP6z6hoduV8kUNnTvWu8TQ9+qE2iXvTeiB8qAFty+cAff6On9shEGOROXhkkYO7L9rzWL2+z8RRlEf9Y6No2FV4tbk1qeqveTIB7vz/kRKw1AbM547qgaEw+NJBU4Vxmvu81SpZHIkqvS7RlbEIRZu+ooZFenUzD7ADqkRNBPhAiByRmvwy/m+sK+/A9260jUyuMvd4r3Wc0opbO+MTcAYTSqQHoVs4A8cVkwQYbMrtGGcXvvRdbt0bfebuzEiOar2JLSnXBPevsJtZNQ5DQbqcL5J0RBol/1ndNZFU773m4rxJfjmDfaUzWeZ474aYbcGzlrrCkJo7R+Isnrj94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSnp5dAukkACvX8mXBO0j8sOoAMkGra3fGayy1eoRSA=;
 b=TnIeYLkJMg+VYscl1anT6wsFmgSdvGLioH9Y+hQrVa87AE4nu4XDCRMHzlu5MDMz078inHc4vqx4AWCBCCQ9FLPKJsqStKsbn1cReoSss7cn75ueJ1bvxedyPjoIu6G1Nrl9L1zrXEQahN/qCDDtl5hPW5w52stLHu7/ofdvw1DnLdj+Bps0VZvny+lZC5dCRJy0IdoO1ln0u2wdK8YjENitlpvfcxizo+T19G5K6jcwwgYSr+MZIECbn5OVcwvg0EDEzgUj1J+YCoaxlZ5hf0sH8h+2lJvMH05BHDtbdSHspStgzTOj8UGftyDRYTcmXdl01BSZfZlU3we2u5h2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSnp5dAukkACvX8mXBO0j8sOoAMkGra3fGayy1eoRSA=;
 b=DPEObF8XeKAQtDlkAQlk87cDiJNneX1A/W0uOpWE1toDnscVbcZHN9NFJlwzN7FA++BhwDfYwKeMnwvrO8O8dze54OWWv8+bHiO8YcvinuzBQyEled3iyohFrVgQX00qfURgup5mm/VNMpFMzObpXEkhrn0/jiv6gtLu1G5mz6A=
Received: from AM0PR04MB5956.eurprd04.prod.outlook.com (2603:10a6:208:114::23)
 by DB9PR04MB9307.eurprd04.prod.outlook.com (2603:10a6:10:36d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Fri, 1 Dec
 2023 17:00:26 +0000
Received: from AM0PR04MB5956.eurprd04.prod.outlook.com
 ([fe80::611a:53a9:3185:c548]) by AM0PR04MB5956.eurprd04.prod.outlook.com
 ([fe80::611a:53a9:3185:c548%3]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 17:00:26 +0000
From: Roy Zang <roy.zang@nxp.com>
To: Frank Li <frank.li@nxp.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "M.H. Lian" <minghuan.lian@nxp.com>, Mingkai Hu
	<mingkai.hu@nxp.com>, "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v5 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Thread-Topic: [PATCH v5 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Thread-Index: AQHaJHHrGHCNctSYK0ibkWhpogoTJbCUpqkg
Date: Fri, 1 Dec 2023 17:00:26 +0000
Message-ID:
 <AM0PR04MB5956E863DA1295E96EC5DBC68B81A@AM0PR04MB5956.eurprd04.prod.outlook.com>
References: <20231201161712.1645987-1-Frank.Li@nxp.com>
 <20231201161712.1645987-5-Frank.Li@nxp.com>
In-Reply-To: <20231201161712.1645987-5-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5956:EE_|DB9PR04MB9307:EE_
x-ms-office365-filtering-correlation-id: 4640eaac-a34a-43e2-6fb7-08dbf28f040d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3EmjH2bbvY/kQtHzzzflJgqeJZGVatS12fRDMEKw1sbzPD71koDEMlHiEnN43t7kTbisoC6JSXCfoW1xREo+r/REUw4ZP1mjTF1rfQerLJ9X7+o0DrYxgjDyN218Gdz5+8kZZ26HdeRK3eQYSX9oSZYnVzd1SVUKFA15vAky/xqdQ4wU22Qw4X5lTqds8YRj2IWFVj5H6EeeRuH36gVPRRb4Rt784pRSxOyu8g0oJsrtU3Gb7VFOriDEk+CVozKTRm2tRynd+xQrgkm7TF6FEsm8OfCCfYfudXO5Lj2pKZMzvpjkDbf4UUvfHrz6UU7PwBjnoTkj/KCd00DQNWYPiQwHqHVWKqRyZnq/9F6ZcpHUHEuBEdNx+8e0cnsthU0bcqYPiQKvDQX4YU+8MBxO5ijHSmOG7zaHbW28bjk5pKrfPeVqP8YX8n20N84CXcFOE6tgtUM+F1xIygpWqm8m+/4EmCsdidwbCjmxgJ3d7DO+HTR06QV2Sq6TNlAb6rxIyf1nKfnkeikv/tylb3McwXSYQcA3HVXJc9kS++YKxRkmVdrpJYK2nnr6RSDKzE2TioA1EJv1nqaZKwzOCTd6zXetvKSxLc5yBaAokQCei3m6jjurSJGfWCAx4uSNAwMj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5956.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(55016003)(38070700009)(86362001)(54906003)(66446008)(64756008)(76116006)(66476007)(66556008)(38100700002)(66946007)(33656002)(9686003)(83380400001)(26005)(6506007)(55236004)(7696005)(122000001)(8676002)(110136005)(2906002)(5660300002)(316002)(478600001)(4326008)(4744005)(52536014)(15650500001)(41300700001)(7416002)(8936002)(44832011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VoK791g51+UxcbFXAY9XZ4GPXiNJgOcvkGq85HGAK0SNmtiEF9QMCP6TEnxc?=
 =?us-ascii?Q?Sann1e/gmFVgsGbyBi9p20atuMDvqdoJ2uhjeToiThcapKWQQ7NS2QAA1ixL?=
 =?us-ascii?Q?kTimuOjdyWYuzjhP3Q0QH7v4KIALkozw2C/+bDtL5sUHXOLu7z23oWAyNJNx?=
 =?us-ascii?Q?HCwLRgOR2ohjPJ2uMW9q6nlTFvSMq+HYXN4sxI6hMqrXOGnmf0J+3kbONjx8?=
 =?us-ascii?Q?Zp5d4rDGsX56fbyuU1AyFWz+/g21mhSyiIoGX2bZRaGspbun6CHWZ2qVJpkY?=
 =?us-ascii?Q?ZqZcfyY2CYviXc4nRKFtu5euZz7Xs7p6jNrIyK6sTeP+5m5Ezz2vEGhjSZFA?=
 =?us-ascii?Q?I/E5bC+GSngZI6GSWB+jtV+FZZWfxtxAPWzGiK/UhL3MgXnEm66uMyjDG6Ad?=
 =?us-ascii?Q?qgjeQ8hTZCYbettkY4lRuq8iXcnuELTcWijAvwUGEbPl75RzkITwE8chBHcM?=
 =?us-ascii?Q?JWcIHwcioOiW0IJztdwEH6tLCH/FCDyG64Mt39d05o9euFnECdVIfV4I/OKi?=
 =?us-ascii?Q?MV1nptNdSFEmbXTEntlvhv6AWzs6kYfBqF1p02cFCn55Cg6/UMZAuCft3iVg?=
 =?us-ascii?Q?nuhbWcuQRy8x0Aezom+bHxfkn+ZvjIaYJOopbzaaTQB5VMPKXTVAPJabdQ7m?=
 =?us-ascii?Q?sW7uY4cu8s2lQq6/Vvuu8T0AEQPCsWPZ0f6basbTul8L5CU/QXJMIaWacjB3?=
 =?us-ascii?Q?leLKA0Y82u5J71cGcvZJeoDB9FhcwbSUyDsh5Bakq9hlOENVZ2eQtsXyoBwg?=
 =?us-ascii?Q?6v4j5UF9qe96vLTcWt/tkDLAwn5eH+G3z+HiUw+7J153f8d3VdG09bnTDgNf?=
 =?us-ascii?Q?KdgSJZ2JdK10M4O5E7pAwMQkOQAKzeUaCjFoHxyr+cZk47CVjVVpYySsql8z?=
 =?us-ascii?Q?oVnNQDi/IBOohGmXla7Ilg00JzjngR0UGMi8cQVcOcDBLuuU4utrnG5uq3Sg?=
 =?us-ascii?Q?vjGuW1fZ7BlC3uZHcPrLRPACtkhEcLfrZUc0112YsprLOzFD7Tx1TUQYvwt2?=
 =?us-ascii?Q?0ioq72Ldutn0QnWmOjCw2Ntx5UsPTRJkgVRZk6eZ17ItpmOUKCkW3RBSFQKZ?=
 =?us-ascii?Q?+hHj4ubYdJ2tjYhni6LDE1o6I3yK1BnNjP7gjrp+Ae3NaxeIfiWUeoJTOsuW?=
 =?us-ascii?Q?LpZpqV1RLbN/zjjwi9XKLX9daju4vuBU1zeMdsb/8V75tUy/T/iYLxHexdun?=
 =?us-ascii?Q?AIyDtWgk9PAtGKkZLaNWcLzp5ZVjPOxDfXCuoMHEdBaAtEXpxHpZbvLGdGHW?=
 =?us-ascii?Q?iWALUSmdjmEsgXFH73TB9qGixCb/rpY2g7uaT1XJaVk48oXZE4YcmcP+RtiU?=
 =?us-ascii?Q?v+4jDb1umIaU0HzRiyQRBbW50oTq5qIMoFsoVOuQlbCemh/j+rq+1UpYtw/0?=
 =?us-ascii?Q?/tx5muj1BSS3BR2r/CpzJFw4zltvg5C8pp+Hpeh61oLx79xTIrJ6/S43d8nM?=
 =?us-ascii?Q?3IVomCN19tQXxrAOm3f5hxwMJw+GxCCrR31ELO3vgLnquDxZLlbrNhs8l3CH?=
 =?us-ascii?Q?gP62wplNULIBViLre4xoERNUTnTx84BOR0niB2QCK4po6Ntk8W6aHNVYLQy/?=
 =?us-ascii?Q?4sJI7dV9gKHVlBH4YtE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5956.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4640eaac-a34a-43e2-6fb7-08dbf28f040d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 17:00:26.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPDZQ/nIh7n0MuPL79ViXzTlfP8AOKSiVfon6y1hrc69n1TxEpk3EMXVbS8aAch6tL+YibhNivV5XfZg6nLAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9307

> From: Frank Li <frank.li@nxp.com>
> Subject: [PATCH v5 4/4] PCI: layerscape: Add suspend/resume for ls1043a
>=20
> Add suspend/resume support for Layerscape LS1043a.
>=20
> In the suspend path, PME_Turn_Off message is sent to the endpoint to
> transition the link to L2/L3_Ready state. In this SoC, there is no way to=
 check if
> the controller has received the PME_To_Ack from the endpoint or not. So t=
o be
> on the safer side, the driver just waits for PCIE_PME_TO_L2_TIMEOUT_US
> before asserting the SoC specific PMXMTTURNOFF bit to complete the
> PME_Turn_Off handshake. Then the link would enter L2/L3 state depending o=
n
> the VAUX supply.
>=20
> In the resume path, the link is brought back from L2 to L0 by doing a sof=
tware
> reset.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by:  Roy Zang <Roy.Zang@nxp.com>
Roy

