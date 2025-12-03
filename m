Return-Path: <linux-pci+bounces-42565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01AC9F241
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 14:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CA63A65A2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B12FB60E;
	Wed,  3 Dec 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfqFRFP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1942FB0BE;
	Wed,  3 Dec 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768791; cv=fail; b=JoTFCUiEmjZg53wO56LsZHmZEyUbq5VEdbsW+q10LEgLp7eUe0r7nRPt8WqdH90qbcYmT6s+y+kZgC97w/C17xEKXjNXrgQeFwW1jSCneXlhkFFHfO2LEExqyPEwfR2xEnuJoSWgaMbHoATIUbAcI8wICaiY2wBu3zhUk1QprJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768791; c=relaxed/simple;
	bh=60zXPnKGnlk0c2F3Zi5Zu7rwon1AaR/Lfb3ogP5e0co=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=hZu1NsN39i/ahThLYV9S4HIgV/ppaqB29KSQhXta50Gpiiqfop92LQHxbJJh3T7CHYBKWB4I0VrL9z9UQ6tIycP6aCvdnwTVNVL5nLQcSHKd5tidqvTlAWbS2A9exP8A5WwG5gwKW6bsSbhgGy/dxCikEiptlq9rJZPxI70kd50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfqFRFP+; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1cIc6HX0opY6C5VDY4ZDdodSAFSyT1Zz1/1w6x8tsNMgt0/N2gC0FUTFBZ4hs4Qwj0gyT0HCx+FJ723D/IXHayCNAoNcU56rkeKLjnTXw+O8cd3yOhpLK+zjarYLyhDa2iD/c1AHeiTvL4qVLf4pYYFlS4mlCG5QxPhhU4kOSZcBLRrfdz3aC18Tevn6PMFYAAt+pBC6yZUtTQhtUtQIEIr/SgJWrEgu8lY58T0AJCyKD8wjBKtBSxZEeqVsvy9u6/O7gaMml3urb+/cHi/EvLialdpH/L/E2peORayGaGTR49G/qhiuEK/73IFMhPrFqbJLOqDAOSHl7erRvGUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5oqUUphNitkXpsGpmNVBHzLRibsyx1c4je+7K0XLy8=;
 b=j3c0cx1xX7IZh9NjIo4BFKo/PDCe+fXVNscaIQagDfFfMog0HOA5fRpxvsfAR9gLYTf92UhoVxFk5imSAAcnF+d/sPASoiTqHEidkJ17UGX4TLZ8R6VYvX4vWRekUTlxHjgcSOAGLP5dG5FyZeESVz5DoBkdVYjq6vJWJHU0pEZgaQTp1OaJxKLlOYvpya7ExVF2zY6Kt+Se0uQbqHRx76i5KxV9g3cFhtlG9bSVp7tUi6ROMSsuR/jLfv1Vt5k4pMBNQxhACoMflrVk4e7X1ub36iYPHVTmbkJCCA8Z1YMm8lubvAg54b0VRKS2Da1o8GrWTocy9egA3yKplMaGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5oqUUphNitkXpsGpmNVBHzLRibsyx1c4je+7K0XLy8=;
 b=BfqFRFP+gg2WIhsiYcSutDnnr93qg+Oe7C7hZn2H70ZHhgPNKlbpySQkUv6+OaT6NkjBl9msMjZP69wwpG8iEjSn2i+gp4dZjWpRLtibthSuQo/uQC/lDKa1M85mOKiA/4Ex+PCEefgcoVQEjt9xk9F3Pw3TUjCAvaUuJnkHXadmuZqN6LQqE8BCDOYcwhyPeACjgq1RNiRsElAiwl6YZshq4299fcCSSq49Ejzi+S4UHeWIV/KEa+WyY2CAjQkK9pV9iB2Wn6mq3VuOoI9atneViVeu20PNylnkrlbHr1pmo2FhpBfHDr4qpQwoUBJewmCAvHvcQ6/SjhZ6K2qLZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:33:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 13:33:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 22:32:58 +0900
