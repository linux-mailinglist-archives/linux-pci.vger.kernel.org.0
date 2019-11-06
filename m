Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2FBF1F47
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKFTvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 14:51:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:7024 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfKFTvr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 14:51:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:51:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="196316242"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2019 11:51:46 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 11:51:46 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.146]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 11:51:46 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: vmd: Reduce VMD vectors using NVMe calculation
Thread-Topic: [PATCH 1/3] PCI: vmd: Reduce VMD vectors using NVMe calculation
Thread-Index: AQHVlMmFA1H8cl+C4UKw+RkNsXxX96d+9TMAgAAekoA=
Date:   Wed, 6 Nov 2019 19:51:46 +0000
Message-ID: <ef9198c8ac174470fb5b2ea32293dc884428e37a.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <1573040408-3831-2-git-send-email-jonathan.derrick@intel.com>
         <20191106180220.GB29853@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191106180220.GB29853@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.131]
Content-Type: text/plain; charset="utf-8"
Content-ID: <59463584FF695142BEE7F6CA79B9C908@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDAzOjAyICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDQ6NDA6MDZBTSAtMDcwMCwgSm9uIERlcnJpY2sgd3Jv
dGU6DQo+ID4gKwltYXhfdmVjdG9ycyA9IG1pbl90KGludCwgdm1kLT5tc2l4X2NvdW50LCBudW1f
cG9zc2libGVfY3B1cygpICsgMSk7DQo+ID4gKwlpZiAobnZlYyA+IG1heF92ZWN0b3JzKQ0KPiA+
ICsJCXJldHVybiBtYXhfdmVjdG9yczsNCj4gDQo+IElmIHZtZCdzIG1zaXggdmVjdG9ycyBiZXlv
bmQgbnVtX3Bvc3NpYmxlX2NwdXMoKSBhcmUgaW5hY2Nlc3NpYmxlLCB3aHkNCj4gbm90IGp1c3Qg
bGltaXQgdm1kJ3MgbXNpeF9jb3VudCB0aGUgc2FtZSB3YXk/DQoNClllcyBJIGNvdWxkIHByb2Jh
Ymx5IGRvIHRoYXQgaW5zdGVhZA0K
