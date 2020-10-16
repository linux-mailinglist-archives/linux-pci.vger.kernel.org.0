Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F004290E3F
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411489AbgJPXnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 19:43:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:23744 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411464AbgJPXnA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 19:43:00 -0400
IronPort-SDR: colKsMvPgSEA7zkbiVsTiJ9kX/IO7b5wLQLFpWB5j6180uIMW/earkE15dPlR6YUlXh5FN97wQ
 XJ653NnvcyoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="228362214"
X-IronPort-AV: E=Sophos;i="5.77,384,1596524400"; 
   d="scan'208";a="228362214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 16:43:35 -0700
IronPort-SDR: 04QrJpbebCZp4aQMWzSV1N/I3Fcp/pY9SeLcJSdayj4Mic0FKIQptGkXgfMFyOWrJzs7aR5SMl
 XNwCOvoOHsNA==
X-IronPort-AV: E=Sophos;i="5.77,384,1596524400"; 
   d="scan'208";a="331316815"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 16:43:34 -0700
Date:   Fri, 16 Oct 2020 16:43:33 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201016234333.GB103781@otc-nc-03>
References: <20200925230138.29011-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925230138.29011-1-ashok.raj@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn


On Fri, Sep 25, 2020 at 04:01:38PM -0700, Ashok Raj wrote:
> When Mechanical Retention Lock (MRL) is present, Linux doesn't process
> those change events.
> 
> The following changes need to be enabled when MRL is present.
> 
> 1. Subscribe to MRL change events in SlotControl.
> 2. When MRL is closed,
>    - If there is no ATTN button, then POWER on the slot.
>    - If there is ATTN button, and an MRL event pending, ignore
>      Presence Detect. Since we want ATTN button to drive the
>      hotplug event.
> 

Did you get a chance to review this? Thought i'll just check with you. 

Seems like there was a lot happening in the error handling and hotplug
side, I thought you might have wanted to wait for the dust to settle :-)

> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |  1 +
>  drivers/pci/hotplug/pciehp_ctrl.c | 69 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/hotplug/pciehp_hpc.c  | 27 ++++++++++++++-
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
