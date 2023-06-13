Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3202872DB12
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jun 2023 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbjFMHgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jun 2023 03:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjFMHgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 03:36:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5E10CC
        for <linux-pci@vger.kernel.org>; Tue, 13 Jun 2023 00:36:35 -0700 (PDT)
X-UUID: 036f188209bd11eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Wu+QGKeWCNfIxlgUbeXdrdlEtGQZEzk0k8QwjX64TXc=;
        b=hLHVRUil8e5LL8xPEkJf6bVDzm3TNRGNpfzsSdrmWX89WeRcB/X2c2mh/0JxyzH3J/6mkFJQsK+X4k+RG3siNeJrKakA/Nvqgjh2nbn32oTMx615Nw1I8SRy3eZlpopRForP/BZcyl95WU+PnsMVwT8dNmr1PN/9CxyiOpO/i5M=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:8a0bd9a6-7ced-4476-a677-9b24af6c0ace,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:54
X-CID-INFO: VERSION:1.1.26,REQID:8a0bd9a6-7ced-4476-a677-9b24af6c0ace,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:54
X-CID-META: VersionHash:cb9a4e1,CLOUDID:8562743e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230613153632ZIQT5N3N,BulkQuantity:0,Recheck:0,SF:28|16|19|48|38|29|1
        02,TC:nil,Content:1,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: 036f188209bd11eeb20a276fd37b9834-20230613
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <zhiren.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1311947910; Tue, 13 Jun 2023 15:36:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 15:36:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 15:36:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aapgcWv2crVoouj3x2zk62KOueax25Zoox4GzZz5QhVRiLKjj620DRYazVhvDKkJHAbdp8/MjztoNH9jMDvBMtmbKk5qznIULl+PkKzNbrovX4PHjvxX8HXpY2LviJ+8GHbF8cQPv1CBSUtFrrACUKQAFfSkkV7aTq+krL07qilmmwInEGIIWGCsffB9mSxP7TGcPYxC9supltusKaTibDO5Mhk4URT1hKQLYhjf/hrk3Y0yUKnYfS9VoF+sVdVYknek3AzPPDUjG8Rj90gjUc130dMhLjvz9kY3XsqRKqhB7EpQLK6Rd7/cudCwk+X7i8DLKqzgIxehqPtrJfe6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu+QGKeWCNfIxlgUbeXdrdlEtGQZEzk0k8QwjX64TXc=;
 b=lbcHnNF60JH1wtsiYSJ1uxp7mU1uHQ9Yv0E9Zhc5bcMf3tjKeVN6Sr7MVEHvJZfr/bg5cxjn+bWRmjWm1wmREVMlQxEfyT5s/PJAWbRk0mTqV4tXlqmPOVWObmB2ZrKFsHSMg8zlxUDvyTX+HXBUF2AUjcnzi6D8vujXUmNDgRKjc1YHRf4olc4LtrZb3//XXIw+XrUzG5y5PP9Y+qXHgkywaNdTAqkbHX+s7e3BoHy2uQBIsqcai3B3XHIk64DlxqMmARrYuLUOMRJhW4XTsplrcv5ztzk5hRmBMRJsezL2vxGGQSqpXbGa1ml/A2Y4PqoaXi1Lwl6kaviQhON24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu+QGKeWCNfIxlgUbeXdrdlEtGQZEzk0k8QwjX64TXc=;
 b=d+UuLMI9wxFXAJD1a2y9LIwLBUQrNRtfSbFh9mqcqsZb9uQbP2tYJkEV9Kl8ld0gjkCzRJE5WLqDWpP2fxUFKsQTEoMzUtyHd/inql9fDbiHGpIR7ihTWn3GcPVWbhjRvV5xtQ0yXhbL9qnlU3/YTPxrizS6VUC7EjxKwVvq4Rw=
