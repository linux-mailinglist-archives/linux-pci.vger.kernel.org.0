Return-Path: <linux-pci+bounces-2254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4076B830242
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4EC286889
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635F14016;
	Wed, 17 Jan 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ooI0pjyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E11401A;
	Wed, 17 Jan 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483467; cv=fail; b=trqAFUDNUDVnDo+NtfezYOQm84rm62FRUACH7udEXaa7mT0NSLyRMavcBWzJW+bqv/29cJwe8Z6lJE3Mu9B46AdB9+nZlEcRcrRw+QoYgzcOUAgMBlndoFFe7UtMo4rzFm0XUCZi1L6hz9EUB5KATyFbOgin4NFucW9Yoit/9q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483467; c=relaxed/simple;
	bh=dGmfvLay2kH23NMIfPZk/qX2qvweuF5BZbyh+FDoOzY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=baYSXV/5dOMcUjgJ46GanOfN9tBu6Xz67STJO0yQJxV9hGCiXbZj+VR82JrGklRniwZ8RYvsRVycyOjh/QbK6leEYV0AFiK4COlAlRE/kSk5v72bsbT8V2Z9I6iwrnFoOsqifkYbzMRq4Epw9OSF92LeT2h6eZBk/6Oyq7X5FlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ooI0pjyq; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705483463; x=1737019463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dGmfvLay2kH23NMIfPZk/qX2qvweuF5BZbyh+FDoOzY=;
  b=ooI0pjyqsOtoOp5pTniiZF/UdDY+muR5sD4B9Wd9K6qZScLB5VEzVKOY
   BFMySKgRcyf/OLgT43qzXmldHbupygmZ99idMjfqUTcllIKZVC0Cq/jez
   SywEImMNYEPJ41w+RuSbTSbKuki8Np7GXy7OyKNqUZ18a396LFM3wvtxx
   D4vnNyDxcfYONsIX84tM6Yo4CjnG1RT0DdZonuay/wMsQQY2XKg/9ebgN
   u0c9BdqJH8n/Fx7Sk9OkQ9VCe/JPJWr1jk7FSsLzRSa1xPD6V2FIyfmeK
   ZgRY5Y2AKmqKajuElhbMRjhikZx6jJ7IsJKyJzpRUniagw0wRZqlCWcz9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="19579418"
