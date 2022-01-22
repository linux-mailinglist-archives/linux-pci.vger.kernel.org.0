Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4207E496D89
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiAVTJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jan 2022 14:09:13 -0500
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:49344
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234766AbiAVTJM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jan 2022 14:09:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHycadUMDug7nkzV4icXVtxnV/GVSBybvcLhCT8DIiKXjwpnem8WsRLmdgS2ClxK3xAnupGp5YCwoWA4fTN0swU+z1L0UXULuVOcHx2SDfwmsThAK/zwWBJzoW5V2D51v3VtO4oRhSereKH6qpaTOSfWrq9rEmPm9qaY/GimKltgZ4TmwvpIqJnCcpfOyT7Z+xgpWTuGi6snFa7GMvpM6KxXdBlLfFXlOA1a2lJo2YhgGx6U+3WzV7QbAJrlK/ykoisZMl/KEhANgttqOloAaiXBCRCELLkvmm60B2OhHvtyjiB4Z1ZntGrpI40hgpyrZm065Vi1Q6/McFzZ0FgaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9l3wDNaRs0IrZvbTSq+23ySfGduxXR6uUViAPqXECs=;
 b=JfcEN4yQSTjiZg/wFWKMPEd+kcX8dWyqVaVRns/iX2MzooQL5+Pmpwhq16O8WiwOOAukWrwNKlSquqaz3L5o9J2bZi3L8FWxvzQtjD7TjiAWvX3Q/f4va4MQpaQl0sOhKalKPU/p6FRO4EiSk/nkxklat2r+0gYeHpcZ1z+kDtT0wB0gtLiPrbb/Zy6U1l2jfKhLrGwQvWrtNKf9ygUWwORTmgF1/1abUZK1riNlKvsyB7YomeYThWOn7CtH5aMmLwKP7HVVDFqw3MQd2FauztbeiT4bLmzxi6NnbuPj9p0u67JCfvVKxvpHo3RFiFY4z+jBLLyUihd9woNQHorMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9l3wDNaRs0IrZvbTSq+23ySfGduxXR6uUViAPqXECs=;
 b=q+/smBfTrdK3InJ5qcvdZP8xvIB+ezTLhLmLBJwzmWOifyW541s99ry1Hj3xjMIZtobya5Z/VKzPnQgbpQJpwTnSO1QmtAVgbjmSvdgL+LSTPVsuBdNKw+P0TiJVmVjZbsizPUhR+yFjlW30dDoMuajgJYp1S2dT0r4/Sw8/Ls4=