Received: from TY0PR03MB6775.apcprd03.prod.outlook.com (2603:1096:400:218::13)
 by TYZPR03MB5406.apcprd03.prod.outlook.com (2603:1096:400:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Tue, 13 Jun
 2023 07:36:26 +0000
Received: from TY0PR03MB6775.apcprd03.prod.outlook.com
 ([fe80::9f60:6eaf:1726:8469]) by TY0PR03MB6775.apcprd03.prod.outlook.com
 ([fe80::9f60:6eaf:1726:8469%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 07:36:26 +0000
From:   =?utf-8?B?WmhpcmVuIENoZW4gKOmZiOW/l+S7gSk=?= 
        <Zhiren.Chen@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     =?utf-8?B?TWluZ2NodWFuZyBRaWFvICjkuZTmmI7pl68p?= 
        <Mingchuang.Qiao@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>,
        =?utf-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= 
        <Lambert.Wang@mediatek.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Thread-Topic: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Thread-Index: AQHZmnpkqiBN1yD7ckqVZqD7Z8TGxq+CGCsAgAZGY4A=
Date:   Tue, 13 Jun 2023 07:36:26 +0000
Message-ID: <a38e76d6f3a90d7c968c32cee97604f3c41cbccf.camel@mediatek.com>
References: <20230609023038.61388-1-zhiren.chen@mediatek.com>
         <328e1ad6-26c3-8a65-005c-b7d6f059535e@collabora.com>
In-Reply-To: <328e1ad6-26c3-8a65-005c-b7d6f059535e@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6775:EE_|TYZPR03MB5406:EE_
x-ms-office365-filtering-correlation-id: a4678f79-38f8-4b86-f06b-08db6be0e526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmL0SqQcubGnIFT4iMBwVbYj7bYS+j8LectiDnVhEOIXwbQOulfay0JMTDk1Vvfbsfh0Q9xYAjSIAEC3xmaHIk9Zb7oWSWOEocULHTWqiVB9xirFHlZay95wmDCGjNpGmRR9wuDDJz8TXjNRRBDmQVajsVkerjYWt8uvjeW0YwGpBuKXviQjHdP5SJ5Ym/y9hxqjz2P9iAuXD/LL/R5OpFGyVfpflwYchdYN0tFKm/j2VHF78w08SnIL3GPj6GFP0mvQWRav9PLiWGSTO2LI9USEQxrLPTl2ViYw87r6mi0dvXstq5wfimf1BeK2wgP/pbSyjGksHI2xuOHDCx1VW5kn29MXvKcGkbZTtAVrxrDw/ddiijs3c917QF65ewVkQveyHbyKlLRrri2voqQDTrK7/ScMVUVfAjpQjiLVX1l2diUiHfDK/bhSAsX0KR8CGPSr/HE5nJlacWl9OYAi8mA7iDeEX5Ql5SR445ATgwnTNtxFhcBGtYrtqcn9rkjLeOsQJRkqncUoWlN4Qg6+PIf1WIVC4E4Hf2hNHrBYyL4pXE1BOPkynvuKzOYZxYNNl0Jf4q/8PcRGpuV9iROva9bj1BDzoi5rZ5ap+JzQsfvGrciUbZQeL6TYG7o8ASSe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6775.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(85182001)(36756003)(86362001)(38070700005)(2906002)(6486002)(186003)(83380400001)(26005)(6512007)(6506007)(122000001)(91956017)(71200400001)(110136005)(54906003)(76116006)(66946007)(66476007)(478600001)(64756008)(4326008)(66556008)(2616005)(5660300002)(316002)(38100700002)(966005)(8676002)(8936002)(66446008)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzJ3QVVEdXU3YmR3NzVoSTNSajhFNitVcjFNQjJwNnBQUGx6SjFEOVZLZEtG?=
 =?utf-8?B?cm5Dem9OOEFxdVJNRkYzMVdadSttZDlqenQwTk9KSE5UVzdXcXR5anJuU2Vu?=
 =?utf-8?B?UGNHZDhSY0RxL3BDTDdiVnFpNUd1QTc3UXRCaEdQZjE2dHkvQzNMaG1NclQz?=
 =?utf-8?B?MitQNllobUdlZVYrTk55OG9VaFhHZldTMUlMRHVRb1did0FOejNPYW5Zejhr?=
 =?utf-8?B?UnVYa3VtNVZDOHpDMldITnZ5dVN3ekhoeTd4ODZkSkQ2V1FGRXZkYXBNVTEx?=
 =?utf-8?B?SjJPTjZxempGRHFCVGJWUnRFTGMxaDNDV1owRjdtWko4bGZXRzhWSzd0TjhL?=
 =?utf-8?B?T2d2YllSZStYTy8rSTAwb0xxdUJKdEV6Q1h2ZUlyZVFvVDlhQ1MyeTZLMVd5?=
 =?utf-8?B?LzVUNEpDVndGcXNOY0JQZEZtdXJJVzh3dzFKNE4xSzlUbGhwb2JxWW9PU2ZX?=
 =?utf-8?B?UFk3NGdBNnJ2T2drN1ZwSkplMFBXalJZVE9hMVBmYW93NEFXdzdXckRaUjdR?=
 =?utf-8?B?Q2FrUHI3QjNKS2pDY3RnV3dCSEt6Ym8wT2pYdUZrSWU1SngrRzU0NjI4ZTd0?=
 =?utf-8?B?YVMrSnVIYnV5YUZoMi82ODlmdXluRk05SURESGVzakdWVUdpY3RObFRyWVZp?=
 =?utf-8?B?bFVjSzJKZkdsRUVlKzRydG91Q2Jmb1F0d2ZtYnVya0Q3ZDBuakhDeEIzSG9x?=
 =?utf-8?B?WXAyRHRMTUI0cUwyOWN1a2llREU5dUdtaTFQOERDV0w0MlU2bXZsUS96M082?=
 =?utf-8?B?Q1Fucm1jY1JENDZqZzFoRzd6dVJGOGRVMmxiVHYvbHZ1NlFmemdFdDI3bGpD?=
 =?utf-8?B?bmlzMGhNYmJmY2dtelBEVzhiLzFDZ1AyMXZ2OFJCcWFBNkxJekRic1cwd2Zw?=
 =?utf-8?B?amNNcHovRTVqQnlMSFNZOUNmTWIxOURJNlNQMG1RYVdwRk51b1RvR0paaXdQ?=
 =?utf-8?B?NkNBYnNWK3hKUkNPbWhJZERRcWk0YUUyaml3R3ltNGprYnRRaHdDSnhUVDkv?=
 =?utf-8?B?WmM0N1dHWkFaamZ4REFYZFdsbStVcmVYay8rbS9jdWpFZk1MUXR0eUtGazE5?=
 =?utf-8?B?QzFjNWJuL1htM0tSYnFJNThNWit5ZVcrRTNVVERmZ0IzSlBZWktTVm9ka3l2?=
 =?utf-8?B?NzEvUmNXWXFJMnNpMjBFNDVGeDRuQVM1S3h4U3B6blg4STBCNTNlSmN6c0c4?=
 =?utf-8?B?OXN3SytIckdwTk85NWl5Wm1GNmgxS2VUU1ZEUUFkUDlEUXRCamRUQ2VURVEz?=
 =?utf-8?B?aVhGU0NRS0d6L1djUytoL0ZFbm1FcW0wNzBIMGZLZnJHT1VVNzVmRW1mcUd0?=
 =?utf-8?B?T3l0c3YwaE5PWlNMZ3FkYVJUM0hvdXJMU2dmWjVWRlFzb3dtaENnNExiYWRp?=
 =?utf-8?B?QW10VTJLZWxXd1k2MnJIMkpmNm5jOFBjYS9kd0hEMWdHZWE3c21nVE9Wc2Ev?=
 =?utf-8?B?OEJzVFNTb1RCaHJIdFA0WDRZU09PU0JPbzQ5VnlXQVhSM292N3NNeTMrRTFw?=
 =?utf-8?B?UDdKakhvZlBZa2lwMlpnOWRIeVZxMGxlamRHT0N4N3hzRk82anBkV0VaVC84?=
 =?utf-8?B?Zk5FL1dxaDNyVlBsdjBtYkVKNVd2KzN0WFRrVTFxb0NxOElSMlFidk1qYkM0?=
 =?utf-8?B?Q0R1U3VuTmpaK1pRTE1MR0gxbnBubGNDRTZxZ3FjVllkQk14cGZ0bGtrM1dX?=
 =?utf-8?B?NGtSYW1EMFFnSkxVdjlzcnlBRDNsSGN6MUxjYkIxbXFXUmI3RE5TS3NvZmt1?=
 =?utf-8?B?NGxSLy9GN1QrWDJXdXJpK0JJWndBWlgzQStoME9ZdTZtZVQzb0Yybks3b21C?=
 =?utf-8?B?akFpY2o2NTJTc3pUVllYNHN6SnpMdTlIS0dqeVRrTkdka05jM0VWWklvcE5T?=
 =?utf-8?B?SkthRkRIQkQ2SlNwbnN2ZlJGbVZmUjNMNDhKeGw1bUNpa1ltTFF3TVN2aGRL?=
 =?utf-8?B?ME1Bdjdmd0JGRTZuME9JRGoyQlJUU0lFQWpoRGt1WGtPajYrdTRrMnU3cWtq?=
 =?utf-8?B?Y3gwYVRWTm0yTlk5RnpDZ0NWczhMVjZnZFVJREN3OFpGY3JwRjUwemhXVTkz?=
 =?utf-8?B?OWFCMWRmMzBNRGVnRjdsTHZhNVR1am9WSTQydllwN00wNzkwNnpDTzdML2Rj?=
 =?utf-8?B?dXJoNVFmbThWNVN2OGpyaE1sOTZsSUFUS1JzYWNUY0RYeFBRRzNzU2pINjhF?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD4E4522B743CB43A288E56727F867AA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6775.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4678f79-38f8-4b86-f06b-08db6be0e526
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:36:26.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S00ao7t8YkqYI79yaYPEBC1JuzdcDhcW27iXvw6rlSlO6/NBfni4Ci4cYGTkwjL0ifm5Us7DxeIn3ARaqdmFqTUhkovbfbl9TtRyHea2BwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5406
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDA5OjQ2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+ICBJbCAwOS8wNi8yMyAwNDozMCwgWmhpcmVuIENoZW4gaGEg
c2NyaXR0bzoNCj4gPiBGcm9tOiBaaGlyZW4gQ2hlbiA8WmhpcmVuLkNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IA0KPiA+IFRoZSBwbGF0Zm9ybV9wY2lfY2hvb3NlX3N0YXRlIGZ1bmN0aW9uIGFuZCBv
dGhlciBsb3ctbGV2ZWwgcGxhdGZvcm0NCj4gPiBpbnRlcmZhY2VzIHVzZWQgYnkgUENJIHBvd2Vy
IG1hbmFnZW1lbnQgcHJvY2Vzc2luZyBkaWQgbm90IHRha2UNCj4gDQo+IGludG8NCj4gPiBhY2Nv
dW50IG5vbi1BQ1BJLXN1cHBvcnRlZCBwbGF0Zm9ybXMuIFRoaXMgc2hvcnRjb21pbmcgY2FuIHJl
c3VsdA0KPiANCj4gaW4NCj4gPiBsaW1pdGF0aW9ucyBhbmQgaXNzdWVzLg0KPiA+IA0KPiA+IEZv
ciBleGFtcGxlLCBpbiBlbWJlZGRlZCBzeXN0ZW1zIGxpa2Ugc21hcnRwaG9uZXMsIGEgUENJIGRl
dmljZSBjYW4NCj4gDQo+IGJlDQo+ID4gc2hhcmVkIGJ5IG11bHRpcGxlIHByb2Nlc3NvcnMgZm9y
IGRpZmZlcmVudCBwdXJwb3Nlcy4gVGhlIFBDSQ0KPiANCj4gZGV2aWNlIGFuZA0KPiA+IHNvbWUg
b2YgdGhlIHByb2Nlc3NvcnMgYXJlIGNvbnRyb2xsZWQgYnkgTGludXgsIHdoaWxlIHRoZSByZXN0
IG9mDQo+IA0KPiB0aGUNCj4gPiBwcm9jZXNzb3JzIHJ1bnMgaXRzIG93biBvcGVyYXRpbmcgc3lz
dGVtLg0KPiA+IFdoZW4gTGludXggaW5pdGlhdGVzIHN5c3RlbS1sZXZlbCBzbGVlcCwgaWYgaXQg
ZG9lcyBub3QgY29uc2lkZXINCj4gDQo+IHRoZQ0KPiA+IHdvcmtpbmcgc3RhdGUgb2YgdGhlIHNo
YXJlZCBQQ0kgZGV2aWNlIGFuZCBmb3JjZWZ1bGx5IHNldHMgdGhlIFBDSQ0KPiANCj4gZGV2aWNl
DQo+ID4gc3RhdGUgdG8gRDMsIGl0IHdpbGwgYWZmZWN0IHRoZSBmdW5jdGlvbmFsaXR5IG9mIG90
aGVyIHByb2Nlc3NvcnMNCj4gDQo+IHRoYXQNCj4gPiBhcmUgY3VycmVudGx5IHVzaW5nIHRoZSBQ
Q0kgZGV2aWNlLg0KPiA+IA0KPiA+IFRvIGFkZHJlc3MgdGhpcyBwcm9ibGVtLCBhbiBpbnRlcmZh
Y2Ugc2hvdWxkIGJlIGNyZWF0ZWQgZm9yIFBDSQ0KPiANCj4gZGV2aWNlcw0KPiA+IHRoYXQgZG9u
J3Qgc3VwcG9ydCBBQ1BJIHRvIGVuYWJsZSBhY2N1cmF0ZSByZXBvcnRpbmcgb2YgdGhlIHBvd2Vy
DQo+IA0KPiBzdGF0ZQ0KPiA+IGR1cmluZyB0aGUgUENJIFBNIGhhbmRsaW5nIHByb2Nlc3MuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWmhpcmVuIENoZW4gPFpoaXJlbi5DaGVuQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcGNpL3BjaS5jICAgfCAyNCArKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvcGNpL3BjaS5oICAgfCA0MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L3BjaS5o
IHwgIDEgKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4g
PiBpbmRleCA1ZWRlOTMyMjJiYzEuLjlmMDM0MDZmMzA4MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9wY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+ID4gQEAgLTEwMTQs
NiArMTAxNCw5IEBAIHN0YXRpYyB2b2lkIHBjaV9yZXN0b3JlX2JhcnMoc3RydWN0IHBjaV9kZXYN
Cj4gDQo+ICpkZXYpDQo+ID4gICANCj4gPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBwbGF0Zm9ybV9w
Y2lfcG93ZXJfbWFuYWdlYWJsZShzdHJ1Y3QgcGNpX2Rldg0KPiANCj4gKmRldikNCj4gPiAgIHsN
Cj4gPiAraWYgKGRldi0+cGxhdGZvcm1fcG1fb3BzICYmIGRldi0+cGxhdGZvcm1fcG1fb3BzLT5p
c19tYW5hZ2VhYmxlKQ0KPiA+ICtyZXR1cm4gZGV2LT5wbGF0Zm9ybV9wbV9vcHMtPmlzX21hbmFn
ZWFibGUoZGV2KTsNCj4gPiArDQo+ID4gICBpZiAocGNpX3VzZV9taWRfcG0oKSkNCj4gPiAgIHJl
dHVybiB0cnVlOw0KPiA+ICAgDQo+ID4gQEAgLTEwMjMsNiArMTAyNiw5IEBAIHN0YXRpYyBpbmxp
bmUgYm9vbA0KPiANCj4gcGxhdGZvcm1fcGNpX3Bvd2VyX21hbmFnZWFibGUoc3RydWN0IHBjaV9k
ZXYgKmRldikNCj4gPiAgIHN0YXRpYyBpbmxpbmUgaW50IHBsYXRmb3JtX3BjaV9zZXRfcG93ZXJf
c3RhdGUoc3RydWN0IHBjaV9kZXYNCj4gDQo+ICpkZXYsDQo+ID4gICAgICAgICAgcGNpX3Bvd2Vy
X3QgdCkNCj4gPiAgIHsNCj4gPiAraWYgKGRldi0+cGxhdGZvcm1fcG1fb3BzICYmIGRldi0+cGxh
dGZvcm1fcG1fb3BzLT5zZXRfc3RhdGUpDQo+ID4gK3JldHVybiBkZXYtPnBsYXRmb3JtX3BtX29w
cy0+c2V0X3N0YXRlKGRldiwgdCk7DQo+ID4gKw0KPiA+ICAgaWYgKHBjaV91c2VfbWlkX3BtKCkp
DQo+ID4gICByZXR1cm4gbWlkX3BjaV9zZXRfcG93ZXJfc3RhdGUoZGV2LCB0KTsNCj4gPiAgIA0K
PiA+IEBAIC0xMDMxLDYgKzEwMzcsOSBAQCBzdGF0aWMgaW5saW5lIGludA0KPiANCj4gcGxhdGZv
cm1fcGNpX3NldF9wb3dlcl9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LA0KPiA+ICAgDQo+ID4g
ICBzdGF0aWMgaW5saW5lIHBjaV9wb3dlcl90IHBsYXRmb3JtX3BjaV9nZXRfcG93ZXJfc3RhdGUo
c3RydWN0DQo+IA0KPiBwY2lfZGV2ICpkZXYpDQo+ID4gICB7DQo+ID4gK2lmIChkZXYtPnBsYXRm
b3JtX3BtX29wcyAmJiBkZXYtPnBsYXRmb3JtX3BtX29wcy0+Z2V0X3N0YXRlKQ0KPiA+ICtyZXR1
cm4gZGV2LT5wbGF0Zm9ybV9wbV9vcHMtPmdldF9zdGF0ZShkZXYpOw0KPiA+ICsNCj4gPiAgIGlm
IChwY2lfdXNlX21pZF9wbSgpKQ0KPiA+ICAgcmV0dXJuIG1pZF9wY2lfZ2V0X3Bvd2VyX3N0YXRl
KGRldik7DQo+ID4gICANCj4gPiBAQCAtMTAzOSwxMiArMTA0OCwxOCBAQCBzdGF0aWMgaW5saW5l
IHBjaV9wb3dlcl90DQo+IA0KPiBwbGF0Zm9ybV9wY2lfZ2V0X3Bvd2VyX3N0YXRlKHN0cnVjdCBw
Y2lfZGV2ICpkZXYpDQo+ID4gICANCj4gPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBwbGF0Zm9ybV9w
Y2lfcmVmcmVzaF9wb3dlcl9zdGF0ZShzdHJ1Y3QNCj4gDQo+IHBjaV9kZXYgKmRldikNCj4gPiAg
IHsNCj4gPiAraWYgKGRldi0+cGxhdGZvcm1fcG1fb3BzICYmIGRldi0+cGxhdGZvcm1fcG1fb3Bz
LT5yZWZyZXNoX3N0YXRlKQ0KPiA+ICtkZXYtPnBsYXRmb3JtX3BtX29wcy0+cmVmcmVzaF9zdGF0
ZShkZXYpOw0KPiA+ICsNCj4gPiAgIGlmICghcGNpX3VzZV9taWRfcG0oKSkNCj4gPiAgIGFjcGlf
cGNpX3JlZnJlc2hfcG93ZXJfc3RhdGUoZGV2KTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICAgc3Rh
dGljIGlubGluZSBwY2lfcG93ZXJfdCBwbGF0Zm9ybV9wY2lfY2hvb3NlX3N0YXRlKHN0cnVjdA0K
PiANCj4gcGNpX2RldiAqZGV2KQ0KPiA+ICAgew0KPiA+ICtpZiAoZGV2LT5wbGF0Zm9ybV9wbV9v
cHMgJiYgZGV2LT5wbGF0Zm9ybV9wbV9vcHMtPmNob29zZV9zdGF0ZSkNCj4gPiArcmV0dXJuIGRl
di0+cGxhdGZvcm1fcG1fb3BzLT5jaG9vc2Vfc3RhdGUoZGV2KTsNCj4gPiArDQo+ID4gICBpZiAo
cGNpX3VzZV9taWRfcG0oKSkNCj4gPiAgIHJldHVybiBQQ0lfUE9XRVJfRVJST1I7DQo+ID4gICAN
Cj4gPiBAQCAtMTA1Myw2ICsxMDY4LDkgQEAgc3RhdGljIGlubGluZSBwY2lfcG93ZXJfdA0KPiAN
Cj4gcGxhdGZvcm1fcGNpX2Nob29zZV9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiA+ICAg
DQo+ID4gICBzdGF0aWMgaW5saW5lIGludCBwbGF0Zm9ybV9wY2lfc2V0X3dha2V1cChzdHJ1Y3Qg
cGNpX2RldiAqZGV2LA0KPiANCj4gYm9vbCBlbmFibGUpDQo+ID4gICB7DQo+ID4gK2lmIChkZXYt
PnBsYXRmb3JtX3BtX29wcyAmJiBkZXYtPnBsYXRmb3JtX3BtX29wcy0+c2V0X3dha2V1cCkNCj4g
PiArcmV0dXJuIGRldi0+cGxhdGZvcm1fcG1fb3BzLT5zZXRfd2FrZXVwKGRldiwgZW5hYmxlKTsN
Cj4gPiArDQo+ID4gICBpZiAocGNpX3VzZV9taWRfcG0oKSkNCj4gPiAgIHJldHVybiBQQ0lfUE9X
RVJfRVJST1I7DQo+ID4gICANCj4gPiBAQCAtMTA2MSw2ICsxMDc5LDkgQEAgc3RhdGljIGlubGlu
ZSBpbnQNCj4gDQo+IHBsYXRmb3JtX3BjaV9zZXRfd2FrZXVwKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IGJvb2wgZW5hYmxlKQ0KPiA+ICAgDQo+ID4gICBzdGF0aWMgaW5saW5lIGJvb2wgcGxhdGZvcm1f
cGNpX25lZWRfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gICB7DQo+ID4gK2lmIChk
ZXYtPnBsYXRmb3JtX3BtX29wcyAmJiBkZXYtPnBsYXRmb3JtX3BtX29wcy0+bmVlZF9yZXN1bWUp
DQo+ID4gK3JldHVybiBkZXYtPnBsYXRmb3JtX3BtX29wcy0+bmVlZF9yZXN1bWUoZGV2KTsNCj4g
PiArDQo+ID4gICBpZiAocGNpX3VzZV9taWRfcG0oKSkNCj4gPiAgIHJldHVybiBmYWxzZTsNCj4g
PiAgIA0KPiA+IEBAIC0xMDY5LDYgKzEwOTAsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gDQo+
IHBsYXRmb3JtX3BjaV9uZWVkX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiA+ICAgDQo+
ID4gICBzdGF0aWMgaW5saW5lIGJvb2wgcGxhdGZvcm1fcGNpX2JyaWRnZV9kMyhzdHJ1Y3QgcGNp
X2RldiAqZGV2KQ0KPiA+ICAgew0KPiA+ICtpZiAoZGV2LT5wbGF0Zm9ybV9wbV9vcHMgJiYgZGV2
LT5wbGF0Zm9ybV9wbV9vcHMtPmJyaWRnZV9kMykNCj4gPiArcmV0dXJuIGRldi0+cGxhdGZvcm1f
cG1fb3BzLT5icmlkZ2VfZDMoZGV2KTsNCj4gPiArDQo+ID4gICBpZiAocGNpX3VzZV9taWRfcG0o
KSkNCj4gPiAgIHJldHVybiBmYWxzZTsNCj4gPiAgIA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9wY2kuaCBiL2RyaXZlcnMvcGNpL3BjaS5oDQo+ID4gaW5kZXggMjQ3NTA5OGY2NTE4Li44
NTE1NDQ3MGMwODMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLmgNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9wY2kuaA0KPiA+IEBAIC03MSw2ICs3MSw0MiBAQCBzdHJ1Y3QgcGNpX2Nh
cF9zYXZlZF9zdGF0ZQ0KPiANCj4gKnBjaV9maW5kX3NhdmVkX2V4dF9jYXAoc3RydWN0IHBjaV9k
ZXYgKmRldiwNCj4gPiAgICAqLw0KPiA+ICAgI2RlZmluZSBQQ0lfUkVTRVRfV0FJVDEwMDAvKiBt
c2VjICovDQo+ID4gICANCj4gPiArLyoqDQo+ID4gKyAqIHN0cnVjdCBwY2lfcGxhdGZvcm1fcG1f
b3BzIC0gRmlybXdhcmUgUE0gY2FsbGJhY2tzDQo+ID4gKyAqDQo+ID4gKyAqIEBpc19tYW5hZ2Vh
YmxlOiByZXR1cm5zICd0cnVlJyBpZiBnaXZlbiBkZXZpY2UgaXMgcG93ZXINCj4gDQo+IG1hbmFn
ZWFibGUgYnkgdGhlDQo+ID4gKyAqICAgICAgICAgICAgICAgICBwbGF0Zm9ybSBmaXJtd2FyZQ0K
PiA+ICsgKg0KPiA+ICsgKiBAc2V0X3N0YXRlOiBpbnZva2VzIHRoZSBwbGF0Zm9ybSBmaXJtd2Fy
ZSB0byBzZXQgdGhlIGRldmljZSdzDQo+IA0KPiBwb3dlciBzdGF0ZQ0KPiA+ICsgKg0KPiA+ICsg
KiBAZ2V0X3N0YXRlOiBxdWVyaWVzIHRoZSBwbGF0Zm9ybSBmaXJtd2FyZSBmb3IgYSBkZXZpY2Un
cw0KPiANCj4gY3VycmVudCBwb3dlciBzdGF0ZQ0KPiA+ICsgKg0KPiA+ICsgKiBAY2hvb3NlX3N0
YXRlOiByZXR1cm5zIFBDSSBwb3dlciBzdGF0ZSBvZiBnaXZlbiBkZXZpY2UNCj4gDQo+IHByZWZl
cnJlZCBieSB0aGUNCj4gPiArICogICAgICAgICAgICAgICAgcGxhdGZvcm07IHRvIGJlIHVzZWQg
ZHVyaW5nIHN5c3RlbS13aWRlDQo+IA0KPiB0cmFuc2l0aW9ucyBmcm9tIGENCj4gPiArICogICAg
ICAgICAgICAgICAgc2xlZXBpbmcgc3RhdGUgdG8gdGhlIHdvcmtpbmcgc3RhdGUgYW5kIHZpY2UN
Cj4gDQo+IHZlcnNhDQo+ID4gKyAqDQo+ID4gKyAqIEBzZXRfd2FrZXVwOiBlbmFibGVzL2Rpc2Fi
bGVzIHdha2V1cCBjYXBhYmlsaXR5IGZvciB0aGUgZGV2aWNlDQo+ID4gKyAqDQo+ID4gKyAqIEBu
ZWVkX3Jlc3VtZTogcmV0dXJucyAndHJ1ZScgaWYgdGhlIGdpdmVuIGRldmljZSAod2hpY2ggaXMN
Cj4gDQo+IGN1cnJlbnRseQ0KPiA+ICsgKnN1c3BlbmRlZCkgbmVlZHMgdG8gYmUgcmVzdW1lZCB0
byBiZSBjb25maWd1cmVkIGZvciBzeXN0ZW0NCj4gPiArICp3YWtldXAuDQo+ID4gKyAqDQo+ID4g
KyAqIEBicmlkZ2VfZDM6IHJldHVybiAndHJ1ZScgaWYgZ2l2ZW4gZGV2aWNlIHN1cG9vcnRzIEQz
IHdoZW4gaXQNCj4gDQo+IGlzIGEgYnJpZGdlDQo+ID4gKyAqDQo+ID4gKyAqIEByZWZyZXNoX3N0
YXRlOiByZWZyZXNoIHRoZSBnaXZlbiBkZXZpY2UncyBwb3dlciBzdGF0ZQ0KPiA+ICsgKg0KPiA+
ICsgKi8NCj4gPiArc3RydWN0IHBjaV9wbGF0Zm9ybV9wbV9vcHMgew0KPiA+ICtib29sICgqaXNf
bWFuYWdlYWJsZSkoc3RydWN0IHBjaV9kZXYgKmRldik7DQo+ID4gK2ludCAoKnNldF9zdGF0ZSko
c3RydWN0IHBjaV9kZXYgKmRldiwgcGNpX3Bvd2VyX3Qgc3RhdGUpOw0KPiA+ICtwY2lfcG93ZXJf
dCAoKmdldF9zdGF0ZSkoc3RydWN0IHBjaV9kZXYgKmRldik7DQo+ID4gK3BjaV9wb3dlcl90ICgq
Y2hvb3NlX3N0YXRlKShzdHJ1Y3QgcGNpX2RldiAqZGV2KTsNCj4gPiAraW50ICgqc2V0X3dha2V1
cCkoc3RydWN0IHBjaV9kZXYgKmRldiwgYm9vbCBlbmFibGUpOw0KPiA+ICtib29sICgqbmVlZF9y
ZXN1bWUpKHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0KPiA+ICtib29sICgqYnJpZGdlX2QzKShzdHJ1
Y3QgcGNpX2RldiAqZGV2KTsNCj4gPiArdm9pZCAoKnJlZnJlc2hfc3RhdGUpKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHZvaWQgcGNpX3VwZGF0ZV9jdXJyZW50
X3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dlcl90DQo+IA0KPiBzdGF0ZSk7DQo+
ID4gICB2b2lkIHBjaV9yZWZyZXNoX3Bvd2VyX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0K
PiA+ICAgaW50IHBjaV9wb3dlcl91cChzdHJ1Y3QgcGNpX2RldiAqZGV2KTsNCj4gPiBAQCAtOTYs
NiArMTMyLDEwIEBAIHZvaWQgcGNpX2JyaWRnZV9kM191cGRhdGUoc3RydWN0IHBjaV9kZXYgKmRl
dik7DQo+ID4gICB2b2lkIHBjaV9icmlkZ2VfcmVjb25maWd1cmVfbHRyKHN0cnVjdCBwY2lfZGV2
ICpkZXYpOw0KPiA+ICAgaW50IHBjaV9icmlkZ2Vfd2FpdF9mb3Jfc2Vjb25kYXJ5X2J1cyhzdHJ1
Y3QgcGNpX2RldiAqZGV2LCBjaGFyDQo+IA0KPiAqcmVzZXRfdHlwZSk7DQo+ID4gICANCj4gPiAr
c3RhdGljIGlubGluZSB2b2lkIHBjaV9zZXRfcGxhdGZvcm1fcG0oc3RydWN0IHBjaV9kZXYgKmRl
diwgc3RydWN0DQo+IA0KPiBwY2lfcGxhdGZvcm1fcG1fb3BzICpvcHMpDQo+IA0KPiBwY2lfc2V0
X3BsYXRmb3JtX3BtX29wcygpDQo+IA0KPiBBbnl3YXkgLi4uIGNhbiB5b3UgcGxlYXNlIGFsc28g
c2hvdyBhbiB1c2VyIG9mIHRoaXMgbWVjaGFuaXNtPyBJDQo+IHdvdWxkIGltYWdpbmUgdGhhdA0K
PiB0aGUgdXNlciB3b3VsZCBiZSBwY2llLW1lZGlhdGVrLWdlbjM/DQo+IA0KDQpBbGwgUENJIGRl
dmljZXMgaW5jbHVkZSBwY2llLW1lZGlhdGVrLWdlbjMgY2FuIGJlIHVzZXIgb2YgdGhpcw0KbWVj
aGFuaXNtDQoNCj4gUGxlYXNlIHNlbmQgYSBwYXRjaCB0aGF0IGltcGxlbWVudHMgdXNhZ2Ugb2Yg
dGhvc2UgcGxhdGZvcm1fcG1fb3BzIGluDQo+IHRoZSBzYW1lDQo+IHNlcmllcyBhcyB0aGlzIG9u
ZS4NCj4gDQo+IFRoYW5rcywNCj4gQW5nZWxvDQo+IA0KDQpJIGNhbm4ndCBwcm92aWRlIHRoZSBw
YXRjaCBiYXNlZCBvbiB0aGUgYWxyZWFkeSBleGlzdGluZyBQQ0kgZHJpdmVyDQppbiBrZXJuZWwg
YmVjYXVzZSBpbXBsZW1lbnRpb24gb2YgcGxhdGZvcm1fcG1fb3BzIGRlcGVuZHMgb24gdXNlcidz
DQpQTSBwb2xpY3kgdGhhdCBJIGRvbid0IGtvbncuDQoNClRoZSB1c2VyIG5lZWRpbmcgcGxhdGZv
cm1fcG1fb3BzIEkga25vdyBpcyBNZWRpYXRlayBUOHh4IG1vZGVtIGNoaXANCndob3NlIGRyaXZl
ciBpcyBjdXJyZW50bHkgdW5kZXIgcmV2aWV3Lg0KKHJlZjoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9jb3Zlci8yMDIzMDMxNzA4MDk0Mi4xODM1MTQt
MS15YW5jaGFvLnlhbmdAbWVkaWF0ZWsuY29tLw0KKQ0KDQpJJ2QgbGlrZSB0byB1c2UgdGhlIFQ4
eHggZHJpdmVyIGFzIGFuIGV4YW1wbGUgdG8gaWxsdXN0cmF0ZSBob3cgdGhpcw0KbWVjaGFuaXNt
IGlzIHVzZWQ6DQoNCkluIHN5c3RlbS13aWxkIHN1c3BlbmQgZmxvdywgVDh4eCBtYXkgcmVxdWly
ZSB0byBzdGF5IGFsaXZlIGJlY2F1c2UgaXQNCmlzIHVzZWQgYnkgb3RoZXIgaGFyZHdhcmUgY29t
cG9uZW50IHRoYXQgaXMgbm90IHVuZGVyIGNvbnJvbCBvZiBrZXJuZWwuDQoNCkluIHRoaXMgY2Fz
ZSwgVDh4eCBkcml2ZXIgY2FuIGltcGxlbWVudCBjaG9vc2Vfc3RhdGUoKSB0byBjaGVjayBhDQpz
dGF0dXMgcmVnaXN0ZXIgdG8gb2J0YWluIHRoZSB3b3JraW5nIHN0YXRlIG9mIHRoZSBUOHh4LiBp
ZiBUOHh4IGlzDQpidXN5LCBjaG9vc2Vfc3RhdGUoKSByZXR1cm4gRDAgdG8gc2tpcCBEMyBzZXR0
aW5nIGluDQpwY2lfcG1fc3VzcGVuZF9ub2lycS4NCg0KQmVzdCBSZWdhcmRzLA0KWmhpcmVuDQoN
Cj4gPiArew0KPiA+ICtkZXYtPnBsYXRmb3JtX3BtX29wcyA9IG9wczsNCj4gPiArfQ0KPiA+ICAg
c3RhdGljIGlubGluZSB2b2lkIHBjaV93YWtldXBfZXZlbnQoc3RydWN0IHBjaV9kZXYgKmRldikN
Cj4gPiAgIHsNCj4gPiAgIC8qIFdhaXQgMTAwIG1zIGJlZm9yZSB0aGUgc3lzdGVtIGNhbiBiZSBw
dXQgaW50byBhIHNsZWVwIHN0YXRlLg0KPiANCj4gKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgNCj4gPiBpbmRleCA2MGI4NzcyYjVi
ZDQuLmEwMTcxZjFhYmYyZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KPiA+IEBAIC0zMjcsNiArMzI3LDcgQEAgc3Ry
dWN0IHBjaV9kZXYgew0KPiA+ICAgdm9pZCpzeXNkYXRhOy8qIEhvb2sgZm9yIHN5cy1zcGVjaWZp
YyBleHRlbnNpb24gKi8NCj4gPiAgIHN0cnVjdCBwcm9jX2Rpcl9lbnRyeSAqcHJvY2VudDsvKiBE
ZXZpY2UgZW50cnkgaW4gL3Byb2MvYnVzL3BjaQ0KPiANCj4gKi8NCj4gPiAgIHN0cnVjdCBwY2lf
c2xvdCpzbG90Oy8qIFBoeXNpY2FsIHNsb3QgdGhpcyBkZXZpY2UgaXMgaW4gKi8NCj4gPiArc3Ry
dWN0IHBjaV9wbGF0Zm9ybV9wbV9vcHMgKnBsYXRmb3JtX3BtX29wczsNCj4gPiAgIA0KPiA+ICAg
dW5zaWduZWQgaW50ZGV2Zm47LyogRW5jb2RlZCBkZXZpY2UgJiBmdW5jdGlvbiBpbmRleCAqLw0K
PiA+ICAgdW5zaWduZWQgc2hvcnR2ZW5kb3I7DQo=
