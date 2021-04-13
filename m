Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4641335DC50
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhDMKO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 06:14:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9590 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238844AbhDMKOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 06:14:53 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DABVuS028856;
        Tue, 13 Apr 2021 03:14:17 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-0016f401.pphosted.com with ESMTP id 37vpuu3b8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 03:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjdj5NadVYhzylZ7SUgFiF9QJHUGQUoi9fSoshuJ8oY81Bmncqa6mXrTn3E9SPgeBgcsrP4OtRJkEupA9V+ReTx5DEAQzY8C2C96ZVfXydD+7s35Q+aRCQlIrCT7thIk88C50pAE+qMJPAdxO15sdh4lT1Q9SVJhTNognBLz3Ym31RN9DF5zMAy9G+ZmsQIBULKqEBHSD8tJiYJ+mA0ee1NLGQn6rAUhRFk6UBSI78Nddt/v8Q4TTCxwPUwf2QY3RjUjT0YB9Ol5YgXFU/aDMKMk26qOQFNgcJC2SQv2Q9RJrgLowPXQW06ogoint2kOXKzgjSzf0QwKQhV64/Vi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3cEROsIHa7u83RHWKshLwNWGL/+jKhbbGDoHY1ypAE=;
 b=U2falhEptMT0DL1vVSeyaJWMRQnkn6xk5B/CZN0mYC8T1NxSY8iJ4hzP8Cibcbi/4CIK92Hes9KOtj+W3J8D7W4TRhxX2f3KNr8fZJdfZcH23eMpA0ps2RnX+gU4dIjdX5gac/TwjyRuRGUIyK+Spug1mOaLzlLM9AwdHal1JyPNBMpSsR3Qe7Y9DhwcJr8OnwSvQ8261RVeQJgzDsnIAVDnjr35DXoXu5NTgnFTQz15bNC6/kmi3nO+QOJRdUBFbngw1ReiEz28SJ4wtB1kZPaE+u+bTcIfjDaroINGAxRdT4lPDaxAttO6zbj910FgKqJH40WHIpwo6tKIRbuuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3cEROsIHa7u83RHWKshLwNWGL/+jKhbbGDoHY1ypAE=;
 b=trjpmTa+nPY2hZNjPnuCpytdIcUmdUq+LJW6+f6jbYFH5rPzCAZgQzakEY5Mb+X+n9i7ROXB92FrPSdbfglEJIakWZzTNXvdt9SdXD6RftyzIoNry1Zc7qkg55Sf60Ozus6xAZDqeLMXmVjERIwWY5cnL19pUg4qfptbseejQ5E=
