Return-Path: <linux-pci+bounces-30143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D45ADFA1F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 02:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4B4189E9A9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 00:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EFA12B94;
	Thu, 19 Jun 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hsPvJtty"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2138.outbound.protection.outlook.com [40.107.94.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E9125D6;
	Thu, 19 Jun 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750293026; cv=fail; b=g/I5y1GzBHQRwtLOXwFiW+CHaq+xqgKr5rYQHl0WIps3AYOnw7kKAmwV8XV4LDljpwZxF+PkD5QRAfUIWjQDZlITbxBMfKOG9y7uZ/B6Ld4GB8GcRyAySwktSTfMnQJr3LO7SNLX+1oXLTJVfxwB+04SBw1N4NkNBC+Mupfg9as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750293026; c=relaxed/simple;
	bh=4THYcqMsnnMNrfMDrtlZK4EhNgXNVysh/yZwhNe3DJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=THVdGbElf4ivqrM2RUGcTarugJqvY+hHCl3TEyn6lszWnB00HoAuRS5ck12TrShYlT/t7hj1ek5StU+GkQPsgXisLGSXVxqblzG6pUt0M7MdKjGphupztcwf58BhGP9E1rzcsWhB8bj/NfcNA70CUfxcXFu1Sb8SJgZ9ezovh5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hsPvJtty; arc=fail smtp.client-ip=40.107.94.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zox/Z2+u23WiziK2ebBYWPutOIJRRnEZU/820bKPDun9nkF4tr7sHKiKPGzrNpNeDwS2XQsb57aNcImD5IZZMGDjGq9An2yziiK/Vw0mU+bJD3ZICESyvo05uU8ciAud4GMX7JrTAT0vDWHbayQ6bucRMOMaTBlE658tUZ00yt3szBaZZsa3KNwu/QHJBCufh7GhhXou/f+jZLArHY/WSJrY5ZVvMvMs3HSKe90V85IVxjk7kOoJ3KWanuU9o0Qi04MzzsEQWj1ZAR98qXmxF+F3xbkH7OgBmRysj3V/7lhLcES+RQkvVpnmqJMvQA1KGJLGXzQ3zsLEpeRInYuIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MRRySWhi5ipHoyZOvY0XBxj1mHQmFd4II0HRZm61ik=;
 b=B97/Gihu99RiT4qTA96Ci+y+jwO80oCT4yMHU9me06LAuSdXdUXFpU/vFJvXXQcmXiAfocmkvBaO8znPiR0J7iWoFknX6aCzY7+zhr8zPJCrIta0dliUYN/3x1jEPmOh+GQ36XgQKC5ch6evXBUExoHaFzenHcKq2n8V1TIifuV0vvmgr2WvY8piubPSC95o79sDgmVjDHvjiHmgOyHTpSoMtkMj/H4vTogvzdvvXI11FQOdzI7tx2h514WHojixemmInHY7Va/3R5/zRCd7N3gGC9JBtqMcmkydbr/vota90AiPAIC9Zfc14qwRQh10yVRvI34pwMniKm1ejQ8oig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MRRySWhi5ipHoyZOvY0XBxj1mHQmFd4II0HRZm61ik=;
 b=hsPvJtty745oA74QeCi2lVeuYlui2oUybUP273359hfdXOZZS++ViGi3pMkNtmot9Ckdsjmm4ZxYK/ANHbASHzWqxosT66Q7w78LI/4yygsg+jdqj5jcfcM1nIfl1xhpQyOot/f6bVjzBtmul3gRHCZghJodScUCUokrdGm7okM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 DM8PR01MB6933.prod.exchangelabs.com (2603:10b6:8:12::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Thu, 19 Jun 2025 00:30:22 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 00:30:22 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Bjorn
 Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, =?utf-8?Q?Micha=C5=82?=
 Winiarski
 <michal.winiarski@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Ilpo =?utf-8?Q?J?=
 =?utf-8?Q?=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Jun 2025 17:30:18 -0700
Message-ID: <86plf0lgit.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|DM8PR01MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: af4a44a2-92fe-41f3-7ac9-08ddaec879e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9wVFdLZWkvN3RiNWJEa1JvcFFkWUxNQ0cxOUp2NHNIdnNsU014Qit5Zm43?=
 =?utf-8?B?amxteS9scHVSeDFBamxkVWdYWGVMK2ZscW0xdWpxcVVSR0dQNVJDVVJoT3lC?=
 =?utf-8?B?eG5jOUdiSk9pOWwySU5OYXFKNmsrbnh0T3NCUitBYU5QQmo2dGpvUjVmakxM?=
 =?utf-8?B?YzEya0VIVHI1bU8xZEFZeGxodXY1dlYxQTN4QkZVQ2pzcmY3MGpia3h1WjNR?=
 =?utf-8?B?Z1BYcW1mcktCRlBvQVI3OUtKTHBFR0tma3NRWEJDR2pmaXFrY2hQNFR6V1Av?=
 =?utf-8?B?Um5GaHI2RWFETmZPM2NGdjNrQXZZaWlxTkp4cGNKamJnYWtTUkw2OU4wOXJp?=
 =?utf-8?B?c2t0Mmc1Y29wVGxadmk0KytvaXpoRVNzSGo4WThXSU1Remdoa05RU1Y4SXQ5?=
 =?utf-8?B?ZlVzcWt4MS9pV1V2NnU0KzF3bGl6bDk3bGJDbEEycmpTcUFsMEVwa0xuVUlL?=
 =?utf-8?B?aFY4VVgrK2diYkpFNjYzblg4SnpBUldGQ0o5UjM5dzdtZEVtdEUvaUdDM0Ju?=
 =?utf-8?B?NVlnQUZBWWdOV2V3OFZFcXNZc0RuSlA3Y2Y2dXdSTXdhUUFiRGVqWlI4YjZ4?=
 =?utf-8?B?eGhoaDhncTlEVEVDNVlqZ1BQU2pvLzR1OUxrUGNVV2NHUzF0ZXYvU09zKyt0?=
 =?utf-8?B?N1BqbTB1TERqSTlWSldUY0Q5SldPUjZoRU8yYy9YckZ0UTJvTjdmTEtKdENr?=
 =?utf-8?B?NjY4cUExamUwK1RWRjFna0tXRllHL2ZHT0Y4SGQ4RHJta1g2QVJiNU5la2Uz?=
 =?utf-8?B?YXlxMm5KNkdvNmlxMVRoNTlJdXdVM001UWNmb0piRUUrQ3AyaGJUR1ZlejVR?=
 =?utf-8?B?Ymo5U2dkTWd3UE91OE5ZK1NrSE9PcEd1SHR3dGpRbTYxdkY5THNRNkwyUWpo?=
 =?utf-8?B?UE9HTldnNjZCYU5nemFKT3IwNUxRazFVcFRCNEF0UmdhRjRkSkN4L2tsOGx6?=
 =?utf-8?B?OGJuSmswYkFTM3BqbVEvdi80NnRpYlBIcmdER0N1TyswbExJWU5vNlNMSGJT?=
 =?utf-8?B?N2g1bzMxQmxTVjlrcEFzTXlFaWlhSEhpbmxFUTZscXhweWdTOS9GdDBlVXNo?=
 =?utf-8?B?cDlES3RqMHlVSVdmWGZiMkNvdEFkeUhQMTlKcXNaWUd3N2dGWVVDbEdmS1NF?=
 =?utf-8?B?RThsL1BqcXIxK2hCSytiVlhRRDc3dW1Ba3V1ZHlvdHg2NVNOVG83Q0pEaUgz?=
 =?utf-8?B?ZGxGZjFSdzIvTmhkbng5R2dBaHZwOGJDd3pTMjk1V0kzZXRkK0Fqc0JNSm4v?=
 =?utf-8?B?RzZVeG52UVlkLy8yMlJRQTJkQ1Nha0pxMWcrSFpjSWRNd3RoZ010T2Eza0FV?=
 =?utf-8?B?WTRCMzMrWCtjNnduL2l6Zkx3ME1BQk55cnkzTXlVemhGeXB4RHAydzhaRVJF?=
 =?utf-8?B?ZDE1U2prUDVPbDF4Q21OMDNhbHA5c3VyTmRIb0lWU2xtaHJTWXZpQVJkTWxs?=
 =?utf-8?B?MVlUd1kzVDBQWVlHVmU4WVcwZGdwU25HRUZxWlc4MWsyZzBOeGJFaUoxSVFm?=
 =?utf-8?B?bnJ1SlBPeTVnaVBnSmZHNDZ1b1NXWEJCUXR2cnVNNVRJckNld0Mwcks2YUJD?=
 =?utf-8?B?M3pSQ3R4OGxraUtBSHF3MmlmTUZHTEQzTEdvRkRweGxGT1ZrcmwrUENvRnYr?=
 =?utf-8?B?QUJ4aFJkTitjRFpqTHB5eVdDME1tamNRc2FoOSs4clZpaktWb3l2Um9MM05z?=
 =?utf-8?B?Yk9tR1l5enZjTXk3ODh0KzVCZTZVVHhrb3Z0OVhBeWUvK0tSdG1XQVFYVlVy?=
 =?utf-8?B?N1pOUi9aQkRXNmtNSDRPWTkyemFaRUZsYXhOK0EwUEo3OWVQcDI3Rm4xS01l?=
 =?utf-8?B?ZnV2S29jcWhxWjZCUXZIeXljMEloeWVLYkRVdDJETis1THNWa0gxVHFQaEta?=
 =?utf-8?B?ZVdna212RFp5VnowUkhnbldNTFIvNWd2ZlprVEVWWktSSW0rZXB3NkE4ZWdR?=
 =?utf-8?B?VU83Wkx4K3pZbE1lbFVSSG9wNWJIN2lmekJ3VGVKLzh5akc4Q01NT3hRR3Mw?=
 =?utf-8?B?Z01sOE9aOHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZNUHJ6MzhKUTlGQTFQUm16RFI5VHJweUtBWTc1dEFxNXpzVWRkZFBGTUZZ?=
 =?utf-8?B?NStzbmVSSU1GYU9rM1J1ZG5OK3kzanBVYUNkeHVuZDVYMGMxZUhLR3hTYTli?=
 =?utf-8?B?UGxhRmZoM0IySEcxUC9IR1J5bW1MejJhZ281MEFHQ0d5eTMvdlZ5UW9SRDZ6?=
 =?utf-8?B?TDlSb1RlVlo4QUdxaXNwejlBZ3VyMldRL0JHQ1pNRGR6T1NKQXV2WjlWM0hB?=
 =?utf-8?B?SHlyNHIxMXFTUHlSTVlCVkFuNENIY00wODkvaFB1NERzaGJOV29zZGpIc1Z3?=
 =?utf-8?B?eW5kZEFpUGV2TnJHSWZCcE9EamFTZ2lZTVBJcXNIekxpbUR4T3JLVmtlNGVm?=
 =?utf-8?B?U1Y3MGpBNCtRcTllSEdhTDNFZ0NLUjR0OXd6VVJMT0tmOEpwSXlGcmxnaFlr?=
 =?utf-8?B?aUhibldRamI3TG5IajNPemVpcjNyem5nVUVuUzIxZTRxL21mUlliYmF6Qklm?=
 =?utf-8?B?cVF1WUdYOXhhY3JEUkVtWWpGMWVvNlNraXVtZ3ZscmVWY3lWK3liWWRDaVA0?=
 =?utf-8?B?VFhJZlBPOGFzc1BGUlUzR2dqNkpIanZhMHBteDJsQml6UHQwa3hUUXFIWUlN?=
 =?utf-8?B?ODYzOEtiZWdueXpDNXE3VUQ5YTREMC9ia1d6VENMM3g3MjVaTHl1UHo4d0xX?=
 =?utf-8?B?dUFiVjVnUGJSSlNROXNtSGZnRGtiVE1qd3JVbDh5S0JDZ1Z2R1lZbG51WXJQ?=
 =?utf-8?B?VDFOUmtCR1JkOXZua1ZuWUZqRFhQd011akRjREpLdjVFOUkxYysxMzBHZnVD?=
 =?utf-8?B?UkhaUEpDMDFhcnpMZExmSWYyWTN3N3h2QW41UjZCS3l1SndiMURrajM3bTlh?=
 =?utf-8?B?VTZ1K1MwNzJqdzk0UFpUTEJFZVJ0dDZCVEJTMm5peVVuL2dLZFhkK3gyblFo?=
 =?utf-8?B?Z01DaEJFQS9icVRUTHM5M29xSEVaaW5NVkdJYlk2Qmh1enoyY1RsNklud0VS?=
 =?utf-8?B?ZGhyUDhnc2JsZFFPVWJ5YXRERW5ESHZobk9oRFNwM0FVK3h3NnNKciszSlN3?=
 =?utf-8?B?eEQ4MDJ0S2lmbmpPOFNSMXFYb2tKNGlsUUtRYTlHOWh4aGFyR2VSOUNkOHJj?=
 =?utf-8?B?UnRkSWFGM2VCYitoL0tPL3B6Q0xjTFE2WDJvVnpjWEdqR01nRlR3Q2QySnlH?=
 =?utf-8?B?cllyWGxwck01MXVjMFdzbk1VaTEwY3pNNzNiM3pQVEtnZ0w3dXMvN0tsV29R?=
 =?utf-8?B?UWM1M3Jsek1KYWhRS2tITjFOaXVCREphY3EvUUtaYzBiSk1ueE0xSE1QN1A3?=
 =?utf-8?B?SHg3dEtZQmVUVmJMeEwwZ29mSzRCdmJTMHdncnNoZS9JUENLZlZzd2h4UnVx?=
 =?utf-8?B?OVhGUTgzbDVTcEtqMGgxQnkzM0dPdFB0RWM5SjNoZmo2WG5GNXZKVGVqUTMy?=
 =?utf-8?B?V2hmNzdiNXVvdGJJdjVFOGdOZGlGaGppRStPQUcwRDhGWHB4ajZaUnF6dGVw?=
 =?utf-8?B?K2RNU3U0eWJCWFVzQnNDV3lyeXI0eC9jTjZLNEYrcGM1cXhoaFd5UG5Ma1RL?=
 =?utf-8?B?azRvRitsbTArOFBhdXB4eTRFc1IzSkUzeVFjRGxYaElVaUNQdCtQNGx2RGl3?=
 =?utf-8?B?RkZRaFpoZlhZcS9BQWRWaGVxSTRRSjFYb0FJZ3huMWx1S3hpVms0TkN3WVh5?=
 =?utf-8?B?MHhya3ZucXRYTHYxWWRmazZrQml0NW1RK0FkSlhxNkZjZXVDOWJ6SVdEWkJY?=
 =?utf-8?B?QnFUN1d3dXpNNGxUWVRUSmpOWUJlaDhJQ2pBYTdXclFtM0RVVlE5YUd5MDdk?=
 =?utf-8?B?N2s2citaZjEzLzFnN0tIcHZ4R0FUQXhpdVFqMU1FRHd4Rm50eERnZExDQklS?=
 =?utf-8?B?dzA2RUlZODJuWWpSVTJyZm5ZeFM3Z0JIaUVqdDFGMEhUcExWRzgzRFgvTWhX?=
 =?utf-8?B?MlkrQmlHMzc4ZEZKcW1mQ09BVHFNOWdDN3NKdUUzdEkxZkNGS1ZZdjZnLyth?=
 =?utf-8?B?ZWhRZE5sM1h0RkpUaWtQMk9pTSt5MlIwNTJ6S1FKMFhSSWRqM05CRVlhcU15?=
 =?utf-8?B?MTRXc3A2UjdibjQrcndkR0tmZWNHRFp6WjJRM3NQVVA2clpEaytFdk1CcHcx?=
 =?utf-8?B?b256NUdNM1k2MFZyTEpSWlIrUWQ4ZUdBc3g1cllXL0dFaUVyYStUay9EM0NF?=
 =?utf-8?B?R0hMazdkcGN1ZFJqUmJLYUMyMUNBSHlKVWZaSVJBNndjRWV6ZlBweGJkTFdp?=
 =?utf-8?Q?dLuPI2NnZMDu/UF/pTWT9dE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4a44a2-92fe-41f3-7ac9-08ddaec879e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 00:30:22.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIo6mzCc+/j8fnAFUz3O+UQQLnJytOuA2SuvOYp/A44u85B18RxNJuzwFuPqTCW22rSrdCe4wO7hfOqmPnCTpxti8QnraAZEGkstd5rojMfYTzgXs4AlMPheGW3cXuLM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6933

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Resetting resource is problematic as it prevent attempting to allocate
> the resource later, unless something in between restores the resource.
> Similarly, if fail_head does not contain all resources that were reset,
> those resource cannot be restored later.
>
> The entire reset/restore cycle adds complexity and leaving resources
> into reseted state causes issues to other code such as for checks done
> in pci_enable_resources(). Take a small step towards not resetting
> resources by delaying reset until the end of resource assignment and
> build failure list (fail_head) in sync with the reset to avoid leaving
> behind resources that cannot be restored (for the case where the caller
> provides fail_head in the first place to allow restore somewhere in the
> callchain, as is not all callers pass non-NULL fail_head).
>
> The Expansion ROM check is temporarily left in place while building the
> failure list until the upcoming change which reworks optional resource
> handling.
>
> Ideally, whole resource reset could be removed but doing that in a big
> step would make the impact non-tractable due to complexity of all
> related code.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Hi Ilpo, I'm seeing a crash on arm64 at boot that I bisected to this
change. I don't think it's the same as the other issues reported. I've
confirmed the crash is still there after your follow up patches.  The
crash itself is below[1].

It looks like the problem begins when:

amdgpu_device_resize_fb_bar()
 pci_resize_resource()
  pci_reassign_bridge_resources()
   __pci_bus_size_bridges()

adds pci_hotplug_io_size to `realloc_head`. The io resource allocation
has failed earlier because the root port doesn't have an io window[2].

Then with this patch, pci_reassign_bridge_resources()'s call to
__pci_bridge_assign_resources() now returns the io added space for
hotplug in the `failed` list where the old code dropped it and did not.

That sends pci_reassign_bridge_resources() into the `cleanup:` path,
where I think the cleanup code doesn't properly release the resources
that were assigned by __pci_bridge_assign_resources() and there's a
conflict reported in pci_claim_resource() where a restored resource is
found as conflicting with itself:

> pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0x340017ffffff 6=
4bit pref]: can't claim; address conflict with PCI Bus 000d:01 [mem 0x34000=
0000000-0x340017ffffff 64bit pref]

