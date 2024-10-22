Return-Path: <linux-pci+bounces-15039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58B9AB718
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9927928495F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318C1CC8A7;
	Tue, 22 Oct 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sajy/sqj"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701D1CC174;
	Tue, 22 Oct 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626166; cv=fail; b=TSwZSqy5hEdYX/Td8m61v8ya188avBCigZsWddQQ24hCgNSVKBsIzCNJE3KJ7XUkAiTm7mAK5UHl3Voc2EylRyy9GDniF+OJZ/at4ttigRb4SZpYFxtsDPqCm4DGU+ccViW50Sxzb38W4RKExwifewqN5DX9JN6WH76szkbqRaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626166; c=relaxed/simple;
	bh=CZ223q5A6jByZm5MFddNG99W/6Dza5pHT4LieSRPKhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g9HfTau+J3K8Ovhm1f08XjrgVLNoQf3VutZCwsE3nRQe10fsfnj7AA8DaRpcFj1BuZewxZEhRxUfYyq8tJLFwszje1udqx5ONXYVnAfU5HBlATiaa8t7iCeS3YUoV7cbd38WMNUi3fO980vLdQ6xYg1MUPxpucWe6zqXqTvqvWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sajy/sqj; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu7aT6VulmQL6u8+FSTrNJJaAEB5e3ZchgkLXXuhqc3p4VDX0Ct0Tvc6aT7JcjS/LVxq0P79ypxUkTL5fS1Qmx/fu7WzLRHSydYy1diPV4mWtG6amq5o9fb2Q+vghfjXYPAshIKo+AMQrQm7hn40OtIpyxWC2KyXuwykskMOD9E9FZVMqg4iZnChux6BF301c6VxN9xtONyKI+9U5DHt6d2LTAUn/pdY5kqIMqvI+43+7ZHmQ2x4s0Z3gfWty9FzYmOkffrFJiIEzwpV0bIeRHcnACLVDy+d7aLp87XCvBAwiI2L9eq9+KlfEp6TMubz5YUWMaV5i2I+w8lSzq0ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/WX/YzwaTdyOyxjJ9dIBkxUPFsvwY/Wb8YC4XZ1S6U=;
 b=kPJnVGgXiztnScEbi12/8Efk2Hj3BI4UR/uvfR4VG7k3UNOT+94PLtrA8XvlSwOq4a7Chyov3aHsKZQKfcSTBKNfXna7DGAfwVGima/jLQhSXSuRyCpp8ETgKqsuHlF/o6gkjp98oyV3Yb80Do14i2Yw/L7GsJU7cIACnsoeQdGCEEje13Qwg/gJ2MxrXUMVmip9YrQVRzppiThz0BeM1D4xoPFz3ixuKJAC//D8J10PXN8msjM5wXHqUGrGGvdchVmryv46ol7/EUZDmLLWxRS06FGDOD7gNlA/t9M6r1Wb/vukkHtLwTqBFlq6h2LxsjqZ5I8qSHSbYmoqcdcZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/WX/YzwaTdyOyxjJ9dIBkxUPFsvwY/Wb8YC4XZ1S6U=;
 b=Sajy/sqjOmDcxKeNWmZYJX1XHVNez1nMRcqdKyad2q9BGeTYFBtg10IpZwoWVoMgwUBg6v4rOMqrQ0CTZmrFkvds33I2/FwZ7j/aiN9y8NT727bxFMjeXFDtGLQJMv1IgE7m0t6eS6QQYpD039dKciEjCxT6bnbBGS/AxJGZrlZ0rBLyJQgzeReCGSeF3OOkZKOpVaoNTg8T5aAmjk9+OnQr5iWNl9xtlX4vru2TqTV8dmsDutyZt7kIFYZj0qy6Hyz6mSJNhCq+Bgsmm5JT57eAos+B1HHZMI757sMKsLldKqTBI/fpv3wmL5ZxmMJucaJ3+Z90gBbo/E3BdXTeYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 19:42:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 19:42:40 +0000
Date: Tue, 22 Oct 2024 15:42:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, kw@linux.com, bhelgaas@google.com,
	lpieralisi@kernel.org, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 7/9] PCI: imx6: Use dwc common suspend resume method
