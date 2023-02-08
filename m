Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC73468FBB4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 00:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjBHX4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 18:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBHX4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 18:56:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC9AD04;
        Wed,  8 Feb 2023 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675900610; x=1707436610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnGUYCr3M9sF+8URLsJxqT1dSYWEzz25FP3QSMK+Jbw=;
  b=Y2olRsAqS1Qx3wk1ax7rKdpMP3vrziXB2VD+Bl4gfsdvvEoJ1yqZhY1b
   /hQaTid474CaqABYfRmQUCyNrzGRA7XVHQbkk3aTHo0bHya6vqElA64Hf
   YtvjeeY2xkv0pLwO8oOsGNqsY3e7GG02hO5/jQazXGZcEa7LELWE99Y+U
   MuQM1mZPz/9aeuvMA7GFWta6HNBjNcuCA66EQbw8FIMSFs8YEvcgvU8Wa
   rX9HliibdOMBIVOxxsTm5XekBySnDJ7/36ZnGknaoos38777lz++Xq6jn
   mks+LObIvaKqYOhLLXtgKsib6Sy9d9nkh0fN11TXnZQVfLckHIoiw8gEr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331249979"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331249979"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 15:56:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="736096462"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="736096462"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.48.215]) ([10.212.48.215])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 15:56:31 -0800
Message-ID: <158ba672-09f1-a202-4fb6-7168496b95c4@intel.com>
Date:   Wed, 8 Feb 2023 16:56:30 -0700
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
References: <20230208221559.GA2489627@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230208221559.GA2489627@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/8/23 3:15 PM, Bjorn Helgaas wrote:
> On Tue, Feb 07, 2023 at 01:51:17PM -0700, Dave Jiang wrote:
>>
>>
>> On 2/6/23 3:39 PM, Bjorn Helgaas wrote:
>>> On Mon, Feb 06, 2023 at 01:51:10PM -0700, Dave Jiang wrote:
>>>> The latency is calculated by dividing the FLIT size over the
>>>> bandwidth. Add support to retrieve the FLIT size for the CXL
>>>> device and calculate the latency of the downstream link.
> 
>>> I guess you only care about the latency of a single link, not the
>>> entire path?
>>
>> I am adding each of the link individually together in the next
>> patch. Are you suggesting a similar function like
>> pcie_bandwidth_available() but for latency for the entire path?
> 
> Only a clarifying question.
> 
>>>> +static int cxl_get_flit_size(struct pci_dev *pdev)
>>>> +{
>>>> +	if (cxl_pci_flit_256(pdev))
>>>> +		return 256;
>>>> +
>>>> +	return 66;
>>>
>>> I don't know about the 66-byte flit format, maybe this part is
>>> CXL-specific?
>>
>> 68-byte flit format. Looks like this is a typo from me.
> 
> This part must be CXL-specific, since I don't think PCIe mentions
> 68-byte flits.
> 
>>>> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
>>>> + * mode, otherwise it's 68B flits mode.
>>>> + */
>>>> +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>>> +{
>>>> +	u32 lnksta2;
>>>> +
>>>> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
>>>> +	return lnksta2 & BIT(10);
>>>
>>> Add a #define for the bit.
>>
>> ok will add.
>>
>>>
>>> AFAICT, the PCIe spec defines this bit, and it only indicates the link
>>> is or will be operating in Flit Mode; it doesn't actually say anything
>>> about how large the flits are.  I suppose that's because PCIe only
>>> talks about 256B flits, not 66B ones?
>>
>> Looking at CXL v1.0 rev3.0 6.2.3 "256B Flit Mode", table 6-4, it shows that
>> when PCIe Flit Mode is set, then CXL is in 256B flits mode, otherwise, it is
>> 68B flits. So an assumption is made here regarding the flit side based on
>> the table.
> 
> So reading PCI_EXP_LNKSTA2 and extracting the Flit Mode bit is
> PCIe-generic, but the interpretation of "PCIe Flit Mode not enabled
> means 68-byte flits" is CXL-specific?
> 
> This sounds wrong, but I don't know quite how.  How would the PCI core
> manage links where Flit Mode being cleared really means Flit Mode is
> *enabled* but with a different size?  Seems like something could go
> wrong there.

Looking at the PCIe base spec and the CXL spec, that seemed to be the 
only way that implies the flit size for a CXL device as far as I can 
tell. I've yet to find a good way to make that determination. Dan?


> 
> Bjorn
