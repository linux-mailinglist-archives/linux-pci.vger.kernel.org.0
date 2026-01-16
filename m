Return-Path: <linux-pci+bounces-45001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C4D299E2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADACC30402D7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5B3346AD;
	Fri, 16 Jan 2026 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EfEiIYAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE35325738;
	Fri, 16 Jan 2026 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527394; cv=fail; b=oqx6N34rwqi7Pa/8br+xCaYsPOSRTCaSEbNA05itg8+42QEdhSBoOScUUMsWV+aGUsGTOzEzoJ4n/e3vzZD50/amTCjlym7NrBTgEtJKXdJw4OPasGoMkcLvNlOqbjtHKOm75ImKTabVhc01kj7XjFtmoOP41STGPIm8ZTVth2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527394; c=relaxed/simple;
	bh=WvxpJg8ytwPhE4Hil3vDoIgkRbVe29g0tOW+5wmisC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOre8Ga9sdgMmfFNuEFezXyIMowhJnSaJSzsFnCmIhurFkjiuWXnuS/KyljLha89NFSQtKrOexV930zD1c5wP49yXeSyhA6VV2QzhKY9rs6QPK6555jl0S6aakeK7LuxJ3x0/ayefBvKobHVAvL73vP4Rk8HhbDNvdZY1oPO8ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EfEiIYAU; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqC4BWSB64F8bnCphwAYclm1Rlh9Oaqc2izOwMWOYYh7fpcMwMJHQAu8Q1kJ0+HBjI6qjPJMybvfmaHVplEBMCpX1ODmIyng6IFQpRQyghaXDgCUj9MdDqjAS209GER00OBZKD4Oiupf2F5IaO2oiYq0x9+55u0jd0PW6sR1fyDOM3WrPqFfFTh1YmXsvXmv7GcDtopXC4iWRN7lnnL8xMLeaOpvOMh3y3XNurZcgniJQ+83JdsD2q4Jsp5uW8SzM6Wq6rY/Meiu1bccJmgC5z8jUpGcTYiRvjg/RX8uM8Gtp9Hp/wOfhwG4LPwW/Py7gzpmhuHxvFkCIguCJYQS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvxpJg8ytwPhE4Hil3vDoIgkRbVe29g0tOW+5wmisC8=;
 b=fmHjIprz50njhgepDpO5nVIFxszUlYDkaRNqj1xVXtzSP8g7JaFc4Edhmr3VKtchJl15ZVzzRJMtvup7nDHzOUyNO1pKhEWO/oZvgLfRZxYYgnLYG8DjlJTTwnAP2SFaYMTPej4qUxqOKwDE9Gnvc+zEdcG48OzQfMDT/poDEf1XflLbSsoQR7xobP+sFTDUnC2EEO/aK/9GUxYZRJcRHzRNmlOPmtIUtWsT3sfPwGbSdRFXAJHe3ao1NK7PjOqS5Kcyz0uqSqGnsb+wf2ztMhzrnvGuToSWwe+Suhrfr5KAcAfnI8KxsF948nj8Bh/fiGwokdKKHV/2GVQRyzKn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvxpJg8ytwPhE4Hil3vDoIgkRbVe29g0tOW+5wmisC8=;
 b=EfEiIYAUvZeGCznywVD75VbIN30eyjVsyk1dcD1XU5Zwbtc4yrCErJrrF02dfqdwzCABdxyK1ctZgGDe2edeFH8jkanH8wm+TXie0Gpoj34evP0AgDSKWOwSUborKNIG++UB8r/xF2gR4e2FAuPTMYNOqy91MU2SoDdTEO4cualBTl4bH6NZvWgIeuhSn01Jo4t57awb9ZnaWeqGkS4Y3/3936sHdoRawGjK6CJ3bELoG03NvRw4et5uDyLhqQjzpTvv6zUqaSFcKsA1MHpOTkjJY3TvOs+jiLxQgAatfwZfrvHn5rQdampMPKLQTzJVA/XQOFLLIN/KRCO0taMeEA==
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by AS8PR04MB8804.eurprd04.prod.outlook.com (2603:10a6:20b:42f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 16 Jan
 2026 01:36:20 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9499.002; Fri, 16 Jan 2026
 01:36:20 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"zhangsenchuan@eswincomputing.com" <zhangsenchuan@eswincomputing.com>, Shawn
 Lin <shawn.lin@rock-chips.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v4 0/6] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Thread-Topic: [PATCH v4 0/6] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Thread-Index: AQHcf61PAt/D1h038UaRZvngPilLjrVUEPPQ
