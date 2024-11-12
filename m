Return-Path: <linux-pci+bounces-16586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670F9C63AE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34EBB2E804
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB604215035;
	Tue, 12 Nov 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6fwcaBW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79D216DFB;
	Tue, 12 Nov 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433734; cv=fail; b=htZFLWRGfou3e/d6SA68VoTsz2Ny6IMxnRNWDZAyVvhS24/4v2qTVpCiHYI+pMSlxFLnBDwBCLtLslH+OlDRh9gZM5qQQcsKz5vC2md3A/U0ns8Pw+4BmsUP9yIQbT+VvikLr0HZ9xX4skGob0B0p7bKZLs8j7ypmGwSfpd0wMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433734; c=relaxed/simple;
	bh=mRSIYGyE7Zx5MR9tyPF4Gn3e1jwej2qgCm7SNors/a4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F2pscnVTJXdaluBAyiYCuFSH5EllqepwkPdgS+1WhtxQNxI+rxJPUKddaDbrKdDb23N3oH3l+PVHJ1nraHZ0L3cOFcdW/LNZsFjATl6VHdp1dBJoVPFxiAXMwKcahn8Y2YHhymXlj7DKFzryVffqw8F0vldB35rg/XnH99N+1uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C6fwcaBW; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slGLSFIbO3nElqxOyFr0zMQFg4iRlVxXDGq5crgl9rFkjliRbVpGpqyJHg5ZMWSZUTQ0mkI8LYlCStxRmn/x2ZaGq7ENry5Clky05D4a/xYDWJVzYHqnM1FG1mHYUov3c3oJHlChHxINTJDcbz32vt3iobWidL+iZ2FnGpCoeRQppDbvDoGa7krb3g4bknCgbjjeL685p7PMBNOx01cpaYNhHxQGRmUy319/74/G3PfK+w2SASpxriuO9jBeG6sxzWd0i0VI0EiItON4GpQo6jtke2BXzsrCIHUiRFNxiAHSE7xlHVrXvSZ8dCsaU8Aa03Dk3Fmotzrt/wzfO+1wjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqrRfjNvc6E0BC0Bxoerwxqq9oC9JL7vqGF8/bfEknY=;
 b=U3F1jFOOIYhcJ3zIO2p73x3j0uekH8NA9TK6cTGom963YsKFN6fLf2BzXKciOFGFaya6maW6mk7MXuzroQsjHnacKPXTTZt3Q1tVZuMCq/FfrXyiujiV3C4fu6F5JsFEEjPJKF2UHOWDJv+6KtV2jBRwaNgx2q6SBwLbmGmQWzi1JxMJa6iSL+PGB/iMlkQ/kxOlF1mSCkVb/0v5OagH/lf16h7XfjoVuPmgOLmAdjFp8E1Jf7P+cWpgwoNvm1SPaV9O9ma8bwHWeAbDxOtdaQ2UQzSHfMJLNkdn2ZTV5CP3IhZmw1/aesjTHkIF9R5XeXqDoKY5Kfox33+2X6fWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqrRfjNvc6E0BC0Bxoerwxqq9oC9JL7vqGF8/bfEknY=;
 b=C6fwcaBW0uMOw+VKuR+/JLOBV0WFVlDiv1es9PMpUFiD+tJxwJ3jtZgCU2t3cyyiX8i/1bbjlPZHqQ3ZsLlycgONAhpVIfjmFMrghnhsjHj8jG/L5lgU1cPfEEd9P7zqm95BgRsCtonRpF5mx0bVjRdoIwP/17XqEz+1OgMC3Go9ompAjcI1xNLfyA/jnZIDuuQNrfG6XjnNcra2EHzq9XyOk2WQu8/pMSW6kTfLFmIkgfpsbcfP4taFBUaE/W9dNvUj/UmBz6cLpm7gsKvQz9hktriPLtx7iJq9pifilH+dNKOOcsCHv+LjOMB8DqeCyA3r1lVdrE3xQYZe3lPmgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:48:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 12:48:17 -0500
