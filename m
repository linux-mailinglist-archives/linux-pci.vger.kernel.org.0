Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2E31F3B2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 02:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSBv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 20:51:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:49597 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhBSBv4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 20:51:56 -0500
IronPort-SDR: 3dYRpTndYOOpQitQ5hx4hWI8WRKLYMdhGr2bxxKSUIftPQ7RLz/hUiLJ4/ZDEXNYq0YWb0bzP3
 PRXTNGBFFu3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162851922"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162851922"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 17:51:15 -0800
IronPort-SDR: O1Liyu6Jbtq8AvRzdwF1mY3lu+PFJ2uMjgVftM1NJHdUJPNVOY3IqpnvoEqoFhv4BqSJrYmPje
 3pQZB9Yynetw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="428556190"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2021 17:51:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 17:51:15 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 17:51:13 -0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2106.002;
 Fri, 19 Feb 2021 09:51:11 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     =?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Thread-Topic: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Thread-Index: AQHW/1FxyeRWMorsOUa/1MhtBDu8kapRGxsAgAwb9fCAAMkFgIAAv4Vw
Date:   Fri, 19 Feb 2021 01:51:11 +0000
Message-ID: <610e4c558a654e15b2864d594d5b3902@intel.com>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
 <YCQT90mK1kacZ7ZA@rocinante> <a5b1aa8ef91a4c71982ad77234932349@intel.com>
 <YC7lE2Ph/MHxNKs+@rocinante>
In-Reply-To: <YC7lE2Ph/MHxNKs+@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAuLi4NCj4gDQo+IEkgdG9vayB5b3VyIHN1Z2dlc3Rpb24gYW5kIGNhbWUgdXAgd2l0aCB0aGUg
Zm9sbG93aW5nOg0KPiANCj4gICBGdW5jdGlvbiByY2VjX2Fzc29jX3JjaWVwKCkgaW5jb3JyZWN0
bHkgdXNlZCAicmNpZXAtPmRldmZuIiAoYSBzaW5nbGUNCj4gICBieXRlIGVuY29kaW5nIHRoZSBk
ZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlcikgYXMgdGhlIGRldmljZSBudW1iZXIgdG8NCj4gICBj
aGVjayB3aGV0aGVyIHRoZSBjb3JyZXNwb25kaW5nIGJpdCB3YXMgc2V0IGluIHRoZSBSQ2lFUEJp
dG1hcCBvZiB0aGUNCj4gICBSQ0VDIChSb290IENvbXBsZXggRXZlbnQgQ29sbGVjdG9yKSB3aGls
ZSBlbnVtZXJhdGluZyBvdmVyIGVhY2ggYml0IG9mDQo+ICAgdGhlIFJDaUVQQml0bWFwLg0KPiAN
Cj4gICBBcyBwZXIgdGhlIFBDSSBFeHByZXNzIEJhc2UgU3BlY2lmaWNhdGlvbiwgUmV2aXNpb24g
NS4wLCBWZXJzaW9uIDEuMCwNCj4gICBTZWN0aW9uIDcuOS4xMC4yLCAiQXNzb2NpYXRpb24gQml0
bWFwIGZvciBSQ2lFUHMiLCBwLiA5MzUsIG9ubHkgbmVlZHMgdG8NCj4gICB1c2UgYSBkZXZpY2Ug
bnVtYmVyIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGNvcnJlc3BvbmRpbmcgYml0IHdhcyBzZXQgaW4N
Cj4gICB0aGUgUkNpRVBCaXRtYXAuDQo+IA0KPiAgIEZpeCByY2VjX2Fzc29jX3JjaWVwKCkgdXNp
bmcgdGhlIFBDSV9TTE9UKCkgbWFjcm8gYW5kIGNvbnZlcnQgdGhlIHZhbHVlDQo+ICAgb2YgInJj
aWVwLT5kZXZmbiIgdG8gYSBkZXZpY2UgbnVtYmVyIHRvIGVuc3VyZSB0aGF0IHRoZSBSQ2lFUCBk
ZXZpY2VzDQo+ICAgYXJlIGFzc29jaWF0ZWQgd2l0aCB0aGUgUkNFQyBhcmUgbGlua2VkIHdoZW4g
dGhlIFJDRUMgaXMgZW51bWVyYXRlZC4NCj4NCj4gVXNpbmcgZWl0aGVyIG9mIHRoZSBmb2xsb3dp
bmcgYXMgdGhlIHN1YmplY3Q6DQo+IA0KPiAgIFBDSS9SQ0VDOiBVc2UgZGV2aWNlIG51bWJlciB0
byBjaGVjayBSQ2lFUEJpdG1hcCBvZiBSQ0VDDQo+ICAgUENJL1JDRUM6IEZpeCBSQ2lFUCBjYXBh
YmxlIGRldmljZXMgUkNFQyBhc3NvY2lhdGlvbg0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/ICBB
bHNvLCBmZWVsIGZyZWUgdG8gY2hhbmdlIHdoYXRldmVyIHlvdSBzZWUgZml0LCBvZiBjb3Vyc2Us
IGFzDQo+IHRpcyBpcyBvbmx5IGEgc3VnZ2VzdGlvbi4NCj4gDQoNCkhpIEtyenlzenRvZiwNCg0K
VGhhbmtzIGZvciBpbXByb3ZpbmcgdGhlIGNvbW1pdCBtZXNzYWdlLiBJdCBsb29rcyBjbGVhcmVy
LiDwn5iKDQpXaWxsIHNlbmQgb3V0IGEgdjIgd2l0aCB0aGlzIGNvbW1pdCBtZXNzYWdlLg0KDQpU
aGFua3MhDQotUWl1eHUNCg0K
