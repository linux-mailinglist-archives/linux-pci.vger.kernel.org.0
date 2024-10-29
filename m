Return-Path: <linux-pci+bounces-15544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30BF9B4F77
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729F828527A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F61D7E33;
	Tue, 29 Oct 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hH567bhz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD251D356C;
	Tue, 29 Oct 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219819; cv=fail; b=Muhmk/qIZMJRyg+bSrASg23sIvygXhyYZN5arfUStcdfvItIN8Bua0srJXZeBUDwfscVLNn+ayhnP/W4hV+dLab+Qlx2Npqwy4qoOZnHxv5h1rqmqm/CbRvWsAVq7cX3ra01HyiuTH84PQhaeg27/RpCXojqtFjBROuyvpDCmCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219819; c=relaxed/simple;
	bh=NXPlQLd0GR2adwrv2G7c7lY2KTqdBSor+PQ9mBUtQ80=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kWaTja9Pv2UJFfUg9A8yWWs2hFKx/J14oPc2ghFESCBdXm2p/0Sa14UBHCKiN6yz+Ef/kYwm4WjciMuvUvxpKYzUFby4eR86BA5c6xCe+VTUToXDuhYXgfYeYaZZQXrAeaugVmeyOcgwIYi2zaiIeIfP/YGhY1qFsrkirvtMjK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hH567bhz; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmdVwjo3zi67xX32jAJf74p/P6OQJO4/fIfkj9/5oH+6s7/wA8B2VT+G+4oddXHau3YVxKblPpK3mR1KdI6HpjrIRfgxJZuNqR4a67FoGM4XrDkD+3geZVsWt7y2qGJAzenE4LfZSlgxQwoBJ2IieYt8h9RZIPC52Tti9yhk2WcKbDBRuPzWO+K6s/Q2TCfaMhoE+M8SLmHCfPgZvy4nYvnlHqQVJPeLRb83I/+4TnP4yL9jXeln7XMOFQMN6LdDMH3SMclsZj7ZvsXPrpMQR6f2EOoeIh6ooggbfFxWeM8pcTiLKje8GQWR8FdG2GRqQHlevQAQ1qcYhYbLR7NiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud83vvAahmvbVVwLXJh+XRg0BtdbsLLBcRBvfAPBPxg=;
 b=JhtKn4SjY7qcaBJSh90k2axFthZ0rw41vz1bgfZNDj0PR0rtFFAfFfm82aV9ivyyNKlenYC45N/UFpkyM9yJyKR1kKOkAjRLk78zQcJAMZ5cuaUaJ8SGZSP3XrgbVfP0Z7lQfXE+M/lo98bDorpbUcDaqcVQXtjO957DZ25Ddx6lPEP1owv74FUV5VKbvgMHvvoVqkbsskC2WWO4EWKrGCsHOCdz2yQeHr1P7mvKrgSgy1H4q6pHB1WYn+MbNpRP1tJOKhXOyXSuwy4Mlcnypqaw8hkLyv4AFGBBF38AGTOsSwztE4O2AN1Af1cK66wppT5S5/Wlb7FFROzYj38/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud83vvAahmvbVVwLXJh+XRg0BtdbsLLBcRBvfAPBPxg=;
 b=hH567bhze7RcsZIt/dSSdLPe3536P1FolOVz0Z3tPRsUB9Peg1Kyc9XZoLDSriNKnJ8mEDx0HUEExtoGXwatifVohb5jk8v1Si/SnjbT/E+HbD1tZeQWNpalwuuXHxnbgPEqhF5lACkmk9OgIb2wznPjkBOJJabdIkmjdcuQMlSvahM6eJ0/jSkLc7OqL3S6WWLbByKh+AjxzEsolahRBueyRIPPDoKBTMfJWkY8MTir6vsyfmfndDPBrI8KYKG/ZcaSlCiFNU1G7mDcWWwGTqC1Qq91GyR8rrdZyY25rvYRDFBsYWP10PqVOoHM44N6LVkhVwsiRHApORaJviDY4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:36:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:36:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:34 -0400
