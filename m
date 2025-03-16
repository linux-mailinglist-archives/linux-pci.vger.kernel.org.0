Return-Path: <linux-pci+bounces-23876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC66A6332F
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 02:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D753AFE41
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8F125D6;
	Sun, 16 Mar 2025 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fc8PHX2L"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F4611E;
	Sun, 16 Mar 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088786; cv=fail; b=ZCODsmERfL+bQrvaLMkqps9CQoFuaCb1RSjYOQekiIWluxOeSJ9p5h5M+b+fVMAAAUULPXPRjyhEdmnzl1dMTnyWNwdVL42wextnDH/st4yQ/jmzZ8VmEiuWkU076p0151E5aIO+zoZIywED8DcDzUrlK59v987vt4qHh6R77BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088786; c=relaxed/simple;
	bh=cYWG4Jw7I7TPN0wPOcJPLzNGog77Pf3lIKu/BNLtDeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A1w0q4yE5Y5dahTOrQrFhTnoPV1h6A7LPFg87pZbhs09hi5ItRzLsWDMCMY/g8eV0mSqVRmvsWVv598kxlICMeqSdYEwUmLqtNCxR63//52UhrcP/DjYJespVytSmxjfrTNuL9WSAOtDuRZRKKNzDCjDZdrnKi6aqJc/NYITVqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fc8PHX2L; arc=fail smtp.client-ip=52.101.67.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9/fwa+JF/hATz+V7cqbMZg00oAdLNT4lkbcI8BTIdlRpLBRunep4E6ayMk+T02Xrm25RqMR/xlunWvN1FE2tFLraRNqmH7MgKDAth0A//soK9kr3vmudNLW3C+qUE3R2oELx5ZaWlvdakqPseSh0MYV4pFr5PzvZ+8C3UhXCcjEE/RGYDodZfzt6OTDQV4YxMqVEQIQULPoJ2xZBcFTjOGEl9p0scmhk6p8NBv8Nw2Jll7wD/HsasIwfpYEmTYvfpH9LDnELU16hEU7V7ODhAsbr28pQq4Xz5KNVZDAwduNF9CGHxsbRBxOjHtqOpVgM1HTdwF4z8OumKbOZ2XBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekgF5xYVyK8IhAYmkEKxWryK0dT38DZBf8TmcIphmu0=;
 b=qC6wVvkFjOvs2p5l7r9IKI3yVuxGfv/w7u1nrzW7tIeliYJ1G3fuxAio9wEvgwKSfCGe3hqYIpJG3egVpDRsgosFhpOQQydBKDfb1F4OiXBRCOfLUUrubfFYI5M83AzliZPAro+ykr191AoppqikdaKD3H6S/ikWCyc+RJ5BaZwhOu/4e1JJB3NyeMSVgfLE/06Z89chPQL/2Ev5hKYVI44H+runPi8/g355ojblVMX5zvm68QmhMFGCtiYYzHcX9iuEDXGNcFqmfl4h/iLmoBHiitTSsa7y0Hr4N8APWrJl3C4fqRzMYFLHVOZdBsd7M4NidagtogBjRlhHsuiFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekgF5xYVyK8IhAYmkEKxWryK0dT38DZBf8TmcIphmu0=;
 b=fc8PHX2LcphaLSKdpDvEb/WD8mYDtOq62rlnRo0O5m829YDeL9ozI0YuGfA2N9QfI3C6Lbn7HRmNav3fk+Z4gtRG+/BUZiIRwS0/V07SwTnfSioyxbzx13+8OYgpGwxkT0fMvzXVdIEg3X45vpqd8F1Hgt0eVcaOsMr3j/ymWMU9sCLh38rueMGZH7EiToGOussu31uzu8rTewzVED35PW18qOCSwlDyIpJX13pXvFIHWe5LqpJb8wnKSTIz+gRg8ZylXd9vUi3ytSw70RqudBqQkvK7OFMIK2kVCytSZy0Lp2gbj0X1tnSic/sjEaRnUIwDD9JNGUXwpCwm7sKr4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6964.eurprd04.prod.outlook.com (2603:10a6:208:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 01:33:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 01:33:01 +0000
Date: Sat, 15 Mar 2025 21:32:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 10/13] PCI: dwc: ep: Use devicetree 'reg[addr_space]'
 to derive CPU -> ATU addr offset
