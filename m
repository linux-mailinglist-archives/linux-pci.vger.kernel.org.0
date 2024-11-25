Return-Path: <linux-pci+bounces-17290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E739D8CAF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76544166938
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ACF1B6D1F;
	Mon, 25 Nov 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L3ztOD7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EF1BCA19;
	Mon, 25 Nov 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561959; cv=fail; b=IHp2NM9bWkLIKVgTm7VolXzV9ZqrH5C5ayX5DlpwuW00CDX98DUkxeZM0mUvfqIhEZ1XiZYvl87ZYRyY4rko/EvnZTeb/KxQBYVZrXJzJA7B36dYRAboB4F1tPpn3Jr8mCS8GvCFYrdYYX+1l74AqWi2+QjUQT3eaTGcwkqZB48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561959; c=relaxed/simple;
	bh=vChQdNTKX/2QtxPtkWPx+NKYlYbPCtlppHx/31PWwIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2ryGBaExxw7pGcZbVDkq9GMU2y78dicGMIPtaT70DTTbpuJl1/AqRCvdDM/AHErh8FBnnaEUUH1N1tDtXVHKMktv7DldLQGwtS6MmmJCWRF1FObvp7fNE/IPyVm44gKP1h9AVGkgRui6M2hWyma3Wb9ezzygtJlYlNP8TwUMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L3ztOD7S; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfEzd0VzaYjG6e/dhAoj3CTLohYMGmfN6/xsxTOnNEyARrFzMnCPrpKkLXDHvRCiKgnB6QL/5H+IYCE4hEyPwE2kMelJMYvReYZqbtnQQPup9674SGoSF9TZxFpGo8L6TkM2oRreqzusLsWAHv/bhsMqI2aPfxsrYGKWKENZsJPC/+LPl+iMz1ukMPt75QUGLp46rHubt0M0TdWpNGkPjMt9vTfyND6/0ljKrFsKvDEQGBtOwzjKHXntk3bh9Gw0/oAwG6raAIbLL8XfSmqjanLcmX9RxD2L6G89rydoIkVuYsp4EX38OzKkt0CXHVqJxRP4V1+rj2Jlpe7fZ6+U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hytQxzEGgu1inBC7iLQdnHPNhWY+/vprJo+zePr5Xnc=;
 b=yWfCQ2iuJy/7QvIfJLrQYwDwwGemsiczcaB0Zhx4yw8MNyW69JcTyOUZYoM4L3JH3KdmcCZPaTfab8tWqpGpzu4r3wTsDNj+W/MsH1HgtZvMG5JR3XiM86HwJzShVKCeyr39tYjrwgyIM4np6Who9kewsTXH99SIUr6RXbqZaOnWHbUk3dYLMDmT7YQHjOcT+7xc97RDCGdPXUP4MDtH5xiTIROMjqh65xBhXc5B3DmQxs0mrFxPsq8xwraeiotmrurOURTVczTLViclBqp0CWJOxEvRwzSUurqWG+BcGjGNEsoYBR+OxOgDLr7VRSg/KVg47fYK1VzYDRpB7bd0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hytQxzEGgu1inBC7iLQdnHPNhWY+/vprJo+zePr5Xnc=;
 b=L3ztOD7SYPlO2ZFsRr74n0drKidEkrdnJpYfpNTMkXsW+nV06yN9te2lFBE0/tpdPPBdYWHrkF9K/BFIb4KG+yOxLdHkvF9PT6wd4UDwU6qQ80w2hCTmhT8eY6X9HLa9x0MnBiTVr9HrGCHSOZyuUg9htm8qtcjHkpUj+ehXceluNtzKw1rxJx4DgXS9U0hZXtOk6mKZS6VliCCHl6H7bvJUr4TT59UeR6YUnt7Vsn7OHr4JvLMKlQGMhJEAwPYe0gvKU+UGUlTKaqGpRgJIp4wOYlCfPEPaZsm36K90PpCWMRnegD0NXauV1V5uGMJBt7yacSDbYBj/vOLG6aNpNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 19:12:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:12:32 +0000
Date: Mon, 25 Nov 2024 14:12:24 -0500
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
Subject: Re: [PATCH v8 5/6] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <Z0TMGNLtMjdid5pT@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-5-6f1f68ffd1bb@nxp.com>
 <20241124135128.775zh3xqkrajzvn4@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241124135128.775zh3xqkrajzvn4@thinkpad>
