Return-Path: <linux-pci+bounces-22830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FBA4D7B5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925641889547
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E71FAC31;
	Tue,  4 Mar 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Ayho/vpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F81FC7E5
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079712; cv=fail; b=rwJHu4u6LdpF26o44pj1tLXMWGn6XGQaNcsjMR5mGSjac/GKr0LwdmfSmjhpjlPDOK22quHlq41dYL8WwY40nIM7ALwYzjV1KnJcBuiToJ347I0XAtTFdGx4YeKwHW+JsDKi9QeK+y4yGSJpRn/vxjBDJPlsv9QbpSJV01pd4P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079712; c=relaxed/simple;
	bh=JPGTmV6fY4J93uTAwcFfv6iKyJgzqnQ3Dmrcz+7GO28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmnZ7JRB2ntrjFn6bNP2cpxh9tiscO6bnRA5qJiDi6iniosmOb/ke3wuOGxom4+2nsAFLUd4PSGids8CD8zvapk9e2ozD3c372NAHcfdVCgP48T8+IdmSKFMwvr0Evjtz35iRy5tWzXesEqkYO1pSZgOmib/81ikDImPD9hggX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Ayho/vpo; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx6sJGTcTvqi+fepfllwqgvPC1ePncQh23+P3F+/7SK4kODJW7V4lu4VO8KV/1tLnx5b5CBbMHUlmGjFgvYT8FQpEAyChI74PsOMtQOIriwMMhyQLWAEF0thiWz10s+xoeAMuVbMfowahohx763E/zX/yabDpLbHXGxAfljyOT2VTNj4m/XC2TMMLW79h8KVdbUSJ+tZtxxEnR//iqZQgPGYyWqEU39ryeM3iWWFVzmvH8qASaNRQNPm/WpESwNH7u2sEjI/Z2cdZKDJxCFY8JI8N0oFgbbMwPNdGbE2NYEFLcA6iLcbN36tW6vOQWD9Tn/EqrTAD8zTpHdHi4/HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPGTmV6fY4J93uTAwcFfv6iKyJgzqnQ3Dmrcz+7GO28=;
 b=oRVbBRRWq9EbFza/YwLkEVDcWm7tVM4GuLbJLzpdtF28lvR1jG/DjvxlaLG93Pnp7XTFhgbBFCFJ3ZDVg9jb6mAo9uatH5Ec4UCgCM6ftCLFomKtAFOn/Il50alsAjAdMPyN1VoqUZsbk+8c8bjUn7CIV0YnHzLObjCi4YJWPqEVOIeFeoBESOqIYqYT39khM4GbsuXMo+cQADazESwkBamwmUADDXo1h6JqGXBLfwPIjGbfaEhCUpEcnhCJyVJrYYCMhNqRpiOd2lQTfNCE4abGVJQEjXj/44cNhZzti/TeuWoMrMgY2OWqPcZeEMMLV+wssE0IRyJaeRr2qf+ohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPGTmV6fY4J93uTAwcFfv6iKyJgzqnQ3Dmrcz+7GO28=;
 b=Ayho/vpopv9K+5AvDJHhepe+yjafkoyI3+RmbIxQxG/QneuS7rdEE2Dhowhs8FtIVxZs9AVHJIkFddxwKg4btoOnVIuL3BFkwAtw0MgTAL42FkAGKv6QL3tORdIAxX9ThBj/CKvYz0YIcVL8dlxMjRt/Zv8VhE5NMSh9gygZrpSHy5H2l/LRhvVa6FINvixiRs/Y4Dj4aRzL9uwgijPsZJ+lTeWX/rwwjeKMKtx5jUwtF55pCH9yvPsOTWgCXDO8FXesKuZ7/eKBW9lzeUVCjTJUVqblmdqdRELZfEvoHW2FTS+u8WTKL6TJ9Boi/PHKsbLWtifK25oVAly96mw6Bw==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by PR3PR07MB8159.eurprd07.prod.outlook.com (2603:10a6:102:176::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 09:15:07 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%3]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 09:15:07 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Rob Herring <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Thread-Topic: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Thread-Index:
 Ads2njIfwP+JWslVRxGz+DAgijI5nRTcDrYAAAmU4YAAAIn8gAB78UrgAAtyOIAAJEKysA==
Date: Tue, 4 Mar 2025 09:15:07 +0000
Message-ID:
 <PA4PR07MB8838A3BD3588448BF50ED3D4FDC82@PA4PR07MB8838.eurprd07.prod.outlook.com>
References:
 <PA4PR07MB8838D3064B113BA7925ED5BAFDC92@PA4PR07MB8838.eurprd07.prod.outlook.com>
 <20250303155353.GA167309@bhelgaas>
