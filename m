Return-Path: <linux-pci+bounces-36616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9AB8F282
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D107189E03A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19F223DED;
	Mon, 22 Sep 2025 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lN8gufNe"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD41B7F4;
	Mon, 22 Sep 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522885; cv=fail; b=nxAhkk66h43FnEdydLCh8rtonXs38kzJjz09/i2u0sAGhZr6qktFSOAsmkEhH2OKu1uMWsa0XphRO72rTijnF8PpCumNMyHDEpLmzHvWsJ5N6eDqYs41i/Wskcu/xfemZYn40+Wc0E4pME5Uv23nEZO/6ZFMqZt/vstCg9DXOTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522885; c=relaxed/simple;
	bh=nUESTG1gh9df6qZIvouCAXBm8zm6b3W5H3UYGBoGyg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyrSSoOgq3xwszdp4SYIgEZkIyHZTScEoUffb4KLaG9T7klSX4DTBhi3jffjVKzJzEMKqi++3B9PFG+b0/oKgEL/n83W5Nr59QE7x3OaYkdpMqpM6NV+KiFLbjikdeOe2T3rLtEhUo2PcW2+7NSdS2yuQdyhOvqZwGDgcJKtd4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lN8gufNe; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u898xUSQcEMsMDZlApE0UsopTbIcJkhwTUQirHLQZ8gh7LHuV1XXkALGtS6cY0HEenE+afNk+G4+KpfgxiKsv2U7C0BUjVLUPiNeuzERLnZTQrdR1ueOHJLMz2Iz/L9MuPnym9DcAOcB3K1QBSgBe/gsZbPCJZKE0gXh7zyhLjdi9WN+L+0iTlKM0uo5uPNIShHSAQgWIt4ZNZL/crzvE88cdKeyoOkdkWlertOyTXTUeE8cVEmS0T8nWFMQVPlNFNBeTucAjEVx5lk8dbnyUYGndwumCr4gdR4PAVA7p/EL4+9+D457lhZArvmsITdQi8EQ2i5HLV7IstZ1mSl3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUESTG1gh9df6qZIvouCAXBm8zm6b3W5H3UYGBoGyg4=;
 b=LMfaNxIoLpsNN4YEpdfh7pzZvXONaswsrAHFrmPVumLtG0UXKTgPozl+qycnpTEKVnREEkueiH6H7ftvprW6/weSILS7Q6otb5L+/OYFL37whI+q7WDi4v2fKfg5eLiWFZUZ54+2uFPJLSgjzAmBXvnPgm1g/7JNXs5uw9j1vrXtJ/430zUMFbfpV4ocXBO/gW4WZ8zx7wwB3AM/G0Rfhnv7OyZpB5zAnxAJ4fh731eNw0OzhagUmrQDrb917WO0GjOsLa2D0oHnG0rzSJxusj+RERblnlfGUU/6a26wapou/Dh/9ZX+CgpD9x1nO9M2haQzg6W7QRS2xF52b+g5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUESTG1gh9df6qZIvouCAXBm8zm6b3W5H3UYGBoGyg4=;
 b=lN8gufNeNnyQyFUQgrn+h348qOcLVdOSCWnPUHvBmy/YRgmHdEWfXK3GPAQAZKdsUozQ9Sg6bIVuk2M9MudEnqcwsK2QlOc1XFsj6HRPz//PeB8A87J++sE9+7LMu5RMN2ktKdVBvMZ1OoPuVVx4Dvj7v8jSQjn4gvVXRjg3nA49WEIowxwk4wByH9FBjeHzKFHgpr488KcwqirBq73EQqWUWv/0PmSHfY6Q3abhSWV6Jygcb8vLC0MfGI37LQOilgnqRWCmh8uh8f7+3WknygAlDg/+U+ZR8H6Ahd+sJPdG4SYne/bftYiNL0dGDL+0/Q4ICfDclvxf3f1GAi3KvA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 06:34:40 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 06:34:40 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/6] PCI: dwc: Remove the L1SS check before putting the
 link into L2
