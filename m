Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3176747E8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjATATi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 19:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjATATh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 19:19:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5959372E;
        Thu, 19 Jan 2023 16:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674173976; x=1705709976;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jONyRn6cR4kHASyurwDGDzuEiqfb7/5fqZ+5axtpFg8=;
  b=FNDxFrnjtYLa1TKoOobEY8KiLRbZ4ldWTNTQHjsLHKky02DMdA4JFGb/
   F9Np03yrxeEU9/fSTMXCYhtNWjkUQwwQv89cUPLaGvIysQbd8ucxC3RAB
   b0pwzJ1deIUVL1BR18S4UepjqMW5lEXy7e+sEHK+EHXGswTiyd+9MoNFP
   9shRrWZ6+hXFB6vH091DfA9j4ID0/jiGyX5nw7+GoCNqdaa5d/YQDawnN
   D9Es6WSuig422Yp13f7kgWnq0mIo46OK4KOS9/H10uOSGcBZh85/jCQfd
   QtPhzWq/GEdl8GupvQQhk0V3AIfpZZihiF6R7GwC2tlkDvHJwppGsDz4I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="389987689"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="389987689"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 16:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653595053"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="653595053"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2023 16:19:35 -0800
Received: from shashemi-mobl.amr.corp.intel.com (unknown [10.212.255.207])
        by linux.intel.com (Postfix) with ESMTP id 12D75580AA4;
        Thu, 19 Jan 2023 16:19:35 -0800 (PST)
Message-ID: <08efd5bc047bbbdff845207593536f658c6a4981.camel@linux.intel.com>
Subject: Re: [PATCH V9 2/4] PCI: vmd: Use PCI_VDEVICE in device list
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Jan 2023 16:19:34 -0800
In-Reply-To: <Y8GJuE9KySv9AcHZ@lpieralisi>
References: <20221208023942.491721-1-david.e.box@linux.intel.com>
         <20221208023942.491721-3-david.e.box@linux.intel.com>
         <4d0d03c0-2880-1b90-ea94-e36d581ca040@linux.intel.com>
         <Y8GJuE9KySv9AcHZ@lpieralisi>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywKCk9uIEZyaSwgMjAyMy0wMS0xMyBhdCAxNzo0MSArMDEwMCwgTG9yZW56byBQ
