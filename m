Return-Path: <linux-pci+bounces-27055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C37AA598F
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 04:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6029E2624
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9905825634;
	Thu,  1 May 2025 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fvzUtftf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wX3A/ric"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2202DC782
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746065058; cv=fail; b=NUPhfkCfYkWvsfoSoqSH9+FYqBXP47j4gvCVqUiRAn1p3HNgQKlHTpG/dC+Oqp9hDQkmmWHpo9klvw1cQa6ojBRzlUwXJGAFHQECJPsNno2lm41ym4s3SeGlh0isF2HgVdzT6Oi8v26UGQIofKA+rz2zvYFT8BQMHULoWaZX9G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746065058; c=relaxed/simple;
	bh=JAexyx6/A/ZFq4ISvQh4B4p0czQ2N/q4zvvGlqm0fTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VI0x35NGgeuYXaO6kQSYl1pK3AUVjXzrjltIG+pwJokrNl3acvBvXNjc0X++2Ao7OTiP1CS47Ja5mRwOVLFYlBnZWw7OzwIdU/8n5japCab5ibHPWHZVKd1uzbR/iI9XrI8W663KxMXOkOEmybN7byl00vMmpHPUiZ/brFOfwlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fvzUtftf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wX3A/ric; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746065056; x=1777601056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JAexyx6/A/ZFq4ISvQh4B4p0czQ2N/q4zvvGlqm0fTk=;
  b=fvzUtftf85dbO34mZb1Ov4BGCm7RQhBD15DA6OV5LM+X2vCclZYvm8qs
   QP/hQds8I8JOs/xzJ5IHjCCqiDqe+QiDeM8fsRxnuGX2Jxq0cYqLF3dD8
   EgZpsh0OP3MPIvqslY9sTtWNazE67WWA9RDUc8XJXwIos6N0aphk5gab/
   PvZj2MbnrzEbu8F6HFvzWXXM4EfDGKq+xV8RCM0/WziQFePP0LsrATvx7
   baTW+kKnIO7KxaogJxYrdKRHt+xScX6ka5m1Hg1bC/ZJ0vnutSCo+WnlP
   VIM5pZxYrpeEMi6INpe5pEyIaLDhpzz2biO3MdF41KpPCeEfaR6h8vxZb
   Q==;
X-CSE-ConnectionGUID: ztQScGOrQLSBDKhB6ZeyhA==
X-CSE-MsgGUID: d3SuEbFATb2msMy9rxIf7w==
X-IronPort-AV: E=Sophos;i="6.15,253,1739808000"; 
   d="scan'208";a="82967553"
Received: from mail-northcentralusazlp17013060.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.60])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2025 10:04:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMvGAqFBNTEQlygl3H8nQcyaqobL+vuONAkQHtoxUX/7QTwztKA97lYGGb/FiTYoiP1WtXEca475v9P5rgAT5xhku1x3v8UI101vuhOR79wAdO+nZIhTrSU4RthRsPeTTMW2yVfSFZMIwj55s42aBUDlMKl39Zq42DNiiaiixRQxYjcqNKWifICV3uCDFbrNpj/iM+EiXupjySiMujlWk1tr5VdOA5njGg+mLxeC2DwkwqWNm3NdLCYhek5hWwQ6gvcCbDCspylnVyW/i1a6jM0ETyURazp8ZHbc9qO8Ej+hdd0uXTCJWH7WPekBxpGHiWffafPjxKx2N3ZMks3AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAexyx6/A/ZFq4ISvQh4B4p0czQ2N/q4zvvGlqm0fTk=;
 b=HlDsakLNTgHWm07ZSsjMatguvhTiZMjVsxfXjq1GQAA3/YDyL1q+i9bFiji7BBVlafV6kSV8TwyDu1cVyzqbdHS+xRPz79w41Awq2fq4VaZNHVPzyzsldXE6SusNqGhzgCWv0GBorBaKzT7EMQ1lq19cHC60hg2k0DPEGdup/YbNxEYhpPm3I7h3kTt3yr2Op9TlpSDtMIB+Wcmw6r0oswQZfsWfJGto4uhcsCxtyqczyfxYRXnq/mHEGQ3okTJ2I2WMZpinEFBucRd1mRadXZcgGE2yQcLLXrF2acFU9CkO6jraxDDTqPW5rnNgJCSQd6t9iAtdvaBfe8smDG+2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAexyx6/A/ZFq4ISvQh4B4p0czQ2N/q4zvvGlqm0fTk=;
 b=wX3A/ricn42cns4xO5h2SksumAXxG17UqcqsQ+55dY2W7BP5SQmMuAQT7/BxNByXufO6Q8aPZzLfnOAB2o18XjIfqnlGKt79TBA8JuZAedguhvPjAS5IC5LeIPBs9hEBZyNec8XvbkuTSbxpfNQqWD/L7KVDDBKPlFVgSrKy2lc=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SJ0PR04MB8472.namprd04.prod.outlook.com (2603:10b6:a03:4e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 02:04:07 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%2]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 02:04:07 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "kw@linux.com"
	<kw@linux.com>, "cassel@kernel.org" <cassel@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Thread-Topic: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Thread-Index: AQHbucvqK/tkXxqKvUmq80aYzlNF27O9BwsA
