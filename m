Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE5544607
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiFIIgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiFIIgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 04:36:49 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130083.outbound.protection.outlook.com [40.107.13.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201DF3D8BBD;
        Thu,  9 Jun 2022 01:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN99ZjQKUZLJztYRLgwUnU6OnHtrZO1n0o4GIAWJf8DrGn2plkXgX0TG5oPfDDSHGX2A2MTOA4MyBH5e1ycOWl1GPNxyO9IxDlv5b6v9ukiqiRZrN6k8GC6/C1FHddRqMK23LZkGT3yeYcHV3fd66swurqlVkxyp+ofxQgK4vaO2gE7NnGU6vCS3NDsjys3C0vd3MQKJGV7RRLAz0XAWVweHROh3wp0rOOAa+cseGneB5f0QiX0Xa6x/jG6O+qcd/xWvpCCLgxbUB2W1wtIsW0K929NujFjl2MAqMaSL2ENVQG8nqUVfdIoU/q55WXaGEqeFd7lBtZ2tLAr3kLSuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1TMbnXBywzBXpCN+JXuKM3Xy29yGobvaZsCHOYIMhc=;
 b=ci5GW/3V8dmbrocIKywFP+8rru0TKPBg+dzPaOYKqonS7+uF317N5QhJVYziGSgC17KGGNA9q8JUBEY524/8KUj2ep2Ghw+kthvcgma2VYqFId6hzHgkIdONJrDYI4MlmoK8juupUfsfSHhVUo5IyEuHMUJ9IG3yRZRTbha2qNdzVhefBctZoydtM1AiAiT5KDqzRTHy7Yi7lSLK9oF628zzYdxYPFELnbfTzS38Vp7KmQ3macHe0Fm6S+bypHHnwSwOTvtNfgbKHG5MMyDQbDSO5yvda1z3smTUIkz5b1q878KPZP1jzZhfkz5AJ3xlGVNlKWN1oP/yvAd7N5JsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1TMbnXBywzBXpCN+JXuKM3Xy29yGobvaZsCHOYIMhc=;
 b=EPIsGR7VbiupMzClz1SPoxcm4sriEgevgQyjBrsY6e7QjS3FoNUvAv8gsE5pT/GHBME1SF7oLTfFmope5jmuTiZ1EmUXu/l1GurlTvigSeYDmYLH3K9CTrFXz9bBFTZv67aJ/0AnQrx+MV8cqoDEnDeIPxL154EjsmQNI+9j45U=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 08:36:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 08:36:45 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Thread-Topic: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Thread-Index: AQHYYOzgdcPKaCfHJE+sY2pPsqwsuK1FUrsAgAF0kuCAACLAgIAAAJQA
Date:   Thu, 9 Jun 2022 08:36:44 +0000
Message-ID: <AS8PR04MB86761E1C2D0C4CBE5E285BA88CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
 <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
 <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
 <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220609075305.GA20630@francesco-nb.int.toradex.com>
In-Reply-To: <20220609075305.GA20630@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c5d0788-45f0-4635-bdc6-08da49f32f90
x-ms-traffictypediagnostic: VI1PR04MB3984:EE_
x-microsoft-antispam-prvs: <VI1PR04MB3984A0C2A6851F70B98504988CA79@VI1PR04MB3984.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EbT1GmY2cBEi96yi96vFxKVcCAViUBgJjXYcyh81iUX+DZd2WBxojKg2C2/fMWOw33CHmf6uS2WS+dPb/YMUv39+9Eg4t2DO3sQREH45UvEUygNI7dmg5YRLIguPTgbqYvxshk+Rj4znbwEQ4Oz1/AUbx/Z5rDEbdYQAI9AnDGbrvXkfViIAMnDYxcwfNxFOZbmZ74KYETTR4h5evPz6DFIJJzPhISOxaMZ3ed77Jo+uh5p9f/oAlRyVMKQzYAsMnCHAs+k2nhuQVVrMPJIXZ4RW8Rdb5kGl6qFmg4zB8UdvwmPB5s7tmYZKXoNW4qU10gRi3lT4x04y29+HDzkVvZcWYsyseVT1wD55rYoVnjcIVLPhSd8/1sYNyTdV9camIdwUQa7jysvMMNZXhd9iZIEjZUGfEkumvZ5Pwp7iCzH9dVGrBJE42d8u0Qm3lR6FRupJO+E0+twf0sINTXTL2hIlIOXxq0iHy2vSCtR6wHeXdv7iIQ0XV8Jxe/tf6+7cqXletqC7RbB487WFJNbxhCjtN5YiM9qNbx3i0rvyIrfbgDdgmd2Ee6b9IJmtBeu4lVIzi3jVGT0nWl9Hp9qCkCVx3FQ5pvdqahhXHE87CZ0plToHm9NRY5r1d+ndXqKslGFJtr+C4+k0WAhW//hJoziannCPdAgOH8mc6losnosWP79tawYEQU3v8LIIYEkuCiQewx4zc2ichaMK0iY81Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(186003)(508600001)(8936002)(54906003)(38100700002)(52536014)(66446008)(76116006)(55016003)(66556008)(66476007)(64756008)(66946007)(8676002)(4326008)(5660300002)(7416002)(2906002)(71200400001)(38070700005)(316002)(83380400001)(33656002)(26005)(122000001)(7696005)(6506007)(9686003)(86362001)(53546011)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnpuUnovK0MwR0ZTM0RoVjNPbzJuUFJOYitkWlFRUVRNSWc4dlFkTTZlWTBk?=
 =?utf-8?B?WDY0OGVwRHlhUktTZXRMN1FtWFhCV0dYSXdYK3VMdDlNWUlOVkh4MU40cTBk?=
 =?utf-8?B?TVo0ZW1qZHYwVjlCbG85eVJyUWVKdCtzQzVKYkx4MWo3RGZMeUFYdUNCNHB4?=
 =?utf-8?B?SkpWUzFSdDRaUmNET0dSK2tNdHIrQXpTOGRxOXVpaW5DekdMTXlWdE9GZjgw?=
 =?utf-8?B?S1NWYVZJT2FpUEc5ZmU3emtkUW4zUm1GaXlZd2dYdWFoeE4xSFFKZHpJSlJo?=
 =?utf-8?B?Vk9sQkhGdURzNks5aGVJUFN4a1NvclBpTEZ1MXN2S2dyejRKbklpMnpnNjFL?=
 =?utf-8?B?QjN0OUdidEs1bTVid0h4OEtqbWhCc243YVZNY3FGQ09qdVdBMmNLS1Z6OFFv?=
 =?utf-8?B?TEdjUWdVWS9iMWxLSVJnZ3VWekhvOEE1V2doaFNsZDlLWDNaNk15dWRWTTlM?=
 =?utf-8?B?eHNlRFpjOG1EaUlWMWxlZHU5QlUvc2ZvaEF0anh0L2VwWHlEeGxYWGZxdGtk?=
 =?utf-8?B?WFNLczN4eGJsVXV5NkZMUG1kcXA5cUpzdEQwYVFmTjlTaGpWVFlQdllOV2dx?=
 =?utf-8?B?bThRWHNmV05XbWVWeFRNNGxPc0pUb3EraHhsa0hRUWxwZ1VobWRKUmp4Z1hN?=
 =?utf-8?B?S0lPR2hXZUNZTkhRa2pmYUlETlFNcjJtQmx5OUhvano1YkxhUXlxM3dpNHBX?=
 =?utf-8?B?cHd2QXRRd094SkRjazZneFQ3bUtVV3pYUWZJeVZ4cnVvbnMvSndVQi8wbzZT?=
 =?utf-8?B?V3VJWE92ZEg5OUlIRURBeXlENE00MVZjL1o3eFA2TmhPSUFTQUdHcVJkdUVK?=
 =?utf-8?B?a2tXbFFjM2NMRFZudmZXRGY4QlpyL1dGcWVzQWJJNll0TEUrVERxcXN2RVVV?=
 =?utf-8?B?UlhGWSt2SnFtVkFTSW5MdGJuZHZ2NXViL3ZNMjV5VkdWZk5mVElVMVZaR2dw?=
 =?utf-8?B?MFJSOFd3b2phRlIrN0JqNlJtRnhhRUtHS1dsMVVjYXhQTkovdXZRNHVXSmdL?=
 =?utf-8?B?MHZNSmZudHhwR3RheUU4ZzJFUHlzakpRUGltNEdyZTA0RjBsTDFSTWxtbERS?=
 =?utf-8?B?TmFQT1R0Z1FaQUhOMk0xdHpBNFVYMU45N2s1TEpxWkhDTEV6QkhUbk1TTllJ?=
 =?utf-8?B?TFFOSnBNRUx2RTV3UitmNGdVWStLQnpHYllQc05ESjh1TFl2M1RobFJUQ25o?=
 =?utf-8?B?QUtSRDhZdm5uckNxRE1pWE5FWnpmZTEyUzNhUi9zU0RzNHRtWmV5S2VTbDk0?=
 =?utf-8?B?NVBCbjNNWUN1b1V1TEczNGRIOS9qc09MYWhJdXhnS3FNc0I2S2tHS3VUVFZ4?=
 =?utf-8?B?MlFSWTFnd3htYy81SFNTeVd1R2dkcnVyREtNYlJQbURpV3dsRDFGN0lQWjQ0?=
 =?utf-8?B?b2w3a0hUbjRyVVN3ZllITTZHNUMxc3MrdHRrSFVPTTRDU09McFVpMGxTU3Rm?=
 =?utf-8?B?RktOeWZxcG50clhMWVpqK1NCQUovT1AyVkxKMjhjVjBXUEQ5QTl5c1FSakd4?=
 =?utf-8?B?aUJndlMyMG5icnJlQlByRW9GZi9OWlJBM1h5OTgwVmI3ZjluM3VhekhJc0wy?=
 =?utf-8?B?elArWkN5ZVdwZDc3RzducUNTckhwQXlKVFkrMGxTOVp0ZllKamw3b3JJOVND?=
 =?utf-8?B?S1I3SGRFVUJsMEUxNkUxWVBleWNmQ0s0ZngxQm9qbmlxRlE1ZGxtNU8yWnhq?=
 =?utf-8?B?Q3c3N1JEMlV4VGFHbmc4MmliT3Z6Nnh0VHIrNGZtYWhoNmUrNklhZmZMUTJZ?=
 =?utf-8?B?MUNjS2xsT0c3NkxsK0gxYWk0TzByWERKVkp5Q3RHK0NFQUVPUHk1TkZINjFs?=
 =?utf-8?B?VC9sOTNETEJ0Z3RGN0Q2aTJCWUxFV3RMTUtoa1JjRmlUWDVPQzlMU3ZHSVlm?=
 =?utf-8?B?SjRMaFVrZERDaHNlUXl1UnEzNDhmRnNteTJXM3hkbTd5OWhVSGFoaTR1bGNK?=
 =?utf-8?B?U04vOXpQNmtEU2NTeWQ1VDJpcXVydzZyenFBalQ3RlZHV29UZTB0VlJsOXBV?=
 =?utf-8?B?cWp2b05rTjU3ODhxRjdrb1pFaStkVTFpT2tOVU9reklvNnJkN2RKUU5WL2hV?=
 =?utf-8?B?T1c5NmJsR1laejlTeFI2ZktNdlFoVjBrSlZkQnhDVXhKUklkblpBUGk4RGIr?=
 =?utf-8?B?OEFtVitmNkhqV0ZTSTJoQmdxOWI1ZXRoSW42S0tpOTdmOW84bWUvOWlaNmZN?=
 =?utf-8?B?VHQ3OTlLZGc0MDlyV1JWdmJLckd4L1ZsSWFScVdlQWl5UXNtMk1ENmdnWXE4?=
 =?utf-8?B?RTRrRVA3UjNBU3JuSVpobS9xeTlDSHAzMzZBT1haS0NGeXZMMFFNOUdtOUVK?=
 =?utf-8?B?MkRnSmVqaGxJUXJlb1lqcENlbEFFZWNCTGYyNjVFZHh2bUtNQlpBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5d0788-45f0-4635-bdc6-08da49f32f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 08:36:44.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65WbQB+4jvgfmttWA8N92YPxLU1QkXdhV4BLO2Pvk8LvtKFRoN9ssbKk15nZ49Y8erZ/vZieQROKYpTzlsde7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLlubQ25pyIOeaXpSAx
NTo1Mw0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEx1
Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA2LzhdIFBDSTog
aW14NjogRGlzYWJsZSBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMgYWZ0ZXIgbGluayBpcw0KPiBkb3du
DQo+IA0KPiBPbiBUaHUsIEp1biAwOSwgMjAyMiBhdCAwNjoxNzo0NkFNICswMDAwLCBIb25neGlu
ZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBTZW50OiAyMDIy
5bm0NuaciDjml6UgMTU6MzUNCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiA+IHJvYmgrZHRAa2VybmVsLm9yZzsg
YnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiA+ID4gamlu
Z29vaGFuMUBnbWFpbC5jb207IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGZyYW5jZXNjby5k
b2xjaW5pQHRvcmFkZXguY29tDQo+ID4gPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4g
PiA+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNi84
XSBQQ0k6IGlteDY6IERpc2FibGUgY2xvY2tzIGFuZCByZWd1bGF0b3JzDQo+ID4gPiBhZnRlciBs
aW5rIGlzIGRvd24NCj4gPiA+DQo+ID4gPiBBbSBGcmVpdGFnLCBkZW0gMDYuMDUuMjAyMiB1bSAw
OTo0NyArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+ID4gPiBTaW5jZSBpLk1YIFBDSWUg
ZG9lc24ndCBzdXBwb3J0IGhvdC1wbHVnLCByZWR1Y2UgcG93ZXIgY29uc3VtcHRpb24NCj4gPiA+
ID4gYXMgbXVjaCBhcyBwb3NzaWJsZSBieSBkaXNhYmxpbmcgY2xvY2tzIGFuZCByZWd1bGF0b3Jz
IGFuZA0KPiA+ID4gPiByZXR1cm5pbmcgZXJyb3Igd2hlbiB0aGUgbGluayBpcyBkb3duLg0KPiA+
ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYyB8IDE5ICsrKysrKysrKysrKysrKy0tLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4g
PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gaW5kZXgg
M2NlMzk5M2Q1Nzk3Li5kMTIyYzEyMTkzYTYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiBAQCAtODQ1LDcgKzg0NSw5IEBAIHN0
YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUNCj4gKnBjaSkNCj4g
PiA+ID4gIAkvKiBTdGFydCBMVFNTTS4gKi8NCj4gPiA+ID4gIAlpbXg2X3BjaWVfbHRzc21fZW5h
YmxlKGRldik7DQo+ID4gPiA+DQo+ID4gPiA+IC0JZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7
DQo+ID4gPiA+ICsJcmV0ID0gZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7DQo+ID4gPiA+ICsJ
aWYgKHJldCkNCj4gPiA+ID4gKwkJZ290byBlcnJfb3V0Ow0KPiA+ID4NCj4gPiA+IFRoaXMgYWRk
cyBiYWNrIGVycm9yIGhhbmRsaW5nIHRoYXQgaGFzIGJlZW4gaW50ZW50aW9uYWxseSByZW1vdmVk
IGluDQo+ID4gPiBmODFmMDk1ZTg3NzEgKCJQQ0k6IGlteDY6IEFsbG93IHRvIHByb2JlIHdoZW4g
ZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkNCj4gZmFpbHMiKS4NCj4gPiA+IFdoaWxlIEkgYWdyZWUg
dGhhdCBkaXNhYmxpbmcgdGhlIGNsb2NrcyBhbmQgcmVndWxhdG9ycyBpcyB0aGUgcmlnaHQNCj4g
PiA+IHRoaW5nIHRvIGRvIHdoZW4gd2UgZG9uJ3QgbWFuYWdlIHRvIGdldCBhIGxpbmssIHdlIHNo
b3VsZCBzdGlsbA0KPiA+ID4gYWxsb3cgdGhlIGRyaXZlciB0byBwcm9iZSwgc28gcGxlYXNlIGFk
ZCBhICJyZXQgPSAwIiB0byB0aGlzIG5ld2x5IGFkZGVkDQo+IG5vbi1mYXRhbCBlcnJvciBwYXRo
cy4NCj4gPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCj4gPiBUaGVy
ZSB3b3VsZCBiZSBhIGxvbmcgbGF0ZW5jeSBpZiB0aGUgbGluayBpcyBkb3duIGFuZCBwcm9iZSBp
cw0KPiA+IGZpbmlzaGVkICBzdWNjZXNzZnVsbHkuDQo+ID4gU2luY2UgdGhlIGR3X3BjaWVfd2Fp
dF9mb3JfbGluaygpIHdvdWxkIGJlIGludm9rZWQgdHdpY2UgaW4gZXZlcnkNCj4gPiBkcml2ZXIg
cHJvYmUgIGFuZCByZXN1bWUgb3BlcmF0aW9uIGxhdGVyLiBFYWNoIGR3X3BjaWVfd2FpdF9mb3Jf
bGluaygpDQo+ID4gd291bGQgY29uc3VtZSBhYm91dA0KPiA+ICA5MCwwMDAqMTAgfiAxMDAsMDAw
KjEwIHUtc2Vjb25kcy4gSSdtIGFmcmFpZCB0aGF0IHN1Y2ggYSBsb25nIGxhdGVuY3kNCj4gPiB3
b3VsZCAgYnJpbmcgYmFkIHVzZXIgZXhwZXJpZW5jZS4NCj4gPg0KPiA+IEhlcmUgYXJlIHRoZSBs
b2dzIHdoZW4gcHJvYmUgaXMgYWxsb3dlZCB3aGVuIFBDSWUgbGluayBpcyBkb3duOg0KPiA+IFsg
ICA1NS4wNDU5NTRdWyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQTTogY2FsbGlu
Zw0KPiBpbXg2X3BjaWVfcmVzdW1lX25vaXJxLjc0MmRmYTA3NGI0MGRjYTdjYTkyNWYwYzQ5Yzkw
NWVjLmNmaV9qdCsweDAvMHgNCj4gOCBAIDE4MzUsIHBhcmVudDogYnVzQDVmMDAwMDAwDQo+ID4g
Li4uDQo+ID4gWyAgIDU2LjA3NDU2Nl1bIFQxODM1XSBpbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6
IFBoeSBsaW5rIG5ldmVyIGNhbWUgdXANCj4gPiBbICAgNTcuMDc0ODE2XVsgVDE4MzVdIGlteDZx
LXBjaWUgNWYwMDAwMDAucGNpZTogUGh5IGxpbmsgbmV2ZXIgY2FtZSB1cA0KPiA+IC4uLg0KPiA+
IFsgICA1Ny4xODIzMDBdWyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQTToNCj4g
aW14Nl9wY2llX3Jlc3VtZV9ub2lycS43NDJkZmEwNzRiNDBkY2E3Y2E5MjVmMGM0OWM5MDVlYy5j
ZmlfanQrMHgwLzB4DQo+IDggcmV0dXJuZWQgMCBhZnRlciAyMTM2MzM0IHVzZWNzDQo+ID4NCj4g
PiBbICAgNTcuMTgyMzQ3XVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMTAwMDAucGNpZTogUE06IGNh
bGxpbmcNCj4gaW14Nl9wY2llX3Jlc3VtZV9ub2lycS43NDJkZmEwNzRiNDBkY2E3Y2E5MjVmMGM0
OWM5MDVlYy5jZmlfanQrMHgwLzB4DQo+IDggQCAxODM1LCBwYXJlbnQ6IGJ1c0A1ZjAwMDAwMA0K
PiA+IC4uLg0KPiA+IFsgICA1OC4yMTA1ODRdWyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAxMDAwMC5w
Y2llOiBQaHkgbGluayBuZXZlciBjYW1lIHVwDQo+ID4gWyAgIDU5LjIxMDgzMV1bIFQxODM1XSBp
bXg2cS1wY2llIDVmMDEwMDAwLnBjaWU6IFBoeSBsaW5rIG5ldmVyIGNhbWUgdXANCj4gPiAuLi4N
Cj4gPiBbICAgNTkuMzE4MzEzXVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMTAwMDAucGNpZTogUE06
DQo+IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEuNzQyZGZhMDc0YjQwZGNhN2NhOTI1ZjBjNDljOTA1
ZWMuY2ZpX2p0KzB4MC8weA0KPiA4IHJldHVybmVkIDAgYWZ0ZXIgMjEzNTk0OSB1c2Vjcw0KPiA+
DQo+ID4gU28sIEknbSBwcmVmZXIgdGhhdCBpdCdzIGJldHRlciB0byBsZXQgdGhlIHByb2JlIGZh
aWxlZCB3aGVuIGxpbmsgaXMgZG93bi4NCj4gPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoYXQ/
DQo+IA0KPiBJIHRoaW5rIHRoYXQgcmVjZW50bHkgQmpvcm4gbWVudGlvbmVkIHNvbWUgY29uY2Vy
biB3aXRoIHRoaXMgYXBwcm9hY2gsIGFuZCBJDQo+IGFncmVlIHdpdGggaGltLg0KPiBJIHRoaW5r
IHRoYXQgdGhlIHByb2JlIG9mIHRoZSBQQ0llIHJvb3QgcG9ydCBzaG91bGQgbm90IGZhaWwgaWYg
dGhlIGxpbmsgaXMgZG93bi4NCj4gDQo+IFdoYXQgaXMgdGhlIHJlYXNvbiBmb3Igc3VjaCBhIGxv
bmcgd2FpdCBpbiBkd19wY2llX3dhaXRfZm9yX2xpbmsoKT8gSXMgdGhpcw0KPiBzbG93aW5nIGRv
d24gdGhlIHJlc3VtZSBwcm9jZXNzIGFzIGEgd2hvbGU/IFdoeSBjYWxsZWQgdHdpY2U/IChJJ20g
bm90DQo+IGZhbWlsaWFyIHdpdGggdGhhdCBwYXJ0IG9mIHRoZSBjb2RlKQ0KPiANClRoYW5rcyBm
b3IgeW91ciBjb25jZXJucy4NClRvIGF2b2lkIGEgY29ybmVyIGxpbmsgZG93biBpc3N1ZSwgaU1Y
IFBDSWUgZHJpdmVyIGZvcmNlIGxpbmsgdXAgR0VOMSBzcGVlZA0KZmlyc3RseSwgdGhlbiB0cnkg
dG8gbGluayB1cCB0aGUgaGlnaGVzdCBzcGVlZCBsYXRlciB3aXRoIG9uZSBzcGVlZCBleGNoYW5n
ZS4NClNvLCB0aGUgZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgd291bGQgYmUgaW52b2tlZCB0d2lj
ZSBpbiBpTVggUENJZSBkcml2ZXIuDQoNCkx1Y2FzIGFuZCBJIHRyeSB0byBmaWd1cmUgb3V0IG9u
ZSBtZXRob2QgdG8gYXZvaWQgdGhlIGxvbmcgbGF0ZW5jeSB3aGVuIHJlc3VtZQ0KYmFjayBmcm9t
IHN1c3BlbmQgbW9kZSB3aGVuIGxpbmsgaXMgZG93biBhbmQgcHJvYmUgaXMgc3VjY2VlZC4NCg0K
QmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IEZyYW5jZXNjbw0KDQo=
