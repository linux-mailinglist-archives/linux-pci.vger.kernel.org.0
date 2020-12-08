Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1949A2D236E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 07:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgLHGFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 01:05:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:3070 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgLHGFF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 01:05:05 -0500
IronPort-SDR: U/bLdPpvXhNUxGJevlgs093LQpw5mqFYA/xps+mmJTq91do1DybkmRTFlvC2XobotkjEHNivWd
 MXEldIInH5YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="160886034"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="160886034"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 22:03:19 -0800
IronPort-SDR: LzhTYhB2twy+C+SMYM3uq1XmQFVAJC5YqUD4Fz5BMYP04TFtCwcSngBuD4Zp63BUP6L01Z9YD4
 +kJZe0iE/K8A==
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="317648360"
Received: from unknown (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.92.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 22:03:18 -0800
Subject: Re: [PATCH v12 0/5] Simplify PCIe native ownership
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201126011816.711106-1-helgaas@kernel.org>
 <b1cb1ad6-e047-8c7a-0abe-b9feee844e59@linux.intel.com>
 <98b11c1b-24b2-5e36-7f08-b96fa772ddd2@linux.intel.com>
Message-ID: <f8769d38-1026-90b7-2380-71aea5f21c61@linux.intel.com>
Date:   Mon, 7 Dec 2020 22:03:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98b11c1b-24b2-5e36-7f08-b96fa772ddd2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 11/30/20 5:11 PM, Kuppuswamy, Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 11/25/20 7:48 PM, Kuppuswamy, Sathyanarayanan wrote:
>> Along with above patch, you also left following two cleanup patches. Is this
>> intentional? Following fixes have no dependency on pcie_ports_dpc_native change.
>>
>> [PATCH v11 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
>> [PATCH v11 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
> 
> Any comment? If you want me to add these patches in my re-submission, please
> let me know.
Gentle ping. Any comments?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