Date: Thu, 1 May 2025 02:04:06 +0000
Message-ID: <cd4896af8c9019e34c59ad1800df9f6bbaccc434.camel@wdc.com>
References: <20250430123158.40535-3-cassel@kernel.org>
In-Reply-To: <20250430123158.40535-3-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SJ0PR04MB8472:EE_
x-ms-office365-filtering-correlation-id: eda5698b-42d5-4d47-82da-08dd8854747c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEM2SGY4TGZLUTRVNWYveWFCSmtLdjRiVHlQTmE0WkR0elhMOGlldjd2cUJ1?=
 =?utf-8?B?OVZRVSs5YWloNnpXRFN5Z0tSNDhDR3pKSmwyMXY2cjFVdC9pcHY3N3MvNm1V?=
 =?utf-8?B?bzdGNDFJbkJlSGpQZkJ5dThMYTk3YVpsbzVQenZrTjcxNStlcUk2VkFtVjBu?=
 =?utf-8?B?blZoL3ozVmR0L3kwdytHdlV5UlFqUVYzZmxyQVJ4azE4V3dRbmNlakt6bU1u?=
 =?utf-8?B?VFVERDFGSDA3ZlY4ZXQrU2dQR0NqbFo1M3p2TzRzb1RyRk82eVpralVnK2ZB?=
 =?utf-8?B?MGs2VXQwQTM2Q3pzMU9RQ0M4MU52VThqaGk1bUtSNDlnM2JXVDFkclBpRVR4?=
 =?utf-8?B?bkRFa0RNY05hYkNPbndEYVRYY1NYOVFacHNKQkFuRkJ4N2cxenNQWlBnaHpB?=
 =?utf-8?B?R251QXJRaFVkY0J3TEIwNVdLOGsrMG85RnlxWGdPNEIxR3d3cFNLZnZhMG0w?=
 =?utf-8?B?b0tVMThoSTBpNG54ZjN1cnpzd25PMzRnckdkZGJZTEsxNlJVbVZUZjZnaTd1?=
 =?utf-8?B?cEg1VkZneWdjcHFneDFHcFhtbHBDaXoxbWlHUTJxME1oNFBjbDQ1T1pORkVo?=
 =?utf-8?B?cDd0cUtobVowNjNHclpBWUVxMW1oN2JBRDRlT1BnM2hEOGhmUDlaSWRDblhV?=
 =?utf-8?B?allZeit4d1hRZy9sc3Jhd21MU1VCNWdFcmp2bS9kWmdRWFZUSFJxYWdjTm13?=
 =?utf-8?B?V08xVFo2eXYyckV3Q0FxTU0vTVp5UlIyMzB4UGtRRTZKVVdLa3pHaWtaVzhX?=
 =?utf-8?B?cUNiTVdxYlUzcU9EZWd3Vks2SHV3VGx1eUNlZ0pTSVBOSzhDZkNESHludk4r?=
 =?utf-8?B?REk0a2NEVUE0WFFvLzE0alBRKyt5dU90RHIvZFZYZk9FMXhuOXJpUVNqK2xK?=
 =?utf-8?B?N0Y3aHRoQ2M5YWFMWTdsckJscWdhUjl0Y1NtTDVTb0xzbm1hUCt4K2FvN1Vs?=
 =?utf-8?B?bnJVMWtJZ1pBQnZweVNHNkpmSUpqc011dk9NS0xUdVBPMCs1MXIvaGE1V3V1?=
 =?utf-8?B?R1dFWTloaTJqR2pBY0xFUnppdHVUU0tDRS9jWnVnbEQzWGtRVXR0VDhnZ0dY?=
 =?utf-8?B?VWswQk83dDVueEpQbDJ1Tk9pY2NEd3dFZm9OQjhIL3BEbjNRV00zUFFRNUx6?=
 =?utf-8?B?MnFTMVh5cWlINitjVGdtZzhvRytadDNxVDBheGE3Tk9NOENDaERVS3dKNStV?=
 =?utf-8?B?aFIvb0pYVEdvMmlCdm5OangzSUZaNm82KzNua2c4SzgrOUNDNWYycmJQYzkx?=
 =?utf-8?B?bG5nOUdTUWM1ZHJ0T3NYMVBPNTR2WjhVMXp0TE4rNlpBdExRRk9ESXlOV3N5?=
 =?utf-8?B?cUJ5SVArTFFScmRxQWZ1WTdwT0o0OUxpSTlBWkIzc0FoL1JFdU1UcjdZNU5t?=
 =?utf-8?B?VUxOOE4rdEhNWUtIeVZVeDhzTzFwVm9Ub2lmY1ZSM1N6ZVFJcTcxWnptVENx?=
 =?utf-8?B?VjU5L01PS0s3MXpZMDZGSFBqejFnVWdEb1NoMERZdWlXTVdjVVAxTm81aGxm?=
 =?utf-8?B?NjFSSmw0TnpTNGk1N2VCc2J1MVFNVEF2azJmWnBiTEtOWTB6WDk5OEV2RXNz?=
 =?utf-8?B?K2hqUU80OTY0cXRsTE9JdnB2WjlSaU1WTnNXbGtVU1dTYjczTUFVbWJJMG1z?=
 =?utf-8?B?eGE4VFFxMkxXNHZ5d2FVV09peVJPQjI0bHdNcXFVUndjMFJvMW4rMjV6dlRQ?=
 =?utf-8?B?NlNUT1BFTFZHU2pkQTJmWHV2TDZjN2t0REdaeExldTBZTGRsR3lhVzVUSnZP?=
 =?utf-8?B?YkV2UlhVeTZGVkNDbnZZMGRVUHp1ZHZDcWVrQUpOdDlPUGRYTENURmsvWjJY?=
 =?utf-8?B?bGt3UEdNQjJscDNVNGVIRld1MlpONmp6a20zazZabHZpTG5yYkZKU3NNaUta?=
 =?utf-8?B?a0ptRFJOUXVxMFJDaVAyMlpQeEErRDdFaEo2Qml0RnNsSjdsbk1tTzdkZ3p0?=
 =?utf-8?B?eWZ3b0dSNmpvTnZVU09rdHFMUmxUNnFSNFJtMFJPTTVvU3pGazZ0cEpMb3Fm?=
 =?utf-8?Q?y/dkc42AVCRou1WL/aYZ3GbuKZPwVk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1Ridi9lVTVxOENVZnRvVGhPMS9MK2hlR08zSSsxcDEyVlQ5NDhEcEF6eXFr?=
 =?utf-8?B?b0JOU3FIMENsbEFCQVAvbitmSnZmcTJqQ21ZRi9iNnZjZ1pWazhPQU9neGZE?=
 =?utf-8?B?QUVNeEFSTURkaE51RldqT1lydThHVFIxZ2kyMlVxamRLRFY4Ui83WUtQeG5q?=
 =?utf-8?B?a2NiT0I0UEpHUS9NVVhPOFV2MzlVd0V5QlRTNVRmSVU2Vmwwc1plNEcyZkh6?=
 =?utf-8?B?R2QrbnpHZHpTVzRLTW1PTHVLMzVRYUpPWExDV2FaSFk4MzVsYW1idXNwZzlY?=
 =?utf-8?B?OXVIRmwyU2pucmQ1YWhCbXcySkZJU1hvMnIzTHNpVGErcE82VGx1djZpK2tk?=
 =?utf-8?B?eSt2UFQ1THNaaHVQM1BuWlF2RVdmWXhlOUJHSVhodWZGQmNTbThWU3B4akh0?=
 =?utf-8?B?eUdDckFLZzJOQ3ZoemRPcFYyVlZBRWhROFR0b2RvYlgyUUdjYkNUOWpvZ1Fm?=
 =?utf-8?B?RXBhOXdKZ3VwL0d5Q0RCM294N1p4N1Bsdk5NdzhkVVNNZ3diYWdwVUtpa1lh?=
 =?utf-8?B?Y2dsVEp0UklnMUhocDZSLy84NWVOUDUwckpBVHJta1BpYlFNNjZsdkwwbXds?=
 =?utf-8?B?Skc4ZVRXOWJxZFV1MVdxNE1hK2ovdjNBRG12ZUxVd2cxUnp3a2Frbkd3YjNl?=
 =?utf-8?B?TjVrdE5UMGFNRWlrS0w5YTJNakpJcnVjWFFNNXNoY1hKUlBReXQ0MnJ5ZnVO?=
 =?utf-8?B?Si8zcXlIQ011U2JvWjNheHUwOXlFb0xBTEc4UU01b0x2L0p4L01mWmtFdGhP?=
 =?utf-8?B?aWIwZDM1OGNMd3V1Y1lxUGx0T1RYNktnZWk3aFhRbWdGRURpeDFyL1JPc0Fz?=
 =?utf-8?B?Ky8vYUo0ZkhRWjNoelZMQ0hkZFFjNkJ2Y3dkWk84WGhUZi9MczNDVHQ3cUla?=
 =?utf-8?B?VGRzeFdzVVAwT05kYUsxRkZDSXdPK01wRTdQRXJ4cnBBT1VwTHpqaXV3RWJs?=
 =?utf-8?B?ZDNDZ2N5VHVCU0w5amo3L1NkVHg5ckhBamU5UXZHV0llMTg3aysxTTFrWFBs?=
 =?utf-8?B?VEtqdjZMZnBrK2x6SVV1b01GVGtudVp6U1hkQlNHbk81Z1g1WW9qbDhFNjFV?=
 =?utf-8?B?KzRyVGNLV3lVNkYydXJoaWdUZXlHK25ZeFI2TjQvRS9VOVpHN3I4SzRYUWx0?=
 =?utf-8?B?dXpaK3BDN1BEQ2I4TGVGOWFxRndRdXA1ckh3Zzl5TE11VWxlaFpOVDdyK1pY?=
 =?utf-8?B?V0VwREUyUTdobFpmNEtXMklPUUN2TDRjOVNmUEFhWEFpUWE4b1Y5VUlVclo3?=
 =?utf-8?B?UDI0dTNmWGwyaW5NbE5MeS9zL1orS2R4ZXIwVVV6bEl3ZHB2a3Z0ZVJzV1ZV?=
 =?utf-8?B?aUVtbVQyZ2lxUzFLbE5WNDF6WHoxVEN2SGNDQisyV0VJVGIvd1A3dHNhT1Ny?=
 =?utf-8?B?TEhPTEIvSUFuSHBhR1AxTjQ2b1AyeC85Qk9xYkNwL3dwei9GZTVFZ2hoNmR0?=
 =?utf-8?B?ZSt0d0JkUWtHVjNuRzFPWXcvSk92MXRwNzViMi8vbTRXdkxkbXd3RzV6WEZq?=
 =?utf-8?B?TU0rQmIzWjN5Ny9IMWdtbjdkZFhRN0VkbEY0WEpSOE0vZks1aWZ4blJzVW9P?=
 =?utf-8?B?TGZ0QmYrNnkyN3A2Wi9pYldWWE0vcEtoVmw3cnIyYitEbmdlT0QzOGNnRzF6?=
 =?utf-8?B?MGNuOUh6elNEWnpWV0dsN3FGSkhFY2V0MytsdWRNL1VEb0RMeTF3dFNLNS9X?=
 =?utf-8?B?OWxkWHF1MVVHbVZVUkE5cUpSMlVNd0tYdml1UlBpVyt2b0N2OXc5NzZTMElM?=
 =?utf-8?B?RkM4NGlKcXo5WW5xK2d5YzhqUG92SWZja3RHOStHVjNyWm9QZnVmVUViN2tY?=
 =?utf-8?B?Q3JxN24vOU9LZGJDR2JOK1pneU5zcGNaZUc0cE50WGsrekFBWHBJazVOMjdx?=
 =?utf-8?B?c2wybWxmcUR3Q3Q4M2w1S0xyd2V0UkJzbTVjcnVNaWtudjhubngySkNDV1Fw?=
 =?utf-8?B?NUdRZGxvNG1xUVhBbXFBL0VyQjBtRThaYnlsdjZsU09XOWRhVkhLcE9RdEt2?=
 =?utf-8?B?QkhIUnRVdUpVV3JzSTUrUjBzT2p5NG1tdGk2ZmFqd0pFcGk1ZjRyRnpROVV5?=
 =?utf-8?B?ZFR6eEkrZGd6and4TXY3Qm5ZY3VHRXo1Znd1YTNDSUh5d3k0eWlnZS8zV3NB?=
 =?utf-8?B?Zjk3RUNFZUgzbGpsSVVGam5hRFNKTWJEdjgzOXZpRFpHLyt0L1RZTHpVOTFX?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56B2A227DADF1747B852EE1B76F494A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UEVJfbrfL48evgo5vNbfPaI55spvuIA80P2bpm23m/dKDzJhqi/Vw4USI7u68fS9LRPLFdjxaMd1BCFwDLPPYUCA3YcPtiNhWCBA5q4n9ygsQFAKOY4jo2U5aMgXgfJ71shunmfQdr3/BleF8D1+uLtB82W3lp4Il88BL9SBOBwIVMP0PdAovE5KVC6hC0XBhKju0mwGt0s6R6Ipy3PsS5dFIZDJzKgCXGisF3kW8P8n5qBP5+OHtsh9J+Z0mORsG64Ef5GEQxEZkWitQS7AApR5VQK496s9E8/VxheN0racNkL/U8Y1mlSAkh3y6joemRBPCiRV5l5vJ8WMSehHh/cden2we5PFM51K4gL7md8Isla8/ipjEgJIG7I068CC4LaIZFW37aRUJt/O67owUIlnoX/bTD78h0Zx1lHFdQr3Z8SK9Zp/HUpfrDFOXHle2iLfEOd1ufgWNNiyuzWkBr3mAUJBIWkvQ/Of4GdG2sgVEGl9nXXxv7htSDBm4IymC1HGdoNzzK2TPtNHA4t2YXuCJZ+TIdRmwQe+y0WY0/3EfA4DF1BYxpaeuD9miMzpEMfBqrQ//kDIXcdUffocpgLsyaOOHBQHsPR/0JEjNTIIDS0GQTeRon5eXy8jU+oy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda5698b-42d5-4d47-82da-08dd8854747c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 02:04:06.9048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yi2Ksbf1/+uwvHfVi7h/wGkheSZO8VEBF3iZVtcv30raMRYTktXQljHZfZXwRMRVycdOVXBIiWs+RelOdVz2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8472

