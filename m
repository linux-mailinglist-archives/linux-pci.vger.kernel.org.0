Return-Path: <linux-pci+bounces-17364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963C9D9BE1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A2DB2E107
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC01DA0ED;
	Tue, 26 Nov 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AkBBxW/C"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AC1D90A2;
	Tue, 26 Nov 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639581; cv=fail; b=ICpPbDIRrYltd4nXsrA9ZS/9iQ/F+LVk5CR3ypUhvk6M6iBrTVyh4YDGXqWA+PJAqWydydxBTcEPa12baqDFWufrLzK3T78Y2E1CqmGLmuEKLpY3ClZ0gKXXz1hfo9Z1MJlHC4c78PrKF0bW0cXdh1SvfqYMl+QgZH7ujZTzTRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639581; c=relaxed/simple;
	bh=N9SNzGKabgOgnB5SOIgJke5FTD5udBIFGdzwUZ/H6+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=djBEquYFDqmL/6N+j6QmCZ0ngt9DeBQQ7K/9fpRevoisYOhXbBIoPfLh5dkwBqEv4PsYgXWjCZ6Ko+YuBEzrQ7h3Erub9vvfq3nZ5KQrSdQBaNZzWE05tXhIc9MOBL+NHiQAHf4IF2XxiZi7CGlo556NQBcbf9WTKaGLP+TxFDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AkBBxW/C; arc=fail smtp.client-ip=40.107.105.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzVCYa63744BZcZEOzpTtillwujMNcl+2Z1PE2Cm1cJfiiN6tBDnrWuC6cJOrAxUvESghaXl2UEiIAMxR9j33TJ4ztIQ1mbONKy+EWoH6Dow6nwRYD9dQ56TrlA5oOJw6ymdyaV5R2u/zhy7edEA8h24Kq72saDmdQ+C3ra+kJH4xjvRDTmvsOD3znmyUFkWobVT442k0ZRMnkct7XsDJ6gQ/EAxjVLd/fhkpiJccqy0Gdj+ANEJcfRjycBdjQH2V/uJiRum6k1qJMhBzF85tNHE6DbGfNwz3t2z3PJelCqmQmQ0Bi1gwM58iBzVccSPo2x5ilWk13mPapSh+jo+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToF9R6NnNYHKxTW+A3i2bIYtlFPHkaI4vtlxf86dCE8=;
 b=PvSeWPQ9w1dKSr0aoXVC6+TNlFC2z8fi/GQ1gPyGv4YiP2U+35SSe5RjdG+Wbeudo2ueeoeZ5AwKzetu364t7b3+E3SrYw0nyJuetCS4Se9tdkP0DjjmMwi3XqtqCgSnUpaOpHQ3l1n0hBRte1Llc394fGOSfxCHrSMC9YBiQV/ZU6dAsaslblqAA4DmZIK+0/S/L4HT4vFANFEPdSO1wbKGpX2dXw/v2k6rTASV2s0iQf3CQ/6D+dH+jNTNP9A850gMjttWvE8xcK/ml3cWZyLJKl8NvVtfVnm+vthIwm9u66Ku01raLJ/IxDHO7gvusgtxD/g9qe6XmsFqvVxD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToF9R6NnNYHKxTW+A3i2bIYtlFPHkaI4vtlxf86dCE8=;
 b=AkBBxW/C1+VcmcC5qC6HbzInnifsEZ2OHdezYDUyHB3UtlhfIFb4QDBW+/SZVu04KqPSJP/SSHO2ePPwD1cyqAadbeLFRE4O1SIkSD8x/paY5AItILDxktPLUhwbUn0oMzO8y70GqHhav+O/TTc9Dmh/v3TVx8igRpaPsfabItnH2abN5a5E4nq9A+SD8UWzPBvH4FNMk1WG4YKXdJGfSrGP4ayXVM5lewFsQDFWwKD2Lm/YwJybFD//4EO3JtnT4HTEkLYt3RXY2/ZJs0UJbsApwvCfEsuEZVAk8Wt5plQgs5kDFvzI2gjEjgZVYD3v3Sd+7vWtRhoaOrXPHWgvZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9682.eurprd04.prod.outlook.com (2603:10a6:20b:472::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 16:46:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:46:16 +0000