X-ClientProxiedBy: PH8PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:510:23c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cf21e9-d815-48af-654f-08dd0d851d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmRpQ2xLa2hHUlBEYjJEeURxS2xWRmo0dDhUc2hxamFMUmtDYkhvc2ZET2k2?=
 =?utf-8?B?OWZ3aEhmOG50UXNmKzIzS1B4bThRWXgvV0N5WkgrMkd1blA1MFVMMytMM0s5?=
 =?utf-8?B?Q01iakQ4KzBnT1hKc1lmUi9PSTRkalN5Mk9rSmNsYzFSVncrSkhZcWdHaTNi?=
 =?utf-8?B?blIybXJ1c0hVVDNZWlI2SnRqZG9nMDNFcUp0S3F2aTlzcDZ1NGdHbDRGMUVY?=
 =?utf-8?B?eFRSN3lZNTZuRXE5R0xkMFVSNXRrbnNKUk1saFBhQ1dVb091V1dMZUIydGY5?=
 =?utf-8?B?eFhUZTBhZlp1MmZYNSsxU2JVK1ZQY0w1VU9MbGVvTDlaR0xFZjVld1gyVTN2?=
 =?utf-8?B?UTlkMkRTSDduL3Qyd0hBTFlkMzFlQXlEUlkzTnNJWTVuYWh4RVRNSEExYkR2?=
 =?utf-8?B?alV6bEdOblJkZmMzdXZxUEtKY0VlM2JCUUpZZG5va3dZVHNldGN4cXoxTUFr?=
 =?utf-8?B?TFRuY01DbVdCaGQxdGVFS0wzVk9LcUQ5aXBxRlRQaFM0K3pQNWdYTzRsL2xo?=
 =?utf-8?B?WGpBbTRMQyt1T2Fydng1dkJuMGp6aWhIWFlScUs0ZEd3TjNjZ2xFRE5oamFG?=
 =?utf-8?B?eVpja3hQa1l2ZVA5Tk5pUUF2cXRrMDhvanpObmhzZUlBS2RmT0xJMHVuTnlk?=
 =?utf-8?B?WjdXbkdDNWptaXdpZUloMURtL295MkVZSWpYajVlWjlvYnphQnFLaDNZUG53?=
 =?utf-8?B?WkhjRmlMQjZIRkVrSmpmZ2owelordVFKYm9XeWVPWFFkT3hOSm1NYjZXbTRC?=
 =?utf-8?B?OEJ1T2U3YmNHNGJINzVuVUxRZmh3bUptKzBNL2MyMzRCbTF1Z3QrQmVvNTNI?=
 =?utf-8?B?dkFwM1Fhd3hxT2V1T0lOa28vSEFKMnkzSVVqb3R6ZHZoVnZHdmVJNVBCT0wy?=
 =?utf-8?B?bUNoNHh6VTVsV05JQXZaNWxVRk9DOEl4NXZmVGprdXpMNG9abDlsdjNlM0dJ?=
 =?utf-8?B?MG03ckZiNitVdUVSVDd4aUpmWWhOcGxwYWhGVnJ4QVAyQWxuQnk3QTRwZzRG?=
 =?utf-8?B?UElpOHR2dGFHRG1LNzhxUER5WEJJbGhFR2FDOGVEbnlFTjVzZWVRYTFLckVw?=
 =?utf-8?B?T0ppRnQ2NFE2VWp6NDZRRDJiYmxYSGwreWE1T1FUeVlJSEFEV0IzQTVIWmNj?=
 =?utf-8?B?S01BdWdtYXhqcnVjdFNwa2lrc1VUWkZwT05ORVliL01JU25XcGN5RE5JSzlK?=
 =?utf-8?B?SDAzZndLZkJnUUYxTTFjWTZGVHdZQ0oxUHduUm5QbWh5UDQ5RGlONGI4WWp1?=
 =?utf-8?B?aVhWU2N2QXdyY25sempxWlpLLzBHcGpkcjJqbU9Wdi9HZ0p5S28vRTc5Q0VR?=
 =?utf-8?B?Qnpra1FaTGpHNU1WL0xHMXVsREM2cUxCTGgvTjBzeGh3UWVOcmhxQWh5RHhV?=
 =?utf-8?B?TmdBSTJGTVhrUXBmZlFGb2dDSFFnVHF6enA2eGlHM3RIdnJqM1hDZXpsSHlu?=
 =?utf-8?B?Y1Vtck44aGE5UmI5eVhNUnFtNWEzWmNKR25pQ2Yremp0Y0ZMbm5iektkRWg4?=
 =?utf-8?B?dy96ZStHWTdyQWQwejBVRVBUazRoVjd3bGJDSkIxSXBadWY3S2h3QkVUeWZR?=
 =?utf-8?B?Z3lTNVlyWTFGcEROWXMxUE94QXJNU2NiQ20yTU5HVkhOcUVNbWxWdS9aRUpy?=
 =?utf-8?B?OEpvOWJNWWdUcit4RjdmL2hHcnJ3SkZEQU9Vei9kVythbWIxWXVRamlCSTRt?=
 =?utf-8?B?U2FFMXZhRXFvU2JaejJaK0FPZXB4dGwrbFphVTVxendZRGNzT0Z4M0J1N2Vi?=
 =?utf-8?B?RWM3YU82Ukh2ckl0NEtVZk5TMFpVZmtIRkFLTUExMldPR3NpSXhNRHRvOW02?=
 =?utf-8?B?UGZmNEg3U1EwU1o3L3Y3THVNYVdQYWQ4Zk95Z1NBR25XSS95ZDFKYmRqeHo5?=
 =?utf-8?B?ZEFzWDBEcDF4bTlqM21xQVl0SllqK0sxK0dKdUNtZ1pEVlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnFRT015TUpPcnZGbEZveHp6cVZub1BuVWJrM0d3azF3dkE0NmlxWTlOaXBh?=
 =?utf-8?B?VHF0NWdGakJGdmIybk9XOXlPL3lPbTNmRWtBNDBCOW5SOVFOcW56TUd2R1V6?=
 =?utf-8?B?Ry80Tk1jTzBMYkViMkRXU0RMOVR0eXhWVmZYRkE0a1IxVmlLbkVvR3kwaHBq?=
 =?utf-8?B?Q0tpNXQ0QXhIK2VEVzlEd0Z4d0ZKZ3M5NzJ2VXZIeExnZlpmMS9zb3M5V0g3?=
 =?utf-8?B?RFVQOGtrMDRhdjZ4aGNtZ0NyK2dxbGZTaGc1S3JEWGh2MjFscDlhMHYweDVp?=
 =?utf-8?B?Nnhpblk0V0FreEpzc3FyZnRtUVAwamovOFQ0c28zYWM4a1NDcmluOWd1bHJD?=
 =?utf-8?B?ZHA5dk1ZTGYzMGs5RDNsdmNseDlESjM1YzZ5ZE9iVjkxV1YxNlpBOGVqVUdD?=
 =?utf-8?B?ZnQvRUw5QVhxa1FtdmZSdDlDdDVuUGN5aEl0NW9uYmthT2ZITEhBNFZoeUZn?=
 =?utf-8?B?WXA3NGFrbWNIVVdKU2luZ1lNc0VBRHVJWk1iNGtzZHZBS3lna2dRZGtxN2Rx?=
 =?utf-8?B?MC8wRVlXU05nbEowQVVOaDk0OG1KOFcyRmJPR1I4a3N3MVU5YmpEMDJTYzJF?=
 =?utf-8?B?eGRhZkVJKzNhZ056bk1oTTBzTkdvLzBMMktjcjJ2Wk5ac3dtbEY4LzFnaGps?=
 =?utf-8?B?WmV1TkxLRjUxQjJBeXV1ZktqTlJLTU0yNEdPV015djRwK0ZuRUtkVDFScUQ0?=
 =?utf-8?B?b1F5a056a2U0RGd0OUQvUGVJNnlCN2NTS1dDV3QzeWhVRXE0Y1hFTDIwbzVw?=
 =?utf-8?B?ODZ4Sis1ekdwRDJDVWtEaHpGWmIxMkJsMWNVZDkzMWtLTVUybkRNQ2hJcUVs?=
 =?utf-8?B?NmxPM3ZZMTV6UXpYeVM0NHJOSmVzQ3BwN2RXZlBDVFJoV2hZaHBDalE2Rjhu?=
 =?utf-8?B?QTJZVnlyMkVqV0NTSW9NdVd6dk13SkF2MXZpU2RsaFRTdi9tOGI0VjhRTXhJ?=
 =?utf-8?B?YVpURUR6aDZVNTNualhiamIrMGtKcysydkxHSVp0Q3hjcTV5aUVDUm8rc2dC?=
 =?utf-8?B?UVY0MGFhNU8yVk5iRmNweFgxY0krQ3Mzam54cWhaRVVrWi94SW5DelhHS1Vz?=
 =?utf-8?B?S1lBMVMxMzlhOVpheHRxZmxlNjc1NnRVVGZZeVNqcEZzVTNWaWRiSkVHYVJX?=
 =?utf-8?B?TWNBdTN6dHlobUpENG52S09xN0tVTHhEVEpqSUVMQ1hLTTdJMEFqVG16WWtB?=
 =?utf-8?B?bFRmRGwwclZVZzZWdHllc1EzYmhLellSZEFiM0xPQ2l6cEJWdGJXOUFIUDVn?=
 =?utf-8?B?Mlhpa1loMEdmUm9tMEcwR1dmV015d3hybjMzbkJQMEtyZHdxLzh3Tkp0ZWcz?=
 =?utf-8?B?UEZ3d3gySGM5cHplV3M5MllOMUp1NkRPZnk0cGZzN0Q2K1VuZ0xibG1iOS9J?=
 =?utf-8?B?UjNNcVdnUStmZ1U0RTRCVHFUQ2c0Mm5jb1Y2eXljVHlnOVpUUmxXRURsNm4v?=
 =?utf-8?B?ZnEzZXpVakdGU0xZUzZKcVhHcE9ybE53bnhVc0tzbXlVQjM1Wlh3OXU1QXlK?=
 =?utf-8?B?bTRiSU9LYXU1Z1d6YW1oaHY0OThTYjBVUUJDRHBkdGs2ZTR4RFJhNS8xRXJv?=
 =?utf-8?B?SjR6a2RTMGs5TkZYaS93WWx5YWFJT09idmgyMnJFUVNyVCs4Qjc2ZEpnc3cv?=
 =?utf-8?B?c0ROSVp4bElxajl0Z2VTUE1Zck9zZjhOY2pSOFlpcDU2c1kyVHp5VTdVQThE?=
 =?utf-8?B?TlBjZG5wTXRzOFU5Ny9LK21MaDU1b3ZvQnRYZitSTitBTGp2R0VUWitPTGM2?=
 =?utf-8?B?UjJYbk9ueXg5MUNyM2xVWHc1L09lMTJreTA5TlUwRGI5V1k0dEhydHB0UjBr?=
 =?utf-8?B?OHVTaHdMZjI1Y3RpdDZWYys5YUtqUk5nS2JDTGtQSHp5ckVrbWI0YmU3WDVK?=
 =?utf-8?B?Qnc5N3ozZGdjNHRoeXd2UDc3SUxua0tFK3RjTEtraGgrUHFCQnh6VTZEcjdj?=
 =?utf-8?B?VVNyUkJreGIwRjl2Z3REaXRhSFZvRktCYjI2b24vaWNYUXhOSFFxdXVDeVVm?=
 =?utf-8?B?TWswbGdQVXVTT3FNVXNZdEZsWGtXcU8zSzRoM3Bram8zLy9pSXVOdllBMlNW?=
 =?utf-8?B?b3Y5eGtYc2NXNE9MTm5zdnZWOUpoVzkwQWpyQXIxRXJKNXhiRGZBSGNwZ04v?=
 =?utf-8?Q?BrgQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cf21e9-d815-48af-654f-08dd0d851d1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:12:32.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhGFemfSSISbbsMW+h8bYzclQceHz/1LRtzEvhoP0YirWqnKbKzc8uI+nKelRq+/KKNOCPEEqQRjhn26+DMFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8487

