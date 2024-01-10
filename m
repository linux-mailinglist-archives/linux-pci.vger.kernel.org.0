Return-Path: <linux-pci+bounces-1985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E08296D0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA381C25ECE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65053F8D6;
	Wed, 10 Jan 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="McOU1nBp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xw4BR7B/"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04783F8D2;
	Wed, 10 Jan 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704880875; x=1736416875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aQBi22N0RZl8LUSdMCvEY6DIhLLwXVgmJczgEIJYhuU=;
  b=McOU1nBpeGJCrCXGq3oR0wzB8z9MAlo+KsMZj+8s2vDEtY3E56U9d+qN
   xGGP7gBSNjo7scvMy86xbWCXXps1TErvFPVSTioIMBaurszgrl8bdbvZY
   r0WAmZ4RLwfilZNF14xMKa8AAwcumVBF2QTwsmmVGg9tk4U9/Wjpp66mw
   Op57vMebI2wdqeD5Kg6Dmvi+wxDCfNW3NNEPS9cITPk7MFUny2FVTaXsH
   Va37QzzEW14QPiPbykOiUJU3hbLIy5S0BejfwOsWBX85SbFVP4T0pjmTu
   7IxILVZalJ7C+etZYJlmRDBj4nzpUbTUMXb3tQe2a5mhpTANYRidzuH4L
   Q==;
X-CSE-ConnectionGUID: N8hvxGhlSqaIN3mE6vVBOg==
X-CSE-MsgGUID: 09goMoBWRVGbG7lcbkcv9g==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="6536450"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 18:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDkzIdbCYAviN9U/NeLyGmPgH2BjINmA0ZYVMZoXLuMRw9vfOly7B/Vd0dl7Szg/X+eS30mLZL912MsLryxWEjPvskvUeGAV4Ipwh9PzkyAcRBtN7hWCnfOHFtbnEkiv4K4IrreUlAUEnIOa3DUxr39RjCw8sfB9y3E5yZsTEd0E2Tzk+GAVQqX251Outt4ZErKqXvTQbX9gJSQHRLJwulN3/LiK1Tjtw5I1wMda6rn7/17T1nflcs60J05uJiiwKk4s3mr6q0L1IwvVO0stptDTaO6H1QGL661g9G/1teV61EF3VHZXgyISGhIYEM41liZqT91/clJADj8V82DyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQBi22N0RZl8LUSdMCvEY6DIhLLwXVgmJczgEIJYhuU=;
 b=ZpXpYVUk9GpVS0cv0Fa1xI7ti4bIcNU8o6heVQ8T6tFj1go2WNvXYSE988YN97a+uM4bv+Zd+7pZt5l3JOgVv7ld8XCe4YwmOaLPvVnyZcyqQrTfurbafo9FLEqPEfmAaN1ULXjJFrR20mqi9CaqqH++5LlQePyjrjCQyvS4UF3+hnWihFB4Wn0gw7pGfSG8qibh//C9wKFff1w7VbKF9i4KB3KIhPZYJ29s93QosG8KtUnEksp9ykhg795whPLly6U8v/epYJfoaD/F28r/BU0MrbVByEXGqHc98023SlDHA12QKwAO27lgkKxrjzkVu2HFPNSFSIkRen2fLe+MjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQBi22N0RZl8LUSdMCvEY6DIhLLwXVgmJczgEIJYhuU=;
 b=Xw4BR7B/8O66M0vN+xQyz5QYsQfDA7OLh++cmWWgQQVK8VDlJ2/OJHbJJryMP7OAudB+LepK6M7wW0zfAhmYoxavCAz0FOJ09mKCXCWbBLzE3EUF8WOA36lRa8StmykC+Vol30llkCTKwjaCdR7CLsTOXg331zIad+FKSItqrM0=
