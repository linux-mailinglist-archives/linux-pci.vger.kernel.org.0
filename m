Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9156A50E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiGGOHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiGGOHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 10:07:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354A2A717;
        Thu,  7 Jul 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657202838; x=1688738838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R0/7Mug7kA4piQO5K6IzN6CnfN7w7Qy7TYc2Dli8N/4=;
  b=FwwGuIWfn134c7d/wtZX0m0YxxSzNSi3dSGtuaN8I8vAGOGM7PCjh/S8
   x3S/+5Si2LvRN0kglvkTxAIaz7X9FXQZ+g+XcbSj7sn40Mbjv7QBTf3br
   nBetuK+3pDWhNEV/0R/CM0SUM4X5HM+yEoF3aCft+xO2+JLqogEdV+taP
   t12nx/FSGC+uo/6RhQecWl+6/Ar1FdvwVt8cBCfjgdcGHMNuSULyaR59S
   BgUDUtx1y7Mw90dHKK/BNoiUAcjLAjU8H02LP7cNjhX++LXCH4z1XUNSE
   Sqz9xVliRGzt4ydm14n4/l2ImIUu/FgKUY3UOBLGS1dVmCghCJPIhC1Z+
   w==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="163765011"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 07:07:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 07:07:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Jul 2022 07:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/ZEb267Va+VEXiLxiX0voUXXUbZ64ZFYMUjREEW46dRKMg3pgXENjZyeDznURd2i1y7nacFRPgGy22cnS4DKlGtl86vXP83goHiZApmEVIqKFszji9fUyIIR3/8jqAQvVbEkp4q7wE78yepMSIMOdvwvcvZN3yIlNcWH79p3EpPa9w72y04bkf2OZ3FQ2Hkwj/6Ie6x6CbzTRu2T14bLWNA/5dSswQ/rnVZb6aQLl0rBU/gXgKmNA552/zP5z5CoEUA6f9RXS3MYQUnXd32LKwMYcF7rILw9O0/5eo1vud6W5JG2VIbmU2VC9OYwHQ31omn9cbXb73MmfXdhyPo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0/7Mug7kA4piQO5K6IzN6CnfN7w7Qy7TYc2Dli8N/4=;
 b=jAxVJmGwnNigb5fxd+vOPFbnAB4RPhBTGacD5xtajznHLco8WcpEfWNikraI6SA4DOy0sanri8/vU/AeM+Xy3YNTf4rYiltwCj/8TORkXFGLMLL99by4Xc9xsOQJY0wniY0snAWoQDquo7UX8vrP7kVV0CyN4XibX40ISH42oOBGicQ1Wu23D/0xoIj0rm/57jkjyns3ugeRa+8saJ5rjECgen02rFeiCRxORXb0riqgJG36BKGH3Kb94dXU7zpI+vVJBbyzsZxhUuBduJh4paQOftFKVAsKTsqUwjG9ZWKgTm4cjGP+Gu+X28wxoooEmPsxDii3RVHVcGMuGeus/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0/7Mug7kA4piQO5K6IzN6CnfN7w7Qy7TYc2Dli8N/4=;
 b=qsSNbQo5tW8AB6AsIMptNmzE3TOltWfxiHdGDkvst6+X82/UuS/JOjlCjN/h6eo7y2ftS3+uC68VFjj8xao8eHF+wpG+EXjyqMjfsEuivrFlr1vwZelSMfJf99VV3M48+1YecLOZXYEJhz1BjeYR5JD13rDNZ9J770FpIzWyazc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 14:07:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:07:06 +0000
From:   <Conor.Dooley@microchip.com>
To:     <arnd@arndb.de>
CC:     <palmer@rivosinc.com>, <palmer@dabbelt.com>,
        <Cyril.Jean@microchip.com>, <Daire.McNamara@microchip.com>,
        <Lewis.Hanly@microchip.com>, <aou@eecs.berkeley.edu>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <kw@linux.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <lorenzo.pieralisi@arm.com>,
        <mturquette@baylibre.com>, <paul.walmsley@sifive.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <sboyd@kernel.org>,
        <wsa@kernel.org>
