Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2D31F3B5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 02:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBSBxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 20:53:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:41825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhBSBxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 20:53:10 -0500
IronPort-SDR: /4rcr095hnP4ag+JxC2+DxIHHyrCxqc2DXLSJwz2qLRG3H5/4tfpgLGYQn31ViSLWagr2xNpfi
 f53MoLWlky5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="202975690"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="202975690"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 17:52:29 -0800
IronPort-SDR: R3T2gbK7ggMFNSKElvyfp0fP31wM0R3CD9B4c8X5eawnjirPxlMaZPh9OFI90riO3iTxZxLHBO
 TwpD+dGOh6eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="378637916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 18 Feb 2021 17:52:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 17:52:28 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 17:52:27 -0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2106.002;
 Fri, 19 Feb 2021 09:52:24 +0800
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
Thread-Index: AQHW/1FxyeRWMorsOUa/1MhtBDu8kapRGxsAgAwb9fCAAMkFgIAAATQAgADDjjA=
Date:   Fri, 19 Feb 2021 01:52:24 +0000
Message-ID: <57a7bbc1ba294ce39c309e519fe45842@intel.com>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
 <YCQT90mK1kacZ7ZA@rocinante> <a5b1aa8ef91a4c71982ad77234932349@intel.com>
 <YC7lE2Ph/MHxNKs+@rocinante> <YC7mFsfTlVsW9Uo1@rocinante>
In-Reply-To: <YC7mFsfTlVsW9Uo1@rocinante>
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

Pi4uLg0KPiANCj4gV2UgY291bGQgcHJvYmFibHkgYWRkIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAg
IEZpeGVzOiA1MDdiNDYwZjgxNDQgKCJQQ0kvRVJSOiBBZGQgcGNpZV9saW5rX3JjZWMoKSB0byBh
c3NvY2lhdGUgUkNpRVBzIikNCj4gDQoNCk9LLiBXaWxsIGFkZCB0aGlzIHRvIHRoZSB2Mi4NCg0K
VGhhbmtzIQ0KLVFpdXh1DQo=
