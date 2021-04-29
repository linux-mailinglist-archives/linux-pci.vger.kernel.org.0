Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9736EAAC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhD2Mln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 08:41:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:31133 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhD2Mlm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 08:41:42 -0400
IronPort-SDR: yzpupXbKbJXm5oL/PhAysO+lqVFeL9Nd6x4ejH4BxOb/4iXDjqHpj9/RVHQn+gB7M1lvFvL3hu
 lrW1hEWdy6dg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="197041174"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="197041174"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:40:54 -0700
IronPort-SDR: 6NrTiFD2f3q6LW9nY7pmP8/vlMgF1dHzsAcwNk10i1dgU7z3JP54ohcWk4SFOAtI6rY7Qj00IH
 b8aon4TAAtcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="605254158"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2021 05:40:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 05:40:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 29 Apr 2021 05:40:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 29 Apr 2021 05:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtpTEoWEuy7KCHAAXmX3ypdmRqhXjzJSf6eY4lCYZbB/s25xD4wIZ6Zxhmhr8oQFMzKd7cl4Jvaj7/kAvlsr9FJjG4nu9jO5+OLmv64AIFpvbRsSBVp6p/u5wzgWb/+aeHPufhWjIe1Yh60bKBNRXX55M1jvC3bpzLrk2sfNe2XtMb5yt85sOKqFBPuFxBnprOqCUY1qJO+jjrz1SuXR4lrN0BASMCjEZ2130ldvmRWCNH3jaDyKtuSE9Wu8onjS6ww9Os9xFdKP08ROFXJKSq00Mup2fVRHtOCEqkKSGingfGV/FOs6uwQ3PJa9c0wqt0gJTNCDd25RHkcJbkx1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQBiIBX+yW/RSRwU3XBBIn1ykOPMvLsqY+Nv7Hn+Ncs=;
 b=dzVGHRFpT2Ek6Ycys8pGGQ53KOZa6h72dvxlUH6ZUYKyLBbeuax8GygzcRlRUr0SpGxEayaO10/RH8WgEv1EY2kmZO0Jrk/1dhLG1Bo6JCRf/jzIk+HbWdCPuGYx4bu4mlv/Tm3ZJW4ePLqVEVxE41xGpHczGmks7ZujyRFu4nvKKqsK9BAPr8YKF4XwVSNZEA7PT1Q/NZ0QPemlQBjeSPOf/1IGs9TJYr9L6VStEKQiVn2183GizHVuqHqqQWZwUx/P2vcoqJYuVUIpS1fO6JhV4YkA63Fu4d07imCXmpkIwEJin/DeVpChjjCM4zq7PgCZglBbNwyhYbHl+/QsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQBiIBX+yW/RSRwU3XBBIn1ykOPMvLsqY+Nv7Hn+Ncs=;
 b=JF93/+eZGS4cIVJ/7y52yNwFqyX1qfpNnXJdDUiKqH6cHXRlO/LlAoD//64zlPwotIK7Lf2gkH5fIZNtesY5MnXX44rud3MTzSI1fHoSbNz2SGTeHGYwqcY0YN3mvHsD/E/swtXerZaFmPBsN7AScaFUR1SkVogTzHQJ38JvjAU=
