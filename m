Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8810A590D32
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiHLIJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiHLIJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 04:09:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A6A830E;
        Fri, 12 Aug 2022 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660291797; x=1691827797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p0858+qRgzGJeVMTYj4l+WG9e1RYGFChIaPW5fqE6Qs=;
  b=axoJcemkW9vUTP0Hz1+P1Ylz2TO/WAlduF4sjQzdb4tg477Ff4AeDy7W
   GYljRVHhcGphGBzLY3rMV/n/t2f9cNirUYDmTIL9KAQz1fNmgDP7DpLpp
   Uc7YW028OZGDaGBuirpnwGDyIkO3/hGW/3R3gG84mK5hXVXqUi5w+Xobn
   DH62FTRvRatsrUqfKUzsWdBaQTSseKYgWPKQdUmYhHPWPHywdXTjoga+O
   caqL5zGOmp6kILlGkSWiNq4NXzhMFCXmJMHj2TgDNGf4KduMFySbDgC65
   5jau2W8RtXkT1D2OH+LuFvtDL2LHctbnG9HK1+p+ECcDUhYWhvCsPfJWH
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="168991937"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 01:09:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 01:09:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 01:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RryIcpIizrY9eEVJENgCV46Ze5OiuFLhK9r59HYmaXOCr2vnSaudQHpL7F2z9ltd4cdubFf9JWXc6M3EnqQET53jIEb9pZ19FgdHD2g1BvA1labZHjPt7Wo5LBWkP0+TeWe0Si08rtgin9YXHOtigrlVH+WWkeScWMnmIdiqjH4mdmpLesb6fw+FDm9zJ9bGL9wl2JQNmagVUY4ZDv0URdubL3lSwtKH3mj4ynv1/ukO5DkJp/mpwBTGU0MYtn5FGZAApQWJSCYv0vj16qYTh/RkpWNpMw5vkZA/qR+aXK5S07bZQ+sLgFOaM6U/aEhxFxvE5yRZ3MiiJoKOq7y/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0858+qRgzGJeVMTYj4l+WG9e1RYGFChIaPW5fqE6Qs=;
 b=Jss+DA5cedf3Jpq8Jm62ZyzsQC6bWBA5TrepbuqE9p9iDrnPcumpW/on4K0Q0g+WKccSekTfHySSufORSusmC9Joxs66WrjFwGp0vAbk0p1OauAO9CLZttOuTpm4CiVS4jg1gRdh03CXNfzOFlUtE2WyfGCE9OqIktuC/3wvC658oEpIh4uFQ1YvidDS+2gQPvgtk3cO27bZsRZmXEwz5IfS5CZayGelEfTxcVqg3PM+jThQLylKWZ+XUDB5KMfW5Ya8pyZSh9GKtWRHwVEr2r7zS48266DATXTQS04aSxORVJ07Mmnt6BSO5/cx5kCA4fHRW9gsUAccqB4zcZSZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0858+qRgzGJeVMTYj4l+WG9e1RYGFChIaPW5fqE6Qs=;
 b=UXJEzc1HmYEB41RWy3Wov4rmDw52R5MSX6RECkooxPrPfA8Pm3fy51rCus3BE0SbSSlNKWjBp0AC+oT0/9sxxvVfsh49bd/p1/4sB1impecA14HW6jAchFzsUdX0n52PUZewBkwrwSC0wpQ2YZutf9aBT9OSZ24LGJQ1db9KTa8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1901.namprd11.prod.outlook.com (2603:10b6:300:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 08:09:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 08:09:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 clocks properties
Thread-Topic: [PATCH 2/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 clocks properties
Thread-Index: AQHYrcGqVjwwy0+GMkSA5AgZisgzK62q4LmAgAAG/ICAAAJ+AA==
Date:   Fri, 12 Aug 2022 08:09:49 +0000
Message-ID: <059e4394-df66-abee-2c11-7f8e9dafc577@microchip.com>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-3-mail@conchuod.ie>
 <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
 <a9dc3a83-faec-71e0-c48e-25e16e18dc29@linaro.org>
In-Reply-To: <a9dc3a83-faec-71e0-c48e-25e16e18dc29@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6421a8e5-1f53-4f70-5a22-08da7c3a0762
x-ms-traffictypediagnostic: MWHPR11MB1901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dy3KF6HqFuj7Yud7/G7ZYb4Uu1Swmw/GQJFXZ9e/7JfdPS5U7Ye2LGtiGt4gTJABrLNewmdt0Q2Qiu+tcWkvSm6tirbTytj9GYtoVwF9J5F4aAqtesBpP/8CraQhJMpP8EPrbYkV6uhi4jLK4LCxANtzivRHGV41XFC7goA71JGLcgakifNqz9VbjponHh/4nbFxvdUK+Un2Cp/pZv29JNTF114Wr+hQ+XrQcyXZWAa8pS3nN3C4QGK2xOp+MAYRlzEeVlUR+RYZcRFXJir/QeV3XDiaJGiTeqJLPtUTtxd5KGjaMrdbBDPSk3bLIDfyi54KqYx4wU9mcKwtS+K1fbx5aByiT9TNHfd0NH/Z3+FWjwISeak4obCsGO9RkfWgH4W1WiFoTER7BpT8K0+N6wEdth35Sz1S+liildGjUdHlzlNYBzwv0vwF2mabwgDB+XLkRT8MQlzT70gUpPrPcTP4nFKobvd7FC00g2AtQ63C1ciHltbuVfa4xWfB0mqEDRM3JKBEJe19aoPyfC2bolpjn4KkxaDozD45C4aX5puJalqguz/5j6VuB2HWkJnUt16N5bzgLYLM465YTyHmZBDzvYJFx7umbRUubMwQ+aH7y4Jf0FfFOo86Dl0HjDyT/Kx2QWamUTQZrjgZXl1LIpRGqGZoo4X2wtQZV0lkb2ynC+22M1jjodh+wQP21VrYFQrbtDrDoOQ8j6GZsHA7Gl1WVpmV+6iERauKTj6+2d2gOQD3EbLeaE5XFMwABJs3X16gtt5jJXumZmUVv8b5T8Zd9It8iVNxOMGHwnZZ+VqAjzBd7NqtBS5tfP2o6Oq8rNX4kziUCxevIaZ2yxRp6VkDvPea4FRKonsR6k9YWUI36R6CEs/sj5m5pYSd4Pon5SgiY4XJIagiBW0qtbu38Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(136003)(39860400002)(366004)(478600001)(66946007)(110136005)(66446008)(54906003)(64756008)(66476007)(4326008)(76116006)(66556008)(8676002)(91956017)(71200400001)(7416002)(6506007)(5660300002)(4744005)(31686004)(8936002)(26005)(2906002)(41300700001)(36756003)(53546011)(6512007)(2616005)(186003)(86362001)(38070700005)(31696002)(921005)(83380400001)(316002)(6486002)(38100700002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEJqbmFFR1BHQVYzZ0JFdG1uS0JaczdVUXNwc2JjVjR4aVNUVFZDa3piM2NR?=
 =?utf-8?B?WUgxUDR3S2ZkQUQ3bG5qTVUzRHk1RGNpRHh2OXV4WWc0ZU01MTZzYUpWelE4?=
 =?utf-8?B?anBiU05aSTVUb01Pb1M1YVJxQ2JOSE5HdE1HMXE2eWFUK3AwaHFMYnNmQ2t2?=
 =?utf-8?B?OXZZbU9UTXAzUThEQS9YTTNSekwyaE1qQlhrTXlUcjlicENac1h1c2dHVkpy?=
 =?utf-8?B?UTBJREF0Sk5BUUl3Y2RqMW8wVVdTMW1uUU94MC9FN2s3QjRiblkxM3pnM0xj?=
 =?utf-8?B?UWU1dm9zUVc2UnVIOFkvaGVPVXBuSm4xWkJDYVhRem1Mb2JtRnk0aVRXK0dB?=
 =?utf-8?B?bHluOHdMaW5VSlhqK0tsQXJQTFo0eURxbzdseWRManlhT1pvSzdmZmNxVy9p?=
 =?utf-8?B?T2puRDB1U2tpUStTVzBDd2Z6Tkt3UWd3VWNXaVVXbTg5STlmbFFTRHRkcHVD?=
 =?utf-8?B?QXIvbnZUUWtCQUYyY3h5VFdYSHRBdXFKVW8wdHVPMzdJY042L1F0WTlBQ0dl?=
 =?utf-8?B?OGRYOEtnOWozZXV0cWxreTV4N0pVQk51ekY0N0lkVWxuMW83dHJnb2VwZmlQ?=
 =?utf-8?B?UDczL3JhTThNU1ZsVHE2a1hSVTBFSWxTUzYrZWM5T29zdVNRSEhYMWs2QWJ4?=
 =?utf-8?B?OURzbmc3cUNwaXRsdWVpQWpXWUs1SGJveEJSTDlqTjZ0SGlVSWhJQWlWaGJT?=
 =?utf-8?B?MUZxYXUwL0kva3FWWHJWdVpqeWxkQ2N5Wk03UTF2L2tpWGZZZGI4MVhCVnpi?=
 =?utf-8?B?MGlURWJDekxuazUxelF1VnZYS2U1MFNzWnN3S0VkSldHcEJ2QVVkaEdQbXd4?=
 =?utf-8?B?UlN5ZHpUaVpOT2hEYi83WHNVVFlNQmdBRHdMK2wvb3NuQU9QTXowaHNKQ3I3?=
 =?utf-8?B?VWF4c0FqeUthWENZUU9IbVUvMElzWU0vUDFzMWh2d0VMOEU5Y29GZjZBMnVl?=
 =?utf-8?B?Qm9XTnliaDBCLytTbEdrMmNQQ0NPSE5DUDRxaWZMWmZUbjdORXlieE9sUHhE?=
 =?utf-8?B?dG1BTWdGSGpWRFE0cVJjNkRYV2tucFh2c3ZBY1VpUTYyTGZvSmFReWtKcUFB?=
 =?utf-8?B?RVUzckswSDdNZGNRWEdTOGJKb3VsT25UdjlEZDhIM0JCUjFTWjNmRXlST3Nz?=
 =?utf-8?B?WUYxWUEwNWhxVnRsandtbitRZkYyUklmVEV1Zkd2bkZNK2RDbXJMK2t4cGtF?=
 =?utf-8?B?RCtVR1JJRlRlN282Y3NRaDlucWRPTTRVN3hLV2dWeUJ4VjI4YmdGVnZhcnhR?=
 =?utf-8?B?MUpYZ3FjeVBNVm44OTBtOUpCd3VseFZmU3M1a1M4SXMwMURjQkRseDZjQWlF?=
 =?utf-8?B?R3VaT3drRi9lL2pnUUhvbWJxQWZhLzBUYnIwYllxczJpMWJZL3o0L1FXWU9v?=
 =?utf-8?B?Vi9HcjJIRm1zNzBLZWtpSk81djBqZHBqMXVUM1g2OWNSSEplUG13TkVKQ2Yv?=
 =?utf-8?B?WmhHYTIrZ1JzY21wMXFBRHUxWmhwWVBxc3ZONURJYXMrS0E2Y3FGMFF4SDVy?=
 =?utf-8?B?VXl1emhvUTFlWTFkeDZndHJ6ckh1VFFYL1hJTHFzTFpjQXkzM3kvZFo2Mkpv?=
 =?utf-8?B?M3c0ZXdsQnppaWhuUjI0WHJwQ1RhVXRpZDV5SjJlZDZ2UFVNUkh5N2VHcWNZ?=
 =?utf-8?B?bWpURWlHME83N0Y5b2x6V211cnBmS2dOcjFyWEJLbkhuOC8reFY0bnpaZUYx?=
 =?utf-8?B?VG1kMVJVOVJ5czhuOE9NQnlPMkhHYmV3L0NIcUJ2RzN5eUM4c0c0UjFoUTQr?=
 =?utf-8?B?VHJPQk1hSjcxYWdBS0xmbEdVeDZGUzk3K1V5aG85dHFFdTRTL1RJNXUrY1Jk?=
 =?utf-8?B?VGlNYnNqeHBwSEpBVTdKL1BtVGVJODFWY1Z4TFN4c0cvVzgzZ01jRm9WaEE0?=
 =?utf-8?B?ME16SFBwVFhKTUZHanMwSDZMR1hOU2tKWW5YTjFtcWFBbFF3aHV0NVJwQk5v?=
 =?utf-8?B?NEtGVEdhMXZUb2l5TG1seERKd05vQUc0TklnWE8waUUzOXBlcTVtVVZHeVNF?=
 =?utf-8?B?Mlh6WEVSREhWZUFzRUNLK1ZnY0ptTVgzRXp2ekZvUmxkdERaQk1UVGJ0ck9r?=
 =?utf-8?B?OUl2VUFaUFN3TXhuaU9JakRiL3RibXdMVFFXeXkxbUJvOHRuUVJQdGtMWDh1?=
 =?utf-8?Q?djJF95Ep6Fs3fdHPvWh/J7riX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7119C6E49FCE948ABEF8DEE82344D69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6421a8e5-1f53-4f70-5a22-08da7c3a0762
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 08:09:49.9867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsRI3LN2/HXcRlDPLLuDM6GPw6WptOZSKEv4fxgPcdsD7AUoI4kPsRpuAut8OAPagUiN2AME/ibWD6asB41oPkIGT5xEL6r2pvWy5grIg0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1901
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTIvMDgvMjAyMiAwOTowMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMi8wOC8yMDIyIDEwOjM1LCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gT24gMTEvMDgvMjAyMiAyMzozMywgQ29ub3Ig
RG9vbGV5IHdyb3RlOg0KPj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+Pj4NCj4+PiBVcGdyYWRpbmcgZHQtc2NoZW1hIHRvIHYyMDIyLjA4IHJldmVh
bHMgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzIGlzc3Vlcw0KPj4+IHRoYXQgd2VyZSBub3QgcHJldmlv
dXNseSB2aXNpYmxlLCBzdWNoIGFzIHRoZSBtaXNzaW5nIGNsb2NrcyBhbmQNCj4+PiBjbG9jay1u
YW1lcyBwcm9wZXJ0aWVzIGZvciBQb2xhckZpcmUgU29DJ3MgUENJIGNvbnRyb2xsZXI6DQo+IA0K
PiBJIGRvbid0IHRoaW5rIHRoaXMgcGFydCBvZiBzZW50ZW5jZSBpcyB3b3J0aCBzdGF5aW5nIGlu
IEdpdC4gVGhlIHNjaGVtYQ0KPiBpcyByZWxlYXNlZCBzbyBvYnZpb3VzbHkgZXZlcnlvbmUgc2hv
dWxkIHVwZ3JhZGUuIEluIHR3byB5ZWFycyB3aWxsIGl0DQo+IG1hdHRlciB3aGljaCB2ZXJzaW9u
IGJyb3VnaHQgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzIHRvIGEgZW5mb3JjZWQgc3RhdGU/DQoNCkkg
aGF2ZSBubyBzdHJvbmcgZmVlbGluZ3MgOikNCkknbGwgcHV0IGl0IHVuZGVyIHRoZSAtLS0gaW4g
dGhlIG5leHQgdmVyc2lvbiBhcyBJIHRoaW5rIGl0IGhhcyB2YWx1ZQ0KZm9yIHBlb3BsZSByZWFk
aW5nIHRoZSBwYXRjaGVzIHNpbmNlIGl0J3MgZmFpcmx5IGxpa2VseSB0aGV5IHdvbid0IHNlZQ0K
dGhlIGVycm9ycy4NCg0KDQo=
