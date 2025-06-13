Return-Path: <linux-pci+bounces-29685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CFFAD8C31
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2941E0DEC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E279476;
	Fri, 13 Jun 2025 12:33:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023105.outbound.protection.outlook.com [52.101.127.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7A6FC5;
	Fri, 13 Jun 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818026; cv=fail; b=YmniwBZjxAPyWDAQUjuVxh/BCxxq5cF9hMqI2cRlybOC59nKGDvFWoR4I1A5lS/pIQUhZLrRissmTDe3ZUjzsLIouNv+Y+CtU05GtnhkNCm2aEv4igpxd4FX5xkfCN3xQhKbTOUNMZAEnOCh8kem8TAoTQUFejq+km0TSo6cvow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818026; c=relaxed/simple;
	bh=9Rxt8AzOh+tlVRa2psVFtK5ls5CzCw2CF6acmSAy4LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ArIBZqdDt/29kq3/juGpWcwLRyNGw5wMWOWrPMRAXzGzkhpJuohVas/S+e95+RW5gFce9LhBOixCG43SfgxAqDkN1orLuu6kUh+CXJhj+bMob/Dt56S30slokNmsuuEviUIDmjnzMm8AQlq56xOSOMH0IZB/PYn0gEXGF+3KFU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj5qJ6xHQM83SLhIKapLTtaJmVKM/r2ChL4MWI1T/2syHyemeaXl2Yu83dC+yTasmi+99lOhPKdEpSGrYk8ZpZUUOGft33TlPYmYYlj6xzainm0C6kIHeSW2rrcNeq00fNBYfKAHXOG/csYhbuD8dp+oOfzFG5y3BBYViSt83SelTQL2rNOaVCh2FbPb4bitBgHamYiIwoWzVdXsbMBm71Akjwm0uL2PSxFK6cj0AKagDbAA4a0vm/MlQ3lsYltL2Sn5/RyVrKpvoZ9l3hejk0CPeQuRQ/sxmuAkK+4ULlsy91CmE50U3doqc/su8krN8aJJ2/o/JDpLkicKLYGu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rxt8AzOh+tlVRa2psVFtK5ls5CzCw2CF6acmSAy4LU=;
 b=Da9KB54r1gCfFn0aPBThzZ7M6UGiUW4pn/gAhX7ens9+aVOPQqgJgrzepn2Ajx4zEtpAqOFg7640K4ybaIviNsKV0WPsz8N1kKD7Ar9wdDtwhSPIgZ1HL1MNzfBwRlG67819Vj16rE9gDefjU1Mdqehh1kme1NZZZ3DLdfvAChQEzwIVB+bAOl4JgdvpJzSGpmoRtoBpvnSrcq9XKoW8Sr1qOf7feYJL/nQquRsX6Gx7HDVzu7WsRN8y6TYDxsPrf5oy4fAlsGOfidcdVRKMseoFqRKL5fBtJ7+WB1Mzv5Oq1O40ts9YEHgguEYTFzeTp7uUKDpPNY4rrgqeQyrwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 (2603:1096:820:87::13) by TYZPR06MB5420.apcprd06.prod.outlook.com
 (2603:1096:400:200::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 12:33:39 +0000
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462]) by KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 12:33:38 +0000
From: Hans Zhang <Hans.Zhang@cixtech.com>
To: Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "mani@kernel.org" <mani@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIDAxLzEzXSBQQ0k6IGR3YzogQWRkIGR3X3BjaWVfY2xl?=
 =?gb2312?B?YXJfYW5kX3NldF9kd29yZCgpIGZvciByZWdpc3RlciBiaXQgbWFuaXB1bGF0?=
 =?gb2312?Q?ion?=
