Return-Path: <linux-pci+bounces-17977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CB9EA51B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 03:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA591887C49
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949919ADA2;
	Tue, 10 Dec 2024 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OmyGouGk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564314A60F;
	Tue, 10 Dec 2024 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797800; cv=fail; b=HTyN9GGnTB960y9tky3qkQpBKFKJwRzh0c+5q2MIkh0XowHyTuWrLhHj9GyD9UzGiKStlcZfS9KXdvfzWbmTl/fYo46VLmKd3hRS7C+HAopBc0EenkVPNC4P5JcZKsjiu2su7dIgpzn4MPKYZkd8OBLvAjk1blLXzsgOIh6jvwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797800; c=relaxed/simple;
	bh=TLTjU5VPSGmxdD8nYHDC87LjPf5ZJ6zYxiW0E+3/e4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHLdLD112H1s8+sJmCSIlBAVrPBI/jw4FQvkEN/AmLd08bkBT5U4dP7GrsVIB+XKYlixgwooFRogkrC8IijYr6/3aZJKYdvWayjYCqjcb1JDb/kBMSHFMx/YjnxskYK/ErF4U2qfU4zZonlixeXewH/Wgvb1+5bUI+shqiaZF7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OmyGouGk; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSJVKN+rSzlwaznmO0o20QfEzH0LlaB5Qmkr9fF/gu7PFVCM6tIFywUqBy+OSjC5n74xx1qfbyka55dQorRdEvIsirorJIk+XuK1+VBb6pFwcFU2OmwDB+pST9PY7KA6eS6QsJjwuMmmdWDNjE+lN87ru8jGno00Jr6Uq41iEUljlwwhGK4+UFwx5k5mVWp8QvB274EiLERBPPE/tB1N9KzhgEtq9pLkYLG7oajE0eI9seOo64RelilhCW7KJAt9J9UdUPx+YT+vMfPuAs6ksUz8mBXY7f/uPKLHFneJAKYt+vvOUPfY0XN2KVnKRbo35x8ErT1ngdigBPINTU/Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLTjU5VPSGmxdD8nYHDC87LjPf5ZJ6zYxiW0E+3/e4w=;
 b=wBJxAnbg/jBD8HcJetc5BeyL6lYMeNulYihc6PuukO4buw42jbk1FVEFXcdTrq/pRdNwpUtZOlVKK7MJLhZoy/VUbrWHJVCYzfyqolYuH5wBwApB17ojKXfXd/Sazsx6DUIuXyhONexn+3c4Co08Lq57XekSaIEVlvyywABh0ji6DS9L8Nd090YSrRMi8GvN0lpSo24limfNHQfSFt8mQsPqSuM40Gffct9+ay0ORk2yq91ZjGP2I8JtBwAXSn8d023nfcQ8cdUqGjudZ5zzq3FUzaK+1U/kh3WxQz/+XtU5UnVKhudKd0i0OHnBqAote+VFZc2Wasqphhb8jaXrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLTjU5VPSGmxdD8nYHDC87LjPf5ZJ6zYxiW0E+3/e4w=;
 b=OmyGouGktsP0+8CfzCOr1xUSJZnoQUkmhGyfmKNgCcJSlOQJzmE6bHp23fB9MFhLn3nlySHYkfvMaQR/hf/nflX4SPeHdcHZTo/hjSf0j/1dkfM8ijAZQyjX6sdyoYuN2UjXHJF4UxAUBV0+2u0s4e8JG8fXFNB7tMl/3hygb0MNIAYBuBl02lec7jpbUv7DH3rwd+JzU9LiwodSswB+nhfBjxSHhjDtqC2ac0qoMk6bArePvgtS80h6WnVYu8HXCTE4qLPDNDj0IF47SAcplPNopmXh5fd81ssTZMoG6i7MMn12n81rL24zT8SdV2y7Gtc+gLw2bovtgqEdChokyw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8357.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 02:29:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 02:29:52 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	Frank Li <frank.li@nxp.com>, "quic_krichai@quicinc.com"
	<quic_krichai@quicinc.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v3 3/3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index: AQHbSg2aC5LDn4GTf0y79GDyrUOzZLLdmfSAgAEnsGA=
Date: Tue, 10 Dec 2024 02:29:52 +0000
Message-ID:
 <AS8PR04MB867639DD98B14369CCC1704A8C3D2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
 <20241209073924.2155933-4-hongxing.zhu@nxp.com>
 <48988ec4-06a9-447b-bdd5-be35f31a5488@kernel.org>
