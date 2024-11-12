Return-Path: <linux-pci+bounces-16585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4C9C63C2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7CBA0E78
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ADF2161FE;
	Tue, 12 Nov 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YO+qyqiK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C595215C68;
	Tue, 12 Nov 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433732; cv=fail; b=j5T/XHnMpMJio6LwciTLNKdYgzfX1iryDj12El1lvD/DBJrE8XtWSLGvYBpLjmz5C1nnBCvE1ubhlhlro0uwGDXsktGPvunLr7y9LLeFzuTy69EuruuaDHOarn2/MKgm/3KsJ1XWtWWKoII3Ryf74npI6wpM3Z2h8sWcmmuZjHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433732; c=relaxed/simple;
	bh=ZboQ2BLdOqWIjNgy+b+PZ+LgoTnTNET8wgnkrAQY6wg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g30GJpfM8EajFa3eUY4jI/oKa0v7Xnjy4f91d8ZBBaab5VlBRlx85UoUFNhmyzhCUBTHtb3RPYNP1kPf1TzivbCoiBMwdIvZmkvsIH+tTX2dkEyVLe7awZvPtmgBNW1Bg/VOGs871vnRdbuxpZFgXlpz+0DxDO1WUORKAUHcW0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YO+qyqiK; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpafnaNq1thQMsohp95tWbTl8RfjvJbMzImZSnAhaWaBpzGwZDVTUUUuwuox6bd2kZh13e/a4wXdRr96DR9C3Tr6S3H4sXrCFmWH8Yi6tnFJ1Sh7pn6fGH52hSwPLAzloCnNUbzD6TBptW4iAUq3/4dffRePtpIplq8uhjUxkdE62IL6YbHPE2emUhd8A7wjyBecwEjaJxILlc/YRo410+IRxT5z+h44A9lPX869lOGLH21b0T1B8mTDDTSKOKLnwedFpViMB2ErzV71NezVTBbnOQd9A0s+M9PfXybAp5SpwUaU/vTz0LKomFyQOEXjG8g3L3Bn3eitqQb52vxXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbS6BZ0dBH0t98ywhMYkZJpXtEPbuws6K5dUXf7jGA4=;
 b=UF5Nl4qNYqh2q7vNaG7xuPil3GlMGPLjy28ioMQTE9UZFL+hA5EvYxIQIK8ZDYqVuVmHQeN2xDUtEaEmjr5iUYpUTuErd8q+xvEd3aabtcy4ZwPgAlD5cnksjU3DZQkojm/WLNB+E96bN5bdytRHq9AIof7Xu2fNfdgSmgSkI+QbQgsVlAoWWMP912AfcmiM0tpqBH7Qcfxa2KW27ySi8Iu4jH1R12ZEe6dQm+4Kb+nOcaSBd1J9XG8xRMcOdPLYWIdhcBxJx2CfT0/TwYv+e2ma7u4LXDSHJQwNeIxdZr6M34vKXcZ3506UDCPjR33WThdW3xMsDdWRtdZk93DTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbS6BZ0dBH0t98ywhMYkZJpXtEPbuws6K5dUXf7jGA4=;
 b=YO+qyqiKcHnfwqSj2N2FAe0+ZMKcw4DP8N+OIMgF7E5tjHou7CWNGZTHcvsIPM5EzC0ssbeE/3gvf3YQW85/JI9vCDQuXTarFHsA8PcqKoeZKUU+DAWN+ImNn48qxRl1neAUR2cvt1QkjO6XvPS/kJQlbbdmj59ntlLexpHaSVlG0x2JTkJJYyk2LwOjZea6HYYEWNGOreR7GEDC4O84MyZSgY9fpP9dFS3vowpWlNlgeL+b5wTvImf4QuPGgS6LWUldDy1+8hKzHq3zSNm0avSv1ZYL5yWsoqQmQbd17Wkyy3+O0AhSrZE7gx5CIvqIAB6bCMx2wXlbk0j7EttICA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:48:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 12:48:16 -0500
