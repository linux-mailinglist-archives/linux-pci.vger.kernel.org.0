Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114E614A7B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKAMRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiKAMRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 08:17:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E715823;
        Tue,  1 Nov 2022 05:17:04 -0700 (PDT)
X-UUID: 94bb844090124bc4a2dc5d3c97e0ebf7-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=u5ov+aY1MrOKm32GldpLB/iZTwJ4PDmqwSVYjX0ZZxo=;
        b=ZZ2Qvo84rKRzvzIdOqwI+KRDRyRdj0VFg6llHyVescXc+qbdWdO3zH1uHMHXGbXMntGHc3abgFZb8JoZ7fbtxQ3xW+MWWvZvk2C9JlHjYeqUUSZDZiYzku29YVoRQ6z/fVJ3NS33jvgc4ByZJmwMLjhNrCcdjGPWxZuBlC/0/28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:52c43d66-9e30-4395-b830-3a76d3976307,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.12,REQID:52c43d66-9e30-4395-b830-3a76d3976307,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:cb134090-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:221101201700Q9DH86IX,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 94bb844090124bc4a2dc5d3c97e0ebf7-20221101
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 594674936; Tue, 01 Nov 2022 20:16:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 1 Nov 2022 20:16:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 1 Nov 2022 20:16:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgwGxZvwU3XPH4JmFUbKdyMHoGexADB0orID91xD7bYOoiZcV+ryZni+XAJxxowNOLl1z9/m16ZFz28qsYf6ZwVbMSkUG5VGVMnYs+UCHQ5kupCqQVN1sOfJuWjOBFsK9XV18yGuQVihyCpfSrYOBp5tOL+jklEMmC/b0jqfsCPPN+W6aK4B7hGlK+c8OhGR64jMdg8ciPt6N/k0bo03TqCt1+qpJn7K1t1z2V4NaY3P29eKnwMyWZdA5KJ4ESVIzNz5j+MhahO4Zdz9aA3gKrq0NIxzyyWR/MpCI+78OZHMFr8gmxxmNMoBLsjO74dlYBh3hSGoSH+ymkr6+ANg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5ov+aY1MrOKm32GldpLB/iZTwJ4PDmqwSVYjX0ZZxo=;
 b=Vqr4cttWURs9ocSvQYCMK/41ZQQWvGl2GSTXh3s97rXyQYgTX/VLHHuIgmRCd5HMgAkoUaU9Tps6iVxeyo4zHNoUtdMbtKXmM5c71MIRI86tnGFCm1vpkstQ2vq7p96e7vlNeSujkS75AgEQImGEWoqQpJaH474z1Ze45KFqa5w0F47+51Vnj4rYTZksD/+PqB9wmcaA5tDuM5P7YyEij5KQIC4nAeQVKmdjCB0qFdwjtRg31gPPkUkiMCdE3LyP+DwbLPTucika2T54w4ib2XW+aXE2257cCnqJEtSmwC2vjlCb2haIL7tKFFW4v8iHvP6zDRtiSNV/EWUq+dp2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5ov+aY1MrOKm32GldpLB/iZTwJ4PDmqwSVYjX0ZZxo=;
 b=NPT8Sb4nN2Pd6o9oDwv/SeTxKGCDjTEZbFO3UjdWEqg6VyYfIDyvAPTUmTIF7tFPKlxx6t28kqAwTJ+E1Go4KJGQfSgLwhzsy5+utpAukY4c7MNO7sBsVutR8JFL6PWq8DeK0NFC8cB/lKfMslkk2cThfLMTBda8xmZavoDbqWU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by KL1PR03MB6254.apcprd03.prod.outlook.com (2603:1096:820:a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.17; Tue, 1 Nov
 2022 12:16:52 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::5bc6:5d32:688c:2f60]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::5bc6:5d32:688c:2f60%2]) with mapi id 15.20.5791.019; Tue, 1 Nov 2022
 12:16:52 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Thread-Topic: [PATCH v3 2/2] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Thread-Index: AQHY68AMcIAWTlaK3k6iJFQjXhHZUK4qACEA
Date:   Tue, 1 Nov 2022 12:16:52 +0000
Message-ID: <543add599af2c6db565b46d1a7d6a7d4f3251e13.camel@mediatek.com>
References: <20221029175806.14899-1-frank-w@public-files.de>
         <20221029175806.14899-3-frank-w@public-files.de>
