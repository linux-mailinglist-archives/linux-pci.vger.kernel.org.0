Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA168E255
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 21:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBGUz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 15:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGUzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 15:55:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A33FF02;
        Tue,  7 Feb 2023 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675803329; x=1707339329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9LCQzmZTAtaj9CMhaomd7z8lVhJMhmY4Ef5JEkFY/XI=;
  b=HRgAAjrN1NWim8KdP5C+vdaLwLk12Uu97SJtzXunQKKxsHizY0XWYkUp
   crDn7MyH3moiXQLPi4tYkt0rnNG5jr+of3h61Rdc82YOMZRiaJOxtpGLK
   Yv430SVkXX7eV3txodo7LobzvGb7/lXma7xrY/W1bWe1wCfwGQ/0qWmsO
   jZip8hC9d7cFuG/VQQE0DK4+bf375GBozmvBqwWy29pqFr+abpYvV8kRf
   5dcviqAfpc9Y+Tgi/Xhw8TZs8KBqSj3uKC4SAs83qySt4yHTYnQvrnBKU
   gRpj/SkxsgJ2aOJaPyo1isiPdtiZtSIVJHbeKVQ8QEzDDJZ7cp4SrHvzT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309273020"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="309273020"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:55:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="995872374"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="995872374"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:55:28 -0800
Message-ID: <805a5d2f-dd3a-54f0-197b-9bb7b021f52b@intel.com>
Date:   Tue, 7 Feb 2023 13:55:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 16/18] cxl: Move reading of CDAT data from device to after
 media is ready
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571670516.587790.14112456054041985666.stgit@djiang5-mobl3.local>
 <20230206221738.GB21823@wunner.de>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230206221738.GB21823@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/6/23 3:17 PM, Lukas Wunner wrote:
> On Mon, Feb 06, 2023 at 01:51:46PM -0700, Dave Jiang wrote:
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -109,6 +106,8 @@ static int cxl_port_probe(struct device *dev)
>>   			return rc;
>>   		}
>>   
>> +		/* Cache the data early to ensure is_visible() works */
>> +		read_cdat_data(port);
>>   		if (port->cdat.table) {
>>   			rc = cdat_table_parse_dsmas(port->cdat.table,
>>   						    cxl_dsmas_parse_entry,
> 
> Which branch is this patch based on?  I'm not seeing a function
> called cdat_table_parse_dsmas() in cxl/next.

v6.2-rc7. See commit 4/18. That's where it's introduced. I adapted it 
from ACPI entries parsing code.

> 
> cxl_cdat_read_table() could be amended with a switch/case ladder
> which compares entry->type to acpi_cdat_type values and stores
> a pointer to an entry of interest e.g. in port->cdat->dsmas.
> Then you can use that pointer directly to find the dsmas in the
> CDAT and parse it.

Yes, but we may have more than 1 DSMAS right? Plus having to parse the 
DSLBIS entries as well, may be better to just have a common parsing 
routine to deal with all that.
> 
> Note however that cxl_cdat_read_table() is refactored heavily by
> my DOE rework series (will submit v3 later this week):
> 
> https://github.com/l1k/linux/commits/doe
> 
> Thanks,
> 
> Lukas
