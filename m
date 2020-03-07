Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5F17CDCF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCGLaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 06:30:55 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1776 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgCGLaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 06:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1583580653; x=1615116653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=DFpsOxrHOqsf0PQAJMXueEicUk8UR3W/BgR/3MNxtGQ=;
  b=kx8zo4x93/8NT/ABPXIkAyyZo2Up2E66QoDTeIwVet8hYa9xCi1tyG0c
   7tzRlGxRJWPIwKbqkZxBMaRuPhLe/mh0N/Npquo68C4O73nvLvKVgx8bJ
   xgUI6y72q4MPlLAo6/0980+ea6ObVz2hvo9FUSsRCwiuAk4OXoyoOrHuV
   Q=;
IronPort-SDR: TVStLvUeAY3cWlpbB4oPKkh+oDA9sILjqRezunIG3dlMAeC36jziCEbc+HO8qYdc6zwS/hZK9v
 dhgte9maTtDQ==
X-IronPort-AV: E=Sophos;i="5.70,525,1574121600"; 
   d="scan'208";a="29821054"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Mar 2020 11:30:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id B77A4A20FD;
        Sat,  7 Mar 2020 11:30:49 +0000 (UTC)
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sat, 7 Mar 2020 11:30:49 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D04EUB003.ant.amazon.com (10.43.166.235) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 7 Mar 2020 11:30:46 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.006;
 Sat, 7 Mar 2020 11:30:46 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "Spassov, Stanislav" <stanspas@amazon.de>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 07/17] PCI: Clean up and document PM/reset delays
Thread-Topic: [PATCH v3 07/17] PCI: Clean up and document PM/reset delays
Thread-Index: AQHV9HPXqrNJUMOXV0awv4Rv3HN/bA==
Date:   Sat, 7 Mar 2020 11:30:45 +0000
Message-ID: <575f12241914cc6fa48e250f24db92af560cc375.camel@amazon.de>
References: <20200303132852.13184-1-stanspas@amazon.com>
         <20200303132852.13184-8-stanspas@amazon.com>
         <CAJZ5v0gD4XweLHQzQfRiBxWz8O5mFsc5Chj4JNhX+5ja6Cxrig@mail.gmail.com>
In-Reply-To: <CAJZ5v0gD4XweLHQzQfRiBxWz8O5mFsc5Chj4JNhX+5ja6Cxrig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.196]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C301443B08B384BA0AF6268820C3620@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDIwOjAzICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gDQo+IFdoYXQgIm1hZ2ljIG51bWJlcnMiIGV4YWN0bHkgZG8geW91IG1lYW4/ICBUaGUg
U1JJT1YgYW5kIEZMUiBkZWxheXM/DQo+IFdoeSBub3QgdG8gYmUgbW9yZSBzcGVjaWZpYyBoZXJl
IGlmIHNvPw0KDQpZb3UgYXJlIHJpZ2h0LiBJIGFtIGV4dGVuZGluZyB0aGUgY29tbWl0IG1lc3Nh
Z2UgbGlrZSB0aGlzIGZvciB0aGUgbmV4dCB2ZXJzaW9uOg0KDQogICAgUENJOiBDbGVhbiB1cCBh
bmQgZG9jdW1lbnQgUE0vcmVzZXQgZGVsYXlzDQogICAgDQogICAgVGhlIGV4aXN0aW5nIHNldCBv
ZiBQQ0lfUE1fKiBjb25zdGFudHMgaGFzIHNvbWUgaW5jb25zaXN0ZW5jaWVzIChfV0FJVA0KICAg
IHZzIF9ERUxBWSBzdWZmaXgpLCBhbmQgZG9lcyBub3QgY292ZXIgYWxsIHRoZSBzY2VuYXJpb3Mg
dGhhdCB0aGUgUENJZQ0KICAgIHNwZWNpZmljYXRpb25zIG1hbmRhdGVzIHdhaXRpbmcgcGVyaW9k
cyBmb3IuDQogICAgDQogICAgSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBpbmZyYXN0cnVjdHVy
ZSB0byBvdmVycmlkZSwgb24gYSBwZXItZGV2aWNlDQogICAgYmFzaXMsIHRoZSBpbmRpdmlkdWFs
IHdhaXRpbmcgcGVyaW9kcyB1c2luZyBzdGFuZGFyZGl6ZWQgbWVjaGFuaXNtcywNCiAgICB0aGlz
IGNvbW1pdCBpbnRyb2R1Y2VzIGFuZCBkb2N1bWVudHMgY29uc3RhbnRzIHByb3ZpZGluZyB0aGUg
ZGVmYXVsdA0KICAgIHZhbHVlcyBmb3IgdmFyaW91cyB3YWl0aW5nIHNjZW5hcmlvcyBhbGwgYXJv
dW5kIFBDSSBkZXZpY2UgcmVzZXRzLA0KICAgIFBNIHN0YXRlIGNoYW5nZXMsIGFuZCBlbmFibGlu
ZyBTUi1JT1YgVkZzLg0KICAgIA0KICAgIFNldmVyYWwgaW5zdGFuY2VzIG9mICdtc2xlZXAoMTAw
KScgaW4gdGhlIEZMUiBhbmQgVkYgZW5hYmxlIGNvZGVwYXRocw0KICAgIGhhdmUgYmVlbiBhZGp1
c3RlZCB0byB1c2UgdGhlIG5ld2x5IGludHJvZHVjZWQgY29uc3RhbnRzIGluc3RlYWQuDQogICAg
Q29ycmVzcG9uZGluZyBleHBsYW5hdG9yeSBjb2RlIGNvbW1lbnRzIHdlcmUgcmVtb3ZlZCwgYXMg
dGhleSBhcmUgbm93DQogICAgc3VwZXJzZWRlZCBieSB0aGUgZG9jdW1lbnRhdGlvbiBvZiB0aGUg
Y29uc3RhbnRzLg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK

