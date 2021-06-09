Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FCE3A1F1E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFIVmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 17:42:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:46202 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhFIVmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 17:42:13 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159LXMva028055;
        Wed, 9 Jun 2021 14:40:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=HfXgEHU3XcFa690U2JEyzGOt4FWOeDBjsXblTIuOMYE=;
 b=WoHAxTIybC2zAloAD6ShlrX1BTHu0vIvaaEFMx5AqEnCvWAysX6uJzb6Qm5jSRbGFP/M
 lkb+T7vv6Q5RHdLTAciPTH/ayBQzMreDPSsvpRmTxN8txXFJc/syMaRDOwA3G1wz/uof
 rhxUu6N9Zu3YFk9MAvQsAazgZJwG9+KvxPA766UT8fVit29lx/gn/o1jsEpx5q3vSjr7
 WQrOQgIj7A+b3W2OBZgJXRS/jr5ZqmQOUMcInN2tCJfPkDbwu1LlHyDUYPAj5diPpvEA
 8klVTJjGGN1Oc7Ykv9jWeGb6F0FDjK2A6Mt84wPIHgzCrdhNfSV8Pzce6mSDKXmFyaWC Uw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3927wb48sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 14:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfj2xIgrAp43Z/Mzgq+pSvxPjC4CX7MQbKuguRi/ddTWgBTblG88OpDcmKKwKMnBilncKHx1Mkqt2r47LvKpG0KpA60fWqPLQOnsvZWV2UZ7fT3PC3gOJvj1C7W0CYxQCeEwRNH1RSkHgQ9DDEa7qiu8aFt9EjYDEhOs3//ldgSbifdK4l3zSQmzGyxEvKUC/58l3J+8BjGrqHJoDyV/2syGzXNRAIjzgvemIJ97qFqhrvNp/P7SDFrZSQ1vTdO3At8mOgU3+Ugjh5//nTfquvXnl8mf2+ZA+fTGHlB3vBddv4nnM+tE5Ew0MOFoSkNy4DPGE3nzArldYgaOESTtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfXgEHU3XcFa690U2JEyzGOt4FWOeDBjsXblTIuOMYE=;
 b=hPzLcw0VjO7wLyagvsit5XSnE2eUgLudCjDfOky6qfK4tmls/pb591tgMtoKJkkqjsqyNGfmhLyrsnM7T7Uy5uLwztvGupb8xfMcdS0rmMEwcj18McdF9g/2LIQmDWohGQvvDEZ2njTv9sSW+wfftxUcbklSSdLM2btCaAtsNsBglWXqhvE7ssF9OvpWFaN3yMwr35jg8odcDvqgCHyktEHjecII8rD8Xnb+yM8U+bCGf+E7jfjf+DbSSFoBqHCFTuFyCA1G1EuJ4mneqU8ZY/ecVeDvXLfwe773TGjRFqFwrLB+IVb90KHmg0nStq4Hbchd0gulAZnSEB1pd8LQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 9 Jun
 2021 21:40:04 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::bdbb:69ac:63f9:fc33]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::bdbb:69ac:63f9:fc33%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 21:40:04 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 8/8] PCI: Change the type of probe argument in reset
 functions
Thread-Topic: [PATCH v7 8/8] PCI: Change the type of probe argument in reset
 functions