In-Reply-To: <20221029175806.14899-3-frank-w@public-files.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|KL1PR03MB6254:EE_
x-ms-office365-filtering-correlation-id: 0760598a-f9f4-4e38-8aa6-08dabc02f57b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7lJPxAWtlvPvpU+xQzLMr2CTxmNjlwIqvy7bbXR8Y25d55peTUTo/NAQcTje14d38Mggj3wY9OnG3sXIllBYx76kBv7qnQ4osr4W10KQYr1rsSs84LFHlbOU/u+N9BcljNnd1cutRVTh6gGmaXKLlq/bBCp3yFPY9RwQ/GhJjFuPbhiNo+t4iXkxjXlR1HHyP8N0hFdpW5ay/RQpD9XnJixs+yh8ntTxw00mjdoT/30ri6vdacIuWFl59FX2urmERHfvpYuhsPjs7HEe2uYw/hAeJRDFz7udSOtk6xbDjq/tybrHy6kz0rsccPMgbYiJBk/or2eBjEIJKZrwQPIarP35U9ooW41wfZ+D7V0TPSzb7hKQhPG5HcVfyTDt7BNAmPUBty/+IaI51XjqtnHL697H7ymrMLipBIIuRWJcyHdgENu7aFWtfkAQNoGXzAWKz0H+WUUpG2i+c8zOiFrZe2x8RBqnBeGV4c8RH2zZM8bJpJCYP7MxxPKiJzW7dzo2BcSj+C9uqV9myNxI6L+Xh156P7HXbxZzdkRHP6L53XARDP6Ty6vTogLM/luaDyZiajCe78tYm1fEiTaE5T3JpSQPwcApD6BVe08P9zA5hvQMwelc2a99PIh7PI/1M3lRho+FkZY84Updgso9xRwAUspKec1GxhD1a/oP48ieiEDjx+wanB+KT3sIb3LydvriPM8L8EZECu7PIAo4rKBCag5Bnze+DcP1YTdCxiGGXhzXUySWMnOGtg5K6JZjjd9oP45nruKTZ6vc4ZrrJHztvyJyINkPsxIfxyZy0mVUSQXUqnaOFfMgC6FmXZn7DWo6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(6486002)(478600001)(71200400001)(110136005)(38100700002)(54906003)(64756008)(316002)(122000001)(2616005)(83380400001)(85182001)(36756003)(8936002)(86362001)(2906002)(6506007)(4001150100001)(4744005)(186003)(26005)(5660300002)(66446008)(7416002)(66556008)(66476007)(38070700005)(8676002)(4326008)(76116006)(66946007)(6512007)(91956017)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0ZzZkgvQ0ZyMnU4aVVQb05XcDAvbjIvL3dOVytWZFhxdG85eERQUWVrVWRv?=
 =?utf-8?B?ZHBlaWpZWExlT2xLNTJ1dkdSWno2MnRIWjc3K21ESEM3YnFISE1oOGZsTTJk?=
 =?utf-8?B?dk5DNG84U25Xajh2RHN2RWFka0E1RmFkZGphOEhsUVBoMkVBc2ZCUnB4dGEw?=
 =?utf-8?B?SmFRYWtQVlZpSGdleVZITEFCOC9JL3gzaExwclhyK1RzVEFscEV3M05pY3NP?=
 =?utf-8?B?emxyQnFtUnFYNFBTdWFMVUZSRm9US0RGVUx4K1FxUFdLdEhDbEtxYWRtNFpX?=
 =?utf-8?B?TXJFakJUWlI0ZVBoNnRyLzl3QjRZd1JUQkxZQnM1dXdtMjVmUkw0QlREZDMr?=
 =?utf-8?B?ZDhYS2FDZGoxd0V4T1NtOXl0cEdJOVR2NDdLbFQzNEVRYjBaQjVlMWRwaWpv?=
 =?utf-8?B?dFd6OVpMWnczMC9udW9PQVZjaUpudmQ5VnhwMEdoTEo5M2pOcFc0KzJCak5T?=
 =?utf-8?B?Y2pyKzhTWUgrSHd3c3c5TUhsUEpLTXJVajlaYWxlWENYeGcwa3FCYlBvWW1Q?=
 =?utf-8?B?Vm90T2Q1MldlYkpqRzJvTitTeExydnhERElZNDE5cVBGdU5jcngzeENWaGRX?=
 =?utf-8?B?b1pMc2J2UE1TS2hEUGxpL1g4NlBMMmVzQXplSmRzaTFqeHVwNUc4dXJZR04w?=
 =?utf-8?B?UDlIdkk2eXFCQm9HeE02eFRJeWpwYjF6UmdvTUJ6UlpxVmhlb2xyMXFUalBo?=
 =?utf-8?B?WVAyR05lNk9xRnpzNldoblcrY2s4aFJZa1RsZmxZcjBRbGJQMnVMUVlOL1pH?=
 =?utf-8?B?amE3dFphZVZaL0dSZGxQd0l5eVl3Y0hWOXA4UHRaVDlYclpSRXk2cWlYVTAr?=
 =?utf-8?B?R0pCcGxTOFZsakFURHRSOXVMclJCTXF1TXA2bWRQMkQ1L3VFK1BpTFJiSHk1?=
 =?utf-8?B?Y0FPeldsTG5IbGhMOGFaWUcvWlN1ZGRMVTZpUGs4NzRlbGtGbG45QXczWmNi?=
 =?utf-8?B?Rm5RWmQ2dlJGZmkxNTF6Tng1RjhlR3JBR3pCdTJDL0xjVFBoWGJqUHQ5UUNL?=
 =?utf-8?B?WEhLT0ozRVJDcGNGdGNGVTh0eXhVS0VTWEpxM2VyOUgrZ0E2MFI3T1I4K3Vi?=
 =?utf-8?B?Z3pRMjZQN2RwR2xyS0llcGl4NDYxUG9yZmZRSkJhcWZvMTNHSlVVb1RvaVdH?=
 =?utf-8?B?QS9wdFVlckNFbGNpcXNBZnJlN2pwRTVmZGR1Ti9NVkNHSXNDZ2QrR3Jkdzh6?=
 =?utf-8?B?MWsyOGpnNVRXWitaRDFMU1o2azdiSklVbXU2RXF5aEVRSjVmakEzckxsL0ZT?=
 =?utf-8?B?Smk2eGM4Yjc0WWRaVS9rVjJjT3JLYzRpUmlmUlpMQktJK2k3bEo4T1ZpNXBD?=
 =?utf-8?B?WnRJejBSdUVGRW9PK1l5U1lkaEhwTjhUV04weXVRb0w4aUpkWmdHREdQZ1V5?=
 =?utf-8?B?V1p1eFlCZVJqRm0yZnFRMGQ1ZTZOb0N3OVc5T05mcml5WjdtbDBwV2IyOFlQ?=
 =?utf-8?B?c3BNWXFqMXJ2MDdqWHRBNGxCeEI0MVozdlRkazEreXNscXMyZDdxc2Yzb2ZW?=
 =?utf-8?B?NGcra0JDMlZOTnQ3UXBtZ2gzSWZjdkhRSGtSaWFlR2ljZVovbzJYSkdTYVND?=
 =?utf-8?B?d3VjaWRBSXV0VjJyVDZ3bnhHdEpWN1NjSG9rY1J2eS9OZUJDamdmaXFsWE1X?=
 =?utf-8?B?OTB6bml3S05qQXYzU0R5alhLNDNwMEF4TFk2aHRKMTF1WUJ5cDFlQ0k1R1FV?=
 =?utf-8?B?bzRxcDJ3Zmh2RUVKU1QxVTdraUVaN0J6RTMzaFNoVy9pd1NkNDE4b01odHFq?=
 =?utf-8?B?eUhqaW5DYWdYaUs4aVEzNXVhWGI3Rkl6MnhSN3pUS1ZZVWQyV05QQ2VvOWl6?=
 =?utf-8?B?eW5ZeTh3bGpPWTZGK0MxWG9QdndWRXRSaFQrdWNiVWk4THV1T1BaMy94ajJN?=
 =?utf-8?B?a1ovWW9PSWprZHRMWmdhRmt3VFNlNmhvUHEzS015UEMyWWVtWjJMZGVvempW?=
 =?utf-8?B?bUsxMHZTblJGTG1sUVhjMVdOZTRwUVFqK0tSTWlVakJScU95eWRpTEVPcDh5?=
 =?utf-8?B?RTh2Vkhaemh5TENRZkc0b0Zjc3dDdkx5Y3ZQZVp1MGMya3lOcHloN1RBRzdI?=
 =?utf-8?B?dHFNcWJzUGh5MDJRL055V2JqRTVNRmZnVFhEMVhBQWhVSktSSGZLbEpSTVpD?=
 =?utf-8?B?VkQ4ZW53NHRweEdNTCtTZGIxRW1uazg2RjBmbWhaWWRnZGRIOWIyeWt5SjdO?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <579A0BBB7B018C4AB52B09EB37D1902E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0760598a-f9f4-4e38-8aa6-08dabc02f57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 12:16:52.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRRZPXr0M0IyFvS7CK46zoRCaD9ts0XmZAlXxNjGjYLz71LpUzeMgBC1uz7GDjNs1j8YxEEk0kj/mlwMWrHHEIrr8blScr24lR3KAotF7hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDIyLTEwLTI5IGF0IDE5OjU4ICswMjAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgYW5kIGNsb2NrLWRlZmluaXRpb24gZm9yIG10Nzk4
Ni4gSXQgbmVlZHMgNA0KPiBjbG9ja3MNCj4gZm9yIFBDSWUsIGRlZmluZSB0aGVtIGluIGJpbmRp
bmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1Ymxp
Yy1maWxlcy5kZT4NCj4gLS0tDQo+IHYyOg0KPiAtIHNxdWFzaGVkIHBhdGNoIDIrMyAoY29tcGF0
aWJsZSBhbmQgY2xvY2sgZGVmaW5pdGlvbikNCj4gLS0tDQo+ICAuLi4vYmluZGluZ3MvcGNpL21l
ZGlhdGVrLXBjaWUtZ2VuMy55YW1sICAgICAgICB8IDE3DQo+ICsrKysrKysrKysrKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiANCkFja2VkLWJ5OiBKaWFuanVu
IFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+DQo=
