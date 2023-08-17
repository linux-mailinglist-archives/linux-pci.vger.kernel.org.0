Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112B877FAB9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbjHQP2p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353206AbjHQP2b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 11:28:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478419A1;
        Thu, 17 Aug 2023 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692286109; x=1723822109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WAN7gFFX+EQnFjTTs/RO+AHy6uW7VHGPY/LGIkShE8o=;
  b=b09Npq7u8DtA7Z54YUufGh7rr3z1j4alLso486J57tynW+UFHQ0OWS4p
   i72tohSJZWs31pKKdqrqESpQbKSuGjVtWBfgQ9rlQooHbLiuVluWue2F9
   cpPiuYAhoC7X0N/sZOzV6BCOAXHUxNFG/YxO1nFYIADRhqaR3f8c6fQPV
   jtJ1Ml6U9qNbCo93akA6HDHW+u+AJ3XWB+crsRtrv4QsEmwPLFoI4Z2NV
   hJ1FI/fVov7o7teEruLED5Z2qKpuAeQ/twaeRHBJAcV2BYCcWsx0AhqJR
   uOVXfIIPtie3TbS60JzVgbxxamvMBWUSk+0ofTFluWj0xWJkhUVnF8JtI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436760079"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436760079"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981223064"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981223064"
Received: from orparaju-mobl2.amr.corp.intel.com (HELO [10.212.148.199]) ([10.212.148.199])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:28:08 -0700
Message-ID: <78b8e5bc-9147-4c07-acfc-d653cfe2d1a1@linux.intel.com>
Date:   Thu, 17 Aug 2023 08:28:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] ACPI: x86: s2idle: Post-increment variables when
 getting constraints
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
 <20230816204143.66281-4-mario.limonciello@amd.com>
 <404044b2-8e7a-4420-9c10-b2ca75d7e3aa@linux.intel.com>
 <ZN3yE3V8Ni8uJMse@smile.fi.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ZN3yE3V8Ni8uJMse@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/17/2023 3:10 AM, Andy Shevchenko wrote:
> On Wed, Aug 16, 2023 at 07:42:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On 8/16/2023 1:41 PM, Mario Limonciello wrote:
> 
> ...
> 
>> Reviewed-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> It's not the first time your tag gets broken. Can you fix it?
> 

Sorry, changed the system recently and did not re-configure the email
client settings. I hope it is fixed now.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
