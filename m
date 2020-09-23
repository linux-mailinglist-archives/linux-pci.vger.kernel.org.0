Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0527529D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIWHyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 03:54:22 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23756 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIWHyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 03:54:22 -0400
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 03:54:20 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08N7rXRu000334;
        Wed, 23 Sep 2020 00:54:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=lppACB/EJ5/lB6bqVaYMbo/R1EZ8DIk6lOYf7DKBGas=;
 b=MlS+dQVogF2tmHq8yMGz7mkYmXnZALmbSomyzR4l/oJrcmVxO9NcIRrzJty3NfmPXy+i
 5FM3hde5wwyjXVcYUBn50rCztRf6qeVK5EYMsv2FobAaUBmTH/Xm+Pve+J9vYG8nNCxb
 PX5kFWYnnqeUA9PgaeOXwXH85/rZSdzVii1FmiJ+iZAg2YQTCIjT9YU6Yow3LLesav6j
 Mg1c/KKYA7LAohR5DP+xMukPjbmArce2z6jf8NElsJNd74hVBt3VXaje5IGcZErKdigE
 uGYQaC3vmplYOhOxoXsFmPrg6l22bF9eIeLC9dY4JlcTGPKQc4DpZY4maoAWPxzUVVor pg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33nehxvvjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 00:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMDfAVjsPIhWS60v62j+31eYLOLPniWkZCQ33mDdjca9j8HMxjFw8T6WQE1qQD4dyDIUgvx3F4dONltE11honjUQKbqoNWdczizbxd5h0Qhe3tMs/XZGzJLobUfxWafqNUL82svL4l4fm7GznzApV59a2ZySTuDj4bn0ughAiiEBVNLSbDdOmFN6iMXLLBpOhrtj+t2Q9u9kkg4LeEwAMvurhll5EcTXZOI8/ykIoKazOgm4t+qIyVxTBlwhHLkIMWrEwC/f+SlO24ydms5fC+63RivVtNKaIiCDxoaSzwXtRv1bqylngmAJjPpVO0uKi+KuuYcMIsMiyecRpuLJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lppACB/EJ5/lB6bqVaYMbo/R1EZ8DIk6lOYf7DKBGas=;
 b=RZamNOazDQQo0zJMWVoalDgwM1b2iUC9V5BgqQ1vsNke1d85lRaEOShfdooCnUuPZbIFVmF/uxprv7anA+fablnqWYalrJWUzZ4GnHadP4MQpXKo0TZRI5S+f/8bDwsDJ3rvelKzOFY1WRJI1eaRozOXIxuhiW5TFzW5t0V07jteTgUSIsEgGQIIRh6fB2MWAuSwZLCScwWAZOPK04TeAWtNI2WwSBwE/SV9pEVRf1g/fsMxBlKwybit4785PyXH9ouCWC251UH2F6iDOmo4gpc67pHIPBcNAGkRaWm0TNE8+Uh+pwSo3TfosGg6lDQLWe2dF3jl6P8D8moL4gCJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lppACB/EJ5/lB6bqVaYMbo/R1EZ8DIk6lOYf7DKBGas=;
 b=Y519vYQFHeVOvqawJKuDy6ee+FRcxIE58BNSx9/oFxtWjJeYmyQCkywlRy7yRSzMetC3kqYEsAVFx+iZ7IkwdmEE288PoaWkdK29dvQPsplb3LjxAvjY2eQE/+p3pmL/31wq+yTBeQC0uskU+e3I/bmgqzlZ6LBi7pQiG5q/D8w=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SA0PR07MB7659.namprd07.prod.outlook.com (2603:10b6:806:b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 07:54:11 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8%11]) with mapi id 15.20.3391.024; Wed, 23 Sep 2020
 07:54:11 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Topic: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Index: AQHWjadRF1RM9N6Jak2UZqsZJXWh76l08uIAgADvBIA=
Date:   Wed, 23 Sep 2020 07:54:11 +0000
Message-ID: <SN2PR07MB2557BD3FF1959A113303C741D8380@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200918103429.4769-1-nadeem@cadence.com>
 <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