Date: Tue, 26 Nov 2024 11:46:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <Z0X7UE/ZfM6fgL1r@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
 <20241124075645.szue5nzm4gcjspxf@thinkpad>
 <Z0TNMIX4ehaB+mSn@lizhi-Precision-Tower-5810>
 <20241126042523.6qlmhkjfl5kwouth@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126042523.6qlmhkjfl5kwouth@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a1612c-a671-4ec1-db14-08dd0e39d889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFNaZFRtQ3VNL0duaUpUbkhXMmpNdk1seWFOd09XQTZscy9qMWhLWTJyNXpz?=
 =?utf-8?B?SjI2Z1BwVFVtS2hxQ2hsU0FtN2ZOSTVzSlhhZnpOMW55MjdwY0xIaStKUmM3?=
 =?utf-8?B?d0VIdkVpVmFZelhIdm1mTTBRenFZakh0eG8rbFJQOE9KQ2luWFRLSUJOOGt3?=
 =?utf-8?B?dkVKRXdIZk5nWDluYm9GaUdXUXZlUGdURXBjTU1LQ01CRVU5WndVZzVnbTFX?=
 =?utf-8?B?MEkzZVcwV25LTTFONGsrUlgwN1BoLzRYMGJhQy9hdE5VcmFHaWk4NlF3cTRO?=
 =?utf-8?B?ck1lTm5kL2xRK2NMRk1TR2FlM3lxNUNlWEdiSk9mRUFVUzdaSEw0Mmtab0VN?=
 =?utf-8?B?cUNwS21nM2hCOGpzYlZJcS9kRzZZZ2xiWFhscnEwaVRVS3E5T2tjdUdiRlB6?=
 =?utf-8?B?S3JxdnBjMDYrMkNCMHdNaTlDcVZ4cnphSDhCNjN3WkliNFM0blQvQnJZbnNo?=
 =?utf-8?B?VXNFV0JtV25mdytRSXNLbmhGbnRtT2lNODhTTU5vWUcxcjZqNlFJSkk4em1P?=
 =?utf-8?B?cDlWWXJIYWxaNWlNcXVjOGZVMEI5OVdzRVB3dGI3UnU5TWZHei93Q0dBdnl1?=
 =?utf-8?B?UUJzUS9qYlBkNCtMdmtFeXlvcXVvdmp3T0ZwRUx6S0pPSkFsWFNJakUrTHhD?=
 =?utf-8?B?MFVQUGlKNmRFK0VWRk5oQzhMSE5JWHF2N2pFcWNPYUp5THMyMWMvdFJObm5w?=
 =?utf-8?B?VC9pbkFzd0dRekpJMjROTkl6d1gzQUE4ejVYbzlhdGFzdUNQUTA1T2RyN1ZD?=
 =?utf-8?B?M29Dbk5XL1IxUExJMkQ0SmFJUEVGZ0lOcWpla1FSazBkUmVkNzBKZkdLL21O?=
 =?utf-8?B?UDNod1lRSW56TUhLWnlrakZ6YWtONmZqZnlyaVFMdEU3ejhyT2s3N1RmYjZx?=
 =?utf-8?B?QktBS29PMEx3b01FNWg1ZE90aXNyYjV4blpMOFZHQUJzejR0QTNHZ1BIbTZW?=
 =?utf-8?B?eHMyNzdUZzhnaTU5R3hZaE5BYkNyNGVPK2dRRXd5RSt0ZFNBVEpwK0tPYk04?=
 =?utf-8?B?S2ZXSlFUaUJwN0tycVJHZmIvcHp0bWIyb1FyQkNRM1NVNGhCaVZtME9OcVc4?=
 =?utf-8?B?WUY2TVVpelV3bmgyckR6eTNNQjdxYkM4VXBCZ1pEMXdNclJEbWM4WjJtbDg1?=
 =?utf-8?B?Q3I3NDdJQkk0OVZyL29ZcGRNZFp4L0xZazV1Y1B5aHV4V1BkMWZ5NjZSTmlK?=
 =?utf-8?B?RnpyTDRmQmJPaWtSU0ROUjNsN0g3OFFpUmpKaWkwTmU1SlJ2RzVEbkJGdVBa?=
 =?utf-8?B?cTFpZ3JURnY2Y0JjbkV0NDR4K1IxQi9SRnMvbWU1Q2hXdlZrRzRVcFJsMkhQ?=
 =?utf-8?B?ZWhESEt6V0dCZWFrTHFtWktZMkdhVUVPOGJtZEJvYVNHSXNxcm50cmpERkhL?=
 =?utf-8?B?ajljQ3JsYU82ZStiNHZld1FDWFVmdDdmNTI4M2k5WlczYmFpMWE5U1V4SUFn?=
 =?utf-8?B?c2RDWDM2a2QrY3VuL29pd0o3Y3BZVUYzTkNQc05aU01OVDlabk0xa25oZUVh?=
 =?utf-8?B?WjdoaytMSU1pZ25YTVgrTlhjaStWd0RTQWVJdWx1YmNoSnJLNENxbVFKVnJG?=
 =?utf-8?B?M25VOTd2KzhuM1p1R254SUtYazZucmNpRlpzQUxHTDNSN3E0OUhCM0ZsR1Np?=
 =?utf-8?B?OUdDVHE5VU1ZaE5sVmY3RTJFRXFlRWNOM25QUWtNTjE5NTBCcHAyek9hNjA1?=
 =?utf-8?B?NWdZNWkrNGh6eDQ3Nk03Ull3UXAyN3R0alNLMVNkakwveHEvd1F2djFuYUVr?=
 =?utf-8?B?WlZhQ3hUdFEzUDJFcjlLKythU0NqMCtMdWtUUG9LeEVPVmpvNHhISHFCY2kv?=
 =?utf-8?B?NVdvMXdBMHNsMFUzajdPblhhZ3k1TlVqZDJnRTJ6b2xuM2dueTgzd2s3c25Y?=
 =?utf-8?B?SGc2QUxZZXlkUFphZEV1cjh0dHRmdWUyLzQ2czBuelRBWXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MytsMVpITnZOR0p0WTh4TnIwWCsrc2dRSGpLS2tzZDdDcXRwdHdpeXdTMmFS?=
 =?utf-8?B?VDhSMVpWdkRxZUNMbU5QZFlsMmswUHp4VU9zOCs5anN2THF3Z1NPM3pCVEZz?=
 =?utf-8?B?akZuUm02SEVUN1VaUEY2dmVxN0xyNUY0TGZrcG9uQi9TcTMzNGMwN1hqNFZp?=
 =?utf-8?B?bU1NQUxpMWwwekZoelU1SGJCU21lZ2NxZGdYb2srZTZ4NXM5SkJXSDZkL01I?=
 =?utf-8?B?WDJrMVp5MTVZclBaY2ZrSzlqcXB6Ri9ZOFBFR24vZTdlNHNTTG1CRVMrOEoy?=
 =?utf-8?B?c0hSZ3RBUy9sS3M2NVMyVGY5ZjZtSTZEWDFTaVdIMlNyZHdIQy9oejVMb2k2?=
 =?utf-8?B?ZWZ4YXEvUGxwbUhUQ0tPUUVCck5qdkxQZGJVYmlScXN6N2lHazVhM1g5bm52?=
 =?utf-8?B?ZEp4VVduWjVXYXFuWnI0aklQSHFzV1ZHblkyc2NCeDBmYU83K2trNktHV0RB?=
 =?utf-8?B?L2Y4OEZwOXFBZkk3Ky9FZElKNHpYK01US0xXU0EvVUVLS1pTNFFpSVB0VlZZ?=
 =?utf-8?B?OEw5Tzk0cXl0SXBWVnJSYmhXZnd3NVpyMXZESmE4aXFwR1oxUzcyY2NjRUJx?=
 =?utf-8?B?SHpPRnJvbjRjaDhQanRxSnpOMkxQS0tkcEZuWWV1eXJ1M3A0SUw0VkxmMWxw?=
 =?utf-8?B?cURSazZ0YXc5Ty85c3VJRzJUU2M0cDQyZCtsbTVqVzFZbkJnZ0U0SmtjVFVX?=
 =?utf-8?B?ai9kOTVsNTBkUHZ1RUpTazM3eTczQ3dqQlFrODlCTGg4YTVwd3A4dmJvbmVM?=
 =?utf-8?B?YnlXN3hXcS9sQkxISjdHSFJiS1h2TXo5a1dTWmVqcndXTzdrWmhRT1RsdEsy?=
 =?utf-8?B?WHQxMDRXbXNWWTEzbDFjekMwb1NJSTJZMlBDcHB2RHkvRVJZZXNxTHNER0J3?=
 =?utf-8?B?QzRiL1lwak50VUlvYkQvK1A0R0RadER6ZWk5VHM1bW5wMVJrTEM2OHZUZkhO?=
 =?utf-8?B?UUlFKzc0TnlPd3AxT0JoVnNKdkkwOVhVcVE1bmhCMC9lMjJRUndHNmxacXhn?=
 =?utf-8?B?a3RrWHYvRDVHdERjS1ozS2Q0L2Fib1U4RGsvUGVuTXRrWkY3d1dGL3RYWDF6?=
 =?utf-8?B?RUEvazdwQWRCeGVZYWpobnVkenVyWjQrd1lUby9meXpQdm1RdFkwRE1tdmtD?=
 =?utf-8?B?SVVVK1NCT0kzSXdaWWFSajgzYmlwV2l6WklKV2VsQ0xvTVJzNmlvNHpZeWxa?=
 =?utf-8?B?SnRJcTRQRjQ3NURxdVZVa3pUazVDM2hjZjlnMEQ0dnhlZy93eVF1bnNCVTBy?=
 =?utf-8?B?VHRPanI4UC8zYmhZaUUvNUE3ckdyYVRSeUEvYkxDa0JUKysramRzNmVtaWt2?=
 =?utf-8?B?TUhnd1RRZGNHRVpTQzNIYXBpcCtWN1RhaFN3QStwdUtERGRJczJYOWhSWWhk?=
 =?utf-8?B?WEo2SEY5OTlXWG9vMll4RnlRUk1rdHVJejBobk9GVjEzdGxDakhQZzQ0MTBw?=
 =?utf-8?B?R0JneUtsVnNpZHhoVHNZU285Z0M0RlJnMTVNa2FpZTViaW1qR1A0c1MvOTE2?=
 =?utf-8?B?K1NQMGZCTDFDT3lnL0Jkcjd2M3REZHd4YWlMQWJKMHFQczV3U25LWmFJdnlX?=
 =?utf-8?B?SVU4Vi9nL0lTdGdOcGZ6aFdUY2g4VVN2T0sycENLVGFhU2VDUm04UDlPSk1r?=
 =?utf-8?B?bkRhTzhaMVRlMWpyYXlFekFBYlVwOE9xaytnNWlUZEdXYkI0eHdzamFGZUJM?=
 =?utf-8?B?VnVNWlJtcC96UjZRZmpZamdZSW1oSm95TVlha2s2VlVMVFNHN0NLODJwOUV1?=
 =?utf-8?B?bm1ZdVVoZllOcFg3VkRKenh5cTNUUXpHQ2UvRCtEYWJLdFhUaHNZV28rMlIw?=
 =?utf-8?B?SEp1NTJ6dHFJYWdlR21zTy9zRjJlV1lEY21hbmwvZ2dVVTVoOGtRUlZaQTc3?=
 =?utf-8?B?d1B2RUxzV2QrYThzTzhxeVdjYnNMbXRqSUdzaDRFRmhHeFZrUzg0d0FkaWVV?=
 =?utf-8?B?Q3hibkJQZWEyM1NzdnVYUFY2ZENXTndRYmtvNjFabElwWU92b3g3TktjNklk?=
 =?utf-8?B?dGo0QjRoUUtwMzJJbFdJRVZDb0dya3BVTmtuK1Uxb3J0c0F2Q3pZWVFRYWM3?=
 =?utf-8?B?bG53d3EzSFd1ZmRWNERqOG9UKy9PUDJmR3o1bzJ2Y2p6NHp5OUtlVXRMbjRt?=
 =?utf-8?Q?B5A0S/pO8ldvkykepjZ0dSBL4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a1612c-a671-4ec1-db14-08dd0e39d889
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:46:16.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5iSgKzm3PTliODejiWix+T82nqh82yWWtt2DRjXnMBSI25V4j9hispefOEwyvYj4qGP1RXVQ6GtClMHe0778Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9682

