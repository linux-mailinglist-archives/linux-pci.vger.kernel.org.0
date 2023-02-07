Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14868E228
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 21:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBGUvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 15:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBGUvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 15:51:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5D3E09B;
        Tue,  7 Feb 2023 12:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675803078; x=1707339078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ToyNyrwixtOUDg+eEMoqUNCxsjNhmyVleCWCGzItYuE=;
  b=bCpirNkOMfvauRRHwGt3h+f9RRE9Y4baCGmIi1d65SaUqPyHNkEJn7cT
   b/StdWnYd+qw6wZo+nC7coePPKEb8tVG1RtWMNX9s7G+vEPXaxvWDJU7x
   vYVjnxsvOPj7dRDrCFY5tSHcaSZB9sqYxlv+eCvCpj+6pAbjeDfd1gA/v
   uJESwCV+gQaw+uZS2TXYG0SIKG2I4uej/b/zgbZd09LPhStLcQK2Yrq2q
   WV/Qe6+i5g7vIuJBhzaJseuQPXZlWY4GCsZ4n+BUMgD7tcpVZuYwby1fM
   8ECZJkimbv/gZg6Z5Se23Z5xtZDEb1jqYVAitPzxRYbzLfcRqKCDpYT2B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415846707"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="415846707"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:51:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912470733"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="912470733"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:51:17 -0800
Message-ID: <19f777db-fdc4-3f6e-ced5-d7bc43f6a340@intel.com>
Date:   Tue, 7 Feb 2023 13:51:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 12/18] cxl: Add helpers to calculate pci latency for the
 CXL device
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <20230206223957.GA2248946@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230206223957.GA2248946@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/6/23 3:39 PM, Bjorn Helgaas wrote:
> On Mon, Feb 06, 2023 at 01:51:10PM -0700, Dave Jiang wrote:
>> The latency is calculated by dividing the FLIT size over the bandwidth. Add
>> support to retrieve the FLIT size for the CXL device and calculate the
>> latency of the downstream link.
> 
> s/FLIT/flit/ to match spec usage.

ok will fix.

> 
> Most of this looks like PCIe, not necessarily CXL-specific.
> 
> I guess you only care about the latency of a single link, not the
> entire path?

I am adding each of the link individually together in the next patch. 
Are you suggesting a similar function like pcie_bandwidth_available() 
but for latency for the entire path?
> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/pci.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h   |   14 ++++++++++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a24dac36bedd..54ac6f8825ff 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -633,3 +633,70 @@ void read_cdat_data(struct cxl_port *port)
>>   	}
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>> +
>> +static int pcie_speed_to_mbps(enum pci_bus_speed speed)
>> +{
>> +	switch (speed) {
>> +	case PCIE_SPEED_2_5GT:
>> +		return 2500;
>> +	case PCIE_SPEED_5_0GT:
>> +		return 5000;
>> +	case PCIE_SPEED_8_0GT:
>> +		return 8000;
>> +	case PCIE_SPEED_16_0GT:
>> +		return 16000;
>> +	case PCIE_SPEED_32_0GT:
>> +		return 32000;
>> +	case PCIE_SPEED_64_0GT:
>> +		return 64000;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
>> +{
>> +	int mbits;
>> +
>> +	mbits = pcie_speed_to_mbps(pcie_get_speed(pdev));
>> +	if (mbits < 0)
>> +		return mbits;
>> +
>> +	return mbits >> 3;
>> +}
>> +
>> +static int cxl_get_flit_size(struct pci_dev *pdev)
>> +{
>> +	if (cxl_pci_flit_256(pdev))
>> +		return 256;
>> +
>> +	return 66;
> 
> I don't know about the 66-byte flit format, maybe this part is
> CXL-specific?

68-byte flit format. Looks like this is a typo from me.

> 
>> + * cxl_pci_get_latency - calculate the link latency for the PCIe link
>> + * @pdev - PCI device
>> + *
>> + * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
>> + * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
>> + * LinkProgationLatency is negligible, so 0 will be used
>> + * RetimerLatency is assumed to be neglibible and 0 will be used
> 
> s/neglibible/negligible/

thank you will fix.
> 
>> + * FlitLatency = FlitSize / LinkBandwidth
>> + * FlitSize is defined by spec. CXL v3.0 4.2.1.
>> + * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
>> + * The FlitLatency is converted to pico-seconds.
> 
> I guess this means cxl_pci_get_latency() actually *returns* a value in
> picoseconds?

yes

> 
> There are a couple instances of this written as "pico-seconds", but
> most are "picoseconds".

ok will fix.

> 
>> +long cxl_pci_get_latency(struct pci_dev *pdev)
>> +{
>> +	long bw, flit_size;
>> +
>> +	bw = cxl_pci_mbits_to_mbytes(pdev);
>> +	if (bw < 0)
>> +		return bw;
>> +
>> +	flit_size = cxl_get_flit_size(pdev);
>> +	return flit_size * 1000000L / bw;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 920909791bb9..d64a3e0458ab 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -62,8 +62,22 @@ enum cxl_regloc_type {
>>   	CXL_REGLOC_RBI_TYPES
>>   };
>>   
>> +/*
>> + * CXL v3.0 6.2.3 Table 6-4
> 
> The copy I have refers to *Revision 3.0, Version 1.0*, i.e.,
> "Revision" is the major level and "Version" is the minor.  So I would
> cite this as "CXL r3.0", not "CXL v3.0".  I suppose the same for CXL
> Memory Device above, but I don't have that spec.

Ok will fix.

> 
>> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
>> + * mode, otherwise it's 68B flits mode.
>> + */
>> +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>> +{
>> +	u32 lnksta2;
>> +
>> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
>> +	return lnksta2 & BIT(10);
> 
> Add a #define for the bit.

ok will add.

> 
> AFAICT, the PCIe spec defines this bit, and it only indicates the link
> is or will be operating in Flit Mode; it doesn't actually say anything
> about how large the flits are.  I suppose that's because PCIe only
> talks about 256B flits, not 66B ones?

Looking at CXL v1.0 rev3.0 6.2.3 "256B Flit Mode", table 6-4, it shows 
that when PCIe Flit Mode is set, then CXL is in 256B flits mode, 
otherwise, it is 68B flits. So an assumption is made here regarding the 
flit side based on the table.

> 
> Bjorn
