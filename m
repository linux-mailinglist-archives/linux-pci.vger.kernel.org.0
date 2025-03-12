Return-Path: <linux-pci+bounces-23472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956E1A5D4F6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 05:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB4717707F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 04:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2871D9663;
	Wed, 12 Mar 2025 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VSkGbED3"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA31D63E1;
	Wed, 12 Mar 2025 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741752554; cv=fail; b=UtDMrMYltZhvOnvwsaexarBdn2/elbQU8L+LJKYhYE6huAbufY+zG39cZ+4yUT0FDnJW44ARw8ZcO5dQe++o87OlgtbEEIrRZMQi9AVuFIbv0lkJUlwIDSjcfZNwApm2O75xG79TdpWAftF0/9zhorMfSenu2eavUVq5OV2cDWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741752554; c=relaxed/simple;
	bh=HfpwY42hZh2oUMVv2hqpGhvj5sd1EgR6sC+bNOIfDvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrOLBq8ToomggRDKaHZTe5DfNCO5moYyzX4473jWtlnwtxhDjK6UsbNI6pGZ6oab0QA+cxatja+hz2UMjfoasCVHyxofrIbRb2CuO8qAkm8Hn3Fvua6/Cbyz9K0H9CefY9tGQ8pWpyMFOSoo28oK6vYT8yNSdB9tVVYU40XB+xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VSkGbED3; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8NUoGfc0nfaYhxrO8m/f4TxwP/ZFCPj7O0lMKS7EQT5L+b3X2jSmsuifXM0pw5cXyAStl7GDyo7oiMCwk3HMvFhQfXialXc6bF9yd6B2STuHMd7CihRmwqARFzEq037vbT90EkYEjR6MNFIqpmm4ANqeROiHjG9v2ZgzlYVy1hzD0emhjhQbzd8DaUuZPW+sdC/qPwD+ePs8XMVM1JshVosYmXGHF+0cfF41hAgg0MX5SqplHAkkH6mmCS0RC/jk+cSJwxwkSyjmRL9VzU9N3/dMwEcLDfteLFUBAZNOPmOSvB96bnVyuNS/9ol/ugHiMpWNNfEpjS11KHkUceElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfpwY42hZh2oUMVv2hqpGhvj5sd1EgR6sC+bNOIfDvY=;
 b=KYCGKMYRnM2MDOMCsNKzzlMhyRMJZ9xLXVOPR9oZ1m3POVrVG5XkoANW4sNQk7j9+sohLP/wxfrie7otWY96IKPFhzckbW2m47k6z5VraOK0qi+1Z4HGhttg4oI4UU6b0z+Fz9IzpsF+xFV9MS3DBlkzgo31DFB5WbTRPBK/gCJxVkZc2nS6gAEBInapp/ib1GlaXiaWRcuQ8HR9bnFmwMwbIrzRDysJvQYu7EkBalcY2coxag2mxhzuVGreFtOIViYTiujVRG0EBsxHWkI7dGTxYkZdkvlIELC6nhLicknspZTE5kDsS8nHYMoWxFTkHOu5s2wZWf2YkTaljBcUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfpwY42hZh2oUMVv2hqpGhvj5sd1EgR6sC+bNOIfDvY=;
 b=VSkGbED3BnCEn3EZnTMUG4GUvIbTE5pT4yA/4sSabiWzzptl/oa0QI3xyrdHyGjvbls3GI4dhh0oeE2FGtD42LzLzgcffkg5n5uKcSvyeadoMx5BZ1fc4JDBsnMGK/iSuyyH7ynGel4LN1H8dQ9kNAnfTdM+Qr0047uPG7JkEisAh8FSCXKul9CBmSfKkSsgJmf8cPun/gaexvVCtYt+3HbDXF6ImuDp5WONoCnhNSzUpvsQ2yofSL8RqxiaxEkeJAh+FJ4FhECvFPBJ9gS0AhCwaEhHqTZzrQXVwPUmwOaM8hOZLkMTvkzsxRKG3LORLfNCp8DrJYVeeOOvroTnCg==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 12 Mar
 2025 04:09:06 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:09:05 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] arm64: dts: imx8mq: Add linux,pci-domain into
 pcie-ep node
