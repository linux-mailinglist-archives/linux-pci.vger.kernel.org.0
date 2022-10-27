Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0660EEF2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 06:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiJ0ESA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 00:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ0ER5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 00:17:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C165A0330;
        Wed, 26 Oct 2022 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666844277; x=1698380277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c2WM3jy4H4MuU5+8696owJAO8S+vMks/LJZNj3CcUtI=;
  b=l94wk7x/b5r35T7ZXFhj05SI//9AKy0D4514rjvzy7BVqZkzCFvUHIWT
   Ycu/AgI5/Oy5SckxGpqJrhqXfOLBr8t3EQxOzxxFceYhCEIJBqwcA+k6c
   wlo+lExZGxjb35ObhDEZ9fhfB8x2oPMwxnrhXhMvKW9Ok1ZUkuj8870Fu
   7AtcbueRAKWcEmlzSEH6ej891VqPNdOWSmZY+cocZWtDvx8KS6WycV/Ic
   lvdRFdaCr3oWosWxZf2KTObznjRhCDdsTWZ3zf2ozQW+N7mSnLWVpQAwE
   yGZQz7bhb9HhkDG7MtK1KWw59jLPxKV1e+BBgPgr57kzpFETZJg/A4KNU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="306855089"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="306855089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:17:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="737518965"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="737518965"
Received: from holmeskx-mobl.amr.corp.intel.com (HELO [10.209.105.249]) ([10.209.105.249])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:17:36 -0700
Message-ID: <a0f29483-9557-9900-bcb7-ec832dc5d2d1@linux.intel.com>
Date:   Wed, 26 Oct 2022 21:17:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
Content-Language: en-US
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, robert.moore@intel.com, ying.huang@intel.com,
        rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Cc:     CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
References: <20221027031458.2855599-1-LeoLiu-oc@zhaoxin.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221027031458.2855599-1-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/26/22 8:14 PM, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> HEST PCIE AER error source information describes the Uncorrectable Error 
> Severity, CorrectableError Mask and other aer register's value to write to the

/s/CorrectableError/Correctable Error
/s/aer/AER

> bridge's Correctable Error Mask register.

Can you add spec reference?

> 
> leoliu-oc (5):
>   ACPI/APEI: Add apei_hest_parse_aer()
>   ACPI/APEI: remove static from apei_hest_parse()
>   ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
>   ACPI/PCI: Add pci_acpi_program_hest_aer_params()
>   ACPI/PCI: config pcie devices's aer register
> 
>  drivers/acpi/apei/hest.c      | 121 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci-acpi.c        |  92 ++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   5 ++
>  drivers/pci/probe.c           |   1 +
>  include/acpi/actbl1.h         |  69 +++++++++++++++++++
>  include/acpi/apei.h           |   9 +++
>  include/uapi/linux/pci_regs.h |   5 ++
>  7 files changed, 300 insertions(+), 2 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
