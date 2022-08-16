Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6246C5961B6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiHPSAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiHPR77 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 13:59:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85A83043;
        Tue, 16 Aug 2022 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660672797; x=1692208797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/WL928uJjhD25n34lMX3961s5SSwUEPH1zJP05xGCAk=;
  b=zeSM5W9vF6Lqg90Uqxo2XuKJ/rNH15ZBJCXjXHfiMMt7wwvVEOITC0Ph
   kYDq4e5/ICUVKIC547SH++qEydeYwSNLMVBVA3cAf4Y7ISmpgjnkZBqq7
   ZU3EkDrq0WSjN9UP2Pu0Qmz+gfjferFmnOZ8BGE0dJFnRI7USYq8La1Rm
   8MNj7SdVYOy5kUt/yRgLm69s0ZCd4zvyV+oApeML3OfehMitW4DcDd3dt
   2vnLJO7VqNcXXigmPZD3AF45JlSIIk0Er7omI3gThicERSsscEGIAYzLf
   K5xipm3IKu7pDFMF0hGDoPu33r1m+RGuAt/IX40OtBOQH1PUmM3T7PyGa
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="169558300"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 10:59:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 10:59:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 16 Aug 2022 10:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0Dz0ryl18IMzhLy7auAyTOrK/K0HqxF40z+qUw+R05eRbNXCUqyTJm5Q6hXutQKCef2sm4y2JiVlij9eLc4UToshPW5h3sRlR7ipypyUIpNmErY0VkObDrJVD159sVweQz2Ee9FeSVEMD9aYlnW//ji9lHkprh3nT/zV8SVvMI3psWfNL+BlAmrs1inkQT3xFmxjK+Yr6Eb5SSjq/1mGM9ey+Reuy4S6DLEmX/A2SlV9TNMfSGorCdbFvi/V20y2Bhjp65t6mhAd3gAtGbsWS0L068vhWPpVHKhRyUSbceIQDH6U9oXCNeEPLlUKw7TmBwX73ss/2+/nJmXWSyIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WL928uJjhD25n34lMX3961s5SSwUEPH1zJP05xGCAk=;
 b=n7p+cH5SmaitgETtfGJk1EBe3yp9eR7y5Y9/Sk/QlytwCeyu9in57oUfUxRBlMBvY6o+/rXuYBHEEtcu4Y9skT9P0botfhshxnJtnqm84QaxzNgFhCPgHftKgFogKO88zFpmIRqC7Lp/z+iaQDLDE3SQoUkjCsrYsUFOrFn82hrl9L2Yg6KXZ+qJ26agI658hG/iwt8exI+cbCAM3O3HDSOTevhRkZEr5/8ZEMUV39iOZDksdtwToDAB8jtn4tbRfkCiW4FrO8VqJ/rNV6x4ey0bXMSNmtRuyDfnl5v/dGXYv5C6vW1IMieCA8aZNySKo8uwl3Cn1IBkX5Uzt2UScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WL928uJjhD25n34lMX3961s5SSwUEPH1zJP05xGCAk=;
 b=A1MZ2e38T7jpgqdIUoFkrjsfrwov42BsJp4L4fH5kNWtlaydSya1MuRDvIucxxcFxf7DQcU7oWWKrfElq9YZy8ec+kGYxjXbovD8ZOo+8CMiltQCSdYcuZNwlPsxCu9xGi9KaIzyvt5a34YimZadgb4fr+Up8XP7u4u705glUqA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4303.namprd11.prod.outlook.com (2603:10b6:208:18b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 17:59:48 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 17:59:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <greentime.hu@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <lpieralisi@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 address translation property
Thread-Topic: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 address translation property
Thread-Index: AQHYrcGjcBNK+hyPA02pML5P0onaLa2q5U0AgAAH84CABt8wAIAAC/6A
Date:   Tue, 16 Aug 2022 17:59:48 +0000
Message-ID: <f4d07239-945d-8fd9-ecc6-93b671931318@microchip.com>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-5-mail@conchuod.ie>
 <edf3da1b-79dc-4e09-8d3e-73aca09e847f@linaro.org>
 <0dd12c70-70f9-1dc1-c5c8-a3ff15be81f6@microchip.com>
 <20220816171652.GA2390778-robh@kernel.org>
In-Reply-To: <20220816171652.GA2390778-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0368e9d4-6763-4f1e-8897-08da7fb11c08
x-ms-traffictypediagnostic: MN2PR11MB4303:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUNY0c2DxRdfX9KEP/6mPijD7Aa0YU9kUNjZD7GBh0Xa3VJW2HDW1iWLBlwTKsbTJDuJlchAXWUghID/XDXux5t8Bmt54rNfGnw+KW/ISZjH2QYmIahczxXMS7efBffw60SmcBRWKFfrw0N+MiUSOzTODaaDQ5LvqCVdy7gj+wgpG/ZE7J7cDXYJ2IQ/6u/FL46dhmaLZAh9LSheALDIBkOGfNfQK2KtEVTcaPGcAmGtQ2fNV2d2b2BOfsvt7mOGRpjGAzyVebNF7SmOt7thJtd225f3fprwrkpKOIQrN5GBS0KnNW06fK6MWKUrQjKYGUrw8xEquw9DPvoBTRao5uNANz8vKM7m9LYX4B/Yh0fOjKqzMnRFIbzhgN3dBJNgf+PU2K249McX7HJ0dTwZQ/V9C5bIEP7dffVRD/t9PP0M2SWOe5ULnJOA2Ntkdd9qVwdt6hMG6ui2dyQ1AMyM6qzeSZjdVAqL5SUo1nEToOjSS19j9zg0uQijYuYmCx2EMdwgKeMMRDw+s5I3uQiqxhmzwrLHVDMumRSP0xesHDEiGKaHCbYeh3LCgML2Xsi67ybqCOj/jfGNz4qXFlKnIgIWmS9yovupMWDdG37nFFgy425Us2t/c7f1j3bkSewahl5CE4vKaDlbs743dd0oN1QdO5G6JRNgnM2XV5bnuPf5VBaGULDeN6LPihNMxqV/EVX1IPr21L20GMp+MNExmHz0dW4ESlTyQpjdsNa+2uSavN9GhZp6bDbx19vpvYGWVAMv4JU0tVttVfISSupGukgJ3FvAyxZ9r+jOMUJFd3aKtfQMOQdueeKvOgxcvNmLboCn66O59Zdm3nTxblMLb0L4nGN236K0OF49VKEwLTeQmoOLeXo8GW0/5nAjHCFG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(396003)(346002)(366004)(6916009)(76116006)(7416002)(54906003)(38070700005)(5660300002)(316002)(91956017)(66556008)(41300700001)(31686004)(31696002)(64756008)(86362001)(6506007)(4326008)(66476007)(8676002)(6512007)(53546011)(36756003)(8936002)(122000001)(2906002)(26005)(66946007)(66446008)(2616005)(186003)(83380400001)(38100700002)(478600001)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmNJcURCalpaWEU3djB0cVBPMUxucFdMc2dRUC9FM0RGUUJNL1JXdEFuQXhU?=
 =?utf-8?B?citxN2tQdnFrUVdabk5IQzJ5bVhadCsxRGJvaWtQT2xYSi9Ha1cxTFVndGs2?=
 =?utf-8?B?YndSbjRtdmdzN3gwdWhCNm84T0xhYTZ4TCtpVHFnZ1dVOG9xT0U4aGUrMnND?=
 =?utf-8?B?TmNibHZBeGR1R1BKbWxqSkIwcXdpa2dxN3c0M28zejI2bC8wTWdqVTU3RGNi?=
 =?utf-8?B?cmNsM3RGeExMeDMwVUlnaTlZM3hTdExXV2xhaWw4ZUgxR0xhN0ZhNFl6aFMx?=
 =?utf-8?B?aVplQi9vTXY0ZmV6UnFwRHA1NUUxNzhZTWlCdnlIa1k3R1RDN0liVCs0Zmgv?=
 =?utf-8?B?TmlVTmtHWDJ6RWZsbDhSUGhwNGI2Z3B3MFA0dlg1bzNaMG9TUWovZFZRZzBK?=
 =?utf-8?B?TFg2cE51NDhBcjE1aU1QUzdjcFdlME9US0pRa0Qzb0dySm80WUFtQ09hb3RY?=
 =?utf-8?B?NWVhcXE5V2dqQjRMa29IdjZNRUk2NXdHcjFPMXlXcnprNGFJdFBDU0h4L2ZY?=
 =?utf-8?B?ckFCYXU3Y1VnRVhEVkFxQ0tBWmN5YjlvbmNoR3dlRmtlQXVUT09vUXZIN2Zz?=
 =?utf-8?B?Wm15ck56T1pjTWUvL21oVnNJcXJ0UmVteXNGQTJVNm8vaGpTR0xnd0dxVHZa?=
 =?utf-8?B?Q1N1RHQ5MFlkQUJ2MFA0Vy92bVNYSHdBN3B0YSs4RGZUL3h5cHFHVUxqWUVK?=
 =?utf-8?B?TEVBR3c0QVFVMTFacmx3Z2g0MVZLNFlndzV3RER5YTc2Q2JzblJjVi82aytE?=
 =?utf-8?B?eHczMTBmZU9jaGV2SmJhNEpuS2VRZ1hYM3F4Ulc3Rm5XZnYrcVlvamFQUlg5?=
 =?utf-8?B?YVBFZmdJVXRNZXR0MldyVCt2cUhIUXRUOGxjbzNRZDY2SUkvejVrZ0R2RUkr?=
 =?utf-8?B?WlJYUUR5TlJYbjlQUjBmMnUxWWVyRTYzbElGbGtlZjAwOEtSRWVGNjQvSHds?=
 =?utf-8?B?YmlZbjZCUnk0aW9Qc2xSNFp6SnpGeGtIcjZQQkhPMi9qQkxOZW1vdzBGdFJj?=
 =?utf-8?B?ZXMwZWVpWnNEOVVqUStRa3R3Qm9kUzFFYThSbG9DYkdiZzRzUkY4VWNHUjB3?=
 =?utf-8?B?NC9JcHgrbkFPbVNpaStpbmpBWmFtTEZreHZ0MlQxOEp6OXhHNE42bU9ialZz?=
 =?utf-8?B?bkxrbHY5SjZsNk1UdEJRVUFGWlZGWDBYUWNKZHVuR0NHbGR5anJ4blBTL0lZ?=
 =?utf-8?B?USttK3BBWW9zQ3EzbTRPdk5hazE1a0c3Y255dzEzMWppQVBWdFF2bWNmZzBm?=
 =?utf-8?B?Qkh3Z1NISVEwRTI4YWpMRnBjMTZHeitJMENocDlpN3BKVVFhbFBSZzQwMnZk?=
 =?utf-8?B?SVhCQkFOdkNkN1hUZnJQMkJFQUZRREM0aXRFLzdQenlBZWQ0bWVMVzFOdGRM?=
 =?utf-8?B?TXRrbEtVUTNwbUpiYjBtcThRaHhkMUppTjVSdng5V0dMT09PbEpzWDNhanZV?=
 =?utf-8?B?enowdHd1MEpYUFlHZnlwR1AvOFgrWW9KWVZaK0RzNCs1cFZ5TjNrVzl6a3lj?=
 =?utf-8?B?OUlmS1JwZ1NwWGVmOG44YUhGUi9jeGtXUnVxRlV0SVZFWjZyZVNlNVUvSHov?=
 =?utf-8?B?RCs0dDVMWERVbHR4WGF4OW9YdGlVWkhZQVdsbFpnd1RRREtPbXdGTHhsa3VR?=
 =?utf-8?B?VE1HU0ZmQ0lpQkNSS0ZHWXU0NGtmQzBROFE0Y0VvbkxsTFNCTzFiL0RGb1or?=
 =?utf-8?B?WW9CWnJtZ1JVTVFTSi9JdURkd3RpbGdmejRhdWNoNDZPbjlhUFhSMTh2SHlh?=
 =?utf-8?B?ZUhkdVZoTlZqYktldnIyZmg2cHR2Q2prTVY2NVZBcG96RTFrRUdyMWdQZkJh?=
 =?utf-8?B?ZzVqdXNGK25PY0M1M3ovbnlwV3R3d1EwMXg1bzc2amVzNVdNUVhjWjkwU0c3?=
 =?utf-8?B?QkhpVmF5S3ZJLzZrNjlvSTNjOWZXZG05UmR1M3JZS1RqZERaU2NZMldZTXFl?=
 =?utf-8?B?MXJBclRWUVcwbVJMQTI1aWVxcUxGVUR6dTZ4OUpXNURDUHZRWmJmalZEVkIx?=
 =?utf-8?B?cGJlOVJLZFoxMlNub29VN2o0dnp0TXV1bnZ0dnRTbmJlZEcxRUQ1QkpYbTZZ?=
 =?utf-8?B?ZFlHZ0dUNDdZWTdoWit5VVVOeVhPUjlxaWd1SjJPenI4TG5oZU5tM3d2OHFE?=
 =?utf-8?Q?SCVjKJ33RQ6heFOIeup+ClYmf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0A8519A99950B428B78F3ACDEB9BCA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0368e9d4-6763-4f1e-8897-08da7fb11c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 17:59:48.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXBibqQ11rAOqKPQMugp21Vlsgx9UXhwq1u8E5B6UzXaRX0UM8GAwSmS+9SYVGXb+5LDXAAgePCkrxOybHkvCpvY/YE2RMqT7Zu3JogdtK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTYvMDgvMjAyMiAxODoxNiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4+ICAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCAgfCAxMSArKysrKysr
KysrKw0KPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3Jv
Y2hpcCxwY2llLWhvc3QueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+Pj4+IGluZGV4IDliMTIzYmNkMDM0Yy4uOWFj
MzRiMzNjNGIyIDEwMDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KPj4+
PiBAQCAtNzEsNiArNzEsMTcgQEAgcHJvcGVydGllczoNCj4+Pj4gICAgIG1zaS1wYXJlbnQ6DQo+
Pj4+ICAgICAgIGRlc2NyaXB0aW9uOiBNU0kgY29udHJvbGxlciB0aGUgZGV2aWNlIGlzIGNhcGFi
bGUgb2YgdXNpbmcuDQo+Pj4+DQo+Pj4+ICsgIG1pY3JvY2hpcCxheGktbS1hdHIwOg0KPj4+DQo+
Pj4gTmFtZSBpcyBub3QgaGVscGluZy4gSWYgaXQgaXMgb2Zmc2V0LCBhZGQgc3VjaCBzdWZmaXgg
KHNlZQ0KPj4+IGJyY20saXByb2MtcGNpZS55YW1sKS4NCj4+Pg0KPj4+IFVuZm9ydHVuYXRlbHkg
SSBkb24ndCBrbm93IFBDSWUgZ29vZCBlbm91Z2ggdG8ganVkZ2Ugd2hldGhlciB0aGUNCj4+PiBw
cm9wZXJ0eSBtYWtlcyBhbnkgc2Vuc2Ugb3Igc29tZSBvdGhlciByYW5nZXMtc3R5bGUgc2hvdWxk
IGJlIHVzZWQuDQo+Pg0KPj4gWXVwLCBJIHRoaW5rIGl0IGlzIHNpbWlsYXIgdG8gdGhhdC4gRXhj
ZXB0IHdlIGhhdmUgNCB0YWJsZXMgcmF0aGVyDQo+PiB0aGFuIG9uZS4NCj4gDQo+IExvb2tzIHRv
IG1lIGxpa2UgZG1hLXJhbmdlcyBpcyB0aGUgYW5zd2VyLg0KDQpIZXkgUm9iLA0KVGhhbmtzIGZv
ciBjaGltaW5nIGluLiBJIHRoaW5rIHdoYXQgSSdsbCBkbyBpczoNCi0gZGVsZXRlIHRoZSBwcm9w
ZXJ0eSBmcm9tIHRoZSBkdHMsIGFzIGl0IHNob3VsZCBuZXZlciBoYXZlIGJlZW4NCiAgdGhlcmUg
aW4gdGhlIGZpcnN0IHBsYWNlLg0KLSByZXN1Ym1pdCB0aGUgc2VyaWVzIHdpdGhvdXQgdGhpcyBw
YXRjaCB0byBjbGVhciB0aGUgZHRic19jaGVjaw0KICB3YXJuaW5ncw0KLSBhZGQgZG1hLXJhbmdl
cyBzZXBhcmF0ZWx5DQoNClRoYW5rcywNCkNvbm9yLg0KDQoNCg==
