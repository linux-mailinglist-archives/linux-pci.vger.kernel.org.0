Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79649696813
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjBNP3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 10:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjBNP3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 10:29:00 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6C8252A6;
        Tue, 14 Feb 2023 07:28:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZJ9m7lh6vAQH8A6L9jDa173KI6/As6qHOpUI8oLuWEx6lD9bAQuJU12ojSWaDnXifpPvv4UQT4AVsSs9Ve+n08a9Oeibn5AONPJJzvnLNg60IphPPsVIOBTybnaCuV+1ZYk372IHAZepSMQmR08hCtknlEGt1jBZRfSwTpNfDrvhEfM/cdKaTqmPpJwUCEt1lYBqGoPbLdI3mKRWrc4Ms1iALtPjXsdjeaiZJj7M+EwdBmkc96ole8aNHvgYe/RLIF9CSUAFk9LlQwol528w1VtHrkgB11zaY2lNYskh8lJP8OOd4UCmq1KJ5rDd1Hs7pNBfwUPpKC2q07M/1s1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm7HhKoZ2Ni0XU+H/1QP6q9n8Fze2T+vNwPcjyOIvOg=;
 b=kvJ8SXa74LiZ15QY899O7+FaKE5Ljsm1OiIc3yMuSNx8VlzQVH9NGylZ85vVET+625w1lIZVerXkMTgI6yjWcr7RDayXMyrJvPqE2c14HC7CDfvN9m/Ho9gYt5EJwj9emiUpvnUo/2MOngtTOmf7mnF/sTRxwY3/mOJv23br6jHmhb3JrCSZj3oxnGt1+XvAYKHxq3Ra0RjRDVdLLV3aU0Ch/RAaoyxI7bxyGZ1ufsvEVpXwMXk3mnlyHxEtzGplXH2saJuzVQ2uB4gBJ8if8woF80BxvFtNdCzAMAdsmT8N9fxRCq4Bdqutz8wannJlODBice51u7vcbHeYp50+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm7HhKoZ2Ni0XU+H/1QP6q9n8Fze2T+vNwPcjyOIvOg=;
 b=L88jL8Pxv4hy3tXr/aQbEQDm2fw+d/yPoQrnz+nzov7ZOv7zYPfMtZ1CeiXS3AUCieTyf/R/Q4a7jN++6ymxbbfhqePEPI7IWoyU6p16j8d34P5rFIWZn9uynkMhFWj8SrstBkX+Buqr2+CK8JiJ1R7n20jDeU0sHL6fBfxYTlk=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PA4PR04MB7808.eurprd04.prod.outlook.com (2603:10a6:102:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 15:28:56 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 15:28:56 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "taki@igel.co.jp" <taki@igel.co.jp>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] Re: PCIe RC\EP virtio rdma solution discussion.
Thread-Topic: [EXT] Re: PCIe RC\EP virtio rdma solution discussion.
Thread-Index: AQHZOyzIhsmm2lUdzUGRwLjL3rp40q7N0WuAgADIPKA=
Date:   Tue, 14 Feb 2023 15:28:56 +0000
Message-ID: <HE1PR0401MB2331F429D5EB7CD1068797E688A29@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230207194527.4071169-1-Frank.Li@nxp.com>
 <9f781dc0-e4d5-4c14-cad9-483f59b2a315@igel.co.jp>
