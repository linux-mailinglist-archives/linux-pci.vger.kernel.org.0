Return-Path: <linux-pci+bounces-17954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34419E9D6C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC99B18870FD
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF01B040D;
	Mon,  9 Dec 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmgqvOUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AD155325;
	Mon,  9 Dec 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766525; cv=fail; b=hCuIhx6+0qa8J4ky0uU9hJBFWNbZWyLw/4/mShKA4CkS7ojoZCGUuIRmSiyoGFZt3ib0tnq0IVon8iAHLVmpTrGQmXAgINRkXZDVtamzQ35OOOW1KYBRjeZhpPQCFQUaYYt5GcWXPGH5QezD+WBBQrzzSZkS2iG4mHSBF5WRYyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766525; c=relaxed/simple;
	bh=VihzRogf7h7/CuH6TuzIZ4wGG6MH7XOdaToVHZQlB8w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sQM5El3+Qi/qAAbfvaBr5OwQBx83l3D+Iaouo6Z/+RPKTLmA0aUsSAn9gz81s8McJzn1h2UFJhgydOPnIXSedz4WCskB2HYrnMb2hhRMvRYdrJYTPZlYfCBtEK09xyHu17Ixnte8c7QtjyRe7QbXBp0Mb8ab2d1BGlwZOzXKH04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UmgqvOUa; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6HWiYbyHfficjZwsDlUNsOtTbLWbBOcrADrmMlh3cXqY/CPRE3sTDQ8e/uLJkE70IxHqom9iRZSF+zy5wyF8irMX9S9w8aBlS55poOC9lkRNelYxz/Qip5KZVvSX7e7pJ/de1U5YAJugU+lu2TbRPzm4JSihZQC79DIQXtOojKONJjGlV/UmMexTIAHxT5z99BSSkTveV/qw25+F8QoaVbnAb3/WQuc+595I5XxQ7bDLsMG/oSSv2h9O5ldAG07bE7ca1v2mdlBZ3WzlDHVxierZNeyasqMNf7fr58GlqhM5/zMPlkJL20tcZPLzkMSeK8PrQXBboQ5G272eq5gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKqUQqst3YIBTuYRldvFw9Qzk/qMXPj/XmdMGedG9uc=;
 b=CgCli4Rj5VR10tVzicFhdQ2ftzlVIiTx6ErKvLSOQkf5N4c/YOQdmm6OruIbiITS8XUKInWvejWvZOyGnrJvgTo4BmTyc6EzsQoOZ771MMhv5nWVIH78+e15aGk9q56J3ey1mNlLR+Jsxoi6HIaMAAqiqXVjLYAeszptgD/Sfv4FqPVgCtotcFRb7G4sL3+D2KU1DpRMEUzSmeFJhx39cZMXcvekuitJonowJpT01mvWtvy81TrFMsKfGDZar6cQHGGy8U13KXCP5j4/8wyznRW5/3wf/oKFzQw/KyXJaMdmQk6v8DhIkKm1aHOjH/oFDau8SIA5XKHWYISAoWfzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKqUQqst3YIBTuYRldvFw9Qzk/qMXPj/XmdMGedG9uc=;
 b=UmgqvOUafVTi8FgfmGUkgdxYihSEo8lXvasuGqb5sFqWeIsetLqFV0CSZrC90r7P84m/642GLuLyuGHX8qlRqIy19ozDFFPGB9Kvga5/Xfo6rvRvwYM7aujKFU2nAq4dyroMzE8z4fFwmkczPmON3eCj4F5iT3sFTElV9Te9G9Vs6SieyXYedbmII8PmQ0tRsKMWjFiQ8fIJjn1t+nhoVAVjFqm3d+8RyLn5obp+vHlyuzSHcKv5kH/mvCcnJ1BLc6ibdntHzTuIOFojK79IaJPMrCSPafXRY/X9VynL3Qok/+ffSsdF5kuVAD9+sTqETqfCMOUHdZIDgiKEQ9HZ6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:48:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:48:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:14 -0500
Subject: [PATCH v11 1/7] irqchip/gic-v3-its: Avoid overwriting msi_prepare
 callback if provided by msi_domain_info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-ep-msi-v11-1-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
