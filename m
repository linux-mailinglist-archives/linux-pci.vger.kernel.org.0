Return-Path: <linux-pci+bounces-15094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAECF9ABEF1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E44281AEA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134414A4E1;
	Wed, 23 Oct 2024 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R7B5DdAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F201482FE;
	Wed, 23 Oct 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665493; cv=fail; b=RVux6hXxgaCsbNRoz7jZw5FF3KyxEJUnCPtQIopdbVmNBlfbXr07hRyXi2MBN/Lqis1me2MOWdIapn0pQfhw1LiX9PD6E5vZErTnu+WiaRklOGL1C/mzycY5NR/tq98HPIO7uI17cxndcnqrOPt3Uputc3J2MV1R4M4XvyaWQ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665493; c=relaxed/simple;
	bh=GODtsXIEFIHT7DllE58jYlNz6Edbgs9pA5++BCwQhSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huilxt4OqyzntpXTxUecdgyA5ZcrLPsRrahXGO2Diw1fnC1piOC2E95tprjrJQO7uH4W75WmHQi2f3bAoxbF89qWkdfqakpF8vspBMHpBCkDtxAVpjC6xBrWCLRUSNVIN4poP6XTdY+bKbX/zxGbxwBIN6zxlQSuf52gVi33ouI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R7B5DdAJ; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eunieIIP8Hl7UW59pfccuXdcuZrcDimluM3MIBMUNAIZ20BrBmmYFtmNWLEfy7eLHWzn4ew1qluJ57GUep+LwsziH30leyc6Ifrd9XiM6D/THnrh2U7jESJQuQV+nQHtJKl706KWRbS3rUCkheFeEg8NhFuwYmpaZ+k4eRP/uUXxr16+DQABTytoYjgRUICJQlSytRXzsDK7MGxQOElwNoIwsG2oMhQLwy3RZio8zNA1ceHFp3kU2f/hEJY8rGRk/WDded4cCHoYgQpWhntED5WjHMFgdAUSahw2nQEzGx9TNqVdzLSPGoK74RwCGWZjRxv0ZQf84EVyMSP4UpZTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GODtsXIEFIHT7DllE58jYlNz6Edbgs9pA5++BCwQhSA=;
 b=AMlRMTD//O1qhwF0stp8CY3XKqS9IxSneySltDlcgBLZ0ALfxN1EX9Ezyv77JS6wSGLAcgH91uQ3+S9eAhVZ+qtC4r0gQ9Xc721X4YY5UdUmsSvW5ZqLSZslTMSVYMke14iWQAdKmM6ZNBtNhRd4adW5Eqddd3nnUo2ffrEJPejUbqM7ilEg53vt/N+SoOwM1iLxJREdny1qHAnW4seWrUjhBinzIbmSxBA3FyYq1p9nNyq7SpmgLkI8A/IWwbFWv4nH3VC1X7RmIv15M6+TwhiXhc6jzgVkTPjNqXBg18LQnnpu+Pt98nA+UDJTu3JMF9LD1Z6+xop6r4va0LHLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GODtsXIEFIHT7DllE58jYlNz6Edbgs9pA5++BCwQhSA=;
 b=R7B5DdAJEMKBQqeJzO8dsSWNTRaS3gHgU6dYQ7f8tpJo0IQ5mJKZeJYo3CBMPVujbFd8UXno17yDAX8sy56jn1vbxKyIa1NxgE1WBVG+z6ep20R8GdbdF6EbTZnio7kHcgUSV/sR/UxO58vP/BJs7+V89M03NbySk6UgCCRXc2lTaLpuZBd74LhAi1mPiZCyCh1iO/KdvuORVNIz2nPsmXl0fw4huU3ed/JIPMnuE78lloNfmAYp2s2vSQQoprePOVUCvC2lVaMN7IOCg/Wbn0Oydh9FSSA2n07vnjqyKx5qkwZe6msTfUlL9Oeq9dPiZLRXYt+A4vmhnVDdg0WTtQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 06:38:08 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 06:38:08 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Thread-Topic: [PATCH v4 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Thread-Index: AQHbJEi+KKzt7x6S50iNsf6Ba0SyfLKT4bag
Date: Wed, 23 Oct 2024 06:38:08 +0000
Message-ID:
 <AS8PR04MB8849DBAB40DF8A57778FFF3B964D2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-6-wei.fang@nxp.com>
In-Reply-To: <20241022055223.382277-6-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM9PR04MB7489:EE_
x-ms-office365-filtering-correlation-id: 7537b410-84c3-4e44-3377-08dcf32d41eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bo+SAlVobeavt9aC5ZeMb+RG0wwVXk39PkhE7Qws2eK1OUd7WXdmWcY7H3Vf?=
 =?us-ascii?Q?Ntdd9xLgbE+JFTeQIV8PLknzNKD8EsZiV2GI3BECh+JqAZlWY5+JAXIZsj4r?=
 =?us-ascii?Q?IGZSnt1WY86doCkeFpyN0CvhIFFFbVaf/xxYQEMXUXMAU8ymfoFCFS/iM6Ty?=
 =?us-ascii?Q?L+FJM6zuxeG2n9jyx5bfYH/0ajr0ExcoBiyxDIx64r8Z0Ne0itptzYsflo2X?=
 =?us-ascii?Q?JBvtj26wDcpp2998JSFlPIp1vOZXwOtoKr31Pwl8vBj9znf9n0dNZ8KwJgRG?=
 =?us-ascii?Q?VufODrb8lxuDLGfDeQ8xZj72rkOoZ8APOzvj2qylgPp3qS8EAKHdfqqhiLMl?=
 =?us-ascii?Q?ZPUZC8c/wzh2BWGkkCf+89FTKffwmLJR//uxvOQtgWUXIsuX4emsCz5TgTtt?=
 =?us-ascii?Q?ArsJ5ykm882nYgpWk5IsKPXtiJ1vR6IbPC2zcsvUeJjoCLt+5i+G8jtEcMwR?=
 =?us-ascii?Q?z445SJp2+gqAcTAayUU7Y4liYtaBG2AL4vTdc5g4HH42RTEjWRUDlPIJekbP?=
 =?us-ascii?Q?32j+70WvMhaxpqpieSilVV6qg+DYa1L7CPq0ALH6YQ9G1ZnfNPdPQ/pZnYWj?=
 =?us-ascii?Q?h0p0Zp3g1hs7MEb+sOhlMPjhzDSiCLZKr+sZkTyyNCCeYvUAA0ZGrN9lfvUo?=
 =?us-ascii?Q?XXjIX5WHtHbF3w6TItRLp4NzFe1diCx34XRHp5NIDUD7hA5w4KHcbYH178I+?=
 =?us-ascii?Q?YPHDGMfNLuYxFntxqC1F1wC6MpHMFDTJ0Tx1sK2Zm31tDlF3Cfulc9yp8+Kc?=
 =?us-ascii?Q?9h2K62ixT8WGcycwzfEvbNQLiDhwrHaQ6nQER8Go6XNa+/Sc1k4c5J7RiNf1?=
 =?us-ascii?Q?xW/VbbD8R9LfZhz6byE618qFL9PEFLogQTNyTdk9AYtZs5Nr8FY7XSA1MD0A?=
 =?us-ascii?Q?9C2VGwA39xkNDG7zs1nFiopu14SQyx4oZaINYU2eDchPNYBdQAyxpxlv6K9e?=
 =?us-ascii?Q?knedDMhexveq9kgieASC4xXaCOGXms9K/+mtXB9YPK6X60kCaBuTb9SIU5WE?=
 =?us-ascii?Q?i/aeYGck9yuJIsiIUqs57shXOLsn6/gWScTz2Ri5CyFuucuAwBiSVWQ+LJ9o?=
 =?us-ascii?Q?CsG+GRgNGuVfgwgEXn2/byMzQsx+kJrjCX0pa2z35Y2ab3hTMkryG2wEP93e?=
 =?us-ascii?Q?UPtrA/Pvq6f8MTOy56fYlOZyTT5ZQlHruIDKZWMN1KZcr0Yjy0DHZkY76Zdo?=
 =?us-ascii?Q?zpBvkz9AgEKwpuPlZgaK5en5LTzee/3zXxosYoAyAx/Wy91hfPVTMKWkrrKR?=
 =?us-ascii?Q?dG59vMQr38mlGKkkEbbQMLKsoUT7Zm4mO60mzuwNMcTAdrqUKd0IVIDxxCY5?=
 =?us-ascii?Q?AJ+tkMCBpRxkw4GB7r6S0L6SB5jVMJD0w2EagiLaWp1WwUo8RyYNIOVHanWh?=
 =?us-ascii?Q?Zqpe3LEFe4vc38ajZPfTOxzMeMcJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4fd0GkJfjo3howH6T0x8UW//rY5CiiaDplVvfJb5pXpTyUpswxKo5QsrRlsu?=
 =?us-ascii?Q?bgQQfTJpbxDn2Gq7nU6xuSuXwyK1JY/AbiV0DPhhOkgXNC2UQ9C80gtvHzXF?=
 =?us-ascii?Q?HMsSf7+6rdGbYPbPHSXfQlHOPb6DzmbWUHO6VDRhKsWWBxinv/amCGu02UMY?=
 =?us-ascii?Q?VmX5eG0UQH3I/7B8m3VaP78fImDlUyZm6dev3wGm3bHWQ+nc/gxOnhrrQhMQ?=
 =?us-ascii?Q?2G9526kuw1lgmjGAgZ/w57OfqGmxeLv19z1QT7V1DUdF7cT3CAOMKMTv3++I?=
 =?us-ascii?Q?lUOuwHNY/CVl33otZa5cjJ1zP9nbPHhlI4gMfwyfL0eT+izz5zh53Q5pGN8Q?=
 =?us-ascii?Q?vjTqqlHrbIrvkHAd//x9mwQo9Q8L04Yo8ew3rczvUArWy7cpjW9d9RgvDJIs?=
 =?us-ascii?Q?YpiM10MfkKRerb85UZ9IoMS4A2/nFc7zmtHgviiJhYPJRMnC1RzgxcqSBAX1?=
 =?us-ascii?Q?VM8HZ8AYfwpeDxj4NhuIHJ5O6DVUPAZGMspPRoZeBZ3P3maw55T3n97dSP2l?=
 =?us-ascii?Q?Q/arg+10alEc8mPUSm22hZL10prdmkPvMrWJtFXJsswWL056lnckxMmU7aZ2?=
 =?us-ascii?Q?skWPc0USv+4aonGYHM2OPW6Z5kOQEYClKklRaKLeN/NDbQ4mswNuOCIo4aqa?=
 =?us-ascii?Q?SiavnBS/COUq8gr5E6qAYoY6xHblWiL7YvnAXRxkCmLstrvHrt3v6vBUC6tM?=
 =?us-ascii?Q?Qc7RzaPXQvPYVxe2yrJOHW2YVTyCYULvx3Gu2mAJDa1qHulHsNi2eN8EK9zO?=
 =?us-ascii?Q?QqHNDLAcdFwH+6sgo9bp+jsrd87BFhZ7XfO/dhH1v1Az9LwCFXd3w72PVFXW?=
 =?us-ascii?Q?oY+kmnQn5UIMC2ywPH5xC6ACS2E4uKHN+0PFRjO+5z/k5dNOnykFmn+pClJ5?=
 =?us-ascii?Q?fqtdMvhV6x1Npd4dYslPF5j5x4PpmMPdsKTUFuBOyH9T9X/GGXdXnPGxjeD0?=
 =?us-ascii?Q?LIHaygol9pDrcCtf8kf1WFEFnTXJyAwo2gddPTVrLkNiHdnzdUyr49/M9bcN?=
 =?us-ascii?Q?m5d8O0+DMgt7poYzO1FK8LY7p23motxfCr/uR7wJzltrpFeTs1W4fVCYRCcS?=
 =?us-ascii?Q?xCNE4QvmyV79t/RU98FgEbXGfuipUdW4SsMM+Ibc8jbTrtrdD/hOOcJQiY3P?=
 =?us-ascii?Q?FW2TRnQN4/GIV3pyVzh9P3fZVHHaItu3eOIphctRtDu8dj4nOZ4Tp/+k7gqu?=
 =?us-ascii?Q?0VukEMfy+XbAktAk6eUQ7iPLFsQU3I02TYIFhp4rrmFNQ+7ouIh91cm/QJwS?=
 =?us-ascii?Q?SFyyqgIpC0fdPabcr/1/F6uFYPWV5VQraFYOCwlYyKtzNyWpSaSP6goJtik9?=
 =?us-ascii?Q?z2HXqbTsrDC7WfrmaZtsvQsYH7PQa27DF1cc2FcAQ8Qq3HI6U0y39XOP4eDD?=
 =?us-ascii?Q?xBYwyBO+C0TCiw2zOCPfS0+mxr76+xFCZ4Qeaa9WdS6pMUJtRG3zlDHpKNlR?=
 =?us-ascii?Q?bamXj6QtElhF6wI63HEp18fl/T4OzdItoy2YP7Uz/Y6YzpMl+saJoe0Cv8Cx?=
 =?us-ascii?Q?hTA4i/w9l/X1n/tLxT9v4znpfb1K4eZLJudybVJx9SKO4pp07EPF55wm5tff?=
 =?us-ascii?Q?7goysGuugx2P6/uoAasnCclq61QunCBNEXaW1e+Z?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7537b410-84c3-4e44-3377-08dcf32d41eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 06:38:08.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goUQOLXTcKAS7Nl3Q9ir3Kjp0dlzZkzYi9bUwrU/dqx+vZCMMEgoXzLCZbZGijH4amOGOckfvH/N6n0jmOv/2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 22, 2024 8:52 AM
[...]
> Subject: [PATCH v4 net-next 05/13] net: enetc: extract common ENETC PF
> parts for LS1028A and i.MX95 platforms
>=20
> The ENETC PF driver of LS1028A (rev 1.0) is incompatible with the version
> used on the i.MX95 platform (rev 4.1), except for the station interface
> (SI) part. To reduce code redundancy and prepare for a new driver for rev
> 4.1 and later, extract shared interfaces from enetc_pf.c and move them to
> enetc_pf_common.c. This refactoring lays the groundwork for compiling
> enetc_pf_common.c into a shared driver for both platforms' PF drivers.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