Thread-Topic: [PATCH 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for
 register bit manipulation
Thread-Index: AQHb2u5eKuHrkrx42EiULNApk4O0zLQBAD6AgAAHvgA=
Date: Fri, 13 Jun 2025 12:33:38 +0000
Message-ID:
 <KL1PR0601MB4726E09FD2A35DC81E7B16F09D77A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
References: <20250611163057.860353-1-18255117159@163.com>
 <aEwTXVZI0wvRvgil@ryzen>
In-Reply-To: <aEwTXVZI0wvRvgil@ryzen>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4726:EE_|TYZPR06MB5420:EE_
x-ms-office365-filtering-correlation-id: 2d467b3a-70d4-4175-60e1-08ddaa7685f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?R3FIUklxeUxxbXFTRWJoakhkVVlDTHFiM0dybUd5L3pqY0dJZ2hkQngxeUZH?=
 =?gb2312?B?K1dEQjhIS3gyRkRFeDc1WG5kQnVKVmNNNFliNk5DWFhNL2k5eUhheWJ6L25G?=
 =?gb2312?B?VzJWZWRFYnRQbEZmdWVVbFZvdi80MXFNR255dzZUNWpEM1YrVlVIMHdLK0hV?=
 =?gb2312?B?WVEyNE1uSllaTUhRSnhHSEtOODBYU3YyNnlJaXVEZ1dHZnJCK2hwWFVweFRp?=
 =?gb2312?B?RVlWM3oya0NXb0IwdVVoWDdDSzRtaGtXb0h3QkpNVEt3OHJ3UVpqTXhja05V?=
 =?gb2312?B?cExiQXFpbG9pYi9vd1MyT3VpUHl0b2dPU1E1M2VULytWY1RQTVhzeXhIdkNW?=
 =?gb2312?B?MUtiQisvNURkcXhkTlIyY2V5YWdCUlA0NFZFUHRGSENIaGRrYkZCTkZ3ejBn?=
 =?gb2312?B?L2FZNlZMbEJSTDlEeEsvdnlLOWtGUUc3QnRuSDMveDNXOEYrV3Z2T3NtTnpU?=
 =?gb2312?B?c0JhZ2tWaU5iUXp4bnhHcExKWVZSWDFQaUVSRVQwdFB4UWxsNkN6N1JXc0hv?=
 =?gb2312?B?RmdpSTdkSk1sUldoWis2ejJ6R3RQM1hHVWRsNmhnZnl1SUVlUVlxQUYwVnFN?=
 =?gb2312?B?UEoyR1JmaHRlWVFIZzN0MFo4S2s5NHAzenB0SHhtOWsra2VsQlE5c2RLeFU2?=
 =?gb2312?B?S0lhb2djOXowMS85bmdiMGdxNzRCZnNrdFArYWI5bGwzNllXUkZJMVRjL3Rk?=
 =?gb2312?B?R2pxYnJQL05SUURvcmtDSGtsSnhQeE8yVnFoRm9pL0ZnYmVGVzZ2U0JHcXVF?=
 =?gb2312?B?VDQxeFQrMUJuK2dRN1V3bFBFY3ZnMjllREliTWN1WnV2aHZ5bGJ1eTFhRkFl?=
 =?gb2312?B?dFpnWWh1di9KSktveC9Ba1liTWVFM052V2ZtZkNFRGVjeTY3eGxWNFBxLzNu?=
 =?gb2312?B?cnRuV3VtVE02aWNuenJCbGUwVS8vVWl2Z2p2aysxUHhCL2JLTGZZMVBFZ1l6?=
 =?gb2312?B?eDI2K01wMW5qQi9SZ1RMcnBXM3diMm8vWlFtMmtEc1BlUEh0OHRCaHNCVC9x?=
 =?gb2312?B?T09MTUUydGVPUzdxaEZWakM1YUkxMlJPMVZFVGtLdkl1bWd6N2tiOWNLeWxn?=
 =?gb2312?B?QWJ5UGIwVERSUE5keFhWdTdJWWZQekI4eUk1K1ZlM0N6YllVbEJkRmlhU0V1?=
 =?gb2312?B?a2h5YVhzQmNXWTlaV0xrV1k5Umw0S0loVGNUWUtFZzQxV1JlOUVZU1daYXpz?=
 =?gb2312?B?RUpyZG5OTGQ2N2hpazh6SytuSnBmY2FlcEZudUs0RGE2dVFUd05Ub3FSTTFx?=
 =?gb2312?B?RDhOcjRwdHhpUzBoeHdkYUZoUVo4ME9mY3Biam1tT1FJaFgyV3hIKzBzK01V?=
 =?gb2312?B?eERYT3Q0YmlXR3ZiOGhiM3JUQ2pDTE5lZEhhTDBiWGpaTVRmWmNCek56T2hv?=
 =?gb2312?B?RVEyaUxXeXlEbVpmUTJqUFFuNzFuMGVkSm9ndjBoMzhyUGlsY3hwL2dIbE5E?=
 =?gb2312?B?Z0FuR3hHb2duSi9DQXZ1ODdhbTd0U09KbTdtS0hSL0FodEFhVithWVJyeVI4?=
 =?gb2312?B?ay8wandlTk4zYWdVMmZySVBiejZOeUVyZzZKM2hjcHZ6b3pxSUpXL0E5MHhu?=
 =?gb2312?B?bHBRK1NMbEJ4MSs2YkRiVGtNNmtZZy9od29Ha1pUOC9uNWk3VDU1b1czSE5q?=
 =?gb2312?B?cmJrNWtSNFhGL3JnZEVFbVU0NVRJYjRPTlVpck9yMmNFcDR4ZDRQZ3ZPSVkr?=
 =?gb2312?B?SjdKR2dyYjZzZUZsQ3ExenE0Q1RHOG9McEtMUk5Nay9BTTBFWm5CUWpTOUNH?=
 =?gb2312?B?M3psaVZsWDEySVNwS1pkZUZnazRFL2dNZ2oxOW81dlFtK3ZvMlZpanhLMEhU?=
 =?gb2312?B?cTJENk96azhhZ1pYbTVJQ0FyLzZGZkZQMitXc24vS3VUeDEybG1mUTdLSXZ3?=
 =?gb2312?B?cjVrOC9yMlE1TU5QWHVBSVVkeTVyVHY4ZWVia0JveGpWVEFLK3RoWkZTV1BY?=
 =?gb2312?B?QUJXYXJ1YkNCbjhsdW1ySnRSeDBqOTVrZSs1cnFORHBTSW50SHAxNFNCditv?=
 =?gb2312?B?bzhCa0lZQUpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4726.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dVdNZVFGQ01rN0ZXK2dySUJWUnQ3b1doUlYwWVA4VlNJaXFOZTgzUW8zZmd3?=
 =?gb2312?B?L0hCbXZ2Q1J0SkN3MXBkRkZZRU5vM1hSYmU2NFJKUEhJeVh1eXQrZkljNDBZ?=
 =?gb2312?B?Z1NmRHFuVlRXSHo3TkU2YWFHUERubEZFWGdZS2xpWmlFUjFzcHpFR3hKNitI?=
 =?gb2312?B?bTBpNjJldUxWZHdRMit6MUV3NlVEb3QyVXNxbnZ1VVJvU1d2bExzYzNyeTh1?=
 =?gb2312?B?S3FwNkpNcndDSzZtVFVFUGloNzN6ckREdkFDbGtWaTV4SittMjE5V3I3Yi95?=
 =?gb2312?B?akJ0N1VQUGhkYWYxZGhEbkZvUTc1dFEwQk5xb1FuTlg5cVI2Z3lnYklIQWJM?=
 =?gb2312?B?bEFFNGl0ZHhRUTNxdVErRkt3amI5RFlhVU1MWnE0SGRlUis5QzRseFlybWc0?=
 =?gb2312?B?Mnd6ZnpYVzh3c1c2VnozL0xoMlgydmowc1FXT0tTWGMwbVVWeGlrN3cweC9H?=
 =?gb2312?B?SFFhVHZXa1haS2pyNWFNdWRBYlVVMkcyUkdhcWFqYVQ5c01IalhCWjZ0ckpw?=
 =?gb2312?B?R3M1MXErOHd4RkFTNmF5M2tsTzYxNEtrMHRHTnRnaUxJb29yV0xBN3lYenlH?=
 =?gb2312?B?QXdHUEFaUmxMenFjWHYyQ0VjRUZaanJ0VExxbXpMSDZGYmRFS3NrOWNwTy9J?=
 =?gb2312?B?Ni85VTBjM1QzUUZkYk1DS0IxdFYwdjhTekRhdnlsNnorRGlCUVJzelVpOHFh?=
 =?gb2312?B?aXJNbExaT0dUSmlyQjlTOGZIQWlnT0twY0tUamE1ZndXcTU0bDBaNzc4S2E0?=
 =?gb2312?B?QlIxMnlLQ21ncnhkMjlWVGFZdVpXL3ZDMVdXb2hsUi8zUkI3eXAzd2srT1FO?=
 =?gb2312?B?NWlkcG9YbmEyR0JleEh4N1hWcTNiQXBuV3FoK3V2SXFWYys2NjNRN0xKMzZR?=
 =?gb2312?B?bkNyK1o1R1M4T3lxRm1KVlhMbkl2SHFtOXZ0dFc4VVpyeG5ZcTBvV3VvRE1L?=
 =?gb2312?B?TDhxT0JqcWczaWxHaEtzUCtHbi9XOS9rUDZRaVlPQTU2ZXZIQk5KWEE2QWRG?=
 =?gb2312?B?QndQaEI5ZlR3RW8wL3p4cEUxZTVQZHZxM0RZL2t4UmgwdWg4TGxDS0Q4bjVo?=
 =?gb2312?B?WDc3MDJIbUMvbDAwTXAxcjZHTlMzVVJNdWF3aU5LdnF2dExEYkM1QzZrTVVN?=
 =?gb2312?B?b0pydmo2NGRPUFVtazliV3lJU2xvM1V3OTRQdXpXcDBqOHIzcDAvUjFvNS95?=
 =?gb2312?B?dGU3RlJQRDRQR0pZOXlqamZSUVplS0NDNGR1elpzZHpldmRpTS9kVjhJWmFv?=
 =?gb2312?B?MjM2Q1JZamFVK09zUFFhZHYrVmJETy9peWplU1BGaWhzdVVyM2VtR1V3N2ln?=
 =?gb2312?B?MFNwSUJGa2JzRThKZlcyNVJXZGF1eUF5TmszZ3VlMG5LU2xBRU5HM0NRbTJK?=
 =?gb2312?B?MXByTTVLbENNSm9BUXR2SHZkY3YreSsrdGVoWXNBRmk4SnBhb01QNmJtQmxy?=
 =?gb2312?B?N2ZydTR3YWpnMFNyMDR6QzN1aENxTnVEVUtic1Q1emJFeisxNURFRStPSmRa?=
 =?gb2312?B?T2JSSHRBZUtJdmZidmtRSTJOOXA5WmhsQmdUUXV0akcvNnJQYWQxMjQ0WlBH?=
 =?gb2312?B?UjJMMldwZ0h2UlR3TGg0SksrbmNmNEhaaHYzNlR1Sm1saytHUUYyekcxY0lJ?=
 =?gb2312?B?N0ZJdzBrb0NnSWRKUHhOWmJVaUQ4bXBvSG0yWjA3TFUvMXdwMTB0enM4d0dq?=
 =?gb2312?B?TjRrQ0l5c2pjam1SK2ZvSzNYRFd3a01rS1VBbitZZ2dJc2pINmk2QndmOWp4?=
 =?gb2312?B?dXVWNEh5STd2dXdaVGEzMnhySFpuK0pHcEIrS2pvZ21pYXhNWUdYUDlwdDJs?=
 =?gb2312?B?dGViNzVpZGtTN2lwVEg0UEhlUktiNEp0WFhvRG9XZ0FXVnBIa2VKcjN2VGxj?=
 =?gb2312?B?cVQzbGxaY2xQSTlTRVQwM0tsRE1VUlhoZkZFakh6TlpYY2k3a1dORW5najhn?=
 =?gb2312?B?MW9pY056S3FNZXBpMGcxVGppQW1SUXdVcXVWaUhOejFUT2Y0TWZ4SExWdk1V?=
 =?gb2312?B?SitUalMwYUJMSzkvODFXbnRKL3c5Qk05b1ZuOW1BaUJybU5BczV5bnRGQXhV?=
 =?gb2312?B?ZU1LdXlLNzVaeVpxN0x2ejc4Tkc0Ky9NK3ZYYmx3QjZHRmRvUzVxcU1BSmlu?=
 =?gb2312?Q?wDok3MYVbN6tct3OvxhKJ2lIP?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4726.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d467b3a-70d4-4175-60e1-08ddaa7685f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 12:33:38.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/4ScNOh4sgNdmmkiXVqM+S3uwG94Q2Y/PzBzz+3lorE9Zdb7G1KoC5p4vZUj0CIxOF1/eA0s0ndxUcTn65XbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5420

SGkgTmlrbGFzLA0KDQpJIGhhdmUgcmVwbGllZCB0byBCam9ybi4gRm9yIHRoZSBuZXh0IHZlcnNp
b24sIEkgd2lsbCBzZW5kIHRoZSBwYXRjaGVzIG9mIHRoaXMgc2VyaWVzIHVzaW5nIHRoZSBjb21w
YW55J3MgZW52aXJvbm1lbnQuDQoNClBsZWFzZSBsb29rIGF0IHRoaXMgbGluay4gQ291bGQgeW91
IHBsZWFzZSBhbHNvIGhlbHAgcmV2aWV3IGl0PyBUaGFuayB5b3UgdmVyeSBtdWNoLg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpL2MzMWMzODM0LTI0N2QtNGEyOC1iZDJjLTRhMzll
YTcxOTYyNUAxNjMuY29tLw0KDQpCZXN0IHJlZ2FyZHMsDQpIYW5zDQoNCi0tLS0t08q8/tStvP4t
LS0tLQ0Kt6K8/sjLOiBOaWtsYXMgQ2Fzc2VsIDxjYXNzZWxAa2VybmVsLm9yZz4gDQq3osvNyrG8
5DogMjAyNcTqNtTCMTPI1SAyMDowMw0KytW8/sjLOiBIYW5zIFpoYW5nIDwxODI1NTExNzE1OUAx
NjMuY29tPg0Ks63LzTogbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBtYW5pQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9y
ZzsgamluZ29vaGFuMUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBbUEFUQ0ggMDEvMTNdIFBDSTogZHdj
OiBBZGQgZHdfcGNpZV9jbGVhcl9hbmRfc2V0X2R3b3JkKCkgZm9yIHJlZ2lzdGVyIGJpdCBtYW5p
cHVsYXRpb24NCg0KRVhURVJOQUwgRU1BSUwNCg0KT24gVGh1LCBKdW4gMTIsIDIwMjUgYXQgMTI6
MzA6NTdBTSArMDgwMCwgSGFucyBaaGFuZyB3cm90ZToNCj4gRGVzaWduV2FyZSBQQ0llIGNvbnRy
b2xsZXIgZHJpdmVycyBpbXBsZW1lbnQgcmVnaXN0ZXIgYml0IG1hbmlwdWxhdGlvbiANCj4gdGhy
b3VnaCBleHBsaWNpdCByZWFkLW1vZGlmeS13cml0ZSBzZXF1ZW5jZXMuIFRoZXNlIHBhdHRlcm5z
IGFwcGVhciANCj4gcmVwZWF0ZWRseSBhY3Jvc3MgbXVsdGlwbGUgZHJpdmVycyB3aXRoIG1pbm9y
IHZhcmlhdGlvbnMsIGNyZWF0aW5nIA0KPiBjb2RlIGR1cGxpY2F0aW9uIGFuZCBtYWludGVuYW5j
ZSBvdmVyaGVhZC4NCj4NCj4gSW1wbGVtZW50IGR3X3BjaWVfY2xlYXJfYW5kX3NldF9kd29yZCgp
IGhlbHBlciB0byBlbmNhcHN1bGF0ZSBhdG9taWMgDQo+IHJlZ2lzdGVyIG1vZGlmaWNhdGlvbi4g
VGhlIGZ1bmN0aW9uIHJlYWRzIHRoZSBjdXJyZW50IHJlZ2lzdGVyIHZhbHVlLCANCj4gY2xlYXJz
IHNwZWNpZmllZCBiaXRzLCBzZXRzIG5ldyBiaXRzLCBhbmQgd3JpdGVzIGJhY2sgdGhlIHJlc3Vs
dCBpbiBhIA0KPiBzaW5nbGUgb3BlcmF0aW9uLiBUaGlzIGFic3RyYWN0aW9uIGhpZGVzIGJpdHdp
c2UgbWFuaXB1bGF0aW9uIGRldGFpbHMgDQo+IHdoaWxlIGVuc3VyaW5nIGNvbnNpc3RlbnQgYmVo
YXZpb3IgYWNyb3NzIGFsbCB1c2FnZSBzaXRlcy4NCj4NCj4gQ2VudHJhbGl6aW5nIHRoaXMgbG9n
aWMgcmVkdWNlcyBmdXR1cmUgbWFpbnRlbmFuY2UgZWZmb3J0IHdoZW4gDQo+IG1vZGlmeWluZyBy
ZWdpc3RlciBhY2Nlc3MgcGF0dGVybnMgYW5kIG1pbmltaXplcyB0aGUgcmlzayBvZiANCj4gaW1w
bGVtZW50YXRpb24gZGl2ZXJnZW5jZSBiZXR3ZWVuIGRyaXZlcnMuDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEhhbnMgWmhhbmcgPDE4MjU1MTE3MTU5QDE2My5jb20+DQoNCk5vIGNvdmVyLWxldHRlcj8N
Cg0KVXN1YWxseSBmb3IgdGhpbmdzIGxpa2UgdGhpcywgaXQgaXMgbmljZSB0byBzZWUgdGhlIGRp
ZmZzdGF0LCB3aGljaCBpcyB1c3VhbGx5IHBhcnQgb2YgdGhlIGNvdmVyLWxldHRlci4NCg0KDQpL
aW5kIHJlZ2FyZHMsDQpOaWtsYXMNCg0K

