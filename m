Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1456BF54
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiGHQpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbiGHQpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:45:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EDE005;
        Fri,  8 Jul 2022 09:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoN82lBuVPVAhEdNpWhGA55aDnZqRSSG/P2WOxUFZ9jvN19SurX0FRWqGhwJflR48zIJaiWe3GzhnK8weXSnziqwX8FJeYWHVGe54lnkaML6FlIpS4S3ADqxtZrlmRIsPrsX5aM8/7GPonG1p6f+C3tnnv+Zq3A4jjcQEpPhqv9DWnuerjYWKQubKsqaCBFYLAnXdV99GMEAYGweF3aIFA9cIiY1ImCVGIGKah0TG/bA9MhZvBNT50jbHQuZyUwlhRepadvGegJAwg3AWeY1EYUMLdVjgxj0cPVyZ+D4bPeHocF27kf4grsPn87yTROeMgDTE5XYs1JLOdu0G9/Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJMapcwEpQTL8k0hUZaJlaDn0KJCWsd4KvzGaGew0UI=;
 b=a1NcGVUcGvFp1zWYuZebNmGGmGviAIBcIfvtagspQxLzLefP+Xyh0i974M0+paJqfHd9XWX9kFqddBW2FOoyMUD/SsgQYC53LLCDo1FQwsgpI1FuOUzAbLbK/mhb8NSK09Vnp3BLCU+IOFu9Wia8B+8SMmx99lQSm+2m7tK4o5fu6o1nj3l6zXzBQQ4STbRNlCdvLg6bwi47VY8LbuSvUrN4FEdSsBWGf30PSlOPZlyQyr0TtgqzUZTpRn6HEekJ6cMd0QXNMeddp6MuTYogJT2klrCZ43Z7VajpcgwnxbmSwQezuJaRc3esCDrWekKjnuSZKdCVYXpp/q2ccv7t0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJMapcwEpQTL8k0hUZaJlaDn0KJCWsd4KvzGaGew0UI=;
 b=mqDqaie3h80BUnz7YNUKoxUGTPVfyL2btXSdawjJZ0bZRyPlFgE+H6qKDOwM27gT5sfWjYtHEeo6EdUei2HxMAp9uioUXhtWyCL8KFUx3G7qhXTvvjWsWFjhOiq/Q5wlW3/TIpo8pXz5blDpqaIXOPz7OopB1qCn8O4LD7fVkKg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH2PR05MB7144.namprd05.prod.outlook.com (2603:10b6:610:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.14; Fri, 8 Jul
 2022 16:45:00 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 16:45:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Ajay Kaher <akaher@vmware.com>, Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Thread-Topic: [PATCH] MMIO should have more priority then IO
Thread-Index: AQHYiw9NzqWSNRsR1kyxPrXhcjObWa1lHkCAgA7qdoCAAHWQAIAAP7qA
Date:   Fri, 8 Jul 2022 16:45:00 +0000
Message-ID: <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
In-Reply-To: <YsgplrrJnk5Ly19z@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a3917dd-8a06-4398-70a6-08da61013317
x-ms-traffictypediagnostic: CH2PR05MB7144:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVUxZpHIllMX3gWUfH7mF6yA7ldgt1HB3czIHmaS8rXhiNGwFBPCpdXztRCy8vmcdauGwKic/RO6qoeNNi7SXjANAi+PjNsL1PON2yTaalNBhDllVZYDrGNsFLXcXtSL3FODX2suLus9tIz69TeiTTczsFTncY+WYvMZI5SgLM46fHAoSp2bbY38gA+tm+iDSfH8Cpx67paXnbH7Wl6JgW+SLENvDb/XwKM6YKnUDPqOBfP5wI/gaVXjAHHqHrA87+4gw2LCqPTMFGHyr/7JVPdYkSGT+mrIlFKAFWnFslY5uJZu+QoEv+ngIh7djSWyYG/hxKg7isQtJwhD9yc88DrxOpot4EvD/hI+SFDPTxAqc47NRA0KFxmnLhx08eYvm0Key60esaY4LzQz8wN+XFnLHIj0eiG+mnhewVA+PWvceRCLHuu7ivjaH6hswWXdI7wM4clS/F9mq88FJUp98xoFc+zERwzqMaSUJOJdpzy17oJ0UJSmPAG17pnhkuAWN3nj9wOrBSGSLWqeh/hLCNuuC1Tx/vbUDM9POOvdIUVuavgxk08mGpQhAPQ2NebHYn/7zaXJ78KqtagoE+YxCKl/40NYu1KLFF29SGcCB80peJ5Lo98mCe4pso+Nlr55zntR28El4zDs8swhoR9P64lhJGYQDaX1fcu8g8qRHA3/VGRHCLFCq7hYWMgrNANVtmUI8j3tC0EJ50YM7IeR0qTw28ZKcnPz83+QqpIwJa7cRU/H7j042AWu7XjZHo4+EO8ADgpad0P7p0YFN++v+lyNPYU/xgQIij0+eT2f5nWvM2Cs0MAmheD5Z30pIpyC9Iy5maGD497VsPVCmhF4xf2xISCiLahOAgwdHyRAy7o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(478600001)(6506007)(6916009)(38100700002)(6486002)(53546011)(186003)(64756008)(66446008)(33656002)(36756003)(54906003)(66946007)(8936002)(8676002)(2906002)(66556008)(41300700001)(316002)(71200400001)(2616005)(45080400002)(6512007)(26005)(7416002)(4326008)(83380400001)(86362001)(122000001)(5660300002)(76116006)(38070700005)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enJQb0YxWkthcFFlMk94aGZjb05mVVNCRUR5cVVwYm1tb2JpSGpWNzRXeDJG?=
 =?utf-8?B?c293eXUyTVBJcVpJODNiOW45T3VYdllqaG5mU1JpaEY3NnI0WC9WNlR1OFR3?=
 =?utf-8?B?MjNWUVd2M25JUE9UZ2hUZS83OVNKNVhBRHdyeWZYaXF2MWVLVTRoT281MzlH?=
 =?utf-8?B?enRreCs4RTVTNnFVSjlVQ0x0STQ1Q1dkMFJUQngxUWRXNzNTRG9hZ0Y0VGRn?=
 =?utf-8?B?aDRtTE12RHdIK3VsM25zUWpIcFRLT3lOaEpWbzlXQm4xZUtZaEM2MmRXRkNw?=
 =?utf-8?B?U3V6Qmp5ZmNNT09TcmUzMHN3Z25Za2UvZnNQbnN1eGRnS0E5WDVZY2RFZ01K?=
 =?utf-8?B?YkpQaGxPOXJCZU9QY3ZyZVZJaW9HbG94RjQwQmlwbVR0Wnd6NWtSd0puczJX?=
 =?utf-8?B?N0x5bWxIN254a1c1MUVITnVFTTh5bndrZk50aCtZUjhQdzZXajFWWlpyRjFw?=
 =?utf-8?B?NkVsUGxMWDcvN05tOFJ4c0xkQm5VTUxlcHhHOERmWm9ldFNDNEVnM1pZaGls?=
 =?utf-8?B?UElQSVdhYnZWcDY5bGlnUk5OL0hYTmdxVVFyVk0vN3Npd1NYS0orTXBTczJ1?=
 =?utf-8?B?Q2w0aUtucUdYZWVvVFhoay8zekpCM3Z0eDRMNWRoTVNkQzdjdyt4Wnk3RnZa?=
 =?utf-8?B?YnZLdFAwcGdXRGNYNzV5TGUwWDFpL2JiRDQwVXZtUUdMaGFkWGVKSnE1bnZG?=
 =?utf-8?B?V3h5WnpEUnVVeG9tVDNCQUQwSVFjeVc1aDhWMXdXSTJMZ1hsSXBLdmk3Z3NX?=
 =?utf-8?B?S2tTeGJQd0FySzlmSFRTNFJZdE5TTERsTmhxM2hkN0hjaE15bW1ENi9TaE9a?=
 =?utf-8?B?aCtjSmc4VGhQUFBoTmNhTmpHWHBqMHd3cnVCYlN5ZXdWcjJWeVdLY0UydUNu?=
 =?utf-8?B?REtZVE50aG1vTXgrblkyWHo4enJJdlVQaDhLM1pGaThDb2JWSElmU3cyb0ZG?=
 =?utf-8?B?Z3Q1Z3VtTUNDK0ZUaWN0bk1LazhYdEgxUkFhL1FoTGhjeGNtOGp1MmIzZWpu?=
 =?utf-8?B?ajNMZzg5Qi9OVE40WlYxWnI2djdTaWNBVy9oU1VJVVJGdFp2OUF2d3FNRWFC?=
 =?utf-8?B?VlBHTE05SENpYVArTmJWSUxibXBMeURkY2hHVU9XOVl1SDhCZjNMeVE5QTRp?=
 =?utf-8?B?KzB6OGYzOC83aDArdm1WYW5PdU9LODFmSEhKaEZLNjBlTG5ObitNNGdIbW9K?=
 =?utf-8?B?Z3pBSktXQk5LREQ3MzF6TjFTQmJyMzhGUjAzQmx1dmw0enlXK2h1OTBxZXlE?=
 =?utf-8?B?OTBBUEI2MXVaZmlYOU5yL2tkWG03ZGU1MDJ3VnNVdEFENk5CRTdMMkdoaHRB?=
 =?utf-8?B?MmJDQ2t5RW9aWXQ2NXNPK2ZRR3RWcVNremZTNzlyalZSODVCcndxTE5GWGls?=
 =?utf-8?B?amN2b1lzUEF1Qm9ROHA2VlNnZkVPMWVadTFnSkRuVzFFa0cxNXJDaWZKaUY2?=
 =?utf-8?B?cGxkdnJ5RGEvbUt3YVRLeFF3NUx6VTNWU29GV0ZnMEhoZlBnOVBLcExtT0VJ?=
 =?utf-8?B?bTRkOEdHSkpJZ09XM3FIVnhGS0RyWHpSYUhPUndyemZLbjI2UFpKT2huRnE0?=
 =?utf-8?B?ZmliYlhmU212eVNzZkdCVVVZbXBvaGQ2UjRCMlZyN2orNFdqZDVTZFJ5ZUEr?=
 =?utf-8?B?d2pUQ2hNckNlWXErNnAxbDNOK0tVM2NPQXRycVlrS3hDekMyZGNRU1NWeEpj?=
 =?utf-8?B?WDR3dzg4QjdhbFZVWFRRdG4zNWkxK2doRlJaaEJ5ck1IT3JUVTFOLy9MNUxa?=
 =?utf-8?B?VkE5UWpnTlJUTWxkdUFsMDJNem10YnB1U2Qvay9ZaEgrOE1ha2dlR0FBRmg4?=
 =?utf-8?B?cHlQZ2V2TXBsaHl3eEdVTm5Qb0syaGxwc1YwQkVwMHYxRlhPQjVydnVzZlZT?=
 =?utf-8?B?dG9adFZlcnhDUXRxOTFKQVgwai9UdmVvWGZUYTNkWEU4WmVGaEFWNUlVNUpx?=
 =?utf-8?B?bEQzeXpycG1CU3BCNkJCN0xOSmNHMnpMODQ2cng1Ymh3SWN6ZnQvclpKZDNp?=
 =?utf-8?B?RWFQdEdsYUxBckdKTEwxUXhVdnp4aXlDRVJ6UjVyY204bEFRQmNYZ2xURS82?=
 =?utf-8?B?U1FjbkdTSUNDb3dhUFBJZmpzT3JOWVNIcklhclc5MnVtT1hveHppYVlBUFYz?=
 =?utf-8?Q?VeSkG0Gz4iIHPkWSDXuiHLBxi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <458D88FC099C9247B36928A9787BC561@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3917dd-8a06-4398-70a6-08da61013317
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 16:45:00.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h18o2An/U7kPrTq4vcFQZu+z3Xl58Z7Gh1dPUfZOLUYKljTekbeqr6pFp85UUJoUB8cDZG/tID344YGrjvAC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR05MB7144
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDU6NTYgQU0sIE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRl
YWQub3JnPiB3cm90ZToNCg0KPiBBbmQgbG9va2luZyBhdCB0aGUgcmVzdWx0cyBhYm92ZSwgaXQn
cyBub3Qgc28gbXVjaCB0aGUgUElPIHZzIE1NSU8NCj4gdGhhdCBtYWtlcyBhIGRpZmZlcmVuY2Us
IGl0J3MgdGhlIHZpcnR1YWxpc2F0aW9uLiBBIG1taW8gYWNjZXNzIGdvZXMNCj4gZnJvbSAyNjlu
cyB0byA4NXVzLiBSYXRoZXIgdGhhbiBtZXNzaW5nIGFyb3VuZCB3aXRoIHByZWZlcnJpbmcgTU1J
Tw0KPiBvdmVyIFBJTyBmb3IgY29uZmlnIHNwYWNlLCBoYXZpbmcgYW4gImVubGlnaHRlbm1lbnQi
IHRvIGRvIGNvbmZpZw0KPiBzcGFjZSBhY2Nlc3NlcyB3b3VsZCBiZSBhIG1vcmUgcHJvZml0YWJs
ZSBwYXRoLg0KDQpJIGFtIHVuZmFtaWxpYXIgd2l0aCB0aGUgbW90aXZhdGlvbiBmb3IgdGhpcyBw
YXRjaCwgYnV0IEkganVzdCB3YW50ZWQgdG8NCmJyaWVmbHkgcmVnYXJkIHRoZSBhZHZpY2UgYWJv
dXQgZW5saWdodG1lbnRzLg0KDQrigJxlbmxpZ2h0ZW5tZW504oCdLCBBRkFJSywgaXMgTWljcm9z
b2Z04oCZcyB0ZXJtIGZvciAicGFyYS12aXJ0dWFsaXphdGlvbiIsIHNvDQpsZXTigJlzIHJlZ2Fy
ZCB0aGUgZ2VuZXJpYyB0ZXJtLiBJIHRoaW5rIHRoYXQgeW91IGNvbnNpZGVyIHRoZSBiYXJlLW1l
dGFsDQpyZXN1bHRzIGFzIHRoZSBwb3NzaWJsZSByZXN1bHRzIGZyb20gYSBwYXJhdmlydHVhbCBt
YWNoaW5lLCB3aGljaCBpcyBtb3N0bHkNCndyb25nLiBQYXJhLXZpcnR1YWxpemF0aW9uIHVzdWFs
bHkgc3RpbGwgcmVxdWlyZXMgYSBWTS1leGl0IGFuZCBmb3IgdGhlIG1vc3QNCnBhcnQgdGhlIGh5
cGVydmlzb3IvaG9zdCBydW5zIHNpbWlsYXIgY29kZSBmb3IgTU1JTy9oeXBlcmNhbGwgKGNvbmNl
cHR1YWxseTsNCnRoZSBjb2RlIG9mIHBhcmF2aXJ0dWFsIGFuZCBmdWxseS12aXJ0dWFsIGRldmlj
ZXMgaXMgb2Z0ZW4gZGlmZmVyZW50LCBidXQNCklJVUMsIHRoaXMgaXMgbm90IHdoYXQgQWpheSBt
ZWFzdXJlZCkuDQoNClBhcmEtdmlydHVhbGl6YXRpb24gY291bGQgaGF2ZSAqcGVyaGFwcyogaGVs
cGVkIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mDQpQSU8vTU1JTyBhbmQgaW1wcm92ZSBwZXJmb3Jt
YW5jZSB0aGlzIHdheS4gSWYsIGZvciBpbnN0YW5jZSwgYWxsIHRoZQ0KUElPL01NSU8gYXJlIGRv
bmUgZHVyaW5nIGluaXRpYWxpemF0aW9uLCBhIHBhcmF2aXJ0dWFsIGludGVyZmFjZSBjYW4gYmUg
dXNlDQp0byBiYXRjaCB0aGVtIHRvZ2V0aGVyLCBhbmQgdGhhdCB3b3VsZCBoZWxwLiBCdXQgaXQg
aXMgbW9yZSBjb21wbGljYXRlZCB0bw0KZ2V0IGEgcGVyZm9ybWFuY2UgYmVuZWZpdCBmcm9tIHBh
cmF2aXJ0dWFsaXphdGlvbiBpZiB0aGUgUElPL01NSU8gYWNjZXNzZXMNCmFyZSDigJxzcHJlYWTi
gJ0sIGZvciBpbnN0YW5jZSwgZG9uZSBhZnRlciBlYWNoIGludGVycnVwdC4NCg0KUGFyYS12aXJ0
YXVpbHphdGlvbiBhbmQgZnVsbC12aXJ0dWFsaXphdGlvbiBib3RoIGhhdmUgcHJvcyBhbmQgY29u
cy4NClBhcmEtdmlydHVhbGl6YXRpb24gaXMgbWFueSB0aW1lcyBtb3JlIGVmZmljaWVudCwgYnV0
IHJlcXVpcmVzIHRoZSBWTSB0bw0KaGF2ZSBkZWRpY2F0ZWQgZGV2aWNlIGRyaXZlcnMgZm9yIHRo
ZSBtYXR0ZXIuIFRyeSB0byBydW4gYSBsZXNzLWNvbW1vbiBPUw0KdGhhbiBMaW51eCBhbmQgaXQg
d291bGQgbm90IHdvcmsgc2luY2UgdGhlIE9TIHdvdWxkIG5vdCBoYXZlIGRyaXZlcnMgZm9yIHRo
ZQ0KcGFyYXMtdmlydHVhbCBkZXZpY2VzLiBBbmQgZXZlbiBpZiB5b3UgYWRkIHN1cHBvcnQgdG9k
YXkgZm9yIGEgcGFyYS12aXJ0dWFsDQpkZXZpY2VzLCB0aGVyZSBhcmUgbWFueSBkZXBsb3llZCBP
U2VzIHRoYXQgZG8gbm90IGhhdmUgc3VjaCBzdXBwb3J0LCBhbmQgeW91DQp3b3VsZCBub3QgYmUg
YWJsZSB0byBydW4gdGhlbSBpbiBhIFZNLg0KDQpSZWdhcmRsZXNzIHRvIHZpcnR1YWxpemF0aW9u
LCBBamF54oCZcyByZXN1bHRzIHNob3cgUElPIGlzIHNsb3dlciBvbg0KYmFyZS1tZXRhbCwgYW5k
IGFjY29yZGluZyB0byBoaXMgbnVtYmVycyBieSAxNjVucywgd2hpY2ggaXMgc2lnbmlmaWNhbnQu
DQpFbXVsYXRpbmcgUElPIGluIGh5cGVydmlzb3JzIG9uIHg4NiBpcyBpbmhlcmVudGx5IG1vcmUg
Y29tcGxleCB0aGFuIE1NSU8sIHNvDQp0aGUgcmVzdWx0cyBoZSBnb3Qgd291bGQgbW9zdCBsaWtl
bHkgaGFwcGVuIG9uIGFsbCBoeXBlcnZpc29ycy4NCg0KdGw7ZHI6IExldOKAmXMga2VlcCB0aGlz
IGRpc2N1c3Npb24gZm9jdXNlZCBhbmQgcHV0IHBhcmF2aXJ0dWFsaXphdGlvbiBhc2lkZS4NCkl0
IGlzIG5vdCBhIHNvbHV0aW9uIGZvciBhbGwgdGhlIHByb2JsZW1zIGluIHRoZSB3b3JsZC4=