On Sun, Nov 24, 2024 at 07:21:28PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Nov 16, 2024 at 09:40:45AM -0500, Frank Li wrote:
> > Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> > and PCIE_ENDPOINT_TEST_DB_DATA.
> >
> > Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
> > address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
> > feedback.
> >
> > Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
> > to enable EP side's doorbell support and avoid compatible problem.
>
> Can you explain the 'compatible problem' and how this patch avoids it? Just for
> the sake of completeness.
>
> >
> > 		Host side new driver	Host side old driver
> > EP: new driver		S			F
> > EP: old driver		F			F
> >
> > S: If EP side support MSI, 'pcitest -B' return success.
> >    If EP side doesn't support MSI, the same to 'F'.
> >
> > F: 'pcitest -B' return failure, other case as usual.
> >
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change form v6 to v8
> > - none
> >
> > Change from v5 to v6
> > - %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g
> >
> > Change from v4 to v5
> > - remove unused varible
> > - add irq_type at pci_endpoint_test_doorbell();
> >
> > change from v3 to v4
> > - Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > - Remove new DID requirement.
> > ---
> >  drivers/misc/pci_endpoint_test.c | 71 ++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/pcitest.h     |  1 +
> >  2 files changed, 72 insertions(+)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 3aaaf47fa4ee2..dc766055aa594 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -42,6 +42,8 @@
> >  #define COMMAND_READ				BIT(3)
> >  #define COMMAND_WRITE				BIT(4)
> >  #define COMMAND_COPY				BIT(5)
> > +#define COMMAND_ENABLE_DOORBELL			BIT(6)
> > +#define COMMAND_DISABLE_DOORBELL		BIT(7)
> >
> >  #define PCI_ENDPOINT_TEST_STATUS		0x8
> >  #define STATUS_READ_SUCCESS			BIT(0)
> > @@ -53,6 +55,11 @@
> >  #define STATUS_IRQ_RAISED			BIT(6)
> >  #define STATUS_SRC_ADDR_INVALID			BIT(7)
> >  #define STATUS_DST_ADDR_INVALID			BIT(8)
> > +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> > +#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
> > +#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
> > +#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
> > +#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
> >
> >  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
> >  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> > @@ -67,6 +74,10 @@
> >  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
> >
> >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> > +#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
> > +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> > +
> >  #define FLAG_USE_DMA				BIT(0)
> >
> >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> > @@ -108,6 +119,7 @@ enum pci_barno {
> >  	BAR_3,
> >  	BAR_4,
> >  	BAR_5,
> > +	NO_BAR = -1,
>
> I really hate duplicating this enum definition both in EPF driver and here.
> Maybe we should move this to pci.h?

Yes, It is not related this patch. It should belong clean up patch. We
can do it later.

>
> >  };
> >
> >  struct pci_endpoint_test {
> > @@ -746,6 +758,62 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> >  	return false;
> >  }
> >
> > +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> > +{
> > +	struct pci_dev *pdev = test->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	int irq_type = test->irq_type;
> > +	enum pci_barno bar;
> > +	u32 data, status;
> > +	u32 addr;
> > +
> > +	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
> > +		dev_err(dev, "Invalid IRQ type option\n");
> > +		return false;
> > +	}
>
> Is this check necessary?