Message-Id: <DEOMBKIRDXH6.2CF2MR2RB2W2C@nvidia.com>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com> <aSXD-I8bYUA-72vi@google.com>
 <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com> <aSbNddXgvv5AXqkU@google.com>
 <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com>
 <DEMV14GBQWMC.28TXT8E5YO5NW@nvidia.com> <aS2I2eHZ9G96ER-h@google.com>
In-Reply-To: <aS2I2eHZ9G96ER-h@google.com>
X-ClientProxiedBy: TYCP286CA0150.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bed9fbd-cfa3-46fb-59f3-08de32707ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzhpekZ6RzV2NFpGazcxc2JOM1BNamMraU5oU01UYm4vY0pzYzNqZFBSekUx?=
 =?utf-8?B?ZVVHSE9tQ3lvOUlhUGxMbEYvNTBjemhxZnNyMHI1RUVoMzUyMUE5dUZWUUpE?=
 =?utf-8?B?NkRaSjhEaUxOeUJIeEtocnRrK3dPdkF4RjdOYnlWWlBNUUdKNTRsZWZaUU5R?=
 =?utf-8?B?QXRVa1VhdmNkNkFyOWgzMC9UN0hxRzRjUUUvdjJ2aXF4dFFRRFRHRkNrTmRW?=
 =?utf-8?B?VE1DOEo5cTJJaWl4MXV5b1kweEFzcmwrMTZpczdxc1FoRG5pZ2N2bnF6UFI1?=
 =?utf-8?B?dVpzWUtvdXpCQWcveDV4U1dKNmxOSFZOSFZ0WFlTTjhIeTIwWVllR0ZTcUNT?=
 =?utf-8?B?ZUlxcVZWaFdpRnA2SHZzV2JneThFK2hvcExNY0FrSG5iT2RiRUYybVpjWVBm?=
 =?utf-8?B?dVBrTDlzQU5zaUFpMm9GcUFCUThKdVBobGQvdUdHTHh0R0J3Zk8wK0F0ZitC?=
 =?utf-8?B?UnA5aXE2NXpLeUJDOEl5Q1ZtM3JwU3NVSFNEdlRMK0hLekhLdk5JK3pNMldB?=
 =?utf-8?B?WDFCK2MxeW1Uc0FsSVN4NmpsejRlTUFFbGxiSUVCT1ZidDBWOEc1R3IrWU0v?=
 =?utf-8?B?bXhPdDNkT3FZdU80REVVYnZQMzhmU3J1aFEvNEVqZTBLZEpHRXRQT3RlTGoz?=
 =?utf-8?B?WGZIdy9nQU92OThtYXhMZGZKbUxROEdDNmJiMjBrWW1sN1BLWkRocEgvZnJR?=
 =?utf-8?B?bU04VTdRQndwSTJpbk5ncEs4Nmp5WHZhS2toRHVzcXNyb2NwVzlaVVlXR1ZM?=
 =?utf-8?B?SkNxdUtyTnhtWGNIRUJBS3U0RkZ5eWpSU2dtbTFISHZ1WHJEdmg2T2ozeWtC?=
 =?utf-8?B?WE9rR2s3bVdVdFAwOExrM2dHcVR6R1g5d245dXV0YXdNNjBhaHk4Yis5U0Qw?=
 =?utf-8?B?RFFpOTBrUk9iWVNPbjVndTdBeU9pMTZUY3Z6NU04eDR5bitYVnFWVkJyaUFj?=
 =?utf-8?B?UnowK3pKSmh5eDk2Qzg3UGdXZUw1U3BFdFgxdGFwNkhpQ3F6WWV6NG1hUVdu?=
 =?utf-8?B?MXE1RG9jM1JSR29VdVEyb1Y5Q3dMMEVBc0FpM0o2aEp4UjZkSy8yVFA5K0s4?=
 =?utf-8?B?L0NqZlJFbXUrcDJ6S2k0blFhU3hrM09MS1Y5THBjb3UyMzdRc0UzUC93QW8v?=
 =?utf-8?B?QTNSU3Jkejlwdk9iakF6Q1IzTCtza2x4ZS92bnpScXRYSDI1QVN2b2Nna29Q?=
 =?utf-8?B?YXUzaS9XM2ZRWlVaNGdNdEVLcmxRV2hRZDdaMnhmUnpwZ3ZjaEtiLytPMDk3?=
 =?utf-8?B?WWdJeElOOGNPVHVXNUx0QVVQcUUvdmN1U3RrVkpVYitoWUl3c1hWVTI1VnFW?=
 =?utf-8?B?SGdFdFYrSVE5Z3c2eGxLSWRCYkJJQWVycXRyZE1vZmdTb2p1K2R0MG9Bbm53?=
 =?utf-8?B?bHVRQ0V1MHpHUmxPNmF0ZXBVK2Q2YWZrM3U3K0dZRkxPUkg5ZG5INmVPbmRu?=
 =?utf-8?B?djJnRHNPVWllVTFHU3p5RDM2RjRiZW10OE15cndDbUVKWjdWN2pqQ0RDK0xD?=
 =?utf-8?B?NEFENlFOY2FJeVJERXFBUWZuRXJaT2F2RE83eW9rMFhnWmI5RFZHVFNVeE1U?=
 =?utf-8?B?clNYQ3FUME1lWDZPcEswRTZITGQvdXBCQ3ZWYTZJMytvcTNiVThLQWxQdm5s?=
 =?utf-8?B?dlJMeW9rUzJ1Z0VBNnh5b0I2Q256VjJGZW9NTmRzK1ZWWUtlSUxiK20xVW9B?=
 =?utf-8?B?UUdHRHJQTzBuSkYzMncwclRoTXVpRytVTE43NlJJMXhXbC9Wek5PTXVqdHFX?=
 =?utf-8?B?cHFoY3piVzZIZmdoWFBTbW9OZ3JOcGhmM2QrSFFISkNxNUdqMmR6K1JyRk93?=
 =?utf-8?B?V1pFak1Mc3pvU1ZSMFZkVTVtcXRlYmM3UTlybEJCYUN2dHZrOFFlSWd2WFlr?=
 =?utf-8?B?aE1CanFiMkdXQkNUWXFwL25FNlFZaWV1SE0vOTdxaTd5ZnZ5NGZQVzFnQ05L?=
 =?utf-8?B?ckczSU02d3NNL3d0MEN3ZC8rZkcwMGVOc2ZPMFl6KzlyQnhNcFZzK0liS0pr?=
 =?utf-8?B?V0liN1BXOUdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlcxUVRMWHZra1BzMWVIMjBZY2RzUjNqMEs1REdWR0ZWZG80Q0dHMVprZ01j?=
 =?utf-8?B?dUhDMVU1NmpISUlLU05rKzBPSHV3Z1M2Tm5UVldnSGc1U1huUHRCbWJXVzAx?=
 =?utf-8?B?TURoOE93TURHQmNmQS93UmM3cXB3ZG40bnBPemN0TVYzdzZrQ1pwcEpXWUJk?=
 =?utf-8?B?OWhlWEoxeEcyMml4TzhJc1lLMCt0RU9WTjY2OGdwVGdndUV1TjBzZmFVRC9h?=
 =?utf-8?B?Q2FrQXJEeWFNT3ZWUHR3d254TzlVWCtlZ1ZNbmdQN0ZVU2YySTJLZWU0VXB2?=
 =?utf-8?B?TTVjTDV3b2tnK3hrL3BOR0pCV2xXTkZyYkt1c3lZZFNHUEJlMWJSR21taGl0?=
 =?utf-8?B?YkNiVHNhbzUzQS9jTnBmZUdWZ01JVzZ4VWZUcTIxMFBSWDlPT2MxRW9PVlAy?=
 =?utf-8?B?ZU5Da3pDZFErUUR4NnZqaUF0RkQ2Sk54Mmt5MlJKQm10eTNmQk1EcU9ReVdx?=
 =?utf-8?B?M0FIM1k3b0lLWGRGMVA4VFNVTUhyVk93SXVCUFQzZCsrbUMyeFAxR08zWEVo?=
 =?utf-8?B?aFZLLzFMdmVNbTZ4Q2NEWk0yNmRSZS95d3Jyb0UxL3lLNzhEV2VLcnpRbGpQ?=
 =?utf-8?B?WWpVQUtvWGFWeno2UmQ2QlIreFFYVHg2YWxISjFkMHA5YzVHWnRzSWxtSHhD?=
 =?utf-8?B?bnFwOXN3ZGV0blVvY295VkV4U0NibU5LVyt4eTQ2RWNkclAwOVN6SUJVT0Vp?=
 =?utf-8?B?dTVscGdIVXlOazR1bHV2UTkrRU50V08zbXVXNjRGSlZBNEdCa0lLNkw5MVkx?=
 =?utf-8?B?QWdrckpDcEFnZUNoNk8zWmF0N3RIandwbDk1b0JLUGJjbFpmbjQwbk5pOHF6?=
 =?utf-8?B?WjV3VjNtSTgwc1lXYW1iYXJSa0hZQjNrajMrY09OMlBIN2VIeDB6V0tXNFNz?=
 =?utf-8?B?MmovVVVnWkRrWDRzdk1SeXRzc1lnZnpEejFKQVNLcVlMbTBvbUpVdUwxS2ZM?=
 =?utf-8?B?cFZqWGFuRTRoVlhteU1ZaHdrWXMzN0lKRGYyUWgxVUs0d04zV1gwdStOWE1P?=
 =?utf-8?B?Z3o1MkhDK0R1L0JYYmNLYjd5WXN3bVdTR3p3ei9DOHk1c0NiZVZ0bkZKajJW?=
 =?utf-8?B?NzU5QUpRdzMxZ3lidjRTekFyWjlxZ1MzZlVxbk9veUx2aUxhQStWalFJU3ps?=
 =?utf-8?B?QnZ0azA5eVdxR29LSGJRMXY5K05hV2wzSC85VFUyY2UwUVcwRVVLd203V2Y3?=
 =?utf-8?B?YWltWCtkUzZmSlhSNGFyam9Db2tBckNGcFlidXk3czN1SFRUYkxpZ0prVUJY?=
 =?utf-8?B?TDJpZlNsTDFRMnVxR2ZTR1FqZEhTajg1MFhLVFdneDFjWHJDY3I5ZjkvWXFa?=
 =?utf-8?B?ckFPdlBwWHd5WTBRQkZUTmRDMFkwZ2M5VnA1WXlaSVdTUGdqZWJ5eDROV0NW?=
 =?utf-8?B?VnhFdnozc0kzeDhBSERJTW9iYVg2ZzJ6NDh4Mk1pbDFBdUFaMTVsMmp6OXRJ?=
 =?utf-8?B?bytxdVBaOVZMdWwyNW1nWjZUR2l5VnAvU3FUWjFncGZtZVg4UFprS1FsZnFB?=
 =?utf-8?B?WWVHaThWblhlNTgwdGdDdzVjVkdLbXgxOXlmTXY4WHV5aDlZQldUOU1VWE5o?=
 =?utf-8?B?d2FRZGNoZHlkZ2gvMVVDNm1IV2htOHMvUjhNaHl3a1IwR1gwSFFqaWZnMlhh?=
 =?utf-8?B?enJBZ0Z2Z3NXaU5qcUpOOG9lU2hqRjM0alZ3NjU4Tk9zRmVnVzJETGdLaVlG?=
 =?utf-8?B?Lzh5MTJiWGprRXpaTUhUV01VSEg4ZHBTb0pvZVBFVjE1SHQ5bTVpVmFsTERO?=
 =?utf-8?B?cStrNzB3MG0vWWwzTjFVWERUZS9jaFIxT1ZFb3BqejVwK1hwSUZWOElsK0oz?=
 =?utf-8?B?VXhURlJ4bVI4ZVpPQ2xqV2l0amtZdEJmYzIwMUQ5cXZOVlMrWW1HOG5xdFdS?=
 =?utf-8?B?cTVsYWdNdkdUTzcvVEJESmYzY3J0UjZGQ0pnVGFzWjIvajRBczVKdElXZDha?=
 =?utf-8?B?dFREdmhpNHZsZ0tGWGpLeXdrREhUeHZ3ZjFFSlRuUTlmZ05lckJrTG8rbWJt?=
 =?utf-8?B?TE0yYzBNZ1drWmFTOWJZYi9UV3pQQTFXTE00TFBJdll2UlBOS1BKMndMenNn?=
 =?utf-8?B?a3FsY3J6blAxS1ZHRkQ4N3RKZEdQMlh1SktUaDBLS1hVTEpEREJZbE5DQk5o?=
 =?utf-8?B?bmtQR1ZXenkwMVN4Uk0xaVNwdG1RelhBbktXMTRGM3ZUYVVRSzFaaWhTc3E2?=
 =?utf-8?Q?tZF2+UtSgQip6JYtFC8xrPnVrcx/pHopmLc1yqSf6jvo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bed9fbd-cfa3-46fb-59f3-08de32707ad5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:33:01.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK+xE6vDrCvb3rRS68Aj79eSXeaRsk9OZDRwfpjwQXAYBT1fSm6eWCx2LRcgbtoFM4AC6rIV7ApXG6sEaebkeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

