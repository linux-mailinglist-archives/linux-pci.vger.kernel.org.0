Return-Path: <linux-pci+bounces-42118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEFBC8A0EC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3333AF4B4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E222EFD9F;
	Wed, 26 Nov 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/hbEO/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C797280024;
	Wed, 26 Nov 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164263; cv=fail; b=b7kWlM8Rbfad01eaKAF8i761oVURvFUtLJziixPU00hAM6f7IJgEe6lOgx2HqKYoO8rGU++OLVP5jiEWtOWlQCgWvhbUyQY9WXCUi3FC9vUOFXi53Io+Ue4V+f3Wwx1//3vGUSXhrrt/0YBJTBOFlomPvmSGFD6a1qw0stqMJkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164263; c=relaxed/simple;
	bh=T8ohWWL0NlecX8wiD8zYnMMsisER+nq6Lx8udo4+22A=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=LYf6buXxn3L1ZsOI12n54zdcVHpjLCu591/KLYrgTrODLuyLND/oY+Z7hdU2soKttjkADbCHgvhoFQngxAiMFgwl9pRG4FeeqOBMEh0Kd1hnC8z/YW5PStGnZ/Dy34+C7IAeH0Es7erVHrQWcqeUrhEMj8mxHYO8JkDQdFtktW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/hbEO/d; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5WaCvf+DnaDSGsJ9STFSqq9gvZop7Y1hJlVgeNQmrKKUTvjSDa7DRMyqdugPlToyxlYcEbiqKJ5MBmuIu0NruKjTZizqxYjOMmaot+i9mMD41hu0AV3HLgzjcQo5YKWxi7OI8t6Ynr9cVoWy9C3MoU5Pv/RLvw/J4Io4nstN0azllDPa5G0ruq3rWnukjzxCA5FjYVGsrLED9ZovkDplp2TtxQegmVzuv8i/egPn3ciA1rI6+CdOBsYbTovxPxrrWyResOPduhL6Cq90aVRxgXBDUyOgLMIbKkzSCPiZ4gghgk8oNVKOZ5njqFGx00thouLr49t2tBInPWrKruusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T572YKPVSHCixHdQYOqUMb2S8VZyEPS7xXU5+KUU63Q=;
 b=UitPEtMr6wyVSNAyuJ8N8IltPxJTih2M8QNQvA5m75jBoEiQo1DyTVfoxnxi0desmxsOGMYaXAfxKxdanhGLnMtsp+7xoFeYh+v/cWZBZGBmqTCHXsm9Cke4s6T19oDaasYB4pX2w8N16xVn3bqTn0ERfyL8fyVsaIsxY1V80aS4d9bhSC/tH9Mej4mRImyozCVeqxZLFoVb00fWSe/e5D/BVo/Fa7G8v3btbn01V2UMtSnAluGAK6FBRsraKo9CPx5ZloVeBVMhaeyQhmp2gKNXPE89B2l17YiXcVvmWSROMpbp6iSsChLlo/pgUrsy5Ci82N9U60dA5mdXy/84VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T572YKPVSHCixHdQYOqUMb2S8VZyEPS7xXU5+KUU63Q=;
 b=a/hbEO/dJfpsTrB+9h/uK288CpoowyD0m897ZbNOYudON8iCIc4PLEEPpRI4omuz2X0Du66NdGLUaAh2MPUCUxv9rurX3Z4b6p0e3Ob+QQv1wbHLMvVf8lEkDaUAKJxtyXjdnZuKoyFGCYzOCkpYzRsVuFOTZEB9gtz9xSP9gU6YWDpky59LBmAF1j6sU0RjFkpKggUinx11lD7txPNo3woAmlELJly1uQsDx5H3afXH0oyu241ePquA+GflYejJ0701x9XdDK7nwOOiQb/sXj7TXaBfLsTMmR/lgpESodHmnIzImm448+slFVrTAF0ne8XOE6PI/zGZKKDCzIubeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:37:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 13:37:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 22:37:34 +0900
Message-Id: <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com>
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
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com> <aSXD-I8bYUA-72vi@google.com>
 <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com> <aSbNddXgvv5AXqkU@google.com>
