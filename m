Return-Path: <linux-pci+bounces-14118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40EA997A6E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBAA2812A2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2E3E479;
	Thu, 10 Oct 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cSAAKnnW"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF114293;
	Thu, 10 Oct 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526223; cv=fail; b=dzZcbjg7dlsGp7ufEzanrIOekcxUzQEDpc/OUrXhXo8i3c+IdM9OQ/uMv9W4hW6Bo4h1ojse871wLJCctlyrqeuRY/GZ/vb+gYgph/iRp6eZNDl+/9gF43IFka3LCqckyflQvWdBKeKGwJhlxP036i0UD4hcLDVF4StJOWBjpVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526223; c=relaxed/simple;
	bh=YSw8mKFcu1SVVzu9MKYUw/HbN/rHaiAmAo4t/aMtI5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scsyOPbj3jfH5W1EA2OZBVAR8z0MuhnAB4FjNc3P+aiTqc2bOuzNVxLiJMexZbIc3H/nVSmZkEx4qiPK3Y9yqxQGfnc2ca2M3TJVXdf7OFf6+h70nd25LutQPLTi4gaIkNnjEjdnuElhInud6kzYdRk2/f8TNk3RVVY2IUedPVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cSAAKnnW; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQbbL0VzBW/rxO1SWUxcwqrHS5Scn7Jyz8H17SG/jSpq2T1SrYcJE7eFUuqiq/9LeZi3RoxGLCSZeaFiflhWwj1oNtXenCa1cBdf1mviBdEOOjzbLTCgjOSZnulttm3cR25Hu21ZQopS9/v/EOMXqlAUuxgK4ixy+jZnv3FKogXj81e5f0cPi9h24gy5icCpf9NTdYlV8Jx4NYBrZ4sH7DGjx6GT72zsIdezYU7vuStUGeGY0ml7AB8Hk7G2KZ8+PzEBQLeyOtrDU4AS/75INXsVuMwQOJPhs5suQeXPlUfZahiE66EuUb5397P1ilXcwJ74cgRppF3yaAzkIYUZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSw8mKFcu1SVVzu9MKYUw/HbN/rHaiAmAo4t/aMtI5s=;
 b=IZ9sA2q/dn/LLLATrw3WUwPKNq+APdtaJkSx70yTia06oxmkjf62YIWsIafIrf0C8a0vpWWPHgI/37BdIaHdUaBG/Pq91CuHXobdH7EHB+4zaXQgeJRsx48+fdz33uXQ/g1vnp319mBllI3Qdcf+rgzfD4hSIWy8FQcqJHy1LaKqFMTFDXqYA2iS9UN2Dy5HbID20YNMvHX0JW9FK2Hlxty3PFINhOVSuGoKALPAtf02+I4wvB5t0PPI3LyhnWQHtM4qPGCJdeuC1CWtXbDy8LuO6yRC7C5Z50M26UHAzNQrNkHp22XFYGFTVCNlGqpVix6+2+BMOn0sxXJrMDMxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSw8mKFcu1SVVzu9MKYUw/HbN/rHaiAmAo4t/aMtI5s=;
 b=cSAAKnnWuslMkoilip95I1VvQkwUyDNorhzkW5jD1ZAUo98SDz7DrnAn+mcE7qQnf/fxwd0yVs14gyMGuMPZ1FPFdwNvrdWNhLP36/KuChEwktjENvzPj2VKJvw78OxibT0RzUFOb9E0AixR35rEa66MBtJqC1Jed75mnpI4kAekUinstKKsmhHN2u8Oiz4AQX8m/a1N3HSVparmAooXLnO15+ROVcg7wt5jIBrjNNJjWi0AI2F8WZNH6xgPuSd60mqLkEUrXhr40QbOBFAtchNISh2/gxZEMN+qNVT41fi7WWvOccSeHqzQOtWJEPmgOqW6ysRj9CefpgpXVCdRcA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 02:10:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 02:10:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 03/11] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH net-next 03/11] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Index: AQHbGjLsnINsgjqstkSWT2DYUkT6t7J+nlOAgACdv9A=
