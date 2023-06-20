Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0474E736E67
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjFTOL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjFTOL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 10:11:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4AE72;
        Tue, 20 Jun 2023 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687270314; x=1718806314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1L0EtD4x6UtEsw0OVqTd1tIuAoRanKqllhmqxwyA4PA=;
  b=A6ZdD9yNq8ncEo6o4E6TanYsaRZRr6VOs3lAAD1mO3WI+7vdLKDnMj3j
   FAlMdJitsmz4YNYNPU1VIOHCNl7RuzOezkPPosmpa+aoKCpbyHJ7dJU17
   lZsmTaLyFytyvxL8b3I4F8k0a8AkWYhqj7IKsVsUGpukdSt6G9td7ZsYO
   YsvOmd3wia1MopEQGDQuUZzWiDnyOVFyEiy58VhiajYECFeNE8wMK+VsG
   KIdqGdZCDe4dAHuvpTa9JC7qvfzqAlCQgTF7xppvVQOLLtpG0tmf52QIP
   rZXdBiUZT5/LEWHAMWHK6ru7fKVrCmx5NMyje55PT37ARFIQnrW+GZalN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340210854"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="340210854"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 07:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888248886"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="888248886"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 07:11:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBc5D-005H2d-0N;
        Tue, 20 Jun 2023 17:11:47 +0300
Date:   Tue, 20 Jun 2023 17:11:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>
Subject: Re: [PATCH v3 00/10] PCI: Improve PCIe Capability RMW concurrency
 control
Message-ID: <ZJGzov7J2rJRLmgC@smile.fi.intel.com>
References: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Cc: Jonas

Jonas, might be interesting material in scope of Marvell WiFi PM flow.
Also shows that some WiFi chips disable ASPM which might be good to
have on Marvell as well.

On Tue, Jun 20, 2023 at 04:46:14PM +0300, Ilpo Järvinen wrote:
> PCI Express Capability RMW accessors don't properly protect against
> concurrent access. Link Control Register is written by a number of
> things in the kernel in a RMW fashion without any concurrency control.
> This could in the unlucky case lead to losing one of the updates. One
> of the most obvious path which can race with most of the other LNKCTL
> RMW operations seems to be ASPM policy sysfs write which triggers
> LNKCTL update. Similarly, Root Control Register can be concurrently
> accessed by AER and PME.
> 
> Make pcie_capability_clear_and_set_word() (and other RMW accessors that
> call it) to use a per device spinlock to protect the RMW operations to
> the Capability Registers that require locking. Convert open-coded
> LNKCTL RMW operations to use pcie_capability_clear_and_set_word() to
> benefit from the locking.
> 
> There's also a related series which improves ASPM service driver and
> device driver coordination by removing out-of-band ASPM state
> management from device drivers (which will remove some of the code
> fragments changed by this series but it has higher regression
> potential which is why it seems prudent to do these changes in two
> steps):
>   https://lore.kernel.org/linux-pci/20230602114751.19671-1-ilpo.jarvinen@linux.intel.com/T/#t

-- 
With Best Regards,
Andy Shevchenko