In-Reply-To: <aSbNddXgvv5AXqkU@google.com>
X-ClientProxiedBy: TY4PR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4a5628-ae1b-49d5-3a99-08de2cf0f6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVNMMDd3eGs2ck1VN0xnUU4yVnRYK0RCbGdqSXNKUjhueGI5MDg2NFdvbjBY?=
 =?utf-8?B?MW1qYTBMdEFqQUVCVGtwWTVKTkVPcUxTSnp6QWV5Q0tKR2FUekdhVGMrNC9w?=
 =?utf-8?B?N2ZVSFZsOTdPNS9MYk9BOEVMcWJsSnl0dGtvcHpTbzFBUjc0cGJjS3pacGxZ?=
 =?utf-8?B?Uys2QUZFWGlkYjJOM1ZKUDJWYVhBQVZ1eGdWQWVpbHdFbHAwZ1p1NlFKazNW?=
 =?utf-8?B?SjUrcnNUVUdxbUVFZ1djYU0zdXJaSVNLNkkvMVpzWE5hZURPcWtWU2duUUVP?=
 =?utf-8?B?Q0drRmcwYlBGZVhOb3dkNHlHWUZNUDBKN2tSQ3JpcFpUZnlQOFNMLzZwak9E?=
 =?utf-8?B?amQ4ODlmSGlRb3NaQWI1T3c4Ym81Yjg0Z3Byb2hXYTRlMmN1U1NFOXZMMm15?=
 =?utf-8?B?QnRKMXdrb3RwWlM1bktzOGtSU2p5QzNsYklaMWxyMkJqQTdyRGdONVcvaDNi?=
 =?utf-8?B?Zk4yZGxiZTJFTGppbFZGOUFiOUk2cFBRaGF4UjJuZGZnWC8zdlpMVnJlWHJN?=
 =?utf-8?B?RnpQRFBCNTNvMXNqYkJaUE51SjZETW9KN1lmZ21tOXFYRHhMNk5yN0dJd3pl?=
 =?utf-8?B?VG81ZVY4T240NlJVMDFUL0d4NUU3Q3FTTUQ4c2VWUTk2M1BJL1hMclNmSnRo?=
 =?utf-8?B?aTY2WGdYazdSc0ZzcVRzSE5SbCtISzlGWmk5L2lydFBYank2Z2hVR25VYjMx?=
 =?utf-8?B?MWczQUo3dWZQVlA1TlFYVDFJTWtFMk1TK3ZsOUlTeDBnMHVxN2lUTCtSNWw4?=
 =?utf-8?B?N3RsTlpXZ3FjWnA0bW9QeHJrRkV6NjVFdUtYTDE3RFovZDVJYUdrTjBQN3FU?=
 =?utf-8?B?YzNncTVxRDVScWlOU2g0THZrRnVEZXBndkRubDV1RHRsMzdDMEI0a0NGWUt3?=
 =?utf-8?B?L0hvYU9reXFPQmx2OWdyNzVGWVRGbGNmZ0xiOTZETkZNOHQ4WjJBQW1iMDFX?=
 =?utf-8?B?Y1pXVmRPSW9YTmZDdG9vWSsxT2hJT3B1NWM2WjgvWGdqOVdJaFJycTE2MExL?=
 =?utf-8?B?K2ZrYnZ5NENacUlJdWlMUE5taEt2RzRRempDUmh6SXVxTkxabDVvcEdmSEZL?=
 =?utf-8?B?Q3RTOFJhSlVQTk5uVndKYUdVVE9ZWVB2dXg1TVJhZXVGa0RqMjE4M1dwZnJM?=
 =?utf-8?B?dnZUMmNQVUErRDMxa09GSUkzSC9KTE51eXAyVUl5WnRmUjJZemFrY1E1di9w?=
 =?utf-8?B?YkhUTUpUbGh4QXlvWEhpYjlmZVJ4UzFaeEZJbEkyTHR3WTdEL2dmR1FYb0p1?=
 =?utf-8?B?R25ER1MvMWQyTEdkVHMzTFNUOEZ6bjNta05YSVRrYmRBdDBubXphRng0ZFFF?=
 =?utf-8?B?Q1VodmZRejhDQ3NiMFNTSUhLL1dmWDR5SXp4WCtFWlZ4SmZOcllTMmw0eml4?=
 =?utf-8?B?bnRyMTVrM242eFVvL2d3OFRSUHMvWWc5cHVWTXRMU3h1YjY0N0I1WFkrdFlN?=
 =?utf-8?B?L1pvK3BEZ1VXOEJaUU5hM05RQUh5QWFCRWYrNzVBbkxvK1FvNFlPQ2F6bjNn?=
 =?utf-8?B?R2xUbzZzUTAveXhycVVRSzZMQnZqUXBPWW9ua3l0REx1MENqUDU1TWJJbG1n?=
 =?utf-8?B?blovbCsrSXBHZG5Db242OWlwKzlYZnBwRDlqTmtvam01TXpMM1B3bVljdnY2?=
 =?utf-8?B?ZnBKS1JEOXNFcXkyYTQvSmk1Ukp6NStRZlNwYXE3S1hCQ3B2b0xodEJEK0FQ?=
 =?utf-8?B?U3JZKzdSWUdyZVE2NjNTdTdmR2c4YlR5Si9nWFg3WDJrU0xjM1JHZUdKclAx?=
 =?utf-8?B?S1hSMXVjWFZDOU04VForb3A2UncxWmpjSU5ablV4MHFkTVovUTNvTXRtQnlk?=
 =?utf-8?B?THNoazRmVkZlWjEzckFobnhJWTVnUE5ROUszYkYvVDQ0TG5wRmJyazVZc0ZB?=
 =?utf-8?B?WVMyU3dKQ09hZHBoRkNJOHBVemxpZUlxYTE0ZzRJREVEQzl1UC9PY1gzMGc2?=
 =?utf-8?B?SlhRVy9MYktxL05GSnRXSGdidnBxV2UxWEFIbTVSZkFxa01xcGdPVWFNay9J?=
 =?utf-8?B?SUgvZEp5T01RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djV4WVBxaldOQURxTFhkL3VUQXBMK0pNT1ZRaFRFM1ZhV0RKTmkrUE9IOTlz?=
 =?utf-8?B?RXRCb2VXem4wNXhKUWNVek82WXNkTERheEhabG1yTWw1di9mRGlTTDYyc1p0?=
 =?utf-8?B?ZG1TdVNPRkdNZFR4cEtIa3hDYzBkbWVJY0pRRWhQaUZ4S1BhcEszVExMbVNQ?=
 =?utf-8?B?dXdNU3hlY0l1YW1qdTNUTW9qWXYvNHVRYzFjNDlaUjV5d2trOUFvUWdoNnB2?=
 =?utf-8?B?WHE4YXdGdE5vclp6ekhSU080U1liZ2pwaGJXUW1SQVR3Wmdkb0pCUHBnWFo5?=
 =?utf-8?B?RlZheUJ4V0tJUSs5S1ZUSkhmbm5CNHNTUkRPYk96REJzNGZOdmxxWmhNMHdl?=
 =?utf-8?B?UUNMWHlscXUzNEtIK3hnRmZoUitOWm1YWGc2ekc1OFdnZDduSmcrcGdiMlFj?=
 =?utf-8?B?bDVCRGFMcHFDYXVNc1RHWUxNTklNODdQRThqMFNZTkZFSENqUGpoQVROSkE0?=
 =?utf-8?B?NkVHSksrdEc0VjBaMC96M3pmOVJZMkcrNFVFVmFVZnRSTnoyQ1o0MkVPZCtM?=
 =?utf-8?B?NWJTRUlEMndVMFhmZHBUVG5ieDMyT1kvdG42eWJSWnVDblNDcTFFQi8xUTJD?=
 =?utf-8?B?aXptUjB1ZklaOWk2YmUxNjdhcStta21mdC9TQzA2V2VyM0FBaXBnUW9XNC84?=
 =?utf-8?B?b2tBTi9UUHBLa2F0TWF3clFKL2tZYlhOdW83WEovWmdXTmJwUnR3VmJNSUlD?=
 =?utf-8?B?VWN0Q3FFYTR3Z05BNXhUUmZVOG1RTEVBZDVxNHNFcVNPL2RGRE9BTk5aSjBP?=
 =?utf-8?B?eHlvZTZjM0VqT0VoODJ3YTlveFFGNHVBOUV4Y0pMUXEzOVdXd3JwWWJ6MVl4?=
 =?utf-8?B?VEI3eWk4TjdiVjEyY3dCNWVvQlZhYzkybUpVZFh1RnJXci9nMnVSbk9HaUhu?=
 =?utf-8?B?ZlJuMFc1aTVQZ3lYVmMzQnVaZ0NnQUIwb1hjWmxLTmdZTnY5a3pkditUaVZq?=
 =?utf-8?B?dHN6Tm4zaXBNOHNvTERRQzhpT2J1N3lxejFrK0hhVG1ISFBzSy9HdnRrOVlp?=
 =?utf-8?B?TDQ1bDVjYzB5eTM3ME5iTE5SWFkwM1pNQklKZjU4b25ESUdzdWxJTGVaQTVX?=
 =?utf-8?B?L0tZVnJ4b2JhOU1qYnEySkZ3YW1veHZJYnhvaklLNWhMeFhLQnRGeTR5enQ2?=
 =?utf-8?B?d2htZlpLYkNJRE9lQXNmeURDbUR4emRldkpLN3RYanlWSCtxUGlVRnlTK3d0?=
 =?utf-8?B?RWFGSUhEU256L3dRRWFKN0R3MHpPOUFiSkExUXBlcnVSY1JQbkJrb2RBOEs0?=
 =?utf-8?B?U2krekFoaTIzUXFqZGZYc2pNTDZzZXZWc3ZReHBXRjkvMTZ3T05lcEdqSGNO?=
 =?utf-8?B?Nk5iUXF5UkNzbWVXMW4yUzBURXJubExlWWU0Z2g1emVsdkNBRmpNbUJlbjZy?=
 =?utf-8?B?M2RBU1g4RGhic0RYMGhPMTd2SllRRXlVd1NPbCtmTHo5eEt1YTFKZ2lRNmli?=
 =?utf-8?B?Q0VZZ1EvWllRL3RPVWNaWUdSeC9qdWs1K3pZdzZaaXdvK0xzeitRb09mcUFa?=
 =?utf-8?B?UWNUTUx0aGhrWUIvcHlMOWJYd2hHY2tUY1llaVFlSk12L1hWNExhcVVpTUQ4?=
 =?utf-8?B?emppMWNVS2ZuSnFZSm5wc1ZuREtsUzB2UDEwZFZzZmJ0TGhTQ3lTN0E2eFN0?=
 =?utf-8?B?V2pUcFM1aGcrcCtVcy9nNXlJT3BBeWhoU3NPMEVyMGNTTmhxOTV2dXNody9H?=
 =?utf-8?B?UDREWW5aaG9NM2duWFl6UmNocHQvemV3VDFBeXB0clQ4cXVjTzFhM1lVUDVT?=
 =?utf-8?B?WCszZVAwcEgxNzZWbWllcy83dHdBbjAzeS9JQ0hzSUdzclpROWtoZnVZeWxV?=
 =?utf-8?B?bHNvN3ludmtHVXJ4cG5mdGpMQzB4OFZYalArRjlvSnZVR1NiaHN4cnNmeVY1?=
 =?utf-8?B?Tm5BMUYvdmlDTlZESFRYVDltRCtCYXNiSWNsQ2M4NHlQN2tURmZLTG90SitJ?=
 =?utf-8?B?eDljN3hmSC8veWh2bE83bFhkWTdXdktreXA3ZXNMKzJrNUhmYndKckNQMDhI?=
 =?utf-8?B?eXBRc1V0Q2xObU5jMDQxOS8rTWJqL2MydlEvOXYrc1R0cjl6VENUU3VDODJv?=
 =?utf-8?B?cWd5YzBYTjdkaUtOTnhUczIwTEJzUTQxZU94OHk1TGMzbmdWeW1URXdVUTQr?=
 =?utf-8?B?dEFUcHFSS21tMi9PYnpON3FhWnhWUzdRUXh0Z3VvSUtIMU5vdkkrMWl4eHJ2?=
 =?utf-8?Q?vLSTVmYH4rzgNWnnEabNXEoYv1Kyw0Nf3ulJ6rV60MVR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a5628-ae1b-49d5-3a99-08de2cf0f6e0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:37:38.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmWmTyhMkUAQwtiRhjjqKHHI+jo0QjOYnQyL9ImiO4iVMj2pN+TJ651VjgY3eixcEFVbUrohOkcM9EZ09PxIkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

