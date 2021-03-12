Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC73399D8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 23:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhCLW5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 17:57:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhCLW50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 17:57:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CMu7vE097197;
        Fri, 12 Mar 2021 22:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4AzuNZylAIQujtqSyKgTWYPii7dJUYbvZhFuFXCKVfU=;
 b=fSG/98AMHzhF2Oyo0VxdnfcYP3yP6uxfbJF2SF9Kov2k9NzRgP4mvUzHcY7xWNQgtgUU
 ngGxwx8jqD8BOKq8NCJRtUn3YSyoitF6dxwE68MhnGIp6jEZ4yHBlKh9uW/mQe81mYmA
 pqVv1iKijJTrIJVV0bhKKIGaC/f49So1PJgHm+kqVQGiI+ru8PpUGEORmaVTUhaITROv
 yGg4DesNIWodJS7mkyIA6T1T0t/6GIQyU0gDDsHrR0rHwTIMj1CGLOoVRHrlt15SunBD
 2VuzXRnhLrbuT3c1Gg0YKqgEDd0D1hY9ZgG0hcwR6NQ4aHtyLLauZji2+0AFqJTBog6Y Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37415rkg7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 22:57:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CMpDkl130704;
        Fri, 12 Mar 2021 22:57:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3020.oracle.com with ESMTP id 378c9st8w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 22:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btoI08xJE0OulgljpcC7H4pJ30c1fKG0cvnXaxVxbe8hEZchNEthUFtZZHVm50JVhA8tY71Q4S3jDkIay+WbgJHFeBu89yE0q0dmdDUXdapoFuatgORF7H1tCZEH/Xqodc3WqX7sEJRpYiw2Xpi6q4nhR7QqOUrzW6Dyq9nQOZavgp/0VdBQjyO76RQEIIiYKmGafInIk/5XAqvYJAGRCgpu0+Ojqv+fWXBIH9RffnDko1WIzGIBz2PPvbaEG3ZxADome1dIyPt2jEZ9jH5M1mUDUjVIbfNWjDXHFOYt/+jHvbh27IaDKv2iQtSXNPQAigZhooByDFhwPxyZhtl2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AzuNZylAIQujtqSyKgTWYPii7dJUYbvZhFuFXCKVfU=;
 b=Sas+GB1X98l5hjoq1Nosor1Jo8BTPxm/kRdgeGAMrzcm/+LkQkF8BzRzU/PJA4f1OStPm+HDGGiL6QNiLve3gEn+Gt1K5d3eUoB1f23LaIpYiCXx1VsathmeHYtgRZlB0OtT5/kE38zt8JDHuF/dmS68HIBNIL6v+RrHo0TH3Y3GVMTnQ7eRcYw13ohrR1pWp0BH2DrS4fV79/A/pw2JVN2dV31fnR4Vc+XZYl2sE4aceTrSpQglMve7cGkLFdLnmenYWcE8Kc4x1kSEkBy++rqKeEr4LRPPQoFupoLlfRmtcFELDljbk5xtUn5uIksAa55aaY8gTnkXhfCr52HjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AzuNZylAIQujtqSyKgTWYPii7dJUYbvZhFuFXCKVfU=;
 b=iptWro41GTazRbtHamMZWtrU9WKuFF0h6JpehIfO94hLzKw63a2cJ5oS1Ef7Tj7kUlWm3RMD6wcTgzK6JzEOU5TsOFB6iBjxd/gJLx61l5ea+t59H3NXddCu7RI5rUuUhrFdJOkl9dI+dVpgi4YZu+EMx/2wJk2SZR6l335U4fo=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by MN2PR10MB3967.namprd10.prod.outlook.com (2603:10b6:208:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 22:57:19 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::1df4:a9f8:9cdb:42b]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::1df4:a9f8:9cdb:42b%4]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 22:57:19 +0000
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: pci_do_recovery not handling fata errors
Thread-Topic: pci_do_recovery not handling fata errors
Thread-Index: AdcXgU62xtCQUzV6Rma22nuKU6yu/wADUkSAAAD3IeA=
Date:   Fri, 12 Mar 2021 22:57:18 +0000
Message-ID: <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
In-Reply-To: <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [173.76.5.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0775d507-36ac-4f7e-87b3-08d8e5aa307f
x-ms-traffictypediagnostic: MN2PR10MB3967:
x-microsoft-antispam-prvs: <MN2PR10MB39671061E78D010B154CE56B996F9@MN2PR10MB3967.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loyxkdhwveRVUtGcFtDNCyH+bx2QHEWMw+W4+BVSBCLDj707KJC+d6HSHT8nzOr2oy8CtPdeK7U0eOv0HG7GkcxCZ9OgdTcYLQjMXz71Nypa2f7EUFkOObX+2JKXPb5AGOlNHcjQCAS0RCas/jpBBVVPnt5+j1hTNQf6z1Xsp5Iz/AGVW23YKU1ifMuM4k4887IVjsXD3xPdt8VjbnGlDwVHzHf0WGRzBET10wY9Hp6OPMGv2yFEiTL0TcmoAZmG2hR/pp7eq0DQvh7QqQCxBS5NMIb2H+3OMOgrYh++aL3M96xvrW99Q1YWZxETDEr1ohc4svuRjIazGagC/2aECDVCk0oFTew2GA+Q79F3SV8Pr9+buhsQGrEcmEL5PM2VUrhCShWE2YyJZkreCqThpIw+G2DrU/2uLSL9rMfRPMKZxpkcneT0nGqTzcdmVJARKf4Tgq90VNt75DUAkG7n7B7lkTjJi8GOz4Nqh5/Nw6cPExg9rHB+JsFqIlsO0zxLxn+WGsywUu+AE6v4AsVA2aVwat+FqM07IRBJXhAoG4dySzNU/UttlN+N7AJgI9+T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(66446008)(64756008)(26005)(186003)(66476007)(76116006)(66556008)(66946007)(86362001)(2906002)(44832011)(478600001)(9686003)(33656002)(8676002)(4326008)(55016002)(52536014)(6506007)(316002)(54906003)(53546011)(83380400001)(5660300002)(110136005)(71200400001)(7696005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bm1HU0ZLazBSa0NvOVhPZEd0ZnBSSGJ0dzdVL1B4emJ0Z3dNdURjUG5oL05w?=
 =?utf-8?B?Rk1DTWR1eVVncXgweENnUTIrVll5alM4cTFJWGtVZnhSV1A4dVR2RlA3SXdW?=
 =?utf-8?B?NlNYZ0pGMFlPeWxrSWowS0t6TXMrbXRyRzFKZ1daRDh2WmRSbDhqWXdHdm83?=
 =?utf-8?B?NlhOdzNzMTFyck03YjBPNFFlTklDdTdoQVRaUGc0WWdwdnpnbkFzOFcrY1dI?=
 =?utf-8?B?WnBIcnltOE5JMHZHQXg4T0pYaW1GS3lkcGZRTHlLUno4K1d0Q0VJczQzSU9i?=
 =?utf-8?B?NzFRazJ1VkR5Z3M3VGNHcXF3eGRJZlduaDg4ZzA3RDBVdGphUFE4MCtpOGdP?=
 =?utf-8?B?L1RUajFqczBncS9ieXc2SEZZbTE2L3ZYMWlPMzVmSVBsNjZDd1VDSnRFSVN1?=
 =?utf-8?B?U1N2MnZSSlozUm4rTFNOaUpaMHZISVVySmtIczVweElnL0ZPenpqY21Tams4?=
 =?utf-8?B?NkNlWWdLMWs1ZTVtMjNINnJOWTVONUdRaHQyMzR6N0hEVy8waE9YTHozNE56?=
 =?utf-8?B?Q2tjSjhtSmUwb0pmTDBxd3Z5Q1RQQTQ4ZkdZM2VsWWNxeDhGQWFVaUFSZ1g5?=
 =?utf-8?B?SnluMXRYT05QbUxvYmVPOGx1c3orNWc2T0RRVUZ4dVlBM3hqR0FoZ3ZpeEJU?=
 =?utf-8?B?czFCT2JNTllIVUkrd01kOVpITHp1RmlhdlBKdktUQjFtWmt5dndWanFNNXds?=
 =?utf-8?B?eGdaeCt1TG1nK2hWMkY5eUQ3OThpRXppeWFPSjFLSU1zMmJPY3lLNWRuWURh?=
 =?utf-8?B?ZUlZNUl0eW9LeUxURjlCQW1pNGdOalA2aGNWZlRPRkpxRWhKVlVTNUQySVlC?=
 =?utf-8?B?amhIU1hIQThvY2lEMnlzK1hwQkJnTXl1M1NwUDJmM0JQc0Uxek82cnNvN1V6?=
 =?utf-8?B?bVNvTDBRY25LRGs5YTBwcnBMWm9aMlcxQ0wzTkZoUUZreUhqTDhiR0hxUG5V?=
 =?utf-8?B?dnZpYUFDejZ3b3RBbU0xYktKVWpDaXVxZHFDZHNUQmNsVU1mRlA5ekJiU3lV?=
 =?utf-8?B?VlhYd3FBdXNQU3YwZ0h5bjZPRm1VKzM0NkZrekVsNDNpenpmcGIydkZzZ1dC?=
 =?utf-8?B?T2JNK1M4VFBmQTdvMGRZUUNkWTVWcnlJdUMxR3hDSkVSKzYvU2xrZkltRFBF?=
 =?utf-8?B?ckVFdWtyRFFEVDdnL2pzVUlxTmpVNEJsMUF0UHJ0cUxmVWhnbjk0d0NiYW1w?=
 =?utf-8?B?aUFQUTg2em00QzIwNzF1WDJGRTdiY2dQY0pCaXlvRjdEV0tpeVZKbnNHL2h6?=
 =?utf-8?B?RitMT3NWY0p0M0NTMFE0WEhzZVFMNENCSExWbW5Kc3dmcmF3cGNMUkxzQXBR?=
 =?utf-8?B?V3BZTStpQURFUm1uN1V0dFlYN08va1pZSWhpSGJRMTIwYXVOQ0ZxMEUzSlJZ?=
 =?utf-8?B?ZVAzd0pCckdSakY1bWJKSHZTeHNSSzc5RnU2eERNaTN1MjVUcXl0MVA0Tm9M?=
 =?utf-8?B?TUVCTTI3M1U0bytvcXZvaGpBb2RSUGxabEpyeVhEUncrZG56V21CTHhtcE82?=
 =?utf-8?B?and4TytQN2MxQ3RoV3dITHc4TnVveDZmd2RWS1lYM3l6V085cENsMmpmakQ4?=
 =?utf-8?B?YWdkQzJzTlpvWnRINlA3WlViaWpJendSVEUzOWJ2c0RZUER4bXNhTFNSZjM1?=
 =?utf-8?B?YXJHeG9nTjZEM3lOWkRac2J6RlJwUXdWQnFIbVBucEdNWnJaU0hRdDYxdlpo?=
 =?utf-8?B?UW1PbEczOVZkbTBCUlFaUW5pa0ZuQWt1aHRGYWVSeFJKTHU4cHZhbVc0TEpr?=
 =?utf-8?Q?thVVPHcjlkTD2KjGnQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0775d507-36ac-4f7e-87b3-08d8e5aa307f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 22:57:19.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovQT5J1ZUjBhwvkhqFqw3xRnKg8aZN41H224a8opsmJpjyx+OLX4Of5JR72YzEn6YgHG52plmVjZ7LhddrLxhqTiFDIE2dUqDfjqd1KYUzy9mPKmizwA6Zq/7qvDy2v2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3967
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120166
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QnV0IHRoZSBjbGVhcmluZyBvZiBmYXRhbCBlcnJvciBpbiB0aGUgZHBjX3Byb2Nlc3NfZXJyb3Ig
aXMgb25seSBmb3IgRFBDIHRyaWdnZXIgZHVlIHRvICJ1bm1hc2thYmxlIHVuY29ycmVjdGFibGUi
LiANCklmIHRoZSB0cmlnZ2VyIHJlYXNvbiBpcyBFUlJfRkFUQUwsIHRoZW4gaXQgZG9lcyBub3Qg
aGl0IHRoZSBlbHNlIGNsYXVzZSBhbmQgbmVpdGhlciBpcyBpdCBjbGVhcmVkIGluIHRoZSBwY2lf
ZG9fcmVjb3ZlcnkgY29kZS4NCg0KRnJvbSBkcGNfcHJvY2Vzc19lcnJvciB3aXRoIG1vcmUgY29u
dGV4dCAtLSANCg0KICAgICAgIGVsc2UgaWYgKHJlYXNvbiA9PSAwICYmICA8PDw8PDw8IG9ubHkg
Zm9yICJ1bm1hc2thYmxlIHVuY29ycmVjdGFibGUiLiBXaGF0IGFib3V0IGZvciBFUlJfRkFUQUw/
DQogICAgICAgICAgICAgICAgIGRwY19nZXRfYWVyX3VuY29ycmVjdF9zZXZlcml0eShwZGV2LCAm
aW5mbykgJiYNCiAgICAgICAgICAgICAgICAgYWVyX2dldF9kZXZpY2VfZXJyb3JfaW5mbyhwZGV2
LCAmaW5mbykpIHsNCiAgICAgICAgICAgICAgICBhZXJfcHJpbnRfZXJyb3IocGRldiwgJmluZm8p
Ow0KICAgICAgICAgICAgICAgIHBjaV9hZXJfY2xlYXJfbm9uZmF0YWxfc3RhdHVzKHBkZXYpOw0K
ICAgICAgICAgICAgICAgIHBjaV9hZXJfY2xlYXJfZmF0YWxfc3RhdHVzKHBkZXYpOw0KICAgICAg
ICB9DQogDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGV5LCBT
ZWFuIFYgPHNlYW4udi5rZWxsZXlAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEy
LCAyMDIxIDU6MjUgUE0NCj4gVG86IEphbWVzIFB1dGh1a2F0dHVrYXJhbiA8amFtZXMucHV0aHVr
YXR0dWthcmFuQG9yYWNsZS5jb20+Ow0KPiBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4NCj4g
PHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGludGVsLmNvbT4NCj4gQ2M6IExpbnV4IFBDSSA8
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz47IGJoZWxnYWFzQGdvb2dsZS5jb20NCj4gU3ViamVj
dDogW0V4dGVybmFsXSA6IFJlOiBwY2lfZG9fcmVjb3Zlcnkgbm90IGhhbmRsaW5nIGZhdGEgZXJy
b3JzDQo+IA0KPiANCj4gDQo+ID4gT24gTWFyIDEyLCAyMDIxLCBhdCAxMjo1NiBQTSwgSmFtZXMg
UHV0aHVrYXR0dWthcmFuDQo+IDxqYW1lcy5wdXRodWthdHR1a2FyYW5Ab3JhY2xlLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSAtDQo+ID4gSeKAmW0gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2h5IHBj
aV9kb19yZWNvdmVyeSgpIG9ubHkgY2xlYXJzIG5vbi1mYXRhbCBidXQNCj4gbm90IGZhdGEgZXJy
b3JzPyBNeSBpbW1lZGlhdGUgY29uY2VybiBpcyBjYWxsIGZyb20gZHBjX2hhbmRsZXIuIElmIGEg
ZGV2aWNlDQo+IHNlbmRzIGFuIEVSUl9GQVRBTCB0byB0aGUgcm9vdCBwb3J0LCBJIHdvdWxkIHRo
aW5rIHRoYXQgYXMgcGFydCBvZiByZWNvdmVyeQ0KPiB0aGUgZmF0YWwgc3RhdHVzIGluIHRoZSBB
RVIgcmVnaXN0ZXJzIG9mIHRoZSBlbmRwb2ludCBkZXZpY2Ugd291bGQgYmUgY2xlYXJlZD8NCj4g
Pg0KPiANCj4gDQo+IEFkZGluZyBTYXRoeWEgd2hvIG1lbnRpb25lZCB0byBtZSB0aGF0Og0KPiAN
Cj4gRmF0YWwgZXJyb3IgYXJlIGNsZWFyZWQgaW4NCj4gDQo+IHZvaWQgZHBjX3Byb2Nlc3NfZXJy
b3Ioc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+IA0KPiAyNTMgICAgICAgICAgICAgICAgICBkcGNf
Z2V0X2Flcl91bmNvcnJlY3Rfc2V2ZXJpdHkocGRldiwgJmluZm8pICYmDQo+IDI1NCAgICAgICAg
ICAgICAgICAgIGFlcl9nZXRfZGV2aWNlX2Vycm9yX2luZm8ocGRldiwgJmluZm8pKSB7DQo+IDI1
NSAgICAgICAgICAgICAgICAgYWVyX3ByaW50X2Vycm9yKHBkZXYsICZpbmZvKTsNCj4gMjU2ICAg
ICAgICAgICAgICAgICBwY2lfYWVyX2NsZWFyX25vbmZhdGFsX3N0YXR1cyhwZGV2KTsNCj4gMjU3
ICAgICAgICAgICAgICAgICBwY2lfYWVyX2NsZWFyX2ZhdGFsX3N0YXR1cyhwZGV2KTsNCj4gDQo+
IFRoYW5rcywNCj4gDQo+IFNlYW4NCj4gDQo+ID4gU25pcHBldCBvZiBjb25jZXJuIGluIHBjaV9k
b19yZWNvdmVyeSDigJMNCj4gPg0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIElmIHdl
IGhhdmUgbmF0aXZlIGNvbnRyb2wgb2YgQUVSLCBjbGVhciBlcnJvciBzdGF0dXMgaW4gdGhlIFJv
b3QNCj4gPiAgICAgICAgICAqIFBvcnQgb3IgRG93bnN0cmVhbSBQb3J0IHRoYXQgc2lnbmFsZWQg
dGhlIGVycm9yLiAgSWYgdGhlDQo+ID4gICAgICAgICAgKiBwbGF0Zm9ybSByZXRhaW5lZCBjb250
cm9sIG9mIEFFUiwgaXQgaXMgcmVzcG9uc2libGUgZm9yIGNsZWFyaW5nDQo+ID4gICAgICAgICAg
KiB0aGlzIHN0YXR1cy4gIEluIHRoYXQgY2FzZSwgdGhlIHNpZ25hbGluZyBkZXZpY2UgbWF5IG5v
dCBldmVuIGJlDQo+ID4gICAgICAgICAgKiB2aXNpYmxlIHRvIHRoZSBPUy4NCj4gPiAgICAgICAg
ICAqLw0KPiA+ICAgICAgICAgaWYgKGhvc3QtPm5hdGl2ZV9hZXIgfHwgcGNpZV9wb3J0c19uYXRp
dmUpIHsNCj4gPiAgICAgICAgICAgICAgICAgcGNpZV9jbGVhcl9kZXZpY2Vfc3RhdHVzKGJyaWRn
ZSk7DQo+ID4gICAgICAgICAgICAgICAgIHBjaV9hZXJfY2xlYXJfbm9uZmF0YWxfc3RhdHVzKGJy
aWRnZSk7ICAgPDw8PCBKdXN0IGNsZWFyaW5nDQo+IG5vbmZhdGFsLiBXaGF0IGFib3V0IGZhdGFs
Pw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gSmFtZXMNCg0K
