Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB24B692F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 11:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiBOKZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 05:25:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiBOKZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 05:25:05 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5557622BC4;
        Tue, 15 Feb 2022 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644920695; x=1645525495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IPo4IcZoDHgHeS0NkJWHVboPWT+/GovYIxuUikHhUEs=;
  b=byFVwaHi+/QGT+ZaeBAZDgOcTRqPmoH/JS7SO7O3T0yGei+nVYTjSAfR
   EmSqAO6rHUpUvYgEVQak5pJGtwZ+JiYd0wpUqVlvhwc4s/AXZZ/YxHM3w
   iXKSQIrc8SniwKoyKkI7KIbmIIBeiv2d8/LgrnJEHnmklGWHeXFcBhr6v
   0=;
Received: from mail-dm3nam07lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZJVIKGoSkVCgOUS8b5Qekg4T4iXRz1hJtyfqeaJS06zlyvAezEzf73k9zXCPgQy0dw+QncU6WY64YRoQ6Ae/R26W117k+PStZngtpnP5YOYkddiAb46uZwYaFnynfK+OGoMW4zpU4BMr5VRTRI803Mb+Hl3CmsA1jYx6ByhL7ujZpMj+9aI539ii/dUvY+Bru5Y0JWN9tE0ajZX2fmxhAhyFWeXHrTgWRfmsB/YzQN5DUbZwpUqqNlH7a03Vn1ZqFNWGNwK4Aipq5GrZ0c+o3vVEOPgCCEJb2qu1wMOPvoibYnxGTdvgvERWk/iowWk1dLj2nS2GJh5SiHFFaff4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPo4IcZoDHgHeS0NkJWHVboPWT+/GovYIxuUikHhUEs=;
 b=VxORCjqd2ozqN88jFq4aJ0XDEGJy0oprnjutoHoTHoQ17Hrs9+oeLAENzDXwIllh5RKEBLaRQ9IbDAJ3lOcxGqIjRMP1THNyd7ErDyxig4E4L/SDaf/KzgVjRp6I7iGrOlB3EgoqE5ivsLLom4N+Ug4mZ4fVAjyRhNog3mMyv9NF8NjgbmuIumB67UvpBW+x2UGauC1ZgGlR5cnhkfOsCmu7NX/bLPBMo11hadLRKAyYP8OP/1hC9A9ZVS0BT94JY+Omu9Bu05FXGd8fHMv/zxQe5O+2YsBf5EbrAIDSukwPWJqFScPrgh6TIP/kWfqz10r+TCPfJT2JKlLg0JjYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CO1PR02MB8537.namprd02.prod.outlook.com (2603:10b6:303:158::14)
 by CY4PR02MB2597.namprd02.prod.outlook.com (2603:10b6:903:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 10:24:49 +0000
Received: from CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::dad:a99d:81aa:74df]) by CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::dad:a99d:81aa:74df%4]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 10:24:49 +0000
From:   "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to
 the GDSC
Thread-Topic: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to
 the GDSC
Thread-Index: AQHYH4D2kVRAuAVr+kiOr5rs9PLyiqyUbYAw
Date:   Tue, 15 Feb 2022 10:24:49 +0000
Message-ID: <CO1PR02MB8537B9CA859D2719B3BDC4FEE9349@CO1PR02MB8537.namprd02.prod.outlook.com>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
 <20220204144645.3016603-4-dmitry.baryshkov@linaro.org>
 <Yf2jRAf5UKYSMYxe@builder.lan>
 <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org>