On Wed Nov 26, 2025 at 6:50 PM JST, Alice Ryhl wrote:
> On Wed, Nov 26, 2025 at 04:52:05PM +0900, Alexandre Courbot wrote:
>> On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
>> > On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
>> >> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
>> >> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>> >> >> The previous Io<SIZE> type combined both the generic I/O access he=
lpers
>> >> >> and MMIO implementation details in a single struct.
>> >> >>=20
>> >> >> To establish a cleaner layering between the I/O interface and its =
concrete
>> >> >> backends, paving the way for supporting additional I/O mechanisms =
in the
>> >> >> future, Io<SIZE> need to be factored.
>> >> >>=20
>> >> >> Factor the common helpers into new {Io, Io64} traits, and move the
>> >> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing =
that
>> >> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO impleme=
ntations
>> >> >> to use MmioRaw.
>> >> >>=20
>> >> >> No functional change intended.
>> >> >>=20
>> >> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> >> >> Cc: Alice Ryhl <aliceryhl@google.com>
>> >> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> >> >> Cc: Danilo Krummrich <dakr@kernel.org>
>> >> >> Cc: John Hubbard <jhubbard@nvidia.com>
>> >> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> >> >
>> >> > I said this on a previous version, but I still don't buy the split
>> >> > into IoFallible and IoInfallible.
>> >> >
>> >> > For one, we're never going to have a method that can accept any Io =
- we
>> >> > will always want to accept either IoInfallible or IoFallible, so th=
e
>> >> > base Io trait serves no purpose.
>> >> >
>> >> > For another, the docs explain that the distinction between them is
>> >> > whether the bounds check is done at compile-time or runtime. That i=
s not
>> >> > the kind of capability one normally uses different traits to distin=
guish
>> >> > between. It makes sense to have additional traits to distinguish
>> >> > between e.g.:
>> >> >
>> >> > * Whether IO ops can fail for reasons *other* than bounds checks.
>> >> > * Whether 64-bit IO ops are possible.
>> >> >
>> >> > Well ... I guess one could distinguish between whether it's possibl=
e to
>> >> > check bounds at compile-time at all. But if you can check them at
>> >> > compile-time, it should always be possible to check at runtime too,=
 so