Thread-Topic: [PATCH v5 1/6] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Thread-Index: AQHcG9/yKmOyPQFTd0uVVtf8TcR5V7Sbr2IAgAMt42A=
Date: Mon, 22 Sep 2025 06:34:40 +0000
Message-ID:
 <AS8PR04MB8833C4E6F51614D78D349E6C8C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-2-hongxing.zhu@nxp.com>
 <b44numhx2wnelicynz36b3wdqrkudchn6l2s2jjmg6iecjk6ae@uo535zip3vq3>
In-Reply-To: <b44numhx2wnelicynz36b3wdqrkudchn6l2s2jjmg6iecjk6ae@uo535zip3vq3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS8PR04MB8403:EE_
x-ms-office365-filtering-correlation-id: 471c04e3-fb5c-449e-3ec4-08ddf9a21bcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzg5d2lram0xN3FUbzdHSjN5MkxmOXZvZkZuYzBWd2VTNG5HdUZwMkczNWtU?=
 =?utf-8?B?UXNCRWFGeC9UaXJQUWRhVThxRk9Yd0FHcmQ1OU56aW1hTFZoaDNpVzZJWmgr?=
 =?utf-8?B?aDNrY2xxL2dUSWFTcUZvd2VqNFlrcCtkNmRRWit4cVNJUFVxRVJPekRzSUZS?=
 =?utf-8?B?ak5wRmNaZWQxcHdJd2M3bkdVbmFrVnM2WlVqZUg1NUF1SDFWSEcreHdHbHQx?=
 =?utf-8?B?RytGaVFMZHlaK3ZIQkhISkRWMjdYTGFGaVI4R045OFhqejJ4dDR4amszb1Vk?=
 =?utf-8?B?V3ZRZmFpZVVGV05mSDVJT3lzMmxiUEVlZVgyamxqVHJzNnVSQnVTenRyUTEw?=
 =?utf-8?B?MG1ZcFhOZmpIeUZCaVkvVHN1TmpSUzRjeExBN1VZZEtyWFpYZDlDc3NLRFdH?=
 =?utf-8?B?VmpQV3I2Lzl3RmxmL3JBdW1nNit0aTRYR1RpYzdKVVRielNEdmhtS0U5b2ly?=
 =?utf-8?B?VjV0WmpTMUhteDRtaGV4TGsxMTQ2VlBwQUtqNG1zeW9QQmtJaEZ6WFczT1hH?=
 =?utf-8?B?NUxiRlVQVlpTaWNvQWVKRjFFcmJXYVFBdHFVLzA5TzlVYlpVcERPMGw1U1Yz?=
 =?utf-8?B?RTd2TXoxNWJmOU5pb3cxWnVYenY3aXgrOSs0L3Z2eFF3UnE5Uk00T1k5cG0y?=
 =?utf-8?B?enUwOVlhZEJDYSszWi90VjRDMHJhMjh0c3lTbkNvR2VxSlpUQWRyRE5Cb2lB?=
 =?utf-8?B?N0FYKzhQSVIwa0VLR2N3NFRNaFZDRnJScFRYS0J2R21DVHg0MHcvQUNyT0lz?=
 =?utf-8?B?UTZ3STBEb2FSTzNaRWlsdnFTUTBLTnpjQTJSREl3aWpXQTNobEhYaXNXTUVP?=
 =?utf-8?B?YUczYXZTZjFLenhpdGgxU2g4ajczK2d4UUlJMjg1d0NTYndXdnNFZFdRT2Q5?=
 =?utf-8?B?UkhJWVhXTmNqaGxyRG5JRWtaZHFPaTl3RHpjMHVlMk10Rk00MkdZSDV6N2gx?=
 =?utf-8?B?bnlCRkpKTFU3aUVoNm8zTUtkT0ZzMEhUMWZDL09GeUhmUHErb1M4YkNCN3dl?=
 =?utf-8?B?Mk5ETytFeUtFM0w4cmJpRDgrSXVUSjk3UGhjUXJWVWxkbDc3MW5XMjlqTm1H?=
 =?utf-8?B?a1FkZW1qbEtrUlM0YXVWQTlCUVpEalJyRWE3d1F0WUlyOTdoaDZvSFQrcko2?=
 =?utf-8?B?WWlRRlhsUnI1bFc4ZGpNaVA1REFLUkVrY2hpT3NZNlJRaDhWam9pTUpQaWNP?=
 =?utf-8?B?ZkdaU3BwUms5ZlNPS3dQZnNYY0R6K1VKN1U1aDZFdXZDeWFnemVkSldXWVFT?=
 =?utf-8?B?Q0RTT2NYSE9QaFluZStuR3d1VUlyV3NiSVBPL2R0bmlGeTVNc0ZMdkRBSEll?=
 =?utf-8?B?QzhJWFVWS2NpSWZzZDlraVRjaDl0V3Z5Zm40VnFYd0JRRnVQWDl1ZEJzYVcx?=
 =?utf-8?B?eEFOT3l1UFh3aU9mVGhUa2V6SHQ1QXJmVVd4Zi9nMlZQT1dXMk1mb21pYVBs?=
 =?utf-8?B?YVNTNlJ5RDBRY0psV1o0SHg0bU1MMGN3NjJDVVNnNGFxVWJPdUlrM3BhU0lZ?=
 =?utf-8?B?cy9MbTlncnF0eVpsd3grSXpndmNvWTlhazZUWTVkd2gvWUVScUFLNkQ5bEdn?=
 =?utf-8?B?WjdELzZLZzdxTFF1ZlFXd1cvd1ozcFI3VUlZRGttdkI0MHU0RGZGUkZXc3FV?=
 =?utf-8?B?RHZGTm5GSzNXSy8rbGFDUDgvVjYrMUUva0R1MVpQL1FDbTNuRVBhNDBRaUkv?=
 =?utf-8?B?bmVKT0tCWnBRbGZSMkdaOWs5aVdMZXk4Nno0QmhRYlE0ZXlzWnNKN0c3Tit5?=
 =?utf-8?B?emh1U0xYUjRPS1ZyK2Y1c2Rybnk5V2c5ejROT1NPMHVvL3FTSzRRRHFzN0JL?=
 =?utf-8?B?VkNNYlBaWEZuR1FwS1FybDUwaXhsMnQ2dGkzbFlMYW9wUXJIa0JSYU9EY09P?=
 =?utf-8?B?aGx1YkNJVmNzNDBRS3k1bzdkUW9pR3lRblMvcXNySUVvUXFDUHlJNmYvRjZm?=
 =?utf-8?Q?aTYvFtPBvME=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2pBVlJEdlZpSHJwOE93SERTL2paby9lclNBOGVEa2dtOW5BNHpYdkNlWTFP?=
 =?utf-8?B?RW0xSTEwa0Q4dmxhMHYzN3gvaTZxb1RnbzE0eEFJeXRRL1Q3SVFIZmtKaGlr?=
 =?utf-8?B?bmg3OXhRNUxEMXhEVUtKaUFTNEphTm9MQ3psNmhPb2QxeVBpamZvSys3RmhK?=
 =?utf-8?B?UHgrb2dGUThXVWJqWDFjZXJvR2t5OXk5RE5iV3dXSmRoMHdxN1QrQ3lrZncx?=
 =?utf-8?B?eHYzSEhKeVFFLzBPUU95RFppRUJVV0Vka0dGQ1FLa1ZkSE1CTy9NcDB0MFhD?=
 =?utf-8?B?aGpyaUlzalJ4S0k2enJ0TnVORW45aHF1REx6cTlzZTNjcklBVmMzeENuSURY?=
 =?utf-8?B?bHlHOWhHWHE1U0llNHlrdSt3YWhOYkN5OTlON3g0UDh3cXFMa1dpRE4welNu?=
 =?utf-8?B?TU5rdzhrUGRCUjNCQUQ5WkdVbHgvZjA2cUk0WC8xQ3RTUlh5RXQ1KytYQ1Z2?=
 =?utf-8?B?OHZUTUhpY25CQjMzeVp4ZGxyU2hSRjArdTB1K2pJbjJCN01QNlFIbnJmSThC?=
 =?utf-8?B?eVhJQXBES0NDV1A4Tk56ZThIUWJiclFvRUxuQXlsS3VFYkltRmp6Nm9tSUpt?=
 =?utf-8?B?UUlQV2VSZmdNV1ZadkNGWm1xRDg5d3hKNWdGQzQvYmRyZ1NNdUNSV1lkZTQ5?=
 =?utf-8?B?alpPVkNZQStIYmprcjZhcnArQmFKQmxLTjRHNFQ4M0crOFpzdXM5VU1ERFpo?=
 =?utf-8?B?TjBDTXhSVkZnTjdvd3dpTjFqQVdwa0ZXbEkrSDMrbTZNOHI2NXIzMG56dStu?=
 =?utf-8?B?RTZRbDJMTmhPOWpXK283bmQrL0ppNWRVaXYrSmRjQm5JenQ1TUszMWVqcFFs?=
 =?utf-8?B?T3VtWmlXSVFMOUdnajN0TWZmbnovaCsxendYTWJSamhFSWxaWGwxYVVkcHVY?=
 =?utf-8?B?ODhnTFhiblR2Y2xyWFBZWkp6Rk9yMmZ0bFg4QUNoR2ZzQ0FyanJISVhvN2RY?=
 =?utf-8?B?MlRCV1k0ZVQyK3BYUmlFYUhlUlA3b1hrMVlRL0ZBUmV0dVNRdTJVZFhScW1T?=
 =?utf-8?B?Vi9ndSs0ZDlpZmR6OGY1eERjcWZzL0tVZlBCclVUWnpvZXZQWGxKUktkbDZB?=
 =?utf-8?B?cWhjSzEwOGlqUWJyWmduSjNSYzdnYkJaWXJXdGNIZjM3NjRIN1ZydFVRTEVt?=
 =?utf-8?B?QlpHRVpUOXBEQkhqTVhLc3gwbkFMZlBBRDN5aHB4aG9DUlFON0oxb1NudEdB?=
 =?utf-8?B?ejNnaE9Eang2TkJmMFZVd0dJSk9FUlZCd1I5Y1I1U1lKYkRkUGp1Sk1GMnQw?=
 =?utf-8?B?L240L1AxNTI2ZFJzVWJtMzl0c3ZwTFcvRi9MU09NYjJMbVBvdGkxTWRqSHVi?=
 =?utf-8?B?cHQzbk4zL1lhSHV5M25GbkNEay9mSjVZdjdET0hDUkJGNnN0VVYwRTdYbitL?=
 =?utf-8?B?ZTJ2Y0R3bmJMbXdQWkZVMWwrSyt4VkhJYlpNdDNkR09WQWNuT0x5YmhSLzdh?=
 =?utf-8?B?bytqNEZoNW8zcjZWcDl0TVZnR3NMVVNMa1MvUEdiVjFTdk9Gai80RVdLL3Zo?=
 =?utf-8?B?NzJSbDNNM3hiLzJOWDJTVFV0UUpoMHJyRXpkTENpV3EyZWYxb3pEUjRpcFQr?=
 =?utf-8?B?blA2aFRxdXFFQS9uWmFxMTVBa3hNVEZ6bjFXNEJyKzVka3JkcjVxQmxJbGk0?=
 =?utf-8?B?ZzUyaGcySW5kdUtqcS9iblYzaEF1L3VwYW8ydGJpSFluRGxoTGJSMnZDOVRa?=
 =?utf-8?B?ZkNSdWR2L0dtb1l0a0Qvbkt2SUQ2WGViVDBBV0Jud0VlUHBPc3hHVC9wWENu?=
 =?utf-8?B?Zm9xNHI2TGo3Q1Y5eUxBM01LdTVXajkzd2F1QnBRcloyTktMQTROMjBHOFdK?=
 =?utf-8?B?V2xmTlg0SXdwWk9SeEdrTERJRFFVSmJHWTRHQ0dRQU9UdGlCaHVJMTBIWUVk?=
 =?utf-8?B?TDNxNDZzQ3k0NjNnaGkrenNVM0Yvck1UVk9ZNDdKQkFuMzRhYk56amtXSTJQ?=
 =?utf-8?B?bVFkdEtQZXVEUnhLSk9Ka0l0d0VxWk1kNFRUZ1BVcnQzVlpTTW44cEZoUUZB?=
 =?utf-8?B?SUlta3Bhd0FoSEh5ZWlyNG1rOEhCcnd5Ui9OaXBZU0NwNENCNy9wMlJXOXgy?=
 =?utf-8?B?cTB0NnZVck44eUFGVXlZazVXNmZnZ25PZ1dxWFFVQkh0b3BuWk1kSXArT3B6?=
 =?utf-8?Q?PYWE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471c04e3-fb5c-449e-3ec4-08ddf9a21bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 06:34:40.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1Xi67qex4Ykf3I6kLic+p4A+hlOIN4yatZSM+ikF843/+1Ixn122BZ26ZRMpKrMwCqOCpin0q73aFiL0+gXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIgyMOaXpSAxMzo1OA0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS82XSBQ
