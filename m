Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7A82B7126
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 23:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKQV7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 16:59:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:8194 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgKQV7t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 16:59:49 -0500
IronPort-SDR: Ai55vrLLSXuQll4MqH3LTupFYRyaL4HBp7tbwrqZL4D7jwxD7Ap6BTwvVrCLk7jVhtS9OiRNVJ
 NtgsMeOSU0TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255731034"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255731034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:59:48 -0800
IronPort-SDR: ae4Tc6GzlnDVxo785U7AaSGaAz1iDpuQ1xqDq8Km2lAHEr9i2vPqoBy4t4BMUrdH2y3RE3ft/U
 QWL2bPu5QFxA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544224316"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:59:47 -0800
Subject: Re: [PATCH v11 08/16] PCI/ERR: Use "bridge" for clarity in
 pcie_do_recovery()
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-9-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <eb655100-68c8-d1e9-9370-9a6f8104f41e@linux.intel.com>
Date:   Tue, 17 Nov 2020 13:59:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-9-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> pcie_do_recovery() may be called with "dev" being either a bridge (Root
> Port or Switch Downstream Port) or an Endpoint.  The bulk of the function
> deals with the bridge, so if we start with an Endpoint, we reset "dev" to
> be the bridge leading to it.
> 
> For clarity, replace "dev" in the body of the function with "bridge".  No
> functional change intended.
> 
> [bhelgaas: commit log, split pieces out so this is pure rename, also
> replace "dev" with "bridge" in messages and pci_uevent_ers()]
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pcie/err.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