Date: Thu, 10 Oct 2024 02:10:16 +0000
Message-ID:
 <PAXPR04MB8510C6D918B8D841C2C18FE388782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-4-wei.fang@nxp.com>
 <ZwaxAb+IQnM3IcI9@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwaxAb+IQnM3IcI9@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB7062:EE_
x-ms-office365-filtering-correlation-id: 5e5b116d-c5b6-4735-a850-08dce8d0aefe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VzhYSm9PU1phNlN4OSsvU1RTNWYzUy9LcUYxRi9rNjNNNU90bnkrNzZvbmJy?=
 =?gb2312?B?dXV6OE8vVWRrd3IvdWhEL1cvQTF4WVFxU2NWMzVGeXZIMFpNSG4vRGVQMXNt?=
 =?gb2312?B?bC9qNExJcHRTaytUQmw0aTF1TUhaQ1czdThpL3JsT1FMM0JzQmxzZ3lqY0ZC?=
 =?gb2312?B?YTM0SHRlTFZjdGwvU1ZGOXpFcHg4cHdvcTZ2SzNuY29CRzFKM090UlVGZHhV?=
 =?gb2312?B?a0dOMnZ1STQyUTRidTZaYS8yeXVlTFVBRjd3dlJndDJTaEM4bktaUnNVbFNU?=
 =?gb2312?B?Vzl4dXl5MTFPVG1QaUM1bldYVzR4T3RjSUpJUnEzWXZaNXZ4V3kycTZzZjls?=
 =?gb2312?B?MXFWZkcvWUdqUnZ6eHpadEY5Q1FUUHMwc1lRUWVQU3dDSlEyUFQrNEZEL2Iv?=
 =?gb2312?B?SDRBNk55SUYzNFNmVWJqem5FRW9UTTFWUEUyazdWZ3AxbFhCWW1PT0pYN1Fl?=
 =?gb2312?B?dkRDSnRsYkcveDc1UW1GaHRNMWxmMVdxSFhUcWZXUFBHVFFFZDlNZ1BCRjlH?=
 =?gb2312?B?Qm9HVENzcWNsVmpHNFRnWnZicXZvTGo3Q1BCYmxkWmNraER3eENKNEUrc0Ni?=
 =?gb2312?B?UWpsNnBXWXp4d1B0UEZzYmZXOHBWNDZJdmFqSEppcWJvbnFhb0xXT3FjSzFu?=
 =?gb2312?B?Zm16ei92WFF3d1pHQmdiamNwcHpka010bDFCQWtqNzMzSlM4aTRGamxYb0lh?=
 =?gb2312?B?Yjd2Z25yVFVmaDNtVmlHSVNuU3lIVllQb3JxUHBaT3VuOVB5TWVLVUtZNnBy?=
 =?gb2312?B?USs2T0lJeWkwdmFZK1NOMGMrSnNWenJkNlRESjBaczRTeGp1akZJUDJlUUR1?=
 =?gb2312?B?R3dsSkI2WU5HNGc3UXFMZGZ1RXc3ZDYzYUN5QWJnenkremc0emRoRXF3Y3JC?=
 =?gb2312?B?eDhRWWh3N1FlaFVxblpDakN0YTBGVHAxNG01L0dWTmtIbWZwazJDbTRQNW9X?=
 =?gb2312?B?MDJZblk3WnUwV0drd1d2emZieEM5eFVUQW9ERTJUMGxDZWRsa3docmRRa2xL?=
 =?gb2312?B?bWpEbnkrWWtoSHNWSFpVUUp0MHBGOXNPMm9SYWhUWFBSckNQU2tQWE9mY0Mr?=
 =?gb2312?B?ajRoVHlJN2p6MEVDSUZkbUxrMUs0VmlQSmNFdzhqZnVRaXNhdDJiU1pINWlE?=
 =?gb2312?B?K21TM240QWgxcWtVY1dYekR1QzBLSi9DMVdKVUd2NTFyU3NlR1FIRktuMFBZ?=
 =?gb2312?B?YlBuV2E4dE9ham9aV3pROWtpNXYxRHRiczM5SUpTV3pUcDlJSWFQN3RNU1h1?=
 =?gb2312?B?a0JyWkRBL05MMGRDYXdNL1VQSTUvdmVMaWZXVUFJMHVEUE83eXZFeHFEVEZa?=
 =?gb2312?B?YkZ5QzN5azZ4TXlSV3djVS9DdHRvbEJBVjFCdWpBNEhtRk82YmlrZFppWW9u?=
 =?gb2312?B?RXpsNDJ2amZXdnRnaytsQzBMK2o3NnZhbHptRExoN05wN2Fpc1IvL3BDSmZz?=
 =?gb2312?B?K1ZGMi9EbVVyZUl2V21wYXMrdzQyZWVlQ01TTzVKcFB2WktXcXJmS3JFNkdp?=
 =?gb2312?B?V0ZWRG5ZMDl2SjgrME41cFNIZndDcENlbGVLc28yY0hGMlBnWW5Dam9mMjVV?=
 =?gb2312?B?SXRtRWxxSXhWVDJwUXlocUdmWGpNYzQrY0xGNldNSDMzbVo5Y1hKaE02WVAw?=
 =?gb2312?B?Y3BXWUczbWl1UzVpcTdZcElkenlONjJTNUlLMGtCOGJsMDYxMWxOUXRRcktR?=
 =?gb2312?B?R25seGhzYVNBem5ONkZwNTVpWUtaeHBOeUZqQzN4T1RJQlkvSXVGOEpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aUdPWWo0OFV0T0MxWjBtcFovWDF1L3NnZ0ZNTGtVY240ODF0MG1RelZwOUZv?=
 =?gb2312?B?emtHQ3NDS091Q240U3ZnTit5N1I1eC9WaThhRU5qN0RJbEVtNmVQdHNseHIv?=
 =?gb2312?B?a2ZNOWhrbVNXbXlSTHJ2US9SYmhJUmRpMmFMQUpoeHEzRnA1dWZiQlRPNElW?=
 =?gb2312?B?enpLSVplOTRaK0plczk2bnhWbGkzRHJUemtDNkxkS3JjZFJ4QVl1MXdocFNX?=
 =?gb2312?B?bW5aNjZYNnU3NFh0U1B6VDcyaCtjTFExT3B4dFU0ZTZtNjV6RGpUYi8zRldE?=
 =?gb2312?B?RzhEQjdudWdNbnZEN3UzMUM1Qy9SS3hwNkV5RmtzVWZRQTl6OURWeGhQaFA4?=
 =?gb2312?B?MElKbU5TcThwenpXSkpkN1ZYc3I3YjZMTFBWMEtYdGp1T2VvRnJKbjVtSUo4?=
 =?gb2312?B?d3VFWkcyaG5ndDJKc1BlbTlQdmtRQ2hueVRQTXhuTjExVG5DOE52cFF4NlBM?=
 =?gb2312?B?WFIyaWN3aDJFRHJWZGx3M0wxbmxBMWhvb25aS2xSSzZvdk1yRURZeVZsOWlB?=
 =?gb2312?B?QUNwZ2YxU3NyaDlIcU9tai9oeEo0dWdWZ0h6c05oREZXTjVoUER0MEd0dE1n?=
 =?gb2312?B?UzhjVmFrNGd1TzFKV1pDM0ZwOW5RNG5QS3lJcTcramVKNlQ2Zm5uRytGYVEr?=
 =?gb2312?B?QnRWb2tkZ3YvRDF4OEY2QmpHWitjbS8zLzg3cEdMdmtrbTdhVWsvcDJ3cXhv?=
 =?gb2312?B?L0t6Q0oxMm5tMWlVZjBwVVZpdEw3VmRqWGYxTGhBSVY2WGZmandTTDRPeDNV?=
 =?gb2312?B?a2h4UDAyZVpXTHBQSnhpcWlmcU10K3doaGJIa01Fd0pSMU1NeEpwbHpmR0J5?=
 =?gb2312?B?ZDBFUHI4OCtKN0dMKzVEU2d6L0VnVVEycTVkL1BnT0xSK0pVeXJuUW9IUkdW?=
 =?gb2312?B?b2k3VkxzY2FvMnhTN2VUL0RIQmJSRUpmSkN2TWt3b2ZFaXpKeXNHbE5rUFZB?=
 =?gb2312?B?c09GdzZFWVNqNktPQzVFVjN0dys1dUdZYTlFWFdWYlovVGIyQlNhSnYvSGtK?=
 =?gb2312?B?aU92VDhWVUt4YXdhNytWbWNuMDRIWUFiWlREVTJxWllGdHhOV0hZQmUwZm9t?=
 =?gb2312?B?YmRrVDdWa0d6Nzg2S1RhUGFsM2twNTZBS0g1VVowaWFmMjB1S09xT0N4bGJz?=
 =?gb2312?B?Tnh2N3ZldVgwdXAvdTJTeWlqV3B2OTBZMnc4aFZ5WHZBSm5GRHVDcS9RRkJZ?=
 =?gb2312?B?U1RwTjBYRDdtVG42WFhSaDhKcTh3ODBMMnYzenBtcThXTzhDTnVhbW03Tjky?=
 =?gb2312?B?enJSUWtwanhGd1JTcTlTVmpaYXErSnpEcXhMN0RUZXR6cVBuZktMQ3lXV0pt?=
 =?gb2312?B?aVJzbkVDKzFTalFpMENyWnFSWVJoVWVQdU1EMzRRSFVjeURhaHhpVWtKS3lG?=
 =?gb2312?B?dEtHYUlIaXQyN2RmTXpNMnRlMXRqUTE1SmFySjFFMlZvdkdmdXNTeFpncHpj?=
 =?gb2312?B?VVJwa29YcHpiQ1BSTFYzWUlWeGxCRlpVODY4bTdCYlZUNncrN0JZc3QxeWZJ?=
 =?gb2312?B?enJvR0puejQwbEVOZFh5SHVuQVUwM3graXZYd3BvWlhvVTBYOHBaSGpjN1A4?=
 =?gb2312?B?T1lTOVJqTzZ5Z0dBQ2UxaVBoaDVtODlzaHRjdnVVSFRmMFIzaFZrSkllNzd0?=
 =?gb2312?B?NWttWGpmTkhGOHRhMDdDTStTNzRkU0c2SGFOb3N4MmRwSzZtbWwvWmFrVDhy?=
 =?gb2312?B?MEd6OEJ0T2tscTVoUzA2aGxBK0F3eGM5MU95VGd5WXpkdExPS3Z4bFZYc0Nv?=
 =?gb2312?B?OXMvQkVIVStKd1VNVzVyYUJjakJ3V1AzTStaczlhYkFjMEE4OForb3JlU1M4?=
 =?gb2312?B?ak92T0xKTEg0ZFY2dE1OYng4blRZaUx3T2wvSEZZSG9CakFJOS91TTNsdUEz?=
 =?gb2312?B?Y3k2cEJJeEJoZ1VuTC84L1JTNU8vemRLRVRVWDJzak5SZVNpUFpxeDltdUUx?=
 =?gb2312?B?and3WmFxVWVvZ0lSRlZuTlE3MzVWdzRNVC9JaXJaY1NiV3JyNjYvd2RtaGM4?=
 =?gb2312?B?THpCUm5rSWp3YnZhRWI5WXlZYmdNQjZDR2oxL3BFb2txY3pPMkd1V2RVbERy?=
 =?gb2312?B?VEV2azRTL0ZHNUtDWUdyNE14NFBkeUlwNlhqdzNiSUNZUEJHYit1MTlFdzAv?=
 =?gb2312?Q?f63w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5b116d-c5b6-4735-a850-08dce8d0aefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 02:10:16.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bego0g4lzasEt/huRPVlM2Pyb6U7l1z1o/8lCr37c3w+9Z1GahCufkxYKADtDPgJVHVIEF5wcdlDeFr7H4rGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjEwyNUgMDozNg0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgMDMvMTFdIGR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBiaW5kaW5ncyBm
