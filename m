Return-Path: <linux-pci+bounces-24694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1CAA709F9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621C818859E1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105E219066B;
	Tue, 25 Mar 2025 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NV3pc9E0"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B12E337F;
	Tue, 25 Mar 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929317; cv=fail; b=qHHAds520aRFNZ7qPgxE7lCwXzyyAb5sQvA/ZMrQVcWlamYkaNUetJYGvbp4WeYPR2iE1MQJHGfK2QbWioL8g10o+xsgYqXWMBmJQ1xnugo+lYuGS53Z0AZ1jiQ6eelLZoH048SBoukcATc8T7m3bTsE6hUVY/IC/1eDykGoWUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929317; c=relaxed/simple;
	bh=W5QeKlNBIr7+MEnojI0+wADsW/AdIkyp++CDsePbzsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ij3Q+UUmlGMgKzM16DHc6HjcYeg06KlHX9giNoyDGg3ZvFcexZZt0I1cZLs/+WrRkYbi8+Vx/hVCKUE2RNx6vzwHoQN98hHtGEYY/T0Jd9I0c2rbRwQRJv6RLI1/qmG3gNM/GPjK3+I4NWG20Ki8yYSlzOTp4h7mdyuP5GVBg3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NV3pc9E0; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmZLoJZtN1ckEB4vJEMq2aZS+WF27I+kQpy5yNLkxKlPnCgpBP5Ej6jrXpGkRiVyPOHuQG5Nwk2QlS7qGr6WlkdBad6FQ1CbB48HoypyIPe0RRFrMFXMltpo/8wi6GINK5O7rf3VZn9XFEX6Ci0pSS77hCqL8zuHex3apRr8gMSAuZ0Y1MMwDxvjY8fdaaWkmXrsauIYrTb9Jffs7x3oki/3ARDJ7t0+az9e9PFLn5IOy6yfb5G8P6Cx2T30KBLzJgHYHuLXGfBfqmYYEI7fuQy2PCoYuPCpINJqC/D+4Ydw/E73ELnriOuVL8BcmP8IohV7d4czuOVGcWZ4bNzqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNFsOJ5jnG/0xiZlO/BBBcMYrQfRcicEFRgCj6/8T3c=;
 b=VyrwZsPs427Wn43toDEouaq/wU7K/c5Xahf8DIbRZqQ7m4GjLhfvFQ5+czWUKeZ47JeZ6kd4kb1DyfoOZv6L9pLnf21lD/RqQZ6aWEtNjpyFNT1SMjDIJVfG2g2lUri7+kG35LuNcXVAPrrEZ9QRUR7JAHD5l7wBzvC92GL+LV7iHYxW2SdD1UoPQGKrq65p5t/HdnoNTY7Xh/F312WBPU1D/T6VDaeitLaFnIJ0/3E4MSWqES5uubACFyL0h5tvUg2fQQeUoNJjBWxH2erLfWowNiBuU2aMW6WaYqlLZa6U/7Hz4xMyeTbXTgs8GAeOPnZfPfudR9VxEzRR0FvtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNFsOJ5jnG/0xiZlO/BBBcMYrQfRcicEFRgCj6/8T3c=;
 b=NV3pc9E0b/P2UXRbYGcjim7hB7oVUj4RRe+6VyS/SfQqW1iPwDGt6IAEshsfYt/ixHWIhqz19dD5mgGP81XF177P4mtwbaDOdehhwEkRctyRyFfIqt5y2IgPZ+cAglhtDqafjEevPCiqh0h8UW1KtOBaIzvQJgSDJcxGirL2sHSSlvJr3YSMH8a1dA1muTJcGefqp/b8507gTPZSN8O3Cr/McejsuY/2lnF/P7yWyp4iyu/54sXPVmZeEMLNUbdETvWKF5uaaWxB83MsPNkpzTEOfSR1SKuutIMpgioyjlOrpXNbS6hz9hYWNM08INnZYNlMG+WXeCKz0gcEDUxaJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7655.eurprd04.prod.outlook.com (2603:10a6:20b:292::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:01:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:01:50 +0000
Date: Tue, 25 Mar 2025 15:01:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <Z+L9lb9OWAzQSIkl@lizhi-Precision-Tower-5810>
References: <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>
 <20250324200437.GA1257874@bhelgaas>
 <3rtte7uyv7gilxnstcxjizpkdlfk5rfxwyc3bd4ednjakn5rfc@fhidkj5vvmtf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3rtte7uyv7gilxnstcxjizpkdlfk5rfxwyc3bd4ednjakn5rfc@fhidkj5vvmtf>
X-ClientProxiedBy: PH7P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5315619a-679c-42aa-4cef-08dd6bcf7ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJFcjNEcmZUdkZxWkNXTzVUQXI2NTF1ZXZMN0VDcjU2RHhtYWd5K3Rkckhv?=
 =?utf-8?B?a29pemswMk9aTXRIeVEyakJDbC9DdzducW54UE1CYXgra2tkZzhQR3lXeElq?=
 =?utf-8?B?aGpkdDJzTTAvaVg0WVJJSDRLU1laWDdvTmhsVWZWcDlvY05UWkMvNENnaDZF?=
 =?utf-8?B?Tk1SSVFqbEVlM3JQQWpBZGFqWHVLU3NtbW84bmhLUit0WE9pU25BMjRuajlP?=
 =?utf-8?B?KzVMZWxmRERYRlZaNWtmbk5WeDd1dW94RnRKZ2hsSjBKeHk4TTBHNkF2a2t3?=
 =?utf-8?B?c2swdkQwUE1hRjhMK1RqNlgwNzc2bUtkUDAxU1BuNVkrSlhzQ05UM1JXYktq?=
 =?utf-8?B?ZGM5L21UWEtMZHB4V3hLQ21wWitReXF0RUZsWStwNE1XUlY4L1pBWUx2U2xh?=
 =?utf-8?B?MjFtWEFMM05TdG9BMCt0eVhTRXpIMU82TnZsLzRqY2JTekdIVXRqVVRQUjFj?=
 =?utf-8?B?Q3E4Q2V5R1czejVub2J5bVpmb2JNLzRoS1JIVHV2U21wQ1p6Zm1KNFRTN2xC?=
 =?utf-8?B?L0RnTDI4RzFoZFZZSFdRb1lpek1yOFNxMnJEOXBkbk1MSHpCVUxVN3BNSURy?=
 =?utf-8?B?TzZVVWVsWmdWbDltTk1kN20rY0xQVzhUeEJZNkJmQUxJNFJKRk9BNWxrUlF1?=
 =?utf-8?B?ZzQvQmJuQmFrWSs0MEsySncxZzdyZ2JFZExuSmZ3dkh4cWNHckJYYjFTVkds?=
 =?utf-8?B?WUFuM3QvTW8xZnZwK1QxNnowV0IvTjVOTlV1UkI2YzBCaC9QL0M4S0hzaFRO?=
 =?utf-8?B?RU9PeCtjaEZ6VmZiS0NLL1JwcVl2eEw1ZjFFUll0cDJwdWZwK0NJamNzaDlP?=
 =?utf-8?B?MUwrRXlsU3FyVFNia0wyRzlmUE1tdU5HUjBOckdPQitTeGU1a3MvaFR4ZjBt?=
 =?utf-8?B?bHNzMGJiTEJZdTJoWnhlSjJVUElMVDJGems0bHlLY0RIWXNsRy9pT094MzA5?=
 =?utf-8?B?TGErWEtMQTN3eTdGNXVBQm9oSUVIdmR4MndkSGNWRVhMQXI4TWtXanZCZy9w?=
 =?utf-8?B?K2VmV2V3NHlvMkljNWkxbGdCVmR5OVBoenN4ZHdtNDdCbTExcS9XdHJSYSs0?=
 =?utf-8?B?SThLRzkwS2JRV0cxcVlVSFg4NWE3UkFSYTVZVTFIWE8wajJpTXd4dU1BZHp3?=
 =?utf-8?B?SUVWT3VHTEttYUYvMDhHN3BwSUt3dE5qL3Y3RGdsYnBjRzIyT0dqV01tMEpJ?=
 =?utf-8?B?VUZORFdMZitDRERBcjA1K3Z6RmhubmhGZkV4Z2RaYXBwcTNld1kzaEtXSDdF?=
 =?utf-8?B?cVZwcy9ScGI3dFZTL1BxU240UHpCOWpZbzFmMEJDZ3Bha3U1T1hkbWVnQWVx?=
 =?utf-8?B?cEpWRGhaQjMrUG1XYlVPeTVvTXBXazdDZXV2RTVRL1ArK3JzNEM5YzhJaTdx?=
 =?utf-8?B?VlorQllGWXZGcTE5KzBaRTBvclJxL2pzd0ZwNjZmNTZEbmFIUUxCVjkxdm5S?=
 =?utf-8?B?VXNRWE9IQ204Q1VTeFBMcjZEUXYwK3BPWE5QcVFFNmg2NmdDSWNSemxzMFJV?=
 =?utf-8?B?VWdYUXF2Y3JVVFlKNUFTa1JiWHlPTU5Wd3hjUlUwRGdYbGplN1VsRmxVTlRE?=
 =?utf-8?B?TG9BKzJGUTNnZ1NKS1N0THRRcHl4eU1OSlNaQThBZm85OENVTTNhUUpTbURr?=
 =?utf-8?B?cUVXQmtYNmN3K094bHN4ZzRoMnVBN1NPTk1UdTlNcnl4d01SUmsvaWpGaWFV?=
 =?utf-8?B?aTljT3RjVEQ4amtBcVF5aEpkM1BsK0NWZGo2eExZUGF5VnhsZWRwbks3Q3VO?=
 =?utf-8?B?WnVGdHhLVDRodU52NTRFd2ZBY3BKcnpId2lyTEVGWmdmNU5jZ1lLaTRGc2N3?=
 =?utf-8?B?eUo4MHkwOW5Vc3RoOUwxamNicitDSjA0ZytmYWxKZWYxTDNRN2JoVnJnakZx?=
 =?utf-8?B?WHI1M2RMZ1plbFFVLzlBaHVjSlJmV0RMcDkrR1lLWEdZRDRWSWd0WW5ySmFa?=
 =?utf-8?Q?6SeanzN6Rmzn3+1rdKAV8N+r8JAo43zp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmliOEhnbFhyOGJmREJQR3BLQW5ORUd3RFBBenMyc3c3K20vZ1lWUG91YTZE?=
 =?utf-8?B?cGcrNTNxQXJPRHVaZldFNlAxWWZIdGRTaFFzKzAzSUxTN3JNUHo3NzlZd0FW?=
 =?utf-8?B?YmV6Y3VreGRjbzl0R0wzZVY4YmFielFHVEFNMzNxV00xQ3FwcUh3T1lVOEJB?=
 =?utf-8?B?WnY2MDJqYlh3WFJSYmZrQmw1ZENFQlpqMGY1dlFQaW1Oak9KUjk4SnlnUHUz?=
 =?utf-8?B?UU8vRUMvbjNTSFYvQ3Z2Nnc4NGt3NlFLd2JMQkxqS3pQeFd3a1NHUDVBYVor?=
 =?utf-8?B?SCs3RWx0eTJNU0hlbGJqK3BGeEVTemFWN2RiajgvQVVoVWpCTS9Qcnk4ZVhT?=
 =?utf-8?B?WXYvS3Z3OWFqcUM5QVNva2JjcGM1TWRnZEo2MU9hK0ZqekZXZXR6VlYvcEFn?=
 =?utf-8?B?N3RNS0dmUjZNV0xud0JKMVdVdFhMOTlidFZ5ZjBaRGhpV082dDBDNTN0MndT?=
 =?utf-8?B?M2ViSlFubis5Q0NUb25IMjNNckxha1ZDR1kvSVBReENKYzlvcWI4QVRlR2xC?=
 =?utf-8?B?eHJkNzJZbFNDaThQbUlqN2YyYkRQd2hyR2U3SjhUaEMxU3RZWEswakNVWWl4?=
 =?utf-8?B?YitSaDZZVUZsbFp0QmlOam05ZFVycGVmZGllQXl4SGtDTE8vVVVYeTRFNzVt?=
 =?utf-8?B?c1JsRFNXN3B4OGU5S29wM2tNV2pGQkRuMEZJcVQyWUJmNFFNMWhLbVRtdXJ5?=
 =?utf-8?B?ck1MR2ZITEdBaHpneHI3M3JYRElJR0Vkbm5IOWp5a2RQaU1idmRjajlIbmNI?=
 =?utf-8?B?TTRhdW9iRVZhM1B1TWFPODcyekd1MWtzUm92MjlmOGVIbGF0VHZLU3lMYmlz?=
 =?utf-8?B?aERaU0tFYjY4SkZBWU5wVVpQeHA4MlA0Rm91dEZBK09COE5hQTZWQW1LeGpB?=
 =?utf-8?B?U3F6QmhLWldEc0FOVjJvSTJtMnFTRUVsZEhwbnR0eGtJTTdpSDZibGpzd2VR?=
 =?utf-8?B?OWc3aUhDamthek4zaHhGM3pNR3diS21zd1pGQW1FR2lvSG5iUlBPclk2OFBR?=
 =?utf-8?B?MlhHWU94T01FV1V4Ky9wMWw5M1Y2bVB0Smw2SkVHZTk2Um5FSHdFbi9nNTVO?=
 =?utf-8?B?UE1XdG5xcVloVU1MT1lTZjhtK24rK2cxSTNyZzBib0N3ellNczdxemNlcito?=
 =?utf-8?B?Zys1Mk5BVXdsZFZWeVJpOElaWHE1OUVLVUtaRDFaSzZrNGlzcXJFdDVUb2o5?=
 =?utf-8?B?NDQyWTY1ejFicVQrcHFyTG40VlVPWmo4OWFzMkNTZ1JFbWNaem5FQ1BhSU9o?=
 =?utf-8?B?ZDRWY3A5WnI0dnFWS2Nwa3UrSW50VkJZNFJTaXFhTVlFUTRDK01pekE2TnRx?=
 =?utf-8?B?UTdZY0dPRjhSVnhReXNGTTFjMVk1VEQ0NUNKVUZrTlIraEJhekZpZW1MS3JO?=
 =?utf-8?B?Y1oxbzd6VUV1MEZ4YkhSNFBaMldkSHN0U3hxQ29IQ2RLYTM5VSswNEFPeTVs?=
 =?utf-8?B?aVA1c3VweG1HckYyVml0ZFBzREZNcCsvbnR5R1RUVFFHVHdqaWRxbHdzaFll?=
 =?utf-8?B?bTRhRDNkK3FvUVR5dkNEWlNhNk45cTdvLzlaL3graGIwS3VVOWdIcWQ0MjRO?=
 =?utf-8?B?Sko1Y0VUeW1icVFwd0RJUU1vcFVZRWN5Um0wUjEydGt4YzZrWVM1OEl4Nklv?=
 =?utf-8?B?Y1hWZmVHT1hFWXVzYzVITkdzUHVxUHMxZ3RvMjhva2VHN2pML0dyZ0VCbHUx?=
 =?utf-8?B?UE5FbWVFQjE5SzBKakMyWEpqSGppSjdjZ3BnMU9iZVpiMm9LazNVQmNzdkR6?=
 =?utf-8?B?REtUU28zNk9YS0RxcHV0R01kRUMyRDc1cHptenZaTGVDU0F6b1k1QkNiczhu?=
 =?utf-8?B?eGlRRW1sV084M0N4QmdUL3V1SFpldWlkcEcxaWFhYlN6YXVyM25uaVB6MG84?=
 =?utf-8?B?OUpKcVF6bG41d09QWkV1c0hkdnNDdzVUNmNCUDJxcXVNMVBiWE9vZU1mSk1z?=
 =?utf-8?B?ZHpLdHZCZGxiWmp6YmhlaTZ3NUhZb25Femd5dldBRjg2aVJ2cU5nRXVsbzhj?=
 =?utf-8?B?ZWVYd3BHN1JBYkwwN2xIamtKcFNQQUxHdU5EamkrNkVudHhuRzlZVHRpUmNw?=
 =?utf-8?B?RTZmRW1ZdWFWb1g3dFhkSEpTTFlXZjVBZXZNS1J4aDVjcnRsdkxJa1lXQWwy?=
 =?utf-8?Q?jV1s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5315619a-679c-42aa-4cef-08dd6bcf7ffa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:01:50.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fZhA3/nLox+q28xkHEEdd0ksomA4+rPVQUZ5L4PYNQwXQrFRg5gg1cEM3qJ9z/tWc7/jqtoLFOuGU6n5pvkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7655

On Tue, Mar 25, 2025 at 11:39:15PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 24, 2025 at 03:04:37PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 24, 2025 at 11:00:24PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> > > > From: Frank Li <Frank.Li@nxp.com>
> > > >
> > > > dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> > > > controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> > > > is a hard-coded way to get the parent bus address corresponding to a CPU
> > > > physical address.
> > > >
> > > > Add debug code to compare the address from .cpu_addr_fixup() with the
> > > > address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> > > > redundant and should be removed; if they differ, warn that something is
> > > > wrong with the devicetree.
> > > >
> > > > If .cpu_addr_fixup() is not implemented, the parent bus address should be
> > > > identical to the CPU physical address because we previously ignored the
> > > > parent bus address from devicetree.  If the devicetree has a different
> > > > parent bus address, warn about it being broken.
> > > >
> > > > [bhelgaas: split debug to separate patch for easier future revert, commit
> > > > log]
> > > > Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
> > > >  2 files changed, 38 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 0a35e36da703..985264c88b92 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > > >  	struct device *dev = pci->dev;
> > > >  	struct device_node *np = dev->of_node;
> > > >  	int index;
> > > > -	u64 reg_addr;
> > > > +	u64 reg_addr, fixup_addr;
> > > > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> > > >
> > > >  	/* Look up reg_name address on parent bus */
> > > >  	index = of_property_match_string(np, "reg-names", reg_name);
> > > > @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > > >
> > > >  	of_property_read_reg(np, index, &reg_addr, NULL);
> > > >
> > > > +	fixup = pci->ops->cpu_addr_fixup;
> > > > +	if (fixup) {
> > > > +		fixup_addr = fixup(pci, cpu_phy_addr);
> > > > +		if (reg_addr == fixup_addr) {
> > > > +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> > > > +				 cpu_phy_addr, reg_name, index,
> > > > +				 fixup_addr, fixup);
> > > > +		} else {
> > > > +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> > > > +				 cpu_phy_addr, reg_name,
> > > > +				 index, fixup_addr);
> > > > +			reg_addr = fixup_addr;
> > > > +		}
> > > > +	} else if (!pci->use_parent_dt_ranges) {
> > >
> > > Is this check still valid? 'use_parent_dt_ranges' is only used here for
> > > validation. Moreover, if the fixup is not available, we should be able to
> > > safely return 'cpu_phy_addr - reg_addr' unconditionally.
> >
> > Yes, that's true IF the devicetree has the correct 'ranges'
> > translation.  This is to avoid breaking platforms with broken
> > devicetrees.
> >
>
> You mean the driver without cpu_addr_fixup() and devicetree with broken 'ranges'
> property? So the existing platforms... Not a bad idea though.

I worry about some platform without cpu_addr_fixup() use fake translation
by ranges property.

like
bus{
	...
	ranges = <fake_addr, real_addr, size>
	pcie {
		regs = <fake_addr + offset>
		reg-names = "config".
		...
	}
}

So add above check, we will remove it if none report it for sometimes.

Frank

>
> > > > +		if (reg_addr != cpu_phy_addr) {
> > > > +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> > > > +				 cpu_phy_addr, reg_addr);
> > > > +			return 0;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> > > > +		 reg_name, cpu_phy_addr - reg_addr);
> > >
> > > This info is useless on platforms having no translation between CPU and PCI
> > > controller. The offset will always be 0.
> >
> > You're right.  This was probably an overzealous message for any
> > possible issues.
> >
> > What would you think of the below as a replacement?  It should emit at
> > most one message, and none for platforms where devicetree describes no
> > translation and there never was a .cpu_addr_fixup().
> >
> > It's still pretty aggressive logging, but I'm just concerned about
> > being able to quickly debug and fix any regressions.  Ideally we can
> > revert the whole thing eventually.
> >
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 27b464a405a4..4b442d1aa55b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >  	struct device *dev = pci->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int index;
> > -	u64 reg_addr;
> > +	u64 reg_addr, fixup_addr;
> > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> >
> >  	/* Look up reg_name address on parent bus */
> >  	index = of_property_match_string(np, "reg-names", reg_name);
> > @@ -1126,5 +1127,42 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >
> >  	of_property_read_reg(np, index, &reg_addr, NULL);
> >
> > +	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
> > +	if (fixup) {
> > +		fixup_addr = fixup(pci, cpu_phys_addr);
> > +		if (reg_addr == fixup_addr) {
> > +			dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
> > +				 reg_name, index, reg_addr, fixup_addr,
> > +				 (unsigned long long) cpu_phys_addr, fixup);
> > +		} else {
> > +			dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
> > +				 reg_name, index, reg_addr, fixup_addr,
> > +				 (unsigned long long) cpu_phys_addr);
> > +			reg_addr = fixup_addr;
> > +		}
> > +
> > +		return cpu_phys_addr - reg_addr;
> > +	}
> > +
> > +	if (pci->use_parent_dt_ranges) {
> > +
> > +		/*
> > +		 * This platform once had a fixup, presumably because it
> > +		 * translates between CPU and PCI controller addresses.
> > +		 * Log a note if devicetree didn't describe a translation.
> > +		 */
> > +		if (reg_addr == cpu_phys_addr)
> > +			dev_info(dev, "%s reg[%d] %#010llx == cpu %#010llx\n; no fixup was ever needed for this devicetree\n",
> > +				 reg_name, index, reg_addr,
> > +				 (unsigned long long) cpu_phys_addr);
>
> So this check is to detect the usage of old DTs with new kernel without
> cpu_addr_fixup()? If so:
>
> (1) The log is not accurate
> (2) The driver would be broken, so the log should be an error. This condition
> should not be met (if we do not remove the fixup for some time). But I think
> this check should be moved ahead of cpu_addr_fixup() so that the correct DTs
> would be honored first and the fixup would be ignored for them.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

