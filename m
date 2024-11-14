Return-Path: <linux-pci+bounces-16799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7629C9565
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F99F1F216B9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12371CABA;
	Thu, 14 Nov 2024 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KqOoP8Xv"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE461B0F05;
	Thu, 14 Nov 2024 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624780; cv=fail; b=rb6BaSRbJphLupW3lWLnDzGIacaPboimnwUD68bRbsHjWsYtnYL2XTSjKjDU4Mynvra/rgtOp88/3E1j4ttzeZWIBAp0pEORZg3uUQ/J02rYUtsOSiJ/0hBE4hgYJbZMbZ+u61baZKYmzAYPYIRVYf522N1SqmLccbqH4BpiciA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624780; c=relaxed/simple;
	bh=GejaoXH9F7tp0F2pj5fsUPiC1b7nvtn4F6gvoOZt97U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mspUTk7Ivp0H3P3XsTCDsr2kkpf1E5Fy3JptlRDKVT/REuM9mfJQ5PlEEMJLfsUuamOFnZ4DE4xC33fz/lCro2Kys60t2XNzL8yhap8EDrXSCwDUkfn6Qb4594ZbIQ4Uu4f+9RfVAgaZqa7u4Hx2YXL6ET0q841TS2PINiBVaNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KqOoP8Xv; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4jtABZTNzPujeKVUT8fcqZPqlUGQK+hwrKdYTbg2SGzqJ7siUUKkPxUEHikUzXAP50ekkYOuXcFqrBmaB/G/700wUpLGhA1GjG1ceEzd4+Xqz+CkmoSOOWPmZvpid+QAgJhG4+/086TjzjxXzFqaL6C5O6kqkL4TJIXm8chzQ8dckVcxI9yYdK4lB5Ij2MfIyLuBuCa9QrOV1pP8x5Y7C543Tjc+4jR3sEwAGaYcGkfQptLbikrQyMv7DYUQa/p8tel7dIal3MuYsRr0OLo3qxi6XN43CEuWfIlfZIW88m9Z97VDZGgUI93fhGLP+nqZhcj9p3HTw49AtrYmUQ4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJXulzg+iI1qW2v4QK7V0AHZaG9zbHgVHKDqdV6gZXk=;
 b=MA01XCXJcfoeP5xkomNoQibnVJg+JBoVbTRkA72R6ON7oyK3EB2wCHQTJe+Vl+1N8e/wrmy3Z86p3Ki3xUtQSUz38m05XW90CY+YHUZxDfAlflZjQt/DvD4s/AIkNSowHmjVHAzSbss/WVYJmFtOwFiUf8V0+61sdkvtDSm5K4AkQxLFlokTH1kOPR66X/7HJd4m6DPeq4YZN6ItiWnO9gv6J7mKNedFhxuAK45tVCeK1bBTBdbTFBcbo6HkZz7DJRGl74XqPnTwz6xn7xyFXVQ2gvVjwX7OTe2vFbNbaFWjXpIB30mTtYSWJUtDT2WjnJ3R3PEHT7gLuyTHYgKSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJXulzg+iI1qW2v4QK7V0AHZaG9zbHgVHKDqdV6gZXk=;
 b=KqOoP8XvPqW69NrQ4Toj8pj+5Y4PzmXpaAjLcN6UQh4gzZ+fE/ZrIMCWtFXPH9wFXRy6bC//6SQc3chUxZBnjhDfK4KIeFfNLaTBEQurA6g1FbyEDuLPtKAJaevvrc0kevy0HVk8sHNkiykj7lDuI2T1yHUvfpmst7jCdVoKTlNUHD9aoJpmUV3oKwpIcqJOFYUgA1QZoUo9/IR+QsDOPz1DZCzfssoDP84JsLPWdarADzduzLWI039g0rEf893qTFLljc8jfy5ny9PCxw2ZIIliwe+zopYE7bGCkut7lw7VO5dRcPKL+1vGiJOoBnaHH51+mwQXnEJtxwRgQ3oStg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:52:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:52:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 14 Nov 2024 17:52:37 -0500
