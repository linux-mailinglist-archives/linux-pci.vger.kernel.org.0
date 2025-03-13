Return-Path: <linux-pci+bounces-23667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD6A5FB9D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF781167885
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5BF268FE9;
	Thu, 13 Mar 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOfYLWfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B60268FDA;
	Thu, 13 Mar 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883183; cv=fail; b=HJCzrvjglN7fkNIyfpK/e6a9w+yJJywKprMFcfdnn43WpLlNsu2DUSv0F3Cbn8U+lgx1uMDw1vU8jS+AJV5lAG7iOlIrKAdYEtNWQ/fcNY4p/OTO4iXtcnUlP4Qyarpx1i4g5kck7usMTEJLi3SisuNSJPJuAIW9A8duGD3MYcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883183; c=relaxed/simple;
	bh=VaB2yxcGC8M5+Rl7jI0YYISsfO8KbzaVV3iib0Z4avw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O2lgTZHBzTRw0E7qD4zHgVH981fDohtSKQvCRhMX99y+VyQGEBI6DJ9LZfU5K0jTNSdrRNizbo4lmhGPKmJcrm/xqjdKbntsQ8o5SEJJwuUOlTuVHkaAGlc6GJ06q+6qo69gcdMHNVrbPufEA+RFhw2C+h83KDtu7aT5NPpthFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOfYLWfn; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvS/9nwQJ/7sy50mgcCkKgvcQlO/4Kbe+ImXXFIy2VQgqrgm634MrIjZ4joNMQdNPnCv2MCkU3NfouDyfMynl6SgOQHbEoUUru5ahdiqZzmXsgIeWBwO9rpJ11PzS2OmVZcLqpDRLMaYFJb64WuhXUJN36OEOZ2yJQ7uuLe4VQr3LvG5VgzPJNr/mGj9XWFqOKciZQl72wdRYl7J89sGNFxfTMjkBPeqY/B4GA0uqMIpoHHxrIDu3tViDAuovydCQi//whkRKaaqIn3IMMkd+8GHaKpIsR/VoCjl1Eh6H9VlEkdVZVbuQJnqA0B2T7GfGRYloCxKbtt0x4WHG99MEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+tzRGoNrATS1gBuOF2MLy1Q4Cg+do3TpEuzX5V3qKM=;
 b=hXJy2STFbhUc79/kZme5X/Sv/z4NeZ8NQl6fcIkTPfN0s+YjIniXPX3o6AcbN1mQistjquGZcC8YvL6Ek5nRKgjULbtm0FfCtYruH/Pz7hH3C05BcuY5qlr3uqjsLmhbHxRbAKe6wjOdfhoTHv44z6SijWkPWbeu5PNLgPFNMTxWyiu/ZDVUbVmtn81LpUUFJFMO2zGpn2ZYuAQ/6QYzEzIGy/EW4AbJIAefJVFd/0no7f26le5htIg8wF88rqm4w9xoH/Z22hK0y/QMZ4HRYRi8lNaMWmRTqFYWJy8iO88Qla/W9yd0jqKPveAoCU9jLXzdqJqwoIrBIE2UiSYYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+tzRGoNrATS1gBuOF2MLy1Q4Cg+do3TpEuzX5V3qKM=;
 b=QOfYLWfnDSr+KASrxdE9bk91bbrYN5nQTbmBchI7vE0WVyyJ/a/Lu+c2XMNb7CltlMqRE+txv9Dcz/bqRntQcSkoGHkqTG2bnkmpdtqwKdaH8mlnubsAGX2t8L/HQ695YzwYw159UBLoPgCXe17YWdKmatRE+/27eLMUlDimnNPl8mlEc5tVFJo5QdHnrJS3pnLErRdRDf2HmxM4MwNJXAnsgbycqseN/CtCwhX2UtVkz/tLTBXOFOq+/Krsg5H6G1K9PuXzdeTuUEu9fnKFqMeBSSdLuY0PaelYl5UbCG7zf5I7QqAowQjBblbDtEGheTy47PivthKP+Otn5t5tnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:26:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:26:15 +0000