Suppose yes, it pass down from RC driver side, we should not suppose it
alwasy do correct things.

>
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> > +				 COMMAND_ENABLE_DOORBELL);
> > +
> > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > +
> > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > +	if (status & STATUS_DOORBELL_ENABLE_FAIL)
> > +		return false;
>
> I think we should add a error print here and below.
>
> > +
> > +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> > +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
> > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> > +
> > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > +
> > +	writel(data, test->bar[bar] + addr);
> > +
> > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > +
> > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> > +				 COMMAND_DISABLE_DOORBELL);
> > +
> > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > +
> > +	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > +
> > +	if ((status & STATUS_DOORBELL_SUCCESS) &&
> > +	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
> > +		return true;
>
> Usual convention is to check for error and return true at the end.
>
> > +
> > +	return false;
> > +}
> > +
> >  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> >  				    unsigned long arg)
> >  {
> > @@ -793,6 +861,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> >  	case PCITEST_CLEAR_IRQ:
> >  		ret = pci_endpoint_test_clear_irq(test);
> >  		break;
> > +	case PCITEST_DOORBELL:
> > +		ret = pci_endpoint_test_doorbell(test);
> > +		break;
> >  	}
> >
> >  ret:
> > diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> > index 94b46b043b536..06d9f548b510e 100644
> > --- a/include/uapi/linux/pcitest.h
> > +++ b/include/uapi/linux/pcitest.h
> > @@ -21,6 +21,7 @@
> >  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> >  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> >  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > +#define PCITEST_DOORBELL	_IO('P', 0x11)
>
> I think defining PCITEST_CLEAR_IRQ as 0x10 was a mistake. It should've been 0xa.
> But since it is a uapi, we cannot change it. Atleast add new ones starting from
> 0xa.
>

Yes, thanks.

> Niklas's consecutive BAR patch adds a new ioctl for 0xa, but we can fix the
> conflict later depending on which patch gets merged first.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