Subject: [PATCH v7 1/6] PCI: endpoint: Add pci_epc_get_fn() API for
 customizable filtering
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-ep-msi-v7-1-d4ac7aafbd2c@nxp.com>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
In-Reply-To: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=3147;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GejaoXH9F7tp0F2pj5fsUPiC1b7nvtn4F6gvoOZt97U=;
 b=H4UfBsT1veKOUojtt3FbC39Xu2ea4QWtLIu+xbDCdzobu6XLfkOlZQucb/5ZCIHUVD7LhQNbq
 Ls/XtDOpllRAJg/DDl0QHJFWr1S1lOBLHnFYM1i4mobJmy77SbFZ+FN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e47ca00-af8a-46ba-29c2-08dd04ff1432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVF0eDgrY056YlZXUFRXTG9rZThLelJKQUZra3JITGxxS0pGR0wzTm9EbHVJ?=
 =?utf-8?B?dkRQU2k1eUJqY3ZmQXlGZmRnZFlvZkN4TVRiMHVmeFdvVnVJQXlGKzIzZnBz?=
 =?utf-8?B?WlRUS240NDdLT2pZV0JFRzNlQnVJb0xMUkxocUtTeXNLc2MxZDZxSGROa3Y0?=
 =?utf-8?B?eS9OdXRHb0lTNEhjT2R6akxCOXphM0kxZDhDUGt4L2ZBSW9FUnBabEp6OXV4?=
 =?utf-8?B?a1ZyOTZQRXI4K3ZIcThhREdMZG9tTitydHdTU0d0a252SjJ0M3JTKzZGRTRS?=
 =?utf-8?B?MEdIZWx2cGdVNGhUWGI3VFoxVDhOc01ZRUZUMXZOOUU4ZlNlVWhKZ2hXbUdy?=
 =?utf-8?B?OXVHM09PU284dXNUZjdIM2E2OVBWWU9TZnVSRnRIRWJYTFhyb3U5ZjMvcDlu?=
 =?utf-8?B?NXN0Z0FJZ2lrVkJLMjJaMzcxL2MwaUZTYVovTTgrTy80UXEydHUvMkRTWFNT?=
 =?utf-8?B?NGRUOWx6dlBlb3NheFhabWFhcWh5TTd1MDdWazdKb3huWXp2VzBwTkczckpM?=
 =?utf-8?B?Ymh3ZVIxajNpMmdMbGVUaEhsUktpTXd0eW50b1JEV2lYcXUyU2RsKzlLNmNE?=
 =?utf-8?B?WkNpbnd4NFlwSUt3ZjVFNGJBbmdEVUZwR2lSMHVMZkxRN0dNbUV6SXY5NStz?=
 =?utf-8?B?dkVaUWllMjF2ZVRBQkozMjRCN2YyQVBLZ1gxUnY1SXJRVFRWYkhtVlBJSUw4?=
 =?utf-8?B?Y3dGQktOQ2Uyb2NwYjBEK2hPZUV3S2N3bjF6eGpPS0RJUW05Qm1NMmZGZ21y?=
 =?utf-8?B?U2FMT1JBL0Vwd2hET3lvbEhVeTY3Mlc5eUd4MUxabk9QR1hmUlhuOXB0czVk?=
 =?utf-8?B?V09KVEFKdjNqSUNKTEZHOEtFREpXQXB2MzFQV2VJRDI5cTlYNzJSbXN5YWN2?=
 =?utf-8?B?bjhNbFRYV2xablkzWStuU1NXN0UvWXhaRW9PQWhwRFo4ZXRXdWNGcFlkaExy?=
 =?utf-8?B?bDVYSzlwLy9UeXNuVklWWWpVTHQ1dXpOVDZWZFVLNEEvb1JQSER3enFFbU9y?=
 =?utf-8?B?NkJHWVIxQUF0YXp6Q3pGR1JhT1dsWWRIdURGckg5MStkcmxyMlovR0QzY2ow?=
 =?utf-8?B?UWhGc0xSQkgvTTFxTlNPWUZTTWpkNzljbUgxbm5sRWp0b1ZPUW9JQ092d0tj?=
 =?utf-8?B?NEYvcG1pYVExRlFaYUNHSVN6MzZDT1ZOQ3BVZXF6QlJWZTVRT0lXZEI3ZEVH?=
 =?utf-8?B?STdwYTk1SnNtTHV2NUhlWkNFTGF5UWxVcjZvTlpUNUc4Q1U1aElHb01nZS9p?=
 =?utf-8?B?cnpwUUVHa2JKSWczVU51andGclZ0enhkb2RCWkRXQ2FrOTFWNmR6MElpMFd2?=
 =?utf-8?B?Mm1FamE0eXJOOE1yY3U5U2VxZjN6d0JXUVdVZGVyY3V2MkV3U1JOUUMxaVBw?=
 =?utf-8?B?SDhUdTBiWE9yU3M2aWRybmxCeTg1WnprNUc1eWJVTi9XaThZVGRIa0ZxM09J?=
 =?utf-8?B?YjJiMVNyaTJMMFhaQWZwS0x2WDFJc0FhVGhCTTUwOGtxNWZ4c0JDQkhRQ1I0?=
 =?utf-8?B?VnhxZThRdDhESElIZkxtVWcyS3dLeGFyUnUxMWhCUHZNTzFmeUtYczlSQ0Rk?=
 =?utf-8?B?TlBUb05hZFNUVXhiNHhmdm54M00ySmZRQnJSL1J5cElnV2wvc095TGxpZEYw?=
 =?utf-8?B?cnVya2hxVTRHVWtqQVNHSHdVQUNRNm41ZjRjTWZQWi91RlJJaGRNNXFDY0ts?=
 =?utf-8?B?Ujl5SExzQmRtd1FLdW1ZT3RXZnprbk9EMEpDWmN6b2hrV3NrSXlsb1dVdXA3?=
 =?utf-8?B?eGRpRHlWa0RxQTJITExqT0NESFFHd1I5bmV5SnJuQjFoYVQ0UzVmN2hkblc1?=
 =?utf-8?Q?juPRtZ/AmKi4TZT+Lrb7XVP+HX0jD+PZZ9enM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVLRkNkKzhVMnU1eXFPeWFSdkRtK09LaE4xZlQwQ0pkNWEzb1IzVWJOTTdM?=
 =?utf-8?B?cjVHaCtLLzRBTUlQcHRRWGs3b0dlTjFiS1lxTXZ2c1pSU0FBcmw3a3ZyM25I?=
 =?utf-8?B?VmpOa0pKZGdubUwxZ1hzOUpKQlJaTWlyYWh3UEFOYmZ4TWxmOS9uYllQL0lj?=
 =?utf-8?B?VSs1YWIvaGwxajhGZ2tMQmJWeVNzdXNQMEVQWmFmOTVsUHQ0RXdSTHFPZTBz?=
 =?utf-8?B?VVhKYjgvZ3RDQ01mVi9zbkFTTVhISG9TK0czb1g1T05wcno3eTBQRml6U2Fh?=
 =?utf-8?B?K2c5MXIydnFCWlhxd3pqS3RuZVZpVElNR2d5T3pBYVZUdFZ2YlA2SXhCa0VY?=
 =?utf-8?B?QXR5NWFTR3FaNThnOGczL21CR0JteDltb3dhUUE3TzBUY1FILzhqcVNrN1N3?=
 =?utf-8?B?Z2F6Y3RvQzlYYnNHRXlTRU5aQUd1bDRyU0hxRVRVQ3dydXZRdmd3ZFhJVkEx?=
 =?utf-8?B?a1pKNk15OW1yOFMram1IMWdSTjlFV21WeGVtS2Fud0JuZEl2cHJKUE1QdVN5?=
 =?utf-8?B?TjFLMEhjL21QbUFJRmRrVXlaMUpQUERhM3pnTlRMM2FDSStyWGcwNXhIOU9B?=
 =?utf-8?B?U1VtWjZyeko2MGE3V29Jc0FTeUhtNVlJanNYZkYrWVJwVVdzblZmYkk2UmRO?=
 =?utf-8?B?eld4R0EwOVVhazdkU2xFa3UydnozUGl4OW9XcUFBbzRMelBVekRwdkU0bjgy?=
 =?utf-8?B?MW5FdVJ0WEhwU05nVG13UjBGM2lxT3d4cUZYRVg4WXBXWFU4OS9PRVp5dkw0?=
 =?utf-8?B?S2dheEZNNzNEK0F4MHZFWmp6dG9jUlkyTFU0NGtSc2huUnY0K3lUOXFiNWw1?=
 =?utf-8?B?RlNiVmJESG1XbXhoM3RWMDh0VEd6UTlHOSs3SFhaZ0ptRHgxRDA3cWFaSG9N?=
 =?utf-8?B?bUxyaktiTUtaVkRreURCeVVRVUhlTVdUZE84Mlk0RWhQSWNhZjdyTnZIa2lP?=
 =?utf-8?B?aXFITUtqaTZqR2twUG5pVWVOaGJRTUdqenN1djBOOVdPZjlVeFZpSzZETzU5?=
 =?utf-8?B?bzduVDZzRmZWamxnTzE1WXBUZE9SOG1DOEIwUjVsNDBBdis0UlBnNkZsUHIv?=
 =?utf-8?B?U1hLYUtZc2xtdEdmMEhleS84aTRzUUk0clJ5SmE3bVZpZmJvejdxTzNrdUZZ?=
 =?utf-8?B?dVhwTG8rdTcvcGlET2R1ZHM3YVFJeStESVM0Y2ROMithR29EdXVteTh0NUkx?=
 =?utf-8?B?aUFoMzROY3JuRWdaSE5vN0pybTNmSC9EbWlRVlBaRE5JdzN2Tzg5MFlDblM4?=
 =?utf-8?B?U2FJOVA2YklMUFVvMU1KSlV0MzRtT0FEdnYxa0FVR1JIV2ZweHlMMlV4WmJ1?=
 =?utf-8?B?ZDJUNFp3am5kRjhiUnZENGNQbFRBNndPdCtJdDRUbml4TzUrYmNqK0hxKzRx?=
 =?utf-8?B?YmZwQnc3REQ0ZHNlWURqRnJoSWFFODhvN3F4alVpbC8vNHZTa0ZqdUh0eUpw?=
 =?utf-8?B?YXZ0QisxM056cWMrU0c3Si9BWXBrY1F6aE5NbGZaY2J4ZmJyZXIwa0h1YnBs?=
 =?utf-8?B?U2JQSWJzNkFNMkE1cUR1ZGhjOHhBL1hMcTRHM2kvSUNMTjNjeDkwbXhueHZa?=
 =?utf-8?B?cThBaXZMQzBzUFRvSnVXbTFJY1k5NG1LVUdSTnNKd2NVcWFWZ1htTFVBMVF6?=
 =?utf-8?B?UFlzaUJnaUtmRkFkSTMxd1ArUGZ6VkZldktiUkxmUmRTeDZ0eXVVOHR2d21J?=
 =?utf-8?B?NHNUdFFFVHQyVTByT2ZqZ0x5N3RuZU1WQ3k2VXR6YVVHTDZiQmg4MVBZY05u?=
 =?utf-8?B?T1owWXNVZEdCbjhnMHhSTWprQlBBaHBrS0d0enJOUWhOZEU5YnRFQjlFRlZD?=
 =?utf-8?B?UTRrWnJVWGdScEN3UGFrcnVXZldwTzAwNllZaGVYWDM3bzRqa2ZPZ0pKVWtN?=
 =?utf-8?B?RlZZajExMU5ma1VBbENyb2YrYndvM1pzMVZUU0RHS3ZOMVF0eTFMYlFOVTZI?=
 =?utf-8?B?L0pCTFNsYWF0MXlSN1NZL3F2eVJFOE04OFVmOVp4dzkycklKclo0U3NXMERu?=
 =?utf-8?B?cFBjZE9LOEZJaGVQN00ySjlDRjI0emE1citUY0NQMzQwdVY4NUxwMitNMHRo?=
 =?utf-8?B?ZitVclNweVhqSXdjZktkWGpZMU9EMGpvOEZLSDI3Ti9JOXNuM0lPSGgwVU1X?=
 =?utf-8?Q?I7Ik=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e47ca00-af8a-46ba-29c2-08dd04ff1432
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:52:55.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr0w/jDvnhhgV95z0Qvdv9H1bgE9wMjh1kHTbhC3bDuSo5VQKnFJn+W5sH6R7gyklQ95TLjMDqe85AHArm+E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

Introduce the pci_epc_get_fn() API, allowing a custom filter callback
function to be passed. Reimplement pci_epc_get() using pci_epc_get_fn()
with a match name callback. Prepare the codebase for adding RC-to-EP
doorbell support.

Add DEFINE_FREE(pci_epc_put) to implement scope based auto cleanup.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v7
- none
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++--
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c3..f5538c007678e 100644
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
index de8cc3658220b..d3d3b8c914614 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -300,7 +300,9 @@ pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
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


