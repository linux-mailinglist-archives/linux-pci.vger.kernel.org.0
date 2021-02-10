Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E1316896
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBJOA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 09:00:59 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39364 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230267AbhBJOAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 09:00:47 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ADuaB7023106;
        Wed, 10 Feb 2021 05:59:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=enMg+WuhtzMch38r4jKePeZkDHlkRey/ScxvXmklo34=;
 b=RX+OGGG4fSSNjRlcesD/UGsd2EUWIT6O5sS+ZxfxjskgGSLyfD8Edm4cZ05GMEcbLwJF
 /H5cQwNjw/tcWAUaIzx4N0qdFlw+9W+qxRE8sQzpBaM0WcoT0L6JieOohSzAEgZNWJNl
 R68JdNQuKL49DpsLagdqwQIm1umT6Jk57yBsz5RL48rKpvOCyO539nhzTk2iflDT5WS5
 D2j6ScxcJpRkS4EbztdCzjfhmrEo9tdf5TIJAYaxOZWVJkQ3Pw+Gu+vni4q5jJfRbAmn
 oaCxUCSoVfE0tBpKhUxlGTiMJeHCdj5Q+dZF+eCW5I1tHz7oESfNkaUdFdGeMpLhICxJ Wg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrm0a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:59:44 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:59:43 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:59:42 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 10 Feb 2021 05:59:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+K2ROsvphrcJ8Tg90siYMo24sZVgOPM2XaQ4eljRGiOMR0aMQs/9Q2CIUuyluNgwQ6l247AoNVTySbkSAFnV5btj74DiJ2YNj8QDzEllQTQTi3IgV5c6DlA4WXwAjQAsVpQnrV+kuCtb5IiIvE8DXbFlnZzmzO9J8HXM8O0NkS9pbC+9nTQSPz8TWekLqZ4itSeVTyMBAFmKHWeQ+nyNGOxVkpiRWMYmtS3qg42sbrQ9vK0SfuFsNQ/pIu+HwlkZzPt7c2i+z0dLvJqMit5SPXnFHJ04WJwkRILgz6njC4457kdpAFJXlRfZNxpsUcJbEB2CJuhUZSWX/EYBzoPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enMg+WuhtzMch38r4jKePeZkDHlkRey/ScxvXmklo34=;
 b=kzVS8vtD/TtbzUwWPBWejRsxNcjI2N8u9FvAT1qk3Uc6ppFBBcj1bthIInexIyAvTQYzKK9dDl4ixMQ8Ywp4OZTUuGJudsgiVtC/B2+IvPkV2P35GTGUXi8MaOOWgKLZ0dHE2GrpniMKIoylhuh6L27KNRAixpARcTjPGxG2W6ciDpRukloUr6ThmS0h+pIkue14x8OvzhBcDG1/9M3uFQgk+VKm0NcivLrHKSw5/T1P77mwmNUcpD5QMKLeTWMEYHsfCopSdOazcqz9uV/4fZEa3iJ1BKLx3+mQNNr3NPrcGTX7Ejx1jiecjvgS6oWm4sKRADw/n5YsoGQDh9PlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enMg+WuhtzMch38r4jKePeZkDHlkRey/ScxvXmklo34=;
 b=PfHrv0cf+tuuLA6l3eXF9Yn7mK368OOKs6ylqB4a1aIPhM8BwwkVYntayQuTKgSvTRTl/F5mC+YN2WQ99oyYW42LyyUIHxbAgOmoA3ATTRZ45q1PC8t4H/LH3REGyl669y4YQc6ZVAOnc/b/K+K0JSRHgElYdlMsWhxCbiZW5Zs=
Received: from CO6PR18MB3873.namprd18.prod.outlook.com (2603:10b6:5:350::23)
 by CO6PR18MB3827.namprd18.prod.outlook.com (2603:10b6:5:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 13:59:41 +0000
Received: from CO6PR18MB3873.namprd18.prod.outlook.com
 ([fe80::c041:1c61:e57:349a]) by CO6PR18MB3873.namprd18.prod.outlook.com
 ([fe80::c041:1c61:e57:349a%3]) with mapi id 15.20.3846.025; Wed, 10 Feb 2021
 13:59:41 +0000
From:   Stefan Chulski <stefanc@marvell.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
CC:     Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] Re: pci mvebu issue (memory controller)
Thread-Topic: [EXT] Re: pci mvebu issue (memory controller)
Thread-Index: AQHW/4pQBXFbh5hPe0SNyN6hCiJLWqpRaEYw
Date:   Wed, 10 Feb 2021 13:59:41 +0000
Message-ID: <CO6PR18MB38735F882B1DDB29D7DEA170B08D9@CO6PR18MB3873.namprd18.prod.outlook.com>
References: <20210209141759.6960fccb@kernel.org>
 <20210210095408.75839806@windsurf.home>
