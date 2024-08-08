Return-Path: <linux-pci+bounces-11501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A263594C23C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB2F283505
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFE190679;
	Thu,  8 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3czJqX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABB190497;
	Thu,  8 Aug 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132962; cv=fail; b=q78CFxzJrifWck1zHBbQyuWVHAt1RRi8g4TSJ4MFyBsoi8HnDJ9trxGcCFZdm8YSrwlZgaIoIm+EROU9MmDpzjzjdzw+kHvTLam9Br+JErVNnIo22x+QNTM8QLaDE8bbbnKaSXw76t04OUicfWvWS1rhhYXE14EtUDOBrJ19If0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132962; c=relaxed/simple;
	bh=IT58rxx6GAnzyh6EZ4QitPY28FLzxZxYWgpVhHaKNbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VQ2qeD3oDETUzAgbjDS+osex9C/lAXKuqp7SKbDo0+2/Fs+/c1p082xDmvwbOcQh6O9jHMf9dg/Qt0Cx7IvFpUVgFDhV4tT4gCg/c78Qsbhbu6MjJ/skPWQQmIpVR9TjEIHcjfMDnU7T+59n8sMX6eM+Pxvrj+HH65IrL/B5/Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3czJqX4; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzrnY5HF0W8ogN0zOWUOUn/ZrK3cadnA9WOS9nL8eYtu5lUFdva/9zSvrB52lrhVty0VXcbOm6rJGJmy3DmK6B9No8ZE1ABmhqg39oeXCYJHekYSCWK4lyDH9nDTjQ1EC50ZGRMKX2Z9mZF2FNop7c0KPfGJUG/n5WzZ8rjhpMnxKoHb7jQtfQW60P4IpdpWl7sIFQU+tYmmeW1lH9XaYKTH5m9FFflBL9GcYDYTjENNTz1phhUfYLmhPCGPlpmD5NJ1UTxuPi5Ju+JIabZiwpHCT+AolihaSIk92+YwDjvnr1GiU93qZtts1tptosKtRlUVYBg/kOPhWCAa+tFPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJffP1cPktpVmM6FnqFa8Gx/n+Dxs02ZuGkd1H1Qokg=;
 b=s/Bav082vPtLrLAAtdHNYyMeyNWM2jZyyhlQC3/k08TIYIp+lPNxR53+er0uw4P0RRMzociLF38nJSI5w7hDz7VYIu55UHv/9PFMjOeoBr/c3/0IssyqpqU2Hww1N5KizdI8LQ71ftt0vUF3QgJP39Re+EZ8PCq25qU5u8i9zNPWQ6U7swHxtt8gmHNcejDs3tTNZ7yLAmF44z1r97oD3iM0G9H3iaMtobKIOI0nEuwSuAg1YklbKteGAIoZLFMKGu1yZQBy9RpjarlIwGePQyZGDT9wui00RdbslGU3Hc/K7q6eiJP6f6/cs6lkd5cLPZS2W7Q8A3Cul3rycw4pHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJffP1cPktpVmM6FnqFa8Gx/n+Dxs02ZuGkd1H1Qokg=;
 b=T3czJqX4GvSP+6kVMkU9gvHDG293FMn0f+1nQokV+jqiPml8xyN1KxU1Chjwhb5W4CInVo8tmaDbaw/YsDKwLcykJaX0o9KeY2eGvR5l0kwWkCJBrO5kxHTj9XUQA+IUiaOVen+u2QZW7P/hq/kpfmofcrpJJW9k8yWMYjSUwVp4S59vnUG+yun946bhzT1iXsncwvXeCa3LRj6ff2gdppus+yJtXZ/Eu/lem8ezjsBpmY839tMIG+adsSalkJpg3p5Xst5uJZS08y8gV7ub6XtWZZlEQVO3faToR/YehRwHcgbAXn5uQxkkN1DrHhGYW+a/ZSaV4JTAxMk4EJZS3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 16:02:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:02:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 08 Aug 2024 12:02:16 -0400
