Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C383696E99
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 21:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBNUgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 15:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBNUgw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 15:36:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B32B2AD;
        Tue, 14 Feb 2023 12:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676407010; x=1707943010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SOL//QdfdM3s9jWC+7EBtWWvXmH7+sm77OJamWGyv5k=;
  b=PGxwAhDt7r8oFQ1FC1KNpanfAF/ruPa0VfyiZFIsKTuiTgxbaTj2c+qb
   b6bfbg6WcXkOlUBNlQgMjK8KngSHvBLcj85vX+zY0eXNWyc4oK0LpyZZ7
   yEk5ttr6ycUyyj5UeSNRpeO1RkMkDXYGh+Yu0UhnmvQc0MYoyLPEnUgOT
   vKnnzjMZq9KqZKOsl+f98bwrU5AUT30FQ3+oQKsagqe4cIJ+ve4KiR+AX
   LXFbCfED3/bGFYWKo6COOEFo7vjTX5mCBCOxhqykIM+eiBCpSKj6h8+OU
   Dw9J5YUXQkIsVzppyNKG1xkOCU0wigvSjVW6cA9JhVaUgIVjvan7qV8cI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="328976623"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="328976623"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 12:36:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="758127518"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="758127518"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 12:36:49 -0800
Message-ID: <7d9321ff-e118-884f-d873-91c141faddfc@intel.com>
Date:   Tue, 14 Feb 2023 13:36:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 04/18] cxl: Add common helpers for cdat parsing
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571659666.587790.1381783105886436293.stgit@djiang5-mobl3.local>
 <20230209115803.00002778@Huawei.com>
 <3c69a080-de0c-3244-cc44-0a187230d203@intel.com>
 <20230211101833.GA12138@wunner.de>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230211101833.GA12138@wunner.de>
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



On 2/11/23 3:18 AM, Lukas Wunner wrote:
> On Thu, Feb 09, 2023 at 03:57:32PM -0700, Dave Jiang wrote:
>> On 2/9/23 4:58 AM, Jonathan Cameron wrote:
>>> On Mon, 06 Feb 2023 13:49:58 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
>>>> Add helper functions to parse the CDAT table and provide a callback to
>>>> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
>>>> parsing. The code is patterned after the ACPI table parsing helpers.
> [...]
>>> Are these all worthwhile given the resulting function name is longer
>>> than accessing it directly.  If aim is to move the details of the
>>> struct cdat_subtable_entry away from being exposed at caller, then
>>> fair enough, but if that is the plan I'd expect to see something about
>>> that in the patch description.
>>>
>>> Feels like some premature abstraction, but I don't feel particularly
>>> strongly about this.
>>
>> I'll drop them. The code was adapted from ACPI table parsing code. But we
>> can simplify for our usages.
> 
> Yes just iterating over the CDAT entries and directly calling the
> appropriate parser function for the entry seems more straightforward.
> 
> 
>>> Random musing follows...
>>> We could add a variable length element to that struct
>>> definition and the magic to associate that with the length parameter
>>> and get range protection if relevant hardening is turned on.
>>>
>>> Structure definition comes (I think) from scripts in acpica so
>>> would need to push such changes into acpica and I'm not sure
>>> they will be keen even though it would be good for the kernel
>>> to have the protections.
> [...]
>> I see what you are saying. But I'm not sure how easily we can do this for
>> the CDAT table due to endieness. Is this what you had in mind?
>>
>> From:
>> struct cdat_entry_header {
>> 	u8 type;
>> 	u8 reserved;
>> 	__le16 length;
>> } __packed;
>>
>> To:
>> struct cdat_entry_header {
>> 	u8 type;
>> 	u8 reserved;
>> 	__le16 length;
>> 	DECLARE_BOUNDED_ARRAY(u8, body, le16_to_cpu(length));
>> } __packed;
> 
> I think this is backwards.  I'd suggest creating a struct for each
> CDAT entry which includes the header.  The kernel switched to
> -std=gnu11 a while ago, so you should be able to use an unnamed field
> for the header:
> 
> struct cdat_dsmas {
> 	struct cdat_entry_header;
> 	u8 dsmad_handle;
> 	u8 flags;
> 	u8 reserved[2];
> 	__le64 dpa_base;
> 	__le64 dpa_length;
> }

In file included from drivers/cxl/pci.c:14:
drivers/cxl/cxlpci.h:109:33: warning: declaration does not declare anything
   109 |         struct cdat_entry_header;
       |                                 ^

Does not seem to be happy about the unamed field.


> 
> Note that in my commit "cxl/pci: Handle truncated CDAT entries",
> I'm only verifying that the number of bytes received via DOE
> matches the length field in the cdat_entry_header.  I do not
> verify in cxl_cdat_read_table() whether that length is correct
> for the specific CDAT structure.  I think that's the job of
> the function parsing that particular structure type.
> 
> In other words, at the top of your DSMAS parsing function,
> you need to check:
> 
> 	struct cdat_dsmas dsmas;
> 
> 	if (dsmas->length != sizeof(*dsmas)) {
> 		dev_err(...);
> 		return -EINVAL;
> 	}
> 
> 
> Note how the check is simplified by the header being part of
> struct cdat_dsmas.  If the header wasn't part of struct cdat_dsmas,
> an addition would be needed here.
> 
> Thanks,
> 
> Lukas