Date: Thu, 13 Mar 2025 12:26:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <Z9MHHU2Im7Eo0ETS@lizhi-Precision-Tower-5810>
References: <b425a7c7a7d6508daf23fe7046864a498029a7ac.camel@pengutronix.de>
 <20250313160648.GA736867@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313160648.GA736867@bhelgaas>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: d03798fc-ad2e-44a8-9015-08dd624bc697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3EzdVdzbGpjd2JzZEZiSE1LczVMMU11VGZ4Mld4NmNxZFhRZGcwQzdlc2hv?=
 =?utf-8?B?MDBvQk5WNDlnUmNtSmd2RTVhazltellNZzUrZmx5UEphWm5UWmxqSEVNNW1F?=
 =?utf-8?B?QnpzU1dYN2lYVzlVazZ5emtDb0FuR1N1YU1qc1QwOXdxM1NON1Z4dVFVRkgw?=
 =?utf-8?B?ZHRVYUhEcitVYUtGbzRacmZoMkNjTVFTRmN1ZU1QUUZxaEoxN3VOQW02MDJ4?=
 =?utf-8?B?aE5IVjlSd2ZiUmhMK3VSSlJiZG1HUXJScXlCdUxYM3Z1RkExZ3dINEUvTStE?=
 =?utf-8?B?Umo1TDU0dy8xVEM0M0YzYmo0cy83OWYxblRhZHZKbFhxd2RMNFpJV015R0xE?=
 =?utf-8?B?Q0xlWXJIRHhYTGg4bDdMVkh3cWtuOHJrcU5WZHRRVWd5d01pUTV0SERmQlNm?=
 =?utf-8?B?dWMrR2hUa1lZTU1DVnIyNGRKb2pEdEZCUFdneWJSZkNDdEpUOXQvTllxbGRI?=
 =?utf-8?B?a2dURXlrTE1BbHRNMFdjNDRDeWEzRkRoWHpqQ1MxNWVRM2s0OTFYOXRiaHFN?=
 =?utf-8?B?ekhvYVNYMTB0RWhhclNHdUlzS0NNbHhmUFZsQTE1REQ5S2VnNXhCNzJmOGFT?=
 =?utf-8?B?QUdvWWU1Wkd6aHhMbmFBY0hCSE04TndOeGQrd2VVb0xKYm1XM1lkbGtNYTZw?=
 =?utf-8?B?Kzg1WkJldFpaOG9HdVFueEZoejhaSGVEQ2RpUms3Mi95L1hlbzU3S2M2T05T?=
 =?utf-8?B?d1VlNTAydEN5VGczZjJrTW81ZFZlTE9OR0taem5xOUZFeStNR2xhbVhoTHA4?=
 =?utf-8?B?cTNvWHJ5Q0x3VzVhUTRwRjdRNVMzYUpNZ2RhMmREOUVpWFhpejBWRE1lR28v?=
 =?utf-8?B?RENvSW5UdWd0UmlnT1lIRWFHZDFPQitSdjBLeHpoOGtMWGZPZjE4U2JENEFY?=
 =?utf-8?B?Qi9QNWtQKzFuQ1FodmNtQ0tMQlltTlJsYjd4cWlqU1Fub0QvTDBodisyM2RU?=
 =?utf-8?B?RGdJeFhYVUorMnlGVFltUDBJUjFmdUZMMTlnQlp5Ukh5cm5PMjQ0c0lMSG5T?=
 =?utf-8?B?S084WVAvZXdKRHRzN1hWUVplUmZ6eDlvTjVRRW5oWkhsS2I2amFCWUhTZjc0?=
 =?utf-8?B?b2lBMDVIc0VYUFZwejhDanRKbHl6alpxb3RXS2lJUWgzbUNteVY2WXRrRXF2?=
 =?utf-8?B?bkREYXFjUUNMeDl2MUV1b2N2dW1IdWVGN0tMV0RPd3JGZTFHQnpMSXJzMFhM?=
 =?utf-8?B?MlFYRUdRalZiQWZzVnF2a0pDR3djUFhXNFVDTHZVdUFLZ0t3WjhEd3B4ajNt?=
 =?utf-8?B?VnNPWXhYcFUzVnowZ3BmWFRPNDFuWVJtRnRFRXNwaGpQcithZWUvVjR2L2N6?=
 =?utf-8?B?d0dJaUFod1FDY29jQlUyeHF0SnZtWVVkWXg0WitYcis3cGphYkY3VjU0aHly?=
 =?utf-8?B?cWk4TWNDM0E2YzBMRDJWRmd2SmZJUW5DSjlzRGxFM2NFNC92VlJ2bEd2VkZk?=
 =?utf-8?B?N3BMV3M5Wm13S3BHR3VKK2Y1cEEyMzl0bk5JNGZKU1NMUGRVNjFZMVRLV2Jm?=
 =?utf-8?B?VldhNE9Ldlh6dm11SzZYNlhhS3krODZPR0pBWTZ4L1h5c1dNNE8wR21OakNs?=
 =?utf-8?B?OFF4SjhjY1BWTjMrVWQwUVVBa2FDQm44NkdJbWxrQ3JqM2JtVlZIdjFPM3Jh?=
 =?utf-8?B?RHNEdm1NL202RGNKQnZnd3BKVWVacWpLditydFdBWG5PUlErQXg5WFk0dFVQ?=
 =?utf-8?B?bXJjU3ExREJpR2htc2c2VkFDOXJ2ZmVrb1Y5ZGlGaFIxRi9JZHdrTVVScXBC?=
 =?utf-8?B?VXhPUW5Bd01JY0c2TzN4TkJrNm93cGdQK1I2ZVlBOGs1OUwrbVR2dFhMcGVu?=
 =?utf-8?B?NCsvMmp4UE9JSFhLa1E5SFk4SHMwWjE2UU9LTlQyWGhWSG9iWCtLUHFZOEFt?=
 =?utf-8?B?L29xS043eWRWdEluVzB0UDl0cVlXVU5jZWY5QjB0MXBlUHBuYzJPNFI4Vitv?=
 =?utf-8?Q?4N9526nqAWO5sOuWVQ4C6r7ySXdyz6Ps?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUg0VGgzRG10Y2dNb09sQ3pHM3dUOHp3ckozU1MvTDY4VURDZHg1OEFFeVZk?=
 =?utf-8?B?eDhCUHpWZHIxZHlRN0ZNTEd1ZjRFWUovSU1mVTNCMTdEVUpXaTdPUGhCWWhC?=
 =?utf-8?B?bC91b0V4eVpPMkdDblRrQU42V2RaWU1CWDArNHdmUm5iTlNrKzVCUmJ0SjAx?=
 =?utf-8?B?U2hmQjNmNDVyc3QvL0paY0gzUmcyOS85UHM1YVhSZGpJYVdlWmQ4Q1plTGFj?=
 =?utf-8?B?Y25iU0VxanpXTGtJUm52cTRRS2VteFcvQk1OODJGbmFrVmFDYUxmUlB1ejZt?=
 =?utf-8?B?QTV0RHJQTnNWc2Y3elVHTEw4T3dNVTVqYVI5QzY2SWU1Ym45c0dKbHNYZEQv?=
 =?utf-8?B?ckxLY3NMRnNyTnFyZlNraHRJZnB5VUZHRkNoYVcxeDZCVHNNeklKY2FWbnNy?=
 =?utf-8?B?UVovbnVrMGVGNmRrOHdFcXBMY2tXT2FTaTFuYm5LaVB0VWthZnc2L1V3OWdz?=
 =?utf-8?B?QkZweVRjVEdGcmhvcXAxRjAvZlh1VUpoSkJlcWt4TE1OUjY4a29CNTY5MTJ1?=
 =?utf-8?B?VnpXZHFNVzNVM0huaXVScFNIeFVmcGRyNUN2dkZjNFNjTnBhOFUzVlMzdE4w?=
 =?utf-8?B?Y1F5U3dkdWIxYmlUR0pzWjliNkVlUFVESGRHQnQ3UUdUc2dMVCtZRnNtcVVB?=
 =?utf-8?B?dTJWY1U2dGM2Y3gzb0J0WnBHS0ZzT2lrNHRsSlFqUU1ENzVXT3BHYnIyS2VE?=
 =?utf-8?B?K2M4OHVxNGt4WlF2V3NJdkpKTEQ4aTFSNTZ4L2ZKN2Nua0hXZE5VZi9aZWRB?=
 =?utf-8?B?VHdMMlNDVDU2TE5QU2ZzaHpySndjZk9FeG9TZndFQzdKbjE3Ym00dUs3aTQ1?=
 =?utf-8?B?ZUs1YnBjUmhYcXU1ZCtickhwall0YW5QSVR1czIwV3pIYTFuMVREMGROaWRq?=
 =?utf-8?B?cEI0MC8rOTdrR1BWQWpFNGg4blFCMFI5MWRJbk1LUTR5T2NCQ2RZK3htT21M?=
 =?utf-8?B?dXBGdjdzZ0VqY1JEbEhHcVdnV2VDNGhWRlVzejBHc2ptTTRYUWxqRUREdVNj?=
 =?utf-8?B?dmVYL2FjTFl1RTgySjg1amFmWmVudVpOYnFHakxPNWo2RGVDUE00Y2RnamZO?=
 =?utf-8?B?STNvaVk5Q0FaV1kwWkd1bjJ5ZFUwRFMxRnVPV0hHbE90YWJnQTJwUlNGMm9F?=
 =?utf-8?B?S3p2N2V1VEJVdGlHNVFvNjJLMFRqOVpnaUREYTlaQXFHa2ljeUZMSjBXSms1?=
 =?utf-8?B?Y1ZlOXFxbFFSYW1BL2FrV2d3cm5iM2QrVDdyYytreDhmWkpWM3BCdU1lckpT?=
 =?utf-8?B?Z2wxcUU3ODBocjFGZmdUVW9PL1hmOFREY09QU3ZiWWNnU2ZPVU9FWjhzR2dF?=
 =?utf-8?B?YjEwK0Y2TlVxZVlDdDRJREgxaFVwNFhMUW4vVnNLZTN1K0xBc1JnS0pZWVJS?=
 =?utf-8?B?d2tiRnNBY01GbkF6eWJvakdqZDluTm1GRzIzRUMwQzhCekxZbkJxT0w4N0Nj?=
 =?utf-8?B?a0FEWlRtdkFsTkJabm14VFYwRFp0OCtBdkJyWEVpYlR6eWw1Q1ZvSTNtR24w?=
 =?utf-8?B?SndjMDZnSnlsYTJkbW12bWhrSE1icUFyV1E3OTJaRWxHcFZpUHFVSDJ0Szkw?=
 =?utf-8?B?VkZyRzh6bVBHRG1YTis4UTRFMFVST0l6OWY0bnZYN0NlZ0xQUzZpQ2lhcGNL?=
 =?utf-8?B?VzJFeXhha3FZUVV6WmdsTkh4T1pyWHdaemF6a0Y4YVkzNGhWTjgxdUJyODFa?=
 =?utf-8?B?OUQ2U3VTK1A1VVl4WnYwUSsyWVZpZXdEVWd1Ujc4SFF5RFphL3kxbnI5cVJz?=
 =?utf-8?B?SFN6d29GNDVPSnJZVWpYWmE0STkvRUY3aUlEb1NNbW4vZ0NmVG1YUEFuUUlW?=
 =?utf-8?B?V1A1VCtPN1E4Ym9YQnlRcTJkanBVeEhqSVNaOURLN3ROcmQ1dFBBL2x5a3Zr?=
 =?utf-8?B?OVJWUEJhNHlOWDBsRXNDK2ZqMk5ja2dFMHVRQjAwamF6eUFhNmYwMG1KUlN1?=
 =?utf-8?B?RXI3RFNBQWpISjYyY2pVemVmbXdpN1VWRDVOTkUrczArUHRLa3IrRDlEa0l1?=
 =?utf-8?B?RVRvN2NvbXB0Z1RQaGRGQzdJTnlGMHhNTjAxMEF3eG5uUDBad1ZHZTlDQ0l6?=
 =?utf-8?B?UVFHQTFmT09JY2kzS0xka3ZXZTZOZnJDbGJ3UVJSeFA2RWdTYzhWbmFsK2Jl?=
 =?utf-8?Q?Ywg4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03798fc-ad2e-44a8-9015-08dd624bc697
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:26:15.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jjko2V0UlObAySfrCQUizhJA/TJLfDt0CDM1vdFvk8tRtcO8OIV16Tig6Vi/9FDwmoPGjoEMKIWVtc9L+ojBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8274