Subject: [PATCH 3/4] PCI: mobiveil: Drop layerscape-gen4 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mobivel_cleanup-v1-3-f4f6ea5b16de@nxp.com>
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
In-Reply-To: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723132945; l=8722;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IT58rxx6GAnzyh6EZ4QitPY28FLzxZxYWgpVhHaKNbo=;
 b=CVEdZtYbfOsojj7KEEMR0N7pWndr+FXQoZ0k5Lhm0NO//dtiaGzO/1CiYKX3feUIdqKm+QMH0
 ZDtcy0ZlO+QDCAs9ZUhA91jS6EfVP3V+IMLyOrf21mPmILC3jxSXmd3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: ccec03b4-715d-4c7a-7413-08dcb7c38638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEtrUGFHNUpmQXhENHJlR3hIbzNINU9yTk9Iek4vZWVLMzNxd0s2Q2VGYnBu?=
 =?utf-8?B?NkFiQzI5ekU3THMxZWZSeWxoYkdkaUwwM1djSmhzNkxnS29sTFJzdHJGMEdC?=
 =?utf-8?B?Y0dvMVlRZXJxNE5Qd0Yxd3ZwT2YvR0xObnMvbzZZWWxESTB2VFFRc3pCMFk2?=
 =?utf-8?B?YXZjSFFWNElYVUpGSldoYVd4RzNTQ1ZRZjNpN0ZVQ1dhMkFJQVNsRm9qOG1D?=
 =?utf-8?B?b29rZWgyM1hJdjQzVklPd2h6WVRuWk8vdEQ0dlhlN21kZUxMS3pCL21kT2Np?=
 =?utf-8?B?dmpLUHQwV1krZk5oYnNydXBOaVJUR2NMN0VZOGFNL01JRUhEOWU5bkI4T0x4?=
 =?utf-8?B?UnR1TitlU1FuOVBrUU5mUjI5RTRPRTVtYy9nVE9qTFFCTHZza3NKcmFFOHE1?=
 =?utf-8?B?SURydHU5UFFQa1RYYnc0RGJmSldDWGU0SXdiVG5uNDZ1TUpUQ2d0OHM2SW41?=
 =?utf-8?B?a2xvOTdlYVUvbld3UTZzY2gxVkRIc2g5SzU2VW1XUkJuV3l3VjVRbStBT1lz?=
 =?utf-8?B?bXhIMW1BTTVkbFhsbmpnVG1KbFBiUXVBRTZLNHc5clV6azY1cFVkRitCaHA2?=
 =?utf-8?B?ZGxGaFVvdzRiR3EyZG1KL1E3ZTFIQmQ5UUFwRnUvMzV6UHBMVnhXMEhtellw?=
 =?utf-8?B?czVMdXJLS1dWQmovckluQ05WOVNlcFkyczA2d3JMTC9KUEZyc3RBQ051SUNJ?=
 =?utf-8?B?TVJvVTBJNmkweU11Y2dUcjNzQTdQQkt3Y3pYaUVESVgwMExvc05BWFJqbmZR?=
 =?utf-8?B?QW1LS3Qrd2VaTWtyWU9oYVBjcWNMVHlvQ3hOUHNZUmRmMVY2OXlBNFJiSnky?=
 =?utf-8?B?SlU1U3pCcXZKVVozQWR3RVZGeVdUMWxhT0FSVVFJclgxa20zaG04Mk5CVmFa?=
 =?utf-8?B?K0ZKUjN6K3Qvb2REVVRGeWoxUGEzNUpIVVRxTmtJUUE3aWpISHVhQlRqRkZi?=
 =?utf-8?B?a1ZDNjV3T3YxWS9iUkYreGMwRUpvb2E1VnZoaVZZRHBzSERncWgxUnF4NHEx?=
 =?utf-8?B?SmI2QXFqek5qdGNHQ0QxcC9EN1V2REpmVFJmcElPZTJmeHpSZk5HKzJ0MnZE?=
 =?utf-8?B?eXh2YWoraS9tMnQ2emhPWnA4N0kvV3JzLzF6TStDSS9zNHFhaTZKNW1nOHdk?=
 =?utf-8?B?RG4vYStVTU5BSFVFU3ZMV2YxUXRmRS9EZis1ZWsrWEQwalJtVmlZVFVKTENX?=
 =?utf-8?B?ZnBqTENpYlZaSTRUbjRtUDNvN250a2YweHB1VE5Qd1BoK2NETzNRUnNZN040?=
 =?utf-8?B?dmx3Q0tIMlpjM0M1MWhGV29tRTk5OXliQi8veE9zelVOYUxrdlNzblIwY0hL?=
 =?utf-8?B?RlU3VFQ3SWkxU1BUcENJdy81dUE1T2Nwcm84K21jZGZORW1yd0Q4Vm00N0x0?=
 =?utf-8?B?Unp6dXFiRnRNYzM2ZHROZ3VCUnFVNjk0TkQ4enJNY2krVHFsTHV3TGdPWFBB?=
 =?utf-8?B?aEJwd3JhVWFaclVESTVEQW5lZ1RWU2JCVFovTHdNUHlLbnVic2Zzb04wck80?=
 =?utf-8?B?VEhtQWxmSitTRmphaGR4WHM1T3ZqL2lDVHhIZnRSNjJRRHRKdkd0dXBQc0pL?=
 =?utf-8?B?QmlQbWVxMGJBbWM2dEIrK00weHlpd0UySmk4SjNlVm1zOXgvS0krY0MwTVFs?=
 =?utf-8?B?ZWlRZExOcVA4eFZtRUZTWnBmcytQRUYzZ1hXbHlYTy9QV1F4YmpscDZEeEda?=
 =?utf-8?B?WXkyWjM1Sk10UzZ3SDVvc0xYZ1lCWnJNRzhaVWVtLzlwZFB2RHA2ME5ZVzFo?=
 =?utf-8?B?Q3JBdlNqZVhuUjdoZHlMdkRNcWRxNHQwd1A4dTQ0OW9wTFF2QjlkcG80SjR3?=
 =?utf-8?B?M3FIcVpGcTREL2FjTXFMSGN3WFk5OGpDdEZtQmRhTEs4dTR0Um5qeCttZ0dP?=
 =?utf-8?B?SVhrbld6RkZrU1N2M04xeWliN2Q4dzJFTTZITWtrMU1hb3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTFLUUY5dnZOdFhmNnhLdjhQb1BVWmVjbHVsMkt1SW15T2ZKK09UZUhneG8y?=
 =?utf-8?B?bW5yN2hOQzNiWDJIZmoxWkZNbGt0TDcySkZBTnI3RE83Z2VXczh3M2RRWDFK?=
 =?utf-8?B?N2krNXV2L3F2T3JWYTdveEljS0pja3owYjB1NFlYdk9yRmtGTjFwTTB2aTFU?=
 =?utf-8?B?QnkzUmwxejJVb1VGcUh4NjBkZHE1VXFQdEtzc21WeXduSlVBQ2krN2M2S1Z2?=
 =?utf-8?B?NHBLZksvUUhKZjY1U1dLMXF0cEtBZWNzRUhCd1FRS2xJVnFsR0ZleFV6USs2?=
 =?utf-8?B?VTRSdCthRjJ1QmtMbGVsbi94TDYrRGkwR3RxSjUyaitpNFZsZEVWVkFjMjJK?=
 =?utf-8?B?WWNqUWk0TUZhYWR1dk4xV1hDTldwdWNhUzl5bHVOWHNiVmk5L2EzSHVNTGcz?=
 =?utf-8?B?ck11QmwwVC9uUGNBRjlKMzZPMUJPeWFSZUJOMEVsVlpwNkxnaGVEZUtROWYw?=
 =?utf-8?B?cHl1VVJabFVoZXB1MjZLV3grWTJ0K09lcCtKUGw0WTQzUUIrZFcwd2EzbXAy?=
 =?utf-8?B?bzVyK2k5REp5bW9YY091VkNpaVVJUFdFSGpINjc3b1hld2VNS3UvcjlBRS8v?=
 =?utf-8?B?N1FnWkRVZmxzdVpHRC9vMEttcVppY283WGtPSVBCTDFMZ21hUkwrK3I2Njdy?=
 =?utf-8?B?WTVqeUVnUGQ3N2JnVDd6UjA2bkRMcUdkbVFlT3NvMlBhbHBtOEZCS0dtVHZY?=
 =?utf-8?B?WUVvUERCVTRFOUxucXd3QVU2YlJzcVErQWx4eWU2UWtjbVRTbUM1ajU5dEFn?=
 =?utf-8?B?MEw0Z2ZBaW43dVRXNGNlN0tUVHJLdFVJNDY0a05NcVNVeHVxUHJKUTBQS3B6?=
 =?utf-8?B?L285aGlVMnpkdHFKY0pHK1pHUkN2TjF4RktRelpGeitPaVZSNWlYSzhpQU04?=
 =?utf-8?B?aktFQUE1N1R4UkdSNHhTZHJjcVh0MFQwZE5rYlN3blhuYmhOZXdhRk9SWmVa?=
 =?utf-8?B?MHJzK01ONEdZaXoyaDNkbmtQNzUvOC8zenhOMnJLWkQxcjBoRmFMSDYyUkFP?=
 =?utf-8?B?bkFjTzF0RUp0WUdTYkVSQnJYSmZxSDhYS3dkMHJucVJaLzdqbWp4MGRGbmkv?=
 =?utf-8?B?ek5jdVNoQmdxUDZVUFhtODFkb0ZaaFpuRjRQbzY0RTdXaVlkcklPRVd3WGhJ?=
 =?utf-8?B?V3hKMS8zVHZ2MVlkZkFhTmZyTEwwMCtQVHJlOFlKS0lobDc5dDE2Ync1RnRZ?=
 =?utf-8?B?MzlXRE9lM0swUGhSeUtYeGlhaVpZc2RIUFFXRFdNc2xjem9mL002TjJNZjMx?=
 =?utf-8?B?NitkYTJ3Z3o5a0N6aHhDamRBV2lsbHVVUjFkbE1YYjNFdHYrS0xOVFRGMHNp?=
 =?utf-8?B?OHBjMkRIZTZUMS9YcUtEcDJReFNXM3JJQ2FtYUNKakJ4OWtZVkRaU0JqMEMz?=
 =?utf-8?B?Z1V6M3ZsR2dHYm1qMjRJMGYrTUhhRWNLc0d0ZThJNHVQRVlDb0VXM2xoTHdj?=
 =?utf-8?B?NVVWQko5N1hZc1hZcXhWbXlDN1pZS0dGUUdZRHVnZnZMazNLT0JVR1Q1eGNk?=
 =?utf-8?B?WThLbGJOOTFvSEZqbWRHQjRBbHVSQ0NmN1BpYjdyQXdwc2RqU2JBUmZ3ZXVE?=
 =?utf-8?B?cWdFQ09VeDJGZ0YxL3E0Q29RTUJ6dmQvNTVFN0tra3YzdW9hSC9uV280eS93?=
 =?utf-8?B?Rk1uVVZvNW91aG13akp1L2FpbnFKUDk5eHo3VkNUQW9DNGZXR28wOWZxdXlI?=
 =?utf-8?B?V09uVmtrWFJ4L1RQY1YvTFZrQUNXbDE5T3ZCN2VXalJlYitZNTg3elgyNTRy?=
 =?utf-8?B?N0dGeWU3TkEzTjFnMnczbENIUnNjNGs1R3Y2ZzBPQWwxeDBwUmJIVEx1SlZN?=
 =?utf-8?B?WU1memZKSmtES2lFdkZZVUZFT0dSYTNDQTkzbWZvYW5RckJLdmFaUjdBaWN4?=
 =?utf-8?B?VkQ4c3B1aEMweFE2OHY2K0JOSVhWM2lxR1dtbmFLMkY0ekh5RDRqaFdVejlL?=
 =?utf-8?B?QjduNTJ6ZllGT0lMRUNWb2x5bm9BeFlBRmRiTURXMmwxZU0zMlZ6WGh4NUNZ?=
 =?utf-8?B?S0gwazFQQmQwZzM3TXZTZHJ3bkZCdmJPSDBkK1E5MHRyK3J4OVlpZmxiYUhV?=
 =?utf-8?B?VS93UE50cHZoMWJtbHpPenJzU3k1OVBKN2h4aW9MMG55OXA2V2owSEtKMmE5?=
 =?utf-8?Q?Ev/vuiJegY2mKEN4mwyphtk7w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccec03b4-715d-4c7a-7413-08dcb7c38638
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:02:37.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b94emaEUeI6CX+U693s7I7g1uCh6DH82v12/lOL2JJqWqoRK9H1shfL/gzZiLSg90n+3+VUQn6SMyqdgvSOyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Only lx2160 rev1 use mobiveil PCIe controller. Rev2 switch to designware
PCIe controller. Rev2 is mass production chip and Rev1 will be not
supported. So drop related code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/mobiveil/Kconfig            |   9 -
 drivers/pci/controller/mobiveil/Makefile           |   1 -
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c | 255 ---------------------
 3 files changed, 265 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index 58ce034f701ab..89b8ce9e1262f 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -11,15 +11,6 @@ config PCIE_MOBIVEIL_HOST
 	depends on PCI_MSI
 	select PCIE_MOBIVEIL
 
