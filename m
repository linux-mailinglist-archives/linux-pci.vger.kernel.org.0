Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6F5AB6EC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiIBQyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiIBQyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 12:54:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE1B10A607;
        Fri,  2 Sep 2022 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662137658; x=1693673658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s0qgJowurzjwW/4luTZ81mFVcfdf8g9Iq6xDDXJ2Vv4=;
  b=YdBnIf2CsrUxmF/4ru1sOUL+rNA7u8H0/tKrpnDSRJK9Wxf/ZoHweB2K
   Ce6XJkYcbfIHSHZclr0siDC3qsV6nDBkvB3MYZV1gYjsw10QB7DB6AyPW
   xmEsO5n98BZHGZqT0UCCzfBEyK1j9tCD6L2EozkgHDTNy9AxBy5v8VMIC
   cCB9nkEEVw2DH8FLfxNL9WV9e/MqATCQnWZrfW47I8PpMA4zEr9WsxV1X
   GWkt1DSTBGQBaQ9gGe3OJXm0Dnk0isFlsPCLfGL9VAUXA0hQXNzYvyyA4
   JzrUDdGDXL5y0b2b3IKPBruiRqMzvyVJ3l0FJBpa6imdbX00NIxNbUxYx
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178825732"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 09:54:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 09:54:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 2 Sep 2022 09:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5dbilC9J6wYdgxvkasLYev1YVYALP9avbAjWohSBkqxGxUgpCy479TQ0YTK7vTaW7SNNjkhssQelqPFIeJbRlWwkeKoYTMkXPXL+bKKnXjD+ggVzsFDYfYaSpqg+GTTVJvWXvoYNWmnfsYYicZ83FvaOP5LZoJevHatTRMLwLgMyyt7lCk2Pk9IN4hTbbPvAq1ftXwO7D6WKjwwOESQshKZCikdIFnkQjT9ARJVoFtRW8mhUF0IyQE2Trr7k+eYuBPnaLH/7pZuNQx2GclougHB9z1WZ4TAruBLKNFYOC/ObS2g4z9nalxlkVejaZAUlJFFxr2XqBLBsFblHWjEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0qgJowurzjwW/4luTZ81mFVcfdf8g9Iq6xDDXJ2Vv4=;
 b=lUCrR8EsKEzLP4ajjfkXuCheXI2TyygEDN8fa86VPjTe5cA0vaMmKMnoX1kvvpUtF7Js13/m0iNifqHY3r7VBxjUVsD2XxPVO4kRc2WTliyxRBfTxaFReNWFrHBDV1uAWTlMdfBi2l5rT84aVKrneb9iYa9j6qlcWcby93pWW24hiLmd/OKnAOyoiqIrtPQoThWQLO6d//2RGrN0AqxNE6RLfgqNf063eOz8pydwoN8bSrDHwHf6O3dxxrTr+kZocO6eJAQrngq6wk4pMlGoGxIWpdbE+I5TmkrNmSDyCBctB+mTLE8A84Sf6M1Vy8qHuxjJFQ0UCGVxFkgsTOX65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0qgJowurzjwW/4luTZ81mFVcfdf8g9Iq6xDDXJ2Vv4=;
 b=kZPTPubiHFxbBZdLULoOuCF9Wq3QOq8njxYJgkDntO/WbjDNymQVVGSg/HwksbKSQv9zver+pkr3LmWoUaunqYXaX9I0ohOt3cZn8/PjLPXdcOT0ABxU7UytY4+aQgB8xeRhfyUBFzsga7paiSchsVta6OK4x618SFYUaC2q22c=
