Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7F1DBFEA
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgETUJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:09:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:11695 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgETUJc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 16:09:32 -0400
IronPort-SDR: ydxf6iNUOR7XaO73SiDSB2P5pdY8nDEuVNpuWk0zBCSuIWyz9R0Y7z8adwi0IsGAkCTXZZgxqI
 VDiS01tU8ehA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 13:09:32 -0700
IronPort-SDR: 22Ev2x6ZPQ78Mz2tqbvPPIRd8FEquVfZJwtIxbIetvJB0QMYgx3wJbBzz3g3l+eYOk/GHHKWdT
 pGaHa8/aE25A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="253724074"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2020 13:09:32 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 13:09:31 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.123]) with mapi id 14.03.0439.000;
 Wed, 20 May 2020 13:09:31 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "thomas.tai@oracle.com" <thomas.tai@oracle.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "subhan.mohammed@oracle.com" <subhan.mohammed@oracle.com>
Subject: Re: Question regarding PCI/AER: Enable reporting for ports
 enumerated after AER driver registration
Thread-Topic: Question regarding PCI/AER: Enable reporting for ports
 enumerated after AER driver registration
Thread-Index: AQHWLt/e1HsT+D+VJEa3vqvgeRH4a6ix3IyA
Date:   Wed, 20 May 2020 20:09:31 +0000
Message-ID: <d9c3371d476c849ccf1aef5fd1b0971c68a8c48e.camel@intel.com>
References: <232b49b5-90cf-8eff-48cb-1bd6ce3a1977@oracle.com>
In-Reply-To: <232b49b5-90cf-8eff-48cb-1bd6ce3a1977@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA1E220708F525478A6C06F1E742C19C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgVGhvbWFzLA0KDQpPbiBXZWQsIDIwMjAtMDUtMjAgYXQgMTU6NDcgLTA0MDAsIFRob21hcyBU
YWkgd3JvdGU6DQo+IEhpIEJqb3JuLA0KPiBJIGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcgIlBD
SS9BRVI6IEVuYWJsZSByZXBvcnRpbmcgZm9yIHBvcnRzIA0KPiBlbnVtZXJhdGVkIGFmdGVyIEFF
UiBkcml2ZXIgcmVnaXN0cmF0aW9uIiBob3BlIHRoYXQgeW91IGRvbid0IG1pbmQgDQo+IGdpdmlu
ZyB1cyBzb21lIGhpbnRzLg0KPiANCj4gV2UgZm91bmQgdGhlIHBhdGNoIG1lbnRpb25lZCBpbiB0
aGUgZm9sbG93aW5nIGxpbmsgZml4ZXMgb25lIG9mIG91ciANCj4gaXNzdWVzIHdoZXJlIGEgZGV2
aWNlJ3MgQUVSIHdhcyBub3QgZW5hYmxlIGNvcnJlY3RseS4NCj4gDQo+IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1wY2kvcGF0Y2gvMTUzNjA4NTk4OS0yOTU2LTEt
Z2l0LXNlbmQtZW1haWwtam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20vDQo+IA0KPiBJIGFtIHdv
bmRlcmluZyB0aGF0IGlmIHlvdSBhcmUgZ29pbmcgdG8gdXBzdHJlYW0gdGhlIHBhdGNoPw0KPiAN
Cj4gVGhhbmsgeW91LA0KPiBUaG9tYXMNCg0KSSBzdXNwZWN0IHlvdSBjb3VsZCBiZSBzZWVpbmcg
aXNzdWVzIGR1ZSB0byB0aGUgZmlybXdhcmUtZmlyc3QNCmRlcGVuZGVuY2llcy4gWW91ciBwbGF0
Zm9ybSBjb3VsZCBiZSByZXF1aXJpbmcgRkZTIHZpYSBIRVNUIHdoaWNoIGlzDQphZmZlY3Rpbmcg
TmF0aXZlIEFFUiBpbiBub24tQUNQSSBkb21haW5zLg0KDQpUaGVyZSB3ZXJlIHNvbWUgcmVjZW50
IGNvbW1pdHMgdG8gY29udmVyZ2UgRkZTIHRvIF9PU0Mgb25seToNCmh0dHBzOi8vbWFyYy5pbmZv
Lz9sPWxpbnV4LXBjaSZtPTE1ODgzNDUzMjcyODExMyZ3PTINCg0KQ291bGQgeW91IHRyeSBCam9y
bidzIGxhdGVzdCBicmFuY2ggPw0KDQpUaGVyZSBpcyBhbHNvIGEgRFBDIHNldCBmb3IgTmF0aXZl
IERQQyB3aGljaCBJIHdpbGwgYmUgcmVzZW5kaW5nIHNvb246DQpodHRwczovL21hcmMuaW5mby8/
bD1saW51eC1wY2kmbT0xNTg4MzU0NTQ0MzE2OTgmdz0yDQoNCg0K
