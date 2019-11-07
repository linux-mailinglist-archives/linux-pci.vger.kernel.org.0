Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41271F3133
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 15:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfKGOT0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 09:19:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:5909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbfKGOT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 09:19:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 06:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="213031550"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2019 06:19:23 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Nov 2019 16:19:22 +0200
Date:   Thu, 7 Nov 2019 16:19:22 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v9 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20191107141922.GQ2552@lahna.fi.intel.com>
References: <SL2P216MB01875C65EE9820B6A69D208580610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01875C65EE9820B6A69D208580610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 03:28:21PM +0000, Nicholas Johnson wrote:
> Rewrite pci_bus_distribute_available_resources to better handle bridges
> with different resource alignment requirements. Pass more details
> arguments recursively to track the resource start and end addresses
> relative to the initial hotplug bridge. This is especially useful for
> Thunderbolt with native PCI enumeration, enabling external graphics
> cards and other devices with bridge alignment higher than 1MB.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> 
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
