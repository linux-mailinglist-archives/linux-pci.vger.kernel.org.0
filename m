Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44113A9463
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFPHve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 03:51:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:33610 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhFPHve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 03:51:34 -0400
IronPort-SDR: ByhNv9QlAs6bHfzVEiListIBGZM/KRM/66691rtKj2qWKN/iqn4KVHypIyDSiuY1HEVoINcNpQ
 zR1HIzWW0z8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185824976"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="185824976"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 00:49:28 -0700
IronPort-SDR: 4cO/52GfVDZeBFHDvA0Y5qbeXWmibdSpE2SfmJ5kAiiDpbBH4AULSSy6iKfT3BX5b0V9g3kLZm
 tbkQN8CCKnJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="479003562"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 00:49:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 00:49:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 16 Jun 2021 00:49:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 16 Jun 2021 00:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H86zAZU2sdaZjPEtKrHqAWEY8jnLW9sKbKVqSuSa7kzlEysG0oIQM+YZG5bwDarefd1SuCI7aZTIeq41UUOgLrV6dixgVSPw+DwXG88QmZeH5R8Q6UhnZ8zKy5lH+DCDIodtvN+zT3o27UfJV5a4mTecbqVO2ISILNWS0++db5Q8y4P7Ce4LaUMqN377ZgKxmuJVaxH2a9WCyqFhjXV2nVzwTw8RaTbatCB0WoRgFk9tQ6sQrtiwyNOkVoVh7N/PVmENhUnslbk8mhA05ElIWK6X7F3a+EX2aFeALyFvwoxp73w1DSNTNRmlSqFaMryUNJ6GoJrBQcj0Ot0xCPHIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjNZ6BaM8726v1mhhLWw1IR8YI+VJ4UWqlMJynpeQg0=;
 b=V+43gDqOQD7YjkIv5S4KI/CyC1HJ52UqfeZjZdwFvkFOE9cct8pbSPGQ1EUI/l+kF9Gg7wBOEOqoPLNaK/UfEo1uxhFT4rJ4TwUs7wW2ZY5t8OO7TZtTITnyfBcSC48mgEqiiiFxMRqGH8dY+r02UQsg+veSXyBWadDXdYFcylS6psEb73oRbLjAj4hQ5ZdNqMWZKpYo1uCKA/oq3ia637V7yhtIj5kbQN7iHo2n4kkLqMSaDFnp+hKfDuc8Hf5g5+pWAHYCFBiq22i7SVaTLlm8uDh+onm8kgETDx7SR+7dtN920QYBgEP+NHIPl//mQciaxF3Bia/LAZLL1N57hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjNZ6BaM8726v1mhhLWw1IR8YI+VJ4UWqlMJynpeQg0=;
 b=uq2H6E3QevaML52VnYIV80FK0JPO88MyRDzqemqybLUzfguyyZ1zIgN3d59He3++/psz24Hzh7vCm6W9eLjKygLPCheY/i0AF9Ihcog0y/YYA539QtQpQ59eDtuJF7zd0BziBNAAM7zgMcSVhYtrYK/nRP1p6wJPWyDTy+F0s+o=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5578.namprd11.prod.outlook.com (2603:10b6:510:e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 16 Jun
 2021 07:49:27 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::201a:d1e0:b3b1:fb8f]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::201a:d1e0:b3b1:fb8f%4]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 07:49:27 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>
Subject: RE: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXW3FV4CKL56K+SEOKbFusTp+FKasVnnGAgACx8/A=
Date:   Wed, 16 Jun 2021 07:49:27 +0000
Message-ID: <PH0PR11MB559572D1AA5A56294211A432850F9@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
 <CAL_JsqJmLz2TChWYGtEGtHpd5aO4hp+zvx8cExb760PDsx-nRg@mail.gmail.com>