Message-ID: <Z9YqQm12WY13obkd@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-11-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315201548.858189-11-helgaas@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: e8393aa9-1773-47a4-af12-08dd642a7d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVJkSlhWZEZaMFd6djZ2SkJQNE9vMmNtTm9xeUM3SzAwbmxlcGh6TnRjREtu?=
 =?utf-8?B?K1MwckpmY296NUhpV0lFOURVTkhmUTVWYXZnemJVNXo3L1RSQk5mcGpsOGlW?=
 =?utf-8?B?VGlLMy9TOGdxcjNiZmRtUEEzSlB5dDIvSHhWaTVBN0RrY3ZGS2VJSVlNOS8v?=
 =?utf-8?B?cUhUUlZzbWZHNk0zSDEydk82Tms0SUVDOHU4KzVMZUhTdGdlZ1hYZXFsZTU2?=
 =?utf-8?B?ZC9HNm1yWU1MTUpKNHc0aEsvSm00blcvOUxQTFZDa1V4KzdiYUlWUU1ISHpC?=
 =?utf-8?B?aUduNXRzeWdQRUJ4S2laM0c3R1pwQ2w4VHNZUm1WaVg4anRVQVhTUFloVXV3?=
 =?utf-8?B?UCtkMEpLbHdnZ0J1NmhXaDZiVFVnVGFTQit5cittV2dIRDlLWnFhbjNXZVBp?=
 =?utf-8?B?M0cxSGorY25vRDlpcmlKVWozeGp3dXFMTk4xMzNWR2VteWNDdE5KZVlzNEhq?=
 =?utf-8?B?YVNOK1gyK3ZsY0E5N2Y2ek1QUVdvY1Y1d3lRWFR2cXdRUmJjbzczb0p2cUhj?=
 =?utf-8?B?MDFDV0ROOFRVbkw0cHkvOWEyZ29TdlhwaGxWL2E5L29EODFud2YvSks2WGxR?=
 =?utf-8?B?VVR2bzFBVjFndytaTUovK0dsYzMrVUxkeU9wSFFOZFlTNHlWdmxSRmpxd1Bj?=
 =?utf-8?B?QmwxQjNKWmR3bm1zTm8za2txVGZqNFpqZjFuaXVOaHZ0MU1RTG1adnBiQjFz?=
 =?utf-8?B?TitkelFhbHZHYzlXVlYxK25vejg3K0dlYmZpeHVJUWlLVWJraVhyYUt4MVpI?=
 =?utf-8?B?ci8zYzNyUGZoSXM2dDNzMUdNcTVUMEkrTHc3dmlGeERFTzBpcVhCU01mUlU5?=
 =?utf-8?B?bzVzREE5QmJVbXZrS1VoNXBnTHJ3cVZOQkJ3TTRGZGhqTFJtK1BPSzFPbnA5?=
 =?utf-8?B?dDFLY0V5aWN6Si8xakNxdjEwYW5acGc4UHZkbkNrNjMrTE93K1c0bEEwNFVJ?=
 =?utf-8?B?eFZ6RUkzbDBXVDlJWjRjUy9walN6YkF5RmxyTERUWlREcWw4TGp3L3dHL0Zh?=
 =?utf-8?B?ZDhrOWJUR01jd3J3ZnBzNWJ6MFBCZktrNzdoMjA1ZDRQZS9RVVFsTWRvUkIz?=
 =?utf-8?B?MXp5Y20xVDZ4b3E4VHNSVmIwKys3VDZpRy9uaXY3eDZxZEx6UjY4bnVDSHRZ?=
 =?utf-8?B?ZE5sbE1IR0RLOTZLREMxYWx2TmkrNkpMcG01OG1MZjJtSDVUWnMySkU1a0ha?=
 =?utf-8?B?UWZ0akk3Q2FzamtvYlNic1dLU3hFcG0xYStxTVg3OGIzTktjV01oeFhSRTFR?=
 =?utf-8?B?VGJrVER5L2owd2hkc1JnUDhWdE5zL1pobnhYV1E0T29qL201MytheEFZdzJo?=
 =?utf-8?B?NThPUUJzWktMQUVrY281UG9BZEs2VDlRTkxRME8zV1hLTHBhSHVpbklWa0NR?=
 =?utf-8?B?WmJiYjk1R1NVSHBHc0YwYlBxM2pmNG0wajNtYnkxajhVWDIveHhwSHZDb09F?=
 =?utf-8?B?OXNRNWcxWHNCMnFXNExDSGlYQVhZeTl5Tzl6Z0ZlbmFNdXkyUmV6TzNnSmdJ?=
 =?utf-8?B?NU0zem9HQWZPcy9lYkhWRDRmNGdjbVNsalIrQkJSTURSRzNXUHNuL3h6UUs0?=
 =?utf-8?B?YmE4b2pWYUpWVFRYVzR6MkNFVEp2blpCcWN4Z0Yzc3pvNkJnajlEU0xyWk9M?=
 =?utf-8?B?TnRueGtTUkR3NGdSaTR3SVdDNVhiNi8xeUdwQkxBNExRUlpTbjdvTE8yd1dl?=
 =?utf-8?B?ZmwrSVVQdlo1YVpUWkVkcm0zZVJQWlZnejExWW5uVVh4VFpXZExiS2I5bDFH?=
 =?utf-8?B?ODVXV29pY0hZb1ZDWlBNZjl2WEhIZEwwdlZJdmE4b040LzdKelVNT1B3QWVo?=
 =?utf-8?B?Y0VHL3F1aVk3WFptbnlPd2ExRTBSSlJ2SXd1dmpwQ0t1UTFzSTFGZWovOUVn?=
 =?utf-8?B?MStaSUI4eU1yR1ZEMFAraVpOTHZQTTd5Y3FsTFY5WEkvU0JSQ0ZtaGd1SmRV?=
 =?utf-8?Q?j9uU8KxBzqLHFRsTbKyi+zXo88gRfZRC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDgwMWpuK3lHS1BaR3A4RkcwRDdvYXNSTk5uUXdJclI0SEFaTkRIS3pkbStk?=
 =?utf-8?B?bnAyb0VxaFpUQ01xWVlHcHNSQnQ0VllrUlNwUHh6bEJqVGhGbnVtbVF6VCtw?=
 =?utf-8?B?clJzOFZnd1BHNW41MFdoQ1RialRrQStnNm0yejBrZENxSFNaWkpWNktaQU1E?=
 =?utf-8?B?ZzVMSmVZRjlNTmt4WDNUTzJ4VkE0YWtNR1N6TGJVcVBsOUx3MzhVdHRRT1Fk?=
 =?utf-8?B?ZE9ua05hVXp4Ny9mVmJVYXN4S3U5UVJCWlRvV3BDRkJkVVdVejNzdTBhWmdu?=
 =?utf-8?B?OFFMZTUwSGdXdFhha0RvTWlPeXN1UHpwU0hVNHpYS3g3QUtSdkdpL2ZGY0Y0?=
 =?utf-8?B?K0dSU3g1UytCSXhVSmg5Qyt5OTNLNytIN1JjWVhiM1ZKZ3Axa3VpN2lhcUs5?=
 =?utf-8?B?c0xFcXB1WTdNRzc2TFFDN3krQzJ4YmY3d1JEbXl6ZndCelpaci9Ic2ZqcTEz?=
 =?utf-8?B?a01tMlZ2RFU0enU4Wk1yN3h4NjY4a0lkSVN6Sm5aQ293USsvWStDaDRXa0pR?=
 =?utf-8?B?em1CVzQ4S3dsQTNhWks5dm5nM1hhTnl2WjVGNTNVamhsckI3Z256OTJxNDBz?=
 =?utf-8?B?dEFuNTg5TXZ0dHhlbHRpTEFyUTlwUDdyY3N1VWhlem1lT0creU5VUnVoVG4y?=
 =?utf-8?B?YVFmTUYzMlNpdEl0L3liYVI3OWpQQ3pZOGFuaTRLeXNHa1lpbU4wOHViZHZG?=
 =?utf-8?B?OU1hVGhkTDJVMjVYblJTSW9WVmN3Y0xJeEFaclN0ZUF2dGJoMG5yellCRXhr?=
 =?utf-8?B?TGFHeEtyYTZuaExvajVIMmROMUpYWkR4UjZEaUY2NW1HejNBRXk5eFhWQlAr?=
 =?utf-8?B?THY5MlpuMzNIWHREN2RMQVMvblU0TWNFSXZ3T0JxS2pqdU5lN2lkdy9sV1Vt?=
 =?utf-8?B?UjBLZWxzY1dLcjZBK3psN05ITlgrR1Y4NXk3NVM1dHFxZE5uSFB4aTFkTkVK?=
 =?utf-8?B?bU5JR2t3Ung2aXVvR2ZTRG1RNmd5bnhlYVJWMlI3RjUvYkk0TnkrQXdWWDVa?=
 =?utf-8?B?dVBVbmcxaEZ4TCtvV1FjL3VTZUF2S3JlL0U0OE1IemRqR1VJdy9BUkw3WlBu?=
 =?utf-8?B?bTBOYmRaeGc4T2tHcmNnOTN0eEQ1azhJaWtSWHNXbXIxbDdmVGZ0ZnhjenIz?=
 =?utf-8?B?ekE2dktITjVZQnhCZjN4NEpZY3VvWEtuU2JhTVZtcGdzc2VoVGJTTytNalBy?=
 =?utf-8?B?TUNoZEtnbGVZOEQ2bnNhNzVOSTRPcTJmOWtNK1U5MmNreHRWUFk5RFlDTkpn?=
 =?utf-8?B?SStvTjlYTW01eDNpM2dmSG9iY2pPSkhPWkUrd3VhUkJRUFNQdTNOSXRETU5K?=
 =?utf-8?B?OVhiRlBJY3A3cVRFa21mRWd0eTNPd1d1S2lIcmJjMVhXT3VZTWszY1dZYlhn?=
 =?utf-8?B?U25tZndqdHBRM1ZHRklweTZ5YmNyN2Y0OGhReXVxVjQzNTNNa25NTG1lM3lT?=
 =?utf-8?B?Q2RqdVhzejhiZ0RxUm5TbThGNTByVmkyRjh5UksvSjRHSjJmUmU5T0JHT0dN?=
 =?utf-8?B?eW5iM0t6VzZ0NENYeU12clU4aFhldUlINGlzeWR1cmJrSFpsOHNUQjVSZStX?=
 =?utf-8?B?QVVkc240Z09sV1RXOTNCMVdrR3JRZ1BGcm9Md1c5SDhDREZleVdkV2dnWmJv?=
 =?utf-8?B?aVJ3cG1FWTVpdUF3MFlTSnM5UExJUCtjNUl3LzRqVFkreGp5Qll5Nit4TGFj?=
 =?utf-8?B?cC9YdEVMa0c4dWpieHN4NDU3MzlZTGZNUEhRY2Y0M0xnaTZndWtTb3BHSExJ?=
 =?utf-8?B?b203K0lQa0ZyNWNET2tac1ZFTlJZM2M1YmlUcmErRjJsZ3pLUkdiTmFFcVlQ?=
 =?utf-8?B?OHU2VmphMDdSSVhnbVdjZEtFeGw0Mk1uWS80UVNHZDZiREdJZjV4OXhRZWNZ?=
 =?utf-8?B?ZTRIQXljZFF4MlZOeUVwSUU4T2IvOWwrUlRCK2thREFsZjdkZnUxY3dOZ3Jm?=
 =?utf-8?B?ckpENnc4eEhIMnliTnExY1hqQ045bDBrcC9jWGhRTVNBRTd0SDZkbkFITEZU?=
 =?utf-8?B?dUJIMXovOXVpSjdlVEI0NjQ1eWxjVW0xaUFJdXhEdXRwRUs1aHhJNS9UN0sy?=
 =?utf-8?B?bWNEaXlwNDZwb3pZd3V2M0c1QkdjZGEzandrd1ZFOEFIVFJNSzB2UUlPYWhn?=
 =?utf-8?Q?acDO/PydyoWOISOFkum/iM26l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8393aa9-1773-47a4-af12-08dd642a7d4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 01:33:01.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmMyYuGujIi9N9LbRn9hHpWsVpMShlwjvS02jMcb6gkjmHL6Vd8KwC9rF8+DMVDjhQygk1VlRp1h0dlZ7aM/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964

