Return-Path: <linux-pci+bounces-16803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E889C956D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4611F2275A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506BE1B4F02;
	Thu, 14 Nov 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mf5hW/Dj"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F881B3956;
	Thu, 14 Nov 2024 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624794; cv=fail; b=o8r0SViS3wzswqVbVfbZg/ysOpRQ2yTsG8lZR0azDJAnusZ6oKUScQ+PpTu9JNgt1eSgPkAfdQTH/R/BUEZHUMmi8h5/IiQxoMAbUAiOG/Q6zhs6l6S65BJtxDIyNQpWVNcTTZrNtc7fozZa1caCuO7pPAz5ASkTk6UFmRBQyIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624794; c=relaxed/simple;
	bh=QTWqCilF4zeHBfeRMKTgOmEbv94DuAHrD35HEjvlft8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MmrFHOMoVPzb+CL8W550xEf+ZDrJghKtBhmCCMlO0znDPK1oWrCXSSGYCP6wK31r8sBgkf4CYl8JYkMIPd1Y0vToEnrleRUW1WjKH5QUKUCnmhCK+1yw2JVcIFDuTkSYOXbjq/YdoRMcSxOEaXInP++RZ/2kz1ikZ6sm9JFDh8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mf5hW/Dj; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0yHbBgcPQsW7keSYSozGbjb+AMbFgIXm+1k2q4NQiIlrUxQCUsw2n/fiuCeifxIC7YLAbwmzWg5esUexuGBl2M8WBOAS3cLzr3vljeyNaJhwJc79tCG/tNJY8GKf8R0XepQfJ5SmK4sTZLCjjkHGpFThmMCYB1eKW9Bb5annUe8AQh/TVjLi4ClmpNX9azH3LZ6gYbHlz34CPVZp0dcpj8gLk/62xRJNqsvAV+kgv8dqWHV4r3p0IRzbKQomuWpt4wBFYZ5WQ/XppaWunmdr3VgW9XOGuNVgHYUXnrpDSTrSO9D/f8TqQFnR9mJihiuOxKrEn/n+EyJjAQiLyFyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95seh1SLCdzbaMMMU9WaEBSdML7dm8hPVr5F6qDIHEo=;
 b=qmdJVo1AqDAlnUlI6jFTsr3RPFud+rapsDtn2eXL7Mev7om1reFWqqCZZ9r10PFamcLbdL2FW7sJiCem9l62uikpRAaITE9QcK4CfrMl44kA/o31FRHsF72gV12GKVSN3PMg0I7/HTTbiIO+APR1II5EK36PIVCOW0R03y7ZgEuyTdrAw3MrBJMrdFI7mgJUpYdhdwHinzH4hiIntVfTx7oVHx76GK91BSAym7L/jFoFbI31n7NY+Gv++3kYkoz9Z5v6oPjdj9SuDSyxYrInEJ/Kwj0suzt0ljulKcKeVLwlQ86hwcWjMwcBb+mT9h1q+5LtxPurwC8Dn36XhJqlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95seh1SLCdzbaMMMU9WaEBSdML7dm8hPVr5F6qDIHEo=;
 b=mf5hW/DjQ894C1SKRhYNjEtp/zPi6XEEX/KwBfcgMQv3VuQYI4P/LgNc7HuY8CHCzSoZS8lQkSZajjRNkxS99swXZpmsU4IJ0nh/sW/3bNst9Ua58rbyfa7bqPlsNh6tjHiGT1OG5WvrKOzhPBT8DuXgH68+elCYGK8Gh371k97yFZqAnEAkiPvgT6wU3YL5IdoaGmxnA730Ip85hDxkSyhzcAECpX9FLQptA07DjCXACcR3ex5Z533c8EB310GYmzm2wofzwWIuHqtnYIPvinA7nrOJROAbpX1vAz+Iv1IUbdPdKLM6Z3K44BElCwkEVmEBzhlQ7xZS8sVRgn5maQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:53:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:53:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 14 Nov 2024 17:52:41 -0500
