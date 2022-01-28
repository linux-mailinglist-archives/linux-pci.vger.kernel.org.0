Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8B49F299
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 05:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiA1Evv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 23:51:51 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:40033
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233856AbiA1Evv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 23:51:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3eSArA+uQIc7xm0WYIyOr3C3Kqe3fPj/654j4zYIumr6EwFpKqtUXxLYgWMluj/SyS3n157GuqtCwNAMETB5WrwfgMPjddxBnWkuC4ECJiGQomzCNySx8t4XvH7udZ5BTkBZCnRDI0hyf5zyDFUyOBYdhX7aW0+af3qs0RgPOdYV5cqs3P4kdChWU0xzSIPPhRFqU6BOfy9MJQ6YnXsAMNQa/QT1Bd5gOccsnCqWUIY7goMAGgzLkYHeNtAfYmmaU4uyvFwQFr46g2Nw8eJybcWn7Up67S9yg+tn8KdrbjSxKadH65v4l2eL8sWsUOJKGUa1yNsYsFAAJnQ+vpGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRmuRZQ7taDj5dm61nEZcfulTYLHCRrh/RenQj2h47s=;
 b=eoWs4gU9ED1TXVIToR1iuCa9M2YWlMVyokWs3Ir9qqRz77QJa64g7+T+EOxhmxK70tH2cdxofO7hv/GqgVW5uP4laesv4FkD/hamlbGMOOOxdoT62NWqFS9zpvXhXLMd9SHN0Xi2kQcHrPEHE/K9ie086UH8KNAkSnubpeuPnXo3qWR4BiBJhJ41xFCfI3hlTCVhwycmhExcQsj5rwpSHpB42zXrNkMrxr1EUySLEei52GI6APSeacu+QmPC/ckod4bX+hCTxUTR6yGbdGBYOV+h52L7Lal3xzUZ7utxKV5w/uVUlmErjWhq3zApF3Fgv9DoK75eM/eAPBAckEN4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRmuRZQ7taDj5dm61nEZcfulTYLHCRrh/RenQj2h47s=;
 b=hzIL/40xjxrsYv5ND1ReWnB0LW50LVfPp9BM7CaWl7jvJxnY0kC8JbZ4M3VvWC97Bkvf5d02I3QLlSaWIQfUS0Jc+mcdhT5EnJe7sgdpxonrX7i8XSO6a7oqhyGp0N+Q8KLxV0SRTHr9hHc0HFffiZzxL7+4fDgghaVRA71PUnE=