>> >> > one should be a sub-trait of the other if you want to distinguish
>> >> > them. (And then a trait name of KnownSizeIo would be more idiomatic=
.)
>> >> >
>> >> > And I'm not really convinced that the current compile-time checked
>> >> > traits are a good idea at all. See:
>> >> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
>> >> >
>> >> > If we want to have a compile-time checked trait, then the idiomatic=
 way
>> >> > to do that in Rust would be to have a new integer type that's guara=
nteed
>> >> > to only contain integers <=3D the size. For example, the Bounded in=
teger
>> >> > being added elsewhere.
>> >>=20
>> >> Would that be so different from using an associated const value thoug=
h?
>> >> IIUC the bounded integer type would play the same role, only slightly
>> >> differently - by that I mean that if the offset is expressed by an
>> >> expression that is not const (such as an indexed access), then the
>> >> bounded integer still needs to rely on `build_assert` to be built.
>> >
>> > I mean something like this:
>> >
>> > trait Io {
>> >     const SIZE: usize;
>> >     fn write(&mut self, i: Bounded<Self::SIZE>);
>> > }
>>=20
>> I have experimented a bit with this idea, and unfortunately expressing
>> `Bounded<Self::SIZE>` requires the generic_const_exprs feature and is
>> not doable as of today.
>>=20
>> Bounding an integer with an upper/lower bound also proves to be more
>> demanding than the current `Bounded` design. For the `MIN` and `MAX`
>> constants must be of the same type as the wrapped `T` type, which again
>> makes rustc unhappy ("the type of const parameters must not depend on
>> other generic parameters"). A workaround would be to use a macro to
>> define individual types for each integer type we want to support - or to
>> just limit this to `usize`.
>>=20
>> But the requirement for generic_const_exprs makes this a non-starter I'm
>> afraid. :/
>
> Can you try this?
>
> trait Io {
>     type IdxInt: Int;
>     fn write(&mut self, i: Self::IdxInt);
> }
>
> then implementers would write:
>
> impl Io for MyIo {
>     type IdxInt =3D Bounded<17>;
> }
>
> instead of:
> impl Io for MyIo {
>     const SIZE =3D 17;
> }

The following builds (using the existing `Bounded` type for
demonstration purposes):

    trait Io {
        // Type containing an index guaranteed to be valid for this IO.
        type IdxInt: Into<usize>;

        fn write(&mut self, i: Self::IdxInt);
    }

    struct FooIo;

    impl Io for FooIo {
        type IdxInt =3D Bounded<usize, 8>;

        fn write(&mut self, i: Self::IdxInt) {
            let idx: usize =3D i.into();

            // Now do the IO knowing that `idx` is a valid index.
        }
    }

That looks promising, and I like how we can effectively use a wider set
of index types - even, say, a `u16` if a particular I/O happens to have
a guaranteed size of 65536!

I suspect it also changes how we would design the Io interfaces, but I
am not sure how yet. Maybe `IoKnownSize` being built on top of `Io`, and
either unwrapping the result of its fallible methods or using some
`unchecked` accessors?

