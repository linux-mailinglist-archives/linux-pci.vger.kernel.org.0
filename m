Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354722B6F89
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 21:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgKQUE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 15:04:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:45863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgKQUE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 15:04:26 -0500
IronPort-SDR: QCVKiSIsYMpDw/g6KayBlWwxUGoL2y2XcORnq378V3bSf4Uvltip696kUEt6NFmglZPb9+OMeA
 BEmbEcdqG59g==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158774857"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158774857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:04:21 -0800
IronPort-SDR: eoV4n4Q664zgr0m30tzsETZlN1h4pMhlGMovlxmsFIYu4NFnYMb4BnVapRfvfVqsLg6Qc+I/Ue
 DaMXhJ76ac0Q==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544190637"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:04:21 -0800
Subject: Re: [PATCH v11 01/16] AER: aer_root_reset() non-native handling
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-2-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4c652293-7f5d-7c80-0c20-3677ec651446@linux.intel.com>
Date:   Tue, 17 Nov 2020 12:04:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-2-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> If an OS has not been granted AER control via _OSC, then
> the OS should not make changes to PCI_ERR_ROOT_COMMAND and
> PCI_ERR_ROOT_STATUS related registers. Per section 4.5.1 of
> the System Firmware Intermediary (SFI) _OSC and DPC Updates
> ECN [1], this bit also covers these aspects of the PCI
> Express Advanced Error Reporting. Based on the above and
> earlier discussion [2], make the following changes:
> 
> Add a check for the native case (i.e., AER control via _OSC)
> 
> Note that the current "clear, reset, enable" order suggests that the
> reset might cause errors that we should ignore. Lacking historical
> context, these will be retained.
> 
> [1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
>      2020, affecting PCI Firmware Specification, Rev. 3.2
>      https://members.pcisig.com/wg/PCI-SIG/document/14076
> [2] https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precision-5520/

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
