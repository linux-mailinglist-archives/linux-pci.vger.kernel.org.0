Return-Path: <linux-pci+bounces-16095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6226B9BDBC8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 03:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8404B223A9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 02:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF518E025;
	Wed,  6 Nov 2024 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P5Q4uUnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2074.outbound.protection.outlook.com [40.107.103.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321F18EFD0;
	Wed,  6 Nov 2024 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858775; cv=fail; b=VAeiojF8PsePCLCrmf0B0o0Wkcec9bUbTuOE3vrJXFg26CYfmpGbf4bW7N6xTFxkRWN/qH9in0b7M/aFEmZp5D6FXbmkAKByF/LflTQCFjK2OqxhtoWxEXF7qVStxmheo3wTMRBciIT82K2sdyOiVHquADzuPY/xbBwd3S6VbJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858775; c=relaxed/simple;
	bh=MZAH+65QLxQKerp38HMWcvOKvp0MmKyDE4gpjdgVF5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LkI27wQzFUXBKP5f8tTxJRUlakQD9HtkrbFi//Vhlu23fAk71OW5kMKx5OkEUpSqybnTB4GfW4ut9Zs8N08y+pNeEFKVaEtEZeQLbysSlcQG/CzU2qrFrKWMV9+o5CiwFwrFhX1C8hzqLHc09k7N6mYdr3LyWO+Yp8Kdj1Y/pJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P5Q4uUnv; arc=fail smtp.client-ip=40.107.103.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syfM9a3n/6/uoM9ntDEVRemQkeDOVlDuPZCpVG1YTPNal03zXx31KL0PlRDkywTQep6lojnwqyg8icZpVwV8TgOR8IvMrGq+sZNF76tYW8XJ2ZvvMHS3y4nD50SFFjhG9F/hpnWxcMZJUNaeS0mAK4faZD+/ndqssEeCk4XZoqqtAB1p6pJ+zZlI4WQkPZ8kSBVLbx/48CY+qtzDTpquvT2Qk6tUSRnAms1e8OFJVHvpnyzQQDYo8hj/+VZI0AjzNT+zm+4xYbeii3OC4GDiOBjIXepyMwJvEX7ocH7VjmOo50ggPhi0apTxzBjnaZA8UhXmn72VXpWnV76od16u6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZAH+65QLxQKerp38HMWcvOKvp0MmKyDE4gpjdgVF5Y=;
 b=dVJScLzDA0Uqq0rydzCwtFswPiO3YmjryC4Bw3OBkFyF1ApB0QsehFk1P/HrqnlpU8n71DaqoTiW2M+LTuReMXdkwNQ5RGv9vj1nsGfSqPgJRiBQKp9pPw8LzsdbbXQ8PjNdj2ZniaySd4W7IxsemKje16L1Id+BE8FjPG6MmvBOUJyshPDh5M9tuqDctDTjC8myjAtUGCRc6royS8nn+lJDR9w4OHT8V+A4WtMrwWF3NC+UPTkC0DVMDT2UL6mHTCTxDi6a9LSNwtIgtPoWLNk8dmzGwbUi61HQHJHXZ5VpiZbyaWu/FRzRwHUz8QgJSX2O37UHVrzfVY3+tUnGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZAH+65QLxQKerp38HMWcvOKvp0MmKyDE4gpjdgVF5Y=;
 b=P5Q4uUnv62Gqy8CDhdZ2xCF47DSBqu45njzNjQg2XdlFrQkeF+dhtz/10sIRWtrGiRCxTmVmSx7iPICmk8jeg5DaYGA3qMeTfijYoQRrF6RVPlitYmxODiMXDR/Uhz7F/tIqGWvFNiko6rp3HIphhMfDbnTvDy0vAVeMItari1JS+N+4MJie1hrnz0DElLlmCsqqKoZ+Y3nj2WKWnmiblyUOr60R8FPtEabAyL1vv/RoF6Wn/I0v97WMSUcemBtCKaVt33Codd4/fL4T1QJ4eqVRefuTFa7quK3H/anAjUbTG3/bWpclFoDd5EsqNqG9wErHlGvMjScO4IgTjYImwQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB7170.eurprd04.prod.outlook.com (2603:10a6:208:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 02:06:09 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 02:06:09 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index: AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKp/raAgAAoaDA=
Date: Wed, 6 Nov 2024 02:06:09 +0000
Message-ID:
 <AS8PR04MB8676592EF1D6F2BDFA2348A18C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>
 <20241105233513.GA1495684@bhelgaas>
In-Reply-To: <20241105233513.GA1495684@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM0PR04MB7170:EE_
x-ms-office365-filtering-correlation-id: 8cc8a8d6-fda6-479e-f4a7-08dcfe0794e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dXB5aEI1Z3dPSG1tMHFoNTV0ZENiQitnaG1BbEN5MW4yaDg1ejlwdlZUWitZ?=
 =?gb2312?B?RnFsVnlQaWZnbHpvZDhmOHRKMHMvWUNWN1dKV3p5aEY3MThiN2p4SktTVENU?=
 =?gb2312?B?aVJQWjFRU0pFaXJVWEFITHRjUWVGUE1JTFlwOVd3SlMxc1o4RmIrdWkyUERk?=
 =?gb2312?B?cjVTMzJZUVpaVEs0VXJldzIrWGNrL3FIa05mNEorWlRTSnZPcE5Qa1F2UHIy?=
 =?gb2312?B?SFNrTm5tRHBFQU1kdkFUNnlBSmVxQ1UvVWM4NkZCakVjMFRZZ3YzUHZCczFL?=
 =?gb2312?B?NGNWanNFdjA3UXBzUWxQTFJPK3lENURFeVE0MGxtUzFCaVNIZ2NBZ25vazVO?=
 =?gb2312?B?UVdHSlhWaHJNdjFMZi96eXIweWpDbGFtZmV5VUJPL0puR2ljREJRUkJsdTFT?=
 =?gb2312?B?d2cwY1NZU2ZTZTA0SEdSbC9IeE5mcVB0ZXllYTdPUEt1c0F4b2JsdUFtMjEy?=
 =?gb2312?B?UzZBMHc3ak9raFNzbFRPN2VZR0NQTTBBanlQZ0hmY1BERGxTVC9DSmZCYXlu?=
 =?gb2312?B?QmxOaXhCYjZ0WUUvdE9SclZ1SStuZ1dDeGFNTVhQT0ZESDlQMkd2dnFvemd5?=
 =?gb2312?B?U1VNUnQyTkt5ZUlGR0ZmWjdHa3pUNVlVdjE4eXJFL3RKV0Z2NFdGUnZTNWNJ?=
 =?gb2312?B?WnRUVy9ocVJXZXd3SFpYSm4xYWhadEhxNmNOTlA3ODRMUDJjbHhCb1lvSGhp?=
 =?gb2312?B?V1Q3WlppNUVPTUVJVkpFMXN3bUpGanFiRUh0cG1YQ3V4K0NqelVGQVNVUHo0?=
 =?gb2312?B?RzJtdVZnNE9PSkk5ZWRxRzBZSlhoTFZuWWRFRzBPLzZQWE5CN21EdnpCRFR3?=
 =?gb2312?B?NU1zWmVWb3JtdkpPRkdJcjBadms3UUNIYW9QbWdENlNFbm1La21HaWZ4b21n?=
 =?gb2312?B?MzJtdG1wbGJwYktBQVc3OVltcHdwcm9jTmlzYy9aT3BhUkZsOHFQbWFZam0r?=
 =?gb2312?B?MHRFVzBjOVh5RzFqeTVzZkE1RlduN2FzYm43c0N0WUY1aGhBNWsxMUhvTUNy?=
 =?gb2312?B?bGhxQUZjdXp4TVRnQ1pkZm5TVDFTM3hSYWViK1dIUU15c0ExanNmd2crMDBp?=
 =?gb2312?B?SE1scEVGeUY5ZXMxN2lVRy9pdGN0QmxVUjRzZ0Vsdm5SN3JjUGhqOU81WkNi?=
 =?gb2312?B?aHZlQUVTdFdLNkFvSXo1Um5FcEJHQ0R3cGpTMWhLODg0MjhQck53VUFYemky?=
 =?gb2312?B?WmVBb1RuRGRRVzBuYVBOUGtCTzFKSHcyS2JQdmJuRTQvdjkxMWVWa1Y1RW5I?=
 =?gb2312?B?TjFYSWVYa1ViQkFPTFZKVTRyRjNDazFVVWROVThXM3U1d1ppZzJwN1RQcElj?=
 =?gb2312?B?cU9HdGFaNThxUG5lNGp5NkFBZ0I1TjQ3NjRFc2o4bUFtVlNKYlhwQ3NGbE1C?=
 =?gb2312?B?bTZkZUUzVStldEk1L2dROVB0amtWYU5NWThJb3pSaGk0amg2RzFSSjA3cWNF?=
 =?gb2312?B?bGxWemxxZUVFVE5sYlYvRkI5VVBkQytXaEgxZDN5Y0Q4K1NJRDhDQ2ptY0Ja?=
 =?gb2312?B?cTllQTRRTTloRm1YQ05xQUpYYzJMci90cGFtbk5UcW9mSDdBeTlZb3ZBblZx?=
 =?gb2312?B?Lzh0NFJiMXh6M1lXWDd1b0R4MVh1ZmtjdmdpbkhBbU5Ca0ZRS2dzWE1TVS9r?=
 =?gb2312?B?MGlEcE1IWC9tM3hrdTJoVHdsMEU3RGdESFF1L1BuTkdVNlFJQ2RaZjBGUXhv?=
 =?gb2312?B?OElmcWdRNWlRWVhOZmNwUzd3N0ZNbHFRVEJLVDRwWmNJeDlvdXpFSGxZeENU?=
 =?gb2312?B?eWFNOWVSVnZkbHNCVUlYQll3NUduemROSmkzdVFHOWhCNEhnZEhlN21VdEJ6?=
 =?gb2312?Q?zsr/x5000hpk1b4UdHs2sflfKvKTijd/NEDwo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q21hZDNpN0pha0wzdEhpd21XNEtnNGRTMHNTc1BFcmtHZHVRWmUyQkg3RkZP?=
 =?gb2312?B?eE43S1YwRFpCMXNuZWo4TXhhK1dkNk5QbEM5Sy9mT0dqaytoWHVoWGwwUzBE?=
 =?gb2312?B?ZktpdWh0VUw1ZEdld1RZV0Noclg2c0o5L3dGbG1tU0ZTTm95TmcrazUwbGdP?=
 =?gb2312?B?cDE2NStpVnQ5endDMmlMK1dFSklYVGlUOU5HemVkM3dRMTJ2SThjY3dvRnJE?=
 =?gb2312?B?SUdVOG5sN25nN3RPT2g2K3U3K2FJK3Y4aTlOWmdXNENJRkhpQXZJd3NWRmtM?=
 =?gb2312?B?QnpLWTlCc3FrOTlFNklSQWw2eWRYYUMrUXNlcVdtK0NnOGNnZEh1TFJ5WlYw?=
 =?gb2312?B?TDNPYnNNM2pHV1FSWFBQZktNNzhEb1k4SVZFdFl5RTlkelJKZGdVVEg2LzJa?=
 =?gb2312?B?cU5zcndNTWNSUHRUbHNxVHNPRUpGSGE3dkhEckl5QmF3MVlBZlhSaFVjeS94?=
 =?gb2312?B?ZE5XVEpOVEFZRUluYndnQkhlSzdIZ0Z6UG91K3NQUXhIcnA4Rk0rRlVxQ2ZC?=
 =?gb2312?B?ZS9kSUIyNi9kaHFvWU4xVUIzbXZUdGk3eTR5L0RwNkxCM3dpLzRTU2ovWHdC?=
 =?gb2312?B?OSt6bEhYV0dMcy9OZnJyM3A3MDZySkpEcGNlY2tsL1ZacnBFZCtBODlKWGM5?=
 =?gb2312?B?Vm5LSzB5ZXVJK0JqQUxFQk50WjZGSWo1YmlabHo3QTlndWpZMWFhNDFZeGF1?=
 =?gb2312?B?cHlMMUhyd1I0WXB3eVBEUVRyUGNsbDgyM3NsRWR6RzByMzhSeHd1TTVtOW42?=
 =?gb2312?B?Q1ZjWVF6REYxdmlNb00rVXFJVTF6S3ZVT1VhWmprL2J3TFRMSjZzWmZxMkta?=
 =?gb2312?B?cG9jd21kQmxpaEc3elhxSHh1Q1J1OUhYTHAyc1BsVnNJOEo4WkJZWFM2NXNz?=
 =?gb2312?B?ZW9SNjBTcHRxRjZXQVArU0hiaEQrUDgvZHR2K2o4R3U0ekJRR1FmS0NwSlZy?=
 =?gb2312?B?TlcvZVpwVzBMY3M2U0d2cjI0MjRyTHAveHJIL1ZCS2VmcjJIelNBZTBRSi9Y?=
 =?gb2312?B?M2VRMEtTQkIrYUZ3a0pZMHVrcnFYbWpFcFdYSWlHd0t0S0l6WVp1dFg4M25a?=
 =?gb2312?B?ZEtvWnIrWnovckZjVDI1VHA3LzBIRzM0N040WDJuc2RaMDIrT1dKaTB4ckxa?=
 =?gb2312?B?V3NnUXBiSGtYSjhmOWJ3NVVkUlZVVFJ5NldLTkNQN2d0em5sVElER3pRbE9o?=
 =?gb2312?B?d0tzc25GU01CUHExU2pSTkdXN3R1Si9EaUhqOStRNnNheFNvTkJlVWxCdXFy?=
 =?gb2312?B?UUJDaUdaUE1uZ3RMNEtqd2JPL0lxYXdOTEQzY2NSRDdpQS9XdEljYlNwR0lS?=
 =?gb2312?B?TGVOajA4SXF6UDNWQlR3OG9FVEx2c2hYMk5TU2RmRzVUaHVubGkybm5iNU1G?=
 =?gb2312?B?MEtJald4T3d0MGhZNXpzMVd6dzZFc3lCNlZGV2Rvb3h4b3JpaDcvQlk5Z2FB?=
 =?gb2312?B?aUZTaEJteDZLK0FnempBOEU1Mzk1L0xxV04rRGFMZlA5d09nS0pvU0pqWkho?=
 =?gb2312?B?c1Y1VXAzemJzVkZsNjIzbFFhS0Vmb3hBY0JkbDJ0cDZjcE95RWZDZHhueTFy?=
 =?gb2312?B?MTJGbXR6WERza05VTGlyR3RVQ0d6SXpoWXVBTW5IRGRHL3o0aHRYSjJNQUNV?=
 =?gb2312?B?VkpTR1RqZGF5dDFwaXA2TFVGVGdOVzRPZld0SVpmMnZOcjJkaWkzbDJJNVpX?=
 =?gb2312?B?V1JtR2kveGlGTXNPSm1waGRJTlBaYVYva21RQVAyaUs5MkdTM3dMYmRxeC9Z?=
 =?gb2312?B?QUJHaWxIR21DNkNqY0NoRENrdzdLM0lmenYzOGlacklLcXJ6K2VzY0RKSy81?=
 =?gb2312?B?cG8yNU5SQW5oUTN1SjJRZDVNUjloNWxuWW52Y2ZUUGh0QUwzR0RiOGRYNkw3?=
 =?gb2312?B?R1JnVXcxeTRGUHB0QmR5b1RWZGZQT00xWkpUZVVPazI1dTRCRkVCbC9DcEFF?=
 =?gb2312?B?RjBsaTg4dDY2RWEvMW5EM2xPcDdwNGRxK3N1ZXRjSFRsTDl3NWJmWXpXaStZ?=
 =?gb2312?B?UmQvNitSYmFOeTViYlJaU0dVK3M5Y21IeS9md0lodDZKSlFFcVJjTlpEeHQv?=
 =?gb2312?B?YzF2OW5yelhtV2FMZ1k1dHZSekdpUklYS1ZrZ0VIYzlHRThWTG9xbGJyQlZD?=
 =?gb2312?Q?AYgtb/JLv3me7+yuwO5Bl7lBN?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc8a8d6-fda6-479e-f4a7-08dcfe0794e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 02:06:09.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJB2W8S9oFnhaBWYlaNyYw1+22t+kHRWDA9o3Hh4ptLC4zw2vz5rYgEJ+/sCrHFIqe/ZVdtOaMLU390pdBEZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7170

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEx1MI2yNUgNzozNQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGt3aWxjenluc2tpQGtlcm5lbC5v
cmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IEZy
YW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbWFuaUBrZXJuZWwub3JnOw0KPiBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgaW14
QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGR3YzogRml4
IHJlc3VtZSBmYWlsdXJlIGlmIG5vIEVQIGlzIGNvbm5lY3RlZCBhdA0KPiBzb21lIHBsYXRmb3Jt
cw0KPiANCj4gT24gTW9uLCBKdWwgMjIsIDIwMjQgYXQgMDI6MTU6MTNQTSArMDgwMCwgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+ID4gVGhlIGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpIGZ1bmN0aW9uIGN1
cnJlbnRseSByZXR1cm5zIHN1Y2Nlc3MNCj4gPiBkaXJlY3RseSBpZiBubyBlbmRwb2ludCAoRVAp
IGRldmljZSBpcyBjb25uZWN0ZWQuIEhvd2V2ZXIsIG9uIHNvbWUNCj4gPiBwbGF0Zm9ybXMsIHBv
d2VyIGxvc3Mgb2NjdXJzIGR1cmluZyBzdXNwZW5kLCBjYXVzaW5nIGR3X3Jlc3VtZSgpIHRvIGRv
DQo+IG5vdGhpbmcgaW4gdGhpcyBjYXNlLg0KPiA+IFRoaXMgcmVzdWx0cyBpbiBhIHN5c3RlbSBo
YWx0IGJlY2F1c2UgdGhlIERXQyBjb250cm9sbGVyIGlzIG5vdA0KPiA+IGluaXRpYWxpemVkIGFm
dGVyIHBvd2VyLW9uIGR1cmluZyByZXN1bWUuDQo+ID4NCj4gPiBDaGFuZ2UgY2FsbCB0byBkZWlu
aXQoKSBpbiBzdXNwZW5kIGFuZCBpbml0KCkgYXQgcmVzdW1lIHJlZ2FyZGxlc3Mgb2YNCj4gPiB3
aGV0aGVyIHRoZXJlIGFyZSBFUCBkZXZpY2UgY29ubmVjdGlvbnMgb3Igbm90LiBJdCBpcyBub3Qg
aGFybWZ1bCB0bw0KPiA+IHBlcmZvcm0gZGVpbml0KCkgYW5kIGluaXQoKSBhZ2FpbiBmb3IgdGhl
IG5vIHBvd2VyLW9mZiBjYXNlLCBhbmQgaXQNCj4gPiBrZWVwcyB0aGUgY29kZSBzaW1wbGUgYW5k
IGNvbnNpc3RlbnQgaW4gbG9naWMuDQo+ID4gLi4uDQo+IA0KPiA+IC0JcmV0ID0gcmVhZF9wb2xs
X3RpbWVvdXQoZHdfcGNpZV9nZXRfbHRzc20sIHZhbCwgdmFsID09DQo+IERXX1BDSUVfTFRTU01f
TDJfSURMRSwNCj4gPiAtCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gLQkJ
CQlQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTLCBmYWxzZSwgcGNpKTsNCj4gPiAtCWlmIChyZXQp
IHsNCj4gPiAtCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRy
eSEgTFRTU006IDB4JXhcbiIsDQo+IHZhbCk7DQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCQly
ZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLCB2YWwgPT0NCj4g
RFdfUENJRV9MVFNTTV9MMl9JRExFLA0KPiA+ICsJCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRf
VVMvMTAsDQo+ID4gKwkJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7
DQo+ID4gKwkJaWYgKHJldCkgew0KPiA+ICsJCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3
YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006DQo+IDB4JXhcbiIsIHZhbCk7DQo+ID4gKwkJCXJl
dHVybiByZXQ7DQo+ID4gKwkJfQ0KPiANCj4gTm90IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaCwgYnV0
IHdoYXQncyB0aGUgcmVhc29uIGZvciB3YWl0aW5nIGZvciB0aGUgbGluayB0bw0KPiBlbnRlciBM
Mj8gIFRoZXJlIGFyZSBhIGZldyBvdGhlciBkcml2ZXJzIHRoYXQgZG8gdGhpcywgYnV0IG1vc3Qg
ZG9uJ3QuICBJcw0KPiB0aGVyZSBzb21ldGhpbmcgZWxzZSB0aGUgZHJpdmVyIG5lZWRzIHRvIGRv
IGFmdGVyIHRoZSBsaW5rIGlzIGluIEwyPw0KPiANCkFncmVlIHdpdGggeW91LCBJIHVzZWQgdG8g
c3VnZ2VzdCBGcmFuayB0byByZW1vdmUgdGhlIEwyIHBvbGxpbmcgdG9vLg0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQo+ID4gIAl9DQo+ID4NCj4gPiAgCWlmIChwY2ktPnBwLm9wcy0+ZGVp
bml0KQ0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

