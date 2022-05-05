Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1B51BDFA
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357041AbiEELbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354942AbiEELbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 07:31:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CD4AE25;
        Thu,  5 May 2022 04:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3N59MLoIibEmn3/J0fWNPm1UIbk2m7VByj6boOl4hdUOH6eAJP+HaftUsfxmAP7aLP0WABixG2KJKdHChu2Xsj6vmcxLQ+qbSoK8ytb9HGhC0buUw1dHqR5YVW8NejNCJy8E/rGy0vd7xJdFp/t1PnNm8cfdoBSyv0HfsFrsN18msMqVNJSXk8NDZUYrMyRR0JyNu4RgWcFTtIwayAQ7CEAoHnwesDix4ZKZe5P0l7pjsFDskohbBuE0jPsOIWbPdbuoaF85WsDmzFvdF7uD3CEU0as0+KDd2yjyWrLq5c60tb3sbk7G0fJvLbecr2AaOT976SCnCmG4sNHMurULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wephEJ2fCyzFhzhnbNGJCoRucTxasGxvU3MpVuDf4Fc=;
 b=nB2TXVFOnkPywGRBUDNxNsT81LGW7NArO3iXaR9qA6t7sa+GSu+ar+lFaRukkVyXcMFnMl0FiOMFjODxBNfsqHJWygOLnPHkDOHfHPKcdSPl/5vvq90uAHGAkhnc/fF2pXu7XlYRPxhP5ipYYgROMGDVDZylm0HL0wVTqgbC3fucBSLCE5dIK6VcdGgSrKUm0nbtCd/qA4NvpKOzntuy2n7Hb7oczNveh7HhV2rOLw3Rnugg0WEU0IzDRR8KvD5BArYdKypac/6IvhYocYTlXJsQQsCX2Sq2nd9UHyaxlTUe+C/IoUdbrmUZeQfvY1dQ9sZc8VIDHoKztOvC/hDpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wephEJ2fCyzFhzhnbNGJCoRucTxasGxvU3MpVuDf4Fc=;
 b=ta6MElKgnyNVX7DirztUHh/r7shbIQMO2Q/k7jKE9rsDchkxZACCq+eCHZpd/YO3UunSbTNLoCft67fCPje/x37ZxsRYci4fhHB+fAmHu6BXES1s7XdZdd6p1RLZy0AJHonXMl6ZiW1eUBAMwSxCjlmKQgR8tdd7PHOMNDd09OU=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DM6PR05MB5370.namprd05.prod.outlook.com (2603:10b6:5:59::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 11:27:06 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::ec67:d45c:ad2c:fa04]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::ec67:d45c:ad2c:fa04%9]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 11:27:06 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "ymcavikas@gmail.com" <ymcavikas@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Srinidhi Rao <srinidhir@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v3] PCI: Speed up device init by parsing capabilities all
 at once
Thread-Topic: [PATCH v3] PCI: Speed up device init by parsing capabilities all
 at once
Thread-Index: AQHYKKuQAeTeBB9b9kSyHQSQaUy/Ba0Q8PSA
Date:   Thu, 5 May 2022 11:27:06 +0000
Message-ID: <8773546D-E43A-4951-9713-44A09025AF5A@vmware.com>
References: <6827AF44-4412-4ABA-A66B-562D7E86C847@vmware.com>
 <1645616049-19712-1-git-send-email-akaher@vmware.com>