-config PCIE_LAYERSCAPE_GEN4
-	bool "Freescale Layerscape Gen4 PCIe controller"
-	depends on ARCH_LAYERSCAPE || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_MOBIVEIL_HOST
-	help
-	  Say Y here if you want PCIe Gen4 controller support on
-	  Layerscape SoCs.
-
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
index 99d879de32d6e..9fb6d1c6504dc 100644
--- a/drivers/pci/controller/mobiveil/Makefile
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
 obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
-obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie-layerscape-gen4.o
diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
deleted file mode 100644
index 5af22bee913bd..0000000000000
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ /dev/null
@@ -1,255 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PCIe Gen4 host controller driver for NXP Layerscape SoCs
- *
- * Copyright 2019-2020 NXP
- *
- * Author: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/of_pci.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/resource.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
-
-#include "pcie-mobiveil.h"
-
-/* LUT and PF control registers */
-#define PCIE_LUT_OFF			0x80000
-#define PCIE_PF_OFF			0xc0000
-#define PCIE_PF_INT_STAT		0x18
-#define PF_INT_STAT_PABRST		BIT(31)
-
-#define PCIE_PF_DBG			0x7fc
-#define PF_DBG_LTSSM_MASK		0x3f
-#define PF_DBG_LTSSM_L0			0x2d /* L0 state */
-#define PF_DBG_WE			BIT(31)
-#define PF_DBG_PABR			BIT(27)
-
-#define to_ls_g4_pcie(x)		platform_get_drvdata((x)->pdev)
-
-struct ls_g4_pcie {
-	struct mobiveil_pcie pci;
-	struct delayed_work dwork;
-	int irq;
-};
-
-static inline u32 ls_g4_pcie_pf_readl(struct ls_g4_pcie *pcie, u32 off)
-{
-	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
-}
-
-static inline void ls_g4_pcie_pf_writel(struct ls_g4_pcie *pcie,
-					u32 off, u32 val)
-{
-	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
-}
-
-static int ls_g4_pcie_link_up(struct mobiveil_pcie *pci)
-{
-	struct ls_g4_pcie *pcie = to_ls_g4_pcie(pci);
-	u32 state;
-
-	state = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
-	state =	state & PF_DBG_LTSSM_MASK;
-
-	if (state == PF_DBG_LTSSM_L0)
-		return 1;
-
-	return 0;
-}
-
-static void ls_g4_pcie_disable_interrupt(struct ls_g4_pcie *pcie)
-{
-	struct mobiveil_pcie *mv_pci = &pcie->pci;
-
-	mobiveil_csr_writel(mv_pci, 0, PAB_INTP_AMBA_MISC_ENB);
-}
-
-static void ls_g4_pcie_enable_interrupt(struct ls_g4_pcie *pcie)
-{
-	struct mobiveil_pcie *mv_pci = &pcie->pci;
-	u32 val;
-
-	/* Clear the interrupt status */
-	mobiveil_csr_writel(mv_pci, 0xffffffff, PAB_INTP_AMBA_MISC_STAT);
-
-	val = PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
-	      PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
-	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);
-}
-
-static int ls_g4_pcie_reinit_hw(struct ls_g4_pcie *pcie)
-{
-	struct mobiveil_pcie *mv_pci = &pcie->pci;
-	struct device *dev = &mv_pci->pdev->dev;
-	u32 val, act_stat;
-	int to = 100;
-
-	/* Poll for pab_csb_reset to set and PAB activity to clear */
-	do {
-		usleep_range(10, 15);
-		val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_INT_STAT);
-		act_stat = mobiveil_csr_readl(mv_pci, PAB_ACTIVITY_STAT);
-	} while (((val & PF_INT_STAT_PABRST) == 0 || act_stat) && to--);
-	if (to < 0) {
-		dev_err(dev, "Poll PABRST&PABACT timeout\n");
-		return -EIO;
-	}
-
-	/* clear PEX_RESET bit in PEX_PF0_DBG register */
-	val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
-	val |= PF_DBG_WE;
-	ls_g4_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
-
-	val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
-	val |= PF_DBG_PABR;
-	ls_g4_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
-
-	val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
-	val &= ~PF_DBG_WE;
-	ls_g4_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
-
-	mobiveil_host_init(mv_pci, true);
-
-	to = 100;
-	while (!ls_g4_pcie_link_up(mv_pci) && to--)
-		usleep_range(200, 250);
-	if (to < 0) {
-		dev_err(dev, "PCIe link training timeout\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static irqreturn_t ls_g4_pcie_isr(int irq, void *dev_id)
-{
-	struct ls_g4_pcie *pcie = (struct ls_g4_pcie *)dev_id;
-	struct mobiveil_pcie *mv_pci = &pcie->pci;
-	u32 val;
-
-	val = mobiveil_csr_readl(mv_pci, PAB_INTP_AMBA_MISC_STAT);
-	if (!val)
-		return IRQ_NONE;
-
-	if (val & PAB_INTP_RESET) {
-		ls_g4_pcie_disable_interrupt(pcie);
-		schedule_delayed_work(&pcie->dwork, msecs_to_jiffies(1));
-	}
-
-	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_STAT);
-
-	return IRQ_HANDLED;
-}
-
-static int ls_g4_pcie_interrupt_init(struct mobiveil_pcie *mv_pci)
-{
-	struct ls_g4_pcie *pcie = to_ls_g4_pcie(mv_pci);
-	struct platform_device *pdev = mv_pci->pdev;
-	struct device *dev = &pdev->dev;
-	int ret;
-
-	pcie->irq = platform_get_irq_byname(pdev, "intr");
-	if (pcie->irq < 0)
-		return pcie->irq;
-
-	ret = devm_request_irq(dev, pcie->irq, ls_g4_pcie_isr,
-			       IRQF_SHARED, pdev->name, pcie);
-	if (ret) {
-		dev_err(dev, "Can't register PCIe IRQ, errno = %d\n", ret);
-		return  ret;
-	}
-
-	return 0;
-}
-
-static void ls_g4_pcie_reset(struct work_struct *work)
-{
-	struct delayed_work *dwork = container_of(work, struct delayed_work,
-						  work);
-	struct ls_g4_pcie *pcie = container_of(dwork, struct ls_g4_pcie, dwork);
-	struct mobiveil_pcie *mv_pci = &pcie->pci;
-	u16 ctrl;
-
-	ctrl = mobiveil_csr_readw(mv_pci, PCI_BRIDGE_CONTROL);
-	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-	mobiveil_csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
-
-	if (!ls_g4_pcie_reinit_hw(pcie))
-		return;
-
-	ls_g4_pcie_enable_interrupt(pcie);
-}
-
-static const struct mobiveil_rp_ops ls_g4_pcie_rp_ops = {
-	.interrupt_init = ls_g4_pcie_interrupt_init,
-};
-
-static const struct mobiveil_pab_ops ls_g4_pcie_pab_ops = {
-	.link_up = ls_g4_pcie_link_up,
-};
-
-static int __init ls_g4_pcie_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct pci_host_bridge *bridge;
-	struct mobiveil_pcie *mv_pci;
-	struct ls_g4_pcie *pcie;
-	struct device_node *np = dev->of_node;
-	int ret;
-
-	if (!of_parse_phandle(np, "msi-parent", 0)) {
-		dev_err(dev, "Failed to find msi-parent\n");
-		return -EINVAL;
-	}
-
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie = pci_host_bridge_priv(bridge);
-	mv_pci = &pcie->pci;
-
-	mv_pci->pdev = pdev;
-	mv_pci->ops = &ls_g4_pcie_pab_ops;
-	mv_pci->rp.ops = &ls_g4_pcie_rp_ops;
-	mv_pci->rp.bridge = bridge;
-
-	platform_set_drvdata(pdev, pcie);
-
-	INIT_DELAYED_WORK(&pcie->dwork, ls_g4_pcie_reset);
-
-	ret = mobiveil_pcie_host_probe(mv_pci);
-	if (ret) {
-		dev_err(dev, "Fail to probe\n");
-		return  ret;
-	}
-
-	ls_g4_pcie_enable_interrupt(pcie);
-
-	return 0;
-}
-
-static const struct of_device_id ls_g4_pcie_of_match[] = {
-	{ .compatible = "fsl,lx2160a-pcie", },
-	{ },
-};
-
-static struct platform_driver ls_g4_pcie_driver = {
-	.driver = {
-		.name = "layerscape-pcie-gen4",
-		.of_match_table = ls_g4_pcie_of_match,
-		.suppress_bind_attrs = true,
-	},
-};
-
-builtin_platform_driver_probe(ls_g4_pcie_driver, ls_g4_pcie_probe);

-- 
2.34.1


