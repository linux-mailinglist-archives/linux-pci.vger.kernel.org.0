Return-Path: <linux-pci+bounces-14594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3E99FAF2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0191B21C1A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C21B0F3E;
	Tue, 15 Oct 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EQv1ylZq"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D41B0F39;
	Tue, 15 Oct 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030094; cv=fail; b=PUIZBdGzDm594/mq9PotPFNjxCQdhhFkyD4wiDBJgPzpw52rifU62gNZZL4D/FlaGN5WfyqhP9xN0Y6urNGRNHrT1MiiVWqJskPC0LblapwWeOI4FYL+bUR2tlK70SJO2IcbEsOJqa/2DslY8VknYtzx1fIqkY5vivHJFLKvGbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030094; c=relaxed/simple;
	bh=pJGXreHYbzV6pOZjMjyos+FLFaeZcfFY9O59zMqECaM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kYf64tjHUKZIU3nDGBnahWUKXcRgJZM/ywcWbwdf1mR7+s33yoAgqzal5Kc6+1UQyg4mK8Y1VY4BeuFc5lKlHC+3H7IBRDLwJCAhAOzQnbRYN4D10QhrZ5sZ+N1Ty159273OU+GxBnQK9EM2S41VOdhxTLUmignBvZlmTUDHaLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EQv1ylZq; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAiFxKdSqpCN8CKwUV/K0lx+Qq7LMXpW1mEtgx5lZKinQqlH5jx48RsE3NJr3iGhDoM4w3WuTtFbU58njp/QY1+txU16nx/rLKYWs0GCH9iaajotZiR119YF/37SNv+M/ddsjDFKikdUK4XWqu6xHH5E0qtZpkSZdLQwcf5cj8EpUJqjyKn4xA/BVcCLLrmSICc7Uu+lXwGPu/3x7q97QMR+u+QQrfew2G276CZUgUkMx6Bo2+sSRnHXtkrv3lDcc91olHoyxsKS2ZEY8mPZC9OGJdu7CFMF/8uyL5rZYpkxXX14l8Pj01r7pZxFq3dWEg9FF5xKHXIQ3jqsJim/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/9JpupgQ96f5TjTCekrzDyc6NamB8T99UcVfyvl6zs=;
 b=yc5QM+Uc2UDJ3zef1PrFbV9rzdPkfHMh5uwLP/5sesPL//Slp06OGrPYZJCVIZNSwrym5s5YVd394sDoIsQGA3GV9LhBGcXz2qsLH+nRtbX2T7ioJgnXkRHxnLM1rZ6+ALdYkFFXNA6FKoLOxwSEIKro2rKKC2qsO514QWRhB8eUt2le28rCNjbDxvhZLMIGE8gZv7vMEhPoWjZ3W8vMab6LLLVzcz2GnmNKxAL6HZ2+61Cv/J3siKF24zK7S7C4Beh4yUyQClSEc2k1H+pxDcyw7sjPI8x/HW1uKNihgndJjjh48vED0SA2IhKMLM1xwJN639d9TyqvYgZEqktOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/9JpupgQ96f5TjTCekrzDyc6NamB8T99UcVfyvl6zs=;
 b=EQv1ylZqRJcBPQUkLhWitkuXX7l7WXXWjUBE8UhikB4AB/17q45CNcikZsSLePKrKqOiI12ErRvcEEGzpih1x75FYBwQD2DLRl0qIl1RLGFqyl9A1p1zIm/kvk4bp4J2L0eaVMtCXl5FC4F4FVZjIxlbxXizh1LRb9u+qykR+ov8SrpVaSUbGQubBSG56fotnEMlKsod+AAi7CXhd0IKXGNY5d2rE29GpZD5fwBIMqJBurlZrqxolUvahrh2sNbiLoVu4QjMiuz3Xecf8PfLRbI2lm2qjV5qe8nZs8zm/KbxfzPEVezHah+X58PIUdlHBVnJGick3zAsyiW5b+eSYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:08:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:08:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 18:07:16 -0400
