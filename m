Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC71E2F27
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbgEZTe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:34:26 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16303 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 14:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590519294; x=1622055294;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=sw3GsXgWODA02zmkjx9WwSIRN5Jis0cQ31/Ca05dRdg=;
  b=aM0E67Dfv2LjUwmz9p2n3lClJnNPSoLBGHuLwzEZtbTDc0a8KOQzuO4E
   RMLvNnXtaxyjOaE7bmSUNzR7I1TQzNkCoAIGWQoJ4N8UpSTCG+l8m7+MA
   /KKwH7D/H6avRGDl17i7AFzXkE52p+fQ8uJEUJH4No6XtHX25UXYp5c9e
   I=;
IronPort-SDR: ts3ePCm91EG/cd8uz8c4XPtmkZtbHDMPNckvoQ+t9cj6hYusStsbojEFrsJ2/SMRCuc2l9OLqX
 BPI/CEcEHpHg==
X-IronPort-AV: E=Sophos;i="5.73,437,1583193600"; 
   d="scan'208";a="33663270"
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Thread-Topic: [PATCH v1] PCI: controller: Remove duplicate error message
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 26 May 2020 18:22:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 96E9C28211C;
        Tue, 26 May 2020 18:22:57 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 18:22:57 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 18:22:57 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1497.006;
 Tue, 26 May 2020 18:22:56 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "zhengdejin5@gmail.com" <zhengdejin5@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHWM3A7ZXCRFcozsESZq5tPMlXzIai6rncA
Date:   Tue, 26 May 2020 18:22:56 +0000
Message-ID: <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
In-Reply-To: <20200526150954.4729-1-zhengdejin5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B772E1B8FC60C34D8AEBA36F4B277AEF@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTI2IGF0IDIzOjA5ICswODAwLCBEZWppbiBaaGVuZyB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbw0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXINCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4gDQo+IA0KPiANCj4gSXQgd2lsbCBwcmludCBhbiBlcnJvciBtZXNzYWdlIGJ5IGl0c2Vs
ZiB3aGVuDQo+IGRldm1fcGNpX3JlbWFwX2NmZ19yZXNvdXJjZSgpIGdvZXMgd3JvbmcuIHNvIHJl
bW92ZSB0aGUgZHVwbGljYXRlDQo+IGVycm9yIG1lc3NhZ2UuDQo+IA0KDQpJdCBzZWVtcyBsaWtl
IHRoYXQgaW4gdGhlIGZpcnN0IGVycm9yIGNhc2UgaW4NCmRldm1fcGNpX3JlbWFwX2NmZ19yZXNv
dXJjZSgpLCB0aGUgcHJpbnQgd2lsbCBiZSBsZXNzIGluZGljYXRpdmUuIENvdWxkDQp5b3UgcGxl
YXNlIHNoYXJlIGFuIGV4YW1wbGUgcHJpbnQgbG9nIHdpdGggdGhlIGR1cGxpY2F0ZSBwcmludD8N
Cg0KVGhhbmtzLA0KICAgSm9uYXRoYW4NCg==
