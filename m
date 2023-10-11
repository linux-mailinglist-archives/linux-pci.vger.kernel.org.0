Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB07C46D2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 02:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbjJKAqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 20:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbjJKAqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 20:46:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F99CF;
        Tue, 10 Oct 2023 17:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPRUpbSXZjnQqFqXHKPRKF2BLHnAYNlQI3gajXupzgL/x+FMITUs648IdyyVl9XxuqUns5B6zMQqQzEEya/wRfufsT/zm3+XLxXwLCKmfxuitw4SgapnzL/jVIoXtlmyiY6yB7+EO/7Ey3cp19+s7Q0Ps2vRY74wZgwGUJ+gTnw0GeLk4cP1fQ3lqZ21l3tvbAMdJjq8PiGi+grbHW5E/KsiMBbjUkHnOSGz4pQMaRcfL5GJDrNBDAUgGZEQGtRm71YN7Mwlh3R1MBzqlyz7Lbi0giWX1Ll9nJ1rPSyuPmdUlwn06/jP88Za4vY0uAro4mLINTbCEAAfea00Z2dVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BbYxkotn810tBh2FkD3IcDSbzrIjC4tuJrq3me9700=;
 b=KSstsOOg4joGDpeeqCGiZURrnPPDWFAxAfv0ps5AsOLZGDqzTnOK658KFnJJhl4Q7qv8ex+gCv4uZ+SjekTOosxTWJlDj2bz+o68DLMreTQ7nryDdN/2q3ZaHwm5tdLTx6hcpGjLeTE/9Cx/2fBrtyKwEQBQKnNfObkOew765ieL/PGXUOchBmMg8hHfrM2RqVC104iRI1oiATr67WR7gxj9cbHg+edykwbTqzch+pVWPwvenk4MnJTJXs5rFZuhLS7TtB/Q3d9LRQX3WHr3ttiHbWsUqJvZhcXhWCBQMYqM66CL8jckVOAdr9wuh5zYO4TTSekpj5SLuY64sNhDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BbYxkotn810tBh2FkD3IcDSbzrIjC4tuJrq3me9700=;
 b=D4tEMg7F1mqyfewPqWts8f4qPvYRK13aFvW4ibeBlmVYMsOPmA6lX01zU6lDELt4kLTGbnQP6PrZiK7ig9aL22trrlmhqr8c6Inn963uWv4uVu1UuWNpRzBgz9oe1SHECW5D7wQU6MUaJ5pHhcbHrO/oPM0J4Pam0Vd/0ERIIh0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9404.jpnprd01.prod.outlook.com
 (2603:1096:400:1a5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Wed, 11 Oct
 2023 00:46:38 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 00:46:38 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v21 01/16] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Topic: [PATCH v21 01/16] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Index: AQHZ7SGGImr+tyW7CkaDL2U+/2PB8rBC+vYAgADidqA=
Date:   Wed, 11 Oct 2023 00:46:38 +0000
Message-ID: <TYBPR01MB534101EE58B97FC3D5723246D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-2-yoshihiro.shimoda.uh@renesas.com>
 <20231010111210.GA4884@thinkpad>
