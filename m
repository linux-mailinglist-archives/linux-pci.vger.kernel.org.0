Return-Path: <linux-pci+bounces-25522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E8AA81B07
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 04:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124FB174729
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 02:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81995D477;
	Wed,  9 Apr 2025 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="imw2jhGt"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E8250EC;
	Wed,  9 Apr 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165888; cv=fail; b=U8cVmXCv+zByesPuS1uosRlMQ8WDnfAWSR8K/3bnPJX+c8T8OfZrT8MGAkMBs2yWvjjH7mDAVhBQz0/Dv5WgkkcIvf+ydmEc5Jddge+YuMUoyOTX24q/ztaVmCwhPeYQemfe6lmoW9bStyg4DO5uliaZ/rpjX1r4BnSiIV/Jn70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165888; c=relaxed/simple;
	bh=yX7kejVA3RATHuLQXo1QPaFcP5h8Vxh6PlToGaynkW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXwzrE7onmxfLUGuo3wevdDP2ZqTYvjVPzjQv+77sh7hpCFRUXoi9F28mJYqSmAkiYQWUe1QQKuJyknaNL/JFilZurWjBG35NshFBzHE9IXcnDmIqPBDl4nB4nk2oDipvtB6QVoHrcVFI2unYKgt9b5gEs5CS4ZO60J4VQOqgaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=imw2jhGt; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChksrrWeWBApJQW9vQh9HOok6PrMavQdWpiCjUO55X+zTzGKtuoBLeOEbw1OZZrSLtuaXhBQ5Jz+SEIRvcfcgDD+zPLf5SwdX/EVTC5lScz+uVGwO7Vzh7bP44kqMHn8bXvAFiAlWwywx/HwkEUBA5rarFMvkYyDnd7M/zKbAR4TIU2KLUBA6bpx3WUTVxDB/TGCTdgrPm8zkJGcTivCalRQ7LZvTCH3KJRbshTC82SQynp4GgI+xfh8YdGQ7oWiTXpDDcYLxCVMHZ8CTjirnWvdGF8eIjN6SgT4KQ5LJZ9fQzdh0xeg6esrcddVra1Z48w8CsuF8gD/DPbRefjLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX7kejVA3RATHuLQXo1QPaFcP5h8Vxh6PlToGaynkW8=;
 b=x5jZAd4N6qKki5Kd7OR+2WlqWxod3ubQp+xT1UnyGh9aYZ1Y/1kJumdTiuglh7X5a1o4b0ugvFVm+k+aHrD4GnSJjsQBXiGaDV99StywRsK77I1emXKwgTuX4mmW2UfIlZ+9NkA/0Jg+VS2Ke+WmekymWCbj4V9LmV7E8vaTs+JtRdkCwpzpY7hPC/JkGfNQ7jw9e8bxIhPUBscHcpw0q04oyKndKb2DG31rNjDbuKFGY51FoEIpjCvl+FZOohK/TUPL/KZagXPNOiMcR+A82KImv971KCy9yX2uCz2Dag6bOFA+H0h/wKjNkH7Esv4bRsFSLCiDDXXhDtwyjWUOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX7kejVA3RATHuLQXo1QPaFcP5h8Vxh6PlToGaynkW8=;
 b=imw2jhGtQSjKbq6shuTQP20Qfpa+FESE9D6s4hBmBgMrVL/ttAw9DSwmvl6GVsZUw0dvn20cGS8QEuZOHwX8QP70v7ulYsLgJLJtdGt9Us1mpSrgECVyF5kftI6GTUif7VQOtL/sP4TScuRKrXVsKvI8cV4rBWXD8ljDntCswFxLwXvFlULYgnzu9gkC1T8Y6ScH696xbctFVsUwam/PnARh1H0mXuzA55ZK23O/E+YgKf8dzb+tS1O8Cd0P3+kHabJXVbKai5dIO+Xsy+49i5g/TcWn293cX71KTG83z7P2HVtpsdFSjVgo50BQw65mdQ1UMjQwMRtxS2sO4NVjVg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 02:31:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 02:31:22 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Krishna Chaitanya Chundru
	<quic_krichai@quicinc.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, Frank Li
	<frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll
 of suspend