Received: from DM6PR11MB3258.namprd11.prod.outlook.com (2603:10b6:5:e::27) by
 DM6PR11MB4091.namprd11.prod.outlook.com (2603:10b6:5:197::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.16; Fri, 2 Sep 2022 16:54:08 +0000
Received: from DM6PR11MB3258.namprd11.prod.outlook.com
 ([fe80::c8cf:c82e:e86e:2db6]) by DM6PR11MB3258.namprd11.prod.outlook.com
 ([fe80::c8cf:c82e:e86e:2db6%6]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 16:54:08 +0000
From:   <Daire.McNamara@microchip.com>
To:     <helgaas@kernel.org>
CC:     <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <heinrich.schuchardt@canonical.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>, <lpieralisi@kernel.org>,
        <Cyril.Jean@microchip.com>, <robh+dt@kernel.org>,
        <Padmarao.Begari@microchip.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1 3/4] PCI: microchip: add fabric address translation
 properties
Thread-Topic: [PATCH v1 3/4] PCI: microchip: add fabric address translation
 properties
Thread-Index: AQHYvteiyC8N/dtDyUyl60vya8pnLq3MWjUAgAABVoA=
Date:   Fri, 2 Sep 2022 16:54:08 +0000
Message-ID: <3dfc10ec5e852988c624445ad08cc430451d14fc.camel@microchip.com>
References: <20220902164920.GA349565@bhelgaas>
In-Reply-To: <20220902164920.GA349565@bhelgaas>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fed14f-6f8b-43ea-d92a-08da8d03c0da
x-ms-traffictypediagnostic: DM6PR11MB4091:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pp89vBuEa/JxZ3wJ8VL34VoJsrfnZErJvEJOT+qFdWbSKrP9WKkbsuC6wREr+tt0a0uW9dgVYBsDSlsKZqDa/AlPoWz3svtvTEGkADWlBN+q5LrDvcOpw6VCRrMHRQk6VruF6w5W1ISjTDIursPmQGIjSGYYMrVuii04uAPXhYihmT7caoUBmR1P0e8tG1Txh4s1e6RQIHHzGW8xnODd+JdN+01wsSwCPpG4krGwtu+QzvCM0VeI6wcZFe1tmUzEDm/aWAdFio6g2a6bRhQpD4QtIPfLy/UN9feIRTxFLZkB3LcFtx6TziDTZuXDEdIguHFs4HXolRayNAWnbnGkTe0N1+Dv+yhv87x0ucNWvbTYZxjvhe9c7akdOYpB1nfJL9bmIyHQjGn6ZhcN2iAOidTLli7gTd9eXUTJuCShWGmZElufHhHmfYhA1xSdzxtGNsUrDcHO3EEhlV+jWEe9Fjj/0wOZItltB+mucLAfrOxl+r/NPy6LbKDSKEX1K/SdQe+gTdwLon7sWN3U3nJZMMATUh0DwwBstVjNcpJe1uT7gT626bBSrTp6i2bj5JM5euSYkL3e8/EoY4DhH7RUapJnwZvGlZcswhSnQXNASd5uSJDh+hhdvgoLcEewFs7zatZG3ABvNYvYhqGo7EgslB2NrhybyCjrCszXMDTIK6jSE1RjvTqPQFqf0R6EG8Fh2BFeg5YStbBPZuQclCCeyz/Yum3y2dj9qMb3BYKlQO9baMTReWr1JkYTwGM9/Sk0wXEU+dfOwNVllkPUU6uSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3258.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(136003)(346002)(396003)(64756008)(66476007)(478600001)(91956017)(71200400001)(316002)(8676002)(76116006)(54906003)(6916009)(4326008)(6486002)(66556008)(8936002)(66446008)(38070700005)(5660300002)(7416002)(2906002)(66946007)(86362001)(38100700002)(26005)(41300700001)(6512007)(122000001)(6506007)(2616005)(186003)(36756003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJCQXVWd3hZeUVhUXV6c1VUVllMVU9OVUxLWVh0cDllSnc2V1dwaVVCZVZU?=
 =?utf-8?B?V01NU3ljczFHMW9nOXp0clZqUHRJWmVWUGhtcG5ERmRZQXd2ZTVxaXZ1MzJ2?=
 =?utf-8?B?am9Nci91WXR0TWh5MTVpWE4yb0NlTnBsQm5jMmM4NkNqcTgwQ0luRFY2elU2?=
 =?utf-8?B?eGFRSFRYOVlrVXJCQ0Exb0x0cW5rRlgyZnNVbzZUbzVOR2hEaU96R3F4TS9Y?=
 =?utf-8?B?cVJKNmF2YmRTMktPOCtBaVE4RGRZRHJKVjlEM3Ewc0JWSW5zU1p5eDlHalNp?=
 =?utf-8?B?WDN0bFUrN1cwOGxHNEpUbHVrZlgxeXp6ODlVenAwei9BSU9USmR4N1I5K1A2?=
 =?utf-8?B?dkF2TjF5Zm12VmlkUXRHaHJJR2VFREl4Ynl2TkJRVmRmaWt5WlluUDRMaEtH?=
 =?utf-8?B?UGhsWjR5Zm9Gd05rWDdhV25Ea1ZpQm4yNWZBbklDYXJuMThKaDd1alVXQUx4?=
 =?utf-8?B?L2xJWVF3YWNEaUdneFlZWTRHOE5XMUs1eFNoM0FtU05LWGtZRnhzbVQvRW5u?=
 =?utf-8?B?TFJpNGR3dmltN1BPSmpCVzVVOHJ4NjRnTDdUb2h0TEJSVk0vN3lidnFIQWNr?=
 =?utf-8?B?a3I0WVB3WlZvTzBwQ21xM2dmdGpxcXpmSWErSXR2VldYZzBNWk9PSzlFaVY2?=
 =?utf-8?B?bTN3akx4WS84NnFlaU43RHgwQWswVExUdGtWTEsvSzBVQmIySFV0OXQyRHpl?=
 =?utf-8?B?cWt3RW1sRUZzWkROWUlQNEZ2M1I4UWdlVnZvd0ZjU2dEbmtqS2NzcjI2U01S?=
 =?utf-8?B?OS9ZVHBMQkFoOUgycCtZNzR3bWllNGdzMnFRd0xFR1hOYmx6R3ZwOVV3Qnpx?=
 =?utf-8?B?ems0UWJTRkhLQ2xFTTNkMFNSc01JMWxaeE13bVFGYzFldXlrbStmaFMwb052?=
 =?utf-8?B?RURXWUViNlovWXpZc2ZBbWQ1cTl3L3RTK2d4MWEzWlJqRU5aNDRoaWl3czhu?=
 =?utf-8?B?MEdZQU85NXVpeXRhOXB2R3hydFQvOTRFYWkrVUV4dlhlNjFtL0p2OVZSM2Nr?=
 =?utf-8?B?bGQ4QVViRlRTUHJvQytvUTExMUhBYUJVVmQyUDFqNGlqWmoyR1J6TnQ4U3A5?=
 =?utf-8?B?Y29yQW5UOUwwTGxtRzcrbHBQZlE1OVRweVpmc0lVcklGd1FqQldQZm4yNmps?=
 =?utf-8?B?OGV0UzNnOXNHYVR1VWJJZUcxY2pKaGVoQmZQYTV0MlY2NzZGOGhwbHBwYWxw?=
 =?utf-8?B?Nk03QWc3NklZdnlUUzdhY2VNNG5EVzh5K2Rya3lJMUJ6K09KczBibFM3djJJ?=
 =?utf-8?B?dXRwS2dDZENqbTdrcGwrUUdRTHI2a0RqaU9kbnByaGtRaHFqMXBHR1U5ZWpm?=
 =?utf-8?B?Q3NZcjVHQktxY0tDM1Mzcm4zNzNvbFJlbWFDZUVhOFl4ZDFwZHRyUTZPL1Jo?=
 =?utf-8?B?YldVcVd0SktEZFN6bFVvZmNiajMyN3h1UitGWUEzcitoR3JpOHVjRzdMNG5r?=
 =?utf-8?B?dHJ4QkswNktnalBoODFjVGFBNFJXVUtMRDRNcEJNTVBzeHcrZE56TjNuelRR?=
 =?utf-8?B?U0RBcFRJdUNYMmVtMDQvNEZqcURxUk85UllpQTFJWllLcTZ1ZEVrSmk0aFQ0?=
 =?utf-8?B?T3lxY2dGQ1JRYnBQWVJoUUtJZVVVUitpRjVjMTFXYVRsRlFJZDRGdjE3dGpH?=
 =?utf-8?B?R3BMMktSYUtEUHI2eXc3R0toNkpGdjdaclhHUUxreEdoRzJUU0tjRjVmLzNV?=
 =?utf-8?B?cTA5UmhYRWtlb2l2Q2VSclpFWVlLcmFndVhZUEpHdlJKUW0waTdnUzZLM1Jk?=
 =?utf-8?B?S0N2WmdZdjk3aERWcE50ZXlLdlcvMXQzTVlCMktPRm1YTm1wMm1ZMm4vUVdm?=
 =?utf-8?B?dlRCNFVjdThyK1pwZHpHWlUxZDdQM0E4S0ZtNi9YdStDRHFjTnhRK0R6SmxT?=
 =?utf-8?B?ZDJZSzJzNUpBdnh6bEhMbysxV2RScjRmd2o1Vndka2hjOGNsTmJ6YWJNZlRB?=
 =?utf-8?B?eEtNK1FsVnF6bEFKRXdxbHpTUWhaMUVKWHNreGxjalgyWFRIZ3pJTXVsQmgx?=
 =?utf-8?B?ekhkamNVKzJDWUoyVjdxSEM2VEhPTHRhaFBqbW50eXV1WUY0ZlBmcTNvL0xS?=
 =?utf-8?B?UHlFTFhSam8zayt1am0vSmRpcGFVQ3dISHlpZnhXVjJQNXdDMlNIellqZWc2?=
 =?utf-8?B?TEFVK3JNVHZhY2pQeHA2aXFvbVFCRnUrTGMwekJZeG9kQkNrUjlEOHV3RjlC?=
 =?utf-8?Q?fp36iv3WU9awJ/BtS7hLcMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3285E135D52FB7449129E362B022351F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3258.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fed14f-6f8b-43ea-d92a-08da8d03c0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 16:54:08.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ek02miPf+rLvCYIj1XWrStOPy6CObm61/y9otvKDclyBNQ0xJn4L5x5tKHZZ7oLvzvVvY0nBxLBzT/IzsJkuDhmsSFG92go3/2NQ++lLAtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4091
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhhbmtzIEJqb3JuIGZvciB0aGUgZmVlZGJhY2suICBJJ2xsIGZvbGxvdyB1cCBSb2IncyBzdWdn
ZXN0aW9uIGFuZCBzZWUNCmhvdyBJIGdldCBvbiENCg0KT24gRnJpLCAyMDIyLTA5LTAyIGF0IDEx
OjQ5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwgU2VwIDAyLCAyMDIyIGF0IDAzOjIyOjAxUE0g
KzAxMDAsIA0KPiBkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiA+IEZyb206
IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPiA+IA0KPiA+
IE9uIFBvbGFyRmlyZSBTb0MgYm90aCBpbi0gJiBvdXQtYm91bmQgYWRkcmVzcyB0cmFuc2xhdGlv
bnMgb2NjdXIgaW4NCj4gPiB0d28NCj4gPiBzdGFnZXMuIFRoZSBzcGVjaWZpYyB0cmFuc2xhdGlv
bnMgYXJlIHRpZ2h0bHkgY291cGxlZCB0byB0aGUgRlBHQQ0KPiA+IGRlc2lnbnMgYW5kIHN1cHBs
ZW1lbnQgdGhlIHtkbWEtLH1yYW5nZXMgcHJvcGVydGllcy4gVGhlIGZpcnN0DQo+ID4gc3RhZ2Ug
b2YNCj4gPiB0aGUgdHJhbnNsYXRpb24gaXMgZG9uZSBieSB0aGUgRlBHQSBmYWJyaWMgJiB0aGUg
c2Vjb25kIGJ5IHRoZSByb290DQo+ID4gcG9ydC4NCj4gPiBVc2Ugb3V0Ym91bmQgYWRkcmVzcyB0
cmFuc2xhdGlvbiBpbmZvcm1hdGlvbiBzbyB0aGF0IHRoZQ0KPiA+IHRyYW5zbGF0aW9uDQo+ID4g
dGFibGVzIGluIHRoZSByb290IHBvcnQncyBicmlkZ2UgbGF5ZXIgY2FuIGJlIGNvbmZpZ3VyZWQg
dG8gYWNjb3VudA0KPiA+IGZvcg0KPiA+IGFueSB0cmFuc2xhdGlvbiBkb25lIGJ5IHRoZSBGUEdB
IGZhYnJpYywgZm9yIGV4YW1wbGUsICBvbiBJY2ljbGUNCj4gPiBLaXQNCj4gPiByZWZlcmVuY2Ug
ZGVzaWduLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2U6DQo+IA0KPiAgIC0gTWFrZSB5b3VyIHN1Ympl
Y3QgZm9sbG93IHByZXZpb3VzIGNvbnZlbnRpb24sIGkuZS4sIGF0IGxlYXN0DQo+ICAgICBjYXBp
dGFsaXplICJBZGQiLg0KPiANCj4gICAtIEFkZCBhIGJsYW5rIGxpbmUgYmV0d2VlbiBwYXJhZ3Jh
cGhzLiAgUGF0Y2ggMi80IGFsc28gbGFja3MgdGhpcw0KPiAgICAgYmxhbmsgbGluZS4gIFdpdGhv
dXQgdGhlIHNlcGFyYXRvciwgaXQncyBqdXN0IGNvbmZ1c2luZyBiZWNhdXNlIEkNCj4gICAgIGNh
bid0IHRlbGwgd2hldGhlciBpdCdzIHN1cHBvc2VkIHRvIGJlIGEgc2luZ2xlIHBhcmFncmFwaCB0
aGF0DQo+IHlvdQ0KPiAgICAgZm9yZ290IHRvIHdyYXAgY29ycmVjdGx5LCBvciB0d28gcGFyYWdy
YXBocy4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFt
YXJhQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1taWNyb2NoaXAtaG9zdC5jIHwgNTkNCj4gPiArKysrKysrKysrKysrKysrKy0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1o
b3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5j
DQo+ID4gaW5kZXggNzI2M2QxNzViNWFkLi5kNzg3NDVlYWE0YjQgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KPiA+IEBAIC0yNjks
NiArMjY5LDggQEAgc3RydWN0IG1jX3BjaWUgew0KPiA+ICAgICAgIHN0cnVjdCBpcnFfZG9tYWlu
ICpldmVudF9kb21haW47DQo+ID4gICAgICAgcmF3X3NwaW5sb2NrX3QgbG9jazsNCj4gPiAgICAg
ICBzdHJ1Y3QgbWNfbXNpIG1zaTsNCj4gPiArICAgICB1MzIgbnVtX291dGJvdW5kX3JhbmdlczsN
Cj4gPiArICAgICB1NjQgb3V0Ym91bmRfcmFuZ2VfYWRqdXN0bWVudHNbMzJdOw0KPiA+ICB9Ow0K
PiA+IA0KPiA+ICBzdHJ1Y3QgY2F1c2Ugew0KPiA+IEBAIC05NjQsNiArOTY2LDM3IEBAIHN0YXRp
YyB2b2lkIG1jX3BjaWVfc2V0dXBfd2luZG93KHZvaWQgX19pb21lbQ0KPiA+ICpicmlkZ2VfYmFz
ZV9hZGRyLCB1MzIgaW5kZXgsDQo+ID4gICAgICAgd3JpdGVsKDAsIGJyaWRnZV9iYXNlX2FkZHIg
KyBBVFIwX1BDSUVfV0lOMF9TUkNfQUREUik7DQo+ID4gIH0NCj4gPiANCj4gPiArc3RhdGljIHZv
aWQgbWNfcGNpZV9wYXJzZV9vdXRib3VuZF9yYW5nZV9hZGp1c3RtZW50cyhzdHJ1Y3QNCj4gPiBt
Y19wY2llICpwb3J0LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiANCj4gV3JhcCB0byBmaXQg
aW4gODAgY29sdW1ucyBsaWtlIHRoZSByZXN0IG9mIHRoZSBmaWxlLg0KPiANCj4gPiArew0KPiA+
ICsgICAgIGNvbnN0IF9fYmUzMiAqcmFuZ2U7DQo+ID4gKyAgICAgaW50IHJhbmdlX2xlbiwgbnVt
X3JhbmdlcywgcmFuZ2Vfc2l6ZSwgaTsNCj4gPiArDQo+ID4gKyAgICAgcmFuZ2UgPSBvZl9nZXRf
cHJvcGVydHkobnAsICJtaWNyb2NoaXAsb3V0Ym91bmQtZmFicmljLQ0KPiA+IHRyYW5zbGF0aW9u
LXJhbmdlcyIsICZyYW5nZV9sZW4pOw0KPiA+ICsgICAgIGlmICghcmFuZ2UpDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICAgIG51bV9yYW5nZXMgPSBvZl9uX2FkZHJf
Y2VsbHMobnApOw0KPiA+ICsgICAgIHJhbmdlX3NpemUgPSByYW5nZV9sZW4gLyBzaXplb2YoX19i
ZTMyKSAvIG51bV9yYW5nZXM7DQo+ID4gKw0KPiA+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBudW1f
cmFuZ2VzOyBpKyssIHJhbmdlICs9IHJhbmdlX3NpemUpIHsNCj4gPiArICAgICAgICAgICAgIHU2
NCBwY2llYWRkciA9IG9mX3JlYWRfbnVtYmVyKHJhbmdlICsgMSwgMik7DQo+ID4gKyAgICAgICAg
ICAgICB1NjQgY3B1YWRkciA9IG9mX3JlYWRfbnVtYmVyKHJhbmdlICsgMywgMik7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgcG9ydC0+b3V0Ym91bmRfcmFuZ2VfYWRqdXN0bWVudHNbaV0gPSBj
cHVhZGRyIC0NCj4gPiBwY2llYWRkcjsNCj4gPiArICAgICAgICAgICAgIHBvcnQtPm51bV9vdXRi
b3VuZF9yYW5nZXMrKzsNCj4gPiArICAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bmxpbmUgdTY0IG1jX3BjaWVfYWRqdXN0X2F4aShzdHJ1Y3QgbWNfcGNpZSAqcG9ydCwgaW50DQo+
ID4gaW5kZXgsIHU2NCBheGlfYWRkcikNCj4gDQo+IE5vIG5lZWQgZm9yIHRoaXMgdG8gYmUgaW5s
aW5lOyBpdCdzIG5vdCBhIHBlcmZvcm1hbmNlIHBhdGggc28gdGhlDQo+ICJpbmxpbmUiIGFubm90
YXRpb24gaXMganVzdCBjbHV0dGVyIGFuZCBtYWtlcyB0aGUgbGluZSB0b28gbG9uZy4NCj4gDQo+
ID4gK3sNCj4gPiArICAgICB1NjQgb2Zmc2V0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGlu
ZGV4IDwgcG9ydC0+bnVtX291dGJvdW5kX3JhbmdlcykNCj4gPiArICAgICAgICAgICAgIG9mZnNl
dCA9IHBvcnQtPm91dGJvdW5kX3JhbmdlX2FkanVzdG1lbnRzW2luZGV4XTsNCj4gPiArDQo+ID4g
KyAgICAgcmV0dXJuIGF4aV9hZGRyIC0gb2Zmc2V0Ow0KPiANCj4gICBpZiAoaW5kZXggPCBwb3J0
LT5udW1fb3V0Ym91bmRfcmFuZ2VzKQ0KPiAgICAgcmV0dXJuIGF4aV9hZGRyIC0gcG9ydC0+b3V0
Ym91bmRfcmFuZ2VfYWRqdXN0bWVudHNbaW5kZXhdOw0KPiANCj4gICByZXR1cm4gYXhpX2FkZHI7
DQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IG1jX3BjaWVfc2V0dXBfd2luZG93
cyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgbWNfcGNpZSAqcG9ydCkNCj4gPiAgew0KPiA+IEBAIC05NzEsMTQg
KzEwMDQsMjggQEAgc3RhdGljIGludCBtY19wY2llX3NldHVwX3dpbmRvd3Moc3RydWN0DQo+ID4g
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAgICAgICAgICAgICAgcG9ydC0+YXhpX2Jhc2Vf
YWRkciArIE1DX1BDSUVfQlJJREdFX0FERFI7DQo+ID4gICAgICAgc3RydWN0IHBjaV9ob3N0X2Jy
aWRnZSAqYnJpZGdlID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gICAgICAgc3Ry
dWN0IHJlc291cmNlX2VudHJ5ICplbnRyeTsNCj4gPiArICAgICB1NjQgYXhpX2FkZHI7DQo+ID4g
ICAgICAgdTY0IHBjaV9hZGRyOw0KPiA+IC0gICAgIHUzMiBpbmRleCA9IDE7DQo+ID4gKyAgICAg
dTMyIGluZGV4ID0gMDsNCj4gPiArICAgICB1MzIgbnVtX291dGJvdW5kX3JhbmdlcyA9IDA7DQo+
ID4gKw0KPiA+ICsgICAgIHJlc291cmNlX2xpc3RfZm9yX2VhY2hfZW50cnkoZW50cnksICZicmlk
Z2UtPndpbmRvd3MpIHsNCj4gPiArICAgICAgICAgICAgIGlmIChyZXNvdXJjZV90eXBlKGVudHJ5
LT5yZXMpID09IElPUkVTT1VSQ0VfTUVNIHx8DQo+ID4gcmVzb3VyY2VfdHlwZShlbnRyeS0+cmVz
KSA9PSAwKQ0KPiANCj4gUmV3cmFwLg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgbnVt
X291dGJvdW5kX3JhbmdlcysrOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaWYgKHBv
cnQtPm51bV9vdXRib3VuZF9yYW5nZXMgJiYgcG9ydC0+bnVtX291dGJvdW5kX3JhbmdlcyAhPQ0K
PiA+IG51bV9vdXRib3VuZF9yYW5nZXMpIHsNCj4gDQo+IERpdHRvLg0KPiANCj4gPiArICAgICAg
ICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIk1pc21hdGNoZXMgaW4gb3V0Ym91bmQgcmFuZ2UN
Cj4gPiBhZGp1c3RtZW50XG4iKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiA+ICsgICAgIH0NCj4gPiANCj4gPiAgICAgICByZXNvdXJjZV9saXN0X2Zvcl9lYWNoX2VudHJ5
KGVudHJ5LCAmYnJpZGdlLT53aW5kb3dzKSB7DQo+ID4gLSAgICAgICAgICAgICBpZiAocmVzb3Vy
Y2VfdHlwZShlbnRyeS0+cmVzKSA9PSBJT1JFU09VUkNFX01FTSkgew0KPiA+ICsgICAgICAgICAg
ICAgaWYgKHJlc291cmNlX3R5cGUoZW50cnktPnJlcykgPT0gSU9SRVNPVVJDRV9NRU0gfHwNCj4g
PiByZXNvdXJjZV90eXBlKGVudHJ5LT5yZXMpID09IDApIHsNCj4gDQo+IERpdHRvLg0KPiANCj4g
SSBndWVzcyAicmVzb3VyY2VfdHlwZSgpID09IDAiIG1lYW5zIGNvbmZpZyBzcGFjZT8gIEkgYXNz
dW1lIHRoZXNlDQo+IGVudHJpZXMgY2FtZSBmcm9tIGRldm1fb2ZfcGNpX2dldF9ob3N0X2JyaWRn
ZV9yZXNvdXJjZXMoKT8gIEZyb20NCj4gZ2VuX3BjaV9pbml0KCksIEkgZ3Vlc3MgdGhlcmUncyBh
biBhc3N1bXB0aW9uIHRoYXQgdGhlIHJlc291cmNlIGF0DQo+IGluZGV4IDAgaXMgRUNBTSBzcGFj
ZT8NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGF4aV9hZGRyID0gZW50cnktPnJlcy0+
c3RhcnQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGF4aV9hZGRyID0gbWNfcGNpZV9hZGp1
c3RfYXhpKHBvcnQsIGluZGV4LA0KPiA+IGF4aV9hZGRyKTsNCj4gDQo+IEhvdyBkb2VzIHRoaXMg
YWRkcmVzcyBhZGp1c3RtZW50IHdvcmsgZ2l2ZW4gdGhhdA0KPiBwY2lfaG9zdF9jb21tb25fcHJv
YmUoKSBoYXMgYWxyZWFkeSBjYWxsZWQgZ2VuX3BjaV9pbml0KCkgdG8gbWFwIHRoZQ0KPiBjb25m
aWcgc3BhY2U/DQo+IA0KPiBIb3BlZnVsbHkgeW91IGNhbiB1c2UgUm9iJ3Mgc3VnZ2VzdGlvbiB0
byBqdXN0IHVzZSB0d28gbGV2ZWxzIG9mDQo+IHJhbmdlcyBpbnN0ZWFkLg0KPiANCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgcGNpX2FkZHIgPSBlbnRyeS0+cmVzLT5zdGFydCAtIGVudHJ5LT5v
ZmZzZXQ7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG1jX3BjaWVfc2V0dXBfd2luZG93KGJy
aWRnZV9iYXNlX2FkZHIsIGluZGV4LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlbnRyeS0+cmVzLT5zdGFydCwNCj4gPiBwY2lfYWRkciwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXhpX2FkZHIsIHBjaV9hZGRy
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXNvdXJj
ZV9zaXplKGVudHJ5LQ0KPiA+ID5yZXMpKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgaW5k
ZXgrKzsNCj4gPiAgICAgICAgICAgICAgIH0NCj4gPiBAQCAtMTAwNSw2ICsxMDUyLDggQEAgc3Rh
dGljIGludCBtY19wbGF0Zm9ybV9pbml0KHN0cnVjdA0KPiA+IHBjaV9jb25maWdfd2luZG93ICpj
ZmcpDQo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiAgICAgICBwb3J0LT5k
ZXYgPSBkZXY7DQo+ID4gDQo+ID4gKyAgICAgbWNfcGNpZV9wYXJzZV9vdXRib3VuZF9yYW5nZV9h
ZGp1c3RtZW50cyhwb3J0LCBkZXYtPm9mX25vZGUpOw0KPiA+ICsNCj4gPiAgICAgICByZXQgPSBt
Y19wY2llX2luaXRfY2xrcyhkZXYpOw0KPiA+ICAgICAgIGlmIChyZXQpIHsNCj4gPiAgICAgICAg
ICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBjbG9jayByZXNvdXJjZXMsIGVycm9y
DQo+ID4gJWRcbiIsIHJldCk7DQo+ID4gQEAgLTEwOTksMTAgKzExNDgsNiBAQCBzdGF0aWMgaW50
IG1jX3BsYXRmb3JtX2luaXQoc3RydWN0DQo+ID4gcGNpX2NvbmZpZ193aW5kb3cgKmNmZykNCj4g
PiAgICAgICB3cml0ZWxfcmVsYXhlZCgwLCBicmlkZ2VfYmFzZV9hZGRyICsgSU1BU0tfSE9TVCk7
DQo+ID4gICAgICAgd3JpdGVsX3JlbGF4ZWQoR0VOTUFTSygzMSwgMCksIGJyaWRnZV9iYXNlX2Fk
ZHIgKw0KPiA+IElTVEFUVVNfSE9TVCk7DQo+ID4gDQo+ID4gLSAgICAgLyogQ29uZmlndXJlIEFk
ZHJlc3MgVHJhbnNsYXRpb24gVGFibGUgMCBmb3IgUENJZSBjb25maWcNCj4gPiBzcGFjZSAqLw0K
PiA+IC0gICAgIG1jX3BjaWVfc2V0dXBfd2luZG93KGJyaWRnZV9iYXNlX2FkZHIsIDAsIGNmZy0+
cmVzLnN0YXJ0ICYNCj4gPiAweGZmZmZmZmZmLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgIGNmZy0+cmVzLnN0YXJ0LCByZXNvdXJjZV9zaXplKCZjZmctDQo+ID4gPnJlcykpOw0KPiA+
IC0NCj4gPiAgICAgICByZXR1cm4gbWNfcGNpZV9zZXR1cF93aW5kb3dzKHBkZXYsIHBvcnQpOw0K
PiA+ICB9DQo+IA0KPiBOb3Qgc3BlY2lmaWNhbGx5IHJlbGF0ZWQgdG8gKnRoaXMqIHBhdGNoLCBi
dXQgbWljcm9jaGlwIHVzZXMgdGhlDQo+IHBjaV9lY2FtX29wcy5pbml0KCkgbWV0aG9kIHRvIGRv
IGEgd2hvbGUgYnVuY2ggb2YgaW5pdCBjb21wbGV0ZWx5DQo+IHVucmVsYXRlZCB0byBFQ0FNLCB3
aGljaCBtYWtlcyB0aGluZ3MgcmVhbGx5IGhhcmQgdG8gZm9sbG93Lg0KPiANCj4gSXQgd291bGQg
YmUgbW9yZSByZWFkYWJsZSB0byBoYXZlIGFuIG1jX3BjaWVfcHJvYmUoKSB0aGF0IGRvZXMgdGhl
DQo+IG1jLXNwZWNpZmljIGluaXRpYWxpemF0aW9uIGFuZCBjYWxscyBwY2lfaG9zdF9jb21tb25f
cHJvYmUoKSB0byBkbw0KPiB0aGUNCj4gZ2VuZXJpYyBzdHVmZi4gIFRoaXMgaXMgd2hhdCBhcHBs
ZV9wY2llX3Byb2JlKCkgZG9lcy4NCj4gDQo+IEJqb3JuDQo=