On Mon Dec 1, 2025 at 9:23 PM JST, Alice Ryhl wrote:
> On Mon, Dec 01, 2025 at 08:57:09PM +0900, Alexandre Courbot wrote:
>> On Wed Nov 26, 2025 at 10:37 PM JST, Alexandre Courbot wrote:
>> > On Wed Nov 26, 2025 at 6:50 PM JST, Alice Ryhl wrote:
>> >> On Wed, Nov 26, 2025 at 04:52:05PM +0900, Alexandre Courbot wrote:
>> >>> On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
>> >>> > On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
>> >>> >> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
>> >>> >> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>> >>> >> >> The previous Io<SIZE> type combined both the generic I/O acces=
s helpers
>> >>> >> >> and MMIO implementation details in a single struct.
>> >>> >> >>=20
>> >>> >> >> To establish a cleaner layering between the I/O interface and =
its concrete
>> >>> >> >> backends, paving the way for supporting additional I/O mechani=
sms in the
>> >>> >> >> future, Io<SIZE> need to be factored.
>> >>> >> >>=20
>> >>> >> >> Factor the common helpers into new {Io, Io64} traits, and move=
 the
>> >>> >> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implement=
ing that
>> >>> >> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO imp=
lementations
>> >>> >> >> to use MmioRaw.
>> >>> >> >>=20
>> >>> >> >> No functional change intended.
>> >>> >> >>=20
>> >>> >> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> >>> >> >> Cc: Alice Ryhl <aliceryhl@google.com>
>> >>> >> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> >>> >> >> Cc: Danilo Krummrich <dakr@kernel.org>
>> >>> >> >> Cc: John Hubbard <jhubbard@nvidia.com>
>> >>> >> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> >>> >> >
>> >>> >> > I said this on a previous version, but I still don't buy the sp=
lit
>> >>> >> > into IoFallible and IoInfallible.
>> >>> >> >
>> >>> >> > For one, we're never going to have a method that can accept any=
 Io - we
