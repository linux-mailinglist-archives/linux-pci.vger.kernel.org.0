Return-Path: <linux-pci+bounces-30491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C960EAE6310
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3E3A3712
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BE28DF22;
	Tue, 24 Jun 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="I+lk6Fvo"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022119.outbound.protection.outlook.com [40.107.75.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D940285CAC;
	Tue, 24 Jun 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762501; cv=fail; b=LpeBJvEKuRc7sU56yDps9e7vWBQVQ3RW1KB/8PWWyugh+oOwT/Qrp3+VasIQ4ydnrM4H1JptQ5J8t6o6J0ggY2WIQ3FDDzoVm9TfLYEUrO8dl0sRY8HyTcvkKz48SeDS/6ECNrYX8FfDNlfY+R5A7dDfWw3PgHc8rpm2bKbzx1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762501; c=relaxed/simple;
	bh=zQ8sxHrjxxBzJf0fZUosqc5aQagVQVr2ACWBMzw4nsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7wOodhttIjHIAtGp8jRd0zcCb1BKroCTc0Xnue2j1Z8AZcfoj6T+wZqRac15w7DRoZSayFz/ucEAmKD5yli8O03Rv2w0qxiBniqRYNe0OF3DiXmTFcluuQvviu8u+hilsMTRWUgNRJDXwdxCujMKUoU4on+w1EJesJnjxbm+90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=I+lk6Fvo; arc=fail smtp.client-ip=40.107.75.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFMfFm05Qpt7skQmU+oOOpt69QVJRVi4lcxYJzwnLNUIUGJtBD0wenEVXzf24QcGJsR9SlGoM1qCLDVboMaIoPtof+GwtmcSWdXx8kQytTefeVmGWZAaEBpqwkVNxjjmJWodeNyVmJBmjSzFSGMDIa1U6UfvQ+Z3F+TlofLjDhG6tZXg4PAeow0PhrCwgSwjbAtFqNxZCZj3WuDD32q+FpFCT0nPMekPQzBWHdsROPrL/Eaq1H7MxKg3xzp6ZKZx2ZmXgrt8gpgh41TNxg/nwl8KXqUsduSn3pvrRB+MH6zV86RBT2wvnUeAUAYl8qqrIMYV2qL3DBqiliGDIPUuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ8sxHrjxxBzJf0fZUosqc5aQagVQVr2ACWBMzw4nsw=;
 b=D7+0cBS388YDbWM92LK9A+XCcbmaGwshUM8LcdZn/oQRkzHcaVl+0JKkRRaOagFSnDSDi05FMbI7il/97EHTyGc9tdzJ++7f+WOzH1dx0f8s+HSRHG2Lrz5fs+DvOtj/wnAZSz2m56WvTDOx7nu7GdrcCS770o8xdp8+21HKbPV4D9VU3HSXI4yCS61WZt9WqK1M38/AaTvsJZ7UVk23iC3OwES2uY3yanFiqlmJVqOIm1VGxPGMw1EoepoLOhheDsX3rvMnlOOxIZaPZ8OoAv9wii6EhGz8EBWMPmc1JAlEzlgiJVsEgkRMO9f0K/OYt5OEjjKdwRciaakPSDVt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ8sxHrjxxBzJf0fZUosqc5aQagVQVr2ACWBMzw4nsw=;
 b=I+lk6FvocF0rF1CXpkbiFzclsAKoR2kG4LIjGlUOs2PW2xlaXpc52T/7L4JCB7TO6gbEYUUvyxDwu1fDSitaJqbY5hDRv/IX2zmaRZqtHVoLNjan5S8vHPY6sv7eGYEKwpsefR5t8m99eIyRriVh9xoj/Ue+zRgVC6ldYZiv7Qb9gkGbkJZWcXXEX72OedRxuiX4iRB4xD0bbOH5ekFjezy8GJtA9PtktLNtyGOYhjUuuSVkSw9houXmvWGzdcPgz7FnigMn8QwaWp0niODIZrkG97lWu+GOn9j/k+vqSrPXlVsnbgKnS7aVYhIh0vRaY/Q+B4dZAAo2d8Oc6uHEZQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB7069.apcprd06.prod.outlook.com (2603:1096:101:1d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:54:52 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:54:52 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
CC: "elbadrym@google.com" <elbadrym@google.com>, "romlem@google.com"
	<romlem@google.com>, "anhphan@google.com" <anhphan@google.com>,
	"wak@google.com" <wak@google.com>, "yuxiaozhang@google.com"
	<yuxiaozhang@google.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSCAwLzddIEFkZCBBU1BFRUQgUENJZSBS?=
 =?utf-8?Q?oot_Complex_support?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggMC83XSBBZGQgQVNQRUVEIFBDSWUgUm9vdCBDb21w?=
 =?utf-8?Q?lex_support?=
Thread-Index: AQHb3BN2vR6oymJpE02QgNNVwAb5JrQA0AqAgArurhCABjx8gIAAJisg
Date: Tue, 24 Jun 2025 10:54:51 +0000
Message-ID:
 <SEYPR06MB513431182C323003B6A93E0C9D78A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
 <7178e816-4cb4-49b3-9a1e-1ecd4caa43ed@linaro.org>
 <SEYPR06MB513414A5AE38EE6749A2902C9D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <754d260c-1a31-494e-af06-49f6aae1813f@linaro.org>
In-Reply-To: <754d260c-1a31-494e-af06-49f6aae1813f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB7069:EE_
x-ms-office365-filtering-correlation-id: ea3636b5-0977-471c-fa20-08ddb30d8be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHBqdkJEeXQzeUNKcGJCRnp0KzBQK2FLb0FRclRMZTE3VmhzWFVrOXZHaURy?=
 =?utf-8?B?VDFCcUJ0RmpEYkNPakZrZVRYY2QwZURiVi9MdXdmcGR6TUV0K3MxY3lSOGlZ?=
 =?utf-8?B?M0VWV1dPLzVOcEI5RTNMcER3anhJbkI2NW1NR0U5cE1jWkRGRVphUTJqaE9n?=
 =?utf-8?B?N3l6cDA0MVA5M0lzMk45cEhQbStVREx4K2pvTmFmVnRLUzJOd2NBallTWFYr?=
 =?utf-8?B?djltQ2lnWVA4STdSWGR4TE5keDlsRkJLWjhYY0Q1bHBKc1lqdER0OXA2WmlW?=
 =?utf-8?B?UDMySTM3bWg3RFZ6b3lkVkFlS2hJdExIci9IQjBwMjRiekRXbkJGWXZXZWZ1?=
 =?utf-8?B?Y0thVEpVYjBYa1BHMHoxZWNxMEVhY0V1eGVjcU5vN2xNczV1RkZEL3dGVDkv?=
 =?utf-8?B?dVprMUZMMGd2Tkd4QUZ6b0RzZTZiZ2taTWhGTTMxcVAvTEtjOTBabzcwM3Ny?=
 =?utf-8?B?eXdPdGl4OTZDTFArSE9FaVNoRU1wVVpQdXp1SUliRFBLTFhRZWtuWDd2c2x1?=
 =?utf-8?B?WTBEejBHRnhuUDJTNWtkTGNrcld3VjhlWlFDamVKNTNxbXp0eU1GeWFiVm94?=
 =?utf-8?B?VmJQV1hjazlaODJHS0JHY0ttQnRsemVCUk5jbk8xSElvYTJUR2JiSzNMOEdJ?=
 =?utf-8?B?WjJHdEppa1NWRHpZN2FLKy9yaC9YQkRjVnhOQWRPckVEelNVOHBaTWNBNi9u?=
 =?utf-8?B?ZGNzUFZFZjZneEZzZ1FCOWpQdk5sQWJmdEN6VUw0QU5jMCtYZHJOU2F1Sy9z?=
 =?utf-8?B?OHhEdE1PbnZxbjFPQ1R4em8xcHp4OVVOTmwzVGJpa3pDQ2ZGcnpYM1ZwdEJp?=
 =?utf-8?B?MzNERkN3Mzk1bVRPcUkzM3BXNFVhUzFRUEx1SEMzNVJqQmlIdkhlTTJMUmZ1?=
 =?utf-8?B?WjJRRHNJWDRKQXgyY1IvNkN4cXlqcVVyWC9pNENWR3ZQQ1ZVQ0xWL3NXeUZE?=
 =?utf-8?B?QnlndVQrbjM4ZTFMc1c5ZDVuZXhlWkpMYldMejdCOUxSK0JZZ2FSTzlUM00r?=
 =?utf-8?B?cndGUGlrU2FEREVwbWdWdjZvSUZhYk12THNubzBLZlU4ZkVGazAzZEV3dkEw?=
 =?utf-8?B?MDgyeU5WM29mR2RaUXlXNXVmTzh5cnpZTUtySVRBSVdQWVdkMXROUVdGbGxo?=
 =?utf-8?B?WDJ1SkZEMVU4M0ZIaUF2RjhCaW43WXk1R0hmdDFCWWRMb0tWYlhJNFNoVXRH?=
 =?utf-8?B?VEFZbS8ySTBwTmlnSjV2UjI4aHNqdzRORGZjSjhXVlhWMHVLQzJqSjY4VEU1?=
 =?utf-8?B?cFlKUElUTFpaTlo2d0ZjdXE4SnNGSVM1bDVpNkpocncvMlhNZ1drSWV2TytY?=
 =?utf-8?B?UDBMZHhLTENjRjBvcHQ4cTNwZlo4WEU3SXE5bkxkY3BRSFpkSmNGOHVZbnNS?=
 =?utf-8?B?ZTE1OTB2c0o0czA0VjJtRVRXcXRldkk1cDM1SkJkczhMM2Zub2I4S2tEeTc1?=
 =?utf-8?B?SW5JbmEwK1dOdWgwMEVxYWVQcXZXNk9ucnBSN3NvMlBVUlFEWVlJTE92ak1r?=
 =?utf-8?B?RlQxazk4NmNYYkR1TWRYR2V2Q3I0QVlDMm5MS3FnekJiR3czK3pKUGhLSGpv?=
 =?utf-8?B?ZSs4cHBxUVpoUXY5L2hjckJCL2hKY0hoNkxXa1o5eEtFVGIvd0Nua0N3QU5P?=
 =?utf-8?B?eUd4UEdBZ0NPVUI0R1JIRUYzbm45aXdDSFhPOUpjMmxkTDQ2STVMTFN4cUJC?=
 =?utf-8?B?NlU0YkRpYldRTk9MSUxnMjhIN0lVZG5VdDlOdWRrb3FISWVXWVRpS3U3QVBj?=
 =?utf-8?B?ZFpsQ28yREVWSStXR2xFQW1KWU9hNTJNWGxKR2cyVWFFSE11eDRQQ2hpQVRX?=
 =?utf-8?B?ZUROemFxV1Q1WWJ5NE1uSFhpOHg2M2JPN3hYZE9TTC8rbEVVQmZWMnBHVnBZ?=
 =?utf-8?B?YkdlekFheGpndUdSR2IvRWlyYmZBWE5zbkZyb2pmVE5aMlY1UmJPUnEveDY3?=
 =?utf-8?B?TXpkbW8ydFF3SzZEc0Z5eEptQVhQWjBoUE0xZFlCbkkzMnpCYVJCWkRvTTNn?=
 =?utf-8?Q?jE6VkvgSr9KZIG6WB0sG4D8lMVztFo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDI3NEpNSW9sNXJudVJMWFZuQlNCN0d1WW1sY2xFZlB2RU5Jd2h2V3dXL1c2?=
 =?utf-8?B?ZnlmQ2EyeHUvWVc1OFcrR2lsYjRmRVZRdzNheXEwWGl1QjM1Q0xrZ3hsbTZW?=
 =?utf-8?B?V3NRL3pIUCszVHhkL0Y2NGpXNHJqRHBjWHFvcXB4WkpwSlpXTWNkNHoyL0hX?=
 =?utf-8?B?T1lXSkFZb0Q1anUzeXFYMW42czRnRFRNUGpKaWpLN3hRc3lpWWVuQTVQNmdT?=
 =?utf-8?B?aGYwMGU3M0llK3FCZUtkQ1B5ZHhHWUF0RlRvNFBYOXBFRnJzMFhMRkM0Vm9s?=
 =?utf-8?B?Z2tWT21qQnBSWnBZbnY2eTZDWEVqTkxMMWxpdVZLa05MZ004aGtCcXVaOEhJ?=
 =?utf-8?B?cTlqcUZKK010cFloeTl6S2c4MGd0OEJsYm1QYXlKS053V0VHaE1qaEorKysr?=
 =?utf-8?B?bVRxZmVSRTdHSFA3WGFIYzFIV25VVStkaWNuTWJ5ZVh6SVMzNnBtSlBBamN4?=
 =?utf-8?B?VWhuZlpFRVBqZjR3ZitRYXlGbS8xbmc2MVRuVEw3RUhlc0Z0MjViUVNFYkdq?=
 =?utf-8?B?WmoyU3dYQ2J0WUxyd1c3a20xTFhCc3kva1Y1L0g4SlBxQUNLLytQdnV2RXlS?=
 =?utf-8?B?ZXo4ZmFYdGdzSGtUSTMzZlJkSm0rOUdLOU95Yk1sK2dha25PaUpkdjR1c21k?=
 =?utf-8?B?REs0OHpKdmZIQm1QUUFaNzd6MFU5YnBoazlaeTRvTVRMRk52Yk9QRmZpWFQ3?=
 =?utf-8?B?YktLOVBjQ200Z3FXemdpVVU0Y21FRHJPVWFrcGhCdXVIWEZYY2NoalBUbzRt?=
 =?utf-8?B?TUs0bnpOV1RUTE9pTmZHR1kxdzZ6THhZZ1o5eTA2RC9JK3hjQkFzdEs4bW5H?=
 =?utf-8?B?VjNCLzJrSmpJUm5COXNPU1ZTelpLUnFUSXEzZnJSRzV4WVg0aHRCQld5TlRo?=
 =?utf-8?B?QzdkYnFZUWdVeXlYcWhrSHNKUnd4UWNWeFVzVWkwY0lwcnBvbzI2RDNJQ0tD?=
 =?utf-8?B?d3ltWkZPSGE1SDdQcUJ5UXgzNXp0T0RPVk82RjlqMDd2NkVLQWs5bGNGbS9n?=
 =?utf-8?B?VHVhRHppZk52ZDJYeDhEQnJXZkcyaVRuOFd6ZW1nQTVoRlJSQWYrdWJEZllY?=
 =?utf-8?B?VnI5TnhEOHlURGNOdUJNRjE5ZG1qcmIrYyszVEFOMThoTU5kK205R3pqOGpk?=
 =?utf-8?B?d055aWUxV0xKMndVaERYMndwblE1UE9KVFJ2cE5HcHZJNmZEWmQ2M21hcklL?=
 =?utf-8?B?c0x2UUx3YzZpQnJLYVBNWldkcHJRTnEzZVJCTUNSTkh4S2FMd2xtZDg5dTBh?=
 =?utf-8?B?YW9rd3pjY3hFaSsrbmtSWXB5U3JNaEpaZ2lsNmJ3UjRlUEFOVWdaTnIxYllk?=
 =?utf-8?B?NjBYdk90dGQ3RWNsbGJPajVyYlFPM0ZleEpvbFBBSitlWVJrRXNnR3JnbmhY?=
 =?utf-8?B?N1VxelhXQkdTYXc3dVVLakdXNThTT0VZNW9aMzRhWXVtNk9xNTZad2lyWks3?=
 =?utf-8?B?SFpXeGdyNXRaYkt2R2NnaWYrbG1yaVVsemNvbnFzSHV0Sk84aFBobWtOWUZK?=
 =?utf-8?B?YXYxWm9IdElVTGtTaGt3TUVLVUtHR0Z4WW03WE9JY0tUcy9jS0s3czF2cmdi?=
 =?utf-8?B?SHJkME9jdjBSbWtXWXBiTkJqT3dlbUhFWGdyZ3E0WnVleTlHYURMaFBuN0F6?=
 =?utf-8?B?U285aTNHOXlDUktOOUhhWithV0h3dk9rVkd2NklIUkoxUXpGMFRFMTRlQ1JK?=
 =?utf-8?B?aFRONHpNU2d5SURMZTV1bkFoQzBYcmh1dWlZbStLZmdoTGRxUVhlMnRaZ0w0?=
 =?utf-8?B?SHNyb3hTSnd3dW8rN3V2OFRTUVQ0eTI2MjFoa3BZTXYza3ZSMWQ1YXBBNEll?=
 =?utf-8?B?Z000MHBBejEyTjFGNVB2YkRXcE04Y0hGaGtYQjduWHVUVXhkV1Z1dFJ5aGpB?=
 =?utf-8?B?dFZBazMvd3BVK0c4cWE3YngwSkw3czlZSVRJY0MvWVh0cXJxZ3FWUVByZ0Rz?=
 =?utf-8?B?NkRWejhSSkhkT2FwdVRjTjdNLzFQa3IzUmRsT3BGR1hTQWh4SnllSmRxSlFo?=
 =?utf-8?B?amRUZ3pRT0JVS1hhZFZEU1YxODlNbURSalIvRnZFMjFMbWVPZjdrS245RS9n?=
 =?utf-8?B?SEhEWGlKZlZqZDRYQklMWnl6TXB4UzdLcWh2NVUrMjQxN0lFOW9TS0V2d1NJ?=
 =?utf-8?Q?JsD8lrG4Kyh74KHc+S9c4pKZ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3636b5-0977-471c-fa20-08ddb30d8be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:54:51.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHL3QNVXX/LH3SeoHPKajsFld3nHCiMTMjVrwRpBNw7hCBn8oq5jbSTWgoI6qupl22vseHtEoZAeMLNgRTZmVQrB5dfVw4O0dfB1TGUEWqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7069

PiA+Pg0KPiA+PiBTbyBpdCBzZWVtcyBhbGwgUENJZSBSQyBjb2RlIGlzIGJ1bmRsZWQgaW4gYSBz
aW5nbGUgZHJpdmVyIGFuZA0KPiA+PiB0aGVyZSdzIG5vIFBDSWUgUEhZIGRyaXZlciBjb2RlLCBp
cyB0aGVyZSBhIHJlYXNvbiBmb3IgdGhhdCA/IElmIHllcw0KPiA+PiBJIHRoaW5rIGl0IHNob3Vs
ZCBiZSBkZXNjcmliZWQgaW4gdGhlIGNvdmVyIGxldHRlci4NCj4gPj4NCj4gPg0KPiA+IFllcywg
YmVjYXVzZSBvdXIgZGVzaWduIGluY2x1ZGVzIHRoZSBQQ0llIFJDIGFuZCB0aGUgUENJZSBFUHMu
DQo+ID4gVGhlIHR3byBmdW5jdGlvbnMgdXNlIHRoZSBzYW1lIFBDSWUgUEhZIGFuZCBhcmUgbXV0
dWFsbHkgZXhjbHVzaXZlLg0KPiA+IEFuZCB0aGVyZSBhcmUgZGlmZmVyZW50IGNvbmZpZ3VyYXRp
b25zIG9uIFJDIGFuZCBFUC4NCj4gPiBUaGVyZWZvcmUsIHdlIGRvIG5vdCB1c2UgYSBwaHkgZHJp
dmVyIHRvIGNvbmZpZ3VyZSBvdXIgUENJZSBidXQgdXNlDQo+ID4gdGhlIHBoYW5kbGUgb2YgcGh5
IHN5c2NvbiB0byBzZXQgdGhlIFJDIGFuZCBFUCBkcml2ZXJzIHNlcGFyYXRlbHkuDQo+IA0KPiBJ
IGRvbid0IGdldCB3aHkgYSBQSFkgZHJpdmUgY291bGQgbm90IGV4aXN0LCBpdCBjb3VsZCBiZSB1
c2VkIGJ5IGVpdGhlciB0aGUgUkMgb3INCj4gRVAgUENJZSBkcml2ZXIgaW4gYW4gZXhjbHVzaXZl
IHdheS4NCj4gDQoNCkluIG91ciBkZXNpZ24sIHRoZSBjb25maWd1cmF0aW9uIG9mIHBjaWUgcGh5
IGxheWVyIGlzIHNldCBieSBIVyBkZWZhdWx0IA0KdmFsdWUuIFRoZXJlZm9yZSwgd2UgZG8gbm90
IG5lZWQgdG8gY29uZmlndXJlIHRoaXMgcGFydCBieSBzb2Z0d2FyZS4NClRoZSBhc3BlZWQscGNp
ZS1waHkgbm9kZSBpcyB1c2VkIHRvIGdldCBzb21lIGluZm9ybWF0aW9uIGxpa2UNCmxpbmsgc3Rh
dHVzLCBCREYgbnVtYmVyIGFuZCB0aGUgbW9zdCBpbXBvcnRhbnQgaXMgd2UgdXNlIGl0IHRvDQpj
b25maWd1cmUgdG8gRVAgb3IgUkMgbW9kZS4gQXMgSSBzYWlkLCBvdXIgUENJZSBkZXNpZ24gZXhp
c3RlZCBFUA0KYW5kIFJDIGFuZCBpdCB1c2VzIHRoZSBzYW1lIFBDSWUgUEhZIG9uIEhXLiBNYXli
ZSB0aGVyZSBpcyBiZXR0ZXINCm5hbWluZyBmb3IgdGhpcyBub2RlLg0KRXZlbnR1YWxseSwgSSB0
aGluayBJIGRvbid0IG5lZWQgYSBQSFkgZHJpdmVyIGZvciBjb21wbGljYXRlZCBjb25maWd1cmF0
aW9uLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