Message-ID: <ZxgAJ9wwdpnHvyVm@lizhi-Precision-Tower-5810>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-8-git-send-email-hongxing.zhu@nxp.com>
 <20241022171800.fwkdvzozw2rnzv34@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022171800.fwkdvzozw2rnzv34@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c023d7-0d71-4d8d-6b16-08dcf2d1b05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REhIYjU1enM0ZjFlcXU3Uk5BcmVqZjQ0UFg4WWtEdzh3UWdMYTBBTytQYm1U?=
 =?utf-8?B?VVVjR2ZEWnIyZlhUd1RMbFRwK2pZK0xRcWwxL0Z0R3g2Y2FxbC9ka1dON0Fw?=
 =?utf-8?B?enI3L1J6dmZCQmJLTjVyZGNMOVM1a0NOdDZQYXZzNEJJVnpoN3pBbmxoQmY4?=
 =?utf-8?B?NW02aWJxYVo0VXlhMllEU0xBVUlVRUpaY3NNd2FvNXdXT1hqYzQrWWhJQUR2?=
 =?utf-8?B?Rk9kY3lwNkZjZFdnUUE5RzBLYm9pMHRJZUw0OExTV2hTK3ZaZTBtU2RtOGc1?=
 =?utf-8?B?aUxiZGZFQjl5eXZOdkg0T05mYWlqM3gzelE4OExXamxvU0Z3RHhjVlVYR24z?=
 =?utf-8?B?L2R0M1I1MEI4UVUwUzg3L3JoUXQ4WmxyNTE4NjU1bkRPL0cwWDhUajBlbjBD?=
 =?utf-8?B?bHBLVlRFV2FucWFVaTVGeDlRbkxKekl1L3FnWUZMNG1TSjdIQkpOYitEZWxR?=
 =?utf-8?B?R2IxcGNkUEhZZmxOdUN4T1dwbGlnbFIycVloalFxMXpqdUszWDl0UmUyM2Fm?=
 =?utf-8?B?cmQ2ejI2eS9CaDZteVZOZnRLYmRMNG9kQUFldW9UVENEYzAzNUFZUlFDaXht?=
 =?utf-8?B?WFhicXVMcklrTlRxdU9OVDhSam9QNlRiZ1l6c1FIOGZQU2cvZHV4WGlVbU5x?=
 =?utf-8?B?YzFxbDhhR2UrYzdycDBIM3BYL0dJRFY3MkRla0ljNTRiSUpiRmtZcUkxVlBy?=
 =?utf-8?B?V2ZXRGFNZUtTRkhlZzdKYzJYTWRaU3A1SlVaU0dlMzJUUG9pbFpXaDJXQjJD?=
 =?utf-8?B?RlJXcmRBN1hBOC9jSXJ1MzlpcWI2WlNlOUpyM1pWUE96aFFFL1NWdUZnNWFN?=
 =?utf-8?B?c3l0d3ZqYXlmZzdLVEZZRERWakVKbjlLQUZNTURmSVU0SFFYQ1lQcXh2bXAx?=
 =?utf-8?B?a3J3b3FsR044TFJ2aURTSHgwUVRqYjlibDVaZW05QWNnVlR2cCtYeFVMZ2to?=
 =?utf-8?B?ZUp5QVU4ekhKMVNFRkxmSllyV3JZRnMyS0VvZjI2MlhkNzJFWVRwaE9RaU9K?=
 =?utf-8?B?YVVqMkJIUlJxd3ZPS1pvK1p2dG1UUzVXR0tMbmpsTHNJMmlPcERRbGN3VEt2?=
 =?utf-8?B?SHlkN056QUdDcG05OFBkZWVma0xqejFscTBvZEVkSmZCTlZhZlhyMXlidlJn?=
 =?utf-8?B?ajZ1TnIvWUgyRElNUWRYQlJOcG13TlVBN0Z3VlJGbmdUSnJPYkE3RWNTbmN4?=
 =?utf-8?B?azhxUzVJL29kaytFeDkyejY5OGFhSklwUlVmM2NOUWl6TXA0OGpzZHRYdC9i?=
 =?utf-8?B?bWxBWGFwekNWK1JBRVgwZUFqWWtENXhNMzZvc1VpRVlENE83MEVGb01oMThW?=
 =?utf-8?B?dVVxdytPdVUvWTFZN2E1Zi9rR0swM05RQVduaHFTZnBXT0Q3Z29kSjN6QVRu?=
 =?utf-8?B?OTJTM210T0lOQXl1UVpNb3BYdkliNjFOQmVTOUZCQU9BMWVVdjdWVHVCRExV?=
 =?utf-8?B?UHBIeEZXV2NsbU1FOG1LOVhUUVY2c05ScjE0VVUwTVJrTllJUDhsaU5SVDJX?=
 =?utf-8?B?Q1ltZmZ2OGtMWUsrUTRhRit1dE5QNFVTT0lBUlRvd2pxbW9seWFZZmdEYWg0?=
 =?utf-8?B?cG94QThpbG11SndsYlhsZnc3bW1sbUxsbkxQNWFHTGlKOWd0SVRVS1IrRHRi?=
 =?utf-8?B?L0luZEFJK3N3VUpBNzZQd2NuY0h5cFlva3Rza0JabEU4Y0xONEJ6UENQbjVn?=
 =?utf-8?B?bEZkenl1dzNoajNaK3N5UTRHbWdYY3U1Z3VCWDUrUVp3Yi9BT2wzUkVianYv?=
 =?utf-8?B?QndwMXZCVVUwNS95aGNSVEdZUzg0ODZIMHZ3cUVma2ZzU0VlMEozSW1MUVYz?=
 =?utf-8?Q?1qrPeLpfyBQjAYfx4KLNqyZoxugs+9k7OoIrg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFpOOG8xNzFRWEEwNFRJWjJhN0ZIQVR6YzFkbms2S3VZSUZwS0VoRVdpa2pP?=
 =?utf-8?B?Q3hWeXg0bTFHQS9TNnB6UXhCbXk4b25mdGJWSkM1UTNYNVY2NXNJSDd6d29s?=
 =?utf-8?B?TXR1Zm1Nc3JMSzhMa2RZd2RPT09CaS9QR2FUaGxIOVczTXozLzhwQnYvbDlP?=
 =?utf-8?B?d3hoQnV6WENlSzBvSmduSVcrYmFkVEhQeGRhWmhaT0tKS3h2WnAzRWlabmsw?=
 =?utf-8?B?dU9VT1dGT294MzhScGFuNFVJYmI4Y0ZUNXpOVFNmZTBDSjBNSE5TMWRqaDhB?=
 =?utf-8?B?UlJyR3ZiK3VGTjNhQmhTN3J6M1JVaE1aNi9VcWpHeVh6dVBzcG5oMWprRXpS?=
 =?utf-8?B?Y0FqWm5KT1hSb0dQSExCTWFIbWNkaFlGRHpidnhyUURZSTlGbStlM2RTRVhG?=
 =?utf-8?B?MkQ0NGNpOVg4d2FMMmNxV3EwUktKTFUxTTRSK0hkcHpUMlBiVjdlUVJ6NnFq?=
 =?utf-8?B?L2VKeTNFZ2ZSWnc3Z1lnU0xFRzBDS3k0N0pnNHNGbkhuWm13T0dFR0lKb2E2?=
 =?utf-8?B?ZkFzdDZwdWRqMUluQU9uaGt6NmhTMi9wMWRaYU1KTFFVYzBtSjJEbmlyS2ZE?=
 =?utf-8?B?K0pwMU5pc2JqNWw0ZGI3OVoycDVYS1hGbnV5dUtpQm9OdG5kc1BBSDNHRDJY?=
 =?utf-8?B?S0xaK0k0NkNIYVhqVnJUNUQvaWNMQVRwOHNvL2M4QUNIZENBRFhpV0U2Q1JL?=
 =?utf-8?B?ZEhuL1dtdEpoZDZQUGdpWitRcjEyK2Q3NXFSK1NpV2lIMEVpNlVyT21jNnN1?=
 =?utf-8?B?bGpJUDJ6TFFWOVJlVTVkRjlWWkFFMjJDQUk5NW5uTkFVWjU0NWpIbEQzT1g2?=
 =?utf-8?B?YkNZQVVITWhNOUlKS1lkd1NKRHJicmpJbldTNXFXME5taVlQaVFNazBYbnBE?=
 =?utf-8?B?alJZTzJGYnFZT1ZreStYd3N2c1k4SjlVOWFDMENUemg3QWdrRmpEZGlvKzR6?=
 =?utf-8?B?Z1JZZUNpUUkxZm9IYU5mQk0xdkJ6QUJnY0NzSWVsVmhhdThCRVpROG55YkZ4?=
 =?utf-8?B?NzN0UFpnZ3IzTTNNKzljamFienFmTUo3Q29mMzMwVVNjOU9GRTN4aW85eTZt?=
 =?utf-8?B?R3BPZEd4YkhwdEJva01rTThrNkYxcHV4Sk8wNnNsempHOUcwNC95MFJvWWFm?=
 =?utf-8?B?T1JRaFJ5d3cvcmVzMGc0M3dDbWUzSkdYYlZLV0NKSzlOL21aT1JmRVN0aWpo?=
 =?utf-8?B?RUVmVDhjMmsrZXdYdmN5SlRJaFU2MG1LTFJ4MVJEZ1dKaXRMSmVMNVlEYVJu?=
 =?utf-8?B?RE1mT3VyZGFiU2ZvN2J0cHF4NkhMTTUySDUzbDIrbVFrVDhZYkhCR0k5aUVK?=
 =?utf-8?B?RFhPaVhJVVNGTDVpb1pIVUhZcEF1cTQvQ0M5NWdrNnV3TTVYOGNVQzJoNmRp?=
 =?utf-8?B?V0RpOXAvbXBGSzZxOVI5eG1MQ0w3bzMwRkNkclNKWHNNMUM0VG1kYVY1Y2FR?=
 =?utf-8?B?SEl6QklkS05ZWDNLeGI4eHJHRm9oamFYYmpQMExMMFhlZXE4UVdwSTllQ2Jy?=
 =?utf-8?B?YVNBU1BXRHUzY3RZVUVYVzFsNFR2VXlhY01GSUQwbGg5SFg2S0ZJRnNsbG1q?=
 =?utf-8?B?SUR3czdaaWZ4cjRyZXk4YzhNWnBvcXFuZlpDcjZqS0lJdVNUZVJyZW1GYk10?=
 =?utf-8?B?UXBFY09ZSGt5TEpqSXhnS2xQMEZhUWI3eHBERFpDUzlKUThJc1pvakdrYk5B?=
 =?utf-8?B?VkRNaEhFZ3BNcUMxbytPbXhtVENBOWhKLzJ0QzRETU1KbzFIcU9Kb2dkUmh2?=
 =?utf-8?B?c1pIeDhnM2tUaStSa29aTWxpWC9uUjR5U014bGp4cnIyZTVqVS91SG0zVEFu?=
 =?utf-8?B?THRlL1FCZXNGT01hNG1VejZiZGxMNjBDUXhhRjNZeEJiOUpRZTBoVG43SFcz?=
 =?utf-8?B?eWhHbkgwTnBmRjA0NzVMZ0JNZWJrZDMrbDhLVkNycUZ5dFRQaGl5WnV4ZHZU?=
 =?utf-8?B?c0gxYlBOUEpoeDhiaUx2NXNkVEZwUkJyajlacldqcHBrUDBDK1BmRGNldndh?=
 =?utf-8?B?R1phZnhzN0ozbTBWTWhrU0lqRXFXS1RnUVl4cDRvQzVhaWxzNjNWSGJxZmY5?=
 =?utf-8?B?a2hyM1hoUGdFNWZoY2lra2pEU3N2dVZ2NldLWEpYQjIvSWZRazFBcjJteExy?=
 =?utf-8?Q?lfrhzRbUcjr+d3bhzd//pOt+X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c023d7-0d71-4d8d-6b16-08dcf2d1b05e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:42:40.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+loPb3k0KMNIBpstyCcBfuRRPRwYEfIadG9hWaJV0Q5fnzkxJ5ZMn+GiTAfpKnib+485W4q5ek1we6Al/toAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888

