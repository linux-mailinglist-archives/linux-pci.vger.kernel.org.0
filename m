Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035671786C9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 01:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgCCX7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 18:59:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:48033 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgCCX7q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 18:59:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 15:59:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="287159299"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.24.9.56]) ([10.24.9.56])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2020 15:59:45 -0800
Subject: Re: [PATCH v16 3/9] PCI/ERR: Remove service dependency in
 pcie_do_recovery()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200303170442.GA89997@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0059035b-2339-fa52-667f-7b9bbdd34ee8@linux.intel.com>
Date:   Tue, 3 Mar 2020 15:59:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303170442.GA89997@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/3/2020 9:04 AM, Bjorn Helgaas wrote:
> On Thu, Feb 27, 2020 at 04:59:45PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently we pass PCIe service type parameter to pcie_do_recovery()
>> function which was in-turn used by reset_link() function to identify
>> the underlying pci_port_service_driver and then initiate the driver
>> specific reset_link call. Instead of using this roundabout way, we
>> can just pass the driver specific reset_link callback function when
>> calling pcie_do_recovery() function.
> 
> I love this!  And I think pcie_port_find_service() is now unused.  I
> can add a patch to remove it.
I can submit a patch to remove it in next version.

Along with this, I think we also need to remove reset_link pointer from 
pcie_port_service_driver. Also we need to make relevant changes in 
Documentation/PCI/pcieaer-howto.rst as well.

I will wait for you to review rest of the patches before sending the 
next version. Please let me know if you want me to just fix this and 
send it.

> -- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
