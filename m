Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39830316DF8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhBJSHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 13:07:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35508 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhBJSFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 13:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612980306; x=1644516306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJ+9Kkc1J5DopGIRKe4YqGARUu/skXfsV21LdBZrulw=;
  b=Zc+drFLZjIWCHA1/93XSzFJhzrqtOM75Q0lEnkabfUe9oaAhpSlTdbbv
   EdMnKxPnE8zC1j1pfF5luL65XjFdJZFdJ8ZCdhDAZgWLOYyQMI3QPuENF
   JBOQEWxCgXfpHkn2I1717l1zSDn32gVXSulkhgyee5WE7ItFCpdzoCMY0
   x4Z0vTAzebJrvhEDeNYClwLuQg72vbHrIS2X7Wl/0SQu4Z8siwg9cshXn
   FcBRWqGUnLefln0DLP+DBxHeQk1J+yg/Yu0NsPHqKMNxdond5pKW50ZH5
   IWuXMRVqlJ4SIUfsHmy+6uBvTus6Wyu42ywpcE2cy608yXAAU8deXShe4
   Q==;
IronPort-SDR: LlMoBaDMnFdhuozyciwETT3M9F4J+vgS5Dc+7A9WSBoBsrIW+WTX8nTQ4UWKKb0eazVgOMfiA3
 lcARfWZayqoRqiAAB/i7lq0ONRh9ftxb8C3T/HQIrIWFsGXyeqIpZ6XULrulf805S+G/cnOI6+
 DqoCnKyzlQdPaOsvvBfo2V9da0kZhUR/hEoPVVCkjsIkjXasXmVzuzN1CQbdGUqVzPVyKL+V/9
 pcnOahgrC37EjpKvX9/hmCeBsxV25+3SnuPRDL/jxFbdfhg8LaRK9bRhgmU+VOYsnuC1GcoiyJ
 VV4=
X-IronPort-AV: E=Sophos;i="5.81,168,1610434800"; 
   d="scan'208";a="106153187"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 11:03:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 11:03:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 10 Feb 2021 11:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeCiLASgnJanIyDlABuFRmZr5MkSCPFShf0dZrY+JStXUcZXvZQVkTR2Qwxt82cM4lfqh06JHhksguWF67aMYVsU+O3x/eMBGk856mmWwHuIqhCmeHr0PZtNFtV3vu79BpZVb7q1CER9bB/YUBpZr9i77Bm+6bz/4/Tu/s9qVxd+ugZ8MZnRzznWR8oaXvjnQAXxIZ0UcnDq9BV+PmwQ46Lxtk4/cPdNxrzyk/c8W7TrbjVkBwvlJDOr286JljqagMCyP+grbJc7BJnGLoFbHer1vWCVWN8zHl3nhqwhYUZusD67qXa2n7bH2pzu01i+CfavLaZxJ74h4zzQxNVcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+9Kkc1J5DopGIRKe4YqGARUu/skXfsV21LdBZrulw=;
 b=SPO8TT8IX3mVK7fx4c8NblZrthNsuGWCoIgtrSTei3VXYyVoFkHGJv0WsdbXgXeBhne0/2YYUfbnhx+R8HG6deDAamsg+fdE4WE2ZcSp1WKwc3aWkf8BYUYSJm1AzqAV6EkPwSG116NdV4NI4s6NTYPvBi6zVUHpU57QEt6CfiF8PUGlNi125CsaIeDaMKTnLzu29Qb+mzhQAj71cZWs8fgsG4Abiv5rf91r4bWC0alBspyAF88daknkIXJIW8q09V3M8YtA8+WOLpJrWxb98/0n/jY9DoUZY+AKuVOkbRTHvSsU2u1R6iwPWvq19S5FhKu0AebkWWpVjXH8S5ED9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+9Kkc1J5DopGIRKe4YqGARUu/skXfsV21LdBZrulw=;
 b=DbcWfPYEjgcCjBFDe7oi26ugKtvCCI7MUEqCUZI8TIKVyIuNgzRrSpDmi7lxRAttl6wtRNvTI+1TaXkqqx2dUfiBn4Yf8aSbv5T7INGUvBgEYLW8Ni18N6vWsRwCGf41GLFUqndA0anaxe2BNKpyW5OSfs0SOheS/T8pNjk0fP8=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB3856.namprd11.prod.outlook.com (2603:10b6:208:ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 18:03:36 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30%5]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 18:03:36 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <cbrowy@avery-design.com>, <hch@infradead.org>,
        <dan.j.williams@intel.com>, <david@redhat.com>,
        <rientjes@google.com>, <ira.weiny@intel.com>, <jcm@jonmasters.org>,
        <Jonathan.Cameron@huawei.com>, <rafael.j.wysocki@intel.com>,
        <rdunlap@infradead.org>, <vishal.l.verma@intel.com>,
        <jgroves@micron.com>, <sean.v.kelley@intel.com>,
        <Ahmad.Danesh@microchip.com>, <Varada.Dighe@microchip.com>,
        <Kirthi.Shenoy@microchip.com>, <Sanjay.Goyal@microchip.com>