Thread-Index: AQHXXCoXTRiN43qBAkGGaxdMjxiTOKr0ejaA
Date:   Wed, 9 Jun 2021 21:40:03 +0000
Message-ID: <20210525190757.GA25307@raphael-debian-dev>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-9-ameynarkhede03@gmail.com>
In-Reply-To: <20210608054857.18963-9-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.193.215.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d92ced2-972d-45ce-8b37-08d92b8f246a
x-ms-traffictypediagnostic: SA2PR02MB7561:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR02MB7561CE6B97AB1F99331A7478EA369@SA2PR02MB7561.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7KqeYqx/bhs2LBOC1BvxNouI9fqXz4QxbvmnqXvd+/jQoGU+YCyqMPcknqpQXVm9k12xVjcOTCS8mADSqqndLAGpm0QvxVlx8HyLZRgYPZQyWeAODP9L8j4IfNqBQ90zr4i/0uHv2587tqzME2UUhwiQvXiV57AXoUGl64LGK7iDYxKPVr55/xUh18nEGBkhGChqps3sBdzkmdJAfk7vH3ai+hx+GN/2SNAW3KiZ31zGL9Gj37EXRA1ja75r8ooun+mJPki+UBP2wDZwTY4mACmG6EcZ/NqUrx586CLdvOhyTEfyfImCw6mVApqY/tm21/bVg+3UP0iDeTdl6rXE5TGtdb5DJ42TYJDUABmihfwkjYRF/cpJg4ChsmR/Nfy+39vEOXUr7zg7x+BW8xJALirAhi7H9h2deAf0OYnAm9vkD77HRT/2LMg/6b4H+mrawxnsKdZ2efggRdVxsaJ18bAGlbPJS9BQ0NoLeB2boz5DQHAscr4LwBirCnNdwcGrJx2nvpMA/uV0ckl9KFROsm/WH6q7FqGv9Q2j5vMQ/eLGxht8P4m7LA7Sq5Lm8Ku/EBk4+oqpGFe+Alue+iJ/afnolMNHbYLUT/kXuQCDWPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(136003)(396003)(366004)(346002)(39850400004)(478600001)(8936002)(2906002)(66446008)(76116006)(66476007)(66556008)(8676002)(64756008)(54906003)(6916009)(71200400001)(5660300002)(122000001)(1076003)(6512007)(316002)(186003)(4326008)(6486002)(26005)(33656002)(9686003)(86362001)(6506007)(44832011)(33716001)(7416002)(83380400001)(38100700002)(66946007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhsc2NKOHA0UCt5OHZaM25ZSWZmTEgxT2crNzU0R2tRdTRiWmdMdWl5c2ZN?=
 =?utf-8?B?NGdMcm9JMjkvZExxNS9VbllCZ044cENWYzJIZEdYVUptRUU3S3ZHVFVsUlpk?=
 =?utf-8?B?MWRqN2lmY2pFbTZTNmUyZWpMZEw1bGp5cE9ZQXVoeWk2eFNZS29pU2llTTdt?=
 =?utf-8?B?SVdGbFNzTTY4UE1jNFFvMzNaZUtzMTdwaDMxMzFmSFlWbzZRMjV0U1d0MWVz?=
 =?utf-8?B?OTVHeDRHMFNYZEJhdzZJWEJOTlhNMnJQbzM5NjdtNXVNSFkvM244aHRKNmNq?=
 =?utf-8?B?Z1lPc0Nyd2EySmFrS29qNjBicGtibzFWSHRkNEJ5eXFQSGlaVmlTZTY3bEIz?=
 =?utf-8?B?bkJNM2o5VCtmb3lVMC9CejZTdDIzMzZCN3RTTlJreVozQmVJZXB4VXVocVRi?=
 =?utf-8?B?dUdVaDBqeFZuRmhpR1FMVjdlcXlIdUYxeWI5SVVucVp3K2s5NTR1ekEwbG4z?=
 =?utf-8?B?Qy9FS2JhK2RhOS84Z3FxbGhQT1BuQWFZN1VDQ1NGc0tYR3RNLzZ1cWFFeFJU?=
 =?utf-8?B?M3dzQWJkbDU2ZSt1WkVoWThsZ2pvRkRYVmFDeFk4d1NWdE1WOHk5VXJJR2tG?=
 =?utf-8?B?T1VzVHl6WCtncktJcUdwbU1FbDJWdXgvd0ZQc1BRcnZvdWdESlBtYmlpUUVs?=
 =?utf-8?B?ZjkraUxkSkhCZHJWZkRnRjhaZVpPQktrM3dPNGlCL1d5K0RObFBwTmhueVJm?=
 =?utf-8?B?cmVaa1FYVzF3L0dQZi9jWWhzTjVRZ1p0djhMcHVpMkxRVFAwdHR4R2Q1bTE3?=
 =?utf-8?B?WFdyMjFvQlBHZ3lqTFlOaEJCRmRLQUI4UzFoYjZtdkFvT21lYWlXTnRPbUw0?=
 =?utf-8?B?Zk1GRjRFRHprUEVQeGtOQWQ3NE9NT2p3RmYzdkxhRFNDQ0Y4S0ZsemNQWnYx?=
 =?utf-8?B?KzZZZFZYOWhFVDhYQ29tQzBWb1RZYXRUZ3p6M29RaE44bitPTll1NlJVTmlG?=
 =?utf-8?B?bnltNGNWZlZ0amdaNDhtWk14a29QRFZIQml6WXYzZCtkR3VDaDc2TjRRU01V?=
 =?utf-8?B?UkcwUlBvS21mUTF3eWNjS0hGWHZKQmc0a3JZcE16elNOTWxWTU1NcU51RkFY?=
 =?utf-8?B?TktjeVQ5L0trT2wzZWxPWWRZMENsMmhZSzhEZVc4aExPRm9zVTFnUm1lZEh4?=
 =?utf-8?B?dnJpeUo2Q0NSRTdoeU5Hd0diSWlzTXFTcWk5TEkxZ0pLQ3dLQ2V2aWVndmxN?=
 =?utf-8?B?QzlabEZVL0lZWWovMEJPUm5DTnkyd1pVc2YyZGVoR1B2U0hxdGtwekxiZjRk?=
 =?utf-8?B?djF3a0ZOVjRYcDQwVStnVVYreE90YkRhR3hHVWZvQ1c0eVoyTUs1TFU4bURS?=
 =?utf-8?B?bmhiM0dqaW45aDllWjRPM1FXK0g0amZsS3dmSis0cWRrL2V5ZUNPRGtjaVI2?=
 =?utf-8?B?NGJYNjduZWFqaUc2K2xlSDBIOTFuSnd4aHpORGljQ2hDQUcrLzhaYVZSSXBu?=
 =?utf-8?B?V2dkdjFYOHRtNm5sZERhTWFHdXNBQjkvYWVUeHZ6NHZXaTFzUHEvdldkdGcv?=
 =?utf-8?B?RmxPQ0I4NURwZ04rbVAwYm5mWm9LQ21UYmw0WmE4MG54cThjS0hBQ2UvckJh?=
 =?utf-8?B?SnhQMExseUdiaDdZa1QxN2VsR3VmVDM1aE9MOTg2SjkzTis0Z2JTYzc1Q1JZ?=
 =?utf-8?B?Y1AwakR3bW9FN2MwYmVrOE5sUXVwdys3dnlrREYzZU5tKy9uYXlRR0lkL3pX?=
 =?utf-8?B?VzFXRU5udVVNR2RSMGNDR3haYXRXOUV4QXpqemdncVR6TVRmVEVLOThEdzk1?=
 =?utf-8?Q?H3mnlty5te4iAHhml11puyy82sdBEEqrik7yqjO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB8B7B63F73B8B478C33B879E575EC74@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d92ced2-972d-45ce-8b37-08d92b8f246a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 21:40:03.9726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hJpEYJk6C1ZhTJVuarjzUFwihue7x4eOaLppl0YzLa3f2QG7yDtG97DihehfNWKEpOWaj9AEyz+APnCi2PFxwiVUwYVaMjI2zAZSU/FkXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-ORIG-GUID: y8_VvIh2Yn5PB0B4W9A6nUBUg2YrkONm
X-Proofpoint-GUID: y8_VvIh2Yn5PB0B4W9A6nUBUg2YrkONm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCBKdW4gMDgsIDIwMjEgYXQgMTE6MTg6NTdBTSArMDUzMCwgQW1leSBOYXJraGVkZSB3
cm90ZToNCj4gSW50cm9kdWNlIGEgbmV3IGVudW0gcGNpX3Jlc2V0X21vZGVfdCB0byBtYWtlIHRo
ZSBjb250ZXh0IG9mIHByb2JlIGFyZ3VtZW50DQo+IGluIHJlc2V0IGZ1bmN0aW9ucyBjbGVhciBh
bmQgdGhlIGNvZGUgZWFzaWVyIHRvIHJlYWQuDQo+IENoYW5nZSB0aGUgdHlwZSBvZiBwcm9iZSBh
cmd1bWVudCBpbiBmdW5jdGlvbnMgd2hpY2ggaW1wbGVtZW50IHJlc2V0DQo+IG1ldGhvZHMgZnJv
bSBpbnQgdG8gcGNpX3Jlc2V0X21vZGVfdCB0byBtYWtlIHRoZSBpbnRlbnQgY2xlYXIuDQo+IA0K
PiBBZGQgYSBuZXcgbGluZSBpbiByZXR1cm4gc3RhdGVtZW50IG9mIHBjaV9yZXNldF9idXNfZnVu
Y3Rpb24oKS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxp
YW1zb25AcmVkaGF0LmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBLcnp5c3p0b2YgV2lsY3p5xYRza2kg
PGt3QGxpbnV4LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW1leSBOYXJraGVkZSA8YW1leW5hcmto
ZWRlMDNAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUmFwaGFlbCBOb3J3aXR6IDxyYXBoYWVs
Lm5vcndpdHpAbnV0YW5peC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2NyeXB0by9jYXZpdW0v
bml0cm94L25pdHJveF9tYWluLmMgICAgfCAgMiArLQ0KPiAgLi4uL2V0aGVybmV0L2Nhdml1bS9s
aXF1aWRpby9saW9fdmZfbWFpbi5jICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvcGNpL2hvdHBsdWcv
cGNpZWhwLmggICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL3BjaS9ob3RwbHVn
L3BjaWVocF9ocGMuYyAgICAgICAgICAgICAgfCAgNCArLQ0KPiAgZHJpdmVycy9wY2kvcGNpLWFj
cGkuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMTAgKystDQo+ICBkcml2ZXJzL3BjaS9wY2ku
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA4NSArKysrKysrKysrKystLS0tLS0tDQo+
ICBkcml2ZXJzL3BjaS9wY2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMiArLS0N
Cj4gIGRyaXZlcnMvcGNpL3BjaWUvYWVyLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+ICBkcml2ZXJzL3BjaS9xdWlya3MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzNyAr
KysrLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9wY2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDggKy0NCj4gIGluY2x1ZGUvbGludXgvcGNpX2hvdHBsdWcuaCAgICAgICAgICAgICAgICAg
ICB8ICAyICstDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygrKSwgNjUgZGVs
ZXRpb25zKC0pDQog
