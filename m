Return-Path: <linux-pci+bounces-35675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B8B4932D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ABD188A036
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A430CD80;
	Mon,  8 Sep 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SVMHBLEN"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8B25634;
	Mon,  8 Sep 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345189; cv=fail; b=FD32WqZYz5zJJ/lHu3zBfRsVkaNB71MRkblZ0B9jb7CwNBQ8ZkFmwXVMvcg8DCe+394c5s7Fe+N0LfWXIjkfhfO76t483so2xUdG6LpeXYWRa0CWuZMJQcfIGp7zKIeNWn4bW87bXjZpomsHN5xEg0hK78QQWaYiRCtGx0wxky0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345189; c=relaxed/simple;
	bh=tTxx1T5sKoYzjZoMGTLc4ZL9H+dvxzn9efRE2smzJgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRuoTUgE4+eIlIZxRe3mCKIcnoM2zAsyXRFtwzv+nrceXzU9mjlWUWRE+rjzDV+wweZBVu6pjShEZ6SfIkcf2mFCXCxFBLqRjejkuvfles1rEGXVZXwfgWFf+sunUsCZPUNjkj/DrRzP3x9jUl2XF9opfdkeMO4AgfzjCZz3Ccc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SVMHBLEN; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIp2uHGINijMD7uvG16YeYoLHOHt6Wb1CWQ39+59Fqkzv+flHzbqxFAT0ZcQmBhihPjbr3Z1ffLxqp3LVdAqBtrppi0RvNlNTNfUHHGcOYSX5ndhOSUJ/izacCMd+o52TZUT9M7yhu2l1yJDZPOD6tUEhg/Q/nAhMnvj9vW+1qJnkpQS3XgQLZYFaz1kqEtbzn2o8kwo267eIkEsOxVYuCz6FVhBOPjYNBHpiGKf4fbcvguiwQA20iQi2mMy2Bx4d2n744U4qztJHE0X1Lddgcp61zGvfvBsDeqzhDNLusZaWP0Pg3IyclQjV7WzPJfl0p7i7z+txG2p6/ACAyrMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li1Adrjj4VVnlXoSqhzmWGYfj7zooVeMiJ3AjTpsi/A=;
 b=UHZ0SCaWIDKaTMbjmrNqZnjxC9rjrBnyYX91C12jLgidOxBTS2821th2vp7w3B9xPLKp3TGoO73dbiluUHNoRTyrEBZ9qVYRPPruwaUKLKAy6YYqf8GtgqTvz2500CxdNVlFMFV20nOtjDZwCW2WE+0SD0B7zEs29kFb2wCAJNy9+6uVpFGXaUxAAsyRplLMwOylJ67gdcFSFXaD7FnwNaXzIfreAfKiS5i5yuNrgmZL6zV1yqQt+L5OF8q8Yvt5bg6lfaUnSXD5O2/iQINjJT6q110zrZo+iSv4keisBzAorskk4jK+GFwyI6JWIOFqBRo8OKKPSCkY1a2mUSVZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li1Adrjj4VVnlXoSqhzmWGYfj7zooVeMiJ3AjTpsi/A=;
 b=SVMHBLENKsh7L8X+CXrem29B22jaxhW7SRc2wFY1znN3oDtHejJLXzPKGgICPQojFF57XF7JogCzZiBM9vBMyMpD9JZK+Avhvt0YN92YR9zdgv3DjXFSJiYnYMOVf/b/7p4odopOCXvq9Z3QhKdvJjIkP4GC+M+ScnES5QMHuwpF7ZWk60x6OM/uhsmNOa83kdlih9lFJFHSfD8U+GWeDfRbAgOwJ46aW6UgKQ9wV8pRCZNpwx6q9YjSGNAZpzztp4g0XOKGTkItxhrMr8cdOp7DEIWI185IBWr63/15NIvDpk6ExkURnDH2vFvkdwH91TiGkPl3nhTDwIASx69F+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VE1PR04MB7214.eurprd04.prod.outlook.com (2603:10a6:800:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:26:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 15:26:19 +0000
Date: Mon, 8 Sep 2025 11:26:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <aL71k+CeZEwTnn86@lizhi-Precision-Tower-5810>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-3-hongxing.zhu@nxp.com>
 <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
X-ClientProxiedBy: PH7PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:510:325::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VE1PR04MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: b0442a1a-dc41-4746-9883-08ddeeec0f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEp2MVY2b2RPdlpremF6MkhlckowRWV1UlUrUUhJRUlsdUt3RWxnTTFjM3Rq?=
 =?utf-8?B?c0lROVA2TFJ0NDM2TmlERzNnOWFJbWx5UFE2T094L3NzSWFndVNGTkpENGxh?=
 =?utf-8?B?SGsvWmdRcVRocmlJamhvK3JnY20rOG1WSlZxa3V1S2FiOW5xNWxlbUlDZzBo?=
 =?utf-8?B?QXRjR3Yrd21VQ3RaNldXdm5hUmxBSEdJWWdqZVhxSFlpNjQxZGNvdUE3L1Yw?=
 =?utf-8?B?ZzBFL0djaURPcGJCYlJrL1k3OUxhQ3JDUk83djJOK3dacHBBTFR2ZW91b000?=
 =?utf-8?B?OWdmWGtSQ1Fzc1ZwdllzeTlNZGJlQkFoUWJIK01FSEprR3lWenJ3OHpSSXdY?=
 =?utf-8?B?VU54NWtWUnNXT0pWQ0xkZTl1aVBWTDFOcTFjb2l0NTFzMHFtd1VJZ3U5ME5U?=
 =?utf-8?B?TDY1WlVQWjk5MVNaWVRCaFNoTEYxdW03YlpKUktKSlQ5ZVZOVmRVMTFWbHpV?=
 =?utf-8?B?TjMvdlBPYmMyaWJsZWE4MTFkcGJYbVA5R1IvWGVNZmtBai9naWhQQXU0d0U0?=
 =?utf-8?B?ZXRrUjl1NWlHKzJSbTRkeXJTNjNZSlJyNjZxeHdwLzBjT0hBdGUrdjF6UGJK?=
 =?utf-8?B?MnhJRTVJSm4zenFab054bGdWQm5vYkhueEN3dUs5bTNkUCs4b1lmSXdybk1X?=
 =?utf-8?B?Ujg4M0ZWTlhYY0NzOVdSYkZiRmpyV01rL0cwZ0xxdnFnNnZGTXhtYXJ2bG9E?=
 =?utf-8?B?c0FnYzJVb3lIZW5EZWo0NDUwOXRzcFRzZlU2YVNyNlBndWd4TWFXTlVrSXVJ?=
 =?utf-8?B?YmdRMXhSZTlmT0lWeXpqbFVhNGhieVU4dzlwSnlDK2ZpRFovR3RuT081QnNo?=
 =?utf-8?B?N3MwbCszT2xRc3JsVnVNOG5KbWoyQ1RTRjg2NXhJQm9DL2tEcUdQZkU1dEhX?=
 =?utf-8?B?bmt0anlhTmh3SmdQSEhRRkMyeVdNa3QxYVRZa3A5YVRHd3hTZ1ZGWEdQWDFJ?=
 =?utf-8?B?OEljS3BTdUx0NXFuMS91aU5lbFpqYXg0U3NVUHU3UXhWeXo1YzFMelF3cXU2?=
 =?utf-8?B?SEJ2Y0w3QWd2T1FnYlh1bFhlODU4N3EySlYxdU9wc24vUzYvQ1YzbHp3K2dU?=
 =?utf-8?B?WXBzWlNCL3FiNTZIZTJvNXQzYWhEd2pBRXhLanhsOENOVGdiTGFqaWJVK0F0?=
 =?utf-8?B?YjA1c3l5TzUwejNVbC9FMTA5a1dydWRWYVdkSC9OanBVbTljSkxqLythcmlB?=
 =?utf-8?B?czRKeHFNMWRraTlabXQzd2xHZjFETTZqTUZ3SHBoR1c5cWc5SzZweTNyaGdO?=
 =?utf-8?B?UmpYZG00YnVkK2t6aUprZ3ZaVys4ZW5RL2tTUDQycE05M21HbEdDMzVzQjNR?=
 =?utf-8?B?VlBpQld5TStiM0RjOWM0aWJDL3prbFVPR1JhOUdpL2VRWThoclorcjFwS0tp?=
 =?utf-8?B?SHVXeW9XRUVzeVd1U3NrNEJUSld4VENGaHNrQjRNZFE5cjZzQXhCd0FsWFYz?=
 =?utf-8?B?VHRseTVEUy9pbUtCSnBZWXk4Zk1tSlRjZU5vNmNVZTk5K3ZvQ0hxOXZNOW5G?=
 =?utf-8?B?NlJFRlhIdS9Lamw3cFBTejU4OHhwdXc3M3dnVmY0amRLL3VlRDdKK3pnbFZy?=
 =?utf-8?B?Q0NXdVVoZ3VwcDdKZFVqT1FOQkpaVG0zdlNFTURDcWYwMTQ0SHh3Y0VXV1h4?=
 =?utf-8?B?UXpUQlVlTTJUbjNQQkR6b1FtWnZXbnFrSnJMQW5JaG1HakpDb2lpWFZSTmlB?=
 =?utf-8?B?MFdKRjhLcHVEMDVpY21kNXpqR1lFVzh2UzErWDJ0RXRoaFhUbndJKzJucUVs?=
 =?utf-8?B?Z0Z2Z2J4RjdLQXVvRlNhWFJlNHZSc1lZWXZ6YW9vM0l2RXJ3ZmY2NFl0Umls?=
 =?utf-8?B?MDJ3SitmK05Oa1VHWi9lUjFMaVUyOWEvUEVpRU5USEQ2L242R1o5c0swSzBK?=
 =?utf-8?B?VzN6bWtKL1Q3WFlndkg0MXdSdEtqaXIxQ0ViZ1ZPbVUyME5nNDRpWERFeGFy?=
 =?utf-8?B?SHMxRFNNVXpFSkIwMkdFRUUrR0llV2FhcnlXdDB5eW96VStibCtUMlI0SHZP?=
 =?utf-8?B?dmpoZm1UemZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDNsRTlrRVZ1VTI4SWFyWlBvQTVNTEJ1ZUYvVk1tU1JOcVdZMUxjRzRkSUtl?=
 =?utf-8?B?MytFVlBUV2tpc3E4U0NGRTlxTGFPa2dCZ2R6N1c3bVBQTUQ5eXhqOG1Kdmhu?=
 =?utf-8?B?TzZCV0ZEWm1Fdnk4cDVERDRGaXF0S1IvRE5IUC9mTkdEbUNNN0w1WmNKdzBZ?=
 =?utf-8?B?TDRqdGxJdlM2UFBmUVRhY0VxMUMrVGx0Um9UUG1IdDA0V1VqTkhUL2g5R1Zu?=
 =?utf-8?B?NlNWN21OZCtiV0ZZb3NZcE5nTlJxQ3dMT3ViNDdDYUJtNmFrUkt0T1FGRzV0?=
 =?utf-8?B?YTlXTThkd3VzSGVYVW1XZUo0MisybDhUK1BDSFFhZ3JKc1IwZWlTbFg4RjBn?=
 =?utf-8?B?V24xZVlZbThBcnVsTmloTGRPd2pna29LVXZuUWtOUG5zSzFqM2dnVmtVOVBR?=
 =?utf-8?B?dGxXdWw1dVpJZkQwNkVkTWNvZUovVWpqcG9UTlg1UTlFRDlsZGVCQVZwZzUx?=
 =?utf-8?B?OTF3dHNIcUdtcHpubmpZSzJUcGdmRERFdHJKQVMrZzlpYVFmNmpsOHl5RVV2?=
 =?utf-8?B?WVNNc3g5NFhGbnI5T3htTUdMYk9VcWpOQm5OYTc1YXlnaEFEWHdSM3BCL0tO?=
 =?utf-8?B?bFhQRmZ6YVB6Z1dqL3RUc1VyTTdhZTdMYWJQM1YxK0g0SCt1cmIyQXVrb1Nz?=
 =?utf-8?B?eUgvT3JsR3dka2NqVDlFMWVaWWNMcnlBZk9QTVo3MlFMbmpGWmw5cVVhN2Vk?=
 =?utf-8?B?L3Q2aWVnODByNWZkSVlsdmVPNWxIQXk2U2dsclN5TkM4ZmJNbGo2S2FkV2hu?=
 =?utf-8?B?V28wS2R4NFE3a2VzZzI1dTdzai9NdlhMN0JFUGlncmZ0V1RqZmxxeldlaUpG?=
 =?utf-8?B?WWVkZUJLaXIvc2lZN281M01KbkRRcXlSRUZHSEVZVFNpcUpqa0ZsS0JMTFZm?=
 =?utf-8?B?ZTZwZmZsWFY5b2JwT0R6R3QyTVpWaGlyczYycjRXNXUzVFhiK21BR2JoM0s4?=
 =?utf-8?B?UFFZME9lYWJKTW01Z3ZPR3VnQ2d4a2lQYlFBd0lOUFJXTEtCVis2OC9Cbitr?=
 =?utf-8?B?WTJ5RGhzTCs5MkZRRDBKWlkzRUpqbVNqTGUxNG1ZOVhxd3Rqem5LdDZGdXJW?=
 =?utf-8?B?SExqRVdSNllHNUFmc2V6Z2tieW5NS2xydWI1djIyZFNuV1dSSTZXQWRqNWlw?=
 =?utf-8?B?MXJ5b3MvM1BLOW03VXRqMjJRTzJxRkF3TGdvNDBZUC9YenhTRTdUSytkOVZV?=
 =?utf-8?B?RnZmMk1rQXNpeGgxK1hqNzc0Q0ZRckg3d1JnTFE1ZGFGYnBsK0tqUDJvM3BV?=
 =?utf-8?B?c0tsWUZLdTBQblBaZTAvdE1CQkxEM3h1Sk9hNFVvdG1WZHBER1ArcUMvMzl5?=
 =?utf-8?B?VEJYOEd4ZzBpTmhjdEJCNWZhcWdUcGc0aUh0QndzbzNrM2dXbkk0eDdmVFpn?=
 =?utf-8?B?S3V2cnZzVlVPaXpmR1NBTUlDTWF0N0lJMCtRTktieDF3Sk8zajkwUkZId21s?=
 =?utf-8?B?MkFmMnF6Yy9JNlZIMjgxbWVFMHdnbGxRQURhOTRqNWVBSnprQUt4TFVwbjFm?=
 =?utf-8?B?c0JBN2VNZDU4SG1abGs2N0V3d0JScWFLTDRWbUJVK0NvaUxZMmRlN2FhbGlr?=
 =?utf-8?B?WHpmMnRDWHAyYkpEdytIdFpQaFdudTlVR2JpaFQzckhIZkFrSFRhNkpLbUI4?=
 =?utf-8?B?Z3BST0NiUVlrNXEvS1dRNGZhSHArVXZreHFrVWtsNVl1cFJlY1RSM0V3Z3BY?=
 =?utf-8?B?R0xlV2lyZ1ZsckI4bmZ0U2RMUENCSDJBY3hScUpPSTlBL0JZbG9OUW8yd3Rj?=
 =?utf-8?B?M0JFZWpIRDh5Z21YMTI1LzErMHlmR3hvdDJ4eit2TEsrYkMyYVJ6N25oeFlW?=
 =?utf-8?B?TlFibmcxd0pQbnpvblBMRU5kR2lLWms3QmM0d1I4QTMrYlR1OGtIOVMzTFB0?=
 =?utf-8?B?ZDNOYVArUXg5dDdHRzA0ZTZDQzVCS29kQk5CTzNNR3VaWno4WHNZQTJFS1pE?=
 =?utf-8?B?NFVPUHBnQ05OajRDYmQ1emhTMnlzcm9XRkx5ZGR1Sk1QZUllNDRTdU1iYVlU?=
 =?utf-8?B?NmtGSk03UlBsZC90NXlKWmJjeTdaUlFTQ1JGRFAyU0pwOTVzaDVzNWUrVmxQ?=
 =?utf-8?B?d1A1cnN4SUNrVzFacWtmRVFaaVFQNUVSL0JLdHhkM3A0TjRPVzhZTjFSZ2lS?=
 =?utf-8?Q?zYNvR/gG9LFs+RnDEmvGzS5oS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0442a1a-dc41-4746-9883-08ddeeec0f4e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:26:19.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEf3QRevjHl6QJ/HP0bxxTN3DDmqZtJTph5ma0oykqROwyTQ8tTi4MicjSiGEDlaGw8Jqe2MKQCGSBJkSFZV4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7214

On Mon, Sep 08, 2025 at 11:36:02AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 20, 2025 at 04:10:48PM GMT, Richard Zhu wrote:
> > The CLKREQ# is an open drain, active low signal that is driven low by
> > the card to request reference clock.
> >
> > Since the reference clock may be required by i.MX PCIe host too.
>
> Add some info on why the refclk is needed by the host.
>
> > To make
> > sure this clock is available even when the CLKREQ# isn't driven low by
> > the card(e.x no card connected), force CLKREQ# override active low for
> > i.MX PCIe host during initialization.
> >
>
> CLKREQ# override is not a spec defined feature. So you need to explain what it
> does first.
>
> > The CLKREQ# override can be cleared safely when supports-clkreq is
> > present and PCIe link is up later. Because the CLKREQ# would be driven
> > low by the card in this case.
> >
>
> Why do you need to depend on 'supports-clkreq' property? Don't you already know
> if your platform supports CLKREQ# or not? None of the upstream DTS has the
> 'supports-clkreq' property set and the NXP binding also doesn't enable this
> property.

It is history reason. Supposed all the boards which supports L1SS need set
'supports-clkreq' in dts. L1SS require board design use open drain connect
RC's clk-req and EP's clk-req together, which come from one ECN of PCI
spec.

But most M.2 slot now, which support L1SS, so most platform default enable
L1SS or default 'supports-clkreq' on.

Ideally, 'supports-clkreq' should use revert logic like 'clk-req-broken'.
but 'supports-clkreq' already come into stardard PCIe binding now.

One of i.MX95 boards use standard PCIe slot, PIN 12
12	CLKREQ#	Ground	Clock Request Signal[26]
which is reserved at old PCIe standard, so some old PCIe card float this
pin.

So I think most dts in kernel tree should add 'supports-clkreq' property
if they use M.2 and connect CLK_REQ# as below [1]
============================================
              VCC
              ---
               |
               R (10K)
               |
CLK_REQ# (RC)------ CLK_REQ#(EP)

NOT add supports-clkreq if connect as below [2]
==========================================

CLK_REQ# (RC)  ---> |---------|
                    | OR GATE | ---> control ref clock
CLK_REQ#(EP)   ---> |-------- |


>
> So I'm wondering how you are suddenly using this property. The property implies
> that when not set to true, CLKREQ# is not supported by the platform. So when the
> driver starts using this property, all the old DTS based platforms are not going
> to release CLKREQ# from driving low, so L1SS will not be entered for them. Do
> you really want it to happen?

Actually, some old board use [2]. we will add supports-clkreq if board
design use [1], so correct reflect board design.

Frank
>
> - Mani
>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 80e48746bbaf6..a73632b47e2d3 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -52,6 +52,8 @@
> >  #define IMX95_PCIE_REF_CLKEN			BIT(23)
> >  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> >  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> > +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> > +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
> >  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
> >
> >  #define IMX95_PE0_GEN_CTRL_1			0x1050
> > @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
> >  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> >  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> >  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> > +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
> >  	const struct dw_pcie_host_ops *ops;
> >  };
> >
> > @@ -149,6 +152,7 @@ struct imx_pcie {
> >  	struct gpio_desc	*reset_gpiod;
> >  	struct clk_bulk_data	*clks;
> >  	int			num_clks;
> > +	bool			supports_clkreq;
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > @@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  			   IMX95_PCIE_REF_CLKEN,
> >  			   IMX95_PCIE_REF_CLKEN);
> >
> > +	/* Force CLKREQ# low by override */
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > +			   IMX95_PCIE_SS_RW_REG_1,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
> >  	return 0;
> >  }
> >
> > @@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> >
> > +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > +{
> > +	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
> > +}
> > +
> > +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> > +}
> > +
> >  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> >  		dw_pcie_dbi_ro_wr_dis(pci);
> >  	}
> > +
> > +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> > +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> > +		if (imx_pcie->drvdata->clr_clkreq_override)
> > +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> > +	}
> >  }
> >
> >  /*
> > @@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	pci->max_link_speed = 1;
> >  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
> >
> > +	imx_pcie->supports_clkreq =
> > +		of_property_read_bool(node, "supports-clkreq");
> >  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> >  	if (IS_ERR(imx_pcie->vpcie)) {
> >  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> > @@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> >  		.init_phy = imx8mq_pcie_init_phy,
> >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > @@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > @@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8Q] = {
> >  		.variant = IMX8Q,
> > @@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.core_reset = imx95_pcie_core_reset,
> >  		.init_phy = imx95_pcie_init_phy,
> >  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> > +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> > --
> > 2.37.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

