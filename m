Return-Path: <linux-pci+bounces-15731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B657F9B800A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75123283714
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95AE1BD03F;
	Thu, 31 Oct 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bz+Q8Wdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78D2E406;
	Thu, 31 Oct 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392043; cv=fail; b=fwYoDsyWbL6aVCV5eicad1PhR3mCErjECUfk9vZd2bfaFdCXS6A5LnrBXOYi7lH1I8vtDcozBqoNeonAchgzODo3Z3MWow8OJv5SiL71NfsUrZIHC3PT0vQq/CJQ3RcpijgvrG4HaaGj9UjADXjmlaovn4scWINelNHOHJfnTEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392043; c=relaxed/simple;
	bh=WztdJXCK+bOn8jeGvfQAh0AF4COBEh+c0a1xNE6MdUc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O222GVxHvhCZCLSP4gL1h5eYJgIABOnto1AMmZnGCua8CQ03p5FbPwUv+H3XmzaaYvDDvMtJrNM4UYomsLmk8i5TCfflKuA0z/UMTeKOkPSEMW/6aS5VrufrdKav8LBi7XFSmT7m8RppEsN0XrFZGflIdQ/g3gZuAes9ruOywS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bz+Q8Wdi; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUZIFn7/A2V2TsW3x3N3GGhrbAD1xOCpEfiCUuKW77KckS0+SjK/YdH+du9TLwZiUKCKUI5ff5O5xUiesTE4FfLTOsMkCjni6oQbrlwE167rdhBlhLjKOa2y077LNl37aqstITiZkOsN3eWI+Dxk2WMA4ryFwUDgQ3ghBIIOc6PkEazsRE6tBNhp77Msp4gIeLCvUX9UmY5TGzX+uqCKteFHexGs+PqHiNwtWJIyH8IkaqI5uZziSvFTqeYNtd0mW7aAzX/+sIt39QtKCngzvRTWCaHs/c30qiT93yMS1WbqvgWPUrdPfL3tQstQPfiP9BmXQt9dmC6uM5fBxsTjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oan0nT460bnBSfdOKCXlsarwBLEOZ6HSByQIFZo5Sn4=;
 b=rN/wty1IPczsVy4Z+8AGBwTW+oUQs/hvWhoBL7XBY6JLSngz/GLrN1qEsghctkdU9I1BAeMHVouQjC9CaQBRyeg900pptNo9BB41thQWsYHaVRryVhkvhFGFRals8xWloAQE3gXvjJ1gnjDCIK52D+/Tk2C2/H1gzG9KlGKbKIGGzX0mn0nhNDbp+/eDVmWcIgyIsObPKnXCInCvnipD9kWy/Eb8Fwv4VxWdlth70hpacaHhpp0uGV0tkIfW14+WCoQ0zipnQrFJg47MfZcm/hKF1D07h0nv6rZcvX2T6y4qHHrt2KKGcUE7Bc1nqxwQB5ADxxlhNFEiYIdIHxCozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oan0nT460bnBSfdOKCXlsarwBLEOZ6HSByQIFZo5Sn4=;
 b=Bz+Q8Wdif90oVm6wCofNWsvzKqPytHIH7O7fij6LknfwV+XPrLCc6RImiqorCUal+bD2w2ySRwRJ5msUz2AlE/GLU50NY6OtsvRKrZvdVMGh7n9fAPIm2P2lD2mf+xGjf1zIB5CCaCnVERkiAMzW/Klx9msoRl225jqmPkEK4+lYIoFpPV2R5fvy4nNgYqRpz+ce1J+coam/cw6+zzQW/jmQKlZjjdKfSoNlfYMk62B9hg6WsKueoHnFu+gdpE3g8QjhvCh6e2JLXuW9xyBR93+BGaMM6Xa7Kxp46rxiypsWPBKpSYxCyu9XaziK1TRVix6Jv7xGC9jHYwcOQ5yzyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:27:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:27:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 31 Oct 2024 12:27:00 -0400
