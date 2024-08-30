Return-Path: <linux-pci+bounces-12467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB29654DE
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 03:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6556281F83
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 01:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E2727473;
	Fri, 30 Aug 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSmiU+1n"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013008.outbound.protection.outlook.com [52.101.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031BEEB7
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982617; cv=fail; b=ACgnuVdOJkJeqAQa05+SjTiENATi7Qo3zXhRQOQ63tSi3ozIUqeW9eRAwOgIC+8UclPvkc43eL81PKbUeZjGHd+JPQtVAN6q+1t22TkseHakiZY/9vAgfgpOwkcQjokQoDf5BdW97QfDfeQtXe+uGvo1flHbbxlQpYY/GQyk0cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982617; c=relaxed/simple;
	bh=zXYASUhcbwndhPO48sodvsXuze2QwMVR34eh++IGt6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rW8pQix8jlkUOdvQwDiLPPlKp4hJwmKZCEeK3yQBSZOw66zo6dtpTPiya21NQDUCnytwS6Vu1qcB7Kevtk3s6skp8THNF5M/ppTVB4KvxrcLoD6qkGbIvq4Ao/eLwgbID3mG3JJpG8QFGWPN1F8+umgU7G+y1hAP1kFDjrKcm/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jSmiU+1n; arc=fail smtp.client-ip=52.101.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYR9Y2ICCstn80KTmXOdEAvd7N5+rO/Mlx9ZZ4oQIJ3W42GmoQRkjSuttfUZL71voJod1jhuTRz65VbWwSXEPpfChz+NaRxsejlExxmhQlzklfRpIqeO0/f1S8zgjIsOkA87l1q1ULZZ7YDD2oSCdBcQ1itAQy+Vt2M1bK9sbNsnzsg0vYwWnrkVYCoS+Hygel7PR7RVmKEJj+8pFbzxi3ABH74V7fkq+iFrh3KJW5cQWMnc3Pj/Py5EoXLM1u7KS7spcQyaSTnhOAV8S6A9tlMh/xS1N9VjgJ3Kijy+3F8ba3c6/mRzzAc0a9uksQJEZX0NYb6MZkVbHwv/PJmaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXYASUhcbwndhPO48sodvsXuze2QwMVR34eh++IGt6U=;
 b=x2FFI1BxlXuN0Xs7n+zufS6jjVVKmdtiXrBYLdLd6PqyvXJPa3kTwLOOIfCQhv+VY/7zUcKqwRpvxJi+H5gZspxkPCuB7d5KDAfoTSiLV2/kA5m7qVKi+UzzCq9OViV1zYBCkDz7yaOY8unHGJgWzRU1k98YUuOyaApyvQTibyckT1kEridyScYQOSjTXxIBhYxDneVAyFkq9YT5xHn6tX1d+zhVQzchvOYUX6fTT59FxoeZT0W9Y/xJLbCIu7DO250aWZKwwRDBo3xiCrn2shlBA8VjYF+F2JglaAMyGvq+QOm/fVi3ToV3CT4v688dPBtwP/DZJjnhWuPhcgmp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXYASUhcbwndhPO48sodvsXuze2QwMVR34eh++IGt6U=;
 b=jSmiU+1nd5UDEno7ra/s4yIoLCCz+q9gJABRTViMVUB25BpBbsmXXUHZlxLrux1R2mZzyHb+k/V5lZ/asCdz+A8/tpI5Y9hOtwJyo0Wx+vuIFzBfI+jNXWCVR6LhLrj3PHTdeTNNkZUbp93iryge5eBChyLHrxoU4Aet37sNLdWW5INh++oBtIW4/ypKzyXmiJ9GuCHliY3uozQzZreTfpWwB33CxlPEWE+D2TgtGCibm9lZXZ/f6xLCK82OUR3ZU5NLpCtTUxBFdhkfAK8b/2KVayVLFW1383JDc77C4fQvT16+tB0DwpnUj4UkPGukwS6C5C/k52LScY5dIcmneg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 01:50:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 01:50:10 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "tharvey@gateworks.com"
	<tharvey@gateworks.com>, Lucas Stach <l.stach@pengutronix.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Thread-Topic: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Thread-Index: AQHa+lmVk407jM5baUSc2LKQGGOv9rI/Bphg
