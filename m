Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB986C0CB4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCTJDB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 05:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCTJC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 05:02:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985A901C;
        Mon, 20 Mar 2023 02:02:53 -0700 (PDT)
X-UUID: fbd435e6c6fd11edbd2e61cc88cc8f98-20230320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=re5jNmQzZvvbnh+ZDncyQ0vMqq4XQvsEfcpbCQKHnYw=;
        b=HTt3VqAy1KWXS4acvtnhPsr0zje8MemIIvy2jJqGi/AKJqDVdJ/jDfHtIF/IK04OVZ2Bw3aOYyGj5p2hFUFUBhLfuAHzeKWbAh6Y25wG8/TJIPkTey/iVzh+4DiUN597Le/TAsphajkUrTNepmIFzW8551rD3PpBc6wSYpRq0Xg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:7b89f412-2a3b-4bd5-b9cc-4f4408137561,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:2,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-3
X-CID-META: VersionHash:120426c,CLOUDID:3adfe428-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: fbd435e6c6fd11edbd2e61cc88cc8f98-20230320
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 559912955; Mon, 20 Mar 2023 17:02:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 20 Mar 2023 17:02:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 17:02:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFBcwZMp0vt4Hz1mqPpoM8oCXJ4iI0VWUszvQCeYRpCWMA8TimuA3hjxwqi87vx64sMZTAzBWkQoqHsUBwB6nQp+0UYB4VZRtAKhslihwJQh3ZUN4E6lCa8aLyG1wLlEJOOYDIT7kixH+y6kJJAWSY9KGy32zvXDF/zR9mJS51LUNdvxYmYjjSECDR0cnmKNUcijxkPV5R+C8HySwfOcAXaWu3VJr9K7nxzVuExnUWKBl9+DYhk67pHO/kGWyiaT95AGqIX20SkHJAgi0Y45eMUux5iGL6GOD4tT/O76XtH4K1XZE4RK9XveYpV8OQwCKk+4VgwrDw8w5jxS/ms1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re5jNmQzZvvbnh+ZDncyQ0vMqq4XQvsEfcpbCQKHnYw=;
 b=Clsj4n4gg3DtbXXC3rubsmxsaEr36xU6pZvi6bDWbrjUHeyRPAP0px6t39w5H25zUpg85xVhYQO5MdgiwAF6W6tpNgUzdS+J6WpFVEf1pQswVW3uoNfyWQVDJlrpm/E4UDepptu43H0FJXOVLsEYA5Q1D7L0iV/HdPxEg5sGpIQrd5+0r7T99qCKAZCoS5pAyN1XN8FGQaNYtHOQSsNW0dU95Z7kFJF0J3l8ZQ7CbUV040I1stMzTA5cyrtgsFCx/AcpzOTJpoXiox57uA52jhEKHLeSsCpg5YW/jDcyh2ryt8bwv/kXFOpnMfjaRtYmuQJ29GKETJQSfWjpRHS69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re5jNmQzZvvbnh+ZDncyQ0vMqq4XQvsEfcpbCQKHnYw=;
 b=BKpz0kv74T1grl218Wy5iRrExg+ermBeXEkBZjZyLFaprPckbtFQy4FrFrtdc+ky78PpnYVvYAuaOR+a1FDzFpZIf6OiFahZMAJ+Ov9UXs4yjyS48JeYJ5ocIRIgXXWHOUggQStk2XEQSwaWTr/bA/NBGQ2ImEu8VK/enW8M/1Y=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by TYZPR03MB5881.apcprd03.prod.outlook.com (2603:1096:400:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 09:02:44 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::e440:dd1d:be13:d79b]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::e440:dd1d:be13:d79b%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 09:02:44 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: mediatek-gen3: Support controlling power and