Subject: [PATCH v7 5/6] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-ep-msi-v7-5-d4ac7aafbd2c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=5527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QTWqCilF4zeHBfeRMKTgOmEbv94DuAHrD35HEjvlft8=;
 b=A4qJoTr2gXtOiudcsj8dKulpIdx+DfKQ+rWaDyuzLoFSoZaT4JDWva4fMaYuIzJiyyQgXdqzg
 NOGm9dE9jptCj/oJEEj/RKt/QQoAuKuN86K2ha9rRENdhNfvW4EEarV
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
X-MS-Office365-Filtering-Correlation-Id: 05103112-3b53-4e3a-6a9b-08dd04ff1d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emMvcFczVkVwQUxDdG02M2cyWXVHUVB4SjN2MGhobkJyZWJyRVdqMFcrYWtn?=
 =?utf-8?B?WkpGeVBzd2NJWmYwWjB3cXptMnorY3piSStyNkI0WkcxbkZteW0rOTltS1Q4?=
 =?utf-8?B?NlAwM1A5a01qQkhZZkMwVUhNNUJFMVNPN0l0dUJJL2xTTW8rMHlCZi9WZWxC?=
 =?utf-8?B?NHJJRFMxcnl1bExUaHBoZ1JXd1BKZTZuRStHR25pWVRyKzllNVl5L1oxbHp5?=
 =?utf-8?B?UXNUdXZqOGNHWjh2UWFENk5abkdRZmxkcW84Q28ycXZTMTY0bWllV245NUxu?=
 =?utf-8?B?SmpOOUkxZEpzQmh0dnVVLzZCOXBBeSs3VWdmMTllQklmT1ZrdW1vTjF2VUFu?=
 =?utf-8?B?TnhIV1pBUy8zTHhvT2lsQm5wZzRCcjRBZ1lFMHB0cGZIV0phbGlZUzJiMnhV?=
 =?utf-8?B?L01XZU9QUDFzSGhPbVhRZ0RkSDNUSGVKRWF4bFhKMDBvTmdZREo2YlNnTjZQ?=
 =?utf-8?B?YzZldVNjT3d0RE1DVlNuV1ZEY1ZibGZKbWxUbjl2SHdMUzkwSDRUc041STNR?=
 =?utf-8?B?SkszQWtNQVBxQmFoOEt2ZFBIK3lYNy9KUlRIcnl3eEFmNExKR2JMOFRQNzBO?=
 =?utf-8?B?ak53bVRHNGRhNXJmN2x6bFNlRm9FSmUwQ3lBQ3ltdGJmcGpiakc0T3BKMzdK?=
 =?utf-8?B?dU1pa3dseXh6MFdMQzNyV0NGdjc0YndoYzBPaWNsNEt6bW1NTzdSdTYrdHJq?=
 =?utf-8?B?dmJHN0dBNTQrSkFXTlQzR05sWWMxM2VLb3A2MlA0UGRtSzRURGdJNkpKaXVu?=
 =?utf-8?B?VnFDM0hIMk85ODNGMithME8waUxGbFROWEZmOGk4ZGFDMEJJMmlBeDQ0RXZ6?=
 =?utf-8?B?SC9BeDg3Q1A4YlkwMjQzeHFwK1FDUDk1Ry9Ia3N3LzRqN1RaRnFVd3gvU21K?=
 =?utf-8?B?UDlFS01HSzdtVnJjU3FCSGIvWlZMZmVGQnRPODdxM2c2K01IdHV6Mm9RUHdl?=
 =?utf-8?B?Z3VKV1FTb2prdzMvVjBqVXU5bFdSNWJ2Q0s4WkQrbjJWNjhaUHRsVEZydzg0?=
 =?utf-8?B?ZUYwNFo2T0p2OC93eHlRbCtDV3FjS1VXa0lDNy9MMDh0dTZaUWVMK0ZqQlRq?=
 =?utf-8?B?OVdRVHFJT1lLUU9VenBnWXo5aDJPeEd2SGxMV0JEeXlrYTZ3Y0ZvZ3RGZGs0?=
 =?utf-8?B?WDNYZ3RYZWF3KzRhTkhQWXZ1b0ZhVDNNMnNLWG1hckt4UWxaZ1NLSUlUZ0dv?=
 =?utf-8?B?TXY0Mkpub2ZYemVXOTl4c2wvSENwK3VINFRNbEJsdTk3V05SWEtrTnJRME9u?=
 =?utf-8?B?eW84ajRVa284VDJUeFMvWlIwWUl0Zmh3RjBxTHBlY041QmhpNXpHOGlhWHVl?=
 =?utf-8?B?ZnExRzFyYTRIY0FraDk5TWdGYS9NYkhkUGQ0NlNidzhvNEFVWmdiMy9CQVdJ?=
 =?utf-8?B?V3QxK2I3NG5WRzd0b0VuUEpyazJzRVF2OENaQmtzS25rQncxYlorbkNUL2t4?=
 =?utf-8?B?NitrMmVhS2tkdEVlaXRHQzcxZmYxb1FyZzA2RHg1MkkrREdVOGx1Ymxjc0Zw?=
 =?utf-8?B?dmRhb3BmSEQxUWIvbEdyMk1ybTV1SklrUjc0bXpLTnE4K2d6VkgyOU9PZ3hF?=
 =?utf-8?B?MENycldvT0RpaUNUQjE3b1hYS3BZalpWeHBUUXZIb1FJaEdxM052ZEd4UVhM?=
 =?utf-8?B?MU90NG5vcTRiMm1pNFdHV2p0MlhRQ0pydVNQNFFESG1PdjA2T0tIZHEwYjY4?=
 =?utf-8?B?U1hKUWJ5Nmk5MnNhZjdMZHdiMnNYSU1BWm9adXRNcFg0WXd5cmxQT2R6WXhJ?=
 =?utf-8?B?L1hYcW9qQUlIaTlRTmZsSjhKMzB3YzZKaE0wdVJzRUliUDF3Y0tZbDNseitq?=
 =?utf-8?Q?j3ppu2emZI7ogBhIcFMHFxrOGfhhE/lTGYgIM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmdBWU5LNUFHallPRWhmWmNWUEN4aDg2OW1iTTFDYnZwcGNTYkhuN3BVNEk3?=
 =?utf-8?B?ZHRyeldFMnYxT1k3cGlLeGliRGhjQjNLTVBqWk1VYURGK0l2Q0NPOVoyS2wv?=
 =?utf-8?B?VU9tQ3BwOEE4UEhOOE9kNU9jTDU5NUFEU0J5S0FqY2dxR21va3hwc1l0ZUVY?=
 =?utf-8?B?TEllYjEzUXg3ZlFSOFRqMjV5b0pac0JRcWVTWjV3T2c0SHVPMHN4dGNBcTRk?=
 =?utf-8?B?OExnUHlNNE5xbE0rMFZqZDd1eURNUnlpdzd5TVh5OU5valhIb3VWVmU5M1FD?=
 =?utf-8?B?ZDMvdkVoaG1rUlVCV0FDQW55SXEwQ1pKc2kydlpqb0NGTTBxbEU1dUxwY082?=
 =?utf-8?B?OXlYbGozejhKTmZsRCtBVnRweDM1UmZINll3aHFGSS8weHhPTGVCVnpRd0dq?=
 =?utf-8?B?eSt5NnpReWx4QjRwanJpdDFTK0RpWlM4L1dXK29kSE1CMlYxNFMzVnRObWVa?=
 =?utf-8?B?a201N2FYajNpMFNmaWNDRk5nU2xKczd4WVRkQXNEd2xTbFVPV2JONzZQUkRT?=
 =?utf-8?B?UTFySHdJdnhZR1lXM2NXbmxxaVdXMWdTR1NGVHpWRzQ0NjRRZGpZYTVUUVE3?=
 =?utf-8?B?Rk1iUVptNUt0TDh4aElhaTVuWm9mUE94d0h6RG83dHRiN0tHWFg2SFduRGZT?=
 =?utf-8?B?OG9HbUxJLytYV1JqR0JnbGlrVWJoSU1wRjhnRVNVbmtwUEcvT3pDNmFYYUVF?=
 =?utf-8?B?bGk0Z1ZMYUF2YlN6MitFUGJyazBFOXBrN2tEamlGMlhiemxGeGp3Wno0Z3Jv?=
 =?utf-8?B?TzExbGlnTkF0bm9PcDJzSnE4WTVHcWVTWklwQ2p2YnB2a2g2L2xaVlkxMHQr?=
 =?utf-8?B?SXVQVWVxalB0ZGRpeGFlMU9Ia2JGSCtIR1ZZUllEaERKOG5Nb2pKT1ZEQUtn?=
 =?utf-8?B?VWNSSWdEVVIyOGFRUXVnd0tXQ3VsQnN3OVRyei9JT2tTcDBxNWxSRjQvcnlz?=
 =?utf-8?B?Skx0R2RORHhGbXQ3VGF1RjFRblRLWDNiWkE4Yjk5NzRIdzdla2NEbEdvSDRH?=
 =?utf-8?B?RVRUYk1xZ1o2WUVwdTkwakdBNGhCV0dJczlQaDhHbitXUzhMZ1ltUFlyQXVH?=
 =?utf-8?B?dittbHNWZ3g3dEovc2tSV0V1WXloUHdxd1YyOUphSkx4YnNieFZLOHlTQmJR?=
 =?utf-8?B?R0l4MHU3cFhNZkh6Qk5wRzZoOHVMRWdLRGtNYTd0ZWJpUE9PT1BTdGpKMzBv?=
 =?utf-8?B?YVhlUERDbEx3ZTlNSVk2Vlc4WFFxVE1FYTU2dDNkNC95cDhRajNsOWJoUGkr?=
 =?utf-8?B?RCs2d3krbmtRbTlGbGdnNE1CQkw1aURNcS85Z1FMb0dkdFV4d0hkZW0vb1BY?=
 =?utf-8?B?aWxuZzExaTFvc3I1NTJQc2ozblJDSURtdmNsMUc2aXluWG5SLzBCMUVFRGdQ?=
 =?utf-8?B?aEJrSzhFN3JzQzA5d2FVV1NyWGpqcXpyL0JGWlFxc0l1Ukw3a3R6NWE1eHJq?=
 =?utf-8?B?Vk9wN01udFVRQjh1MG15bGswU0JXeDRpdW1idFpMb0p0STUyMWRkQy91dGRn?=
 =?utf-8?B?aGdUUThJMThpUVYwNGdEVzZtRTJwV3BYYmtTODJzVG9ROWYyQzY3RitZdS9m?=
 =?utf-8?B?dXVZQjc4a3dlT1Q3UE51ajhrdzJzRWkzTUFqR2t3QUUxYnNFU01XdlpibzJr?=
 =?utf-8?B?eEU5cDBqN2VkQWhwR0pkSUZ3aHFvdk1MMms2ZkF5cS9XMkNacWJ4dEpLZ0lO?=
 =?utf-8?B?bGMwM3phY0lhdHR6UmYraGZ3eC9yU0N5NzVlWlBEaWRxZGNnVjJVUjlQODN3?=
 =?utf-8?B?bnZiMktFQWJBZGtJMFZzY1RIZXhiRXBGVDN6Rk40amZMZmlQMVVzVkY5Rmh2?=
 =?utf-8?B?RXdrT0NzU25sTUphY0pzUHBhQzVtQk5pYkNxb0tqakdtVis1M3pxWmFqU2Fn?=
 =?utf-8?B?cWlQUUI4TTRrMEU2MGJOeVpjMjlqTGlnOWh5d3haVlFGRHpSNHRMbG82ejJ1?=
 =?utf-8?B?YWZ4VXNleFNWZVIwZ1gxZU9xcWFOYTBadHpDU2ZqYVpMQlNJRFBOOHVzMGFs?=
 =?utf-8?B?YlEvRlQ4UlRJK1lNS0d5TDNJVlZYL2lheGp1NkROQnJpRmF1d05qWFdvajdX?=
 =?utf-8?B?TGNHelhNR3dqSU9QL1E5M0lULzQvbzMzSFZPZ0JIZ0o2T3cvbFJZaUltL2Ew?=
 =?utf-8?Q?CQgI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05103112-3b53-4e3a-6a9b-08dd04ff1d1e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:53:10.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBUpvDhni6lNoHoLArVYorCmqZciuSLvLwUhX+zpmifXBZBm7C0j1SNifb8HDy3Nqvh5gdHAOqwc222KzX621A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

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
Change form v6 to v7
- none

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


