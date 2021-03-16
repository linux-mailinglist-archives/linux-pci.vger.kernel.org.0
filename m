Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1998B33E01A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 22:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhCPVOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 17:14:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhCPVOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 17:14:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GLDajP062771;
        Tue, 16 Mar 2021 21:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FHicQzYGOOP5ZnQgNJZmf1BrfOwCUfHNSpkVBsBxGFE=;
 b=ya39GhXgCZMOR94xcWb8AYl3dSa49IxYo9KvkAvzC0uUDW7CQD/cLyxqkklBX+Rf2sJY
 q9SOadVXf2yCjOLtR49FlD+laAlz0/mtQHd/+mgFYiKWGGU4k+xM5JkmPKv3RZuGDEqL
 0VrsCRDcwmNEQUntjc50Ci9nbac6DxnuyrF//+PpxA6FLzipYdWsKK0ekdYg9QkF1MKF
 XIjYta6lYOi6haHJWWWDvdgQq2g04B+df+iwnFoDbVJFAk0TWE+HZx8ko10TKdyU9i1h
 tMzkAYOXZPE6F18e36wMAR9DzY9Gg3wSsq+YS92OtogaDBPByKL2TSAI+6yKHK6w7rSv Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 378p1nt09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 21:13:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GL9kqr040920;
        Tue, 16 Mar 2021 21:13:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3020.oracle.com with ESMTP id 3797a1r98t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 21:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB2mjiPX0posCcEdZaUbTRPdL6ySUrJOXO20/rMniB6PiWjueA5ra6YaPZFUbQAtEe8JBV2z8grG1MR7XbXyCW6iFkE1C9YivBTn8GZRumBrl75wVMSjYRAnJ5LkqH9XEVHSfI/xq/YrPfJr20XHwVzFDcv4Iate0ls9TbdpLUmdX5SO7UEH2bjiMe4J0YyIZRS+H8WCivSrO94gz30RKUZ2PM343IXMqljDPi2pjnPGmWHS4nkxZD1FxT4gAHuxiuGLETIVLZp0FhvjCMtGzd3cLq99wgnYaMAoCqv2x5OSOr2VrRYv0R3FBOML+CT+y7QAdLZurm8B03Yo+YED4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHicQzYGOOP5ZnQgNJZmf1BrfOwCUfHNSpkVBsBxGFE=;
 b=LUXP6dsTOYLKbX/uWxvdGudlTixQAkKMW27QPmlqYhzff6z+8KjrTZ+nTBuEOg+tFPGvA+c5XIIJ9NHqct7/uJx6sU99yVo2hIj5z5pWr+bpa8waGlS2klLaXEPwccz/13YzZuuJIYqHDJ2Kr/YIJvcxluSDu8zXm+6u/8GtDAmHMxeoN+2Itbs2fB/MJhG7fLtxUvYXVJoeKGW09/2uif5SWx8o0XWcA1KsMFZBvzpDIVr56V7vs0/67OzY5zjf58dC2E46276QoVnJjPqUc0QKIo29RNFqekbebbsS5S/5wdFfEfl6YjQzeLV06+KEsnqNyuVeIOcmLBuwrkYY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHicQzYGOOP5ZnQgNJZmf1BrfOwCUfHNSpkVBsBxGFE=;
 b=VA1P57K9hjvl6j0H2Ubok+DGC1aUZEI1iPoQOEr++7szEqbuLoGGPv1Ffw+N82KDp0QGZAVmZ6jlY9kPzUdNnYDyaueuTml8Pw2kL0iSqBxKNtc4p6YtDQhX1z8Xhi6u9icXHbykFWaeOHr2ld9F5w3k2jKtXBg9EePNa0MYG6s=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by MN2PR10MB3840.namprd10.prod.outlook.com (2603:10b6:208:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 21:13:57 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::1df4:a9f8:9cdb:42b]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::1df4:a9f8:9cdb:42b%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 21:13:56 +0000
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [External] : Re: pci_do_recovery not handling fata errors
Thread-Topic: [External] : Re: pci_do_recovery not handling fata errors
Thread-Index: AdcXgU62xtCQUzV6Rma22nuKU6yu/wADUkSAAAD3IeAAJl3igACfKSHw
Date:   Tue, 16 Mar 2021 21:13:56 +0000
Message-ID: <MN2PR10MB4093780C86ABFCAB54B1427C996B9@MN2PR10MB4093.namprd10.prod.outlook.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
 <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <20210313171135.GA8648@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210313171135.GA8648@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [173.76.5.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1baa9074-5891-43e9-68ac-08d8e8c06938
x-ms-traffictypediagnostic: MN2PR10MB3840:
x-microsoft-antispam-prvs: <MN2PR10MB384066968F4DE692C0D96DBA996B9@MN2PR10MB3840.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xODlbkoCND2Ta4vbXWgs/Junr99+CHs0CySrogdx+GD9gltJF940HNiyAvhgOrjinKA1g1t7kk3h2fxY7C8TRR4VQrIaby7f3w8uimCnrPifG+uiwy1M6wow6cHdqqkxuyUtogDwf2cQZC+ZCM3X8OE6LWaahINUu26iRORz7iY1cypI4lX7V3wn4BiIGkxLYNO8YvE4NunDobWlVwcAR5GjPvKstILOFS8Oce1FQDxRB90qwKDZfPOpOr1KIfABMM5JIrkMQ/QiPIr8745v2c3i4JGwrbThwN8Ji4ncCLlOwLWjOjJ2/hR1LrgFWl3/b0RwhTeR2cV+hNGhdrhr/hcuw7hZzOkjXr2Q3gomGoftP2kDwlBULsIhrnTdPugkB/FWWBhSdFELydokTnBaDLATc+YFnyFPsZ9GkwrlcS4xzCsrPjo76baKhPZrjZ47GarBGwbU79vlzFfZ7v6sS/Few1c460Sc38YhgHEaf4GoUfyuOZu/L1nzgpIIX8Bg1O3rHM3iVP6dUlncdV1BVzf5n45QBVUYFJBMoa9vsmCVpqJ+cZcGQlyJz710YzGS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39860400002)(346002)(71200400001)(478600001)(26005)(83380400001)(4326008)(54906003)(5660300002)(66946007)(86362001)(53546011)(52536014)(186003)(33656002)(55016002)(8676002)(9686003)(6916009)(316002)(44832011)(66556008)(66446008)(8936002)(6506007)(66476007)(64756008)(76116006)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z1NGK1JnWkJhMkZIMnVUOWhOU1A3dG4rRHRlZXkySFJnYjVwMWZBT0VNRUYr?=
 =?utf-8?B?UW9nK2lYQzNtejlia3RhKy9BK1B5cGRWU3djejd0Q1FZaDdTc3hNdVZJRkNs?=
 =?utf-8?B?cTkxMWg1U2ZUNDNSWkFid1FOckNTUE9GQnN0Q1VRcXNkbW80RWxoNmF0eWdZ?=
 =?utf-8?B?WnozamJuZVhuOXVMSzlxY2FzcU15WEZrcEFoRFFWR2o5QkQwT2w1MzN5Z3hD?=
 =?utf-8?B?QkoxYXREZXV5RkJJS3VkREtHSThXbXNZWEVYNEs4VGptN0NuQUR1aWlscDVY?=
 =?utf-8?B?a1RqbURHRjI3L21Md1F6OE9FdG90aWptMnJHQ1dJVnEyVDFDS3pXVitjb0pP?=
 =?utf-8?B?dmIxcDBpYnByaGo1RUg0a0JDdE13OGZTK2J6d2RDYUFuWG1MdEpNVlZuUkoz?=
 =?utf-8?B?bUtBbzd4Nkt2TEJZMnVtbGpmVTN2VDArQ3dJcDg5UnZxR1RwTmZwY29JSWFo?=
 =?utf-8?B?RUZVcVhaTzZQei9COTY1TUZzaGh4eG9WbVo2cG96a2RscDlYT0U5ZjJaZThC?=
 =?utf-8?B?M2U0TWpTVldWSXZLdUxBaVNXZFVFME1rUnlCazk1MThNb2NaS0NqRno2dDYw?=
 =?utf-8?B?ZnB6RkRuM3FISE1FcjNuMGZHUUwrbVo0Y3hDVVZoSmhFSkp3eEVFNmllVVN3?=
 =?utf-8?B?RzJsS0JRdGcveFVKZGFKb2RiZlF4UWdxcGVXTFBJbWRia2t2a0NRZFBiQWpZ?=
 =?utf-8?B?Kzh3bGhFa3V5MFBtaTNRb041cmZYa0UzaUx6OGNsTjNEcTZMZXA4a2puY2tz?=
 =?utf-8?B?NnNtZE1hQzhxcUxTVlFuUEwrRHdKOUp0QmMycGdwUGVSSndqblk5SDMrUFhB?=
 =?utf-8?B?MlBtRmhPR2ZnYW5ZV3VLNS9pOWkrQW5BdFpXaTJncDRZSmJhZXhLUFRZSXdR?=
 =?utf-8?B?eEZWc215RlNXeDI5a2tTT3h4UmYzZ1BHbnFHNHFZVUdlM2I2eVg3UXVqekxY?=
 =?utf-8?B?ZGg5NlZVRmV6Z3IvQzhYY0FpZElnWkt4ZUpoSFo4VXVUM0taNkhhbHRwa1pJ?=
 =?utf-8?B?WDY2U1ZieUlKRTVxWG9MRXF3YWxFQXhRUnV2TWdGWCtZT0JkTnVrVDVrRHQ2?=
 =?utf-8?B?QVFlQWlkTVorQ3czSjNUME01Ulp3dmtkb1BrT2NJRndCVHM2aDhPeU5WWGlx?=
 =?utf-8?B?TVBNR3h4Qk4yTDdUbTFESjFRdElRVS8xeVA1RFJZSUp2T2pGU1V5TktIMkFO?=
 =?utf-8?B?ZG1VMzJDZlBhdDMrRkpidDczaXpaMUtnZDZtYkIvWExVNk9iUWVaWnA4VFdG?=
 =?utf-8?B?RnFyMXhJMnVEYUJqbnJkVzlNbVNudC9mc2RzREtQQjVPOFNSeE1qSWlwOVh4?=
 =?utf-8?B?TFdwM09mZUM4YUJtNWNxU25xQlVtRzBrSWM3MWVsS2lhVUZDMHNyUlZacTRR?=
 =?utf-8?B?UktJWEdwV2tpNkdieHVrallVSVJYRUw4Kzd1U3lkWGdpc3lBeUQ0R3VaWFFk?=
 =?utf-8?B?RnFRQkFMZG1PWlMzN2p3eVRJcVJsc0xOdVB4R0ZEM3JBQ3BnalQ3SFN5OE5J?=
 =?utf-8?B?M083bDFFV3ZaK0FPVWduVlUzMkU1QTRkRmFlUEhGYzZqRUE0TkljUElkZ0dY?=
 =?utf-8?B?aXJhcVdjOGs2QVZlTFR5SEFPU3Q0NFpZNWdSVVNIc25nQnVJZFV5d3RHNkYv?=
 =?utf-8?B?b21PR3Flb05JS2lKNEVkbzROVFFLSU1GbG4xVjlFUTdQNWNZZytHOUNWN1Yy?=
 =?utf-8?B?T1VYNGRwbnRFeHhOK3BrdUZ3TzUrTjlvWkRRb01oZE9wMU9rWDhTUHRJN1hW?=
 =?utf-8?Q?ySrcM6XSbho2zKcNTs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baa9074-5891-43e9-68ac-08d8e8c06938
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 21:13:56.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIrghvjSbRoj8MAOp6XXVRDHyWDPqwiXohfb7y6LBc7Ax58F2KbqnF4VHZLco93/ebcKXrdoMEUeQed55OcKXvnPWp58Oe9GgxaoPS0k0qfvZio+ffs3zu7g+l0fsGsz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3840
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160136
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160136
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