In-Reply-To: <20231010111210.GA4884@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB9404:EE_
x-ms-office365-filtering-correlation-id: 08cc275d-3453-40b4-c364-08dbc9f386eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZzrIo1VJ2Oh28Bg0w7x2N3cvIThHhxfFBGG7P7ffzLJA1JnTlT/UWLqCxoNYdCzRPI9BwzifEF0fKryJUOQ3ZAL9OmLb0gFElVBqkjtT6nBEgzg3Xc7BN0vMpfipR/XXyo8YFS9iQzlD5tqRMMjUY93gDl5VsdvgqrE0dJxAEqaO0O5HY1TbZz3IQm7snJohpVaCVbS+qarTDDBs8ZfCO/rqfKwsAINHDubka6qG6WRadFfs4Y5TRIQ3jPTKIhasiqg8+Rs5mG8xyk21lAGTGe6oZaFXILYbxXOoJ1clR6Brjw2hSoyMHGkbblBQDkcubCFw9JK31GkH64AHrVplAfZlyVaW4Wk2QMLYzhZa9JU9tgZL+wvklbTolhrq40Ua4+/djH25QZ300gKto2+zm2FHGx3lo9pRYTSSITwX7wQJkoIaoNP1eI3QX0yjQ7qcqQ9EuPg4KAB3zDKMRE+FLmDjsTbcQdncvKbEdP+ifQ8JdHNGdmrYtbKV4JTyUQ/50xzymNd/6GSud4iBVKGFb2gkE12qKvQhAinuI3gDpUFr+MlbVAhSxseJKEkVdaJjslM30w5Y56z+yAHIuJd6JKiAD65HZ7IKQkbdL2BH+UmQ4UmDmosI0tFRkujQ2arc1deSs/boBzAXton0o6k8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(33656002)(55016003)(86362001)(38100700002)(38070700005)(122000001)(83380400001)(7416002)(2906002)(966005)(7696005)(478600001)(6506007)(71200400001)(4326008)(8676002)(52536014)(6916009)(316002)(41300700001)(66476007)(8936002)(66556008)(5660300002)(64756008)(76116006)(66446008)(54906003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25ydU5JYVgydXdtVU5pWXp2VUcrV0NMelRlekt6azlaQXBXTWlUbVE0RjdP?=
 =?utf-8?B?bTlWTlNuYzlFa1NwOFJMcHVObnNyR3hYR0JKWkxtbllVZy9VS2Zpc3ZIeUlG?=
 =?utf-8?B?dWpiaExXQ1BaOGNkUDdkbk1QakNQVUNTdUNDQ2VtZzBSaDZQenhNVVpUTlVt?=
 =?utf-8?B?cHBBK0VickducVg3eEVqU2x2eWpNSk5IanVBV3E0ZUtFdkRJTTYyUSs0U2hW?=
 =?utf-8?B?MjVSeGplUnp1LzF0b0lOdmNOODlKMC9sMVk3Mi9IM1dBTStGS0ZVM1JMWXN0?=
 =?utf-8?B?UXluaG0xL25kWTVqOHVqNVp1T2IxWVlKL1ZOWGlGNkFGSmIzcFdqaUt0MGha?=
 =?utf-8?B?OE5xTGFLUVhzdjJSd0ZhekxETlE2K1l2Sk9rY1ZtY2Q4bTM3N0poeHZXRFFi?=
 =?utf-8?B?aG9WWlRTVFg5OXlTWGZ4QkkzelRhUTdCSUxFNVcxMzRBL0lmV1kwTFI5eGVJ?=
 =?utf-8?B?U3IxdlpIUUZka244UHFaSkh0TXc3Y2x4Mm5xSDlmVzl3a0JhTGxDYVRZYjU5?=
 =?utf-8?B?dGZ5K3dNaStVVW1xVDhpS0M2QU5LdWd5MXZvZmQ5NngvMFJuc2dWUSttWmxq?=
 =?utf-8?B?dGEyOCtTWnhqQ2M2dVZDWnZ6UVBGTjk1cWhaeE1zRFBmYStJOGdRMEtJQWFP?=
 =?utf-8?B?bUJnRVV2WWNzY3dsOGdwVUlIMTRuMEd6TXlhRFpVTGpieW9aOStacGlPR3Zl?=
 =?utf-8?B?YTBoWXV5b3cwTy9mQ21PYXJmb1dLOER5MkZ5bWFYd2U4enJLNHJpalByVXUw?=
 =?utf-8?B?MnVvai82VVhUNVJvL1RVLy9DOGNwM3BSc1VXbURTTmdRcE5QbzF4ZWFVQ3dm?=
 =?utf-8?B?UE5hZnRuRTFsS3gvbDBsRWM3UUt4ZmM5OEZhYTR0WVd2eFdVVTkxZXI1V3BF?=
 =?utf-8?B?S0t6REFUWjdYRmhWa21ZOTQ3cm1QUUZYWGJLdVBsY21XR2VqckRvT25Ga29u?=
 =?utf-8?B?WW5OR0ZNSnNqeXo1bk8xQUc3a0xFVi83OG9ydU85VUJmOG9nTUNhOExnZGpP?=
 =?utf-8?B?bkVWbjhpMForeFFSMm1uaVhrRWRZeWZ3TWlGNXE0bXF4R09oeXN0aXZyR05Z?=
 =?utf-8?B?ZExaVE5YclREejR3WHlER0hZY2swUHAzQVMzV3phMjg4NzFXcUIweWFvZlpJ?=
 =?utf-8?B?eW5MMjRsYjBoY1VrYXV6bTltbU81Wm5aNm9LcXYzRVlJcnlDMGFPSzBOQ282?=
 =?utf-8?B?T1B6anhJUUFXQnpSNnpjNHJXRmpLMUdPS1VHSmh4MjZjVENjd2Y2WnpvOFF5?=
 =?utf-8?B?UDN0ZHBuNmYxbXltQlF2ZTRGek5nakNQaUdDZEk2S1YySm9FMkRFcy9oQjdr?=
 =?utf-8?B?T2RvYUNVK1hjS0l0bjlHaGozenI5d0FiUkt2TEdWZHF0WThyaHpQcG00NmdT?=
 =?utf-8?B?b0VaNnpOY1hSZUs2S2dVZFZmclkvVHZLMm9qbkJ1UXphK255V0VrVjdmOWlQ?=
 =?utf-8?B?SlI4TjlzVmxzOFJPdmFrRE9JaVJ5MWVqc0pmV0VrUU1VWkwzYk4xZE1kUDcz?=
 =?utf-8?B?SExleTYyYldRZHJ0S2xtcFkrcUQyanpHWXNJRWk5N0Q0S0puNHpLUm9wdXBT?=
 =?utf-8?B?cldFWUtsRDE3NWYzQWsvelp6VHdxSzVSK1BUT1MyOGpybDh6L3pITEFNcVJZ?=
 =?utf-8?B?N1RpRHQrUUZVWlk5VjVUcEQ0OXZySU9UMTVaNTFXd2NKU0lsTUtXajRWbGxO?=
 =?utf-8?B?dFYwV1d3TXFLTndUVUJOOG00b1ZZSHVEQzkza2Y3T0xRUW4yYlZoRXA0T3Ur?=
 =?utf-8?B?UVkyQWtaNG42NWttNktiMllOL0dZdXoyeWxGdXZIUk10MkdrWkIxNmZXT1di?=
 =?utf-8?B?eUVzVENmYnZrOEh3NG8zbW9NNGNvL0toSkNrRUl6WjBjYy9mdUhJYnlrRmlt?=
 =?utf-8?B?b0JGTm11aDVlTk81dnZvY2MzbHlvcmtFVHI5Q2JqdEdPRi9qWVpJYXlCYm9p?=
 =?utf-8?B?L08yOHVIbjA2dXRSWmVqa1hOUDZ4SE9aUDNoVEdnOGlhTjlobkIvMjRNdStF?=
 =?utf-8?B?cHBUa1UyckorRGlDaTYwVk43V2ZiUUJGZmFRa3VobnQzWXNFVlNVRTFTVDNh?=
 =?utf-8?B?RTVpVUNadzZ1MDRaYnRkcDRYc1FUUzJRUzRkL1Z0b0xoU3lFcnlXZGZ6QXlp?=
 =?utf-8?B?aXhOckJSM2VnQ2NTZUlrbHJOQllublVMQ1pwNWkyeFZkcXh4MkJxY3RoRVFa?=
 =?utf-8?B?ZGgxM0xvYjBLVG04K1crWEZMOWtQOE91RFlENTRNd3RBT3JMUTdvaEFWSkIy?=
 =?utf-8?B?emlrWVYrN2trMFV4NkNnMlhoTWdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cc275d-3453-40b4-c364-08dbc9f386eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:46:38.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3309mAHbOlzDrGSL6z1lqLFeVphdyNovacjWXBPpY7XRMIdgBWLexcyAN1jRe3wnwx1mbrf8TmiWkhTIE4yPMuIgvFt/hYHS0gyVEb0TTgfCkOS5CyqQwBX5uT/uAjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgODoxMiBQTQ0KPiANCj4gT24gRnJpLCBTZXAgMjIs
IDIwMjMgYXQgMDM6NTM6MTZQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4g
VGhlIGNvbW1pdCAyNGVkZTQzMGZhNDkgKCJQQ0k6IGRlc2lnbndhcmUtZXA6IEFkZCBtdWx0aXBs
ZSBQRnMgc3VwcG9ydA0KPiA+IGZvciBEV0MiKSBhZGRlZCAuZnVuY19jb25mX3NlbGVjdCgpIHRv
IGdldCB0aGUgY29uZmlndXJhdGlvbiBzcGFjZSBvZg0KPiA+IGRpZmZlcmVudCBQRnMgYW5kIGFz
c3VtZWQgdGhhdCB0aGUgb2Zmc2V0cyBiZXR3ZWVuIGRiaSBhbmQgZGJpMiB3b3VsZA0KPiA+IGJl
IHRoZSBzYW1lLg0KPiA+DQo+ID4gSG93ZXZlciwgUmVuZXNhcyBSLUNhciBHZW40IFBDSWUgY29u
dHJvbGxlcnMgaGF2ZSBkaWZmZXJlbnQgb2Zmc2V0cyBvZg0KPiA+IGZ1bmN0aW9uIDE6IGRiaSAo
KzB4MTAwMCkgYW5kIGRiaTIgKCsweDgwMCkuIFRvIGdldCB0aGUgb2Zmc2V0IGZvciBkYmkyLA0K
PiA+IGFkZCAuZ2V0X2RiaTJfb2Zmc2V0KCkgYW5kIGR3X3BjaWVfZXBfZ2V0X2RiaTJfb2Zmc2V0
KCkuDQo+ID4NCj4gPiBOb3RlOg0KPiA+ICAtIC5mdW5jX2NvbmZfc2VsZWN0KCkgc2hvdWxkIGJl
IHJlbmFtZWQgbGF0ZXIuDQo+ID4gIC0gZHdfcGNpZV9lcF9nZXRfZGJpMl9vZmZzZXQoKSB3aWxs
IGNhbGwgLmZ1bmNfY29uZl9zZWxlY3QoKQ0KPiA+ICAgIGlmIC5nZXRfZGJpMl9vZmZzZXQoKSBk
b2Vzbid0IGV4aXN0IGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPiA+ICAtIGR3X3BjaWVf
d3JpdGVYX3tkYmkvZGJpMn0gQVBJcyBhY2NlcHRlZCB0aGUgZnVuY19ubyBhcmd1bWVudCwNCj4g
PiAgICBzbyB0aGF0IHRoZXNlIG9mZnNldCBjYWxjdWxhdGlvbnMgYXJlIGNvbnRhaW5lZCBpbiB0
aGUgQVBJDQo+ID4gICAgZGVmaW5pdGlvbnMgaXRzZWxmIGFzIGl0IHNob3VsZC4NCj4gPg0KPiA+
IFtrd2lsY3p5bnNraTogY29tbWl0IGxvZ10NCj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1wY2kvMjAyMzA4MjUwOTMyMTkuMjY4NTkxMi02LXlvc2hpaGlyby5zaGltb2Rh
LnVoQHJlbmVzYXMuY29tLw0KPiANCj4gTm8gbmVlZCBvZiB0aGUgIkxpbmsiLiBJdCB3aWxsIGJl
IGFkZGVkIGJ5IHRoZSBtYWludGFpbmVyIHdoaWxlIGFwcGx5aW5nIHRoaXMNCj4gcGF0Y2guDQoN
CkkgZ290IGl0LiBJJ2xsIHJlbW92ZSB0aGlzLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGlo
aXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gUmV2
aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc+DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchDQoNCj4gWW91ciBzLW8tYiB0
YWcgc2hvdWxkIGNvbWUgbGFzdCBpbmRpY2F0aW5nIHRoYXQgeW91IGFyZSBzZW5kaW5nIHRoZSBw
YXRjaC4NCg0KSSBnb3QgaXQuIEkgYWxzbyBnb3QgYSBjb21tZW50IGZyb20gQmpvcm4gWzFdLCBz
byBJJ2xsIHJlbW92ZSBLcnp5c3p0b2YncyBzLW8tYiB0YWcuDQoNClsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMzEwMDUxNTA5MDcuR0E3NDYyOTFAYmhlbGdhYXMvDQoNCkJlc3Qg
cmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dpbGN6eW5za2lAa2VybmVsLm9yZz4NCj4g
PiAtLS0NCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAg
IHwgMzIgKysrKysrKysrKysrKystLS0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuaCAgfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gaW5kZXggZjkxODJmOGQ1NTJm
Li44NTE1MzhkZGVjMGEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+IEBAIC01MiwyMSArNTIsMzUgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCBkd19wY2llX2VwX2Z1bmNfc2VsZWN0KHN0cnVjdCBkd19wY2llX2VwICpl
cCwgdTggZnVuY19ubykNCj4gPiAgCXJldHVybiBmdW5jX29mZnNldDsNCj4gPiAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgZHdfcGNpZV9lcF9nZXRfZGJpMl9vZmZzZXQoc3RydWN0
IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBpbnQg
ZGJpMl9vZmZzZXQgPSAwOw0KPiA+ICsNCj4gPiArCWlmIChlcC0+b3BzLT5nZXRfZGJpMl9vZmZz
ZXQpDQo+ID4gKwkJZGJpMl9vZmZzZXQgPSBlcC0+b3BzLT5nZXRfZGJpMl9vZmZzZXQoZXAsIGZ1
bmNfbm8pOw0KPiA+ICsJZWxzZSBpZiAoZXAtPm9wcy0+ZnVuY19jb25mX3NlbGVjdCkgICAgIC8q
IGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5ICovDQo+ID4gKwkJZGJpMl9vZmZzZXQgPSBlcC0+
b3BzLT5mdW5jX2NvbmZfc2VsZWN0KGVwLCBmdW5jX25vKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
ZGJpMl9vZmZzZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIF9fZHdfcGNpZV9l
cF9yZXNldF9iYXIoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTggZnVuY19ubywNCj4gPiAgCQkJCSAg
IGVudW0gcGNpX2Jhcm5vIGJhciwgaW50IGZsYWdzKQ0KPiA+ICB7DQo+ID4gLQl1MzIgcmVnOw0K
PiA+IC0JdW5zaWduZWQgaW50IGZ1bmNfb2Zmc2V0ID0gMDsNCj4gPiArCXVuc2lnbmVkIGludCBm
dW5jX29mZnNldCwgZGJpMl9vZmZzZXQ7DQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAgPSAm
cGNpLT5lcDsNCj4gPiArCXUzMiByZWcsIHJlZ19kYmkyOw0KPiA+DQo+ID4gIAlmdW5jX29mZnNl
dCA9IGR3X3BjaWVfZXBfZnVuY19zZWxlY3QoZXAsIGZ1bmNfbm8pOw0KPiA+ICsJZGJpMl9vZmZz
ZXQgPSBkd19wY2llX2VwX2dldF9kYmkyX29mZnNldChlcCwgZnVuY19ubyk7DQo+ID4NCj4gPiAg
CXJlZyA9IGZ1bmNfb2Zmc2V0ICsgUENJX0JBU0VfQUREUkVTU18wICsgKDQgKiBiYXIpOw0KPiA+
ICsJcmVnX2RiaTIgPSBkYmkyX29mZnNldCArIFBDSV9CQVNFX0FERFJFU1NfMCArICg0ICogYmFy
KTsNCj4gPiAgCWR3X3BjaWVfZGJpX3JvX3dyX2VuKHBjaSk7DQo+ID4gLQlkd19wY2llX3dyaXRl
bF9kYmkyKHBjaSwgcmVnLCAweDApOw0KPiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpMihwY2ksIHJl
Z19kYmkyLCAweDApOw0KPiA+ICAJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgcmVnLCAweDApOw0K
PiA+ICAJaWYgKGZsYWdzICYgUENJX0JBU0VfQUREUkVTU19NRU1fVFlQRV82NCkgew0KPiA+IC0J
CWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWcgKyA0LCAweDApOw0KPiA+ICsJCWR3X3BjaWVf
d3JpdGVsX2RiaTIocGNpLCByZWdfZGJpMiArIDQsIDB4MCk7DQo+ID4gIAkJZHdfcGNpZV93cml0
ZWxfZGJpKHBjaSwgcmVnICsgNCwgMHgwKTsNCj4gPiAgCX0NCj4gPiAgCWR3X3BjaWVfZGJpX3Jv
X3dyX2RpcyhwY2kpOw0KPiA+IEBAIC0yMjgsMTYgKzI0MiwxOCBAQCBzdGF0aWMgaW50IGR3X3Bj
aWVfZXBfc2V0X2JhcihzdHJ1Y3QgcGNpX2VwYyAqZXBjLCB1OCBmdW5jX25vLCB1OCB2ZnVuY19u
bywNCj4gPiAgew0KPiA+ICAJc3RydWN0IGR3X3BjaWVfZXAgKmVwID0gZXBjX2dldF9kcnZkYXRh
KGVwYyk7DQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVw
KTsNCj4gPiArCXVuc2lnbmVkIGludCBmdW5jX29mZnNldCwgZGJpMl9vZmZzZXQ7DQo+ID4gIAll
bnVtIHBjaV9iYXJubyBiYXIgPSBlcGZfYmFyLT5iYXJubzsNCj4gPiAgCXNpemVfdCBzaXplID0g
ZXBmX2Jhci0+c2l6ZTsNCj4gPiAgCWludCBmbGFncyA9IGVwZl9iYXItPmZsYWdzOw0KPiA+IC0J
dW5zaWduZWQgaW50IGZ1bmNfb2Zmc2V0ID0gMDsNCj4gPiArCXUzMiByZWcsIHJlZ19kYmkyOw0K
PiA+ICAJaW50IHJldCwgdHlwZTsNCj4gPiAtCXUzMiByZWc7DQo+ID4NCj4gPiAgCWZ1bmNfb2Zm
c2V0ID0gZHdfcGNpZV9lcF9mdW5jX3NlbGVjdChlcCwgZnVuY19ubyk7DQo+ID4gKwlkYmkyX29m
ZnNldCA9IGR3X3BjaWVfZXBfZ2V0X2RiaTJfb2Zmc2V0KGVwLCBmdW5jX25vKTsNCj4gPg0KPiA+
ICAJcmVnID0gUENJX0JBU0VfQUREUkVTU18wICsgKDQgKiBiYXIpICsgZnVuY19vZmZzZXQ7DQo+
ID4gKwlyZWdfZGJpMiA9IFBDSV9CQVNFX0FERFJFU1NfMCArICg0ICogYmFyKSArIGRiaTJfb2Zm
c2V0Ow0KPiA+DQo+ID4gIAlpZiAoIShmbGFncyAmIFBDSV9CQVNFX0FERFJFU1NfU1BBQ0UpKQ0K
PiA+ICAJCXR5cGUgPSBQQ0lFX0FUVV9UWVBFX01FTTsNCj4gPiBAQCAtMjUzLDExICsyNjksMTEg
QEAgc3RhdGljIGludCBkd19wY2llX2VwX3NldF9iYXIoc3RydWN0IHBjaV9lcGMgKmVwYywgdTgg
ZnVuY19ubywgdTggdmZ1bmNfbm8sDQo+ID4NCj4gPiAgCWR3X3BjaWVfZGJpX3JvX3dyX2VuKHBj
aSk7DQo+ID4NCj4gPiAtCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWcsIGxvd2VyXzMyX2Jp
dHMoc2l6ZSAtIDEpKTsNCj4gPiArCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWdfZGJpMiwg
bG93ZXJfMzJfYml0cyhzaXplIC0gMSkpOw0KPiA+ICAJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwg
cmVnLCBmbGFncyk7DQo+ID4NCj4gPiAgCWlmIChmbGFncyAmIFBDSV9CQVNFX0FERFJFU1NfTUVN
X1RZUEVfNjQpIHsNCj4gPiAtCQlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgcmVnICsgNCwgdXBw
ZXJfMzJfYml0cyhzaXplIC0gMSkpOw0KPiA+ICsJCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCBy
ZWdfZGJpMiArIDQsIHVwcGVyXzMyX2JpdHMoc2l6ZSAtIDEpKTsNCj4gPiAgCQlkd19wY2llX3dy
aXRlbF9kYmkocGNpLCByZWcgKyA0LCAwKTsNCj4gPiAgCX0NCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggZWYwYjJlZmE5
ZjkzLi42MTg5ODg0YjRlZmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC0zNDEsNiArMzQxLDcgQEAgc3RydWN0IGR3
X3BjaWVfZXBfb3BzIHsNCj4gPiAgCSAqIGRyaXZlci4NCj4gPiAgCSAqLw0KPiA+ICAJdW5zaWdu
ZWQgaW50ICgqZnVuY19jb25mX3NlbGVjdCkoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5j
X25vKTsNCj4gPiArCXVuc2lnbmVkIGludCAoKmdldF9kYmkyX29mZnNldCkoc3RydWN0IGR3X3Bj
aWVfZXAgKmVwLCB1OCBmdW5jX25vKTsNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdHJ1Y3QgZHdfcGNp
ZV9lcF9mdW5jIHsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPg
rr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