Subject: [PATCH v6 4/5] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-ep-msi-v6-4-45f9722e3c2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731433711; l=5495;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mRSIYGyE7Zx5MR9tyPF4Gn3e1jwej2qgCm7SNors/a4=;
 b=NXmYNgTDzlS+Hq5U4WYuoGLf8occAlD/CCAGqkAlLRZnc4PFuv+F0gpZsIxFueTf0Ine0Borv
 XHxiZ13h8IbBCLm7Gbh7I4eNcVMNIrnNU1tUOwb50LiMc3YOL787EOY
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
X-MS-Office365-Filtering-Correlation-Id: 4838bbc9-baf0-4f89-9493-08dd03424481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFdkN2VFL3hJakZlZnJ2Rnk2c0J3RGpXdUdDMVhMcWFTQ245SDRwTHUyZDJx?=
 =?utf-8?B?Vmx3SG5kRGo1OVVPWDVSV3htOU85NFZ4SjB6VUFNQTdoempXbUxLOVB5Nm12?=
 =?utf-8?B?Z2RvK1IvcmxrS05xNXNjQlNSRW1jLzJLRVJQMW80ZnJSNkNLN3B3NFFJemJ5?=
 =?utf-8?B?VHBpenRMTW9GL2dhcm1JMXNTd05zWE8yWk1CS3NRWUNDWVczUW9hZUlLWmhC?=
 =?utf-8?B?YzZVY2FOZldyMHRaOTB3Q0ZnNUNta3VhTGFEb0l1UkpIaFRRVFJ3S3paTXlZ?=
 =?utf-8?B?dlVQTXFqWk1UeXlDZjJYam9Ed1BEWjRWZG5lNU4rQUk5R2xvdnJycnpWbnBi?=
 =?utf-8?B?cTBpaDc1enR0dlBOdTJvMFZsY0IrdTNKTGp1ZU5yK1UzVW56TUVsdDI3Y1F1?=
 =?utf-8?B?NUhZY0pTenpNK1VTbGtFZ3p6NlNQc1ZpSlNVTVUwQzZ6Wm51UHlaWi8zcnR6?=
 =?utf-8?B?S2w2ZjhpS2RGTkZBRXpqSU5PQ2ZBbkJGcG4zeDBhVDlUQlZxTlB5aEVvSE1I?=
 =?utf-8?B?alVpcFpDK2huaEdXb2Q3SHdzclo0MXFiaFJRWkpjYUpzenM1RU4zUnp4cnJP?=
 =?utf-8?B?SkRSR090cXY2d1lIbHFtdXhBM1kxaUtHZGIzQ3Z3YUlsNVNPRHRuTVBDbGk1?=
 =?utf-8?B?aEdOb2sxRGN6L2NuU2Z5WWZ0NDNwOXpVT3dQTVMzT2hqTWQ1UGNXYTRYZGMr?=
 =?utf-8?B?U096RnUwZDFrK2NDNm5xelpjeXFNKy91UjJyd1Zla2dYKzFKSkR6ZGRqRit2?=
 =?utf-8?B?NTNtckw5VGxTazUyMDhieHlwN2FwcThBRDUwQzhkUnpqWXIzQjF5MUVMT1pt?=
 =?utf-8?B?ZmJOODh4VUVHRDViMTVvWk9BeVBvODRMajJpN1hETEo1ZS8wYUlQU0YzOS8v?=
 =?utf-8?B?TUtoZWRaeEFzM1hOWEhLZERuLzhsaENFQ3FWUmRIQ0hMWE91VDMzcCtEaXVY?=
 =?utf-8?B?eUdvTDFIelJLREtYdzdHaHp1UFMwL2NVUEtVazFwanFHQTlhZ2V5NG1ad1do?=
 =?utf-8?B?QTBhUWRGc3FYN0Y2VWp1b2NwVGsvc2RWeDdkdHQ5aDZUM2RYTzRYRTd5OWZk?=
 =?utf-8?B?a3Y5K1NyNWphbExZNC9iUkpIcHFZSHVERDVvSDlmdUtnME1GSFYwOC9BNnlx?=
 =?utf-8?B?dFFVbzY4bk0wV1dTMFVmZU1VV0EwcHBIVzV2d1JsUHNQQldNcjM2bTVObzIz?=
 =?utf-8?B?VDRGVUZ4YXBsOTUrTFhCY3dHcHB1RzZ4bEpHbU9EY1FncEVNcXZEOFQ5bXNU?=
 =?utf-8?B?bG8wRlp2eHQ3RHFNaW1nVWU2S1c3MFRMbWtiZ3pkangvTHhKV3VKSWZvZHg4?=
 =?utf-8?B?VnhGY2JtSDZmc3J6M052SWxkMWxoZ3JmSmdXaXg0eGpCSUlndmlxdVh4dnVM?=
 =?utf-8?B?NlNzb3hMRzRRS2RYVEZ1QTZxK2htcDdRTFBGU0JqNXc4ZXdXd0hvYkVzQTJJ?=
 =?utf-8?B?NnhBUk5DeHY4MXc4QVJzMnlSM0pYbG5VaTEySEY4ZUxtU2ZCYjdwNDA2QzIy?=
 =?utf-8?B?N09Lbzl5MFZIazFzbW10cHJvbWVONHBtYi9Rd3RaOVNBSEtOK3VSMVJtQnU4?=
 =?utf-8?B?bHdsZW9MNnlQcGpjWGRzN1BtQ3o5MEtmc3orN2RNRzJZdGVTQkpZcjVDOHBY?=
 =?utf-8?B?L2trV3dOUjlFTm4rcDhVSE1Ha2Zia2Y0ejF4dm01UHJOOGJMZk1SVEJ6RnZZ?=
 =?utf-8?B?alZvVlRHQ1Axb3FwdWRVSmZYNzFCc1F5RFZNMnR6UlkwdzJZay9uVFc0azNw?=
 =?utf-8?B?QXVCME5vTSt2MkZrSzVZemthL0RpRTg5cjJkQVc0Nng5b25OQUpONjE1ck5r?=
 =?utf-8?Q?WGv5CruluDHIUSL+Boygb5L7zq6L/wwgJtcBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE96N3dWaEFYbWwwRUVXWklxRURIMGwxbjhGS3NnVmNCQytEeHdlc20rc1c3?=
 =?utf-8?B?cmRlZUpDNjdPVEpZZHRGblkzdmZ3eWZmQ0hVVTJKQzB0L3pXZndnU0RUTDd0?=
 =?utf-8?B?azR1eUU5QlIwT2ZnMSsreWMzbFpKZkZFNWc1TENscXFvNzRrL0llaWxtTlFN?=
 =?utf-8?B?UWIwemhhTzFBdDl4N2kxZks4OG5tR09qZDhBUmg3RnJvSktocFJiTWRhU2ly?=
 =?utf-8?B?NUh5RllKUEpCczVpdzRoVHZyV1REOWlkQzJodHQ4VWFWV1pLRzQ0eFk5dEdz?=
 =?utf-8?B?ZnJTT09YWWp4dmZ1alEzSHd6R25hdmlZUllhVlZqYXBCTWZna0RSODNPQmVQ?=
 =?utf-8?B?Z3hxeEtiMzBjOGJuTG9iUzJaS1g1MnVZY2puWk5LdjRYcGw4Z0tEallEcG9j?=
 =?utf-8?B?N2hxNlN0a091MFVxbm84Z2dUU1ZsMG5FM2ZkR3lXVXRjb0RWWmYwL3FDYzNU?=
 =?utf-8?B?b0JpTUJDcmdEcDVNU05XMTNJalZBZGgyaXVEa3ZHRVhaOWszM1VmRVppK0xL?=
 =?utf-8?B?YUVKS0lYOGw4dU1tWExxWEpsd0cxNHlDaHRHUlM4ZnhiaEQxNjgxbC9qS09P?=
 =?utf-8?B?eFNub1lxb3YxSW8rdGp6eHNKRXEwR2M4dUxDY3E3ekxHRFpYUGVuMWpDY2RN?=
 =?utf-8?B?VlNacHUwd3ZrMmtTL3hRR1c5RlUyRzdDcnRxQkVDbWE4U3VCUGcyODlJWm9o?=
 =?utf-8?B?ZUZQRHdxek9YR1QrTFpjRGNRL0FCUUVzM2hsek1yQUVtSzhSRURQQUNxM2Zj?=
 =?utf-8?B?eW1JUjhUT3VLRkhJcFVnVDN1VnJxUUNwM2luNmovaFZJZ01aODU3OTZ5d0Y2?=
 =?utf-8?B?aFRFcEhiMXUycWhRSndVRzBoM2VtM1A3VThyRXBMK096Rk5xY3g3Q1h5NTR3?=
 =?utf-8?B?RGZlQWtTTGxSY3J0SXQ3TVAxVTM0bjR2ZmZpcFVycEZMa2VBK1laaE9lUzZH?=
 =?utf-8?B?VEJETGU3YUVwZms4S1B4Vk1lQm9GSDBFZ25RQXM0MGYyWisrdDFKYWI0RU9Y?=
 =?utf-8?B?eWk5cHZFdnVUd3I1eFNYOFZOWEU1aVA3SHFGekNiclZnZThPTGpGVXpRenRU?=
 =?utf-8?B?blRJY1B3ZVMwVENEWkFKc0FlQkVYZUhSd1FSZ29hQitidjhoSjJzek83SXV6?=
 =?utf-8?B?SkZhSjQ5VEUwcGF0K0ZGemZ0dkJ3VmNhVEN5TTdOU2hYYjNDdURQTERYajV2?=
 =?utf-8?B?VG16Wi8wSENHenFjMUtEdkxmSWwwT0NGa3lSckxZTzhSUzRIQURpNm1PZ2VT?=
 =?utf-8?B?d0xMSTdKVTFIOU9uYWdsT2NqRnlNY3NrSCtyK3BjMHJycExHZGdlWGl5RUFJ?=
 =?utf-8?B?OStwb0pYenFyNVhpdlBRVWpQUmRpZlorbGFnZEo0UE1GZjF0TG5qT2RzMGVR?=
 =?utf-8?B?L05UZEJuTjU5dnNTNlV4dkgzODJJcFIzTzdsTG5VMzBJRnFKeFByWDFaMWQw?=
 =?utf-8?B?N0tHbU91UDliR0tCSXhBU0VMb0FwSXZvNXpGOExTRUlpNWtpT0Z5bzlQQzRV?=
 =?utf-8?B?aExIT0p1SndJTXNKY0xDUGlobjVZcTRHTVg4M1NIK3dhZFJrYVlmU2g3MXRm?=
 =?utf-8?B?dEdqbnkwdDRjS1E0N2RkKzNDUGRjRm1Fb0dCUnhhZ3g1dDdGMnVaTERjV3U5?=
 =?utf-8?B?cXAxM1hJSnRkMWxHV1pubElGWFIwa21mUTRuVWE1a1RvRjlsdkNaU0FxOFFF?=
 =?utf-8?B?OWlIYW8zWCs0ejFXaE5Cd2NYUkpXZWpPK0VLL0JvMk1LSXZ4Qkc3S3hIQjlr?=
 =?utf-8?B?Y0lzWkNXVVpBN3VaWGNRbFkrbm5CbmlIV29rOWxFTStyVjdmV2ZnVTFxR2oz?=
 =?utf-8?B?aENVUEw3TGJhUnN6bFMzRk1wRmN5Sm9sb01EdGladHFlQU5DcEJBTWdtbEZv?=
 =?utf-8?B?Q05LR1N3cEthckgzMko5UUloR21ON0t0a2ZSL0tnbWMvbFRhTXVRL3BCVk1H?=
 =?utf-8?B?TTV4UWdnK1MzcUZiQWJEYWN1L2xLenFveHMxaGRUdGVVQUJNbUZJN0k0MjRz?=
 =?utf-8?B?VWNxWFdTa3Z1b2pHRFBJZGdQcC9vd09WTVJaOVphOWRVcFlsK0IzN1FIdjR2?=
 =?utf-8?B?blVPMGhIaXJ1d3V6amJHUXByY1hHNFlKKzZrS0YvUDNScEJqYlZ1L1hySUdI?=
 =?utf-8?Q?o4t4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4838bbc9-baf0-4f89-9493-08dd03424481
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:48:50.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naHTFPrVEySCb0JrFKpRrjcuwUJWUmg8Wsjrpu5dyRgokYdGwXJMQSm2Sm1ELBUWpCzJd8BK9j+hZcbrsv+3BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem.

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 71 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..dc766055aa594 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,62 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL)
+		return false;
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if ((status & STATUS_DOORBELL_SUCCESS) &&
+	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +861,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..06d9f548b510e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+#define PCITEST_DOORBELL	_IO('P', 0x11)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 

-- 
2.34.1