Subject: [PATCH v7 1/7] of: address: Add parent_bus_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241029-pci_fixup_addr-v7-1-8310dc24fb7c@nxp.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=4762;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NXPlQLd0GR2adwrv2G7c7lY2KTqdBSor+PQ9mBUtQ80=;
 b=neSi6t48nUqyzgiIKTUZl9yWlJkBbL7wWbrra3WS67+WJ+N01sWoD8iSDTLVwIWxL1iHAFl1A
 No5VXxlt/FtDeAhPpwlFiaiiRA7gh7fF0cH5iTnc+dVO0zU/+Ym0F60
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 433bac44-f019-4d52-a88a-08dcf837e4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE8vcytTK3VOeUVhOTh2cUovSzhYaWR1YVhiV2VURW5xbnBIYkRSYnFYaFdE?=
 =?utf-8?B?Z0JGOUVEeEljYUk4Tndid2dJUzFKMG9tYnF3UXZ2STZJVjc1bTZPbjFyNldP?=
 =?utf-8?B?OFYvQ0wrdXozclZuZ0IyMkp2bHF5NnFzR0VEbll6cXhDV3pPd25rMHFYdThu?=
 =?utf-8?B?ZzRjVHV4eFpKZ3ptdlJ0SVpFUDk5K25GeGlqTmkrWVprNnpCYlVvRXFtRlJI?=
 =?utf-8?B?WjZVTW16WGFGZ0FvUEZUZ2JibDI2M1NUTEhCem92SkJCWkFzMWRtdEhWVGV1?=
 =?utf-8?B?Y1Y4U0FwRUJlSTVvZldZWUN6RGpmT2FsdzUwbEZXY2pCR0lOM09ycjNpOGI2?=
 =?utf-8?B?aHVZeVZ2MllHc0c2SU5DWHdTNXRGVCtRVDY1ZHlIU2p5cVQwZ3pYeFZnbjRK?=
 =?utf-8?B?cUsrUUlvbU9OQVBpZ0M2MVZzTlFKN1hBSThPVEx0MlQ2Vk55dDR5UVUwc09w?=
 =?utf-8?B?Y0NtVGdxOWFXV3BIdlB4Rkc1UXJ3cWhyRnh5bmRtQUR5dTlIckZJUUQveHNh?=
 =?utf-8?B?Z25jNDB2L0lzci81bFZsNDIwcFoxZndubFMvZ2pteDhnWWR1TVRBZEdBZGQ4?=
 =?utf-8?B?LzdTaUJ4aTQwOENndWhNenY2aVJFL0pncldyUXBFbWVXVlB5YXpwRUk5VFRZ?=
 =?utf-8?B?KytxNkdubkttTitXbkF1UWFSYkNYOEZrSU1Cc0IvZWRPMElMTjVWV3c5RjZM?=
 =?utf-8?B?Qm9iOVZjb1BqNDd0TlRocFhKcUVuUEhJUWFSdFAveXRmaDRHQlhzK1JPQnJw?=
 =?utf-8?B?Sk5YVlFLSUx5WmFjb0dGRHJOTkhkR2xhTlNLZ0haV1BvYUFDYlBGWitIUUdI?=
 =?utf-8?B?QTh0dXd2Slh5ZDJvUi9sT1ZGQmdpdVUxWXpLbUxsaXVZMnVWQjEyWTR3b3po?=
 =?utf-8?B?ZHJxWDhtdlVvRTJZK1NSM1VodHpIRHFoMnMzU3Voakdzelg1MkVlblUvd1dJ?=
 =?utf-8?B?SG1VSFZEUFg1cW80bEdEU1FBN0l0R09vMDc1b2dsb1ZBcDhzVDlTNlJpVEFT?=
 =?utf-8?B?OGVRRUFZN3A4YjdmaVIwbGJWTU11SmMvemRNZHk2Q1o4aGJDOTJ2Q1RZbmlW?=
 =?utf-8?B?bEpCelRQdlBKM0VhdW12bWI1VFNjNlMyeWttdG5nRThBT3E1MFBhR0sySFJN?=
 =?utf-8?B?S3JTOXE2ZnRWd1NUVlpqVVFKQy8vclUyTjluYXZpaS9WUGxuRWFYNks2N1R0?=
 =?utf-8?B?MnBiakdSQ05EZ0RYWnZFZ09UZDhTQTFUcE9JM2F3Q1ZLR1JJTWlPbVYxYnZj?=
 =?utf-8?B?MHErREszcHNMRkt5R1dyVzJ3dEZuZG5YMkdPSkpMVEJiZDdxc2FXUm5jemh0?=
 =?utf-8?B?VGZ6NHlzSHdaQ2V4citKcEVnY1ZtS2FwV2h5OUVCSVlpQlMzZGVKMVlrQjZ4?=
 =?utf-8?B?d1lBY21uVTNCS1I4VHp5eFk4dWg3UDVxTVBGZjhGSTRsbSsxd1EyWmM4Wm9Y?=
 =?utf-8?B?dlpIcktnZUxORnE0dHJCRlc2czROblRkSXFDVGJOMDBMQXZxcmwzMTh3S0xQ?=
 =?utf-8?B?Mno5dS8zam8yV2FTcmswUjV1cHlKR1JsN0xPNURCUDRHanAycWtPN29JRVE2?=
 =?utf-8?B?NElVSlhOZjJrRlpJTHY1SUtzejZoaVQwWGJoazQ4cnh5cmg5dzdVQUs5RXZD?=
 =?utf-8?B?akM4QlEvYVlFanhjT3lnMWhSM2Y5OWJsNzJZL0lPS21pZFROdnQxdjRjVWkz?=
 =?utf-8?B?SysyS0dFaTNrWW9SVmdOcUVlZ2F0bFR2bE95L1A2dm1SaURrUHd3bjJWZHdu?=
 =?utf-8?B?ajJzWjhvZkdjaVdMVjVYUDhWTW82a1owaXQ3TTJEUThRaFQvcnQ4NVM5QXFs?=
 =?utf-8?B?T3owYzAzS0lOdlRaeEMvU3RrSkxvU05aZWh4bjRTZktvUnN1SnVyUWxlM3p5?=
 =?utf-8?Q?9usDjy57/slxR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVNCSVlKeFE0Y2sxOHB0NjZBZHdGQUR3bituUmt3bnYzZy9aRTdFUkl6VFcv?=
 =?utf-8?B?UC9OeGE3cjd5bHhiN3FucGU5TWVLeUZYYUY4a1lwLzIrNWpwTTlVK1RxZ1dl?=
 =?utf-8?B?UEpPUXFuYWRmLzVoRjZXZm41Q1cyOHhST2hJODFDR282V09rYnczczUwTlMr?=
 =?utf-8?B?SE1VL001NzBESURXdFFHNlFmUU0wRXBTdlpZRm5qcjhPRTlLblFHV1ZWbjc1?=
 =?utf-8?B?SGtrZU1ZYmUxcTRnOXB3SXVBU1orMGRKTUMzZTRLck9QbldiaWw0eGlkWjVt?=
 =?utf-8?B?VmlKVEt4clV0TVZ6M3VBVHRJUlZHcE1zOWppclEwK2FSTXlrY29iRHJFQzR1?=
 =?utf-8?B?aXg0MEduN1c3RkJscm1VRlpFUVVIYVBPU0tPbFJpRFB1L2I5Q1o4RUJncysw?=
 =?utf-8?B?SXVYSFoyZUJYUnRzcGhlcFp5UXo4S0MyMngvTFhiMlNvTGlnZlNSQU5PaDVt?=
 =?utf-8?B?WGRkNGQ4bEpkbWxTNkxsY2Y1NkZ6aDMvQUxXV00ra2l0ai9zeVl6TTBhVnE2?=
 =?utf-8?B?U0NzSlZLRTJ5ZVFZR1ZubmEyeDBSMjRhZ09NMWNxb05YSk83NUxsYTJVSU1q?=
 =?utf-8?B?eEsvK1R1dVhYZWxlSTVxbmRXbjVsSkZ5RW5aakw3WjdaWVZTdi9JSWRrUjlC?=
 =?utf-8?B?enVDZG82ZVBsWHcrL3VJY0FFWWs0c0tWRlhNVTVUdk9HRUhZOEtqK0FqWXNF?=
 =?utf-8?B?eWhxam1qR0hIMnNERFJwZjVCRVRWOCtCUmZvVWRZRGtWcVo2R2dDVGdlTmhQ?=
 =?utf-8?B?TU44QnlrR1NYN05FUkZTbkZBckxFUGp1d21ML0FTUG5lM1V6L2c2N2hwOXRZ?=
 =?utf-8?B?SWQ1NGVMWUNWT1NOY3JCN3htRk1yMzYrY3VRejkxYWFWcEJVZ3VuV0E0L2dD?=
 =?utf-8?B?M0wwZ2tpU2NCWnM5ckFBN2lCLzZuanA0aEJYaEo4ZDhvakZPU2ZDVkRQR3dh?=
 =?utf-8?B?c2JzQ3luMndnRHl1cjBVQWlNcGIrdXFGQ2h4bTFwblpKbW1zUWZOVy9MNTdZ?=
 =?utf-8?B?TlNtdElTL0hlNjdGOFh0MEt4cXlZRThleVJneS9admJFMjN6L09FOFFwNkpl?=
 =?utf-8?B?aCtCQ1hvaFdHY3VlOHg2Um5EeUJLa1h6ekM5c2xRTFo1dzYyN0RHVUNlODFJ?=
 =?utf-8?B?K3NZQXFESFREOU1EMXJJc3I4UEY0L2N3d1NvZkg5UFJpekpUYVZzclhHakhl?=
 =?utf-8?B?S0YvZTVISXRsOVBESnkrNXpTNGFHRjA2QkcxMVA0bmNZcktkU1ZXODFjL21L?=
 =?utf-8?B?OThkWGlCZnRjSGNaSDYyRk1JdURuWFN0NnVIeVFwL1o1V3RGdzRhQklxcXZL?=
 =?utf-8?B?cDc0UzdiNXdxbnRJaFY5dnpwNE50VUZCdS9laFNlaTlld2g1dWpXVWQ1MUs1?=
 =?utf-8?B?VE5wbEpuZFNxeFFmUlFUbE9FTnNEUHhHT0pONTBEZDlrVVR0MmhkZG1QMS9I?=
 =?utf-8?B?RDhwM2hYTCtLUi9xVENyRUFVbXMwM1FhNkkwZnR6QTBvWlBzNjJZWllzaTNV?=
 =?utf-8?B?WmZDN1ZFVXlOVHhjZTRGd3ZrZm41QnRlRVZLVDBVRzJTU1ZJcjJNeGpRYUk5?=
 =?utf-8?B?TFNXUURrSEFTWnIvMHJaazBkcGVFRkNvWkpmSFovUHIrOG5GZzNIZFpaUjdS?=
 =?utf-8?B?ZW4vMEtza2tBalY0eDRDQzU2MjIxY1dua3lRNGRPbnpzZnF0MXVZNkxqWlhW?=
 =?utf-8?B?VUhCVVlSRkpINjhVYlRaVEYvWlprcTJlc2ttak1ueldPMzRoSjBwdy83eWZ6?=
 =?utf-8?B?REhGUXdZMlVMc0xTaHNoOWI3RzFBTnhPT3VvYjh5N09KS1FjZ2RaZGVDcU8r?=
 =?utf-8?B?L3VOZHNOUVpXWjRGK05wZFRTb1JIOFFUeHNFRWR4L09KSGpManlZT292bDJj?=
 =?utf-8?B?NWZPZDRqL1NPbld2N3Q5ME5YNXJzRkZMVVdpK01HRERwOXkyNkxIeVR5eElz?=
 =?utf-8?B?Kyt1Yy92NkcvMUVGczI3Y24xZGxEbFZsMFhPQVJXeTB5clRGUEpnbFQ1eUhy?=
 =?utf-8?B?WUVvK1BDSWxhMGJ3L3VyZWI4OUo1S2ozeFcrOGIyaTBWc1FrdFdVME1IcnBJ?=
 =?utf-8?B?NHBieXhHTWlLR3l6dTdjRm92bEJGYzFLMVBMRkhLQXB4TCs0dy91THZmeVlE?=
 =?utf-8?Q?4rS/m2mjfkvKKGxYCQizC6ik8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433bac44-f019-4d52-a88a-08dcf837e4f5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:36:53.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wm6A7BX+57kAHkj7vLw7G0mMiq1ztUOn2MHp4rbUdsFxTVjL+o+Nh1EVxNqPl40dulaMt0sMWfC9i+Nueiydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Introduce field 'parent_bus_addr' in struct of_pci_range to retrieve parent
