Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12478C3C4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjH2MDD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjH2MDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:03:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0617A3;
        Tue, 29 Aug 2023 05:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb2Vaz+G2SPUYr5V/xas/NMoK/wfk0bhhc3EluZvRs07lB0E5s6XxsB9fKGiyVqYU6MSV0cFlnLvpCbgHKkIlCPqhyqUZlHCEEsBK12r3pAtd5frdcRTDpzNdAMn3aKTXxLMyYzUw2R+fDHYQJ6ICmAKy3lHLifyXr67GqlSsExwYikd2gCsk69nPlsrSKC157oGTx5G+zngcYqHIfAdAYOeNJuKQu4V4OjmVv+lvPMQLFfGDsTEWNsdY0LK7CBz13NFL5jb8xLtupKB7XYaVUju5iUkESkIrK0cEUK9vo8UnobAXZ6eAbnDB4xU3ZH4qkjHz2PPU8B4GqSoLh4qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnArHjObv65ZnD2XsGddFPD2s71Kan7LsRJFp1pta3c=;
 b=fO+QEZ/BCbg4fKP3yLt2/kNVmvouRMPh4+QBX88471nECRhiehFionc4lTt2ah+9Ud8sqJ+P1tTNaZVbaQ7R/wnLEcW71+RSkbS/9GLhn3YPNW8sz9LqYTHL2rQ7QZQWXALIFx0Q++2yaxxknSA580fwclSmo/N3sA4a1M7am/fCuf8ev+bM121EbMIZGqS/7HVPJA59x0wOxD/TcDEolXTo25wEK0NQvXEuv12DBZgx+U8YrBjkjM386zZxgeHX3rZyYjW4RcCtgugnl5nqyxewQewLjBey/JNRZWqQf0YAI7jKeOM/cfRqMJIarZl6+LsBQI1b4jOEXeWx89+KwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnArHjObv65ZnD2XsGddFPD2s71Kan7LsRJFp1pta3c=;
 b=n5Ee5LZsWbeUbUYv02DBMEZ9555hoXm/NKv9/pdwnoFTGnmFGSKc/+exQUApwhdwrsktZl2CybqQVOyX28Y+CIAjYbkOM5pohoZ3eKHbTXwg/4dhYVSnrxubQO8nGUIuOCw30XgraGa2uEg115zoMm+YnRtnSod0xgYGSreEROs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB11942.jpnprd01.prod.outlook.com
 (2603:1096:400:3fe::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 12:02:52 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 12:02:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZ1zcNtDThJaZvc02SH965eUO1lK/7VSoAgAJkVICAAS3c4IAA2aeAgAFxcVA=
Date:   Tue, 29 Aug 2023 12:02:52 +0000
Message-ID: <TYBPR01MB5341D736E6AB8A8CF4DFF691D8E7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
 <20230827065903.GA1514918@rocinante>
 <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <y5veq46prsa5rwy42zhods6v6lst2rbf3tqzuznblkyz4tbcf5@wdhju7x3o3oc>
In-Reply-To: <y5veq46prsa5rwy42zhods6v6lst2rbf3tqzuznblkyz4tbcf5@wdhju7x3o3oc>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB11942:EE_
x-ms-office365-filtering-correlation-id: f0392e34-14ce-41ff-2326-08dba887df4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xV4kBEihUL3liEcOudZvosdNwYKTUHRvtwE/JhaAlZ7OkFAMA9WV2Dr/w9r04MuZa5hahXaIhzd2QDsW+O17YQ/P78r0Rro4grwHE856um6q/YvcgOKrbo8XcS1IharkV/qzSkIiVa5NYdHyFo8azUWVCyZ8zMubuugvlgmoGNxzAqI0HVM2EeO6Go7G7MZb+H0BzpXW7GWkkjDH9CmU5H3+dUaO38ExeSq73YuMnW8pMC8dg+E8zlLjkTPE7iiU8lpsOB0th2skL8XE/0qdwHAVdxTDjobZAp84z2U9ZaG7tYhnvCpO5HSeiHSP3S/ym0F1xBjPcATreUDkayoO9FJh9UAZHACZVMJkliYz3UrYIuD8yddznWVpAEyQH+NLF5zVUf5janw33HHNTBWZEwV6PRp/ooLdw+fDInLj7rjyiOK83eNZuJnJwd4N+iKlsCZgMpDarGbZLWLv+TEneomOvRfdTeogl6hQIXT1MCF5VEhpmeAy4majZ0U+jz6/vl5g3F67BSK7EykOwtNIMGkOEfQTrWSZyP4mEsMbShC2pYCQRD+tIeP1yVEGVkOfxt/ELdiz7wrla2GNkb5QROKEgre9anOVVJ6cS99qqzDI6geEJ8T9Ay4pMpjBfGDC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(9686003)(7696005)(71200400001)(6506007)(83380400001)(478600001)(26005)(2906002)(76116006)(7416002)(316002)(6916009)(64756008)(54906003)(66446008)(66476007)(66946007)(8936002)(66556008)(52536014)(5660300002)(41300700001)(4326008)(8676002)(66574015)(33656002)(55016003)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlNmWlFkUmoreTBGNHFNdHQ2VDllZEF2V05qU3VacmVpZkFXQ1l6dUYzeDYw?=
 =?utf-8?B?b2g1a3ZnQnozWkRnR2wwYTRHTVg3clFhazRIdjQvK1lld1lMTzcycXFuTjFq?=
 =?utf-8?B?eXRkK3NKYnlLeTRyTzgvNWxYYVMvNTZKbWFFSEpwbExKZDRLY082YjNDbjNU?=
 =?utf-8?B?ZVEzSHpnL0lESE4zUXlYbjRJNWwwM0ZuSFZPTEFNaXlEcWF3ZUtHdWd2UEhx?=
 =?utf-8?B?bFlwVm56QlZpTTNkLzE5aHpMVEdXalQ3dm43NzBwWk1NclJDNXYvdjZlcUJJ?=
 =?utf-8?B?QzcxVDVaY2RzdS9pendVVGI4L2lVM3o0ZXN3TndneG5kcWZhMFhiY1dUbFhM?=
 =?utf-8?B?Q3EwZzhsVU80eVE4QjUyc0pKZ0lwOXUycU5zeGc0VXBJN3I4U084QkI5VFpo?=
 =?utf-8?B?c1JUSjBlRUVDR1BjcUlyMnJ4Y1NaeVJ0Qi9RK1dkQ3E1Vjl3S082Um1CcFhI?=
 =?utf-8?B?L2RIa0JQMmRPd1pJMThWSHAvRGorK2VzVlY5SThxVjRQMHgxSmhuMXdHY1JP?=
 =?utf-8?B?TFdLRzFNd2FPTEEyb1crSVJBaEJOdWk5cmR1VGJjNm05aDltekRFT2UyZEt0?=
 =?utf-8?B?elRPSmREM0pwMEV2azJpeW1UUzFiYk5HTjdCcC9kR2N3aERKSG9Hb2xsSnZl?=
 =?utf-8?B?ZlhBN0FCcmRscXFFcGZFZi81ekdvWEdTTng0dTNyK1lUWlFwbExOVFJzM3RM?=
 =?utf-8?B?MHNFOUZqSXhkdUJwV0RiakR4U1hVM0F0Lzl5cE9TRW5uaVY5YnV0cmJOT3Js?=
 =?utf-8?B?dDhhOS92NkRaTitJSW44V2pHUDdSV3lpWHdycDVQd2pWK1NtMVUrSE9YUHF5?=
 =?utf-8?B?ODJNSmxxZ2JkSUNUVCtUNldTL1lrMkh6VER5WGZIOXV3TStSWGphN08xbXRo?=
 =?utf-8?B?V1p5V1JjUURrdW1NTkx5OVFKeEFNdUFEdmhxRnZRZHBYamo4b0ZOSStZMHFJ?=
 =?utf-8?B?VDR6SDJUSUV5aTNtMVM4WkxXUUZGS0xyWEwzTGJXV3RibFhMeDI4L1ZYM3Fu?=
 =?utf-8?B?TWV2Ti9SQy82eDlocTBraXJ4NmY1RXRrcEw0QStYb0xPTWZJTUVGSW1RclBp?=
 =?utf-8?B?RkVkQm0xMnlFWmhFL3p6ZmpqcjhYckdqZkdKNzdjS3I4cHR1dGliV1RhbXlM?=
 =?utf-8?B?cUxoanBZMk5FQytNYk9HOVpHTi9kbFlUc2prdXMya2tJRW9UMFNWdzhVUzdF?=
 =?utf-8?B?amU2d1BRdXRnSHpIamdpb0Q3UlgvMjVzaDB1cFNzVlJwVWE0WXNTNlVSeDNZ?=
 =?utf-8?B?L0Q3TWtmM1FLT1hRb1h2dktxN1JaSjZld2F6aG56TGFPeStnOUpqRzlLbzlS?=
 =?utf-8?B?VkpSc2VkWWdYdEd5UFl6bmVvWXRTZTBkWHFDeGVKalJ1eStqTXZZeE56Y2k1?=
 =?utf-8?B?UUxlTWIrZ3o4QnI3ZTlxeExXTGdlclRmbERVbHJVVStBR1Q5NnNYQlNpUFBY?=
 =?utf-8?B?Z1FOM0xPTjZzcHh5RkMwRnkzdnFNTFYwUDlKdDhiMk4yMkw4YXV5ancwTUFF?=
 =?utf-8?B?bGVKaWFJanJrS0F5MjU5cjVubjFzQjFOSUJwZEk4ZU5sZjd6WmVYdzFnWElG?=
 =?utf-8?B?emUvb05uTTBrcnlVWHd3Q3ZiM0JyWDZ6elFldWd1OHNXM08zRXZxdTArUVRq?=
 =?utf-8?B?NFFHZ0p5RzdFRlRPUEh4akhxQnZFUUx1bEJQUmVoQ1RwQVlyVTF1MFEzSmhR?=
 =?utf-8?B?dG15aXZzM0wvZGY2bklHTGsyd0NzeTUxZzJ2RVFGOHlsaU9nemFsTUEwUEZV?=
 =?utf-8?B?R2JYRmRFNWVIUExYNm5YdFNlUnpwdjZpTDI5Tk1ZSE9DelJvZEorck5ESFph?=
 =?utf-8?B?dThNRHdSLzlyNDhpQTRNMEZKVmloUW5nUzdFSm1jYlVxQzdWdk9oTG8rR2da?=
 =?utf-8?B?U0ZIQVFseWt6bk4yWVJRQ3M1M2NBUW51YmtBdXpkM05EcEM3SWN2UkxJUGJH?=
 =?utf-8?B?NEIzeTBhNjVobUY0Qm9hT2lGM1diR3dFUjJlYjFCT0xLOU0zS0JRaFI5S1d6?=
 =?utf-8?B?cW9wKzZabmJ3VXBnbW15TnJlTzlRR0Q0WUJ1U2lYd0FQUnpZK1RpWm5oZW5H?=
 =?utf-8?B?T1pCa0ZRa2FueXpHTmwrdjhIa0hwVmZZTHI2UEdFWUZwOGlQaWEzL1BRc3JO?=
 =?utf-8?B?R3c2RDI4RWRXdXFWL2cwS2tEYktpU1Q5a1k1Z3ZTVGpGNUkyNmdrQUp6VjJD?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0392e34-14ce-41ff-2326-08dba887df4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 12:02:52.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: keiu/ORcl1JjjbHKDk0xh94jfJDSPFbisFGnX6sM34dVaIvimt94QTrmfFyknbUYh6t6hXx6mV5Xy/o160PrmXuQJ1neyp36NTLztqkYfOdqipPS5GhF1vkNuvzJ5LFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IE1vbmRheSwgQXVndXN0IDI4
LCAyMDIzIDEwOjU4IFBNDQo+IA0KPiBIaSBZb3NoaWhpcm8sDQo+IA0KPiBPbiBNb24sIEF1ZyAy
OCwgMjAyMyBhdCAwMToxOToxN0FNICswMDAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4g
PiBIZWxsbyBLcnp5c3p0b2YsIFNlcmdlLCBNYW5pdmFubmFuLA0KPiA+DQo+ID4gPiBGcm9tOiBL
cnp5c3p0b2YgV2lsY3p5xYRza2ksIFNlbnQ6IFN1bmRheSwgQXVndXN0IDI3LCAyMDIzIDM6NTkg
UE0NCj4gPiA+DQo+ID4gPiBIZWxsbyBldmVyeW9uZSENCj4gPiA+DQo+ID4gPiA+ID4gQWRkIFIt
Q2FyIFM0LTggKFItQ2FyIEdlbjQpIFBDSWUgSG9zdCBhbmQgRW5kcG9pbnQgc3VwcG9ydC4NCj4g
PiA+ID4gPiBUbyBzdXBwb3J0IHRoZW0sIG1vZGlmeSBQQ0llIERlc2lnbldhcmUgY29tbW9uIGNv
ZGVzLg0KPiA+ID4gPg0KPiA+ID4gPiBObyBtb3JlIGNvbW1lbnRzIGZyb20gbXkgc2lkZSBmb3Ig
dGhpcyBzZXJpZXMuIEl0IGxvb2tzIGdvb2QgdG8gbWUNCj4gPiA+ID4gbm93LiBJZiB5b3UgaGF2
ZSBub3RoaW5nIHRvIG5vdGUgdG9vIHBsZWFzZSBtZXJnZSBpdCBpbiBlc3BlY2lhbGx5DQo+ID4g
PiA+IHNlZWluZyBpdCdzIGFscmVhZHkgdjIwLikNCj4gPiA+DQo+ID4gPiBZZXMsIGl0J3MgYWJv
dXQgdGltZSB3ZSBwdWxsIGl0LiAgVGhhbmsgeW91IGV2ZXJ5b25lIGludm9sdmVkIGluIHRoZSB3
b3JrDQo+ID4gPiBoZXJlLCBlc3BlY2lhbGx5IHJldmlld3MgKFNlcmdleSBhbmQgTWFuaXZhbm5h
biksIGFzIHRoZSBzZXJpZXMgbG9va3MNCj4gPiA+IGFtYXppbmcuDQo+ID4NCj4gPiBUaGFuayB5
b3UgdmVyeSBtdWNoIGZvciB5b3VyIHN1cHBvcnQhDQo+IA0KPiBJdCB3YXMgbXkgcGxlYXN1cmUg
dG8gYmUgcmV2aWV3aW5nIHlvdXIgcGF0Y2hzZXQuIFRoYW5rcyB5b3UgdmVyeSBtdWNoDQo+IGZv
ciB0aGUgcGF0aWVuY2UgYW5kIHN0cm9uZyBlYWdlcm5lc3MgdG8gY29tcGxldGUgdGhlIHR1cm5l
ZCBvdXQgdG8gYmUNCj4gc3VjaCBhIGxvbmctdGltZSBwcm9jZWR1cmUuIEknbSBzb3JyeSBpZiBz
b21ldGltZXMgSSBhY3RlZCB0b28NCj4gbWV0aWN1bG91cy4pIEl0IHdhcyBhbHdheXMgZG9uZSBm
cm9tIG91dCBvZiByZWFjaGluZyBncmVhdGVyIGdvb2QuDQoNCkkgYXBwcmVjaWF0ZSB5b3VyIHN1
cHBvcnQuIE15IHBhdGNoIHNldCBiZWNhbWUgcXVpdGUgYmV0dGVyIGJ5IHlvdXIga2luZGx5IHJl
dmlldyENCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBSZWdhcmRzDQo+
IC1TZXJnZSh5KQ0KPiANCj4gPg0KPiA+ID4gVGhhdCBzYWlkLCBzb21lIHBhdGNoZXMgaW4gdGhl
IHNlcmllcyBkbyBub3QgYXBwbHkgY2xlYW5seSBhZ2FpbnN0IDYuNS1yYzEsDQo+ID4gPiBzbyBJ
IG5lZWQgdG8gaGF2ZSBhIGNsb3NlciBsb29rIGEgbGl0dGxlIGJpdCBsYXRlciwgaG9wZWZ1bGx5
IEkgd2lsbCBiZQ0KPiA+ID4gYWJsZSB0byBnZXQgaXQgaW4gdGltZSBiZWZvcmUgQmpvcm4gc2Vu
ZHMgaGlzIFB1bGwgUmVxdWVzdC4NCj4gPg0KPiA+IEknbSBzb3JyeSBmb3IgYm90aGVyaW5nIHlv
dSBhYm91dCB0aGUgY29uZmxpY3QgYmVjYXVzZSBteSBwYXRjaCBzZXQgaXMgYmFzZWQgb24gcGNp
LmdpdCAvIG5leHQsDQo+ID4gbm90IDYuNS1yYzEuLi4gQnV0LCBhbnl3YXksIHRoYW5rIHlvdSBm
b3IgYXBwbHlpbmcgdG8gY29udHJvbGxlci9yY2FyIQ0KPiA+DQo+ID4gPiDjgrfjg6Ljg4DjgZXj
gpPjgIENCj4gPiA+DQo+ID4gPiDkuIDpgKPjga7jgrfjg6rjg7zjgrrjgYrnlrLjgozmp5jjgafj
gZfjgZ/vvIENCj4gPiA+IOeJueOBq+OAgeS9nOalreOBjOWwkeOBl+WJjeOBq+mWi+Wni+OBleOC
jOOAgeODrOODk+ODpeODvOOBleOCjOOCi+OBvuOBp+OBq+aZgumWk+OBjOOBi+OBi+OBo+OBn+eC
ueOBiuaJi+aVsOOCkuOBiuOBi+OBkeOBhOOBn+OBl+OBvuOBl+OBnw0KPiA+ID4g5YWo44Gm44Gu
6KaB5rGC5aSJ5pu044Gu6L+95Yqg44Gr44GU5Y2U5Yqb44GE44Gf44Gg44GN44CB44GC44KK44GM
44Go44GG44GU44GW44GE44G+44GZ44CCIOWAi+S6uueahOOBq+OCguacrOW9k+OBq+aciembo+OB
hOOBp+OBmeOAgg0KPiA+ID4g44GU5ouF5b2T44GE44Gf44Gg44GE44Gf5LuV5LqL44Gv57Sg5pm0
44KJ44GX44GE44KC44Gu44Gn44GX44Gf44CCIOmHjeOBreOBpuOBq+OBr+OBquOCiuOBvuOBmeOB
jOOAgeOBqeOBhuOCguOBguOCiuOBjOOBqOOBhu+8gQ0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5
b3VyIGNvbW1lbnQgaW4gSmFwYW5lc2UhDQo+ID4g44GT44Gh44KJ44GT44Gd44CB44GC44KK44GM
44Go44GG44GU44GW44GE44G+44GX44Gf77yBDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4g
WW9zaGloaXJvIFNoaW1vZGENCj4gPg0KPiA+ID4gVGhhbmsgeW91IQ0KPiA+ID4NCj4gPiA+IAlL
cnp5c3p0b2YNCg==