In-Reply-To: <20250303155353.GA167309@bhelgaas>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|PR3PR07MB8159:EE_
x-ms-office365-filtering-correlation-id: 3409350d-d830-4c15-2efb-08dd5afd0e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0hNcHdEM3NLbWEwdW1VSU9abnVBL1psaVpyckJLTmFiaFFMVkMzTm91NGVn?=
 =?utf-8?B?S21OWkwwSTlXZVNDVE9Yd2xoMUljekJyWFNFTHZlSllpVmxoWnJTUXEzOUd0?=
 =?utf-8?B?UXNjeHlubzZpRThRWnZ1bkdIcy9kMW96eldDcy94a3c3N1BUNHcwOTJva2lB?=
 =?utf-8?B?RDFKRkF4Q1JDamdWbjZMQVRjdFdENmZGNmtHcFAzV080d1NESXdNTlh3SFNO?=
 =?utf-8?B?SDB3MUNxam1HMmlFcmxrOHhlallVbTZ0N3lXSFhtSnN1bmM4STVrWlVSWUFv?=
 =?utf-8?B?Q3pSSm56Z1Fqci9kcmE4MjBHTnFQY05hdWppeWhJdXZ1LzVGanV5NWgrcDlY?=
 =?utf-8?B?WGFrQlIwNVZtR3ZpSGQ0Sm9PZ2F0K0RUcTd5S21lUzZ3VWF1cFBJcDF0dlZi?=
 =?utf-8?B?aXdqNThHaWkxN29vQnVkNm5FQ3JuZVgzYVd1Vk1mY2tZU1lOditHVDBWWloy?=
 =?utf-8?B?ZHFGdUFiMTBTcFFWY0w4aG1rLzU4SldaL003M1NvM2ZvSG9PSFVNWjJWSjhn?=
 =?utf-8?B?NCs1djNKUlZiWnZ6QVZ2MVZEK0k3Z05ISEpZUFRSRWdnZVcxYTBVQ1VwL0Y3?=
 =?utf-8?B?bVZxdXM0Y2M4TXN1Y1JMcDFLQy9abWozU2VRV1NUVmRwKy8wT1k4Uk9SWmFN?=
 =?utf-8?B?cGExL3lRMUJBakZHeWtQWDlIOEhUREs0bDhZZlVsYXpFVFhCcW1iditlZXB2?=
 =?utf-8?B?NTBmTjNxaTFRdk5XR0lnQm01TGNrTk1TQW41MWdNSTFrNUNjK05kZ2xveHo5?=
 =?utf-8?B?SFdMcUR0K1N2V3FxZFdNYVNCbjRuYzUyTDRhbm1kL2VxQUptSml3aDJIenhH?=
 =?utf-8?B?Y2gvMjNYaXRlVklVZzhXSG1BOXJMOEtnVTFDcWxxN0dZQ08zQmY3eDc4QVhU?=
 =?utf-8?B?OXl1RkFlUytCNVB6NlJuekZLK3FnVUVabU9ka0Z0RjJ3VWVBcEtxVnRkV3Iy?=
 =?utf-8?B?WFl5MWw4Z0c0UEFKY2VXQWhOSmF1cDJDTzVOaHJjMmhtU0xXTnZSREVrNVlX?=
 =?utf-8?B?eWlYaTVWU2N5czlSTzI0QmoxYUkzTlV5MHNaTG9uRkdURUhpU1Yyc1UxbFVO?=
 =?utf-8?B?QTR2ckpUbm9WR3QwaEpUQmxQV3Q3a0pyL1FEaldjZHduYU1MVnlrVG9VUzZC?=
 =?utf-8?B?eThwbGNPSmVrbTAzdmNlbFE2VCtqdW56d2FzTjlMYXZaZjlVMFNjMW5GajQ2?=
 =?utf-8?B?dUlJTDZtVkR0SmVmdDZJRzZ6NDl2ZGRMVlpENEdjUE1sZUdBSWRtZURMNU5M?=
 =?utf-8?B?WU9XaU9GLzlNaXdoT2lOQ3FTL3NtWWllTzFmdURLYjFOWUIxYU4zeXppWHVt?=
 =?utf-8?B?andBVUNvenlsalMwMCszL2JySWpEcURFSzY4NXJtRG1Za2lPVUlnS3NWcW9Z?=
 =?utf-8?B?V0F4MlhVcVptdjhXejBBVnZGY2N4MXVUNmhac21YVFM0K3FsYjBzRHExY0hw?=
 =?utf-8?B?b284ODlISHFJajRkakhtNkFkbHVGMjRkWmxVUjRjOWpZczhSYWxRRkovVTBC?=
 =?utf-8?B?UHhUWUJCYkl1MHVjL1ZQVnhSTEEyYmo3TTRsalV2M3dZUlRETVBWQy95anlY?=
 =?utf-8?B?R1o4YWFyWXU0WHJGK2c0R3RSZFZrbkVNdCtsL3FvMEhIVUFJT3VWelhDNWJm?=
 =?utf-8?B?RUMzV3hRajZHTkw5VXJXbGVWeklDN3B1MFFNV25xbmh6TUpnbGUydkl1aXdu?=
 =?utf-8?B?N1BwVE5SZ2VycWZDOWZmMWthYVZ5UzZNMmh4OU1HOS9TUGgycVA1NHpNNHRB?=
 =?utf-8?B?dmY0dXRoVkt2SDVXU3NRK3B6OWNVaUh3c096b3cvSzdYU3BCM0RiN2c3MU9F?=
 =?utf-8?B?OEE2UmRiNWdHUXd3QXBZRDAxWitPY0c1WThKVVBsc2lVbi9aVmg2Qkt4Qkhu?=
 =?utf-8?B?S0VBakkzdElYMG12cE5uRzhqYWtISVZEUVFmcmJlU0JiL1JZQjlRbEZXWTFZ?=
 =?utf-8?Q?LlOvXyFy1L4UCzwk+tEUCp+T+paEsNLf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3FpamJIQlpoc3JldHozcmFtdTV4RDJzYVZHV1N3MGhqVk5OdDBsUzlEVGxi?=
 =?utf-8?B?bC9GQUV3WVM0ajl3dVFsUSt0SzlTOUZpT2hUakd0MGtNVGMxS3ZzR2ErV2Mz?=
 =?utf-8?B?VGdxakdBVFNnYnIyZjFpZjlrWHUwc1dnM0JLYWYzd3ozNkdIanV2cXdhbmdF?=
 =?utf-8?B?ZUtscFlVbUs4RDRoV3BSTFVUV1Z2UmRmd2ZTTGx0d2ZqMUZ0TnM1ZTJHak05?=
 =?utf-8?B?YkFIWE9CQ3FDNzRJbFJLSStvcVNZOXlGM2thTGpneDRaaGRDam1sTjRxZk1H?=
 =?utf-8?B?b0xpcHE4cDdoS2cybVVYY0QwTUU3SWk5V2NYSGVmUUhvVjB2VUZUV1V4a29R?=
 =?utf-8?B?Qkh3THRwY29EMEY0U2tyamtTakw1a3JtazhnSExESXJoNXVZQnR0YzdqY3pB?=
 =?utf-8?B?Ynp1NnBob1lNS0NrajlmOGx6cmlnaW9QaXFRdU9aS3hRVmUwSCt0emUzeWF1?=
 =?utf-8?B?KzVZbk52azRMcjJrWHRyaldLZlBSOWZBUnZDeTdDU2I1a1ExQTJPT2prR0Fj?=
 =?utf-8?B?TE5wRzR2d1V2SmU1amQrQmMvckIwMVZvR1BFRkFjQm8wRUx4d1NlSXNxazVj?=
 =?utf-8?B?WTV5QWQ1WUtsblEvS2pIRGhiRzNsUkRrcUdYY3V5MmlwNlZKOGVwcmdEOGZZ?=
 =?utf-8?B?angrSitHb3VEQVhtMDRlVmZnb25sazlMRUVaWFRLN3pZUWYwdnVPWDd1QVhR?=
 =?utf-8?B?eklqWUNwTDlPVGg2Z2ZNSGZxTExHWmlHK1dMQ3NEd3VEb052aElEU3VucGVZ?=
 =?utf-8?B?S293RUxVZ2xacWN2VjlZZ2hNQU5DRWY3bWx0NjB1OThpN2tXR3ZSN1RneW0r?=
 =?utf-8?B?MmwrSERrN2FxZGhkTUd2c1lhc2s2ZVQ2dURKL2dHSzJzcVV5VEZ3d0NGT3dO?=
 =?utf-8?B?cmZOdnFlOGR3T0NlV2xwSG9Wa0NlVk1vRUxMY1JhdnZKdEIrM21aVDBXK1NI?=
 =?utf-8?B?MjZremFVNWpCQ2plWE96YngxS0FtUlVJUzJFS3Z4cnRTbXRMbUwyTSt6OHRy?=
 =?utf-8?B?UUE5N1BCOWNMM3I3UW9RRXZrRnF4ZXBpODhjV3pqWHpYdm1teUNqUFFOQzgy?=
 =?utf-8?B?NDZJNkxrOXBjUFRhREFKQ0NVR3NIazhFVFJsVXB1dm51blhqbWt1cDNDeWZE?=
 =?utf-8?B?eFAxMkV3b0NFTW9lV3l3NTZHdTl3cjdVcGhHNm5JRmJBc2xlYVJCc3Z3Q25m?=
 =?utf-8?B?Sk8ydGZJMlVhSytUMUNHekJHMEJGY1NOSHJscTAyMXY4dTZVeUxuU2NsVkZL?=
 =?utf-8?B?UUE3bEowREZmNVVwM1N3a1Y0WnlQbFVFMFBudnM1MCs1Q0FzTlZROW1VbUxq?=
 =?utf-8?B?cG5PYkwvaEJHK1gvR0kyNjUvSEVtSzZOVWVsS1B4OU1ya3dRRWc0Nm15OHZ3?=
 =?utf-8?B?azNYdVExQTROaGFvYkxFUFpUZVdoWmtKVEEzdFhRT0pqcE1SUENzS2tqT05J?=
 =?utf-8?B?MjNhYTI1SlhDbi9ncERGcVRvWTJRZlREVzRpTm5TS0ZSMm16RE5zbWw0cEcv?=
 =?utf-8?B?dG81VmZEbTNBTzBoRXVzMUtpa3d6aWEvSGxkdmJnSTNWdXY3bkxLTU5ReU0z?=
 =?utf-8?B?SGVHVWNCWFk2RkFzNXlodm1SOFVJbUJkTENLa3Avdlk4dU9ia2pUQjFuWWpG?=
 =?utf-8?B?SFBnS21DS3l2Y2l6VmhZc0Zra1VTWWozN1B0TlRqb0luWXlXU1N0RmZxd2RI?=
 =?utf-8?B?WjduTUdvUGkvYnhwaEgzblF3RUg4emduVWttdXpFaTJ1WUN4ZHlyM3ZNUVNN?=
 =?utf-8?B?WTl1U2ptZldreTY2dFNkM3ZyOHlzZzNWam5iYVZhcTR4b3RGMDhhV0ZaVmow?=
 =?utf-8?B?akRpTGhUdHlmWWtVRmJEemxZcTJ0R3Y4QmczZU1ZK1JFMDNJM3ZOUGNvMnZZ?=
 =?utf-8?B?VTI0VUZxc0liVTMyZ1RKVEh5MlRmYXVQZUM4Njk1Y2R2OUxUMkdrMWxNSzQx?=
 =?utf-8?B?Z255MEkzWHVEYjJEUHVFM2ZBOFJrc2R4Y2JEOXhmTmhUVHpIOVJEMVpMRWxD?=
 =?utf-8?B?OGo1ZXdCb0MwRE5HMFY3RUw3Y3Y4c0xEa2ZBN1VUbTAvL1hWU1k5Ly9Vcktn?=
 =?utf-8?B?aExEV2o0KzFPeWtHNmk4ZWRYYzcyck5PM05nV3N2VVYwTmpEcnU4Vi9nUHFJ?=
 =?utf-8?Q?RGKFs+ST6bC2hH7k46QHVriZd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8838.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3409350d-d830-4c15-2efb-08dd5afd0e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:15:07.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOk16bTXXUGWTRYjLHO3NaRC6Fp/ziooseHCn3rxdbVFNWolnzzVzHGRJnIkrBUIXimsE0O8F/TuGlCOZsP5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8159

