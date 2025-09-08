Return-Path: <linux-pci+bounces-35623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C2B48286
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C6C1794AF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D753B7A8;
	Mon,  8 Sep 2025 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="nIpvHvOJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46198EACD;
	Mon,  8 Sep 2025 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297772; cv=fail; b=Jn4GEn3CvLImVtNQ2slCY+C8dZy1tk4tp/tezOr0QKlzvHBMNj21p5QkER74LYj9Xkt1o2uvNFgmfOKJYwck/uk3sJp2efaejOvxZafxfg/EGLnrAScGUDaqLPwtJ7OVkKCedEanATv7JH29X9FZtZ4k2WZwT7RApBgwy5d7n2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297772; c=relaxed/simple;
	bh=bmtEjXH3mt9acBTimRijJ8S1Gid58O7u23rlaCeW4/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BKh2ao/MOvqA3+odknjWcXWArT00IgQBPX/nNMsRtz0buQBQMnn7y4ygVNxRTULaNVdiSwDlu3khJS73Pf8S88/3jON7EB3INIFeqer7fPGOYqIk7a3SUnXBd8rrSLFK0ZWwUtywm/sgx2gZH4p7veF1VethBQj3nUYORf6CeKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=nIpvHvOJ; arc=fail smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 58811kxD3351269; Mon, 8 Sep 2025 10:01:46 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1757293270;x=1758502870;bh=bmtEjXH3mt9acBTimRijJ8S1Gid58O7u23rla
	CeW4/s=;b=nIpvHvOJN2ID3A0uM7F/QqRdOYXwiVMWyQPSFQYh2oxLjaI6++7K2VZyLqIQSQNIgtl
	5V4tKYOqcb/iLqKJtH64xo/X9WLiAZOxxL+t4G4Auz7W6ijXvX8QqGup2rWUqsv/cumgvXBHv3BKg
	C5BJ0Kif0XoTV0y7pm6GQ5SF8sycCzmrHHBV4YJzgXK/pfVAHkShiTDorjfAdee7WCYCTih0REr8O
	TCN352/ZMmIOz+Fe4BQXQBjMOwMGCr/12Hm2Emmwc2fLsTMKrwHUmybr4IKZMmH8ps6M1LwYJWees
	9DRtKQINopwacDXZVOs7BUDxh28SbtRSfVOX0Oqw8tFA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 588118Tg733879; Mon, 8 Sep 2025 10:01:08 +0900
X-Iguazu-Qid: 2yAaS2H4MfQGG4DReQ
X-Iguazu-QSIG: v=2; s=0; t=1757293267; q=2yAaS2H4MfQGG4DReQ; m=A2oYwZGOxJrNlXnVOFgn75C/v2oZOmcWjRUsaXUDSCQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cKpYH23r7z1xnZ; Mon,  8 Sep 2025 10:01:07 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKHXwzW+4lkssxhr+EpRgK8Y3UPW+qdyFJ+5b8jG3Y43vlSWtkDj/T9ycttqS9TTbRIOKlwTJ6mqCRjyDt8TZMOjjpS084WVFU/CBhqpVEN9EcHSeeafSXFspGCIKZCNwpQpknWUHRkkAL+RSpZ15Ue+z2mZ5oo9ONPWOhJmvUAjcooSZxPuJD90OcH+ilvTNb/52va74+eL5fPQHCKXx/TjWzpjwNvoOwI1KG/nqp4nP+gippNLC+PACxD6W0nK8CXumDhIjg1ONGvV6ZYMalw4lXVGHse6f7WeOgLoYAxEzH+CiKIEKuuhkuEOjOspzucg6xRiNIArGuem4uoGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmtEjXH3mt9acBTimRijJ8S1Gid58O7u23rlaCeW4/s=;
 b=pmw4ZvCR3zvEHSQxVV5V3XwLDcb/wOF2JkorLrTUZMDiSUsRsCrABZO4wSAsBNjE7Cnf/3eXw3ArteprU3YIBtwSF/xFNIuni6c8TT+8vZYfqqpN1lUQnN+0ZmD7bnk01AjK7UD7emYrEGx64PtGzxd2cFOlvGw7GEs/1+F0hs1OU3v/JfaSRaOvb7Tc2tAG0FsnZd5yI0tv+w3Hx8QPZ3joDBsYYIWju3df4BG4FEuX3rgMAzhVsseUwWbt3hGP6QbzjmUz9FJo6xNh/uyFUMoaXbl4d71GjDsyGzkszmktsubzqhREZeK6GjUcPue5RjkRRZSKSx+H+xJkg9OJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <Frank.li@nxp.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <bhelgaas@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <yuji2.ishikawa@toshiba.co.jp>