Subject: [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
In-Reply-To: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=7041;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pJGXreHYbzV6pOZjMjyos+FLFaeZcfFY9O59zMqECaM=;
 b=9dOrBghNwgYKOSVoqa8ePrZBzQDXnWv6v/HGCIqT7GzqcBEt9LHUWSxbT6pfSib+3KLFYAbBB
 vPLB7hWFMFzDDskU5XhC97dPP22qC6YYuQUQtXRRIThRJ94AXPCYBGf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a96be5-ef53-46dd-4b1f-08dced65da8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlV2aHZ4bk1ONjZ3ODlFVW1FN080TElIelNuc0VxZTB3SmNyaVBZTHZwNFdG?=
 =?utf-8?B?bDFWMXd0cGdIRlNESzVmNis2Z0hwZzlxV3JyRld4bkRPSUJDQWpCdDFkdmdK?=
 =?utf-8?B?a25NWHdtc1ArV0V0YVQ5RWE0ODNDUzE2aHl2Wm5qM1ZyMStpUWN5VmtTeUha?=
 =?utf-8?B?L0ZKeXpIbmNsYUh4b2NpNUdFVk9nbXNDSUZLbTVScEpHendnQ1l0ZGQ2Wllh?=
 =?utf-8?B?bDVtZE9GV3pZY01XbHRuM204VW5QZGJsZXRrdDlRTTRaM3BjcWM0V3FCSmxN?=
 =?utf-8?B?WHBYQ1p2ZVFSNHZ2Yk05bndXVkJQY0Y4OXVUQVMwWGpKdGx2dlYrWFFjWDdI?=
 =?utf-8?B?aysrM2lrdW9LVjBHRWRVMUZzMmpicnpYOFNoUVczRHBkbWFkVXFaQnljejkz?=
 =?utf-8?B?ZzRvMlg3dXBRMTJIRHJ5bWw5Rm8wUlJlNlI5NW9MbURZbHFjN21sTWNoUEto?=
 =?utf-8?B?dUF5VHJtWGh2M3p4K3YwcGJRNStFRHpMRjlkdThDc2NiMzlyS0hENzMzWUVD?=
 =?utf-8?B?Z0VpZFowOEZYejJlUmQvQWtjUGFaMy8wM3V2OGlMUzRyaXQwUWVSVzM0a01n?=
 =?utf-8?B?TEJUOGxORVRKeDRxVlJqc3VsdHRkUGRwcE9LbjhNSTh2MFhURDhySWIvU1Ra?=
 =?utf-8?B?YVFCVGx4UGlydzdHeUZYaUZUSmZLMjhPczcrNTJPejNYamQxanozL0hheDNB?=
 =?utf-8?B?SENzRU9zMWwwY0hIN3FQNGhGdGdES2RrRnZ2SWZraUtkeE0xQ1lCMlBldC9P?=
 =?utf-8?B?NzQrVUVhdUVFN3ZXYzRUT3BOWXBVTldQU0JRUml0ck9uSnhmVXlZRC9MdXFZ?=
 =?utf-8?B?MlBMa3NKbTdxRCt1YW5NaTZKMnRMdXpIakhHQ3o4VGQrcW5tSS9LRkFxaStL?=
 =?utf-8?B?YkdDbUl6Rzd3NTc0NGdocW9FU25hSjgzWi9KK0MxSkF3OE1YYkp6Z240aDFx?=
 =?utf-8?B?NS9xNVNxeGZsUjNpMWJINW1iWEpMQzdsbjRwRjFRdGo3Y3NCbEkvNmVGQVpK?=
 =?utf-8?B?ZnErcEpYYTc4Q0UzNEhEOXNWS3pFVFFrR1ZYZW5qaVdVWlpqZE9WWGF3UUpl?=
 =?utf-8?B?NDRSc2ZXMk9uSG5UajJ1dzVIS2dYYTZhMEkzci9HVzg5eXJQL2YrS2UzQk53?=
 =?utf-8?B?NTM4b0xTRnZLekt4UmF6aTBMWWxyQ2Rpa3BmaHhTTXZIMXE0N2R2T1ZyeUlw?=
 =?utf-8?B?V2VaZnhRaWlwc1hDRkVFeC9rV2dZTVZUSzFpbVYrU2NUdzdIYVZyTGwvd2ZK?=
 =?utf-8?B?NjBDNytGME45YnI5RHVTM1dPQTQ4SmovMkNzaFQvZXp4VzhxaGF4TVVJVWRi?=
 =?utf-8?B?SEhTTTBZU1BFS2ZLdnpjL0VWQUlEL2ZQbHFvNUVpbDBpTkt4enY1bGwybkh2?=
 =?utf-8?B?WnFQL2FIZURnK3MvR0dxQ2NEZmNsWEdOczFUNEd3QnlObXlXUThmS0c3MGVo?=
 =?utf-8?B?dUJwUlhPVzhNdGVlMzh2c0gzL283ZTFBZFBkUHZHYXd6cFA1bTl3b2lUdk4z?=
 =?utf-8?B?YXlDUi9MbnBZc21FTnRkQnE3NllyR3BUVkM2QnR4NHV5S3BXbTNha1lmaUND?=
 =?utf-8?B?MnBsemZkZkczVXY1QUVwYm5uRmpQMGtvV05PRzNsSGJoWHZpWGtzdm45VXB0?=
 =?utf-8?B?VXlXTlUxdURzOXZlcUdscWtLa0xSOXVVR1JoWlJ5RU5kRk9XODc4QVlMaklX?=
 =?utf-8?B?SElrQjhnbGNOY0hyV1BOVVpMTjlPY0VLZlFXMkVTUlk2eEtsVTJoZnJ5RnJN?=
 =?utf-8?B?Wnd1SnJTaDJDSTQ5Yk5jQnk4Yk83R1pIRHlwTkNkbFpDZXZFWHdBVDRQVkFU?=
 =?utf-8?B?Y2sxSVp1RzVBL1VTdGVtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU04R2ZLWGVzZExWMTZxTE9ncStHNUp0WGdVN294V1o4QkNWTjB6NFMyeXk2?=
 =?utf-8?B?QlM0R3poVTBzRlFDVzgzeWZFTUNXTzFLWjlCL1g2TWxwdmlRcDh2MkY4UlVI?=
 =?utf-8?B?ODUxUUY1NzZ0R0tMSVV6NytjWkIyQWtESnFicEV6N0x3anRxYktrVDZTL3lL?=
 =?utf-8?B?N2FhbE41MG5NaTJPTFFOOFlPM3JkUjFwczhpNmNNZ01YR2RycG1oT2N6emcr?=
 =?utf-8?B?dnJ6UWdnZEVIcmR2WHVyUStrb21OVXg1cW91K1JXbFdkb0U0djZLWWt6U3l3?=
 =?utf-8?B?bksxZlVGS2wxTk5xamZWMklzWEF0K0ZsTER2WnZHOEVxTkRueUQzU2p0VUVr?=
 =?utf-8?B?cUkxdUEwakFwYUg5RkdiZXZtbVZORTlpalJlSkd3Vm1NOVQ5S2ZzZnVUelFF?=
 =?utf-8?B?Zzc4TFhWc3B4UzdzRWV4ak1EeHhPMlNxRkYxUVQ0bXk4dk13TkhkY2lBdHpl?=
 =?utf-8?B?M0xBM05TMVVsSVhZdUhiNmRUNlRKTkV0UHZvNWhlTS9zYnM0NnVKMVlFck9R?=
 =?utf-8?B?UEZNLzd0T3J2bWxrZWtpMnRGNit4c1dZTERrN2kyYUx2eGc1TUdFZS9YeFNE?=
 =?utf-8?B?UkxKNzZFYmQvVHV1b2hXdVMvcXMzZVh5MzlXZG1BeHBYNWtPWE0ybVdqVitZ?=
 =?utf-8?B?VVFOQTF6RWpTTzQ3ZGlpL211RmJBVHE4cFBBL2VseUpybWpib1JoWDlFeDdq?=
 =?utf-8?B?dFgwV2ZFcVE2S3NvUW1vRVl4K1k2RklHWTFDbmNzUlZqK0RiKzFQSExjVUhX?=
 =?utf-8?B?c21BV0RKLzNKeHAwaklQNGlLZjgxTTJSN3RHMXlQcHBFd1ZJUWs4QjdRWmhm?=
 =?utf-8?B?eGd4eG96RzJQbnI1bFIzVW4xWVMzU1NpQjRMMXgxeFJtUTVwVDlndXlHMUpo?=
 =?utf-8?B?ZDAwWDZPeGRsc3lBR2NSeFh2SFdSS0ZGVGZ1UHhuS0t1MDRDcTd4OU4xQ3Er?=
 =?utf-8?B?WVpsKzc5ZjJQYkhQTzVCakd3dlFxTXZ2RXExUHZURTFEWXRDVnRtTi9SUW1C?=
 =?utf-8?B?eVp3L0R1REdzcXlXUnprZHNoSzdFSHg1b2paY05SaUd5eVVhZ2Vnb1hOL1BF?=
 =?utf-8?B?eG1BdlgzUzRTZTNsNVBZSmNwdHJrdHRFWGhXSUVYR1pqODIxNVNxdVZnMFNY?=
 =?utf-8?B?bE9rbFdtRzhkbnZacFNsOFgrSndUYjhHRm1nYzJZYXZCK0hURkIxRlBWM0dw?=
 =?utf-8?B?RXZRVzNUM2tMWEdKTndXY1FzZDRMOWlGeE5QK2lVMGUwOGp5Ni91dnFsTDV2?=
 =?utf-8?B?cUx6Y3ZhVVF5TDNIbEJHQ2NzRFdQcE9wUWc4b2s3T3VPU2RLZTljekVqbHlU?=
 =?utf-8?B?Vmx6MkNoZTNtdE1hWjNJNW4vdStCODdVNmh1Y3cwcWNzdjVwRnZpRC9VV01M?=
 =?utf-8?B?djZ2ZitzWW40YSt5UEkycDZlVXFzOHlzTFZkSms4NnpLbW1NbmxSUjJ3UFdG?=
 =?utf-8?B?N3lNMFZJRnV1Sk9nUFdMREZwcFMyRWRrc0V4RFI1cGZ5U1BHazhpVTFNK0Zk?=
 =?utf-8?B?VFlSeGtTOW5MaVcrMTJiTmJSM3gyUmM4bEIxeStycTBkRzhscmRmcGFxU2hS?=
 =?utf-8?B?WTBBc29oVlU3d3lobDFuVSs1Q1ozb1o3UXFoSmpuZ0dYV29iZlN1T0EwMWhU?=
 =?utf-8?B?MXE3bHNBSC90dEZkd3MraHIwSU1QTmxvT3I3aDJaRnNDN2paTzkra0hFQkIy?=
 =?utf-8?B?SVAyZE00eWpTNnk3UElUVEdkMXAxUmxIZzNtODdUTno5b2hrdHVIS1hJdWZu?=
 =?utf-8?B?MnpRdm9rRXdLeENBeFFCWjgvbTdTZWdTZ1BpbXczZGVtUHVIZEdPeGsyZHlk?=
 =?utf-8?B?Q1BRaFJLd0xIcXNBOGM1MEw5L1FUN3dXTUU4Mzk4LzY3ZHVMU29UWlR2VGJ5?=
 =?utf-8?B?U0NIcmNMZlRFK2ZQelZSTmN3amk2bE5FU2tVRVhUNU9xeloyczhtRm1VSG5s?=
 =?utf-8?B?V0dNSFNBOG9ZNlA1ekhsbHU2c3VrOXVjeHpPR3BBM0F1S3JyMzJQNmliLzRz?=
 =?utf-8?B?R3Y4Um50TTA1eGlQSHRPcGw3bUdhM2JMaDRaZW5TQkJuSVBJVEJGWUV3ZWhu?=
 =?utf-8?B?djVTSEFXUS91dGJWY3B5WHdEOWlrSGRjaEFndVRMUGlBenFtSXF5NldzWGN1?=
 =?utf-8?Q?8kPE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a96be5-ef53-46dd-4b1f-08dced65da8a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:08:09.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anXZuXv0Mk3VoQ/cpQ170Bm3Y+J8DB9mSvv/Rk8XtTiRnomNnrB0uIqPhRSjGLUJSCX5ggjcl1XQgRS5Z0ivQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/Makefile     |   2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 162 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |  15 ++++
 include/linux/pci-epf.h           |   6 ++
 4 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..534dcd05c435c
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include <linux/msi.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+
+static irqreturn_t pci_epf_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf *epf = data;
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+
+	if (desc && epf->event_ops && epf->event_ops->doorbell)
+		epf->event_ops->doorbell(epf, desc->msi_index);
+
+	return IRQ_HANDLED;
+}
+
+static bool pci_epc_match_parent(struct device *dev, void *param)
+{
+	return dev->parent == param;
+}
+
+static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc __free(pci_epc_put) = NULL;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
+
+	if (!epc)
+		return;
+
+	/* Only support one EPF for doorbell */
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+	if (!epf)
+		return;
+
+	if (epf->msg && desc->msi_index < epf->num_db)
+		memcpy(epf->msg, msg, sizeof(*msg));
+}
+
+static int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_db)
+{
+	struct msi_desc *desc, *failed_desc;
+	struct pci_epf *epf;
+	struct device *dev;
+	int i = 0;
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc))
+		return -EINVAL;
+
+	/* Currently only support one func and one vfunc for doorbell */
+	if (func_no || vfunc_no)
+		return -EINVAL;
+
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+	if (!epf)
+		return -EINVAL;
+
+	dev = epc->dev.parent;
+	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI\n");
+		return -ENOMEM;
+	}
+
+	scoped_guard(msi_descs, dev)
+		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
+			ret = request_irq(desc->irq, pci_epf_doorbell_handler, 0,
+					  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i++), epf);
+			if (ret) {
+				dev_err(dev, "Failed to request doorbell\n");
+				failed_desc = desc;
+				goto err_request_irq;
+			}
+		}
+
+	return 0;
+
+err_request_irq:
+	scoped_guard(msi_descs, dev)
+		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
+			if (desc == failed_desc)
+				break;
+			kfree(free_irq(desc->irq, epf));
+		}
+
+	platform_device_msi_free_irqs_all(epc->dev.parent);
+
+	return ret;
+}
+
+static void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	struct msi_desc *desc;
+	struct pci_epf *epf;
+	struct device *dev;
+
+	dev = epc->dev.parent;
+
+	scoped_guard(msi_descs, dev)
+		msi_for_each_desc(desc, dev, MSI_DESC_ALL)
+			kfree(free_irq(desc->irq, epf));
+
+	platform_device_msi_free_irqs_all(epc->dev.parent);
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc;
+	struct device *dev;
+	void *msg;
+	int ret;
+
+	epc = epf->epc;
+	dev = &epc->dev;
+
+	guard(mutex)(&epc->lock);
+
+	msg = kcalloc(num_db, sizeof(struct msi_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->msg = msg;
+
+	ret = pci_epc_alloc_doorbell(epc, epf->func_no, epf->vfunc_no, num_db);
+	if (ret)
+		kfree(msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	struct pci_epc *epc = epf->epc;
+
+	guard(mutex)(&epc->lock);
+
+	epc = epf->epc;
+	pci_epc_free_doorbell(epc, epf->func_no, epf->vfunc_no);
+
+	kfree(epf->msg);
+	epf->msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..f0cfecf491199
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..1e7e5eb4067d7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -75,6 +75,7 @@ struct pci_epf_ops {
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
  * @bus_master_enable: Callback for the EPC Bus Master Enable event
+ * @doorbell: Callback for EPC receive MSI from RC side
  */
 struct pci_epc_event_ops {
 	int (*epc_init)(struct pci_epf *epf);
@@ -82,6 +83,7 @@ struct pci_epc_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bus_master_enable)(struct pci_epf *epf);
+	int (*doorbell)(struct pci_epf *epf, int index);
 };
 
 /**
@@ -152,6 +154,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +186,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct msi_msg *msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


