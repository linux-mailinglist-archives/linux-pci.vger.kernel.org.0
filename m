Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C80243FC1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMUYC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 16:24:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:26014 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMUYC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Aug 2020 16:24:02 -0400
IronPort-SDR: iXzQd7p/97F/IJDusMOlEVIHEWZ7EHKOeEdOPKjzRf0Z4wjrjhCudFky6vIw637ZhEMBUW6/Za
 IuYp7Fg4wtVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="215844533"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="215844533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 13:24:01 -0700
IronPort-SDR: vwrqQNKuxqzw1JS9GWvdctSYlnWuuL7m7YroTi9yuuPLgPK97ge6CdGZwxuo7QyT1Nu+nZs2BI
 F//qXAuzayjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="318649415"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.212.185.171]) ([10.212.185.171])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2020 13:24:00 -0700
Subject: Re: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is not
 enabled
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, jsbarnes@google.com
Cc:     Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <810f1b0e-0adf-c316-f23c-172338f9ef0a@linux.intel.com>
Date:   Thu, 13 Aug 2020 13:23:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/13/2020 12:58 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build error when CONFIG_ACPI is not set/enabled by adding
> the header file <asm/acpi.h> which contains a stub for the function
> in the build error.
> 
> ../arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
> ../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
>    acpi_noirq_set();
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> ---
> Found in linux-next, but applies to/exists in mainline also.
> 
> Alternative.1: X86_INTEL_MID depends on ACPI
> Alternative.2: drop X86_INTEL_MID support

at this point I'd suggest Alternative 2; the products that needed that (past tense, that technology
is no longer need for any newer products) never shipped in any form where a 4.x or 5.x kernel could
work, and they are also all locked down...