aWVyYWxpc2kgd3JvdGU6Cj4gT24gV2VkLCBEZWMgMDcsIDIwMjIgYXQgMDY6NTY6MzhQTSAtMDgw
MCwgU2F0aHlhbmFyYXlhbmFuIEt1cHB1c3dhbXkgd3JvdGU6Cj4gPiAKPiA+IAo+ID4gT24gMTIv
Ny8yMiA2OjM5IFBNLCBEYXZpZCBFLiBCb3ggd3JvdGU6Cj4gPiA+IFJlZmFjdG9yIHRoZSBQQ0kg
SUQgbGlzdCB0byB1c2UgUENJX1ZERVZJQ0UuCj4gPiAKPiA+IEFkZCBzb21lIGluZm8gYWJvdXQg
d2h5IGl0IGlzIGRvbmUuCj4gCj4gSSBhbSB3YWl0aW5nIGZvciB0aGUgZHVzdCB0byBzZXR0bGUg
b24gdGhpcyBzZXJpZXMsIGl0IGlzIHByZXR0eQo+IGNsb3NlIHRvIGNvbXBsZXRpb24gaXQgc2Vl
bXMsIHBsZWFzZSBsZXQgbWUga25vdyB3aGVuIHlvdSBjb25zaWRlcgo+IGl0IHJlYWR5LgoKSSdt
IHNlbmRpbmcgYSBWMTAganVzdCB0byBhZGQgdGhlIGNvbW1pdCBtZXNzYWdlIFNhdGh5YSBzdWdn
ZXN0ZWQuIEJ1dCBvdGhlcgp0aGFuIHRoYXQgaXQgaXMgZG9uZSBmb3IgbWUuCgpEYXZpZAoKPiAK
PiBMb3JlbnpvCj4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEUuIEJveCA8ZGF2aWQuZS5i
b3hAbGludXguaW50ZWwuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogSm9uIERlcnJpY2sgPGpvbmF0
aGFuLmRlcnJpY2tAbGludXguZGV2Pgo+ID4gPiBSZXZpZXdlZC1ieTogTmlybWFsIFBhdGVsIDxu
aXJtYWwucGF0ZWxAbGludXguaW50ZWwuY29tPgo+ID4gPiAtLS0KPiA+ID4gwqBWOSAtIE5vIGNo
YW5nZQo+ID4gPiAKPiA+ID4gwqBWOCAtIE5vIGNoYW5nZQo+ID4gPiAKPiA+ID4gwqBWNyAtIE5l
dyBQYXRjaC4gU2VwYXJhdGUgcGF0Y2ggc3VnZ2VzdGVkIGJ5IExvcmVuem8KPiA+ID4gCj4gPiA+
IMKgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0KPiA+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+ID4g
PiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jCj4gPiA+IGluZGV4IGUwNmU5ZjRmYzUwZi4uOWRlZGNh
NzE0YzE4IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jCj4g
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMKPiA+ID4gQEAgLTk5NCwzMyAr
OTk0LDMzIEBAIHN0YXRpYyBpbnQgdm1kX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiA+
IMKgc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKHZtZF9kZXZfcG1fb3BzLCB2bWRfc3VzcGVuZCwg
dm1kX3Jlc3VtZSk7Cj4gPiA+IMKgCj4gPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2
aWNlX2lkIHZtZF9pZHNbXSA9IHsKPiA+ID4gLcKgwqDCoMKgwqDCoMKge1BDSV9ERVZJQ0UoUENJ
X1ZFTkRPUl9JRF9JTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF9WTURfMjAxRCksCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoHtQQ0lfVkRFVklDRShJTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF9WTURf
MjAxRCksCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRh
ID0gVk1EX0ZFQVRfSEFTX01FTUJBUl9TSEFET1dfVlNDQVAsfSwKPiA+ID4gLcKgwqDCoMKgwqDC
oMKge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF9W
TURfMjhDMCksCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHtQQ0lfVkRFVklDRShJTlRFTCwgUENJX0RF
VklDRV9JRF9JTlRFTF9WTURfMjhDMCksCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLmRyaXZlcl9kYXRhID0gVk1EX0ZFQVRfSEFTX01FTUJBUl9TSEFET1cgfAo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgVk1EX0ZFQVRfSEFTX0JVU19SRVNUUklDVElPTlMgfAo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgVk1EX0ZF
QVRfQ0FOX0JZUEFTU19NU0lfUkVNQVAsfSwKPiA+ID4gLcKgwqDCoMKgwqDCoMKge1BDSV9ERVZJ
Q0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHg0NjdmKSwKPiA+ID4gK8KgwqDCoMKgwqDCoMKge1BD
SV9WREVWSUNFKElOVEVMLCAweDQ2N2YpLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1CQVJfU0hBRE9XX1ZTQ0FQIHwK
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFZNRF9GRUFUX0hBU19CVVNfUkVTVFJJQ1RJT05TIHwKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oFZNRF9GRUFUX09GRlNFVF9GSVJTVF9WRUNUT1IsfSwKPiA+ID4gLcKgwqDCoMKgwqDCoMKge1BD
SV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHg0YzNkKSwKPiA+ID4gK8KgwqDCoMKgwqDC
oMKge1BDSV9WREVWSUNFKElOVEVMLCAweDRjM2QpLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1CQVJfU0hBRE9XX1ZT
Q0FQIHwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFZNRF9GRUFUX0hBU19CVVNfUkVTVFJJQ1RJT05TIHwKPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoFZNRF9GRUFUX09GRlNFVF9GSVJTVF9WRUNUT1IsfSwKPiA+ID4gLcKgwqDCoMKgwqDC
oMKge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhNzdmKSwKPiA+ID4gK8KgwqDC
oMKgwqDCoMKge1BDSV9WREVWSUNFKElOVEVMLCAweGE3N2YpLAo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1CQVJfU0hB
RE9XX1ZTQ0FQIHwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFZNRF9GRUFUX0hBU19CVVNfUkVTVFJJQ1RJT05TIHwK
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFZNRF9GRUFUX09GRlNFVF9GSVJTVF9WRUNUT1IsfSwKPiA+ID4gLcKgwqDC
oMKgwqDCoMKge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHg3ZDBiKSwKPiA+ID4g
K8KgwqDCoMKgwqDCoMKge1BDSV9WREVWSUNFKElOVEVMLCAweDdkMGIpLAo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1C
QVJfU0hBRE9XX1ZTQ0FQIHwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFZNRF9GRUFUX0hBU19CVVNfUkVTVFJJQ1RJ
T05TIHwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFZNRF9GRUFUX09GRlNFVF9GSVJTVF9WRUNUT1IsfSwKPiA+ID4g
LcKgwqDCoMKgwqDCoMKge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhZDBiKSwK
PiA+ID4gK8KgwqDCoMKgwqDCoMKge1BDSV9WREVWSUNFKElOVEVMLCAweGFkMGIpLAo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hB
U19NRU1CQVJfU0hBRE9XX1ZTQ0FQIHwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFZNRF9GRUFUX0hBU19CVVNfUkVT
VFJJQ1RJT05TIHwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFZNRF9GRUFUX09GRlNFVF9GSVJTVF9WRUNUT1IsfSwK
PiA+ID4gLcKgwqDCoMKgwqDCoMKge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJ
X0RFVklDRV9JRF9JTlRFTF9WTURfOUEwQiksCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHtQQ0lfVkRF
VklDRShJTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF9WTURfOUEwQiksCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRhID0gVk1EX0ZFQVRfSEFTX01FTUJB
Ul9TSEFET1dfVlNDQVAgfAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgVk1EX0ZFQVRfSEFTX0JVU19SRVNUUklDVElP
TlMgfAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgVk1EX0ZFQVRfT0ZGU0VUX0ZJUlNUX1ZFQ1RPUix9LAo+ID4gCj4g
PiAtLSAKPiA+IFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15Cj4gPiBMaW51eCBLZXJuZWwgRGV2
ZWxvcGVyCgo=