Received: from SN6PR04MB4861.namprd04.prod.outlook.com (2603:10b6:805:94::19)
 by PH0PR04MB8403.namprd04.prod.outlook.com (2603:10b6:510:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 10:01:08 +0000
Received: from SN6PR04MB4861.namprd04.prod.outlook.com
 ([fe80::f82a:d478:7586:775f]) by SN6PR04MB4861.namprd04.prod.outlook.com
 ([fe80::f82a:d478:7586:775f%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 10:01:08 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"fancer.lancer@gmail.com" <fancer.lancer@gmail.com>, "vidyas@nvidia.com"
	<vidyas@nvidia.com>
Subject: Re: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index: AQHaQyWCoLb8WRl3KkWO8x9Jzhtf77DSXyaAgAByaQA=
Date: Wed, 10 Jan 2024 10:01:08 +0000
Message-ID: <ZZ5q4oPEj0N1mQED@x1-carbon>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
 <20240107072707.GC3450972@rocinante> <ZZ2JXMhdOI1Upabx@x1-carbon>
 <20240110031137.GA2630@thinkpad>
In-Reply-To: <20240110031137.GA2630@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR04MB4861:EE_|PH0PR04MB8403:EE_
x-ms-office365-filtering-correlation-id: 84da9d7f-073c-4d8d-1995-08dc11c3110c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XHiIOsoLGaMFrju5cgN2X2pH1MrZ169XV21DkUImYve0xXPBlRLqu6L4TrFNO9OgjByelPQpEGLB8+3CVhOrmDhpkndxYhUqHZZ9V61nMI8XZoKB/K3POtl5dfErzn1TOMg4AfRCQGrj7taYk7uctl0XroxXoko+Kz+PlGWVRaE9k3Hgns9iHAD2/KuFy6/Teth2ICYHQ8EM3Z0qSnLlxYTKhyRG5i8tfGAZPEews5C1umbVV61lTrVnyU0pKdHCL7PQAaYnt4dw9RUvfq1vGnSQuA/L/0PVdQPGXBF+cWD2rAHkbkJq+QMM4DnSv2xR9KUM9VmmMmu9uRpJc924Mz4zztKzNMx5tYYbkDrhOe3M8Bdjb9P64SnAHJCvliSlkiNY/gxBBJ2viRQ3TtjSm2pdgp9179glBMzHjO5cM3WGgC7nI9q6vHbz3Ern4V1ShvF//tpib6l2vnnnk7PgbtP3aHonJmOUj+W+M5ITNGTN/0xTa5LeVmXIw9Xpmy4OwxaWwXXpoSMt6iJzVPRuJ3ho7jJs2ZzObhxdgI3OfKPJyBDYMOMR6BYijicnnD+amaTegXnU0i3GqrOM57UyniDQO9SA+Bo/nn7DJk/bsIoFDHC8xelw4Y9JZsgp7Yqo33DmrMEtm+SGMBMyOGK10w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4861.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(39860400002)(366004)(136003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(91956017)(4326008)(66946007)(66476007)(66556008)(76116006)(316002)(8676002)(8936002)(26005)(478600001)(966005)(64756008)(66446008)(71200400001)(83380400001)(66574015)(2906002)(41300700001)(5660300002)(38070700009)(38100700002)(122000001)(7416002)(82960400001)(6916009)(33716001)(86362001)(6506007)(6512007)(54906003)(9686003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDIrVzdyRFlSWVc3MUZzbGZRQ0tLYTZWU2tITHJuc2N2YWFWNHlkQXRIazl4?=
 =?utf-8?B?L2VGTEhkSjYvMXd0SWUrT2hSMlZwNjJxQlpEZjByV2FUaThnMExhanRxUWt6?=
 =?utf-8?B?cjhEa0ZJV2pHenJ5cWNldEk5UlVQREpkSElEdzZzeGViQnZWbTEzd2xKMi9u?=
 =?utf-8?B?MFd4WVZ2V2dFalJZcndGSEtpR0hnczdwWjJsNVNvSCtuVlhNR1c3ZFVCRW9h?=
 =?utf-8?B?Y1EzNS9KTi9NMitnU25oaVMrMmdROEpERGJlNUlwdHNqdWNTN2U1OE5CUENh?=
 =?utf-8?B?eXd0ZUp1V3NrTGtIZXMrK2tHZzh1MGtWUDkwWlBKZUtUSFAzc2lQdDI1aTFu?=
 =?utf-8?B?dFVrMFdlRUVsbW82cTJ4VGFHMXlFbTk3c3N1UWdMeW1ma1ppZy82c1VaRGVt?=
 =?utf-8?B?WGJRRFJHajJoYmZNQ2p2WjZNeGxYK2dmc3V4SDBVYVc5N2lWRWhST3BqMW55?=
 =?utf-8?B?aUVEbUxvNkNjVHgvamF5U2ZybkxiUUt6RjdFMGtYdHJUUmlkS2tFTWtCQlNS?=
 =?utf-8?B?aFk3VXlyVmZJdlVDbWJ6MFhiVU9VNFBxS1JEQUozZWlOcVQvaFdOcldNbW9r?=
 =?utf-8?B?RGVBQVVZM1Y0Wm9ucXBUU0hKK0M4QlNBQWhwK09VVUdLcjk0elViaEk5ekl1?=
 =?utf-8?B?bGNTcnBseG54VitvT2dyUmVOVzdSR3BoRk44VzY0T2lqUGUyVlBJekY5Zi9h?=
 =?utf-8?B?ZzhSZFBhcTFOV1Arc2JFazlmeUU1TkFWY1hpMzRpSnhXOGJwbmpvNkJIMmRG?=
 =?utf-8?B?dXJ5YTBSS3NQQTdEYW1ydHlLWEdjUUxNS2Y0YlgrNGtaajNIOFllakNiT3JX?=
 =?utf-8?B?RmFzc0FmT25IKzNsblMvZWdJWitJajZYeXMrM0NSblF4OG1aK3VqNU5LMGpz?=
 =?utf-8?B?NGVwNXFVUUkyazltTEJ0RU92Mlpxanp6SGRjYUduQThhbDBGQjlmYWExRjhq?=
 =?utf-8?B?ZjBUWlhpUXZsNjY3T1JMa2F2TWhiNVhBSmlkUEpJMnBCMkxvNVkxN29oYlNK?=
 =?utf-8?B?UTF1RWtGcjhvYTFjVi9naGR0VlVBc0VmSzVWUmpEemJJWlRuN1ZLUHlYUkxU?=
 =?utf-8?B?NGpvbzlMUlNhY2xoWTZhcTJ5cFJ3bWhBNkpwQWZ4Q05qSW9UV1NDYUNIYWJp?=
 =?utf-8?B?SHR5YlRSV0dLZ0RaRGRVWXdmb1NDK2dOYm50MFQvd3VsNFZnSnZ0eWI4WnJH?=
 =?utf-8?B?bTdMVjI0TmpSeThtS2VBM3h0Umtlck9YbFhvRWZ0U2Vic3VLYmsvTmIySnpW?=
 =?utf-8?B?SzNkL1d6QWRPRm9zZThFdFprZ1dNNmtONnVObTkyc2pJWlZxcmxPS0E3S3NN?=
 =?utf-8?B?NEdYSnI4dTFSbkhNSGhZeFJ3cXFDWGgycU9FTjlSdUdpbGRtci9HN2xNQTdn?=
 =?utf-8?B?WUYvN1cyUCs0USt5aVE3bnUyVXk1WXdxdXIzV3IyNzk2T3h6OWZoNWxqQ2p2?=
 =?utf-8?B?VTJvOWhOcWtXcDZMc1dkcVljQVU2VE8zaFJUeG9rY21QL2J2eWhEb3VFRTRD?=
 =?utf-8?B?UVUxZGM2RkMrUGlFUERLVVpGTng1Z2hBZUs0R29sMXZ6VXM1M1BOZmJtM0p0?=
 =?utf-8?B?Q3FiQzRibkN4ZE1jMk5SRktZU3J0NlVCbFo3bEQ2SUt2Mlo3OVNXbHRkbU1F?=
 =?utf-8?B?c3o2ZzU2amN2c2pqT2dyc002MUNJcnEvajQxdDBRMmlMOEVxTDdzdDd3UnlE?=
 =?utf-8?B?SXRwV0Q0ZllHRXdRYVBhZ3gyMTBKdXkwcWV0QU9jUGFGV1BUN2JTc1MwRWsx?=
 =?utf-8?B?dU1nVDZmUDhUNXRYUnhtbytZOTlPWUZSY0s3dk04ZHEzTU1qOW5hdzB0V1M3?=
 =?utf-8?B?WEorNWhWQVhhdnI1MWlhQW5JSkZtUXk5MFEwSWtwOEU3bi9YWDlRendGVUsr?=
 =?utf-8?B?T3MzVXJ3VVJDWVc2VzB2bXZBY05WRzA5WTRNQXNaNzJXNTVhcWpmdmJkakxl?=
 =?utf-8?B?ZTBFTFlyTkNmUkNJRkEybEs2cGRVUU1TaTFYMlMxOXRTQ2tqemJnanZXcUsr?=
 =?utf-8?B?cGh4SVh5R0h1ek1YSHBNUDc3eUYvWU0zNEdKQ3A1eHBHdHJxUGdlWm92eGNr?=
 =?utf-8?B?OHRDNmtob1dkeDRGelBHeG9CRjJzTXFJQktOQ0lFOTVEYTVFRE9Ba2lhcFdn?=
 =?utf-8?B?QW0vVGdPOU8xZGVJdzdJdUFWUkRZRTNzMTJTZzRnQzFTT3Z4bEtPZWJSY1Fr?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFB370A9C4F24445B9D2FF4F70D3BC17@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pfoEI+YUJPUDPPHbotpBdQovDX7U51D7fZFfweqLqM8SdFgCfvjz01REsJzAQuM4a92B1Y+YVtYSqco3M+cAxNd3np/p2i2GMJ1cVLAq9UT1ffpzUbreb5NQGU31XZ/kMU8pH5doHc5q/eK2McuKEA2GIv/XpN+1gEwfSPbazmnPgBPcEbQVYFmhCtdOgCSjERK2Ss817XaOrAfLoZgmRfUvFSW/nFeZp9fjleYmo9cnkOAVqNg4DjBHE/f0oK6yeHne+V1is2AKc4kxRcEzrUs4XVOgSrIsOepkX6eq3DaHGMAdl5kVjlzOSGs1fTae2PR8zhOUQpFvnonn6rkMi28TGwNIanoudBPOlRBJHV46LAcJTYXh1yJsCyuYmJ5Qsigl+ddfqXkHUmwCaLfMjLrmSV7i6DZHOJ9XUWMswQ9JcHgagj4Oz8TJSc8FoyrfjAi8B06H0A64f/i3XVKDpgDWfRN+P0UnK5r/bn8ma5XFKL03DoOcrzu3XXRsQBC7IW4r36/mkMx7RHoQ9NwmkwY9uGxMZ3KGHN5tHvQzDQJ2TP60AmGaOLfOccXt7wwGYefQyHk+js+HLZ7ufzkbKmazjk0HrGvbMGLJR873d+4po2XJ42W6wiNJR+Vf5jQ0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4861.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84da9d7f-073c-4d8d-1995-08dc11c3110c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 10:01:08.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Np5u1euA33Jk+HdUSWHeXZifCodptFumqGJ4XJd+8Ji17LuY3YZRWQRWH/FlJK9lAGjC5/bVYjOEjW4SMzmpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8403

SGVsbG8gTWFuaSwNCg0KT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgMDg6NDE6MzdBTSArMDUzMCwg
TWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAwOSwgMjAyNCBhdCAw
NTo1ODo1M1BNICswMDAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0KPiA+IE9uIFN1biwgSmFuIDA3
LCAyMDI0IGF0IDA0OjI3OjA3UE0gKzA5MDAsIEtyenlzenRvZiBXaWxjennFhHNraSB3cm90ZToN
Cj4gPiANCj4gPiBDb25zaWRlcmluZyB0aGF0IHdlIGtub3cgdGhhdCB0aGlzIHNlcmllcyBpbnRy
b2R1Y2VzIG5ldyBwcm9ibGVtcw0KPiA+IGZvciBkcml2ZXJzIHdpdGggYSAuY29yZV9pbml0X25v
dGlmaWVyIChpLmUuIHRlZ3JhIGFuZCBxY29tKSwgc2VlOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXBjaS9aV1ltWDhZJTJGN1E5V014RVNAeDEtY2FyYm9uLw0KPiA+IA0KPiA+
IERvIHdlIHJlYWxseSB3YW50IHRvIGFwcGx5IHRoaXMgc2VyaWVzIGFzIGlzPw0KPiA+IA0KPiA+
IA0KPiANCj4gTmlrbGFzLCBJIHRoaW5rIEkgZXhwbGFpbmVkIGl0IGluIHRoaXMgdGhyZWFkIGl0
c2VsZi4gTGV0IG1lIHJlaXRlcmF0ZSBoZXJlDQo+IGFnYWluLg0KPiANCj4gVGhlIGZhY3QgdGhh
dCB5b3UgYXJlIHNlZWluZyB0aGUgZG1hZW5naW5lIHdhcm5pbmdzIGlzIGR1ZSB0byBmdW5jdGlv
biBkcml2ZXJzDQo+IG5vdCByZWxlYXNpbmcgdGhlIGNoYW5uZWxzIHByb3Blcmx5LiBJdCBpcyBu
b3QgdGhlIGpvYiBvZiB0aGUgRFdDIGRyaXZlciB0bw0KPiByZWxlYXNlIHRoZSBjaGFubmVscy4g
VGhlIGNoYW5uZWxzIGFyZSByZXF1ZXN0ZWQgYnkgdGhlIGZ1bmN0aW9uIGRyaXZlcnMgWzFdDQo+
IGFuZCB0aGV5IF9zaG91bGRfIHJlbGVhc2UgdGhlbSB3aGVuIHRoZSBjaGFubmVscyBhcmUgbm8g
bG9uZ2VyIHJlcXVpcmVkLg0KDQpTdXJlLCB0aGUgZnVuY3Rpb24gZHJpdmVyIHNob3VsZCByZWxl
YXNlIHRoZSBjaGFubmVscy4NCg0KDQo+IA0KPiBJIGtub3cgdGhhdCB0aGUgUENJX0VQRl9URVNU
IGRyaXZlciBpcyBub3QgZG9pbmcgc28gYW5kIHNvIHlvdSBhcmUgc2VlaW5nIHRoZQ0KPiB3YXJu
aW5ncy4gQnV0IEkgZG8gbm90IGhhdmUgYSBkZXZpY2UgdG8gdGVzdCB0aGF0IGZ1bmN0aW9uIGRy
aXZlci4gUWNvbQ0KPiBwbGF0Zm9ybXMgdXNlIGEgZGVkaWNhdGVkIGZ1bmN0aW9uIGRyaXZlciBh
bmQgdGhhdCByZWxlYXNlcyB0aGUgY2hhbm5lbHMgd2hlbiBpdA0KPiBnZXRzIHRoZSBMSU5LX0RP
V04gZXZlbnQgZnJvbSBFUEMgWzJdLg0KPiANCj4gU28gbXkgY29uY2x1c2lvbiBpcyB0aGF0IHRo
ZSBpc3N1ZSBpcyB0aGVyZSBldmVuIHdpdGhvdXQgdGhpcyBzZXJpZXMuIElmIHlvdQ0KPiBzdGls
bCB3YW50IG1lIHRvIGZpeCB0aGUgRVBGX1RFU1QgZHJpdmVyLCBJIGNhbiBzdWJtaXQgYSBjaGFu
Z2UsIGJ1dCBzb21lb25lIGhhcw0KPiB0byB0ZXN0IGl0Lg0KDQpUaGF0IGNvbmNsdXNpb24gaXMg
bm90IGZ1bGx5IGNvcnJlY3QuDQoNCkxldCdzIHRha2UgZS5nLiB0aGVzZSBlcnJvciBtZXNzYWdl
cyB0aGF0IHRoaXMgc2VyaWVzIGludHJvZHVjZXM6DQpbIDEwMDAuNzE0MzU1XSBkZWJ1Z2ZzOiBG
aWxlICdtZicgaW4gZGlyZWN0b3J5ICcvJyBhbHJlYWR5IHByZXNlbnQhDQpbIDEwMDAuNzE0ODkw
XSBkZWJ1Z2ZzOiBGaWxlICd3cl9jaF9jbnQnIGluIGRpcmVjdG9yeSAnLycgYWxyZWFkeSBwcmVz
ZW50IQ0KWyAxMDAwLjcxNTQ3Nl0gZGVidWdmczogRmlsZSAncmRfY2hfY250JyBpbiBkaXJlY3Rv
cnkgJy8nIGFscmVhZHkgcHJlc2VudCENClsgMTAwMC43MTYwNjFdIGRlYnVnZnM6IERpcmVjdG9y
eSAncmVnaXN0ZXJzJyB3aXRoIHBhcmVudCAnLycgYWxyZWFkeSBwcmVzZW50IQ0KDQpUaGVzZSBj
b21lIGZyb20gZHdfZWRtYV9jb3JlX2RlYnVnZnNfb24oKSwgd2hpY2ggaXMgY2FsbGVkIGJ5IGR3
X2VkbWFfcHJvYmUoKS4NCg0KVGhpcyBpcyBhIGRpcmVjdCByZXN1bHQgZnJvbSB5b3VyIHBhdGNo
Og0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcGNpL3Bj
aS5naXQvY29tbWl0Lz9oPWNvbnRyb2xsZXIvZHdjLWVwJmlkPTlhYjVjOGJiN2EzMDUxMzViMWI2
YzY1Y2I4ZGI5MmI0YWNiZWY3OWQNCg0KV2hpY2ggbW92ZXMgZHdfcGNpZV9lZG1hX2RldGVjdCgp
IGZyb20gZHdfcGNpZV9lcF9pbml0X2NvbXBsZXRlKCkgdG8NCmR3X3BjaWVfZXBfbGF0ZV9pbml0
KCkgKHNpbmNlIGR3X3BjaWVfZWRtYV9kZXRlY3QoKSBjYWxscyBkd19lZG1hX3Byb2JlKCkpLg0K
DQpTbyB3aXRob3V0IHlvdXIgcGF0Y2gsIHRob3NlIGRlYnVnZnMgZXJyb3IgbWVzc2FnZXMgYXJl
IG5vdCBzZWVuLg0KDQpUaHVzLCBJIGRvIG5vdCB0aGluayB0aGF0IGl0IGlzIHN1ZmZpY2llbnQg
dG8gb25seSBtb2RpZnkgdGhlIHBjaS1lcGYtdGVzdA0KZHJpdmVyIHRvIHJlbGVhc2UgdGhlIGRt
YSBjaGFubmVscywgYXMgSSBkb24ndCBzZWUgaG93IHRoYXQgd2lsbCBhdm9pZCBlLmcuDQp0aGUg
ZGVidWdmcyBlcnJvciBtZXNzYWdlcyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2guDQoNCg0KS2lu
ZCByZWdhcmRzLA0KTmlrbGFz