Setting `pci=3Dhpiosize=3D0` avoids this crash, as does this change:

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 16d5d390599a..59ece11702da 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2442,7 +2442,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bri=
dge, unsigned long type)
 	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
-	unsigned int i;
+	unsigned int i, relevant_fails;
 	int ret;
=20
 	down_read(&pci_bus_sem);
@@ -2490,7 +2490,16 @@ int pci_reassign_bridge_resources(struct pci_dev *br=
idge, unsigned long type)
 	__pci_bridge_assign_resources(bridge, &added, &failed);
 	BUG_ON(!list_empty(&added));
=20
-	if (!list_empty(&failed)) {
+	relevant_fails =3D 0;
+	list_for_each_entry(dev_res, &failed, list) {
+		restore_dev_resource(dev_res);
+		if (((dev_res->res->flags ^ type) & PCI_RES_TYPE_MASK) =3D=3D 0)
+			relevant_fails++;
+	}
+	free_list(&failed);
+
+	/* Cleanup if we had failures in resources of interest */
+	if (relevant_fails !=3D 0) {
 		ret =3D -ENOSPC;
 		goto cleanup;
 	}
@@ -2509,11 +2518,6 @@ int pci_reassign_bridge_resources(struct pci_dev *br=
idge, unsigned long type)
 	return 0;
=20
 cleanup:
-	/* Restore size and flags */
-	list_for_each_entry(dev_res, &failed, list)
-		restore_dev_resource(dev_res);
-	free_list(&failed);
-
 	/* Revert to the old configuration */
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res =3D dev_res->res;

I don't know this code well enough to know if that changes is completely
bonkers or what. Maybe a change that gets zero as pci_hotplug_io_size
for root ports that don't have an io window would be better? Any other
ideas, or other information about the crash that I could provide?
Thanks,

Scott

[1]: Crash:
> SError Interrupt on CPU0, code 0x00000000be000411 -- SError
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.15.2+ #16 PREEMPT(un=
def)
> Hardware name: Adlink Ampere Altra Developer Platform/Ampere Altra Develo=
per Platform, BIOS TianoCore 2.09.100.00 (SYS: 2.10.20221028) 04/30/2
> Workqueue: events work_for_cpu_fn
> pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : _raw_spin_lock_irqsave+0x34/0xb0
> lr : __wake_up+0x30/0x80
> sp : ffff800080003e20
> x29: ffff800080003e20 x28: ffff07ff808b0000 x27: 0000000000050260
> x26: 0000000000000001 x25: ffffcc5decad6bd8 x24: ffffcc5decc8b5b8
> x23: ffff080138a10000 x22: ffff080138a00000 x21: 0000000000000003
> x20: ffff080138a14dc8 x19: 0000000000000000 x18: 006808018e775f03
> x17: ffff3bc1330d2000 x16: ffffcc5e3a520ed8 x15: 8daad055c6e77021
> x14: f231631cf9328575 x13: 0e51168d06a6cf91 x12: f5db8c23b764520c
> x11: 0000000000000040 x10: 0000000000000000 x9 : ffffcc5e3a520f08
> x8 : 0000000000002113 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : ffff800080003e08 x3 : 00000000000000c0
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff080138a14dc8
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.15.2+ #16 PREEMPT(un=
def)
> Hardware name: Adlink Ampere Altra Developer Platform/Ampere Altra Develo=
per Platform, BIOS TianoCore 2.09.100.00 (SYS: 2.10.20221028) 04/30/2
> Workqueue: events work_for_cpu_fn
> Call trace:
>  show_stack+0x30/0x98 (C)
>  dump_stack_lvl+0x7c/0xa0
>  dump_stack+0x18/0x2c
>  panic+0x184/0x3c0
>  nmi_panic+0x90/0xa0
>  arm64_serror_panic+0x6c/0x90
>  do_serror+0x58/0x60
>  el1h_64_error_handler+0x38/0x60
>  el1h_64_error+0x84/0x88
>  _raw_spin_lock_irqsave+0x34/0xb0 (P)
>  amdgpu_ih_process+0xf0/0x150 [amdgpu]
>  amdgpu_irq_handler+0x34/0xa0 [amdgpu]
>  __handle_irq_event_percpu+0x60/0x248
>  handle_irq_event+0x4c/0xc0
>  handle_fasteoi_irq+0xa0/0x1c8
>  handle_irq_desc+0x3c/0x68
>  generic_handle_domain_irq+0x24/0x40
>  __gic_handle_irq_from_irqson.isra.0+0x15c/0x260
>  gic_handle_irq+0x28/0x80
>  call_on_irq_stack+0x24/0x30
>  do_interrupt_handler+0x88/0xa0
>  el1_interrupt+0x44/0xd0
>  el1h_64_irq_handler+0x18/0x28
>  el1h_64_irq+0x84/0x88
>  amdgpu_device_rreg.part.0+0x4c/0x190 [amdgpu] (P)
>  amdgpu_device_rreg+0x24/0x40 [amdgpu]
>  psp_wait_for+0x88/0xd8 [amdgpu]
>  psp_v11_0_bootloader_load_component+0x164/0x1b0 [amdgpu]
>  psp_v11_0_bootloader_load_kdb+0x20/0x40 [amdgpu]
>  psp_hw_start+0x5c/0x580 [amdgpu]
>  psp_load_fw+0x9c/0x280 [amdgpu]
>  psp_hw_init+0x44/0xa0 [amdgpu]
>  amdgpu_device_fw_loading+0xf8/0x358 [amdgpu]
>  amdgpu_device_ip_init+0x684/0x990 [amdgpu]
>  amdgpu_device_init+0xba4/0x1038 [amdgpu]
>  amdgpu_driver_load_kms+0x20/0xb8 [amdgpu]
>  amdgpu_pci_probe+0x1f8/0x7f8 [amdgpu]
>  local_pci_probe+0x44/0xb0
>  work_for_cpu_fn+0x24/0x40
>  process_one_work+0x17c/0x410
>  worker_thread+0x254/0x388
>  kthread+0x10c/0x128
>  ret_from_fork+0x10/0x20
> Kernel Offset: 0x4c5dba380000 from 0xffff800080000000
> PHYS_OFFSET: 0x80000000
> CPU features: 0x0800,000042e0,01202650,8241720b
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

