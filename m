Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0144BDBB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhKJJZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 04:25:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:21627 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhKJJZu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 04:25:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="230100018"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="230100018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 01:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="503894361"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2021 01:21:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 01:21:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 01:21:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 01:21:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 10 Nov 2021 01:21:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nakThsltk0CT/ePoGC5XHnA+KK/bHW0Qy9XaLRVrMZXf3wJ3HZdlJRrTIDFjVV5cIjsdd3ymiVX7FvwdrdsIIQWfyGGbrfk+Y0aidpMdF9itk4fHJfNO5OsLYObOOuMC77o/A4HmOBvU1FgSxO/jENDcbEFTx2T8pDT8rtuuv7dLZ5uXOQeqAcBPmKUGzCl3qbXEivl3/onIycNi+DxQDSRvQXM0Ucu+kofjZlnwBGRKXeNlumeu3XO7boIhJjnssXPwuf5ruXxpPdQghEU2LYVTzmNzoRrP7X9r1qwGlvVgeoeGh4ZEb+BNk2Zu2GPMRRIINyRe3AYDsIezWpv5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VAkaNOWodBXP7AA7IYp59Rua4rWLohE9kuDwfAyBOc=;
 b=i44Gq2JKk734Sdo89yw7o/ZEy63SDcxpqF629CJRg/Ihn/I+0YR5SpFR+/IGP5UpkYHUNWBb/T6iwLjcByNUUrHZXlV8ZaMqwYrRtvp1F51FQOFlD0b7BKwgR+5TvNKQtiNLSFSCpIqAypbUvAFZl1maJIExtyty81vOg+wlTLG+VaG07/HcfwfUXnMjCncTVz5hJlNG6+z0QjMJxWmIGGM+h3kvsy8n5FQazw/07uU6tZkIE3baI+KXu1Pjh2MfDYvS7CMtjY7l5UAiq2zzZz9hS7KtwRt/6+d0qV/b3RxJ8pvcYV41xIZBrptM8tS1G9tOoLrd+mG8oG914d/uUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VAkaNOWodBXP7AA7IYp59Rua4rWLohE9kuDwfAyBOc=;
 b=hJwDfCUd7kzhd8nyyRfqWTfbpJHWl3n9WMpnhbPY0ucCPIVndGvVhe5wBV31r/54MGKSzF2sG5dndhY2jY9cCibHH0eEDRHI8a3jMr6cX2bliWMG1RbQ8/GsCtCg7vbL0yjy0UE9C2kzAZ9Ns8P/Hr7NXRKOk61RjYXXU6Cf/TQ=
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM6PR11MB3658.namprd11.prod.outlook.com (2603:10b6:5:142::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Wed, 10 Nov 2021 09:20:59 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849%4]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:20:59 +0000
From:   "Bao, Joseph" <joseph.bao@intel.com>
To:     stuart hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: RE: HW power fault defect cause system hang on kernel 5.4.y
Thread-Topic: HW power fault defect cause system hang on kernel 5.4.y
Thread-Index: AdfPm0b60GGT2vlORua28HBxsdiYnQAnnSiAAUFzF9AAEAMjAAAlJd/g
Date:   Wed, 10 Nov 2021 09:20:59 +0000
Message-ID: <DM8PR11MB570293D37A0027753CEE3F8386939@DM8PR11MB5702.namprd11.prod.outlook.com>
References: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211102223401.GA651784@bhelgaas>
 <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
 <912e5d6c-b6d2-d4b7-d3f3-8c6624a14eb6@gmail.com>
