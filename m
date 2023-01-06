Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA0660409
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjAFQMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 11:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjAFQM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 11:12:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6C3225F;
        Fri,  6 Jan 2023 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673021546; x=1704557546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiB/HmNLk6RRBwRo9+bpToiRB1wJzr3BowDDu9kV9VA=;
  b=lXUwhQnE51sKCh+846bzd4tNGJrDVKHm04e1q7gEICjPoCYrPMKGDQi4
   IaKrZ2NYP3a888exH3XBV61q2Z0j9PtB3M7RCRAc2mmv28Y3/QNTp07FL
   02twCt6YHyi5dPRqtv3gG4rncz+4USsAKaS9E2IeTyd8iep3QbQnar+ZH
   Tmv5EdudI4vIrHItfuBK8DRz8TRmz2xiJNDvS/HC6sx9BS8aki08tD86N
   kVCs5G3k5v0+PVzSmRAd17tV8YVI7dutMGC0WAHdT1B3tJaEyjQhlWbVh
   AA73mm3URKyK36miRmipSiBr0RLAeN3gMpUb0jfPfbVMUE1fJQpXdnYEk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="408754447"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="408754447"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:12:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="744679234"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="744679234"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.171.41]) ([10.213.171.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:12:25 -0800
Message-ID: <18574003-2c20-6219-20aa-d21869ecb467@intel.com>
Date:   Fri, 6 Jan 2023 09:12:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 09/11] cxl/pci: Add (hopeful) error handling support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org, terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
 <166974413966.1608150.15522782911404473932.stgit@djiang5-desk3.ch.intel.com>
 <20230106160515.000046b8@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230106160515.000046b8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/6/23 9:05 AM, Jonathan Cameron wrote:
> On Tue, 29 Nov 2022 10:48:59 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> Add nominal error handling that tears down CXL.mem in response to error
>> notifications that imply a device reset. Given some CXL.mem may be
>> operating as System RAM, there is a high likelihood that these error
>> events are fatal. However, if the system survives the notification the
>> expectation is that the driver behavior is equivalent to a hot-unplug
>> and re-plug of an endpoint.
>>
>> Note that this does not change the mask values from the default. That
>> awaits CXL _OSC support to determine whether platform firmware is in
>> control of the mask registers.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> I've been messing around with improving the qemu injection to do multiple
> errors and ran into a bug...
> 
> I'll send a patch next week, but in meantime...
> 
> 
>> ---
> 
>> +/*
>> + * Log the state of the RAS status registers and prepare them to log the
>> + * next error status. Return 1 if reset needed.
>> + */
>> +static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> +	struct device *dev = &cxlmd->dev;
>> +	u32 hl[CXL_HEADERLOG_SIZE_U32];
>> +	void __iomem *addr;
>> +	u32 status;
>> +	u32 fe;
>> +
>> +	if (!cxlds->regs.ras)
>> +		return false;
>> +
>> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>> +	status = le32_to_cpu((__force __le32)readl(addr));
>> +	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>> +		return false;
>> +
>> +	/* If multiple errors, log header points to first error from ctrl reg */
>> +	if (hweight32(status) > 1) {
>> +		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
>> +		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
>> +				     CXL_RAS_CAP_CONTROL_FE_MASK);
>> +	} else {
>> +		fe = status;
>> +	}
>> +
>> +	header_log_copy(cxlds, hl);
>> +	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
>> +	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
> 
> This address is meant to be that of the CXL_RAS_UNCORRECTABLE_STATUS register
> but in the event hweight32(status) > 1 it's been ovewritten with the
> address of CXL_RAS_CAP_CONTROL.

Great catch! I'll send out a fix.

> 
> 
>> +
>> +	return true;
>> +}
>> +