bus address information.

Refer to the diagram below to understand that the bus fabric in some
systems (like i.MX8QXP) does not use a 1:1 address map between input and
output.

Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
(drivers/pci/controller/cadence/pcie-cadence-plat.c),
"cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
etc, even though those translations *should* be described via DT.

The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
behavior and driver use 'parent_bus_addr' in struct of_pci_range.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie@5f010000 {
                compatible = "fsl,imx8q-pcie";
                reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                reg-names = "dbi", "config";
                #address-cells = <3>;
                #size-cells = <2>;
                device_type = "pci";
                bus-range = <0x00 0xff>;
                ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                         <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

'parent_bus_addr' in struct of_pci_range can indicate above diagram internal
address (IA) address information.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v7
-none

Change from v4 to v5
- remove confused  <0x5f000000 0x0 0x5f000000 0x21000000>
- change address order to 7ff8_0000, 7ff0_0000, 7000_0000
- In commit message use parent bus addres

Change from v3 to v4
- improve commit message by driver source code path.

Change from v2 to v3
- cpu_untranslate_addr -> parent_bus_addr
- Add Rob's review tag
  I changed commit message base on Bjorn, if you have concern about review
added tag, let me know.

Change from v1 to v2
- add parent_bus_addr in struct of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..1a0229ee4e0b2 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..13dd79186d02c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1