Subject: RE: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Topic: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Index: AQHW/0AqZCOVul459UanKz+acVTCvapRfUwQgAAdewCAAAx2IA==
Date:   Wed, 10 Feb 2021 18:03:35 +0000
Message-ID: <MN2PR11MB36450EFC1729D9A4CDB2FB27888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com>
 <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210164904.lfhtfvlyeypfpjhe@intel.com>
In-Reply-To: <20210210164904.lfhtfvlyeypfpjhe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [142.134.145.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1be68f97-d6dd-421d-dcb6-08d8cdee2fe3
x-ms-traffictypediagnostic: MN2PR11MB3856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB385637DA454C5F0B17DD800E888D9@MN2PR11MB3856.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGw5lSVDsEA26xJgkcrh4HeKvKdBjMhFt+K32htYVJVHtlzN1FBdgpmVMku8D12eRlm1hqT1m3Kp8WcmF7hx5kMtjIbVHaUWCgaOu4KIrzqZpUtu+AxdMm5T1G0FtM4Ni/1t6uh4Otud9iwMSVHebC2ox1QWUyKmw6Vf7oY8gliNdCcqFiq2mxaxZDWtVdMtoLPsBb4OskQTPLwL3fkN32C9cECVPB1BdAuRRH1giWYVIK28Ip/hPzCzllN1HIdoeWNARVSTFTpRy/IIBvJTSQcnhYx/7AvWrQtaZjARn5bIvHDrLgG8JE/MIm0riRtkR7X1Qgr3YfQu6RYCpnIqsC1ZFBMFb0+vmqF47BHYvBlfMk/UjE0Svv/1qYel5AKPYhXy5wvMXlug5xcf/PgX9+i57Uq1dDW5veSYRbnSiIFzPuRXuTawtXMu+1cpMbPqTYUq1j9TIfS21mu1RFrQjYQPXccDlubH258EN7SuhMo2bVY+s5pHu112D4pTvGZCJ4FR4UQ8kmQb9oDpWRSqbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39860400002)(33656002)(9686003)(6506007)(478600001)(8936002)(55016002)(54906003)(7416002)(316002)(8676002)(71200400001)(66446008)(66556008)(66476007)(66946007)(76116006)(64756008)(86362001)(26005)(2906002)(7696005)(186003)(4326008)(83380400001)(6916009)(52536014)(5660300002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d25HNHhUbkxmWUN4STR6d0NTVHhlTnVqNWtRb3JhOEdDWms3TG5sWWNCd0hI?=
 =?utf-8?B?c1JOdDJGcVdsa1dxMS8wS3JWU3U5c0YyS2dlWk5DbGM0d2Vzd1RXTEVRQ045?=
 =?utf-8?B?NDhrYUIxbWovWGtxY0M1cGpOR2dlZ1JFcjFYcU5YYStIajhmU3hxNUNDbUR6?=
 =?utf-8?B?cjZ0SGNmOW52ZThSVmRlYXRZQzRaRmYwckZPQ0UzSStLVWQxN2J3clBNelM1?=
 =?utf-8?B?VThzbFd2V1BFNDRETEp6L0U2aHg4ZUR0c05Lbm1xeGRoYmIzTEVKVTVlTGlm?=
 =?utf-8?B?Qmw5cGh3b3NtKzJxQjNXZXZ6Sy9EZHF3NWEwVmlOTUU4anRzUm12djVPeWY1?=
 =?utf-8?B?aXQyZTdwVzJEWG4zZThZelp2M1F4Y0xPdUc4Mk90Si9RWnBQL2NJVVJ1N0RP?=
 =?utf-8?B?czVQTmsvakpQQk9wODJFcUZlUGhtZE9CSFJ4UC9hVTRhUGpGaU9mS2VUblFn?=
 =?utf-8?B?OEtUQmdWT213WGFFQUpiRlNRQ0VjaFQ3Zm1ENlMxVGptdWVqUlBRTzk5eUhw?=
 =?utf-8?B?d0FnV3RCMEEvNXlxdE1TNnVuZnlkSGxvZklQeE5NRExaYW1PRVFlUkhGa0FZ?=
 =?utf-8?B?dkhVZThPV2N5VmljQ0c5d2ZWTkxoengrWFpaZlJqa3lqQytkZ0J4VWFqTUVI?=
 =?utf-8?B?bnhsQkd0aUlQdU03cFVrUDJtbEV4TG50dHFOR0FaZWRBKzkxTmczcEFFZ3I3?=
 =?utf-8?B?MC9vYXRtUzNMbXIvMytCdnMxZnJ0NUVDbFJHWFJRczlORGpoRVVmbWIxYWxl?=
 =?utf-8?B?QkVVQVcvVmxaRi8vVGdldFlLakhrRSsxcDBYY0NVQndtSk1jQW50a1RJYTBJ?=
 =?utf-8?B?Q3hGdW9oZERsdXV1d0wwd000ZXd0NHN6T1NHaGVpUUxtMjdvei9HSEdqVmxI?=
 =?utf-8?B?MWlsbUFBeGNPejY5emhKRjlod016dzVTVmhvUWZvYjlQNXZyT1hFZ1RINkRM?=
 =?utf-8?B?ZDZpU3FvMzFXWkxxcXJQN3BOOGdzLzF3S3lFaDJoK096RjN0am5MZGhpWjJU?=
 =?utf-8?B?eHlxYTVDZEE1NzlPZzN0Sk1zUXhYSmNRRmVzeWFldFBGbDFWaU90cm43bVd2?=
 =?utf-8?B?M3B0TENQUmRHbzFVSW92OWUzRlRKRG1DNlpjK2pwaWNZV3YxcTdPM1hUSVVC?=
 =?utf-8?B?d1ZWQWh3d1RVVVVtb0I3SEV5VnljQUdhdXZlWkovN25RSzN3LytXYVNIRnVY?=
 =?utf-8?B?UDVsb1lIWFhDblFPMTRBeUNyOTVhMmp5Zi81RVJVVjk4S2RSa1NBRXJWTFJx?=
 =?utf-8?B?RTFsWEt4b0s5cThRaCtJYXB5dmVFK0hqR3o1V3Q3czZhYzJJT3VRSjh4ZE5C?=
 =?utf-8?B?WFI4enFIdkdlMTBpZkMxSWNYcXZjL2orOXJaTDg3anFXV3NncHdaUDVqSTZI?=
 =?utf-8?B?NnBMUmdMN3gwSjA0S3QweTFadHZYSXJSQzNDVWlXTVNzSW43cC9ITjRkdUt4?=
 =?utf-8?B?dU5tNXkyWDRsOGdGT1ROWGMraytLMVk4WlFVb1hJMmQ5UTBJaGhJcmZJbm9M?=
 =?utf-8?B?M0VWM3EzNjl4KzdrdUtOUEhHbDNoL3NGR0dZWTNxcEZzbFZ3ckZYRDVPeFJ0?=
 =?utf-8?B?QldQcEtXREdIcG8rSGhWY2tkUG5tblQ3eXZHaUd2eDlCcUZJN2UrbzErelFP?=
 =?utf-8?B?OTkyZmNPZFJnQWdvYzBsSnlkN0N1eDl0TjAxd1lLUFpJK2d6OGJsUzN0eWs0?=
 =?utf-8?B?Umx1dEhCT3RTNExmeFpSczBTdGJhVWo0a2dubXhaUXRYVkJvd3JlY2hwWjBZ?=
 =?utf-8?Q?06A+2RcRBfZxGBYVjJE4xf45yBph+wqvmaM7ga9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be68f97-d6dd-421d-dcb6-08d8cdee2fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 18:03:35.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zu1rEbW7cHnnKLjEh6ri4r0xUbti1DgOO+SIyiDf2gBThJLk7DcIF8A8claAAIPeivUE8DStZX1m4ipS7ibzZ4nFkuOboeB89tfd6hfZ+Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3856
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL0tjb25maWcgYi9kcml2ZXJzL2N4bC9LY29u
ZmlnDQo+ID4gPiBpbmRleCBjNGJhM2FhMGEwNWQuLjA4ZWFhOGU1MjA4MyAxMDA2NDQNCj4gPiA+
IC0tLSBhL2RyaXZlcnMvY3hsL0tjb25maWcNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY3hsL0tjb25m
aWcNCj4gPiA+IEBAIC0zMyw2ICszMywyNCBAQCBjb25maWcgQ1hMX01FTQ0KPiA+ID4NCj4gPiA+
ICAgICAgICAgICBJZiB1bnN1cmUgc2F5ICdtJy4NCj4gPiA+DQo+ID4gPiArY29uZmlnIENYTF9N
RU1fUkFXX0NPTU1BTkRTDQo+ID4gPiArICAgICAgIGJvb2wgIlJBVyBDb21tYW5kIEludGVyZmFj
ZSBmb3IgTWVtb3J5IERldmljZXMiDQo+ID4gPiArICAgICAgIGRlcGVuZHMgb24gQ1hMX01FTQ0K
PiA+ID4gKyAgICAgICBoZWxwDQo+ID4gPiArICAgICAgICAgRW5hYmxlIENYTCBSQVcgY29tbWFu
ZCBpbnRlcmZhY2UuDQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgVGhlIENYTCBkcml2ZXIgaW9j
dGwgaW50ZXJmYWNlIG1heSBhc3NpZ24gYSBrZXJuZWwgaW9jdGwgY29tbWFuZA0KPiA+ID4gKyAg
ICAgICAgIG51bWJlciBmb3IgZWFjaCBzcGVjaWZpY2F0aW9uIGRlZmluZWQgb3Bjb2RlLiBBdCBh
bnkgZ2l2ZW4gcG9pbnQgaW4NCj4gPiA+ICsgICAgICAgICB0aW1lIHRoZSBudW1iZXIgb2Ygb3Bj
b2RlcyB0aGF0IHRoZSBzcGVjaWZpY2F0aW9uIGRlZmluZXMgYW5kIGEgZGV2aWNlDQo+ID4gPiAr
ICAgICAgICAgbWF5IGltcGxlbWVudCBtYXkgZXhjZWVkIHRoZSBrZXJuZWwncyBzZXQgb2YgYXNz
b2NpYXRlZCBpb2N0bCBmdW5jdGlvbg0KPiA+ID4gKyAgICAgICAgIG51bWJlcnMuIFRoZSBtaXNt
YXRjaCBpcyBlaXRoZXIgYnkgb21pc3Npb24sIHNwZWNpZmljYXRpb24gaXMgdG9vIG5ldywNCj4g
PiA+ICsgICAgICAgICBvciBieSBkZXNpZ24uIFdoZW4gcHJvdG90eXBpbmcgbmV3IGhhcmR3YXJl
LCBvciBkZXZlbG9waW5nIC8NCj4gPiA+IGRlYnVnZ2luZw0KPiA+ID4gKyAgICAgICAgIHRoZSBk
cml2ZXIgaXQgaXMgdXNlZnVsIHRvIGJlIGFibGUgdG8gc3VibWl0IGFueSBwb3NzaWJsZSBjb21t
YW5kIHRvDQo+ID4gPiArICAgICAgICAgdGhlIGhhcmR3YXJlLCBldmVuIGNvbW1hbmRzIHRoYXQg
bWF5IGNyYXNoIHRoZSBrZXJuZWwgZHVlIHRvIHRoZWlyDQo+ID4gPiArICAgICAgICAgcG90ZW50
aWFsIGltcGFjdCB0byBtZW1vcnkgY3VycmVudGx5IGluIHVzZSBieSB0aGUga2VybmVsLg0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgICAgIElmIGRldmVsb3BpbmcgQ1hMIGhhcmR3YXJlIG9yIHRoZSBk
cml2ZXIgc2F5IFksIG90aGVyd2lzZSBzYXkgTi4NCj4gPg0KPiA+IEJsb2NraW5nIFJBVyBjb21t
YW5kcyBieSBkZWZhdWx0IHdpbGwgcHJldmVudCB2ZW5kb3JzIGZyb20gZGV2ZWxvcGluZyB1c2Vy
DQo+ID4gc3BhY2UgdG9vbHMgdGhhdCB1dGlsaXplIHZlbmRvciBzcGVjaWZpYyBjb21tYW5kcy4g
VmVuZG9ycyBvZiBDWEwubWVtIGRldmljZXMNCj4gPiBzaG91bGQgdGFrZSBvd25lcnNoaXAgb2Yg
ZW5zdXJpbmcgYW55IHZlbmRvciBkZWZpbmVkIGNvbW1hbmRzIHRoYXQgY291bGQgY2F1c2UNCj4g
PiB1c2VyIGRhdGEgdG8gYmUgZXhwb3NlZCBvciBjb3JydXB0ZWQgYXJlIGRpc2FibGVkIGF0IHRo
ZSBkZXZpY2UgbGV2ZWwgZm9yDQo+ID4gc2hpcHBpbmcgY29uZmlndXJhdGlvbnMuDQo+IA0KPiBU
aGFua3MgZm9yIGJyaW5pbmcgdGhpcyB1cCBBcmllbC4gSWYgdGhlcmUgaXMgYSByZWNvbW1lbmRh
dGlvbiBvbiBob3cgdG8gY29kaWZ5DQo+IHRoaXMsIEkgd291bGQgY2VydGFpbmx5IGxpa2UgdG8g
a25vdyBiZWNhdXNlIHRoZSBleHBsYW5hdGlvbiB3aWxsIGJlIGxvbmcuDQo+IA0KPiAtLS0NCj4g
DQo+IFRoZSBiYWNrZ3JvdW5kOg0KPiANCj4gVGhlIGVuYWJsaW5nL2Rpc2FibGluZyBvZiB0aGUg
S2NvbmZpZyBvcHRpb24gaXMgZHJpdmVuIGJ5IHRoZSBkaXN0cmlidXRpb24NCj4gYW5kL29yIHN5
c3RlbSBpbnRlZ3JhdG9yLiBFdmVuIGlmIHdlIG1hZGUgdGhlIGRlZmF1bHQgJ3knLCBub3RoaW5n
IHN0b3BzIHRoZW0NCj4gZnJvbSBjaGFuZ2luZyB0aGF0LiBpZiB5b3UgYXJlIHVzaW5nIHRoaXMg
ZHJpdmVyIGluIHByb2R1Y3Rpb24gYW5kIGluc2lzdCBvbg0KPiB1c2luZyBSQVcgY29tbWFuZHMs
IHlvdSBhcmUgZnJlZSB0byBjYXJyeSBhcm91bmQgYSBzbWFsbCBwYXRjaCB0byBnZXQgcmlkIG9m
IHRoZQ0KPiBXQVJOIChpdCBpcyBhIG9uZS1saW5lcikuDQo+IA0KPiBUbyByZWNhcCB3aHkgdGhp
cyBpcyBpbiBwbGFjZSAtIHRoZSBkcml2ZXIgb3ducyB0aGUgc2FuY3RpdHkgb2YgdGhlIGRldmlj
ZSBhbmQNCj4gdGhlcmVmb3JlIGEgW2xhcmdlXSBwYXJ0IG9mIHRoZSB3aG9sZSBzeXN0ZW0uIFdo
YXQgd2UgY2FuIGRvIGFzIGRyaXZlciB3cml0ZXJzDQo+IGlzIGZpZ3VyZSBvdXQgdGhlIHNldCBv
ZiBjb21tYW5kcyB0aGF0IGFyZSAic2FmZSIgYW5kIGFsbG93IHRob3NlLiBBc2lkZSBmcm9tDQo+
IGJlaW5nIGFibGUgdG8gdmFsaWRhdGUgdGhlbSwgd2UncmUgYWJsZSB0byBtZWRpYXRlIHRoZW0g
d2l0aCBvdGhlciBwYXJhbGxlbA0KPiBvcGVyYXRpb25zIHRoYXQgbWlnaHQgY29uZmxpY3QuIFdl
IGdhaW4gdGhlIGFiaWxpdHkgdG8gc3F1aW50IGV4dHJhIGhhcmQgYXQgYnVnDQo+IHJlcG9ydHMu
IFdlIHByb3ZpZGUgYSByZWFzb24gdG8gdHJ5IHRvIHVzZSBhIHdlbGwgZGVmaW5lZCBwYXJ0IG9m
IHRoZSBzcGVjLg0KPiBSZWFsaXppbmcgdGhhdCBvbmx5IGFsbG93aW5nIHRoYXQgc21hbGwgc2V0
IG9mIGNvbW1hbmRzIGluIGEgcmFwaWRseSBncm93aW5nDQo+IGVjb3N5c3RlbSBpcyBub3QgYSB3
ZWxjb21pbmcgQVBJOyB3ZSBkZWNpZGVkIG9uIFJBVy4NCj4gDQo+IFZlbmRvciBjb21tYW5kcyBj
YW4gYmUgb25lIG9mIHR3byB0eXBlczoNCj4gMS4gU29tZSBmdW5jdGlvbmFsaXR5IHByb2JhYmx5
IG1vc3QgdmVuZG9ycyB3YW50Lg0KPiAyLiBGdW5jdGlvbmFsaXR5IHRoYXQgaXMgcmVhbGx5IHNp
bmdsZSB2ZW5kb3Igc3BlY2lmaWMuDQo+IA0KPiBIb3BlZnVsbHkgd2UgY2FuIGFncmVlIHRoYXQg
dGhlIHBhdGggZm9yIGNhc2UgIzEgaXMgdG8gd29yayB3aXRoIHRoZSBjb25zb3J0aXVtDQo+IHRv
IHN0YW5kYXJkaXplIGEgY29tbWFuZCB0aGF0IGRvZXMgd2hhdCBpcyBuZWVkZWQgYW5kIHRoYXQg
Y2FuIGV2ZW50dWFsbHkgYmVjb21lDQo+IHBhcnQgb2YgVUFQSS4gVGhlIHNpdHVhdGlvbiBpcyB1
bmZvcnR1bmF0ZSwgYnV0IHRlbXBvcmFyeS4gSWYgeW91IHdvbid0IGJlIGFibGUNCj4gdG8gdXBn
cmFkZSB5b3VyIGtlcm5lbCwgcGF0Y2ggb3V0IHRoZSBXQVJOIGFzIGFib3ZlLg0KPiANCj4gVGhl
IHNlY29uZCBzaXR1YXRpb24gaXMgaW50ZXJlc3RpbmcgYW5kIGRvZXMgbmVlZCBzb21lIG1vcmUg
dGhvdWdodCBhbmQNCj4gZGlzY3Vzc2lvbi4NCj4gDQo+IC0tLQ0KPiANCj4gSSBzZWUgMyByZWFs
aXN0aWMgb3B0aW9ucyBmb3IgdHJ1bHkgdmVuZG9yIHNwZWNpZmljIGNvbW1hbmRzLg0KPiAxLiBU
b3VnaCBub29naWVzLiBWZW5kb3JzIGFyZW4ndCBzcGVjaWFsIGFuZCB0aGV5IHNob3VsZG4ndCBk
byB0aGF0Lg0KPiAyLiBtb2RwYXJhbSB0byBkaXNhYmxlIHRoZSBXQVJOIGZvciBzcGVjaWZpYyBk
ZXZpY2VzIChsZXQgdGhlIHN5c2FkbWluIGRlY2lkZSkNCj4gMy4gVHJ5IHRvIG1ha2UgdGhlbSBw
YXJ0IG9mIFVBUEkuDQo+IA0KPiBUaGUgcmlnaHQgYW5zd2VyIHRvIG1lIGlzICMxLCBidXQgSSBh
bHNvIHJlYWxpemUgSSBsaXZlIGluIHRoZSByZWFsIHdvcmxkLg0KPiANCj4gIzIgcHJvdmlkZXMg
dG9vIG11Y2ggZmxleGliaWxpdHkuIFZlbmRvcnMgd2lsbCBqdXN0IGRvIHdoYXQgdGhleSBwbGVh
c2UgYW5kDQo+IGRpc3Ryb3MgYW5kL29yIGludGVncmF0b3JzIHdpbGwgYmUgc2VlbiBhcyBob3N0
aWxlIGlmIHRoZXkgZG9uJ3QgYWNjb21tb2RhdGUuDQo+IA0KPiBJIGxpa2UgIzMsIGJ1dCBJIGhh
dmUgYSBmZWVsaW5nIG5vdCBldmVyeW9uZSB3aWxsIGFncmVlLiBNeSBwcm9wb3NhbCBmb3IgdmVu
ZG9yDQo+IHNwZWNpZmljIGNvbW1hbmRzIGlzLCBpZiBpdCdzIGNsZWFyIGl0J3MgdHJ1bHkgYSB1
bmlxdWUgY29tbWFuZCwgYWxsb3cgYWRkaW5nIGl0DQo+IGFzIHBhcnQgb2YgVUFQSSAobW92aW5n
IGl0IG91dCBvZiBSQVcpLiBJIGV4cGVjdCBsaWtlIDUgb2YgdGhlc2UsIGV2ZXIuIElmIHdlDQo+
IHN0YXJ0IGdldHRpbmcgbXVsdGlwbGUgcGVyIHZlbmRvciwgd2UndmUgZmFpbGVkLiBUaGUgaW5m
cmFzdHJ1Y3R1cmUgaXMgYWxyZWFkeQ0KPiBpbiBwbGFjZSB0byBhbGxvdyBkb2luZyB0aGlzIHBy
ZXR0eSBlYXNpbHkuIEkgdGhpbmsgd2UnZCBoYXZlIHRvIGRyYXcgdXAgc29tZQ0KPiBndWlkZWxp
bmVzIChsaWtlIGFkZGluZyB0ZXN0IGNhc2VzIGZvciB0aGUgY29tbWFuZCkgdG8gYWxsb3cgdGhl
c2UgdG8gY29tZSBpbi4NCj4gQW55dGhpbmcgd2l0aCBjb21tYW5kIGVmZmVjdHMgaXMgZ29pbmcg
dG8gbmVlZCBleHRyYSBzY3J1dGlueS4NCg0KVGhpcyB3b3VsZCBuZWNlc3NpdGF0ZSBhZGRpbmcg
c3BlY2lmaWMgb3Bjb2RlIHZhbHVlcyBpbiB0aGUgcmFuZ2UgQzAwMGgtRkZGRmggdG8gVUFQSSwg
YW5kIHRob3NlIHdvdWxkIHRoZW4gYmUgYWxsb3dlZCBmb3IgYWxsIENYTC5tZW0gZGV2aWNlcywg
Y29ycmVjdD8gIElmIHNvLCBJIGRvIG5vdCB0aGluayB0aGlzIGlzIHRoZSByaWdodCBhcHByb2Fj
aCwgYXMgb3Bjb2RlcyBpbiB0aGlzIHJhbmdlIGFyZSBieSBkZWZpbml0aW9uIHZlbmRvciBkZWZp
bmVkLiAgQSBnaXZlbiBvcGNvZGUgdmFsdWUgd2lsbCBoYXZlIHRvdGFsbHkgZGlmZmVyZW50IGVm
ZmVjdHMgZGVwZW5kaW5nIG9uIHRoZSB2ZW5kb3IuDQoNCkkgdGhpbmsgeW91IG1heSBiZSBvbiB0
byBzb21ldGhpbmcgd2l0aCB0aGUgY29tbWFuZCBlZmZlY3RzLiAgQnV0IHJhdGhlciB0aGFuICJl
eHRyYSBzY3J1dGlueSIgZm9yIG9wY29kZXMgdGhhdCBoYXZlIGNvbW1hbmQgZWZmZWN0cywgd291
bGQgaXQgbWFrZSBzZW5zZSB0byBhbGxvdyB2ZW5kb3IgZGVmaW5lZCBvcGNvZGVzIHRoYXQgaGF2
ZSBCaXRbNTowXSBpbiB0aGUgQ29tbWFuZCBFZmZlY3QgZmllbGQgb2YgdGhlIENFTCBFbnRyeSBT
dHJ1Y3R1cmUgKFRhYmxlIDE3Mykgc2V0IHRvIDA/ICBJbiBjb25qdW5jdGlvbiwgdGhvc2UgYml0
cyByZXByZXNlbnQgYW55IGNoYW5nZSB0byB0aGUgY29uZmlndXJhdGlvbiBvciBkYXRhIHdpdGhp
biB0aGUgZGV2aWNlLiAgRm9yIGNvbW1hbmRzIHRoYXQgaGF2ZSBubyBzdWNoIGVmZmVjdHMsIGlz
IHRoZXJlIGhhcm0gdG8gYWxsb3dpbmcgdGhlbT8gIE9mIGNvdXJzZSwgdGhpcyBhcHByb2FjaCBy
ZWxpZXMgb24gdGhlIHZlbmRvciB0byBub3QgbWlzcmVwcmVzZW50IHRoZSBjb21tYW5kIGVmZmVj
dHMuDQoNCj4gDQo+IEluIG15IG9waW5pb24sIGFzIG1haW50YWluZXJzIG9mIHRoZSBkcml2ZXIs
IHdlIGRvIG93ZSB0aGUgY29tbXVuaXR5IGFuIGFuc3dlcg0KPiBhcyB0byBvdXIgZGlyZWN0aW9u
IGZvciB0aGlzLiBEYW4sIHdoYXQgaXMgeW91ciB0aG91Z2h0Pw0K