Subject: Re: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Topic: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Index: AQHYhou4Yct9CdBHxU6rAH/n3LO9DK1y/l2AgAACAACAAAg/gA==
Date:   Thu, 7 Jul 2022 14:07:06 +0000
Message-ID: <75d066e0-ea6a-8389-f36f-92688a32b525@microchip.com>
References: <20220622225822.2166305-1-mail@conchuod.ie>
 <a39bad24-d2bb-ef3e-d57a-2ac4fa1156ef@microchip.com>
 <CAK8P3a04WLx4Me_=hm9v+Kpq31i3ZCDfPiDhT64RyE_pZZPDVg@mail.gmail.com>
In-Reply-To: <CAK8P3a04WLx4Me_=hm9v+Kpq31i3ZCDfPiDhT64RyE_pZZPDVg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f097ec90-6fe6-410c-fcd7-08da6021f9cf
x-ms-traffictypediagnostic: MN2PR11MB4760:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exo5pWdeb9fu7R348rRgLq/GRQFgbL4J4uygwf36ffMTZQFXCPDvLz4YVDpHRjfpQNYXtwlHJJ0MJQ1WXCXbxHnh0FxvSouDRescQaqed3FG/BmZU00XQ6IPWV1mT79WbV63+3uU8bSsWRaGgraQBSY/ToGRbhtI0IWbEfrbo89koUgTx3GnbalNR8kOXBlLKgE6VZ9v4PTRFaDBYpXz3d0bgl6Ad+kfGizIor0aRrTf0yd5Do1uKnCmc0sgGOe6fy+yrgkrnWqObylq9vW7Sd6Bj24+Y4ykg6e4hmyZ/QVUEDS1vxBYqmrO5X4NBbmX4cwF+2F7d8MqLaGgHhAcvvnVRUkrtdtuc+8hm2tKzhfvXK9suKNsaFCJSJTYssUFQihCxB2UJLaUR4K/cElUIFk0EgFeRct+7HPcGoItQDmg8hlMWClZRUvZzDtOJlA3gkjP8vq0kMvg7juQPd+mnEBBLydvPQCl5vfKW9HWZnpthujoZTDALSJtT05jV70uUmVMQETaaLBB9lvvnnwBtBzS5YFOTL6Ns2VAR6fNOl6GgQ4kfXIjQOYTJoajW6lt1ePMvJZ8PXF4ELolE1K8AwOuwsv50qppAe1/ijvsGHOUMxfj6LXyXgub7BDZE1eUkJqI6NPjwu+0UlPWaUPa0us6JQzZ0BQVVdNFlKspm9z94pcOHOq+gWLFmwphKnnvg3oqjlEtm/2KLU03vulr1LTKp+Ds6ZZANwn59BIPJm/C8h1RuwUOw93IQw21vccfX6Wh2XxDvf84kVkxiVcHIrBgPZiPqJ4o1a2lTpV+LD5nsRhli2/KD6dlLduedNJTTxFxzLeiOBZPWy2sV1DC8ftJ79ygI4CS0bm5eZeJZjTRneGkO2gd9dY3ozzoTnKX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(6916009)(31686004)(54906003)(186003)(66446008)(64756008)(76116006)(71200400001)(8936002)(66556008)(478600001)(8676002)(91956017)(66476007)(66946007)(2616005)(26005)(6512007)(4326008)(6506007)(83380400001)(53546011)(36756003)(38070700005)(38100700002)(86362001)(2906002)(7416002)(41300700001)(122000001)(316002)(31696002)(6486002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dQZHhWTnFmOGNvWG14SmtZRzN0Q3Q0Q2tLTlkvTzZOajVmWHpnRlNsU2xY?=
 =?utf-8?B?SnR1OEh3cXJmWXJkenJsZGJ5S2hETVF2TDVoQ0t0V3ZRZ1pMcm9hWGtNWFdW?=
 =?utf-8?B?MlZ0U1NuVUl3Z3JwZ1BiOVFNNTcyTlR5M2dNU1A0QmdwUW82T21aVkFJSlVy?=
 =?utf-8?B?aTlyZVVSbEwwM0o4dXhYNjBzRkg5eW9HcnlsTXlUUHRLMzJWYU83TGZpL0tR?=
 =?utf-8?B?MVgrZE5IcTlSR2RyVEQxdDFvai93SVhoQURESFgvWUVqdVdwZS82SkVCaElx?=
 =?utf-8?B?ci84RjZQMFdHRW41S3RhL0ViaUJ4clg3WHJrOEpPVHNyR3BxS2RBVzFHTDN1?=
 =?utf-8?B?a1hxTDBkMnp0ZlFBWTAwSjhyUTA3N2ZHbTVUVlpJUGJyTFV0c2VBeFhVdjYy?=
 =?utf-8?B?M3A1T2FzRysxY2E4V2FFTzJoRnQzVUV3UjN2TERuMGNzeXdabTM2RFpzaTlp?=
 =?utf-8?B?THkrQW1HZ2VLRXd0dGJLQkdjL1B2QXlSdEc1Qy9Nc3YyWkYwQU5SMCtzcGpR?=
 =?utf-8?B?M3crWWFhMWlmazFGb0wveXRtenNIcHQ2UVUrVFZURWVhaUhvRFpmM3VBblpi?=
 =?utf-8?B?RFpnMG9lenNSYjZ3bWg2OEpqbW1kN0VlcDZwVVJQT2szbGJkMThqdHJCSVBu?=
 =?utf-8?B?Mm81djNIVE1Mdmg5L29peWg5OFpPQ3N5THVLUDR2alFaczlQTWFpUWdGTW1C?=
 =?utf-8?B?VXBIaGVnaUtObTFYR0xzZ2RFazRkYTRQZFFDRkdjWlFWemdkYlBCM1NNaWtY?=
 =?utf-8?B?UUhqU2xZZG1XazExWlNJVlptSk1KM1RQTmRodERxV1Y2c0VtYkljKzVteU40?=
 =?utf-8?B?Ni91NU95c0xJUEJySEZMZHVUZGNHdEVuejFpNWZNU1Q4QTQwZmtjWEh6dFl0?=
 =?utf-8?B?N2hveEFvRDFtaFZUb0hyZjk4dUg3LzVWWWRheTRaeVozR0hwKzZyOEJvZVY0?=
 =?utf-8?B?VmJQZHVYL3ZMd0ZUMW02bVdocjZlMzBqY29iRzR4UVZkdGdBb2tYalNXWGhF?=
 =?utf-8?B?RHJJNVVaVXA4M0xmT3pWeEpzeG41TUJ6YWYydVNQM3pqbHc0aTVOZEk2Q3d4?=
 =?utf-8?B?T3pCY010ODRhdHZ2RG5yT2dGZys3Y0JQdGNsYkdNSG5ybWhYSzR0bG56OEdL?=
 =?utf-8?B?Y280dkE0UGtLcGMyRk10ckFHZnp2V0RMUUVrQ0IyRmxoOUZ2Sy9SUGl4NGxl?=
 =?utf-8?B?SUVrdjUyV2xWdmtiUzV0V0pwN29BbWd0eUdraXRjQjVoRHhDcFF5VUpOaVZl?=
 =?utf-8?B?U3dndW5VRldXdFZFSGc2T2ZqZmNQTmtYWlY2QlRkWmRhc0xpR1QrK0ZhTXpV?=
 =?utf-8?B?ekJ6Wmp6VEV0RE1YM01CckhETE96eStKWkpHcUJkR0VZZ1ZuMVVla0xZUWVW?=
 =?utf-8?B?NGJkV3FNcjJxNGJQaU0rcWlyUFFESUVpbVE3c1NKMW9PTk5ZNEZNQ3pCcWRY?=
 =?utf-8?B?aGxNQU8wcGpSZmZQQVo2SWRMenp0Wkk5WmdpeUI3UkpYZlM5NldBU0VJdVIx?=
 =?utf-8?B?bzVLNHplR3lnYitGZG9VL3Q2YXkzR2V2SzdBVHFMdHI4S1k0TGdDMzhrazZ0?=
 =?utf-8?B?eFU3bHc1RFgxaHV0bnBhZllIQ3hoWUV0bTJKWHVxbzZmN2tzckhxVS94eWJQ?=
 =?utf-8?B?QU9kSjZERVppS28vK3AxZWdXbGs3TFVwSmdHM2taVzV4YkkwdXVIK1dmZ3J1?=
 =?utf-8?B?cGZLQ05yV1k1ZVlFSEUyekdESFpmeE0rZy9BdjFPRVp1TkIzMkh4djFBL2NI?=
 =?utf-8?B?Yzk5aTZCbldwMVhLeXNwYlZTN0ZnZFhGQnUyUUIzeUtmc1JSSzh3ZnV3MXZ5?=
 =?utf-8?B?UmU2R2NReUJDZ2ZMT2FkdURYV0ErdmxxSVFZWnZBVk1kOG5UM3o0Q2thdGVV?=
 =?utf-8?B?aXRXcVNycXgvcmtGTFo1djBvcFp0RmZycUpHT2QxVTdXcHJaZGtjWERRU0tH?=
 =?utf-8?B?QnlDQ08rN3BNY1RqTmNrcVB6L2FjMVVYUEErNHpVTEp5cG82NkQ5Q3JLazV4?=
 =?utf-8?B?TXhlMXFGSDhLdGc1ZnlydnFoQ2RRWENtV2tPeTlveHBITzlJNUNSc1JZbFdp?=
 =?utf-8?B?alZ0SVVrOVpHQ0p0akdCUyt0bEZ4bGdHZXVsZEMvRTZrTXhITzVvVmpqa1Er?=
 =?utf-8?Q?U9QDL8le4M3G8RRvAR0Nc4FlW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3FB7BC9E756CC4F85793B61E840D20D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f097ec90-6fe6-410c-fcd7-08da6021f9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 14:07:06.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYubmV3aaKJC9ioNieKM8Bc5oCDqyGdMfYhEBA3sKdJIOcfigA32FD7VIAPDxkt3iuQtVMRDh4DO3SRCGmeAEVhvhmyCnvyA6aFwR1Co0T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMDcvMDcvMjAyMiAxNDozNywgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEp1bCA3LCAyMDIyIGF0IDM6MzAg
UE0gPENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAyMi8wNi8y
MDIyIDIzOjU4LCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+Pg0KPj4+IEhhcmR3YXJlIHJhbmRvbSwgUENJ
IGFuZCBjbG9jayBkcml2ZXJzIGZvciB0aGUgUG9sYXJGaXJlIFNvQyBoYXZlIGJlZW4NCj4+PiB1
cHN0cmVhbWVkIGJ1dCBhcmUgbm90IGNvdmVyZWQgYnkgdGhlIE1BSU5UQUlORVJTIGVudHJ5LCBz
byBhZGQgdGhlbS4NCj4+PiBEYWlyZSBpcyB0aGUgYXV0aG9yIG9mIHRoZSBjbG9jayAmIFBDSSBk
cml2ZXJzLCBzbyBhZGQgaGltIGFzIGENCj4+PiBtYWludGFpbmVyIGluIHBsYWNlIG9mIExld2lz
Lg0KPj4+DQo+Pj4gQWNrZWQtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
DQo+Pj4gQWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4N
Cj4+IEFybmQsIFBhbG1lcjoNCj4+IERvZXMgdGhlIFNvQyB0cmVlIG1ha2UgbW9yZSBzZW5zZSBm
b3IgdGhpcyBwYXRjaD8NCj4+IEkgYW0gbWlzc2luZyBhbiBhY2sgZnJvbSBIZXJiZXJ0IChidXQg
SSBkb24ndCB0aGluayB0aGF0J3MgYmxvY2tpbmcNCj4+IGZvciBhIE1BSU5UQUlORVJTIHVwZGF0
ZSB0byBteSBvd24gZW50cnk/KS4NCj4+DQo+PiBJZiBTb0MgaXMgdGhlIGJldHRlciBvcHRpb24s
IHNob3VsZCBJIHJlc2VuZCB0aGlzIHRvIHNvY0BrZXJuZWwub3JnPw0KPj4gVW5mb3J0dW5hdGVs
eSwgc2luY2UgSSBvcmlnaW5hbGx5IHNlbnQgdGhpcyBwYXRjaCB0aGVyZSBoYXZlIGJlZW4NCj4+
IG90aGVyIGNoYW5nZXMgdG8gdGhpcyBlbnRyeSB0aGF0IHdpbGwgY29uZmxpY3QgaW4gLW5leHQg
KGFsbCBhcmUNCj4+IGFkZGl0aW9ucyBzbyBlYXNpbHkgcmVzb2x2ZWQuLi4pLg0KPj4NCj4+IEkg
d2FzIGhvcGluZyB0byBnZXQgdGhpcyBwYXRjaCBhcHBsaWVkIHRvIHY1LjE5LXJjKGZvbykgc2lu
Y2Ugd2UNCj4+IG5ldmVyIGFkZGVkIG1haW50YWluZXJzIGVudHJpZXMgZm9yIHRoZXNlIGRyaXZl
cnMgcmF0aGVyIHRoYW4gd2FpdA0KPj4gZm9yIHY1LjIwLg0KPj4NCj4+IElmIHlvdSAocGx1cmFs
KSB3b3VsZCByYXRoZXIgd2FpdCBmb3IgdjUuMjAsIEkgY2FuIHJlc3VibWl0IHRoaXMgcGF0Y2gN
Cj4+IGFmdGVyIHY1LjIwLW13MSB3aXRoIGFuIGFkZGl0aW9uYWwgaTJjIGVudHJ5IChpZiB0aGUg
ZHJpdmVyIGlzIGFwcGxpZWQpDQo+PiB0aGF0IGFscmVhZHkgaGFzIGFuIGFjayBmcm9tIFdvbGZy
YW0uDQo+IA0KPiBJIHRlbmQgdG8gdGFrZSBNQUlOVEFJTkVSUyB1cGRhdGVzIGFzIGJ1Z2ZpeGVz
IGluIHRoZSBzb2MgdHJlDQo+IChmb3IgNS4xOSksIGFuZCBJIGNhbiBwaWNrIGl0IHVwIGlmIHlv
dSBzZW5kIGl0IHRvIHNvY0BrZXJuZWwub3JnLg0KDQpDb29sLCBJIHdpbGwgcmVzZW5kIHRvIHNv
Y0BrZXJuZWwub3JnLg0KDQo+IA0KPiBUaGVyZSBzaG91bGQgbmV2ZXIgYmUgYSBuZWVkIHRvIHdh
aXQgZm9yIHRoZSBtZXJnZSB3aW5kb3cNCj4gd2l0aCB0aGVzZSB1cGRhdGVzLCBpdCdzIGVpdGhl
ciBhIGJ1Z2ZpeCAoZm9yIDUuMTkpIG9yIGZvciB0aGUgY3VycmVudA0KPiAtbmV4dCBjeWNsZSAo
NS4yMCkuDQoNCkkgd2FzIGp1c3Qgc3VnZ2VzdGluZyB0aGF0IHRvIGF2b2lkIGNvbmZsaWN0cyBp
biBsaW51eC1uZXh0DQpidXQgdGhleSB3aWxsL2NhbiBiZSB0cml2aWFsbHkgcmVzb2x2ZWQuDQoN
ClRoYW5rcyBBcm5kLg0KQ29ub3IuDQoNCg==
