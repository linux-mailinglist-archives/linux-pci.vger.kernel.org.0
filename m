Return-Path: <linux-pci+bounces-11499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF4294C236
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714291C21604
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C14190059;
	Thu,  8 Aug 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/twwTms"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079C18FC99;
	Thu,  8 Aug 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132957; cv=fail; b=ehm1QdOcGy+o7w9FJwWCxMPC2qOxy5oX0z0klTw4ro6WNulDyJgelWuCxBfR8X9IKd3pWK9ZmriiiswkzsvfIy1OCExaJEOjc6GQkIhEFJFLRNwcxgYiq8gMyZmkuccZdgf1bOmuGSjnaLD49yn16/WDFPnreYDKBN0J4o1F74g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132957; c=relaxed/simple;
	bh=xoOhUaTReuUUpIBK3aLnYqUxORYPZ6N7M1QmUFltZAw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GFnEvmjIl+Ny4AMIunxj0Bl40DoUsYwr4IraP/04ahI+s36hjjHn8bk+uvWwMNeEmrURPVbUUJuk9evOqQ9BjXBnd54D2I2HwN6M2uqOZnqq96hfUrtRgwmCQx87FWTtXZgSe565jY5ruUJjDPDGYJhCmOyre/JP89Yg/KCWrYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O/twwTms; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxrR05Y9DepjgokZe9WyQ+hgN5QXUQWm2uk4Ucf4luGNvDRzLsUJqfCsMfb5DK4rqsVqo1pibcwROq4+pilm6O6n15iIw2BtbBADkoS36yW4DTQy7mqTSo6X3tVb7eVIO3LJTDJVH4Jou/k7x/O/CF3GXmkL6tUWm6zGlS50GjIwUigPUrfb6XMdTxLC6q/mwrRC+rFFFQ2lBPeNaxDSZ5QlXJ69ZzoZXgm6vhmTzx688+dOPUsnFjtRdLg3kL6fwqzsYwWAKq/GNB2m3KLHEtSm5OBkTx9J97iYR7O/8pB08xBiSBtZc8ZfsvMGgENd9R8vSvWJDVdnjD0GvpacqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+SZno2URSY1oFr/BP47LXaxCUqolKPVyQXl70gfOkU=;
 b=RH/ysNTUs6Z1/yHbKdFbnjI4V6qpLMT4rxgmu5eRqcdV/w47F58xk+SF6uHlbMMbpllb2OsSnXvADIxdTS2Drmj7WvzdY3OKidiolJ/nX3KULxr+X/N6TLV7XM80tpvGU+UC4zVQ5UcJoaxn9zxzqWA3CCg/xBMxa8QcQlohSm1WO+0qwelMYzRPhG55md/dtnnj+TlKArU7jrzH55OTeMZFp/0MletdRmMWBUUdwndcvRGUGQuVpfKEydC3L4f0zauE3NZ6hUh8lEhUr63Phs4BbxJLMeS/Hkkt7cd/sVoXUFyps9KQkwDLB3WYUzA3BZ9SQxt0Q0nHNf/MROo/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+SZno2URSY1oFr/BP47LXaxCUqolKPVyQXl70gfOkU=;
 b=O/twwTmsABEtMP9jQajGe1L8nKEqi/C+15FaIvELyqeL1xvMuTP+gQeVtz4nUzkYrbL3t0IvJIuimULclyoPfgJ3qv8e9TPVYs8zSQsjUzxeuR/A7ZTnVu3cXWH4kW6mE9bQJs1cKuUSrHb0/cv27XaH/2GsPJV/5yRpvd50pz0i/kzjxGaogKXXB4vekZIimLiCTqknFvfHX9mLtb9k94JChqNTakV9UfwnPJAn2XksCuFtaLYEFyHVR1ss1AB4IwVSshjjf4pgkbvwg+Q8AB79LeGpicdBPtF3x94O+d/voqY9adYiyGBrcFeYdbESfayF4SRNfhUB/zQcnOYoJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 16:02:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:02:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 08 Aug 2024 12:02:14 -0400