On Tue, Nov 26, 2024 at 09:55:23AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 25, 2024 at 02:17:04PM -0500, Frank Li wrote:
> > On Sun, Nov 24, 2024 at 01:26:45PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Nov 16, 2024 at 09:40:44AM -0500, Frank Li wrote:
> > > > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > > > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> > >
> > > I don't see 'doorbell_done' defined anywhere.
> > >
> > > > doorbell address space.
> > > >
> > > > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > > > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > > > address space.
> > > >
> > > > Set doorbell_done in the doorbell callback to indicate completion.
> > > >
> > >
> > > Same here.
> > >
> > > > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> > >
> > > 'avoid breaking compatibility between host and endpoint,...'
> > >
> > > > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > > > to map one bar's inbound address to MSI space. the command
> > > > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> > > >
> > > > 	 	Host side new driver	Host side old driver
> > > >
> > > > EP: new driver      S				F
> > > > EP: old driver      F				F
> > >
> > > So the last case of old EP and host drivers will fail?
> >
> > doorbell test will fail if old EP.
> >
>
> How come there would be doorbell test if it is an old host driver?

fail by unsupport ioctrl(). It should "implicit default behavior".

Frank

>
> > >
> > > >
> > > > S: If EP side support MSI, 'pcitest -B' return success.
> > > >    If EP side doesn't support MSI, the same to 'F'.
> > > >
> > > > F: 'pcitest -B' return failure, other case as usual.
> > > >
> > > > Tested-by: Niklas Cassel <cassel@kernel.org>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Change from v7 to v8
> > > > - rename to pci_epf_align_inbound_addr_lo_hi()
> > > >
> > > > Change from v6 to v7
> > > > - use help function pci_epf_align_addr_lo_hi()
> > > >
> > > > Change from v5 to v6
> > > > - rename doorbell_addr to doorbell_offset
> > > >
> > > > Chagne from v4 to v5
> > > > - Add doorbell free at unbind function.
> > > > - Move msi irq handler to here to more complex user case, such as differece
> > > > doorbell can use difference handler function.
> > > > - Add Niklas's code to handle fixed bar's case. If need add your signed-off
> > > > tag or co-developer tag, please let me know.
> > > >
> > > > change from v3 to v4
> > > > - remove revid requirement
> > > > - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > > > - call pci_epc_set_bar() to map inbound address to MSI space only at
> > > > COMMAND_ENABLE_DOORBELL.
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
> > > >  1 file changed, 117 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > index ef6677f34116e..410b2f4bb7ce7 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > @@ -11,12 +11,14 @@
> > > >  #include <linux/dmaengine.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/msi.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/pci_ids.h>
> > > >  #include <linux/random.h>
> > > >
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > > +#include <linux/pci-ep-msi.h>
> > > >  #include <linux/pci_regs.h>
> > > >
> > > >  #define IRQ_TYPE_INTX			0
> > > > @@ -29,6 +31,8 @@
> > > >  #define COMMAND_READ			BIT(3)
> > > >  #define COMMAND_WRITE			BIT(4)
> > > >  #define COMMAND_COPY			BIT(5)
> > > > +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> > > > +#define COMMAND_DISABLE_DOORBELL	BIT(7)
> > > >
> > > >  #define STATUS_READ_SUCCESS		BIT(0)
> > > >  #define STATUS_READ_FAIL		BIT(1)
> > > > @@ -39,6 +43,11 @@
> > > >  #define STATUS_IRQ_RAISED		BIT(6)
> > > >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> > > >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > > > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> > > > +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> > > > +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> > > > +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> > > > +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> > > >
> > > >  #define FLAG_USE_DMA			BIT(0)
> > > >
> > > > @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
> > > >  	u32	irq_type;
> > > >  	u32	irq_number;
> > > >  	u32	flags;
> > > > +	u32	doorbell_bar;
> > > > +	u32	doorbell_offset;
> > > > +	u32	doorbell_data;
> > > >  } __packed;
> > > >
> > > >  static struct pci_epf_header test_header = {
> > > > @@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> > > >  	}
> > > >  }
> > > >
> > > > +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > > > +{
> > > > +	enum pci_barno bar = reg->doorbell_bar;
> > > > +	struct pci_epf *epf = epf_test->epf;
> > > > +	struct pci_epc *epc = epf->epc;
> > > > +	struct pci_epf_bar db_bar;
> > >
> > > db_bar = {};
> > >
> > > > +	struct msi_msg *msg;
> > > > +	size_t offset;
> > > > +	int ret;
> > > > +
> > > > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > >
> > > What is the need of BAR check here and below? pci_epf_alloc_doorbell() should've
> > > allocated proper BAR already.
> >
> > Not check it at call pci_epf_alloc_doorbell() because it optional feature.
>
> What is 'optional feature' here? allocating doorbell?

Not all platform support ITS. If hardware have not ITS support,
pci_epf_alloc_doorbell() will return fail.

>
> > It return failure when it actually use it.
> >
>
> So host can call pci_epf_enable_doorbell() without pci_epf_alloc_doorbell()?

Suppose yes because host don't know if EP support doorbell.

>
> > >
> > > > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	msg = &epf->db_msg[0].msg;
> > > > +	ret = pci_epf_align_inbound_addr_lo_hi(epf, bar, msg->address_lo, msg->address_hi,
> > > > +					       &db_bar.phys_addr, &offset);
> > > > +
> > > > +	if (ret) {
> > > > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	reg->doorbell_offset = offset;
> > > > +
> > > > +	db_bar.barno = bar;
> > > > +	db_bar.size = epf->bar[bar].size;
> > > > +	db_bar.flags = epf->bar[bar].flags;
> > > > +	db_bar.addr = NULL;
> > >
> > > Not needed if you initialize above.
> > >
> > > > +
> > > > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
> > > > +	if (!ret)
> > > > +		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> > > > +	else
> > > > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > > > +}
> > > > +
> > >
> > > [...]
> > >
> > > >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > > >  	.epc_init = pci_epf_test_epc_init,
> > > >  	.epc_deinit = pci_epf_test_epc_deinit,
> > > > @@ -921,12 +1010,34 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > +	ret = pci_epf_alloc_doorbell(epf, 1);
> > > > +	if (!ret) {
> > > > +		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > > > +		struct msi_msg *msg = &epf->db_msg[0].msg;
> > > > +		enum pci_barno bar;
> > > > +
> > > > +		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
> > >
> > > NO_BAR check?
> >
> > This is optional feature, It should check when use it.
> >
>
> NO. Why would you call request_irq() if the doorbell BAR is not available? It
> doesn't make sense.

Maybe reasonable now. But it will be not true if we support map two
seperate memory regions to a bar in future.  Anyway I can add check here.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