In-Reply-To: <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjU4NWVkYjMtZmQ3MS0xMWVhLWFlOGMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XGY1ODVlZGI1LWZkNzEtMTFlYS1hZThjLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iNDA4NiIgdD0iMTMyNDUzMjEyNDkwNzIwNzI0IiBoPSJBbU9TZFdpdlg0Z0FuOS9ITFFZNnBadU1iaEU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d38b5e66-f2e5-4551-0349-08d85f95dbe0
x-ms-traffictypediagnostic: SA0PR07MB7659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR07MB76599E101DF5DDD1C226CD4CD8380@SA0PR07MB7659.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZRmZvfMi0WU/RAozmd/M/0LYEed3cA5k9OISu3rL2T13FkvvgGZLu1l2m6l4uYRsXR2numrB+CH5BQ+Y1v75AbuDyxrZ7PTc4oIIPXkskv6ow+1MTAb+CN5O38jPp9i9euVCBrXl0MQBUbvvf3Tll1X6XB+cn4DjCkseXrF+hRU0C+plrdD0Bh4X07iQpbzqjDl8NKtYV3EY1TMris+96fEVkaQxxitYXwv5ghjrCYau2tv/EDT6ycSwGmIQ7Wt5+UIyBMDxOlc/2Z7hHeMItfXzgu9cZbv8Acax3ssrQKwYPbnNKlO3eWBf7ISiBKaTpAK919F/+kH0OPmEQtdLsLb7ojcoIXIi2kATsNGcB//umTJgrhZMtNm/AqLkwaTSi725k1F5ROTNxMfnVIk0hrRVs0cwbyQ2PfdNATTIMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(36092001)(52536014)(8676002)(6506007)(71200400001)(107886003)(4326008)(316002)(9686003)(5660300002)(86362001)(83380400001)(7696005)(54906003)(33656002)(66476007)(66556008)(478600001)(186003)(26005)(53546011)(55016002)(6916009)(66946007)(2906002)(64756008)(8936002)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4pR2r0lRggFDWm7NVBBF7QHuu3z2edLgHKRH28jomBpy4PGplLs/17geKCBCMIEGFT5JXt6JzqXJ7cpFJbwEvpMCoLGabcAs0T4mzohiLa7VYqLzXlvy7zTqoqgKGdIJMu1rHA7tiM8cTn1CcfP2uOiILVqXa8K6IcQZ/+fCW3XxFH65Yr9zZfaPOTjd2FUOxI/xgHNRgfdLbz9wJefnfvEu3A0PVas8WH4Xb1Bvot1roLaqtNCmQxzFspsExtcM9D+i0xMKJyj5g0YfGQgtu61BKlrbLENrllFzUvoxZIivePhvrrP/QS/Gw03qR97sy70f69eVmlb/ITPrthMqnwfW5Offv/kP20PQafEwJNhX0qEwSmdwJaRVqs78K/GNtbc97GatSXm4EuEIjQFoeGs53aHMRyz0q/tRR/s9rQuMHbDiZ5swxEB7eZkfFcO8wB9qMAdXJibEFi1fNjULFeV/OPpQmxVaSfnuzFK5VxNcgLVmyJmxDS74k5p4mJymZcET+cSgQDkFAq/QUfX0PrB76g1iQoP3BttbYtuajLbnq7n2f59m34CwLh/5DAyMWqkM0cSrerPqyBCbOBeHtPDB5uWqCR7WJpVX9YeeWDJU1D9tlfEUQjagAbCBLz35Pba8lkhN3YtKcDbyo4h2Aw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38b5e66-f2e5-4551-0349-08d85f95dbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:54:11.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJ5Sdf1Uxs0y+Wofb65+XANybBxHp57dw11+IfGgJAKTk2eFiQb4lCAeYFSs9/CE7QM3cVRYA0Dp3aMvuPcLhnYbe6xrUpXISBno6XkY9UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_03:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230063
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMiwgMjAy
MCAxMTowOCBQTQ0KPiBUbzogQXRoYW5pIE5hZGVlbSBMYWRraGFuIDxuYWRlZW1AY2FkZW5jZS5j
b20+DQo+IENjOiBUb20gSm9zZXBoIDx0am9zZXBoQGNhZGVuY2UuY29tPjsgTG9yZW56byBQaWVy
YWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBCam9ybiBIZWxnYWFzIDxiaGVs
Z2Fhc0Bnb29nbGUuY29tPjsgUENJDQo+IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWlsaW5kIFBhcmFiDQo+IDxtcGFyYWJAY2FkZW5j
ZS5jb20+OyBTd2FwbmlsIEthc2hpbmF0aCBKYWtoYWRlDQo+IDxzamFraGFkZUBjYWRlbmNlLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOiBDYWRlbmNlOiBBZGQgcXVpcmsgZm9yIEdl
bjIgY29udHJvbGxlciB0byBkbw0KPiBhdXRvbm9tb3VzIHNwZWVkIGNoYW5nZS4NCj4gDQo+IEVY
VEVSTkFMIE1BSUwNCj4gDQo+IA0KPiBPbiBGcmksIFNlcCAxOCwgMjAyMCBhdCA0OjM0IEFNIE5h
ZGVlbSBBdGhhbmkgPG5hZGVlbUBjYWRlbmNlLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBDYWRl
bmNlIGNvbnRyb2xsZXIgd2lsbCBub3QgaW5pdGlhdGUgYXV0b25vbW91cyBzcGVlZCBjaGFuZ2Ug
aWYNCj4gPiBzdHJhcHBlZCBhcyBHZW4yLiBUaGUgUmV0cmFpbiBiaXQgaXMgc2V0IGFzIGEgcXVp
cmsgdG8gdHJpZ2dlciB0aGlzDQo+ID4gc3BlZWQgY2hhbmdlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTmFkZWVtIEF0aGFuaSA8bmFkZWVtQGNhZGVuY2UuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWhvc3QuYyB8ICAgMTMg
KysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1j
YWRlbmNlLmggICAgICB8ICAgIDYgKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiA+IGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1ob3N0LmMNCj4gPiBpbmRleCA0
NTUwZTBkLi40Y2I3ZjI5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
Y2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1ob3N0LmMNCj4gPiBAQCAtODMsNiArODMsOCBAQCBz
dGF0aWMgaW50IGNkbnNfcGNpZV9ob3N0X2luaXRfcm9vdF9wb3J0KHN0cnVjdA0KPiBjZG5zX3Bj
aWVfcmMgKnJjKQ0KPiA+ICAgICAgICAgc3RydWN0IGNkbnNfcGNpZSAqcGNpZSA9ICZyYy0+cGNp
ZTsNCj4gPiAgICAgICAgIHUzMiB2YWx1ZSwgY3RybDsNCj4gPiAgICAgICAgIHUzMiBpZDsNCj4g
PiArICAgICAgIHUzMiBsaW5rX2NhcCA9IENETlNfUENJRV9MSU5LX0NBUF9PRkZTRVQ7DQo+ID4g
KyAgICAgICB1OCBzbHMsIGxua19jdGw7DQo+ID4NCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAg
ICAgKiBTZXQgdGhlIHJvb3QgY29tcGxleCBCQVIgY29uZmlndXJhdGlvbiByZWdpc3RlcjoNCj4g
PiBAQCAtMTExLDYgKzExMywxNyBAQCBzdGF0aWMgaW50IGNkbnNfcGNpZV9ob3N0X2luaXRfcm9v
dF9wb3J0KHN0cnVjdA0KPiBjZG5zX3BjaWVfcmMgKnJjKQ0KPiA+ICAgICAgICAgaWYgKHJjLT5k
ZXZpY2VfaWQgIT0gMHhmZmZmKQ0KPiA+ICAgICAgICAgICAgICAgICBjZG5zX3BjaWVfcnBfd3Jp
dGV3KHBjaWUsIFBDSV9ERVZJQ0VfSUQsDQo+ID4gcmMtPmRldmljZV9pZCk7DQo+ID4NCj4gPiAr
ICAgICAgIC8qIFF1aXJrIHRvIGVuYWJsZSBhdXRvbm9tb3VzIHNwZWVkIGNoYW5nZSBmb3IgR0VO
MiBjb250cm9sbGVyICovDQo+ID4gKyAgICAgICAvKiBSZWFkaW5nIFN1cHBvcnRlZCBMaW5rIFNw
ZWVkIHZhbHVlICovDQo+ID4gKyAgICAgICBzbHMgPSBQQ0lfRVhQX0xOS0NBUF9TTFMgJg0KPiA+
ICsgICAgICAgICAgICAgICBjZG5zX3BjaWVfcnBfcmVhZGIocGNpZSwgbGlua19jYXAgKyBQQ0lf
RVhQX0xOS0NBUCk7DQo+ID4gKyAgICAgICBpZiAoc2xzID09IFBDSV9FWFBfTE5LQ0FQX1NMU181
XzBHQikgew0KPiA+ICsgICAgICAgICAgICAgICAvKiBTaW5jZSB0aGlzIGEgR2VuMiBjb250cm9s
bGVyLCBzZXQgUmV0cmFpbiBMaW5rKFJMKSBiaXQgKi8NCj4gPiArICAgICAgICAgICAgICAgbG5r
X2N0bCA9IGNkbnNfcGNpZV9ycF9yZWFkYihwY2llLCBsaW5rX2NhcCArIFBDSV9FWFBfTE5LQ1RM
KTsNCj4gPiArICAgICAgICAgICAgICAgbG5rX2N0bCB8PSBQQ0lfRVhQX0xOS0NUTF9STDsNCj4g
PiArICAgICAgICAgICAgICAgY2Ruc19wY2llX3JwX3dyaXRlYihwY2llLCBsaW5rX2NhcCArIFBD
SV9FWFBfTE5LQ1RMLA0KPiA+ICsgbG5rX2N0bCk7DQo+IA0KPiBXaHkgdGhlIGJ5dGUgYWNjZXNz
ZXM/IFRoaXMgaXMgYSAxNi1iaXQgcmVnaXN0ZXIuDQpUaGlzIGlzIGEgMzJiaXQgcmVnaXN0ZXIu
IEJ1dCB0aGUgcmVnaXN0ZXIgZmllbGQgcmVxdWlyZSBpcyBhdCBmaXJzdCBieXRlIG9ubHkuIEhl
bmNlIHRoZSBieXRlIGFjY2Vzcy4NCj4gDQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAg
ICAgY2Ruc19wY2llX3JwX3dyaXRlYihwY2llLCBQQ0lfQ0xBU1NfUkVWSVNJT04sIDApOw0KPiA+
ICAgICAgICAgY2Ruc19wY2llX3JwX3dyaXRlYihwY2llLCBQQ0lfQ0xBU1NfUFJPRywgMCk7DQo+
ID4gICAgICAgICBjZG5zX3BjaWVfcnBfd3JpdGV3KHBjaWUsIFBDSV9DTEFTU19ERVZJQ0UsDQo+
ID4gUENJX0NMQVNTX0JSSURHRV9QQ0kpOyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KPiA+IGluZGV4IGZlZWQxZTMuLjA3NWMyNjMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2Fk
ZW5jZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2Fk
ZW5jZS5oDQo+ID4gQEAgLTEyMCw2ICsxMjAsNyBAQA0KPiA+ICAgKi8NCj4gPiAgI2RlZmluZSBD
RE5TX1BDSUVfUlBfQkFTRSAgICAgIDB4MDAyMDAwMDANCj4gPg0KPiA+ICsjZGVmaW5lIENETlNf
UENJRV9MSU5LX0NBUF9PRkZTRVQgMHhDMA0KPiA+DQo+ID4gIC8qDQo+ID4gICAqIEFkZHJlc3Mg
VHJhbnNsYXRpb24gUmVnaXN0ZXJzDQo+ID4gQEAgLTQxMyw2ICs0MTQsMTEgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGNkbnNfcGNpZV9ycF93cml0ZXcoc3RydWN0DQo+IGNkbnNfcGNpZSAqcGNpZSwN
Cj4gPiAgICAgICAgIGNkbnNfcGNpZV93cml0ZV9zeihhZGRyLCAweDIsIHZhbHVlKTsgIH0NCj4g
Pg0KPiA+ICtzdGF0aWMgaW5saW5lIHU4IGNkbnNfcGNpZV9ycF9yZWFkYihzdHJ1Y3QgY2Ruc19w
Y2llICpwY2llLCB1MzIgcmVnKQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1cm4gcmVhZGIocGNp
ZS0+cmVnX2Jhc2UgKyBDRE5TX1BDSUVfUlBfQkFTRSArIHJlZyk7IH0NCj4gPiArDQo+ID4gIC8q
IEVuZHBvaW50IEZ1bmN0aW9uIHJlZ2lzdGVyIGFjY2VzcyAqLyAgc3RhdGljIGlubGluZSB2b2lk
DQo+ID4gY2Ruc19wY2llX2VwX2ZuX3dyaXRlYihzdHJ1Y3QgY2Ruc19wY2llICpwY2llLCB1OCBm
biwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgcmVn
LCB1OCB2YWx1ZSkNCj4gPiAtLQ0KPiA+IDEuNy4xDQo+ID4NCg==
