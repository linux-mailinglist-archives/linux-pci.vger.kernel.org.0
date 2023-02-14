Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C3695552
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 01:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBNAYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 19:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBNAYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 19:24:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67C449E;
        Mon, 13 Feb 2023 16:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676334255; x=1707870255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gkhl6ezDlc1ss5YwSYVQ4Gf3h6MQxMz/5wqdYif/WQ0=;
  b=Hpd1fx5w1ob+bE0s/5PTUgRYs4+Dal4sJiSNZ6FSMnzj3sX+DOguvfwK
   Cr/AWZrU/Kf0I5zZKEa79NHRzBAeMHHk5GonJ83NRhZPb7K5jCOlzsMar
   UjK6TJ8qI+O9kHvMKk/rtXnbumHWqE7P+CsFbPbeVcwZTVod5EauecVad
   k7sidhT7DnIVDuLdcD/4MCycncU/i/Zm1cU+LfUo7SgFIE4fr4AGt1t/e
   VlL0PryvIt0NQgMTvTy0o/mHp9fXbTdlS/GBk4O9Pn2Qf/WZ6i9v+MMs0
   RRcUJJ8o8IxCI9fiV8SHBzU5bEpXQGBZ+zvGv7O7o1hNiO2ov3esNnfUk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="311396686"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="311396686"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 16:24:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="646571961"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646571961"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.99.85]) ([10.212.99.85])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 16:24:14 -0800
Message-ID: <db76a0ac-a597-378c-5f6d-8e358af45cba@intel.com>
Date:   Mon, 13 Feb 2023 17:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 07/18] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571662248.587790.4362747686454305108.stgit@djiang5-mobl3.local>
 <20230209135007.0000667d@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230209135007.0000667d@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/23 6:50 AM, Jonathan Cameron wrote:
> On Mon, 06 Feb 2023 13:50:23 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Provide a callback to parse the Device Scoped Latency and Bandwidth
>> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
>> contains the bandwidth and latency information that's tied to a DSMAS
>> handle. The driver will retrieve the read and write latency and
>> bandwidth associated with the DSMAS which is tied to a DPA range.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> A few comments inline,
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/cxl/core/cdat.c |   34 ++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h       |    2 ++
>>   drivers/cxl/port.c      |    9 ++++++++-
>>   include/acpi/actbl1.h   |    5 +++++
>>   4 files changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index f9a64a0f1ee4..3c8f3956487e 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -121,3 +121,37 @@ int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg)
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
>> +
>> +int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg)
>> +{
>> +	struct cxl_port *port = (struct cxl_port *)arg;
>> +	struct dsmas_entry *dent;
>> +	struct acpi_cdat_dslbis *dslbis;
> 
> Perhaps reorder to maintain the pretty upside-down Christmas trees
> (I don't care :)

will fix
> 
>> +	u64 val;
>> +
>> +	if (header->type != ACPI_CDAT_TYPE_DSLBIS)
>> +		return -EINVAL;
> 
> Isn't this guaranteed by the caller?  Seems overkill do it twice
> and I don't think these will ever be called outside of that wrapper that
> loops over the entries. I could be wrong though!
>

ok will remove


>> +
>> +	dslbis = (struct acpi_cdat_dslbis *)((unsigned long)header + sizeof(*header));
> header + 1
> 
>> +	if ((dslbis->flags & ACPI_CEDT_DSLBIS_MEM_MASK) !=
> 
> This field 'must be ignored' if the DSMAS handle isn't a match
> (as it's an initiator only entry) Odd though it may seem I think we
> might see one of those on a type 3 device and we are probably going to
> have other users of this function anyway.
> 
> I think you need to do the walk below to check we have a DSMAS match, before
> running this check.

ok, will move down to where entry is matched

> 
>> +	     ACPI_CEDT_DSLBIS_MEM_MEMORY)
>> +		return 0;
>> +
>> +	if (dslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
>> +		return -ENXIO;
> 
> This would probably imply a new HMAT spec value, so probably just
> log it and ignore rather than error out.

ok

> 
>> +
>> +	/* Value calculation with base_unit, see ACPI Spec 6.5 5.2.28.4 */
>> +	val = dslbis->entry[0] * dslbis->entry_base_unit;
> 
> In theory this might overflow as u64 * u16.
> Doubt it will ever happen in reality, but maybe a check and debug print if it does?

ok will use check_mul_overflow()
> 
>> +
>> +	mutex_lock(&port->cdat.dsmas_lock);
>> +	list_for_each_entry(dent, &port->cdat.dsmas_list, list) {
>> +		if (dslbis->handle == dent->handle) {
>> +			dent->qos[dslbis->data_type] = val;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&port->cdat.dsmas_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1e5e69f08480..849b22236f1d 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -705,6 +705,7 @@ struct dsmas_entry {
>>   	struct list_head list;
>>   	struct range dpa_range;
>>   	u16 handle;
>> +	u64 qos[ACPI_HMAT_WRITE_BANDWIDTH + 1];
>>   };
>>   
>>   typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
>> @@ -716,6 +717,7 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
>>   			    void *arg);
>>   
>>   int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
>> +int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg);
>>   
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong' version
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index b1da73e99bab..8de311208b37 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -65,8 +65,15 @@ static int cxl_port_probe(struct device *dev)
>>   			rc = cdat_table_parse_dsmas(port->cdat.table,
>>   						    cxl_dsmas_parse_entry,
>>   						    (void *)port);
>> -			if (rc < 0)
>> +			if (rc > 0) {
>> +				rc = cdat_table_parse_dslbis(port->cdat.table,
>> +							     cxl_dslbis_parse_entry,
>> +							     (void *)port);
>> +				if (rc <= 0)
>> +					dev_dbg(dev, "Failed to parse DSLBIS: %d\n", rc);
> 
> If we have entries and they won't parse, I think we should be screaming louder.
> dev_warn() would be my preference for this and the one in the previous patch.
> Sure we can carry on, but something on the device is not working as expected.

ok will fix this one and previous.

> 
>> +			} else {
>>   				dev_dbg(dev, "Failed to parse DSMAS: %d\n", rc);
>> +			}
>>   		}
>>   
>>   		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index e8297cefde09..ff6092e45196 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -369,6 +369,11 @@ struct acpi_cdat_dslbis {
>>   	u16 reserved2;
>>   };
>>   
>> +/* Flags for subtable above */
>> +
>> +#define ACPI_CEDT_DSLBIS_MEM_MASK	GENMASK(3, 0)
>> +#define ACPI_CEDT_DSLBIS_MEM_MEMORY	0
>> +
>>   /* Subtable 2: Device Scoped Memory Side Cache Information Structure (DSMSCIS) */
>>   
>>   struct acpi_cdat_dsmscis {
>>
>>
> 