Subject: RE: [PATCH v2 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges to
 reflect hardware behavior
Thread-Topic: [PATCH v2 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Thread-Index: AQHcBarazpq0F6xHgUiMA0HAnZU0NrRURRcAgDRnUmA=
Date: Mon, 8 Sep 2025 01:01:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C811C01699A6469CA307CD0CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1754358421-12578-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1754358421-12578-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <aJI07hBmKNrsGFv9@lizhi-Precision-Tower-5810>
In-Reply-To: <aJI07hBmKNrsGFv9@lizhi-Precision-Tower-5810>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB11111:EE_
x-ms-office365-filtering-correlation-id: 61c3fdcc-83da-44e2-e0c2-08ddee732fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WnROUEhadUF2R0VDaXE5UGh6OVRmemw2VFdxT1E3MCtOTmtPRldXVktJTXdV?=
 =?utf-8?B?REl0TW9oL3B0Smx0VmlMaEErQ1lxWnd2WUVqZ2U5VGhUOWYxejFEU2VxM2RO?=
 =?utf-8?B?WmVoZlZ6Wkw5dmlHMm9uSTEwOWd5SmtpTkdlOHFRREVGSWhmNHRnSVNDbk5w?=
 =?utf-8?B?OFBicVNPd0lDdWRPRGRNZzFVYVFpZlA4U0M5VXRSamJXL1ZMZ0ovdG5sTW5F?=
 =?utf-8?B?TlZWbDBISEU3WGp5djZFNUtGM2lSMytjSXRWRFowaFI5SDBOUG5BbCs5SXFZ?=
 =?utf-8?B?OVh2WUlZdmI3Y1Q4eDZLME1OVXcvOTlHcFNwdVFxcWxmQkdDRHpoY256eFky?=
 =?utf-8?B?V1RGUkFxekYwUXJ5TGplbmlJU2c1K1duUVp5aW5IMzFHM1VvQWx3OThSVVg5?=
 =?utf-8?B?SnhmQTVEV0Z2dmxEcEpLRUh3UG52ZEhYWXJXRlpZWnBpbHQyYWJycXNlZ0Fv?=
 =?utf-8?B?Qld1VFd3MThyNzlJSjRmVk5kRCtiMkxDRjV3b3FUT3dVZ25JSmthVGovTlFI?=
 =?utf-8?B?bXhJdWNDYzl0anRydmxrOTRQQVFjalE5WEgwWkh1aFlrMEpnaEZQRWVtcTcw?=
 =?utf-8?B?RXlTc216Wjh3T1RCbTRLaVJNL2JaZUs3Ty9uZUpubHpZeUV1QVhlVDBKeGRI?=
 =?utf-8?B?cCt2TTRpZFRZNEpuYmx2ZkVRZzFma0NJa3FyYkNodTFJdWNaNHlmZXdEQXRl?=
 =?utf-8?B?NmdlajBORVgzaTluNGduZHdyQkVwM1pRY1QrK0h6bWpHV3ozSTdaVjlOTERa?=
 =?utf-8?B?Z0craVZXQmQ3eWEzVm5YZ0xoTmRtamNtOFFKN1lUWW5Fa25rU085Y2NZWXht?=
 =?utf-8?B?aCszMjJCbGpSZlY5Z3R5eGpld3FEUVdTcmwycmg0U3dHME43REVkVllkRmZm?=
 =?utf-8?B?d2dkaFYyREhkVDlheHNtS01BRC9LbHFRTmVzQkVNaUVySnVuZUtQemluejJD?=
 =?utf-8?B?Z3BwdEEzMk5kcTJnS2x0MThycFdsNEQ2Nm5TaTFnMS9YTmlMcFJTcWlvWm9T?=
 =?utf-8?B?VEpYTHVtdWdSNU45LzhNSkVubnhlc01WM2VUendNL1dSb2h6RVdpSEJrU1l4?=
 =?utf-8?B?QTcyUTVUOHQ0cllvaVk1MkVVUnZGYzBLd0FHbjhUckhaMzRFbGE1UHlpcVNt?=
 =?utf-8?B?OGdqM3F6K1VSRTJ6U0dPNDZpam9JRkdmVmc5cjdIRDB2bVpEZ203V3l1MWdC?=
 =?utf-8?B?UDdkaFBQMTNRU0ZGV0JpdkFiaUVnVzBoWlljZTNHdGxjVVFlNGtNRVJKV1ZE?=
 =?utf-8?B?WFdPRnBtcTFrZ0J1SDNCWWE1RXFMUGhNYzR1ZTJoeHVKa0wvMXNRWXg5Qy8y?=
 =?utf-8?B?RmRObnh2Z1R0WkJPaFVLZWhrQ2lPOHhnWC9mRnljSEQvQnp6dGVIMHFYSld5?=
 =?utf-8?B?bm9LNFY5ejVER0VFdDZreDNPemRHNCtId2pSaWh6UGwvS0Y4TExXV1JWSXZT?=
 =?utf-8?B?UGYxSXVoTXpPZVFaRnRMN0xIMlozUTc2Ry9VZEtpR3N4bE90RS96czV3RitO?=
 =?utf-8?B?WW1oMzFieS9uL0FzbnVJVWEzdmxvS1poSUhSbEEvckVDWDBXWk9PZGlQblpQ?=
 =?utf-8?B?RUpEcFhWM2Z4bFkyWVk2MGlnbk1maExrOGViRzFXTXRFS3doc1BZamI1VXRF?=
 =?utf-8?B?K09zQ0JoV05JdVRjbHgzcGE1cTlXMk4vZWZ1VWJBVitZbHFBOE9BZkx2ckNZ?=
 =?utf-8?B?MU1XY2RWWWlVY2hEQlFZRXVHZDhwSlAydjR1cVBhc05MR3BXLzdHaDB2ZXlD?=
 =?utf-8?B?MG9rbUFBQ1lvL3l1Z3ZLOHdJNlJxaDFHQzJ4eG9nWkVveFpiYVE5S1BUSWtm?=
 =?utf-8?B?QzF5UkE1RXBUdTlSVDBvUGFSVkppeWJLci9XK0NwOGtTampNVmZBSWRXOGJN?=
 =?utf-8?B?T1RmRTd5QVpRSE5MeW51cFhCRmhCTVNqZ2phYlRkaWRLUlhNNW1XNlkvYXRz?=
 =?utf-8?B?VDVQekJDc3ZWMFZXb25KSk5KMVBVN3BRVDMxMHM5WHNoOUJsbUFBSm83L0gv?=
 =?utf-8?B?Q0R4NzFveVdRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a2NuRjJoaTRnUWFFcmJoVmZTRjdJQ2hDOUxCclUxV1RueGJMcXlTU29zTnM5?=
 =?utf-8?B?eDV4K05jTUMza0tRa05FQkdKQkoySS82VW9HWEE4ZnVVdlJTclZMZnZsN01i?=
 =?utf-8?B?QXB6TG1QQnRxY2diYk1DSWVMejhCZnZDV1U2TWs2YUZhd2VQWDVZNVpJRXdl?=
 =?utf-8?B?WlRDOUYvZXZWcG1IRTM3WkxEaTlyL3A1dHlEZVV1bVVXTVRFb015cGUrdzlV?=
 =?utf-8?B?bW00SE1DdW1xWEpTMjA5RHZvWFVaYlh4dm1TVWlmdm04L052cGkvZzZUd2NG?=
 =?utf-8?B?eXdxazM4Uy9RZWYzZzYxNnBSM1RSeGo5STNlb2ZZaEVSZXJuQ1ovK3JQTjVQ?=
 =?utf-8?B?ZTBBTXE2Z2s1akx5K01ic3ZsWmdCYXpSWkFKWlh2NEVMSFlMQ2FWSVR5aTgv?=
 =?utf-8?B?YkwvMHJsRWswcys5THhTaUdGUkFheWttWlN0ODkxaGNBME1RM3YvNHNRU0NO?=
 =?utf-8?B?RTBDQlRlSHpIb2VFS0hkMlpaOTdhMDd1cE5mcmlKNEJoZFhjTlFScXEwVGdw?=
 =?utf-8?B?NHZEck9DSGh1ZzUrVEZnOG51SWFHRDZOTUJmVzBGNHNwakw2SCtsVXpTNmlK?=
 =?utf-8?B?K1p0Q1ltcU5zd2phSm96R2p2RDl6c2Y5TGJZNWdWMFV6OUJSZEZHa0pUdUZn?=
 =?utf-8?B?Q0dmSndRNkZXV1ZMc0hsTjVreXVBWGtFK0RsWGNvcHNHQ2xxZmhad0o2Q3Z6?=
 =?utf-8?B?T2NDblI4QXNQaERnajRzRnpCVGZrMGRGcnUySzVQcjhXSnVkcnpGM1ZEVkV0?=
 =?utf-8?B?bTNOOFgvSXU0VzFtUXRCQXlIWnBmYWF3a1FibWtTUHROUmlSeUxxc3hPKy9V?=
 =?utf-8?B?c2dZQmw5czdyN0xpTk1vejQ4WG4vQ0tVOEY4alkzaExHQVI3TTV3eGtFaENL?=
 =?utf-8?B?UzBFalpOR1hjT1VpWnEvQ09tUGtRUmh6S0RnN0hobXJ5aUVDc2dnOEZrQjRj?=
 =?utf-8?B?Y3RWSXVWdElPOHIrUTZFQ0lzeEQ4dkgvZ3FVaFo3UDFoL0JLWXM0cHoxditx?=
 =?utf-8?B?c1NKU3kyWHVWZytjSmRyNlFQbjltYzg3akNjeTFxZUtFRmxmdDRFNUVwK0V4?=
 =?utf-8?B?bmZhRkMzTmJicUxuY2srTHBQdDEzNDJqM1J0TkFIUmp2NjZuYnMzc1VYNWs2?=
 =?utf-8?B?b3dKbDVkMFpmUHRYQ0N2SllDd2hmdkNPZ3k0bVlVK1NYZU5iMVd5d05qbmdk?=
 =?utf-8?B?VExxcDBHaVBaUklJbk5ueVdJSGZDbXJlTVBZL3kvUkZBSHpWRGtveGE1UDND?=
 =?utf-8?B?ampYbGtQZkJPZzJISURWNWtzR05lYm9KZzJSeUhPM2lCNHhkV29RU0ljUTJF?=
 =?utf-8?B?dVoySE1OU1h5b2hLTDA3MEVjRE0xK09VVFE0VWp3bk1jRjhCNGhtK2l4MHd0?=
 =?utf-8?B?YXA5KzIyN1JKaWI0UWhqYldSd2swbjhYa0daVjMycFpGaE5FcHdSd0MrK0pF?=
 =?utf-8?B?RVdtaGFOU0I2OWRFQjJCOUVpdTM4SGQ2V25TWGR6SCtlV1A2Z2J4NjNRV1NY?=
 =?utf-8?B?RC94Q0k5ZnBnWTNUR0lFWXF6NHh3UlhpdVJISDJzdmY5aHNkUnQ5Nk5zSEhD?=
 =?utf-8?B?VURaMHVpM0JRekRXa2pYeFZaV3RsZkFRZm1kNkZoU1BibExnZ0tDYnJYS0pL?=
 =?utf-8?B?Snhkc0huN1FBdFZUZEM5RXRjV0NRTE0xdEpOODRZbU10UVZrQlUxaVlSM3B0?=
 =?utf-8?B?MGZjbDU1T00vb2ZtQkEzTGpYWG54bTFHOFZDSDFMMGljTWFYNjVpS0w5TEYv?=
 =?utf-8?B?dmRJWWpLQkZ2c3pKS0dscFJtbk96b25Rb3kvSG9lMks4SlpjejhBemlWcWY1?=
 =?utf-8?B?amlBczhHdXd0bFJuYlBiT0pUN3ZUT0xGcW4rdUN4TmVMcWpsYjJmTGtoMks2?=
 =?utf-8?B?MkxKYVJ3bWh6WVR5OTBtUE5KZjJBSG9adG5KdVlUN2RhRWFGeWs2b0F2NzlN?=
 =?utf-8?B?aTJCY294Nldpd0FyMy95RDdTQ05IQkRrTVlKcnpiK29lZkNTV3I2WmFqZ05T?=
 =?utf-8?B?NFNxdFdCTjkxSVB5VWx2RGxQTUpzazJyeHFFVTZTRUQ4NlpXMGpkVEpESmd1?=
 =?utf-8?B?d25MdjRnOXlNUDJkSTlBTlhYaTVCWlJaVVdVTXc1UzBIVkxZYVhjaHlZMHJj?=
 =?utf-8?B?N3VDYzFWVkRzZ3BvVVRnZHhvaVd3d3JHVUVrcmR5anZzdDZOYkRUUzVyWDU3?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c3fdcc-83da-44e2-e0c2-08ddee732fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 01:01:04.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmQwun7GRWfpIKGqWABMhdXpg6xTs79VcEcH/k4c6D3vw8RoIu10Tb4GcX91K+5WoHtolLqiW7W7Y3GpBPTJ4s8thHzCZXZhNcZOSSPPiThiTEREXkCy0rFsisMdNFi4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11111

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8RnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNiwgMjAyNSAxOjQ1IEFNDQo+IFRv
OiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8
sO+8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBDYzogcm9iaEBr
ZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwu
b3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBpc2hpa2F3YSB5dWpp
KOefs+W3nSDmgqDlj7gg4pah77yh77yp77yk77yj4peL77yl77yh6ZaLKQ0KPiA8eXVqaTIuaXNo
aWthd2FAdG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGFybTY0
OiBkdHM6IHRvc2hpYmE6IFVwZGF0ZSBTb0MgYW5kIFBDSWUgcmFuZ2VzDQo+IHRvIHJlZmxlY3Qg
aGFyZHdhcmUgYmVoYXZpb3INCj4gDQo+IE9uIFR1ZSwgQXVnIDA1LCAyMDI1IGF0IDEwOjQ3OjAw
QU0gKzA5MDAsIE5vYnVoaXJvIEl3YW1hdHN1IHdyb3RlOg0KPiA+IEZyb206IEZyYW5rIExpIDxG
cmFuay5MaUBueHAuY29tPg0KPiA+DQo+ID4gdG1wdjc3MDggdHJpbSBhZGRyZXNzIGJpdFszMToz
MF0gaW4gdG1wdjc3MDggYmVmb3JlIHBhc3NpbmcgdG8gdGhlDQo+ID4gUENJZSBjb250cm9sbGVy
LiBTaW5jZSBvbmx5IFBDSWUgY29udHJvbGxlciBuZWVkcyB0byBjb252ZXJ0IHRoZQ0KPiA+IGFk
ZHJlc3MgcmFuZ2UNCj4gPiAweDQwMDAwMDAwIC0gMHg4MDAwMDAwMCwgYWRkIGEgYnVzIGRlZmlu
aXRpb24sIGRlc2NyaWJlIHRoZSByYW5nZXMgaW4NCj4gPiBpdCwgYW5kIG1vdmUgdGhlIFBDSWUg
ZGVmaW5pdGlvbi4NCj4gPg0KPiA+IFByZXBhcmUgZm9yIHRoZSByZW1vdmFsIG9mIHRoZSBkcml2
ZXLigJlzIGNwdV9hZGRyX2ZpeHVwKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiBTdWdnZXN0ZWQtYnk6IFl1amkgSXNoaWthd2EgPHl1
amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTm9idWhpcm8g
SXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiA+IC0tLQ0KPiA+
IHYyOg0KPiA+ICAgVXBkYXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+ICAgRml4IHJhbmdlLg0KPiA+
ICAgU2V0IHRydWUgdG8gdXNlX3BhcmVudF9kdF9yYW5nZXMgaW4gcGNpZS12aXNjb250aS5jLg0K
PiA+ICAgbW92ZSBwY2llIHVuZGVyIHRoZSBkZWRpY2F0ZWQgc3ViLWJ1cy4NCj4gPg0KPiA+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEvdG1wdjc3MDguZHRzaSAgfCA3NQ0KPiA+ICsrKysr
KysrKysrKystLS0tLS0tLS0gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdmlzY29u
dGkuYw0KPiB8DQo+ID4gMiArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygr
KSwgMzAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy90b3NoaWJhL3RtcHY3NzA4LmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdG9z
aGliYS90bXB2NzcwOC5kdHNpDQo+ID4gaW5kZXggMzk4MDZmMGFlNTEzMy4uYjc1NDk2NWE3NmNh
NiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEvdG1wdjc3MDgu
ZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdG9zaGliYS90bXB2NzcwOC5kdHNp
DQo+ID4gQEAgLTQ3OCwzNyArNDc4LDUyIEBAIHB3bTogcHdtQDI0MWMwMDAwIHsNCj4gPiAgCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gLQkJcGNpZTogcGNpZUAy
ODQwMDAwMCB7DQo+ID4gLQkJCWNvbXBhdGlibGUgPSAidG9zaGliYSx2aXNjb250aS1wY2llIjsN
Cj4gPiAtCQkJcmVnID0gPDB4MCAweDI4NDAwMDAwIDB4MCAweDAwNDAwMDAwPiwNCj4gPiAtCQkJ
ICAgICAgPDB4MCAweDcwMDAwMDAwIDB4MCAweDEwMDAwMDAwPiwNCj4gPiAtCQkJICAgICAgPDB4
MCAweDI4MDUwMDAwIDB4MCAweDAwMDEwMDAwPiwNCj4gPiAtCQkJICAgICAgPDB4MCAweDI0MjAw
MDAwIDB4MCAweDAwMDAyMDAwPiwNCj4gPiAtCQkJICAgICAgPDB4MCAweDI0MTYyMDAwIDB4MCAw
eDAwMDAxMDAwPjsNCj4gPiAtCQkJcmVnLW5hbWVzID0gImRiaSIsICJjb25maWciLCAidWxyZWci
LCAic211IiwgIm1wdSI7DQo+ID4gLQkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gLQkJCWJ1
cy1yYW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiA+IC0JCQludW0tbGFuZXMgPSA8Mj47DQo+ID4gLQkJ
CW51bS12aWV3cG9ydCA9IDw4PjsNCj4gPiAtDQo+ID4gLQkJCSNhZGRyZXNzLWNlbGxzID0gPDM+
Ow0KPiA+ICsJCXBjaWVfYnVzOiBidXNAMjQwMDAwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0g
InNpbXBsZS1idXMiOw0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiAgCQkJI3Np
emUtY2VsbHMgPSA8Mj47DQo+ID4gLQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4gLQkJ
CXJhbmdlcyA9IDwweDgxMDAwMDAwIDAgMHg0MDAwMDAwMCAwIDB4NDAwMDAwMDAgMA0KPiAweDAw
MDEwMDAwDQo+ID4gLQkJCQkgIDB4ODIwMDAwMDAgMCAweDUwMDAwMDAwIDAgMHg1MDAwMDAwMCAw
DQo+IDB4MjAwMDAwMDA+Ow0KPiA+IC0JCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjExDQo+IElS
UV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+IC0JCQkJICAgICA8R0lDX1NQSSAyMTUNCj4gSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQo+ID4gLQkJCWludGVycnVwdC1uYW1lcyA9ICJtc2kiLCAiaW50ciI7
DQo+ID4gLQkJCWludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiAtCQkJaW50ZXJy
dXB0LW1hcCA9DQo+ID4gLQkJCQk8MCAwIDAgMSAmZ2ljIEdJQ19TUEkgMjE1DQo+IElSUV9UWVBF
X0xFVkVMX0hJR0gNCj4gPiAtCQkJCSAwIDAgMCAyICZnaWMgR0lDX1NQSSAyMTUNCj4gSVJRX1RZ
UEVfTEVWRUxfSElHSA0KPiA+IC0JCQkJIDAgMCAwIDMgJmdpYyBHSUNfU1BJIDIxNQ0KPiBJUlFf
VFlQRV9MRVZFTF9ISUdIDQo+ID4gLQkJCQkgMCAwIDAgNCAmZ2ljIEdJQ19TUEkgMjE1DQo+IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+IC0JCQltYXgtbGluay1zcGVlZCA9IDwyPjsNCj4gPiAt
CQkJY2xvY2tzID0gPCZleHRjbGsxMDBtaHo+LCA8JnBpc211DQo+IFRNUFY3NzBYX0NMS19QQ0lF
X01TVFI+LCA8JnBpc211IFRNUFY3NzBYX0NMS19QQ0lFX0FVWD47DQo+ID4gLQkJCWNsb2NrLW5h
bWVzID0gInJlZiIsICJjb3JlIiwgImF1eCI7DQo+ID4gLQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQo+ID4gKwkJCXJhbmdlcyA9IC8qIHJlZ2lzdGVyIDE6MSBtYXAgKi8NCj4gPiArCQkJCSA8MHgw
IDB4MjQwMDAwMDAgMHgwIDB4MjQwMDAwMDAgMHgwDQo+IDB4MEMwMDAwMDA+LA0KPiA+ICsJCQkJ
IC8qDQo+ID4gKwkJCQkgICogYnVzIGZhYnJpYyBtYXNrIGFkZHJlc3MgYml0IDMwIGFuZCAzMSB0
byAwDQo+ID4gKwkJCQkgICogYmVmb3JlIHNlbmQgdG8gUENJZSBjb250cm9sbGVyLg0KPiA+ICsJ
CQkJICAqDQo+ID4gKwkJCQkgICogUENJZSBtYXAgYWRkcmVzcyAwIHRvIGNwdSdzIDB4NDAwMDAw
MDANCj4gPiArCQkJCSAgKi8NCj4gPiArCQkJCSA8MHgwIDB4MDAwMDAwMDAgMHgwIDB4NDAwMDAw
MDAgMHgwDQo+IDB4NDAwMDAwMDA+Ow0KPiA+ICsNCj4gPiArCQkJcGNpZTogcGNpZUAyODQwMDAw
MCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gInRvc2hpYmEsdmlzY29udGktcGNpZSI7DQo+ID4g
KwkJCQlyZWcgPSA8MHgwIDB4Mjg0MDAwMDAgMHgwIDB4MDA0MDAwMDA+LA0KPiA+ICsJCQkJICAg
ICAgPDB4MCAweDMwMDAwMDAwIDB4MCAweDEwMDAwMDAwPiwNCj4gPiArCQkJCSAgICAgIDwweDAg
MHgyODA1MDAwMCAweDAgMHgwMDAxMDAwMD4sDQo+ID4gKwkJCQkgICAgICA8MHgwIDB4MjQyMDAw
MDAgMHgwIDB4MDAwMDIwMDA+LA0KPiA+ICsJCQkJICAgICAgPDB4MCAweDI0MTYyMDAwIDB4MCAw
eDAwMDAxMDAwPjsNCj4gPiArCQkJCXJlZy1uYW1lcyA9ICJkYmkiLCAiY29uZmlnIiwgInVscmVn
IiwgInNtdSIsDQo+ICJtcHUiOw0KPiA+ICsJCQkJZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiAr
CQkJCWJ1cy1yYW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiA+ICsJCQkJbnVtLWxhbmVzID0gPDI+Ow0K
PiA+ICsJCQkJbnVtLXZpZXdwb3J0ID0gPDg+Ow0KPiA+ICsNCj4gPiArCQkJCSNhZGRyZXNzLWNl
bGxzID0gPDM+Ow0KPiA+ICsJCQkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKwkJCQkjaW50ZXJy
dXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsJCQkJcmFuZ2VzID0gPDB4ODEwMDAwMDAgMCAweDAwMDAw
MDAwIDANCj4gMHgwMDAwMDAwMCAwIDB4MDAwMTAwMDANCj4gPiArCQkJCQkgIDB4ODIwMDAwMDAg
MCAweDEwMDAwMDAwIDANCj4gMHgxMDAwMDAwMCAwIDB4MjAwMDAwMDA+Ow0KPiA+ICsJCQkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDIxMQ0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArCQkJ
CQkgICAgIDxHSUNfU1BJIDIxNQ0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArCQkJCWlu
dGVycnVwdC1uYW1lcyA9ICJtc2kiLCAiaW50ciI7DQo+ID4gKwkJCQlpbnRlcnJ1cHQtbWFwLW1h
c2sgPSA8MCAwIDAgNz47DQo+ID4gKwkJCQlpbnRlcnJ1cHQtbWFwID0NCj4gPiArCQkJCQk8MCAw
IDAgMSAmZ2ljIEdJQ19TUEkgMjE1DQo+IElSUV9UWVBFX0xFVkVMX0hJR0gNCj4gPiArCQkJCQkg
MCAwIDAgMiAmZ2ljIEdJQ19TUEkgMjE1DQo+IElSUV9UWVBFX0xFVkVMX0hJR0gNCj4gPiArCQkJ
CQkgMCAwIDAgMyAmZ2ljIEdJQ19TUEkgMjE1DQo+IElSUV9UWVBFX0xFVkVMX0hJR0gNCj4gPiAr
CQkJCQkgMCAwIDAgNCAmZ2ljIEdJQ19TUEkgMjE1DQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
PiA+ICsJCQkJbWF4LWxpbmstc3BlZWQgPSA8Mj47DQo+ID4gKwkJCQljbG9ja3MgPSA8JmV4dGNs
azEwMG1oej4sIDwmcGlzbXUNCj4gVE1QVjc3MFhfQ0xLX1BDSUVfTVNUUj4sIDwmcGlzbXUgVE1Q
Vjc3MFhfQ0xLX1BDSUVfQVVYPjsNCj4gPiArCQkJCWNsb2NrLW5hbWVzID0gInJlZiIsICJjb3Jl
IiwgImF1eCI7DQo+ID4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJCQl9Ow0KPiA+
ICAJCX07DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLXZpc2NvbnRpLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtdmlzY29udGkuYw0KPiA+IGluZGV4IGNkZWFjNjE3NzE0M2MuLjJhNzI0YWI1
ODdmNzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS12
aXNjb250aS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS12aXNj
b250aS5jDQo+ID4gQEAgLTMxMCw2ICszMTAsOCBAQCBzdGF0aWMgaW50IHZpc2NvbnRpX3BjaWVf
cHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAlwbGF0
Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwY2llKTsNCj4gPg0KPiA+ICsJcGNpLT51c2VfcGFyZW50
X2R0X3JhbmdlcyA9IHRydWU7DQo+ID4gKw0KPiANCj4gVGhpcyBjaGFuZ2UgYmVsb25nIHRvIFBB
VENIIDIuIEl0IHN0aWxsIHdvcmtzIHdpdGggb2xkIGRyaXZlciBhZnRlciBhZGQgcGNpLWJ1cw0K
PiBpbiBkdHMsIGp1c3QgYSB3YXJuaW5nIHdpbGwgcHJpbnQuDQoNClRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcuDQpJIHNlZS4gSSB3aWxsIGZpeCBhbmQgcmVzZWQuDQoNCj4gDQo+IEZyYW5rDQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


