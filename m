Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65735E637
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbhDMSWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:22:51 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:43376 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347617AbhDMSWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 14:22:47 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DILrPV024591;
        Tue, 13 Apr 2021 14:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=QF1UAHjHl35iTWRnWVofBM2Bta6+/0zLycLcvk4A2aU=;
 b=w9V17P3eenpcXwmxPgJ10p9Hh+87B9WXsppCNlQd195VPoWAo6VVu3UsaqEXP93geXml
 A+oGfI6TvcJue0+9h59qQs3sppxeWGMFxrLhW9K0ARLIINEDbJj/K8B1i06nHGG7wRVm
 5NGLOh2DRxgeg5iHJxWxsnh5BudMQM9CDb+VXMoDi53AGLCCNy9vrTwSSjdjlBFtK77/
 9y9gq6I2yLpSUCSIZSs6G+O3vqDgu5sUKHlh8Azm+pIl98nX5+9JLBQL9YLcG/60S8V9
 ttr2VW2UYjnM+M5J6X6Zso8OBoQL54gxrIoJSiyfOpBSrVFQbpZmvYJ4VsgaGbB3g/xG jQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 37vun5mhqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 14:22:25 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DH9DlZ020597;
        Tue, 13 Apr 2021 14:22:25 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-00154901.pphosted.com with ESMTP id 37usp3nupr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpJZKC9VuBOw3qSxV+e3MMt3Wk6ZJTx7as1/+T1toIQdkHRHiY/b4gnDhVfucx5+f3HRgjOHNCLwRYOrMQLEpMpWP+7RAHuW/X772iJYak+NnHp5h5VRoky3zdBTCHeeb8q7+fqiV+QKvYzC/Ir8DUiggylNijHcDk13qmo+kyGR+8fqK0uJ6hUg6RLyYOeooShUiaJo8k5PFQJTK8tmKf2KDXk0Lz4KO443gcjmPd/TBfgOqx4vJaq6WC7MpkVD0nHRG5UAHNebMm+wsYal3iQ9WUdrpH9wCdXoUtk04c39pyqgL/hCGXJVqRPB+KTaI7Ur+jxhYzQCi3H6via4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF1UAHjHl35iTWRnWVofBM2Bta6+/0zLycLcvk4A2aU=;
 b=A2b5LLGgUHI1Lpx5UA7HzdZzBjz+Pl6Xzeh3v44h2AP2jr+t+gWON3fzqsaePN9Ym4mAJKYKV0yfoGmrsXLwBsd9t7ocAkRp7FQlADfNYE9nTSpdipZ3+2US2E7t3OPQ0tefTj9ZULDnYXaA0Tc/3CobGKxmKqpnAfOQ78+sUjscbzkJyQNojNFwixiFV2Q1f71EdrbJX9b8ST+bv0XNDveS1/1hSFNSRLtPKmgT6fB9tbzJAdDDD1CoSDAR6GrJgj29lk7Wy1No3+ywErE7ahUfALb6sHdZM4r4O80GfezIoC7WVvKXJ0P6JRs2LK5TzA3iZ7o7JhsJLK603CqpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB4711.namprd19.prod.outlook.com (2603:10b6:a03:9b::15)
 by BY5PR19MB3812.namprd19.prod.outlook.com (2603:10b6:a03:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 18:22:23 +0000
Received: from BYAPR19MB4711.namprd19.prod.outlook.com
 ([fe80::ec13:7aef:e53f:2f99]) by BYAPR19MB4711.namprd19.prod.outlook.com
 ([fe80::ec13:7aef:e53f:2f99%2]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:22:22 +0000
From:   "K, Narendra" <Narendra.K@dell.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
CC:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "K, Narendra" <Narendra.K@dell.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSCAwLzFdIFVzZSBvZiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8=?=
 =?utf-8?B?4oCmL2luZGV4IGZvciBub24tU01CSU9TIHBsYXRmb3Jtcw==?=
Thread-Topic: =?utf-8?B?W1BBVENIIDAvMV0gVXNlIG9mIC9zeXMvYnVzL3BjaS9kZXZpY2VzL+KApi9p?=
 =?utf-8?Q?ndex_for_non-SMBIOS_platforms?=
Thread-Index: AQHXL6QKk7fts0IlSUyTkZlYCaJGvqqyudsg
Date:   Tue, 13 Apr 2021 18:22:22 +0000
Message-ID: <BYAPR19MB4711D0F78D778178ADCACC64814F9@BYAPR19MB4711.namprd19.prod.outlook.com>
References: <20210412135905.1434249-1-schnelle@linux.ibm.com>
In-Reply-To: <20210412135905.1434249-1-schnelle@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Enabled=True;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Owner=Narendra_K@Dell.com;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_SetDate=2021-04-13T18:08:06.9223385Z;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Name=Internal Use;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_ActionId=aa3a2b56-bace-4fa7-977b-b16225f0996d;
 MSIP_Label_7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90_Extended_MSFT_Method=Manual;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Enabled=True;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Owner=Narendra_K@Dell.com;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_SetDate=2021-04-13T18:08:06.9223385Z;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Name=No Visual Marking;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_ActionId=aa3a2b56-bace-4fa7-977b-b16225f0996d;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Parent=7de70ee2-0cb4-4d60-aee5-75ef2c4c8a90;
 MSIP_Label_c6e0e3e8-8921-4906-b77b-3374d4e05132_Extended_MSFT_Method=Manual
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [157.46.167.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47454121-cc09-4648-1742-08d8fea9151b
x-ms-traffictypediagnostic: BY5PR19MB3812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB38129EE5FD2C14EB9AD8629A814F9@BY5PR19MB3812.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pn7wvsBhdDhqnwfMJU5c2sMlTRF05RrY4l6I1w4LpnPZAKAMus2qgh/TH43NNNgaw/LFrTM6Oq7DbLbliCFHA40TNu77azTBsPQYFsis7oGykufk5B5bv+q1XH9i1hVGFa6i2QHynp3HzmSykFSK9E1kbA0MAkqtM02dC/KspwYEGPv8FdBg4VCRBdqqfs6XZ848Z+cAJxJYSiQb/89g0VycQqzIxPdXwWJvhzMYA9nMFGD7K27k09cq08Sc9mBsqxXBedI9Isx3oH/C8ul8stHjKMAOui/hcDwbkX2Zzhj9XjQvZDzXlEs8L0AOQzf32tMetcukzYixLbNysmlGiiXAnafoZPlsI54JjEIQxf3dM+V9JqK+DZ7qkVeCJDZ3tu+2TGvyrqQxZUyNIypmvok+qL9+YoX8u2XP+4Ld16KQr45KpSB1eTNyms5BM/pAz30Swr4i39VU7VZawaD3CcxuFeocAX+L/JyWcrucGHVMesSadVoiFlJ9huQVRB6hrPR3PepnsIV7PSpN/xE0kRtCGr8zUChP4g76F2lho7gyUNCNsIbWd7j1+bq4qhWWuwnDC2guZBUD6yfzW7MTGJWZ4EzxLBN4TJq2MWIvxG8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR19MB4711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(26005)(4326008)(6506007)(7696005)(33656002)(2906002)(53546011)(9686003)(107886003)(52536014)(38100700002)(6916009)(186003)(66476007)(64756008)(66556008)(66946007)(786003)(316002)(54906003)(76116006)(66446008)(478600001)(71200400001)(86362001)(55016002)(5660300002)(83380400001)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVlCSzU4UmJyOHhrOFcwSFpVTzZuc2NNNFcxbkhmNDZZamVCangvTWRSd3py?=
 =?utf-8?B?cFVRM2dFU2VTVEVqcEVCOUxJMmIybmVOTGRKbEFTbTFQbW5Ld1VQMDJyV3l4?=
 =?utf-8?B?aXpKR1NBRWlTS1pRbkdIdG1OWjQrc2hqRGZWdFg2UVZLcEt5SFZ3dm4rdENS?=
 =?utf-8?B?L0FLbnR4Rzl5c2RnUk1tT3FzRXpzd3RydTJmT3NiZENtL3dJN2IxSmFwMDVG?=
 =?utf-8?B?Q3BFTWVzQ3RzZGRhWGZuNWFyRFJJdThzanBIOFV4VVVnZXE0Qm5lcTh2ZFBY?=
 =?utf-8?B?K2xCWUo0K1pCSkVaNDlJUlVhY2RXNUJNS0Vmc3UyQW83NTRrK0pvUERtdXY3?=
 =?utf-8?B?cU5WUjBRdjF0WDVMUGZpQlRTR3dBWUt4Unp6OGtNRCtZMklEc25zazI0aith?=
 =?utf-8?B?S3NNSEkzR2ZuZnloY3dIeXl0WUZHOFI4RW9OdEtoZEx1aGNlVUY5RWx5bXNH?=
 =?utf-8?B?MzYxa0J5VmJVUjQ3dmVrZmgveXY4alZKc2pBSzdMR3Blbi8va3RpUlZ0VE5H?=
 =?utf-8?B?YnAvZ0Q5NFhJdUt2Z1NIWkQwNFRPK05qanB2NUQvcnkxcm1WV2VVQTFmbTJ2?=
 =?utf-8?B?c1J5cjhRNDRCbW9JYjd0TllzSm91eUQ4S1RrR0RoWGwreGc0SGpNdkpKUGxR?=
 =?utf-8?B?MzdSM2M1TkNFZlFzQTFUcG1FV0xrZVRhT2NCeE1WdjU0L3g0bHJiWGRpK0Zq?=
 =?utf-8?B?eU1IWmhuc0NhNTRUZmhFSEhlTmhOQnhPZVNYcURhVE5rRlZsSS83S1ljMmlZ?=
 =?utf-8?B?TTgvQ1UweU9DcHFJNWpTMWxtQ3lwK0tqaWpxQ24vbGh2SEN0OG9ENHdjazVy?=
 =?utf-8?B?bGxnOVlPQkJ1Z0c4aUlTdWkwbENQb3RkWjhSQzNFK284Y0kxVHpvZDErcG84?=
 =?utf-8?B?ZFY1dm96ZFoza2ZleGl1Tk9GVVVpT2Z6NHFrNEppdTJIakNtK3pKNUFJelVG?=
 =?utf-8?B?SVhQVW1YVlpad0VSMjQ4ZVZWVG43V0ZmSGxZUjdZM2NwMXU3eVNjQTRxQi9Y?=
 =?utf-8?B?M3h6UnFDL2JZMmJKc3UxWm5EYWNrYjBUMTZZSTZsVnp3anBQdHhGVWlvM2tG?=
 =?utf-8?B?UXZ6UXkrekpscFBjaGt2bVFKZHJ4cm4wOVlCWTJEQUZBMWNySUx3WG5PeDBl?=
 =?utf-8?B?QXE1RCtlT0tDUXhXSUQ0RWlFOHB3ZlVwa2tRbmdrRS9yY05MVDI2akhHN0Jj?=
 =?utf-8?B?QzM0MVZKcXAxcnkxaC9mRU9ac0ZWSkFxQ0syKzVWOG9kdzNnUktaUDhOS3dS?=
 =?utf-8?B?U0VWY0lRWXZ0NTluWHUvMzNFWTlTNkh4eHNyRWxwcFRNRFYzSkdFVEF1d3Ax?=
 =?utf-8?B?NTNWMFQ3QUcxQ0ZWeTE4TDdyZExWcTZQNk0xRy8yZGVmNTZoLzlvNW1zWmdO?=
 =?utf-8?B?M01WeWFLcS9LRzlJWjNyei80QlNVTGhXTzlkU1dJcSt4ekVLbGlSc05ZSmg1?=
 =?utf-8?B?ZXZGS1lRVGtrd2tUdmxabDRxWHc4OHZTTVVrbHR1Z1I5MjU4OUw0dmxpNVQ1?=
 =?utf-8?B?UFlhUVpwR0FzZ1pqL3NuWE45cXc2NEliZXZaQjlldU5zQnZUOGlLQjMwVm05?=
 =?utf-8?B?RTB3dTVRQXIwS1RoaUQrZnhpZzFOMWc4bjJ5bHoyZGlieHFEb2luaFgwU0Fp?=
 =?utf-8?B?WEVMNnF6SnAxM2QxM29OOEZHYWJhSmZEL0Y0WTVsdjEzYmQ2dlB4VEJzMld1?=
 =?utf-8?B?Tjl1Q0ovbDF0NzV3VzZQZmVhSytlV29KSE16OXZ0WWNZS0UwNjAzcDZPaGl1?=
 =?utf-8?Q?9ooLejyEuYaRP4gA2wWNcLHCJLHC/ySRSXu0fS2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB4711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47454121-cc09-4648-1742-08d8fea9151b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 18:22:22.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh/4Swu+Jtg97D7xiRqZK2fC64xH2yKA3mjWqTognUv+0oR5rrDCt6cvlmxevWYHrYZEhgBUS/Q1Ufo8HyO2YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_01:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130111
X-Proofpoint-ORIG-GUID: tDyZRriPoG9DnqGyeGqSx1sB8kmNCyRY
X-Proofpoint-GUID: tDyZRriPoG9DnqGyeGqSx1sB8kmNCyRY
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130124
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgU2NobmVsbGUgPHNj
aG5lbGxlQGxpbnV4LmlibS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTIsIDIwMjEgNzoy
OSBQTQ0KPiBUbzogSywgTmFyZW5kcmENCj4gQ2M6IFZpa3RvciBNaWhhamxvdnNraTsgU3RlZmFu
IFJhc3BsOyBQZXRlciBPYmVycGFybGVpdGVyOyBsaW51eC0NCj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAw
LzFdIFVzZSBvZiAvc3lzL2J1cy9wY2kvZGV2aWNlcy/igKYvaW5kZXggZm9yIG5vbi1TTUJJT1MN
Cj4gcGxhdGZvcm1zDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gSGkgTmFyZW5k
cmEsIEhpIEFsbCwNCj4gDQo+IEFjY29yZGluZyB0byBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLWJ1cy1wY2kgeW91IGFyZSByZXNwb25zaWJsZSBmb3INCj4gdGhlIGluZGV4IGRldmlj
ZSBhdHRyaWJ1dGUgdGhhdCBpcyB1c2VkIGJ5IHN5c3RlbWQgdG8gY3JlYXRlIG5ldHdvcmsgaW50
ZXJmYWNlDQo+IG5hbWVzLg0KPiANCj4gTm93IHdlIHdvdWxkIGxpa2UgdG8gcmV1c2UgdGhpcyBh
dHRyaWJ1dGUgZm9yIGZpcm13YXJlIHByb3ZpZGVkIFBDSSBkZXZpY2UNCj4gaW5kZXggbnVtYmVy
cyBvbiB0aGUgczM5MCBhcmNoaXRlY3R1cmUgd2hpY2ggZG9lc24ndCBoYXZlIFNNQklPUy9ETUkg
bm9yDQo+IEFDUEkuIEFsbCBjb2RlIGNoYW5nZXMgYXJlIHdpdGhpbiBvdXIgYXJjaGl0ZWN0dXJl
IHNwZWNpZmljIGNvZGUgYnV0IEknZCBsaWtlIHRvDQo+IGdldCBzb21lIEFja3MgZm9yIHRoaXMg
cmV1c2UuIEkndmUgc2VudCBhbiBSRkMgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIG9uIDE1dGggb2YN
Cj4gTWFyY2ggd2l0aCB0aGUgc3ViamVjdDoNCj4gDQo+ICAgIHMzOTAvcGNpOiBleHBvc2UgYSBQ
Q0kgZGV2aWNlJ3MgVUlEIGFzIGl0cyBpbmRleA0KPiANCj4gYnV0IGdvdCBubyByZXNwb25zZS4g
DQoNCkhpIE5pa2xhcywNCg0KU29ycnksIEkgbWlzc2VkIHJlc3BvbmRpbmcgdG8gdGhlIFJGQyBz
ZW50IGVhcmxpZXIuICANCg0KPiBXb3VsZCBpdCBiZSBva2F5IHRvIHJlLXVzZSB0aGlzIGF0dHJp
YnV0ZSBmb3IgZXNzZW50aWFsbHkNCj4gdGhlIHNhbWUgcHVycG9zZSBidXQgd2l0aCBpbmRleCBu
dW1iZXJzIHByb3ZpZGVkIGJ5IGEgZGlmZmVyZW50IHBsYXRmb3JtDQo+IG1lY2hhbmlzbT8gDQoN
Ckkgd2lsbCBnbyB0aHJvdWdoIHRoZSByZXF1ZXN0IGFib3ZlIGFuZCBwcm92aWRlIGNvbW1lbnRz
IGluIHR3byBvciB0aHJlZSBkYXlzLg0KIA0KV2l0aCByZWdhcmRzLA0KTmFyZW5kcmEgSw0KDQo=
