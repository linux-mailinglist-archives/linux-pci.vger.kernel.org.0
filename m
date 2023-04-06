Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E136DA5F3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjDFWqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjDFWqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 18:46:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6409C9EF8;
        Thu,  6 Apr 2023 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680821176; x=1712357176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=23pyhOfYFpMqZohsNtnk7XDxL9YnKfBWKdx53RftC+A=;
  b=nEFwKo+UW8LVysoZU1lp38Xe92LstcZshA19IylnxcflRigA+vEC4fVo
   D9pRZQE3ABQXsk2oGxbGM2n5mLXyRNPFOIRcC2WdoSRF/p2xvtfW1BTK/
   4jrAr5F2VQLtso75PeIW7jbKjgBXlAZcXmsclQ/AD66wsuBDYNkh7Lpzs
   8y5WIU5W0yh/d7nzVay7pDRkzI3CUPpmRiD+0GYXXkK308WU8cyq13En9
   fxEvafAKWcK2gQsB9R847JlryS+a6635AeN1FVQbmdHghXOWrs3oGO5h6
   OZJehA11rYK/YxW/ZVwzpjTd/1lSL6ZPcDdvjue8kPggabNGfxmO8Nt8N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407985102"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407985102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 15:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="680833289"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="680833289"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 06 Apr 2023 15:46:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 15:46:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 15:46:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 15:46:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 15:46:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0eJNUqCZlUgpQAflxRiixPxo9ikGgnliJVrlXgEpsQJwSTsYrQXoNyHYPerKb0HDHHaLcrvxSW3jzRn+j/0MjxC9cDIF+ZZWYZRz3q527vW5gq/W8woMrfrOfKlfjweMH6UeNk+nmYqUeCXK/G4I5y1wBTUqvunBvJGt7C/k786yRcrgnaDLSQMPeiZvzCu0gXoN5m841+ns/w1C/j2Y1v2peTeXnM2R8TLGLPJhtjxRM/z7z6Fqk74dh5N89rvZKjswAiUyXrTTPzDWSXothPlvKNcAddZQqJ8oBVGpJ8hpNbAMraFI6HTDxgBnfy4TUR+sxcL7Zbq5PApmoxxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23pyhOfYFpMqZohsNtnk7XDxL9YnKfBWKdx53RftC+A=;
 b=egrPB3jXZVNKbpuy9ng/X8qaFtMnFRx7DIt9gyFjxxP66PXYZQzjkpkuepAXk6aLwjBW4CX9ztK3h6Oi3ijSNMt8sztnGJUv7X9HS/HV/PDur8NA6J8F6IRmz9hLzOKi6ChdpkOir8MBV7H0CwAfPckG67LJqxltSN3S0z9bU+8wdyX5FV3z3GJWIrEkcmQMCsx5xPzAZiFCTptEM6vEzL0z73wiDyZLgAqLtYpqLNxHqSnRdN4PYj+8IEKjP7FHJnL1xidGu87zrtulYRKthXE7GwjogipAr1ao+rEpY+a1dwKIZaZ8Rorzbo0CQXkx9z8iybaN+U9kcY8nxbnQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5627.namprd11.prod.outlook.com (2603:10b6:510:e4::9)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 22:46:08 +0000
