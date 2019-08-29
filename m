Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACB9A288D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 23:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2VBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 17:01:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44269 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2VBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 17:01:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so4796615ote.11;
        Thu, 29 Aug 2019 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q0LKYROnO/5Jtf/PK6jgGgvS0DoPlSzVpeE94fKs7PU=;
        b=gHKBKFR5V0IntTFWx7iQpxi4nWYtIBUxyKiP2x/RNqfTWFWS6IYEpr9dclMb/OeNHL
         D8CnNxsT5f9C8SOnEbxnBdtMYIw+hC40ik7m1UD12L6rht0Mu3+R7AMFRiiIp/aII6i8
         qaWajxJXjBatkg4JLiDs1b0ZSYEs1VLmmdT9EuS5T37PCeakc8H2uJMzyiZ9Zl2diWnX
         7gSkXzZulxsOad5DkxQZTo1/BPb3TI4Z8gx8hoDQx7bORNr8cfaLNOxnrOV2W8BBpW1k
         VeaLzsSAuHV6eGEfD4b/M6Fup10ig9XVUc0hdXFTJRSzeHFOmklLe1HDCO6Zr9YwCRhr
         tEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q0LKYROnO/5Jtf/PK6jgGgvS0DoPlSzVpeE94fKs7PU=;
        b=ByDIh5d0zH9GwZWT7M6IBWKZxyIbUXJZ5iuSCBiMrFiktRrMCr4aPs3BiiVl4h29eR
         +QKA32Gp1tozEVWkbrYLc5niv8Im58GYhH0COYH5a8xiqGwT3e/TKy6d/TbbMN/WhCAL
         ius+9b4WnxlB32GKxuSVdyqsju2gDHbUtuWXj+uL6OgR9hNm5zZ21MP9gtwOvSlhWXps
         XziPoP2vf6aDOVZU+/VKDYEqR1aN0pCy5+pakP5JwCyWOcDBST3+AFKjILR/xos1YMG0
         U6sdvaAAUjVrh4VXIX5d5BxV6VA4Xuw1vqexczXkjLMPw+dN1vV4WylNWxI5AQP29AFD
         CBaA==
X-Gm-Message-State: APjAAAVVBmb9/ObAKckCEbEwpyY+Wgj6+pcz5Jr/N5/E4oLsoMIHz2V4
        PNR1xaIuDachiP/+EJIECzzPE281y3BthCQMeJM=
X-Google-Smtp-Source: APXvYqz8XKcVj5y8chDt54jfqFa4faagnw4jNnBX6f6wAr2Yielcw7NoAUyPgcN8oOW/C+AZOlvjUwN6Tir0AJaafiA=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr9936377otk.81.1567112493063;
 Thu, 29 Aug 2019 14:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com> <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
 <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com> <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
 <023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com>
In-Reply-To: <023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Aug 2019 23:01:22 +0200
Message-ID: <CAFBinCCdje3Q3=adk+gUkcxHfwvAuoB8sQERbDsyt6Q58fgcOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        eswara.kota@linux.intel.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, hch@infradead.org,
        jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQpPbiBUaHUsIEF1ZyAyOSwgMjAxOSBhdCA3OjEwIEFNIEtpc2hvbiBWaWph
eSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+IHdyb3RlOg0KWy4uLl0NCj4gVGhlIFBDSSBFWFBS
RVNTIENBUkQgRUxFQ1RST01FQ0hBTklDQUwgU1BFQ0lGSUNBVElPTiBkZWZpbmVzIHRoZSBQb3dl
cg0KPiBTZXF1ZW5jaW5nIGFuZCBSZXNldCBTaWduYWwgVGltaW5ncyBpbiBUYWJsZSAyLTQuIFBs
ZWFzZSBhbHNvIHJlZmVyIEZpZ3VyZQ0KPiAyLTEwOiBQb3dlciBVcCBvZiB0aGUgQ0VNLg0KPg0K
PiDilZTilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilaTilZDilZDilZDi
lZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDi
lZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilaTilZDilZDi
lZDilZDilZDilaTilZDilZDilZDilZDilZDilaTilZDilZDilZDilZDilZDilZDilZDilZcNCj4g
4pWRIFN5bWJvbCAgICAgIOKUgiBQYXJhbWV0ZXIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
4pSCIE1pbiDilIIgTWF4IOKUgiBVbml0cyDilZENCj4g4pWg4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWq4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWq4pWQ4pWQ4pWQ4pWQ4pWQ4pWq4pWQ4pWQ4pWQ4pWQ4pWQ
4pWq4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWjDQo+IOKVkSBUIFBWUEVSTCAgICDilIIgUG93ZXIg
c3RhYmxlIHRvIFBFUlNUIyBpbmFjdGl2ZSAgICAgIOKUgiAxMDAg4pSCICAgICDilIIgbXMgICAg
4pWRDQo+IOKVn+KUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKU
gOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKV
og0KPiDilZEgVCBQRVJTVC1DTEsg4pSCIFJFRkNMSyBzdGFibGUgYmVmb3JlIFBFUlNUIyBpbmFj
dGl2ZSDilIIgMTAwIOKUgiAgICAg4pSCIM68cyAgICDilZENCj4g4pWf4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA
4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pWiDQo+IOKVkSBUIFBFUlNUICAgICDilIIg
UEVSU1QjIGFjdGl2ZSB0aW1lICAgICAgICAgICAgICAgICAgIOKUgiAxMDAg4pSCICAgICDilIIg
zrxzICAgIOKVkQ0KPiDilZ/ilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilLzilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDi
lIDilIDilaINCj4g4pWRIFQgRkFJTCAgICAgIOKUgiBQb3dlciBsZXZlbCBpbnZhbGlkIHRvIFBF
UlNUIyBhY3RpdmUg4pSCICAgICDilIIgNTAwIOKUgiBucyAgICDilZENCj4g4pWf4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pS84pSA
4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pWiDQo+IOKVkSBUIFdLUkYgICAg
ICDilIIgV0FLRSMgcmlzZSDigJMgZmFsbCB0aW1lICAgICAgICAgICAgICAg4pSCICAgICDilIIg
MTAwIOKUgiBucyAgICDilZENCj4g4pWa4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWn4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWn4pWQ4pWQ4pWQ4pWQ4pWQ4pWn4pWQ4pWQ4pWQ4pWQ4pWQ4pWn4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWdDQo+DQo+IEluIG15IGNvZGUgSSB1c2VkIFQgUEVSU1QtQ0xLIChpLmUg
UkVGQ0xLIHN0YWJsZSBiZWZvcmUgUEVSU1QjIGluYWN0aXZlKS4NCj4gUkVGQ0xLIHRvIHRoZSBj
YXJkIGlzIGVuYWJsZWQgYXMgcGFydCBvZiBQSFkgZW5hYmxlIGFuZCB0aGVuIHdhaXQgZm9yIDEw
MM68cw0KPiBiZWZvcmUgbWFraW5nIFBFUlNUIyBpbmFjdGl2ZS4NCj4NCj4gUG93ZXIgdG8gdGhl
IGRldmljZSBpcyBnaXZlbiBkdXJpbmcgYm9hcmQgcG93ZXIgdXAgYW5kIHRoZSBhc3N1bXB0aW9u
IGhlcmUgaXMNCj4gaXQgd2lsbCB0YWtlIG1vcmUgdGhlIDEwMG1zIGZvciB0aGUgcHJvYmUgdG8g
YmUgaW52b2tlZCBhZnRlciBib2FyZCBwb3dlciB1cA0KPiAoaS5lIGFmdGVyIFJPTSwgYm9vdGxv
YWRlcnMgYW5kIGxpbnV4IGtlcm5lbCkuIEJ1dCBpZiB5b3UgaGF2ZSBhIHJlZ3VsYXRvciB0aGF0
DQo+IGlzIGVuYWJsZWQgaW4gUENJIHByb2JlLCB0aGVuIFQgUFZQRVJMICgxMDBtcykgc2hvdWxk
IGFsc28gdXNlZCBpbiBwcm9iZS4NCnRoYW5rIHlvdSBmb3IgdGhpcyBkZXRhaWxlZCBvdmVydmll
dyBhbmQgZm9yIHRoZSBleHBsYW5hdGlvbiBhYm91dCB0aGUNCmFzc3VtcHRpb25zIHlvdSBtYWRl
IChhbmQgd2h5KQ0KDQoNCk1hcnRpbg0K