In-Reply-To: <CAL_JsqJmLz2TChWYGtEGtHpd5aO4hp+zvx8cExb760PDsx-nRg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.181.36.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fd616e1-1233-4bbf-93f2-08d9309b443d
x-ms-traffictypediagnostic: PH0PR11MB5578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5578C379F3FDF75F194B7109850F9@PH0PR11MB5578.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PkKbIOC6czOz3JESYE2rxK83bZVBzuvm0lUxprFqmw1IIsY+qvIaEaVYpvIwFLJcebzTThAxziede7LutufUuU1no+/8eeTxWhzy4otO3Fm+b55K6a0FbgSv4eAWrzjfkgQWv/R3pyUXgUkK3TyKNef19u3YmkwZgI4fan6MwEH4+w51ohvBJ/ZHGrGwZhYNZG1/JiRCcbgWUFGwBCe8Mo+HiPtnqcCe5d8gM/+Sd9rZwFMTw6S+nadwu522c50Rx7FNiVGTaD/ySQo9AQb0pdPa5CrGxo8Pq69vb9rlsGmr7JSWvtBzeavFkQvtD7LM2cjsT8VjxluJwx5F5H+qCWgucDkDi+N8+/KGUaVBSiZoIWMCR+TetzkLIvvHLWUPmmPMb3FMvVND5VMyR2ASIomNthGqg1+x7rCprp1oWxEBcGw5bWmE81dGIYiApH7kfQYGK6sLxv8W6sh5dkLMiK2BwkRmRROEtxUClfmYCnIvJcxQ36lZjOjPT7vvfDYzXIXdcgKc1GjWcZCY44DrJsXUDmHhozLWa8rhnLwvvqMYmBU3GvLg+NfFL8UnK9SZwKzKwLV1AipufeZmQVb9CngrSRgN2LGekxR740NKMUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(5660300002)(52536014)(478600001)(8936002)(7696005)(55016002)(4326008)(9686003)(71200400001)(8676002)(66556008)(64756008)(66446008)(66476007)(122000001)(76116006)(38100700002)(66946007)(316002)(186003)(26005)(83380400001)(6506007)(54906003)(2906002)(86362001)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUpaaWZPZzkxZ2czRkc3WDlPL1VZTG1VeEZGSjM0dnIwK01PQ2t6dWU0ajg4?=
 =?utf-8?B?Y0RzQjlLelJpMGIwb2h2VVdKQUZVMWpSUlF5VTdOSVJTTU1XSC9sOVBYd0Qy?=
 =?utf-8?B?SnMwQVRrNDVZZUU0OWYwZGlNTjRicFBhRDFLNW5WbVlnN3FzbzdSR0tlNUcy?=
 =?utf-8?B?QzNhemVBUEhCeDQweCsyd1UrTVR4N0J3OCtmU0U0SUdLL0JpVnlGRUk2Q1Fl?=
 =?utf-8?B?QzNSM29iN3hmdGlVLys4ZkRUMWtwYjdlODZUUVAydkkzUTRLMnA0eCtqS2l3?=
 =?utf-8?B?T2FjQnFFS05LbzA4M3JaM0RsaVpRMVkwSFN6czRSd0Z5ZDdrRjRzUnVCUWVQ?=
 =?utf-8?B?bTBZVWJqdzhPd2pVeEVlY2JXTldZN1Z2Y3dpVkxJeFVyWFRpbGp6OElZNHZ1?=
 =?utf-8?B?VlFiKzBJVE1Mai9vOE9FMGJQdHI5MzhKVWFpVFFZOCt0Z1JubURyZnJRU3pn?=
 =?utf-8?B?Z1Z0MUdBYStZbCs2alFST1dWUkJkS2JjVVI0dThnUnppTmNJUUtmVTRXUFRs?=
 =?utf-8?B?RkY2Q0wxT05lbktNYnhsUzgwdm50dmxEdUwzaGRNVTJkc1ZnODc5d1hPYk5X?=
 =?utf-8?B?QkM0c3ppSTNraS9JdSsyQWMvekdtdWszSEdOelRDV3gvUnQ4ZmMzR2IwT2F3?=
 =?utf-8?B?RFltWDVkVkkvcW4zdjg3dTJHd2hJbEI5bGh0azgxOGFGLyt0VU9JNnZpR0xw?=
 =?utf-8?B?QlJTSVMweStmV2VYMU5NTW9MMURGbWRzVGZ4b2QzSDNjTnYxbG9xSHd5Ujdq?=
 =?utf-8?B?TDNpaEl4WFVVL0s3SWZ2QzBQTmNGVXVUdU9zc1hFY3NzMUNsVjBmRDl1eE9Y?=
 =?utf-8?B?dVZMcUQ0K0gyQmFCcGdvZ2tKNUJPWlRYNm9IaGxlQmZSbFE5UnB3NzcwRVlo?=
 =?utf-8?B?YjI1TEtsZmFrNlhkZXo3Z3A0N3JEVWdhT2s3TlIxZDFEdmo5QVZrZklNSE96?=
 =?utf-8?B?TWVVemxjcEVNRG1vSklZdUhYMGo5UklHNE50VG53YXI3NVBxejgzVk5JYS9H?=
 =?utf-8?B?dzY1cDZTM0dLWTJJMmNzTUJVeDVnMG9JUGF0U0pORHRwdjFVTVkzd1VDeDVx?=
 =?utf-8?B?dEYrVjBGcVBWNURCRC96VXJDK3JmRG1jOG1YUXpoVXo4U1NtY3dDWUM5VVVS?=
 =?utf-8?B?UW94MTM0Rnptc0xKeURkVGUzK3M3OEtQcDQ4VFlvSTRwSWRuYnQwMFpNNUo5?=
 =?utf-8?B?TklWSG14aFJiRnMrMDF5ZTQ5cDAzdUdrajZGbi9ocVpnTnA3cm42U2FKWlNT?=
 =?utf-8?B?K2duTVJQQTZRNkI3a05XVDNxazE5NmVXNGtYUE9CdjI3YmRaZkpveDROVFpz?=
 =?utf-8?B?bGJnRHFIbnF3M0xNRkpIL25hUzlpN0RMSTNCTlFDVlR2dUIrWXJlMlNaNTJk?=
 =?utf-8?B?V3oxZVBtU2w5QjlwUXVFb25BVFZSeHcwYkFxVm9lSFV5Mndsc25PRXNyUmE0?=
 =?utf-8?B?a2ZPditZUHdtZk0vRmN1RVFWVkdtdzBuSnRKSy81OEpwbkZsUzRWVm1mUGpP?=
 =?utf-8?B?Y3VCNGtkL3NueXJ5S3l4SnNaaUdvbTlrS3E4S1dBcTFsOEV0NEEvblFITFky?=
 =?utf-8?B?ZE4zWE5tWm02dVRuanV6bExROEtyMTUrMVdlem83L1FLcGRjTVkzdDJLMjFt?=
 =?utf-8?B?bDdhY1R3NWhLTktFMEF5Tmp4VDQyczI3Yzg5dmpCNU9wdmtVSVFJbGlpb0Nz?=
 =?utf-8?B?Z1RDZ0lPNGFwdTZFSmhTOEU4MW5sWm81QUg5RVFOTmdqdWlLa1pNY3RLSXl4?=
 =?utf-8?Q?U2tqJ1Iv/jniYBPfk7qkijtlvmutce0aIrBeWUD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd616e1-1233-4bbf-93f2-08d9309b443d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 07:49:27.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4OjHRZekAUALqxP29LC4VShJOYxQqlRTo2sTvW2EW1Zs1D/5rmF/QN3dDflcJ8k7KIwhD2CqhrwnFN/TxtGIUEII8je+eIHOJR0qVtSITU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5578
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxNiwgMjAy
MSAyOjM5IEFNDQo+IFRvOiBUaG9rYWxhLCBTcmlrYW50aCA8c3Jpa2FudGgudGhva2FsYUBpbnRl
bC5jb20+DQo+IENjOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNv
bT47IFBDSSA8bGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5p
bnRlbC5jb20+OyBNYXJrIEdyb3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsNCj4gUmFqYSBT
dWJyYW1hbmlhbiwgTGFrc2htaSBCYWkgPGxha3NobWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50
ZWwuY29tPjsNCj4gU2FuZ2FubmF2YXIsIE1hbGxpa2FyanVuYXBwYSA8bWFsbGlrYXJqdW5hcHBh
LnNhbmdhbm5hdmFyQGludGVsLmNvbT47DQo+IEtyenlzenRvZiBXaWxjenluc2tpIDxrd0BsaW51
eC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDIvMl0gUENJOiBrZWVtYmF5OiBBZGQg
c3VwcG9ydCBmb3IgSW50ZWwgS2VlbSBCYXkNCj4gDQo+IE9uIE1vbiwgSnVuIDcsIDIwMjEgYXQg
MTo0NyBBTSA8c3Jpa2FudGgudGhva2FsYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogU3Jpa2FudGggVGhva2FsYSA8c3Jpa2FudGgudGhva2FsYUBpbnRlbC5jb20+DQo+ID4NCj4g
PiBBZGQgZHJpdmVyIGZvciBJbnRlbCBLZWVtIEJheSBTb0MgUENJZSBjb250cm9sbGVyLiBUaGlz
IGNvbnRyb2xsZXINCj4gPiBpcyBiYXNlZCBvbiBEZXNpZ25XYXJlIFBDSWUgY29yZS4NCj4gPg0K
PiA+IEluIFJvb3QgQ29tcGxleCBtb2RlLCBvbmx5IGludGVybmFsIHJlZmVyZW5jZSBjbG9jayBp
cyBwb3NzaWJsZSBmb3INCj4gPiBLZWVtIEJheSBBMC4gRm9yIEtlZW0gQmF5IEIwLCBleHRlcm5h
bCByZWZlcmVuY2UgY2xvY2sgY2FuIGJlIHVzZWQNCj4gPiBhbmQgd2lsbCBiZSB0aGUgZGVmYXVs
dCBjb25maWd1cmF0aW9uLiBDdXJyZW50bHksIGtlZW1iYXlfcGNpZV9vZl9kYXRhDQo+ID4gc3Ry
dWN0dXJlIGhhcyBvbmUgbWVtYmVyLiBJdCB3aWxsIGJlIGV4cGFuZGVkIGxhdGVyIHRvIGhhbmRs
ZSB0aGlzDQo+ID4gZGlmZmVyZW5jZS4NCj4gPg0KPiA+IEVuZHBvaW50IG1vZGUgbGluayBpbml0
aWFsaXphdGlvbiBpcyBoYW5kbGVkIGJ5IHRoZSBib290IGZpcm13YXJlLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogV2FuIEFobWFkIFphaW5pZSA8d2FuLmFobWFkLnphaW5pZS53YW4ubW9oYW1h
ZEBpbnRlbC5jb20+DQo+ID4gQWNrZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaWthbnRoIFRob2th
bGEgPHNyaWthbnRoLnRob2thbGFAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBLcnp5c3p0
b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT4NCj4gPiAtLS0NCj4gPiAgTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9LY29uZmlnICAgICAgICB8ICAyOCArKw0KPiA+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9NYWtlZmlsZSAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5jIHwgNDUxICsrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0ODcgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1rZWVtYmF5LmMNCj4gDQo+
IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KDQpUaGFuayB5b3Us
IFJvYiwgZm9yIHRoZSAiUmV2aWV3ZWQtYnkiLg0KDQpTcmlrYW50aA0K