In-Reply-To: <20210210095408.75839806@windsurf.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [80.230.78.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9b7e8a2-8529-426c-e078-08d8cdcc1cfc
x-ms-traffictypediagnostic: CO6PR18MB3827:
x-microsoft-antispam-prvs: <CO6PR18MB382775F574D159A79A6C133CB08D9@CO6PR18MB3827.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gy9/XKK/7QLv9c4DErHqazEYem+SGunlSxcSYBorADLYPcNBWW+v2M4vd+zj6z0sv9UNTPGnf/jMrNHiARF3Oo9S3amEzD+RRJRr/eieD0IUPXPqdlEKvBdmcVSNgfqLJ0uvXL9gV37pg97SMZxTkLumG+HE+HfOeRu85KiWaqnzHMfBk0RXw3X7aqZWXhWcfEHB3UCZv/c9WSspOeXIDy4i8Fe9/c9e/vMydkJYhTcCb88NX5GoP4K8BQpFEmRxSR0w8Meu4ruMaW4gmg5cH/cNp3JfxkP2L9vMgrYc3e+dpuEGdi4FuiSwGiFwwE144dO/jQ9ka0SoOdM9s0DQBRofeEtlX/750ESDVynwqOPVpOdC+oasa2IzpxT5ez/Nw3KWJkyGU5a9GSUN6r66jqa4SiyI7cdc08VkoJOY/MuZUM3ZGvMnCcb4BxY2CLlB8ayY7ULv5ewTLGTe3JUyy5oGwd+YxPNTWKzkqZUZRb85uO2rlPnGR7rIWJDzMZYh89HGwgus+nm7ju9736lWeexf7EXyfmC69r0fIpe7zCH5tjZp0frOBGNAlC8YjCn/Ba5008e8gpzDwxdxC0o4E5mANOmDet41p3JhFWTVG2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB3873.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(83380400001)(86362001)(33656002)(8676002)(4326008)(19627235002)(2906002)(478600001)(316002)(6506007)(9686003)(54906003)(71200400001)(26005)(76116006)(66946007)(55016002)(186003)(966005)(66556008)(7696005)(110136005)(66476007)(8936002)(66446008)(64756008)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M2FPcWhaUTV3WERReUZGSFNjODZHZEViSHExb1RTRlJkNDRXdEVsTnoyclFM?=
 =?utf-8?B?U3Z3dzhHQlh1WmhrQ1gyQ0Y5QVVvdTRjRkJiVkJPZHJud1MxSkZ6eFU3MTgw?=
 =?utf-8?B?aFdJcjhQUmZJZmt6UVkwNitZVElTTnVzT2JKcGlqS1R6YjZ0MU1BOTQ3OVFE?=
 =?utf-8?B?akIzakJRWG10VFAyQXJmRzRLVm0zT2h4VG8vRHN0Ty9KeVc0L1FGUmxqWEto?=
 =?utf-8?B?Q1Z5OHlwUVZRNGw2bnY0c3dQcm90R3Z0L09lME9HTGFZNFZ1cnJBR29VbXQ1?=
 =?utf-8?B?a29NTStsTEthM21xUkNlQ3pFZ0d1YnFVSXAvYVdlZnM3RXhSRThSV2xhWEsx?=
 =?utf-8?B?TUhxL3dUYUUzMnhERGpmRnh0ZW5OdEN5THRaSHh0a3k0YjNPWk9vK3o1bU40?=
 =?utf-8?B?QnpVVE9IKzNCa0xkZG9qU0xVcjd0clYwVmJaei9ZeUR0cDQwblR0ekt1Qkdq?=
 =?utf-8?B?UndCbFB5aG1WMmVwRGNWdEYxWWxldmdwMkcvVUZPamRDeXZMYVA2bDRLbkc0?=
 =?utf-8?B?VXl1eWVQdi9PYlBUS1NKaFc1clNPaU0wOXpoOU93Z0JlUm94R3dCYTdPOHE1?=
 =?utf-8?B?a3NXRS9ZWFUzcThHNlN6UEgyRktDT1I5cTYzWmY3SlA2QStxUzI2aEFiSkZO?=
 =?utf-8?B?MlpvcUxBQWNpakQ3dUhteU1nS3doSmo5ejZ3L3gwRDZabi9vV0VSNzhFOXAw?=
 =?utf-8?B?TFRweE1JTnRyVE14SUZoRVZZVlJMTVZzUnR0MmlBaUFkemZid3RRcmpncy82?=
 =?utf-8?B?cStWZm5wL2pnQUUraGRSQkFyMk5uU1VPQW5iOHluZjc5Qnl5WEFmb1UrWjJ2?=
 =?utf-8?B?T2lML0lBNm9wZGl0MHRBdVpWRlRuTDJLN25XVlVyMitSN1l4Y3FqeHdlL2FR?=
 =?utf-8?B?SFhEbXl1OXg3YmdGZ1BIWnU4N1FBZG5nMk5uRzVoSnRRN05iOHk1bXZORmR5?=
 =?utf-8?B?UjdWa1VJRmlFblIyUkdLamFNVWNUNjZ4Vkg2VUM0ODZHMmFQc1hDRnBReEdl?=
 =?utf-8?B?MXA2K0ZXWFNaU3NSTndSclNJdzNqLzJ5QW9FUy9yTnZ5R09wcnhPOWlLVGpV?=
 =?utf-8?B?ekNna2x3QWFNdkxKOG14aml2QnZraTJ5NjRrb0dLd0s3NzlxbVk4aUdsVXJr?=
 =?utf-8?B?MndEYUJKTVJTNVVjc0RxV3JNS0xpWmVWa2JxS2pDZkdrZVc3a3N2R1pqaWZ6?=
 =?utf-8?B?dFluZWRrd1o3R3BCU0JWbk5kVDBHYjllYUJ1YlVlTHdYZXdaNmpwSHZvaW5P?=
 =?utf-8?B?MUw0WDFYL1FqQWdFbmxCNGJNNzRyRFlGYklERXRKZWtpSzcxTzRJQTRPOGVS?=
 =?utf-8?B?azk1dUErUnhMc0pmcFJiNXh2c01LbGN1U3ZKYlZvQVRYS1ZrNUlWZEwrWjNl?=
 =?utf-8?B?Y2puazV5STM4d0puakxDWUo0dXpFd1RRZlNmL2xsWDZhd2crRlhpbGQxRnhV?=
 =?utf-8?B?bWlsYWhqK0gwaXJaRjdtQzNCbzFTWXp6U0hPckV3UFZNYVFjNGRvend5YXJX?=
 =?utf-8?B?YzRSK3o2aG1rZVZuc21jS3h3cEpSN1B6R1dTeEZJOW5wTXByVzhnaEZwUk9D?=
 =?utf-8?B?Mk5DUGZTTDE4amI3Rmg5VlFWUTRaRTNHbEdKbi9lYXE5c05kSXp2OC8zRlZW?=
 =?utf-8?B?RHA4TXNnZ1pXSE5nbUtpTjJEQTZGR0pXdUIvQnFIY1BEU1FvVEU0RGJQR0Zx?=
 =?utf-8?B?ZEpXcE5rVkF4ZVNZaFBvRkhVcHNJdFA2b2NSa3NDakM4MDJGcmxIRnhmVnYy?=
 =?utf-8?Q?W8a1ASti5cAL9yuYKUQntX0TzVOTh7VpXPz2XhO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3873.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b7e8a2-8529-426c-e078-08d8cdcc1cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 13:59:41.4768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILm7IDiwlJEcB1vCAuJ+pl+/QNjwbFL28XY9bjxC7uX4sLLGdQlO0gg4cem+7ZS6oQHceJAL7nKB55/vpeLzEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3827
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+IChzZW5kaW5nIHRoaXMgZS1tYWlsIGFnYWluIGJlY2F1c2UgcHJldmlvdXNseSBJIHNlbnQg
aXQgdG8gVGhvbWFzJyBvbGQNCj4gPiBlLW1haWwgYWRkcmVzcyBhdCBmcmVlLWVsZWN0cm9ucykN
Cj4gDQo+IFRoYW5rcy4gVHVybnMgb3V0IEkgc3RpbGwgcmVjZWl2ZSBlLW1haWwgc2VudCB0byBA
ZnJlZS1lbGVjdHJvbnMuY29tLCBzbyBJIGhhZA0KPiBzZWVuIHlvdXIgcHJldmlvdXMgZS1tYWls
IGJ1dCBkaWRuJ3QgaGFkIHRoZSBjaGFuY2UgdG8gcmVwbHkuDQo+IA0KPiA+IHdlIGhhdmUgZW5v
dW50ZXJlZCBhbiBpc3N1ZSB3aXRoIHBjaS1tdmVidSBkcml2ZXIgYW5kIHdvdWxkIGxpa2UgeW91
cg0KPiA+IG9waW5pb24sIHNpbmNlIHlvdSBhcmUgdGhlIGF1dGhvciBvZiBjb21taXQNCj4gPiBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC5r
ZXJuZWwub3JnX3B1DQo+ID4gYl9zY21fbGludXhfa2VybmVsX2dpdF90b3J2YWxkc19saW51eC5n
aXRfY29tbWl0Xy0zRmlkLQ0KPiAzRGY0YWM5OTAxMWU1NDINCj4gPg0KPiBkMDZlYTJiZGExMDA2
MzUwMjU4M2M2ZDc5OTEmZD1Ed0lGYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJg0KPiByPURE
UTNkSw0KPiA+IHdrVEl4S0FsNl9CczdHTXg0emhKQXJyWEtOMm1ETU9YR2g3bGcmbT1sRU5tdWRi
dTJobEs0NG1WbS0NCj4gZThiZ2RpOVJtMkFDDQo+ID4gRFhOOFFZMGZyZ2N1WSZzPTcxMDlJLQ0K
PiB4dnB4MXdXNTMycHh2azFXOHNfWGVHNzdWUWYyaVA3UXpoRWFvJmU9DQo+ID4NCj4gPiBBZnRl
ciB1cGdyYWRpbmcgdG8gbmV3IHZlcnNpb24gb2YgVS1Cb290IG9uIGEgQXJtYWRhIFhQIC8gMzh4
IGRldmljZSwNCj4gPiBzb21lIFdpRmkgY2FyZHMgc3RvcHBlZCB3b3JraW5nIGluIGtlcm5lbC4g
QXRoMTBrIGRyaXZlciwgZm9yIGV4YW1wbGUsDQo+ID4gY291bGQgbm90IGxvYWQgZmlybXdhcmUg
aW50byB0aGUgY2FyZC4NCj4gPg0KPiA+IFdlIGRpc2NvdmVyZWQgdGhhdCB0aGUgaXNzdWUgaXMg
Y2F1c2VkIGJ5IFUtQm9vdDoNCj4gPiAtIHdoZW4gVS1Cb290J3MgcGNpX212ZWJ1IGRyaXZlciB3
YXMgY29udmVydGVkIHRvIGRyaXZlciBtb2RlbCBBUEksDQo+ID4gICBVLUJvb3Qgc3RhcnRlZCB0
byBjb25maWd1cmUgUENJZSByZWdpc3RlcnMgbm90IG9ubHkgZm9yIHRoZSBuZXd0b3JrDQo+ID4g
ICBhZGFwdGVyLCBidXQgYWxzbyBmb3IgdGhlIE1hcnZlbGwgTWVtb3J5IENvbnRyb2xsZXIgKHRo
YXQgeW91IGFyZQ0KPiA+ICAgbWVudGlvbmluZyBpbiB5b3VyIGNvbW1pdCkuDQo+ID4gLSBTaW5j
ZSBwY2ktbXZlYnUgZHJpdmVyIGluIExpbnV4IGlzIGlnbm9yaW5nIHRoZSBNYXJ2ZWxsIE1lbW9y
eQ0KPiA+ICAgQ29udHJvbGxlciBkZXZpY2UsIGFuZCBVLUJvb3QgY29uZmlndXJlcyBpdHMgcmVn
aXN0ZXJzIChCQVJzIGFuZCB3aGF0DQo+ID4gICBub3QpLCBhZnRlciBrZXJuZWwgYm9vdHMsIHRo
ZSByZWdpc3RlcnMgb2YgdGhpcyBkZXZpY2UgYXJlDQo+ID4gICBpbmNvbXBhdGlibGUgd2l0aCBr
ZXJuZWwsIG9yIHNvbWV0aGluZywgYW5kIHRoaXMgY2F1c2VzIHByb2JsZW1zIGZvcg0KPiA+ICAg
dGhlIHJlYWwgUENJZSBkZXZpY2UuDQo+ID4gLSBTdGVmYW4gUm9lc2UgaGFzIHRlbXBvcmFyaWx5
IHNvbHZlZCB0aGlzIGlzc3VlIHdpdGggVS1Cb290IGNvbW1pdA0KPiA+ICAgaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZ2l0bGFiLmRlbngu
ZGVfdS0yRGJvb3RfY3VzdG9kaWFuc191LTJEYm9vdC0yRG1hcnZlbGxfLQ0KPiAyRF9jb21taXRf
NmEyZmEyODRhZWUyOTgxYmUyYzc2NjFiMzc1N2NlMTEyZGU4ZDUyOCZkPUR3SUZhUSZjPW4NCj4g
S2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9RERRM2RLd2tUSXhLQWw2X0JzN0dNeDR6aEpBcnJYS04y
bURNDQo+IE9YR2g3bGcmbT1sRU5tdWRidTJobEs0NG1WbS0NCj4gZThiZ2RpOVJtMkFDRFhOOFFZ
MGZyZ2N1WSZzPUIwZUtCa2JsRXlnUEdZdktEZE11d3p6WWhEZzVKbGhfUTQNCj4gZVhIbElMLW9j
JmU9DQo+ID4gICB3aGljaCBiYXNpY2FsbHkganVzdCBtYXNrcyB0aGUgTWVtb3J5IENvbnRyb2xs
ZXIncyBleGlzdGVuY2UuDQo+ID4NCj4gPiAtIGluIExpbnV4IGNvbW1pdCBmNGFjOTkwMTFlNTQg
KCJwY2k6IG12ZWJ1OiBubyBsb25nZXIgZmFrZSB0aGUgc2xvdA0KPiA+ICAgbG9jYXRpb24gb2Yg
ZG93bnN0cmVhbSBkZXZpY2VzIikgeW91IG1lbnRpb24gdGhhdDoNCj4gPg0KPiA+ICAgICogT24g
c2xvdCAwLCBhICJNYXJ2ZWxsIE1lbW9yeSBjb250cm9sbGVyIiwgaWRlbnRpY2FsIG9uIGFsbCBQ
Q0llDQo+ID4gICAgICBpbnRlcmZhY2VzLCBhbmQgd2hpY2ggaXNuJ3QgdXNlZnVsIHdoZW4gdGhl
IE1hcnZlbGwgU29DIGlzIHRoZSBQQ0llDQo+ID4gICAgICByb290IGNvbXBsZXggKGkuZSwgdGhl
IG5vcm1hbCBjYXNlIHdoZW4gd2UgcnVuIExpbnV4IG9uIHRoZSBNYXJ2ZWxsDQo+ID4gICAgICBT
b0MpLg0KPiA+DQo+ID4gV2hhdCB3ZSBhcmUgd29uZGVyaW5nIGlzOg0KPiA+IC0gd2hhdCBkb2Vz
IHRoZSBNYXJ2ZWxsIE1lbW9yeSBjb250cm9sbGVyIHJlYWxseSBkbz8gQ2FuIGl0IGJlIHVzZWQg
dG8NCj4gPiAgIGNvbmZpZ3VyZSBzb21ldGhpbmc/IEl0IGNsZWFybHkgZG9lcyBzb21ldGhpbmcs
IGJlY2F1c2UgaWYgaXQgaXMNCj4gPiAgIGNvbmZpZ3VyZWQgaW4gVS1Cb290IHNvbWVob3cgYnV0
IG5vdCBpbiBrZXJuZWwsIHByb2JsZW1zIGNhbiBvY2N1ci4NCj4gPiAtIGlzIHRoZSBiZXN0IHNv
bHV0aW9uIHJlYWxseSBqdXN0IHRvIGlnbm9yZSB0aGlzIGRldmljZT8NCj4gPiAtIHNob3VsZCBV
LUJvb3QgYWxzbyBzdGFydCBkb2luZyB3aGF0IGNvbW1pdCBmNGFjOTkwMTFlNTQgZG9lcz8gSS5l
Lg0KPiA+ICAgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHJlYWwgZGV2aWNlIGlzIGluIHNsb3QgMCwg
YW5kIE1hcnZlbGwgTWVtb3J5DQo+ID4gICBDb250cm9sbGVyIGluIHNsb3QgMS4NCj4gPiAtIHdo
eSBpcyBMaW51eCBpZ25vcmluZyB0aGlzIGRldmljZT8gSXQgaXNuJ3QgZXZlbiBsaXN0ZWQgaW4g
bHNwY2kNCj4gPiAgIG91dHB1dC4NCj4gDQo+IFRvIGJlIGhvbmVzdCwgSSBkb24ndCBoYXZlIG11
Y2ggZGV0YWlscyBhYm91dCB3aGF0IHRoaXMgZGV2aWNlIGRvZXMsIGFuZCBteQ0KPiBtZW1vcnkg
aXMgdW5jbGVhciBvbiB3aGV0aGVyIEkgcmVhbGx5IGV2ZXIgaGFkIGFueSBkZXRhaWxzLiBJIHZh
Z3VlbHkNCj4gcmVtZW1iZXIgdGhhdCB0aGlzIGlzIGEgZGV2aWNlIHRoYXQgbWFkZSBzZW5zZSB3
aGVuIHRoZSBNYXJ2ZWxsIFBDSWUNCj4gY29udHJvbGxlciBpcyB1c2VkIGFzIGFuIGVuZHBvaW50
LCBhbmQgaW4gc3VjaCBhIHNpdHVhdGlvbiB0aGlzIGRldmljZSBhbHNvIHRoZQ0KPiByb290IGNv
bXBsZXggdG8gInNlZSIgdGhlIHBoeXNpY2FsIG1lbW9yeSBvZiB0aGUgTWFydmVsbCBTb0MuIEFu
ZA0KPiB0aGVyZWZvcmUgaW4gYSBzaXR1YXRpb24gd2hlcmUgdGhlIE1hcnZlbGwgUENJZSBjb250
cm9sbGVyIGlzIHRoZSByb290DQo+IGNvbXBsZXgsIHNlZWluZyB0aGlzIGRldmljZSBkaWRuJ3Qg
bWFrZSBzZW5zZS4NCj4gDQo+IEluIGFkZGl0aW9uLCBJIC90aGluay8gaXQgd2FzIGNhdXNpbmcg
cHJvYmxlbXMgd2l0aCB0aGUgTUJ1cyB3aW5kb3dzDQo+IGFsbG9jYXRpb24uIEluZGVlZCwgaWYg
dGhpcyBkZXZpY2UgaXMgdmlzaWJsZSwgdGhlbiB3ZSB3aWxsIHRyeSB0byBhbGxvY2F0ZSBNQnVz
DQo+IHdpbmRvd3MgZm9yIGl0cyBkaWZmZXJlbnQgQkFScywgYW5kIHRob3NlIHdpbmRvd3MgYXJl
IGluIGxpbWl0ZWQgbnVtYmVyLg0KPiANCj4gSSBrbm93IHRoaXMgaXNuJ3QgYSB2ZXJ5IGhlbHBm
dWwgYW5zd2VyLCBidXQgdGhlIGRvY3VtZW50YXRpb24gb24gdGhpcyBpcw0KPiBwcmV0dHkgbXVj
aCBub25leGlzdGVudCwgYW5kIEkgZG9uJ3QgcmVtZW1iZXIgZXZlciBoYXZpbmcgdmVyeSBzb2xp
ZCBhbmQNCj4gY29udmluY2luZyBhbnN3ZXJzLg0KPiANCj4gSSd2ZSBhZGRlZCBpbiBDYyBTdGVm
YW4gQ2h1bHNraSwgZnJvbSBNYXJ2ZWxsLCB3aG8gaGFzIHJlY2VudGx5IHBvc3RlZA0KPiBwYXRj
aGVzIG9uIHRoZSBQUHYyIGRyaXZlci4gSSBkb24ndCBrbm93IGlmIGhlIHdpbGwgaGF2ZSBkZXRh
aWxzIGFib3V0IFBDSWUsDQo+IGJ1dCBwZXJoYXBzIGhlIHdpbGwgYmUgYWJsZSB0byBhc2sgaW50
ZXJuYWxseSBhdCBNYXJ2ZWxsLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpJIG5vdCBmYW1pbGlh
ciB3aXRoIEFybWFkYSBYUCBQQ0llLiBCdXQgSSBjYW4gY2hlY2sgaW50ZXJuYWxseSBhdCBNYXJ2
ZWxsLg0KDQpCZXN0IFJlZ2FyZHMsDQpTdGVmYW4uDQoNCg==