Received: from MW2PR18MB2217.namprd18.prod.outlook.com (2603:10b6:907:7::33)
 by MW3PR18MB3611.namprd18.prod.outlook.com (2603:10b6:303:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 10:14:15 +0000
Received: from MW2PR18MB2217.namprd18.prod.outlook.com
 ([fe80::3811:5dde:7523:bb7d]) by MW2PR18MB2217.namprd18.prod.outlook.com
 ([fe80::3811:5dde:7523:bb7d%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 10:14:15 +0000
From:   Ben Peled <bpeled@marvell.com>
To:     Ben Peled <bpeled@marvell.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ofer Heifetz <oferh@marvell.com>
Subject: =?utf-8?B?UkU6IFvigJ1QQVRDSOKAnSAwLzVdIEFzeW5jaHJvbm91cyBsaW5rZG93biBy?=
 =?utf-8?Q?ecovery?=
Thread-Topic: =?utf-8?B?W+KAnVBBVENI4oCdIDAvNV0gQXN5bmNocm9ub3VzIGxpbmtkb3duIHJlY292?=
 =?utf-8?Q?ery?=
Thread-Index: AQHXL7DdHnwqfdixfkeqQ22a38hQ56qyOumA
Date:   Tue, 13 Apr 2021 10:14:15 +0000
Message-ID: <MW2PR18MB22175AED0E4FCC2BF640AB8CC24F9@MW2PR18MB2217.namprd18.prod.outlook.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
In-Reply-To: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.67.24.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3470b93e-bae1-40e8-ed3d-08d8fe64e46c
x-ms-traffictypediagnostic: MW3PR18MB3611:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR18MB3611652255EDE41C0D3BBEF2C24F9@MW3PR18MB3611.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1WFQpbyxSb/aqYkMs6Iso1MXQwAyKx/jdiY8OA7y6FSXs9iq/1WPT8fMzGtYrYkJxKVjSmgq6ja3xyuP+TFcuRj3P8t2iXHBeJwuhMJ39aZ1r1EVTBztSb1sKotNiAmCLHmWuLbhek99Ag555WZ9F8bRnCCQkzn1eAzBy1cYLjLk+xd+gwbR94mIrJuaZwsPptTmHwNpbClX71YDxE0lTIzx1kqAAHB/dkajXQpVm7oK+4G7Fj0bO4zSSeyH/RgwvE5fHTZL7Y6UGqDOfKjuGx9ys++BQWm5s1Dex2ttrG6QdZyvTkq8C6FVWaJrnQlFeLLb+uDexqpGoZAmAi11J7o1boCjNJ19FZMOupIVPNn2YBA3uBZMgStCzv0nDMwWK5Ty4V2gcblcutZy+fFAt9a1f8/ti1TqM1DORorCBMcQy/XY1Akwlj5AW8eE9hSYRb0/vVPFkSzOmEhtdrEBxppF3JvLVd5eqrW3qKVe7gl/Bx7ox701g0iqLdljl+Vpbr2nwVIudb8NPi+zLS5r3LgV746hzPxb7tM97N8kgp2DwBhCcXL9jZDpC0mIWM9+dcS7Oh5vwJnA44Mtu0rDUszZ77HelUupvYQx82R7i8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2217.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39850400004)(136003)(376002)(478600001)(107886003)(316002)(4326008)(2906002)(86362001)(9686003)(71200400001)(5660300002)(7416002)(83380400001)(8936002)(110136005)(186003)(66946007)(66446008)(64756008)(66556008)(66476007)(6506007)(53546011)(52536014)(38100700002)(33656002)(55016002)(26005)(54906003)(7696005)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RWFRRnQrNDRMZk9Zd1pSWTR1YlhqWjBjYUF5cVZiNlVVTVFnU28rWmcyaG4z?=
 =?utf-8?B?a2JwTUxESWwyMWE1bnR0M0kyOThmUHJmOTFUeG5Gb0RHcXcvbFYweHlHdHls?=
 =?utf-8?B?SzY0TFZ0emVsdXMvRHB5bm1wSGtjbEFNM0FXKzZ2UEszbmVCa05kLzZaNWgy?=
 =?utf-8?B?Tng5cnFPVU5sOGpkNW9uRkNOTWo3WTdGSHUzTmZGV0lQODdTYWlRUis0TlVq?=
 =?utf-8?B?MFV4ZjdGbVZTVHZiVGlaNWZIMWlXKzFsK0szakJ5OVorSnp1UXJqclZJbHNJ?=
 =?utf-8?B?NFN0dERNZjJpcWdUbm94bkkvL2FMaTQydm5HeE9XK2hBOVZ1NEwrZVNoMURa?=
 =?utf-8?B?Y0cxeTZSd29TQzFlbENqS014a3RxV1MreDNaL3h4MVhxNWN2ZEo3R2hCTXBx?=
 =?utf-8?B?UkY3SStWZXdCdURaMkhVM0lFd1FvVTljdW41bmljbHhRU2svdjUvdHIxRUEx?=
 =?utf-8?B?N1RtQkJyWS9YVWY5R2xseHV6SWs4cTlDL2JtSGhvdDJwSjRTMS9RTWk2RlFl?=
 =?utf-8?B?L1B4c25Ud0QwU3dtQkNlbUFqUWtxdW5xQ1RJeGg1UWl3NUtHdkNZaDNXUUY3?=
 =?utf-8?B?VmxTSVNzOVZ5UVUrVS9vajRZKzh4ZFV1ZVFEaC9WOTZPTmw0VndLRnhDejlX?=
 =?utf-8?B?emVwdE4rQ1V0UEJzdHBTcllxdWpYY2loUU5JNnN0RDExYUx1a0U2VzNHME1J?=
 =?utf-8?B?Tk1vMmZtRjhHMVRMMmNkbUo2L3JHRmJPbGlZdGVKOUdtYTF3NEhKNjNVSExr?=
 =?utf-8?B?WVg3bEdEZkM0NG1GT1pJRzdFbUdUNXVCTmwwWkZySmRVMVNuQ3J4UjJIb29X?=
 =?utf-8?B?Y3lTTXM4RlBHVlR2Qy9iK3hZdG5WbGR1Q0JDUHJQT0VVanJYam4zU3djdnc5?=
 =?utf-8?B?NjJvSUY2RWRlS3c0QThsNDRuSXFoTy94Z0l2eGJDYUtLaUdEWG81RXM5Q2M3?=
 =?utf-8?B?RC9Rd2lrNUVUMGdHU2pFZ3hINDNpMDVIVFRzclFQWnJ3aDlHOHVTNmpzUlo0?=
 =?utf-8?B?OVVmb2ZHZVpzb01LMy9tTnZFNGlMUXk1bi9yVGkzTmFQOUNSU2E0K2ZKQWJ1?=
 =?utf-8?B?eTVuK2grNEJEUGVBNnIzMFNtZG9TV09Eb3c2VnNPMTA4a3VEUnlVOTdRUnhQ?=
 =?utf-8?B?TktyTWRjM1JvaUxjWWdBM3QxRWxudjc2Z1hMaGRJaTFoclJGM1h5R013MVE4?=
 =?utf-8?B?ZVJIbm1QV25iQ1pXNm00Zm1WMHZyTW8yQ1BmR1R1Sk0yVDdlYWFYcVl6d1hJ?=
 =?utf-8?B?d2crOUhqck91LzNiUG1MN3dJeDJJNnNrTHN3Q2N0S2ZKQWd3ME1SWlJRdzRV?=
 =?utf-8?B?dmlRd0pJSnFnNjZNMUMzV1o2YWdteStycFB3NjZjNWhZOEViQ2ZvSmx1RHhk?=
 =?utf-8?B?WUpKVC8ydlpvMFFUU3JRNmRuZnZVZXpWcTFjZUFtbGRYOE1SQzhPSERSeUZH?=
 =?utf-8?B?WFZtWkMwVFFlYkRoUzJPbkRDdE5hdG4wTW9UTE1heHE3M05nYXhvWXl4NTBD?=
 =?utf-8?B?RWdJaFJmbXNHZHI2ampOWk9JMXIyOE5Gc2xjdjdWdTdwdVFwdnk1VmIxcm9h?=
 =?utf-8?B?dUtxNEU5Ty9OR1psYjR5RkJEYm56NXJsclBPNmVDRVdnd1B0VHhvcXhYRlIy?=
 =?utf-8?B?akhHYkVUMUpWc0c2UEJjUnlqNXhLVlhhalpzZVNRUDFDeUxaYkJzNFhVOUNl?=
 =?utf-8?B?WFFlZDVia0o4Nzc5SVVjbkdobGxJb3BuVU1vNm11VnNGbTczM2JqMC9QQnRP?=
 =?utf-8?Q?9SfGGi0Y3volwkoVL0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR18MB2217.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3470b93e-bae1-40e8-ed3d-08d8fe64e46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 10:14:15.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efENj8wF/VNLvUFKZ10BjYJVxYIe6skol+sliHSZFxuuscQUNmikgI66Vvb1jGHHpTB+agPyXixJ3leZIu3LpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3611
X-Proofpoint-GUID: 8gKKVk7ky2cb9VhTDY4QYyiR0utwseaZ
X-Proofpoint-ORIG-GUID: 8gKKVk7ky2cb9VhTDY4QYyiR0utwseaZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgYWxsLA0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIGxpc3QgdGhlcmUgaXMgYSBzbWFsbCBj
aGFuZ2UgbWlzc2luZy4gDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBicGVs
ZWRAbWFydmVsbC5jb20gPGJwZWxlZEBtYXJ2ZWxsLmNvbT4gDQpTZW50OiBNb25kYXksIEFwcmls
IDEyLCAyMDIxIDY6MzEgUE0NClRvOiB0aG9tYXMucGV0YXp6b25pQGJvb3RsaW4uY29tOyBsb3Jl
bnpvLnBpZXJhbGlzaUBhcm0uY29tOyBiaGVsZ2Fhc0Bnb29nbGUuY29tDQpDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
c2ViYXN0aWFuLmhlc3NlbGJhcnRoQGdtYWlsLmNvbTsgZ3JlZ29yeS5jbGVtZW50QGJvb3RsaW4u
Y29tOyBhbmRyZXdAbHVubi5jaDsgcm9iaCtkdEBrZXJuZWwub3JnOyBtd0BzZW1paGFsZi5jb207
IGphekBzZW1paGFsZi5jb207IEtvc3R5YSBQb3JvdGNoa2luIDxrb3N0YXBAbWFydmVsbC5jb20+
OyBOYWRhdiBIYWtsYWkgPG5hZGF2aEBtYXJ2ZWxsLmNvbT47IFN0ZWZhbiBDaHVsc2tpIDxzdGVm
YW5jQG1hcnZlbGwuY29tPjsgT2ZlciBIZWlmZXR6IDxvZmVyaEBtYXJ2ZWxsLmNvbT47IEJlbiBQ
ZWxlZCA8YnBlbGVkQG1hcnZlbGwuY29tPg0KU3ViamVjdDogW+KAnVBBVENI4oCdIDAvNV0gQXN5
bmNocm9ub3VzIGxpbmtkb3duIHJlY292ZXJ5DQoNCkZyb206IEJlbiBQZWxlZCA8YnBlbGVkQG1h
cnZlbGwuY29tPg0KDQpUaGUgZm9sbG93aW5nIHBhdGNoZXMgaW1wbGVtZW50IHRoZSByZXF1aXJl
ZCBwcm9jZWR1cmUgdG8gaGFuZGxlIGFuZCByZWNvdmVyIGZyb20gYXN5bmNocm9ub3VzIFBDSUUg
bGluayBkb3duIGV2ZW50cyBvbiBBcm1hZGEgU29Dcy4NCg0KVGhlIHByb2NlZHVyZSBpcyBkZWZp
bmVkIGFzIHRoZSBmb2xsb3dpbmc6DQoxKSBQcmV2ZW50IG5ldyBhY2Nlc3MgdG8gdGhlIFBDSS1F
IEkvRiBieSBkaXNhYmxpbmcgdGhlIExUU1NNDQoyKSBGbHVzaCBhbGwgcGVuZGluZyB0cmFuc2Fj
dGlvbi9hY2Nlc3MgdG8gdGhlIFBDSS1FIEkvRg0KMykgSFcgcmVzZXQgdGhlIFBDSUUgZW5kIHBv
aW50IGRldmljZSAoYmFzZWQgb24gYm9hcmQgc3VwcG9ydCkNCjQpIFJlc2V0IHRoZSBQQ0lFIE1B
Qw0KNSkgUmVpbml0aWFsaXplIHRoZSBQQ0lFIHJvb3QgY29tcGxleCBhbmQgZW5hYmxlIHRoZSBM
VFNTTQ0KDQpUaGUgZXhlY3V0aW9uIG9mIHRoaXMgcHJvY2VkdXJlIGlzIHRyaWdnZXJlZCBieSB0
aGUgUENJRSBSU1RfTElOS19ET1dOIGludGVycnVwdA0KDQpCZW4gUGVsZWQgKDUpOg0KICBQQ0k6
IGFybWFkYThrOiBEaXNhYmxlIExUU1NNIG9uIGxpbmsgZG93biBpbnRlcnJ1cHRzDQogIFBDSTog
YXJtYWRhOGs6IEFkZCBsaW5rLWRvd24gaGFuZGxlDQogIFBDSTogYXJtYWRhOGs6IGFkZCBkZXZp
Y2UgcmVzZXQgdG8gbGluay1kb3duIGhhbmRsZQ0KICBkdC1iaW5kaW5nczogcGNpOiBhZGQgc3lz
dGVtIGNvbnRyb2xsZXIgYW5kIE1BQyByZXNldCBiaXQgdG8gICAgDQogICAgQXJtYWRhIDdLLzhL
IGNvbnRyb2xsZXIgYmluZGluZ3MNCiAgYXJtNjQ6IGR0czogbWFydmVsbDogYWRkIHBjaWUgbWFj
IHJlc2V0IHRvIHBjaWUNCg0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
cGNpLWFybWFkYThrLnR4dCB8ICAgNiArDQogYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS1jcDExeC5kdHNpICAgICAgICAgIHwgICA3ICsrDQogZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1hcm1hZGE4ay5jICAgICAgICAgICAgIHwgMTI2ICsrKysrKysrKysrKysrKysr
KysrDQogMyBmaWxlcyBjaGFuZ2VkLCAxMzkgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuNy40DQoN
Cg==
