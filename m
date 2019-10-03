Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56DC9E3E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJCMTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 08:19:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:15781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJCMTv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 08:19:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 05:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="205607733"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Oct 2019 05:19:47 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Oct 2019 15:19:46 +0300
Date:   Thu, 3 Oct 2019 15:19:46 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 0/6] Patch series to support Thunderbolt without any
 BIOS support
Message-ID: <20191003121946.GS2819@lahna.fi.intel.com>
References: <SL2P216MB01873757CFAE0E4B02F1BBE080C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01873757CFAE0E4B02F1BBE080C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 12:52:58PM +0000, Nicholas Johnson wrote:
> Patch series rebased to 5.3-rc1.
> 
> If possible, please have a quick read over while I am away (2019-07-27
> to mid 2019-08-04), so I can fix any mistakes or make simple changes to
> get problems out of the way for a more thorough examination later.
> 
> Thanks!
> 
> Kind regards,
> Nicholas
> 
> Nicholas Johnson (6):
>   PCI: Consider alignment of hot-added bridges when distributing
>     available resources
>   PCI: In extend_bridge_window() change available to new_size
>   PCI: Change extend_bridge_window() to set resource size directly
>   PCI: Allow extend_bridge_window() to shrink resource if necessary
>   PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
>   PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
>     window

Hi Bjorn,

What's the status of this series? I don't see them in v5.4-rc1.

Thanks!
