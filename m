Return-Path: <linux-pci+bounces-2476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBF838B74
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862361C218EC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F15A106;
	Tue, 23 Jan 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="45sSmFy9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B35C5E0;
	Tue, 23 Jan 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004836; cv=fail; b=eiWbe9rVW/LrR7kR3+UVhw7xhhjXf1NxHBm0gv9Cc9kdCy5/UQrjGXVDaOzZfTni+wAzT/aqRFEvVvy1yw9PRsROnqYOfoCDMebBNOuNsPRzRBBZwWgSxTzsHYJ8v4ekzN5GS2Bg06Mft1SHbB8jKg5LI3eRtg2v+N/R9xQtb5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004836; c=relaxed/simple;
	bh=qbkh8761xeZXJSWIQfHFhE9vM0guL/DRZcMpHeLG8Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oNqgbpgMzotcuYud29upIt34WA7vmKFatn99Ni+XKcsO3jB0q/7YXV5Qsf4MZG5FVNwL4uW6bt1nB556jwKqIFCgExSvlE9KDXDxSejFVkd7ksB7Fii1zPWu/g3quBkEPyh29b/bEsyB5TwOTWwPzTVd7pFLUHbm+7Z4kYTLrz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=45sSmFy9; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifyWFJp24gaCmslRqP6imJV67UjeCGW+NGFg3X0p4MT4GkO6kSXYwsazM6QTHQ+oL+1e1nbMSt2NpELNH+ztpqlMrx2FikPxcdSL36dbGT7mbfYIWCeIseM8DIdlmBKQLtfQ/k+yRX9JpvSa1hBD/PP+RYWIQrKJ4ObVsSFvqenKllBPa4CbDZUkgk6JVou1vPZ6hy6U1Flt+Ww6F/Mx5aL+aU0rWm8oJzFNmp8Y/4NhgHWydIFbSm8HpBqNIYgp+61shj3MeD/BEKfh8kY1UdDTWLL6DNnEk00lPZlTX+cDxcANv0U5/JRm/om0uSEq62p3Y4ZXsWnmRxFrB3+0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbkh8761xeZXJSWIQfHFhE9vM0guL/DRZcMpHeLG8Js=;
 b=mfvaqgjM70oDQZyoTKKNNCZ8Hq/EJXYLTsKVFQQyt5m+re4ix3pYWqtkm+W7ImJCHRbJRAxt814E1KVR7OT5klc1UzOSN3cvAfl+86Pcp9+EVh7KltVsxJY4KaWghvTynm1ud9lZMn2IR3YtSVl8kMfdzGjiHTjPCR4ggeMXrViKlvJ3xf2D+w2TWHhFrWXJGkKwgrHnbFB10nW6X+FUcIFg1qt2ot/2Ld9Yrkmgl2veZa5vrRX2bKUhdPJC8HvLXAAUaYB/Jc7VIUQnC8ZP7JSzWyrML0kT733HJGevbETrF8XqOewNZgSrB90N7yAU0BTzZ6PGGREvlgAbRwS/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbkh8761xeZXJSWIQfHFhE9vM0guL/DRZcMpHeLG8Js=;
 b=45sSmFy9W+K95YWIfryd0CXhOqDNo4LsyN8DkWVibHCW+JiqQj5gAjxLcQSvCHwojgcdRdhzazX2hpUI0bRlrCPQGc9LahJbLGyEuoBLK6tQ75utX1IpHmDhSk/aZLiA3MSRn94UwEXyNaci5Ben7xP4oPNyK83I/wbOXcuTY5A=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 10:13:52 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::bafd:1985:94e6:ef33]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::bafd:1985:94e6:ef33%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:13:52 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Hildebrand,
 Stewart" <Stewart.Hildebrand@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"Chen, Jiqian" <Jiqian.Chen@amd.com>, "Ragiadakou, Xenia"
	<Xenia.Ragiadakou@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Topic: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Index: AQHaP5+doYjSbLzTtkiUcLxinuNXV7DmmK+AgAEHcQA=
Date: Tue, 23 Jan 2024 10:13:52 +0000
Message-ID:
 <BL1PR12MB5849D7A9EC2BEB55CAF3A889E7742@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240122233731.GA291870@bhelgaas>