>> >>> >> > will always want to accept either IoInfallible or IoFallible, s=
o the
>> >>> >> > base Io trait serves no purpose.
>> >>> >> >
>> >>> >> > For another, the docs explain that the distinction between them=
 is
>> >>> >> > whether the bounds check is done at compile-time or runtime. Th=
at is not
>> >>> >> > the kind of capability one normally uses different traits to di=
stinguish
>> >>> >> > between. It makes sense to have additional traits to distinguis=
h
>> >>> >> > between e.g.:
>> >>> >> >
>> >>> >> > * Whether IO ops can fail for reasons *other* than bounds check=
s.
>> >>> >> > * Whether 64-bit IO ops are possible.
>> >>> >> >
>> >>> >> > Well ... I guess one could distinguish between whether it's pos=
sible to
>> >>> >> > check bounds at compile-time at all. But if you can check them =
at
>> >>> >> > compile-time, it should always be possible to check at runtime =
too, so
>> >>> >> > one should be a sub-trait of the other if you want to distingui=
sh
>> >>> >> > them. (And then a trait name of KnownSizeIo would be more idiom=
atic.)
>> >>> >> >
>> >>> >> > And I'm not really convinced that the current compile-time chec=
ked
>> >>> >> > traits are a good idea at all. See:
>> >>> >> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.c=
om/
>> >>> >> >
>> >>> >> > If we want to have a compile-time checked trait, then the idiom=
atic way
>> >>> >> > to do that in Rust would be to have a new integer type that's g=
uaranteed
>> >>> >> > to only contain integers <=3D the size. For example, the Bounde=
d integer
>> >>> >> > being added elsewhere.
>> >>> >>=20
>> >>> >> Would that be so different from using an associated const value t=
hough?
>> >>> >> IIUC the bounded integer type would play the same role, only slig=
htly
>> >>> >> differently - by that I mean that if the offset is expressed by a=
n
>> >>> >> expression that is not const (such as an indexed access), then th=
e
>> >>> >> bounded integer still needs to rely on `build_assert` to be built=
.
>> >>> >
>> >>> > I mean something like this:
>> >>> >
>> >>> > trait Io {
>> >>> >     const SIZE: usize;
>> >>> >     fn write(&mut self, i: Bounded<Self::SIZE>);
>> >>> > }
>> >>>=20
>> >>> I have experimented a bit with this idea, and unfortunately expressi=
ng
>> >>> `Bounded<Self::SIZE>` requires the generic_const_exprs feature and i=
s
>> >>> not doable as of today.
>> >>>=20
>> >>> Bounding an integer with an upper/lower bound also proves to be more
>> >>> demanding than the current `Bounded` design. For the `MIN` and `MAX`
>> >>> constants must be of the same type as the wrapped `T` type, which ag=
ain
>> >>> makes rustc unhappy ("the type of const parameters must not depend o=
n
>> >>> other generic parameters"). A workaround would be to use a macro to
>> >>> define individual types for each integer type we want to support - o=
r to
>> >>> just limit this to `usize`.
>> >>>=20
>> >>> But the requirement for generic_const_exprs makes this a non-starter=
 I'm
>> >>> afraid. :/
>> >>
>> >> Can you try this?
>> >>
>> >> trait Io {
>> >>     type IdxInt: Int;
>> >>     fn write(&mut self, i: Self::IdxInt);
>> >> }
>> >>
>> >> then implementers would write:
>> >>
>> >> impl Io for MyIo {
>> >>     type IdxInt =3D Bounded<17>;
>> >> }
>> >>
>> >> instead of:
>> >> impl Io for MyIo {
>> >>     const SIZE =3D 17;
>> >> }
>> >
>> > The following builds (using the existing `Bounded` type for
>> > demonstration purposes):
>> >
>> >     trait Io {
>> >         // Type containing an index guaranteed to be valid for this IO=
.
>> >         type IdxInt: Into<usize>;
>> >
>> >         fn write(&mut self, i: Self::IdxInt);
>> >     }
>> >
>> >     struct FooIo;
>> >
>> >     impl Io for FooIo {
>> >         type IdxInt =3D Bounded<usize, 8>;
>> >
>> >         fn write(&mut self, i: Self::IdxInt) {
>> >             let idx: usize =3D i.into();
>> >
>> >             // Now do the IO knowing that `idx` is a valid index.
>> >         }
>> >     }
>> >
>> > That looks promising, and I like how we can effectively use a wider se=
t
>> > of index types - even, say, a `u16` if a particular I/O happens to hav=
e
>> > a guaranteed size of 65536!
>> >
>> > I suspect it also changes how we would design the Io interfaces, but I
>> > am not sure how yet. Maybe `IoKnownSize` being built on top of `Io`, a=
nd
>> > either unwrapping the result of its fallible methods or using some
>> > `unchecked` accessors?
>>=20
>> Mmm, one important point I have neglected is that the index type will
>> have to validate not only the range, but also the alignment of the
>> index! And the valid alignment is dependent on the access width. So
>> getting this right is going to take some time and some experimenting I'm
>> afraid.
>>=20
>> Meanwhile, it would be great if we could agree (and proceed) with the
>> split of the I/O interface into a trait, as other work depends on it.
>> Changing the index type of compile-time checked bounds is I think an
>> improvement that is orthogonal to this task.
>
>
>
>> I have been thinking a bit (too much? ^_^;) about the general design for
>> this interface, how it would work with the `register!` macro, and how we
>> could maybe limit the boilerplate. Sorry in advance for this is going to
>> be a long post.
>>=20
>> IIUC there are several aspects we need to tackle with the I/O interface:
>>=20
>> - Raw IO access. Given an address, perform the IO operation without any
>>   check. Depending on the bus, this might return the data directly (e.g.
>>   `Mmio`), or a `Result` (e.g. the PCI `ConfigSpace`). The current
>>   implementation ignores the bus error, which we probably shouldn't.
>>   Also the raw access is reimplemented twice, in both the build-time and
>>   runtime accessors, a fact that is mostly hidden by the use of macros.
>> - Access with dynamic bounds check. This can return `EINVAL` if the
>>   provided index is invalid (out-of-bounds or not aligned), on top of
>>   the bus errors, if any.
>> - Access with build-time index check. Same as above, but the error
>>   occurs at build time if the index is invalid. Otherwise the return
>>   type of the raw IO accessor is returned.
>>=20
>> At the moment we have two traits for build-time and runtime index
>> checks. What bothers me a bit about them is that they basically
>> re-implement the same raw I/O accessors. This strongly hints that we
>> should implement the raw accessors as a base trait, which the
>> user-facing API would call into:
>>=20
>>   pub trait Io {
>>       /// Error type returned by IO accessors. Can be `Infallible` for e=
.g. `Mmio`.
>>       type Error: Into<Error>;
>>=20
>>       /// Returns the base address of this mapping.
>>       fn addr(&self) -> usize;
>>=20
>>       /// Returns the maximum size of this mapping.
>>       fn maxsize(&self) -> usize;
>>=20
>>       unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Se=
lf::Error>;
>>       unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> R=
esult<(), Self::Error>;
>>       // etc. for 16/32 bits accessors.
>>   }
>>=20
>> Then we could build the current `IoFallible` trait on top of it:
>>=20
>>   pub trait IoFallible: Io {
>>       fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>>           if !offset_valid::<U>(offset, self.maxsize()) {
>>               return Err(EINVAL);
>>           }
>>=20
>>           self.addr().checked_add(offset).ok_or(EINVAL)
>>       }
>>=20
>>       /// 8-bit read with runtime bounds check.
>>       fn try_read8_checked(&self, offset: usize) -> Result<u8> {
>>           let addr =3D self.io_addr::<u8>(offset)?;
>>=20
>>           unsafe { self.try_read8_unchecked(addr) }.map_err(Into::into)
>>       }
>>=20
>>       /// 8-bit write with runtime bounds check.
>>       fn try_write8_checked(&self, value: u8, offset: usize) -> Result {
>>           let addr =3D self.io_addr::<u8>(offset)?;
>>=20
>>           unsafe { self.try_write8_unchecked(value, addr) }.map_err(Into=
::into)
>>       }
>>   }
>>=20
>> Note how this trait is now auto-implemented. Making it available for all
>> implementers of `Io` is as simple as:
>>=20
>>   impl<IO: Io> IoFallible for IO {}
>>=20
>> (... which hints that maybe it should simply be folded into `Io`, as
>> Alice previously suggested)
>
> Yes, it probably should. At the very least, it should be an extension
> trait, which means that it should never be used in trait bounds, since
> T: IoFallible is equivalent to T: Io. But in this case, probably just
> fold it into Io.

