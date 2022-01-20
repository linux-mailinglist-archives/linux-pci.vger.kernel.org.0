Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0ED49495E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 09:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358371AbiATI0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 03:26:05 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:40322 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232274AbiATI0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 03:26:05 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K7xJbu024922;
        Thu, 20 Jan 2022 08:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=O5tfcReZs8fsJ9Py6sUGeegUrA53vLEcryDMcAvyzeo=;
 b=mF89xHx1o6T8ZEJa0+SteiDTVwMZNfCBu8Ra2OsnT/UwBUCnRmdrKSQTStxTS40VCnWl
 mZzTSJSOyFUb4+IkUeOefNQeErIlhWQTBFojzrXd7tGNIBh9I+tzu1G4Sok2icSTeAnY
 PgnL+agIjvLpkxTSgB2GNLXp2Pykw/01XJXUJFF5zfEi/9ywoDa5FUMNfvltV5Xk210D
 ROQdA8S2UIb1yKBO+muh3sV2mK5Jppa3bj3elYPzqGhNmTLudEnL4e4CaV9aE04e+O5T
 ncaVDVxEuKtbVKiorOITuy80ShifMO9KpkaxfzHcJfLYAZLcYKc4nXsnm3LmEZ8pN6LH 3w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dp4220n9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 08:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpKq7kLb7EaOY134yhdM/3ogbRop2RVzi5LJpft+v0HwEVrR9dCzgp8gDsphEiSugxfFOfjQRVrZH5vOcAFci5B9TOXVNCFItGBB6Ewvec4i/0Al3Ll9jGEBBEKBbvhxNtvwsZene8X52l1G2LSWC8OJn5RWUf/YtdtyggUd660ztF+PEZla38/S5LrxElfGzfBqdSyyn/pcpZgdJVqoekLCPKF8e5bXSosF0tIrPppjhHYXafAxpXGx1veVDBXfzPHk+jeSVA+pc9gMkMTRe1RAmswcr6UzbDNFqRU08lner9xiQ2o0aPm6DE4Zff79+Ekv4iNYbeAz/LNghop3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5tfcReZs8fsJ9Py6sUGeegUrA53vLEcryDMcAvyzeo=;
 b=HwS/9HRMfVdHNbkW2vQmyq9ZnqlIY8dZXb55m9/szflL/tu0LAro0DFeLxZhmAcO+1MC4kJng70F5sGdfL4BuAVbriT2p/iIxf4fKBn7absKLWF4Q/XwcaS5RIQjpHvYbd4GEWsSzV0pu1yg+/xHjwOMnr3hV1eh2V68CsplqnA6AWd+RIFPSvD5aZSDVs8d2Eg4WWHMH9axtvLjwcDPmxymDQQeuBXe0YiKLW6lJWc3NH2pdC+XWYlml6Y5zEoJ/LrYpZvLAK8WY0l6+Var6vKS68uxdy6bPD3oXIQTqrcMqfadMYi2UcuD5V8yqFnbyfSeaPvOU1/fFCnyee7piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5tfcReZs8fsJ9Py6sUGeegUrA53vLEcryDMcAvyzeo=;
 b=bks0T7VGuhxDhUPtR1VTBCzONp00g6iPsbQ5RkyT2LeJD0E9sZO/qfHJWtM6cufMhjEaxqBj1DRFc8JsUHV6o8aSnIqc7aNM9vx61TZCwMkyyBCI/4pzJ8yK5aXYBE+oKH2BFyerOLyFC7kerFkyqIKtl3GlWUitWoRqRRRQkKnhju5E7yZvDJnn2q06P8wwANjdKzqMp78yBUx6Xo6CRGBx+GwuH4fyAEVN1kIdUcuVNWHIhJzTxlDj64T26TEav3zZKJ4fc9xV26UIaIr/yAVhS44ldCBwnSXrfoekfpw8njddSiNnDhhW8zOfr8Mh0bT5odXG3eWvIM6L2bkDCw==
Received: from SA1PR19MB5572.namprd19.prod.outlook.com (2603:10b6:806:229::8)
 by CH2PR19MB3816.namprd19.prod.outlook.com (2603:10b6:610:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 08:25:52 +0000
Received: from SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db]) by SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db%7]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:25:51 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint test
 read and write operations
Thread-Topic: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint
 test read and write operations
Thread-Index: AdgN08pRFuc4KG9kQuiq2cd/4nCPdQAANOIAAAAK8uAAAFVRAAAAOO6g
Date:   Thu, 20 Jan 2022 08:25:51 +0000
Message-ID: <SA1PR19MB5572D993FFC2EECDA89E5A66A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
References: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <YekYAAHPEBeJflZN@kroah.com>
 <SA1PR19MB5572A56F07CC46A064330408A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <Yekahmtc0bsaUMhi@kroah.com>