Subject: [PATCH v6 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-ep-msi-v6-3-45f9722e3c2a@nxp.com>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
In-Reply-To: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731433711; l=8063;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZboQ2BLdOqWIjNgy+b+PZ+LgoTnTNET8wgnkrAQY6wg=;
 b=ELGVxL8Z2myYje4lYOAdqm3c4pSGwfuVY6xoMVvHgB1SUJAjTg3fok7nhgoXncXra867E0pno
 eqJtYjV0/cFCh9iiUyCSfBzDCNq4kalulBiksXNdbKbtqVmcLVsrju8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: e412afbc-5244-42e4-8986-08dd03424244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2NjdEVhQkRpY212bWhEVUUrSzRaSHRqZTBUWmc0SjBWTXplTnBOTUMzMmMw?=
 =?utf-8?B?S1RPblRrVzZ6MjhncHZ5L1dmUXZudzBZUEdlMWtsYTZDeEVkZ1VqQWRPU0lv?=
 =?utf-8?B?cmY4UFczNTJNNENHVEVoUUxFQXdIa3kraVhkL2VEZms1bEpmUDBpV3JLdnZp?=
 =?utf-8?B?UWJGMzlKWXlmclhrcnczWk80TGVRWDE5YS9TZ3NmM09hT1BsRm5FSS8rOFpF?=
 =?utf-8?B?RWFHQS9wTmd2amh4Z3ZoOXl6RmMvUXdGMm1qbmtqVkpaNms5UzFKU2xEUzk2?=
 =?utf-8?B?VUYwcmdVVmtVQS9VWUtkbTFOaEpiNk5nbEFMMUJSV0ZBVHIrOEpxcTdaSjJG?=
 =?utf-8?B?SnRMMk9OYk1pTVk5UDlGQXE5OFRqaWkyOElRVXpsejMwN1RVckJrR0VqM2xP?=
 =?utf-8?B?Q2VidkQwbHUxYVNrY056WVptQTB3dldxbmkwcFp5T3Bod2gyOXlncmdGLyty?=
 =?utf-8?B?YnRsZDZ6akV1N1lyeHNRd0ppWnFDL2RxWVk3WlBMeFduMURDekFadkRDOUxX?=
 =?utf-8?B?czRZTEpPdUdkNm5LemZXSGoydnVtYkdpdjYxQSt5M3ZWNXZpOW4yQkRzNjUr?=
 =?utf-8?B?RTNzYUdGZm5DYVFacFMvcVhwUHRDS0k2bElURXNQY1ZVV3ZRWC9CTm1MSFZJ?=
 =?utf-8?B?bk0xYzRmNXBTbkc0U25wcmVsblZaVzFNOGE2amg4dm9yQWxCanNRbE1tMjli?=
 =?utf-8?B?c3Z2T2hndTU1ZC9VMGJocDZZUXlhTEFiakNCemk4NjN6ZnJMeER1VVlFajRW?=
 =?utf-8?B?dkt2QVpuQlBNSjc0ci94V0ZiVVB6ODh6d0srd2UrdEFSS0Nzc212SlBRSC9I?=
 =?utf-8?B?RVJFdnFiK3ZTMG42WW50bEFNRzBHcU04TllsYW94R005cWh2MWtxY0RJdnhr?=
 =?utf-8?B?bjZ3NVMrVVoxZWpQZjMxa0Myb0FpclhWRTFoQUIvZjVTcmNxL0hlWGgwTkJW?=
 =?utf-8?B?ZW5rZ0R3cjlKMEliZXFuMVorRjVYNGpNUytjUWlyRGtkcVZrNkQrYW1Gajdx?=
 =?utf-8?B?TXNRYXk0SXZzRFBrUkpKbndpUHc1WGluOXEvZ1dlTzlzSlkvcXduRGg1d0p1?=
 =?utf-8?B?a3lBRGZwVUgwOTNMSkdGZ29tc2M2Tmt4bDY4TmFWdjZEYnJ0c1BlM29CR3Vs?=
 =?utf-8?B?dlNRbWJKV0tyZTZHTUJNYU1PNWl6bXpqS3VNQmcrZDdnOGxuZjI0Qk9adkNv?=
 =?utf-8?B?NFhway9aemVZTDRPZGRNSVlqamZmaVMrUitPalArY2lzQStMbFFoZEx6ZTR5?=
 =?utf-8?B?RWRwTFJycGVqOTdsaFhGdHNHaFhPR2xKd0YweW9CeFl2dUtpZ3p6Y015T2Zr?=
 =?utf-8?B?d2Y4NHhuM3JlQS92UzBkb2tOUVk3cDJIbXNYeG9PWmJKNk91U0tLVCtKTk4x?=
 =?utf-8?B?VExXZXg3dXNZeDVSM2szOElibGxlVHRhV1VWdlBLbmhCY095TnNOcWE2L2Ru?=
 =?utf-8?B?cTFXMDJnVEdmQ3M0MklaMXliREsyMTR4aG9pbGh3aVV4SUNLaUdHREJPdW1R?=
 =?utf-8?B?WGcrcjA0bGxJYlJIZzhmcTk1QlpSeG9md0RNdUlPN254TGhXWWtnelBQdmpP?=
 =?utf-8?B?WmtwQzdEWXZQb09ZMFpCb2M0SndYcHpFd2dJV0VJZERlaFIvRGxoNWRxRzBV?=
 =?utf-8?B?Q0xpL3N2YVdPK1lQRjd2Vkt0RGl6cUttcGc5T1JUb0FQZi91c1JUVklmSmJI?=
 =?utf-8?B?R2U3UGZQVVkybDFRdlFkMXQvVkNrVXBzWXRSUGZ2Sk9wRzNWbmRMcmdsUUVt?=
 =?utf-8?B?MWpUVklUOVhBK3IwMnZSaFhVeWV6ZTl5eDZabnVDc242SnljOGVRa2VyZ2FG?=
 =?utf-8?Q?Rx3qpCZlE0HJOrud1VkA6DeKm8YlXO1NFS/uA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEc1WHo3bmJ0YVNydVhwb1c5WG1ZRlZSUmhHdjhyaytEdXBVQ0ttMm11NExt?=
 =?utf-8?B?Wk9sSHRselJobzNXd2IyZU5TSTFQY3F1N2RvNll1bU1raE11dzFKUk5ZV0Jx?=
 =?utf-8?B?WGJOR05obVRyRi83SUVqeW5EVVB5c3ltQWdWRC9rSkRpdTBGWE8wMFZScmk4?=
 =?utf-8?B?Q05VWElJdThjdkZUQmNhVmNhOEtBYlFlRE9OYnl2MU9tVnZVSmd0dXBGM2JT?=
 =?utf-8?B?cGZpRDgrQzhpRWxVTGltd3BJYzJ5SUdvb0phVXJTblNZamJnT2l1YWJ5STVE?=
 =?utf-8?B?MnFobVVjQU03S2tOTUloNFVveFJZamh2Vkw3Nk9PaGl5VndFV0MvY3dxUTda?=
 =?utf-8?B?a3A3Vys0dnhuVm1EbGRhazRjdHJjRzNnanFOWlBlR2Yrek1DMFQ1TUFKRzVN?=
 =?utf-8?B?UFJVK2JPWUpwMXhLTVU0ajF0bWJCRXAwL3lyQnE5dHltV3NCUjY4YUxiai8x?=
 =?utf-8?B?a0YvT1ZHcVduNTdPNXU5QzBIaTVxRUx6TERpOVFGNktkb1JTbmp6QW1uSXNQ?=
 =?utf-8?B?dmd2SHZRY2toVmE3em5IZXFGcm1EL0pwNnpocTcwdVNvbmQrcFcrcjFyeVJz?=
 =?utf-8?B?Q2F6VzgwRmNhVjlTTHpLMGRNd2E4KzhidVZuR2NLQ3VpZnhmQjhUNURxWVZD?=
 =?utf-8?B?OUxBdzlscWJwdVhLSkFtWVFUakdiWXJ3ZXlWQ3BLRE5wQlpkcURJZHA1RlA5?=
 =?utf-8?B?bnlmelpkT2l4TnBDMzlnQjBtY2hqWmtmZ2JPM3N2cVdKd0NvVjhIckMza1Zt?=
 =?utf-8?B?UCtia3FrYWo1YXRjSHJxRG5zUThXVmVMYUhCWG9qeGJqc3pLTC9tbHBOWlVt?=
 =?utf-8?B?azBzdGZOMk95Q1hUMk9aUktMQ21WWFh0b3JMVk1aSk5IcmdUK1l2eWM4YjVC?=
 =?utf-8?B?S2tnN3pwY01WeW1MUUx1T0FyUlhaT29hUkUvdG50MEUrSkIyWXRHaU0zSUp0?=
 =?utf-8?B?ajFzNWpSdEJCN3hJVHRBZ1F2QU5KNTBDUU9aYlU3VWxtYW12MS82N01wcmk4?=
 =?utf-8?B?V1VFUjhkRlNlZUcwblFiZXJ1Sk9MSzUrYVdnZkZOOG1aSHgxaU1tTVI1QUlY?=
 =?utf-8?B?WkRuV1R3bDUxTlE2WE0ycURKSkkrMnU2ZUF4cU1RdTljYmgzZEJDRVRLWmhX?=
 =?utf-8?B?c1ZHZTdHdGZWYVVnRW5OMVhrMHBBbUNUd3pMYjUrbXFjQ2hQTHdWZ0lxUUNB?=
 =?utf-8?B?MVE1ZXlFekZwT0x5NjJHUGRsM25oSlRWeTd3UDRxc3l5Zk16dHNkaG0zV0py?=
 =?utf-8?B?K1pOUGZhMS9ZdTBJZmd0TVV5VjZDY09rRlMvN3R5ZlQrbmJDNklNNExXV1Ji?=
 =?utf-8?B?WU1BaUpBZlJoUmZVQXQ0Wm4ra2ptd3NFRnY4OTNyWnVQbnNMTHJaUXhNamxJ?=
 =?utf-8?B?R0hacWRRR2xsbHAvaVRiT3ZoaHR3YlI4NTh3RDhwR0xmdGhYUnFSZGFlbW9K?=
 =?utf-8?B?SEx1Y3ZJdytmaUVPMXIzZ3RkM1MxbTZIcXlKd215OVZDNWhheXlLZXI2dnZt?=
 =?utf-8?B?Q25FVkVGSDFybnJmVVJVeVpxRWZjOXYzMHg3a3RLb2pVRXE0aFN6L0NJYXZR?=
 =?utf-8?B?VjloRjNGakplSkNGR1dVQkZnNmhCbEtyY0NPZGdqR0VFUmxVNzZtcGg5SzM1?=
 =?utf-8?B?VmhDN1Z0N3BaN3dsVXhkYVZTbFdsVDQyRDVwTTJYSnE4a2JwR1NXMmZZMk1T?=
 =?utf-8?B?ZVNacVBRSzZlaWpmTllUNCtTNGpRWThNRWxMd0NDSXBLRGZ5NnV4eTNha2Vj?=
 =?utf-8?B?RjFyTFNsVHZEM010blFpb2Y4RGYrRXVma0RHS01mYzZYakhhQnlMbnlBdWZq?=
 =?utf-8?B?NFpqT0hhRUN0TklHd2hGZHZnKzROVkxicURzMTdFeU5IT1VFUzFWa1M5TnFC?=
 =?utf-8?B?TG92NHFtYU5vQ2JaTnhYYllMZm5oTi9DZWVtbXYxSlU5MVNROU5UVlpycCsw?=
 =?utf-8?B?ZzQyZkhCZ3RkbWo5cTdiTDdsdDFWek1TYVY0OEFFMnRjN0pPOGtBT1hNWHcr?=
 =?utf-8?B?Ry9ldXFpdUIxK3hOeEp5YjhUcjhqVXBGdkxTZFBaVWd5dmxCMXdxd0FPUTZW?=
 =?utf-8?B?QkVSMG5Nd3ROTkNxR2JQc212OTNvVW5PcGc3c0o2NExFYW9acEhqM0I1dDBM?=
 =?utf-8?Q?d1zg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e412afbc-5244-42e4-8986-08dd03424244
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:48:47.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /InclPP/mKOKVeZ2bSG2d9uXwWAVerj/8vZEhBBFsQZ3Azjz4bkDtQn7Y4AcU89t00Ns62SLKHjYy8xDoC0uUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set doorbell_done in the doorbell callback to indicate completion.

To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
to map one bar's inbound address to MSI space. the command
COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 129 ++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..2d05ab5e4ac6a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar db_bar;
+	struct msi_msg *msg;
+	u64 doorbell_addr;
+	u32 align;
+	int ret;
+
+	align = epf_test->epc_features->align;
+	align = align ? align : 128;
+
+	if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epf_test->epc_features->bar[bar].fixed_size, align);
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	doorbell_addr = msg->address_hi;
+	doorbell_addr <<= 32;
+	doorbell_addr |= msg->address_lo;
+
+	db_bar.phys_addr = round_down(doorbell_addr, align);
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+	db_bar.addr = NULL;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (!ret)
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+}
+
+static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +757,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -822,6 +899,18 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
 	return 0;
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
@@ -921,12 +1010,46 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (!ret) {
+		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+		struct msi_msg *msg = &epf->db_msg[0].msg;
+		u32 align = epc_features->align;
+		u64 doorbell_addr;
+		enum pci_barno bar;
+
+		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+
+		ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+				  "pci-test-doorbell", epf_test);
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request irq %d, doorbell feature is not supported\n",
+				epf->db_msg[0].virq);
+			return 0;
+		}
+
+		align = align ? align : 128;
+
+		if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
+			align = max(epf_test->epc_features->bar[bar].fixed_size, align);
+
+		doorbell_addr = msg->address_hi;
+		doorbell_addr <<= 32;
+		doorbell_addr |= msg->address_lo;
+
+		reg->doorbell_offset = doorbell_addr & (align - 1);
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = bar;
+	}
+
 	return 0;
 }
 
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epc *epc = epf->epc;
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
@@ -934,6 +1057,12 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		pci_epf_free_doorbell(epf);
+	}
+
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