Agreed, I don't see any benefit in keeping these separate although I
remember Danilo prefering to keep them parted.

<snip>
>> How does this sound? I can share a branch with a basic implementation
>> of this idea if that helps.
>
> My main thoughts are:
>
> First, we need to think some more about the naming. Currently you have
> several methods with the same name. For example, you have a read8 method
> implemented in terms of a different read8 method. It'd be nice with a
> summary of the meaning of:
>
> * try_ prefix
> * _unchecked suffix
> * _checked suffix (not the same as try_ prefix?)

I guess it shows that I quickly tried to adopt a naming pattern as I was
writing my email. :)

The logic was roughly:

- `_unchecked` suffix for unsafe ops, like the standard library,
- `try_` prefix if the accessor returns an bus error,
- `_checked` suffix if the bounds are checked at run-time by the
  accessor.

So `try_read8_checked` checks the bounds at runtime and returns a
`Result`, `try_read8` checks the bounds at build time and returns a
`Result` which only errors are bus ones, and `read8` is for the case
where the bus' error type is infallible, and we can know at build time
that no error will ever be returned.

... this naming pattern can probably be improved.

> Second, I think we need to think a bit more about the error types.
> Perhaps the trait could define:
>
> /// Error type used by `*_unchecked` methods.
> type Error;
>
> /// Error type that can be either `Self::Error` or a failed bounds
> /// check.
> type TryError: From<Self::Error> + From<BoundsError>;
>
> where BoundsError is a new zero-sized error type we can define
> somewhere. This way, Mmio can use these errors:
>
> type Error =3D Infallible;
> type TryError =3D BoundsError;
>
> wheres cases that can fail with an IO error can use kernel::error::Error
> for both cases.