In-Reply-To: <Yekahmtc0bsaUMhi@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d555ad78-cb14-44da-f0b5-08d9dbee787e
x-ms-traffictypediagnostic: CH2PR19MB3816:EE_
x-microsoft-antispam-prvs: <CH2PR19MB38169CB39E3BDC8E772ACEEBA05A9@CH2PR19MB3816.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TIlvl4cYzAc8BUHeJ1tR8v270Qk+i91IUxMLiNvULJY0Fu69/8qERd3FIm47FhlUhQfW7qOTu/n8SZBvSIIyO5Ix6e6q7q73/ugulHediE27FRC0wDYDEuMs3jz21V5+xXLGjYXsmz6+sbOjVrPDcQiJGd46k81p+vx0IImE5p4bwV3m7DjvuLfYxCG5oF7wA+PkGqOXYwI22z4tpS88QhcvcOPAWAOLoDryaWt5PXxC/nmusZn2Fampr7s8Uf/8k5bMqWryUcC0ZnL80c6PiO3ga6vjEDLx9bboAXSs3M7bXJga9hZmou4zX4PPKOq4jeYA/mSQDrlUYeHAF5uN/+eIaH9y4HZgYlvEl2FaU4ylogpxnABsa+8gjf0DGCI+08mzSCV+zS+9z76MWtyQ75poQiehiApDbDQiEz7e9Nf0FLog/h62ni9x8dx9LV48iPfqDDacJnC+k4F4Fvw3EZrAQY2Y5xCh7E36FuVND47aGgr67Zsij7QGLOasLhI/ILCn6jLsLPUD0TQHEaZMlAYSGOvLFOjv/T2zDgFhUZJmAqy8YRpnUtSg8P/7pYTRNXBIsqaBsNwUkot4Wz5MFlrpfvp6Yf7WYh86yC4NmEGCxUJ169hAud4v7q9YXaWUyeD2MrOcq2V3uxg6QlR/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5572.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52536014)(4326008)(9686003)(316002)(71200400001)(38100700002)(54906003)(88996005)(86362001)(5660300002)(64756008)(66476007)(66556008)(66446008)(66946007)(7696005)(122000001)(53546011)(6506007)(55016003)(66574015)(2906002)(508600001)(33656002)(8936002)(6916009)(8676002)(186003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVxaldZSXBzQVlra2YxUkZGVklMOUVxVHdqazN6WGJHQ1BuT1NLQ25TU204?=
 =?utf-8?B?NXh3TU9GRWxkZGF5N3o0RG9iTkQzWnU1bTVad1Jzd0FGbE9mTzJiSzVycFRI?=
 =?utf-8?B?MDNIcTZSaEExWG9aVGoxditJUFpSRjdwYmRDSUJrTTNmdG1Xa1hEUkluWmtD?=
 =?utf-8?B?ZVJlY2Nxa2NQZTB2ZnBFY3ZlQjlKM2krbWpub2dmVjdINmlEcDJtN21MNC90?=
 =?utf-8?B?WnVFWEh6UkE2bitsWldmSG1Zbk5kbXFJeWtNcXltV2pPdnQwU2w4TnQzY1or?=
 =?utf-8?B?eGpVSC9LTVR0clFqRkFhMzBQOW9KRytxK05GdnpVaHJXNklMampZUFRrZDRT?=
 =?utf-8?B?a1BEUWVhTGd5VlpNOGd3WEFmblJEL2tqWU9peTVKN3U3Uk5oNC9sTzRtU002?=
 =?utf-8?B?Z3pmYTNqbitab1NTUGdSVnlNU1k4SUsvQ3h6S2wvaGxKSUJFelJNOGNBaGNw?=
 =?utf-8?B?dGhhaEVSaUxpUGZNdjNjVzdHT1NCd0pUY0NieFRKdTMraWhYdG1XcXppaGJr?=
 =?utf-8?B?QU5tdWxxVnBuYUpxdlV3dUp3QUF5SjhTZ3BFbkVqN1RXL3NGd3lCdFZOb3JY?=
 =?utf-8?B?emV4UkdtSlpzNW95b3pjTjFlKzhvaGt4eGQyR2RlbW8rUmU3U2pqU2wwZXBO?=
 =?utf-8?B?TE5GbmVnczVRTDJjalJxRERBN1hQYTRWR1M3Tlp4S3Job2hTS2xDY3RpMDI3?=
 =?utf-8?B?OVhJMUJwUGkrTlg0T1NoajVRZWtnUnpOM0V0NVl3d09MRWdQQmh2ZEFFUzl5?=
 =?utf-8?B?eVNKS0c4Y21NblVDZitBNU1PQ1ZFT2ozdm9VVFhqbGIyQW5ZNHUyVy9aRVJW?=
 =?utf-8?B?R1JOS2pRQlZEaWRsUVo3NVpSa29GVDVGMmxwM1pmeXNrUFlKZHNsMm1HTkhv?=
 =?utf-8?B?TlV6a0JMMnd4UHJPZGhKUFI4N3VCWWw3OThNRnpUcERMWDF0T2FHZUI4Rzkv?=
 =?utf-8?B?MVMvamJVejBndmhibjFEV0ZnYU4vTnlNcE9OR2ZuSDFuUUt5YjhnWkhScXBh?=
 =?utf-8?B?MWN3bU1ldTlUcFhzeStmcXBMOVpidlhUMy9FTFJLRWVLam5rdUczcjI5YmtK?=
 =?utf-8?B?MG9TcHVOam1uYmhuaU8vMTJvNFdTVnNnNWdCVG8xOVFCY2FXSmZxZVEzOExG?=
 =?utf-8?B?cXIyRDhPVDRjNFR0c05kMEdKSWRpd05YcUxQeGlVdUZwS3haanpxU2dzNVJt?=
 =?utf-8?B?MnBBSGFJdk5rSk41TDZoYjlmck9pZHhJRnoxSmVTZVlTd2tRcXVmWXZCaWdB?=
 =?utf-8?B?SXAyTVR6UnNsbUJRTGdBZnYvT0ptOGRkaEZQNVlIbEhIT2Y0SmhxM3NaYStY?=
 =?utf-8?B?cU5vOU9aMjF0WDA3UklTVGNyaVRtZHpsZE8raE1XYVVzbG82WCtmNGs0dFZM?=
 =?utf-8?B?SGRraDJCNDQ4T0tweW92amdNbEpkcUROYjFXbnV0aS9iN1ZGU0ZCVnRYYzFy?=
 =?utf-8?B?U1ZGdGhWbmVWd2tOcHpkSWVobmtxQis5ZkgzMWU5Z0RxY2M5cnJkbkVudk9l?=
 =?utf-8?B?R3hNSWtRQWkzanVCZFYvN1Uvc01MeTlva1I5VW9XM25kbTBlenVmV01JcHcw?=
 =?utf-8?B?UHZkRVpnUUliTTgzRE5YdlF0b05MTEcwWUdzZWlJdFVORzJBVnowUnI1cUNM?=
 =?utf-8?B?Q3NhYU5OY1dEY2VER1RVUkdSUEN2enRUVzRkdjJaMGh2cGpmU2pXamdSeFZY?=
 =?utf-8?B?SVJaRUpTelYwYkxIazVSVklaZmZaQVQ2WjNIcHlBdTJtNGtYaldNZXV1eHUr?=
 =?utf-8?B?eDAzT3k1VkdKN2lveUNJdDZZcStFaXBUdWJyaW9vcko5ZnVPM0lDTi8walF2?=
 =?utf-8?B?Q2VDNERCWGRBQTdReXNWNkJoUFo2eUhMR1pBV1pVdHk5YTd3UkI2RWJHa1FM?=
 =?utf-8?B?UTZHc1BkUWFkMGlBd21SbUYwKy9HejQ4ZlNVQW5oQUNqS2gwTXdQd1k1Vnhs?=
 =?utf-8?B?RGdrOElTWlhMZ1JDYzJjeThSZFhOaFBSSXYyeEI2Tkx1UUdKQTNyQVRrUGhM?=
 =?utf-8?B?RmRmS3pGaDMweUwxN1JydkFjWEp0TFU0N29XMzFiTmxscFloSTJicWczWHFZ?=
 =?utf-8?B?Tkk1a3VLOURKY0lESzF4dk5hdVY3V25DV1c1TU9ERThmdGd5ZWVGeTFEa1E1?=
 =?utf-8?B?TW5MR3AydjNFUmpUcFM5NkNnMjVPVWtlZy91M3huTmw0czJkb1l0d2g2S3Nn?=
 =?utf-8?Q?Ha3RCyj4iukJy7XmLmPG8ig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5572.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d555ad78-cb14-44da-f0b5-08d9dbee787e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:25:51.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KeOkPg/SY1RNqeqAhqIp939fu2pBxWZ1zTx/EgtmbyHL56Q1vN/SdBmxfF1H9whDZm8Ju/8Ww+2sbkHqtotEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3816
X-Proofpoint-GUID: x99kI5xreG0NSfIkXZ6MB8N2zCo6YVbl
X-Proofpoint-ORIG-GUID: x99kI5xreG0NSfIkXZ6MB8N2zCo6YVbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=937 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200043
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4g
W21haWx0bzpncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4gU2VudDogVGh1cnNkYXksIEph
bnVhcnkgMjAsIDIwMjIgNDoxNyBQTQ0KPiBUbzogTGkgQ2hlbg0KPiBDYzogS2lzaG9uIFZpamF5
IEFicmFoYW0gSTsgTG9yZW56byBQaWVyYWxpc2k7IEtyenlzenRvZiBXaWxjennFhHNraTsgQXJu
ZA0KPiBCZXJnbWFubjsgQmpvcm4gSGVsZ2FhczsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJl
OiBbUEFUQ0hdIG1pc2M6IHBjaV9lbmRwb2ludF90ZXN0OiBzaW1wbGlmeSBlbmRwb2ludCB0ZXN0
DQo+IHJlYWQgYW5kIHdyaXRlIG9wZXJhdGlvbnMNCj4gDQo+IE9uIFRodSwgSmFuIDIwLCAyMDIy
IGF0IDA4OjA5OjIwQU0gKzAwMDAsIExpIENoZW4gd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIFttYWlsdG86Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+ID4gPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAy
MCwgMjAyMiA0OjA2IFBNDQo+ID4gPiBUbzogTGkgQ2hlbg0KPiA+ID4gQ2M6IEtpc2hvbiBWaWph
eSBBYnJhaGFtIEk7IExvcmVuem8gUGllcmFsaXNpOyBLcnp5c3p0b2YgV2lsY3p5xYRza2k7IEFy
bmQNCj4gPiA+IEJlcmdtYW5uOyBCam9ybiBIZWxnYWFzOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6
IFtFWFRdIFJlOiBbUEFUQ0hdIG1pc2M6IHBjaV9lbmRwb2ludF90ZXN0OiBzaW1wbGlmeSBlbmRw
b2ludCB0ZXN0DQo+IHJlYWQNCj4gPiA+IGFuZCB3cml0ZSBvcGVyYXRpb25zDQo+ID4gPg0KPiA+
ID4gT24gVGh1LCBKYW4gMjAsIDIwMjIgYXQgMDg6MDM6MTdBTSArMDAwMCwgTGkgQ2hlbiB3cm90
ZToNCj4gPiA+ID4NCj4gPiA+DQo+ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ID4gPiAqKioqKioqKg0KPiA+ID4gPiBUaGlz
IGVtYWlsIGFuZCBhdHRhY2htZW50cyBjb250YWluIEFtYmFyZWxsYSBQcm9wcmlldGFyeSBhbmQv
b3INCj4gQ29uZmlkZW50aWFsDQo+ID4gPiBJbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgc29s
ZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsKHMpIHRvIHdob20gaXQNCj4gaXMNCj4g
PiA+IGFkZHJlc3NlZC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgZGlzY2xvc3VyZSwg
ZGlzdHJpYnV0ZSwgY29weSwgb3INCj4gcHJpbnQgaXMNCj4gPiA+IHByb2hpYml0ZWQuIElmIHlv
dSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRl
ciBieQ0KPiA+ID4gcmVwbHkgZW1haWwgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcyBvZiB0aGUgb3Jp
Z2luYWwgbWVzc2FnZS4gVGhhbmsgeW91Lg0KPiA+ID4NCj4gPiA+IE5vdyBkZWxldGVkLg0KPiA+
DQo+ID4gSGksIEdyZWcNCj4gPg0KPiA+IEknbSBzb3JyeSB0aGF0IEkgaGF2ZSBubyB3YXkgdG8g
cmVtb3ZlIHRoaXMgbWVzc2FnZSBieSBteXNlbGYuDQo+IA0KPiBTb3JyeSwgYnV0IHBhdGNoZXMv
ZW1haWxzIHdpdGggdGhhdCBub3RpY2Ugb24gaXQgYXJlIG5vdCBhbGxvd2VkIHRvIGJlDQo+IGFj
Y2VwdGVkIGZvciBvYnZpb3VzIHJlYXNvbnMuICBQbGVhc2Ugd29yayB3aXRoIHlvdXIgY29tcGFu
eSB0byBmaXgNCj4gdGhpcy4NCg0KT2ssIHRoYW5rcyEgU28sIHNob3VsZCBJIHJlc2VuZCB0aGlz
IHBhdGNoIGFmdGVyIGZpeGluZyB0aGlzIHNlbGYtYXR0YWNoZWQgbWVzc2FnZSB3aXRoIG15IGNv
bXBhbnk/DQoNClJlZ2FyZHMsDQpMaQ0K
