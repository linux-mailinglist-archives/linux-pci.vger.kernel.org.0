Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE54F1C3FB0
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgEDQU0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 4 May 2020 12:20:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:44918 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgEDQUZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 12:20:25 -0400
IronPort-SDR: 37Uu7hT3BZM/48A4Cu3zmTHZGu51G3S46+c47gah7BsJIrGsA2/lS3sFKWs+duS1wu38b5pXYd
 n4l29LbsxGxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 09:20:24 -0700
IronPort-SDR: KSyj6izJhiAmX9pdCsINbtWFR4XQfJ5oodzIYF/USrdXme6l9d2XWS4+WyMzuxOb7Xx4iEYyfL
 +709Lu3W7gpQ==
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="369138245"
Received: from slindhur-mobl1.amr.corp.intel.com (HELO [10.212.9.95]) ([10.212.9.95])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 09:20:24 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        "Sean V Kelley" <sean.v.kelley@linux.intel.com>
Subject: Re: [PATCH v6 0/2] pciutils: Add basic decode support for CXL DVSEC
Date:   Mon, 04 May 2020 09:20:21 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <47C51040-497A-4D1F-97F1-B6C87830F7C9@linux.intel.com>
In-Reply-To: <20200420221444.2641935-1-sean.v.kelley@linux.intel.com>
References: <20200420221444.2641935-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20 Apr 2020, at 15:14, Sean V Kelley wrote:

> Changes since v5 [1]:
>
> - There can be multiple vendor specific DVSEC IDs associated with CXL.
> (Bjorn Helgaas)
>
> [1] 
> https://lore.kernel.org/linux-pci/20200415004751.2103963-1-sean.v.kelley@linux.intel.com/
>
> This patch series adds support for basic lspci decode of Compute 
> eXpress Link[2],
> a new CPU interconnect building upon PCIe. As a foundation for the CXL
> support it adds separate Designated Vendor-Specific Capability (DVSEC) 
> defines
> and a cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms 
> and
> provide available details. It makes use of the DVSEC Vendor ID and 
> DVSEC ID so as
> to identify a CXL capable device.
>
> [2] https://www.computeexpresslink.org/

Just a light ping on these patches.

Thanks!

Sean

>
> Sean V Kelley (2):
>   pciutils: Decode available DVSEC details
>   pciutils: Decode Compute eXpress Link DVSEC
>
>  lib/header.h        |  24 ++++
>  ls-ecaps.c          |  79 +++++++++-
>  tests/cap-dvsec     | 340 
> ++++++++++++++++++++++++++++++++++++++++++++
>  tests/cap-dvsec-cxl | 340 
> ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 782 insertions(+), 1 deletion(-)
>  create mode 100644 tests/cap-dvsec
>  create mode 100644 tests/cap-dvsec-cxl
>
> --
> 2.26.0