On Tue, Oct 22, 2024 at 10:48:00PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 15, 2024 at 04:33:31PM +0800, Richard Zhu wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Call common dwc suspend/resume function. Use dwc common iATU method to send
> > out PME_TURN_OFF message. Old platform such as iMX6SX and iMX6QP, iATU
> > CTRL2 bit 22 (PCIE_ATU_INHIBIT_PAYLOAD) are reserved. So can't send out MSG
> > without data by dummy MMIO write. Without PCIE_ATU_INHIBIT_PAYLOAD, MSGD
> > will be sent out instead of MSG. So keep old method to send PME_TURN_OFF
> > MSG.
> >
>
> This PME_Turn_Off implementation is the only difference between the DWC common
> ops and the custom one here? I don't think so. Please describe all the
> differences.
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 97 ++++++++++-----------------
> >  1 file changed, 36 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 161daad34a94..baa853d84b4d 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > @@ -82,6 +83,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> >  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> > +#define IMX_PCIE_FLAG_CUSTOM_PME_TURNOFF	BIT(9)
> >
> >  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> >
> > @@ -106,19 +108,18 @@ struct imx_pcie_drvdata {
> >  	int (*init_phy)(struct imx_pcie *pcie);
> >  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> >  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> > +	const struct dw_pcie_host_ops *ops;
> >  };
> >
> >  struct imx_pcie {
> >  	struct dw_pcie		*pci;
> >  	struct gpio_desc	*reset_gpiod;
> > -	bool			link_is_up;
> >  	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> >  	struct reset_control	*pciephy_reset;
> >  	struct reset_control	*apps_reset;
> > -	struct reset_control	*turnoff_reset;
> >  	u32			tx_deemph_gen1;
> >  	u32			tx_deemph_gen2_3p5db;
> >  	u32			tx_deemph_gen2_6db;
> > @@ -898,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
> >  		dev_info(dev, "Link: Only Gen1 is enabled\n");
> >  	}
> >
> > -	imx_pcie->link_is_up = true;
> >  	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> >  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
> >  	return 0;
> >
> >  err_reset_phy:
> > -	imx_pcie->link_is_up = false;
> >  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
> >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
> >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> > @@ -1023,9 +1022,33 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> >  	return cpu_addr - entry->offset;
> >  }
> >
> > +/*
> > + * Old dwc iATU ctrl2 bit 22 (PCIE_ATU_INHIBIT_PAYLOAD) are reserved. So can't
> > + * send out MSG without data by dummy MMIO write. Without
> > + * PCIE_ATU_INHIBIT_PAYLOAD, MSGD will be sent out. So have to keep old method
> > + * to send PME_TURN_OFF MSG.
>
> Please reword the comments:
>
> "In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register
> is reserved. So the generic DWC implementation of sending the PME_Turn_Off
> message using a dummy MMIO write cannot be used."
>
> > + */
> > +static void imx_pcie_pm_turn_off(struct dw_pcie_rp *pp)
>
> s/pm/pme
>
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> > +
> > +	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > +	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > +
> > +	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
> > +}
> > +
> > +
> >  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  	.init = imx_pcie_host_init,
> >  	.deinit = imx_pcie_host_exit,
> > +	.pme_turn_off = imx_pcie_pm_turn_off,
> > +};
> > +
> > +static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
> > +	.init = imx_pcie_host_init,
> > +	.deinit = imx_pcie_host_exit,
> >  };
> >
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> > @@ -1146,43 +1169,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
> >  	return 0;
> >  }
> >
> > -static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
> > -{
> > -	struct device *dev = imx_pcie->pci->dev;
> > -
> > -	/* Some variants have a turnoff reset in DT */
> > -	if (imx_pcie->turnoff_reset) {
> > -		reset_control_assert(imx_pcie->turnoff_reset);
> > -		reset_control_deassert(imx_pcie->turnoff_reset);
> > -		goto pm_turnoff_sleep;
> > -	}
>
> What about this part of the code? Don't you need it now?

Don't need it, previous wrongly use reset interface to do send pme turnoff
operate. Now dwc common driver can do it.

>
> > -
> > -	/* Others poke directly at IOMUXC registers */
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -	case IMX6QP:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> > -				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> > -		break;
> > -	default:
> > -		dev_err(dev, "PME_Turn_Off not implemented\n");
> > -		return;
> > -	}
> > -
> > -	/*
> > -	 * Components with an upstream port must respond to
> > -	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> > -	 *
> > -	 * The standard recommends a 1-10ms timeout after which to
> > -	 * proceed anyway as if acks were received.
> > -	 */
> > -pm_turnoff_sleep:
> > -	usleep_range(1000, 10000);
> > -}
> > -
> >  static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
> >  {
> >  	u8 offset;
> > @@ -1206,36 +1192,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
> >  static int imx_pcie_suspend_noirq(struct device *dev)
> >  {
> >  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> > -	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
> >
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
> >
> >  	imx_pcie_msi_save_restore(imx_pcie, true);
> > -	imx_pcie_pm_turnoff(imx_pcie);
> > -	imx_pcie_stop_link(imx_pcie->pci);
> > -	imx_pcie_host_exit(pp);
> > -
> > -	return 0;
> > +	return dw_pcie_suspend_noirq(imx_pcie->pci);
> >  }
> >
> >  static int imx_pcie_resume_noirq(struct device *dev)
> >  {
> >  	int ret;
> >  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> > -	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
> >
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
> >
> > -	ret = imx_pcie_host_init(pp);
> > +	ret = dw_pcie_resume_noirq(imx_pcie->pci);
> >  	if (ret)
> >  		return ret;
> >  	imx_pcie_msi_save_restore(imx_pcie, false);
> > -	dw_pcie_setup_rc(pp);
> > -
> > -	if (imx_pcie->link_is_up)
> > -		imx_pcie_start_link(imx_pcie->pci);
>
> So this is also not needed? Why? Please explain in the commit message.

dw_pcie_resume_noirq()
  dw_pcie_start_link()
    imx_pcie_start_link()

Will add in commit message.

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

