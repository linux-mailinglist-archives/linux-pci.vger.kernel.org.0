Return-Path: <linux-pci+bounces-42169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A209CC8C19A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 22:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B78034E70A1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5B3191CE;
	Wed, 26 Nov 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VyOSuTcs"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E62DC35C;
	Wed, 26 Nov 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193682; cv=fail; b=ZqFckyeL02QpmMMmxdrsVcIkV0UfprdXJ5QxlUxQIA006TcMozaO9qRnrun7Ni/5saghJt6kr2ka2mBbltsqKM5YXaj7AFThO0/kcTI07g1TnodtFNpSj4iB9iy3tR3OVfGHH9VoL6Yij6vkHH5TXqMriUos4bnwEntyDhRZTHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193682; c=relaxed/simple;
	bh=sV18528zow6CGtHtIDjlab9YC2jvUUGu16Te0hBsmJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AItUtKq70ZR7GotW/0gvQWyR9rCTH4SPnGO4jzJ2H5znHTAX/mpbPiyHkaq3+27TsmfF4OiltwgoCpm5tsZhcwrtstOCBmjD7zzaGjZGCBEJeO89aSwlgRDRnPPdmWK7fZJ3TD50c+a7b4h2YdlNOQKniKrs2l8bcryB8AQpYwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VyOSuTcs; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqekUDRLQItD54Kiy3Tk4ngrIT3EFTrlmKKKm9w8/rp9iJ3MH2KZ6+cHjD8zLW4YkPMTtd1IlPAyvfq6rBW+5edmMWZFNTW3bcWdfyUCwjfSlZoNbgCCVVR9fXadOQ9A/ZTSwXHjmBjSHsBwMfgj8/DaSBIFqY1+GKB0GP5k+jUvmyfHVUKohCVrFDFTGSV10KAQ6W8MYbOSmMDrW4vz15pZxcwAjXN6OKEX9HBkHInmyshQHb9Nq0bzVljPIYXuuV9jfi7QDCD6BLZnGQCoh4E/Z1bUZYLMQcYp+SZr4e7xiV/ypfD4mcxj7a9sEd1C0b5o7mkZ7/sogiXLZ7nBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVNKIOKeTN7/hB2w5rc6RmCryMZqzbLDcAKInknUZP4=;
 b=tb9ljaFLG0N7oDhYpX3dUcuIAeejwDlzqRoWrJXLpizBuvLvJJpIoHmHwkQcMZ7EQVwzuRKmLHrnOWka++Ifs8w3TiL2yqNhYleh8dR0U1W5DuLggE8SKy7+fd2SNt+e3x7yobcCvXpTO428ziI2x9gu9W6mh+zKEablsbnB9ujX3Enej6FyRIt/5fsNnAoE+MOLkCr3OPJxcLZawxRY2zkTDy2kY7zuZziLWx/5lN2fAGN35T63FTpH3rkMbU9AadKTWqH4kV1Dla5jQX+IeDYTJ//U46Eyqqb7nK1OXE/T82DyqLhdAsNZPcLUZM44Ct2EmxjopTGrhdHRWpOJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVNKIOKeTN7/hB2w5rc6RmCryMZqzbLDcAKInknUZP4=;
 b=VyOSuTcsD5UzndcWDkXLOGoXpIlvv1QIOqmTSMJSrj1sUjZ53wDUrI48Ykhu9sA+RDlBFWlmsH4HBi8thVNg1WOkGhzTqfkOan6VIcR14tOu32/i1Rc/pWO9OBZJgV1jjHzuPQjKnTnMIDmPB7A7NgQgIc3T06ntQgei8FUCSiwJfES+56ZrP3RwDLg1aN9d8U7HSEnu5tFGt/+Bn2DsWGo8FzdVxc7K9tMwhZOmoQgU6rvkcBeW8d7w0EdAoKRwhGIKPJByjDbTxmMH1co1jUsk8vBWw4j0zodWyrT5CufZDvKOddrJzmRtt9S7ImnZS9Amu2VuOgTm9JevKmWCeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 21:47:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9366.012; Wed, 26 Nov 2025
 21:47:55 +0000
Message-ID: <f8170513-e08a-46ff-9fb2-310f3e9c1ba4@oss.nxp.com>
Date: Wed, 26 Nov 2025 15:47:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
 jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
 ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, cassel@kernel.org
References: <20251126214131.GA2852425@bhelgaas>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20251126214131.GA2852425@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:510:e::30) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebb7e18-27db-4b89-a546-08de2d3574f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y255TWVQWEVvdE5GNnZjSUlmNnRxd3AvQnlOK1NuVUxyZEtYY0lkR2h6amo4?=
 =?utf-8?B?aDU3OEZ3L1QrNVhlL1YrVlNES0xvc2RIcFpFRzlVQVcyRWkvdTFEeTN3V2dT?=
 =?utf-8?B?aHBHU3dDNUk0VlRERERLWHJEWE9vQjI1Ni9EekJRZnpJbEMxRmVNd1JWMnc5?=
 =?utf-8?B?YnJpUE91OVo1dGVJU2FyT3I4ZUl2cGtHQ25ZZnRmQlBXWTJ3bFVGZHpSYkIy?=
 =?utf-8?B?a0lHTVFYM1E5N2ZETDJwVXNEc3dTeStBMk9WcUQrTHlQbGFZbDVuZE90NzBn?=
 =?utf-8?B?eHhlNUlHWGFVRTNJbmovV3Bnczh3TkhidGdFNTBUNVI5MEhEUGdpYmZhT0Va?=
 =?utf-8?B?eTdleFZlS2oxRkpiWEQ4K0RPcHVZSUMvZUNJeWhaVmZVb0Q0UDVFMWVSV1Bn?=
 =?utf-8?B?QzdFRDBlandFTjdXa29RdmJzeEVCSzVOYjA1bU5ZRTAxRWxzYWhWbGkxRFU2?=
 =?utf-8?B?QTlTMWU0SlJydTNaaU9majdTdTJhSEdOS2tYU044N3UwWll1VzdyaGlVSHor?=
 =?utf-8?B?SVVyWHlVQjVEMTlBaFBpUXpwM3pYNWFUWmQ1dDM3SU9wbkZXV1VKMC9ZYStY?=
 =?utf-8?B?NUJKM2p0NVFpaTFTajh0dDVaZFZSNHhBb1F1ZTFJaWNjMXdhdU1VeXRmcjNK?=
 =?utf-8?B?aitDTVRESlNSM2w1ZkF5Vmx6TlJpYzJHajc3RmtxNnU1WGhIWG5GWHpXOFRX?=
 =?utf-8?B?UUZpYjBRUUdMV3lvZGxFQVkrL1dtZG1jWkVXOFkvZVUwQUFvVHZWaEFKZHZJ?=
 =?utf-8?B?UTN3UGk1UXdsVmNPRVI5VndxWGpoQ1A0Sk9kZkdPQTZQWXNiamFuUkN3ME1X?=
 =?utf-8?B?bHA1Nk40TkxJd3cwYWltQWJPUTdkU29DUUdsK2M2VFBhK2pwdk9TWnlSaGFy?=
 =?utf-8?B?Nlh3TGMvNzN6Wm1ybUlSSFprV2Q2V1NaNkFybml3VjB0S0lYaDB1WitNL205?=
 =?utf-8?B?WmxVcnJFMWozR1lyTkZic0ZOK2RCcHozOGpNVVpZNXJJdDJncWRXZEVlSDVK?=
 =?utf-8?B?N2xJeGJyTnA1ZFg3azdZTVN4ZkQ5d2Jsa2RJL2NtM3JxSFR6empTanZZUVpM?=
 =?utf-8?B?dkZpcVV2Mnd5NGNrSWJQNjBya0NTTis5cWFQbTJ5NWxRUW1SMzI2WUl6YURz?=
 =?utf-8?B?a294N1R2c3gzbEJuelpuZWIrVXRJdEk5OWhZMDk0WlM1WHNHem1YM1RVZ21q?=
 =?utf-8?B?WmxFZ0NwaXVqWVdtTWpvbEk1UjJNb1FNeU5aOXhlOVJlZElLdTRiUzhtTnJo?=
 =?utf-8?B?QlA5RldqbWE3aHVxUmNJcjNLN3d1UXc2NnluNDRyUzMrNmdFdGVQMXhZMm5P?=
 =?utf-8?B?MUdCdXRaMUxLc3hnS1BaSkVoQituM1h4b3FKRE8vWnRoR3JSRUw1YmM0Syt6?=
 =?utf-8?B?b2xtT1hCR3I2VDZ6Z0MyR3JjL09XVktNMG9OdHVnMFI4cGJuZm1iQjMzYWsv?=
 =?utf-8?B?Vnp2N29jOEpuQmdmVlVNTGZhNGpRYU0vRnQycXpOSzA1aWlHNWlYb0EwcWVr?=
 =?utf-8?B?dTFrUmlCV0tWQlNmUXZoQVp0UEFyNllRV2RUUjNVT0o5MW15ejJiOTl1U0lX?=
 =?utf-8?B?Yk9IcVl5MkQwSURQeFlwbVkrcFBIK082a0Z2Znd6WnNoRHI3VnZMUDdabHdr?=
 =?utf-8?B?OHpadkpDaUZDbzk0cVlvQU5XR0xmM0FvSVJMWWxPT3ZIVXcwMWJaZ2p6ZDNr?=
 =?utf-8?B?bFduZ21MdW9GcUpRa3FReWp0UDZmNFFxeGEwTm5mcjExR2M0VEMxdFBwRkFH?=
 =?utf-8?B?WnZVVmdyS2d5anVUWFJDU2dDZFE0QWppTVBicHE3Zm96MFBiWWo4VW9sb3lh?=
 =?utf-8?B?TE9STWd4OEVuYU1lUkR3bEg5SDc2RlFlT1VJNjJFUGdTcGxYUnFqbU1ZWmFr?=
 =?utf-8?B?Uy9BdDUvN2hjdmZmOEM5M3RuV1VlNFBxNXpBWmY5RTMyVGhGT0Q2NEZnTkVD?=
 =?utf-8?B?RU16dmtxanZhNnpMdVgxaWlBSTNEaTNiTWpXcVRoR3d4WWFoZGlnaG1lSzBn?=
 =?utf-8?B?SFJJMlRCYWxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDdBOS9FYXNnVDF5RGlZSXZlMFFKcEIxTlI2R2VzWmdCbEc4Y09XcEVjNjFo?=
 =?utf-8?B?MktFZHd1M0dtMkt1Uzg2Ymt5NnJMVXMwcjR3cUR0enJYcXNRR2ZicGNhRTdB?=
 =?utf-8?B?SGs0ZVZyc1hGVXpoVVBaR3pLTHhpYnpPMTNzQVhrUlRKemdKbFQzQ1FkVkNt?=
 =?utf-8?B?MFRCY0dVWWJ6K2xnaDR4NWhjQnB5dVVLZWpYRll4ZjRrcE5KNHU2cjVUTkl6?=
 =?utf-8?B?Z0Z2ZTRJSUpUUFZXNHAyWDhvU05BSjFsbThZZlRFYWRDbVNxancrbWVvMUla?=
 =?utf-8?B?NHN3OTNHRWY1MUUyMzZFbEtTS1VkNlBmU1hYd2RsVEJ3MndNa2ZQOHgzb25j?=
 =?utf-8?B?cm9TMzk2QnlPRmZHUTk1cDRoRS9kMnV5bW5iZmFURGxsb2NSN21YUjB3Wkd1?=
 =?utf-8?B?bHRlM1pCME56ejFJVG40ZU5BSWVXVE1OVzJZU1UxS3F5L3UxUFZYcXA0a3JO?=
 =?utf-8?B?LzdxQ1VmWkx6K0FzQXhmSWo4YmExbVR4d1E3aXVzZy9iNGFGY010RWUxNk1W?=
 =?utf-8?B?d2FrNTdEVWpEQks2TzZXaVptTmNGZy9ZLzJ4dFNaNG5HdEF2bUtFVmMwYlZW?=
 =?utf-8?B?c2EranpIVUw1MkNwOFdKK3VoRllRTHAwUEZpcGQ1NnFnZU01Rm0yZzBrUWtj?=
 =?utf-8?B?WXdSRFZNWDhyeEtEM2cxaXJtZkZ3SmxQbVBZcFR4VEdTWGZhZU13TVZqS0Z2?=
 =?utf-8?B?UVZuS2lOOTUwaGRKU3ZyV0FVbnJla2lOeHhPVTByUDNuc3A5MGhWYklEemdR?=
 =?utf-8?B?UEp2YzRzZmdoVXUvMlYxWHpBNkcwOERWaGdLbmJ2R3ZBai84dm9FV1Zrek53?=
 =?utf-8?B?b0M2alNnUVJlbHR5bUplZDBvUnExd0hmeHh2c2NmOUd2V1ZIbUJzODZ6TndF?=
 =?utf-8?B?UWduRGlieG54ZFQ5L1Naakk5RjZNVnZFZFRLeDF1VDhrb1dSOVR1QVNjZC8w?=
 =?utf-8?B?OWw3MW9vYjgxVFZPbUpCSHV2SGZDdU9WcE9OSkowSGZnMVZLYllxR1M5dzd5?=
 =?utf-8?B?VXh3MklqT0MvOWdYUWtoUUI3UUgyWkMxbktzc0s0U3lxM0x6Z2ovcnVZdDEy?=
 =?utf-8?B?ZUdjVmJqc08zMktzVk9vYnVBQjJHMTNKd21ISUtRaHNaOHZzcTRsMVdpeS9D?=
 =?utf-8?B?ZWVLVWF4UkdmbU1VYlQ0N2hRckFPcmFaWXhSMTRVYmxlWTdhVU1Pb1lBZUZq?=
 =?utf-8?B?dXhTUGIwNHI5dXNUalNPWkNXbDY1ZnNvRzlwSTNBSzdzRE8rZnZnK2swaVZ1?=
 =?utf-8?B?bmEreEJpRmgvL3ZsNHcyS29tVSt4cGk2OVBtOEVKZkRXTjcxeTBZUlk4aG5z?=
 =?utf-8?B?ZXVyb1pHbWZ1YjQyYzRHTWpFUDlIU21DejV6S1Vrb2gxa1NsVFFOMTFJK01U?=
 =?utf-8?B?aXpxRDRIYVNSYXhmZy9PYVlicnM0SzJnQ1NsUk5KeENTMXZadmRXZThLR3B2?=
 =?utf-8?B?dHZ1RXZlTVFObk1hVjFoYnRTd3dJbWNFREtvMGdBUFRqT3NpSFRkeVA2ejdB?=
 =?utf-8?B?ZEhvRXBZV2lERk51elpOeTUxRVgrRDlZVmdjKzFPb3FIVkRjQUI0MStVTStN?=
 =?utf-8?B?MW9YM3pYelpDYXZENG5NbHNKSDF6MFhOTGlna0ErWkVHR0lxR09YdjZwemlw?=
 =?utf-8?B?VnRkR0UxVlpRVnJDaW5KVWdXb0FHT25zenJRa1REb2JhU0gvTGRWL0dEQ3lp?=
 =?utf-8?B?T1pLc2JMOFEyVlo0b01VT0NwWExvcGhBZkFEalpFK1Z4blBkY3pZdityWUZk?=
 =?utf-8?B?a3I5VFVCOUJaMWtTKzJWVW0yY0tIRUFMb0t6M3dIZmRTcnNpcFI0Qzk4dWh4?=
 =?utf-8?B?OVpPSktWUHpQeHpkT0hib3FIdzd3U2Rnd2VieTdsbGd0ZnRCdGhQOEp0dm1E?=
 =?utf-8?B?YUdNT1RCa1d5SEJ5NmtDS3IvUE9OWG1tUWpYeGRLRkJjQksyRXFSd25WYWls?=
 =?utf-8?B?YlhpL0xIWGJNM3g5UVR6Q0VYS0ZoZS9CbTFOWWcwMmFaT2JjOEZFTjBoNlNR?=
 =?utf-8?B?M1h0MVZ1L1pWQkJxcE54M2U1QU5OSmxIUmdvTFF1RU1UNm9DUVc3cWdIVlZH?=
 =?utf-8?B?MzdyM0g2dFlTWjJWbDZzZllLN2hYR2tlSGsxWWJMNkkwdGFGbkxLS3VSb25R?=
 =?utf-8?B?TENVUDEwWVVUSjF0K29xeFBLVXA0TS9FMllObDhBcXJOcVltVVVQWkFZWkZV?=
 =?utf-8?Q?vvlNySgIYZbO5lC7crRsTP0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebb7e18-27db-4b89-a546-08de2d3574f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 21:47:55.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEipxC9yE941vYEzUqW/2dLCPBwLcAjTq77CFmJ1rBCnzsy6hnP7uY22YYY/J9EjWt5YDUTQEZeQ3MPe8M+cZnhzftpPUXkKgNpJ75X/hsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885

On 11/26/2025 3:41 PM, Bjorn Helgaas wrote:
> [+cc Ciprian @oss.nxp.com, see email addr question below]
> 
> On Fri, Nov 21, 2025 at 05:49:20PM +0100, Vincent Guittot wrote:
>> Add a new entry for S32G PCIe driver.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e64b94e6b5a9..bec5d5792a5f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
>>   F:	drivers/pinctrl/nxp/
>>   F:	drivers/rtc/rtc-s32g.c
>>   
>> +ARM/NXP S32G PCIE CONTROLLER DRIVER
>> +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> 
> I'd be happy to change to
> Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> per https://lore.kernel.org/r/f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com
> 
> I notice that most nxp.com addresses in MAINTAINERS use "@nxp.com"
> addresses, not "@oss.nxp.com".
> 
> Let me know your preference.
> 
> Bjorn

Hello Bjorn,

I prefer "@oss.nxp.com".

Thanks,
Ciprian