I thought we could roughly achieve this by using the regular kernel
`Error` as the type returned by all accessors - does this extra
associated type bring something more?

> Third, if we're going to postpone the custom integer type for
> IoKnownSize, then I think we should get rid of build-checked IO ops
> entirely for now.

That would be a pretty disruptive change. I dread the Nova patch that
would be required. ^_^;

I'd also say it looks out-of-scope for this change? Zhi's goal is just
to extract the Io API into a trait, and this design doesn't
fundamentally change it, nor does it adds the build-checked IO ops -
they are already here, and this doesn't make the situation worse. I
agree this front should be improved, but that's a different effort.

Should we drop these ops, every single register access in Nova would
become fallible, and we would need to add error handling code for errors
we know for a fact cannot happen. I'd really like to avoid that.

> Fourth, I didn't know about the alignment requirement. I would like to
> know how that fits in with the rest of this. Is it treated like a bounds
> check? That could make sense, and we could also have a custom integer
> type that both has a max value and alignment invariant. But what about
> the *_unchecked and runtime bounds-checked methods?

Basically we would need the custom integer type to hold as invariant
that the current `offset_valid` is always true:

  const fn offset_valid<U>(offset: usize, size: usize) -> bool {
      let type_size =3D core::mem::size_of::<U>();
      if let Some(end) =3D offset.checked_add(type_size) {
          end <=3D size && offset % type_size =3D=3D 0
      } else {
          false
      }
  }

I initially thought that we could maybe turn this into a class of
primitive types for which a custom invariant to hold could be passed as
e.g. a closure, but of course it's not that simple. I'm still hopeful we
can reach a breakthrough somehow though.