In-Reply-To: <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12a5fcad-eb89-4d29-8353-08d9f06d65b2
x-ms-traffictypediagnostic: CY4PR02MB2597:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR02MB259766B4FC981C3D6FE87B2895349@CY4PR02MB2597.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCWdl+qVfkbj29MzWUREF7m0CUxvHrvSx4/wZATTmejPALFQx4oTGx/pQglzBeuxCpEt6w5G1Kk3zckvqh6laOI2NX+W9j2MzslAUJxf9a3nPWlXsKCda3ydkzWAgHoFiWjHeS5Yl2+4yX67+pXXKOZKUe3tE2ypV1WAxKG7His4pXKV8zi4M23kAJjK6qV3ATXqh8IJRUvYqreZ4hIIINjvUyGwgJ8FqgXXBcB25EhFWuh56HdbPhP0KED8GPABxANeoKYlqFff3pZg6d+5WK/FVA7GwfqFk7xC7CBbnTH5gwk75fyim4pnPbiuNtD82NbQresqqvqJxmmhGYG+G1DwAkBg9JfyNOn5NHYSIk+7DKhgEqv7f2Ufmt9DMDLZPRtnCmRqZTE8/Yk4NedzZiNDNNb1FGsfbIGwGpZg0ZVtjkpXsZj/n4XnwzvPJq+RFqG1TEwWx72hcgzjOmxTIBR/n2uEYsI6rFPoPggZZ24kj+qsRRCATu57vflm+JrB4gWsKfEkm2zmvg0zLcriBww3g19E2Wlm1U/WLk99ZicUfrnXvmRl/5zZrOZv26XERG+v+K30/U9yg8t1plh/qzPuMIlyM33WcR4DQYXCFMgVunLt9IlAfCrRIXt+R9B3MIhfe9rnnJ5V2uPMq13sW+5qMTZy1fF+Sjjq8miTt3rkMjS+0LTUIG1BQKA0arTnGtgjtAitYp9iQcA0vC02rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8537.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(53546011)(9686003)(316002)(5660300002)(186003)(26005)(8936002)(122000001)(2906002)(52536014)(83380400001)(6506007)(86362001)(33656002)(4326008)(55016003)(66446008)(66476007)(38100700002)(66556008)(508600001)(54906003)(38070700005)(71200400001)(8676002)(110136005)(76116006)(64756008)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjdRRnU5Qm5NTExxUkpUdWdvVlRwdTBUYmVUMld6RmxzVzlwZFIyejdPRG44?=
 =?utf-8?B?dFFhd3RHNlBUbll2VGhWdi8rOURaMEorU2hZL0NldS9vQW9XdlcwUEE5anBN?=
 =?utf-8?B?dWxSaDg5bitESGpoNDh4cEZ2T1E1WDd4VHNZTERWTEtZUWpBaHo0Z2pHRHNE?=
 =?utf-8?B?SXhUR2RoNmZkK29BUzdCcHdwOU1SNzl6NW9WbUZ1RFEyK3ZmTCtSQkpqcU91?=
 =?utf-8?B?MFVPZFJvNkcwM0Z0UmhRWHhoOFlXNC9wZEVhVUhTdCtmeE9nck9BdTRseE9I?=
 =?utf-8?B?NmxUUW9yRm92UnRGODNjdlUwZWxaK0F6VDlNTmx0UHA0YmxYWWNmSEl6SjNO?=
 =?utf-8?B?b0hQbHpyNS9sUjBTRVlvZHRMV1BsNURPbFc3elM0T0Q1dmFabFZpYldoZ0ZK?=
 =?utf-8?B?bDhPekhpUnppZ2U1c0d1WWFDbVRNaHg3Z0wwakQ3dS9MM2tVcGZFRFRjcDdl?=
 =?utf-8?B?VXB5TkFlblR3dVIzY0ZSUFJXZFFhUzV3U3VNWE8xejY1dHAzdG5tN1Y1VU9Y?=
 =?utf-8?B?Z1lrSzFpN3VmWkFLZlpJRHhrUGVGbHl2K2tUV1JYdDhWQVo5UW55bDljK2JZ?=
 =?utf-8?B?eHpWQU5BOHZ0NWVsd2cxQW1qRlp0Y3hQVFdKbEpmcllVVHFBVW96S3JXdzAy?=
 =?utf-8?B?bWNMMXptVjVSQjEwQ0F5blcwdTZTM2QydnUyb3VMM3dCQ2VRWjgrZEtnM3Q5?=
 =?utf-8?B?UWVudFVnNncxNXFuM25sNGRaWTk2dmhFVFNvcWZ4WFdQZmxPWVdZOEdOUUcw?=
 =?utf-8?B?bW00QzNtNDI3ZUlNRW5FNEFIdkpKdnc5QUZkcGZMRFZVM1J0amxMYi9TUjRD?=
 =?utf-8?B?THBaTzFxUnpsRW9EU3hJaFR5RzBucFR1Mm1HVXYzOWMyQkROajFHcWp5RU9T?=
 =?utf-8?B?R1Bvb0IvNWVGS29zUk13d3ArS3dxaDVNWFUzK1llUk04Wlp4aXVuNXl0Mm5x?=
 =?utf-8?B?dmwwQ3VYdm5hMm9QSkNPWEIzZHJUS0p3eWwydUFNR0FBRnN3VWl0dUM1TlB4?=
 =?utf-8?B?V0FORnBiOThzRTQ2Q3hKUUlHNm8zVHRHbys5QXlad1MwTlVGK1NBVTR1VEdP?=
 =?utf-8?B?YjFEQWxvN3ZRdDNQN2t1YWIxb2pxRjZNQjhJTERBSGZPSWdHYXlCaDJDcXU5?=
 =?utf-8?B?WTkxNlZoNDBOZ0lXOVRIMTBCbkwwbm5KNEZ3MWdTK0d0ZldramxDZkxVWkYx?=
 =?utf-8?B?OE9SSkJlZURlS2tEYXVJcUNnd2NBQzRkdlRnWFFDOXhiVUZRUHMwSEZsVFQ0?=
 =?utf-8?B?K05DWGIxdlJyTytROGNERkROR0lrakJZdG1sdmRSUXRVaytjbjVPL0UwNlFv?=
 =?utf-8?B?N3JNUU0rc3JzbmU4KzEzQzhEKzV3VlpvSkpTYWlaUHRJd0l6cGt6R2pFQ1J6?=
 =?utf-8?B?M2Z4ZnNzbkpBaFc3REhxZVdET083b25KUUtYQ2VMWGFhSXVncDRQZ29kSzhC?=
 =?utf-8?B?ZHlGTjZRWVpUM1dvY1lJM0dnNDRLMDh4NnE3eVg5aFU3MnhtbDI2ajQ0cjlq?=
 =?utf-8?B?ajl0djBYN3BxOWN6QS8wWFN5OWZSdCtiZ2ZkS2xBSGF4R2xpemU0dW1qUXZ0?=
 =?utf-8?B?aG1nSDhWWTBrNEtIYVU1Vk1oR2NNS3dWL3ovR0k4M3ZxVldadXV1Tjh6cmJF?=
 =?utf-8?B?OEtoTHFFTHhKTk4zUlAvTHk3TjVaNmo3V2x2NDJwcGJJR2M2bjVNUE1wcWpB?=
 =?utf-8?B?VjN0bXlXcU42YXdtQklackhYd3lNMXdJczV1TUxpS09vekp0S3BXL1NLekxF?=
 =?utf-8?B?b1FSbWJLMS80TDNjWWEzOHdHMDBTZEV1SnhDTGhESEtaT2dyMUI1MUlvTFZw?=
 =?utf-8?B?QlRtc1VrQ1loQTByWW01Q2EzMEo2YzE4c2t0c0pkYXBFTEtZdEhmeEtUVW9O?=
 =?utf-8?B?enhqa2tCcjJsdFNmNEJYZklBWkU4c2pScXYrajdVMUxVeis1Ym1yQWphcldw?=
 =?utf-8?B?SEd4UGFsRWdQbHczOG9iV2hmQWs5WVlBeEN2NjRvY3BjTHJuYTYzSGZZOFVL?=
 =?utf-8?B?V1B4dTVjQXI1Y0hsNXhIM2xudDRCcnhzVVdTa0hBNW80QmxtQmp5UDRSR3A1?=
 =?utf-8?B?K211eGRjU2x1SVRLUFZvSURqR09qUWdPVSt2dlFKL04ra2xyN3IwSjdOSm1h?=
 =?utf-8?B?MmIvL2tEUlFyMG5rbkowYVBrQ3lRZUIxeWxHYWdYY2hLMUptbjNVWUV0aStG?=
 =?utf-8?B?Wlo2TW1lRTVwSXBDOVF4cUV4YlU0dlZOczZSQ2JWbktHZm5yQUl4VjhFTWpz?=
 =?utf-8?B?c3Z6ajhjVmovWGJ1a2Izek1nTitBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8537.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a5fcad-eb89-4d29-8353-08d9f06d65b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 10:24:49.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzyFFfUIoJPrk1It+gQv4Q+ZXO/3TDn4dDgxoBWHu16YxubTcgZGC+lbjmUfNIfP7omlVxtvHQN819LQOMw/A8sta93frwfodjsBFcrXgOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2597
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEbWl0cnkgQmFyeXNoa292IDxk
bWl0cnkuYmFyeXNoa292QGxpbmFyby5vcmc+IA0KU2VudDogU2F0dXJkYXksIEZlYnJ1YXJ5IDEy
LCAyMDIyIDE6MjMgQU0NClRvOiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgUHJhc2FkIE1h
bGlzZXR0eSAoVGVtcCkgKFFVSUMpIDxxdWljX3BtYWxpc2V0QHF1aWNpbmMuY29tPg0KQ2M6IEFu
ZHkgR3Jvc3MgPGFncm9zc0BrZXJuZWwub3JnPjsgU3RhbmltaXIgVmFyYmFub3YgPHN2YXJiYW5v
dkBtbS1zb2wuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5j
b20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIFdpbGN6eT8/
c2tpIDxrd0BsaW51eC5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJy
ZS5jb20+OyBTdGVwaGVuIEJveWQgPHN3Ym95ZEBjaHJvbWl1bS5vcmc+OyBCam9ybiBIZWxnYWFz
IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgUHJhc2FkIE1hbGlzZXR0eSA8cG1hbGlzZXRAY29kZWF1
cm9yYS5vcmc+OyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgbGludXgtYXJtLW1zbUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDAzLzExXSBjbGs6IHFjb206IGdkc2M6IGFkZCBzdXBwb3J0IGZvciBjbG9ja3MgdGll
ZCB0byB0aGUgR0RTQw0KDQpPbiAwNS8wMi8yMDIyIDAxOjA1LCBCam9ybiBBbmRlcnNzb24gd3Jv
dGU6DQo+IE9uIEZyaSAwNCBGZWIgMDg6NDYgQ1NUIDIwMjIsIERtaXRyeSBCYXJ5c2hrb3Ygd3Jv
dGU6DQo+IA0KPj4gT24gbmV3ZXIgUXVhbGNvbW0gcGxhdGZvcm1zIEdDQ19QQ0lFX25fUElQRV9D
TEtfU1JDIHNob3VsZCBiZSANCj4+IGNvbnRyb2xsZWQgdG9nZXRoZXIgd2l0aCB0aGUgUENJRV9u
X0dEU0MuIFRoZSBjbG9jayBzaG91bGQgYmUgZmVkIA0KPj4gZnJvbSB0aGUgVENYTyBiZWZvcmUg
c3dpdGNoaW5nIHRoZSBHRFNDIG9mZiBhbmQgY2FuIGJlIGZlZCBmcm9tIA0KPj4gUENJRV9uX1BJ
UEVfQ0xLIG9uY2UgdGhlIEdEU0MgaXMgb24uDQo+Pg0KPj4gU2luY2UgY29tbWl0IGFhOWMwZGY5
OGMyOSAoIlBDSTogcWNvbTogU3dpdGNoIHBjaWVfMV9waXBlX2Nsa19zcmMgDQo+PiBhZnRlciBQ
SFkgaW5pdCBpbiBTQzcyODAiKSBQQ0llIGNvbnRyb2xsZXIgZHJpdmVyIHRyaWVzIHRvIG1hbmFn
ZSANCj4+IHRoaXMgb24gaXQncyBvd24sIHJlc3VsdGluZyBpbiB0aGUgbm9uLW9wdGltYWwgY29k
ZS4gRnVydGhlcm1vcmUsIGlmIA0KPj4gdGhlIGFueSBvZiB0aGUgZHJpdmVycyB3aWxsIGhhdmUg
dGhlIHNhbWUgcmVxdWlyZW1lbnRzLCB0aGUgY29kZSANCj4+IHdvdWxkIGhhdmUgdG8gYmUgZHVw
bGlhY3RlZCB0aGVyZS4NCj4+DQo+PiBNb3ZlIGhhbmRsaW5nIG9mIHN1Y2ggY2xvY2tzIHRvIHRo
ZSBHRFNDIGNvZGUsIHByb3ZpZGluZyBzcGVjaWFsIEdEU0MgDQo+PiB0eXBlLg0KPj4NCj4gDQo+
IEFzIGRpc2N1c3NlZCBvbiBJUkMsIEknbSBpbmNsaW5lZCBub3QgdG8gdGFrZSB0aGlzLCBiZWNh
dXNlIGxvb2tzIHRvIA0KPiBtZSB0byBiZSB0aGUgc2FtZSBzaXR1YXRpb24gdGhhdCB3ZSBoYXZl
IHdpdGggYWxsIEdEU0NzIGluIFNNODM1MCBhbmQgDQo+IG9ud2FyZHMgLSB0aGF0IHNvbWUgY2xv
Y2tzIG11c3QgYmUgcGFya2VkIG9uIGEgc2FmZSBwYXJlbnQgYmVmb3JlIHRoZSANCj4gYXNzb2Np
YXRlZCBHRFNDIGNhbiBiZSB0b2dnbGVkLg0KPiANCj4gUHJhc2FkLCBwbGVhc2UgYWR2aWNlIG9u
IHdoYXQgdGhlIGFjdHVhbCByZXF1aXJlbWVudHMgYXJlIHdydCB0aGUgDQo+IGdjY19waXBlX2Ns
a19zcmMuIFdoZW4gZG9lcyBpdCBuZWVkIHRvIHByb3ZpZGUgYSB2YWxpZCBzaWduYWwgYW5kIHdo
ZW4gDQo+IGRvZXMgaXQgbmVlZCB0byBiZSBwYXJrZWQ/DQoNCltFeGN1c2UgbWUgZm9yIHRoZSBk
dXBsaWNhdGUsIFByYXNhZCdzIGVtYWlsIHdhcyBib3VuY2luZ10NCg0KUHJhc2FkLCBhbnkgY29t
bWVudHM/DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEJqb3JuDQo+IA0KDQpIaSAgRG1pdHJ5LCANCg0K
R3JlZXRpbmdzICEhIQ0KDQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UsICB0aGVyZSB3YXMg
YW4gaXNzdWUgd2l0aCBteSBtYWlsIHNvIEkgY291bGRu4oCZdCByZWNlaXZlIHRoZSB1cGRhdGVz
IHByb3Blcmx5LiBOb3cgaXNzdWUgaXMgcmVzb2x2ZWQuDQpJIGFtIGluIGRpc2N1c3Npb24gd2l0
aCBpbnRlcm5hbCB0ZWFtIHRvIGtub3cgbW9yZSBhYm91dCB0aGlzLiBJIHdpbGwgdXBkYXRlIG15
IGNvbW1lbnRzIGFmdGVyIHRoaXMgZGlzY3Vzc2lvbi4NCg0KVGhhbmtzDQotUHJhc2FkIA0KDQo+
PiBDYzogUHJhc2FkIE1hbGlzZXR0eSA8cG1hbGlzZXRAY29kZWF1cm9yYS5vcmc+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBEbWl0cnkgQmFyeXNoa292IDxkbWl0cnkuYmFyeXNoa292QGxpbmFyby5vcmc+
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9jbGsvcWNvbS9nZHNjLmMgfCA0MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBkcml2ZXJzL2Nsay9xY29tL2dkc2Mu
aCB8IDE0ICsrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9xY29tL2dkc2MuYyBiL2RyaXZl
cnMvY2xrL3Fjb20vZ2RzYy5jIGluZGV4IA0KPj4gN2UxZGQ4Y2NmYTM4Li45OTEzZDFiNzA5NDcg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Nsay9xY29tL2dkc2MuYw0KPj4gKysrIGIvZHJpdmVy
cy9jbGsvcWNvbS9nZHNjLmMNCj4+IEBAIC00NSw2ICs0NSw3IEBADQo+PiAgICNkZWZpbmUgVElN
RU9VVF9VUwkJNTAwDQo+PiAgIA0KPj4gICAjZGVmaW5lIGRvbWFpbl90b19nZHNjKGRvbWFpbikg
Y29udGFpbmVyX29mKGRvbWFpbiwgc3RydWN0IGdkc2MsIA0KPj4gcGQpDQo+PiArI2RlZmluZSBk
b21haW5fdG9fcGlwZV9jbGtfZ2RzYyhkb21haW4pIGNvbnRhaW5lcl9vZihkb21haW4sIHN0cnVj
dCANCj4+ICtwaXBlX2Nsa19nZHNjLCBiYXNlLnBkKQ0KPj4gICANCj4+ICAgZW51bSBnZHNjX3N0
YXR1cyB7DQo+PiAgIAlHRFNDX09GRiwNCj4+IEBAIC01NDksMyArNTUwLDQzIEBAIGludCBnZHNj
X2d4X2RvX25vdGhpbmdfZW5hYmxlKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZG9tYWluKQ0K
Pj4gICAJcmV0dXJuIDA7DQo+PiAgIH0NCj4+ICAgRVhQT1JUX1NZTUJPTF9HUEwoZ2RzY19neF9k
b19ub3RoaW5nX2VuYWJsZSk7DQo+PiArDQo+PiArLyoNCj4+ICsgKiBTcGVjaWFsIG9wZXJhdGlv
bnMgZm9yIEdEU0NzIHdpdGggYXR0YWNoZWQgcGlwZSBjbG9ja3MuDQo+PiArICogVGhlIGNsb2Nr
IHNob3VsZCBiZSBwYXJrZWQgdG8gc2FmZSBzb3VyY2UgKHRjeG8pIGJlZm9yZSB0dXJuaW5nIA0K
Pj4gK29mZiB0aGUgR0RTQw0KPj4gKyAqIGFuZCBjYW4gYmUgc3dpdGNoZWQgb24gYXMgc29vbiBh
cyB0aGUgR0RTQyBpcyBvbi4NCj4+ICsgKg0KPj4gKyAqIFdlIHJlbW92ZSByZXNwZWN0aXZlIGNs
b2NrIHNvdXJjZXMgZnJvbSBjbG9ja3MgbWFwIGFuZCBoYW5kbGUgdGhlbSBtYW51YWxseS4NCj4+
ICsgKi8NCj4+ICtpbnQgZ2RzY19waXBlX2VuYWJsZShzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4g
KmRvbWFpbikgew0KPj4gKwlzdHJ1Y3QgcGlwZV9jbGtfZ2RzYyAqc2MgPSBkb21haW5fdG9fcGlw
ZV9jbGtfZ2RzYyhkb21haW4pOw0KPj4gKwlpbnQgaSwgcmV0Ow0KPj4gKw0KPj4gKwlyZXQgPSBn
ZHNjX2VuYWJsZShkb21haW4pOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+
ICsNCj4+ICsJZm9yIChpID0gMDsgaTwgc2MtPm51bV9jbG9ja3M7IGkrKykNCj4+ICsJCXJlZ21h
cF91cGRhdGVfYml0cyhzYy0+YmFzZS5yZWdtYXAsIHNjLT5jbG9ja3NbaV0ucmVnLA0KPj4gKwkJ
CQlCSVQoc2MtPmNsb2Nrc1tpXS5zaGlmdCArIHNjLT5jbG9ja3NbaV0ud2lkdGgpIC0gQklUKHNj
LT5jbG9ja3NbaV0uc2hpZnQpLA0KPj4gKwkJCQlzYy0+Y2xvY2tzW2ldLm9uX3ZhbHVlIDw8IHNj
LT5jbG9ja3NbaV0uc2hpZnQpOw0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArRVhQ
T1JUX1NZTUJPTF9HUEwoZ2RzY19waXBlX2VuYWJsZSk7DQo+PiArDQo+PiAraW50IGdkc2NfcGlw
ZV9kaXNhYmxlKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZG9tYWluKSB7DQo+PiArCXN0cnVj
dCBwaXBlX2Nsa19nZHNjICpzYyA9IGRvbWFpbl90b19waXBlX2Nsa19nZHNjKGRvbWFpbik7DQo+
PiArCWludCBpOw0KPj4gKw0KPj4gKwlmb3IgKGkgPSBzYy0+bnVtX2Nsb2NrcyAtIDE7IGkgPj0g
MDsgaS0tKQ0KPj4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKHNjLT5iYXNlLnJlZ21hcCwgc2MtPmNs
b2Nrc1tpXS5yZWcsDQo+PiArCQkJCUJJVChzYy0+Y2xvY2tzW2ldLnNoaWZ0ICsgc2MtPmNsb2Nr
c1tpXS53aWR0aCkgLSBCSVQoc2MtPmNsb2Nrc1tpXS5zaGlmdCksDQo+PiArCQkJCXNjLT5jbG9j
a3NbaV0ub2ZmX3ZhbHVlIDw8IHNjLT5jbG9ja3NbaV0uc2hpZnQpOw0KPj4gKw0KPj4gKwkvKiBJ
biBjYXNlIG9mIGFuIGVycm9yIGRvIG5vdCB0cnkgdHVybmluZyB0aGUgY2xvY2tzIGFnYWluLiBX
ZSBjYW4gbm90IGJlIHN1cmUgYWJvdXQgdGhlIEdEU0Mgc3RhdGUuICovDQo+PiArCXJldHVybiBn
ZHNjX2Rpc2FibGUoZG9tYWluKTsNCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoZ2RzY19w
aXBlX2Rpc2FibGUpOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3Fjb20vZ2RzYy5oIGIv
ZHJpdmVycy9jbGsvcWNvbS9nZHNjLmggaW5kZXggDQo+PiBkN2NjNGMyMWE5ZDQuLmIxYTJmMGFi
ZTQxYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xrL3Fjb20vZ2RzYy5oDQo+PiArKysgYi9k
cml2ZXJzL2Nsay9xY29tL2dkc2MuaA0KPj4gQEAgLTY4LDExICs2OCwyNSBAQCBzdHJ1Y3QgZ2Rz
Y19kZXNjIHsNCj4+ICAgCXNpemVfdCBudW07DQo+PiAgIH07DQo+PiAgIA0KPj4gK3N0cnVjdCBw
aXBlX2Nsa19nZHNjIHsNCj4+ICsJc3RydWN0IGdkc2MgYmFzZTsNCj4+ICsJaW50IG51bV9jbG9j
a3M7DQo+PiArCXN0cnVjdCB7DQo+PiArCQl1MzIgcmVnOw0KPj4gKwkJdTMyIHNoaWZ0Ow0KPj4g
KwkJdTMyIHdpZHRoOw0KPj4gKwkJdTMyIG9mZl92YWx1ZTsNCj4+ICsJCXUzMiBvbl92YWx1ZTsN
Cj4+ICsJfSBjbG9ja3NbXTsNCj4+ICt9Ow0KPj4gKw0KPj4gICAjaWZkZWYgQ09ORklHX1FDT01f
R0RTQw0KPj4gICBpbnQgZ2RzY19yZWdpc3RlcihzdHJ1Y3QgZ2RzY19kZXNjICpkZXNjLCBzdHJ1
Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKiwNCj4+ICAgCQkgIHN0cnVjdCByZWdtYXAgKik7DQo+
PiAgIHZvaWQgZ2RzY191bnJlZ2lzdGVyKHN0cnVjdCBnZHNjX2Rlc2MgKmRlc2MpOw0KPj4gICBp
bnQgZ2RzY19neF9kb19ub3RoaW5nX2VuYWJsZShzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmRv
bWFpbik7DQo+PiAraW50IGdkc2NfcGlwZV9lbmFibGUoc3RydWN0IGdlbmVyaWNfcG1fZG9tYWlu
ICpkb21haW4pOyBpbnQgDQo+PiArZ2RzY19waXBlX2Rpc2FibGUoc3RydWN0IGdlbmVyaWNfcG1f
ZG9tYWluICpkb21haW4pOw0KPj4gICAjZWxzZQ0KPj4gICBzdGF0aWMgaW5saW5lIGludCBnZHNj
X3JlZ2lzdGVyKHN0cnVjdCBnZHNjX2Rlc2MgKmRlc2MsDQo+PiAgIAkJCQlzdHJ1Y3QgcmVzZXRf
Y29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg0KDQotLSANCldp
dGggYmVzdCB3aXNoZXMNCkRtaXRyeQ0K