Received: from PH0PR11MB5627.namprd11.prod.outlook.com
 ([fe80::2864:1a43:1d11:4036]) by PH0PR11MB5627.namprd11.prod.outlook.com
 ([fe80::2864:1a43:1d11:4036%8]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 22:46:07 +0000
From:   "Natu, Mahesh" <mahesh.natu@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Thread-Topic: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Thread-Index: AQHZaNILPgjqoT4o4E6v9yh9LAhisK8e2qeAgAAA/hA=
Date:   Thu, 6 Apr 2023 22:46:07 +0000
Message-ID: <PH0PR11MB56279E58301D3CC8813EC709F5919@PH0PR11MB5627.namprd11.prod.outlook.com>
References: <a4803e7e-bbfe-8925-88e9-935775960e63@linux.intel.com>
 <20230406222135.GA3743643@bhelgaas>
In-Reply-To: <20230406222135.GA3743643@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5627:EE_|SA2PR11MB4956:EE_
x-ms-office365-filtering-correlation-id: 32c3bea2-8862-49ed-3e6c-08db36f0b61e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddGKKyH7tszmEf7B8YFxswN/U0t6ARpiowB5H94oBqXXozxgrunrNklJrllZo9ii2+/W2IQOBjQMJSVNB5S18RSHPAQQUx8LGjU+KVbmn7c6+VXOWKNjTNr/QQq5/6UO2F+a6n94Q2FWwL7UYXKE3JubrVoyJHGPfqCKLekEMkxnXvzQDdwd/usmwOyDTe3IpDbm8UQMGVNZgAGPdAy9CvdOTRKDw9aMAyc2KYUv2/5FmhVw9nIh+eHbLzcHu2lz+jEKEWQNEB657RcX8/NHIPTOGbQI/QszIHp7FPr1V2cFvD/2MeuAGOlq3aHhWZmYt1zpJOo/EmkFSqneZdRporwR1/BKp/L3SG9hGK8Mu+WHHDDAbL+TEHxgVvVUvHzYtUOtMQRrAFfHZLxmoMznDkC13CRtuzpfvWf8ad+vPmnekAX7dXJyQdK6dGKBnUdAs7gmxMOqViFUVtxo4CLJZWIqd8K/qVBFnuUpDZFu9wMcA84qfY2pWY80ala0f2UYjhh7owewM0qtLGyJ4D882hcvy5r3PFVBdE7u9jCkY8phgbITnaAvJRH2QKxFmRilnQQGOABG1Nkczf5E28OgKJ5Y0R3nxl9D2D9oOQaVV0KaYZ1EFuitj4IG6M+FVkoG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5627.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(4326008)(33656002)(55016003)(41300700001)(38100700002)(38070700005)(66946007)(52536014)(66556008)(8936002)(66476007)(86362001)(66446008)(64756008)(76116006)(8676002)(5660300002)(122000001)(82960400001)(2906002)(110136005)(186003)(83380400001)(9686003)(6506007)(26005)(53546011)(478600001)(71200400001)(54906003)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tyt6eDFSL0IrcnZ4NHRLU2hEWlNEVStVUjh4M0drWE1hc0xxR283QnZwc2Zs?=
 =?utf-8?B?anpqWWMxMklRS09SWXp1aFllK250OGhIY2dtM3lWNkI2T0RBeDl6MHpDNWhY?=
 =?utf-8?B?eGNjVG5mMkxpZjM4TGNoU3VJMnZPN3RxUnVBOTYvN3hHQ2R5d0JXZWxRcWZB?=
 =?utf-8?B?RmVEbFJmL3hLek5MeWhrSkxwRWkrYlY3UkR3K2d6TEEycXdSaldjSmdjc0Fo?=
 =?utf-8?B?TnNSV3RQVVQrTlBEa1d5VEV1NTh6VGs2d0lTS2h5ZEVZUFphdTB5OURZck1r?=
 =?utf-8?B?ekZuaUNxZmpZSk5qRDNVRW1LeWY2M1gxcU83RmcrMnRURjJVQ21vR1ZWMno2?=
 =?utf-8?B?ZHU1UFdPY1dKbzdDOXA5NGRlZnM3OFJwUFZUejR5TEdSM1EzWlQxT2ZRUjZv?=
 =?utf-8?B?STRScjBiWVdLNm55WThZUGEyWW4xTnhQUlRjckVoT2JZTmZQZUdvby9YS1Nq?=
 =?utf-8?B?ZWRhMHp3TngrSUlKcUtwSzZtcWhocnhjcVdqaHVvakpaaksybjk3WEl4VFdY?=
 =?utf-8?B?cGZ5NGF4bE5aQXA1VS91N2h4cHRFdWxQbktOZmx4cFVPc25NbTIzUUJIYzMy?=
 =?utf-8?B?RU1yWGV2YnE5Sk1KakdqY1ZpTkcyNVZNRE1HcStkeUNITGVMOW5pbjl1ODZH?=
 =?utf-8?B?UzJtRXR1enBYRUR1bVIyaFNDQzhXUGhUUTRXcE0yS3dVR0V1MDBFeUFqalhR?=
 =?utf-8?B?bE5HSmRlaHUrc1dIWHhicGdsQVJwSTFKU01JN3dVM0tCeGpDWHlOOUVzY2kv?=
 =?utf-8?B?YmROVnMxdmw1dDFUcVJMNVZYK2FVT3M3VkUrMWZoWmczUnJjczhhS1NXcTFG?=
 =?utf-8?B?cEtvbGJrQURYYjJYN3QwTHJ4ZWtNYVB1QmhzKytMS2I5VmVSVWQ3QXZxNUky?=
 =?utf-8?B?VUc3b0VQVHEvMThTNTdRMHFvZmY4eXV6dk5uQ3FhMFV6YlVKRWllZVlHM3ZP?=
 =?utf-8?B?d3pVbHkxM0M5UXFNRFUwWjJCdUZMK3o2T0c5Z0thZlkrR0t3VUY0VjNGV2Vi?=
 =?utf-8?B?NEJ6djhmbk9zT0pidXIwUUlnQlNod3VkUEpZVDMyL1NaTklOeEhFWkVqRGlz?=
 =?utf-8?B?WmY4ZmFyUzVzVGp6R2lrZFBwZWNMRzA4ejNyaEdTVkpkOWtLc0x4cFl5dVk0?=
 =?utf-8?B?MjJNUTFJaDBjazlrVGtwL0NpL3E4TFhLUFNEL3loTzY5bnNnZUJXUWtLcytZ?=
 =?utf-8?B?a3ArRHR1dWpIK2M0TkpxdERFNDRmQk1qdVExYWVwZWhBVmhHMkduRW1pdkZ2?=
 =?utf-8?B?SGRoa1RtRyt1MnB6MDc5WnJETVEvV1psbE5PVjhGRlFjOGk1c3loaUlJc2ZG?=
 =?utf-8?B?ZFJvZjljSDVOcFZ3VU9RUjhwZ0JWQk9ER2M5dmNORWpySHpWKzhNQytKZlN5?=
 =?utf-8?B?dVl3MTJOa0VaNHZyZ0NsbHQvOElXM3pQdG1jQ3FDNUxHam40MENVUU5lMU1z?=
 =?utf-8?B?aUJKSi8zT01yYi9CcS9HZE5jaVAwdkVTUVp5Ti9zNlB3dW5COTdkWTdKUGs1?=
 =?utf-8?B?Tzk3c2RwOWl3SUNDb0VIZFZNRXduL1hCSFpPVnU4WC93alRneHNJRTNNUXdk?=
 =?utf-8?B?OVlMZHZZS1BURDVCQmQ1YzA2V3h6L3FnbFErb1NMdjUxc0Q0QXdyNGNNN0tG?=
 =?utf-8?B?bVQ0QVJpVWYxV0RxS2lKWnpqYU5aSWp0Q0orQmo5Z2RWOHlOUU5uYTF4aU9u?=
 =?utf-8?B?cjc5MHFSaDFuRmtMYmNZWTBka0dscE5wRmM1MGFObzVzb1RQS01XNzROZFRB?=
 =?utf-8?B?VmtNZkt2N0o4U0pqbHJNQVBGdnNBOGV1SFFJQzdIMG4yY0JVUjdFWlVsN21S?=
 =?utf-8?B?VmdTa3ZnN3Z1cWxOUUVsV3R2dGxFa0J2dDVZKzZCV29uRURNUWFLRlRJSGtT?=
 =?utf-8?B?emxIS1hNYVRNSDlCd3NiZEcwOHZ4MXV6QWdHenJSY2FFMVBuODVQT3VxTjNG?=
 =?utf-8?B?ZUxOVERBNFN0VHlrVFJ6aVRJZHA3OTRtUDZYcWhNMDNiakxscXMyOWJXQ3lq?=
 =?utf-8?B?MVhlMnlEVnF3Z1haZG9VM0tBSGx4WFRrTkxoWnArbUdFYU5EMHZSTXhmWWNT?=
 =?utf-8?B?UzBUdW1IREQzdnpIUm0rN29HQ3o2WE16NVhKT3d4amtkKzJEbklGTE9yUmFY?=
 =?utf-8?Q?OGPSAlcCgOAIoBegN7KPfhGM7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c3bea2-8862-49ed-3e6c-08db36f0b61e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 22:46:07.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Upjf9xz+toK4fhHZ/S9rPJAVjor2YdpiDhoiZ8+llooF+yV7rnPwUuoyiYm7O0/q0ql4+vgzM9ytcGQGnSHe4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCg0KTXkgYXNzdW1wdGlvbiB3YXMgdGhpcyBzZXF1ZW5jZSBpcyBzb21ldGhpbmcgbGlrZSB0
aGlzLCB3aGVyZSBmaXJtd2FyZQ0KKmNhbid0KiBjb2xsZWN0IGVycm9yIHN0YXR1cyBmcm9tIGRl
dmljZXMgYmVsb3cgdGhlIERvd25zdHJlYW0gUG9ydCBiZWNhdXNlIERQQyBoYXMgYmVlbiB0cmln
Z2VyZWQgYW5kIHRoZXkgYXJlIG5vdCBhY2Nlc3NpYmxlOg0KDQogIC0gSGFyZHdhcmUgdHJpZ2dl
cnMgRFBDIGluIGEgRG93bnN0cmVhbSBQb3J0DQogIC0gRmlybXdhcmUgZmllbGRzIGVycm9yIGlu
dGVycnVwdA0KICAtIEZpcm13YXJlIGNhcHR1cmVzIERvd25zdHJlYW0gUG9ydCBlcnJvciBpbmZv
IChkZXZpY2VzIGJlbG93IGFyZQ0KICAgIG5vdCBhY2Nlc3NpYmxlIGJlY2F1c2Ugb2YgRFBDKQ0K
ICAtIEZpcm13YXJlIHNlbmRzIEVEUiBOb3RpZnkgdG8gT1MNCiAgLSBPUyBicmluZ3MgRG93bnN0
cmVhbSBQb3J0IG91dCBvZiBEUEMNCiAgLSBPUyBjb2xsZWN0cyBlcnJvciBzdGF0dXMgZnJvbSBk
ZXZpY2VzIGJlbG93IERvd25zdHJlYW0gUG9ydA0KICAtIE9TIGV2YWx1YXRlcyBfT1NUDQogIC0g
RmlybXdhcmUgY2FwdHVyZXMgZXJyb3Igc3RhdHVzIGZyb20gZGV2aWNlcyBiZWxvdyBEb3duc3Ry
ZWFtIFBvcnQNCg0KTU46IFRoZSBhYm92ZSBmbG93IGlzIGNvcnJlY3QuIFRoZSBlcnJvciByZWdp
c3RlcnMgb24gdGhlIGRldmljZSBhcmUgc3RpY2t5LCBzbyB0aGV5IHNob3VsZCBzdXJ2aXZlIERQ
QyAoPWhvdCByZXNldCkuDQoNCkJ1dCB0aGF0IGRvZXNuJ3QgZXhwbGFpbiB3aHkgKmZpcm13YXJl
KiBjb3VsZCBub3QgY2xlYXIgdGhlIGVycm9yIHN0YXR1cyBvZiB0aG9zZSBkZXZpY2VzIGFmdGVy
IGl0IGNhcHR1cmVzIGl0Lg0KDQpNTjogQWdhaW4geW91IGFyZSByaWdodC4gVGhlcmUgaXMgbm8g
cmVhc29uIHdoeSBmaXJtd2FyZSBjb3VsZCBub3QgY2xlYXIgZXJyb3Igc3RhdHVzIG9mIHRoZSBk
ZXZpY2UgYWZ0ZXIgdGhlIGxpbmsgaGFzIGJlZW4gYnJvdWdodCBvdXQgb2YgRFBDLCBidXQgYWZ0
ZXIgYSBsb3Qgb2YgYmFjayBhbmQgZm9ydGgsIGl0IHdhcyBkZWNpZGVkIHRoYXQgT1Mgd2lsbCBj
bGVhciB0aGUgZXJyb3IgcmVnaXN0ZXIgb24gdGhlIGRldmljZSBkdXJpbmcgRFBDIHJlY292ZXJ5
PXN1Y2Nlc3MgcGF0aC4gVGhpcyB3YXMgbW9yZSB0aGFuIDQgeWVhcnMgYWdvIGFuZCBJIGhvbmVz
dGx5IGRvbid0IHJlbWVtYmVyIHdoeSB3ZSB3ZW50IHRoaXMgd2F5LiANCg0KSSBndWVzcyB0aGUg
Zmxvd2NoYXJ0ICpkb2VzKiBzaG93IGZpcm13YXJlIGNsZWFyaW5nIHRoZSBlcnJvciBzdGF0dXMg
aW4gdGhlICJkbyBub3QgY29udGludWUgcmVjb3ZlcnkiIHBhdGguDQoNClRoYW5rIHlvdSwNCk1h
aGVzaA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCam9ybiBIZWxnYWFz
IDxoZWxnYWFzQGtlcm5lbC5vcmc+IA0KU2VudDogVGh1cnNkYXksIEFwcmlsIDA2LCAyMDIzIDM6
MjIgUE0NClRvOiBTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteSA8c2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KQ2M6IE5hdHUsIE1haGVzaCA8bWFoZXNoLm5hdHVA
aW50ZWwuY29tPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjJdIFBDSS9FRFI6IENsZWFyIFBDSWUgRGV2aWNlIFN0YXR1cyBlcnJvcnMg
YWZ0ZXIgRURSIGVycm9yIHJlY292ZXJ5DQoNCk9uIFRodSwgQXByIDA2LCAyMDIzIGF0IDAyOjUy
OjAyUE0gLTA3MDAsIFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15IHdyb3RlOg0KPiBPbiA0LzYv
MjMgMjowNyBQTSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiBPbiBXZWQsIE1hciAxNSwgMjAy
MyBhdCAwNDo1NDo0OVBNIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToN
Cj4gPj4gQ29tbWl0IDA2OGMyOWEyNDhiNiAoIlBDSS9FUlI6IENsZWFyIFBDSWUgRGV2aWNlIFN0
YXR1cyBlcnJvcnMgb25seSANCj4gPj4gaWYgT1Mgb3ducyBBRVIiKSBhZGRzIHN1cHBvcnQgdG8g
Y2xlYXIgZXJyb3Igc3RhdHVzIGluIHRoZSBEZXZpY2UgDQo+ID4+IFN0YXR1cw0KPiA+PiBSZWdp
c3RlcihERVZTVEEpIG9ubHkgaWYgT1Mgb3ducyB0aGUgQUVSIHN1cHBvcnQuIEJ1dCB0aGlzIGNo
YW5nZSANCj4gPj4gYnJlYWtzIHRoZSByZXF1aXJlbWVudCBvZiB0aGUgRURSIGZlYXR1cmUgd2hp
Y2ggcmVxdWlyZXMgT1MgdG8gDQo+ID4+IGNsZWFudXAgdGhlIGVycm9yIHJlZ2lzdGVycyBldmVu
IGlmIGZpcm13YXJlIG93bnMgdGhlIGNvbnRyb2wgb2YgQUVSIHN1cHBvcnQuDQo+ID4+DQo+ID4+
IE1vcmUgZGV0YWlscyBhYm91dCB0aGlzIHJlcXVpcmVtZW50IGNhbiBiZSBmb3VuZCBpbiBQQ0ll
IEZpcm13YXJlIA0KPiA+PiBzcGVjaWZpY2F0aW9uIHYzLjMsIFRhYmxlIDQtNiBJbnRlcnByZXRh
dGlvbiBvZiB0aGUgX09TQyBDb250cm9sIEZpZWxkLg0KPiA+PiBJZiB0aGUgT1Mgc3VwcG9ydHPC
oHRoZSBFcnJvciBEaXNjb25uZWN0IFJlY292ZXIgKEVEUikgZmVhdHVyZSBhbmQgDQo+ID4+IGZp
cm13YXJlIHNlbmRzIHRoZSBFRFIgZXZlbnQsIHRoZW4gZHVyaW5nIHRoZSBFRFIgcmVjb3Zlcnkg
d2luZG93LCANCj4gPj4gT1MgaXMgcmVzcG9uc2libGUgZm9yIHRoZSBkZXZpY2UgZXJyb3IgcmVj
b3ZlcnkgYW5kIGhvbGRzIHRoZSANCj4gPj4gb3duZXJzaGlwIG9mIHRoZSBmb2xsb3dpbmcgZXJy
b3IgcmVnaXN0ZXJzLg0KPiA+Pg0KPiA+PiDigKIgRGV2aWNlIFN0YXR1cyBSZWdpc3Rlcg0KPiA+
PiDigKIgVW5jb3JyZWN0YWJsZSBFcnJvciBTdGF0dXMgUmVnaXN0ZXIg4oCiIENvcnJlY3RhYmxl
IEVycm9yIFN0YXR1cyANCj4gPj4gUmVnaXN0ZXIg4oCiIFJvb3QgRXJyb3IgU3RhdHVzIFJlZ2lz
dGVyIOKAoiBSUCBQSU8gU3RhdHVzIFJlZ2lzdGVyDQo+ID4+DQo+ID4+IFNvIGNhbGwgcGNpZV9j
bGVhcl9kZXZpY2Vfc3RhdHVzKCkgaW4gZWRyX2hhbmRsZV9ldmVudCgpIGlmIHRoZSANCj4gPj4g
ZXJyb3IgcmVjb3ZlcnkgaXMgc3VjY2Vzc2Z1bC4NCj4gPj4NCj4gPj4gUmVwb3J0ZWQtYnk6IFRz
YXVyIEVyd2luIDxlcndpbi50c2F1ckBpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEt1
cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIA0KPiA+PiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dh
bXlAbGludXguaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4NCj4gPj4gQ2hhbmdlcyBzaW5jZSB2
MToNCj4gPj4gICogUmViYXNlZCBvbiB0b3Agb2YgdjYuMy1yYzEuDQo+ID4+ICAqIEZpeGVkIGEg
dHlwbyBpbiBwY2llX2NsZWFyX2RldmljZV9zdGF0dXMoKS4NCj4gPj4NCj4gPj4gIGRyaXZlcnMv
cGNpL3BjaWUvZWRyLmMgfCAxICsNCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9lZHIuYyBiL2RyaXZl
cnMvcGNpL3BjaWUvZWRyLmMgaW5kZXggDQo+ID4+IGE2YjliNDc5Yjk3YS4uODc3MzRlNGMzYzIw
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2llL2Vkci5jDQo+ID4+ICsrKyBiL2Ry
aXZlcnMvcGNpL3BjaWUvZWRyLmMNCj4gPj4gQEAgLTE5Myw2ICsxOTMsNyBAQCBzdGF0aWMgdm9p
ZCBlZHJfaGFuZGxlX2V2ZW50KGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGV2ZW50LCB2b2lkICpk
YXRhKQ0KPiA+PiAgCSAqLw0KPiA+PiAgCWlmIChlc3RhdGUgPT0gUENJX0VSU19SRVNVTFRfUkVD
T1ZFUkVEKSB7DQo+ID4+ICAJCXBjaV9kYmcoZWRldiwgIkRQQyBwb3J0IHN1Y2Nlc3NmdWxseSBy
ZWNvdmVyZWRcbiIpOw0KPiA+PiArCQlwY2llX2NsZWFyX2RldmljZV9zdGF0dXMoZWRldik7DQo+
ID4+ICAJCWFjcGlfc2VuZF9lZHJfc3RhdHVzKHBkZXYsIGVkZXYsIEVEUl9PU1RfU1VDQ0VTUyk7
DQo+ID4gDQo+ID4gVGhlIGltcGxlbWVudGF0aW9uIG5vdGUgaW4gUENJIEZpcm13YXJlIHIzLjMs
IHNlYyA0LjYuMTIsIHNob3dzIHRoZSANCj4gPiBPUyBjbGVhcmluZyBlcnJvciBzdGF0dXMgKmFm
dGVyKiBfT1NUIGlzIGV2YWx1YXRlZC4NCj4gPiANCj4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgdGhl
IF9PU0MgRFBDIGNvbnRyb2wgYml0IGluIHRhYmxlIDQtNiBzYXlzIHRoYXQgDQo+ID4gaWYgdGhl
IE9TIGRvZXMgbm90IGhhdmUgRFBDIGNvbnRyb2wsIGl0IGNhbiBvbmx5IHdyaXRlIHRoZSBEZXZp
Y2UgDQo+ID4gU3RhdHVzIGVycm9yIGJpdHMgYmV0d2VlbiB0aGUgRURSIE5vdGlmeSBhbmQgaW52
b2tpbmcgX09TVC4NCj4gPiANCj4gPiBJcyBvbmUgb2YgdGhvc2Ugd3JvbmcsIG9yIGFtIEkgbWlz
c2luZyBzb21ldGhpbmc/DQo+IA0KPiBBZ3JlZS4gSXQgaXMgY29uZmxpY3RpbmcgaW5mby4gSU1P
LCB0aGUgYXJndW1lbnQgdGhhdCB0aGUgT1MgaXMgDQo+IGFsbG93ZWQgdG8gY2xlYXIgdGhlIGVy
cm9yIHJlZ2lzdGVycyBkdXJpbmcgdGhlIEVEUiB3aW5kb3dzIG1ha2VzIG1vcmUgDQo+IHNlbnNl
LiBJZiBPUyBpcyBhbGxvd2VkIHRvIHRvdWNoIGVycm9yIHJlZ2lzdGVycyBvd25lZCBieSBmaXJt
d2FyZSANCj4gYWZ0ZXIgdGhhdCB3aW5kb3csIGl0IHdvdWxkIGxlYWQgdG8gcmFjZSBjb25kaXRp
b25zLg0KPiANCj4gTWFoZXNoLCBsZXQgdXMga25vdyB5b3VyIGNvbW1lbnRzLiBNYXliZSB3ZSBu
ZWVkIHRvIGZpeCB0aGlzIGluIHRoZSANCj4gZmlybXdhcmUgc3BlY2lmaWNhdGlvbi4NCg0KTXkg
YXNzdW1wdGlvbiB3YXMgdGhpcyBzZXF1ZW5jZSBpcyBzb21ldGhpbmcgbGlrZSB0aGlzLCB3aGVy
ZSBmaXJtd2FyZQ0KKmNhbid0KiBjb2xsZWN0IGVycm9yIHN0YXR1cyBmcm9tIGRldmljZXMgYmVs
b3cgdGhlIERvd25zdHJlYW0gUG9ydCBiZWNhdXNlIERQQyBoYXMgYmVlbiB0cmlnZ2VyZWQgYW5k
IHRoZXkgYXJlIG5vdCBhY2Nlc3NpYmxlOg0KDQogIC0gSGFyZHdhcmUgdHJpZ2dlcnMgRFBDIGlu
IGEgRG93bnN0cmVhbSBQb3J0DQogIC0gRmlybXdhcmUgZmllbGRzIGVycm9yIGludGVycnVwdA0K
ICAtIEZpcm13YXJlIGNhcHR1cmVzIERvd25zdHJlYW0gUG9ydCBlcnJvciBpbmZvIChkZXZpY2Vz
IGJlbG93IGFyZQ0KICAgIG5vdCBhY2Nlc3NpYmxlIGJlY2F1c2Ugb2YgRFBDKQ0KICAtIEZpcm13
YXJlIHNlbmRzIEVEUiBOb3RpZnkgdG8gT1MNCiAgLSBPUyBicmluZ3MgRG93bnN0cmVhbSBQb3J0
IG91dCBvZiBEUEMNCiAgLSBPUyBjb2xsZWN0cyBlcnJvciBzdGF0dXMgZnJvbSBkZXZpY2VzIGJl
bG93IERvd25zdHJlYW0gUG9ydA0KICAtIE9TIGV2YWx1YXRlcyBfT1NUDQogIC0gRmlybXdhcmUg
Y2FwdHVyZXMgZXJyb3Igc3RhdHVzIGZyb20gZGV2aWNlcyBiZWxvdyBEb3duc3RyZWFtIFBvcnQN
Cg0KQnV0IHRoYXQgZG9lc24ndCBleHBsYWluIHdoeSAqZmlybXdhcmUqIGNvdWxkIG5vdCBjbGVh
ciB0aGUgZXJyb3Igc3RhdHVzIG9mIHRob3NlIGRldmljZXMgYWZ0ZXIgaXQgY2FwdHVyZXMgaXQu
DQoNCkkgZ3Vlc3MgdGhlIGZsb3djaGFydCAqZG9lcyogc2hvdyBmaXJtd2FyZSBjbGVhcmluZyB0
aGUgZXJyb3Igc3RhdHVzIGluIHRoZSAiZG8gbm90IGNvbnRpbnVlIHJlY292ZXJ5IiBwYXRoLg0K
