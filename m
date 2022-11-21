Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372B5631A62
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 08:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKUHi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 02:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKUHiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 02:38:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A532872A;
        Sun, 20 Nov 2022 23:38:45 -0800 (PST)
X-UUID: 4a9911fee8694011997b29a478c05676-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ik0kJo2+fiYDO5HS2yRx4CjDo+5UaPNT0AhHdN/5Rzo=;
        b=sH8DWs8Co7G800E5Ct8vbYPexK/qVYSso7GjTQLZNuS//NxzawYcX+SSIzuGJAwZqN94C881eHlMkVjAMFzcZGBUuQ0I//4SOQ4Kx03loBjDygp7HyDsNQap6fONat+8znrREdjCRXuSTAQ4a77mXP90GVwfuNEwWDuEurX51us=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:f1b43ac2-c467-40b7-b2a7-97eed961e936,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.13,REQID:f1b43ac2-c467-40b7-b2a7-97eed961e936,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:55765a2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121153842DXYRCH0W,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4a9911fee8694011997b29a478c05676-20221121
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1586427336; Mon, 21 Nov 2022 15:38:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 15:38:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 21 Nov 2022 15:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRQNfK10kk8N1t6YtxYUyq/NeUf5Vp7rvaMMHN4whlKOabHy+25RSnLWwlP4ouNOQmSypRgiuX7pxc9hHgQ4XNnwUto4mH1DbOcCQa7LnoXyltCtL442M/5MuGV86MfDf9fmbvRjoZ2Pqw8MwY9tODwmg0hP0IqID7Nw4zLPTdfPCl9u9UJVQhC29SOxeER/V86cjmlxMR3RqCIbUKYujn7mCf6NllKQ2d9Qme1nszTxuDhraCGcD/j/NNSSl0MamJ7ih+/lnh5dJrhwgbPUvqrLQu/tXfRQvnUOtfAUmqZhfZNkb6X/XuwZ9S9t9Lz641AYDGK/GVT7b8+HYMIPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik0kJo2+fiYDO5HS2yRx4CjDo+5UaPNT0AhHdN/5Rzo=;
 b=nsTkbfyxeuw0dW+6X3MavL9ChRwAeiOBK2TivdCdh5w8NSwJoN1ciVHrA4bFdJwy/rYMlQfrC08pznXRAH7TsidMwSVltR98PO6U3RiJ9YLbJw4uCW/4bjS3CHCCLA7Fp4oDecB9cD7THG7uXCTRuOwdTwh+AE1WWfOSr7NbtzYYLxqqFMfMMdW+NFNKNObCPRE1EBfng46VaFtkvHX1BenbRpAvUePuOQvvjdXB5MsGEgUGMARr8XZINkdmHVQwT3It/FvEfuBalNOQWK75bCcuKbNj/O/0he9+8BGdM5N4nmRqbmli/ECcnBZMTTwDC8fec2qOI4gIG0xm2bMF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik0kJo2+fiYDO5HS2yRx4CjDo+5UaPNT0AhHdN/5Rzo=;
 b=eTN7oeyyKEUTrxWq8InsVvtBpdMAxIgBGBRZfe5zpSDMyVRRYxj806t1xWcw8CJbCzbCqbWE35JIjOlVfoWuGNch5Cy6fz0cJZyU7fJX9Q5cBvgVxx9KyZpNHVV2MhPq4c6tSYS5mrp9CWhHLb5fb8aMOeACpbzw2rsFuuq9A8Y=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SEYPR03MB7144.apcprd03.prod.outlook.com (2603:1096:101:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 07:38:36 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 07:38:36 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux@fw-web.de" <linux@fw-web.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 07/11] arm64: dts: mt7986: add usb related device nodes
Thread-Topic: [PATCH v6 07/11] arm64: dts: mt7986: add usb related device
 nodes
Thread-Index: AQHY+4A6FqCbcv+i/USuBYGTcxFYHa5JAYWA
Date:   Mon, 21 Nov 2022 07:38:36 +0000
Message-ID: <e22f554e2182cb9cea5f582f8676d9e9e5a4f6d0.camel@mediatek.com>
References: <20221118190126.100895-1-linux@fw-web.de>
         <20221118190126.100895-8-linux@fw-web.de>
In-Reply-To: <20221118190126.100895-8-linux@fw-web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SEYPR03MB7144:EE_
x-ms-office365-filtering-correlation-id: 0db9e805-5707-4bb9-9d29-08dacb93662d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcfy0Wywy7DjGg30EDpAxG0gF7krM4j0qvPGpkxLRln12yVkqrR2qhLUS7mttuD2O0r8P+jjtizdBeSCFAYaee4cQh00xtR90H6eUzPWXDdFwPOmPEhfAtLqrv2Gwwy3Z4q6+PUyvqs+ut4iQv3/ayrtpA7eJ1gVJIRdCN377KPLkdHbWdeh+oMM0GQbyKh9Ba0/7z3TfJXvXNkeI5GkS/CqNSIDEK1R0mcrn+BOLHY9Qw4drIqfrDtvuz/+1JsGqRrqOhfgLa6VW1mCU6ydsB4xXVL+dKGucC9hkny6l4Wmu8gSU+4FF4MYY65NPzad5NvQHVrN+2WzeJmfR7SP9tJIpkqvtWvtFwXnqoR5SHTldq0PPRiUusjR/EZu39rHKCP8uXxwUK6maPbDuVG29JGqHIAPhTAhluscYkbH1CJlABNC2LYSqQ2K0A+GWEG1HtmzA7XY0TsWmCtAVlpZa72UEawK+LmmQNMLCYj6rQIA3qJI4uAYmuMKgJSGq+ATZOlTpy9QV2T3Y321d8LVIlsCYjE2T0z1hjugw30l6MsfzNcWk0ofyP0I1Hsn2QmfgqgDzfQHpn5y/bDnaPPg5nVrVdk/G8VHW5oDtISzarSweH2IgXplyfFAcMceF44DC7r8cgZvWhW45NTAntyC+k8OpNWOEChvCX2bb/s03DQhZwnWt6ykuk+P46O5T0BEsLxXXlaLzPoGJBwfhrQvfuGhwgrffRm3dNuqTuhsAPSWX7vw9J/4sY5KKTECkwdIXIDf+dHH8XKmiT7NF09SoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(41300700001)(7416002)(76116006)(8936002)(4001150100001)(5660300002)(4326008)(316002)(54906003)(66556008)(66446008)(66476007)(66946007)(64756008)(8676002)(91956017)(6486002)(85182001)(36756003)(71200400001)(478600001)(2906002)(122000001)(6506007)(186003)(6512007)(26005)(2616005)(110136005)(38100700002)(38070700005)(83380400001)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blZtSndzL0dJZzRRTjVxeUorcGNONjBwRGdkeWNJOGpCMnBPRUwzNUJzOE9p?=
 =?utf-8?B?UVpEek9IVUk5OUhFdlNHQVB1bkNmc01JNTdJSHp5cTJmRFFJRmxDVCtUbjF2?=
 =?utf-8?B?ZE1MMUxraUhaUXV5UFV2cDY1U08wQUVKQnlKNkU2Y3FMWFlkOVd3Z1krMm9Y?=
 =?utf-8?B?eHdYRm1xMXBuc0l4QXFFL2hmNW1xaUc4YXJvd0lmMGx0WVhVU2IwakFSOTJD?=
 =?utf-8?B?MHR1ekVkMWhCYzJjbThDZk1meDBaQzQwM0lKSWNOZUNpYnplN29wVEZZakNq?=
 =?utf-8?B?OWRJdC9tVStrSXFnNkU3NWdwRG1iNnhORmlKUlJnSGQxZzBLOEYzTHdRTU1B?=
 =?utf-8?B?R1RhOFZoQ2xHN0xBOXNxaUtENVhPRjRjWjduY2NiNitLKzhUY1dlbE9KNG42?=
 =?utf-8?B?UURxS294R3ROSzZvSFFQQW4yZXh1VUVoZHJVbTB5L0ZIYi94VjlEOS92TG1K?=
 =?utf-8?B?SnRNVFhrak9EVFZubDRySlY5NEppVGs5cVVPRFU0MXhvTUlrc0MrRzROQzc1?=
 =?utf-8?B?aTNYbXBCaytMaUdwQjF3bXlFWnhCdk40elhSVmpEUmxBTFdNeG5aaVE2dmpR?=
 =?utf-8?B?V0kvVTVBWjB0cnJZUkMwNkJvbWxwamtONnZMSXluc0dmWVpNQi8wUnAyV0hU?=
 =?utf-8?B?K2hUU0JQbGFkNmR0TFkwMkFVaDMzRUVpcjhrN2I4cURYejdrNGpkKzdBZWZH?=
 =?utf-8?B?L0ljbEcwSVY3M0tma3VxRHdISkpJT3VINERYM0QrZmdkMUUwQ0xYRkw2R0JZ?=
 =?utf-8?B?enJiSkZoK25EeWhpR0o2VEdMUVVTYmJxRkdmYWhzOWU1WW52SDBhcWRIWWp5?=
 =?utf-8?B?ZlZoWWFwcUV4WC9rSzViYnVaM2VQTXZKeXVOcU1lbElEYXI0bWZ0dWRVM0Zo?=
 =?utf-8?B?OE9VSURMWDZhUVlxbDRnSHpRaExaT2FJUSt5RXpicjNEUWxXdFNlODdjbWZT?=
 =?utf-8?B?RTM5eFN5QzJnZ2dEVmh3V3RCZW1lbm5LV2ZGK3dUSkhaWUtidFBLNnBjTDNI?=
 =?utf-8?B?NnZuaExpOFBUS3A3MkV1VW9jL3Q5RE9nUXdPQTVzcjlYYVVlbDkrMmRGdE4y?=
 =?utf-8?B?djUyZjhMUzRZQ1dVeVVkTGdFYm9YTkZaeGVKSHpwc2ZmZk1OUVlqRFJSK1A1?=
 =?utf-8?B?RFNibkJMM09Cb0J6N3pZNVBiaHZvZHlkU29SbHovcU9RTVdHYit1UmtYZzJ6?=
 =?utf-8?B?QzRjOGdUVHBkSzdadWV6bmZ5aUJtS1hrTTE2U29kMkJHSXZSazY2TlBEYnJ4?=
 =?utf-8?B?L1lwTWVmT1dMeG5Qc3pFVE9icGZDVGIxRnUwWFA4ME5QNTRCeGV2ME5XczZ4?=
 =?utf-8?B?N1VPYXVETG1iNmcxYXlQQmVXQU5kR2dVTE50WTN1UEg5eHVuMDBGTTNLLzhT?=
 =?utf-8?B?dlpoN3ExV001ckxXL1c3L2ptRzdOUVkwNnJjRExhMFJQOWQySEVEaDRSd3hU?=
 =?utf-8?B?bmZINVoyV2svRTR0eTNzSk83eEFtMlN3dWdGOVRkeE1NU0czZkpUTWl4QVM2?=
 =?utf-8?B?UFNlNS84dkUyWW52RGhZRnJ6U1RoZ2pmcDVnT2dKUHhYc3FYYlJ4dm5NWGpO?=
 =?utf-8?B?N0tMTEN0enZhMklaSDVIY2hHTUpUVWpQM3VsRXRMNVdPZUE3Q3d5eUNocWNz?=
 =?utf-8?B?MW1UVzIxU2k1cUI5OU9aeVpONFA5dTcybWM1aWFkZmozcVI5a0EwcEpjTkx3?=
 =?utf-8?B?RHRSdVV6T0tZd0RkQkx6VE83S1NtQit1R1ppTG5nSmxnaGM3MkM5WWtXdVJ0?=
 =?utf-8?B?MVk4eVhBVytjY0RjV3VPQXV0Vmp0bzMyZGZMc2pFdnNpUWNWa2Q5dGFqWFds?=
 =?utf-8?B?N3pUR0NJQi9yUmQ3L29BdHhVSFFuOWl0Mjg2Ukl3UTJvTCs5K2dhSkQ3d2Uw?=
 =?utf-8?B?c2JkS1hwNXYwTlBVQzcxK21DQ1lFaFNiNC8wM0dWOFVHMFBpOGZBZFoxRXd3?=
 =?utf-8?B?S3B5VGlMSW1xb1NDODNiTG1naDExdk4rL2loRWE5ZVBHbk92eUdWNThjcytq?=
 =?utf-8?B?OUo4elU3RzlqR1k0WlhwRkZwUEVvdGNwZWRQRFU5QjUxYWRTVm9YT2xQRXpP?=
 =?utf-8?B?aE9NUkRjTXJLTWIwSit3cW1UK1BCSlJTMHFVdkY5MklKNi9QOCtFS0pkSWY4?=
 =?utf-8?B?YVdlVXVqN1N3U0tGNmFwZ1VmQS95dmJjN3pPVHdqRDEzenFxNDFzc3VLb0Nm?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CD41C00316D754E88CF0465CD9E7ED3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db9e805-5707-4bb9-9d29-08dacb93662d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 07:38:36.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yx6/sO2YAuJKMAPUOGsUf0lXztBfj+YOuZ3WlhIDwcJI8/2PqiG4KQnDTtTg1AfVB0G8ype2r5ao1Zw1g/zYs0wCNo6p6Ju7ZGAcFbEVJS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7144
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTE4IGF0IDIwOjAxICswMTAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBGcm9tOiBTYW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhpcyBw
YXRjaCBhZGRzIFVTQiBzdXBwb3J0IGZvciBNVDc5ODYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
YW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBX
dW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4gLS0tDQo+IGNoYW5nZXMgY29t
cGFyZWQgdG8gc2FtcyBvcmlnaW5hbCB2ZXJzaW9uOg0KPiAtIHJlb3JkZXIgeGhjaS1jbG9ja3Mg
YmFzZWQgb24geWFtbCBiaW5kaW5nDQo+IA0KPiB2NToNCj4gIC0gdXBkYXRlIHJhbmdlcy9yZWcg
b2YgdXNiLXBoeQ0KPiAgLSBub3QgYWRkZWQgUkIgZnJvbSBBbmdlbG9HaW9hY2NoaW5vIGZvciB2
NCBiZWNhdXNlIG9mIHRoZXNlIGNoYW5nZXMNCj4gDQo+IHY2Og0KPiAtIHJlbW92ZSB1bnVzZWQg
dXNiIHJlZ3VsYXRvcnMNCj4gLSByZW1vdmUgM3YzIHJlZ3VsYXRvciAod2lsbCBiZSBhZGRlZCB3
aXRoIGVtbWMtcGF0Y2gpDQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDc5ODZhLXJmYi5kdHMgfCAgOCArKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ3OTg2YS5kdHNpICAgIHwgNTUNCj4gKysrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2Yi1yZmIuZHRzIHwgIDggKysrDQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmEtcmZiLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ3OTg2YS1yZmIuZHRzDQo+IGluZGV4IDAwNjg3OGUzZjJiMi4uODI4ZDUw
NGE0ZTQ4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4
NmEtcmZiLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmEt
cmZiLmR0cw0KPiBAQCAtMTQwLDYgKzE0MCwxMCBAQCAmc3BpMSB7DQo+ICAJc3RhdHVzID0gIm9r
YXkiOw0KPiAgfTsNCj4gIA0KPiArJnNzdXNiIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9
Ow0KPiArDQo+ICAmc3dpdGNoIHsNCj4gIAlwb3J0cyB7DQo+ICAJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiBAQCAtMjAxLDYgKzIwNSwxMCBAQCAmdWFydDIgew0KPiAgCXN0YXR1cyA9ICJva2F5
IjsNCj4gIH07DQo+ICANCj4gKyZ1c2JfcGh5IHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9
Ow0KPiArDQo+ICAmd2lmaSB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCIsICJkYmRjIjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ3OTg2YS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDc5ODZhLmR0c2kNCj4gaW5kZXggMjlkYTliOGVkNzUzLi5jNjliOGJmZjdmNGEgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS5kdHNpDQo+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS5kdHNpDQo+IEBAIC0yODEs
NiArMjgxLDYxIEBAIHNwaTE6IHNwaUAxMTAwYjAwMCB7DQo+ICAJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiAgCQl9Ow0KPiAgDQo+ICsJCXNzdXNiOiB1c2JAMTEyMDAwMDAgew0KPiArCQkJY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDc5ODYteGhjaSIsDQo+ICsJCQkJICAgICAibWVkaWF0ZWss
bXRrLXhoY2kiOw0KPiArCQkJcmVnID0gPDAgMHgxMTIwMDAwMCAwIDB4MmUwMD4sDQo+ICsJCQkg
ICAgICA8MCAweDExMjAzZTAwIDAgMHgwMTAwPjsNCj4gKwkJCXJlZy1uYW1lcyA9ICJtYWMiLCAi
aXBwYyI7DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTczIElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiArCQkJY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFfSVVTQl9TWVNfQ0s+LA0K
PiArCQkJCSA8JmluZnJhY2ZnIENMS19JTkZSQV9JVVNCX0NLPiwNCj4gKwkJCQkgPCZpbmZyYWNm
ZyBDTEtfSU5GUkFfSVVTQl8xMzNfQ0s+LA0KPiArCQkJCSA8JmluZnJhY2ZnIENMS19JTkZSQV9J
VVNCXzY2TV9DSz4sDQo+ICsJCQkJIDwmdG9wY2tnZW4gQ0xLX1RPUF9VMlUzX1hIQ0lfU0VMPjsN
Cj4gKwkJCWNsb2NrLW5hbWVzID0gInN5c19jayIsDQo+ICsJCQkJICAgICAgInJlZl9jayIsDQo+
ICsJCQkJICAgICAgIm1jdV9jayIsDQo+ICsJCQkJICAgICAgImRtYV9jayIsDQo+ICsJCQkJICAg
ICAgInhoY2lfY2siOw0KPiArCQkJcGh5cyA9IDwmdTJwb3J0MCBQSFlfVFlQRV9VU0IyPiwNCj4g
KwkJCSAgICAgICA8JnUzcG9ydDAgUEhZX1RZUEVfVVNCMz4sDQo+ICsJCQkgICAgICAgPCZ1MnBv
cnQxIFBIWV9UWVBFX1VTQjI+Ow0KPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJfTsN
Cj4gKw0KPiArCQl1c2JfcGh5OiB0LXBoeUAxMWUxMDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10Nzk4Ni10cGh5IiwNCj4gKwkJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRw
aHktdjIiOw0KPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCj4gKwkJCXJhbmdlcyA9IDwwIDAgMHgxMWUxMDAwMCAweDE3MDA+Ow0KPiArCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJdTJwb3J0MDogdXNiLXBoeUAwIHsNCj4gKwkJ
CQlyZWcgPSA8MHgwIDB4NzAwPjsNCj4gKwkJCQljbG9ja3MgPSA8JnRvcGNrZ2VuDQo+IENMS19U
T1BfREFfVTJfUkVGU0VMPiwNCj4gKwkJCQkJIDwmdG9wY2tnZW4NCj4gQ0xLX1RPUF9EQV9VMl9D
S18xUF9TRUw+Ow0KPiArCQkJCWNsb2NrLW5hbWVzID0gInJlZiIsICJkYV9yZWYiOw0KPiArCQkJ
CSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArDQo+ICsJCQl1M3BvcnQwOiB1c2ItcGh5
QDcwMCB7DQo+ICsJCQkJcmVnID0gPDB4NzAwIDB4OTAwPjsNCj4gKwkJCQljbG9ja3MgPSA8JnRv
cGNrZ2VuDQo+IENMS19UT1BfVVNCM19QSFlfU0VMPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJy
ZWYiOw0KPiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArDQo+ICsJCQl1MnBv
cnQxOiB1c2ItcGh5QDEwMDAgew0KPiArCQkJCXJlZyA9IDwweDEwMDAgMHg3MDA+Ow0KPiArCQkJ
CWNsb2NrcyA9IDwmdG9wY2tnZW4NCj4gQ0xLX1RPUF9EQV9VMl9SRUZTRUw+LA0KPiArCQkJCQkg
PCZ0b3Bja2dlbg0KPiBDTEtfVE9QX0RBX1UyX0NLXzFQX1NFTD47DQo+ICsJCQkJY2xvY2stbmFt
ZXMgPSAicmVmIiwgImRhX3JlZiI7DQo+ICsJCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gKwkJCX07
DQo+ICsJCX07DQo+ICsNCj4gIAkJZXRoc3lzOiBzeXNjb25AMTUwMDAwMDAgew0KPiAgCQkJICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkJICNzaXplLWNlbGxzID0gPDE+Ow0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZiLXJmYi5kdHMNCj4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmItcmZiLmR0cw0KPiBpbmRleCAyYzdm
MWQ0ZmIzNTIuLmNkZmMyOTIwMDJjZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDc5ODZiLXJmYi5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDc5ODZiLXJmYi5kdHMNCj4gQEAgLTE2NywxMCArMTY3LDE4IEBAICZzcGkxIHsN
Cj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiAgDQo+ICsmc3N1c2Igew0KPiArCXN0YXR1
cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gICZ1YXJ0MCB7DQo+ICAJc3RhdHVzID0gIm9rYXki
Ow0KPiAgfTsNCj4gIA0KPiArJnVzYl9waHkgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307
DQo+ICsNCj4gICZ3aWZpIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICAJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IiwgImRiZGMiOw0KDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MgYSBsb3QNCg0KDQo=