Subject: [PATCH 1/4] dt-bindings: PCI: layerscape-pci: drop compatible
 string fsl,lx2160a-pcie
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mobivel_cleanup-v1-1-f4f6ea5b16de@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723132945; l=880;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xoOhUaTReuUUpIBK3aLnYqUxORYPZ6N7M1QmUFltZAw=;
 b=zG6qMwe2dS2kZec17JTfP4FqqaqacAmWuUpE/NgA2fBGGy8zcbqOsn2mrm8ZKmaFLDkgvnjyr
 Ji1jGHWQyJYBgltsYd3G0P0t/4ka8ZeqHlAFsNCJPG3USgusjr3gslS
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
X-MS-Office365-Filtering-Correlation-Id: 16f693c4-75b8-4c12-de96-08dcb7c38282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU1Bb3lIUG9oWWdZa2pLNkFwaHBOcGxDeVBRV3JZQnlTbXlJaG9JMk10YzZF?=
 =?utf-8?B?aWtzbUJyTGs0K2dQQUcrTEFTUzQ2SExseWdtVmR0Tm9UY3lUWkRjVW00R2dX?=
 =?utf-8?B?MklacGJydkpMdVk2RUNnNHEzd0ZPRWZ1RCtCaTBjZGwva2Y2TGQ1S1o2cUhF?=
 =?utf-8?B?RnV1ZkxZc3JJT0Z3UjNDMVc4Ui94QjJFaVdWd3J0YkFXaEMxS3BkdXVzM2pE?=
 =?utf-8?B?VEVKdlc4dkQ2ZUJlSEhPQ09LREJQSFM4eVVJUkNsZmhMQUV1Ly82V1dJeWpU?=
 =?utf-8?B?L0ZBWmxGR012alF3QUp0V2p4V3pmM21yd2EzUVZITDNSUVdZWnR0SmZWc1M4?=
 =?utf-8?B?S2JoelBreWtqWjRvV0dzcy9vcWJ1emEyYnIyb3A4U1lwbllLQllBUXN4YzFi?=
 =?utf-8?B?M0s0VkpGS2ZIVEpWRW8wQU1yUWtBSzFWTlZMQWowOVkydSt1T2JQanJnMWo1?=
 =?utf-8?B?NGpUMUw0a2dHT3kvTStwUDlJQXFWSUNIZE9QRlpCZ1VpMU1IKzVtU0VKb0Vp?=
 =?utf-8?B?WkVDd05YaUJWdzlQYlRnRlR3eXdDbFI1UzkwUjcyWVJFUldyZnhuZEVubFZv?=
 =?utf-8?B?M3hDYjJEUzNXeDRQV0prMy9SUnZvMTNMQ2Q4Y25MangrQldDeVFkbHR1YTFu?=
 =?utf-8?B?YWY4bDM1OXdlTEdtRU9LMFh5TTFQakhIeG1LZjRJU2ZhRDR3Q013RDQ2alp1?=
 =?utf-8?B?ZmRCd3ZwbW5WRjN0dUhpQWZRL0dDSzBHeTZNUTVZY0lnTWZRbGxtZzNuUll5?=
 =?utf-8?B?b095VmtmS2RjdFpBR0t4Qi9FbVBjYWdQekk5b24ySmJYdy8zajZKRThzMGJD?=
 =?utf-8?B?a2tFQUFCcEFBQkNpNlpzaVNxbWZ4dnJmVDV2QkNDdUV3NEtYczErWnFETTMz?=
 =?utf-8?B?aGYrVEhyeDA3WUZnRnExeXMyWmsrMW1nZzR6Q2dFdUUrMFJZdWdjREthOS9h?=
 =?utf-8?B?RzE0cXRCRFRQemJwUzRNUklKbWNxcEtNMXp4N2FnR1VLM2RrK2cyb1hCaWdX?=
 =?utf-8?B?TXJJOWt5QmsyQk4ybE94OU9SeHVpd1BUS2tIT1hoNVpiZVM0aGRKc1NMbnlZ?=
 =?utf-8?B?cWlsaWpLMURVVWUwZUhkdXNuQ3ZUM3drQTVuUkpKSCtEVzRUUVQyNEtaT29V?=
 =?utf-8?B?WVZZNVdnd3pjL0xGUVovczdWTHJNY1BjNm5za3BkTWRQZWNOYmhOSVRTRU5r?=
 =?utf-8?B?YUt0OVhsaEtKVjhqdm5UYkdXdWNBckNjdVVQVTJEMUlGN3Zkb1kvNG5uQ2Ny?=
 =?utf-8?B?K00xODFCVXA2d3p6VnpZWjYxdmtRdmk2SHNscnBXamEvMDd3YURZeU1oeDFs?=
 =?utf-8?B?Y05zb0RQODBlajUvNDBQSHlMbXNqaWRBU3FzVWk2cGZFc3RMUE9lVHpVQUZ0?=
 =?utf-8?B?eThDMmdjYjJ0Mnc0QTNmUjMxOHViNlo2NnZHbFoxL0RDODhNOHpNY24rRDYy?=
 =?utf-8?B?R05JRTdBMmVjMmF3V3RNMThjVG9VRmw5a2czUWc4Tk9ocCtQSWRpZ1pmTERZ?=
 =?utf-8?B?V3NTVUd6aGVYMDNwOXJLRUVoN3YrT0prWkpDOXZDNGZvZ3ZabUE4bXE3Q0Er?=
 =?utf-8?B?YUtvOGZBWU9JZjFzODFhWnVOR0hweEg4UXc1SEZPdVArdFo1R1pJMHpTQ2o5?=
 =?utf-8?B?cXAxWDFCREh2SE9FVDdYdXJFRnVLRS9sbW54TEFLSmZDenFvY25ZVjZvR3g2?=
 =?utf-8?B?djVmUUJwYzlkODhuMU1KOGg3U2xaMTdXQlROM0JpeDlVcFZKVWFXQmtFSUhG?=
 =?utf-8?B?Vm5lMDVPeXRDTU1xYWNCQVhybHNwWTVTVWNoVGlWQVV0NlV3dzd5cWR2RnhC?=
 =?utf-8?B?bjFsdWo2cjJBbnBhYnhkSFNPZlZWUXY3UTVOZkxpT3NUR0tvY3c0TllNNnJw?=
 =?utf-8?B?WmNsNHB1TDVmMFd6dGhDUFZNM01xaDhDd0o0RndUeVQ4U0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckpOOGNTUnMxVmFKRDBKYWVScjZSb0xpK282dWQrbE9zQ2dwcHRkbDI1elR6?=
 =?utf-8?B?dDU3d1FuQ1pacWFSWG8rMlMya2RnV1cvL0pjMHNodVNYR2diUCtPK2kxNGNW?=
 =?utf-8?B?RWRtVGRyWEhJUjFLVXdmTmlNaHpCTlpzeDE2Wko4WXpQbVo3aDVwRVBYZGE5?=
 =?utf-8?B?ZHdOcXF2OXlTbDhkWloxSktpMnlBOWVUcmQ1bHFHUnYvMEx3anFHWlFrU2ZK?=
 =?utf-8?B?bEdIbHhnTGJJV0JwU3A3Rk1tMVFCRWp4SFBhMHk2WTc2dEtuVDJ5VStjUG4x?=
 =?utf-8?B?VVh5cHE4aHd4eExrWHZpSW9IR2JacXM1cC9HekMxUWRBcFNETGJINnFCS2dz?=
 =?utf-8?B?T2QxcFhoekdYbGFIVVI2RFFtSVRTeEJYOUw3dEIrOStlNEhQYUpiajFVb091?=
 =?utf-8?B?YUJrY3hwdWJ5UkxsS3VvQ2xxSlVnU3Fjc1AvZGdsSWlJdWFZejJFZS9ybXQr?=
 =?utf-8?B?Rm4weG5ybVUzbWRKejZPQkNOQ28xV3QydjZWQTQ1OGpzNDBqQWFrMElBYkJl?=
 =?utf-8?B?T3RXKzEzb3FaUS9SbnU4TkhIUkt3MnIyWlRwNC9KTlJCdGZpTk5DLzBteXNE?=
 =?utf-8?B?VHowTlN4RkUwZFVHWS9GcXpwQlZuVVRaYTZPVno1Y2tmOXZNejg5SlFaaXh0?=
 =?utf-8?B?NXBTelF4SHlIYjcyMVBNSTFpNGtYQTVDMXRQU2h5T0xLendJQlBwRXhGYzVt?=
 =?utf-8?B?MzgwR244cjh4RmxKU2JBM3NqMzNYOHlib1d5RUFpeG1TRkhWS0VXeDBEZEtT?=
 =?utf-8?B?OFNtRnVlRGp4U3o3eHNQVXc0aDdnTzQyMGlEdkVCRXJaYzUycU9lNHpDd0dU?=
 =?utf-8?B?UzEyQWxMbmZXK2dIdFI4U05qOEZyd2RFdFc3TGJwajRTMk1ETUtUOEhsM1Vp?=
 =?utf-8?B?L3I4ZUV1MGw5TS9KMStyTEZPV01JdEVuZ1AwSk9CaVhmK0cwWENKcFNnSEln?=
 =?utf-8?B?OVRGZUFzclB5b3EzdEoxMVhNTjVkaDlscVJuSUF0U1daZURLYkRTblI5N2Rm?=
 =?utf-8?B?Z21rNEllTHpESWp6cXI1ZldXRHBpNlcwTmdPc3M4Ni90RWdmS3BKQzRSM3Yr?=
 =?utf-8?B?WTVPQjlWeURtUU5LZm9od1lIVkJkc25pSHlNOGVCMHhBbkhHOE43aklpODh1?=
 =?utf-8?B?dlhRUVZlWXptVStZTUxwZExzRlVteTF0VEI0SlI0OE5JTFlTRkczS1REVVNq?=
 =?utf-8?B?U2Q5SkxKMlFScENxb3NKcCtCN1FtYkdoRGgxV3lxS1JGQ3FDelhXd3RwWFpx?=
 =?utf-8?B?ZUYrVW5NUjY0WW1jSFJDMG9HeTY3eFI4NXlSeCtHMXZZQzZXQnk5UEpLZEFU?=
 =?utf-8?B?RXhBNHI2Q010OXJMUGhYZ1pSUHp3VjNzRFZ1cG5BMlJtTXV2OGxDQW1KN24r?=
 =?utf-8?B?VENqSTFtblpSSmYwS1pzOWRWc3FUOU0vV3V4OXBxakpZWW5xNVZkM1JxRlBK?=
 =?utf-8?B?d1NjRnhCVmtYSWVBQlpOeHZEakVyWHlQL0g5RFl1ZUFFak91MTJWa1VZVFdr?=
 =?utf-8?B?REozTHBFLy9rckVHclZpNGJzdGhrSnk5WE1QSC9remRxV2c5U0t3UUkyUGpJ?=
 =?utf-8?B?eU41NFNNWnJqazE0SFQ0R3QvekJUY1RxRTN1SXAwc3NrdEZ2ck02b2RMc2ZW?=
 =?utf-8?B?eDdDZmRibUlhbXdZVUdsWmlFMFoxS0NVa29FU05WeHFGTmFCL1g4REpMdGxG?=
 =?utf-8?B?Yk5WM3ZHVm5ESzJCaGcrT2ZqUVowZ2dwWUJKaWU0dVVJY0FoTEpQU1QrZlY3?=
 =?utf-8?B?ZFU1WkFLTEJTRk41WlpKdmI4MUxQQmdUMzJzTUlEMmkxZlp1OXlzVVZKZ25B?=
 =?utf-8?B?VmJyRUxsNDhrQVkwZjhUc3kvMlo3YkNrOXpOdlJmWjZMaDA5RXFjd3ZTaVFh?=
 =?utf-8?B?Rzl0dHAyYlJDT0doU3U4czY2ZmdiZitHMUoxbHc0eDVYckcyeHhrL0FyR1hT?=
 =?utf-8?B?KzlVU090UTJoSFpDVlNxN2crcFNrZDhWeE1nWnAwL0hyelJzU2JrUDRFOTJC?=
 =?utf-8?B?eDlDeHRWODVVOU5iTFc2aU92TldnbEZzS1BkR3ZtQ01rdU42WGVsM1diWUE3?=
 =?utf-8?B?SGZQVjhndWFIeGZsb2V6aXFsTjMySUIyY2lxdzFSMmZHTDFqNG12MW5rUXhr?=
 =?utf-8?Q?0GIIj0Lx3e2qFESJGq6DH4Q3s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f693c4-75b8-4c12-de96-08dcb7c38282
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:02:31.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2M20dvnNv+d/UiOpZGYOMV1rQQ2bqKCRZxUOoBdp590FFHTzrj0SVywrlnTvBqOUeOTpsTImxdlfIN1XfdNVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

fsl,lx2160a-pcie compatible is used for mobivel according to
Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt

fsl,layerscape-pcie.yaml is used for designware PCIe controller binding. So
drop it.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 793986c5af7ff..4010a53c32d2a 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -32,7 +32,6 @@ properties:
       - fsl,ls1043a-pcie
       - fsl,ls1012a-pcie
       - fsl,ls1028a-pcie
-      - fsl,lx2160a-pcie
 
   reg:
     maxItems: 2

-- 
2.34.1