T24gV2VkLCAyMDI1LTA0LTMwIGF0IDE0OjMxICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBXaGlsZSB0aGUgcGFyYW1ldGVyICdpbnRlcnJ1cHRzJyB0byB0aGUgZnVuY3Rpb25zIHBjaV9l
cGNfc2V0X21zaSgpDQo+IGFuZA0KPiBwY2lfZXBjX3NldF9tc2l4KCkgcmVwcmVzZW50IHRoZSBh
Y3R1YWwgbnVtYmVyIG9mIGludGVycnVwdHMsIGFuZA0KPiBwY2lfZXBjX2dldF9tc2koKSBhbmQg
cGNpX2VwY19nZXRfbXNpeCgpIHJldHVybiB0aGUgYWN0dWFsIG51bWJlciBvZg0KPiBpbnRlcnJ1
cHRzLg0KPiANCj4gVGhlc2UgZW5kcG9pbnQgbGlicmFyeSBmdW5jdGlvbnMganVzdCBtZW50aW9u
ZWQgd2lsbCBob3dldmVyIHN1cHBseQ0KPiAiaW50ZXJydXB0cyAtIDEiIHRvIHRoZSBFUEMgY2Fs
bGJhY2sgZnVuY3Rpb25zIHBjaV9lcGNfb3BzLT5zZXRfbXNpKCkNCj4gYW5kDQo+IHBjaV9lcGNf
b3BzLT5zZXRfbXNpeCgpLCBhbmQgbGlrZXdpc2UgYWRkIDEgdG8gcmV0dXJuIHZhbHVlIGZyb20N
Cj4gcGNpX2VwY19vcHMtPmdldF9tc2koKSBhbmQgcGNpX2VwY19vcHMtPmdldF9tc2l4KCksIGV2
ZW4gdGhvdWdoIHRoZQ0KPiBwYXJhbWV0ZXIgbmFtZSBmb3IgdGhlIGNhbGxiYWNrIGZ1bmN0aW9u
IGlzIGFsc28gbmFtZWQgJ2ludGVycnVwdHMnLg0KPiANCj4gV2hpbGUgdGhlIHNldF9tc2l4KCkg
Y2FsbGJhY2sgZnVuY3Rpb24gaW4gcGNpZS1kZXNpZ253YXJlLWVwIHdyaXRlcw0KPiB0aGUNCj4g
VGFibGUgU2l6ZSBmaWVsZCBjb3JyZWN0bHkgKE4tMSksIHRoZSBjYWxjdWxhdGlvbiBvZiB0aGUg
UEJBIG9mZnNldA0KPiBpcyB3cm9uZyBiZWNhdXNlIGl0IGNhbGN1bGF0ZXMgc3BhY2UgZm9yIChO
LTEpIGVudHJpZXMgaW5zdGVhZCBvZiBOLg0KPiANCj4gVGhpcyByZXN1bHRzIGluIGUuZy4gdGhl
IGZvbGxvd2luZyBlcnJvciB3aGVuIHVzaW5nIFFFTVUgd2l0aCBQQ0kNCj4gcGFzc3Rocm91Z2gg
b24gYSBkZXZpY2Ugd2hpY2ggcmVsaWVzIG9uIHRoZSBQQ0kgZW5kcG9pbnQgc3Vic3lzdGVtOg0K
PiBmYWlsZWQgdG8gYWRkIFBDSSBjYXBhYmlsaXR5IDB4MTFbMHg1MF1AMHhiMDogdGFibGUgJiBw
YmEgb3ZlcmxhcCwgb3INCj4gdGhleSBkb24ndCBmaXQgaW4gQkFScywgb3IgZG9uJ3QgYWxpZ24N
Cj4gDQo+IEZpeCB0aGUgY2FsY3VsYXRpb24gb2YgUEJBIG9mZnNldCBpbiB0aGUgTVNJLVggY2Fw
YWJpbGl0eS4NCj4gDQo+IEZpeGVzOiA4MzE1M2Q5ZjM2ZTIgKCJQQ0k6IGVuZHBvaW50OiBGaXgg
LT5zZXRfbXNpeCgpIHRvIHRha2UgQklSIGFuZA0KPiBvZmZzZXQgYXMgYXJndW1lbnRzIikNCj4g
U2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3NlbCA8Y2Fzc2VsQGtlcm5lbC5vcmc+DQo+IC0tLQ0K
PiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jIHwgNSAr
KystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWVwLmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtZXAuYw0KPiBpbmRleCAxYTBiZjkzNDE1NDIuLjI0MDI2ZjNmMzQxMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gQEAg
LTU4NSw2ICs1ODUsNyBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZXBfc2V0X21zaXgoc3RydWN0IHBj
aV9lcGMNCj4gKmVwYywgdTggZnVuY19ubywgdTggdmZ1bmNfbm8sDQo+IMKgCXN0cnVjdCBkd19w
Y2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiDCoAlzdHJ1Y3QgZHdfcGNpZV9l
cF9mdW5jICplcF9mdW5jOw0KPiDCoAl1MzIgdmFsLCByZWc7DQo+ICsJdTE2IGFjdHVhbF9pbnRl
cnJ1cHRzID0gaW50ZXJydXB0cyArIDE7DQo+IMKgDQo+IMKgCWVwX2Z1bmMgPSBkd19wY2llX2Vw
X2dldF9mdW5jX2Zyb21fZXAoZXAsIGZ1bmNfbm8pOw0KPiDCoAlpZiAoIWVwX2Z1bmMgfHwgIWVw
X2Z1bmMtPm1zaXhfY2FwKQ0KPiBAQCAtNTk1LDcgKzU5Niw3IEBAIHN0YXRpYyBpbnQgZHdfcGNp
ZV9lcF9zZXRfbXNpeChzdHJ1Y3QgcGNpX2VwYw0KPiAqZXBjLCB1OCBmdW5jX25vLCB1OCB2ZnVu
Y19ubywNCj4gwqAJcmVnID0gZXBfZnVuYy0+bXNpeF9jYXAgKyBQQ0lfTVNJWF9GTEFHUzsNCj4g
wqAJdmFsID0gZHdfcGNpZV9lcF9yZWFkd19kYmkoZXAsIGZ1bmNfbm8sIHJlZyk7DQo+IMKgCXZh
bCAmPSB+UENJX01TSVhfRkxBR1NfUVNJWkU7DQo+IC0JdmFsIHw9IGludGVycnVwdHM7DQo+ICsJ
dmFsIHw9IGludGVycnVwdHM7IC8qIDAncyBiYXNlZCB2YWx1ZSAqLw0KPiDCoAlkd19wY2llX3dy
aXRld19kYmkocGNpLCByZWcsIHZhbCk7DQo+IMKgDQo+IMKgCXJlZyA9IGVwX2Z1bmMtPm1zaXhf
Y2FwICsgUENJX01TSVhfVEFCTEU7DQo+IEBAIC02MDMsNyArNjA0LDcgQEAgc3RhdGljIGludCBk
d19wY2llX2VwX3NldF9tc2l4KHN0cnVjdCBwY2lfZXBjDQo+ICplcGMsIHU4IGZ1bmNfbm8sIHU4
IHZmdW5jX25vLA0KPiDCoAlkd19wY2llX2VwX3dyaXRlbF9kYmkoZXAsIGZ1bmNfbm8sIHJlZywg
dmFsKTsNCj4gwqANCj4gwqAJcmVnID0gZXBfZnVuYy0+bXNpeF9jYXAgKyBQQ0lfTVNJWF9QQkE7
DQo+IC0JdmFsID0gKG9mZnNldCArIChpbnRlcnJ1cHRzICogUENJX01TSVhfRU5UUllfU0laRSkp
IHwgYmlyOw0KPiArCXZhbCA9IChvZmZzZXQgKyAoYWN0dWFsX2ludGVycnVwdHMgKiBQQ0lfTVNJ
WF9FTlRSWV9TSVpFKSkgfA0KPiBiaXI7DQo+IMKgCWR3X3BjaWVfZXBfd3JpdGVsX2RiaShlcCwg
ZnVuY19ubywgcmVnLCB2YWwpOw0KPiDCoA0KPiDCoAlkd19wY2llX2RiaV9yb193cl9kaXMocGNp
KTsNCg0KUmV2aWV3ZWQtYnk6IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5j
b20+DQoNCldpbGZyZWQNCg0K

