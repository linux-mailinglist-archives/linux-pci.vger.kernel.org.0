Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC9509E8D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 13:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388780AbiDULeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiDULeL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 07:34:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACC140D0
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650540682; x=1682076682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fQDL1PW/muE1k28auM9kBVjajY+V89lkBuNWETGqENo=;
  b=I6IRtblJs4YAod8I4xonm+GQNdt6t5YRBKgYbrwq8lXRzERgx72uSwUZ
   s+8ImP4wC+4qJElTIvdNGz2COj6GIrwWSUXgzReBcrtu5Tx/4jVft3mU3
   lS5BUUBxmaE3mCMleXqiGfdSd7D+ZxA7ucnCrMQnMPs0ALlY/FMwEelBn
   xwDi39/RUP6+8pucCPxpalBjWZlARDB/2/jpXNeTbwoeuhDOOXInP5T21
   arT4s/UoZaNPb9n88hB6mvZ1VHpzPG1Tc8qmeNCuzCESRUjJtauqAWbYA
   HVec5pXUlKJ5U/Uj+U5QvgcUd0H6YFlqlhgW4BYgA9yNBG0nw/SPBfX7r
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="93089959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 04:31:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 04:31:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Apr 2022 04:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoyYTwc0bActIyM4K1YWJhBMbPF7cDtNchWmFCuHkpp+VDzXMyTFMJDpvPjc2XM8vqrDDKX3xrgqpGiRCwGOaMVrHFpYgpmKNTZXiQRKgQhbVfD+Nh1cXWynfva8bfP3R86WwH3KZItbs+Jx8jtucOr/FEY5SEZWmfVLJaX1sR/GE51p7cPSwi+uqUy4TdOzaIpYPJrWDgDe4Eh1rTJKri5ATsN6cWi5fB7g2TVb/B/Zkb0Va31D6rbqnRF5wDfmQ4rpTRHh8iSDlkSKoxF0TDH9kAu9/giFEBI4GMMFGOneMRYdsRNkBK4DFrPdWmXh27FwFJ6qgmGVoEAJ5zmTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQDL1PW/muE1k28auM9kBVjajY+V89lkBuNWETGqENo=;
 b=Q/C3D+8yZUIux3YISQE7c+XGN/sFRJPQxRK7AZaHzI3N8zjhigrjGuL7Ja2wKnyfXF5gdo5dMBeLXjs+c7wu267dk3p+DbYBsk2WFjvbR0xq6EzNPhaufs3Rng+uLT8fk5FPbBo886YjBMR33p1ugoFxhfS2558Suz2YwyOb0AnRjFFgfOxxJ62hEE2m70fq360eArbzHo1L1xctSJEz3MpldEDGmyW3WEDjvLjc61X8O0dx+Ag5ieovYX+Arrpb9hYiJnW8OiQwBxgC3CAUFA7VQaz7VVArxnW34d4r2hF/HlGVN6Qi7P5okA66nL52/Paro0Jq5iwwFrXBbwfxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQDL1PW/muE1k28auM9kBVjajY+V89lkBuNWETGqENo=;
 b=sQJZrCnWP51lJuaqytu74SzUKA3RyocQfCV1j0kyVkcd4nTO/SjbcELDxGRB+x0SWih4StDk62CJfYKnoFDCt16qaQGRN+ro5WWmACKyfqbjpFK1SRUVoChCbmHPxKbhr/NNlaaGXaP776PH1bbhz4nU/Gl80WvmSXRdDr9eFXs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by SN6PR11MB3293.namprd11.prod.outlook.com (2603:10b6:805:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 11:31:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 11:31:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <pali@kernel.org>, <u.kleine-koenig@pengutronix.de>
CC:     <Daire.McNamara@microchip.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <ian@linux.cowan.aero>, <kernel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: microchip: Allow driver to be built as a module
Thread-Topic: [PATCH] PCI: microchip: Allow driver to be built as a module
Thread-Index: AQHYVJn7sorTKwljF0ixBpG4IvND9Kz5Ac+AgAE7hoA=
Date:   Thu, 21 Apr 2022 11:31:16 +0000
Message-ID: <bad31f90-f853-fdff-c91c-1a695ff162d1@microchip.com>
References: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
 <20220420164139.k37fc3xixn4j7kug@pali>
In-Reply-To: <20220420164139.k37fc3xixn4j7kug@pali>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45019729-0d84-41a8-15f8-08da238a72b5
x-ms-traffictypediagnostic: SN6PR11MB3293:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3293C8C6D1420225FE2F344398F49@SN6PR11MB3293.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GJhiLocluRUE1miLm+UMIkpz9QPxhA9aK7et7Hxoy6jAHocsqMErHgBeq0YaBIcMltTkkIkQvkLNIWepHh6u9e323LnjBGNHPji5e973mGFikvAAR/MaABA9NLHkZn7ceVDwgcYVhj3eOZ8m+eVF3XxoJ1ZN/7K4z9AH7X/J0ODOORRYg06FXrcG0kzoszqSMW2r4XTxFfyFiCFl/raigpkUt/8MTK6OaBKBF6KZvRoNBrrG/vczJA3fjz3HBnNgViWenWSHp/L22kJKvd9JkF5WUUP6/9hwOWCi9brX457GSLDUvUuv/EkdaBXcsEnhe8E5oaquk27bg2TkKD0vPCoHwbFEnmNafpEy0aHEr3rYjz4qwP9FP/RWwcdxq/Sk9VEzbr79kmDhdOdh9wFsIQxyDLBiyTPc1xee6n+Y3UePOMJ6CUMeB+kiIjETWJeiqyzC0P4kVRmVxzt7OnZ8crpVdeABebk5KwGmg5ycVEcEn36XQEXd/gYo6x1RNOCBhBh65BgDUFHZQJEPhmglfHx62VUz4syidvJqx9YmNmp1MZUwpcJ3xGGEu9Mps9Qv8Gmb/Jo0/V68mEsKhad6l4i9RGS+XnEL6yJcaOShpIpBaeaYdp4bc2kgycL64U10FgnxuRbYGsdvVhNGE9/wH9rNZPalF9sLRCxpFGdgXwsuCZ9pgLeQoJlKuUXPO6YkR0AMxYSG5C5PGlZx7HF8z3y0OI2L3f6Irxx/UoIdsuffLK/r5Dbu6n50KPzcaKQmus/ZNVtX63CWqWJgiVyszzzODzpF3m+XMo0vFcnnDMnVmXfGONvhvDQDyybatFiiKC2bhZYnn7PAvYEMv5JiJmsbsfqoL8Dnc/c2gtbvRY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(508600001)(7416002)(54906003)(5660300002)(2906002)(38070700005)(38100700002)(8936002)(122000001)(31696002)(86362001)(316002)(71200400001)(91956017)(66556008)(66446008)(66946007)(8676002)(66476007)(64756008)(4326008)(76116006)(6506007)(110136005)(53546011)(186003)(83380400001)(6512007)(2616005)(26005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWg0THdSZ0JQMUYzU29vU0hVYVpqU3ZHM1dFcXBTSHExQTFBdDQ1RVFSYmtF?=
 =?utf-8?B?KzJvZlEvQ3JPZnJVUm4wQVJUSS9wOHNnbERmZkpLUnFnekhNbmFnanJia0tL?=
 =?utf-8?B?UE1CY0ZrWGV4VVB4T29DZU90bnIydUVnajVJeVYzS1dsZXZWUldPNEJwWWhH?=
 =?utf-8?B?dHlYWWcvNlcraVk2cG91NnFOejF2b0xrTjNCS05vOXhCZ3ptT1JESGwzZitT?=
 =?utf-8?B?VDRZdUMvakpNQisweUVWMzhYVHl2UExtekpqK1NGdHQ3VDVzNmNaTk80Y3I2?=
 =?utf-8?B?aTVObXEzTjlFd1FwMDVpQW9pSWZVdVp1akFTS2pwMWFldnBmeWY3azdzd3hN?=
 =?utf-8?B?cm5TVDVsc2prK3ptYlNEeVdJNDNJbVhjSENiSXprbEU5b1Q5MnRsNWFoYVI5?=
 =?utf-8?B?WEcxMEdMM29UdEJjbG5JTjJ0UkV2bEFoUTdjQk54RkdaL2xLbFlTc1liL3RJ?=
 =?utf-8?B?VVNMZjVPZE85L0JVWm01RE9XREFlMEtSZTA5RlBqY1E1OXB3OHJYT0xZaXBQ?=
 =?utf-8?B?UGI1Z0RXaEE3YkhUNE5FemJ2MjIrRHUzaThKN3BsWTJ5YnhRYnV3SWNhdnY1?=
 =?utf-8?B?YVJhUmg0TlpVeDQ1b1MrZDh1Znk5U0ZCOFRoVTZRUmI2SjdXTnpnZFc2d1BJ?=
 =?utf-8?B?M0RJa1hjWHRlSjd5SXJYVDdMR2JSRXRRQyswVUZGS0hGL3J4a2FRTDRVQUFz?=
 =?utf-8?B?OUVsYnRFOFRJdDNaS0ZaL0N1TzBzRjJ1SDgrK0VxRmF0d2ZkQTZsWTVBcm5D?=
 =?utf-8?B?Vm9mU3JuNFhXRUpzNGd1aC9WYmM3eFFiWGVQZTljUmxVT3ZmejlId044dW5D?=
 =?utf-8?B?VlRhWE12Tk1OQlpNMjBFU0UvWTluMmI4OUVxMi91bWNOOHk1ZjBJdVNVRkxQ?=
 =?utf-8?B?ajRpYlBQTGJIVERrWkVnOGR2MlNlem5EN0p3dmQ4OUQ5Y0wrQi9sS3JhUEpI?=
 =?utf-8?B?QytrM1JhajhVSXRmdVR4Q0p2c3cxSWRtaXRTcHVUVVdGVlprOU5FbS93UHc0?=
 =?utf-8?B?VUlqbzJoV0JsRHFNc1NNR0NiZ2lZaDdEQzB1aUtEK1gxa1FEUXN6Q1JwQnZW?=
 =?utf-8?B?VmZraWdyMG1IM2FvNExHU0RTbUZqVXA5REwvZkljNEVSemlpOVJjUEJDemJP?=
 =?utf-8?B?Q1lRQ2p3andzblEvQXgvWDE4T2t3bzhLN1EvQU5uZE9RUjUxYWhUdEZpRDAr?=
 =?utf-8?B?U3RYSzRtb2Zac1JUL2NIbFRxOHJZUDZTRGkvWFkyek1PeW1FdFNNK2R2TFVo?=
 =?utf-8?B?V0lGaGx2S0lzOWx3dENMeXZLbkVpS0NEdXB6M2xucWNQZWFab0xvR3VXdEl3?=
 =?utf-8?B?RUNSZmxwUzVVZEdxQUJ1bHVtUTVmbVQ5ZThKUEF2citqRzN6OHVXaDlQNk9v?=
 =?utf-8?B?ejc3V25kQmcvYk53cndFWmYvdWFUZitMTDJ5QTJyMnlveFlBSEdOc2Z6Zm13?=
 =?utf-8?B?OEJNZHJlRXdlclpIRHppYkp6ZVg0SGZtbkxpN3g1SzZacTVXUTZMZzNSK0tU?=
 =?utf-8?B?Q0pVbmdxcFNmOFZSbmNWd2ViYVVEM1JNMXFHbTdRNkduYkM5cTd0QjYyMXBG?=
 =?utf-8?B?bHlwblJsdE03SXhKb1BZa2dpeWFtUkc1YTJ4UXRON1FIRjhyR3BlQnpudTZT?=
 =?utf-8?B?dVN0L0xsL0dSMkczaUhVc01RdnFKdGtaRnRnaWQ0VEtLQVlBc3FaZ1R6Z256?=
 =?utf-8?B?K3FtQ1lnMnpzazdaaXV4ZG5Ya2wzZ29GalVjOUNWNmRqeFF6RkJRUHZGdWZa?=
 =?utf-8?B?UHZkbjZ1N1JyWFZPbDUzZVlLaEtJLzY4UTlldVNjWHRIN2p3blc3MVJ3U0xh?=
 =?utf-8?B?NHFxL2p3azRwc1NpVnVnU3hpeVNXOTQyU2JudllMMTJvckZ0L0NYTm1JS0kv?=
 =?utf-8?B?MlhzUHdxUVVGMUFlTWpkeWZ5NVBLU08vVEE0TC9MMW4wT3hLazNjT1I5aFYz?=
 =?utf-8?B?R2MxMk1OWmZMNEZWQ1l3NndQNUUvVzg5dUp6NFVzN2lrb2ZsV3VSWCtCN0ND?=
 =?utf-8?B?UXVCVXBCazU2MUcxSEhucXlleXBEc0VRVko5NHJXc1VBbmdMQmhjNjBvcWpZ?=
 =?utf-8?B?MzU0NG5CZFhJbmt3dm1zaVRZS3R3V1BNYmlyVFZGRU83cVZDdzNZeTQyVUx4?=
 =?utf-8?B?S2FZT0ZBZW9MQktEZi9tejVVTFllTzA2VTk0bzVUSHFyU081TTYwNExoV1hj?=
 =?utf-8?B?MVVObWRmN09Ba05vcUFyOG1kdmNraUcwRFBzZVFRZFRBNkpLN0hQVUdySHBN?=
 =?utf-8?B?QmlBMUZOTk1nSW5MWTdpeXZtRjNTRHFqcG1iaktFWWVzZWQ3WDIyeGV4MG5L?=
 =?utf-8?B?cXdjaDFuRTJrdnY5KzFQOWUveGNsWmNXemJsRlJ4eXp4STlGZmtWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <550F8B46A939C94DB293C1834564C462@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45019729-0d84-41a8-15f8-08da238a72b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 11:31:16.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tywH5YJc3VYKlHh1Br4vr41I+j0KrhxsfriYAmHppz0sk03HkBgU+Cq0Eg+E48pIoBG0iZkL2DYu/rCrVCqX5SHT6VKiETGYBxGwZAiznbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3293
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjAvMDQvMjAyMiAxNjo0MSwgUGFsaSBSb2jDoXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkbmVzZGF5IDIwIEFwcmlsIDIwMjIgMTE6
MzQ6NDkgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+PiBUaGVyZSBhcmUgbm8ga25vd24gcmVh
c29ucyB0byBub3QgdXNlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLA0KPiANCj4gSGVsbG8hIEkg
dGhpbmsgdGhhdCB0aGVyZSBhcmUgcmVhc29ucy4gcGNpZS1taWNyb2NoaXAtaG9zdC5jIGRyaXZl
ciB1c2VzDQo+IGJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKCkgYW5kIG5vdCBtb2R1bGVfcGxhdGZv
cm1fZHJpdmVyKCk7IGl0IGRvZXMgbm90DQo+IGltcGxlbWVudCAucmVtb3ZlIGRyaXZlciBjYWxs
YmFjayBhbmQgYWxzbyBoYXMgc2V0IHN1cHByZXNzX2JpbmRfYXR0cnMNCj4gdG8gdHJ1ZS4gSSB0
aGluayB0aGF0IGFsbCB0aGVzZSBwYXJ0cyBzaG91bGQgYmUgcHJvcGVybHkgaW1wbGVtZW50ZWQN
Cj4gb3RoZXJ3aXNlIGl0IGRvZXMgbm90IGhhdmUgc2FuZSByZWFzb25zIHRvIHVzZSBkcml2ZXIg
YXMgbG9hZGFibGUgYW5kDQo+IHVubG9hZGFibGUgbW9kdWxlLg0KPiANCj4gQnR3LCBJIGltcGxl
bWVudGVkIHByb3BlciBtb2R1bGUgc3VwcG9ydCBmb3IgcGNpLW12ZWJ1LmMgZHJpdmVyDQo+IHJl
Y2VudGx5LCBzbyB5b3UgY2FuIHRha2UgYW4gaW5zcGlyYXRpb24uIFNlZToNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjExMTI2MTQ0MzA3Ljc1NjgtMS1wYWxpQGtlcm5l
bC5vcmcvdC8jdQ0KDQpIbW0sIHNvIHdoYXQgaXMgdGhlIHdheSBmb3J3YXJkIGhlcmUsIGFyZSB5
b3UgaGFwcHkgdG8gZG8gaXQgeW91cnNlbGYNCm9yIGRvIHlvdSBub3QgaGF2ZSB0aGUgaGFyZHdh
cmUvd291bGQgcmF0aGVyIHRoYXQgd2UgZGlkIGl0Pw0KDQpJZiB5b3UnZCBwcmVmZXIgdGhhdCB3
ZSBkaWQgaXQsIGRvIHdlIGNoYW5nZSB0aGUgZHJpdmVyICYgc3VibWl0IHRoYXQNCmFzIGEgc2Vy
aWVzIHdpdGggdGhpcyBwYXRjaCBhcyBwYXRjaCAyLzI/IE9yIHNob3VsZCBpdCBiZSBhIHNpbmds
ZQ0KcGF0Y2ggd2l0aCB5b3VyIHN1Z2dlc3RlZC1ieT8NCk5vdCBxdWl0ZSBzdXJlIHdoYXQgdGhl
IGV4cGVjdGF0aW9uIGlzIHdpdGggYXR0ZXN0YXRpb24gZm9yIHNvbWV0aGluZw0KbGlrZSB0aGlz
Lg0KDQpUaGFua3MsDQpDb25vcg0K