Subject: [PATCH v4 1/5] PCI: endpoint: Add pci_epc_get_fn() API for
 customizable filtering
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-ep-msi-v4-1-717da2d99b28@nxp.com>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
In-Reply-To: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730392028; l=3101;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WztdJXCK+bOn8jeGvfQAh0AF4COBEh+c0a1xNE6MdUc=;
 b=5R7ouNHd90vplufWGmVJaXnpYoRGO/hg16Xps5b38myeJ5Rvm7rUk9iQDjrnayCIReb1GHWsh
 I7Qu7uZx4FfBE8DwSjryyLQy5AqsqdkTvNlxPbHByxwA2nccdUyPCrd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af4b9e5-ba50-4a91-2294-08dcf9c8e20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czV4QVZMM0N2QkgwMFYvVWVVSk9DdkFTT01Td0tNTFV2OTlpbmlpWTErU2Za?=
 =?utf-8?B?Tkd6T0hMdHJoNWxZK0E2SDBvekpiV3ZXSmdTUnpycndXNm9BZnlNUEZQejYz?=
 =?utf-8?B?VXZoZFZ0Skw5MGlsd0p1N3h1NncxcTk3enpRVkxTWXFQSzBwUDk5YTY4VGd0?=
 =?utf-8?B?ZFBFZkVUSGpBVU9PR0d3bTh5VWczU2VNOUpmdHJ0ZGtUUzJuWExJZXpNWGNr?=
 =?utf-8?B?Ykw0MmY2MEllS2pROTRVNVhINm00Vzd0L2tXOGtBdGZrc0NuQjg3SzhMWHMz?=
 =?utf-8?B?WUYrSFJ6RHF1emFOQ1JocFV3dTcxdDE4N0xkTVJKUDVyMktTanorMEtucUo4?=
 =?utf-8?B?L3VNd3hqdU50eHN0akNDUEtjMSt2UU1pRGlxZnY4eVZhblY2WUtmM1c1TEdC?=
 =?utf-8?B?c3dYZzg4ZzIzZGpRN3VIODk1V0VUSWF3cnE2WFh2S3JvZzBQMkxLZkgwTGJm?=
 =?utf-8?B?UnFBNjVUeDdtZUljbCtaWUx6MWQ5a3JJalN3MGhHWEIzSng4eVpER2xFRXFF?=
 =?utf-8?B?dXhIc084a2hwNk9LczFMajhxWG1mT0RlcFdYb1ZZUEJsdC9EaDlaQVNIcVB5?=
 =?utf-8?B?YjNLbnA5OHVoZko1TTIzTXpCQzMycmpvNFQ4bGlPRzJiMk9KaC9SbGcwVTdp?=
 =?utf-8?B?RGV1dzlQVkdsTFBFVGtvaU1LeEF0THZqR2dIS3o4NkRTL204S3dXcy9YRVRJ?=
 =?utf-8?B?TlE2TFBsV1o4cGZHV2owNkQwcmh4anZ3bCtmcG5NTmlWT3BsbmtNRmUzVWRM?=
 =?utf-8?B?Z3Y3VE43MENHbXJXNTVjSjZhNjFRbGg3dTZPRmpqNGk1dHlhYXk3Sis2ZkNq?=
 =?utf-8?B?dTFZenZnZXFVbldWRGMwSWhRUklHK2xubGZTTVllSFF3WVhNWVJ4Q1F5cW9Q?=
 =?utf-8?B?OE9remd4MWV0Vi9hOURYaGc4a0NPRjIrV3JoR3E5OUhRQlFQaGR1SGxzQUUy?=
 =?utf-8?B?NXA3Mi91VU9JM040eDBlR0tDb2lBbW5Sd2xqOGJCa0ZBVFFCZUZKMGFnY3dP?=
 =?utf-8?B?YlE2ckE1TDhzTmFaY2pMR2NrUWxLZmFjMnhqaktmejk2VGVmWlJ1VGVicHJQ?=
 =?utf-8?B?MW91Qzl4bnNubkxoWDVsWkEyWHE3ZVpIRm96OC95VWFCWWljWWwveFNJQ2R3?=
 =?utf-8?B?QzExYlA5RVgycjNFc0taajlDUTEyYkNIY3dBRkdqenVZcmZkT0tmOHlMWHVM?=
 =?utf-8?B?QnRMMXorTUZrU2pTVHQ3ZTBYbU42UXZGVGlBODM4eDFLc2Y1OWV0aWdrRWlS?=
 =?utf-8?B?bjNYS242N3p6bnU2aG9kQ0xNemtKU0hDd3NZVnFPNW9ZRVRWaWRPaGg3WEJn?=
 =?utf-8?B?WmVjL0RGU1dvWE43U25iRWNuNC9wRDdFYjRERVdxc1hDb1hlOGJQSlE3TzA2?=
 =?utf-8?B?NGMxT0E4WlJQNldoeXFON0xDV2dGTXJBSU0vZ0w5Q1VvdmNHdWtsRStpRWM4?=
 =?utf-8?B?SGljbEttdWtHYUd0aW5PUFVLM1ZicVZHR1dpU0MxVDZjNkZjdU5vNXRqaXp0?=
 =?utf-8?B?Ymd5K2dzNFpuUDVmT0tEdTNVbkhjSE9CNXcrUFJyaDkvWSsrM01nb1BxRlBv?=
 =?utf-8?B?UVRxRWFBV05sOFEvbWw5dTFLeFpSc283Sk9JNi9ZdFBwSzVWRHpvYitIQm5Z?=
 =?utf-8?B?VEFJeU4zSElaMXg5akFJMnIzdno4Ym9RdkVUajlSNlRPbndxRjJueWdmMlZL?=
 =?utf-8?B?MituU2NvZTUxdUZza1N2ZmMxbWoxRVpiejdjb2JnaWJTYWMzNjBvUUtDUjE4?=
 =?utf-8?B?NEY4cm9GYzcvaEJSU3lOTmtZRWlBdmhGbzB2NUV3NkFVTk5uTlJua1FFdExZ?=
 =?utf-8?Q?Zh5c+5rBeI+vVK6vsn262O7PWhYMVb7ECZVMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnBnVXRTSE9DVENBYTFxREF1a0JFdERKUWhESnhXMFJuZGd4Z2dpMkxtMDNN?=
 =?utf-8?B?djFQbmI2Q3VQK3E5elZrWG8wcUdTdUVHeUNBN3VOUFBZYUNPYXQvOXJiQnR0?=
 =?utf-8?B?REhKbmJQS2UzNnVjTU5Wd0M0YldmN09HYm5zdG9vazROMUE5MytWcFhmS25x?=
 =?utf-8?B?Rzl3R3B0bjMyZk1idGo5ZDRGUm8raDF6cTNUaGNhY3Zjb2ZTdGJKYmlxc3Rm?=
 =?utf-8?B?L1EzcEo4a3o3UzZ1UmZUZkdDSlBIblZMeEV4RjRJYVRPdmhsQVpIWmM0clZo?=
 =?utf-8?B?aHBrVEFuU0RsZkhsSW02TkZSRnhKYmVQRHRpNU83dWZiZVVVWWljNG5ycnRw?=
 =?utf-8?B?OXdQRkRUQnM2cjdEa0JIdE1ZNkFESVAzcGRZdkN2UFgwdDF6K29jU0FzbG5P?=
 =?utf-8?B?a2puaDNPZEVYMnd2Q0haMVBBN1RNM3ZGQkVGVC9mTVhvT0dYY24yaCtHMW5Z?=
 =?utf-8?B?UVdDdTB5bWN3SDFZRnp4ZXJUQlNGeCs0a1p3U0FqMDVNR0o2aGFmYXdhUFhJ?=
 =?utf-8?B?SktIcXFqWXNtRzhZekhaU0RXL2RNWUxMMWloWUw5UXBPRlNsNzR3bk9uS2pR?=
 =?utf-8?B?Q3ViNDBuUGhBa3haL0xaWm02Vld5U2FEYjBnby85MVZGOFFLVWhadmVpS1Bq?=
 =?utf-8?B?NzBLREgvMnlSckZ6WFVGOVV3UVp3U05yemlUemZZaTJIRTBQTTFQc3pyNmpS?=
 =?utf-8?B?UGczallSTjNxYmdOZklkdjZORzF4a3FKcjFUTG1aT1lUanJOT2k1UERsR3Ax?=
 =?utf-8?B?UGcyYkJ4RDY5WmdPNEFjYi9MZWZuTEZCallNM1VmZGVZR3NLOC95RHFPeTdY?=
 =?utf-8?B?ZnA2L2RMcjVtVkdMd3ltdVhTQ0U3aHhwcHAzOXBjQ3N6elEreWxyZ1BWSzNl?=
 =?utf-8?B?N0dWMWxjeStDMzU5V21ZVU1GSHYrK3U0QlplVE5TSU1lekVXT1k4TlJYeUUv?=
 =?utf-8?B?NmxqY2JkSUgwaDN5S25vRnRUQW5SdGxUQUJsa3Q1L1hRVnNVUGxkU1UveGdD?=
 =?utf-8?B?YVVhZ3V3M3N0bjlHK0hTbzhONkNhUzZjbi9wdGwzaE9CdjBhWmpad3JBNjhG?=
 =?utf-8?B?K2xoR1lTc1FkY2xJbUJoOUdGU0FpeVpoaUV4eDMyelFTeFMxWDFrUVIxa3pP?=
 =?utf-8?B?S3VWZzNSTFF4Uks2MVJUeUtVQWEyZnFLSmJMRnpGWDlyaEx4dFpzWSs3c3Fu?=
 =?utf-8?B?bnhrWkJqRURJVXlHWmdtdlE3emIzTE9ieE5kR0M4WktTVkl2d0FOb0ZpcmtZ?=
 =?utf-8?B?Vy84QjJvdXRJY3U1K3Bndy9tY25vOVk1MWs4eDJhNWI4TXpQK3I3NWtLZTdv?=
 =?utf-8?B?SGJ2OHpYbTB1R3dwSlNKcWMvUlMzdDl2cWRweGNsTVlGaEt6OEdGN3lrN0py?=
 =?utf-8?B?QS9xaEJPRVdtR1FxVXRjdnhDWWJDOUhWMkViOElmaUFCNStITFZhWVo3Ymx2?=
 =?utf-8?B?WTlTMHZQaWxoZ3hEQlNRQk84aVZEODVkaGxJUTJ2N1NvUVFNczRTSXlkKzlv?=
 =?utf-8?B?d29JeWNvaW5ZZEsyalBDUUFYWXFhNnByaW9SRTNqTEtIVEtoMEI0WlhuSGV3?=
 =?utf-8?B?aXFPditGcU91RjA0Nmk4c3cveHU2KzRjOUgwTkIrT1hMNi9HdHZKZDZPMVdx?=
 =?utf-8?B?VVFnUGYwMXNpbE1OcWUxcmtYVVQrQS9kN2pMUUlHVGY4ZFRsejlWTzBPRVpv?=
 =?utf-8?B?QmNURzZKMzdmWEw3OEw1RUhLVWNZVUpqTTJYUWlscGhnUU03emZzK0ZXenVO?=
 =?utf-8?B?ZWdJa3lNYWMvU05xMzlKWm4rOXZHRndINkJNK09jNkR1RFFmYXVOeWdRZEV5?=
 =?utf-8?B?OWdCeDA4ZHVITUFJSW5uamY3VDhVTys3MDNyTjl0SklCQU1zYWRYLzRZUW8r?=
 =?utf-8?B?enBsNlJXdkNEV3lGYkxCU0NxUmVjQTdJTXhnQXhCbTdFcHhUOWVvWjdyVi9r?=
 =?utf-8?B?eVdkUTg1ZVN6QWJabythWkFMRmt0OE5jamxvdXVKK1picEFhUnRmMTFPY1pF?=
 =?utf-8?B?SGRUOHk4RWNtb3NuUWVvcjJ3aEVHN1RYbG9zK29kSjVFZUZXTWR2OFNmYmha?=
 =?utf-8?B?UlVxbURrTHBoTmlQSWF3bnhjbjRock56amF6czNDcHNrbjlpODQyczl0MHBz?=
 =?utf-8?Q?Pbn8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af4b9e5-ba50-4a91-2294-08dcf9c8e20f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:27:16.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gtkQKvmiGvI98OyIatVYcmvRcEYlgXl3v6i6O2ByG0jjg49qgoajaEGNbPFX7JKg5nJvj9/3gAVT1wDlflBzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