Received: from BY3PR05MB8497.namprd05.prod.outlook.com (2603:10b6:a03:3c8::23)
 by DM6PR05MB6922.namprd05.prod.outlook.com (2603:10b6:5:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 04:51:43 +0000
Received: from BY3PR05MB8497.namprd05.prod.outlook.com
 ([fe80::a1ad:f4ce:d76:96c1]) by BY3PR05MB8497.namprd05.prod.outlook.com
 ([fe80::a1ad:f4ce:d76:96c1%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 04:51:43 +0000
From:   Vikash Bansal <bvikas@vmware.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Vikash Bansal <bvikas@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Topic: [PATCH v2] PCI: Speed up device init by parsing capabilities all
 at once
Thread-Index: AQHYFAK+oPrtukqCvUK9dsIHNG2zPA==
Date:   Fri, 28 Jan 2022 04:51:43 +0000
Message-ID: <2A631B59-B3BD-4B3C-9DDD-795B7843333B@vmware.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.56.21121100
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e79883cf-c9f5-4cbf-07da-08d9e219e1a0
x-ms-traffictypediagnostic: DM6PR05MB6922:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR05MB692216DF9A7F099993B689BCAB229@DM6PR05MB6922.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUuWvv2Iv55XVJQ/1+nR5OoHQj/UglvEqRILgp7P5h1iAiBLtZjLkl/GShKhz9GXiJy83xDqK3uSAE3QVvfz7qQxt8hZnhSeGZ9ERHwr6tjcibBNv+rYtDxTQNnDQssGG0aqFwaQonYR43lYLMrnedFJVvzrOjzbedBJCdETIQHUleFrfFr9tQWAgzLZPZuTyxu9Y0y6UswGX6n4bH69ADlpLi5/aH7bw5InaLuYU9W/t9/47byz5bCjXtmizfs59/M1Og+l27EX6Fo79BrSXwpqf9+Dxm36blCJWSFKDVxl1ejK2qrySwxtlIraznVwA/t14rA/r4gOoLgghquikBO0O5iqQS8tXfE+cBGjkBhcyzW8WbEtYujEg91DOtnX8LjddAdMs7bHTm4knm0PP8qAv5G8p5nLtrjYgNf6ylzHmejnG/+c+MckQwNm8NIkNNylkC6vPpW878a2jezWO5uO7QBhPSdyWb+HlLKhwmz5MSCcQ0A2BxqP7swVOlPT8LiK07E/YX4u3urSIPE6f/7IwDfCF9fHgLYO7XluA7/3wpu/u65sqQGoHoaPVTEDcwBXEj6dKwRb0Nzuz0V1HGBQleB4j8SrKvHEd1uj892Lt4+ovVG54pn8OUgSuTscepCUL3MphHkFAVFWmnPH8bedBoswupKVodNVF78md7AimGpYFxaoeIL7sauHxeRimqncicOcrX5AfgPcjgjdU/lc/KSwySfHCAsddkPa/58tYPrSb2Ss49aZ2us0Aibz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8497.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(107886003)(8936002)(64756008)(66446008)(66556008)(66476007)(76116006)(186003)(66946007)(26005)(2616005)(2906002)(71200400001)(6916009)(316002)(54906003)(91956017)(4326008)(83380400001)(36756003)(5660300002)(33656002)(38070700005)(122000001)(38100700002)(55236004)(6486002)(86362001)(508600001)(6506007)(6512007)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDM5TUdTOXdyMUtOekdacW1uVXVnRXVRRWlhSDlpbW9XQWFsYmRqY3Z4Ymx6?=
 =?utf-8?B?bWtON2ZzVm4yZkFYeTl5UU8wU1A4cjFlNlBrR3hmK3F2SEZvOHRSLzJSaEhn?=
 =?utf-8?B?ZzRvQU40TTdkN2hZZzJPOWJlNE1sK1JNY0Y2RVdKbU1QU0VzdldicklrRDNW?=
 =?utf-8?B?Rk5FZTZYNHZNbG1xVnErbHFGMGxYakpUTWVzMlZPYkl4Zmh2T1JSRnpsU3Q4?=
 =?utf-8?B?dTNuNk91ZVJFNy8wbGRvZXpGbzZDMDNUd2VIV1pKMDM2bTViYUNEV0IyWUpy?=
 =?utf-8?B?NG85anlmZHNFbzhpOWw0TER5eHNoaGFKSXVEUCtjMWJjNXlMTU5DTjFJWDJ2?=
 =?utf-8?B?L1R6S1RHaG15Y003Zk9JenNwM3FCSVJKbjVsWWEvSFJ6RmtoVks2Qm5Wbmww?=
 =?utf-8?B?bjcxZU14RkhuSFRiM0Rxak9oOG8xaVdDc2gyUnlPWUNXTmE0UHJLL3dHVm9Q?=
 =?utf-8?B?WnJPcUY2TWVzQlFGUjlXdnNmb2lqUmVsRkxQbDZ5RGJhQXE2T0w5R3U4T3dY?=
 =?utf-8?B?dENzVXRBYXU2cHN3WGxDQVp6SUduU2g5VVM1UlhyZlJQdEJsY0dxelRvSjVK?=
 =?utf-8?B?L3lpd2pJQnh2NnhOWnlJTkJqN2IySkh1VDh4ek9HTWozcUZvRVBpamRRNVRZ?=
 =?utf-8?B?UDNHVGJCcktQeGtuWE5XUGNmS0NoeU5RbDg0Q0c3L3Z6eUZaTzhHaDZLblV4?=
 =?utf-8?B?SjBsOHF1TVQwczU3dUJNODRzZkQyZDcwMEIyUkFtc2x0dXlKcUcxbU5Hb04y?=
 =?utf-8?B?T25YKzhMbXl5ZEZ6WWVURkYzTFpQSXRRcTBRbjBFNDg4V1hWSFVCUU56bTJ3?=
 =?utf-8?B?Z0xDY1pDWjBRajZlUVVTdlJuTi9qNXIxalZ5NS9td3ZnOEdtVHAvM1RFYkZh?=
 =?utf-8?B?RVB4bTI0QVNFZGxWOWIrWTlOb1lMakQ5dWhBaVhHb1huQzF1Yjhmdjg1VTUr?=
 =?utf-8?B?NVZSVHNoM3RmYUtVT0s3WUxubXYrenNwWFZLeTI0SkZDcnZ4eXhQc0V5VmtF?=
 =?utf-8?B?ME0rTnlHSDBQYkxucDlwYWZtc05VYTVqTVo3clBmbm9GQ05pOVNVYmlpYXNn?=
 =?utf-8?B?YUlaTFp5cXJHYXZIaEJuay9oYUI3Q2lSNEJsL2V4alNYR3RXNlpBVmM1Sjdq?=
 =?utf-8?B?WERqakZlby83UklNNnM0cWhOZ3B3Y3BHbGkwa0FuZi85dE1ZNWo5TVh3VzYr?=
 =?utf-8?B?WlRpd29raUZ6UUc3N3N4TmtyQmZIa2NJVzh0ZitOVWxtV1BxTUJlTmxTc25Z?=
 =?utf-8?B?aFkwZzhtZTdtUmZjTFY5WFMyaEZnSHBkWXUzTG56K2ExVDVxZDYrejNFaS9Y?=
 =?utf-8?B?K25JV0ppNUJhWnJRWVVGNGxEcVJvZHNSbHRYa3crQTI0eU9LR3NIQnF1NXJB?=
 =?utf-8?B?ZGt4cmNiRVpGbS9RVWFKby9yN3M5SWJ6dkl6OXdvUi9mMkMzNjBESmQrWjFu?=
 =?utf-8?B?dVhxbEIxREVRaUI2dnFjWXFETlRNSGFIa0JQL1pYRzloNitNRnNyNFZiQkFL?=
 =?utf-8?B?UTYwSXM5RmNQTDQxUDh0OHlWNThKNXNqMXZKcnJmOEVCeFh0K0ErWU1vNXpw?=
 =?utf-8?B?ZzJSRi9BT3VnM3dyU0ZNeEZKZXkvVytwK2M2akM4WGRKZGxxME9OL2pEUHNq?=
 =?utf-8?B?ZVB3TDJBbDExamtMNUxSdGJEV3hxYU9Hd3E4M0oxQ3hQR09WS2tWYWJMbDNv?=
 =?utf-8?B?ZFNIS2hYT2NUVUtMOTJDTXIxN2lYTkpJY1pvUmsxOXlnZVpId1ZFV2w2M1BK?=
 =?utf-8?B?T3czR2dweFZtNE1ISWZRemtpblIzMmpkQllsM0tTcHRLajBRcGY5eUxMalpZ?=
 =?utf-8?B?WWNWRDIwdllPTkMvbXZBdktVRkI0b0VJc2VQa3pIbXp5cEEwanNZR3RFbVVv?=
 =?utf-8?B?SHZvVTRQZjdiK082OXg0USt5Zzk2R3Jac0JtcmJkVW12Nko5OEEyYmpXemtU?=
 =?utf-8?B?UWxzNGYzNU50WEVodEtyRHNVa05xazl3K3UyZHN2dklKUWVpaTlVWTA4OUZB?=
 =?utf-8?B?SU83TjZQZkJGWHNEMEhyeSszQXZMNWNVWCtwV0xqTDlJdEtFK1RLVXlyZ0Er?=
 =?utf-8?B?bHJJa0FrMHZpQ2F3QTg1aU1RS1R5Q2JRbjhEcVR4eCtPV2ptM3EvUEsxc3Bw?=
 =?utf-8?B?eTRWS0MzK3FSNUdidmJ5cEQrZisxRThrQzY3YVd2Y1ROR2g1anVOcWxBZkda?=
 =?utf-8?Q?tEdj/qZgroEL3uHimCzCBYn4Dyvk/iwo8tRvM5DPTY1E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EFCF293D1B3AE49BBE775C54C9D99D5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8497.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79883cf-c9f5-4cbf-07da-08d9e219e1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 04:51:43.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkY581xw8jfzw0t6fAjef98p1DH8gYLeGLJy/gcBrm7xpfMixuGMZFD/CuwF7wEs15fIlFrrN4rnYyx2U4dlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6922
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHRoZSBQQ0kgY2FwYWJpbGl0eSBsaXN0IGlz
IHBhcnNlZCBmcm9tDQp0aGUgYmVnaW5uaW5nIHRvIGZpbmQgZWFjaCBjYXBhYmlsaXR5LCB3aGlj
aCByZXN1bHRzIGluIGEgbGFyZ2UgbnVtYmVyDQpvZiByZWR1bmRhbnQgUENJIHJlYWRzLg0KDQpJ
bnN0ZWFkLCB3ZSBjYW4gcGFyc2UgdGhlIGNvbXBsZXRlIGxpc3QganVzdCBvbmNlLCBzdG9yZSBp
dCBpbiB0aGUNCnBjaV9kZXYgc3RydWN0dXJlLCBhbmQgZ2V0IHRoZSBvZmZzZXQgb2YgZWFjaCBj
YXBhYmlsaXR5IGRpcmVjdGx5IGZyb20NCnRoZSBwY2lfZGV2IHN0cnVjdHVyZS4NCg0KVGhpcyBp
bXBsZW1lbnRhdGlvbiBpbXByb3ZlcyBwY2kgZGV2aWNlcyBpbml0aWFsaXphdGlvbiB0aW1lICBi
eSB+Mi0zJQ0KKGZyb20gMjcwbXMgdG8gMjYxbXMpIGluIGNhc2Ugb2YgYmFyZSBtZXRhbCBhbmQg
Ny04JSAoRnJvbSAyMDFtcyB0byAxODRtcykNCmluIGNhc2Ugb2YgVk0gcnVubmluZyBvbiBFU1hp
Lg0KDQpJdCBhbHNvIGFkZHMgYSBtZW1vcnkgb3ZlcmhlYWQgb2YgMjBieXRlcyAodmFsdWUgb2Yg
UENJX0NBUF9JRF9NQVgpIHBlcg0KUENJIGRldmljZS4NCg0KUmFuIHBhaG9sZSBmb3IgcGNpX2Rl
diBzdHJ1Y3R1cmUuIFRoaXMgcGF0Y2ggaXMgbm90IGFkZGluZyBhbnkgcGFkZGluZw0KYnl0ZXMu
DQoNClNpZ25lZC1vZmYtYnk6IFZpa2FzaCBCYW5zYWwgPGJ2aWthc0B2bXdhcmUuY29tPg0KLS0t
DQoNCkNoYW5nZXMgaW4gdjI6DQogIC0gUmFuIHBhaG9sZSB0b29sLg0KICAtIE1vZGlmaWVkIGNv
bW1lbnRzIHRvIGFkZCAiY2xvY2sgdGltZSIuDQogIC0gUmVtb3ZlZCBjb21tZW50cyBiZWZvcmUg
Y2FsbCB0byBwY2lfZmluZF9hbGxfY2FwYWJpbGl0aWVzLg0KDQpkcml2ZXJzL3BjaS9wY2kuYyAg
IHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KZHJpdmVy
cy9wY2kvcHJvYmUuYyB8ICAxICsNCmluY2x1ZGUvbGludXgvcGNpLmggfCAgMiArKw0KMyBmaWxl
cyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvcGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYw0KaW5kZXggOWVjY2U0MzVm
YjNmLi5iMzYxNzg4YmNjMjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0KKysrIGIv
ZHJpdmVycy9wY2kvcGNpLmMNCkBAIC00NjgsNiArNDY4LDQxIEBAIHN0YXRpYyB1OCBfX3BjaV9i
dXNfZmluZF9jYXBfc3RhcnQoc3RydWN0IHBjaV9idXMgKmJ1cywNCglyZXR1cm4gMDsNCn0NCg0K
Kw0KKy8qKg0KKyAqIHBjaV9maW5kX2FsbF9jYXBhYmlsaXRpZXMgLSBSZWFkIGFsbCBjYXBhYmls
aXRpZXMNCisgKiBAZGV2OiB0aGUgUENJIGRldmljZQ0KKyAqDQorICogUmVhZCBhbGwgY2FwYWJp
bGl0aWVzIGFuZCBzdG9yZSBvZmZzZXRzIGluIGNhcF9vZmYNCisgKiBhcnJheSBpbiBwY2lfZGV2
IHN0cnVjdHVyZS4NCisgKi8NCit2b2lkIHBjaV9maW5kX2FsbF9jYXBhYmlsaXRpZXMoc3RydWN0
IHBjaV9kZXYgKmRldikNCit7DQorCWludCB0dGwgPSBQQ0lfRklORF9DQVBfVFRMOw0KKwl1MTYg
ZW50Ow0KKwl1OCBwb3M7DQorCXU4IGlkOw0KKw0KKwlwb3MgPSBfX3BjaV9idXNfZmluZF9jYXBf
c3RhcnQoZGV2LT5idXMsIGRldi0+ZGV2Zm4sIGRldi0+aGRyX3R5cGUpOw0KKwlpZiAoIXBvcykN
CisJCXJldHVybjsNCisJcGNpX2J1c19yZWFkX2NvbmZpZ19ieXRlKGRldi0+YnVzLCBkZXYtPmRl
dmZuLCBwb3MsICZwb3MpOw0KKwl3aGlsZSAodHRsLS0pIHsNCisJCWlmIChwb3MgPCAweDQwKQ0K
KwkJCWJyZWFrOw0KKwkJcG9zICY9IH4zOw0KKwkJcGNpX2J1c19yZWFkX2NvbmZpZ193b3JkKGRl
di0+YnVzLCBkZXYtPmRldmZuLCBwb3MsICZlbnQpOw0KKwkJaWQgPSBlbnQgJiAweGZmOw0KKwkJ
aWYgKGlkID09IDB4ZmYpDQorCQkJYnJlYWs7DQorDQorCQkvKiBSZWFkIGZpcnN0IGluc3RhbmNl
IG9mIGNhcGFiaWxpdHkgKi8NCisJCWlmICghKGRldi0+Y2FwX29mZltpZF0pKQ0KKwkJCWRldi0+
Y2FwX29mZltpZF0gPSBwb3M7DQorCQlwb3MgPSAoZW50ID4+IDgpOw0KKwl9DQorfQ0KKw0KLyoq
DQogICogcGNpX2ZpbmRfY2FwYWJpbGl0eSAtIHF1ZXJ5IGZvciBkZXZpY2VzJyBjYXBhYmlsaXRp
ZXMNCiAgKiBAZGV2OiBQQ0kgZGV2aWNlIHRvIHF1ZXJ5DQpAQCAtNDg5LDEzICs1MjQsNyBAQCBz
dGF0aWMgdTggX19wY2lfYnVzX2ZpbmRfY2FwX3N0YXJ0KHN0cnVjdCBwY2lfYnVzICpidXMsDQog
ICovDQp1OCBwY2lfZmluZF9jYXBhYmlsaXR5KHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBjYXAp
DQp7DQotCXU4IHBvczsNCi0NCi0JcG9zID0gX19wY2lfYnVzX2ZpbmRfY2FwX3N0YXJ0KGRldi0+
YnVzLCBkZXYtPmRldmZuLCBkZXYtPmhkcl90eXBlKTsNCi0JaWYgKHBvcykNCi0JCXBvcyA9IF9f
cGNpX2ZpbmRfbmV4dF9jYXAoZGV2LT5idXMsIGRldi0+ZGV2Zm4sIHBvcywgY2FwKTsNCi0NCi0J
cmV0dXJuIHBvczsNCisJcmV0dXJuIGRldi0+Y2FwX29mZltjYXBdOw0KfQ0KRVhQT1JUX1NZTUJP
TChwY2lfZmluZF9jYXBhYmlsaXR5KTsNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2Jl
LmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQppbmRleCAxN2E5Njk5NDJkMzcuLmIyZmE1YjJjNDJm
NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMNCisrKyBiL2RyaXZlcnMvcGNpL3By
b2JlLmMNCkBAIC0xODMxLDYgKzE4MzEsNyBAQCBpbnQgcGNpX3NldHVwX2RldmljZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQ0KCWRldi0+aGRyX3R5cGUgPSBoZHJfdHlwZSAmIDB4N2Y7DQoJZGV2LT5t
dWx0aWZ1bmN0aW9uID0gISEoaGRyX3R5cGUgJiAweDgwKTsNCglkZXYtPmVycm9yX3N0YXRlID0g
cGNpX2NoYW5uZWxfaW9fbm9ybWFsOw0KKwlwY2lfZmluZF9hbGxfY2FwYWJpbGl0aWVzKGRldik7
DQoJc2V0X3BjaWVfcG9ydF90eXBlKGRldik7DQoNCglwY2lfc2V0X29mX25vZGUoZGV2KTsNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KaW5k
ZXggODI1M2E1NDEzZDdjLi5hYmNmN2ZkYzRjOTggMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4
L3BjaS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3BjaS5oDQpAQCAtMzM1LDYgKzMzNSw3IEBAIHN0
cnVjdCBwY2lfZGV2IHsNCgl1bnNpZ25lZCBpbnQJY2xhc3M7CQkvKiAzIGJ5dGVzOiAoYmFzZSxz
dWIscHJvZy1pZikgKi8NCgl1OAkJcmV2aXNpb247CS8qIFBDSSByZXZpc2lvbiwgbG93IGJ5dGUg
b2YgY2xhc3Mgd29yZCAqLw0KCXU4CQloZHJfdHlwZTsJLyogUENJIGhlYWRlciB0eXBlIChgbXVs
dGknIGZsYWcgbWFza2VkIG91dCkgKi8NCisJdTggICAgICAgICAgICAgIGNhcF9vZmZbUENJX0NB
UF9JRF9NQVhdOyAvKiBPZmZzZXRzIG9mIGFsbCBwY2kgY2FwYWJpbGl0aWVzICovDQojaWZkZWYg
Q09ORklHX1BDSUVBRVINCgl1MTYJCWFlcl9jYXA7CS8qIEFFUiBjYXBhYmlsaXR5IG9mZnNldCAq
Lw0KCXN0cnVjdCBhZXJfc3RhdHMgKmFlcl9zdGF0czsJLyogQUVSIHN0YXRzIGZvciB0aGlzIGRl
dmljZSAqLw0KQEAgLTExNDAsNiArMTE0MSw3IEBAIHZvaWQgcGNpX3NvcnRfYnJlYWR0aGZpcnN0
KHZvaWQpOw0KDQp1OCBwY2lfYnVzX2ZpbmRfY2FwYWJpbGl0eShzdHJ1Y3QgcGNpX2J1cyAqYnVz
LCB1bnNpZ25lZCBpbnQgZGV2Zm4sIGludCBjYXApOw0KdTggcGNpX2ZpbmRfY2FwYWJpbGl0eShz
dHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgY2FwKTsNCit2b2lkIHBjaV9maW5kX2FsbF9jYXBhYmls
aXRpZXMoc3RydWN0IHBjaV9kZXYgKmRldik7DQp1OCBwY2lfZmluZF9uZXh0X2NhcGFiaWxpdHko
c3RydWN0IHBjaV9kZXYgKmRldiwgdTggcG9zLCBpbnQgY2FwKTsNCnU4IHBjaV9maW5kX2h0X2Nh
cGFiaWxpdHkoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IGh0X2NhcCk7DQp1OCBwY2lfZmluZF9u
ZXh0X2h0X2NhcGFiaWxpdHkoc3RydWN0IHBjaV9kZXYgKmRldiwgdTggcG9zLCBpbnQgaHRfY2Fw
KTsNCi0tDQoyLjMwLjANCg0K