[2]: boot snippet
> ACPI: PCI Root Bridge [PCI1] (domain 000d [bus 00-ff])
> acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments =
MSI EDR HPX-Type3]
> acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug PME LTR DPC=
]
> acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
> acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configura=
tion
> acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0x37fff0000000-0x37ffffffffff] =
for [bus 00-ff] with pci_32b_read_ops
> acpi PNP0A08:01: ECAM area [mem 0x37fff0000000-0x37ffffffffff] reserved b=
y PNP0C02:00
> acpi PNP0A08:01: ECAM at [mem 0x37fff0000000-0x37ffffffffff] for [bus 00-=
ff]
> PCI host bridge to bus 000d:00
> pci_bus 000d:00: root bus resource [mem 0x50000000-0x5fffffff window]
> pci_bus 000d:00: root bus resource [mem 0x340000000000-0x37ffdfffffff win=
dow]
> pci_bus 000d:00: root bus resource [bus 00-ff]
> pci 000d:00:00.0: [1def:e100] type 00 class 0x060000 conventional PCI end=
point
> pci 000d:00:01.0: [1def:e101] type 01 class 0x060400 PCIe Root Port
> pci 000d:00:01.0: PCI bridge to [bus 01-03]
> pci 000d:00:01.0:   bridge window [io  0xe000-0xefff]
> pci 000d:00:01.0:   bridge window [mem 0x50000000-0x502fffff]
> pci 000d:00:01.0:   bridge window [mem 0x340000000000-0x3400101fffff 64bi=
t pref]
> pci 000d:00:01.0: supports D1 D2
> pci 000d:00:01.0: PME# supported from D0 D1 D3hot
> ...
> pci 000d:00:01.0: bridge window [mem 0x340000000000-0x340017ffffff 64bit =
pref]: assigned
> pci 000d:00:01.0: bridge window [mem 0x50000000-0x502fffff]: assigned
> pci 000d:00:01.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 000d:00:01.0: bridge window [io  size 0x1000]: failed to assign
> pci 000d:00:01.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 000d:00:01.0: bridge window [io  size 0x1000]: failed to assign