Introduce the pci_epc_get_fn() API, allowing a custom filter callback
function to be passed. Reimplement pci_epc_get() using pci_epc_get_fn()
with a match name callback. Prepare the codebase for adding RC-to-EP
doorbell support.

Add DEFINE_FREE(pci_epc_put) to implement scope based auto cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- none
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++--
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f0071092550..14e6011df4b2c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -48,6 +48,11 @@ void pci_epc_put(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_put);
 
+static bool pci_epc_match_name(struct device *dev, void *name)
+{
+	return strcmp(dev_name(dev), name) == 0;
+}
+
 /**
  * pci_epc_get() - get the PCI endpoint controller
  * @epc_name: device name of the endpoint controller
@@ -56,6 +61,20 @@ EXPORT_SYMBOL_GPL(pci_epc_put);
  * endpoint controller
  */
 struct pci_epc *pci_epc_get(const char *epc_name)
+{
+	return pci_epc_get_fn(pci_epc_match_name, (void *)epc_name);
+}
+EXPORT_SYMBOL_GPL(pci_epc_get);
+
+/**
+ * pci_epc_get_fn() - get the PCI endpoint controller
+ * @fn: callback match filter function, return true when matched
+ * @param: parameter for callback function fn
+ *
+ * Invoke to get struct pci_epc * corresponding to the device name of the
+ * endpoint controller
+ */
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param)
 {
 	int ret = -EINVAL;
 	struct pci_epc *epc;
@@ -64,7 +83,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 
 	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
+		if (!fn(dev, param))
 			continue;
 
 		epc = to_pci_epc(dev);
@@ -82,7 +101,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	class_dev_iter_exit(&iter);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(pci_epc_get);
+EXPORT_SYMBOL_GPL(pci_epc_get_fn);
 
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 42ef06136bd1a..682808f4510be 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -266,7 +266,9 @@ pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 					 *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param);
 void pci_epc_put(struct pci_epc *epc);
+DEFINE_FREE(pci_epc_put, void *, if (!(_T)) pci_epc_put(_T))
 
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size);

-- 
2.34.1