Received: from PH0PR05MB8510.namprd05.prod.outlook.com (2603:10b6:510:a7::23)
 by SN6PR05MB5805.namprd05.prod.outlook.com (2603:10b6:805:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.10; Sat, 22 Jan
 2022 19:09:10 +0000
Received: from PH0PR05MB8510.namprd05.prod.outlook.com
 ([fe80::5490:3d56:8317:5965]) by PH0PR05MB8510.namprd05.prod.outlook.com
 ([fe80::5490:3d56:8317:5965%4]) with mapi id 15.20.4909.014; Sat, 22 Jan 2022
 19:09:09 +0000
From:   Vikash Bansal <bvikas@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Topic: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Index: AQHYDI9PHjjBXmLhA0GwF8F8yaRAo6xrdBqAgAEWJICAAz/mAA==
Date:   Sat, 22 Jan 2022 19:09:09 +0000
Message-ID: <F4FA5791-E19A-4D6D-9EE7-705CEC174BA1@vmware.com>
References: <1642526161-22499-1-git-send-email-bvikas@vmware.com>
 <YekAgfkDgV6z6hYV@kroah.com>
 <195F50E8-2E4D-416B-A24A-4602321FABB7@vmware.com>
In-Reply-To: <195F50E8-2E4D-416B-A24A-4602321FABB7@vmware.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.56.21121100
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec46f1d8-8a4f-4520-eae5-08d9dddaab7e
x-ms-traffictypediagnostic: SN6PR05MB5805:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <SN6PR05MB580576AEB1B92B65E4B3085AAB5C9@SN6PR05MB5805.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sdopj+kJzbtYZzoNfebZPj+Gf+mMdvIpSG+NgS8HUR89FPDMeJy8MngrWR3QF/01cBUkREw1AUlLZ6EXCYnZFkDN0SI8k+ouAZ/UiUK/WHDQ6Shi/rSh7JqxbFW9WyNFw57DdCZltMQXsrpuAPSXa+ZX14ZrDShdklJUEEiVX5Q3g6T479EgrgKabakS7vtASwMbbaB+jPM8+lQFOqpCdKIhDmH4wcFPS4QH6Go33XVtqc/20VeEWQVmnkN3+2tqFo9XwmLauYzDeaYgpsp39mVZL1q05Jq/8XNhBgO4arYFbtPg1k9uj7/vl6fmeCemgIW/R9ByygB0WXImXRbOi+B447raRZyPvoC5U8Ie62jk3Hla8kvWJMHW3+chIhw8fNi5yjFKFEub0wojhWq+m2JVFti+NF6MUkqRfF7UldgAABuM+AMZN8UHDbFXlPX2YxouP0PlgiH3L6GAR41BoZUGJ/GenuGRsq7ChQZb9vROc7hYQ/5ahNzO4VFKBG3gbVyJpFF9w/IJPgsnii2RIwtrZRN+bLGDJg529iz0B19eWvLXflQzgJQByBPEiT9ZZz3WdcsHmNL7ZSgp5LVXtzgVPoBGqjh6gk6S5N+VDVqFko/q4Q1+k/YVm5Bi98YIdZnDvhw1QWoKn6RsmCVAnX8T6JrZi1MichefDK3z46ZpwX3QaV/cc0xmfOtcViwiaCrKj3v/0jsbQVQVVQ9l9oJIfl3KWBpeiLSTL3SXfRdWPtle0U/BfHH8rn40MzjkYuWb23S0ZtFfR8ijgZwlyYYCRxRgNMyKR4tn5PvQAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8510.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(6486002)(71200400001)(76116006)(66946007)(66446008)(8936002)(33656002)(66556008)(66476007)(64756008)(38070700005)(86362001)(316002)(91956017)(54906003)(6916009)(8676002)(4326008)(38100700002)(122000001)(508600001)(26005)(2616005)(83380400001)(186003)(36756003)(5660300002)(107886003)(6512007)(2906002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm1RRUMrYXNKUVl1dCtSeThTZmJzSDZ6bkhTTFh0U2pNNFlNTlFRUmI0Ni9F?=
 =?utf-8?B?ajVTYW5lMXcrQ0hYcXB4ZjIrem92cWhLRjI1K0dDNUlGS0lxYXZLdlpvK1hJ?=
 =?utf-8?B?b1lOYm4rdXRZaTkxTWdvNGkzUUI3a3RRWHBzRFBvVVZ2VDRXWGRwajB1UmdV?=
 =?utf-8?B?a1Q4RURUakpMZ0JqTTFsVE5BbjBHaGxBZWJ6SCtYNFNPeUtrQmM1dE1pSFIy?=
 =?utf-8?B?eFdMZEFmWHlROFNxd3doU0xSVHpGU3JhYW12ZVcwemRaRFEzcXY0SmVoMlVx?=
 =?utf-8?B?VG1RME5GRGpRZjJpSzJUck1MZ3FiV2FZRUREcDdaeG8rQjBxTFFMc3BCYWFY?=
 =?utf-8?B?T0lZYTQ4d3k0d0x3dXJ4RUJuVzJPc0xtWGpxVDl5NWNIdUtVQyt3NE9qNXlv?=
 =?utf-8?B?WDdhSEZaekRscXc4NWxvUlEyVlY2dU1WZ2E2WnI0Vlk4aW1LdllxZ3BQZEVC?=
 =?utf-8?B?Z2FQRmd1VzRSaU9iWVkvZ1FVbnNHZmhxSTZRZkthdVBwKzNHcWl6dmxESGtj?=
 =?utf-8?B?RzNXbEJScTBaUy9semg2S2I1NG1ML1BIbTJ6MGFzV3pmeWlBL0F5OU1WNk1m?=
 =?utf-8?B?MUlsNTJaUmZjTkllQWFwL2I1SkdBUnBKbGxWVzhqN1FtajRlUkJaeGRmaGsv?=
 =?utf-8?B?MFZnMUNSQjlIdTU5VnZuM2VmU0RXOEZMMThnYUsrSUtSUHJONHZzdkVweEYv?=
 =?utf-8?B?OWdGc0xOdlQxM29iZndvZGNJK3U5dHlLQkdxZHVTY0R6ZmFGNG1jdVRwdXF5?=
 =?utf-8?B?dkp6cVFFMjZ4MjVkaDF6bVV2NExiRDlFVFNsOEJwdk9WWGFsK0J6RW5EbW5r?=
 =?utf-8?B?bjRWUkVNRjgvbGprTjB1NlQxWVFScm15Ri82bGNUS3VvY1RhSHlydzJwQUtY?=
 =?utf-8?B?dTR1a0p1QzJwaVlKYTNCWE1FNTBrc0xPVXA4OHRkVHlvY1R1SmlGUy9aQ0Fl?=
 =?utf-8?B?ZzBRb1lDcjl6V3FKYnVlV3dNYUticEh6eGdxUVNqNGtDTWxuZzBvcUtQUkk5?=
 =?utf-8?B?NzdFZTlvSzFaTXg5cXozOW5zOENieTVlcHdTaDFGRjVhcitzTVE4dGV5elk4?=
 =?utf-8?B?RllIN2pFdGF6TE0xL3pZWWlvNllYNFd0a01HWS95RXVqSUpGQ2VaWTl6V2U4?=
 =?utf-8?B?ZkJqQ3FITGJ6Y2VvNlU2elowZStqZzVaTG9BRzZ6bThLb2RFQm1wb1p4QkNo?=
 =?utf-8?B?a2hTUytpM1BDWTl5cVdQaVhiQ0w1blJMQUNtZ21iRnhUVXpZdjRlQkx2UHZn?=
 =?utf-8?B?b3pxd1dheEkwMVExUTBwUjZBbGtmUnRIakluY3BWZnA3bGprK3BacjVoc1FL?=
 =?utf-8?B?d3EvMU43YTZySlA3MFVDT3hIbFd2OXNSMDFxUmRWWFM1bThDb2ZWM3h1OTJy?=
 =?utf-8?B?SFhIb1NVT3dGd2JqYmU0L1c2OFF4Unh1RHpaWWY1S3VKck4xb0J4Wno3cHZZ?=
 =?utf-8?B?Y2pEZmNWa3ZRcU5DbnJGZUMzSHpUZUJPUHhLWVFQM0Z4aUlIWGg0anIxcHpu?=
 =?utf-8?B?RUwzZDBVUmxDRmhwRmZEYlgvem5KU0tXNUg1R2R2Y2dBYnIxWG4wTzJiUFRx?=
 =?utf-8?B?N0NwenoxK0MveWlPK0hXMkRUU0dwZDhydll5RTFqeEZCNll1Nm50S3FkUVhT?=
 =?utf-8?B?c2RwRWtwQ3lXS2JHbUFzR3Z3dnRaSko1RnIxdGpiTmY5K0pqZkFlUGRONnFw?=
 =?utf-8?B?RjBUSVQ0K0FXTUU0WDhzRkRtclBtd3ZxeVhjeE5acmhmeEVGUHFOejdsT1dl?=
 =?utf-8?B?dmtZcTN2VldzOTArdlZsNVhiUVQ1N2ZPeVgwMTEya2Q5SzJMbnE1eExRZ21D?=
 =?utf-8?B?T0ZWYnQ5ZDhGRjJtTXVQM3doZm1MMXNNMFNlazBCYTlDa284UEo0bk5Hajlu?=
 =?utf-8?B?b09KZnlyMlFvZDBSUzBPa0duNllnLytCdThUdlZaNUNJb2dJVmlHQXFlRGE3?=
 =?utf-8?B?eVpWWFVTSU90cHlMd29heVhRTllMTGp2RGFwQ0lTLzQ5UGZ5cDd1WmZRZkFj?=
 =?utf-8?B?UWZYdDh2WHdKN2FvZU5JT29HbjFPUHZOQ1JVaDBnSE95WkQ1NjJST1pLT2RD?=
 =?utf-8?B?WVBpUmJ3NS9BUUUwWkhwQWVuZkx1aGRKYmRydjlkOGVvcEZiMWtRZkNsQnNG?=
 =?utf-8?B?WlZHbzNVc09QQnlQbWxyWjkrVGNvajhIYjZnZDNhb20xdEVPWlBTSWJzUkJo?=
 =?utf-8?Q?yj911LDXdMsExaL4YGLv23E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10C88E8DAC08754BBCC56523C9FD4D4F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8510.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46f1d8-8a4f-4520-eae5-08d9dddaab7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 19:09:09.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6F5YcRiZR5MCwH4o3BXnTjs61KMaveGXyhiud0dBY2oiQz+B3cjxOzSodKAbZ+EG75LcWaIt/7HjK8D+Q5H74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5805
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ICAgICAgICBJbiBteSBlYXJsaWVyIHJlc3BvbnNlLCBJIGFncmVlZCB0byBmZXcgY2hhbmdlcyBz
dWdnZXN0ZWQgYnkgR3JlZy4NCiAgICAgICAgSSBvYnNlcnZlZCBzb21lIGlzc3VlIHdoaWxlIGlt
cGxlbWVudGluZyAyIG9mIHRob3NlIGNoYW5nZXMuIA0KDQogICAgICAgIE9uIDIwLzAxLzIyLCAx
MTowMSBQTSwgIlZpa2FzaCBCYW5zYWwiIDxidmlrYXNAdm13YXJlLmNvbT4gd3JvdGU6DQogICAg
ICAgID4+PiArCQlwY2lfYnVzX3JlYWRfY29uZmlnX3dvcmQoZGV2LT5idXMsIGRldi0+ZGV2Zm4s
IHBvcywgJmVudCk7DQogICAgICAgID4+PiArCQlpZCA9IGVudCAmIDB4ZmY7DQogICAgICAgID4+
PiArCQlpZiAoaWQgPT0gMHhmZikNCiAgICAgICAgPj4+ICsJCQlicmVhazsNCiAgICAgICAgPj4+
ICsNCiAgICAgICAgPj4+ICsJCS8qIFJlYWQgZmlyc3QgaW5zdGFuY2Ugb2YgY2FwYWJpbGl0eSAq
Lw0KICAgICAgICA+Pj4gKwkJaWYgKCEoZGV2LT5jYXBfb2ZmW2lkXSkpDQogICAgICAgID4+PiAr
CQkJZGV2LT5jYXBfb2ZmW2lkXSA9IHBvczsNCiAgICAgICAgPj4NCiAgICAgICAgPj5TaG91bGRu
J3QgeW91IGhhdmUgY2hlY2tlZCB0aGlzIGJlZm9yZSB5b3UgcmVhZCB0aGUgdmFsdWU/DQogICAg
ICAgID4+DQogICAgICAgID4NCiAgICAgICAgPlllcywgd2lsbCBtb3ZlIHRoaXMgY29kZQ0KICAg
ICAgICA+DQoNCiAgICAgICAgQ2Fubm90IGJlIG1vdmVkIGJlZm9yZSByZWFkLCBiZWNhdXNlICJp
ZCIgdXNlZCBpbiB0aGlzICJpZiIgY29uZGl0aW9ucyBpcw0KICAgICAgICByZXR1cm5lZCBieSBs
YXN0IHJlYWQuDQogICAgICAgIA0KICAgICAgICA+Pj4gQEAgLTExMjgsNiArMTEyOSw3IEBAIHZv
aWQgcGNpX3NvcnRfYnJlYWR0aGZpcnN0KHZvaWQpOw0KICAgICAgICA+Pj4gIA0KICAgICAgICA+
Pj4gIHU4IHBjaV9idXNfZmluZF9jYXBhYmlsaXR5KHN0cnVjdCBwY2lfYnVzICpidXMsIHVuc2ln
bmVkIGludCBkZXZmbiwgaW50IGNhcCk7DQogICAgICAgID4+PiAgdTggcGNpX2ZpbmRfY2FwYWJp
bGl0eShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgY2FwKTsNCiAgICAgICAgPj4+ICt2b2lkIHBj
aV9maW5kX2FsbF9jYXBhYmlsaXRpZXMoc3RydWN0IHBjaV9kZXYgKmRldik7DQogICAgICAgID4+
DQogICAgICAgID4+V2h5IGlzIHRoaXMgbm93IGEgZ2xvYmFsIGZ1bmN0aW9uIGFuZCBub3Qgb25l
IGp1c3QgbG9jYWwgdG8gdGhlIHBjaQ0KICAgICAgICA+PmNvcmU/ICBXaG8gZWxzZSB3b3VsZCBl
dmVyIG5lZWQgdG8gY2FsbCBpdD8NCiAgICAgICAgPg0KICAgICAgICA+V2lsbCBtYWtlIHBjaV9m
aW5kX2FsbF9jYXBhYmlsaXRpZSBsb2NhbCBhbmQgbW92ZSBpdCB0byBwcm9iZS5jDQogICAgICAg
ID4NCg0KICAgICAgICBwY2lfZmluZF9hbGxfY2FwYWJpbGl0aWVzIGZ1bmN0aW9uIGlzIGNhbGxl
ZCBvbmx5IG9uY2UgaW4gcHJvYmUuYyBmaWxlLA0KICAgICAgICBidXQgdGhpcyBmdW5jdGlvbiBp
cyBjYWxsaW5nIF9fcGNpX2J1c19maW5kX2NhcF9zdGFydCB3aGljaCBpcyBkZWZpbmVkIGluIHBj
aS5jLA0KICAgICAgICBzbyBuZWVkIHRvIGltcGxlbWVudCB0aGlzIGZ1bmN0aW9uIGluIHBjaS5j
IGFuZCBtYWtlIGl0IGdsb2JhbC4NCg0KICAgICAgICBUaGFua3MNCiAgICAgICAgVmlrYXNoDQog
ICAgICAgIA0KDQoNCg0KDQo=
