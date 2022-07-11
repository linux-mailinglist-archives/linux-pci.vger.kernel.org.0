Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92B65708A1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGKREx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKREw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 13:04:52 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013000.outbound.protection.outlook.com [52.101.64.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E462AC5C;
        Mon, 11 Jul 2022 10:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD1LLWSDOoB410wQVJddrsXNcdzgEPo3JLgBazd6BZxwjovx6QXkzaB1KmIV24iNYQGmCmt/Ul2jX6poBK+EWhQdtD1uDIeVi4WzZTNEDY17SVU3ByDM5BR+Scoce8dUZNO5QUAb4h+PgOiZygPiXr9dEJGGuk9vb3igx4PHnScD9yaQySHOS4EFZFtob2QhCQXSiaXD40vgQ4LMOMbX4BNAiQKy20zkL5H8/XHP6FzHuS7d411TMgTDbO6oW3Eyg5srHdzQU1zMliAOurzqMQHE05d+IVAdozDKi4h7rmQt4wr57Ddms5lqAop4bY3SM1DU/w0eyRI/pXEjBsgiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ofbtdHvaZZ+53MvPzMLuWOFN/quyq0J3ciMHliXfo=;
 b=Q9IQ5ltmMnz9tjhFWR/1AO7ON7ZBNaQhRvrMsmzA0moW2NBjBvAONRM10xd+PcRHK3TpfsaahxlTs0iT1GjWQnsmxnMrv18jmHdNzIHFauwfUo/DrdFHBWvUmSRxkizwmZhzJ0zMJvqT96pFW2aeGzAjrXNyL/kdKHnWZQvEt5EL5qVal/b7mzfVX8LFi1k8DWmJguCDhHCC+T8fhFc0KD9fBIfB5tNKzBnwyx30c9idIv5dnsCbOQkJMUZzh9QizvSsIJ5Snx//FLQYx3rsvAZOu0uv5aXIMIL0TaTDw7uyVr1OxI9MQl9gQbz4OcuzKWhdLQmgJkj1Wfl+Q4QEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ofbtdHvaZZ+53MvPzMLuWOFN/quyq0J3ciMHliXfo=;
 b=OxMDw66XgALqoLAZEsTAB61MNvEs7rv+isewiuFcM0pZ4s3En5+7bMJxCoWtmJnoo1os4vNV7FWDEWanCrMAsYSUOpuu2VqOTzwk5tanVAB36bLVmuJ0UHtJ+R6XrZLo7SJS3bDuC8DCITnRu+zvGszzzv2Zfgr0sipO/v9TXCA=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6783.namprd05.prod.outlook.com (2603:10b6:208:181::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.13; Mon, 11 Jul
 2022 17:04:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5438.011; Mon, 11 Jul 2022
 17:04:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Thread-Topic: [PATCH] MMIO should have more priority then IO
Thread-Index: AQHYiw9NzqWSNRsR1kyxPrXhcjObWa1lHkCAgA7qdoCAAHWQAIAAP7qAgAATwgCAAAszgIAAAjYAgAASVwCAA9g2AIAAsM+A
Date:   Mon, 11 Jul 2022 17:04:48 +0000
Message-ID: <83C436BD-E12E-420C-B651-B3788F1C4683@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
 <85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com>
 <4E0E503E-64E1-4B0A-B96A-0CD554A67107@vmware.com>
In-Reply-To: <4E0E503E-64E1-4B0A-B96A-0CD554A67107@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f11ef783-fea6-4d86-4cfd-08da635f761f
x-ms-traffictypediagnostic: MN2PR05MB6783:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eo5Tx5hoEwiIVlnxBh0xeKvnKyNuDmntOFaq0g3qhoBdEob8hq6Q0bX/JxrJqI17tvaXGOoDCR95cEvF6bwPhkOt5NBB/EcQRWCdelNvyHn4j1dAtNYO/c7Sf9x30qvgXrTgl/W0U2ZTShOOJ7WcvRE8dJx09fuMFSQPFsH4+f9yWyzydsme6KCNl3k6zjp4YudCmx2TX4uZYJHONBTnxiQGsdZz96JCnZOArqvhI4O338W5T7mYpVmEkAkZp1gLxRw83kPXIcZbmrskfSrTPW/e9qL2xDEVF08rGLHkRNq37SbfjHWje3dKA5nKLNiym1zyuS3T+49BIUKRbPXQaFQ/3SfjRH2b49Dcv4EGZ3d0+HIJRHmvKyH9Ymki0fQbB0DI6lDGkuU6SIgy1dRGFYEqaoYjNqxJ0zqTdIJWwsr0CyofcZhqOAZyWYovieYXocrf1ldTp0C7Orn6xkOTK3E1LyAc5PsBcYrtUBnTSYJvrsVnvImzkrx0pWXtYsslIl6NhwCc9UP8IhOI5E3JJI8LHJd2H+PAg/Cghc+/0lXjUrGKxTL1Ob/vrj9gnXyey5ff4GXGtJzac5fIykZFtT9oxVHp7Zkouf82EzWtHAgx9FpDbOg9AI6CNMDl3+OmSsbxHJSPvIjPy5tjFB3qrXtP1WG47iaO7tmbTaJEAoyzGgIJeqrMQE2YFc1/VvT+6/dH9vc1W46eom8D3l0R8EX8B3asrQ2u48iy6htD8O5LFO8/Q1G334Ax13lAm5DN+eCsP50/w6NGGkwNhDw/eMikTm4CbdJ1UOKM56BnVL+sW42aJIGOQK8dCA4SygCxjonMpiGVg81qmODT4365al3YyRsZ2KqiWDc8W/+NrXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(6486002)(478600001)(66946007)(66446008)(38100700002)(53546011)(83380400001)(66476007)(41300700001)(2906002)(38070700005)(8936002)(71200400001)(6506007)(5660300002)(36756003)(186003)(33656002)(54906003)(6512007)(107886003)(2616005)(26005)(86362001)(8676002)(6916009)(122000001)(4326008)(76116006)(66556008)(7416002)(316002)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk9vNERVcUdESG03OEN2emFNQXRrcmlpN1JhaERHK21iY2UxV09ueTB2Nysy?=
 =?utf-8?B?eXIrSW1VR3BEMWJVR3pWSE9nVExoSUM1R1R5UVdhaUNZbHk2dEV5QUxQRkcv?=
 =?utf-8?B?TnVFQ1pTSWY0Um8zY3NWb2tHUTlTT2YwUVd5U2d4N3NiUmh0dEk2bEpNWkVQ?=
 =?utf-8?B?NTdjalZ3ek1HZ0w2ZUF4cVBxOVZVZ2dOTWJFUEh4MHdwbGFrYUlvRkl1eHNh?=
 =?utf-8?B?NllWN05aR25saDNTdk5zZXZzc2hNaHRRMFV2a0FmR1U1YzY1ekpPc0pQRkJj?=
 =?utf-8?B?V3ZWREhxZGF0Vkh5VUhIOW1hSlgyOXlWOGR1eHNsY1BsTi9hc3FpU0J1SWta?=
 =?utf-8?B?TmNheVRGSEN0RU9oMzQvQThTYjZ5VWtFN094SWY3SVZnRzdNL000MUxiNkJS?=
 =?utf-8?B?ZFRyY1VnY2pXSzJjVENmRFJiRmY3SWdKaDlmaWhyZ29pclBjWHo3NGVzN0h5?=
 =?utf-8?B?ZTJBNHQ3UzNGcGE4a0pmcHY2TjFwalordytiTHVrUXU2UUtadTNkRVg4OU1Z?=
 =?utf-8?B?TXZWQVdFNWNKZnNiRktaZllvbkh4SWkzWEtiRlJpTkswUG8rZ1pjMmE4WnlM?=
 =?utf-8?B?V0JmRnkxSGdhRlQ0YU56VHI1VWFsOUlZTVh3a2U1ekNUaDVVNkhKSWxNRlhj?=
 =?utf-8?B?Z3lnd1pXNUtWMDhzNStIeENuNDZJSElTcjIxUUtMNkk0bDk0bkx1L24veis4?=
 =?utf-8?B?bEhMMU1rSkh3TDZybHd5Si9nRFVjZmpsZnVjMXJoQnFsT1NuaWQrb0FkNWF2?=
 =?utf-8?B?QlNOdmJlSUtudnZHeEIrZkVlSkVhR0xCd0ZCaUJqZnhqRld2NXo5bnIwVzdW?=
 =?utf-8?B?VEhZc0FsSmpDOWdpSDJiZzduRHErTGVDekc1WHl0NDdrNlM1NVd3YjJoT0Qr?=
 =?utf-8?B?YXpwcGRpZ1dGcW1tSThCbTBJajFOZkwvbVNJOEl0MlBEcXNsNENuWG5kQUlo?=
 =?utf-8?B?TUM2U2RTa3ltc1poYXRJZmdremw1aEU3d0g2dFpucjBvMC9xK3RzTzFKUWhi?=
 =?utf-8?B?b0R5SVoxQWpPOTFnMGVFVlVOVlVBYXAzbVY2RjBnODEwOHcvZWI1VU93bDZ6?=
 =?utf-8?B?ZE45MVJ0UHk2WXIxUVNFdFBSODdzRmtDakFyelhTTTdlUktLb3REYXQ1VDNU?=
 =?utf-8?B?dm82ek1FYzlhMWJlUnpodVRRWTFTQ3VUdzk2cUhlYUt6aWpKY3h0Y21vRzhn?=
 =?utf-8?B?eWJ1bjhadXFGZndZRkhoNm52dmJwVTRaUGQ0TVJBRStqL1pNa1ltRitBUlBL?=
 =?utf-8?B?S1RwYTd6ak9uRjhrMnV1Z2Zoc2RLL1lzWDdxcmxaWVFmSVZXTzZxRUpEQm05?=
 =?utf-8?B?dzh2RWxqc3RZOWVOVTVPd21maFRXd0YwckNQV2FMTGFrZnNEajRScS9JdlN0?=
 =?utf-8?B?TFk3R1dUcmUxeUdHL1k4Y29uWXhycnpSbVJOTXVmcC92L09NVmgzcEVEOTZj?=
 =?utf-8?B?QnpWNnRUeXNtNnZEUFY2K0M4VWNGd3RoUzJEdnFLd0tBT0FWbzlkVWZMazZF?=
 =?utf-8?B?cDYxYVErSFl6bU9Zc2EvUmNoMC9tU2hwRktMa0RCWVRWMHlLL21EMmp3cXJ0?=
 =?utf-8?B?cFc0c3dGclpCdmlZcFh1ODc3ZVhQRVlKcU8yT2UzYkI4bDFkbXZWYk9qdmxs?=
 =?utf-8?B?emVoZGZZbjB6QnVpZFBhb1VKSzFrRVpXUzAxS1hyQ09RTmtweVlrNXlZa3Nr?=
 =?utf-8?B?bHl4NGhJSDhkV0YyTzBlWVpWQXdCUnllcGNTM1FqdU45dTViaHRuMzdVM1JL?=
 =?utf-8?B?dEFNcTVRbDJlMVVwRTJqeTVjMXh4NzhqZEFlZm84cHZ5N3hrSHIrUGUyVWhG?=
 =?utf-8?B?Y0wvcmFiODdma2RaL1BGcG52c0UxdGljMEQzQ2RLYWFQUGJtZ3F4RVhWMnFW?=
 =?utf-8?B?M255dDkvSGVIZU5UTWFRbGJiQmxhS1ZiU21ZOFRYK2Vabk1XdUJtQ1NhNjRU?=
 =?utf-8?B?cExvTk9oQm9pNk9rUE9Ubmtva1V3aXJCekZ1NHFwS0hyMk9MRnE5SDdxTlJT?=
 =?utf-8?B?cVhBRXhXTys3UmJBNmpzS281ZWtxcVlkNHFXaVdNQzJLeEs0bkM3eTRsa3ZM?=
 =?utf-8?B?T3Q2K1FydytEaEN1NGd0WEtQdSs5dnRyMTdpRGZGWVpUSVo5NkNldFduSW9H?=
 =?utf-8?Q?9wcg6MVAd8BmpY42cGifTInUT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D398CFDCEFBF6E44B0223F4ACCE2CE97@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ef783-fea6-4d86-4cfd-08da635f761f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 17:04:48.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTq2JjD4vIZ7t2MZeCV0paX0ymgSl+oeKCQBJwloRlwGdBnMVB//9LEO2X9N9gEpemWMPrwFD9TuEHYrsyzoxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6783
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gSnVsIDEwLCAyMDIyLCBhdCAxMTozMSBQTSwgQWpheSBLYWhlciA8YWthaGVyQHZtd2FyZS5j
b20+IHdyb3RlOg0KDQo+IE9uIDA5LzA3LzIyLCAxOjE5IEFNLCAiTmFkYXYgQW1pdCIgPG5hbWl0
QHZtd2FyZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIEp1bCA4LCAyMDIyLCBhdCAxMTo0MyBBTSwg
TWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4+PiBJIGhh
dmUgbm8gbWlzY29uY2VwdGlvbnMgYWJvdXQgd2hhdGV2ZXIgeW91IHdhbnQgdG8gY2FsbCB0aGUg
bWVjaGFuaXNtDQo+Pj4gZm9yIGNvbW11bmljYXRpbmcgd2l0aCB0aGUgaHlwZXJ2aXNvciBhdCBh
IGhpZ2hlciBsZXZlbCB0aGFuICJwcm9kIHRoaXMNCj4+PiBieXRlIi4gRm9yIGV4YW1wbGUsIG9u
ZSBvZiB0aGUgbW9yZSBpbnRlbnNpdmUgdGhpbmdzIHdlIHVzZSBjb25maWcNCj4+PiBzcGFjZSBm
b3IgaXMgc2l6aW5nIEJBUnMuIElmIHdlIGhhZCBhIGh5cGVyY2FsbCB0byBzaXogYSBCQVIsIHRo
YXQNCj4+PiB3b3VsZCBlbGltaW5hdGU6DQo+Pj4gDQo+Pj4gLSBSZWFkIGN1cnJlbnQgdmFsdWUg
ZnJvbSBCQVINCj4+PiAtIFdyaXRlIGFsbC1vbmVzIHRvIEJBUg0KPj4+IC0gUmVhZCBuZXcgdmFs
dWUgZnJvbSBCQVINCj4+PiAtIFdyaXRlIG9yaWdpbmFsIHZhbHVlIGJhY2sgdG8gQkFSDQo+Pj4g
DQo+Pj4gQmluZ28sIG9uZSBoeXBlcmNhbGwgaW5zdGVhZCBvZiA0IE1NSU8gb3IgOCBQSU8gYWNj
ZXNzZXMuDQo+IA0KPiBUbyBpbXByb3ZlIGZ1cnRoZXIgd2UgY2FuIGhhdmUgZm9sbG93aW5nIG1l
Y2hhbmlzbToNCj4gTWFwIChhcyByZWFkIG9ubHkpIHRoZSAndmlydHVhbCBkZXZpY2UgY29uZmln
IGkuZS4gNEtCIEVDQU0nIHRvDQo+IFZNIE1NSU8uIFZNIHdpbGwgaGF2ZSBkaXJlY3QgcmVhZCBh
Y2Nlc3MgdXNpbmcgTU1JTyBidXQNCj4gbm90IHVzaW5nIFBJTy4NCj4gDQo+IFZpcnR1YWwgTWFj
aGluZSB0ZXN0IHJlc3VsdCB3aXRoIGFib3ZlIG1lY2hhbmlzbToNCj4gMSBodW5kcmVkIHRob3Vz
YW5kIHJlYWQgdXNpbmcgcmF3X3BjaV9yZWFkKCkgdG9vazoNCj4gUElPOiAxMi44MDkgU2VjLg0K
PiBNTUlPOiAwLjAxMCBTZWMuDQo+IA0KPiBBbmQgd2hpbGUgVk0gYm9vdGluZywgUENJIHNjYW4g
YW5kIGluaXRpYWxpemF0aW9uIHRpbWUgaGF2ZSBiZWVuDQo+IHJlZHVjZWQgYnkgfjY1JS4gSW4g
b3VyIGNhc2UgaXQgcmVkdWNlZCB0byB+MTggbVNlYyBmcm9tIH41NSBtU2VjLg0KPiANCj4gVGhh
bmtzIE1hdHRoZXcsIGZvciBzaGFyaW5nIGhpc3RvcnkgYW5kIHlvdXIgdmlld3Mgb24gdGhpcyBw
YXRjaC4NCj4gDQo+IEFzIHlvdSBtZW50aW9uZWQgb3JkZXJpbmcgY2hhbmdlIG1heSBpbXBhY3Qg
c29tZSBIYXJkd2FyZSwgc28NCj4gaXQncyBiZXR0ZXIgdG8gaGF2ZSB0aGlzIGNoYW5nZSBmb3Ig
Vk13YXJlIGh5cGVydmlzb3Igb3IgZ2VuZXJpYyB0bw0KPiBhbGwgaHlwZXJ2aXNvci4NCg0KSSB3
YXMgY2hhdHRpbmcgd2l0aCBBamF5LCBzaW5jZSBJIHBlcnNvbmFsbHkgZGlkIG5vdCBmdWxseSB1
bmRlcnN0YW5kIGhpcw0KdXNlLWNhc2UgZnJvbSB0aGUgZW1haWwuIE90aGVycyBtYXkgaGF2ZSBm
dWxseSB1bmRlcnN0b29kIGFuZCBjYW4gaWdub3JlDQp0aGlzIGVtYWlsLiBIZXJlIGlzIGEgc2hv
cnQgc3VtbWFyeSBvZiBteSB1bmRlcnN0YW5kaW5nOg0KDQpEdXJpbmcgYm9vdC10aW1lIHRoZXJl
IGFyZSBtYW55IFBDSSByZWFkcy4gQ3VycmVudGx5LCB3aGVuIHRoZXNlIHJlYWRzIGFyZQ0KcGVy
Zm9ybWVkIGJ5IGEgdmlydHVhbCBtYWNoaW5lLCB0aGV5IGFsbCBjYXVzZSBhIFZNLWV4aXQsIGFu
ZCB0aGVyZWZvcmUgZWFjaA0Kb25lIG9mIHRoZW0gaW5kdWNlcyBhIGNvbnNpZGVyYWJsZSBvdmVy
aGVhZC4NCg0KV2hlbiB1c2luZyBNTUlPIChidXQgbm90IFBJTyksIGl0IGlzIHBvc3NpYmxlIHRv
IG1hcCB0aGUgUENJIEJBUnMgb2YgdGhlDQp2aXJ0dWFsIG1hY2hpbmUgdG8gc29tZSBtZW1vcnkg
YXJlYSB0aGF0IGhvbGRzIHRoZSB2YWx1ZXMgdGhhdCB0aGUg4oCcZW11bGF0ZWQNCmhhcmR3YXJl
4oCdIGlzIHN1cHBvc2VkIHRvIHJldHVybi4gVGhlIG1lbW9yeSByZWdpb24gaXMgbWFwcGVkIGFz
ICJyZWFkLW9ubHnigJ0NCmluIHRoZSBOUFQvRVBULCBzbyByZWFkcyBmcm9tIHRoZXNlIEJBUiBy
ZWdpb25zIHdvdWxkIGJlIHRyZWF0ZWQgYXMgcmVndWxhcg0KbWVtb3J5IHJlYWRzLiBXcml0ZXMg
d291bGQgc3RpbGwgYmUgdHJhcHBlZCBhbmQgZW11bGF0ZWQgYnkgdGhlIGh5cGVydmlzb3IuDQoN
CkkgaGF2ZSBhIHZhZ3VlIHJlY29sbGVjdGlvbiBmcm9tIHNvbWUgc2ltaWxhciBwcm9qZWN0IHRo
YXQgSSBoYWQgMTAgeWVhcnMNCmFnbyB0aGF0IHRoaXMgbWlnaHQgbm90IHdvcmsgZm9yIGNlcnRh
aW4gZW11bGF0ZWQgZGV2aWNlIHJlZ2lzdGVycy4gRm9yDQppbnN0YW5jZSBzb21lIGhhcmR3YXJl
IHJlZ2lzdGVycywgc3BlY2lmaWNhbGx5IHRob3NlIHRoZSByZXBvcnQgaGFyZHdhcmUNCmV2ZW50
cywgYXJlIOKAnGNsZWFyLW9uLXJlYWTigJ0uIEFwcGFyZW50bHksIEFqYXkgdG9vayB0aGF0IGlu
dG8gY29uc2lkZXJhdGlvbi4NCg0KVGhhdCBpcyB0aGUgcmVhc29uIGZvciB0aGlzIHF1aXRlIGFt
YXppbmcgZGlmZmVyZW5jZSAtIHNldmVyYWwgb3JkZXJzIG9mDQptYWduaXR1ZGUgLSBiZXR3ZWVu
IHRoZSBvdmVyaGVhZCB0aGF0IGlzIGNhdXNlZCBieSByYXdfcGNpX3JlYWQoKTogMTIwdXMgZm9y
DQpQSU8gYW5kIDEwMG5zIGZvciBNTUlPLiBBZG1pdHRlZGx5LCBJIGRvIG5vdCB1bmRlcnN0YW5k
IHdoeSBQSU8gYWNjZXNzIHdvdWxkDQp0YWtlIDEyMHVzIChJIHdvdWxkIGhhdmUgZXhwZWN0ZWQg
aXQgdG8gYmUgMTAgdGltZXMgZmFzdGVyLCBhdCBsZWFzdCksIGJ1dA0KdGhlIGJlbmVmaXQgaXMg
cXVpdGUgY2xlYXIuDQoNCg==