Date: Fri, 16 Jan 2026 01:36:20 +0000
Message-ID:
 <DU2PR04MB8840B5B71AC253D0CEC316468C8DA@DU2PR04MB8840.eurprd04.prod.outlook.com>
References:
 <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
In-Reply-To:
 <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8840:EE_|AS8PR04MB8804:EE_
x-ms-office365-filtering-correlation-id: 4320a528-1399-4f0e-0970-08de549fa693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?gb2312?B?di9sVEJQU2JoWXJZMnNXWE9aN2NOYUFQZnNueDF5YUh6c3NSV1M3VjlQS0pn?=
 =?gb2312?B?anNsamJySzg0cTNkLzhtamVPaGN2SkpwNDhndlVJSjMyQi9RWEZXZzc0bEla?=
 =?gb2312?B?Tk1mci9mN2JlZlpGSFIzYjVMOGE5aXpyNGYzQkJwMEJKbTM2cWV2YTJMMEVR?=
 =?gb2312?B?RDQxV3ROd1R1OWI0NG13VVl1elp6N2JiZERvM2dCU2o4bjJZV1JTbjdNTjJo?=
 =?gb2312?B?MStzNVJVSkoySklHZWJnNEVIRThNV2Fmd2IxWEtUOSsxYVplNGFrdEFWK3do?=
 =?gb2312?B?ZitYUDR1QTRZT3puaTBvNFpQOWZ6ZEhiaHo0MDVzWTNlUkR5OUwzVU54UnhR?=
 =?gb2312?B?WWJCZCtaM0ZXUVRnY0hINEVHaUM0Q0h3RVlSaUtGMjZRNklac2M4MnVDQVRF?=
 =?gb2312?B?dVNtOFZpV0g4a3daajduQml6NnNZWllDMkozaUNGSG12blR6OXdiTUJzSmxV?=
 =?gb2312?B?T2l1Rjk3MXJGUUZUVDI0MUtRYVV6QVRHL0F1VlFCUVg1dVM3akY5bFl2N3J5?=
 =?gb2312?B?eXc2b2c3ZVpvbFArdjJxTHRiL0U0Q1ZzRmRRM056SHRMNUF3NkJ1THB5dkFF?=
 =?gb2312?B?bFREY2tqcWF2alA4WmJ3d1NzRDduTFRNbVRlRlZlS295WWF0ejJDcHMrZmdR?=
 =?gb2312?B?UEFvRW9ENmlhS0Yxa0xZME85UTlnNnVlSzg1aW03SnMrRVFFOThDWkM1YlB3?=
 =?gb2312?B?Y2c0YnhUMDNFZ0hONnlBS3VMY2JmQXBuaG5GMEJwUjJhd0Uvbk9MckdaYStM?=
 =?gb2312?B?Vi9CbGo5Z3pkbjhKWWVHbXZYM3drTnkyTWVmcjMzN2hGQklhWHdmYmJha1I0?=
 =?gb2312?B?RkN6d2pnOFVaYVd4a3d3dUR4bGZXUWpnUXJGZ05LUTFFdVJFT2F2UWw4bHBi?=
 =?gb2312?B?aWhsT0R1cGhqajFVZTFBWW9ZMmo3RkZvUDRkMWRVU1pBS1BLYjlSVDFjaTNC?=
 =?gb2312?B?S2UwMGJDbkd5WkM3bm9xamdVV1Z0UFFRalFPenlqcFdxbi9meUkxTnNRRTFq?=
 =?gb2312?B?MVBEakNXZ1pwbU5vQkdzVTRlZ1JURDczOS9sOVZpRWZYNXBRQ2VyRENVdCta?=
 =?gb2312?B?eHJuME5WbFg4NWN4cDVPNVVHQXNGNFF2STdyR1VOZW1XSjVuTTFuZC8zWTNT?=
 =?gb2312?B?bGNRckkrQjZTOUlJNHNZS2Z6OWo5a0tCU1VUeTRVd2lMaDRjN3JITGk5bGtM?=
 =?gb2312?B?Z0pUWjluSkIrZUFXcTBvYzY0Y25Gc0RDRk5zM0Nka3NDVVZ6RjAxMUw2RHND?=
 =?gb2312?B?aFlWcEoyM0pDRXcwSU1pNDQwRHBPQkZ4WXpKYXFrN2tLSWl6c25sRkE2K1d2?=
 =?gb2312?B?ZVc5enlidHhMdXZ2RmhZbzRGQ3RQc2ZxcXIxc1lJRDgveWlzQ0NzWU5zSFF5?=
 =?gb2312?B?QjZLanJpeC9ET2lFVlkrV1VuaFZFVytTVmZxN1lwMEgycFhON1l5QVB0WU83?=
 =?gb2312?B?NFRWNURjNm5taUhuRERiWm5LaWhDRFVEL29ob21FMVJVWE91aVBCU0QxY1JE?=
 =?gb2312?B?Y3p6S0g2NWFjdThteW54T2hpbS9XL1ZySUJ4Y2RRMUE2SjhUTVByMzNBT1Vw?=
 =?gb2312?B?bWY0WVE1UWlXeWJGbGgyY3lLbUlnaVI3VWNWM1U4dzZrdm1VSEw2THVIdDVR?=
 =?gb2312?B?UUhmRmlBZFgxNzV2MExoa3hmRWluMENmTy9MUW83YWdxODR0VDdoUCs2dGJo?=
 =?gb2312?B?TVBZeEFoVlBabkovVmsxbDlLK1ZEQ0VvbEUzdWZGSnk5NDZEbUVjWkphTDFz?=
 =?gb2312?B?RDRnYk5xaFBuSkZnL3d1YU15UlRIT1NMVXRnZkUwTEl2ZEhTRCtpb01DN0Rh?=
 =?gb2312?B?TWZiOXZFdW84c0FnTVFpczBXamJZL2dVcFhINTlnL3NRNXVUR0JoNVdMdDM0?=
 =?gb2312?B?Y05icTNjMjhPVG9OMlVxbnF3V0FGWHdjWVI4REFxNFBTWnkvbms3UG4zcVE2?=
 =?gb2312?B?L3VnZ0Z0US9FMHE5UjBlS1RianRNWmNndThaRit3VUpMWEc1aU13NHdPaVdW?=
 =?gb2312?B?QVV0RksxYWhvRVhXR0owVjUzbVAvSTdhQUFacEhsVnhWT2w4Zk13YTZIQW01?=
 =?gb2312?B?M1lBL25TdjJKaExleWF5K1VvWUJIMUJENEZiekowcGw5UFZjSlEzanF6ZEVI?=
 =?gb2312?Q?ITXM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dVlTbjk4bWg2aVRmRmludjQ2M3BaMjFDQi9SQi9ndm5sQVk0dURwbFZ3djFC?=
 =?gb2312?B?M09OclhmY2ZQMkQ2bG5CTjA4WnVmTDlxVWtTTVZWNE11WlBHQlVidGhLOHNS?=
 =?gb2312?B?S3R1MkM1Y2xwL3NWNDJWakxVRmFaaU9uS2d4dW8wK3N4UkU4Kzg2Mkk3aXk1?=
 =?gb2312?B?amtFV1Q3S1dpTjZNaGRDakQwVXdkT1dmSVdXWGdZdWZqOXBoRSs0OURsRUk2?=
 =?gb2312?B?UE4rYS8xTFNsUkgzaEJYZmd1OU02MUEyRFhTSGpJa2Q4cFNqaTgrWkMraFhX?=
 =?gb2312?B?eHpBRWpWdWhPSGE1SWZXYWxod0NoZzF4MUdnaHNWR3dXMytFL0cvZ242TzVv?=
 =?gb2312?B?RDFtMVo5cHh6WUo4RTlqUlZaa0FTQ0tLaTVaOThsWG1USitIc2NOZ2tpMDd1?=
 =?gb2312?B?SU96N1ZSL3BQM2VIQUlvYjNyVURHSDhNTElmcWdHOVZNMmpobW8xOGo5MW1O?=
 =?gb2312?B?UEpFMlEyTzdSUFQ2YTBCTjJqd2x6UStCUUYvdk40b3F0bzJyMUFEM3JEcHJp?=
 =?gb2312?B?RUVwems1cW5HRDBRU0FkQUdkYTF0TDZ0WWdMMXdiSGtaemNLQ1FYZGVuUUtR?=
 =?gb2312?B?VjlqQ3MxV3NtUytKUEo2RElZbU5LQU9yTVNmMmJNUnpRaWpRd3BrUTJ2akJ2?=
 =?gb2312?B?VDUyT0R6UUhDMVdDUitlN3NIaVlxRjExd2tucVVKOHA2MCtjdkhYbVRhUVZJ?=
 =?gb2312?B?OWVkNCtkQUNMSUhRUk5lcGVnbDNJY1VCWnJvS3QwRFlIMWd0aXJQS21OZ25S?=
 =?gb2312?B?NEc4a1lLSFJjVitxVGlkc1dDTUMzSmxwRFl2cDYxQW5qRGZzYnUxc1N2TDN2?=
 =?gb2312?B?dDI5VWtRdlNGaWJFQXNFaWRBK0E3RWNPa0JYeHU1WFQ2ckNJVlNESGllRVZE?=
 =?gb2312?B?UDViR0ltVkR4dWhRMi9ONWErbFE3RGR4R2NkcXFIekVOZldIdmEyaHc2WHV6?=
 =?gb2312?B?bXB1YjBHL2JGWUxSSUZmNUhlMm9wMWRvZE1rTWl4TVc3VERoTk1SdkxNWkU5?=
 =?gb2312?B?WHRWRDBLcittUHZqc0xwZHYxbFRzVVA2c29oWm5wazBKVEJ4QWtrUCt4UkxP?=
 =?gb2312?B?dGFtVU9TTkVvME5MTERBSGxBMjF2VFhFTmRHL1pwcXFjNFpKcGI5L0pNVDJh?=
 =?gb2312?B?bm1rREJvNDErRkJHOVRrZkdjRlk2VWh0Sy9xNGVnVmZhOTNWS3JVd1R1WVpm?=
 =?gb2312?B?MXh2WmR3K3dWN0dVaUYwc2NPSFppOW5BQlNySlNUOWVlVDlkNlBVUENFT29H?=
 =?gb2312?B?VndzKzdrVjUrdFN2L1V3YWtuUHdCVTJ0T3FCZWpmZ0JQK3ord1FaUHF0Rjcv?=
 =?gb2312?B?Rm84TWJ5ZXJERlo0QmVKb1lqQXhoN3lVOWkxNitucTVHQnorQXRXdjJ3a2p2?=
 =?gb2312?B?bTNYQ0VKcWFDRVdFTDE1WGVvU2NLNGlXS09TSUswUWk1VGo5VU5sdThOOFJG?=
 =?gb2312?B?cENTK2tuS200V0ZxSkVUN2xqamZUZ2l1eS9xdmgwUVJrZzRPamFjQmlnZGg5?=
 =?gb2312?B?OUJZTGhrTkdIaThRaUxOVzE1SWJTbXM3UHd4TWQvV3NPUmRLc0pXNnZrdEUz?=
 =?gb2312?B?YXJPZktFTjlHM3p2c2Rkak5ubHo0d1BWYnV3TEhob3Rud3BkL1QvV3VhS2pn?=
 =?gb2312?B?UFQxd1FHMHhZeWlBTFQ0ZWllbDJSMi8wd0RLb09jMGpDZTg1ajUwbXZWemNN?=
 =?gb2312?B?RlZPd1ZjWkdJWklnbVVEMkNIZVhlWFUyVVVIZ2FLRVFROFdaaEdOR21sNytE?=
 =?gb2312?B?cmxrK29ESmhVcjJsTTZDSHJ3bHdkNVkvaVVXTFoxTUdidlFLdXZFamNXbXJS?=
 =?gb2312?B?TmxhNDJCTVIzSEZFRjNRYjc1UE4vOGRvVE1naTc5UUVtZzIxTGErb2M1Y2h0?=
 =?gb2312?B?NWZpQzZMWmUyVnRuT3JpRlBuTnA2K3ZKeGUzZE5Kd3JPekZxeVVaMjdhYVNT?=
 =?gb2312?B?OU9qL0pjTnpnNlh6V1F5SVZSUzdnNHhSZkFISGtHK2lEd25kUzMxajB0NWs5?=
 =?gb2312?B?ZGE0aHJHQXhING03RFFGczUxT2tDL0QvVkRjd3htc0NkamIvN2psTm9KdUcx?=
 =?gb2312?B?c0JBVFZob3ljUm5obnZ2L3d6aDdQSVQrVHNlSlhibXF5aFdNMWhzUWN5Kzc2?=
 =?gb2312?B?L1NFNGErRTh1UkNEWVdXZlVhR3lWclM3YW1TRzJTWS9jWlluYUZpb2N4Tkg5?=
 =?gb2312?B?V25pd0I2YWlGNHZ4SEZhd09MSU5tVTA5eFZLYktrbkJubkNBUXpsT0hzNm43?=
 =?gb2312?B?aER6ZTdrWitnS2hRR1FVU3AreVduamVCYVBzYTlFdmxFSmtmbytsbkF1a05D?=
 =?gb2312?Q?lGZlh3iojxdZeO46VI?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4320a528-1399-4f0e-0970-08de549fa693
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 01:36:20.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Esb/ThIes+L8NxpzG5St6MrsQ9+27ONU9m539FCEbvSGFa7hhhRL+f/IP+807vdLY5mV1UzQWJTUq7qPPgeouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK21hbml2YW5uYW4uc2FkaGFzaXZhbS5vc3MucXVh
bGNvbW0uY29tQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jHUwjfI1SAxNjoxMg0KPiBUbzog
SmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFpbC5jb20+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0N
Cj4gPG1hbmlAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5l
bC5vcmc+OyBLcnp5c3p0b2YNCj4gV2lsY3p5qL1za2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQmpvcm4NCj4gSGVsZ2FhcyA8YmhlbGdh
YXNAZ29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnOyB6aGFu
Z3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNvbTsgU2hhd24NCj4gTGluIDxzaGF3bi5saW5Acm9j
ay1jaGlwcy5jb20+OyBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsNCj4gTWFu
aXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxjb21tLmNv
bT47DQo+IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQg
MC82XSBQQ0k6IGR3YzogUmV3b3JrIHRoZSBlcnJvciBoYW5kbGluZyBvZg0KPiBkd19wY2llX3dh
aXRfZm9yX2xpbmsoKSBBUEkNCj4NCj4gSGksDQo+DQo+IFRoaXMgc2VyaWVzIHJld29ya3MgdGhl
IGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIEFQSSB0byBhbGxvdyB0aGUgY2FsbGVycyB0bw0KPiBk
ZXRlY3QgdGhlIGFic2VuY2Ugb2YgdGhlIGRldmljZSBvbiB0aGUgYnVzIGFuZCBza2lwIHRoZSBm
YWlsdXJlLg0KPg0KPiBDb21wYXJlZCB0byB2MiwgSSd2ZSByZXdvcmtlZCB0aGUgcGF0Y2ggMiB0
byBpbXByb3ZlIHRoZSBBUEkgZnVydGhlciBhbmQNCj4gZHJvcHBlZCB0aGUgcGF0Y2ggMSB0aGF0
IGdvdCBhcHBsaWVkIChoZW5jZSBjaGFuZ2VkIHRoZSBzdWJqZWN0KS4gSSd2ZSBhbHNvDQo+IG1v
ZGlmaWVkIHRoZSBlcnJvciBjb2RlIGJhc2VkIG9uIHRoZSBmZWVkYmFjayBpbiB2MiB0byByZXR1
cm4gLUVOT0RFViBpZg0KPiBkZXZpY2UgaXMgbm90IGRldGVjdGVkIG9uIHRoZSBidXMgYW5kIC1F
VElNRURPVVQgb3RoZXJ3aXNlLiBUaGlzIGFsbG93cw0KPiB0aGUgY2FsbGVycyB0byBza2lwIHRo
ZSBmYWlsdXJlIGlmIGRldmljZSBpcyBub3QgZGV0ZWN0ZWQgYW5kIGhhbmRsZSBlcnJvciBmb3IN
Cj4gb3RoZXIgZmFpbHVyZS4NCj4NCj4gVGVzdGluZw0KPiA9PT09PT09DQo+DQo+IFRlc3RlZCB0
aGlzIHNlcmllcyBvbiBSYjNHZW4yIGJvYXJkIHdpdGhvdXQgcG93ZXJpbmcgb24gdGhlIFBDSWUg
c3dpdGNoLg0KPiBOb3cgdGhlDQo+IGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIEFQSSBwcmludHM6
DQo+DQo+ICAgICAgIHFjb20tcGNpZSAxYzA4MDAwLnBjaWU6IERldmljZSBub3QgZm91bmQNCj4N
Cj4gSW5zdGVhZCBvZiB0aGUgcHJldmlvdXMgbG9nOg0KPg0KPiAgICAgICBxY29tLXBjaWUgMWMw
ODAwMC5wY2llOiBQaHkgbGluayBuZXZlciBjYW1lIHVwDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1h
bml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFsY29t
bS5jb20+DQpIaSBNYW5pOg0KVGVzdGVkIG9uIGkuTVggcGxhdGZvcm1zLCBubyBlcnJvciByZXR1
cm4gYW55bW9yZS4gT25seSAiRGV2aWNlIG5vdCBmb3VuZCIgaXMNCmR1bXBlZCBvdXQgd2hlbiBu
byBlbmRwb2ludCBkZXZpY2UgaXMgY29ubmVjdGVkLiBUaGFua3MuDQpUZXN0ZWQtYnk6IFJpY2hh
cmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtIFNraXBwZWQgcmV0dXJuaW5nIGZhaWx1
cmUgZHVyaW5nIHJlc3VtZSBhcyB3ZWxsIGlmIG5vIGRldmljZSBpcyBmb3VuZA0KPiAtIExpbmsg
dG8gdjM6DQo+IGh0dHBzOi8vbG9yZS5rZS8NCj4gcm5lbC5vcmclMkZyJTJGMjAyNTEyMzAtcGNp
LWR3Yy1zdXNwZW5kLXJld29yay12My0wLTQwY2Q0ODU3MTRmNSU0MG8NCj4gc3MucXVhbGNvbW0u
Y29tJmRhdGE9MDUlN0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0MyMWU4Y2FhDQo+IDcw
OGFjNGIxZTJiNGMwOGRlNGRjNDZmZDglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3QzANCj4gJTdDMCU3QzYzOTAzMzcwMzI1MzQxNTk5MyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpGYlhCMGVVDQo+IDFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lK
WGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsDQo+IGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3
QyZzZGF0YT1aWUtCa3JVQ1dLaTdocmFVU09SdGlESHdzbFENCj4gQXYwa2R6eVVMT05NSjdtSSUz
RCZyZXNlcnZlZD0wDQo+DQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gRHJvcHBlZCBwYXRjaCAxIHRo
YXQgZ290IGFwcHBsaWVkDQo+IC0gUmV3b3JrZWQgdGhlIGVycm9yIGhhbmRsaW5nIG9mIGR3X3Bj
aWVfd2FpdF9mb3JfbGluaygpIEFQSSBmdXJ0aGVyDQo+IC0gTGluayB0byB2MjoNCj4gaHR0cHM6
Ly9sb3JlLmtlLw0KPiBybmVsLm9yZyUyRnIlMkYyMDI1MTIxOC1wY2ktZHdjLXN1c3BlbmQtcmV3
b3JrLXYyLTAtNWE3Nzc4YzYwOTRhJTQwbw0KPiBzcy5xdWFsY29tbS5jb20mZGF0YT0wNSU3QzAy
JTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzIxZThjYWENCj4gNzA4YWM0YjFlMmI0YzA4ZGU0
ZGM0NmZkOCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdD
NjM5MDMzNzAzMjUzNDQ1MzA0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUNCj4g
MWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpv
aVRXRnBiQ0lzSWwNCj4gZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWRybGlaTUNp
d1BBYjJuSkNLVFhQY3NSZ0xhNGV4DQo+IHNDS0d6YzJ0Y0s4SFNBJTNEJnJlc2VydmVkPTANCj4N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBDaGFuZ2VkIHRoZSBsb2dpYyB0byBjaGVjayBmb3IgRGV0
ZWN0LlF1aWV0L0FjdGl2ZSBzdGF0ZXMNCj4gLSBDb2xsZWN0ZWQgdGFncyBhbmQgcmViYXNlZCBv
biB0b3Agb2YgdjYuMTktcmMxDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlLw0K
PiBybmVsLm9yZyUyRnIlMkYyMDI1MTExOS1wY2ktZHdjLXN1c3BlbmQtcmV3b3JrLXYxLTAtYWFk
MTA0ODI4NTYyJTQwbw0KPiBzcy5xdWFsY29tbS5jb20mZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcu
emh1JTQwbnhwLmNvbSU3QzIxZThjYWENCj4gNzA4YWM0YjFlMmI0YzA4ZGU0ZGM0NmZkOCU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdDNjM5MDMzNzAzMjUz
NDY0NjM0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUNCj4gMWhjR2tpT25SeWRX
VXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWwN
Cj4gZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWF0emxSSUF2REN1UUpuSVJGYUp5
WWFSQTNPUTFuDQo+IGQ0ZXBQSkJOZWZmNmhVJTNEJnJlc2VydmVkPTANCj4NCj4gLS0tDQo+IE1h
bml2YW5uYW4gU2FkaGFzaXZhbSAoNik6DQo+ICAgICAgIFBDSTogZHdjOiBSZXR1cm4gLUVOT0RF
ViBmcm9tIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIGlmIGRldmljZSBpcw0KPiBub3QgZm91bmQN
Cj4gICAgICAgUENJOiBkd2M6IFJlbmFtZSBhbmQgbW92ZSBsdHNzbV9zdGF0dXNfc3RyaW5nKCkg
dG8NCj4gcGNpZS1kZXNpZ253YXJlLmMNCj4gICAgICAgUENJOiBkd2M6IFJld29yayB0aGUgZXJy
b3IgcHJpbnQgb2YgZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkNCj4gICAgICAgUENJOiBkd2M6IE9u
bHkgc2tpcCB0aGUgZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgZmFpbHVyZSBpZiBpdCByZXR1cm5z
DQo+IC1FTk9ERVYNCj4gICAgICAgUENJOiBob3N0LWNvbW1vbjogQWRkIGFuIEFQSSB0byBjaGVj
ayBmb3IgYW55IGRldmljZSB1bmRlciB0aGUgUm9vdA0KPiBQb3J0cw0KPiAgICAgICBQQ0k6IGR3
YzogU2tpcCBmYWlsdXJlIGR1cmluZyBkd19wY2llX3Jlc3VtZV9ub2lycSgpIGlmIG5vIGRldmlj
ZSBpcw0KPiBhdmFpbGFibGUNCj4NCj4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWRlYnVnZnMuYyAgIHwgNTQgKy0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyAgfCAyMyArKysrKy0tDQo+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyAgICAgICB8IDc1DQo+
ICsrKysrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oICAgICAgIHwgIDIgKw0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktaG9zdC1jb21tb24uYyAgICAgICAgICAgfCAyMSArKysrKysNCj4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWhvc3QtY29tbW9uLmggICAgICAgICAgIHwgIDIgKw0KPiAgNiBmaWxlcyBj
aGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNl
LWNvbW1pdDogNjhhYzg1ZmI0MmNmZWIwODFjZjAyOWFjZGQ4YWFjZTU1ZWQzNzVhMg0KPiBjaGFu
Z2UtaWQ6IDIwMjUxMTE5LXBjaS1kd2Mtc3VzcGVuZC1yZXdvcmstOGIwNTE1YTM4Njc5DQo+DQo+
IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFu
LnNhZGhhc2l2YW1Ab3NzLnF1YWxjb21tLmNvbT4NCj4NCg0K