S2VpdGggLQ0KSSB1bmRlcnN0YW5kIHRoYXQgdGhlIFJQIGRpZCBub3QgZGV0ZWN0IHRoZSBlcnJv
ciBhbmQgc28gbm90aGluZyB0byBjbGVhciBpbiBpdHMgQUVSIHJlZ2lzdGVyLiBNeSBxdWVzdGlv
biBpcyAtIHdoZXJlIGlzIHRoZSBmYXRhbCBlcnJvciByZWdpc3RlciBjbGVhcmVkIGluIHRoZSBk
ZXZpY2UncyAodGhlIGRldmljZSB0aGF0IHdhcyB0aGUgY2F1c2Ugb2YgdGhlIGZhdGEgZXJyb3Ip
IEFFUiByZWdpc3Rlcj8gSXQgZG9lcyBub3Qgc2VlbSB0byBiZSBkb25lIGluIHBjaV9kb19yZWNv
dmVyeSB3YWxraW5nIHRoZSBoaWVyYXJjaHkgKHVubGVzcyBJJ20gbWlzc2luZyBpdCkuLi4uDQoN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWl0aCBCdXNjaCA8a2J1
c2NoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxMywgMjAyMSAxMjoxMiBQ
TQ0KPiBUbzogSmFtZXMgUHV0aHVrYXR0dWthcmFuIDxqYW1lcy5wdXRodWthdHR1a2FyYW5Ab3Jh
Y2xlLmNvbT4NCj4gQ2M6IEtlbGxleSwgU2VhbiBWIDxzZWFuLnYua2VsbGV5QGludGVsLmNvbT47
IEt1cHB1c3dhbXksDQo+IFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dh
bXlAaW50ZWwuY29tPjsgTGludXggUENJDQo+IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsg
YmhlbGdhYXNAZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIDogUmU6IHBjaV9kb19y
ZWNvdmVyeSBub3QgaGFuZGxpbmcgZmF0YSBlcnJvcnMNCj4gDQo+IE9uIEZyaSwgTWFyIDEyLCAy
MDIxIGF0IDEwOjU3OjE4UE0gKzAwMDAsIEphbWVzIFB1dGh1a2F0dHVrYXJhbiB3cm90ZToNCj4g
PiBCdXQgdGhlIGNsZWFyaW5nIG9mIGZhdGFsIGVycm9yIGluIHRoZSBkcGNfcHJvY2Vzc19lcnJv
ciBpcyBvbmx5IGZvciBEUEMNCj4gdHJpZ2dlciBkdWUgdG8gInVubWFza2FibGUgdW5jb3JyZWN0
YWJsZSIuDQo+ID4gSWYgdGhlIHRyaWdnZXIgcmVhc29uIGlzIEVSUl9GQVRBTCwgdGhlbiBpdCBk
b2VzIG5vdCBoaXQgdGhlIGVsc2UgY2xhdXNlIGFuZA0KPiBuZWl0aGVyIGlzIGl0IGNsZWFyZWQg
aW4gdGhlIHBjaV9kb19yZWNvdmVyeSBjb2RlLg0KPiANCj4gSWYgdGhlIHJlYXNvbiBpcyBFUlJf
RkFUQUwsIHRoZW4gdGhlIHBvcnQgZGlkbid0IGRldGVjdCB0aGUgZXJyb3I7IGl0IGlzIGp1c3Qg
dGhlDQo+IGZpcnN0IERQQyBjYXBhYmxlIGRvd25zdHJlYW0gcG9ydCB0byByZWNlaXZlIHRoZSBt
ZXNzYWdlIGZyb20gc29tZSBkZXZpY2UNCj4gZG93bnN0cmVhbSwgc28gdGhlcmUncyBub3RoaW5n
IHRvIGNsZWFyIGluIGl0cyBBRVIgcmVnaXN0ZXIuDQo+IA0KPiA+IEZyb20gZHBjX3Byb2Nlc3Nf
ZXJyb3Igd2l0aCBtb3JlIGNvbnRleHQgLS0NCj4gPg0KPiA+ICAgICAgICBlbHNlIGlmIChyZWFz
b24gPT0gMCAmJiAgPDw8PDw8PCBvbmx5IGZvciAidW5tYXNrYWJsZSB1bmNvcnJlY3RhYmxlIi4N
Cj4gV2hhdCBhYm91dCBmb3IgRVJSX0ZBVEFMPw0KPiA+ICAgICAgICAgICAgICAgICAgZHBjX2dl
dF9hZXJfdW5jb3JyZWN0X3NldmVyaXR5KHBkZXYsICZpbmZvKSAmJg0KPiA+ICAgICAgICAgICAg
ICAgICAgYWVyX2dldF9kZXZpY2VfZXJyb3JfaW5mbyhwZGV2LCAmaW5mbykpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgYWVyX3ByaW50X2Vycm9yKHBkZXYsICZpbmZvKTsNCj4gPiAgICAgICAgICAg
ICAgICAgcGNpX2Flcl9jbGVhcl9ub25mYXRhbF9zdGF0dXMocGRldik7DQo+ID4gICAgICAgICAg
ICAgICAgIHBjaV9hZXJfY2xlYXJfZmF0YWxfc3RhdHVzKHBkZXYpOw0KPiA+ICAgICAgICAgfQ0K
PiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBL
ZWxsZXksIFNlYW4gViA8c2Vhbi52LmtlbGxleUBpbnRlbC5jb20+DQo+ID4gPiBTZW50OiBGcmlk
YXksIE1hcmNoIDEyLCAyMDIxIDU6MjUgUE0NCj4gPiA+IFRvOiBKYW1lcyBQdXRodWthdHR1a2Fy
YW4gPGphbWVzLnB1dGh1a2F0dHVrYXJhbkBvcmFjbGUuY29tPjsNCj4gPiA+IEt1cHB1c3dhbXks
IFNhdGh5YW5hcmF5YW5hbg0KPiA+ID4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGludGVs
LmNvbT4NCj4gPiA+IENjOiBMaW51eCBQQ0kgPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBi
aGVsZ2Fhc0Bnb29nbGUuY29tDQo+ID4gPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIDogUmU6IHBjaV9k
b19yZWNvdmVyeSBub3QgaGFuZGxpbmcgZmF0YSBlcnJvcnMNCj4gPiA+DQo+ID4gPg0KPiA+ID4N
Cj4gPiA+ID4gT24gTWFyIDEyLCAyMDIxLCBhdCAxMjo1NiBQTSwgSmFtZXMgUHV0aHVrYXR0dWth
cmFuDQo+ID4gPiA8amFtZXMucHV0aHVrYXR0dWthcmFuQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+
ID4gPg0KPiA+ID4gPiBIaSAtDQo+ID4gPiA+IEnigJltIHRyeWluZyB0byB1bmRlcnN0YW5kIHdo
eSBwY2lfZG9fcmVjb3ZlcnkoKSBvbmx5IGNsZWFycw0KPiA+ID4gPiBub24tZmF0YWwgYnV0DQo+
ID4gPiBub3QgZmF0YSBlcnJvcnM/IE15IGltbWVkaWF0ZSBjb25jZXJuIGlzIGNhbGwgZnJvbSBk
cGNfaGFuZGxlci4gSWYgYQ0KPiA+ID4gZGV2aWNlIHNlbmRzIGFuIEVSUl9GQVRBTCB0byB0aGUg
cm9vdCBwb3J0LCBJIHdvdWxkIHRoaW5rIHRoYXQgYXMNCj4gPiA+IHBhcnQgb2YgcmVjb3Zlcnkg
dGhlIGZhdGFsIHN0YXR1cyBpbiB0aGUgQUVSIHJlZ2lzdGVycyBvZiB0aGUgZW5kcG9pbnQNCj4g
ZGV2aWNlIHdvdWxkIGJlIGNsZWFyZWQ/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IEFk
ZGluZyBTYXRoeWEgd2hvIG1lbnRpb25lZCB0byBtZSB0aGF0Og0KPiA+ID4NCj4gPiA+IEZhdGFs
IGVycm9yIGFyZSBjbGVhcmVkIGluDQo+ID4gPg0KPiA+ID4gdm9pZCBkcGNfcHJvY2Vzc19lcnJv
cihzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gPiA+DQo+ID4gPiAyNTMgICAgICAgICAgICAgICAg
ICBkcGNfZ2V0X2Flcl91bmNvcnJlY3Rfc2V2ZXJpdHkocGRldiwgJmluZm8pICYmDQo+ID4gPiAy
NTQgICAgICAgICAgICAgICAgICBhZXJfZ2V0X2RldmljZV9lcnJvcl9pbmZvKHBkZXYsICZpbmZv
KSkgew0KPiA+ID4gMjU1ICAgICAgICAgICAgICAgICBhZXJfcHJpbnRfZXJyb3IocGRldiwgJmlu
Zm8pOw0KPiA+ID4gMjU2ICAgICAgICAgICAgICAgICBwY2lfYWVyX2NsZWFyX25vbmZhdGFsX3N0
YXR1cyhwZGV2KTsNCj4gPiA+IDI1NyAgICAgICAgICAgICAgICAgcGNpX2Flcl9jbGVhcl9mYXRh
bF9zdGF0dXMocGRldik7DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4NCj4gPiA+IFNlYW4N
Cj4gPiA+DQo+ID4gPiA+IFNuaXBwZXQgb2YgY29uY2VybiBpbiBwY2lfZG9fcmVjb3Zlcnkg4oCT
DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgLyoNCj4gPiA+ID4gICAgICAgICAgKiBJZiB3ZSBo
YXZlIG5hdGl2ZSBjb250cm9sIG9mIEFFUiwgY2xlYXIgZXJyb3Igc3RhdHVzIGluIHRoZSBSb290
DQo+ID4gPiA+ICAgICAgICAgICogUG9ydCBvciBEb3duc3RyZWFtIFBvcnQgdGhhdCBzaWduYWxl
ZCB0aGUgZXJyb3IuICBJZiB0aGUNCj4gPiA+ID4gICAgICAgICAgKiBwbGF0Zm9ybSByZXRhaW5l
ZCBjb250cm9sIG9mIEFFUiwgaXQgaXMgcmVzcG9uc2libGUgZm9yIGNsZWFyaW5nDQo+ID4gPiA+
ICAgICAgICAgICogdGhpcyBzdGF0dXMuICBJbiB0aGF0IGNhc2UsIHRoZSBzaWduYWxpbmcgZGV2
aWNlIG1heSBub3QgZXZlbiBiZQ0KPiA+ID4gPiAgICAgICAgICAqIHZpc2libGUgdG8gdGhlIE9T
Lg0KPiA+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gPiAgICAgICAgIGlmIChob3N0LT5uYXRpdmVf
YWVyIHx8IHBjaWVfcG9ydHNfbmF0aXZlKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBwY2ll
X2NsZWFyX2RldmljZV9zdGF0dXMoYnJpZGdlKTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHBj
aV9hZXJfY2xlYXJfbm9uZmF0YWxfc3RhdHVzKGJyaWRnZSk7ICAgPDw8PCBKdXN0IGNsZWFyaW5n
DQo+ID4gPiBub25mYXRhbC4gV2hhdCBhYm91dCBmYXRhbD8NCj4gPiA+ID4gICAgICAgICB9DQo+
ID4gPiA+DQo+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiBKYW1lcw0KPiA+DQo=