Thread-Topic: [PATCH v2 0/2] PCI: mediatek-gen3: Support controlling power and
Thread-Index: AQHZT/a0FE9BkfPezEOgcSBhzWr+qa8DdYcA
Date:   Mon, 20 Mar 2023 09:02:43 +0000
Message-ID: <33525d184e53674b19d51cc3da5d63c4b1fbd565.camel@mediatek.com>
References: <20230306064059.7239-1-jian.yang@mediatek.com>
In-Reply-To: <20230306064059.7239-1-jian.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|TYZPR03MB5881:EE_
x-ms-office365-filtering-correlation-id: a689eb64-818c-47e8-3082-08db2921de32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GycN6PLlEsnSOGlSnj6kTOKF2J9hTV+c0WCUltBIQvcMxG5IhVv2JbcvngFbqMhtC3HDXWZtz8rRvFPMrdpNtYFsSgZ7JetEL0aD1JkVbsrCWVQHHXYOGGAMwfmoAZXojYp/7D8/xkTBrIw/A64KWmfJoEZYZQ4IqZn5aRkzIbn7hFXVWMfSU5gBgkfskeLoJ4nkth+Vb3RPsQGMZ/ORJ/PFJEE+aOsiQQss+hj2Wr2f0Vqo73u6EGXeh2yZBhIqwwiifTUfATn3/hvaFHV6UmYULxtZTA7v/uba0Db5FKVsz7D8IEPdVx8vLZw+25gHZAQVsVFOXf7cL1mFNReOGo1AmM55jpUlJwof/vXXrGqEGanQKXRP4zKPo8RpadFoNpCZjpGlZoeZHMtzpzz1d9Zvp5UgCDU515evtIv3UtazeuMlR7w8D/zeQ1fBjOaXjPzMdpQ1//GgjoN6TWsq4R1qzUvQjtpPoU+1IE5sBYU1MpZmpYturPtG0WP/Jqp5Y8DIjXYVCQvdnz4lHRUr1zDfZkr45i48+HMxULqfwh0Sw9y6+dYRlOfkZ9+sspVa7Jua47HAO+ozEyfHwbdrowiqL60S+xs6VUsUN0SlUihNlGh+v2Y2+3rzxfVY/VGuxC+/CtHVzxRqK5XfHR3SGd5QaY/qGd8l00D3CLBJxdzosCunXkvvefneV/JVf+CuEEuuPWDhXA4EBCUdISfLatI2+wVmMQ6G0+6LZxeL6Vd02U25QGl4hTJ65ldhYxDz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199018)(86362001)(36756003)(85182001)(71200400001)(478600001)(91956017)(66556008)(66476007)(66946007)(4326008)(83380400001)(316002)(110136005)(54906003)(64756008)(186003)(6512007)(26005)(6506007)(2616005)(6486002)(76116006)(8676002)(2906002)(66446008)(122000001)(38100700002)(5660300002)(38070700005)(8936002)(41300700001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjdDRFhjcXVPWjRZbk1WLzVOd3FpeUJlOEphTFU5VWpxZU9LbllFMWVBYk1p?=
 =?utf-8?B?VWhtckRuLzlKVHN0L1I1NlZ3emg0VjZ2S2pTM1BqZDRkR0hmZWx3S212ams3?=
 =?utf-8?B?QmZ0eWNhcnF2WlJGMWg1OUVjZ0xVbnRTS2RrYUJOaWhGR216MGhNOWxZR2x3?=
 =?utf-8?B?eVNaRnZZeEkxVHJjcnNtbENVaE40dFBEbjJDV1JQSDY4cGUySTBWcTAyS0ZW?=
 =?utf-8?B?cmFCUE1iZlVsU09paW5DOWxteGxENnZLTW4zN0g0STlhRklKUVlWSlk4aHRM?=
 =?utf-8?B?WnZ3TWlyZ0FFemJIMDFRQU5iR3FnTlhkOEczS3NWRk5mSHJCT1ZRUUNDcEVk?=
 =?utf-8?B?UEh1cmRFbkFLNUhUYzZXUnhSaEpWK3dMY0FwaW1MSXl6UU5rK0YvaG81OThn?=
 =?utf-8?B?TFFrT0lzTVhYS2srT2hWT2tvMmdMUW4rbWcrTFhYMTltL0FRUkE3WnlsZHdN?=
 =?utf-8?B?elZuQnFIY2U0d3QxSSszT2ZhZmRTdWt0RkdaMFBBTENxQkw4SGtDZ0JQd1g1?=
 =?utf-8?B?RmFzOEptMDZKS1VLU2c4VC83NGRjSFFPWkVOdWxXTzhLK1ZxdDJKK2NGWVZ6?=
 =?utf-8?B?Zy9yN2JnUTl5U2JTeEhudnBYeklSSVFZQmxXQ2xKN3FLS2dzZEx3QTNJR1gz?=
 =?utf-8?B?SjRkVEhwTjVQa2N1QXY4cHhnSVRDOHpUbFFiNGJYc3dMWE5NRHo2QThhTlds?=
 =?utf-8?B?bzh3NnA2QnB2ZjJtNE10YkFScFhOOVhTK01xbXJhaVdTcENwZkZla3FyU2gy?=
 =?utf-8?B?U1VqeElqY2FNWS92Q1JNZHcrMHJ5dHNyU3ZOdWpkakM2S3FzWFpyMWNNSS8r?=
 =?utf-8?B?cGZVeXY0dGlBYldmRUdnR0pvTmVXNTM4REN6N3IrclVza3E5c2RnYktVYjZL?=
 =?utf-8?B?YVRuWlhrZTY4RXVydGMwblZibFQzRjU5bkpEQjhxRFFPSVh5eG1UNDd3WmhC?=
 =?utf-8?B?alZZNFo1UVpReXMvYUdiYmN2NytRU0ZybXA0NlA2L2JjMm5udFFZTmo2NXkw?=
 =?utf-8?B?Yk1tSTFXazgwT3d3cDNQc0VIeHNHSWw1MVNpNnpsVWltY0ZHanVyck92ZFNV?=
 =?utf-8?B?UnlrdExrZkFYUkt3cHJ6SWNLemxIMVpVYUVJZHRBVzZTQmRPNG9IMlZXOFVU?=
 =?utf-8?B?UlFRalZXY1EzVDYvQjVhNEhIYVg0aDk4c002ZE5aUVZDYXZ6NXFVam1uU3JO?=
 =?utf-8?B?L21sTzdYQnAxUG1zcEkzSW1naEtMSDdlTGhpMk5PSU1saCtOMDJoT2JnKzV2?=
 =?utf-8?B?d3l6alpoZzJrWHhucnZaYWZtTU43VEcvZ1pFVkxFQ2ozMjZVNlR5VlptdVVq?=
 =?utf-8?B?R081QlNxdTE2Y2s2Z1hTYnlWUWdXZHBOV2tFSmtoMEo5Wi9Gb3pMZjhpajNp?=
 =?utf-8?B?UUl6L1doWDB2YnJDME1BQXR5bXo3Q3oxU1huZllNSk1wVU9MdG9TaTdCQzZ1?=
 =?utf-8?B?S1JZVzZsMUpxWGhhNWd4UFhFVEFMbnhyeThZc2s4RGdoc3lxdlk0SFJaYnd2?=
 =?utf-8?B?dlFCRmxhbll3dzVyTEpLR3BXYUlGd3Q2SVBkOFIvQlc0bFdzMzV5K0tFV0ZE?=
 =?utf-8?B?WDE5dTJNMndRZ0ZRQTY4Y3FxOVdqVEt4YUtoQ3d4NHRYUnl6VEhwOUQ4TnlM?=
 =?utf-8?B?WU8xZERoc09EOXUrK3FuK0ZRQWw5RUx4ZGlXWGpROTI3QkFUWDhPUU1zTjB2?=
 =?utf-8?B?cmgrZTl2a3pvWlpVMWVLdEVBbUt3NnRGZ2RCeEUvV2FIWkdrTjVFVkxvNkZp?=
 =?utf-8?B?a3N1U0VJbWxKaWl5U05EbTFzU3RQR2kwdHhUY2xnSTNNeW55NWhsZXA5TGhn?=
 =?utf-8?B?YmtCMU56aVdCQm1SUzZxcy9wRUR0RENMWS9xYXY3QVZpNGh1RHE0d0d6c2FJ?=
 =?utf-8?B?MkF4YnhqT3Z1ZWNOc2Jqd1U3NDZxWDVzeXFQQkRNb2FnMitEcXV1UjBTVTBX?=
 =?utf-8?B?dEgxcHBpK1dhZCtvMzkrK1I3enBSc3E2cFFuZGZITFRGSEZkZkY1L29QMC9z?=
 =?utf-8?B?ai9TY1NUN0RQeXJKeDg1UmZicDRTZ2hpNFAvc2lhVWprb2pwWXZjR1RReDVx?=
 =?utf-8?B?U3VzUmllQWVyWExlVytWeW1JODBmUTdIQnNyNjZuNkVkb0laSjEySTNKUitS?=
 =?utf-8?B?azFKUTc2QVBlV3EvZHZSMi9oMmFjWmp6bXNCVDdwR1hCV09wWnF2dXZ0cm41?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE492D14527CF24FAA94F1BB3ABD0A83@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a689eb64-818c-47e8-3082-08db2921de32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 09:02:44.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZD4ICXlNSqgMUdOX3HVeMNRk/3Bqcr+7ZeT4GCxx9N6b3UTy3NfWfi+OFALb683jEGON5VHApJTdhBX8v4vfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5881
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBNYWludGFpbmVycywNCg0KR2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2ggc2VyaWVzLCBp
ZiB0aGVyZSBpcyBhbnl0aGluZyBJIGNhbiBkbyB0byBnZXQNCnRoZXNlIHBhdGNoZXMgbWVyZ2Vk
LCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCkJlc3QgcmVnYXJkcywNCkppYW4gWWFuZw0KDQpPbiBN
b24sIDIwMjMtMDMtMDYgYXQgMTQ6NDAgKzA4MDAsIEppYW4gWWFuZyB3cm90ZToNCj4gRnJvbTog
ImppYW4ueWFuZyIgPGppYW4ueWFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBUaGVzZSBzZXJpZXMg
cGF0Y2hlcyBhZGQgc3VwcG9ydCBmb3IgY29udHJvbGxpbmcgcG93ZXIgc3VwcGxpZXMgYW5kDQo+
IHJlc2V0DQo+IEdQSU8gb2YgYSBkb3duc3RyZWFtIGNvbXBvbmVudCBpbiBNZWRpYXRlaydzIFBD
SWUgR0VOMyBjb250cm9sbGVyDQo+IGRyaXZlci4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IDEu
IFJlbW92ZSBhbiB1bm5lY2Vzc2FyeSBwcm9wZXJ0eSBpbiBkdC1iaW5kaW5ncyBmaWxlLg0KPiAy
LiBVc2UgdGhlIGZsYWcgJ0dQSU9EX09VVF9MT1cnIHRvIHNldCBpbml0aWFsIHN0YXRlIG9mIGEg
ZG93bnN0cmVhbQ0KPiBjb21wb25lbnQncyByZXNldCBHUElPLg0KPiAzLiBLZWVwIGRvd25zdHJl
YW0gY29tcG9uZW50IHBvd2VyZWQgb24gaW4gc3VzcGVuZCBzdGF0ZSBpZiBpdCBuZWVkDQo+IHRv
DQo+IHdha2V1cCB0aGUgc3lzdGVtLg0KPiANCj4gamlhbi55YW5nICgyKToNCj4gICBkdC1iaW5k
aW5nczogUENJOiBtZWRpYXRlay1nZW4zOiBBZGQgc3VwcG9ydCBmb3IgY29udHJvbGxpbmcgcG93
ZXINCj4gYW5kDQo+ICAgICByZXNldA0KPiAgIFBDSTogbWVkaWF0ZWstZ2VuMzogQWRkIHBvd2Vy
IGFuZCByZXNldCBjb250cm9sIGZlYXR1cmUgZm9yDQo+IGRvd25zdHJlYW0NCj4gICAgIGNvbXBv
bmVudA0KPiANCj4gIC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwgICAg
ICB8IDE3ICsrKysNCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4z
LmMgICB8IDg2DQo+ICsrKysrKysrKysrKysrKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo=
