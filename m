Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C629DF6E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgJ1WRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:17:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:58445 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbgJ1WRH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:07 -0400
IronPort-SDR: tTBMoPS/hCNOyFsZL3XBzSXqn956hNj6ObC4YkZVzzVjW45p3LYwVwzz14ahwVf3Tq3CdQxKwJ
 1s9f9dMckjqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="147581619"
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="147581619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:13:51 -0700
IronPort-SDR: rdROUzDEGk2wo3Npe3je3eTrc3dLnV4UgVqN9FX4UpdDVebiBYWc2eO8G/wZ8eHuduCXAY4LF1
 92hA9IyS0fVQ==
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="536311333"
Received: from rramir3-mobl.amr.corp.intel.com (HELO [10.254.71.48]) ([10.254.71.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:13:50 -0700
Subject: Re: [PATCH v11 4/5] PCI/portdrv: Remove redundant pci_aer_available()
 check in DPC enable logic
To:     Ethan Zhao <xerces.zhao@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, knsathya@kernel.org
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2faef6f884aae9ae92e57e7c6a88a6195553c684.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh1J=_nxFTztyEjMBJav_W+JY60gzf27dvantMeKU+Aatg@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ee679e38-dd8a-7d43-8715-a4e454664f89@linux.intel.com>
Date:   Wed, 28 Oct 2020 10:13:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKF3qh1J=_nxFTztyEjMBJav_W+JY60gzf27dvantMeKU+Aatg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/27/20 11:00 PM, Ethan Zhao wrote:
> On Tue, Oct 27, 2020 at 10:00 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> In DPC service enable logic, check for
>> services & PCIE_PORT_SERVICE_AER implies pci_aer_available()
> How about PCIE_PORT_SERVICE_AER is not configured, but
> pcie_aer_disable == 0 ？
Its not possible in current code flow. DPC service is configured
following AER service configuration.
>> is true. So there is no need to explicitly check it again.
>>
>> Also, passing pcie_ports=dpc-native in kernel command line
>> implies DPC needs to be enabled in native mode irrespective
>> of AER ownership status. So checking for pci_aer_available()
>> without checking for pcie_ports status is incorrect.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/portdrv_core.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 2c0278f0fdcc..e257a2ca3595 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -252,7 +252,6 @@ static int get_port_device_capability(struct pci_dev *dev)
>>           * permission to use AER.
>>           */
>>          if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> -           pci_aer_available() &&
>>              (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
>>                  services |= PCIE_PORT_SERVICE_DPC;
>>
>> --
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
