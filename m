Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22358690F37
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 18:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBIR3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 12:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBIR3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 12:29:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92314234;
        Thu,  9 Feb 2023 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675963738; x=1707499738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I1EPFaCtvZAqjpCM/9aHUriU6FK6A8rkdVNgfid4YK0=;
  b=UxJX2WyqQBfnz8NbpEEc0T26bYo/1PZLJaMDC/sSrUhktc2HTS8np1v8
   j3DJ18scc2p3ceAKsjfMYzI5J/b58yNpImYrqTR0pl1DeO3BQA42lgE3d
   rRKguFS23b4pELvAwM+D567JuFpiju3ZVThaKXVm5SkYrrmQdlHpREAP1
   y3vU2bTqNugN9w2qfLGWljEqLJrOPbG9wEXaOqEejq7bFkSfbXh830l5M
   WrbymGJKso/Lifd1ymRsCb3sR6ut1E7YLUUatQ5x5ebTMCPMYXpz7l7us
   xnKqro1HOANsAEIekzP07h+IHnfzkhjKPLcsbsEwG2QRp019pzzE8oPkI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328817328"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328817328"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:28:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756492249"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="756492249"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.163.223]) ([10.213.163.223])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:28:44 -0800
Message-ID: <203df5bd-97c8-d419-4e6d-5b0aea59ea47@intel.com>
Date:   Thu, 9 Feb 2023 10:28:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 01/18] cxl: Export QTG ids from CFMWS to sysfs
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571656940.587790.15913351407119270213.stgit@djiang5-mobl3.local>
 <20230209111529.00007f2c@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230209111529.00007f2c@Huawei.com>
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



On 2/9/23 4:15 AM, Jonathan Cameron wrote:
> On Mon, 06 Feb 2023 13:49:30 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Export the QoS Throttling Group ID from the CXL Fixed Memory Window
>> Structure (CFMWS) under the root decoder sysfs attributes.
>> CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Hi Dave,
> 
> 
> I've no objection to this, but would good to say why this
> might be of use to userspace.  What tooling needs it?

Will do.

> 
> One comment on docs inline. With those two things tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
>> ---
>>   Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
>>   drivers/cxl/acpi.c                      |    3 +++
>>   drivers/cxl/core/port.c                 |   14 ++++++++++++++
>>   drivers/cxl/cxl.h                       |    3 +++
>>   4 files changed, 27 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 8494ef27e8d2..0932c2f6fbf4 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -294,6 +294,13 @@ Description:
>>   		(WO) Write a string in the form 'regionZ' to delete that region,
>>   		provided it is currently idle / not bound to a driver.
>>   
>> +What:		/sys/bus/cxl/devices/decoderX.Y/qtg_id
>> +Date:		Jan, 2023
>> +KernelVersion:	v6.3
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Shows the QoS Throttling Group ID. The QTG ID for a root
>> +		decoder comes from the CFMWS structure of the CEDT.
> 
> Document the -1 value for no ID in here. Hopefully people will write
> their userspace against this document and we want them to know about that
> corner case!

Ok I will add.

> 
>>   
>>   What:		/sys/bus/cxl/devices/regionZ/uuid
>>   Date:		May, 2022
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 13cde44c6086..7a71bb5041c7 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -289,6 +289,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>>   			}
>>   		}
>>   	}
>> +
>> +	cxld->qtg_id = cfmws->qtg_id;
>> +
>>   	rc = cxl_decoder_add(cxld, target_map);
>>   err_xormap:
>>   	if (rc)
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index b631a0520456..fe78daf7e7c8 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -284,6 +284,16 @@ static ssize_t interleave_ways_show(struct device *dev,
>>   
>>   static DEVICE_ATTR_RO(interleave_ways);
>>   
>> +static ssize_t qtg_id_show(struct device *dev,
>> +			   struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>> +
>> +	return sysfs_emit(buf, "%d\n", cxld->qtg_id);
>> +}
>> +
>> +static DEVICE_ATTR_RO(qtg_id);
>> +
>>   static struct attribute *cxl_decoder_base_attrs[] = {
>>   	&dev_attr_start.attr,
>>   	&dev_attr_size.attr,
>> @@ -303,6 +313,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>>   	&dev_attr_cap_type2.attr,
>>   	&dev_attr_cap_type3.attr,
>>   	&dev_attr_target_list.attr,
>> +	&dev_attr_qtg_id.attr,
>>   	SET_CXL_REGION_ATTR(create_pmem_region)
>>   	SET_CXL_REGION_ATTR(delete_region)
>>   	NULL,
>> @@ -1606,6 +1617,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>>   	}
>>   
>>   	atomic_set(&cxlrd->region_id, rc);
>> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>>   	return cxlrd;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
>> @@ -1643,6 +1655,7 @@ struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>>   
>>   	cxld = &cxlsd->cxld;
>>   	cxld->dev.type = &cxl_decoder_switch_type;
>> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>>   	return cxlsd;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
>> @@ -1675,6 +1688,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>>   	}
>>   
>>   	cxld->dev.type = &cxl_decoder_endpoint_type;
>> +	cxld->qtg_id = CXL_QTG_ID_INVALID;
>>   	return cxled;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1b1cf459ac77..f558bbfc0332 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -279,6 +279,7 @@ enum cxl_decoder_type {
>>    */
>>   #define CXL_DECODER_MAX_INTERLEAVE 16
>>   
>> +#define CXL_QTG_ID_INVALID	-1
>>   
>>   /**
>>    * struct cxl_decoder - Common CXL HDM Decoder Attributes
>> @@ -290,6 +291,7 @@ enum cxl_decoder_type {
>>    * @target_type: accelerator vs expander (type2 vs type3) selector
>>    * @region: currently assigned region for this decoder
>>    * @flags: memory type capabilities and locking
>> + * @qtg_id: QoS Throttling Group ID
>>    * @commit: device/decoder-type specific callback to commit settings to hw
>>    * @reset: device/decoder-type specific callback to reset hw settings
>>   */
>> @@ -302,6 +304,7 @@ struct cxl_decoder {
>>   	enum cxl_decoder_type target_type;
>>   	struct cxl_region *region;
>>   	unsigned long flags;
>> +	int qtg_id;
>>   	int (*commit)(struct cxl_decoder *cxld);
>>   	int (*reset)(struct cxl_decoder *cxld);
>>   };
>>
>>
> 