In-Reply-To: <9f781dc0-e4d5-4c14-cad9-483f59b2a315@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PA4PR04MB7808:EE_
x-ms-office365-filtering-correlation-id: 68588202-a5fa-479b-6347-08db0ea0301f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0a1jx8lBXnPha4XbrNkpkDsGzs1KOem4u+qHXLDqQeioVu/ra5HEaF1c/FahuVK46KlAbi72/mVTBztaJ6ZvoISjvtF2yNy6vvyWmFgZIq2R7KJ1kgKPrNIzHx8lyLMPR1K5k89OIvbqRiPfZ465ZuwvZ2jec99U8zIcWlcP2c+oy+U/01PK0sqjbzrRcW2n/aIzUd0vUsLxztLVjCkdVx/J78q6GhQW1S0OQ9KpGt2MsxzvwlBAomTB8lhDzqzuuSCh7hG5LErwzKSv/OzVKFKEp37kazhHXOReaOR0PliclNKR9G0/vc2RjyiS2OZeForE3bHS3/KfZiH+TqbsGv3fua6TqfCykEOJocULpiR3XdMV0gKxzd9bq97rTNN62/TpzbGsIeIKs+b1VZrBzGpn/G+D/+O2dgBR9GWFG7UOhvY4EUpZB7chmcE0gWpTGURzszDl1OteWPVtfIRFiXwexthTh4zvpOWs3PgpREELJXqfYP8enLaeSC0FGVEhJh93L5+AgzAv+qq75aXDvYZC8GOjxDPrctT717hVTC3oDSTN93qHwiiRaPa9XupNI5AMgZVToIznK5ZEQ23lXh3AZRLWgXJaD95kADfi8LX3+LLhKvqjYgBVNrFxoxxm6EU4ociPLZw6h0mVxBOZizOWtngCuV7Rh/elG7N6Ckt1Db4f/tFfYCQJPOdCb8jvyWRNtz8pYpZuqIxcfNbiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199018)(33656002)(86362001)(38100700002)(55016003)(38070700005)(122000001)(66476007)(4326008)(52536014)(66946007)(66446008)(66556008)(76116006)(41300700001)(54906003)(110136005)(316002)(8676002)(64756008)(7416002)(2906002)(186003)(8936002)(44832011)(5660300002)(71200400001)(55236004)(6506007)(26005)(7696005)(9686003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDEzYnRMYTM0c0ErNmhDQndvQXprbVJza1picVBLRTQ1aTRuYmFnTU85MmJY?=
 =?utf-8?B?eWFDdXRueVh1M0Yyd3g2alhQMnZBUzZTR2RWNlNIYXJRb28yOVJ6RmhvQkZF?=
 =?utf-8?B?Q0lLZHNXY0pqTGJ4b3FZWWROL05lVGliSXZTc3Y2WS9jd0p4SUtpd25BZmZt?=
 =?utf-8?B?VzEwNFlpZENlQU9PNXdxVG00OEJpUE1aRlFGanpvK2hYbWFrRXZURzJzemJU?=
 =?utf-8?B?L01IbWVqTXZlaWlkN2EzTHQ5VXQrbFF0RkM5Mm1hNnJrSjByKzNYblFJNWZD?=
 =?utf-8?B?bmtUZEVKY0xlWk5DSlNXM0NuK0s0RkthUHVObitHL3JFTWtQeGg1aXBFVHlh?=
 =?utf-8?B?OHA2bzBLZ1o0QStEMEJoZ0E0Um5wR09ub1h2VllGcHdzaEFQNUJETGJhSjZC?=
 =?utf-8?B?QzdGNzRad28wMlVJMzFUaU9MYjk2aDZiOCs1ZEU2N2dUQThLMkM4K3g1S2ZW?=
 =?utf-8?B?RWhWalM2OEIzNEZFa1BydnpNbUFFbnNMcjNBdjBiWXQ1aEkyRzhISkk4cUJl?=
 =?utf-8?B?dnNraEluR0twNk9tQ3NzemxkbjhpaEJZSXMvdms0NUdob3JRRzk0blFoSmtZ?=
 =?utf-8?B?MVAreExub01TbGtXY0NKKzB0SjFHdzFiSlRGTDFTU3VFRE9QVlFhSnE5aGtE?=
 =?utf-8?B?bHdvaTJkUHRRU043RERscHhqRDZTamhXdlpQN3UzTDd5V3VVVkwzNDVtNVli?=
 =?utf-8?B?TVluckF2V3YxYi9EdUpQSVlhMnpJck1UQlBnRU9TK2hXZkg3R0d3WnUvTXZo?=
 =?utf-8?B?ZktnZmcwc1JQc2JmMTFZMm9abEI0TUJlUk1NelhLRlpCaXh4WWthZWtGeXRh?=
 =?utf-8?B?aWxYcTFIMEJYR0lzY1VxWVpXZWpzZTgvWGxQOE9ZMHZSZGxHaDZLUkhMYlA3?=
 =?utf-8?B?UUd0bi9wZXllUU44VXJOTW4xV3JoWFE1NVBheENQTDd4UnArZXFzeWZPMDVw?=
 =?utf-8?B?SVV0cjY3aDIvVjFJVDcvQnlaVExqTWtaSkt0NHJFVStpUk5WU0p1UDR6UzV2?=
 =?utf-8?B?bmFxdWd2Uld5ajFzVjRuSjFFSUxzYVp2NmZidzV0TEY1ZE1PRWlIT1VrSmxn?=
 =?utf-8?B?cTJzcmdlSHpIWThFeGlDSm9rMjlzZ2VnNzMrQWcyMzl0WHhSeFRZYy9MTGY0?=
 =?utf-8?B?ZmRnUWlibzVxd0xhcmJ0aXpjTXRXKzljMUhXUEgyWkxmRTBLdHAvQ1lmWnc4?=
 =?utf-8?B?OXcyM3h0aWN4dlJOM1ZhL3B5NzhYSE9DcU1DWEVIc0tKemtiU2toTXplenFV?=
 =?utf-8?B?SzVHOWxUQ2YvUkdXa0twYzRMczZZSXpQMzlyUm4zSnVkam9aMkFVK2RHSzVk?=
 =?utf-8?B?bHBVbGxvTjFsK1czQm9IRjdCUW9OSVNzZWpzamtySXFzdDJkYXBWT0U0QU9M?=
 =?utf-8?B?eC8zYTcwSTY0T2FaWnRTZk5WcGZsdnN0RkdCMUF0L0p3SEJHNFZUK2JtNlBY?=
 =?utf-8?B?UTJGd0V1a0xQNktraEJ6TTFRTkVTZVJ6R0ZualBqTmtGdUpCNjFYOURKZ0xY?=
 =?utf-8?B?WkN0ZzdsZTJnMmx3M1gvdmxhQkFJSEZNVFR1RXkwL0QySGJ1Z056ZHl6MjZI?=
 =?utf-8?B?a0RJOWlTMVhnN0t2Nm83UnpZa25aK3d2aUFuVlM0V3EvVHpVc1VsQUZGQTlw?=
 =?utf-8?B?M0NWV2NMK3plTEoxOC9lOGNEUmsrUGJKYXZYT0Vqd0hzci9uZFRNNkFpNEVZ?=
 =?utf-8?B?WFZMTHRwNHVkSnE0R1lKa0RXR29nc3Nua0JDd2lnTTlkSjJDY0FwYktrc2xF?=
 =?utf-8?B?TDdCWHpETzFmWTN2RDl4K09PWHZzL1NwbmczSEdJdjF6TlJ6UXdtSjY4QUpD?=
 =?utf-8?B?VkRhTys5NEx6SWFrS29lV2w4MWhGd3BHaGhmNmZSaEVsNU9vdDBhNW4ydTB3?=
 =?utf-8?B?b0VlWVZWTkNsa0hBNW5CVmtaaGxRTHJzZDc4c3NSOVpUWldUeW1VR0xIYmxr?=
 =?utf-8?B?S0ZzL2JtZUdSL01UZ0NzOU5Ca3l3OFBpbzArSzBZSE5wZUM4cUdVUzQxdHk4?=
 =?utf-8?B?RnhMcCtMZjJ6bEJ2dnJuajJwcWJibGkwMzlpWGJ1bWM2ZjhVd1VORFV1Yitx?=
 =?utf-8?B?VTJDdWtYQW14cVRwMnB1UnlSSFNWRFdPbGc3RlVsVEl1UU5rcG1hU3R6LzRW?=
 =?utf-8?Q?jm6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68588202-a5fa-479b-6347-08db0ea0301f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 15:28:56.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGqU2yH92G5ULx70UmyZsk70/pRa1poA6Eg3iYrS+x67uNHisyZ8JNKRNz1hXPg1V5CdEtIAj68Iv5PUCUE+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBFUCBzaWRlIHVzZSB2aG9zdCwgUkMgc2lkZSB1c2UgdmlydGlvLg0KPiA+IEkgZG9u4oCZdCB0
aGluayBhbnlvbmUgd29ya3Mgb24gdGhpcyB0aHJlYWQgbm93Lg0KPiA+IElmIHVzaW5nIGVETUEs
IGl0IG5lZWRzIGJvdGggc2lkZXMgdG8gaGF2ZSBhIHRyYW5zZmVyIHF1ZXVlLg0KPiA+IEkgZG9u
J3Qga25vdyBob3cgdG8gZWFzaWx5IGltcGxlbWVudCBpdCBvbiB0aGUgdmhvc3Qgc2lkZS4NCj4g
V2UgaGFkIGltcGxlbWVudGVkIHRoaXMgc29sdXRpb24gYXQgdGhlIGRlc2lnbiBzdGFnZSBvZiBv
dXIgcHJvcG9zYWwuDQo+IFRoaXMgc29sdXRpb24gaGFzIHRvIHByZXBhcmUgYSBuZXR3b3JrIGRl
dmljZSBhbmQgcmVnaXN0ZXIgdG8gdGhlIGtlcm5lbA0KPiBmcm9tIHNjcmF0Y2ggZm9yIHRoZSBl
bmRwb2ludC4gVGhlcmUgaXMgYSBsb3Qgb2YgZHVwbGljYXRlZCBjb2RlLCBzbyB3ZQ0KPiB0aGlu
ayB0aGUgc29sdXRpb24gMSBpcyBiZXR0ZXIsIGFzIEZyYW5rIHNhaWQuDQo+ID4gU29sdXRpb24g
MyhJIGFtIHdvcmtpbmcgb24pDQo+ID4NCj4gPiBJbXBsZW1lbnQgaW5maW5pYmFuZCByZG1hIGRy
aXZlciBhdCBib3RoIEVQIGFuZCBSQyBzaWRlLg0KPiA+IEVQIHNpZGUgYnVpbGQgRURNQSBoYXJk
d2FyZSBxdWV1ZSBiYXNlZCBvbiBFUC9SQyBzaWRl4oCZcyBzZW5kIGFuZA0KPiByZWNlaXZlDQo+
ID4gcXVldWUgYW5kIHdoZW4gZURNQSBmaW5pc2hlZCwgd3JpdGUgc3RhdHVzIHRvIGNvbXBsZXRl
IHF1ZXVlIGZvciBib3RoDQo+IEVQL1JDDQo+ID4gc2lkZS4gVXNlIGlwb2liIGltcGxlbWVudCBu
ZXR3b3JrIHRyYW5zZmVyLg0KPiBUaGUgbmV3IEluZmluaUJhbmQgZGV2aWNlIGhhcyB0byBpbXBs
ZW1lbnQgYW4gSW5maW5pQmFuZCBuZXR3b3JrIGxheWVyLg0KPiBJIHRoaW5rIGl0IGlzIG92ZXJl
bmdpbmVlcmVkIGZvciB0aGlzIHBlZXItdG8tcGVlciBjb21tdW5pY2F0aW9uLiBJbg0KPiBhZGRp
dGlvbiwgdGhlIGRyaXZlciBvZiB0aGUgSW5maW5pQmFuZCBkZXZpY2Ugc2hvdWxkIGJlIGltcGxl
bWVudGVkIG9yDQo+IGVtdWxhdGUgdGhlIGV4aXN0aW5nIEluZmluaUJhbmQgZGV2aWNlIHRvIHVz
ZSB0aGUgdXBzdHJlYW0gZHJpdmVyLiBXZQ0KPiB3YW50IHRvIHJlZHVjZSB0aGUgY29zdCBvZiBp
bXBsZW1lbnRhdGlvbiBhbmQgbWFpbnRlbmFuY2UuDQoNCkluZmluaWJhbmQgZHJpdmVyIGlzIHF1
aXRlIGNvbXBsZXguIFRoYXQncyByZWFzb24gd2h5IHByb2dyZXNzIGlzIHNsb3cgaW4gbXkNCnNp
ZGUuICBJIGhvcGUgdGhlIGVuZHBvaW50IG1haW50YWluZXIoa3cpIGFuZCBQQ0kgbWFpbnRhaW5l
cihCam9ybikgY2FuDQpwcm92aWRlIGNvbW1lbnRzLiAgDQoNCj4gPiBUaGUgd2hvbGUgdXBzdHJl
YW0gZWZmb3J0IGlzIHF1aXRlIGh1Z2UgZm9yIHRoZXNlLiBJIGRvbuKAmXQgd2FudCB0byB3YXN0
ZQ0KPiA+IHRpbWUgYW5kIGVmZm9ydHMgYmVjYXVzZSBkaXJlY3Rpb24gaXMgd3JvbmcuDQo+ID4N
Cj4gPiBJIHRoaW5rIFNvbHV0aW9uIDEgaXMgYW4gZWFzeSBwYXRoLg0KPiA+DQo+ID4NCj4gPg0K
PiBCZXN0LA0KPiANCj4gU2h1bnN1a2UuDQoNCg==
