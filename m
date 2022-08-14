Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D6591FEA
	for <lists+linux-pci@lfdr.de>; Sun, 14 Aug 2022 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiHNNsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Aug 2022 09:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2022 09:48:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D81C106;
        Sun, 14 Aug 2022 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660484880; x=1692020880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JkJ7h/v9rs7+peGmqYrCSmY80B1vr3Z2rakPAeyiEUc=;
  b=V13sXV71I0q0X6JPaw4qgmZ/P0XbRGquDLP+amRUa+pgI3Dmw89NZ3q+
   JewnrtyFWsSeCyP7AW+iMVwLoP5+t05oLLfSbueAholFElId/0BlFjU7a
   ogWAMbg6q/jmCQlZVnJw+o0DspurbC1rUBwmBtRtWeor1a1EvbIZU0FCs
   Vy8B+/xwu/nmTU9isp0lUQN2j2zZ6ymvD4rILKTocdQZdFGViA9PrG+Lw
   uX3PbmK1S0bJKpdF62KcgtkxA2Qe1UHP+UNmXvMV6UY31Ux0DHBVNDhI5
   qdt0yeH13wphF8y9uI3/XR4A+/z7ztlsxvej5pX6RZVGiQ9xBB0640hEW
   g==;
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="176173911"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2022 06:47:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 14 Aug 2022 06:47:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 14 Aug 2022 06:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZbUR+tPKXXzHdYPr4r4pVzyYIO8WwRV2GZV5SuxBwDHTEESK/m0MeRhi1TrDqOKhYsc3Xbuuo71at+Q5m7E1Ul+Xw87B8KIs179jMuJB2wkpbs90wCt+npYkcUC3rX8xPstr/qZXti8iHeZRgm2/qJSga+Ila6JDH5JmKqee2JWm3C2lx+JUh1dpLK6dJHR/SioYT55tJl2tgB8NkaKSyaw2TCNgD0wAp3qFommmVqxyGKrX/sbELs8krhLzoH+m/8pAr9iX1+nrnnzFXZWE7jQH/GzEbNmrP+fdDy6VVmN4q1ia/nx7TpuNdrv02AjGmCsw2c8WdfLkgEG/ihWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkJ7h/v9rs7+peGmqYrCSmY80B1vr3Z2rakPAeyiEUc=;
 b=IhgOlzprB/1bn0wrfUyDIPBo0ABBzdnHJXWndrGNQOJ858xCc5jOl/xNOpT5veT2cZxRY8AI/vAuW869mm7YF4MPzWQptpYUzLUuxeeIj+rOT1Ko59p7wottp3vnNwB7+sHXcZ4IaX/678Om1qBbyPs+yXrf0p4/poPs5BwmXZIMf1X2qAGKhdZlizjL9o8BW+MfbKbJqhzZ9OWvlXGpxCeJ4AfbXsqwcXakN9SHeOvuCicKfxBHLdnZ50EgM7rNe8+v7igF0WFrNGrY6yrhVSvL5fAy4VcbK0eAiKd0nA/czwM3pB3fs9zU0PQ6LpfHUQ8pcBZImyqjgbWklC81aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkJ7h/v9rs7+peGmqYrCSmY80B1vr3Z2rakPAeyiEUc=;
 b=GX1rzUoAorraFzefz/6AX0UmbEU8AIOulZ2TFIU2bpTk/+V01NEglnxxZ3AdJt83yhcmwsj0P4FugeeDAC/RiiUPXct3zTg0x8zgnI02q3XAgn+Z0uFwHPQr1Id4V3fXHz24c0+aa5YrZ3mhfxr+Mq8SnP7Osr9MJd14vdOdkN0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH8PR11MB6610.namprd11.prod.outlook.com (2603:10b6:510:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 13:47:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 13:47:55 +0000
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
Thread-Index: AQHYrcGqVjwwy0+GMkSA5AgZisgzK62q4LmAgAOMrIA=
Date:   Sun, 14 Aug 2022 13:47:55 +0000
Message-ID: <d25f8901-b9d7-ae8e-0061-2a033af16693@microchip.com>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-3-mail@conchuod.ie>
 <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
In-Reply-To: <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c318897-de56-489a-6789-08da7dfb9787
x-ms-traffictypediagnostic: PH8PR11MB6610:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1It0ltidBiM6e6BjOgwqiyX3Q5nwo6YvKpjboHFVvhinrbcHs0VulQdTivT9ZayBck/SD9RvFrJ+4IcbY0k4+iwVIe2S7Bn7gaqbfqQ6sUotqXdYIST/Zq1rKmK/Mnlh/ZoT2B0Bb4KFif7pPMQmLO85zfMxWCSWQoO0Ww9ipN0e6FWCf5DxtQGB8Y+LEbQUpyC6cJvRBGgMhSi2Ydvry5urXiQfwuuySNX7qVTmqAo6zKpu1hBkjnII4DT+Xk7boMqxC4z7ScpQkiVP+SEByAiH6csuJ/oEBQBMYZiJ0T5hJ6S5wuFUglalPyLjAS001XYPIGlQxloQupR2O1RQoA2RARyoKDEoRb3MVScENOGG0fZ3thXZ2E/pjkDBjMbaxcrs4CuITApZrUN1r/v+9T0ci+O6+DT0DgpKwdkoTGbe9qS2W4R01582W1OFWC2DQrj6Hls/P3Yhr8Xbzrt9PioQamogox3R0+Qyrm9Jy1cTlvNb8bKfSplqJPuac8z3xG5lwm7nggnrON1KIK3S/pCK+y3eCVJInKByY9Ba9ILNRn803OuOtB/+egTF/czUEW2eEAym4JXCY+xzysDURWNNOxA/POczHDoM91Hk37ru30EQbEDFrlKWflR6scfEAM28Wyzm5hZ46PEhTM7Ch6jQbwhC9XHDpt4yECW6eml3NNtCP/NoZo5a1AFfmHlRH4/qIrdfL9ZA/JoQdXEoDlQKtei3kNp18T1O6J+teQUgXSfCxVH0HC5H4QlJLz6ePIEqC+Rf9LQst4Sbg3bCF64vnF/CvZPaU/KAPxFdIpZozqPxJcVGP3Gj3G6xXmRNrXibNaRnM11tLQZIexLXUF7fYozhJpOF0Vs7Bi3pbaP2uKm1nWvhlTpvMiVnExZTgJbzmMyk7PVu4CZqoUXUtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(376002)(136003)(366004)(396003)(346002)(316002)(38100700002)(8676002)(91956017)(64756008)(4326008)(66446008)(478600001)(66556008)(83380400001)(31686004)(54906003)(110136005)(76116006)(66946007)(6486002)(36756003)(26005)(31696002)(41300700001)(2906002)(7416002)(921005)(8936002)(5660300002)(6512007)(6506007)(122000001)(38070700005)(71200400001)(66476007)(186003)(86362001)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmtZRTRNamZtUUxTaExJcElZTm1Va3BTcGlPdVJtQ2J5dzJCeVF1WGRIcDJz?=
 =?utf-8?B?dkN0UG1qQ3E2TFQ0SW9hWGFqZjl5NTduTzdSb0xFdm9hZk9iZGsvTjcxeC8v?=
 =?utf-8?B?QTVVbVRENUJTRTZtL25Hb3BWcHZqbG95bHZhMVRiMzdOMDN1aENmTjBaT3pa?=
 =?utf-8?B?YmR4amhSWE5FUnB1eEtmNmJpVVJYdlVCODZyQmZ0MVhwa0lYbmhIUjlZUkQv?=
 =?utf-8?B?dnloYWo4SVcyQlE2cThHU1JZRHBudGJDeDZSSHBqc2s3NEthclo5b3FLRlhy?=
 =?utf-8?B?Z1RJei96RjVlTXQwVVp6NUthRVR1WVFoaHBPNnVnZFA1amlHdit4MTZhSmk2?=
 =?utf-8?B?OW5uc1JybGt2djYzWE55MkI3WUplV2U0a3JiSUxBMUdlYmhXSFh5TXhFUXd0?=
 =?utf-8?B?ZFF1TEJmbldRMmdqQ1QyZDM5MkZ1VXhmVFZlcFVTazJ5cHV4U25hSkpmS002?=
 =?utf-8?B?OE9JYStGY3RWYVZ1dzZ5WkdIdDRQU09xZ0EwL1pITzVPU0xhcU5GZ0xOTFM5?=
 =?utf-8?B?MlBPOVRuVDVsbnUyUzJwakl2RU82cWFYOW1OODZJTlc0QlNwcHFGWE9lTWFw?=
 =?utf-8?B?TDdRWUFqdUdEUStaU2tTLzFzSW5lTTFPa1pseEZaODBGeHhwQUlXNk5xaHlO?=
 =?utf-8?B?TGVFcjh1NnF4RVFYV0gyTWVtNzQyZUNMMUVoRnQ4Qm1rWWdCQldkdkRKRUt5?=
 =?utf-8?B?ZWdxMG0yTFFTQVNqaUtQaHBMWmE5eG9JclBncXBjL3dteFdQb0dpRlFaV09V?=
 =?utf-8?B?SE5SU1hJcFlaV0JwcTduTXY3Umk4Y3NPSm5mekFlVFNCQ3JjQVZHY285d1F5?=
 =?utf-8?B?azlZVWw4MDRndVAzVis4MG1XVHUxZmR2SXdLajArTE5sdGxBeE1QQlN2ZDQ5?=
 =?utf-8?B?R0lXbFpRamkrc3l5VkdJUmFXOVRDSkFHRndCT1Z5OEZzbDZrSXVRRTNkVVUy?=
 =?utf-8?B?SmErQmcwVlBOUDlwRjJ1TDFQQ3V0VDY3Z3c4cUxIMG9MTk1BU0ZxNnhFd1Bx?=
 =?utf-8?B?WUlXcUEvUWdYc3g5R09GVFI2bGdjVXRiT3JoM0VES0l4azlLNzQvVGRWaThN?=
 =?utf-8?B?MlFVNk1nZCtPQWU0MXFac3pUMkF6d3ZIL3BWL1l4eDJvR29FTUt4Y2tKNkJo?=
 =?utf-8?B?QzVZc0RpczZPaXJuOVVXQkZhTnNlR2Nac2U0TTlWSTRwVnVTUkV6OEhTUG9p?=
 =?utf-8?B?d0dEazNrSnRsVzBnQk9URU5ZaVJpc0hucDNWVW5GU2xoajVMcmRxREJUdUQ3?=
 =?utf-8?B?N3ZvQ2VpNlM5ZGtrQ1IwZnFmS1Y5RHNzSmJmN3lKeDV3VStDeGJqOGJDeWhW?=
 =?utf-8?B?UElHdGxqZ3hUcU5ibFkxYXUrOVJxQXdzVUt6am1Ia0kvTHcwZTNsRXJWQWpW?=
 =?utf-8?B?QzRKbU1xRzFQL3JDYkI2RmxqZVNPcXVsVVpSMEVsaUMySG9xWmhmRUp0ODlJ?=
 =?utf-8?B?dkJJSDRoK1QvVE92cEJkQnUrL2NnU0tyK3VWS1JXdVZoSDJxdjV3WHVQdUdS?=
 =?utf-8?B?UDAxMVZrZmZwRVJMM0E2WkQrRUZmamN0OEtDR2FjQmtnaW1KY0RxZy9wK20v?=
 =?utf-8?B?VUN1UmJQZFVjUzFYUzJmWW5qbXdqNmJxZzlEWVpaK3NFMm9mQmpNNVNoVjJz?=
 =?utf-8?B?c2VpSTZSVFZReWJmMVIveHRWVklyb2ZyTW02NDZPSkpLdHFCaWdrRFpqT1BY?=
 =?utf-8?B?S3UvMk1WMjlpanBPVnFnYkpQczlDQjg4SzZaTVRZdUZLMFJTMFZqTTg4ZGQv?=
 =?utf-8?B?bXhWVW85U0F6NGZXRHpXVVF0MDJiK0x4NGNwbXVNbmZJT20yWUlvWGg3Y1Nq?=
 =?utf-8?B?Vk5KdUtnVHp6a3B1R1JhZ1hCaU1OZ1MrV1JNYWlvS01JOTYrRXIydXZtYkJE?=
 =?utf-8?B?MGF2RWpEcDZhMVpOb2VTM1IzUDBURDZtcmJqRXJLRkV1REJlTVRRdVM2cUIw?=
 =?utf-8?B?SzhjR2RXaVZLc1NCR0QzbnpEYTZ3NXg2Z3JHc0dvaloxbiszcmpZN3ZYSHhU?=
 =?utf-8?B?eVpvWU5vWkVqb2FXcmpNMHozKysxK3l5eTdObUMxcWY4WDdCMkc3cWo4aGFX?=
 =?utf-8?B?UTR5Z0FIaGgyZFg4eXFIYWZocTJ6Ukl5UGlyYW53ZnNlbGdwVEVHMlFsT2Zr?=
 =?utf-8?Q?VBLYW7eHwFwcNw+jvn8bRiEd9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <288EE4FEDFBA474C9D3A01E0E8229F80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c318897-de56-489a-6789-08da7dfb9787
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 13:47:55.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngh8E/zyi7mAdsqZ37L/mT7BbzGSD3Vjvz53z1yHsZruymyHOE1gz0p6ZdlTJeHPO83cPH7EmvgU6zGFRMQRcunzTOD/BX21OU++J2tXlXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTIvMDgvMjAyMiAwODozNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMS8wOC8yMDIyIDIzOjMzLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IFVwZ3JhZGluZyBkdC1zY2hlbWEgdG8gdjIwMjIuMDggcmV2
ZWFscyB1bmV2YWx1YXRlZFByb3BlcnRpZXMgaXNzdWVzDQo+PiB0aGF0IHdlcmUgbm90IHByZXZp
b3VzbHkgdmlzaWJsZSwgc3VjaCBhcyB0aGUgbWlzc2luZyBjbG9ja3MgYW5kDQo+PiBjbG9jay1u
YW1lcyBwcm9wZXJ0aWVzIGZvciBQb2xhckZpcmUgU29DJ3MgUENJIGNvbnRyb2xsZXI6DQo+PiBh
cmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLWljaWNsZS1raXQuZHRiOiBwY2llQDIw
MDAwMDAwMDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgnY2xvY2st
bmFtZXMnLCAnY2xvY2tzJywgJ2xlZ2FjeS1pbnRlcnJ1cHQtY29udHJvbGxlcicsICdtaWNyb2No
aXAsYXhpLW0tYXRyMCcgd2VyZSB1bmV4cGVjdGVkKQ0KPj4gICAgICAgICBGcm9tIHNjaGVtYTog
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0
LnlhbWwNCj4+DQo+PiBUaGUgY2xvY2tzIGFyZSByZXF1aXJlZCB0byBlbmFibGUgaW50ZXJmYWNl
cyBiZXR3ZWVuIHRoZSBGUEdBIGZhYnJpYw0KPj4gYW5kIHRoZSBjb3JlIGNvbXBsZXgsIHNvIGFk
ZCB0aGVtIHRvIHRoZSBiaW5kaW5nLg0KPj4NCj4+IEZpeGVzOiA2ZWU2Yzg5YWFjMzUgKCJkdC1i
aW5kaW5nczogUENJOiBtaWNyb2NoaXA6IEFkZCBNaWNyb2NoaXAgUG9sYXJGaXJlIGhvc3QgYmlu
ZGluZyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1o
b3N0LnlhbWwgICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCj4+
IGluZGV4IGVkYjRmODEyNTNjOC4uMmEyMTY2ZjA5ZTJjIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlw
LHBjaWUtaG9zdC55YW1sDQo+PiBAQCAtMjUsNiArMjUsMzEgQEAgcHJvcGVydGllczoNCj4+ICAg
ICAgICAtIGNvbnN0OiBjZmcNCj4+ICAgICAgICAtIGNvbnN0OiBhcGINCj4+DQo+PiArICBjbG9j
a3M6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEZhYnJpYyBJbnRlcmZhY2UgQ29u
dHJvbGxlcnMsIEZJQ3MsIGFyZSB0aGUgaW50ZXJmYWNlIGJldHdlZW4gdGhlIEZQR0ENCj4+ICsg
ICAgICBmYWJyaWMgYW5kIHRoZSBjb3JlIGNvbXBsZXggb24gUG9sYXJGaXJlIFNvQy4gVGhlIEZJ
Q3MgcmVxdWlyZSB0d28gY2xvY2tzLA0KPj4gKyAgICAgIG9uZSBmcm9tIGVhY2ggc2lkZSBvZiB0
aGUgaW50ZXJmYWNlLiBUaGUgIkZJQyBjbG9ja3MiIGRlc2NyaWJlZCBieSB0aGlzDQo+PiArICAg
ICAgcHJvcGVydHkgYXJlIG9uIHRoZSBjb3JlIGNvbXBsZXggc2lkZSAmIGNvbW11bmljYXRpb24g
dGhyb3VnaCBhIEZJQyBpcyBub3QNCj4+ICsgICAgICBwb3NzaWJsZSB1bmxlc3MgaXQncyBjb3Jy
ZXNwb25kaW5nIGNsb2NrIGlzIGVuYWJsZWQuIEEgY2xvY2sgbXVzdCBiZQ0KPj4gKyAgICAgIGVu
YWJsZWQgZm9yIGVhY2ggb2YgdGhlIGludGVyZmFjZXMgdGhlIHJvb3QgcG9ydCBpcyBjb25uZWN0
ZWQgdGhyb3VnaC4NCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgaXRlbXM6DQo+PiArICAg
ICAgLSBkZXNjcmlwdGlvbjogRklDMCdzIGNsb2NrDQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjog
RklDMSdzIGNsb2NrDQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjogRklDMidzIGNsb2NrDQo+PiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogRklDMydzIGNsb2NrDQo+PiArDQo+PiArICBjbG9jay1uYW1l
czoNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgZW51bToNCj4+ICsgICAgICAgIC0gZmljMA0K
Pj4gKyAgICAgICAgLSBmaWMxDQo+PiArICAgICAgICAtIGZpYzINCj4+ICsgICAgICAgIC0gZmlj
Mw0KPj4gKyAgICBtaW5JdGVtczogMQ0KPj4gKyAgICBtYXhJdGVtczogNA0KPiANCj4gTm8gbmVl
ZCBmb3IgbWF4SXRlbXMuDQoNCkkgYnJvdWdodCB0aGlzIHVwIG9uIElSQywgYnV0IHRyYW5zZmVy
cmluZyBpdCBoZXJlIHNpbmNlIGl0J3MgYmVlbg0KYW4gKHVuZGVyc3RhbmRhYmxlISEpIGZldyBk
YXlzICYganVzdCBkaWRuJ3Qgd2FudCB0aGluZ3MgdG8gZ2V0IGxvc3QNCmlmIG15IG5ldCBkaWVk
LiBDdXR0aW5nIG91dCB0aGUgYmFjayAmIGZvcnRoLCBpbiBzdW1tYXJ5Og0KIg0KSSdtIHRyeWlu
ZyB0byByZW1vdmUgdGhlIG1heEl0ZW1zIGZyb20gdGhlIGNsb2NrLW5hbWVzIGFycmF5IHlvdQ0K
ZGlkbid0IGxpa2UgLSBidXQgSSBjYW4ndCBmaWd1cmUgb3V0IHdoYXQgdG8gZG8gaW5zdGVhZCB0
aGF0IGRvZXNuJ3QNCnRyaWdnZXIgZXJyb3JzLiBBbGwgNCBjbG9ja3MgYXJlIG9wdGlvbmFsLCB0
aGUgb25seSByZXF1aXJlbWVudCBpcw0KdGhhdCBhbnkgb25lIG9mIHRoZW0gaXMgcHJlc2VudC4g
RWl0aGVyIEkgc2VlbSB0byBnZXQgY29tcGxhaW50cyB0aGF0DQpteSBwcm9wZXJ0eSBpcyBub3Qg
YW4gYXJyYXkgKHNpbXBseSByZW1vdmluZyB0aGUgbWF4SXRlbXMpIG9yIGNvbXBsYWludHMNCnRo
YXQgYmVjYXVzZSBJIGhhdmUgY2xvY2swLDEsMyBhbmQgbm90IDIgdGhhdCBjbG9jazMgaXMgdW5l
eHBlY3RlZC4NClRoZSByb290IHBvcnQgaXMgcGh5c2ljYWxseSBvbiB0aGUgb3Bwb3NpdGUgc2lk
ZSBvZiB0aGUgRlBHQSB0byB0aGUgY3B1cw0KJiB0aGUgQVhJIGNvbm5lY3Rpb24gaXMgdGhyb3Vn
aCB0aGUgRlBHQSBmYWJyaWMuIFRoZXJlIGFyZSA0IEFYSQ0KaW50ZXJjb25uZWN0cyB0byB0aGUg
ZmFicmljICB3aGljaCB0aGUgUENJIGNvbnRyb2xsZXIgY291bGQgaW4gdGhlb3J5IGJlDQpjb25u
ZWN0ZWQgdG8gYWxsIDQsIGJ1dCBpdCBvbmx5IG5lZWRzIHRvIGJlIGNvbm5lY3RlZCB0byBvbmUu
LiBJIGhhZA0KZG9uZSBkb25lIG1pbkl0ZW1zIGFuZCBtYXhJdGVtcyBhIGxhOg0KZGV2aWNldHJl
ZS9iaW5kaW5ncy93YXRjaGRvZy9zdCxzdG0zMi1pd2RnLnlhbWwNCmIvYyB0aGF0IHNlZW1zIHRv
IGhhdmUgdHdvIGNsb2NrcyB0aGF0IGl0IGRvZXNudCBjYXJlIGFib3V0IHRoZSBvcmRlciBvZg0K
Ig0KDQpSb2IgdGhlbiBzdWdnZXN0ZWQ6DQoiDQpJIHdvdWxkIHJlbW92ZSB0aGUgJ2l0ZW1zJyBs
aXN0IGluICdjbG9ja3MnIGFuZCBtYWtlIHRoZSBkZXNjcmlwdGlvbg0KY2xlYXIgdGhhdCBhbnkg
b2YgY2xvY2tzIGlzIHBvc3NpYmxlLiBJdCdzIG5vdCBpZGVhbCwgYnV0IGl0J3MgYSBjYXNlIG9m
DQp0aGF0J3Mgd2hhdCBpcyBhbHJlYWR5IHRoZXJlLg0KIg0KDQpJJ2QgdGhlbiBoYXZlIHNvbWV0
aGluZyBhbG9uZyB0aGUgbGluZXMgb2Y6DQogIGNsb2NrczoNCiAgICBkZXNjcmlwdGlvbjoNCiAg
ICAgIEZhYnJpYyBJbnRlcmZhY2UgQ29udHJvbGxlcnMsIEZJQ3MsIGFyZSB0aGUgaW50ZXJmYWNl
IGJldHdlZW4gdGhlIEZQR0ENCiAgICAgIGZhYnJpYyBhbmQgdGhlIGNvcmUgY29tcGxleCBvbiBQ
b2xhckZpcmUgU29DLiBUaGUgRklDcyByZXF1aXJlIHR3byBjbG9ja3MsDQogICAgICBvbmUgZnJv
bSBlYWNoIHNpZGUgb2YgdGhlIGludGVyZmFjZS4gVGhlICJGSUMgY2xvY2tzIiBkZXNjcmliZWQg
YnkgdGhpcw0KICAgICAgcHJvcGVydHkgYXJlIG9uIHRoZSBjb3JlIGNvbXBsZXggc2lkZSAmIGNv
bW11bmljYXRpb24gdGhyb3VnaCBhIEZJQyBpcyBub3QNCiAgICAgIHBvc3NpYmxlIHVubGVzcyBp
dCdzIGNvcnJlc3BvbmRpbmcgY2xvY2sgaXMgZW5hYmxlZC4gQSBjbG9jayBtdXN0IGJlDQogICAg
ICBlbmFibGVkIGZvciBlYWNoIG9mIHRoZSBpbnRlcmZhY2VzIHRoZSByb290IHBvcnQgaXMgY29u
bmVjdGVkIHRocm91Z2guDQogICAgICBUaGlzIGNvdWxkIGluIHRoZW9yeSBiZSBhbGwgNCBpbnRl
cmZhY2VzLCBvbmUgaW50ZXJmYWNlIG9yIGFueSBjb21iaW5hdGlvbg0KICAgICAgaW4gYmV0d2Vl
bi4NCiAgICBtaW5JdGVtczogMQ0KICAgIG1heEl0ZW1zOiA0DQoNCiAgY2xvY2stbmFtZXM6DQog
ICAgaXRlbXM6DQogICAgICBlbnVtOg0KICAgICAgICAtIGZpYzANCiAgICAgICAgLSBmaWMxDQog
ICAgICAgIC0gZmljMg0KICAgICAgICAtIGZpYzMNCiAgICBtaW5JdGVtczogMQ0KICAgIG1heEl0
ZW1zOiA0DQoNCkRvZXMgdGhhdCBzZWVtIHJlYXNvbmFibGUgdG8geW91Pw0KVGhhbmtzLA0KQ29u
b3IuDQo=
