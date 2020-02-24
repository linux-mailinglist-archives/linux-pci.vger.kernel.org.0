Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB8B16AE50
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXSFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:05:10 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59374 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1582567509; x=1614103509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=NICTr+BaOX4Un/cBgH5SEx9jaL0bDATdWKKW2yJzuZw=;
  b=r4yN1bgn9RkytyJqLHbERAdrLhkEwMvxVfRJ6b6VRxrY29fJm26XB75N
   RFQjJmw/UBLVVQShHvEL1Vl2xPW7UyPLsokltCOkgaIRGfb+WUd4xySRi
   zAOkMmG2nZRfAQ5B87qhmiNBr1gHBSEMcjuGSIDLz8FhQdrHoq/UHHfn0
   k=;
IronPort-SDR: z7ITEUughIkabfK3Xr+wsEWnnCK2TwXSqWSu8s7cbFFlMe3xEo35j2AlbF4jpW0RhxeGi4WqAc
 7a0Is+ZGrvwg==
X-IronPort-AV: E=Sophos;i="5.70,480,1574121600"; 
   d="scan'208";a="27168047"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 24 Feb 2020 18:05:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 97490A07B7;
        Mon, 24 Feb 2020 18:05:04 +0000 (UTC)
Received: from EX13D09EUC002.ant.amazon.com (10.43.164.73) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 24 Feb 2020 18:05:03 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D09EUC002.ant.amazon.com (10.43.164.73) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 24 Feb 2020 18:05:02 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.000;
 Mon, 24 Feb 2020 18:05:02 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei" <wawei@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Introduce per-device reset_ready_poll override
Thread-Topic: [PATCH 2/3] PCI: Introduce per-device reset_ready_poll override
Thread-Index: AQHV6kPY0XP3tPNngEia4H4MvyG6HagqapsAgAA6uoA=
Date:   Mon, 24 Feb 2020 18:05:02 +0000
Message-ID: <52543631a871ba576b9711d5b6a3fad12019cece.camel@amazon.de>
References: <20200224143450.GA219843@google.com>
In-Reply-To: <20200224143450.GA219843@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.10]
Content-Type: text/plain; charset="utf-8"
Content-ID: <113798D59EBFB64783DEB04E8D0D2988@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTI0IGF0IDA4OjM0IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBJIGxpa2UgdGhlIGZhY3RvcmluZyBvdXQgb2YgdGhlIHRpbWVvdXQsIHNpbmNlIGFsbCBjYWxs
ZXJzIG9mDQo+IHBjaV9kZXZfd2FpdCgpIHN1cHBseSB0aGUgc2FtZSB2YWx1ZS4gIFRoYXQgY291
bGQgYmUgaXRzIG93biBzZXBhcmF0ZQ0KPiBwcmVsaW1pbmFyeSBwYXRjaC4uLg0KDQpBZ3JlZWQu
IFRoZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRjaCBzZXJpZXMgd2lsbCBkbyB0aGUgcmVmYWN0
b3Igc2VwYXJhdGVseS4NCg0KSSBhbSB0aGlua2luZyB3ZSBtaWdodCBhbHNvIHdhbnQgdG8gcmVw
bGFjZSB0aGUgInJlc2V0X3R5cGUiIHdpdGggYW4gZW51bQ0KdGhhdCBpbmRleGVzIGludG8gYW4g
YXJyYXkgdG8gZ2V0IHRoZSBzdHJpbmcsIGJ1dCAtLSBtb3JlIGltcG9ydGFudGx5IC0tDQppbmRl
eGVzIGludG8gYW4gYXJyYXkgb2YgcGVyLWRldmljZSBvdmVycmlkZXMgZm9yIHRoZSB2YXJpb3Vz
IHJlc2V0IHR5cGVzLg0KQXMgcGVyIGRpc2N1c3Npb24gb24gUEFUQ0ggMSwgSSBub3RpY2VkIHRo
ZSBBQ1BJIF9EU00gbWV0aG9kIGRldGFpbGVkIGluDQpQQ0kgRmlybXdhcmUgU3BlYyByMy4yLCA0
LjYuOSBjYW4gcHJvdmlkZSBpbmRpdmlkdWFsIGRlbGF5IHZhbHVlcyBmb3IgZml2ZQ0KZGlmZmVy
ZW50IHNjZW5hcmlvcyAoQ29udmVudGlvbmFsIFJlc2V0LCBETF9VcCwgRkxSLCBEM2hvdCB0byBE
MCwgVkYgRW5hYmxlKSwNCnNvIHdlIHNob3VsZCBwcm9iYWJseSBzdG9yZSBlYWNoIG9mIHRoZW0g
aW4gc3RydWN0IHBjaV9kZXYuDQoNCj4gSSdtIGEgbGl0dGxlIHdhcnkgb2YgImxvd2VyaW5nIHRo
ZSBnbG9iYWwgZGVmYXVsdCBwb3N0LXJlc2V0IHRpbWVvdXQiDQo+IGJlY2F1c2UgdGhhdCdzIG5v
dCBzYWZlIGluIGdlbmVyYWwuICBGb3IgZXhhbXBsZSwgYSBob3QtYWRkZWQgZGV2aWNlDQo+IHRo
YXQgaXMgY29tcGxldGVseSBzcGVjIGNvbXBsaWFudCByZWdhcmRpbmcgcG9zdC1yZXNldCB0aW1p
bmcgbWF5IG5vdA0KPiB3b3JrIGNvcnJlY3RseSBpZiB3ZSd2ZSBsb3dlcmVkIGEgZ2xvYmFsIHRp
bWVvdXQuDQo+IA0KDQpUaGF0IG1ha2VzIHNlbnNlLiBIb3dldmVyLCB0aGUgdGltZW91dCBpcyBj
dXJyZW50bHkgMSBtaW51dGUuDQpUaGUgb25seSB1c2VyIG9mIHRoaXMgdmFsdWUgaXMgcGNpX2Rl
dl93YWl0KCksIHdoaWNoIGlzIGl0c2VsZg0Kb25seSBpbnZva2VkIGFzIHBhcnQgb2YgdmFyaW91
cyByZXNldHMuIEFyZSB0aGVyZSBhbnkgc2NlbmFyaW9zDQp3aGVyZSB0aGF0IG11Y2ggdGltZSBp
cyB0cnVseSBuZWVkZWQgYWZ0ZXIgYSBkZXZpY2UgcmVzZXQ/DQoNCg0KCgoKQW1hem9uIERldmVs
b3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdl
c2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWlu
Z2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBC
ClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