Received: from MWHPR11MB1982.namprd11.prod.outlook.com (2603:10b6:300:10f::22)
 by MWHPR11MB1792.namprd11.prod.outlook.com (2603:10b6:300:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 12:40:51 +0000
Received: from MWHPR11MB1982.namprd11.prod.outlook.com
 ([fe80::31af:72e4:2193:8880]) by MWHPR11MB1982.namprd11.prod.outlook.com
 ([fe80::31af:72e4:2193:8880%11]) with mapi id 15.20.4065.027; Thu, 29 Apr
 2021 12:40:51 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Thread-Topic: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Thread-Index: AQHXI6+udlf71UAyWUy6GAXnNNJKcqrJ5V8AgABMLoCAAV0NgIAAEy5w
Date:   Thu, 29 Apr 2021 12:40:50 +0000
Message-ID: <MWHPR11MB1982D672DD8A2F09A493F48E975F9@MWHPR11MB1982.namprd11.prod.outlook.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
 <20210428144041.GA27967@wunner.de>
 <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
In-Reply-To: <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 700ff452-9524-4955-55a5-08d90b0c0597
x-ms-traffictypediagnostic: MWHPR11MB1792:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17922BA7273A5739CF4C2248975F9@MWHPR11MB1792.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPk6f/AU9h9XKuKoofvEt7YIy2BNu8l6TG7b46bolJp2x3/7tkiKKxKJ5B1SuyTNRg6MfAoXl9VV1xxPmowV0/eSE/x9CqulgFPemjBRSrg04L+tb0wiSB0FWiuF9SBMLs2DoiZZwLzoG7b9WJ9esxQQGp0lCeVAvVz3Pnrrio+lhKQaE9mPzICWsRkN5h275oRbG1nyxihc2rU9hDcOUqC8M+31GFxDHqU4UaH+cnz6wUF7acvpBiaoFM5BTj3MgPO9WCjHWW1DPntEv0rtxsg0vxkUFvfcpwL18HxIFnw1B8PtnuvuIxB1AJm3wipCmNHLQRaC/i/XICB0iy5rbiaxspB4wu34t+ye8JxmhIhK8seNBGZK1mgz5KJvsUoTk+Svu9/Uu20+99AcRTde709+i2KSG91EJNIypOuRQexaG4CZ/NNbi4kpw5ck0P9dw3Qa6QJicpIcpngxrpB1VVzrOyrajqEYoqqJDWGmEB5RdTmOu0O8n8ZAjZRd99CnSOORJmR+XnTFkcq3f8yvBNYUVo5qUzuM7fk6byBMyxZ3I5Q5F1v7SkjwmQYT5LVyMTADaqJTePOQrKGQucUyAxmTMUMGJt8m780z2jfMfD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1982.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39850400004)(366004)(346002)(396003)(4326008)(66476007)(8676002)(76116006)(8936002)(7416002)(2906002)(33656002)(6506007)(52536014)(26005)(38100700002)(5660300002)(55016002)(186003)(66446008)(83380400001)(71200400001)(66556008)(66946007)(110136005)(7696005)(478600001)(54906003)(86362001)(64756008)(316002)(122000001)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M0dmeHRzQ0xySVFYWmlvQzB0M1BCbTVITUwwTVFUb3R4a1hGRVNVdTBxckNl?=
 =?utf-8?B?NWQySGU3bWN5bjNxd3ZZcXJ3N0R5eHV3Zk9JQzEyZnhLM0FXMUNrNHV4UU1u?=
 =?utf-8?B?SnEvaWkxNjJ0MU00cDZ5b04vM3RJZ2tlNnN4dTk1eDhoRWFZMVVHZTBUekxB?=
 =?utf-8?B?WVlqYWtveFlkN3c4a3IweTcxRnhuOWJ6VW01cWJOckxiaW9USDhubnQvWEZK?=
 =?utf-8?B?amZjM1VKamFEbkRjTUF4bkVOOHNINGJCcVdybnJRbVMzcEtRdUx2RVRFdnRI?=
 =?utf-8?B?MGpNMGtibG1uUlZuVEJhazhwU2NMNm90STNBM3dhZlpETkN6M3ovQnVqaUtX?=
 =?utf-8?B?VFU0ZURyU2ZlQjhtc3ZCYVhTQVZ6dmp1dWZFUU92Q05maTdTN2xPYzhKS1Yv?=
 =?utf-8?B?ejlSZEdaRXUxVlVnWnM3d3pIejVaYnBabVJnQm5LbUxWNTlpTFF0b3dUeUgv?=
 =?utf-8?B?aW9JbENTU3JDT1IzeittNDhnUnp2TGZrQmx3ZkxXYzAyVjBoVkpPU1N0L3o1?=
 =?utf-8?B?VHlNT1FzUldhNUNTbkVaWG05bUR1QTRTck5nRXptVDNWVlZmalRpNzdiVFdw?=
 =?utf-8?B?bGgvemx3a1NySGhuV0U5eFZNalVYZEJ3QTZRS2tkWk9OY1NRTkhNOFNPTXI2?=
 =?utf-8?B?ZGFtTjRkeXd5ZXloVDZ0MmVYbEo0azhZQ0c2ZitncG8zS0ZxZkRQMGZaRllH?=
 =?utf-8?B?QTROSUdGcGt1a2xtcnJNZ0VJSnh2R2lRS0txNmtqRC9OWk5SWlBNN0VpcXA0?=
 =?utf-8?B?VjJUdjh5MTZycFZMSmdxekRPQjBzM21hdWZaNlArRTlIblJLSFVBOTY1RGg2?=
 =?utf-8?B?NGk4Q29FN3N4NEFmTjlobkFzcWZyMlhYbzB4RXI3TE5WMFloMm9QYld6Rmkr?=
 =?utf-8?B?U1VkSUh6V082ZXYyV2UwL1R3a2o5alBkZHNBR3JKa093akpRWk9CMDVXUito?=
 =?utf-8?B?Q0N2b2FNaWM3UTRKUUU4MFB5UEJpdnJTbTJiUmt6NS9ucmYvbFdWeXdSSG40?=
 =?utf-8?B?dzF0Zk9QQkVnUnl2emRYZFFDTEFQRmZ6aUE1OGR0NkRrUk8rVXhVazdMWHhj?=
 =?utf-8?B?WmpHYW5SZDBiU0hKUm9xWGdMYncrQ2hQS1ZIYkszZnhhREZLeHovTzBZdTNG?=
 =?utf-8?B?N2VPbVlucVNBZGREemtvdFdRS21FaVRLZDdCVFBBT2ozeVdwSWhsMktWNGRY?=
 =?utf-8?B?YThUUm1mMkE5SXJvc2lpWW5ldzYzMU53NlhjQlhlRHV6Y3ZJMUQ5dHlJaFpQ?=
 =?utf-8?B?OGlwVG5ta3U3K2JuTzRTMnZodExsdlhMVUx1NnFyd3lkMEJUUGhJSGZpcWxt?=
 =?utf-8?B?Nm1lL3F3NzRuYlEzYzh0ZjJuOHRRY3l2SDZRbGVuSGFuUkVDZ0h1NmNSUitD?=
 =?utf-8?B?bVltZmgzakNQb1BySnJGUGcyVDdySmxDd3hqeFBwdThsSkVRMWl6OXVTRUxC?=
 =?utf-8?B?UTFFTlkwZ1VSc1BtaEZvcE05NlRIQWt2UXlWUnVWLzNuU0RGQUdmSnRWQ1R2?=
 =?utf-8?B?aWVYelYzS3M1dWs1V0dwU2hNZ0hWUXJEUytGSXJDLzg4MnRrbVd4elFRTzFs?=
 =?utf-8?B?TUhuc0RFcnRrRlNKVkJIUXRiRlFHSWZkWEVOL01XdGovYUMzWWthK1VqOS9x?=
 =?utf-8?B?VWZMVEJqRTZtQ0lLWmdOd1NEWjkyK251ZW9rQXFUQmhpWnFBdTRSYlpjYXk5?=
 =?utf-8?B?ZVJtODAzbjgxdzdXR3JjK1I2S2JOMkE2b3NLU25Ob0JUK0tIMlUzWTc4T21n?=
 =?utf-8?Q?/8VdHGqkM2Au5HaNlfDD2JD+SOuxzucoYeC1qKy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1982.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ff452-9524-4955-55a5-08d90b0c0597
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 12:40:50.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEHmXu23ZhGq352n0D9xjzbd9Boz/88VuA0CptNPRjiknEWM2hHnlbh+DxIWw70fkLnllq7aka9x8OXnfDh8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1792
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhlIHNhbWUgcXVlc3Rpb24sIHdoeSAzcywgbm90IDZzLCBpcyB0aGVyZSBhbnkgc3BlYyB0byBz
YXkgdGhlIERQQyByZWNvdmVyeSBzaG91bGQgYmUgY29tcGxldGVkIGluIDNzID8NCg0KVGhhbmtz
LA0KRXRoYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFlpY29uZyBZYW5n
IDx5YW5neWljb25nQGhpc2lsaWNvbi5jb20+IA0KU2VudDogVGh1cnNkYXksIEFwcmlsIDI5LCAy
MDIxIDc6MzAgUE0NClRvOiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4NCkNjOiBCam9y
biBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2Ft
eSA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPjsgV2lsbGlhbXMs
IERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBaaGFvLCBIYWlmZW5nIDxoYWlmZW5n
LnpoYW9AaW50ZWwuY29tPjsgU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz47IFJhaiwgQXNo
b2sgPGFzaG9rLnJhakBpbnRlbC5jb20+OyBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBSdXNzZWxsIEN1cnJleSA8cnVzY3VyQHJ1c3Nl
bGwuY2M+OyBPbGl2ZXIgTydIYWxsb3JhbiA8b29oYWxsQGdtYWlsLmNvbT47IFN0dWFydCBIYXll
cyA8c3R1YXJ0LncuaGF5ZXNAZ21haWwuY29tPjsgTWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3Rl
cmJlcmdAbGludXguaW50ZWwuY29tPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IHBjaWVocDogSWdub3JlIExpbmsgRG93bi9VcCBjYXVz
ZWQgYnkgRFBDDQoNCk9uIDIwMjEvNC8yOCAyMjo0MCwgTHVrYXMgV3VubmVyIHdyb3RlOg0KPiBP
biBXZWQsIEFwciAyOCwgMjAyMSBhdCAwNjowODowMlBNICswODAwLCBZaWNvbmcgWWFuZyB3cm90
ZToNCj4+IEkndmUgdGVzdGVkIHRoZSBwYXRjaCBvbiBvdXIgYm9hcmQsIGJ1dCB0aGUgaG90cGx1
ZyB3aWxsIHN0aWxsIGJlIA0KPj4gdHJpZ2dlcmVkIHNvbWV0aW1lcy4NCj4+IHNlZW1zIHRoZSBo
b3RwbHVnIGRvZXNuJ3QgZmluZCB0aGUgbGluayBkb3duIGV2ZW50IGlzIGNhdXNlZCBieSBkcGMu
DQo+PiBBbnkgZnVydGhlciB0ZXN0IEkgY2FuIGRvPw0KPj4NCj4+IG1lc3R1YXJ5Oi8kIFsxMjUw
OC40MDg1NzZdIHBjaWVwb3J0IDAwMDA6MDA6MTAuMDogRFBDOiBjb250YWlubWVudCANCj4+IGV2
ZW50LCBzdGF0dXM6MHgxZjIxIHNvdXJjZToweDAwMDAgWzEyNTA4LjQyMzAxNl0gcGNpZXBvcnQg
DQo+PiAwMDAwOjAwOjEwLjA6IERQQzogdW5tYXNrZWQgdW5jb3JyZWN0YWJsZSBlcnJvciBkZXRl
Y3RlZCBbMTI1MDguNDM0Mjc3XSBwY2llcG9ydCAwMDAwOjAwOjEwLjA6IFBDSWUgQnVzIEVycm9y
OiBzZXZlcml0eT1VbmNvcnJlY3RlZCAoTm9uLUZhdGFsKSwgdHlwZT1UcmFuc2FjdGlvbiBMYXll
ciwgKENvbXBsZXRlciBJRCkNCj4+IFsxMjUwOC40NDc2NTFdIHBjaWVwb3J0IDAwMDA6MDA6MTAu
MDogICBkZXZpY2UgWzE5ZTU6YTEzMF0gZXJyb3Igc3RhdHVzL21hc2s9MDAwMDgwMDAvMDQ0MDAw
MDANCj4+IFsxMjUwOC40NTgyNzldIHBjaWVwb3J0IDAwMDA6MDA6MTAuMDogICAgWzE1XSBDbXBs
dEFicnQgICAgICAgICAgICAgIChGaXJzdCkNCj4+IFsxMjUwOC40NjcwOTRdIHBjaWVwb3J0IDAw
MDA6MDA6MTAuMDogQUVSOiAgIFRMUCBIZWFkZXI6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwDQo+PiBbMTI1MTEuMTUyMzI5XSBwY2llcG9ydCAwMDAwOjAwOjEwLjA6IHBjaWVo
cDogU2xvdCgwKTogTGluayBEb3duDQo+IA0KPiBOb3RlIHRoYXQgYWJvdXQgMyBzZWNvbmRzIHBh
c3MgYmV0d2VlbiBEUEMgdHJpZ2dlciBhbmQgaG90cGx1ZyBsaW5rIA0KPiBkb3duDQo+ICgxMjUw
OCAtPiAxMjUxMSkuICBUaGF0J3MgbW9zdCBsaWtlbHkgdGhlIDMgc2Vjb25kIHRpbWVvdXQgaW4g
bXkgcGF0Y2g6DQo+IA0KPiArCS8qDQo+ICsJICogTmVlZCBhIHRpbWVvdXQgaW4gY2FzZSBEUEMg
bmV2ZXIgY29tcGxldGVzIGR1ZSB0byBmYWlsdXJlIG9mDQo+ICsJICogZHBjX3dhaXRfcnBfaW5h
Y3RpdmUoKS4NCj4gKwkgKi8NCj4gKwl3YWl0X2V2ZW50X3RpbWVvdXQoZHBjX2NvbXBsZXRlZF93
YWl0cXVldWUsIGRwY19jb21wbGV0ZWQocGRldiksDQo+ICsJCQkgICBtc2Vjc190b19qaWZmaWVz
KDMwMDApKTsNCj4gDQo+IElmIERQQyBkb2Vzbid0IHJlY292ZXIgd2l0aGluIDMgc2Vjb25kcywg
cGNpZWhwIHdpbGwgY29uc2lkZXIgdGhlIA0KPiBlcnJvciB1bnJlY292ZXJhYmxlIGFuZCBicmlu
ZyBkb3duIHRoZSBzbG90LCBubyBtYXR0ZXIgd2hhdC4NCj4gDQo+IEkgY2FuJ3QgdGVsbCB5b3Ug
d2h5IERQQyBpcyB1bmFibGUgdG8gcmVjb3Zlci4gIERvZXMgaXQgaGVscCBpZiB5b3UgDQo+IHJh
aXNlIHRoZSB0aW1lb3V0IHRvLCBzYXksIDUwMDAgbXNlYz8NCj4gDQoNCkkgcmFpc2UgdGhlIHRp
bWVvdXQgdG8gNHMgYW5kIGl0IHdvcmtzIHdlbGwuIEkgZHVtcCB0aGUgcmVtYWluZWQgamlmZmll
cyBpbiB0aGUgbG9nIGFuZCBmaW5kIHNvbWV0aW1lcyB0aGUgcmVjb3Zlcnkgd2lsbCB0YWtlIGEg
Yml0IG1vcmUgdGhhbiAzczoNCg0KWyAgODI2LjU2NDE0MV0gcGNpZXBvcnQgMDAwMDowMDoxMC4w
OiBEUEM6IGNvbnRhaW5tZW50IGV2ZW50LCBzdGF0dXM6MHgxZjAxIHNvdXJjZToweDAwMDAgWyAg
ODI2LjU3OTc5MF0gcGNpZXBvcnQgMDAwMDowMDoxMC4wOiBEUEM6IHVubWFza2VkIHVuY29ycmVj
dGFibGUgZXJyb3IgZGV0ZWN0ZWQgWyAgODI2LjU5MTg4MV0gcGNpZXBvcnQgMDAwMDowMDoxMC4w
OiBQQ0llIEJ1cyBFcnJvcjogc2V2ZXJpdHk9VW5jb3JyZWN0ZWQgKE5vbi1GYXRhbCksIHR5cGU9
VHJhbnNhY3Rpb24gTGF5ZXIsIChDb21wbGV0ZXIgSUQpDQpbICA4MjYuNjA4MTM3XSBwY2llcG9y
dCAwMDAwOjAwOjEwLjA6ICAgZGV2aWNlIFsxOWU1OmExMzBdIGVycm9yIHN0YXR1cy9tYXNrPTAw
MDA4MDAwLzA0NDAwMDAwDQpbICA4MjYuNjIwODg4XSBwY2llcG9ydCAwMDAwOjAwOjEwLjA6ICAg
IFsxNV0gQ21wbHRBYnJ0ICAgICAgICAgICAgICAoRmlyc3QpDQpbICA4MjYuNjM4NzQyXSBwY2ll
cG9ydCAwMDAwOjAwOjEwLjA6IEFFUjogICBUTFAgSGVhZGVyOiAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMA0KWyAgODI4Ljk1NTMxM10gcGNpZXBvcnQgMDAwMDowMDoxMC4wOiBE
UEM6IGRwY19yZXNldF9saW5rOiBiZWdpbiByZXNldCBbICA4MjkuNzE5ODc1XSBwY2llcG9ydCAw
MDAwOjAwOjEwLjA6IERQQzogRFBDIHJlc2V0IGhhcyBiZWVuIGZpbmlzaGVkLg0KWyAgODI5Ljcz
MTQ0OV0gcGNpZXBvcnQgMDAwMDowMDoxMC4wOiBEUEM6IHJlbWFpbmluZyB0aW1lIGZvciB3YWl0
aW5nIGRwYyBjb21wZWxldGU6IDB4ZDAgPC0tLS0tLS0tIDIwOCBqaWZmaWVzIHJlbWFpbmVkIFsg
IDgyOS43MzI0NTldIGl4Z2JlIDAwMDA6MDE6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMDAwIC0+
IDAwMDIpIFsgIDgyOS43NDQ1MzVdIHBjaWVwb3J0IDAwMDA6MDA6MTAuMDogcGNpZWhwOiBTbG90
KDApOiBMaW5rIERvd24vVXAgaWdub3JlZCAocmVjb3ZlcmVkIGJ5IERQQykgWyAgODI5Ljk5MzE4
OF0gaXhnYmUgMDAwMDowMTowMC4xOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikgWyAg
ODMwLjc2MDE5MF0gcGNpZXBvcnQgMDAwMDowMDoxMC4wOiBBRVI6IGRldmljZSByZWNvdmVyeSBz
dWNjZXNzZnVsIFsgIDgzMS4wMTMxOTddIGl4Z2JlIDAwMDA6MDE6MDAuMCBldGgwOiBkZXRlY3Rl
ZCBTRlArOiA1IFsgIDgzMS4xNjQyNDJdIGl4Z2JlIDAwMDA6MDE6MDAuMCBldGgwOiBOSUMgTGlu
ayBpcyBVcCAxMCBHYnBzLCBGbG93IENvbnRyb2w6IFJYL1RYIFsgIDgzMS44Mjc4NDVdIGl4Z2Jl
IDAwMDA6MDE6MDAuMCBldGgwOiBOSUMgTGluayBpcyBEb3duIFsgIDgzMy4zODEwMThdIGl4Z2Jl
IDAwMDA6MDE6MDAuMCBldGgwOiBOSUMgTGluayBpcyBVcCAxMCBHYnBzLCBGbG93IENvbnRyb2w6
IFJYL1RYDQoNCg0KQ09ORklHX0haPTI1MCBzbyByZW1haW5pbmcgamlmZmllcyBzaG91bGQgbGFy
Z2VyIHRoYW4gMjUwIGlmIHRoZSByZWNvdmVyeSBmaW5pc2hlZCBpbiAzcy4NCklzIHRoZXJlIGEg
cmVmZXJlbmNlIHRvIHRoZSAzcyB0aW1lb3V0PyBhbmQgZG9lcyBpdCBtYWtlIHNlbnNlIHRvIHJh
aXNlIGl0IGEgbGl0dGxlIGJpdD8NCg0KVGhhbmtzLA0KWWljb25nDQoNCg0KPiBUaGFua3MsDQo+
IA0KPiBMdWthcw0KPiANCj4gLg0KPiANCg0K
