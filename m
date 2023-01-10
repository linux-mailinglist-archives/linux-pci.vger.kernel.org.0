Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB8664D91
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 21:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjAJUin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 15:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjAJUid (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 15:38:33 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A42A4BD5E;
        Tue, 10 Jan 2023 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673383112; x=1704919112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y0yZaBVtQ38aeZIo8Y56O5/1QglVHbW63SlAqR8deB8=;
  b=GA3gTg8bdQDw8A6L3W+N3ozKhnzHz1peYHxvcY4PsuG/JbnveKmuAPvS
   /uuXthTLRUQPzDwruNxZAZXVD9J8jtRkxYguY9+Y2RJsXlAZxha8tNuOz
   Q88s98az+07u5ssY8SiXN1TkM7xavP8fzs4m2irs78dJPEvHRs5f/37qy
   +85lnjcCEYFJt7lUeZyFDgY2MIIyEFDQcnAZUecEDR72773YgL1yrV6y7
   877DWhuQ320FhjhiseVREhPEpLhAYzfJaTnK8VlMDhquo7dtBGfrt0icd
   YjzPThc/4YY+nUFDrwjs4AuBpLIA4ST0oBlxhq0vQuAMqsqnxvpOTkGNY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385560827"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="385560827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 12:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="745915514"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="745915514"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2023 12:38:31 -0800
Received: from [10.252.208.27] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 676F6580377;
        Tue, 10 Jan 2023 12:38:28 -0800 (PST)
Message-ID: <0f25f140-2fad-09ff-f4c8-1231836b86f4@linux.intel.com>
Date:   Tue, 10 Jan 2023 15:38:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] PCI: Fix extended config space regression
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Dan J Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230110180243.1590045-1-helgaas@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-01-10 1:02 p.m., Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") appeared
> in v6.2-rc1 and broke extended config space on several machines.
> 
> This broke drivers that use things in extended config space, e.g., perf,
> VSEC telemetry, EDAC, QAT, etc.
> 
> This happened because mmconfig-shared.c checks to see that ECAM space is
> reserved in E820 or ACPI motherboard resources.  If it's not, it assumes
> ECAM doesn't work.  07eab0901ede removed some E820 entries, so it looked
> like ECAM was no longer reserved, so we stopped using it.
> 
> The machines where this broke don't reserve the ECAM in ACPI PNP0C02
> devices (which seems to be what the PCI Firmware spec requires), but they
> do mention it in the EFI memory map as EfiMemoryMappedIO.
> 
> Bjorn Helgaas (2):
>   x86/pci: Simplify is_mmconf_reserved() messages
>   x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
>

This patch series fixes the issue on my machine.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  arch/x86/pci/mmconfig-shared.c | 44 +++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