X-IronPort-AV: E=Sophos;i="6.05,200,1701097200"; 
   d="scan'208";a="19579418"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 18:23:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTmOCo1BUJ8BYTGZannY7/UD2Z/ntFkVnQGk+pTq9tTlyrfQsyEZa2J6TxJkzW/up/Fm9ztvx9a0+Cb6HCAzx7MqSVhzeOeq58PqoI9WoKE3pKVYQgsWXRr+qEgQzrRgWW2dqBi0dAZH6o/c5KrYe2p5fbKnV2taa/bCrDUp18G7ta49a1Xcydhpqym7hgbPiWYByUyd5WGB6yaalEXtDiiICRgOBI5L0e+AwxHfQUJ6ojT33jz43KOVsUi4nQ1X92Mtzhz57yCHBfwT0oBHn46FMXnnaCQLr2aPEfwWT1lGnSp/PTm/yAwLuFwdSSzPdlnthOSveVmQ+pzEDlHqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9I3327izq2Hs2/slwR6zr1Y+j5fYq3pGgeACvvSPuo=;
 b=B/eZNsx1eeBcO1EK4FSnEidW8uqEUlbOCMnrW9Ck+F0ep6FVWL61bhGaEqb0zkZEeKaKzbewoVFHTRDKAd50z/VT9vT0FDgKIyqd/O4gUjFRojaMG5bXzfBg7gej3KZY6+epFrz21JbmUcqrA68+/bZXpI7QTS7TqqQUEP9wyHjT4s+6Y/1nE06unPtggPAaJ+8WanQhX8MjRiEIb+CoTZu2xjAU6ucc/k2nDfd9iVONrpnu+OmUtuUVwrXQmJ2iPUz2UV3eA7Q9bvmKHl2ygCzzzQtkhyCv6pK7VvRhWmLn72FuO8PKK9F6HUfMfo3LFUlkKQo61RPJHWTAZY2TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11764.jpnprd01.prod.outlook.com (2603:1096:400:3b8::7)
 by TYBPR01MB5454.jpnprd01.prod.outlook.com (2603:1096:404:801d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 09:23:07 +0000
Received: from TYCPR01MB11764.jpnprd01.prod.outlook.com
 ([fe80::19d6:fc5e:27ce:1700]) by TYCPR01MB11764.jpnprd01.prod.outlook.com
 ([fe80::19d6:fc5e:27ce:1700%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 09:23:07 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, 'Jonathan Cameron'
	<Jonathan.Cameron@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Thread-Topic: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Thread-Index:
 AQHaMwXr559Y+43gz0Gam6b/l4Ghc7DRwyuAgAItCgCAAj19AIAEiiJQgAJoPwCAAMIzUA==
Date: Wed, 17 Jan 2024 09:23:07 +0000
Message-ID:
 <TYCPR01MB1176459803A873C402809104ABA722@TYCPR01MB11764.jpnprd01.prod.outlook.com>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
 <20240109155755.0000087b@Huawei.com>
 <659f404a99aad_3d2f92946e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240112112414.00006443@Huawei.com>
 <TYCPR01MB11764763DFE894B96EF0C6C38BA6C2@TYCPR01MB11764.jpnprd01.prod.outlook.com>
 <65a6f52e5724d_3b8e29410@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65a6f52e5724d_3b8e29410@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d370c119-dc12-416e-b815-1066b7834358;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-01-17T09:04:21Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11764:EE_|TYBPR01MB5454:EE_
x-ms-office365-filtering-correlation-id: 8c49bd9c-a39f-4da9-5d01-08dc173dea51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /HA7W/jaeNAy8UOFieT7RXFIp5ZoL5fwbWA3CMwRSlojbP4kEhGoJeU4meEoXPJIhfdUOSK5ijhLvdwPR8roxXWKuDBLbldn1V7yrzEWgbpret0zKmhzwe6GnNzve/Cr1n98UtCxhIje4iCxAxJlZpW/TtnBHYfyBVARHf1tALkFIiZsHdmzkRmtKpmXzhQKBNKycAdo2XQTPZYkvkcEny/MRGHt5/VJXeKtohFTIYINBxBP6K3H8DncaVT0tpUKRHDMERhkZESV8Ra1njHTDqY6X85tEUYg36PjnCdFKD3Nqo82SO7HRtpI9oxnw3d9+W8xTeACmEYJvUDL8Dr7YqY5WdAoWS21/FxM085c32fMWx/wGbET3hEHHBo7s9jqoOEjchbMaVFJgLEw3ZbJaLpYUVIpmPVh/Py+RULLbo4uvUAm7FMkbpevu2PdVr6AgBOVp6IGVKUfDgKPT2+maHXlPn5adZrV6qELc7PFjjHZLXmsxRdh80xTET8hals3ykhok6tyNIxh3r6ICJ8natgpmmtpcXBWrrKwaHJ2qOifGaN7S8fsNxlmBXTsKbuQBwnu2NVs/WuYV5IjXHI0OJv0n+e/2uPxhgp4aqEI0UunJyjDqdq+OTW+gq1xiU46rn9RlQPIDiptwg8QNdOgtg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11764.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(1590799021)(64100799003)(1800799012)(83380400001)(1580799018)(33656002)(41300700001)(86362001)(82960400001)(85182001)(52536014)(38100700002)(122000001)(4326008)(110136005)(66946007)(2906002)(66476007)(64756008)(8936002)(8676002)(66446008)(316002)(6506007)(66556008)(76116006)(54906003)(107886003)(26005)(7696005)(478600001)(9686003)(53546011)(5660300002)(71200400001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?eFZwS1pSMnI5ZVJOam9sTm1LYlBQUTFJRC9leE9MeFpMR3FFZ2hESUIx?=
 =?iso-2022-jp?B?K0dMcGFvMnZvSmRud0N1RWtUNkpoVEg1ek9KUjNaT2JwZ0RadHJPUTdh?=
 =?iso-2022-jp?B?dXpRSkRWUXlaMUwxTzJmOFpkcjVieHd0dlhoMEtPMlNISFpIcGxSZyto?=
 =?iso-2022-jp?B?eWNlWTBQMTdhTFF4VjlxNGFzUmpBMis2aDFrZWdKbXBEbWJoeHpCQ1Nt?=
 =?iso-2022-jp?B?R1lRU2FmMFFaVTZySGlyWDhuMFEyaUc5MWxqYm9OcysxSnJnYUI1UER1?=
 =?iso-2022-jp?B?NW5zSDQ5YnlWVWpCaU9sOHpsV0J1czBTU2EyalIydll3ZkFWd2tiYWZa?=
 =?iso-2022-jp?B?WWJSSjJuUjR3dkFDay90RVJOTk9UVklhbDZyMU9BTHZPdngvVzg0T2JP?=
 =?iso-2022-jp?B?TUVnY1FQd1FVT3o2VzNKWlRXajhhMll3MDNLSnpnVnphV0dYditYU1hk?=
 =?iso-2022-jp?B?a3dDbnZ4TGQ2c3M2TFFQU1JsVHF2SjkyN0JpN2RmOFpBU0dvQkJXMEpv?=
 =?iso-2022-jp?B?WGtwTGFUWHpPdlQ1OEQrU2VEcFRha3dURkt6bXFNUHNQUWQ2bkNiR3Vk?=
 =?iso-2022-jp?B?Y1Fhem1FUDdMR0tBUUk1d2FtZ3NEU1pYKzhoV3hvMTFlT3k3aXYxeEpO?=
 =?iso-2022-jp?B?Z0VScGI0d1RPL3hVVHUzb0JxVlBWdEZmcHVwQ0FmMFJaeTV0WnROOGVj?=
 =?iso-2022-jp?B?My9xK2ZSN0tsd3R5ZEFHRUJYZ1FFK1JtOXIzZWtydFgwaUEvV3NPdXpn?=
 =?iso-2022-jp?B?bVgwajZBTEs2bG1PdXRvbzBkZE85TWU1ZlFmamJ1SXc2NjByWDl4MTRQ?=
 =?iso-2022-jp?B?Wk10VTRBUjNkNEE5VzdnWElmRThic2N6cnFKUTZJSVZaM3MydHhuODJs?=
 =?iso-2022-jp?B?MjV1ekF3MHVFUFExRGUrdWUyMHRDREdDMms1ME02dXFielBiaDZ6ZFlt?=
 =?iso-2022-jp?B?elNZVFJoQWN0bnkrb21HeTNHWVNwWko1a09YU09waFR4TGhVZFFaY2g1?=
 =?iso-2022-jp?B?anhPbXd5Mm9QUktuUElRbXhta0Z1eFNhYW1jampWcWxPUmJZUGpRRVR0?=
 =?iso-2022-jp?B?eXlmejNoQVhXNS8rY1I0TE9JMmFoWTN0RkpOZ2dnWGd1YzBiVSszakdP?=
 =?iso-2022-jp?B?MTYwMmR3ZUxEOWt3QUxocHhOV0dBOXVwZ3hhOFc3Q3BWMitnYmlyQTM2?=
 =?iso-2022-jp?B?NGhBNERScG8yZzNOSU9XMW5jVGtiUlhxVFVrZVpZR0hOQXdXcFUvajlP?=
 =?iso-2022-jp?B?Y2RSa2pRbzFaVm0xdXY4d05rcWtMSDdQNWZCMXRvcE5zODBhWlBEK1dQ?=
 =?iso-2022-jp?B?RCtmaFhCbmZ6bG10SzJBTUk3MTI3TXJIYTY2K05DYW5aQVBWMnQ3VHVK?=
 =?iso-2022-jp?B?MTc1WEN4b2hEcGZvd1hCdHprZVVtMW5oSVVqOEVBVVhmcEdsR1FVZ3gv?=
 =?iso-2022-jp?B?WVFUT3h2ZkhBZHpoay82ejdjYmY1WWpCdktCY3A5ekNZbi85V1ZUL2I4?=
 =?iso-2022-jp?B?N2pHdlB3TXJ4WUlmd0UrUHFhNHJjNUpKcVVuaFgxN0R0RGpGeW9URFB2?=
 =?iso-2022-jp?B?OVhENUZtM3M0OWdob2l2V3o5eTNSWnJheGh2dnJkRzdvVUhXVHQ3bit0?=
 =?iso-2022-jp?B?SnRnck9UZkxVNHczcFlLaEQxZUFWMzVxTFJOMnhSNlR0eVhKL2NMV0RS?=
 =?iso-2022-jp?B?d1prNE0wVzlra3RhaTRqa09pN3BTTWt3RUlXUHVsd2dRaEVDdGNCeDRM?=
 =?iso-2022-jp?B?eHVjekRFWmpKNVBBSngyL3ZIVHQ0SDRCQTZsVVdzQjdDekY0eHlORXhU?=
 =?iso-2022-jp?B?dEZBeUxFVE54NzhOcVJoZjBNVFViQUI1NHZ5S1ROMEJPRlZwc0hHRjEv?=
 =?iso-2022-jp?B?MlZac0NSNVp4UmFCNllTWFBqQ0VkbDVqMmlZQStRRnNRYklDeDdhSmJz?=
 =?iso-2022-jp?B?SGhKSjJmdDc0N09yRFZJTmhOSWRZRG9yOE9GT0lWd1FrMmZhMXplTkhF?=
 =?iso-2022-jp?B?aGJvNnJPQ3pPNmtEeHBEWk0rMCszZGFjSnJZc3RseUozUU1KWUtVM09D?=
 =?iso-2022-jp?B?TnNvZ1FPaVlEUGNnUmpzTFJpWDFTSWhKM1pSdDVqalpsRm5mbDlKTVRT?=
 =?iso-2022-jp?B?b3JTVW1YZVJXeXJOSS90ZW5oYndIaWRuUHlFeGZRNWllRGIxNDhqQU1N?=
 =?iso-2022-jp?B?N3VBL3RuaDFZZ1dWZ01VSkExeUY5b0VWcXpSVGNpQjJlK1QxS3RVeEM1?=
 =?iso-2022-jp?B?bUZGMnJ2TGtpWjRtUlFyK2J1MGZJMzhFWk9mTEpWTEJoM0tId3h6cVFT?=
 =?iso-2022-jp?B?MzNTSlBBd1Yya2hreGRHSjRVWVE4QW5Xb3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hPHsuMrCiGz0CacaDWWOcZwKTsfo68504HJc6FIgE8K52m0nP4ZYYsTmwVjjS8zsch8I3J5tU5LIGU6cCLeBZQzArDPdkNcwbtVwzY/x0rEcfTCpdzRFf7U9l7j3iPHKXFTnJioJxaAMlqw3D/MZRhtk2wYmu1rZ1Ib9BeQEsQa40+W40EMau5ymYcSjNTfF5fe3vVYxEVhghrgKN+8zPVDUOY8vNPyy8o3HQLiaxR+DnqJ78TRjgH0poZeWIXwsvJOfI2bWoegHVX/J8XOyT+ot/cQ0GG4EUW8KoPN21HZx+0jhWPSrp4p6SH6cgASAOOIfsP+rbMRe6aNS5Ivur65krtPrtkw2q8D0ZyUI/645WnUfI4PztcuT6RbJvalFSuNDZnjTkL6/2oYdhpmtgZHDW0SGApVGrPg/9FSqlNq2yVsbVOKQcbW8NVNiEn5sv3FZgSoChOzzdgVDmUYpBwdYGUMlCFYtle7Sczcm28mTx7ff9+Ov98hdXcl7Zpd0mmEuGasJevdok54LSgAbNcPwRszcvxjTaeXtuMRo0ufR9EZOenyMYPkBJ9GSHbp7yQpExY5lNpmhHFxRwLI8DBSRIbilnCNl90U1b293Hp4NRLnfAuoVCYAnygxJVi5e
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11764.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c49bd9c-a39f-4da9-5d01-08dc173dea51
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 09:23:07.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZDA4Q0nAiKyQavXUwKdD0/Y9KGVQCbr4QlkgPU6PLRtFt8W/tBoaxqwBVUyWxTYd1xPM/CuXDFh0d1FqEM7bK5khk4TOrwV7WFotv4RdA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5454



> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Wednesday, January 17, 2024 6:29 AM
> To: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fuj=
itsu.com>;
> 'Jonathan Cameron' <Jonathan.Cameron@huawei.com>; Dan Williams
> <dan.j.williams@intel.com>
> Cc: linux-pci@vger.kernel.org; linux-cxl@vger.kernel.org; Gotou, Yasunori=
/=1B$B8^Eg=1B(B
> =1B$B9/J8=1B(B <y-goto@fujitsu.com>
> Subject: RE: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
>=20
> Daisuke Kobayashi (Fujitsu) wrote:
> > > > I am wondering about an approach like below is sufficient for lspci=
.
> > > >
> > > > The idea here is that cxl_pci (or other PCI driver for Type-2
> > > > RCDs) can opt-in to publishing these hidden registers.
> > > >
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> > > > 4fd1f207c84e..ee63dff63b68 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -960,6 +960,19 @@ static const struct pci_error_handlers
> > > cxl_error_handlers =3D {
> > > >         .cor_error_detected     =3D cxl_cor_error_detected,
> > > >  };
> > > >
> > > > +static struct attribute *cxl_rcd_attrs[] =3D {
> > > > +       &dev_attr_rcd_lnkcp.attr,
> > > > +       &dev_attr_rcd_lnkctl.attr,
> > > > +       NULL
> > > > +};
> > > > +
> > > > +static struct attribute_group cxl_rcd_group =3D {
> > > > +       .attrs =3D cxl_rcd_attrs,
> > > > +       .is_visible =3D cxl_rcd_visible, };
> > > > +
> > > > +__ATTRIBUTE_GROUPS(cxl_pci);
> > > > +
> > > >  static struct pci_driver cxl_pci_driver =3D {
> > > >         .name                   =3D KBUILD_MODNAME,
> > > >         .id_table               =3D cxl_mem_pci_tbl,
> > > > @@ -967,6 +980,7 @@ static struct pci_driver cxl_pci_driver =3D {
> > > >         .err_handler            =3D &cxl_error_handlers,
> > > >         .driver =3D {
> > > >                 .probe_type     =3D
> PROBE_PREFER_ASYNCHRONOUS,
> > > > +               .dev_groups     =3D cxl_rcd_groups,
> > > >         },
> > > >  };
> > > >
> > > >
> > > > However, the problem I believe is this will end up with:
> > > >
> > > > /sys/bus/pci/devices/$pdev/rcd_lnkcap
> > > > /sys/bus/pci/devices/$pdev/rcd_lnkctl
> > > >
> > > > ...with valid values, but attributes like:
> > > >
> > > > /sys/bus/pci/devices/$pdev/current_link_speed
> > > >
> > > > ...returning -EINVAL.
> > > >
> > > > So I think the options are:
> > > >
> > > > 1/ Keep the status quo of RCRB knowledge only lives in drivers/cxl/=
 and
> > > >    piecemeal enable specific lspci needs with RCD-specific
> > > > attributes
> > >
> > > This one gets my vote.
> >
> > Thank you for your feedback.
> > Like Dan, I also believe that implementing this feature in the kernel
> > may not be appropriate, as it is specifically needed for CXL1.1 devices=
.
> > Therefore, I understand that it would be better to implement the link
> > status of CXL1.1 devices directly in lspci.
> > Please tell me if my understanding is wrong.
>=20
> The proposal is to do a hybrid approach. The drivers/cxl/ subsystem alrea=
dy
> handles RCRB register access internally, so it can go further and expose =
a
> couple attributes ("rcd_lnkcap" and "rcd_lnkctl") that lspci can go read.=
 In
> other words, "/dev/mem" is not a reliable way to access the RCRB, and it =
is too
> much work to make the existing sysfs config-space access ABI understand t=
he
> RCRB layout since that complication would only be useful for one hardware
> generation.
>=20
> An additional idea here is to allow for the CXL subsystem to takeover
> publishing PCIe attributes like "current_link_speed", that are currently =
broken
> by the RCRB configuration, with a change like this:
>=20

Thank you, it seems that my understanding was incorrect.=20
I will try to consider the implementation by dividing it into parts:=20
the hook on the pci driver, the RCRB access in the cxl driver,=20
and the sysfs reading in lspci.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index
> 2321fdfefd7d..982bbec721fd 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1613,7 +1613,7 @@ static umode_t pcie_dev_attrs_are_visible(struct
> kobject *kobj,
>         struct device *dev =3D kobj_to_dev(kobj);
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>=20
> -       if (pci_is_pcie(pdev))
> +       if (pci_is_pcie(pdev) && !is_cxl_rcd(pdev))
>                 return a->mode;
>=20
>         return 0;
>=20
> ...then the CXL subsystem can produce its own attributes with the same na=
me,
> but backed by the RCRB lookup mechanism.