Thread-Topic: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll
 of suspend
Thread-Index: AQHbqFMD+NNlos4dREitFgMxw9LKubOZ3McAgAC11LA=
Date: Wed, 9 Apr 2025 02:31:22 +0000
Message-ID:
 <AS8PR04MB86766063C3A9E969234779EB8CB42@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250408065221.1941928-2-hongxing.zhu@nxp.com>
 <20250408145840.GA231894@bhelgaas>
In-Reply-To: <20250408145840.GA231894@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB9914:EE_
x-ms-office365-filtering-correlation-id: 3fb956e3-ca2c-4679-8163-08dd770e9e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?R0lFazRaTHZ0bkhha0s4d054OU8yVEo1U2hIbGErTFBrOEVjUlpvM1hpZk5h?=
 =?gb2312?B?R1l6WHRscXBRbjlkZ2dsQ013eDdhOW4zNmlmSkNMMzNCLytqdFlYNTBRS3lp?=
 =?gb2312?B?OTBQek4wcDZXY3VFdFBVWENjZ1R0b2ZxQnBtZjAvRGlxTHo1WW8zMy9WeTJX?=
 =?gb2312?B?YW80QnE2cis5WDd1OHdCS3dJZGFlZ2JxcG5vZGg2T1p2aEtsRk1OMnZ0eGh6?=
 =?gb2312?B?RmxHSCtESGszVW5tMzA2Y0JBWGlGWXF2ajBlanpyV0hDTnVHT0Jaa2ExUXJx?=
 =?gb2312?B?MXNKZkJEb1RHdjAzQm1wZ1lNVzcybUNUNlJyUERvQU5ONExLeU9mRkk2Q1lY?=
 =?gb2312?B?TldsSXhiaXV1dDBNQ3JZOHNBaVZQaERjRERRd1dBdGxHWFdVZm84N25BWTJk?=
 =?gb2312?B?MFhNVUV3UFMzcExLR3UyNk5qQlloNzh0L2tRUFVoRkczSkh3S2FGMkw3N3B5?=
 =?gb2312?B?RS9VVFZrTFhXTm1IazMyTDNWSHd1WXoyeE15Y3VnRlhnS1lycVozcGRFREFv?=
 =?gb2312?B?bVRPZGN3T0dFR1ljOHZ6ZDdtTmpUNU9saU0wWHcrQzJIL3BDMGdENmk0eEt6?=
 =?gb2312?B?eXNGRXVyY2JQOElGdXJyTUx1Vm5ncXhoOW1xbmpBSUJ1bEdwNFRqSjFzMEsx?=
 =?gb2312?B?K2xSdWVUVmJQQnpHejF6Q2FyWHIzMmw2YlpKenQvWWgwWW5EOUVmZ2xRSlht?=
 =?gb2312?B?a1ZVTnNKN05tOUNqK1N4UGNCcEdqYXVnVVRveVpzQ3JUVm9rYlJ1eFVQckRt?=
 =?gb2312?B?Z1pWb1V2R1VjVjZSYVN4b1FzcWlqZkxmMm9lSFZya2o3cmlXNlQvUUZkTEN0?=
 =?gb2312?B?MDVHVmFJcHBheTNIdmRCNlZUOVhBdXUweTV2MGJoWmIxdGtUNU45UkZlOWpo?=
 =?gb2312?B?L3ByUGhKeVp2S2tCRVFkaG9EMXFnVm5ZdHNRYnd0dkZQd1NZUnVMdVovNHRx?=
 =?gb2312?B?disyRTR6VEYwbG1CclAxMVhnYWZBSTVhaTNVYVJUVUZqVmx3anBOS0tXTGpp?=
 =?gb2312?B?MnQrWW1BVUpjYnJ1K3FTT0FlU2N1c0lFeGViV3haNG04MlpiTkFZenQ4ZDIx?=
 =?gb2312?B?S281eCtxeEZIRUFMQmRIM1JPUnZQbjBQaHdtTUdJcFN2emlSMzlIMkdsbkYr?=
 =?gb2312?B?SG50VEc2bUdGVVBQUjV1alBtM3NOTlk0QUc2RVAvN3lXcWVGN25zSzMvSk1u?=
 =?gb2312?B?Ty9xTTJMU29lQmlsYlgyemgwOE85NUE3TnVuQzFsOTZRV3I3QWNlaHFINGVM?=
 =?gb2312?B?OFh1U01HMEZXTGpXQWdLZXBMSC9IY2MxUThRSGZvc1FCVkd2Sks4ZElHdDNw?=
 =?gb2312?B?eXI1eVRmMTljZC9QR0ZyNnMwbE12RkwvcTBncmpZMG1adDlTQ0Q3akIvKzdU?=
 =?gb2312?B?V3luRTZHY3FjWnVIK3AwQk5yVnFlSlZncXdsazlUZndkR2pGd3NjNWpFTk03?=
 =?gb2312?B?RnhQbzVINWlvTVFpME1aWlVNQXk3YzFRblQ4QjgwLzhUaVZPcUhYMzRqQ0hS?=
 =?gb2312?B?UWN2c01CUm1SSEQyd3dKOUFOMEtJUDc2ZHdqWkdDKzk2TXM5akM0eEtGbC9S?=
 =?gb2312?B?OVdpNVJCUzlsdkJOOHpSbUhyUEpnTGtNTjFvTHJXb1E1Ym45TWxiVlBrdWpI?=
 =?gb2312?B?ejNWczBNTnpRSGFGM3VqYzZzNTdHS0N2S0d0bjY2L3B5SWdNTHdUTGtzT20x?=
 =?gb2312?B?K1ZMcWxRVGswVGErVnRGcC90a1Fyb2Vnek1xSitXYVNWOGhmSkdCNndWSzI1?=
 =?gb2312?B?ZjgvcjV4dTVyYUlJSHhNVmNLdmdSUFExZFdWN0xvZS9qYXdTTU43Z3IxL09Y?=
 =?gb2312?B?YUpWQldYL3hkVi9FTUVoYlpxYzBseWZpLzFBY08zR3YwcTFUak55OEpOZCtV?=
 =?gb2312?B?MFg2RVk0dWJLcElCYzdJL3FDQllHdFlnN28vVjRkSmR3UE9XV01jVFZqMTFS?=
 =?gb2312?Q?YBOVILDdy0Zkieeu5jRwkDBMfCmPRvcs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q21VR0lKQnVHd1JmdWcyZjBvL3ZVQ0RsaTRab2xVOFNJdU94djZrY0lhblZt?=
 =?gb2312?B?S08zY2xsUWlZMmIrcm5GMHdiZi80MElKS1UyQzZTeG9HVEtkM3ljenlkK3JF?=
 =?gb2312?B?L2ZkK0hHTVpuRVRZek1aOGlIT0Eva05jdkxsYW5lQk5hNi8vV0FLcHd1MnJu?=
 =?gb2312?B?SnhUdFpnLy9uTkpCUUN5b3FFbytaTjY1bjdiTWdvd1lCemtsYWhvQ3pBZkVS?=
 =?gb2312?B?b0FXK1BVRHNubHBrc010dFZQVG5WU3NVZlRRUC9PSk1QMmZka0xjK0laL0c0?=
 =?gb2312?B?cmZVS3VYbFU2NkZKaEpuSEl1OXR0ODQ3aEVXSVV3blhDNFJVSW5yNUg1VkVX?=
 =?gb2312?B?TDBOWS80cE9YTnBBV1pBckZCMEVmS2RzQ2xXd0NFOHB2c0pTVXEzc1RBL1RN?=
 =?gb2312?B?YytLTWtnSVFIOWlKR3kwYUM1RldTSDh5b1YzcGVxQmJUZ2VQQWpocUUxWnhP?=
 =?gb2312?B?MDhRV0Y1QjJQcmpYQnRGMzN2QzdtMlBuKzhrNk5KU0FuKzJRMTZaeVh4Smk0?=
 =?gb2312?B?SzVrR2JZT0RKS2c0Lzd0Q1gvVWhmbnc3OHpVZXRIUUcxdkFCMmJESGk1MFhM?=
 =?gb2312?B?OC9yeDU0ZWpGdTJ4MWNZRy9GTDJJeFBxS1QvV2Y4V3dHanZGd0hxV2R6aHEz?=
 =?gb2312?B?empybUlQc0x2Ty9raXllS2llQkJ6c2s3eWpQaElaM1krdmxaVXdtcDdOV3B3?=
 =?gb2312?B?SU1hWkZTNU80Zk5pVkVNM2I2WU1VblB2WEppWHNWTEIxcHk0ZXoyT3ViNlpC?=
 =?gb2312?B?QysrUXJMSGJHV01hd3pFc0NRYWF0eEdHZnExVllrUUoxQXpHS0wyTWZ0WHBG?=
 =?gb2312?B?THcyYmlmTGE2M2w1WlhmMHVJdWpMbFZuTTQ0M29abTJVYTlONXlGZVNIR1dP?=
 =?gb2312?B?bHFoRGQzZThUVzc0OHhrR05WUHVKYzhSdVdhcmhzZ3FJdVFOM2ZCYzRPWFBR?=
 =?gb2312?B?MFM1M0NpTE1oSTFoTzhYYm1XMnlnWnF4VkZ5ZHhydmxKeFpHcEJ2cTlqZnhO?=
 =?gb2312?B?aDdYQkpUNjNZQm5rb0JBTEg1UkdoOFNmNGdISkQwNXZSbnU2WXR2eXVTYmVF?=
 =?gb2312?B?ajd5enpmdi9aUGtzR0NLK3lUSytaT2pnVHFQMXNvZ1JvZ2ljRHpGNmw1Tkhp?=
 =?gb2312?B?Q1d5dDQvVGwyYVhENW10MEFlejB4T2d6a1hnOC9SaTJmQUxFc2xIZzkxNFBp?=
 =?gb2312?B?b0d3VmFwajNheWM4OGVNTk9lTFhoYVJsc1M4czRVSitCVTlLeWlqcTZwQ1Vp?=
 =?gb2312?B?ZVB5U2E3Znh5L2YwMzZCVzd5eGxLOFRVcjJIVGFqTmJwZGRpbFJiQnlpYUVj?=
 =?gb2312?B?TjNuOEorZms0eGdTZ2NpTm5iTkdVUmN2WTM5TFBBbWxndjNYN1Bib1p4bEZC?=
 =?gb2312?B?SFRJeENsblNSNDBmRTFRY3dxVVlGWWg5eEEvMEtMd3JQLytXbGNmUmJITHBx?=
 =?gb2312?B?WjFPczgxWGhzYUZ4Q21nbStIMlFPdGhFNy9rTkF6V01RdmlManF6dWFQT3Zh?=
 =?gb2312?B?ZVZON0Y1Z2FGeFYxNWY2dE42NytjSmJhdmc3ZDJ1WGRQdmJ5dWoreEpRNS9G?=
 =?gb2312?B?ZVdHMjBqczdCcGk3b0dMZE0vODBlcEV4aWpCemo3ZmxMTXE4Mkk3M1BqMndV?=
 =?gb2312?B?NGJvZi9OUVZpamRON3dvbm51UXE3Uk9RcG81S0NxRWJldVVzaVJDbkwyV1Vz?=
 =?gb2312?B?RFEyT2laMWNOcVd5R0NMRk9LRDVSSUJxYk4rTzJwRGdMa1pEdkdTbDlLYjJM?=
 =?gb2312?B?bk1saGxyZm1kTnJVa2FocjVhM1hYeTd5QXhVWjdxaTQzT0prWWFQdTJpbERE?=
 =?gb2312?B?ZXVzb3JTY2dVVGJ5K1dNVnNlUDBNSlRQTmQrM3J3bGdNdGNVeXp6U0RGU1FS?=
 =?gb2312?B?M0xRRjJPRjI5clpheXZaUitxYlp4TUFnYjFiS2Y2ZzFxbU9wVnVXV3h3Nzdz?=
 =?gb2312?B?VWdUNm5BNDJIcWIvNkdQcVFVZWNueHd2aE1Dazk0aklESWNCOGg5Q2dSZERa?=
 =?gb2312?B?ZnErWGd2enFtZXJMUmx3anFmNVRmR254czRwZklSY1VzaU9PdUphbTcyWTRT?=
 =?gb2312?B?K2VHbnRWK3lNbzIvNHk3WUFUNmkwbSs5TXphVzNBUzN0QjNVZUdrM21GM1RD?=
 =?gb2312?Q?stO6gCujRYKee+N80opIiHwB2?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb956e3-ca2c-4679-8163-08dd770e9e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 02:31:22.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zinRGpfepFYifv2Ijw7Zxpmxdxejn4+8QMKBDegeNB+DrndGeBcSxOJWRdg0KwPzamiZz+Mqu6aEo00azNFu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jTUwjjI1SAyMjo1OQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGppbmdvb2hhbjFAZ21haWwuY29t
OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiBtYW5pdmFubmFuLnNhZGhh
c2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMu
bGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMS80XSBQQ0k6IGR3YzogQWRkIHF1aXJrIHRvIGZpeCBoYW5nIGlzc3VlIGlu
IEwyIHBvbGwgb2YNCj4gc3VzcGVuZA0KPiANCj4gT24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMDI6
NTI6MThQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gaS5NWDZRUCBQQ0llIGlzIGhh
bmcgaW4gTDIgcG9sbCBkdXJpbmcgc3VzcGVuZCB3aGVuIG9uZSBlbmRwb2ludA0KPiA+IGRldmlj
ZSBpcyBjb25uZWN0ZWQsIGZvciBleGFtcGxlIHRoZSBJbnRlbCBlMTAwMGUgbmV0d29yayBjYXJk
Lg0KPiA+DQo+ID4gUmVmZXIgdG8gRmlndXJlNS0xIExpbmsgUG93ZXIgTWFuYWdlbWVudCBTdGF0
ZSBGbG93IERpYWdyYW0gb2YgUENJDQo+ID4gRXhwcmVzcyBCYXNlIFNwZWMgUmV2Ni4wLiBMMCBj
YW4gYmUgdHJhbnNmZXJyZWQgdG8gTERuIGRpcmVjdGx5Lg0KPiANCj4gUGxlYXNlIGluY2x1ZGUg
dGhlIHNlY3Rpb24gbnVtYmVyLiAgU2VjdGlvbiBudW1iZXJzIGFyZSBlYXN5IHRvIGZpbmQNCj4g
YmVjYXVzZSB0aGV5J3JlIGluIHRoZSBzcGVjIFBERiBjb250ZW50cywgYnV0IGZpZ3VyZXMgYXJl
IG5vdC4gIEUuZy4sICJQQ0llDQo+IHI2LjAsIHNlYyA1LjIsIGZpZyA1LTEiDQo+IA0KT2theSwg
d291bGQgYWRkIHRoZW0gbGF0ZXIuDQoNCj4gPiBJdCdzIGhhcm1sZXNzIHRvIGxldCBkd19wY2ll
X3N1c3BlbmRfbm9pcnEoKSBwcm9jZWVkIHN1c3BlbmQgYWZ0ZXIgdGhlDQo+ID4gUE1FX1R1cm5f
T2ZmIGlzIHNlbnQgb3V0LCB3aGF0ZXZlciB0aGUgbHRzc20gc3RhdGUgaXMgaW4gTDIgb3IgTDMg
b24NCj4gPiBzb21lIFBNRV9UdXJuX09mZiBoYW5kc2hha2UgYnJva2VuIHBsYXRmb3Jtcy4NCj4g
DQo+IE1heWJlIHdlIGRvbid0IG5lZWQgdG8gcG9sbCBmb3IgdGhlc2UgTFRTU00gc3RhdGVzIG9u
ICphbnkqIHBsYXRmb3JtLCBhbmQNCj4gd2UgY291bGQganVzdCByZW1vdmUgdGhlIHBvbGwgYW5k
IHRpbWVvdXQgY29tcGxldGVseT8NCj4gDQpZZXMsIEkgdXNlZCB0byBzdWdnZXN0IHJlbW92ZSB0
aGUgTDIgcG9sbCBhbmQgdGltZW91dCBpbiB0aGUgZm9sbG93aW5nDQogZGlzY3Vzc2lvbi4NCmh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDI0LzExLzE4LzIwMA0KSGkgS3Jpc2huYToNCklzIGl0IGZl
YXNpYmxlIHRvIGVsaW1pbmF0ZSB0aGUgTDIgcG9sbCBhbmQgdGltZW91dCBpbiB0aGlzIGNvbnRl
eHQ/DQoNCj4gSWYgbm90LCB3ZSBuZWVkIHRvIGV4cGxhaW4gd2h5IGl0IGlzIHNhZmUgdG8gc2tp
cCB0aGUgcG9sbCBvbiBzb21lIHBsYXRmb3Jtcy4NCj4gIlNraXBwaW5nIHRoZSBwb2xsIGF2b2lk
cyBhIGhhbmciIGlzIG5vdCBhIHN1ZmZpY2llbnQgZXhwbGFuYXRpb24uDQo+IA0KPiBzL2x0c3Nt
L0xUU1NNLw0KT2theS4NCj4gDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IEBAIC05NDcsNyArOTQ3LDcgQEAgaW50IGR3X3Bj
aWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKSAgew0KPiA+ICAJdTggb2Zmc2V0
ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX0VYUCk7DQo+ID4gIAl1
MzIgdmFsOw0KPiA+IC0JaW50IHJldDsNCj4gPiArCWludCByZXQgPSAwOw0KPiA+DQo+ID4gIAkv
Kg0KPiA+ICAJICogSWYgTDFTUyBpcyBzdXBwb3J0ZWQsIHRoZW4gZG8gbm90IHB1dCB0aGUgbGlu
ayBpbnRvIEwyIGFzIHNvbWUgQEANCj4gPiAtOTY0LDE1ICs5NjQsMTcgQEAgaW50IGR3X3BjaWVf
c3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0K
PiA+ICAJfQ0KPiA+DQo+ID4gLQlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9s
dHNzbSwgdmFsLA0KPiA+IC0JCQkJdmFsID09IERXX1BDSUVfTFRTU01fTDJfSURMRSB8fA0KPiA+
IC0JCQkJdmFsIDw9IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQsDQo+ID4gLQkJCQlQQ0lFX1BN
RV9UT19MMl9USU1FT1VUX1VTLzEwLA0KPiA+IC0JCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9V
UywgZmFsc2UsIHBjaSk7DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJLyogT25seSBsb2cgbWVz
c2FnZSB3aGVuIExUU1NNIGlzbid0IGluIERFVEVDVCBvciBQT0xMICovDQo+ID4gLQkJZGV2X2Vy
cihwY2ktPmRldiwgIlRpbWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkhIExUU1NNOiAweCV4XG4i
LA0KPiB2YWwpOw0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4gKwlpZiAoIWR3Y19jaGVja19xdWly
ayhwY2ksIFFVSVJLX05PTDJQT0xMX0lOX1BNKSkgew0KPiA+ICsJCXJldCA9IHJlYWRfcG9sbF90
aW1lb3V0KGR3X3BjaWVfZ2V0X2x0c3NtLCB2YWwsDQo+ID4gKwkJCQkJdmFsID09IERXX1BDSUVf
TFRTU01fTDJfSURMRSB8fA0KPiA+ICsJCQkJCXZhbCA8PSBEV19QQ0lFX0xUU1NNX0RFVEVDVF9X
QUlULA0KPiA+ICsJCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gKwkJCQkJ
UENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQo+ID4gKwkJaWYgKHJldCkg
ew0KPiA+ICsJCQkvKiBPbmx5IGxvZyBtZXNzYWdlIHdoZW4gTFRTU00gaXNuJ3QgaW4gREVURUNU
IG9yIFBPTEwgKi8NCj4gPiArCQkJZGV2X2VycihwY2ktPmRldiwgIlRpbWVvdXQgd2FpdGluZyBm
b3IgTDIgZW50cnkhIExUU1NNOg0KPiAweCV4XG4iLCB2YWwpOw0KPiA+ICsJCQlyZXR1cm4gcmV0
Ow0KPiA+ICsJCX0NCj4gPiAgCX0NCj4gPg0KPiA+ICAJLyoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggNTZhYWZkYmNk
YWNhLi4wNWZlNjU0ZDc3NjEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC0yODIsNiArMjgyLDkgQEANCj4gPiAgLyog
RGVmYXVsdCBlRE1BIExMUCBtZW1vcnkgc2l6ZSAqLw0KPiA+ICAjZGVmaW5lIERNQV9MTFBfTUVN
X1NJWkUJCVBBR0VfU0laRQ0KPiA+DQo+ID4gKyNkZWZpbmUgUVVJUktfTk9MMlBPTExfSU5fUE0J
CUJJVCgwKQ0KPiA+ICsjZGVmaW5lIGR3Y19jaGVja19xdWlyayhwY2ksIHZhbCkJKHBjaS0+cXVp
cmtfZmxhZyAmIHZhbCkNCj4gDQo+IE1heWJlIGp1c3QgbXkgcGVyc29uYWwgcHJlZmVyZW5jZSwg
YnV0IEkgZG9uJ3QgbGlrZSB0aGluZ3MgbmFtZWQgImNoZWNrIg0KPiBiZWNhdXNlIHRoYXQganVz
dCBtZWFucyAibG9vayBhdCI7IGl0IGRvZXNuJ3QgZ2l2ZSBhbnkgaGludCBhYm91dCBob3cgdG8N
Cj4gaW50ZXJwcmV0IHRoZSByZXN1bHQgb2YgbG9va2luZyBhdCBpdC4NCj4gDQpIb3cgYWJvdXQg
ZHdjX21hdGNoX3F1aXJrKHBjaSwgdmFsKSAocGNpLT5xdWlya19mbGFnICYgdmFsKT8NCg0KQmVz
dCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiA+ICBzdHJ1Y3QgZHdfcGNpZTsNCj4gPiAgc3RydWN0
IGR3X3BjaWVfcnA7DQo+ID4gIHN0cnVjdCBkd19wY2llX2VwOw0KPiA+IEBAIC00OTEsNiArNDk0
LDcgQEAgc3RydWN0IGR3X3BjaWUgew0KPiA+ICAJY29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzICpv
cHM7DQo+ID4gIAl1MzIJCQl2ZXJzaW9uOw0KPiA+ICAJdTMyCQkJdHlwZTsNCj4gPiArCXUzMgkJ
CXF1aXJrX2ZsYWc7DQo+ID4gIAl1bnNpZ25lZCBsb25nCQljYXBzOw0KPiA+ICAJaW50CQkJbnVt
X2xhbmVzOw0KPiA+ICAJaW50CQkJbWF4X2xpbmtfc3BlZWQ7DQo+ID4gLS0NCj4gPiAyLjM3LjEN
Cj4gPg0K

