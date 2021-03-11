Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E5336A79
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 04:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCKDNe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 10 Mar 2021 22:13:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:52462 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhCKDNH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 22:13:07 -0500
IronPort-SDR: BhKXoqS3G88QgZR5uwchuOl3v7XdbxSIKqH3YDmB6SaN3SaVKwHR2brx5qtaRtQWirm3wZ/pbG
 THs7rKMCfGlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="187969867"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="187969867"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 19:13:06 -0800
IronPort-SDR: F3pACgYlTs8CBDSVQ5RlGllv1DSyR8uBThdE+p8bxtiapg0xRu79HdIxkWCByfBKEEJx0twRsU
 MsD+jwekRijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="370421299"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2021 19:13:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 19:13:06 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 19:13:05 -0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2106.013;
 Thu, 11 Mar 2021 11:13:02 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     'Bjorn Helgaas' <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Thread-Topic: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Thread-Index: AQHXCLh6LEG1CfkjwEO3CLgkzlZ+yap9WgQAgADHGrA=
Date:   Thu, 11 Mar 2021 03:13:02 +0000
Message-ID: <b76a5239650842f7bd852b6b4dba3288@intel.com>
References: <20210222011717.43266-1-qiuxu.zhuo@intel.com>
 <20210310220030.GA2068330@bjorn-Precision-5520>
In-Reply-To: <20210310220030.GA2068330@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> [...]
> 
> I think 507b460f8144 appeared in v5.11, so not something we broke in v5.12.
> Applied to pci/error for v5.13, thanks!

Thanks Bjorn!

> If I understand correctly, we previously only got this right in one
> case:
> 
>    0 == PCI_SLOT(00.0)    # correct
>    1 == PCI_SLOT(00.1)    # incorrect
>    2 == PCI_SLOT(00.2)    # incorrect
>    ...
>    8 == PCI_SLOT(01.0)    # incorrect
>    9 == PCI_SLOT(01.1)    # incorrect
>    ...
>   31 == PCI_SLOT(03.7)    # incorrect

Yes, you're right. 

Thanks!
-Qiuxu