On Sat, Mar 15, 2025 at 03:15:45PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │             ┌────────►
>   │           ┌──────────┐      │             │  ││dynamically
>   │           │          │ Outbound Transfer  │  ││allocated
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ───────┘  ││PCI Addr
>   ││     │    │  Fabric  │Bus   │                ││
>   ││ CPU ├───►│          │Addr  │                ││
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
>
>   bus@5f000000 {
>           compatible = "simple-bus";
>           ranges = <0x80000000 0x0 0x70000000 0x10000000>;
>
>           pcie-ep@5f010000 {
>                   reg = <0x80000000 0x10000000>;
>                   reg-names ="addr_space";
>                   ...
>           };
>           ...
>   };
>
> In the diagram above, CPU writes data to outbound window address
> 0x7000_0000, and the bus fabric maps it to 0x8000_0000. The ATU uses
> bus address 0x8000_0000 as input address and maps to some PCI address
> dynamically allocated by a PCI device driver on the host side.
>
> The pcie-ep@5f010000 'reg[addr_space]' is the parent bus address of the
> PCIe controller input, including the ATU.

how about

The pcie-ep@5f010000 'reg[addr_space]' is the parent bus address, which is
input of PCIe controller including the ATU.

Frank

>
> Set parent_bus_offset, the offset from the CPU address to the PCIe
> controller input address using dw_pcie_init_parent_bus_offset().  The
> parent_bus_offset is not used yet, so no functional change intended.
>
> Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-7-01d2313502ab@nxp.com
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> [bhelgaas: commit log]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2db834345ec2..bb87d0c5c665 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -904,6 +904,13 @@ static int dw_pcie_ep_get_resources(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>
> +	/*
> +	 * artpec6_pcie_cpu_addr_fixup() uses ep->phys_base, so call
> +	 * dw_pcie_parent_bus_offset() after setting ep->phys_base.
> +	 */
> +	pci->parent_bus_offset = dw_pcie_parent_bus_offset(pci, "addr_space",
> +							   ep->phys_base);
> +
>  	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
>  	if (ret < 0)
>  		epc->max_functions = 1;
> --
> 2.34.1
>