Date: Fri, 30 Aug 2024 01:50:10 +0000
Message-ID:
 <AS8PR04MB86760487CB68BC5AA90634AD8C972@AS8PR04MB8676.eurprd04.prod.outlook.com>
References:
 <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>
 <20240829212235.GA68646@bhelgaas>
In-Reply-To: <20240829212235.GA68646@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA4PR04MB7630:EE_
x-ms-office365-filtering-correlation-id: 89ef39e9-ac9e-4501-9ebb-08dcc896155b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YlJKR1BmaFNURXM4M21DaEZOY3luNHFYVGRvUlllTGxWVXVjTGtpb1hiVStO?=
 =?gb2312?B?QTR6L1hvbDhDaktRa3g3NmttNHp0bmxCeCsrakRYRFhLd0dBdE1LSTZVN2hO?=
 =?gb2312?B?OHIySTNjaElsWlIwc0dpaE9Fekp0MnZ6QkZ5bnFmUDdPOXU0a3Yyc2dVT3RQ?=
 =?gb2312?B?S0poOHBqWVNlM0ExL093MEdoaWgwYzIwdEF4VDBVTFZWbk9wdXIxeEVQZmVU?=
 =?gb2312?B?NXZoanh4YmJNcVVZSVlEUUpRcEVzNnFWKzNtUTFXWHZNYURpdG90ZDZyKzdj?=
 =?gb2312?B?OHdDNEhCSFVLTjlrbEtSdi9aTkNPYks4cTByQjArUDFWOEtCdk01WmU2c1ZS?=
 =?gb2312?B?OXNRdjJtczEyMmNTWHFEcTljYXJZRk1FYUhPU0hPY3ptN2JMOVgyeXlpV2tp?=
 =?gb2312?B?TVd0bVg4S2o1Y0Q0dk91eEFjbHJhSUIzd01xRVFXeHdaaXlMbEtQNHJjUHVj?=
 =?gb2312?B?b2tKeE54OHNxK0RoeUFJbVJKSmtsR1o0MWdyMjQ5ZEVqUVByQWtaS2FrZFN3?=
 =?gb2312?B?N2tSRklUMHFKYWV6RFJmOVBOQXZDVGZKTER6a0FjNUtrQnlGQkc3bGVsTWZI?=
 =?gb2312?B?dGpGQWE1WUhmUUlFK2NGeWVZSEwwZXpUbktoU2F4aGRpbzlGRHpTRU9uTmxj?=
 =?gb2312?B?WEVNR1FXSzVDZldGT2R3cWc3c1B1VHZQSjg1cnRTaTVoZjJDZU9nakw2YlBG?=
 =?gb2312?B?UUxxTEsxTVhzRVB5RGtZbExCeVN4MkdNdzFvdHFMc0dGelBSWUFPL3d2Qmxz?=
 =?gb2312?B?M0ZpMy9zNVpSWENpR3JXcUdKakhVTXBJRDFaZWhQTDROeHR4YkxkdWIrbkdV?=
 =?gb2312?B?a1lYWXhQKzZQMUR6RUZ1VkdHdGU2VGtFRU8xSzdabG5jME43alJOUUlQN1pS?=
 =?gb2312?B?VmdGNFV0b2RqTUVtdWpZc01HT1dOZXNLRUxoZlNiQStBN0tSMnhTQWkvK2VC?=
 =?gb2312?B?T0UxcDcwK1Eydy9FSmZrcE90UnZseHpabkZLYUorSWJDdjFCRzFyZjRKTjBI?=
 =?gb2312?B?dVlId1VLWE10YUFVSUVzWDZBVU9YZTNNbDF5NGlibkFkQUpJUkRmR0tpaEFs?=
 =?gb2312?B?ZzZEY2M3TllrWlVBSmpjYzViNnRYbjJHVGEzcHpKSXlzYnZIWnBLVG1uZ1BP?=
 =?gb2312?B?ZVNDdVpXcW0vYjk5bXZsREZwanRPdDJGS0ZNQ2IvTDVQZExqMHVkazFEc1ll?=
 =?gb2312?B?b0tKMzAyVThvL29ycnhMdG5Da2xMUlhDc0NCNjN0cGwxZGl5VlBjZ1Q1Ym01?=
 =?gb2312?B?MDRNNnU1V0YweVFocDlnK01QYXRuVFYyQWNRZGg4RTlPV2l6ZjJ2d3NRVUtt?=
 =?gb2312?B?OENTc2JCNVRMa0JXUEcxaTBCL2hDUU1Od0EwWm4zbzlGTGIya0FPc2lseFhT?=
 =?gb2312?B?K3FwZ0E2cWRtd1RwcW5ZdDFzbFkyalROT1dGcSs0eFkrblZxaHBub3I4WEhh?=
 =?gb2312?B?U3hMdjNHa3hReDc2VWZ0OG9DYkhzYkNGZ1RtTmtmdGpWemd6Z2o2ZWpzbUs5?=
 =?gb2312?B?Qk4vQmZNU3lIV3hiVGQxNUsyVE1QTVVHbEdrVE9DN2FUUTRuMThNS1JCTHM5?=
 =?gb2312?B?UnR0RXZoRE5oRzhWT3hLVmhuT2QyajZ5dU5ySFhpS0Q5SmhnbmJrNVk3bjRS?=
 =?gb2312?B?b0lGSEtZMnVRNlI2QkZVSDgwMVVNY1E5Y3FvVnp2L0hsaHdPcS9ZN29DcUNS?=
 =?gb2312?B?RzcwM3JGTmJPRUg0b3p5bmpGRjEwSndtQlI0TlA4b2RoQkpUQWhVdnNWbVRz?=
 =?gb2312?B?WHhGa1I2Yk1BR2JQTnhHZzllM0dTU2E1QUtDTUl1TjhDeDZwR1B2STBrekV5?=
 =?gb2312?B?SHVaQk8xVFNDNUxYbmtscGJpTm95TmFvRHhva3RvMjNmaThNNldMaDMwRWpt?=
 =?gb2312?B?OXZRcWMrV1YyK21Dekc5V0RzRDJzV0RMMDdOR1hDVklVMkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MzV1U3BPQnpSWUx5MDUwSW9UNGRELy81SXNSNENTL1BqTHM2K3RwK1hNTmE3?=
 =?gb2312?B?c0VqaFdKTHRyRkg1RG9UY2MvcjNFUDF0OFRpcmdSMmYyeTBhSm1LUEYvbU5s?=
 =?gb2312?B?SEpoQm4xUGhITTBoM0JkNXBxSnVQeTI0R3J4WnY3MmFtUHRFaFVaOVB6d0pK?=
 =?gb2312?B?amhha0M0eGl2ZkR0bmVCZWRPUDRzUmYwMkg2OTRMaGxZcm9JTTFlRkExR0xS?=
 =?gb2312?B?WitxQ1dUM3B2emsxOE5mZ3JkemUrWGFHWG8ycm41cWZYKzY1UHAyOURQR2hK?=
 =?gb2312?B?Vk1Nb2hWOXNvMnpkTE9aQ3VaN091eGpNL3JROGhleGlEMWxsNVZPL3E4R0xZ?=
 =?gb2312?B?b244RkVoYnYzZmlObDlLRUxqMUZuSVpaaThuUjJNeFh5KzN5dkFvMXRsaE9J?=
 =?gb2312?B?Uk44RWlSNGFxaU1jU3p1b00vZ09HNGxhUjlsQU0zb2R4d1JuTktaRXdPNWw3?=
 =?gb2312?B?bTJFOEhpem5xTVRlZ3hoMjlCaFFTYXJVbG5iOVpDUjNaWHE1ZVJLK2RhMlhB?=
 =?gb2312?B?TW01amRBSEdYMDFJTEVWRTRRVi92TkNkLzloUUl2NkZZdzNIcEZLOGxsbUJu?=
 =?gb2312?B?b0ZZT005RWtPU2R4RFRFWngzV2k2bzZlZm5XNHRVeUxRMEIwSmpQZjUrcWRr?=
 =?gb2312?B?N3ZhSTVZWVk2VEprL2NjSXMzZnd6b0NaZ094MEp1Z1Zod29DMGVVYjNacHVj?=
 =?gb2312?B?RVNVVmJXNTF4SHUvQlZSTjdBWWJ1bVdZVWtCN2R0TVBiV1o4ZW1RemliSENj?=
 =?gb2312?B?cVBiYWk5STMxUHB4bDVwNlVDd1VqVlRHZzNIS1lHeWkvT1BBZ29LM0lmejdJ?=
 =?gb2312?B?VGFVV0hleWlZSHdnOUlZVzN5T2hmNHIvbmFCenZ6T1pTWkpYTHJOWUpwOG9o?=
 =?gb2312?B?OUY3QkRsZ1ZZQVd4bVpsWUV6R0JveS8wdjdLbVQvTmMveXdMZ21QdEVHR2lm?=
 =?gb2312?B?bjFLTlJzbzFzdnBVRm1oMWtNZmhzbS9rQTVKL3NyM2dXQXB0d1FwU2M3MU1l?=
 =?gb2312?B?QVBuVDNWNG9mNUM1NFJVbGV4dWw1T2hvbHBPbDRtVU51cDAvQ2MwVTFDVDFk?=
 =?gb2312?B?b0tIcjBsMjFlTVgwczZ1ZG1MYXUrWGhrNlZrZTRrYmd1NC9IWXkwTnkzdFdj?=
 =?gb2312?B?SDlzR0NXcmNCOHBKR1ZJTXFMS0llVDBobGgvSUg2WjJES2tOQnFRVVkvanEv?=
 =?gb2312?B?dUs5azhmMzNrN3V5a2NtVzJ4RUU1aDZ6QStmNjluNlFnZW9WU1Y0cy8xTkRH?=
 =?gb2312?B?bmhCWmpURUpBbUg5V0dhQzVjVmJtcnlOVDVNYjlMcjlqMlFYaFRYeFVQU0V6?=
 =?gb2312?B?SnhtWjR5aHVRc01FZDhGNC8wUGRxakxQcmJsZGJuY2Fwc3VnbE1QTVdVaEJz?=
 =?gb2312?B?czdPcHpZaDVMOWt5eEVtU3pIaGlhY1BhcGlraFRyVnhaMkptRENrc1Z1dG1x?=
 =?gb2312?B?Q21yVkhhWW9VNFN3UTNSSmFCd09NRnhCK3FZNTFUTkZ6TEQrZWh0eTZHZGRo?=
 =?gb2312?B?TlBQbFVOTEFOY1lGMFdKd3F5M29kcVNTREdpMlFZNTlWN2V2eG5LSnRsOHM2?=
 =?gb2312?B?dUNlTFEwQWVkNldqOFpBcXpwVXQyaWcvTHBSaStrUDdZR0t4MVlZUWlVZWtE?=
 =?gb2312?B?d1o0T2k4WWJVVlEzYjZOYTd0cVNjeEdWMWg0cjc3MHlhZVZUbHhRdnJWbTY4?=
 =?gb2312?B?OHRUSjdiV2N1U0trTU9kRnJBSzAxcmtwNUFZdUhvTEFqOHFIOFlRQ3hpN0tx?=
 =?gb2312?B?aDRCbld0UXpPT0FRa1FuVjVOOGpmdTFuS3pOVkdwRjJWTm9SL2RDYkpTTHVs?=
 =?gb2312?B?T3dkNTBxenhMTVdhYUk0N0NHL1pFNlVCdW5xQk5NOHN1VDAyQlBRamxsbmor?=
 =?gb2312?B?dVpZVGh6dFZyTUNMMk1PL3Q2UlFUTTlZcEpaODFkSldnZmpYUXN5UGRWc2Uy?=
 =?gb2312?B?VVEzUVp2dktXZ0dRcWl6d0pkMTJsSWVqV3dPYnYvNmV5b2dmTHhtMnUvWlBZ?=
 =?gb2312?B?bm9LK3R1YnZrZzZTRS9NZi9kdHd0akxlQkJ4QnE2Y3h4Y2ZsVkpucHNub0xz?=
 =?gb2312?B?eE54Zm9scHVKcnlYcWhzVEtlVXFXUDhEMktoazIzUGhFcVpYdE8wNGNmZFdV?=
 =?gb2312?Q?zdRXAPGlibKS99dmk6B1ojOs5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ef39e9-ac9e-4501-9ebb-08dcc896155b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 01:50:10.8409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bIWstS9z6WDvYqZl1nzVFq+PdZChbSOkNx9YY/aslEzR+9wIFgFEvbm6C3Q6AjCf3U4Y9M0Z6Mrf1q29nABMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7630

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jjUwjMwyNUgNToyMw0KPiBUbzogdGhhcnZl
eUBnYXRld29ya3MuY29tOyBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVj
YXMNCj4gU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBsZWdhY3kgUENJIGRldmljZSBiZWhpbmQgYSBi
cmlkZ2Ugbm90IGdldHRpbmcgYSB2YWxpZCBJUlEgb24gaW14DQo+IGhvc3QgY29udHJvbGxlcg0K
PiANCj4gWytjYyBSaWNoYXJkLCBMdWNhcywgbWFpbnRhaW5lcnMgb2YgSU1YNiBQQ0ldDQo+IA0K
PiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCAwMjo0MDozM1BNIC0wNzAwLCBUaW0gSGFydmV5IHdy
b3RlOg0KPiA+IEdyZWV0aW5ncywNCj4gPg0KPiA+IEkgaGF2ZSBhIHVzZXIgdGhhdCBpcyB1c2lu
ZyBhbiBJTVg4TU0gU29DIChkd2MgY29udHJvbGxlcikgd2l0aCBhDQo+ID4gbWluaVBDSWUgY2Fy
ZCB0aGF0IGhhcyBhIFBFWDgxMTIgUENJLXRvLVBDSWUgYnJpZGdlIHRvIGEgbGVnYWN5IFBDSQ0K
PiA+IGRldmljZSBhbmQgdGhlIGRldmljZSBpcyBub3QgZ2V0dGluZyBhIHZhbGlkIGludGVycnVw
dC4NCj4gDQo+IERvZXMgcGNpLWlteDYuYyBzdXBwb3J0IElOVHggYXQgYWxsPw0KPiANCmkuTVgg
UENJZSBSQyBzdXBwb3J0cyBJTlR4Lg0KQWRkIHBjaT1ub21zaSBpbnRvIGtlcm5lbCBjb21tYW5k
IGxpbmUsIGNhbiB2ZXJpZnkgaXQgd2hlbiBvbmUgZW5kcG9pbnQNCiBkZXZpY2UgaXMgY29ubmVj
dGVkLg0KQmFzZWQgaS5NWDhNTSBFVksgYm9hcmQgYW5kIG9uIE5WTUUsIE1TSSBvciBJTlR4IGFy
ZSBlbmFibGVkLg0KbG9ncyBvZiBNU0k6DQpyb290QGlteDhfYWxsOn4jIGxzcGNpDQowMDowMC4w
IFBDSSBicmlkZ2U6IFN5bm9wc3lzLCBJbmMuIERldmljZSBhYmNkIChyZXYgMDEpDQowMTowMC4w
IE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJvbGxlcjogRGV2aWNlIDFlNDk6MDAyMSAocmV2IDAx
KQ0Kcm9vdEBpbXg4X2FsbDp+IyBjYXQgL3Byb2MvaW50ZXJydXB0cyB8IGdyZXAgTVNJDQoyMjE6
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBQQ0ktTVNJICAg
MCBFZGdlICAgICAgUENJZSBQTUUNCjIyMjogICAgICAgICAxNCAgICAgICAgICAwICAgICAgICAg
IDAgICAgICAgICAgMCAgIFBDSS1NU0kgNTI0Mjg4IEVkZ2UgICAgICBudm1lMHEwDQoyMjM6ICAg
ICAgICAzODIgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBQQ0ktTVNJIDUyNDI4
OSBFZGdlICAgICAgbnZtZTBxMQ0KMjI0OiAgICAgICAgMTE1ICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgUENJLU1TSSA1MjQyOTAgRWRnZSAgICAgIG52bWUwcTINCjIyNTogICAg
ICAgIDUyMSAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgIFBDSS1NU0kgNTI0Mjkx
IEVkZ2UgICAgICBudm1lMHEzDQoyMjY6ICAgICAgICAgNTMgICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgIDAgICBQQ0ktTVNJIDUyNDI5MiBFZGdlICAgICAgbnZtZTBxNA0KDQpMb2dzIG9m
IElOVHggYWZ0ZXIgcGNpPW5vbXNpIGlzIGFkZGVkIGludG8ga2VybmVsIGNvbW1hbmQgbGluZToN
CnJvb3RAaW14OF9hbGw6fiMgbHNwY2kNCjAwOjAwLjAgUENJIGJyaWRnZTogU3lub3BzeXMsIElu
Yy4gRGV2aWNlIGFiY2QgKHJldiAwMSkNCjAxOjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250
cm9sbGVyOiBEZXZpY2UgMWU0OTowMDIxIChyZXYgMDEpDQpyb290QGlteDhfYWxsOn4jICBjYXQg
L3Byb2MvaW50ZXJydXB0cyB8IGdyZXAgbnZtZQ0KMjE5OiAgICAgICAxMjI1ICAgICAgICAgIDAg
ICAgICAgICAgMCAgICAgICAgICAwICAgICBHSUN2MyAxNTcgTGV2ZWwgICAgIFBDSWUgUE1FLCBu
dm1lMHEwLCBudm1lMHExDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gSSBzZWUgdGhh
dCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHN1cHBvcnRzIGJvdGggaG9z
dCBhbmQNCj4gZW5kcG9pbnQgbW9kZXMsIGJ1dCB0aGUgb25seSBtZW50aW9uIG9mICJpbnR4IiBp
cyBmb3IgYW4gSU1YIGRldmljZSBpbg0KPiBlbmRwb2ludCBtb2RlIHRvIHJhaXNlIGFuIElOVHgg
aW50ZXJydXB0Lg0KPiANCj4gQSBmZXcgRFdDLWJhc2VkIGRyaXZlcnMgbG9vayBsaWtlIHRoZXkg
c3VwcG9ydCBJTlR4Og0KPiANCj4gICBkcmE3eHhfcGNpZV9pbml0X2lycV9kb21haW4NCj4gICBr
c19wY2llX2NvbmZpZ19pbnR4X2lycQ0KPiAgIHJvY2tjaGlwX3BjaWVfaW5pdF9pcnFfZG9tYWlu
ICh0aGUgZHdjL3BjaWUtZHctcm9ja2NoaXAuYyBvbmUpDQo+ICAgdW5pcGhpZXJfcGNpZV9jb25m
aWdfaW50eF9pcnENCj4gDQo+IGJ1dCBtb3N0IChpbmNsdWRpbmcgcGNpLWlteDYuYykgZG9uJ3Qg
aGF2ZSBhbnl0aGluZyB0aGF0IGxvb2tzIGxpa2UgdGhvc2UuDQo+IA0KPiA+IFRoZSBQQ0kgYnVz
IGxvb2tzIGxpa2UgdGhpczoNCj4gPiAwMC4wMC4wOiAxNmMzOmFiY2QgKHJldiAwMSkNCj4gPiAw
MTowMC4wOiAxMGI1OjgxMTINCj4gPiBeXl4gUEVYODExMiB4MSBMYW5lIFBDSSBicmlkZ2UNCj4g
PiAwMjowMC4wOiA0ZGRjOjFhMDANCj4gPiAwMjowMS4wOiA0ZGRjOjFhMDANCj4gPiBeXl4gUENJ
IGRldmljZXMNCj4gPg0KPiA+IGxzcGNpIC12dnYgLXMgMDI6MDAuMDoNCj4gPiAwMjowMC4wIENv
bW11bmljYXRpb24gY29udHJvbGxlcjogSUxDIERhdGEgRGV2aWNlIENvcnAgRGV2aWNlIDFhMDAg
KHJldg0KPiAxMCkNCj4gPiAgICAgICAgIFN1YnN5c3RlbTogSUxDIERhdGEgRGV2aWNlIENvcnAg
RGV2aWNlIDFhMDANCj4gPiAgICAgICAgIENvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNw
ZWNDeWNsZS0gTWVtV0lOVi0NCj4gVkdBU25vb3AtDQo+ID4gUGFyRXJyLSBTdGVwcGluZy0gU0VS
Ui0gRmFzdEIyQi0gRGlzSU5UeC0NCj4gPiAgICAgICAgIFN0YXR1czogQ2FwLSA2Nk1IeisgVURG
LSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0NCj4gPiA+VEFib3J0LSA8VEFib3J0LSA8
TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtDQo+ID4gICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBB
IHJvdXRlZCB0byBJUlEgMA0KPiA+ICAgICAgICAgUmVnaW9uIDA6IE1lbW9yeSBhdCAxODEwMDAw
MCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKQ0KPiA+IFtkaXNhYmxlZF0gW3NpemU9MjU2S10N
Cj4gPiAgICAgICAgIFJlZ2lvbiAxOiBNZW1vcnkgYXQgMTgxODAwMDAgKDMyLWJpdCwgbm9uLXBy
ZWZldGNoYWJsZSkNCj4gPiBbZGlzYWJsZWRdIFtzaXplPTRLXSBeXl4gJ0ludGVycnVwdDogcGlu
IEEgcm91dGVkIHRvIElSUSAwJyBpcyB3cm9uZw0KPiA+DQo+ID4gSSBmb3VuZCBhbiBvbGQgdGhy
ZWFkIGZyb20gMjAxOSBvbiBhbiBOVmlkaWEgZm9ydW0gWzFdIHdoZXJlIHRoZSBzYW1lDQo+ID4g
dGhpbmcgb2NjdXJyZWQgYW5kIE52aWRpYSdzIHNvbHV0aW9uIHdhcyBhIHBhdGNoIHRvIHRoZSBk
d2MgZHJpdmVyIHRvDQo+ID4gY2FsbCBwY2lfZml4dXBfaXJxcygpOg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9w
Y2kvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBpbmRleCBlYzJlNGE2MWFhNGUuLmE3
MmJhMTc3YTVmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253
YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9z
dC5jDQo+ID4gQEAgLTQ3Nyw2ICs0NzcsOCBAQCBpbnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0
IHBjaWVfcG9ydCAqcHApDQo+ID4gICAgICAgICBpZiAocHAtPm9wcy0+c2Nhbl9idXMpDQo+ID4g
ICAgICAgICAgICAgICAgIHBwLT5vcHMtPnNjYW5fYnVzKHBwKTsNCj4gPg0KPiA+ICsgICAgICAg
cGNpX2ZpeHVwX2lycXMocGNpX2NvbW1vbl9zd2l6emxlLCBvZl9pcnFfcGFyc2VfYW5kX21hcF9w
Y2kpOw0KPiA+ICsNCj4gPiAgICAgICAgIHBjaV9idXNfc2l6ZV9icmlkZ2VzKGJ1cyk7DQo+ID4g
ICAgICAgICBwY2lfYnVzX2Fzc2lnbl9yZXNvdXJjZXMoYnVzKTsNCj4gPg0KPiA+IFNpbmNlIHRo
YXQgdGltZSB0aGUgcGNpL2R3YyBkcml2ZXJzIGhhdmUgY2hhbmdlZCBxdWl0ZSBhIGJpdDsNCj4g
PiBwY2lfZml4dXBfaXJxcygpIHdhcyBjaGFuZ2VkIHRvIHBjaV9hc3NpZ25faXJxKCkgY2FsbGVk
IG5vdyBmcm9tDQo+ID4gcGNpZV9kZXZpY2VfcHJvYmUoKSBhbmQgZHdfcGNpZV9ob3N0X2luaXQo
KSBjYWxscyBjb21taXQgaW5pdA0KPiA+IGZ1bmN0aW9ucy4NCj4gPg0KPiA+IFdoaWxlIEkgZG9u
J3QgaGF2ZSB0aGUgcGFydGljdWxhciBjYXJkIGluIGhhbmQgZGVzY3JpYmVkIGFib3ZlIHlldCB0
bw0KPiA+IHRlc3Qgd2l0aCwgSSBkaWQgbWFuYWdlIHRvIHJlcHJvZHVjZSB0aGlzIG9uIGFuIGlt
eDZkbCBzb2MgKHNhbWUgZHdjDQo+ID4gY29udHJvbGxlciBhbmQgZHJpdmVyKSBjb25uZWN0ZWQg
dG8gYSBUSSBYSU8yMDAxIHdpdGggYW4gSW50ZWwgSTIxMA0KPiA+IGJlaGluZCBpdCBhbmQgc2Vl
IHRoZSBleGFjdCBzYW1lIGlzc3VlLg0KPiA+DQo+ID4gRG9lcyBhbnlvbmUgdW5kZXJzdGFuZCB3
aHkgbGVnYWN5IFBDSSBpbnRlcnJ1cHQgbWFwcGluZyBiZWhpbmQgYQ0KPiA+IGJyaWRnZSBpc24n
dCB3b3JraW5nIGhlcmU/DQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4NCj4gPiBUaW0NCj4g
PiBbMV0NCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZmb3J1DQo+ID4gbXMuZGV2ZWxvcGVyLm52aWRpYS5jb20lMkZ0
JTJGeGF2aWVyLW5vdC1yb3V0aW5nLXBjaS1pbnRlcnJ1cHRzLWFjcm9zcw0KPiA+DQo+IC1wZXg4
MTEyLWJyaWRnZSUyRjc4NTU2JmRhdGE9MDUlN0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20l
Nw0KPiBDZmExZDk4DQo+ID4NCj4gZmJkZWEwNDVmYjcyZjEwOGRjYzg3MGI1YjglN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3DQo+IEMwJTdDMCUNCj4gPg0KPiA3QzYzODYwNTYz
MzYyNjA4NDc2MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakENCj4gd01E
QWlMQ0pRSQ0KPiA+DQo+IGpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMCU3QyU3QyU3QyZzZGF0YT1paw0KPiAzcXZCdVB3DQo+ID4gbGoyOXExQlVVdGUlMkY0MlN3
U3B4WW5LR1c5UHZtRkxGdWFFJTNEJnJlc2VydmVkPTANCg==

