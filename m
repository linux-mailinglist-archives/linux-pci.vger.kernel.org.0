Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3727C320EE1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBVBEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 20:04:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:51655 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBVBEx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Feb 2021 20:04:53 -0500
IronPort-SDR: U28LiCK9r5n2Of1yAVqBJySucHUs9WeHxw0vHod8yM1qFXNXxG3sjAZ+xYVrsDI+kfIQ3h2A9m
 Kcd4zcODwsDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="269233478"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="269233478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 17:04:12 -0800
IronPort-SDR: udvRjf8c642SH3LiL5Dn2d3FnIg352e7OoiqSAQuxXbE4QwkUn0onbAHgRcSvZ5binxFIvkK1I
 eMJFdn/0XkTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="402313932"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2021 17:04:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Feb 2021 17:04:11 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Feb 2021 17:04:10 -0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2106.002;
 Mon, 22 Feb 2021 09:04:08 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     =?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Thread-Topic: [PATCH v2 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Thread-Index: AQHXBmZlagcS3VhAq0mqYPHwwg7Guapi2DoAgACHA7A=
Date:   Mon, 22 Feb 2021 01:04:07 +0000
Message-ID: <4a0bf3a852ed47deb072890319fb39ec@intel.com>
References: <57a7bbc1ba294ce39c309e519fe45842@intel.com>
 <20210219022359.435-1-qiuxu.zhuo@intel.com> <YDMBRFWTYKTrDyBI@rocinante>
In-Reply-To: <YDMBRFWTYKTrDyBI@rocinante>
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

PiAuLi4NCj4gPiBbIEtyenlzenRvZjogVXBkYXRlIGNvbW1pdCBtZXNzYWdlLiBdDQo+IFsuLi5d
DQo+IA0KPiBUaGFuayB5b3UhICBJIGFwcHJlY2lhdGUgdGhhdC4gIEhvd2V2ZXIsIHdlIHByb2Jh
Ymx5IHNob3VsZCBkcm9wIHRoaXMgZnJvbSB0aGUNCj4gY29tbWl0IG1lc3NhZ2UuICBQZXJoYXBz
IGVpdGhlciBCam9ybiBvciBMb3JlbnpvIGNvdWxkIGRvIGl0IHdoZW4gYXBwbHlpbmcNCj4gY2hh
bmdlcy4NCg0KT0ssIHdpbGwgc2VuZCBvdXQgdGhlIHYzIHRoYXQgZHJvcHMgIlsgS3J6eXN6dG9m
OiBVcGRhdGUgY29tbWl0IG1lc3NhZ2UuIF0iIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQot
UWl1eHUNCg==
