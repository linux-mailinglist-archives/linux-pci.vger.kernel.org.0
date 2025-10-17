Return-Path: <linux-pci+bounces-38515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D5BEBA5B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 22:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C895744E4D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFCD33343C;
	Fri, 17 Oct 2025 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iG3E0UlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910D266B64;
	Fri, 17 Oct 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732670; cv=fail; b=et4dBN9dd9UBrr9BK/ogszrF79yGtWTTQllmruVHnB0bSXtpVe8YoY+CTaGaFs/0xsrZnqsNIalcMkxduZubgRX4j6OS5FJVGPDcV2Ms+Mjw5RLpsc7PtfoA420HfTEX06XxaNiGkT9VWq25D0/9hLO96p1uh+iDXerPeDaBsaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732670; c=relaxed/simple;
	bh=VnWlnXzZn+dkpuqHM3a7J7vFM/KikcaZi6jTsuzR7w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gqpiKnW+ZYU1pcu0n5irjwFwAiaD+L/0UBRbcDgTwOOlh17XyVJxmcP/K7II5aiFsj9ULOH4xrgVWPXekKd/tnB2z4x4EdI3dRTkX3+p5Pr76OuJmXpl7ECxrNJS8Fa/m2OaSAQs0nm/HOOhxHYaimZAoP1AINiIbVOBPgomSgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iG3E0UlS; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV9muspOxa1BI3Pv8/5ul1FRPoptzaDZ2d/d5srwB0bziFvdfxTyuM1XZYJ8Ritl3jhKCPzhedI3XA8sEbZU/Z98uFqAqVchZ0QO5TkmzsA5Gk4Fa7qABQZUhlv2v8IGUgSEX3KsJ7tTzYCTJ6J95Cg7bfzHwEERFra2XaRMTZj0/4b1X4vT8gIYm7c/9q5KHgrn18FX38bh57u/ChDrQChd4k2TPIg8pCn7eFjeu/syX/cWxaVELfAu79mQU5yn4IOaCBRIRtisUOh51XtnQOCpmZ7NqToYSdNwC4OIlweQ/8mrHK5v2EN1gOtdhMtjObDAi08PKN4ocqmMRJ0mHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc03PpQLEzZSRPUenXzCgLo3wJO602ec7/VvvigJMlY=;
 b=oKB8OJYOxYG4NNSTd1t5qV22bAf90PpW27KokTCTVxME47aQudtWP5jMjBNT+dPdYPru9Q28GokngbCdVSWr3FR5qEEz7CXUr8nG77blNg+IkF7F7yynJ0iN2IX1MimDO1DqQlh7lWAIkBandGTe4j1Lzokg4v9pa9bt3bXCz4Z8cgItPqTCcXPXhdM6lJKLWDwOYrXNzWM+fqf/S+Q/Uox92fzWKU7U+dcu1wUJWBiK9W+6BJKFm4Hes3SBwFd1f1LQjo136YdaOAEulOvtJGJwq0Z4iQrRIiVozup7J4NTBqxoCGArRt5XzZH2q72ckkBGrC5M+KMGvwSnDDgf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc03PpQLEzZSRPUenXzCgLo3wJO602ec7/VvvigJMlY=;
 b=iG3E0UlSKR9Y+l9UiIJUvzZJcQe4d3fCkKhN682Mk0DgCEOL+X0UVItvoL0P9XBxhLkUXhk+AJ8PxWMZZn4WH/92sliJ/KQVM/FPMTpEXhCcda8tsFOrFff8VwpVLmFlJrScpzDKtIIHl9wxvaaXqRve7mJ8IoV2cebEwfvFhmb7TXMBnFcbukBJofi2LZRKmopBnTuqHtDO+YipKR0T1vjzP5uTIZSu0krmw/CYFOxI2gA9fhVV3VxboCZuGp1KyLhBLj4pzo2CKRgFlATQ1lRXQo1hk/p69O81O7VI7xQ25h7RRRyIN4l9lZat8MaFELJZxZHyo00GyQ5zIrxPEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB8017.eurprd04.prod.outlook.com (2603:10a6:20b:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:24:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 20:24:21 +0000
Date: Fri, 17 Oct 2025 16:24:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
Message-ID: <aPKl73UFUnIo2AxT@lizhi-Precision-Tower-5810>
References: <20251017084752.1590264-1-lpieralisi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017084752.1590264-1-lpieralisi@kernel.org>
X-ClientProxiedBy: CH0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:610:119::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e333e5-977a-4d43-9873-08de0dbb27f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|7416014|1800799024|7053199007|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXJVV1pSaCt4STRsM2VsbU5QaWhJNVRiTDQyRkpCbGhraWxudkgvMkxqTDRt?=
 =?utf-8?B?SUVBdHI3WUVjL25sYW1ib20rbThjQ1NJOU5UWGJEODB1TENNTmEzYmRnUDVE?=
 =?utf-8?B?SzVnb0gzNnRyRHZ3WWY4TUV3alJ6Wk1LcVBHSnl4ekV4UlQwTUFHYkRpVnJH?=
 =?utf-8?B?V1B4aEVqT241d2dlVENGK0J0Wm5tT0N2NEEwRnVzTXRqNUNtRFJoaGc0ai94?=
 =?utf-8?B?SloySWRkaGJYRWtuT09KN3d4RG9jTlYrZVZsWnBlaDVzK3Vtdzd0T0tTdEJX?=
 =?utf-8?B?L3lURnQrekxwOGFEYnBmejBYaGJXTUx5WC9UdkhYVUI5Q0svNk1jeVk1aFNx?=
 =?utf-8?B?eVI4V0tKK1J1ZE80MmZpTXNROGdCeW9nMHJ3UHFsYlpnRW85TXd5SGgxejRH?=
 =?utf-8?B?N1E0d2UzQ0lRMTdRZEo2c0xPWEhGUkpNSHkxWG82L0NObXdWZjRRajcrL1pM?=
 =?utf-8?B?TGhFUFNmOE1LQUlLTnlpWEUvSXZhZXZNWkpSeUJEeHlwTXViN0FSNE0vWXZG?=
 =?utf-8?B?NzNlNzdhL295YU84Z0xZU0NMUFF2d085Q20zODRiNElrckdFd0ZzTHVocGti?=
 =?utf-8?B?eDQ5UC9ZLzNDc29yWVJ5MFpOaUdsZkk3UXdWQjg2US8xMUxTU2hiTysvZGlo?=
 =?utf-8?B?b3pjcjExamdtNVFOVlRxeE5JU01LclY4ZHphRDZLOEhXQ20zanpHeTRJNDBk?=
 =?utf-8?B?QmVwUzhwcGZKWTFuY0FMSzJXK3VCWXIzWWJxQnl6Q3J0QXhxMHEwenFVenBC?=
 =?utf-8?B?Z0tBTkk5RnNnbFZCNkdUZi9ITDlWU2tpMVhWSk53b3kxMzhld1FZblYwYUZp?=
 =?utf-8?B?ODNHWEgvUFk1Z0dtbjhFVC9sRU1OYlVUdkRNeGdNTWUrNktkSks2KzE1M3lH?=
 =?utf-8?B?QnNFUEUrVytDdU5VeVhjTnRXUFVFRmVoellGWitESUhZcmk5RVc1djNzaWg1?=
 =?utf-8?B?dVY4YjA1Y1dreXNJZFFPckNqdjBTY1h4c1hlWmVQR1FaYlhncjFRc2Z1dEh4?=
 =?utf-8?B?UldnY20zVEhaOE1JRThOeDNIekVVbnJTOUo0S2FzRXdWRkZvWGVHNm9Rdm5F?=
 =?utf-8?B?VjBDVXJpTGtQVEVjV2pocUhYZldsYloxZHFPMDhhU3draURscGFwS1hjSFkx?=
 =?utf-8?B?TFUvREdlekdWdEwwWEdVQmNRQ0U1UjdpM0ExN3Z5MnRmcWhsbjdTQ3haRGYv?=
 =?utf-8?B?TytoNmU1K3VNdnB2R2prdkVUZTh1a1ZIdEJFSEFKZ3NnbEVOQ2p5R3JGY3VQ?=
 =?utf-8?B?SWVZYW5mMjI0MFhqYnFEZWxhMEN5UHhIUE1RTjVTYjhLYXE0RTVTSXY0Y2RV?=
 =?utf-8?B?dzdGNHRVWXJ3dytkZ0RrNmFxbUFndTg2MlBBYktHMUhZc1F6SDRtdXZxdmFy?=
 =?utf-8?B?L0FkdmVLMzBXc0JieEo0THZZOHJPRzBFUDVGUlRPMERlQmpHTWtxRGRxSUY2?=
 =?utf-8?B?Z2NGTkVGV24zN2FQYW9Vdkd3M003SGxWaUx2RFBCVzZac20zQVRYMWVRUVQv?=
 =?utf-8?B?OTZaRkRTUGpSZy8wWVJFUTNlNmt6U0JqbG1DMGpwV0tjQStZd3ZRN21oU200?=
 =?utf-8?B?K0I0QWV5a1dEc1FYV3IraXlOai9IQ2V0U3U0ZUE1eHJjWVYxUzFnTENLODF3?=
 =?utf-8?B?WC85R3FzMW90TmVwdVdtaTRqMDEvdFNVaUxRK2hiN0ZVSWJobXJ4YkhZa2tP?=
 =?utf-8?B?WDFreGZRVGNRTnpMMmpva3FmVWJacVdXd2dod3NYOW16SndqTTVvY1RsYThZ?=
 =?utf-8?B?b0tML05ZY2JoTXpPRHI2eGNUbmlaN0Q3Z3MvbWZPSGtwRzNaVTZoTTR0TzZC?=
 =?utf-8?B?OHN0K0ZIaFk0djZXSXphNURJcDNCOXgzVjhuWFRoaUNCTmd4RVRGZ2cyQ2tm?=
 =?utf-8?B?MitBRmxFSUhsaHUrR3VtV2xZUVN1c3lLdXh5U2FFU0U1UW5uYlRFYW1teXZv?=
 =?utf-8?B?WUVLWE4vMXF3bWI1RFJ2ZnV4YXZnUmVRejZQV1owWVFZUXE0ZUpJYk91YVAw?=
 =?utf-8?B?eFkyaCtJaUQ5UEtTZlloM2JPNWdBdVI2cEJFbEVORjhGODhlS21kV2NKY3BK?=
 =?utf-8?Q?eB/b1h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(7416014)(1800799024)(7053199007)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azZOTVpwNHM1MXFDaWkxbS81aXhHVHpzdFdVUEhQUmM4eEZ4cjhmK2pYd2F5?=
 =?utf-8?B?amlFYzZBQVV6Y3V1NnBieUtsajNzeG96SW02UkZpYUtxbHM1OE9zTXR1aDdU?=
 =?utf-8?B?MkhKMm5YZmd6V3NqTGUxcEZGOU9BWHpFd0VqeE90NHVHY285eVJKeERsdzNM?=
 =?utf-8?B?Q3RLd0JxeUhYb0x4eWorVm1CdXpVTmpXL3AyWkwxUDhjQXZTTDFPRWNybnVO?=
 =?utf-8?B?WWFDTTJZcTN4QitTUXJnMlpGeEFjWkg4S0k1Nk5GRGtIUnQ1K1UzaUE2anFH?=
 =?utf-8?B?a2VNbVJMeG9xVjhnQXpoWTNzcnZsWG1keVd5aXhpL3BNNDFCaGs1UHpLV2NR?=
 =?utf-8?B?NVdXQ1NDc2VmTzB3dHJFOGxWekVKVGd4QWJGUnZUU2t3TWNqb0xxK1FLWDVX?=
 =?utf-8?B?WlNBdVBXWWlJeFZuaFNQbEJaalVGMjZkUXNva2NqSGhubWM5Z1JZbmhRd25Z?=
 =?utf-8?B?QUtFazlGeU13QXJNalBRT21rTHdsdFp2UWVxbmdsa1lDZFc1QWxtSC9MMWN3?=
 =?utf-8?B?dEZKV1B5TEVUVm5rdDVvRXhuOE5aSzdDaENDMmpPWU93bmVrb0F3M0RKMTNq?=
 =?utf-8?B?YWRLaGJwVFpJaGQxN0RRK25FODA4OW9HV3ltenFxVGNYdm4ySGUvNVkwVXUx?=
 =?utf-8?B?QjBvdjhVUXBwUG5MYU42Vkk3bGFITFdwR1MycFViblJLL1BJamhVSmVWNlkw?=
 =?utf-8?B?ckZnMkdVZHNSRlVLemdzc3pXNEpQUlNBQ3MzVGRmU0xzZ0RPbDgxbnRMZXl3?=
 =?utf-8?B?ay9TRHdqMlFpWGFsN3Z5R3RPcWxCMXdXalJPK1ZWM2RWVUs3MWtxbzltcGJt?=
 =?utf-8?B?eWNkcXlyUnNscGw3VU9tdGZDOHVhbG5LdFZXZ3RYcDlOdHkvWk9hUTlEa2VB?=
 =?utf-8?B?WldPOEJYdHB3RHM5MW9LeUt0bFNNUTg2aElsSG5RSUlaUE5ySnZDQzFtTE5T?=
 =?utf-8?B?bGcyS1p1VUdCUjA1SFIxYmJFbVBwYXZLa0ZIN05YQ2tiWEJyUUVKc3E2ZFo4?=
 =?utf-8?B?NXBYci9rVm56OHg3RlVIVm9lMElFN1V5ZnJQR3lsaXBVeU9WeUFXbm9wMC9T?=
 =?utf-8?B?c1FKS2JicEpXRmZlaEdaaGNCV3o2d1BXWFYwUnRoSm5oOE92eHBRdk1UTkcv?=
 =?utf-8?B?ZS9Ca2pWUDhGUndIWEVOanlnTVZCdEp2T3RQSHovVGFLOEUwcXhHMUZrdDVh?=
 =?utf-8?B?ZFNWRlRPaEZtWE5nS2I5V1BiOXAxejBmV1FEeFh1bVYrTVh3S2JRdDRFL1kx?=
 =?utf-8?B?WU1uUHg2SHJEdG1HalJUam5kRzJiRUcvcEd0T0NKNkFPZXp2aVlvS1NZdndz?=
 =?utf-8?B?MHdVcFBKNVdOZjlTaXhOTGY1WmZsR29KeEoyMkIyVjMyVzV4eWpHQlVNM3dK?=
 =?utf-8?B?ZVN0RHpqa0VZek1oMzNOTDVDMGFZMFh3eVF2eUR0RndHNFpoaDVIWnVuT2VS?=
 =?utf-8?B?SXAxSVhJVU1Tdnc2UU5JK0REc1k4OTEzSEpBNVo0WUc2UFhPWU1JWk85Ykcz?=
 =?utf-8?B?elh1ZXV5OE5mMFpOdUFSdWc2WEpIRkh3bVJqL0MzK05LQzFkczBRT3hrLzh5?=
 =?utf-8?B?UC9jYUNranJIM2d5Q0taQmZiOWx6UWdBUUs4S3I3ZFBaWFRHVEpzQ09LOGlX?=
 =?utf-8?B?WEEzbGJCS042em95YjJLeWxtNGFCYmYvOXNkS3NGa2syU1h1ZXQ2eWdiUVc0?=
 =?utf-8?B?czc4ZXphNTJmd0FzT0V2aFFBczVpeHlZTnh6SitPeC9teEQ2OXdIS0wyWEsx?=
 =?utf-8?B?MFA3SGp1U0V3Nit3YXdzUzlmbVpzYXVabGlKVmZ0REpSZG5kZlVGRVdHcnQ2?=
 =?utf-8?B?ZSs2aHJDSlQvRGpPUkJwSDNGQjVCaUFocDRHY3VxSGx0VzUxb09qMlpvb3Ex?=
 =?utf-8?B?aXN5eXdqQXl3V0pZSytXYjBQNEQvYk56cGJjZUxmcGlsRnVIZlA4UTNrQWtm?=
 =?utf-8?B?VzgybGMrUDg2c3hjU05RY0pwN2xQTWdCSE96L3N0Ri9paWNobU1DWmw2Zkgz?=
 =?utf-8?B?M1JORUpHY0hjbHN0djAwNEo5RS9ybEJQc1BVaTFvM0hCOG9tQmNwS1NiT3Jn?=
 =?utf-8?B?VWU2UHc4V1Npd1B3WlNlRXhhMEVLMzRyZCs4MGpoOWdVVkFCU3BkQTV6N0V1?=
 =?utf-8?Q?mHN4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e333e5-977a-4d43-9873-08de0dbb27f0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:24:21.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tX2orY3XuyABxlvUnYyOcwFmV34KS2jBVrNNahwjoDao6y0MLGtEWaErczpS9LdvcNZwvAGwvBXvfyh0zv1kJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8017

On Fri, Oct 17, 2025 at 10:47:47AM +0200, Lorenzo Pieralisi wrote:
> This is series is a follow up to [1] - with additional patches that are
> addressing Rob's feedback (pcie-layerscape-gen4 was removed from the
> kernel, Yay !) and other bits and bobs I noticed while staring at the code.
>
> Patch (1) is a fix and technically we would like to get it in v6.18 please.
>
> Patch (4) is compile-tested only, I can not run it on HW, I do not have it,
> Scott, Ray please test it if you can.
>
> v2 -> v3:
> 	- Added additional patch to export of_msi_xlate()
> 	- Merged Marc's ITS parent diff
> 	- Added trailers, fixed commit logs
>
> v2: https://lore.kernel.org/lkml/20251014095845.1310624-1-lpieralisi@kernel.org/
> v1: https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/
>
> [1] https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/
>
> Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>

I tested epf msi doorbell, no regression. My test cover only using msi-map
code path.

For whole series

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Lorenzo Pieralisi (5):
>   of/irq: Add msi-parent check to of_msi_xlate()
>   of/irq: Fix OF node refcount in of_msi_get_domain()
>   of/irq: Export of_msi_xlate() for module usage
>   PCI: iproc: Implement MSI controller node detection with
>     of_msi_xlate()
>   irqchip/gic-its: Rework platform MSI deviceID detection
>
>  drivers/irqchip/irq-gic-its-msi-parent.c | 91 ++++++------------------
>  drivers/of/irq.c                         | 43 +++++++++--
>  drivers/pci/controller/pcie-iproc.c      | 22 ++----
>  3 files changed, 67 insertions(+), 89 deletions(-)
>
> --
> 2.50.1
>