On Thu, Mar 13, 2025 at 11:06:48AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 09:54:25AM +0100, Lucas Stach wrote:
> > Am Mittwoch, dem 12.03.2025 um 10:22 -0400 schrieb Frank Li:
> > > On Wed, Mar 12, 2025 at 09:28:02AM +0100, Lucas Stach wrote:
> > > > Am Mittwoch, dem 12.03.2025 um 04:05 +0000 schrieb Hongxing Zhu:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: 2025年3月11日 23:55
> > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > > kw@linux.com; manivannan.sadhasivam@linaro.org; bhelgaas@google.com;
> > > > > > s.hauer@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > > > > > linux-pci@vger.kernel.org; imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > > hardcodes
> > > > > >
> > > > > > On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > > Sent: 2025年3月10日 23:11
> > > > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > > > > kw@linux.com; manivannan.sadhasivam@linaro.org;
> > > > > > bhelgaas@google.com;
> > > > > > > > s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > > > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > > > > > > imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > > > > hardcodes
> > > > > > > >
> > > > > > > > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > > > > > > > Use the domain number replace the hardcodes to uniquely identify
> > > > > > > > > different controller on i.MX8MQ platforms. No function changes.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> > > > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > index 90ace941090f..ab9ebb783593 100644
> > > > > > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > > @@ -41,7 +41,6 @@
> > > > > > > > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > > > > > > > >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > > > > > > > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11,
> > > > > > 8)
> > > > > > > > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > > > > > > > >
> > > > > > > > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > > > > > > > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > > > > > > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct
> > > > > > > > > platform_device
> > > > > > > > *pdev)
> > > > > > > > >  	struct dw_pcie *pci;
> > > > > > > > >  	struct imx_pcie *imx_pcie;
> > > > > > > > >  	struct device_node *np;
> > > > > > > > > -	struct resource *dbi_base;
> > > > > > > > >  	struct device_node *node = dev->of_node;
> > > > > > > > >  	int i, ret, req_cnt;
> > > > > > > > >  	u16 val;
> > > > > > > > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > > > > > > > platform_device *pdev)
> > > > > > > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > > > > > > >  	}
> > > > > > > > >
> > > > > > > > > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev,
> > > > > > 0,
> > > > > > > > &dbi_base);
> > > > > > > > > -	if (IS_ERR(pci->dbi_base))
> > > > > > > > > -		return PTR_ERR(pci->dbi_base);
> > > > > > > >
> > > > > > > > This makes me wonder.
> > > > > > > >
> > > > > > > > IIUC this means that previously we set controller_id to
> > > > > > > > 1 if the first item in devicetree "reg" was 0x33c00000,
> > > > > > > > and now we will set controller_id to 1 if the devicetree
> > > > > > > > "linux,pci-domain" property is 1.  This is good, but I
> > > > > > > > think this new dependency on the correct
> > > > > > > > "linux,pci-domain" in devicetree should be mentioned in
> > > > > > > > the commit log.
> > > > > > > >
> > > > > > > > My bigger worry is that we no longer set pci->dbi_base
> > > > > > > > at all.  I see that the only use of pci->dbi_base in
> > > > > > > > pci-imx6.c was to determine the controller_id, but this
> > > > > > > > is a DWC-based driver, and the DWC core certainly uses
> > > > > > > > pci->dbi_base.  Are we sure that none of those DWC core
> > > > > > > > paths are important to pci-imx6.c?
> > > > > > >
> > > > > > > Thanks for your concerns.  Don't worry about the
> > > > > > > assignment of pci->dbi_base.  If pci-imx6.c driver doesn't
> > > > > > > set it. DWC core driver would set it when
> > > > > > >  dw_pcie_get_resources() is invoked.
> > > > > >
> > > > > > Great, thanks!  Maybe we can amend the commit log to mention
> > > > > > that and the new "linux,pci-domain" dependency.
> > > > >
> > > > > How about the following updates of the commit log?
> > > > >
> > > > > Use the domain number replace the hardcodes to uniquely
> > > > > identify different controller on i.MX8MQ platforms. No
> > > > > function changes.  Please make sure the " linux,pci-domain" is
> > > > > set for i.MX8MQ correctly, since  the controller id is relied
> > > > > on it totally.
> > > > >
> > > > This breaks running a new kernel on an old DT without the
> > > > linux,pci-domain property, which I'm absolutely no fan of. We
> > > > tried really hard to keep this way around working in the i.MX
> > > > world.
> > >
> > > 8MQ already add linux,pci-domain since Jan, 2021
> > >
> > > commit c0b70f05c87f3b09b391027c6f056d0facf331ef
> > > Author: Peng Fan <peng.fan@nxp.com>
> > > Date:   Fri Jan 15 11:26:57 2021 +0800
> > >
> > > Only missed is pcie-ep side, which have not been used at all boards dts
> > > file in upstream.
> >
> > I wasn't aware of this. 2021 is quite a while ago, so I suspect that
> > nobody is going to run a new kernel with a DT this old. I retract my
> > objection.
>
> Sounds good, thanks, Lucas.  We really do want to avoid breaking old
> DTs, so I appreciate your highlighting of it.  Even if we believe none
> of them will break, I think it's worth mentioning the
> 'linux,pci-domain' dependency and the commit that added it to the
> .dtsi in the commit log.

Yes, I think you can add it? some thing like

"linux,pci-domain" must match the PCIe controller instance sequence for the
i.MX8MQ platform.

Frank

>
> Bjorn