In-Reply-To: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=2525;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VihzRogf7h7/CuH6TuzIZ4wGG6MH7XOdaToVHZQlB8w=;
 b=P5ZtWrjInra1d8pJDhRjqJfZU1RWwu/QYItIAZRTfGUhD8GNPrTVSje3doJAwgcn12AdAo5du
 TomJEVUaSQyD1nGqy/NvaVxDxYSTsRLwdrOzzJiSX61jC0E36iGuwsf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4403ed-8879-4073-9f46-08dd1879b6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZCR0JsblJmS2hPa0srQlNyS2d3R3ZUV3g0LzdCZFRZaGVabWlpTVV1aFBN?=
 =?utf-8?B?QytnYlJRcFA2WG51cmc5QnJRWUlzMmpEUjhMK3gySzc3RktSZWZnakNYVFNY?=
 =?utf-8?B?Vm56VmxnbkkzVjk1eGtZSnQ2NGFWMFhnb2V4N3dabnBDeWNyVXlrZUw1dUNT?=
 =?utf-8?B?YUpvbVV5Q1lqKzhYOHZmY0hlSGdXc1NDK2JGWkFNSHpxNTFOMnF4dmlxWFV5?=
 =?utf-8?B?bDR2WG44SnFZN0wrMnBELzBicG5GTk5aVkZEMWcyODlVSFJrQmNLRDlSaTJV?=
 =?utf-8?B?ZjRGNm53OVdBVmkxOUdvWlBEbFpVOEwycUUxdE56V2JaUU9sUVoxTjhRS0tF?=
 =?utf-8?B?RGRhWDV4amxoR0lKL2dYVnRENEp5MWVKZFVZL2c0TEg1NGp6cHJwTGkyMXpI?=
 =?utf-8?B?M016RUw5SmR0MTdILzh5bkxXZ0VFNHBIbTNPdFpUdzRzaThYVFh2eGtJUDJ3?=
 =?utf-8?B?SzdNdXRvRUZRblJNRHEycmsrR05nNlVCcHA3N3NURlN2QitFWVh0SGFhaGNB?=
 =?utf-8?B?cURQMlJmeW4rV3BoU216S3VoRjNZVENhLzc2UVB3cVozMm1QamVZeExlRDVS?=
 =?utf-8?B?dm96R2JBZkNIams1U0grUXo3TmlNS25UU3VmL2M5eVJKSWRZRzJHYTdnbTVG?=
 =?utf-8?B?T2VmbmRSL0xZeFVlQmdjN2d2YUFsazdLYWg5bk1Va0U2L1hPeDJSTnhhbUxi?=
 =?utf-8?B?dEZ6MmMyZGlMenJUVkxRRkt3YS9VVzhSZW1LWm54Q1M2UVJueTU4citZd2NR?=
 =?utf-8?B?dlB3enFZUHBVWlZFekhhbHBUQk51SjlCNGV3b2hHMytmeXg2TjFLZS9oY2dI?=
 =?utf-8?B?cUozR0dPbUNyWHJwcGdzL3NMZUVqbHhSMUdQY21UTlVxRUF0bUdqTHZ2RXI3?=
 =?utf-8?B?WnlXbTMwUkIxY1FkMmEyK09aMGNTVkI5TTZBc2VveGl2azQ2WDM2aWFkWENI?=
 =?utf-8?B?VkdwVk9jYWFNR1Bia0hTdS9iOTRWbDlyMUpWVEVsbWtlMXhYYXpac1BJRzF0?=
 =?utf-8?B?TStjd3E1Uzc0bEdJekUyOXhXSDk2UDlCamkzNElTR1VvTnNETGQ1V1MzMGlt?=
 =?utf-8?B?ajhmQWg4N3g5eDQ1SWt0L3Nub2o5dXdNRlFxSWxyZTRVQkpodXhiRVNKY3Ur?=
 =?utf-8?B?TjhvdkR4UUZDMVE5M3FJME41OWhaQ0JFS3owQkgrZTJKc2hTVU5KUGRpQ3pQ?=
 =?utf-8?B?NkQzbW9vbHF6YkhnOVhJN05QNXNmMFdqUTduek5PalNiSVZGa1pSQUJ2U0xR?=
 =?utf-8?B?TytHang1bnJiMk56NUlJeEdBNHFRMUxPMTh0UGxsMWJ1OEJKVUsrODFjUDNJ?=
 =?utf-8?B?NndvaTN0bnpDczdqdEFHK1UvNDc4N1FBNVhpYUJaOXlUTEJRdXNlM0s1Q0hp?=
 =?utf-8?B?MnZzT2RvSjhSQ3dCYVoxRzEwY0tvWjU1WWloSldmRlpWdTZRbVJlN3NEVTRP?=
 =?utf-8?B?WXlwRzMwV1lMcWxHaUt6QlJtK1NUaTQyeW1CNDdJR1VWS1lmUHZadDg5TFpu?=
 =?utf-8?B?SzVLZUdoZlNxaXRZb3JnQWlmTFkrVXQ4Sk4xWGlkTUFOZnhHbkRmWGxjTVp6?=
 =?utf-8?B?WGhQRTNvditPcUxvYTRRVjJpZitzamFkWDljRndrYlJiYURzQ2xkOUR2Yndk?=
 =?utf-8?B?aVZISVowMzU3clRJMEFERGdyRUgwaXVoZkxQYkRGU3p6Zk5lN0g2NWZpNGEw?=
 =?utf-8?B?TGF3NEtQSWRMdUJTZHQrWlpoaWgxS0oxV3pmbS96RkJpdW0wWW11aXMxSnps?=
 =?utf-8?B?TGgzNXJ3RGw5bDl0b29tMWVuN0dwRXNqK3JNSmhuSTU3elk0L3Y5ckdsajda?=
 =?utf-8?B?K1BMN2NoeERBcFV1RHVXbDhGdWJkVUxkYzB6MFRxMW5JdlRmMXdWYkJWY09t?=
 =?utf-8?B?NXJkMkVRK0Vxa1ZRZ3BDZ3laeVJLOEM1Rm9Nb0ZEWVVGdHFnYUd1aEx0NkI1?=
 =?utf-8?Q?H8ZBrfoPVXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGs1eGpUSHAxQ2dlQVdaSEpwTUVyYnJuaE1VZGNuaE1SZnFudnRIajRXMGdG?=
 =?utf-8?B?dit2ZEovTUNmd0xnQ0VldjFvYW5vaVphMDAxbmtPOC9nRDA5aU85Y0gwZXZt?=
 =?utf-8?B?L3FWd0lBaDIzYm5Pd2J3SXBkZkQ1ai9FazB2cXFISE9pRElFMThFR3BiUldu?=
 =?utf-8?B?WXpHeUZ2VVY0eVNkZ3Q0emNtVmZOSzBsYUppS0NLUzNuaXNtaTJWWHBUejU5?=
 =?utf-8?B?RVEwd2dnQnlDY0UxSTJUK3dJNmo2Z1Q1VEEzeTFKV2RpaDhoU0UwdkIvblYy?=
 =?utf-8?B?RVY3NlJ2aHI4bjBGbEMxU1h5QkRPOXhjMTNvbDE4eS96MloybWprdnVlMUUy?=
 =?utf-8?B?ZFgrWkc3YW1DR2JQRUZtN3ZHcVp1VzVuWFJqbi96UnZlaFJKZ0x2MGdQZFNI?=
 =?utf-8?B?Mk4wQWYzNWhKRlIraHdRNFB2dHdFajEzaUs4elJUMDhLanVRZ3FUeSt0ellS?=
 =?utf-8?B?TEhUbnJkNVN4ZVhiU3Zwdmk0WUNFTzN0QkhWUktGbkpUem9yZWxtOHRlNDQz?=
 =?utf-8?B?V0xZa0hicXRRRHEwNGR1alVhWDJzQ1c3VDdMMm81amhiVjIxbWt6bWhtcGdI?=
 =?utf-8?B?QjNlejYraFR0NFE4b0lpL1FnRm5rTCszaFJqR29Zb3hvc1FBUGVCUzZONDZX?=
 =?utf-8?B?bzNvdW1LSTBMeDVLR0hXYU8zMkdlYUJrbXlKWjlzT3BWUGhHUkorVEF2M29v?=
 =?utf-8?B?ME1mUHAxRFJ3TldKUk9mUjFPZ25zRkF0aFoyTGNTYWJXZHY4bXBUUDVWdzli?=
 =?utf-8?B?cE9sS3J3ZUZWRWxwTkJnVzRVNUpUaUxxczVWWXExVSt0bjQvVW9pVkw1dVlK?=
 =?utf-8?B?VjhOZ0dmN3o4dk9hTmxnNE1TMGQ2d3d5ZzdaOHd3NEdRZHVzN1FFWk5FaWdy?=
 =?utf-8?B?ZERTVmtsZEllSEVCbTdsdWlQKzYycHdqWVk0czZINGJwMWpiRTBNUVZzRVRh?=
 =?utf-8?B?cDVWSG56YU1PR2hYcFZsb0R1TFNtQS9UZmx2bVU0ZnBpbmoybTArZFpaOENK?=
 =?utf-8?B?ZzZxVUFXRy8yN3MzeDdTMW9FUWlYUEZUVlFrbUsrUkJhcGk5QVJBMlRZSXdy?=
 =?utf-8?B?ZGx0eGg2TkJYS2RqK055QWJBQjhRMzZrWG9heFZaU3ZrWGtyTEVnNGRpVk5F?=
 =?utf-8?B?R0EySXhNL2dFMFp0clk2QVkwQVlmVXdNVjBtSlNEZWM3MVVrNE52VGpYc2lI?=
 =?utf-8?B?SXVtcU1IUmtZd3V6a05pSkZIM3NIMDBCV3VackJjbllaU1E4NDh5QVY1ZElW?=
 =?utf-8?B?NGRVcE9pcmo2Yk4zL0JHTFV2SXBZVmZiY3pSR25lMml0ZzREQ1gweUMvbjRL?=
 =?utf-8?B?alRBSnIwY1J5bHBweGxpSUUxbXpxRnhRMnN0ZzhRTkZNdlQ5Q2NuaCttNVky?=
 =?utf-8?B?MkhvTEVhK1FsK2k5emh5blNWdzQ2WVlFSXZ0UXJhT3hKUFA0SzFMYnBzYXBw?=
 =?utf-8?B?WUhCQVVWdnFvM0cxc2NFK1dWUUhNOTRRMWVvbFU2ejIxQ2VtTnlzWXNQNlRG?=
 =?utf-8?B?Ri9EblJQOU5OUk5SczhUeFVjeHp4R2FiTEZzdXBxNmcyVXBTRE9LZmpINi8w?=
 =?utf-8?B?L1Y1R0U0c3VOY0hRa1Jhd0I4N3Q5SnBvNkI0bUxhTVY4Q2N4Sys0LzdJY3lu?=
 =?utf-8?B?T2NzdWhiSVA3NVJmOGc3SWZ0cXNDWFBIK0lNeFRnbTB3Qk9wOHdZRVJDSm1I?=
 =?utf-8?B?WUVETnRhNm8zOHR6N0FBOEZqdlJPYUIxSk9LK1h2T3piZEljUVNVWlNLRDht?=
 =?utf-8?B?ZkZtY2R4bE11QW80S1hlMzNnbWd6M2VEWkJhTDErNFJaTTFDTE1GNDQ1c2ty?=
 =?utf-8?B?Q01lS2dEcmppYU1QK0pHbUVYall2c0NmUytTQWljMWd2U2E4WC9pRU03QWNm?=
 =?utf-8?B?SGUzUjYrWkpWd0pMMHpVbU5xa3Z5RmJCN2IxNnAyQmk4aExmbTBqdFNtcncw?=
 =?utf-8?B?MXFKYjBhNGt1eWxoN0crTVlxNDI4eFNMU0lQZmZTcG12eWdkU1R1d2Q3aDNI?=
 =?utf-8?B?ZVBsaFl6TGkydzFvZm5rZjFRc0RMWnhPc1p4VWMrVGVuYzVIcVllYUpra1U3?=
 =?utf-8?B?U3ZiR241QjUrUG4vUXFIRmNEWko1bXNtSXZXdmdqdE80QStkZjBsRnovSkpK?=
 =?utf-8?Q?qVew=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4403ed-8879-4073-9f46-08dd1879b6ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:48:39.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTQfo+4V16oPhc6LJUBGg+6l/1tiFS1ul5l4tkdYUQGJI5Xng4eWM2fF2gRMK6VyDjGEpLzJi0UobGRq0ZpAVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

  ┌───────────────────────────────┐    ┌───────┐
  │                               │    │       │
  │ PCI Endpoint Controller (1)   ├───►│ ITS   │
  │                               │    │       │
  └───────────────────────────────┘    └───────┘
      ▲        ▲
      │        │
  ┌───┴──┐  ┌──┴───┐
  │      │  │      │
  │Func1 │  │Func2 │
  │ (2)  │  │      │
  └──────┘  └──────┘
     ▲         ▲
     │         │
     └─────────┴─────────────── PCIe Bus

(1) is platform device, which is generally descripted by Device Tree(DT).
(2) Func1 and Func2 is created by configfs

The current platform MSI API supports only a single device. For instance,
a platform device (e.g., PCI Endpoint Controller) calls
platform_device_msi_init_and_alloc_irqs() to allocate MSI IRQs.

Child devices (e.g., function devices created by configfs) require
individual MSI domains, with the same MSI parent domain as the parent
device. These individual domains need specialized msi_prepare callbacks to
set  msi_alloc_info_t. However, the current ITS implementation overwrites
the msi_prepare callback with its_pmsi_prepare().

Modify the implementation to assign its_pmsi_prepare() only if
msi_domain_info::msi_prepare is NULL, allowing customized callbacks where
needed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v11
- new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 75aa0d4bd1346..33e94cfc4d506 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -195,7 +195,8 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 * FIXME: See the above PCI prepare comment. The domain
 		 * size is also known at domain creation time.
 		 */
-		info->ops->msi_prepare = its_pmsi_prepare;
+		if (!info->ops->msi_prepare)
+			info->ops->msi_prepare = its_pmsi_prepare;
 		break;
 	default:
 		/* Confused. How did the lib return true? */

-- 
2.34.1