In-Reply-To: <1645616049-19712-1-git-send-email-akaher@vmware.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.47.21031401
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02452f4e-0415-42c8-39ff-08da2e8a2f97
x-ms-traffictypediagnostic: DM6PR05MB5370:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <DM6PR05MB537084CA6A6CCA7801061C8ABBC29@DM6PR05MB5370.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+ntHmpn4DksgyQrX6qV5hZqfiTZdFdIBGOmZxiCFb37FSWT+dTnGyiwhfmKLwGxPHgLSCkW/wG3BOOWC2WmzuXWa8U/R01KJjHoitlHcRRn9GBjZkWc+rQMzhZ8wjuiwVMS3j32Bt2Kly8m3sT0LeglJm+JrEAUw8Tb0v4U08R+mGYAddH6PbU0uJRy1reP3IlsoT/W3t//qbiOl7p8qjhTKY7IABRys1Ta/hNcgS6H5yaUQULwCzijD0/eONQ7/Opl8ld/75Vbr59C6TH7KrDgpYHXWJGvvtrhFYDzq91qMTZnK7oGjjpFnCz1EeTgPSZ8m3klr0W09T7xTDG6gRCB5ExXYjBWVXL/jkcdQF054ZqYIk5as0if09V0hTbMpwWCV9x67KhUH8WWJbs0gQ09cm0Qr/fhiEZDoEp6sI3HVhv+7sAY8OV8/C2wIaqFBqOrIK7sduI9PquY4kMPy2ztTuecqE4KyYw4UMJhmV3mjsusd4i0hIV+rHkEN96fcTq9XTdCUrpApbP9FbYyJ4YoFwdNGE8kPiEhL7illIwV9oEyi5t6pfcJmloGdXxR0bPLPUy4Fv/sJ24Pk71hOxg9T2GBs5+M5ei3MMI7BjbmhYn2VlBg7fx5db6GQkmp++jI7PRFtGsEJD80LC1mCTr42Gq01PSuYVsrnepeiHY6WBBqudU36VNlOZJjtn+2g9LELt5Wk15juso8vbld3CORPmZeB3C3gVQUL4W1w8hpsIshURPPpd8+Z7D53zu0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(316002)(71200400001)(66556008)(66476007)(64756008)(110136005)(54906003)(66446008)(6486002)(4326008)(8676002)(76116006)(5660300002)(508600001)(91956017)(8936002)(36756003)(107886003)(6506007)(33656002)(2906002)(26005)(6512007)(38100700002)(2616005)(38070700005)(83380400001)(122000001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVR2UXlGSUwvVk1XcCt4MmNKRjRVcVdPbE9RNUgxamk0T1RreDhpd3AyMkNH?=
 =?utf-8?B?S3hjWDNzQzZFNWFxeUU5eWVSdHZ4OXJQUXNHSHVOdzY2ZUpHbEJZWHUrMzdz?=
 =?utf-8?B?aGZWa2pycGNqSlIxNDFuQTRJbUZuTGt2RXFBMVk3WWR6clA3aE5RdzRwOU9X?=
 =?utf-8?B?V1BMTHJkcXlBYm4rWlpTRXExa01RWkpydUZoN3phdlo5TERIVXh4MkVRN3Ra?=
 =?utf-8?B?UkVJMXBqOUE3dFFnZXBKYXdWUkFlcVpxQ2FCSklPOEF0UDlCVjIxS2h4OTh3?=
 =?utf-8?B?U05PS2NPTGd5NFlrMlNXWmtETEdXdGEvVGxVWHBaZ2NBckNFL3VZNHljS0t2?=
 =?utf-8?B?Y054eFY0eFVTYnJWZVhMUlJRN2h6UlRDKzN2cUJwRit0N291U2M5VU5OUVBK?=
 =?utf-8?B?V0p5azdacnRWU05ZUG1HZFJoeGlmYVhjQmxOcmhqR3l6eXpVYVhiRlZGQ09W?=
 =?utf-8?B?QUszRnVzOWFqQ29ybEJpcjZ3WWtNZU9ZM1NSMElTcFJhYjFEektWdWxUZjcv?=
 =?utf-8?B?Q3ZHK0VYcVVKSmZPMHVTbWJGSDNhK1dESi9tSGQ5dXo0SmVyK3RidVREVXpT?=
 =?utf-8?B?bnE3dXZkMEw3M3FYUDdrVEhnVkhFZW56ZmZmc0Q2eENvVm1VdksyRVltUVJq?=
 =?utf-8?B?LzFRdThRalBPZk1WelNoaVFENUlEMTBPZTBHSmpLTk4wUG9NRkEwOFpFWkEw?=
 =?utf-8?B?VHRDNzhMSk9PM3VzWjZpV0RhVzlRUTdkb0c2azk4cHZiRU1RQkhjMGRXZWEx?=
 =?utf-8?B?VUErR3d4OUlhQVQ2U09JaEFZYWZMYUtiUEo2TWk4Z0s4NXBwVTNuWXZUQU1T?=
 =?utf-8?B?RHFjdGlZek5ORXZJUWZCYWwyUUhZUzRTRGc4U0FmQSthK2NHRmdKdjdnRTRD?=
 =?utf-8?B?UGlPNGVaRmo0bENYc3BGa2J4NWhoVWRoMzVORWZFejRnSUNkZUxGYjVpbWRO?=
 =?utf-8?B?clk0U2ZXYXdVcGRVZlgzNTAxcGIwNzFaZ2VGTlpPL29PRGJjUVVxaEF6SnNK?=
 =?utf-8?B?Tkc2YXArelhPd01ueG1yRDBmRkdDNjkrVW16YlA3L2hmbzB4dnVlc0JyTUFL?=
 =?utf-8?B?RENoeUF2dkVWRDM1T0ZlSnZ3blppSWFCZUUzQ3FPbE9JN204RlpzTFoxejl3?=
 =?utf-8?B?UjNBS05jOGUwQXNROFZxL0R1NjdKVXpwOHpDZTNWc0Jzdit2QnhFZWgwaCtQ?=
 =?utf-8?B?YUZlMXFOaEZBNllwYUJ5S0R0UjY1UnlSV0NhdHluUU91bHFGNFFWaGlsWk5Y?=
 =?utf-8?B?ZjNiUkNtbjdaTDlmdmRmTHVZZlRxUGZxc21wSTZkTEJIdTVJMVlSZVpYQUs1?=
 =?utf-8?B?ejNyTjYyb3dUUCtXaHdqYkRYSTY0NnFTQkVrZmZ2QlU2a3dSSmxOMDl6MGo0?=
 =?utf-8?B?ZlRuS1RQcytmWjIwTHRqdnFGT2Jldjd3bmtrbHRNcTMzeUhSMWU5bk14SktB?=
 =?utf-8?B?NnlMN3RWemc3dC9WSjhUWkE2WTlVZ2F0REJRdU55Y3NLN3IzTU5KSSsxZlNT?=
 =?utf-8?B?QzZOVFVCTFJBbTAwSEJ2SERNVHRFMCtPS0xzUjRIV0VGeHovNUlpb2pJN21h?=
 =?utf-8?B?Q3Boa01Uc25oNDFYR1BHVDUzUDdGdHdSTlRNQjJVRmE5Zi9GTXNVQzM2c2VI?=
 =?utf-8?B?QmRUSmVKa2UwOFZSKy9xVStSRmdrU0wzd21qYnQybUFaNnBCVXk1TlMvVEls?=
 =?utf-8?B?a1U1SDEvU3lmRG45QmFLdW1vTmpHU2dETzUvNkE2WkhBRmlPVlRzNlJpVFRm?=
 =?utf-8?B?MVJVeGl1WlJ4NlNQZmJONC9kWDRNS0dkSE1PUTNsb1RrdW9ZclJpNUFUZWxk?=
 =?utf-8?B?dFhxSWU5UDk5NFdxc01rSHFpRlY1WDU1U00vOXhIbGFFYWF2eWV2Z2NFNjly?=
 =?utf-8?B?ZnhOM2kvdG56dFpzSzMwUXcwTllhM1dyNDFFdCtQdXdtaXVCSzlTTWVYTGJq?=
 =?utf-8?B?bzJ3a2FYai9tcU8xOThoOU52VkFXMW5BT3hvRzZoZktHK04vQTE5K2xyRkN5?=
 =?utf-8?B?S3VGYk5nZUhBWk9PZlMxMWhNNjQveS9hMCtYaUl4ajQxZG5ZK0VCTk5oRGNh?=
 =?utf-8?B?U09iTkhvMXgyYmhYYStsV2JDUzg3b1RMajNTaFdKVlp2c0JNSG1IQm11Tzhm?=
 =?utf-8?B?U2RadmhBbFFDdFRPU0Q4U2tlUTVKZ24rQVdqZnNmVWh4RWdjTDNrbHFaWWVM?=
 =?utf-8?B?blBhTGtta2dEeU1wWjdwU2R2WHB0bHh2UUJPdDFkeTlndHdXcGc5YzFvZlpB?=
 =?utf-8?B?dkI1YXh3Y3RzYnBFa05DZHZ6K0IvcGZsZGNWK28wbFc0aENUMlpFbnB2bWwy?=
 =?utf-8?B?czhDMFNHWEdkYmovWE5CSFRkcUV3QUNNcEI1Z3dYQU5RQzMzeWZBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFBD414163BF3549B1263BA1DEF071A8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02452f4e-0415-42c8-39ff-08da2e8a2f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 11:27:06.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT7Qv2YW2GnL0SOvbF2nSt9TZPsGYT5Tyu6sdImECd88lFCBAJ68sQ/GnTCK0o+7Tkl2O8YCMuyUVOsyyNVw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5370
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQrvu79PbiAyMy8wMi8yMiwgNToyMCBQTSwgIkFqYXkgS2FoZXIiIDxha2FoZXJAdm13YXJlLmNv
bT4gd3JvdGU6DQoNCj4gRnJvbTogVmlrYXNoIEJhbnNhbCA8YnZpa2FzQHZtd2FyZS5jb20+DQoN
CkJqb3JuLCBhcyBwZXIgeW91ciBndWlkYW5jZSB3ZSBzZW50IHYzIChob3BlIGl0J3MgYXMgcGVy
IHlvdXIgZXhwZWN0YXRpb24pLiANCg0KUGxlYXNlIGxldCB1cyBrbm93IGlmIHlvdSBhcmUgbG9v
a2luZyBmb3IgbW9yZSBpbXByb3ZlbWVudCBvciANCndhbnRlZCB1cyB0byByZS1zZW50IHRoaXMg
cGF0Y2guDQoNCi1BamF5DQoNCj4gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHRoZSBQ
Q0kgY2FwYWJpbGl0eSBsaXN0IGlzIHBhcnNlZCBmcm9tDQo+IHRoZSBiZWdpbm5pbmcgdG8gZmlu
ZCBlYWNoIGNhcGFiaWxpdHksIHdoaWNoIHJlc3VsdHMgaW4gYSBsYXJnZSBudW1iZXINCj4gb2Yg
cmVkdW5kYW50IFBDSSByZWFkcy4NCj4gDQo+IEluc3RlYWQsIHdlIGNhbiBwYXJzZSB0aGUgY29t
cGxldGUgbGlzdCBqdXN0IG9uY2UsIHN0b3JlIGl0IGluIHRoZQ0KPiBwY2lfZGV2IHN0cnVjdHVy
ZSwgYW5kIGdldCB0aGUgb2Zmc2V0IG9mIGVhY2ggY2FwYWJpbGl0eSBkaXJlY3RseSBmcm9tDQo+
IHRoZSBwY2lfZGV2IHN0cnVjdHVyZS4NCj4gDQo+IFRoaXMgaW1wbGVtZW50YXRpb24gaW1wcm92
ZXMgcGNpIGRldmljZXMgaW5pdGlhbGl6YXRpb24gdGltZSAgYnkgfjItMyUNCj4gKGZyb20gMjcw
bXMgdG8gMjYxbXMpIGluIGNhc2Ugb2YgYmFyZSBtZXRhbCBhbmQgNy04JSAoRnJvbSAyMDFtcyB0
byAxODRtcykNCj4gaW4gY2FzZSBvZiBWTSBydW5uaW5nIG9uIEVTWGkuDQo+IA0KPiBJdCBhbHNv
IGFkZHMgYSBtZW1vcnkgb3ZlcmhlYWQgb2YgMjBieXRlcyAodmFsdWUgb2YgUENJX0NBUF9JRF9N
QVgpIHBlcg0KPiBQQ0kgZGV2aWNlLg0KPiANCj4gUmFuIHBhaG9sZSBmb3IgcGNpX2RldiBzdHJ1
Y3R1cmUuIFRoaXMgcGF0Y2ggaXMgbm90IGFkZGluZyBhbnkgcGFkZGluZw0KPiBieXRlcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFZpa2FzaCBCYW5zYWwgPGJ2aWthc0B2bXdhcmUuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBBamF5IEthaGVyIDxha2FoZXJAdm13YXJlLmNvbT4NCj4gDQo+IC0tLQ0K
PiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gICAtIEFkZGVkIGNoZWNrIGJlZm9yZSBhY2Nlc3MgY2Fw
X29mZiBmcm9tIHBjaV9maW5kX2NhcGFiaWxpdHkoKS4NCj4gICAtIE1vdmVkIGRlY2xhcmF0aW9u
IG9mIHBjaV9maW5kX2FsbF9jYXBhYmlsaXRpZXMoKSB0byBkcml2ZXJzL3BjaS9wY2kuaC4NCj4N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gIC0gUmFuIHBhaG9sZSB0b29sLg0KPiAgLSBNb2RpZmllZCBj
b21tZW50cyB0byBhZGQgImNsb2NrIHRpbWUiLg0KPiAgLSBSZW1vdmVkIGNvbW1lbnRzIGJlZm9y
ZSBjYWxsIHRvIHBjaV9maW5kX2FsbF9jYXBhYmlsaXRpZXMuDQo+DQo+IC0tLQ0KPiBkcml2ZXJz
L3BjaS9wY2kuYyAgIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0NCj4gZHJpdmVycy9wY2kvcGNpLmggICB8ICAxICsNCj4gZHJpdmVycy9wY2kvcHJvYmUu
YyB8ICAxICsNCj4gaW5jbHVkZS9saW51eC9wY2kuaCB8ICAxICsNCj4gNCBmaWxlcyBjaGFuZ2Vk
LCA0MCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvcGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPiBpbmRleCAzZDJmYjM5Li5jZjU0
ODExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0KPiArKysgYi9kcml2ZXJzL3Bj
aS9wY2kuYw0KPiBAQCAtNDY5LDYgKzQ2OSw0MCBAQCBzdGF0aWMgdTggX19wY2lfYnVzX2ZpbmRf
Y2FwX3N0YXJ0KHN0cnVjdCBwY2lfYnVzICpidXMsDQo+IH0NCj4NCj4gLyoqDQo+ICsgKiBwY2lf
ZmluZF9hbGxfY2FwYWJpbGl0aWVzIC0gUmVhZCBhbGwgY2FwYWJpbGl0aWVzDQo+ICsgKiBAZGV2
OiB0aGUgUENJIGRldmljZQ0KPiArICoNCj4gKyAqIFJlYWQgYWxsIGNhcGFiaWxpdGllcyBhbmQg
c3RvcmUgb2Zmc2V0cyBpbiBjYXBfb2ZmDQo+ICsgKiBhcnJheSBpbiBwY2lfZGV2IHN0cnVjdHVy
ZS4NCj4gKyAqLw0KPiArdm9pZCBwY2lfZmluZF9hbGxfY2FwYWJpbGl0aWVzKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpDQo+ICt7DQo+ICsJaW50IHR0bCA9IFBDSV9GSU5EX0NBUF9UVEw7DQo+ICsJdTE2
IGVudDsNCj4gKwl1OCBwb3M7DQo+ICsJdTggaWQ7DQo+ICsNCj4gKwlwb3MgPSBfX3BjaV9idXNf
ZmluZF9jYXBfc3RhcnQoZGV2LT5idXMsIGRldi0+ZGV2Zm4sIGRldi0+aGRyX3R5cGUpOw0KPiAr
CWlmICghcG9zKQ0KPiArCQlyZXR1cm47DQo+ICsJcGNpX2J1c19yZWFkX2NvbmZpZ19ieXRlKGRl
di0+YnVzLCBkZXYtPmRldmZuLCBwb3MsICZwb3MpOw0KPiArCXdoaWxlICh0dGwtLSkgew0KPiAr
CQlpZiAocG9zIDwgMHg0MCkNCj4gKwkJCWJyZWFrOw0KPiArCQlwb3MgJj0gfjM7DQo+ICsJCXBj
aV9idXNfcmVhZF9jb25maWdfd29yZChkZXYtPmJ1cywgZGV2LT5kZXZmbiwgcG9zLCAmZW50KTsN
Cj4gKwkJaWQgPSBlbnQgJiAweGZmOw0KPiArCQlpZiAoaWQgPT0gMHhmZikNCj4gKwkJCWJyZWFr
Ow0KPiArDQo+ICsJCS8qIFJlYWQgZmlyc3QgaW5zdGFuY2Ugb2YgY2FwYWJpbGl0eSAqLw0KPiAr
CQlpZiAoIShkZXYtPmNhcF9vZmZbaWRdKSkNCj4gKwkJCWRldi0+Y2FwX29mZltpZF0gPSBwb3M7
DQo+ICsJCXBvcyA9IChlbnQgPj4gOCk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICsvKioNCj4gICAq
IHBjaV9maW5kX2NhcGFiaWxpdHkgLSBxdWVyeSBmb3IgZGV2aWNlcycgY2FwYWJpbGl0aWVzDQo+
ICAgKiBAZGV2OiBQQ0kgZGV2aWNlIHRvIHF1ZXJ5DQo+ICAgKiBAY2FwOiBjYXBhYmlsaXR5IGNv
ZGUNCj4gQEAgLTQ4OSwxMyArNTIzLDkgQEAgc3RhdGljIHU4IF9fcGNpX2J1c19maW5kX2NhcF9z
dGFydChzdHJ1Y3QgcGNpX2J1cyAqYnVzLA0KPiAgICovDQo+IHU4IHBjaV9maW5kX2NhcGFiaWxp
dHkoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IGNhcCkNCj4gew0KPiAtCXU4IHBvczsNCj4gLQ0K
PiAtCXBvcyA9IF9fcGNpX2J1c19maW5kX2NhcF9zdGFydChkZXYtPmJ1cywgZGV2LT5kZXZmbiwg
ZGV2LT5oZHJfdHlwZSk7DQo+IC0JaWYgKHBvcykNCj4gLQkJcG9zID0gX19wY2lfZmluZF9uZXh0
X2NhcChkZXYtPmJ1cywgZGV2LT5kZXZmbiwgcG9zLCBjYXApOw0KPiAtDQo+IC0JcmV0dXJuIHBv
czsNCj4gKwlpZihjYXAgPj0gUENJX0NBUF9JRF9NQVgpDQo+ICsJCXJldHVybiAwOw0KPiArCXJl
dHVybiBkZXYtPmNhcF9vZmZbY2FwXTsNCj4gfQ0KPiBFWFBPUlRfU1lNQk9MKHBjaV9maW5kX2Nh
cGFiaWxpdHkpOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5oIGIvZHJpdmVy
cy9wY2kvcGNpLmgNCj4gaW5kZXggM2Q2MGNhYi4uM2NiNzBkNSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9wY2kvcGNpLmgNCj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmgNCj4gQEAgLTg3LDYgKzg3
LDcgQEAgYm9vbCBwY2lfYnJpZGdlX2QzX3Bvc3NpYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0K
PiB2b2lkIHBjaV9icmlkZ2VfZDNfdXBkYXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0KPiB2b2lk
IHBjaV9icmlkZ2Vfd2FpdF9mb3Jfc2Vjb25kYXJ5X2J1cyhzdHJ1Y3QgcGNpX2RldiAqZGV2KTsN
Cj4gdm9pZCBwY2lfYnJpZGdlX3JlY29uZmlndXJlX2x0cihzdHJ1Y3QgcGNpX2RldiAqZGV2KTsN
Cj4gK3ZvaWQgcGNpX2ZpbmRfYWxsX2NhcGFiaWxpdGllcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KTsN
Cj4NCj4gc3RhdGljIGlubGluZSB2b2lkIHBjaV93YWtldXBfZXZlbnQoc3RydWN0IHBjaV9kZXYg
KmRldikNCj4gew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMv
cGNpL3Byb2JlLmMNCj4gaW5kZXggMDg3ZDM2NS4uZDc1ZTFmYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9wY2kvcHJvYmUuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+IEBAIC0xODM5
LDYgKzE4MzksNyBAQCBpbnQgcGNpX3NldHVwX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0K
PiAJZGV2LT5oZHJfdHlwZSA9IGhkcl90eXBlICYgMHg3ZjsNCj4gCWRldi0+bXVsdGlmdW5jdGlv
biA9ICEhKGhkcl90eXBlICYgMHg4MCk7DQo+IAlkZXYtPmVycm9yX3N0YXRlID0gcGNpX2NoYW5u
ZWxfaW9fbm9ybWFsOw0KPiArCXBjaV9maW5kX2FsbF9jYXBhYmlsaXRpZXMoZGV2KTsNCj4gCXNl
dF9wY2llX3BvcnRfdHlwZShkZXYpOw0KPg0KPiAJcGNpX3NldF9vZl9ub2RlKGRldik7DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KPiBp
bmRleCAxOGE3NWM4Li5iZDYxY2VlIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGNpLmgNCj4gQEAgLTMyNiw2ICszMjYsNyBAQCBzdHJ1
Y3QgcGNpX2RldiB7DQo+IAl1bnNpZ25lZCBpbnQJY2xhc3M7CQkvKiAzIGJ5dGVzOiAoYmFzZSxz
dWIscHJvZy1pZikgKi8NCj4gCXU4CQlyZXZpc2lvbjsJLyogUENJIHJldmlzaW9uLCBsb3cgYnl0
ZSBvZiBjbGFzcyB3b3JkICovDQo+IAl1OAkJaGRyX3R5cGU7CS8qIFBDSSBoZWFkZXIgdHlwZSAo
YG11bHRpJyBmbGFnIG1hc2tlZCBvdXQpICovDQo+ICsJdTgJCWNhcF9vZmZbUENJX0NBUF9JRF9N
QVhdOyAvKiBPZmZzZXRzIG9mIGFsbCBwY2kgY2FwYWJpbGl0aWVzICovDQo+ICNpZmRlZiBDT05G
SUdfUENJRUFFUg0KPiAJdTE2CQlhZXJfY2FwOwkvKiBBRVIgY2FwYWJpbGl0eSBvZmZzZXQgKi8N
Cj4gCXN0cnVjdCBhZXJfc3RhdHMgKmFlcl9zdGF0czsJLyogQUVSIHN0YXRzIGZvciB0aGlzIGRl
dmljZSAqLw0KPiAtLQ0KPiAyLjcuNA0KDQoNCg==