PiBPbiBNb24sIE1hciAwMywgMjAyNSBhdCAxMDozNTo0MUFNICswMDAwLCBXYW5uZXMgQm91d2Vu
IChOb2tpYSkNCj4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCAwNTowMTo1
MVBNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBGZWIgMjgsIDIw
MjUgYXQgMTI6MjfigK9QTSBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+IHdy
b3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgTm92IDE0LCAyMDI0IGF0IDAyOjA1OjA4UE0gKzAwMDAs
IFdhbm5lcyBCb3V3ZW4gKE5va2lhKQ0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiBTdWJqZWN0
OiBbUEFUQ0ggMS8xXSBQQ0k6IG9mOiBhdm9pZCB3YXJuaW5nIGZvciA0IEdpQg0KPiA+ID4gPiA+
ID4gbm9uLXByZWZldGNoYWJsZSB3aW5kb3dzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFj
Y29yZGluZyB0byB0aGUgUENJZSBzcGVjLCBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSBzdXBwb3J0
cw0KPiA+ID4gPiA+ID4gb25seSAzMi1iaXQgQkFSIHJlZ2lzdGVycyBhbmQgYXJlIGhlbmNlIGxp
bWl0ZWQgdG8gNCBHaUIuIEluDQo+ID4gPiA+ID4gPiB0aGUga2VybmVsIHRoZXJlIGlzIGEgY2hl
Y2sgdGhhdCBwcmludHMgYSB3YXJuaW5nIGlmIGENCj4gPiA+ID4gPiA+IG5vbi1wcmVmZXRjaGFi
bGUgcmVzb3VyY2UgZXhjZWVkcyB0aGUgMzItYml0IGxpbWl0Lg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IFRoaXMgY2hlY2sgaG93ZXZlciBwcmludHMgYSB3YXJuaW5nIHdoZW4gYSA0IEdpQiB3
aW5kb3cgb24gdGhlDQo+ID4gPiA+ID4gPiBob3N0IGJyaWRnZSBpcyB1c2VkLiBUaGlzIGlzIHBl
cmZlY3RseSBwb3NzaWJsZSBhY2NvcmRpbmcgdG8NCj4gPiA+ID4gPiA+IHRoZSBQQ0llIHNwZWMs
IHNvIGluIG15IG9waW5pb24gdGhlIHdhcm5pbmcgaXMgYSBiaXQgdG9vDQo+ID4gPiA+ID4gPiBz
dHJpY3QuIFRoaXMgY2hhbmdlc2V0IHN1YnRyYWN0cyAxIGZyb20gdGhlIHJlc291cmNlX3NpemUg
dG8NCj4gPiA+ID4gPiA+IGF2b2lkIHByaW50aW5nIGEgd2FybmluZyBpbiB0aGUgY2FzZSBvZiBh
IDQgR2lCIG5vbi1wcmVmZXRjaGFibGUNCj4gd2luZG93Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFdhbm5lcyBCb3V3ZW4gPHdhbm5lcy5ib3V3ZW5Abm9raWEuY29t
Pg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9wY2kvb2YuYyB8IDIgKy0N
Cj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvb2Yu
YyBiL2RyaXZlcnMvcGNpL29mLmMgaW5kZXgNCj4gPiA+ID4gPiA+IGRhY2VhM2ZjNTEyOC4uY2Ni
YjFmMWMyMjEyIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvb2YuYw0KPiA+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvb2YuYw0KPiA+ID4gPiA+ID4gQEAgLTYyMiw3ICs2
MjIsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4gPiBwY2lfcGFyc2VfcmVxdWVzdF9vZl9wY2lf
cmFuZ2VzKHN0cnVjdA0KPiA+ID4gZGV2aWNlICpkZXYsDQo+ID4gPiA+ID4gPiAgICAgICAgICAg
ICByZXNfdmFsaWQgfD0gIShyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9QUkVGRVRDSCk7DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgaWYgKCEocmVzLT5mbGFncyAmIElPUkVT
T1VSQ0VfUFJFRkVUQ0gpKQ0KPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGlmICh1cHBlcl8z
Ml9iaXRzKHJlc291cmNlX3NpemUocmVzKSkpDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAg
aWYgKHVwcGVyXzMyX2JpdHMocmVzb3VyY2Vfc2l6ZShyZXMpIC0gMSkpDQo+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIk1lbW9yeSByZXNvdXJjZSBzaXplDQo+
ID4gPiA+ID4gPiBleGNlZWRzIG1heCBmb3IgMzIgYml0c1xuIik7DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJIGd1ZXNzIHRoaXMgcmVsaWVzIG9uIHRoZSBmYWN0IHRoYXQgQkFScyBtdXN0IGJlIGEg
cG93ZXIgb2YgdHdvDQo+ID4gPiA+ID4gaW4gc2l6ZSwgcmlnaHQ/ICBTbyBhbnl0aGluZyB3aGVy
ZSB0aGUgdXBwZXIgMzIgYml0cyBvZiB0aGUgc2l6ZQ0KPiA+ID4gPiA+IGFyZSBub24temVybyBp
cyBlaXRoZXIgMHgxXzAwMDBfMDAwMCAoNEdpQiB3aW5kb3cgdGhhdCB3ZQ0KPiA+ID4gPiA+IHNo
b3VsZG4ndCB3YXJuIGFib3V0KSwgb3IgMHgyXzAwMDBfMDAwMCBvciBiaWdnZXIgKHdoZXJlIHdl
ICpkbyoNCj4gPiA+ID4gPiB3YW50IHRvIHdhcm4gYWJvdXQgaXQpLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gQnV0IGl0IGxvb2tzIGxpa2UgdGhpcyBpcyB1c2VkIGZvciBob3N0IGJyaWRnZSByZXNv
dXJjZXMsIHdoaWNoDQo+ID4gPiA+ID4gYXJlIHdpbmRvd3MsIG5vdCBCQVJzLCBzbyB0aGV5IGRv
bid0IGhhdmUgdG8gYmUgYSBwb3dlciBvZiB0d28NCj4gPiA+ID4gPiBzaXplLiAgQSB3aW5kb3cg
b2Ygc2l6ZSAweDFfODAwMF8wMDAwIGlzIHBlcmZlY3RseSBsZWdhbCBhbmQNCj4gPiA+ID4gPiB3
b3VsZCBmaXQgdGhlIGNyaXRlcmlhIGZvciB0aGlzIHdhcm5pbmcsIGJ1dCB0aGlzIHBhdGNoIHdv
dWxkIHR1cm4gb2ZmIHRoZQ0KPiB3YXJuaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiAweDFfODAwMF8w
MDAwIC0gMSA9IDB4MV83ZmZmX2ZmZmYNCj4gPiA+ID4NCj4gPiA+ID4gU28gdGhhdCB3b3VsZCBz
dGlsbCB3b3JrLiBNYXliZSB5b3UgcmVhZCBpdCBhcyB0aGUgc3VidHJhY3QgYmVpbmcNCj4gPiA+
ID4gYWZ0ZXIgdXBwZXJfMzJfYml0cygpPw0KPiA+ID4NCj4gPiA+IFJpZ2h0LCBzb3JyeS4gIEkg
Z3Vlc3MgYSBiZXR0ZXIgZXhhbXBsZSB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiA+
ID4NCj4gPiA+ICAgW21lbSAweDIwMDBfMDAwMC0weDIxZmZfZmZmZl0gLT4gW3BjaSAweDBfZmYw
MF8wMDAwLTB4MV8wMGZmX2ZmZmZdDQo+ID4gPg0KPiA+ID4gd2hlcmUgdGhlIHNpemUgaXMgb25s
eSAweDAyMDBfMDAwMCwgc28gd2Ugd291bGRuJ3Qgd2FybiBhYm91dCBpdCwNCj4gPiA+IGJ1dCBo
YWxmIG9mIHRoZSB3aW5kb3cgaXMgYWJvdmUgNEcgb24gUENJLg0KPiA+ID4NCj4gPiA+ID4gPiBJ
IGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHRoaXMgd2FybmluZyBpbiB0aGUgZmlyc3QgcGxhY2Us
DQo+ID4gPiA+ID4gdGhvdWdoLiAgSXQgd2FzIGFkZGVkIGJ5IGZlZGU4NTI2Y2M0OCAoIlBDSTog
b2Y6IFdhcm4gaWYNCj4gPiA+ID4gPiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSBhcGVydHVyZSBz
aXplIGlzID4gMzItYml0IikuICBCdXQgSQ0KPiA+ID4gPiA+IHRoaW5rIHRoZSByZWFsIGlzc3Vl
IHdvdWxkIGJlIHJlbGF0ZWQgdG8gdGhlIGhpZ2hlc3QgYWRkcmVzcywNCj4gPiA+ID4gPiBub3Qg
dGhlIHNpemUuICBGb3IgZXhhbXBsZSwgYW4gYXBlcnR1cmUgb2YgMHgwX2MwMDBfMDAwMCAtDQo+
ID4gPiA+ID4gMHgxXzQwMDBfMDAwMCBpcyBvbmx5IDB4ODAwMF8wMDAwIGluIHNpemUsIGJ1dCB0
aGUgdXBwZXIgaGFsZiBvZg0KPiA+ID4gPiA+IGl0IGl0IHdvdWxkIGJlIGludmFsaWQgZm9yIG5v
bi1wcmVmZXRjaGFibGUgMzItYml0IEJBUnMuDQo+ID4gPiA+DQo+ID4gPiA+IEFyZSB3ZSB0YWxr
aW5nIENQVSBhZGRyZXNzZXMgb3IgUENJIGFkZHJlc3Nlcz8gRm9yIENQVSBhZGRyZXNzZXMsDQo+
ID4gPiA+IGl0IHdvdWxkIGJlIHBlcmZlY3RseSBmaW5lIHRvIGJlIGFib3ZlIDRHIGFzIGxvbmcg
YXMgUENJIGFkZHJlc3Nlcw0KPiA+ID4gPiBhcmUgYmVsb3cgNEcsIHJpZ2h0Pw0KPiA+ID4NCj4g
PiA+IFllcywgQ1BVIGFkZHJlc3NlcyBjYW4gYmUgYWJvdmUgNEc7IGFsbCB0aGF0IG1hdHRlcnMg
Zm9yIHRoaXMgaXMgdGhlDQo+ID4gPiBQQ0kgYWRkcmVzcy4NCj4gPiA+DQo+ID4gPiBJIHRoaW5r
IHdoYXQncyBpbXBvcnRhbnQgaXMgdGhlIGxhcmdlc3QgUENJIGFkZHJlc3MgaW4gdGhlIHdpbmRv
dywNCj4gPiA+IG5vdCB0aGUgc2l6ZS4NCj4gPg0KPiA+IEkgYWdyZWUuIFRoZSBjaGVjayBpcyBJ
IGJlbGlldmUgaW4gcGxhY2UgdG8gbWFrZSBzdXJlIHRoZSBob3N0IGJyaWRnZQ0KPiA+IG5vbi1w
cmVmZXRjaGFibGUgd2luZG93IGRvZXMgbm90IGV4Y2VlZCB0aGUgNCBHaUIgYm91bmRhcnkuDQo+
ID4gVGhpcyBpcyBub3QgcG9zc2libGUgZHVlIHRvIHRoZSByZWdpc3RlciBtYXAgb2YgUENJZSBj
b25maWd1cmF0aW9uDQo+ID4gc3BhY2UgdHlwZSAxIChyZWdpc3RlciAweDIwKS4gSSBndWVzcyB0
aGUgY2hlY2sgd291bGQgYmUgbW9yZSBjb3JyZWN0DQo+ID4gaWYgd2UganVzdCBjaGVjayB0aGUg
ZW5kIGFkZHJlc3Mgb2YgdGhlIHJlc291cmNlIGluc3RlYWQgb2YgdGhlIHNpemU/DQo+ID4gU29t
ZXRoaW5nIGxpa2UgdGhpcz8NCj4gPg0KPiA+IEBAIC02MjIsNyArNjIyLDcgQEAgc3RhdGljIGlu
dCBwY2lfcGFyc2VfcmVxdWVzdF9vZl9wY2lfcmFuZ2VzKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwN
Cj4gPiAgICAgICAgICAgICByZXNfdmFsaWQgfD0gIShyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9Q
UkVGRVRDSCk7DQo+ID4NCj4gPiAgICAgICAgICAgICBpZiAoIShyZXMtPmZsYWdzICYgSU9SRVNP
VVJDRV9QUkVGRVRDSCkpDQo+ID4gLSAgICAgICAgICAgICAgIGlmICh1cHBlcl8zMl9iaXRzKHJl
c291cmNlX3NpemUocmVzKSkpDQo+ID4gKyAgICAgICAgICAgICAgIGlmICh1cHBlcl8zMl9iaXRz
KHJlcy0+ZW5kKSkNCj4gDQo+IHJlcy0+ZW5kIGlzIGEgQ1BVIGFkZHJlc3MuICBBbGwgdGhhdCBt
YXR0ZXJzIGhlcmUgaXMgdGhlIFBDSSBhZGRyZXNzLA0KPiB3aGljaCBpcyBkaWZmZXJlbnQuDQo+
IA0KPiBZb3Ugd291bGQgbmVlZCBwY2liaW9zX3Jlc291cmNlX3RvX2J1cygpIG9uIHJlcywgYW5k
IGxvb2sgYXQgdGhlIHJlZ2lvbi5lbmQNCj4gaXQgcmV0dXJucy4NCg0KSSd2ZSBtb3ZlZCB0aGUg
Y2hlY2sgdG8gZGV2bV9vZl9wY2lfZ2V0X2hvc3RfYnJpZGdlX3Jlc291cmNlcygpIGluc3RlYWQg
b2YgdXNpbmcNCnBjaWJpb3NfcmVzb3VyY2VfdG9fYnVzKCkgYXMgc3VnZ2VzdGVkLiBMZXQgbWUg
a25vdyB3aGF0IHlvdSB0aGluayBvZiB0aGlzLg0KDQpTdWJqZWN0OiBbUEFUQ0hdIFN1YmplY3Q6
IFtQQVRDSCAxLzFdIFBDSTogb2Y6IGF2b2lkIHdhcm5pbmcgZm9yIDQgR2lCDQogbm9uLXByZWZl
dGNoYWJsZSB3aW5kb3dzLg0KDQpBY2NvcmRpbmcgdG8gdGhlIFBDSWUgc3BlYywgbm9uLXByZWZl
dGNoYWJsZSBtZW1vcnkgc3VwcG9ydHMgb25seSAzMi1iaXQNCmhvc3QgYnJpZGdlIHdpbmRvd3Mg
KGJvdGggYmFzZSBhZGRyZXNzIGFzIGxpbWl0IGFkZHJlc3MpLiBJbiB0aGUga2VybmVsDQp0aGVy
ZSBpcyBhIGNoZWNrIHRoYXQgcHJpbnRzIGEgd2FybmluZyBpZiBhIG5vbi1wcmVmZXRjaGFibGUg
cmVzb3VyY2Uncw0Kc2l6ZSBleGNlZWRzIHRoZSAzMi1iaXQgbGltaXQuDQoNClRoZSBjaGVjayBj
dXJyZW50bHkgY2hlY2tzIHRoZSBzaXplIG9mIHRoZSByZXNvdXJjZSwgd2hpbGUgYWN0dWFsbHkg
dGhlDQpjaGVjayBzaG91bGQgYmUgZG9uZSBvbiB0aGUgUENJZSBlbmQgYWRkcmVzcyBvZiB0aGUg
bm9uLXByZWZldGNoYWJsZQ0Kd2luZG93Lg0KDQpNb3ZlIHRoZSBjaGVjayB0byBkZXZtX29mX3Bj
aV9nZXRfaG9zdF9icmlkZ2VfcmVzb3VyY2VzIHdoZXJlIHRoZSBQQ0llDQphZGRyZXNzZXMgYXJl
IGF2YWlsYWJsZSBhbmQgdXNlIHRoZSBlbmQgYWRkcmVzcyBpbnN0ZWFkIG9mIHRoZSBzaXplIG9m
DQp0aGUgd2luZG93IHRvIGF2b2lkIHdhcm5pbmdzIGZvciA0IEdpQiB3aW5kb3dzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBXYW5uZXMgQm91d2VuIDx3YW5uZXMuYm91d2VuQG5va2lhLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvcGNpL29mLmMgfCA4ICsrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL29mLmMg
Yi9kcml2ZXJzL3BjaS9vZi5jDQppbmRleCA3YTgwNmY1YzBkMjAuLjY1MjNiNmRhYmFhNyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvcGNpL29mLmMNCisrKyBiL2RyaXZlcnMvcGNpL29mLmMNCkBAIC00
MDAsNiArNDAwLDEwIEBAIHN0YXRpYyBpbnQgZGV2bV9vZl9wY2lfZ2V0X2hvc3RfYnJpZGdlX3Jl
c291cmNlcyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQogICAgICAgICAgICAqaW9fYmFzZSA9IHJhbmdl
LmNwdV9hZGRyOw0KICAgICAgICB9IGVsc2UgaWYgKHJlc291cmNlX3R5cGUocmVzKSA9PSBJT1JF
U09VUkNFX01FTSkgew0KICAgICAgICAgICAgcmVzLT5mbGFncyAmPSB+SU9SRVNPVVJDRV9NRU1f
NjQ7DQorDQorICAgICAgICAgICBpZiAoIShyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9QUkVGRVRD
SCkpDQorICAgICAgICAgICAgICAgaWYgKHVwcGVyXzMyX2JpdHMocmFuZ2UucGNpX2FkZHIgKyBy
YW5nZS5zaXplIC0gMSkpDQorICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIk1lbW9y
eSByZXNvdXJjZSBzaXplIGV4Y2VlZHMgbWF4IGZvciAzMiBiaXRzXG4iKTsNCiAgICAgICAgfQ0K
DQogICAgICAgIHBjaV9hZGRfcmVzb3VyY2Vfb2Zmc2V0KHJlc291cmNlcywgcmVzLCByZXMtPnN0
YXJ0IC0gcmFuZ2UucGNpX2FkZHIpOw0KQEAgLTYxOSwxMCArNjIzLDYgQEAgc3RhdGljIGludCBw
Y2lfcGFyc2VfcmVxdWVzdF9vZl9wY2lfcmFuZ2VzKHN0cnVjdCBkZXZpY2UgKmRldiwNCiAgICAg
ICAgY2FzZSBJT1JFU09VUkNFX01FTToNCiAgICAgICAgICAgIHJlc192YWxpZCB8PSAhKHJlcy0+
ZmxhZ3MgJiBJT1JFU09VUkNFX1BSRUZFVENIKTsNCg0KLSAgICAgICAgICAgaWYgKCEocmVzLT5m
bGFncyAmIElPUkVTT1VSQ0VfUFJFRkVUQ0gpKQ0KLSAgICAgICAgICAgICAgIGlmICh1cHBlcl8z
Ml9iaXRzKHJlc291cmNlX3NpemUocmVzKSkpDQotICAgICAgICAgICAgICAgICAgIGRldl93YXJu
KGRldiwgIk1lbW9yeSByZXNvdXJjZSBzaXplIGV4Y2VlZHMgbWF4IGZvciAzMiBiaXRzXG4iKTsN
Ci0NCiAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICB9DQogICAgfQ0K