Q0k6IGR3YzogUmVtb3ZlIHRoZSBMMVNTIGNoZWNrIGJlZm9yZSBwdXR0aW5nDQo+IHRoZSBsaW5r
IGludG8gTDINCj4gDQo+IE9uIFR1ZSwgU2VwIDAyLCAyMDI1IGF0IDA0OjAxOjQ2UE0gKzA4MDAs
IFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFNpbmNlIHRoaXMgTDFTUyBjaGVjayBpcyBqdXN0IGFu
IGVuY2Fwc3VsYXRpb24gcHJvYmxlbSwgYW5kIHRoZSBBU1BNDQo+ID4gc2hvdWxkbid0IGxlYWsg
b3V0IGhlcmUuIFJlbW92ZSB0aGUgTDFTUyBjaGVjayBkdXJpbmcgTDIgZW50cnkuDQo+ID4NCj4g
DQo+IFNvcnJ5LCBJIGNvdWxkbnQnIGRlY2lwaGVyIHRoaXMgc3RhdGVtZW50LiBDb3VsZCB5b3Ug
cGxlYXNlIGVsYWJvcmF0ZT8NCj4NCkl0J3MgbXkgZmF1bHQgdGhhdCBJIGRvbid0IGRlc2NyaWJl
IGl0IGNsZWFybHkuIFdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZS4NCkhlcmUgaXMgdGhl
IG9yaWdpbmFsIGRpc2N1c3Npb24gYWJvdXQgdGhpcyBwYXRjaC4NCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2lteC8yMDI1MDgxODE1NDgzMy5HQTUyODI4MUBiaGVsZ2Fhcy8NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KIA0KPiAtIE1hbmkNCj4gDQo+ID4gRml4ZXM6IDQ3NzRmYWY4NTRm
NSAoIlBDSTogZHdjOiBJbXBsZW1lbnQgZ2VuZXJpYyBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGZ1bmN0
aW9uYWxpdHkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYyB8IDggLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IDk1MmY4NTk0YjUwMS4uOWQ0NmQx
ZjAzMzRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTEwMDUsMTcgKzEwMDUsOSBAQCBzdGF0aWMg
aW50IGR3X3BjaWVfcG1lX3R1cm5fb2ZmKHN0cnVjdCBkd19wY2llDQo+ID4gKnBjaSkNCj4gPg0K
PiA+ICBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpICB7DQo+
ID4gLQl1OCBvZmZzZXQgPSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ksIFBDSV9DQVBfSURf
RVhQKTsNCj4gPiAgCXUzMiB2YWw7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQkvKg0KPiA+
IC0JICogSWYgTDFTUyBpcyBzdXBwb3J0ZWQsIHRoZW4gZG8gbm90IHB1dCB0aGUgbGluayBpbnRv
IEwyIGFzIHNvbWUNCj4gPiAtCSAqIGRldmljZXMgc3VjaCBhcyBOVk1lIGV4cGVjdCBsb3cgcmVz
dW1lIGxhdGVuY3kuDQo+ID4gLQkgKi8NCj4gPiAtCWlmIChkd19wY2llX3JlYWR3X2RiaShwY2ks
IG9mZnNldCArIFBDSV9FWFBfTE5LQ1RMKSAmDQo+IFBDSV9FWFBfTE5LQ1RMX0FTUE1fTDEpDQo+
ID4gLQkJcmV0dXJuIDA7DQo+ID4gLQ0KPiA+ICAJaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9v
ZmYpIHsNCj4gPiAgCQlwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKCZwY2ktPnBwKTsNCj4gPiAg
CX0gZWxzZSB7DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/
4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KDQo=