Thread-Topic: [PATCH v1 1/2] arm64: dts: imx8mq: Add linux,pci-domain into
 pcie-ep node
Thread-Index: AQHbh/hNv/0ewzrr3UuwkUP4jJuTYrNdWoiAgBGdwbA=
Date: Wed, 12 Mar 2025 04:09:05 +0000
Message-ID:
 <DU2PR04MB86776EF9E224096AF09C90BD8CD02@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
 <20250226024256.1678103-2-hongxing.zhu@nxp.com>
 <Z8JBL7/LoCRemdjH@lizhi-Precision-Tower-5810>
In-Reply-To: <Z8JBL7/LoCRemdjH@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|GV1PR04MB9056:EE_
x-ms-office365-filtering-correlation-id: 8694deed-3085-4f2a-917d-08dd611ba194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?V2tsM0lXeXI4RFVBQkZzWENONVVvUFFUTUxNeFB3ZTJTWFhZRmtKTml2SWE2?=
 =?gb2312?B?YlU5ekNjTEZSWFdZMjFReHRLanlRb240UUZPeXZIVWhsT3Bpam9FMFBZaGhW?=
 =?gb2312?B?ZlVSZS9iUUpjbll3TWw2dXptY3c4Z2dXVmw0MzgxSWNubmF5MkY1aUMxVnV3?=
 =?gb2312?B?eGNFc25jbTlOL2gyMFByRDFPM203SlJadkxTZ0tuOTFBcm1MNkFtNkZ6dGRm?=
 =?gb2312?B?MFR2QkwydXIwYjhVMnRUeURsNHBVdzRlaGNZTmtpNzRUZzlFWFB3N1BVdlRt?=
 =?gb2312?B?akJBNmhFM0lBV0NHbi9sSW9HQVQwSXpHcE1lWjN2N29UczQ3VDFadWd2anZv?=
 =?gb2312?B?MG5hbW55WExvSWJYdXJ0OGZraEVrUlVjb0JJeWxvU1JCYnVoTjRSMlc0RVY0?=
 =?gb2312?B?L0FwWUJLcnJJVVV6Rll3aWkyUUo4c1BmYVJlYXYrcW1SdUl6SnVxU3ltUEdw?=
 =?gb2312?B?Z3ZOZXZEME1XZUVkRnNZa0ZNOXFPVCtoSXc2NDJwWUozT05ueHh5QWF2a2xt?=
 =?gb2312?B?Q2VYUEtYTW5LRUhMUkRQZ1Z4N1hoNWh6bG9MckRYbTFaRUEwbDBBSjU2d0FT?=
 =?gb2312?B?b1J0cDUvMVJHYjBKOVoxZ0tXY1JMMmVqKzYybGZYWXFtZFhxR1hjWW4yd0hU?=
 =?gb2312?B?RitkdXltaks1RkJQOSt2QXRJUWgyKzAxWEltV2hYTHhTYU56UzgrSFNNOTE5?=
 =?gb2312?B?bUJGeDZwb3BqWThBaGVyTXE3Z0hZRXFtS25raFAvRXVOdG41QW95SDZuOWVG?=
 =?gb2312?B?ZHBERjVERlBsTHBGNHJNSTh3dSs3K2phbGIyZmVYcDhrcGtHNGE2b1YzVG5r?=
 =?gb2312?B?Q2loZlNjM2RRRVRkK1Z4dDJGakdMd095VlBydWFHZStMbUFKM3FEN0p4K0Nw?=
 =?gb2312?B?Tk8xK3k1MTlIL0JTMnQxVGhGc3lpdFkvS0NuSy9qc3lleGNSM1RWdWpNVjF4?=
 =?gb2312?B?WW1TQndwK0J4VzV5bWM4d0ZxUm5ORG1EQlBsd3k5czJFUGZTeHc5SEdCTDRj?=
 =?gb2312?B?Nm9mK2lRM05zczBpWEtLNWsxZXFybXA3b2NpUXUvdE4yZmJtVDN6WVo4UE5h?=
 =?gb2312?B?cWd5dGdEVjBkbENXbEQwRUJZeEtlUFdDbFFDYkpmeFRIdHpLWGpoVUJSeWR6?=
 =?gb2312?B?QVZJbnRBUDJRemp3VWd0SngwSE9QZ3U0Mlk2b3lhL0ZBdDhvTTkzWTEzM2hV?=
 =?gb2312?B?bkFxOEJMbVhSdzhONWV2by9EclB3Y2tBL3I2RHd1YzZ3TnBINFZZN0wxejJP?=
 =?gb2312?B?SUVPR0xFbDJ3VVA4dmpkWEY5WVFRVFM4QS9DMzUxU0cvZVZGaVhWYVhHNTNX?=
 =?gb2312?B?VTF0STF3c3E4b21mV0QxWjN2a01vRGkxR2NkU0ZFNkRocE9NME9vUDMxNnZ5?=
 =?gb2312?B?TjlTcWJCQUNjODhkSnFHVmVYSWhxZ2ZxQ25va1M0UktzUktzZndNZEcyTFh4?=
 =?gb2312?B?aGV4d1FJQVRCOHlEZmNQalJpRkRsYUZYNlNVeGxqN1FOMlVGK256ckU1bERL?=
 =?gb2312?B?QlpzMXdsQjQ0ZDJsRjRKc3BqWTU1aEY5MW1lRGNGeDRYZXFGNFYxamdJbUtQ?=
 =?gb2312?B?cXV5aGdPcGYxT2swRk1KQlA1ZmRlc2hXZ2trbDhwcDNlT21tREpjb2ZRaGxD?=
 =?gb2312?B?UDgwbjdGbTJNV1dsMlNMWnljVkhOWFRXQVhZUXF4UEgrZ1BXcGpRcG5rMGp6?=
 =?gb2312?B?U01HSVB1OXdIUGxwTDBGb1hTMExsS2R3WDB1eHlhbjUzLzBKSG5mYW5oM0lP?=
 =?gb2312?B?MHNCUVd3ODVBTm9rcE4yUGsrckRLMlZKSjIrYlpDcVNabzdZRC9wZkh2bm4w?=
 =?gb2312?B?T3c3aFdHc3lUSER6SkRXYmJsZ1BtOERadThoaWhhSHJKR0pDN2lnZXkreUIy?=
 =?gb2312?B?UjNxa1FEYnRrVy9IR0FFSXpGcWYyVDdPVVlNM2FWdCtQUHdiOFJHSU5nS0cv?=
 =?gb2312?Q?86fuHmRLks18XruP6S7fh4Fi2gTYYtGG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TjB6VU1MVkg3ajlTUElCT3RkM2JiTTFTU0NSSk1hTnloWUtKQkowOVZKcm5v?=
 =?gb2312?B?MzZHMjUrWER0M1hmVVRIOUVNdFBsNlB4YUNlWGdmRFN3WUZjV2VSSC8rVHBy?=
 =?gb2312?B?OUxQZ1JsbDkzR01Sczl5SjYxS2VoczVuUGNYMjU0bWlQOTE5c284RVRDUTBU?=
 =?gb2312?B?a2V6ajF6OEorRWVDd1JJejQ1ejREMVUrZUhEZGdPLzBFTi9KR2MvdlpiZ0pW?=
 =?gb2312?B?WnVVQndYNlpWYVdhMEZNSlNHN044d0tBK0R0ZmZNeFJBME9mWk8rdWNPb0w3?=
 =?gb2312?B?Ymt4QnozTmFZUVJwNUpmM1BsSHZqbzM2VU5udlBEY2tZRm5JSEw5QzdZeVc4?=
 =?gb2312?B?Wmt2N3ZwYXZFYjUyRURNYkJOSjk5Z2xvdHRhcCtSNkxwVFRXcjNUYzNoc21Q?=
 =?gb2312?B?bEhZb2RNcjhDdzBxNVJyMjNYZlo0NTFyZnhxaDBuMTE4NlExMDh6NkZPZFlP?=
 =?gb2312?B?VkdYblNHSmVTWXdiakVrMmk1ZmVSYkkvR3k5Z2dNYThOWlZ3U1hTdlltaUJM?=
 =?gb2312?B?TTFYK0xScTU4RHV6dFN5REdaVnVXVjc4QU1DMllCdU0rYmJnZVlUSUVFclBG?=
 =?gb2312?B?UmVZYkF5eUVaTzJNbmIySkluZUdFL20xZCthQmx3aXY2R0NXTGZGaEtiSElI?=
 =?gb2312?B?SkRLTllIdG80Vm9JYjZCbldMSWxLNHNJV0VVd0lZeHdSd3gzYkNHdVh6VE5i?=
 =?gb2312?B?UVNLM2ZITHhCcmMwMWJrbEhiUmFSdkVXU09mTXh0ZEhwWitRZ2FNSVlSVVNn?=
 =?gb2312?B?dDcvcFVxSDRSYkJ5TTlBYkp1MjFxYVhFcHdXZ2tGcnQxbjVzemVWck9LQzd4?=
 =?gb2312?B?NnJ0MlhKWjdNakN0RXI1TFhUNExEWmtxaFhGeC84a1hzOGtyYkZKSWMvZW5I?=
 =?gb2312?B?cFJiTk00UTM4K21kU0RWb2FtS2w2UWpDekVFNmpRWXBXOHVaWEtnOTBrcnQ2?=
 =?gb2312?B?dm9wb1hQbk9PNHJOYUxuekJ3Tnl2SmxjSFdrempoZjVQQjFOYzRCSlZBRVlp?=
 =?gb2312?B?MTh5YVhLNzgxZVV3ckt3S1pKN3RQQzdITTdzOEUvbzFyaE5mTXo1b1YvMFJB?=
 =?gb2312?B?b1FrUS9PVmpKeUIySDE3alVTakp1Y1BZWWl3aDFsdjhqdWYrNTJaK3NuMkVk?=
 =?gb2312?B?Y2xicmt1c3J5ZE90cW5HeE04Uy82bWt0czgxV24rL2lwcVgvT3MxRGpZaGhz?=
 =?gb2312?B?STVyaTRvMkhtMEtqWEMyVE05VXZmdEtiZVpaSEFJU1Ixb3B6a3dTR3M0bHZZ?=
 =?gb2312?B?VlVEK2sxZEZtMXpJSHN1bm1ZbVYvTDBVQ1o5ME05eHN6b3BGb1QyWERkbSs2?=
 =?gb2312?B?MFpnUnJodjUyeFZsZVNDcVhiR1pyd0p3ak15eWdlTnFRdVdZWTZKdnJzV2Vm?=
 =?gb2312?B?WHZZR0tNbUlEeGJaUHZBNXZwMDJ3RXZBZWVPVk5TWDdXOU5XRWJxL09jWVM4?=
 =?gb2312?B?aTR1dUtUYzZoV1RyWHprZEY4ekk4ckljMlhhQUpRTzVSaHRMN1J4eHdvK2s4?=
 =?gb2312?B?V3lUUE5UdzlpWEpXTE9HWldaTjZXei9sWDlwUm9HcnMycUsvb090M2IwSkxF?=
 =?gb2312?B?Nm5ScG5FWjlSOG80QmdsckdtREFiek9vdWdGSVpaL0s3cDlQQ28yTDBBS2ky?=
 =?gb2312?B?UjlPR3RyWlFlb0o2Qi9TQk5FTGdQOTg2cXduL3k1TTc0WEtjMDRmQlJyTm1v?=
 =?gb2312?B?bU4zODR1U3VLcTk5RHB3bG5NLzgrY2RIZWt4aExOSDhDMG5yaDZTVi82a0p5?=
 =?gb2312?B?dGJoUkkrV211WjNsRTJmUkFMdUxUMXlSd0U5eGVYajdaRjFzQ2E3a1VyUmFF?=
 =?gb2312?B?eHVOcVVsekd4bkdiNVZwYkpaVzZnNGREeVVhayt1di93RVc3SHlPVUNRV0RQ?=
 =?gb2312?B?Q2lieWpQbndxcG1tN2NWVUFXakJuNHBXWkZ6eGtISnFqN1N2NFEzVXdyM3Zj?=
 =?gb2312?B?VFJDZDY2QlIxajNNZ2ZaU2trVFBvQysrVFJzOVBVRHpPK3hscks2bzZIdTZ5?=
 =?gb2312?B?UnM2TGJlQnVXMTRSRXJNN3FzSThhaTNUWnB4Z1NaRWxSUm90NHI3dXczdU1t?=
 =?gb2312?B?Lzl1c2g4QXJxOC9SSktvN0JKbVhiVGx6b01PaGpHaG5nOStuZENpRE5EMkRC?=
 =?gb2312?Q?nY5gDjaUQpB24Wyk6MA558w5D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8694deed-3085-4f2a-917d-08dd611ba194
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:09:05.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJBzAe70TDR/s0LzJk8+9psK1vx7AM1OsjYlcXY3BmxtvzBryEFkPqqKdUKKWGh/DxYYuch4Ivw75fC0gCWkPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNcTqM9TCMcjVIDc6MDUNCj4gVG86IEhvbmd4aW5nIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2Vy
bmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd0BsaW51eC5j
b207IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29t
Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlz
dHMubGludXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDEvMl0gYXJtNjQ6IGR0czogaW14OG1xOiBBZGQgbGludXgscGNp
LWRvbWFpbiBpbnRvDQo+IHBjaWUtZXAgbm9kZQ0KPiANCj4gT24gV2VkLCBGZWIgMjYsIDIwMjUg
YXQgMTA6NDI6NTVBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gQWRkIGxpbnV4LHBj
aS1kb21haW4gaW50byBwY2llLWVwIG5vZGUgb2YgaS5NWDhNUS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gDQo+
IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gDQpIaSBGcmFuazoN
ClRoYW5rcy4NCg0KSGkgU2hhd246DQpTaW5jZSB0aGUgUENJZSBwYXJ0IGlzIHBpY2tlZCB1cCBi
eSBLcnp5c3p0b2YuDQpDYW4geW91IGhlbHAgdG8gcGljayB1cCB0aGlzIGR0cyBjaGFuZ2VzIGZv
ciBpLk1YOE1RPw0KVGhhbmtzIGluIGFkdmFuY2VkLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwgMSAr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGIvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gPiBpbmRleCBkNTFkZThkODk5
YjIuLjM4N2IzZTIyN2NmYyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcS5kdHNpDQo+ID4gQEAgLTE4MjgsNiArMTgyOCw3IEBAIHBjaWUxX2VwOiBwY2ll
LWVwQDMzYzAwMDAwIHsNCj4gPiAgCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDgwIElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPiA+ICAJCQlpbnRlcnJ1cHQtbmFtZXMgPSAiZG1hIjsNCj4gPiAgCQkJ
ZnNsLG1heC1saW5rLXNwZWVkID0gPDI+Ow0KPiA+ICsJCQlsaW51eCxwY2ktZG9tYWluID0gPDE+
Ow0KPiA+ICAJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1BDSUUyX1JPT1Q+LA0KPiA+ICAJ
CQkJIDwmY2xrIElNWDhNUV9DTEtfUENJRTJfUEhZPiwNCj4gPiAgCQkJCSA8JmNsayBJTVg4TVFf
Q0xLX1BDSUUyX1BIWT4sDQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0K