In-Reply-To: <912e5d6c-b6d2-d4b7-d3f3-8c6624a14eb6@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: timeout-no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c00d7a-51f4-4b08-5f2b-08d9a42b686e
x-ms-traffictypediagnostic: DM6PR11MB3658:
x-microsoft-antispam-prvs: <DM6PR11MB3658ADDA13916B76FD32644F86939@DM6PR11MB3658.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JH5ZUoHaNt9aYh6CtY93HmHMHRLVOqtTjz6Ji1Y4Uh0Mw+VcoBCqmNpM/hyHHbOs3XMtuXpw4Ge/iph0vy96FTYmOQRpdUN/NKLP6c+R6MoUKJsic1DvFNwcOyeYjPKxk+HR1Ak6Q20w2s3AfQ7dUOvETXELmrVfzZJ2aaB98hpx51caVMwy0Gf2rXC/M/FoFxK192is5+avvWSlSmuSn8hxhCaQxkskC9nWZu7f2vSPNfbHKS0epnP0hku8h9mTZlz9YgAVXdEqDiE+SYV7NFfJszwzMeJ1F724S7KcXXCQqsyObrkIRpwGEQO41+uMFsEhYPscSu4ZLHi3HofEdjxF/l0nVJ5Age6DEZNmpKstqOF4BDOY4cah4shOb0JhDxSXHUJLunYhxwW7wy/XNrJeEp5dT3ssxra20TNGR61jDDoABaHUj1r9FdHzFCrdabUNKVE3LH673dD/r7mu4/iqfmZM0dmD3W5rqGpYIbWt13P3XW9vo/vQ3jdRHq8gK35iWEMCWoYN5d+S578GdP51vNK7qTsIM8Ub2cQzs6FavcVs/ZI13FXxPxD8tWdLxTQ6dZzzBz5P9NwTTqzUKVkCdpBrGqIpAC7/QzLbs8yORmx+fCFpjzHoYkGuCfyiEoQvR5eQkOyTsdPweAfNGYMBR8SKUiM55ihguiN4GaKojIpf0+lC5FBtEB50FekZcwTxxzZHZYjB8Tk9Qh7Hfw0cP9PDh/t53x4kE8PuhEBV8LR+MC3mWYUvosqdb3tamu1+3xVc1HsgO6hlHXxeDOds2d/oGumVZoG9cMvEqw947NxOuGGwIKfXFaN3QxF0WBrWCBkskokaZcB4Me724g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8676002)(66476007)(83380400001)(4326008)(7696005)(53546011)(5660300002)(64756008)(54906003)(2906002)(33656002)(8936002)(66946007)(66446008)(76116006)(508600001)(66556008)(55016002)(186003)(110136005)(122000001)(86362001)(38100700002)(316002)(26005)(966005)(38070700005)(82960400001)(52536014)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHYyOWJYcGhoZXY5NFZRd3pSUzhTUXcrV2RsZUprMzQrZWpCKzR1K05iWDFF?=
 =?utf-8?B?K2ZzTzZQeTFCeTBrVUcxWlNnSE43RUhacStXdVNIeW5yQ2FWbTNLelUxbFVq?=
 =?utf-8?B?dmVLRVFTY2FrNi80WWMrbmFyM2ZpY3RHRjdUMUcxcU5TVm9iWEZrUThRRVZF?=
 =?utf-8?B?V1V6NnBENTMvNWRaeG42b0l3ejBrQkI0ZUVDUE5GakVERHNhY2lIZDIxaWhy?=
 =?utf-8?B?Q2ZZbElncEVPN3p3NXFVcDBSZFVYb0V6dHkwRHhjTlZDUDB0U2VMZmtSdUk5?=
 =?utf-8?B?eWQ4aVg2cVlHZWZkU3laSXhkYTRIelFiZ1pYN3A0RFh4ZERkZzVycVdQeTIr?=
 =?utf-8?B?ZEtXeFc5U3pNSlpVbG1yS2ZHQllYK29CL0tPaHBWeFJtbjNpRHpDY1JkZTJs?=
 =?utf-8?B?MllQanVaRFlLdGcwdVYzbjF4QVA5WWVXUFluQU1ZSDFIMmdEU0pMRzR2dWJG?=
 =?utf-8?B?TWZmZzRCOVltVFV3U2FRK3VleXA2RlRkUEJWNnF2VjRXSEVtM3YwTVkydzJS?=
 =?utf-8?B?dXo0TytObjJucnY1WXY5RmhBNUxxbTd1dVhubGtraHBNNDAvWmlHZllCZVBK?=
 =?utf-8?B?V25PVEtrajk2TXVqdEpqdWlHdVYyNE5LL1VsMkJCQnJRVHE4emtCWXl4RTZK?=
 =?utf-8?B?bklzSiswTnRuLzFBNHV4czBHVGZVcXVDcW05M0VwNU9mWHZ1WjlkSHVETEg3?=
 =?utf-8?B?Y3V3djRuaGg4aTFick5iWjJNaWcxajB1NGZNUWhaK05KV0R2cXhlU1grVmRm?=
 =?utf-8?B?RndMaGVQWldDSXovZ20xeWNGVGFlNkxoYzcwaHpuNnBDTUl0RVZYSGpGWGxa?=
 =?utf-8?B?RXRjR0FVc2FxWC9Bbkt3V21BRkdiOXpES05OQzVPakZsTy9sOUxIYyt4Q2xJ?=
 =?utf-8?B?K0hJdEdqMXg5eGlkRjY5Z1k4VHVFVTJjVFlsUVNBSHExTllWeVFlVE1ndmNN?=
 =?utf-8?B?ampDamJLQmFGbWdlZG41OG9iSDdoZmxsU1JnRkpKNnEyQXRTV3hYNHZwRTFS?=
 =?utf-8?B?TWVDb3ZXUmJNSTB6OWdXcDJ2SlVJSUNBazZNS2FRbkpEMXljaFEzZlZQMWlX?=
 =?utf-8?B?L0FkMERhVUIwTFZLQ2hoeFVzSU5EWmloMDNvakxkUStxcGtXZTIzeHpyeldV?=
 =?utf-8?B?U0Z2eWovS1M1UW1ndVNRQTE4Y29ad3dYRFRsSmJUbWdlOW02aG9QdkhQZm9K?=
 =?utf-8?B?Sm5CYXliN216QVJIRVpHSUlyTU5jRm5JK1RFM0tuMzk0aXJjYVVaaGJqNlh2?=
 =?utf-8?B?Q3AxVG1DdjVKV0MxcDc2eG1pZEtaOGpMaUdjS25aTUZBSGNvOFlqKzh1blZH?=
 =?utf-8?B?QitDMEVFTlFTZ3o0My80cnpWek0wbHFFazBGNVdQaTRwRVJ2TlRpKzZOT2Q2?=
 =?utf-8?B?aUt6Vi9RSS9rQW5QNWdta2RVT2RQd29WL0NvODFqQm82emRmOWZ4d05CM0RT?=
 =?utf-8?B?Q0FoTldrVHE0SkV0YUFHVmlTYWRlbllzanA3ZnoxWVNkMHNCbDNsakVrTTBr?=
 =?utf-8?B?NWVIeHBURkRGb3A2d1grTFJ6d2JTSmQ1MzN2MzdRV3h4MHJXMm00eW55NlI2?=
 =?utf-8?B?RFNjTDJQU09NSVVSSDk5c1V5YkpxZjhKNmtpVnBmZ1Z6RjE2WlZIM1BLQ2to?=
 =?utf-8?B?UzVFdlBpanc2Zm5uams1dzRVclNiVnRBRXhMbHhHNEFjSElEVU1vZGhwZnJE?=
 =?utf-8?B?TXhDNGFPUXdEUGNrTEV1WlN4UG83VWdYcFJFSlhxZkpnZ2o4T0g2UjUwYmJJ?=
 =?utf-8?B?RmhVWkQyUHpTMmtsS3JxY29vZzdSTjNiTGo2ZmxMaElYeFd5bGVqUC9sVEZV?=
 =?utf-8?B?SWpYU3hNeWxVRGNrb3BjcFVhS1RRQlMrckRSV1dLQUJCaGJvTFNPVWZNekw2?=
 =?utf-8?B?NzUvRmcxa2R0YTVNK1V1dncwN21FellJYjR6dms2ZHFZaUppUllaZldqQWN0?=
 =?utf-8?B?c1hmdWlxUTIvcTNBUGV2N3NFS1h3cTlhblB5dlBSQzRvRkdvcHUwZ3lRbENK?=
 =?utf-8?B?NzBqV1JTRnJTNWtDdWdyVXU2SzdYdGdOeWdFV0NsR3BybURGZlFDOUlMdXl6?=
 =?utf-8?B?S1B3Y1Fxd1h6SHFEVlYvdGlkak5HbElsR1JzK1lGQytSWU5ZS2ZMQkxuNWty?=
 =?utf-8?B?My9TTllxV2c3TlNtTUpiQ01ucmVPcExEZUd5Vmo1TjhpaWxtazFENVRQcE9U?=
 =?utf-8?Q?U9Kv5PiIr4XXYMLp7SXbSRk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c00d7a-51f4-4b08-5f2b-08d9a42b686e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 09:20:59.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fqzTgX2pmwCFPJ+4MIXwEkz8N+XGjscenNLdi2PjbME/DmNa9ALow1jLC4dcxd4zMOHOrJ4MI54qwCVVtIJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3658
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3R1YXJ0LA0KVGhlIHBhdGNoIHlvdSBhdHRhY2hlZCBkb2VzIG5vdCB3b3JrIGZvciBtZSwg
dGhlIGxvZ2ljIHNob3VsZCBiZSBvayBidXQgSSBoYXZlIG5vdCBmaWd1cmVkIG91dCB3aHkuIEJ1
dCBhIGxvb3AgY291bnRlciBhY3R1YWxseSBoZWxwcyBtaXRpZ2F0ZSB0aGlzIGlzc3VlLiBUaGFu
ayB5b3UgdmVyeSBtdWNoIQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2ll
aHBfaHBjLmMgYi9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYw0KaW5kZXggODhiOTk2
NzY0ZmY5Li4zZDJjMzM2ZmY3NDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9ob3RwbHVnL3Bj
aWVocF9ocGMuYw0KKysrIGIvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMNCkBAIC01
MjksNyArNTI5LDggQEAgc3RhdGljIGlycXJldHVybl90IHBjaWVocF9pc3IoaW50IGlycSwgdm9p
ZCAqZGV2X2lkKQ0KICAgICAgICBzdHJ1Y3QgY29udHJvbGxlciAqY3RybCA9IChzdHJ1Y3QgY29u
dHJvbGxlciAqKWRldl9pZDsNCiAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBjdHJsX2Rl
dihjdHJsKTsNCiAgICAgICAgc3RydWN0IGRldmljZSAqcGFyZW50ID0gcGRldi0+ZGV2LnBhcmVu
dDsNCi0gICAgICAgdTE2IHN0YXR1cywgZXZlbnRzID0gMDsNCisgICAgICAgdTE2IHN0YXR1cywg
ZXZlbnRzLCByZWFkX3JldHJ5X2NvdW50ID0gMDsNCisgICAgICAgdTggUkVBRF9SRVRSWV9NQVgg
PSA2Ow0KDQogICAgICAgIC8qDQogICAgICAgICAqIEludGVycnVwdHMgb25seSBvY2N1ciBpbiBE
M2hvdCBvciBzaGFsbG93ZXIgYW5kIG9ubHkgaWYgZW5hYmxlZA0KQEAgLTU4NSw3ICs1ODYsNyBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgcGNpZWhwX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQog
ICAgICAgICAgICAgICAgcmV0dXJuIElSUV9OT05FOw0KICAgICAgICB9DQoNCi0gICAgICAgaWYg
KHN0YXR1cykgew0KKyAgICAgICBpZiAoc3RhdHVzICYmIChyZWFkX3JldHJ5X2NvdW50IDwgUkVB
RF9SRVRSWV9NQVgpKSB7DQogICAgICAgICAgICAgICAgcGNpZV9jYXBhYmlsaXR5X3dyaXRlX3dv
cmQocGRldiwgUENJX0VYUF9TTFRTVEEsIGV2ZW50cyk7DQoNCiAgICAgICAgICAgICAgICAvKg0K
QEAgLTU5NCw4ICs1OTUsMTAgQEAgc3RhdGljIGlycXJldHVybl90IHBjaWVocF9pc3IoaW50IGly
cSwgdm9pZCAqZGV2X2lkKQ0KICAgICAgICAgICAgICAgICAqIFNvIHJlLXJlYWQgdGhlIFNsb3Qg
U3RhdHVzIHJlZ2lzdGVyIGluIGNhc2UgYSBiaXQgd2FzIHNldA0KICAgICAgICAgICAgICAgICAq
IGJldHdlZW4gcmVhZCBhbmQgd3JpdGUuDQogICAgICAgICAgICAgICAgICovDQotICAgICAgICAg
ICAgICAgaWYgKHBjaV9kZXZfbXNpX2VuYWJsZWQocGRldikgJiYgIXBjaWVocF9wb2xsX21vZGUp
DQorICAgICAgICAgICAgICAgaWYgKHBjaV9kZXZfbXNpX2VuYWJsZWQocGRldikgJiYgIXBjaWVo
cF9wb2xsX21vZGUpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfcmV0cnlfY291bnQr
KzsNCiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gcmVhZF9zdGF0dXM7DQorICAgICAgICAg
ICAgICAgfQ0KICAgICAgICB9DQpSZWdhcmRzLg0KSm9zZXBoDQoNClJlZ2FyZHMuDQpKb3NlcGgN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHN0dWFydCBoYXllcyA8c3R1YXJ0
LncuaGF5ZXNAZ21haWwuY29tPiANClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDksIDIwMjEgMTE6
MzcgUE0NClRvOiBCYW8sIEpvc2VwaCA8am9zZXBoLmJhb0BpbnRlbC5jb20+OyBCam9ybiBIZWxn
YWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+DQpDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29v
Z2xlLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KU3ViamVjdDogUmU6IEhX
IHBvd2VyIGZhdWx0IGRlZmVjdCBjYXVzZSBzeXN0ZW0gaGFuZyBvbiBrZXJuZWwgNS40LnkNCg0K
DQoNCk9uIDExLzkvMjAyMSAxOjU5IEFNLCBCYW8sIEpvc2VwaCB3cm90ZToNCj4gSGkgTHVrYXMv
U3R1YXJ0LA0KPiBXYW50IHRvIGZvbGxvdyB1cCB3aXRoIHlvdSB3aGV0aGVyIHRoZSBzeXN0ZW0g
aGFuZyBpcyBleHBlY3RlZCB3aGVuIEhXIGhhcyBhIGRlZmVjdCBrZWVwaW5nIFBDSV9FWFBfU0xU
U1RBX1BGRCBhbHdheXMgSElHSC4NCj4gDQo+IA0KPiBSZWdhcmRzDQo+IEpvc2VwaA0KPiANCg0K
SXQgZG9lcyBhcHBlYXIgdGhhdCB0aGUgY29kZSB3aWxsIGhhbmcgd2hlbiBwY2llaHBfaXNyIHNl
ZXMgUEZEIGhpZ2ggYW5kIHBvd2VyX2ZhdWx0X2RldGVjdGVkIGlzbid0IHlldCBzZXQsIGlmIFBG
RCBkb2Vzbid0IGNsZWFyIHdoZW4gYSAxIGlzIHdyaXR0ZW4gdG8gaXQuICBJdCB3aWxsIGNvbnRp
bnVlIHRvIGxvb3AgdHJ5aW5nIHRvIGNsZWFyIGl0LCBhbmQgcG93ZXJfZmF1bHRfZGV0ZWN0ZWQg
d29uJ3QgZ2V0IHNldCB1bnRpbCBhZnRlciBpdCBnZXRzIHRocm91Z2ggdGhpcyBsb29wLg0KDQpJ
dCB3b3VsZG4ndCBiZSBoYXJkIHRvIG1vZGlmeSB0aGF0IGNvZGUgdG8gb25seSBhdHRlbXB0IHRv
IGNsZWFyIGVhY2ggYml0IG9uY2UuICBJIHdvdWxkbid0IGV4cGVjdCB0aGUgc2FtZSBldmVudCBi
aXQgdG8gZ2V0IHNldCB0d2ljZSB3aXRoaW4gdGhpcyBsb29wLCBzbyB0aGlzIG1pZ2h0IGZpeCBp
dCAoSSBkaWQgbm90IHRlc3QpLiAgQWx0ZXJuYXRlbHksIGEgbG9vcCBjb3VudGVyIGNvdWxkIGJl
IGFkZGVkIHRvIHByZXZlbnQgaXQgZnJvbSBsb29waW5nIG1vcmUgdGhhbiBzb21lIGFyYml0cmFy
eSBudW1iZXINCig2Pykgb2YgdGltZXMgaW4gY2FzZSBvZiBzdHVjayBiaXRzLg0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMgYi9kcml2ZXJzL3BjaS9ob3Rw
bHVnL3BjaWVocF9ocGMuYw0KaW5kZXggMzAyNGQ3ZTg1ZTZhLi4zZTUwMmI0ZThlZjcgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYw0KKysrIGIvZHJpdmVycy9w
Y2kvaG90cGx1Zy9wY2llaHBfaHBjLmMNCkBAIC01OTQsNyArNTk0LDcgQEAgc3RhdGljIGlycXJl
dHVybl90IHBjaWVocF9pc3IoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KICAJc3RydWN0IGNvbnRy
b2xsZXIgKmN0cmwgPSAoc3RydWN0IGNvbnRyb2xsZXIgKilkZXZfaWQ7DQogIAlzdHJ1Y3QgcGNp
X2RldiAqcGRldiA9IGN0cmxfZGV2KGN0cmwpOw0KICAJc3RydWN0IGRldmljZSAqcGFyZW50ID0g
cGRldi0+ZGV2LnBhcmVudDsNCi0JdTE2IHN0YXR1cywgZXZlbnRzID0gMDsNCisJdTE2IGNoYW5n
ZWQsIHN0YXR1cywgZXZlbnRzID0gMDsNCiAgDQogIAkvKg0KICAJICogSW50ZXJydXB0cyBvbmx5
IG9jY3VyIGluIEQzaG90IG9yIHNoYWxsb3dlciBhbmQgb25seSBpZiBlbmFibGVkIEBAIC02NDMs
NiArNjQzLDcgQEAgc3RhdGljIGlycXJldHVybl90IHBjaWVocF9pc3IoaW50IGlycSwgdm9pZCAq
ZGV2X2lkKQ0KICAJaWYgKGN0cmwtPnBvd2VyX2ZhdWx0X2RldGVjdGVkKQ0KICAJCXN0YXR1cyAm
PSB+UENJX0VYUF9TTFRTVEFfUEZEOw0KICANCisJY2hhbmdlZCA9IHN0YXR1cyBeIGV2ZW50czsN
CiAgCWV2ZW50cyB8PSBzdGF0dXM7DQogIAlpZiAoIWV2ZW50cykgew0KICAJCWlmIChwYXJlbnQp
DQpAQCAtNjU5LDcgKzY2MCw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBwY2llaHBfaXNyKGludCBp
cnEsIHZvaWQgKmRldl9pZCkNCiAgCQkgKiBTbyByZS1yZWFkIHRoZSBTbG90IFN0YXR1cyByZWdp
c3RlciBpbiBjYXNlIGEgYml0IHdhcyBzZXQNCiAgCQkgKiBiZXR3ZWVuIHJlYWQgYW5kIHdyaXRl
Lg0KICAJCSAqLw0KLQkJaWYgKHBjaV9kZXZfbXNpX2VuYWJsZWQocGRldikgJiYgIXBjaWVocF9w
b2xsX21vZGUpDQorCQlpZiAocGNpX2Rldl9tc2lfZW5hYmxlZChwZGV2KSAmJiAhcGNpZWhwX3Bv
bGxfbW9kZSAmJiBjaGFuZ2VkKQ0KICAJCQlnb3RvIHJlYWRfc3RhdHVzOw0KICAJfQ0KICANCg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJqb3JuIEhlbGdhYXMgPGhl
bGdhYXNAa2VybmVsLm9yZz4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMywgDQo+IDIwMjEg
NjozNCBBTQ0KPiBUbzogQmFvLCBKb3NlcGggPGpvc2VwaC5iYW9AaW50ZWwuY29tPg0KPiBDYzog
Qmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IA0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTdHVhcnQgSGF5ZXMgPHN0
dWFydC53LmhheWVzQGdtYWlsLmNvbT47IA0KPiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5k
ZT4NCj4gU3ViamVjdDogUmU6IEhXIHBvd2VyIGZhdWx0IGRlZmVjdCBjYXVzZSBzeXN0ZW0gaGFu
ZyBvbiBrZXJuZWwgNS40LnkNCj4gDQo+IFsrY2MgU3R1YXJ0LCBhdXRob3Igb2YgOGVkZjUzMzJj
MzkzICgiUENJOiBwY2llaHA6IEZpeCBNU0kgaW50ZXJydXB0IA0KPiByYWNlIiksIEx1a2FzLCBw
Y2llaHAgZXhwZXJ0XQ0KPiANCj4gT24gVHVlLCBOb3YgMDIsIDIwMjEgYXQgMDM6NDU6MDBBTSAr
MDAwMCwgQmFvLCBKb3NlcGggd3JvdGU6DQo+PiBIaSwgZGVhciBrZXJuZWwgZGV2ZWxvcGVyLA0K
Pj4NCj4+IFJlY2VudGx5IHdlIGVuY291bnRlciBzeXN0ZW0gaGFuZyAoZGVhZCBzcGlubG9jaykg
d2hlbiBtb3ZlIHRvIGtlcm5lbCANCj4+IGxpbnV4LTUuNC55Lg0KPj4NCj4+IEZpbmFsbHksIHdl
IHVzZSBiaXNlY3QgdG8gbG9jYXRlIHRoZSBzdXNwaWNpb3VzIGNvbW1pdCANCj4+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQv
Y29tbWl0Lz9oPWxpbnV4LTUuNC55JmlkPTQ2NjczNThkYWI5Y2MwN2RhMDQ0ZDViYzA4NzA2NTU0
NWIxMDAwZGYuDQo+IA0KPiA0NjY3MzU4ZGFiOWMgYmFja3BvcnRlZCB1cHN0cmVhbSBjb21taXQg
OGVkZjUzMzJjMzkzICgiUENJOiBwY2llaHA6DQo+IEZpeCBNU0kgaW50ZXJydXB0IHJhY2UiKSB0
byB2NS40LjY5IGp1c3Qgb3ZlciBhIHllYXIgYWdvLg0KPiANCj4+IE91ciBzeXN0ZW0gaGFzIHNv
bWUgSFcgZGVmZWN0LCB3aGljaCB3aWxsIHdyb25nbHkgc2V0IA0KPj4gUENJX0VYUF9TTFRTVEFf
UEZEIGhpZ2gsIGFuZCB0aGlzIGNvbW1pdCB3aWxsIGxlYWQgdG8gaW5maW5pdGUgbG9vcCANCj4+
IGp1bXBpbmcgdG8gcmVhZF9zdGF0dXMgKG5vIGNoYW5jZSB0byBjbGVhciBzdGF0dXMgUENJX0VY
UF9TTFRTVEFfUEZEIA0KPj4gYml0IHNpbmNlIGN0cmwgaXMgbm90IHVwZGF0ZWQpLCBJIGtub3cg
dGhpcyBpcyBvdXIgSFcgZGVmZWN0LCBidXQgDQo+PiB0aGlzIGNvbW1pdCBtYWtlcyBrZXJuZWwg
dHJhcHBlZCBpbiB0aGlzIGlzciBmdW5jdGlvbiBhbmQgbGVhZHMgdG8gDQo+PiBrZXJuZWwgaGFu
ZyAodGhlbiB0aGUgdXNlciBjb3VsZCBub3QgZ2V0IHVzZWZ1bCBpbmZvcm1hdGlvbiB0byBzaG93
IA0KPj4gd2hhdCdzIHdyb25nKSwgd2hpY2ggSSB0aGluayBpcyBub3QgZXhwZWN0ZWQgYmVoYXZp
b3IsIHNvIEkgd291bGQgDQo+PiBsaWtlIHRvIHJlcG9ydCB0byB5b3UgZm9yIGRpc2N1c3Npb24u
DQo+IA0KPiBJIGd1ZXNzIHRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSBmaXJzdCB0aW1lIHdlIGhh
bmRsZSBQRkQsDQo+IHBjaWVocF9pc3QoKSBzZXRzICJjdHJsLT5wb3dlcl9mYXVsdF9kZXRlY3Rl
ZCA9IDEiLCBhbmQgd2hlbiBwb3dlcl9mYXVsdF9kZXRlY3RlZCBpcyBzZXQsIHBjaWVocF9pc3Io
KSB3b24ndCBjbGVhciBQRkQgZnJvbSBQQ0lfRVhQX1NMVFNUQT8NCj4gDQo+IEl0IGxvb2tzIGxp
a2UgdGhlIG9ubHkgcGxhY2Ugd2UgY2xlYXIgcG93ZXJfZmF1bHRfZGV0ZWN0ZWQgaXMgaW4gcGNp
ZWhwX3Bvd2VyX29uX3Nsb3QoKSwgYW5kIEkgZG9uJ3QgdGhpbmsgd2UgY2FsbCB0aGF0IHVubGVz
cyB3ZSBoYXZlIGEgcHJlc2VuY2UgZGV0ZWN0IG9yIGxpbmsgc3RhdHVzIGNoYW5nZS4NCj4gDQo+
IEl0IHdvdWxkIGRlZmluaXRlbHkgYmUgbmljZSBpZiB3ZSBjb3VsZCBhcnJhbmdlIHNvIHRoaXMg
aGFyZHdhcmUgZGVmZWN0IGRpZG4ndCBjYXVzZSBhIGtlcm5lbCBoYW5nLg0KPiANCj4gSSB0aGlu
ayB0aGUgZGlmZiBiZWxvdyBpcyB0aGUgYmFja3BvcnQgb2YgOGVkZjUzMzJjMzkzICgiUENJOiBw
Y2llaHA6DQo+IEZpeCBNU0kgaW50ZXJydXB0IHJhY2UiKS4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMNCj4+IGIvZHJpdmVycy9wY2kvaG90cGx1
Zy9wY2llaHBfaHBjLmMNCj4+IGluZGV4IDM1Njc4NmEzYjdmNGIuLjg4Yjk5Njc2NGZmOTUgMTAw
NjQ0DQo+PiAtLS0NCj4+IGEvaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC90cg0KPj4gZQ0KPj4gZS9kcml2ZXJzL3BjaS9ob3Rw
bHVnL3BjaWVocF9ocGMuYz9oPWxpbnV4LTUuNC55JmlkPWNhNzY3Y2YwMTUyZDE4ZmMyDQo+PiA5
DQo+PiA5Y2RlODViMThkMWY0NmFjMjFlMWJhDQo+PiArKysgYi9odHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2kNCj4+ICsrKyB0IA0K
Pj4gKysrIC90cmVlL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jP2g9bGludXgtNS40
LnkmaWQ9NDY2NzM1OGRhDQo+PiArKysgYg0KPj4gKysrIDljYzA3ZGEwNDRkNWJjMDg3MDY1NTQ1
YjEwMDBkZg0KPj4gQEAgLTUyOSw3ICs1MjksNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgcGNpZWhw
X2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+PiAgIAlzdHJ1Y3QgY29udHJvbGxlciAqY3Ry
bCA9IChzdHJ1Y3QgY29udHJvbGxlciAqKWRldl9pZDsNCj4+ICAgCXN0cnVjdCBwY2lfZGV2ICpw
ZGV2ID0gY3RybF9kZXYoY3RybCk7DQo+PiAgIAlzdHJ1Y3QgZGV2aWNlICpwYXJlbnQgPSBwZGV2
LT5kZXYucGFyZW50Ow0KPj4gLQl1MTYgc3RhdHVzLCBldmVudHM7DQo+PiArCXUxNiBzdGF0dXMs
IGV2ZW50cyA9IDA7DQo+PiAgIA0KPj4gICAJLyoNCj4+ICAgCSAqIEludGVycnVwdHMgb25seSBv
Y2N1ciBpbiBEM2hvdCBvciBzaGFsbG93ZXIgYW5kIG9ubHkgaWYgZW5hYmxlZCANCj4+IEBAIC01
NTQsNiArNTU0LDcgQEAgc3RhdGljIGlycXJldHVybl90IHBjaWVocF9pc3IoaW50IGlycSwgdm9p
ZCAqZGV2X2lkKQ0KPj4gICAJCX0NCj4+ICAgCX0NCj4+ICAgDQo+PiArcmVhZF9zdGF0dXM6DQo+
PiAgIAlwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKHBkZXYsIFBDSV9FWFBfU0xUU1RBLCAmc3Rh
dHVzKTsNCj4+ICAgCWlmIChzdGF0dXMgPT0gKHUxNikgfjApIHsNCj4+ICAgCQljdHJsX2luZm8o
Y3RybCwgIiVzOiBubyByZXNwb25zZSBmcm9tIGRldmljZVxuIiwgX19mdW5jX18pOyBAQA0KPj4g
LTU2NiwyNCArNTY3LDM3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBwY2llaHBfaXNyKGludCBpcnEs
IHZvaWQgKmRldl9pZCkNCj4+ICAgCSAqIFNsb3QgU3RhdHVzIGNvbnRhaW5zIHBsYWluIHN0YXR1
cyBiaXRzIGFzIHdlbGwgYXMgZXZlbnQNCj4+ICAgCSAqIG5vdGlmaWNhdGlvbiBiaXRzOyByaWdo
dCBub3cgd2Ugb25seSB3YW50IHRoZSBldmVudCBiaXRzLg0KPj4gICAJICovDQo+PiAtCWV2ZW50
cyA9IHN0YXR1cyAmIChQQ0lfRVhQX1NMVFNUQV9BQlAgfCBQQ0lfRVhQX1NMVFNUQV9QRkQgfA0K
Pj4gLQkJCSAgIFBDSV9FWFBfU0xUU1RBX1BEQyB8IFBDSV9FWFBfU0xUU1RBX0NDIHwNCj4+IC0J
CQkgICBQQ0lfRVhQX1NMVFNUQV9ETExTQyk7DQo+PiArCXN0YXR1cyAmPSBQQ0lfRVhQX1NMVFNU
QV9BQlAgfCBQQ0lfRVhQX1NMVFNUQV9QRkQgfA0KPj4gKwkJICBQQ0lfRVhQX1NMVFNUQV9QREMg
fCBQQ0lfRVhQX1NMVFNUQV9DQyB8DQo+PiArCQkgIFBDSV9FWFBfU0xUU1RBX0RMTFNDOw0KPj4g
ICANCj4+ICAgCS8qDQo+PiAgIAkgKiBJZiB3ZSd2ZSBhbHJlYWR5IHJlcG9ydGVkIGEgcG93ZXIg
ZmF1bHQsIGRvbid0IHJlcG9ydCBpdCBhZ2Fpbg0KPj4gICAJICogdW50aWwgd2UndmUgZG9uZSBz
b21ldGhpbmcgdG8gaGFuZGxlIGl0Lg0KPj4gICAJICovDQo+PiAgIAlpZiAoY3RybC0+cG93ZXJf
ZmF1bHRfZGV0ZWN0ZWQpDQo+PiAtCQlldmVudHMgJj0gflBDSV9FWFBfU0xUU1RBX1BGRDsNCj4+
ICsJCXN0YXR1cyAmPSB+UENJX0VYUF9TTFRTVEFfUEZEOw0KPj4gICANCj4+ICsJZXZlbnRzIHw9
IHN0YXR1czsNCj4+ICAgCWlmICghZXZlbnRzKSB7DQo+PiAgIAkJaWYgKHBhcmVudCkNCj4+ICAg
CQkJcG1fcnVudGltZV9wdXQocGFyZW50KTsNCj4+ICAgCQlyZXR1cm4gSVJRX05PTkU7DQo+PiAg
IAl9DQo+PiAgIA0KPj4gLQlwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChwZGV2LCBQQ0lfRVhQ
X1NMVFNUQSwgZXZlbnRzKTsNCj4+ICsJaWYgKHN0YXR1cykgew0KPj4gKwkJcGNpZV9jYXBhYmls
aXR5X3dyaXRlX3dvcmQocGRldiwgUENJX0VYUF9TTFRTVEEsIGV2ZW50cyk7DQo+PiArDQo+PiAr
CQkvKg0KPj4gKwkJICogSW4gTVNJIG1vZGUsIGFsbCBldmVudCBiaXRzIG11c3QgYmUgemVybyBi
ZWZvcmUgdGhlIHBvcnQNCj4+ICsJCSAqIHdpbGwgc2VuZCBhIG5ldyBpbnRlcnJ1cHQgKFBDSWUg
QmFzZSBTcGVjIHI1LjAgc2VjIDYuNy4zLjQpLg0KPj4gKwkJICogU28gcmUtcmVhZCB0aGUgU2xv
dCBTdGF0dXMgcmVnaXN0ZXIgaW4gY2FzZSBhIGJpdCB3YXMgc2V0DQo+PiArCQkgKiBiZXR3ZWVu
IHJlYWQgYW5kIHdyaXRlLg0KPj4gKwkJICovDQo+PiArCQlpZiAocGNpX2Rldl9tc2lfZW5hYmxl
ZChwZGV2KSAmJiAhcGNpZWhwX3BvbGxfbW9kZSkNCj4+ICsJCQlnb3RvIHJlYWRfc3RhdHVzOw0K
Pj4gKwl9DQo+PiArDQo+PiAgIAljdHJsX2RiZyhjdHJsLCAicGVuZGluZyBpbnRlcnJ1cHRzICUj
MDZ4IGZyb20gU2xvdCBTdGF0dXNcbiIsIGV2ZW50cyk7DQo+PiAgIAlpZiAocGFyZW50KQ0KPj4g
ICAJCXBtX3J1bnRpbWVfcHV0KHBhcmVudCk7DQo=