In-Reply-To: <48988ec4-06a9-447b-bdd5-be35f31a5488@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8357:EE_
x-ms-office365-filtering-correlation-id: b0129f83-5a96-4b3d-e8ed-08dd18c28729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWtnODI4N0ZlWjVGQUl4RXdKckRsOGpxMTdoZk5XQkI2SzBlRFVWMlRQYklm?=
 =?utf-8?B?RHRiMWtUd00rNjE2bUIvTmtiS1E0ZU9zeXkyWlA3ZGRkaXBBb2VKdEZGY00y?=
 =?utf-8?B?ZEF5T2lycVBWR3F6OXRlMUE5UG9uRGZvdG9XZDdUOWFvQXFTNDNIcEcwSmhR?=
 =?utf-8?B?K3QzK0R2b25xYnJDTi85QWhZMW1zY0dZMTlxTDNzU0xoaXFwb3VDdlBzbEN3?=
 =?utf-8?B?MGlocUpCTmFWVFExalBva1ZpSWJGek90cHFoSml0c2VsakRCSmpSZm5zWlB1?=
 =?utf-8?B?bHRFZUtlZjFPeUp1dWdxRkliZlBGdGpXV1Vzb2ZNMzVSd3lMbVcvTzArdGVw?=
 =?utf-8?B?TjlqTk5QcmhQWTZoaTV6cENIWElKd3hOSi9BVHdQL0Z1R1VKbHJmRkM4RTJ4?=
 =?utf-8?B?eGlwTG5KVGlNeVp6NUM2TWFqb1VVUFp1K1dMclp3dzREcElWTXJSOXRJZjZV?=
 =?utf-8?B?bGlpM3JBUHoyRFVJWHpDallLaVl1TEdaNEkvMHZZdkJqSDZ0d1ZtMi9Wajha?=
 =?utf-8?B?WnBZMXB5dXp5WmRYcmtDbmtlYlZqd1I3eHBiRFI2Y2R2U0dORVV2NGdlejNY?=
 =?utf-8?B?MzZXbFFRKytESE5kQnhpQTJxRFR3bW9zY3lNSkd1VlJjRzJFbDNDMncxZnlT?=
 =?utf-8?B?YS9sdjMreHZpUGsyRis2ZkpUeVpDZHVJYm1vL2dXTE45SlovdWFBR1hROUdQ?=
 =?utf-8?B?NUNqRnNRa3hsWW54RjBIaVB4MW9SenR3UmZtNm9hT25zRjVIRzJEMk44N2Jy?=
 =?utf-8?B?Q2U3Sk5GdEVXUStKaStFS2xTZlBZRGgvbmw3K0dRdjZkYXVqNk9WbmhWUVkz?=
 =?utf-8?B?MDBsL3IvT0tvTGtCci9tYWNhWDJhNi9yM0RSYW9XQmk4aGswdjc4MWRXVWVH?=
 =?utf-8?B?ZktrTWZuRVpOUzd3VnE1aDEvbWJaN0libzFzY2Z1R3dpRThMcTNKTHdpOTc1?=
 =?utf-8?B?WUJqbHNqN1R1cTNTV3BiM3VWNUNpOGljUUJDeDFMZFJXN1o0VG80Nm9QSXpr?=
 =?utf-8?B?SVI4Y2gvbnBrejZocU0vVGJXeDk1MGZoSGlTUlBFOHhNcEJydlJrT3I0bkFa?=
 =?utf-8?B?Z2J4QjJwR2VCRHdxcUppWFo3dEdIYm9BN0dUQU5EZ3hkcGRGaXp1OXV3bWZG?=
 =?utf-8?B?UngyektnRm1IUU95TWt2NGgvTU1jVlhjL2Nla2FGR20zczgrWjhVYTR2R3Mr?=
 =?utf-8?B?SzVCUUFPYmVqemlWbm9remJIblVTV3E3UGpoUW5MdGVLRFhMbGtTMisxV3pB?=
 =?utf-8?B?ZmtnUVVzTDBmelVva0hQQ1FXdURkK20zMnRhQUVBQWk5cnlCRDRRTmVrdDZH?=
 =?utf-8?B?aUZoanV2WVFhQzRQdnVibTh2RW5QZklsMFFxcDBGSHNNektub2lTb3JsL2w1?=
 =?utf-8?B?RDlGTTY0cXp1MElwdTZsa3pzaS85U1QvQ3dKUkZzMnVnYzRDQUlBQmR6cG5B?=
 =?utf-8?B?K0F2ZlczN3VqcllTU2hJTUFsd2ZiSHFiUDNDeHhNRHVnY2xkSGgweUIwaVBE?=
 =?utf-8?B?QmtyTHdva1Y3dzU1WFU3d0tnVDJGQi9BV1hRWjRIT05sdE9Sa3J1RzZUS3dE?=
 =?utf-8?B?WHRJZXVvbE81b0pZVkV2LzFlRWtrL09lNlNaNDlNWnBuRjU3QVdFczBseTBQ?=
 =?utf-8?B?NFBheFlLR0hjUEpLTkpSQXJpcHo2VFdhWUtjVWp1Tk4xc1lqU1hMZUU2QVdI?=
 =?utf-8?B?MU9EdW9xUXdVQk5SQWt5a2pWb01lWDVocGxHQmI3dFNLUU1HTjZNYTF3Qk9o?=
 =?utf-8?B?a0ZoUTF3WFBlSmdXSG1kdWF5Ni9UUG5HK1BCOXdLQmFyVy8wa2hxNW5jcms3?=
 =?utf-8?B?U0JjU1FDTlZGQy8wNzNHTW1iK3dNZDZOQ3N0djBBTzRvSTBXYnNyYVU3SHBG?=
 =?utf-8?B?K281ZDlaZ202SVlkdDdNRzZTbmI0V1lJb200K3hYQm4rclE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2NSSGF3SEVLZ0ZJQW5TRUF2OUdrNFpXWjJPUzFpaThhYWgwN1g1KzgwdU9R?=
 =?utf-8?B?V21MYjJBbWExMlBXZHNhNVVZQ2tCajFya0JzTzRlVXZVR0JPZGFoV2ZMQU9W?=
 =?utf-8?B?eEFUMkZCMzhaTm1yS1dSOVJtMDRXelQxb3psMHZCeDcveHQrNUszL3ExOUVR?=
 =?utf-8?B?NHJCaXJjRTVRdm12c3orOW1RUjVKaE9yQnNaVzZYSDhPZ2pjZmQxdkJXRndr?=
 =?utf-8?B?bnprcnhFRU9LWVhBaDNpdkQzbm94bjdOd1orcTlpOHYrU3ZZU0lNeGFFbGxQ?=
 =?utf-8?B?WExqNy95bU9DaEFCcUltZzQrd0dsWFhWSEtVRWxJdEtSMHBQbW9tYTlhOG5j?=
 =?utf-8?B?MGxsWU56YUkvZTh0cTZlbTdRQlpVNjJMV0U4OHFZM251MXZBZVU2NHJ0bGVG?=
 =?utf-8?B?bG05Y3Y1TGlCRDZZQ3pyZXArVER0c1JHbGw5eXZPNS8yNEwreERBemtKVkNV?=
 =?utf-8?B?allQdHBkQXc0b24rLzczTTF6VXhTWnNTdWtvYWdudGtzSzgwRXFIWFFVNVpD?=
 =?utf-8?B?eGFGb0xTZEFKQWFlWlVDM0VXQnpHRi95d0pEaG5taVk2TEtlc3VlK3QzaGR3?=
 =?utf-8?B?VEdhUFc3R0ttWHBBbkc0NWdJSWc2K1BOQ1BwVkJibDNtdnlTY2dyRURGYTVU?=
 =?utf-8?B?MGlEY25qL2FYWThrZDZiRlJXZWxBSjE5eVJjTWlDTHBwU1RXZE8rUVRMWDQr?=
 =?utf-8?B?QXNNQUxZZzFEZ1JkcUNXRmh0N3JCY0Faa3FRN0krNE1IQ1N4cHBtM3J5a0VC?=
 =?utf-8?B?dHNpZURNYkZ5WG1rOVVXKy82TnNJeC9kQzJ0U2xSVjNyTHI1aHNYb1N5eFpF?=
 =?utf-8?B?WEFpYzhHNjZXTkd2Yk9iSTM1S3JaZUE2RmdsSVh6eWU1T2k0TWlTQ1F1aDFV?=
 =?utf-8?B?RUtxSndsWnpBSmJvQWQ2R2l3YkhmMkZLMWZzYnkzS0FlVjRYK2lCZkF4L1k4?=
 =?utf-8?B?cUs3eTU3VFpmQ0UzV0x5VWNoQWI5OFVlUG9vRzJXem16V2Fqam9GVUpES25F?=
 =?utf-8?B?WVZSWTZZV2d0TStJR29VZFJjSCtNODdrTmgyejR6VWozdnVRWk9ORHJHSjcx?=
 =?utf-8?B?MEtBalpWNTRGbS9CK2tYdVpoR0N3Q0dhRyt5ak8zdm03SHU3RlB3RHZpSnpv?=
 =?utf-8?B?ZXhYYU9VRndNcFRYa09jcFgwMW53c1lhMUVkbVQza1d0SFczNDVwM2Zibmp6?=
 =?utf-8?B?YXV4cStwanR3QzQ0ZkhmNjg1YzhiZXYvOWxnVjJ6aDlvZ3AxQjhYZ3NYR2pR?=
 =?utf-8?B?bDNDdzJtR3BjOVBzU0xybXNRREF4VDlnbVJhZ2JrS2RvZjBnQVhYZDZjZUw0?=
 =?utf-8?B?dDZlUzBWWGplVXVIdnY3b3lwMG5TYmlSanl2ZHpMZGpNTWtpZGxQOW1jQjlD?=
 =?utf-8?B?QUIxK1VlcTNrUkNoeXdqM3lOUlBnY0U3dmtWNmpsZWdKbUk2MHI2OW8yZ09U?=
 =?utf-8?B?a2FEeGtXRVJ2ZS85WE4vUGM0bHpQcEZadkdmNjRBU052Y0FwVEZQQnZtYVd4?=
 =?utf-8?B?Z3l3VXhsZ291eWJhd1A0OCtsUFd0TC8ycUpldXdiKzRMcW11bEFPbGR0d3FF?=
 =?utf-8?B?eWwxRGUrUmpETm9zQUxjdkdLMDNuM3JlZ0NqUnRrYlFxM3Bxa2pIdTAyd21H?=
 =?utf-8?B?a0lOSlYyVjhVWE1EUEZ5bWExTUxoWmlQVS9BcUJRdXVUS1NtYXAvQW9XRTl6?=
 =?utf-8?B?Q1JhYjM3MmpOdVRwTCsxVGV1ZS9rQmVKVjI0NVUveTlvaWJJcTdmdmc4bURC?=
 =?utf-8?B?b1JPWHRaYXFLK2JGRStoU2VqOEVXMmFSQUhQUkpMWjgxUFBpZGx5dU1yUmxr?=
 =?utf-8?B?QmF3NE84c0tPZzRRMjV4aVNseGoxZ09NNmVBRm9tank0cmtjZEFxaWdnTzgw?=
 =?utf-8?B?Z0N6aEM3aFZUWlpLSFdkT0FaMElGNDc0N2swRXhBMjEwV3BQTmdsdWFQZDhV?=
 =?utf-8?B?YUc5UDBXYjZ6cUxQUmpTWEcwM3NNWjB4bnFDMHhMdTBZc0lSRS9HKzVseVN6?=
 =?utf-8?B?d01FU3ZOMVhORldZdDFoZG5yaDJSd2lZUkorUUFIMVV6ZnEzTkVSenE2UnlP?=
 =?utf-8?B?VksyeVRQdTJ0V2lwU04weWExa3RMcHl1b1k0cDhkNVk0M016WnpvUHJjTm9x?=
 =?utf-8?Q?WcTaD7vt5pcIOxq5C9iz6ExXk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0129f83-5a96-4b3d-e8ed-08dd18c28729
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 02:29:52.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLaAEv5fwstcb4asJDMIiOXdfcQkPGllJbuwlyC8wfSbuhMPlOdOD9IBt70gRSw/vLALG/6S69bRbac/ThMNKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8357

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxl
bW9hbEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI05bm0MTLmnIg55pelIDE2OjQ4DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207
DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXgu
Y29tOw0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3Jn
OyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT47IHF1aWNfa3JpY2hhaUBxdWljaW5jLmNv
bQ0KPiBDYzogaW14QGxpc3RzLmxpbnV4LmRldjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy8zXSBQQ0k6IGR3YzogQ2xlYW4gdXAgc29tZSB1bm5l
Y2Vzc2FyeSBjb2RlcyBpbg0KPiBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KPiANCj4gT24gMTIv
OS8yNCAxNjozOSwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gQmVmb3JlIHNlbmRpbmcgUE1FX1RV
Uk5fT0ZGLCBkb24ndCB0ZXN0IHRoZSBMVFNTTSBzdGF0ZS4gU2luY2UgaXQncw0KPiA+IHNhZmUg
dG8gc2VuZCBQTUVfVFVSTl9PRkYgbWVzc2FnZSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIGxp
bmsgaXMgdXANCj4gPiBvciBkb3duLiBTbywgdGhlcmUgd291bGQgYmUgbm8gbmVlZCB0byB0ZXN0
IHRoZSBMVFNTTSBzdGF0ZSBiZWZvcmUNCj4gPiBzZW5kaW5nIFBNRV9UVVJOX09GRiBtZXNzYWdl
Lg0KPiA+DQo+ID4gT25seSBwcmludCB0aGUgbWVzc2FnZSB3aGVuIGx0c3NtX3N0YXQgaXMgbm90
IGluIERFVEVDVCBhbmQgUE9MTC4NCj4gPiBJbiB0aGUgb3RoZXIgd29yZHMsIHRoZXJlIGlzbid0
IGFuIGVycm9yIG1lc3NhZ2Ugd2hlbiBubyBlbmRwb2ludCBpcw0KPiA+IGNvbm5lY3RlZCBhdCBh
bGwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZh
bUBsaW5hcm8ub3JnPg0KPiA+IC0tLQ0KPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS1ob3N0LmMgfCAzOA0KPiA+ICsrKysrKysrKysrLS0tLS0tLS0gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICB8DQo+ID4gMSArDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LWhvc3QuYw0KPiA+IGluZGV4IDE0ZTk1YzI5NTJiYmUuLjAyZTBlOGMyNTVjNzAgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3Qu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1o
b3N0LmMNCj4gPiBAQCAtOTgyLDI1ICs5ODIsMzEgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2ly
cShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJaWYgKGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwg
b2Zmc2V0ICsgUENJX0VYUF9MTktDVEwpICYNCj4gUENJX0VYUF9MTktDVExfQVNQTV9MMSkNCj4g
PiAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+IC0JLyogT25seSBzZW5kIG91dCBQTUVfVFVSTl9PRkYg
d2hlbiBQQ0lFIGxpbmsgaXMgdXAgKi8NCj4gPiAtCWlmIChkd19wY2llX2dldF9sdHNzbShwY2kp
ID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfQUNUKSB7DQo+ID4gLQkJaWYgKHBjaS0+cHAub3BzLT5w
bWVfdHVybl9vZmYpDQo+ID4gLQkJCXBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYoJnBjaS0+cHAp
Ow0KPiA+IC0JCWVsc2UNCj4gPiAtCQkJcmV0ID0gZHdfcGNpZV9wbWVfdHVybl9vZmYocGNpKTsN
Cj4gPiAtDQo+ID4gLQkJaWYgKHJldCkNCj4gPiAtCQkJcmV0dXJuIHJldDsNCj4gPiArCWlmIChw
Y2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKQ0KPiA+ICsJCXBjaS0+cHAub3BzLT5wbWVfdHVybl9v
ZmYoJnBjaS0+cHApOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldCA9IGR3X3BjaWVfcG1lX3R1cm5f
b2ZmKHBjaSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+IA0KPiByZXQg
aXMgYWx3YXlzIDAgZm9yIHRoZSAiaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYpIiBjYXNl
LiBTbyB0aGlzIHRlc3Qgb2YgImlmIChyZXQpDQo+IHJldHVybiByZXQiIHNob3VsZCByZWFsbHkg
Z28gaW5zaWRlIHRoZSAiZWxzZSIsIGFuZCB0aGUgaW5pdGlhbGl6YXRpb24gb2YgcmV0IHRvIDAg
b24NCj4gZGVjbGFyYXRpb24gY2FuIGJlIHJlbW92ZWQgdG9vLg0KSGkgRGFtaWVuOg0KT2theSwg
dGhhbmtzLg0KQlRXLCBJJ20gY29uc2lkZXJpbmcgdGhhdCB0aGUgdXNlLWNhc2Ugb2YgIzEgcGF0
Y2ggaGFkIGJlZW4gY292ZXJlZCBieSAjMw0KIGNvbW1pdCBhbHJlYWR5Lg0KVG8gYmUgc2ltcGxl
LCBob3cgYWJvdXQgZHJvcCB0aGUgIzEgcGF0Y2gsIHJlLWZvcm1hdCB0aGUgY29kZXMsIGFuZCBh
ZGQgb25lDQogRml4ZXMgdGFnIGludG8gIzM/DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUN
Cj4gDQo+ID4NCj4gPiAtCQlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNz
bSwgdmFsLCB2YWwgPT0NCj4gRFdfUENJRV9MVFNTTV9MMl9JRExFLA0KPiA+IC0JCQkJCVBDSUVf
UE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gLQkJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9V
VF9VUywgZmFsc2UsIHBjaSk7DQo+ID4gLQkJaWYgKHJldCkgew0KPiA+IC0JCQlkZXZfZXJyKHBj
aS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4JXhcbiIsDQo+
IHZhbCk7DQo+ID4gLQkJCXJldHVybiByZXQ7DQo+ID4gLQkJfQ0KPiA+ICsJcmV0ID0gcmVhZF9w
b2xsX3RpbWVvdXQoZHdfcGNpZV9nZXRfbHRzc20sIHZhbCwNCj4gPiArCQkJCXZhbCA9PSBEV19Q
Q0lFX0xUU1NNX0wyX0lETEUgfHwNCj4gPiArCQkJCXZhbCA8PSBEV19QQ0lFX0xUU1NNX0RFVEVD
VF9XQUlULA0KPiA+ICsJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiArCQkJ
CVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMsIGZhbHNlLCBwY2kpOw0KPiA+ICsJaWYgKHJldCkg
ew0KPiA+ICsJCS8qIE9ubHkgZHVtcCBtZXNzYWdlIHdoZW4gbHRzc21fc3RhdCBpc24ndCBpbiBE
RVRFQ1QgYW5kIFBPTEwgKi8NCj4gPiArCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0
aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4JXhcbiIsIHZhbCk7DQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIFJlZmVyIHRvIHI2LjAsIHNlYyA1
LjMuMy4yLjEsIHNvZnR3YXJlIHNob3VsZCB3YWl0IGF0IGxlYXN0DQo+ID4gKwkgKiAxMDBucyBh
ZnRlciBMMi9MMyBSZWFkeSBiZWZvcmUgdHVybmluZyBvZmYgcmVmY2xvY2sgYW5kDQo+ID4gKwkg
KiBtYWluIHBvd2VyLiBJdCdzIGhhcm1sZXNzIHRvbyB3aGVuIG5vIGVuZHBvaW50IGNvbm5lY3Rl
ZC4NCj4gPiArCSAqLw0KPiA+ICsJdWRlbGF5KDEpOw0KPiA+ICsNCj4gPiAgCWR3X3BjaWVfc3Rv
cF9saW5rKHBjaSk7DQo+ID4gIAlpZiAocGNpLT5wcC5vcHMtPmRlaW5pdCkNCj4gPiAgCQlwY2kt
PnBwLm9wcy0+ZGVpbml0KCZwY2ktPnBwKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggNWMxNGVkMmNiOTFlZC4uN2Vm
Y2I0YWY2NmRhMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oDQo+ID4gQEAgLTMzMCw2ICszMzAsNyBAQCBlbnVtIGR3X3BjaWVfbHRz
c20gew0KPiA+ICAJLyogTmVlZCB0byBhbGlnbiB3aXRoIFBDSUVfUE9SVF9ERUJVRzAgYml0cyAw
OjUgKi8NCj4gPiAgCURXX1BDSUVfTFRTU01fREVURUNUX1FVSUVUID0gMHgwLA0KPiA+ICAJRFdf
UENJRV9MVFNTTV9ERVRFQ1RfQUNUID0gMHgxLA0KPiA+ICsJRFdfUENJRV9MVFNTTV9ERVRFQ1Rf
V0FJVCA9IDB4NiwNCj4gPiAgCURXX1BDSUVfTFRTU01fTDAgPSAweDExLA0KPiA+ICAJRFdfUENJ
RV9MVFNTTV9MMl9JRExFID0gMHgxNSwNCj4gPg0KPiANCj4gDQo+IC0tDQo+IERhbWllbiBMZSBN
b2FsDQo+IFdlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0K

