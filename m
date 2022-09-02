Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9D5AB4A0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 17:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiIBPC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiIBPCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 11:02:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A5E24BC6;
        Fri,  2 Sep 2022 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662129100; x=1693665100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rofv0LaST8OOKezxdgWCQYC1yOH82FpL6YI2POxrFX0=;
  b=W/+30aZIfKgOWgeHLNuC4TdqsDWYpoF3zDQiu0C+i6MM5KG+x+XXSpaS
   EJASrNstPQ/3J8ugaPiHI3xuZEI0MXEk+Rdu95QD/JnVUjzsZUXZRAzeh
   W8lxjMoFztSilDopX8Ek7jwPr3vLvMjXZ1uiY4EQ2gG5aIANGcRRrNIvV
   oe4No7fntqMVNZYQS7JuVxrqL3UQr8gca2hOUNGAxCEyD+Yw/C4u0mOML
   BjuAR9CJm+RKDbn+50NRVUDLu046NAnmAz20matopR4ixMj5UpED4hxsp
   yXe8L/GKiYtehRadr5KEbITb/PDpW+YJdIR1jMA9FmTuhVgNU2Cxx5//y
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178943331"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 07:29:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 07:29:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 2 Sep 2022 07:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SetbUhtWMI3q0HcnNezatXZnAs67DA5N2oN0Hgp1stD3fa2r6dHrfFZfVl7u0wFCbjKjo75wej8bOhIxATPjcWwAvwQydqVVlw6W+n4zK43IBLxbTvXwG1X68vQez+0wZ8HopccBEkgNReusJ0y301bfCFgN0olohNMXrL7r9S8Ovdpmokw+TC/kIbOWt9nV1MxzpQ3uUGFQrcC8TGQ1KMKku0sYFDbdPao6P6xqIdVxg0rBTNEl9Wj5LKJWLEimr8QF3wc53e1HnAjAfq9hLHr7nEyUzYnnwLc3+O3+TDfKFCfmesahTN9AnziJ5Th6y3uCEGjJoftEbJflGRpElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rofv0LaST8OOKezxdgWCQYC1yOH82FpL6YI2POxrFX0=;
 b=hJMbx5YtBtNevy/fLsDI/aJf5kNugk3wYa8PAhfqdqOXUTn1FumRUYVkUPuVzNOXeuYoSXYkPscmeVPM99ahsHB97MJHcE0skhEzI08/4U2AkeQbPOemxC+fJ7E6w6/DCPu0jlKjKTCLXj87DS1VNvE29fbHm6YNx5OtyAW1cRNx7xw4bLAx1bY2UQxdaefLIHfemoH8O3avIMt+2J0a05UyJt4xd2tBFoTIi5wuJOb76SzZiqcPld/ytvRwvbZhgoTGtBdUJwlBYNpAbGmSkSSAboOeGP1zWssGGGTp5S1kwqMPDS+lcFfCipgkdTDST3pd/NT8fyFQtAFVXrvxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rofv0LaST8OOKezxdgWCQYC1yOH82FpL6YI2POxrFX0=;
 b=OrNxuVVdk2/1Sk5GR56jl5QAmb6hioRziMIjKmpmurTMZo1/SntsNJJ+3wXGAeYBSD2yo4bhRKqeuuqUgu0jMLns5gtU5MoIOObp09r6fBTUkP4NeoX09KzB/I8J0qlj6IA897INXfJ5bXsFweq5UirvmP4EY0ym8RVXBjhD27o=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL3PR11MB5681.namprd11.prod.outlook.com (2603:10b6:208:33c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 14:29:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.016; Fri, 2 Sep 2022
 14:29:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Daire.McNamara@microchip.com>, <aou@eecs.berkeley.edu>,
        <bhelgaas@google.com>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <lpieralisi@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <Cyril.Jean@microchip.com>, <Padmarao.Begari@microchip.com>,
        <heinrich.schuchardt@canonical.com>,
        <david.abdurachmanov@gmail.com>
Subject: Re: [PATCH v1 2/4] riscv: dts: microchip: add fabric address
 translation properties
Thread-Topic: [PATCH v1 2/4] riscv: dts: microchip: add fabric address
 translation properties
Thread-Index: AQHYvteEdsTpG+fnqUSHltZhu7SeFK3MMwIA
Date:   Fri, 2 Sep 2022 14:29:20 +0000
Message-ID: <26e3a8af-7eca-e571-de13-915fdfd77b2a@microchip.com>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
 <20220902142202.2437658-3-daire.mcnamara@microchip.com>
In-Reply-To: <20220902142202.2437658-3-daire.mcnamara@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5628489-ee3a-408c-79bc-08da8cef8624
x-ms-traffictypediagnostic: BL3PR11MB5681:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 268nct21ofVV2jDVQOLdrIfq/UHX/9bUmAG5CojgNkWDxhcoeWztHPP+SE7iMYjZjXBSFHHa1wkmyaixPze7ntSmx+EGK14dnpOMKDRQGByHzZJ8aKMhY5UIqJuJH7Kg8rmV7IuPdgv9W4xXKpEuJdAX/YhCEfKX32gpJIJmjIIyagqt268lcn0Ic1WdcTvSSQ8hR7RyZSYe4JLVxHZgcpT+VKq9KNppNOfSYYOO3jkWQQSciyE/yxoKyTr9jdx2+6ozsYTIxU+aCUN32zUyikYnEkj/1Tz7jdfptYt0gQahw7UfVprGkUAhCu7TA0zUexVnWySVCxLAS1+Z6VcgQVUD/LP2h88xKSnxnhV6FwMExsTXBvqV9aL9syy2A8dJWiWETQePYx//+ha9yZnq/APFhMCPWDc1Q6WfUyuxKVA7exQWMv7ZVggZb5dNfAZk0CDyKfKoTyDcgk4fj2jrkRszdC30hBT/lIAqrsLuTxV9YKpG9RJqGJ3u3pABhO1jW5+yXCcRD/YAhT146SerVUPMrL73zO9+/Ac1XWMuNWbHqMFj+e52T67p7qyL+lpedptJYR6yzOdyzwbeD/++vnzwbK+U0vXckK5QoQHHDzNqoxiU4fg/WJPsjKYtSRIRV04XUEhao/f/NOWdWIBcIQzmo9HU2LkParXzCTVczM7E29aKgZ93DRBAG7lAj2ePYJsTmh2RrXGveHjM1eh/C1yaevG4RlD/nCmU6kGumS9fK5SPCTDuxt2xHZI1uCwDvXjK1xTIsioUVk/2twS1WlYHlbOLwxAjSbv5WZATjgnRDmZHWUKrQJRFG5pHVl8NdCv7PaLh2hmMtO1VdU+21IxX906qeXiKo/ilygK9WaJCeAuvdVBKAEPW7bror/1p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(346002)(376002)(26005)(53546011)(6506007)(6512007)(186003)(2616005)(7416002)(5660300002)(8936002)(31686004)(36756003)(31696002)(86362001)(966005)(6486002)(71200400001)(478600001)(41300700001)(38070700005)(83380400001)(921005)(8676002)(64756008)(66446008)(66476007)(110136005)(76116006)(66556008)(4326008)(66946007)(38100700002)(2906002)(316002)(54906003)(91956017)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHlkcjR6VFBhRFEyZ0U0TjNCSUFobHB3L2F3RG1KTFh0c0E1eEJnQUxLeGdG?=
 =?utf-8?B?dEVQemwvYms3a0dwNjFQQXdyU2xpN3g5Z2ZhaFVEUithdnpxZVkwclpXc1Za?=
 =?utf-8?B?L0hMUWtYbUdRaWVoWlJrNDBORzZWcHRpU0UvZ1lDbmQ1MHh1bFhkeC96UDNI?=
 =?utf-8?B?ckJmUkJIMm9hOXhkL05mQldNUi9YSUlUdC90bWhPeUZoeEZESlpWYjhsM3pa?=
 =?utf-8?B?TlNoTmY1MGVIYWZWSEtoaC83OG1uSDFaSWJZMW1kSzhJU0drTUU1dlpHTmR2?=
 =?utf-8?B?RWRoTzdxakxTbnpPMFJtaURjYkloUi9pcGowMC9ZVGdlWUM3WkxoMFpIYXVR?=
 =?utf-8?B?enFKSnpEZ0FLOWFqMG5NZkRFOGxybEZaVjZPbDlIWE1IV0tEWjNMbWJGWm1D?=
 =?utf-8?B?RU9sTDNiVlpPejZjSTEzbjJGZjQzOXREcC9JMHEwSG5iRG1mVXVPMzJDMzNF?=
 =?utf-8?B?VG5KYnZpaVFweXJ2ZzF5dkdCM3BkR2hKenlNN1B1b2d1S2VHZ0kva243M0dO?=
 =?utf-8?B?MkhXcE1vQ2ZIZENYV1hlSENXYktTNEoxTDRrODV3eWxJZEVzU2szaWI5ZG9K?=
 =?utf-8?B?cjRPWW5uQUNaUndJUWpmVU4wS3haZkdmUHgrL0FaMUVvUXYyMmhpS0k3NEZm?=
 =?utf-8?B?VGJFc1A4N2NLaDNjdEQ4YTNLOFNzOW03NjZtV2RrN3ZrR0cwMVdmRlN2TFZC?=
 =?utf-8?B?VldHL1V0WVV5RG84dXEyRjBNQjhSbDNUN0RRbVZTazB4RWluUjBDVFo3TUpI?=
 =?utf-8?B?dzVSODlmMElJZEJBZEQrTmtoZTJLOVI1cTVIak0rZ2c4OGh5Z2NYU3owTE03?=
 =?utf-8?B?dVNMcUZ6TXhvemw3TXFydzhkcmJuTXNQSHg3L0c5cmZVblJCdzI5dnFDTU1I?=
 =?utf-8?B?OHJwdCtLWGUzdFg0YjRDSEQvemdCZHc4MXA0SXdZRldhZTRwZ1ZWL3lNSmFT?=
 =?utf-8?B?TTRIbk1uRUxRRkdvL2lOOTdmZlB2emNXS0xmcVQrZmsrK25YS0g0ZC9BTCth?=
 =?utf-8?B?RFd6OE9MdHJQRUtsWjR5YSt4em9NM1FleW1ldHdDUDE0WE45bXFtVTlsTSt6?=
 =?utf-8?B?cGs2U1JRcWFHd2duTFNuZVA5TmF6SVhLSzlZcWdVUDFlcWZVOE1RUS8yZkFD?=
 =?utf-8?B?V0tVd25UYkZTSDRuSUJ5K0xUN1JFWW5wbTI3NWx3UWptTCtHSnpFZjNHSGdX?=
 =?utf-8?B?VC85ZWJEc3RHZmhSamNldU81L0F2S2xKcWNOcmxuOFIwbVlPaTczbDVCRzFy?=
 =?utf-8?B?V2tSekl2SnVHQjhuR1d1T0ROZ0h1ZHhPU29jK2pkU1ZKQlNyMkYwTmpyZUhH?=
 =?utf-8?B?MGI2Q1NVUURJeGUxTWxQcng4MmJwRE9tOTE5c1NyUVhvZ1RVRG44bEpCWDUv?=
 =?utf-8?B?NzJZUXFLREFnbEZCSWpjbTR3WUZuTjVkam8xaXNHQmoxcDMzYzFQUGZycFlk?=
 =?utf-8?B?WHpMTnhRUjlRZTZxVFRGLzNrWDg4Y0NUdlYyU2RTV05MeGV3eUs4V3FHZGRJ?=
 =?utf-8?B?THoyamFPQjdhQmN1cDk5eThDWHozK3FDQm9JdGl2SzFuN3FiZkdpSmZlc2lM?=
 =?utf-8?B?bEhKSUhTanBMN1ExcW83LzhQM0VsRlBiUDZFRDVsK0xKTzFFMzdQV09mM0xy?=
 =?utf-8?B?WkRhU2RRSDI2U2trelZYRGhvRUFXaE83VTR3Rkh5M0x0OWVvTktJRE9ldFht?=
 =?utf-8?B?VURQdWlvM0pTbUJjZ3BQOEtBTmJtQlQ0MlZ5Rmh4ZjdwQmt3Z25QREdMcmxH?=
 =?utf-8?B?a1ZRWENUYkppTTAxUUNPcXJKS1FTaFhqbXRRS0NyRHkvU3R1cjVFQWgxWEcx?=
 =?utf-8?B?MTV1UFczNS8va3ZDY2Y5bUZZaVc1VUs2QlBRa0FYczFDcWh2R0lxTTdtM1Mx?=
 =?utf-8?B?UlNKZ2RQMFhjaGUyQTNaNWNZWkd0NTBXbTZTWU5NVWtBa0xzQ1RUOHZoMVE5?=
 =?utf-8?B?bCs3Q2pkaVhsclA3RHQzamtOc2pFQUV6dzJhRFhzLzZUOWdtbUoyaUhvaERY?=
 =?utf-8?B?dkhLUWk1dlU1STgvUTdyNmtla0J0eWIxSU1uTlduTXJ0Vi9DdkpEVWtaQVRt?=
 =?utf-8?B?YnY0ZWFBd1lDVzUzbjhZUVBwaGEvTWdNV216TmphSG9Cc09lRFJES1p3dHRU?=
 =?utf-8?Q?chHKc1NMXz/JxL5/mBEV/C6KB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFAC42CAA4A314459F825055477BA115@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5628489-ee3a-408c-79bc-08da8cef8624
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 14:29:20.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmptSjpPe9UiigqlYB500n0DYpHMRL9q2LR6kSlxgoLf9AZ20JIqD969OP4N/752Epth1xDd3A1ykXyxq+c2+07ZXfjhqRUEGnvfjy0kxco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5681
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMDIvMDkvMjAyMiAxNToyMiwgZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBEYWlyZSBN
Y05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IE9uIFBvbGFyRmly
ZSBTb0MgYm90aCBpbi0gJiBvdXQtYm91bmQgYWRkcmVzcyB0cmFuc2xhdGlvbnMgb2NjdXIgaW4g
dHdvDQo+IHN0YWdlcy4gVGhlIHNwZWNpZmljIHRyYW5zbGF0aW9ucyBhcmUgdGlnaHRseSBjb3Vw
bGVkIHRvIHRoZSBGUEdBDQo+IGRlc2lnbnMgYW5kIHN1cHBsZW1lbnQgdGhlIHtkbWEtLH1yYW5n
ZXMgcHJvcGVydGllcy4gVGhlIGZpcnN0IHN0YWdlIG9mDQo+IHRoZSB0cmFuc2xhdGlvbiBpcyBk
b25lIGJ5IHRoZSBGUEdBIGZhYnJpYyAmIHRoZSBzZWNvbmQgYnkgdGhlIHJvb3QNCj4gcG9ydC4N
Cj4gQWRkIG91dGJvdW5kIGFkZHJlc3MgdHJhbnNsYXRpb24gaW5mb3JtYXRpb24gc28gdGhhdCB0
aGUgdHJhbnNsYXRpb24NCj4gdGFibGVzIGluIHRoZSByb290IHBvcnQncyBicmlkZ2UgbGF5ZXIg
Y2FuIGJlIGNvbmZpZ3VyZWQgdG8gYWNjb3VudCBmb3INCj4gdGhlIHRyYW5zbGF0aW9uIGRvbmUg
YnkgdGhlIEZQR0EgZmFicmljIG9uIEljaWNsZSBLaXQgcmVmZXJlbmNlIGRlc2lnbi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAu
Y29tPg0KDQpBcyBhbiBGWUkgdG8gdGhlIFBDSSBtYWludGFpbmVycywgSSdsbCB0YWtlIHRoaXMg
cGF0Y2ggdGhyb3VnaCB0aGUNClJJU0MtViB0cmVlIG9uY2UgZXZlcnl0aGluZyBlbHNlIGlzIGFw
cHJvdmVkIGFzIGl0IGNvbmZsaWN0cyB3aXRoDQpzb21lIG90aGVyIGNoYW5nZXMgdGhhdCBhcmUg
cGVuZGluZyB0aGVyZS4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gLS0tDQo+ICAgYXJjaC9yaXNj
di9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1pY2ljbGUta2l0LWZhYnJpYy5kdHNpIHwgNiArKysr
Ky0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1pY2lj
bGUta2l0LWZhYnJpYy5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1p
Y2ljbGUta2l0LWZhYnJpYy5kdHNpDQo+IGluZGV4IDk4ZjA0YmUwZGM2Yi4uNjgzOTY1MGU3ZDFi
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLWljaWNs
ZS1raXQtZmFicmljLmR0c2kNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAv
bXBmcy1pY2ljbGUta2l0LWZhYnJpYy5kdHNpDQo+IEBAIC01Nyw3ICs1NywxMSBAQCBwY2llOiBw
Y2llQDMwMDAwMDAwMDAgew0KPiAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFzayA9
IDwwIDAgMCA3PjsNCj4gICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmZhYnJpY19jbGsxPiwg
PCZmYWJyaWNfY2xrMz47DQo+ICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiZmljMSIs
ICJmaWMzIjsNCj4gLSAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDMwMDAwMDAgMHgwIDB4ODAw
MDAwMCAweDMwIDB4ODAwMDAwMCAweDAgMHg4MDAwMDAwMD47DQo+ICsgICAgICAgICAgICAgICBy
YW5nZXMgPSA8MHgwMDAwMDAwIDB4MCAweDAwMDAwMDAgMHgzMCAweDAwMDAwMDAgMHgwIDB4ODAw
MDAwMD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICA8MHgzMDAwMDAwIDB4MCAweDgwMDAw
MDAgMHgzMCAweDgwMDAwMDAgMHgwIDB4ODAwMDAwMDA+Ow0KPiArICAgICAgICAgICAgICAgbWlj
cm9jaGlwLG91dGJvdW5kLWZhYnJpYy10cmFuc2xhdGlvbi1yYW5nZXMgPQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgPDB4MDAwMDAwMCAweDAgMHgwMDAwMDAwIDB4MzAgMHgwMDAwMDAwIDB4
MCAweDgwMDAwMDA+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgPDB4MzAwMDAwMCAweDAg
MHg4MDAwMDAwIDB4MzAgMHg4MDAwMDAwIDB4MCAweDgwMDAwMDAwPjsNCj4gICAgICAgICAgICAg
ICAgICBkbWEtcmFuZ2VzID0gPDB4MDIwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHgwIDB4MDAwMDAw
MDAgMHgxIDB4MDAwMDAwMDA+Ow0KPiAgICAgICAgICAgICAgICAgIG1zaS1wYXJlbnQgPSA8JnBj
aWU+Ow0KPiAgICAgICAgICAgICAgICAgIG1zaS1jb250cm9sbGVyOw0KPiAtLQ0KPiAyLjI1LjEN
Cj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXJpc2N2DQoNCg==