In-Reply-To: <20240122233731.GA291870@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5111.namprd12.prod.outlook.com
 (15.20.7202.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM4PR12MB5101:EE_
x-ms-office365-filtering-correlation-id: dde0e558-0a86-415e-6734-08dc1bfbffe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LKUUyGBSUXG6svQmSuiUXBKS47uRehgMgbfcBiUN4RH19x8Djcwe4vMHK3URrkuYbQKwGnPhp2XoXveFnHNCqcdFm2YCkvMw0xG4bCJdxSzjqLJ6v4UIvTKCIXF1unXUXpUP4Ip6E5pv+14f7syErIHd/zhVG3/i0EzKQ7UMiFEhvnPr9G1xI17YnoZUKzhSLJ2ZufC/6SZhPM3iRro2CJPjk/Lnai64UJyFvqLJ/i7UpTb6TllU1lT+PKnKTQmMNYBb/ZSQF0eI6/G4FOupI2DW2/i2zgQ3NNdmxNdQKRfs8Z6/FqzSAMRXdrc3Z4C0UO2mzTY4rXWGckNNPvge2tUEmLHjylF3FNdsCeVjppJ+TqKqfd8s/qKgMjEr3XazN8OjdxXF/q9hfG+5o49wJd6xsPTH9joIfgvCWq7fbbwiAa/Ms2+L2JaddhQDChMIeNQuBOyrOR/NjHNL5VeiJNEcDVUUTxjn+bMPNOee3C+KQQlhsQB+oeDwR5oXTwF4wBk+Y3pRdjpmh/l/MC3fJ11w9Gs7Jg2m9nyCSX5uj/DrecF/1Zjd9j94hKyw0D4iMaYAuuNaSUtEPQaZa4PKMi2ttrAz6ZmhQXUjzvVdYFv9pnaJuIpx9MCkaF0MMXLBkj1HEnS1/GQejAMXACbkiA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(71200400001)(966005)(478600001)(38100700002)(122000001)(55016003)(53546011)(83380400001)(9686003)(7696005)(6506007)(7416002)(33656002)(316002)(64756008)(54906003)(5660300002)(66446008)(2906002)(8936002)(8676002)(4326008)(52536014)(66476007)(110136005)(38070700009)(26005)(66556008)(76116006)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEYxRFRiN3hOaE9pOWpidE9EdVg4SmhHQ1o4QWkyaFlMbk00OVdZb2s0alNL?=
 =?utf-8?B?QjRUU3pmY2tJamUvbHl0N1NDcEpwOVNiajRCbzlOMkpPeUllT1pFaG1FYnhL?=
 =?utf-8?B?U0l2a2t2VnVNcGFITzY1VlRJaW84MEJJdzJNQ3lYaUdldFpMSjk3K0QyN3B5?=
 =?utf-8?B?M0xuN3FobS8zOXRIQk5FdXZaRHk0U3ZLZzE4TVZoakJqOUtnV2p4Z1NYbVlM?=
 =?utf-8?B?aWdrRWRXQloxUkF2K0Fka3kvOG9kYzF2SjBMa0lJUUVGaEJ2VGFEWWNaQ2F5?=
 =?utf-8?B?dnZvWk1KbVF3NFltVVZGa1ZEMTRDc1hxMlVkai95RUxBcEpGdGM3WlQzc04v?=
 =?utf-8?B?WDNIczBxQUptZXByRHE4dzZvN0tGN0paSGpLMWtIRlNEbkErRUpSckd4SmZr?=
 =?utf-8?B?TVE3TGo1OCtFdzlYQWNLQ2ttcERJK2JsSVcyYmNGOEsyWTZ6aFBEQmozcGdE?=
 =?utf-8?B?ejhWTDgwQ29yT2NxcXlabU10TE9BaDZJOS9oZUtSaTRqNDBoZlRMYWNGWmNs?=
 =?utf-8?B?WnN4N2NJMDJ3Q1RPY05PZ28ydHlPSUNoTkhSVnlIVjgvS3lDTzhRVWpBTTZG?=
 =?utf-8?B?QU1NL29jaFZxZVhMalMvUnFQbDY0ZDNjaEs0eFB5SmpXZWRxMXprYys0YXND?=
 =?utf-8?B?QkRtTTlscTBkdUVMY01Za0RHWlFzd2Q0NFpLcFRpTmJHQ1ZmTXlnRlFqUjh1?=
 =?utf-8?B?UkFoVnZ2dTVJYThDbitxaXFZRU9TdG5jTUg1TnIyV3NkaUlkbHpKVHF2b1pT?=
 =?utf-8?B?TjBiN3BPZFY1VEhFVnJvN2lFZW9rc1F6dlpFMTAycDdpYWJLVDRRWmdzanhn?=
 =?utf-8?B?MzRUMUtKSkh4QTFsaldaUlJGQjVka2hmQlNDM1dEbk1JZVE0a1duQnNyNXRl?=
 =?utf-8?B?MWpoTG9RNUVPVTV1cUFwZmorSEpNTVl2WXRCaUNwV3hxQ3VVN2gxVDRzT1h4?=
 =?utf-8?B?aXZ6SnhtdUprckEzNmlydEVPR2p4aVk0VjhYUEsvWXBEY3FLQXpHekliUzlr?=
 =?utf-8?B?OStkUDJNYWtZaEE1dEtodGVmZE1XTGRtZ3gzL3NWa1pYb3RSdjd4MEFMSFpF?=
 =?utf-8?B?NENUSlg3bHVPeWExcHlaMlFldFpZRXVRaXp4bWtaRGUwYVRrWHVobnhRQkRB?=
 =?utf-8?B?NFhDSk83SlhtUmVLQjNhUmpTOEdudnd1SjVYTi9wQjZkY2cyTFRYaE56dDdl?=
 =?utf-8?B?RnlvaUl4S2J3WWFiM3ozdjhwOWhrbVhMNTJsN2syR0lrazhSVWtCYS9ScGlU?=
 =?utf-8?B?Ymx1SldXd1V6MUp0V2l0a0d5WE5LUTBONGUwZS9ZU0cwSGhRZ3ozZ2JXWW10?=
 =?utf-8?B?SEdUN2ZGQ3Z5ZnRFbUc2bmpZY3JtM1lZczZ2YmJ0ZWRjRWlEMlBkU3Ztckhj?=
 =?utf-8?B?aWhKYzBoTWRacTNNZ09BdjlJY1RHOEJ5RWhKUCsrTHhqaVkwT3BUL2NTUFl6?=
 =?utf-8?B?bTIzQ3dTQWZCRFpFdHhWMUZuRVdFQlUyc3k0YWtTVTlWekdlTk0wTHJyak03?=
 =?utf-8?B?enVVSzdyY2tXM1Fab01QWmRUU01nZEVUTjE3U3lldGlHUWhWVkRDUUlWc2FD?=
 =?utf-8?B?Nk8rUDlvZzRKdDg1LzJ3cWdxbTRQMStidUFqQWlGK2l1V05EWFVJaXlKdlg3?=
 =?utf-8?B?UDNSaHNHeERCMTdXRW5DMXFCWDFXTjFWdlRMWHAyVXdBZ1JuS1FXZE9vb3p6?=
 =?utf-8?B?Tkhrdmx5ZU8wdXJpeE1NS1hJbU93dnRjSGc2WStnZnJzU0RISkhaN1ZqNEsv?=
 =?utf-8?B?c2hJS2xISWRndXo0MjIvSllpZU9DYTYwdGN5Q3RwRUNNYjA4bUZtWllqVEJ2?=
 =?utf-8?B?OGtkSFVFYjcrRWV6eDFqdTB0K2ZTd2dmM0diWVRnVHg2YzFqU1Nia3hqYnor?=
 =?utf-8?B?QytBZHU3d21NSUJOZ09EQkxSTjMyejk2ckttUHRzV1N5dXRWdkM3TzFISEpD?=
 =?utf-8?B?djltNGxQSzYvNG1Hc3o3WVJzTUxMd09YNUN4bmVZYkJVeWF4Sll1aDZOcGs5?=
 =?utf-8?B?akhvcUdxMDlaR3hrVmE5cVFBNFA3bGswSkE1M3VLN0FKQ21kSkdDMG9vVnVT?=
 =?utf-8?B?ZWRYRmJsMGhZUmhWS0NYZS96VmtpdkFLNlMvbC9QUzBRTFBpbHVPU1E4Z2RU?=
 =?utf-8?Q?qlb4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0B9A0128D0F0D44BA3A8797260C3494@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde0e558-0a86-415e-6734-08dc1bfbffe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:13:52.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGPxSXNAoawDl/vU62eCxMclrZTHxeGx61f9e1oPhubi8Bj9k4IaMPVZpe3L60VLnYompEfMxKOqotvp1J+f6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101

T24gMjAyNC8xLzIzIDA3OjM3LCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiBPbiBGcmksIEphbiAw
NSwgMjAyNCBhdCAwMjoyMjoxN1BNICswODAwLCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+IFRoZXJl
IGlzIGEgbmVlZCBmb3Igc29tZSBzY2VuYXJpb3MgdG8gdXNlIGdzaSBzeXNmcy4NCj4+IEZvciBl
eGFtcGxlLCB3aGVuIHhlbiBwYXNzdGhyb3VnaCBhIGRldmljZSB0byBkdW1VLCBpdCB3aWxsDQo+
PiB1c2UgZ3NpIHRvIG1hcCBwaXJxLCBidXQgY3VycmVudGx5IHVzZXJzcGFjZSBjYW4ndCBnZXQg
Z3NpDQo+PiBudW1iZXIuDQo+PiBTbywgYWRkIGdzaSBzeXNmcyBmb3IgdGhhdCBhbmQgZm9yIG90
aGVyIHBvdGVudGlhbCBzY2VuYXJpb3MuDQo+IA0KPiBJc24ndCBHU0kgcmVhbGx5IGFuIEFDUEkt
c3BlY2lmaWMgY29uY2VwdD8NCkkgYWxzbyBhZGRlZCB0aGUgTWFpbnRhaW5zIG9mIEFDUEkgdG8g
Z2V0IHNvbWUgaW5wdXRzLg0KSGkgUmFmYWVsIEouIFd5c29ja2kgYW5kIExlbiBCcm93biwgZG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGFib3V0IHRoaXMgcGF0Y2g/DQoNCj4gDQo+IEkgZG9u
J3Qga25vdyBlbm91Z2ggYWJvdXQgWGVuIHRvIGtub3cgd2h5IGl0IG5lZWRzIHRoZSBHU0kgaW4N
Cj4gdXNlcnNwYWNlLiAgSXMgdGhpcyBwYXNzdGhyb3VnaCBicmFuZCBuZXcgZnVuY3Rpb25hbGl0
eSB0aGF0IGNhbid0IGJlDQo+IGRvbmUgdG9kYXkgYmVjYXVzZSB3ZSBkb24ndCBleHBvc2UgdGhl
IEdTSSB5ZXQ/DQpJbiBYZW4gYXJjaGl0ZWN0dXJlLCB0aGVyZSBpcyBhIHByaXZpbGVnZWQgZG9t
YWluIG5hbWVkIERvbTAgdGhhdCBoYXMgQUNQSSBzdXBwb3J0IGFuZCBpcyByZXNwb25zaWJsZSBm
b3IgZGV0ZWN0aW5nIGFuZCBjb250cm9sbGluZyB0aGUgaGFyZHdhcmUsIGFsc28gaXQgcGVyZm9y
bXMgcHJpdmlsZWdlZCBvcGVyYXRpb25zIHN1Y2ggYXMgdGhlIGNyZWF0aW9uIG9mIG5vcm1hbCAo
dW5wcml2aWxlZ2VkKSBkb21haW5zIERvbVVzLiBXaGVuIHdlIGdpdmUgdG8gYSBEb21VIGRpcmVj
dCBhY2Nlc3MgdG8gYSBkZXZpY2UsIHdlIG5lZWQgYWxzbyB0byByb3V0ZSB0aGUgcGh5c2ljYWwg
aW50ZXJydXB0cyB0byB0aGUgRG9tVS4gSW4gb3JkZXIgdG8gZG8gc28gWGVuIG5lZWRzIHRvIHNl
dHVwIGFuZCBtYXAgdGhlIGludGVycnVwdHMgYXBwcm9wcmlhdGVseS4gRm9yIHRoZSBjYXNlIG9m
IEdTSSBpbnRlcnJ1cHRzLCBzaW5jZSBYZW4gZG9lcyBub3QgaGF2ZSBzdXBwb3J0IHRvIGdldCB0
aGUgQUNQSSByb3V0aW5nIGluZm8gaW4gdGhlIGh5cGVydmlzb3IgaXRzZWxmLCBpdCBuZWVkcyB0
byBnZXQgdGhpcyBpbmZvIGZyb20gRG9tMC4gT25lIHdheSB3b3VsZCBiZSBmb3IgdGhpcyBpbmZv
IHRvIGJlIGV4cG9zZWQgaW4gc3lzZnMgYW5kIHRoZSB4ZW4gdG9vbHN0YWNrIHRoYXQgcnVucyBp
biBEb20wJ3MgdXNlcnNwYWNlIHRvIGdldCB0aGlzIGluZm8gcmVhZGluZyBzeXNmcyBhbmQgdGhl
biBwYXNzIGl0IHRvIFhlbi4NCg0KQW5kIEkgaGF2ZSB0cmllZCBhbm90aGVyIGFwcHJvYWNoIGlu
IHRoZSBwYXN0IHZlcnNpb24gcGF0Y2hlcyB0aGF0IGtlZXBpbmcgaXJxIHRvIGdzaSBtYXBwaW5n
cyBhbmQgdGhlbiB4ZW4gdG9vbCB3YXMgY29uc3VsdGluZyB0aGUgbWFwIHZpYSBhIHN5c2NhbGwg
YW5kIHdhcyBwYXNzaW5nIHRoZSBpbmZvIHRvIFhlbi4gQnV0IGl0IHdhcyByZWplY3RlZCBieSBY
ZW4gbWFpbnRhaW5lcnMgYmVjYXVzZSB0aGV5IHRob3VnaHQgdGhlIG1hcHBpbmdzIGFuZCB0cmFu
c2xhdGlvbnMgd2VyZSBhbGwgTGludXggaW50ZXJuYWwgYWN0aW9ucywgYW5kIGhhcyBub3RoaW5n
IHRvIGRvIHdpdGggWGVuLCBzbyB0aGV5IHN1Z2dlc3RlZCBtZSB0byBleHBvc2UgdGhlIEdTSSBp
biBzeXNmcyBiZWNhdXNlIGl0IGlzIGNsZWFuZXIgYW5kIGVhc2llciB0byByZXRyaWV2ZSBpdCBp
biB1c2Vyc3BhY2UuDQpUaGlzIGlzIG15IHBhc3QgdmVyc2lvbjoNCktlcm5lbDogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTEyNDEwMzEyMy4zMjYzNDcxLTEtSmlxaWFuLkNoZW5A
YW1kLmNvbS9ULyNtOGQyMGVkZDMyNmNmNzczNWMyODA0ZjAzNzFlOGE2M2I2YmVlYzYwYw0KWGVu
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy94ZW4tZGV2ZWwvMjAyMzExMjQxMDQxMzYuMzI2Mzcy
Mi0xLUppcWlhbi5DaGVuQGFtZC5jb20vVC8jbTlmOTA2OGQ1NTg4MjJhZjBhNWIyOGNkMjQxY2Fi
NGQ3NzllMzY5NzQNCg0KPiANCj4gSG93IGRvZXMgdXNlcnNwYWNlIHVzZSB0aGUgR1NJPyAgSSBz
ZWUgInRvIG1hcCBwaXJxIiwgYnV0IEkgdGhpbmsgd2UNCj4gc2hvdWxkIGhhdmUgbW9yZSBjb25j
cmV0ZSBkZXRhaWxzIGFib3V0IGV4YWN0bHkgd2hhdCBpcyBuZWVkZWQgYW5kIGhvdw0KPiBpdCBp
cyB1c2VkIGJlZm9yZSBhZGRpbmcgc29tZXRoaW5nIG5ldyBpbiBzeXNmcy4NCkFzIGFib3ZlIHJl
YXNvbi4NCg0KPiANCj4gSXMgdGhlcmUgc29tZSBtb3JlIGdlbmVyaWMga2VybmVsIGludGVyZmFj
ZSB3ZSBjb3VsZCB1c2UNCj4gZm9yIHRoaXM/DQpObywgdGhlcmUgaXMgbm8gbWV0aG9kIGZvciBu
b3csIEkgdGhpbmsuDQoNCj4gDQo+IHMvZHVtVS9Eb21VLyA/ICAoSSBkdW5ubywgYnV0IGh0dHBz
Oi8vd3d3Lmdvb2dsZS5jb20vc2VhcmNoP3E9eGVuK2R1bXUNCj4gc3VnZ2VzdHMgaXQgOikpDQo+
IA0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL2FjcGkvcGNpX2lycS5jICB8ICAxICsNCj4+ICBkcml2ZXJzL3BjaS9wY2kt
c3lzZnMuYyB8IDExICsrKysrKysrKysrDQo+PiAgaW5jbHVkZS9saW51eC9wY2kuaCAgICAgfCAg
MiArKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2FjcGkvcGNpX2lycS5jIGIvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0K
Pj4gaW5kZXggNjMwZmUwYTM0YmM2Li43MzlhNTg3NTVkZjIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiArKysgYi9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiBA
QCAtNDQ5LDYgKzQ0OSw3IEBAIGludCBhY3BpX3BjaV9pcnFfZW5hYmxlKHN0cnVjdCBwY2lfZGV2
ICpkZXYpDQo+PiAgCQlrZnJlZShlbnRyeSk7DQo+PiAgCQlyZXR1cm4gMDsNCj4+ICAJfQ0KPj4g
KwlkZXYtPmdzaSA9IGdzaTsNCj4+ICANCj4+ICAJcmMgPSBhY3BpX3JlZ2lzdGVyX2dzaSgmZGV2
LT5kZXYsIGdzaSwgdHJpZ2dlcmluZywgcG9sYXJpdHkpOw0KPj4gIAlpZiAocmMgPCAwKSB7DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMgYi9kcml2ZXJzL3BjaS9wY2kt
c3lzZnMuYw0KPj4gaW5kZXggMjMyMWZkZmVmZDdkLi5jNTFkZjg4ZDA3OWUgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL3BjaS9wY2ktc3lzZnMuYw0KPj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLXN5
c2ZzLmMNCj4+IEBAIC03MSw2ICs3MSwxNiBAQCBzdGF0aWMgc3NpemVfdCBpcnFfc2hvdyhzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+PiAgfQ0KPj4gIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhpcnEpOw0K
Pj4gIA0KPj4gK3N0YXRpYyBzc2l6ZV90IGdzaV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+
ICsJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4+ICsJCQljaGFyICpidWYpDQo+
PiArew0KPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsNCj4+ICsN
Cj4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXVcbiIsIHBkZXYtPmdzaSk7DQo+PiArfQ0K
Pj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhnc2kpOw0KPj4gKw0KPj4gIHN0YXRpYyBzc2l6ZV90
IGJyb2tlbl9wYXJpdHlfc3RhdHVzX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPj4gIAkJCQkJ
IHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPj4gIAkJCQkJIGNoYXIgKmJ1ZikNCj4+
IEBAIC01OTYsNiArNjA2LDcgQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnBjaV9kZXZfYXR0
cnNbXSA9IHsNCj4+ICAJJmRldl9hdHRyX3JldmlzaW9uLmF0dHIsDQo+PiAgCSZkZXZfYXR0cl9j
bGFzcy5hdHRyLA0KPj4gIAkmZGV2X2F0dHJfaXJxLmF0dHIsDQo+PiArCSZkZXZfYXR0cl9nc2ku
YXR0ciwNCj4+ICAJJmRldl9hdHRyX2xvY2FsX2NwdXMuYXR0ciwNCj4+ICAJJmRldl9hdHRyX2xv
Y2FsX2NwdWxpc3QuYXR0ciwNCj4+ICAJJmRldl9hdHRyX21vZGFsaWFzLmF0dHIsDQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgNCj4+IGlu
ZGV4IGRlYTA0M2JjMWUzOC4uMDYxOGQ0YTg3YTUwIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KPj4gQEAgLTUyOSw2ICs1
MjksOCBAQCBzdHJ1Y3QgcGNpX2RldiB7DQo+PiAgDQo+PiAgCS8qIFRoZXNlIG1ldGhvZHMgaW5k
ZXggcGNpX3Jlc2V0X2ZuX21ldGhvZHNbXSAqLw0KPj4gIAl1OCByZXNldF9tZXRob2RzW1BDSV9O
VU1fUkVTRVRfTUVUSE9EU107IC8qIEluIHByaW9yaXR5IG9yZGVyICovDQo+PiArDQo+PiArCXVu
c2lnbmVkIGludAlnc2k7DQo+PiAgfTsNCj4+ICANCj4+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBw
Y2lfZGV2ICpwY2lfcGh5c2ZuKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiAtLSANCj4+IDIuMzQu
MQ0KPj4NCj4+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

