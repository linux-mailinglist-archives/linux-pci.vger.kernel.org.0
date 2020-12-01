Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226B2C9472
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 02:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgLABMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 20:12:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:19574 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgLABMz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 20:12:55 -0500
IronPort-SDR: nbgnG3xw+IqmRE92hrDRv506MpJAX46mPrjIGoraSRkm2lArEso7q0P4ppG9d18giCFXOY+vNP
 mrRfGLP+u/Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="169242049"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="169242049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 17:11:15 -0800
IronPort-SDR: 6+7csCN7SAYZCPjAZG/cDXYFsMpUXKQJzynedZ7Dn3Yl0ovHST7/FYgwkKM/yPbbiVFjPpJk6f
 ivT7wz+xJw0w==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="364475610"
Received: from rvalimx-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.91.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 17:11:11 -0800
Subject: Re: [PATCH v12 0/5] Simplify PCIe native ownership
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201126011816.711106-1-helgaas@kernel.org>
 <b1cb1ad6-e047-8c7a-0abe-b9feee844e59@linux.intel.com>
Message-ID: <98b11c1b-24b2-5e36-7f08-b96fa772ddd2@linux.intel.com>
Date:   Mon, 30 Nov 2020 17:11:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b1cb1ad6-e047-8c7a-0abe-b9feee844e59@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 11/25/20 7:48 PM, Kuppuswamy, Sathyanarayanan wrote:
> Along with above patch, you also left following two cleanup patches. Is this
> intentional? Following fixes have no dependency on pcie_ports_dpc_native change.
> 
> [PATCH v11 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
> [PATCH v11 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver

Any comment? If you want me to add these patches in my re-submission, please
let me know.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
