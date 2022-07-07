Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADA56A3AD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiGGNad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiGGNac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:30:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718031912;
        Thu,  7 Jul 2022 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657200630; x=1688736630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/8Fo371fpiC7Q5pAFSqdvqORDJJP8y9MgS/Rp9NaJ4U=;
  b=iSrvIRWEqTJEp6dsHyVxtUweqlx+CCZ6M8AqhhLR7Wg5pgVSJOYYYN1l
   ZdMW2K6s4ZFXD1tIA12+6W9cwVzhWI6oFVA39oqS9ij9JXc+Roic1UyfV
   qBc7fdrrhqaDbtbmiEr+WuiZHOn6lF3dKYPd7dRiRe3cpDO9LqRUJOxZ/
   qkEQgCIZuGkz9mxRzmp2e9XthI7p03NNpxkgLQe6hgkioQ4LJNDRQ189x
   RXd+1PO+1fI12wc+up//DRyeBNBL0zUzSmZYWjOFNs8nmyfX7ah/P53gq
   KsewcMsWVh9xFrMVQSBtialUqR752NDBNn0QgTXOGB1kN4EwixtEtQU9Y
   g==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="181161214"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 06:30:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 06:30:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 06:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ligocp/LAItEYPN7LWKDj872dVSsUjMD1hyvWZpkryBYCE7wba/qujt+js6HUJUYJih0hNXSDQIWN4akwuTurifLrjooyZGqD3qZwNt//ksUwVVqD4iQJVfct2hHU/EiS67DBVfrNyfVEViyJ1zFK1J2mz0WGm5i+XbjcwRGEz8d9/P4NdtpvjIPA1nzjl6O0YzvWd9m8qp2wSNFkdDXNiy4Aew47SxfP2ys47ERZkM2VqWy42pRxG0gtwYLAqCr7jxFUe8xXe+/uNXyltr6lM970v/fz7SgRLk7uQrMjernee0zLy4nbjfjz6uQMan5StA2H/UDpT21tsGbqMzTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8Fo371fpiC7Q5pAFSqdvqORDJJP8y9MgS/Rp9NaJ4U=;
 b=mQMpFWJu2ZC3UVYQe7+gXoq/Zxm280DZ1iFAkesAtoY4dgg6FQ7DRVN84CXT25jUlqZORCjWH3iYeMHsBKcQU6Hy1q5gmOPA98QF7Bg2kbo68T+CTbwpuK9KgQkBBMgWgfMmvmpsB4TQrbnZcefIxIFnh0ZZVOfJp7mRELrAv2E6EyP6I+gGclK5Bd9FLFgiWb2mWej/HAXHZlEarKmQ/iwmLjJ+DdnUGbxsJ5AC7PKcd91oA3IMdjRFP/OmVQMwURxQ7gl3M/Id38oU2+yz7Xs6c1TYZKfplYQkrbx8FM9i2vRxz45wk24o6wGl0NgqokMzeopwZnbmzbOg9lw2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8Fo371fpiC7Q5pAFSqdvqORDJJP8y9MgS/Rp9NaJ4U=;
 b=oliGTSAZlRjElCRZw+zgdu5ifTLw+KDVT1IJy4M8f0m/+a/BCm9Ra4jxq3QMLQZnXnFz7h84PTq7Gq2+lgTJb33rTHwMcllK8psbEHPFqFymj93kssIoA7BnitSUi6zKgq+9XBPFFK+A5bQv2Z5QssJLkGeK4P7I0UvRKdkP8QU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR1101MB2302.namprd11.prod.outlook.com (2603:10b6:301:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 13:30:28 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 13:30:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@rivosinc.com>, <palmer@dabbelt.com>, <arnd@arndb.de>
CC:     <Conor.Dooley@microchip.com>, <Cyril.Jean@microchip.com>,
        <Daire.McNamara@microchip.com>, <Lewis.Hanly@microchip.com>,
        <aou@eecs.berkeley.edu>, <gregkh@linuxfoundation.org>,
        <herbert@gondor.apana.org.au>, <kw@linux.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <lorenzo.pieralisi@arm.com>, <mturquette@baylibre.com>,
        <paul.walmsley@sifive.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <sboyd@kernel.org>, <wsa@kernel.org>
Subject: Re: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Topic: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Index: AQHYhou4Yct9CdBHxU6rAH/n3LO9DK1y/l2A
Date:   Thu, 7 Jul 2022 13:30:27 +0000
Message-ID: <a39bad24-d2bb-ef3e-d57a-2ac4fa1156ef@microchip.com>
References: <20220622225822.2166305-1-mail@conchuod.ie>
In-Reply-To: <20220622225822.2166305-1-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70bb7d02-7385-491a-8457-08da601cdb28
x-ms-traffictypediagnostic: MWHPR1101MB2302:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MPXH7uY2Oxsx0apHeOKaziMWLhiwAHR4Lbso7Yl8Cv1+ty6MwI7XZSYKK8dtxJT7Wom3AIse3ImqaSs0bDv0QYWLxZem6RICUrhix6MoCbJUvft09qYzONUP7jFeJn2irmVEuZ409Qr5sVkBtcGUQjtpCRqjsA8fBVRythxl6S0KDH+vijtbG+YI4wsaWCg8zjbri/YmbIm8txZtWb+jFWBgCWVmFgT7JLXSO+uNm8MTe73f8pPLPRzdJTThnHaFhJJ4kyKMmjuIdXlKlTXnIeXiPZRZyuQnxsq9Z0dLEm6mv8mAjNByDJQLaQ5PccI3eq8Ke6omsWAEJZvrGu4z15BKmOgfMbpE3kZLYTEwdBuwGMhYO/NoA/H88Gl/xYkKNnbBQh1KibbzwhX1qtPn29i9lGJO6GB9d8TpR/792rYwAzwZNuupfiTMPb9M1vJbg6D020YyTnnQNPXjCIljK6IYLqWU0E6rsF6MOfjYiXUvXmcjuLcYj3BgtZdxpMZYB9Y4WBeA9L362rZSa5K9+ijubVryW0XTi6YuZACtyOqA1DAFISmpGqhQirXceMQ1i+XHbUQO6drD2JoQWuxM96f5X5LggrOVvtKliKp8sTeqNWJZQ7HnW4DbLAOpsJq6Ta3kbdm2kAlBGb8PH24buNjKy6n5XsLCJtNwKu8OWiwBGO4OuZ7c8tKzjzSRJyxVlswx09rosrEvDc5cZkY9X8GXEF+/fFHjpa0x9FHMIZTRozRnD0VE2+VUEW3zn01fcN0nBikP05naeMwS4hDd/e7pErfG6NqYfr+YoaV4hodkQmcuC9/GUcNu9MrIrQOVcm4+/i3P292JhkD8XPxP/x4gfOl7hhzausJ9B4dRTzi1SdfHDnXzA4l3Gq/yKfk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(346002)(376002)(316002)(38100700002)(31696002)(8936002)(66446008)(41300700001)(86362001)(5660300002)(38070700005)(31686004)(478600001)(6486002)(6506007)(36756003)(110136005)(122000001)(54906003)(26005)(2906002)(186003)(6512007)(53546011)(71200400001)(91956017)(8676002)(66946007)(2616005)(64756008)(7416002)(66476007)(76116006)(66556008)(83380400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVBTRTFXdkdvbS9vVkU1Tmh4SDBPMmliT1JmQ1JZMzNUMUVtVDE1MFlleXRH?=
 =?utf-8?B?Y0U4OVlUMnd6QkJaOGVoMHVMVXR1UjJ0aThVeWxUYWNiOTFtUm4zZzdWMzFo?=
 =?utf-8?B?bkxJditlQXNSNmlud1ZnSmpGcnJFRC92UmQ5djF0NVFtcEJxWnJKNExXOS9M?=
 =?utf-8?B?L1hMRkJVRlFIMEpOV3VTSU5sdjMrQk1SZ2pGWUp3RVNhdnRwTHVRRXMyY1ZF?=
 =?utf-8?B?MHJ3am5FZFBSOGdCWGpZL3E3bnYrdjJCYVVxL1NPbkN6c3htRm9sTHdWTVZl?=
 =?utf-8?B?SWpQUkRCSlhBRms5UDFuTHZRdWhid0FCUGdkcHZJR3lVNEsrS1dITkV4QUJl?=
 =?utf-8?B?OWc1Sy9wUnpSQXFBRGtGSE1zNGJrTFFKUG9rTHhDSUtqTEsvd1pDQlczbUhv?=
 =?utf-8?B?eEFpUUxoWEhJazBWcFhjanFPUDFabmhQamhpTWNFSmoxNFlGSjBoS2l1bms5?=
 =?utf-8?B?dFpGcUtRSURwWEdLc1o1SERoYVZLYmtUekd2cTlIdTlpZndUR2x5cDlxVUN5?=
 =?utf-8?B?bktsRWU2c244SHlrNGFCeFkwT1VES0VGNmZDV2hZU0pRNG5iQ0lXVlZzUUFz?=
 =?utf-8?B?dEJSR1NnUnk2aGFkUnpmOVV0WE1IZkRJcysxVDVpZ3ZXRW9scmJIeC9kZ3ZJ?=
 =?utf-8?B?K3VuRmU1bDV2R3F0RGpuQmhVcStVS1VMTXpUTW9pdUU4L0JITExCU28rYzdH?=
 =?utf-8?B?Zm11ZTFTZ2d6d2dxaGNMcmx4Y3N6NVNxWXlBOHpVSVFzN3VhdFhJUXdxS29E?=
 =?utf-8?B?V2xGSDN4a3g3ZU04dWlDYkd1UjByMEcvcDVla0lMZ01HU2FyazNZRlYwek9n?=
 =?utf-8?B?M1dJQkQzSmlLa0JMZmhTSHp1c2J2Mm4vUDFvN3pYK3paTTUwQ1dXR3JPc2Uv?=
 =?utf-8?B?SDBsTlc2VlpZVFJQWnQ0THU4T2tMaE9QWTA0dTJRNUdQUTgrUVVzeEhoRWFT?=
 =?utf-8?B?MVJYR0RQTEYyRks3SGlEdFJ5R2VGVXc0bkwrSHFYVkhxRDVYV0cwc2s1d1dn?=
 =?utf-8?B?N3hxcGlNOHJvK2FXZzRIMU1XTkRDMlRxRENtWXI0WWV1cEtabnZxdStPQVJj?=
 =?utf-8?B?OTc4T1N0K3VBeVNsY2NMZ3FkMFQ0VXA1TkdTUzVCaDhvZ3RjSURwQ2lXcGRG?=
 =?utf-8?B?MHNCTDk4OStuM0tyREdxcDYyUHVYK0krbWtQcFo4QXRhMDMyTWdIb3NuUjZu?=
 =?utf-8?B?QTMxNU5sWGV5M01ybnRiTWhjM2xoMkNsY3FDcG1GNEc0SE1rNEhFN2d5MVFq?=
 =?utf-8?B?R2ZyeWZ2aXJreitpVnYxYzRzSHorbE5uSDZkSmlFL2hVWUx6dnp5empQODJ3?=
 =?utf-8?B?RFhiajUva2lOQ3VmWGNIdzdUWFdnSkNqODd6cnZpVXpuUWhLUXY3eEVmNUF1?=
 =?utf-8?B?T280M0pRekhzL28rZXA3NTJQU3NLUkxuLzhReHBiRUtEemFFWnJmTFJOd1hu?=
 =?utf-8?B?K1dSZnNXTGJJTUhzUitOQzg2RG9zZVpZZUFqQXNvSW5nZmt4QXVlNkppN3VZ?=
 =?utf-8?B?c3BqZGVneUxlT1l2TjBnVDQ0NysycXZlNVpuMG5IbEpINGJnaGdnWnhnbGNG?=
 =?utf-8?B?QkR3Tm52aytCSEtzRFFXbDU0bThQd1drcS9DaGtvUGxtRXM2NzcrUm9ETXcr?=
 =?utf-8?B?aFhsRERaMTc0djFuK2J5N0hBMWRPVHJqMm9XRnhEZGdkRUNpWGpzWi90bGhX?=
 =?utf-8?B?YVY5Y2NGbHArdWJ0ZXRTT2hZcWt0ejNGTG4xa29mSkdCajR3SWIrNFEzbk5J?=
 =?utf-8?B?UGxYM09rM0VkM2YzbEIwSDVxekFvSzVxZ3FDNGJGT2V2b1BFb0lTMUNzZ3Rx?=
 =?utf-8?B?aEhOc3NHRUtscW9jK096Q0ozQ0FpZVBLSHdSVkE1RUNJUFZsSUFkcnM2RzdI?=
 =?utf-8?B?T3hiRWYwZjRKZWI0NmU4RjZSbWI2WW44VTV1Y2drMEdYbEFGUzVjaUlqUUtr?=
 =?utf-8?B?MW1ZZjlTL2pSNk1yYTV2dmpvZWNHZ1Z6QnlzdWRGQy9pV2ZGWWd4OXBVOWtX?=
 =?utf-8?B?dnh3ZkhwaEI0RTdDTU90UHE3clAyN2U5Z0dWU2ZvcXRKRDJmSk9UWnUyVlI1?=
 =?utf-8?B?VGtLUHlTTm0yWnYrMTRLODlHQk1vTzJLM1ZqQ2Fod1cvNHdFbktjUFZsR2hm?=
 =?utf-8?Q?0x0UpFROpu7ZeyeB9Gl+i770G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5008DDB5F7A787458E097BCB3A4266D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bb7d02-7385-491a-8457-08da601cdb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 13:30:27.8406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGkHf9zc7rXI7He/GPzcGwKb3e6w3begWVKgHVKpJdRs/X109KyrC9KahNgP4X/ZkQw3c5J6O9Jv9O3lYYjtHQdP6bp8I5ASyuMhMGAigDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2302
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjIvMDYvMjAyMiAyMzo1OCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBGcm9tOiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gSGFyZHdhcmUgcmFuZG9t
LCBQQ0kgYW5kIGNsb2NrIGRyaXZlcnMgZm9yIHRoZSBQb2xhckZpcmUgU29DIGhhdmUgYmVlbg0K
PiB1cHN0cmVhbWVkIGJ1dCBhcmUgbm90IGNvdmVyZWQgYnkgdGhlIE1BSU5UQUlORVJTIGVudHJ5
LCBzbyBhZGQgdGhlbS4NCj4gRGFpcmUgaXMgdGhlIGF1dGhvciBvZiB0aGUgY2xvY2sgJiBQQ0kg
ZHJpdmVycywgc28gYWRkIGhpbSBhcyBhDQo+IG1haW50YWluZXIgaW4gcGxhY2Ugb2YgTGV3aXMu
DQo+IA0KPiBBY2tlZC1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4g
QWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KQXJuZCwgUGFs
bWVyOg0KRG9lcyB0aGUgU29DIHRyZWUgbWFrZSBtb3JlIHNlbnNlIGZvciB0aGlzIHBhdGNoPw0K
SSBhbSBtaXNzaW5nIGFuIGFjayBmcm9tIEhlcmJlcnQgKGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQn
cyBibG9ja2luZw0KZm9yIGEgTUFJTlRBSU5FUlMgdXBkYXRlIHRvIG15IG93biBlbnRyeT8pLg0K
DQpJZiBTb0MgaXMgdGhlIGJldHRlciBvcHRpb24sIHNob3VsZCBJIHJlc2VuZCB0aGlzIHRvIHNv
Y0BrZXJuZWwub3JnPw0KVW5mb3J0dW5hdGVseSwgc2luY2UgSSBvcmlnaW5hbGx5IHNlbnQgdGhp
cyBwYXRjaCB0aGVyZSBoYXZlIGJlZW4NCm90aGVyIGNoYW5nZXMgdG8gdGhpcyBlbnRyeSB0aGF0
IHdpbGwgY29uZmxpY3QgaW4gLW5leHQgKGFsbCBhcmUNCmFkZGl0aW9ucyBzbyBlYXNpbHkgcmVz
b2x2ZWQuLi4pLg0KDQpJIHdhcyBob3BpbmcgdG8gZ2V0IHRoaXMgcGF0Y2ggYXBwbGllZCB0byB2
NS4xOS1yYyhmb28pIHNpbmNlIHdlDQpuZXZlciBhZGRlZCBtYWludGFpbmVycyBlbnRyaWVzIGZv
ciB0aGVzZSBkcml2ZXJzIHJhdGhlciB0aGFuIHdhaXQNCmZvciB2NS4yMC4NCg0KSWYgeW91IChw
bHVyYWwpIHdvdWxkIHJhdGhlciB3YWl0IGZvciB2NS4yMCwgSSBjYW4gcmVzdWJtaXQgdGhpcyBw
YXRjaA0KYWZ0ZXIgdjUuMjAtbXcxIHdpdGggYW4gYWRkaXRpb25hbCBpMmMgZW50cnkgKGlmIHRo
ZSBkcml2ZXIgaXMgYXBwbGllZCkNCnRoYXQgYWxyZWFkeSBoYXMgYW4gYWNrIGZyb20gV29sZnJh
bS4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gLS0tDQo+ICAgTUFJTlRBSU5FUlMgfCA1ICsrKyst
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggYTZkM2Jk
OWQyYThkLi4wMWE3YmZhNDliZGMgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBi
L01BSU5UQUlORVJTDQo+IEBAIC0xNzEzNiwxMiArMTcxMzYsMTUgQEAgTjoJcmlzY3YNCj4gICBL
OglyaXNjdg0KPiAgIA0KPiAgIFJJU0MtVi9NSUNST0NISVAgUE9MQVJGSVJFIFNPQyBTVVBQT1JU
DQo+IC1NOglMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlAbWljcm9jaGlwLmNvbT4NCj4gICBNOglD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiArTToJRGFpcmUgTWNO
YW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+DQo+ICAgTDoJbGludXgtcmlzY3ZA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiAgIFM6CVN1cHBvcnRlZA0KPiAgIEY6CWFyY2gvcmlzY3Yv
Ym9vdC9kdHMvbWljcm9jaGlwLw0KPiArRjoJZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9tcGZzLXJu
Zy5jDQo+ICtGOglkcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPiAgIEY6CWRyaXZl
cnMvbWFpbGJveC9tYWlsYm94LW1wZnMuYw0KPiArRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gICBGOglkcml2ZXJzL3NvYy9taWNyb2NoaXAvDQo+ICAg
RjoJaW5jbHVkZS9zb2MvbWljcm9jaGlwL21wZnMuaA0KPiAgIA0K