b3IgTkVUQw0KPiBibG9ja3MgY29udHJvbA0KPiANCj4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQg
MDU6NTE6MDhQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gQWRkIGJpbmRpbmdzIGZvciBO
WFAgTkVUQyBibG9ja3MgY29udHJvbC4NCj4gDQo+IENhbiB5b3UgYWRkIHNob3J0IGRlc2NyaXB0
IGFib3V0IGJsb2NrcyBjb250cm9sPyBZb3UgY2FuIGNvcHkgYmVsb3cNCj4gZGVzY3JpcHRpb24u
DQoNClN1cmUsIEknbGwgYWRkIG1vcmUgZGVzY3JpcHRpb24gaW4gbmV4dCB2ZXJzaW9uLCB0aGFu
a3MuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFt
bCAgICAgICB8IDEwNyArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEw
NyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+DQo+
ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9ueHAsbmV0Yy1ibGstY3RybC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L254cCxuZXRjLWJsay1jdHJsLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uN2QyMGVkMWU3MjJjDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhw
LG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTA3IEBADQo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAx
LjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0
L254cCxuZXRjLWJsay1jdHJsLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE5FVEMgQmxv
Y2tzIENvbnRyb2wNCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFVzdWFsbHksIE5F
VEMgaGFzIDIgYmxvY2tzIG9mIDY0S0IgcmVnaXN0ZXJzLCBpbnRlZ3JhdGVkIGVuZHBvaW50DQo+
ID4gK3JlZ2lzdGVyDQo+ID4gKyAgYmxvY2sgKElFUkIpIGFuZCBwcml2aWxlZ2VkIHJlZ2lzdGVy
IGJsb2NrIChQUkIpLiBJRVJCIGlzIHVzZWQgZm9yDQo+ID4gK3ByZS1ib290DQo+ID4gKyAgaW5p
dGlhbGl6YXRpb24gZm9yIGFsbCBORVRDIGRldmljZXMsIHN1Y2ggYXMgRU5FVEMsIFRpbWVyLCBF
TUlETyBhbmQgc28gb24uDQo+ID4gKyAgQW5kIFBSQiBjb250cm9scyBnbG9iYWwgcmVzZXQgYW5k
IGdsb2JhbCBlcnJvciBoYW5kbGluZyBmb3IgTkVUQy4NCj4gPiArTW9yZW92ZXIsDQo+ID4gKyAg
Zm9yIHRoZSBpLk1YIHBsYXRmb3JtLCB0aGVyZSBpcyBhbHNvIGEgTkVUQ01JWCBibG9jayBmb3Ig
bGluaw0KPiA+ICtjb25maWd1cmF0aW9uLA0KPiA+ICsgIHN1Y2ggYXMgTUlJIHByb3RvY29sLCBQ
Q1MgcHJvdG9jb2wsIGV0Yy4NCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gKyAgLSBDbGFyayBXYW5nIDx4aWFvbmluZy53
YW5nQG54cC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6
DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIG54cCxpbXg5NS1uZXRjLWJsay1jdHJsDQo+
ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1pbkl0ZW1zOiAyDQo+ID4gKyAgICBtYXhJdGVt
czogMw0KPiA+ICsNCj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+
ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGllcmINCj4gPiArICAgICAgLSBjb25z
dDogcHJiDQo+ID4gKyAgICAgIC0gY29uc3Q6IG5ldGNtaXgNCj4gPiArDQo+ID4gKyAgIiNhZGRy
ZXNzLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAyDQo+ID4gKw0KPiA+ICsgICIjc2l6ZS1jZWxs
cyI6DQo+ID4gKyAgICBjb25zdDogMg0KPiA+ICsNCj4gPiArICByYW5nZXM6IHRydWUNCj4gPiAr
DQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246IE5FVEMgc3lzdGVtIGNsb2NrDQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsg
ICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGlwZ19jbGsNCj4gPiArDQo+ID4gKyAgcG93
ZXItZG9tYWluczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtwYXR0ZXJuUHJv
cGVydGllczoNCj4gPiArICAiXnBjaWVAWzAtOWEtZl0rJCI6DQo+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy9wY2kvaG9zdC1nZW5lcmljLXBjaS55YW1sIw0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+
ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSAiI2FkZHJlc3MtY2VsbHMiDQo+ID4gKyAgLSAi
I3NpemUtY2VsbHMiDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIHJlZy1uYW1lcw0KPiA+ICsgIC0g
cmFuZ2VzDQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiBZ
b3UgaGF2ZSBub3QgcmVmIHRvIG90aGVyIHlhbWwsIHVzZQ0KPiANCj4gYWRkaXRpb25hbFByb3Bl
cnRpZXM6IGZhbHNlDQo+IA0KDQpPa2F5LCB0aGFua3MNCg0KPiA+ICsNCj4gPiArZXhhbXBsZXM6
DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBidXMgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDI+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsNCj4gPiArICAg
ICAgICBuZXRjX2Jsa19jdHJsOiBuZXRjLWJsay1jdHJsQDRjZGUwMDAwIHsNCj4gDQo+IG5lZWRu
J3QgbGFiZWwgbmV0Y19ibGtfY3RybC4NCj4gDQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAibnhwLGlteDk1LW5ldGMtYmxrLWN0cmwiOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MHgw
IDB4NGNkZTAwMDAgMHgwIDB4MTAwMDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICA8MHgwIDB4
NGNkZjAwMDAgMHgwIDB4MTAwMDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICA8MHgwIDB4NGM4
MTAwMGMgMHgwIDB4MTg+Ow0KPiA+ICsgICAgICAgICAgICByZWctbmFtZXMgPSAiaWVyYiIsICJw
cmIiLCAibmV0Y21peCI7DQo+ID4gKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
PiA+ICsgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgcmFu
Z2VzOw0KPiA+ICsgICAgICAgICAgICBjbG9ja3MgPSA8JnNjbWlfY2xrIDk4PjsNCj4gPiArICAg
ICAgICAgICAgY2xvY2stbmFtZXMgPSAiaXBnX2NsayI7DQo+ID4gKyAgICAgICAgICAgIHBvd2Vy
LWRvbWFpbnMgPSA8JnNjbWlfZGV2cGQgMTg+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgcGNp
ZV80Y2IwMDAwMDogcGNpZUA0Y2IwMDAwMCB7DQo+IA0KPiBuZWVkbid0IGxhYmVsIHBjaWVfNGNi
MDAwMDAuDQo+ID4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInBjaS1ob3N0LWVjYW0t
Z2VuZXJpYyI7DQo+ID4gKyAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4NGNiMDAwMDAgMHgw
IDB4MTAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0K
PiA+ICsgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAg
ICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsgICAgICAgICAgICAgICAgYnVzLXJhbmdl
ID0gPDB4MSAweDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4ODIwMDAwMDAg
MHgwIDB4NGNjZTAwMDAgIDB4MA0KPiAweDRjY2UwMDAwICAweDAgMHgyMDAwMA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIDB4YzIwMDAwMDAgMHgwIDB4NGNkMTAwMDAgIDB4MA0KPiAw
eDRjZDEwMDAwDQo+ID4gKyAweDAgMHgxMDAwMD47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICAgbmV0Y19lbWRpbzogbWRpb0AwLDAgew0KPiANCj4gbmVlZG4ndCBsYWJlbCBuZXRjX2VtZGlv
Lg0KPiANCj4gRnJhbmsNCj4gPiArICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54
cCxuZXRjLWVtZGlvIiwgInBjaTExMzEsZWUwMCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4MDEwMDAwIDAgMCAwIDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0g
PDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAgfTsNCj4gPiAr
ICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=

