Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88B56DEAF3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 07:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLFWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDLFWm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 01:22:42 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401EB5583;
        Tue, 11 Apr 2023 22:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVZpWuPoS7klrYcZL2vG9MgeUdjkzkWnuCwYhY0eVe1cdEiGhBzZie/JfNfwXYYfhWFJJxNZ1i0qEp+gBLWfQL/QaDc23LIxGHAl6gTwo6mDEGpUdzhfgyGYeL8bnigd794lmWgHbEVT44ZQbSVhPVDx3fe1MG8w2XNpCruvhXbGX1D/N5FvcAOt9xnJwclpuEFqtFhSJBoNS52esNnQyf5gjMUTAh2sjaCLyWkrOTnd1jHnirral1P8/3Hy28963E9S7J/qcxgDZCrv6DAwF83MW16oUA7XY6QKHC/uDa1kxW5RxkOF7F+f5TVKC9lwKlJDMKmsEE2aSd3F3YjoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj9Y2UCIq5h2R1fHths6BmrB7Vaoz7WcNLwXJKKAihw=;
 b=jMTGWFaSHi9BjlYjW4KGWK0oqapfWf2VWIkq2blv//JQnRrw5WfEEW2O5g3S0AHku8l/D3dXwqiXCb5m94cam9kBcxVGrSBOAGsV6Q1EbIxf+AACuYLtgoon+cPENQ2Hd/K2ace+FdUQx5ooOHD866CEQx0PmS73ZANuxsf+XT4BhELIrRYregls/cVPpZN/MbzMRqH2mlKkqaKZuOK4iF4mrKhRI2e30YSiiNVfs6zu07xDxflwrUZMwQL7tYZBZBf5aHCBsH3+I2t2pHjfzxgIlfxW66kb2V/Sd9vWFE+Qkbu+K1TCrpSLrlRNeYuUtiIAGwBdsye3I9grM/QkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj9Y2UCIq5h2R1fHths6BmrB7Vaoz7WcNLwXJKKAihw=;
 b=QMKNJmYE4i5EIHk6jMCHBAxSUHycNbKl+dP2nhm3MZGtBRjWNatM1gIEnmMvtzs+j77wtauRxTEMzQv/t7BQ0qA7Nx+rlgvjfavZgoJvcnvBgm3mLGEVFjvXYH1v5TXjLWa4SAjbCcEWYDW5I6f1k2o6YpXBd2mm8DE6sfL1/AU=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB6173.jpnprd01.prod.outlook.com
 (2603:1096:400:4e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 05:22:35 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.028; Wed, 12 Apr 2023
 05:22:35 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: RE: [PATCH v11 02/13] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Topic: [PATCH v11 02/13] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Index: AQHZU0zDh1rLQITDBUCF6r3s1EhLta8nRm4AgAAPX7A=
Date:   Wed, 12 Apr 2023 05:22:35 +0000
Message-ID: <TYBPR01MB5341492288CF683A6FE2EC62D89B9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-3-yoshihiro.shimoda.uh@renesas.com>
 <ada2062d-c857-97c1-41fe-a2eedde1b832@socionext.com>
In-Reply-To: <ada2062d-c857-97c1-41fe-a2eedde1b832@socionext.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB6173:EE_
x-ms-office365-filtering-correlation-id: 8a74eef8-95a2-40d9-c5cf-08db3b15ec9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37xaW04X8WrKBKfHRutDsf7WfcHBtoEEoNHonTYHXCqC6lk3pPAU0UaFyLbUJ8dxQ+n8vfz63fegg37hDMjaIiewsIOOBA9W+UUjBkwhQl8aEHEai/MbIha5fu6ZvWr7+35JX9dDB2ZElk1AIT/utlyaW0tr5XiZjtnpbuDiHpmkmYJBkKyJHVdoBOobDhL72+bgOHsAfw5jXwHo3myp5uDyAsFsqZiMz6rvc22akMQZkPJewtzmgGuUeDP6P6qB6zZlrexNTMI8Q2VWdAurxIbOT1VDa4782zDUSyJ3kmf2SGl+pzZQfGFTF1z4OLauDUuylB17HQKdlgBeVHnNn8IfxLAcvyCwZ0fDW1/Twv60HUQKAEWblIw2XHC85KqkNRsma+bUSGzmnM5k3Mqf3fS+weZ5X/4+8vxl+0rXOdLAJ2r2HdHoPSfIgtZTnmAINpv1Pl1mK0fkD9XdOs3Pjl2z0zww5GSHKNBIErnwVy07ILyV990bRhqLk71JD1lpJSCaGBgXk1UlKqjtBIDh0OgoKQ5qbM/qMIlK1QycgdXKUDDvRpg/hhbEwChdQGb2m/dWJiJXBFSeoM6QF8wK00RuUP7fkGwcGf/YAXi8yfjqfpqmOPtR97bMBvvEOr/p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(2906002)(478600001)(7416002)(8676002)(33656002)(8936002)(316002)(41300700001)(66556008)(66476007)(66946007)(76116006)(66446008)(64756008)(86362001)(110136005)(54906003)(4326008)(55016003)(71200400001)(7696005)(38100700002)(83380400001)(122000001)(6506007)(38070700005)(9686003)(52536014)(5660300002)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2JXYkVIdXlsZklDbFlUMUpyN21aaUNSMDdWWEFVcFdLemFNeG5jM3F3eHhw?=
 =?utf-8?B?NHN2dWhxM0VWd2twMFN3ZktWS0w3Z0pRR25WSzFtdlR1OVVJckw1SERKMVRy?=
 =?utf-8?B?SGlxN1o3SlZ2RUtpQ2FzZHZFNk1LTHNPOHAvd0t6N2FWQWJxQnpKYzhUZmho?=
 =?utf-8?B?WlhUQnk3Q2lGQURLWkxUY1FjMDVubWdCc0RmLzZGOEQwOU1mbHhkTGJzZDll?=
 =?utf-8?B?cXpmUHltcGFtdy9hcWhaa2phZzEvODhYQURYdWFBMDhYQVk4RU12S3h3QVQ0?=
 =?utf-8?B?S1FFQSt1VlNCVUxNYStPRndWTFAwTnV6RWNQblBReXEwNmpXbUhWY3l0NHVv?=
 =?utf-8?B?bzdZVjNONVdyVkRqaEJGWWtPekZpN3pnc25CYThXeU1QY21hUndlSTZ6d0ww?=
 =?utf-8?B?TzYxRGxmUWNwd3BRbmVxdU5pd0tQVVAzZHNRNW1tTWY4QVVLV1FCNSs5TGdU?=
 =?utf-8?B?MVJhQ3hxZXNpdS9wNmNKdjI4cmo3dnhpMFlTQnVTY0dZTzdGQWx0Zm9WUEVi?=
 =?utf-8?B?SE8zNU5ia1Jzc1B3YVo3UWUrOWY5OVNrbnpydlRmTFpUTzNBTTlNbS90SlIr?=
 =?utf-8?B?NytxbWl6RUw2aGM3bzFjWDQ1NUY3QWhFQkorMnE5YVBBOGtXOXJQSkRmOFN2?=
 =?utf-8?B?a0Z6UTRVRUlDUkNhRng2dTh0d08vaEpCaDFGeWw4UkNlc1hrZGdqREhNanhj?=
 =?utf-8?B?UklpQjhmdkJadDlvSG5yV281R1Bob095V2dGejBCa3MxK3BBR0lXVEt5L29r?=
 =?utf-8?B?ODR4TVJHakp1SE5xbVFlRUVPejNPczZDV2ZFaFJ4UWpkaHIwQjRySklLZVBM?=
 =?utf-8?B?a3AzVStaVS8wZ3NpRVZ5aTNCcllwdkkxWVk4d2xMUDNJVUFLZXFGeWZQUVAw?=
 =?utf-8?B?RUtZUFgvbUlDSE40YU1aZnBlb1puSFZ6K1lpSS9jdnVYMTVtQ1FqTTlheG9w?=
 =?utf-8?B?aHhSY3NMOGgwemVDbkNPVTV4eUlQOHRpQkpJellzYThmM1U3VUJRemRCUHNF?=
 =?utf-8?B?Uy9pejAzSFFQenUwWS9jcjRhQkIvSzhOclV6dk1QdXlYcnNxOG9FZmVuZFQ5?=
 =?utf-8?B?ZTlhZUIwbjV4eUdtZVdkZXZiZXhNQ2QvbnNZTHZBKzZZTnVKUWgrNWhxR1RX?=
 =?utf-8?B?Q0EzSXBEK0lvOFhXZTZZTVlPamhPZGs2WjNGVWVtN0VCeWt6SEwyS0RnN25x?=
 =?utf-8?B?alJTTVdHMUl1ZEpRb1VHOC9RUXFLYVovUzlob0RWbjhlOXlsWU42aTNpWWZG?=
 =?utf-8?B?QS9mR1dqNUFOdmIwVktqZkYvWVY1R1VsSTJDejZwTmlMcXVRZ1llOEE0YXV4?=
 =?utf-8?B?dFlKV04zbERRMElJMGdRNkxNRUxYczZHN3QrNEpxbGdZZlNoc2NaWmVLaXE2?=
 =?utf-8?B?R21NZWg1YUMrREZBbDhrZXVQNnllQk03VzZEbWhJNU9uaUNxbGVHN2Y4MzQ0?=
 =?utf-8?B?ZXNEWXJGMzRGTmhwMkpNQXRTNDN0Wk5FRjFnbkFQQ1R4MU94RldJelZObGs2?=
 =?utf-8?B?cHl3N1Y1cisvcEkvMklZYXNEcE1ZSkI4a0JjdmxFeDJNZ013bTBWN3VoSVVo?=
 =?utf-8?B?TUsrb0VyVWR3NjZSSG5jdnFITCtWUnExd3JMakszdUlNeTVtYnNXczN2OEcz?=
 =?utf-8?B?NDlMTTVHMldVWi9JY1BZazZQa2VIV1RjQ0dVOW1zaVpPV3h0MElKWVVOME5Y?=
 =?utf-8?B?bTBEdjUycVdCeW95dGVERk1wWmM1OEtuODl3amU5NC9JS2ZXazJ1bnFWMy9E?=
 =?utf-8?B?TzVXOUhqUkp2QmQwUTVzUkx2OWFwUjV0MXFQaXZMY3hJdnhLR0hLL1FnMFJt?=
 =?utf-8?B?bGFEblp6RmVRbVZxa1AxQWlnL0JjSDBMeUxhK0NWYndDMjZXVmo3VG5qTTkz?=
 =?utf-8?B?Ni9XL2JYQzdyUUdDRU9WUmg1NDdnYjkzQUx2dHlZSUhDb2RhemwzcXdkbGls?=
 =?utf-8?B?Sm5tTTBWalEzM3lNNEw5ZTJZYWhZeXZxQnRIOStkeENVaTFWWGpkYnM0RDdy?=
 =?utf-8?B?MGdJQm1PT3dDL0RnSm9HVENyd2N1VXE0TjkxVXVwSVZjS3hWNXQ5Mno0eWFU?=
 =?utf-8?B?VXlvN3hZY28vSld1c3BRS01lTjZOZVJNM0dWOUgxdWRHZ3N1QjhQd2p4cFkw?=
 =?utf-8?B?VmZDT0FqaDRVTG9wcEM1bnpwUHR4RVBkMSs3WlVLdWc5TmFuVjlJc3JabmVi?=
 =?utf-8?B?ZC91OEplZ3YwZk5iVGhySVB3RnJCNjRJMnZnMmRCYmxSVGlwUWd3dkdJenRp?=
 =?utf-8?B?NUVFbkMwZnJHdXR3dEgrUTJJbUdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74eef8-95a2-40d9-c5cf-08db3b15ec9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:22:35.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CI3Mgh4YlOUzYhDdAlkv7g4EkgQsUc0reuNsXIT6Ou7HIlh2ktB1FYXIwE1MYc813vjxsA92LF27t9wrlelJnIib1QF8ZH6aFgLrrcBicCpUG9b6B+E9aDFyrVybrqno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSGF5YXNoaS1zYW4sDQoNCj4gRnJvbTogS3VuaWhpa28gSGF5YXNoaSwgU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAxMiwgMjAyMyAxOjIzIFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+
IE9uIDIwMjMvMDMvMTAgMjE6MzQsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEluIHRo
ZSBwY2lfZXBmX3Rlc3RfaW5pdF9kbWFfY2hhbigpLCBlcGZfdGVzdC0+ZG1hX2NoYW5fcngNCj4g
PiBpcyBhc3NpZ25lZCBmcm9tIGRtYV9yZXF1ZXN0X2NoYW5uZWwoKSB3aXRoIERNQV9ERVZfVE9f
TUVNIGFzDQo+ID4gZmlsdGVyLmRtYV9tYXNrLiBIb3dldmVyLCBpbiB0aGUgcGNpX2VwZl90ZXN0
X2RhdGFfdHJhbnNmZXIoKSwNCj4gPiBpZiB0aGUgZGlyIGlzIERNQV9ERVZfVE9fTUVNLCBpdCBz
aG91bGQgdXNlIGVwZi0+ZG1hX2NoYW5fcngsDQo+ID4gYnV0IGl0IHVzZWQgZXBmX3Rlc3QtPmRt
YV9jaGFuX3R4LiBTbywgZml4IGl0LiBPdGhlcndpc2UsDQo+ID4gcmVzdWx0cyBvZiBwY2l0ZXN0
IHdpdGggZW5hYmxlZCBETUEgd2lsbCBiZSAiTk9UIE9LQVkiIG9uIGVETUENCj4gPiBlbnZpcm9u
bWVudC4NCj4gDQo+IEkgYWxzbyBlbmNvdW50ZWQgdGhpcyBpc3N1ZSBhbmQgZm91bmQgdGhpcyBw
YXRjaCBiZWZvcmUgc2VuZGluZyBteSBmaXhlcyBwYXRjaA0KPiBmb3IgdGhlIHNhbWUgZGlmZiBh
cyB0aGlzIG9uZS4NCj4gQW5kIEkgY29uZmlybWVkIHRoZSBpc3N1ZSBpcyBmaXhlZCB1c2luZyBw
Y2l0ZXN0IHdpdGggZURNQSBvbiBVbmlQaGllciBTb0NzLg0KPiANCj4gRm9yIDAyLzEzIHBhdGNo
IGlmIG5vdCBhbHJlYWR5IG1lcmdlZDoNCj4gDQo+IFRlc3RlZC1ieTogS3VuaWhpa28gSGF5YXNo
aSA8aGF5YXNoaS5rdW5paGlrb0Bzb2Npb25leHQuY29tPg0KDQpUaGFuayB5b3UgdmVyeSBtdWNo
IGZvciB5b3VyIFRlc3RlZC1ieSENClNpbmNlIEkgbmVlZCBtb3JlIHRpbWUgdG8gZml4IHYxMiBw
YXRjaCBzZXJpZXMgZm9yIHNvbWUgcmVhc29ucywNCkknbGwgc2VuZCB0aGlzIHBhdGNoIGluZGVw
ZW5kZW50bHkuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gVGhhbmsg
eW91LA0KPiANCj4gPg0KPiA+IEZpeGVzOiA4MzUzODEzYzg4ZWYgKCJQQ0k6IGVuZHBvaW50OiBF
bmFibGUgRE1BIHRlc3RzIGZvciBlbmRwb2ludHMgd2l0aA0KPiA+IERNQSBjYXBhYmlsaXRpZXMi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9k
YS51aEByZW5lc2FzLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNp
LWVwZi10ZXN0LmMgfCAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi10ZXN0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLXRlc3QuYw0KPiA+IGluZGV4IDBmOWQyZWM4MjJhYy4uMTcyZTVhYzBi
ZDk2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2kt
ZXBmLXRlc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2kt
ZXBmLXRlc3QuYw0KPiA+IEBAIC0xMTIsNyArMTEyLDcgQEAgc3RhdGljIGludCBwY2lfZXBmX3Rl
c3RfZGF0YV90cmFuc2ZlcihzdHJ1Y3QNCj4gPiBwY2lfZXBmX3Rlc3QgKmVwZl90ZXN0LA0KPiA+
ICAgCQkJCSAgICAgIHNpemVfdCBsZW4sIGRtYV9hZGRyX3QgZG1hX3JlbW90ZSwNCj4gPiAgIAkJ
CQkgICAgICBlbnVtIGRtYV90cmFuc2Zlcl9kaXJlY3Rpb24gZGlyKQ0KPiA+ICAgew0KPiA+IC0J
c3RydWN0IGRtYV9jaGFuICpjaGFuID0gKGRpciA9PSBETUFfREVWX1RPX01FTSkgPw0KPiA+ICsJ
c3RydWN0IGRtYV9jaGFuICpjaGFuID0gKGRpciA9PSBETUFfTUVNX1RPX0RFVikgPw0KPiA+ICAg
CQkJCSBlcGZfdGVzdC0+ZG1hX2NoYW5fdHggOg0KPiA+IGVwZl90ZXN0LT5kbWFfY2hhbl9yeDsN
Cj4gPiAgIAlkbWFfYWRkcl90IGRtYV9sb2NhbCA9IChkaXIgPT0gRE1BX01FTV9UT19ERVYpID8g
ZG1hX3NyYyA6DQo+ID4gZG1hX2RzdDsNCj4gPiAgIAllbnVtIGRtYV9jdHJsX2ZsYWdzIGZsYWdz
ID0gRE1BX0NUUkxfQUNLIHwgRE1BX1BSRVBfSU5URVJSVVBUOw0KPiANCj4gLS0tDQo+IEJlc3Qg
UmVnYXJkcw0KPiBLdW5paGlrbyBIYXlhc2hpDQo=
