Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9113D7D1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 11:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgAPKVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 05:21:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:61301 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgAPKVW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 05:21:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 02:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="257773923"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 Jan 2020 02:21:19 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jan 2020 12:21:18 +0200
Date:   Thu, 16 Jan 2020 12:21:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Message-ID: <20200116102118.GX2838@lahna.fi.intel.com>
References: <PSXP216MB0438679CD51C0B198CDA231480370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438679CD51C0B198CDA231480370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:57:47PM +0000, Nicholas Johnson wrote:
> Change extend_bridge_window() to set resource size directly instead of
> using additional resource lists.
> 
> This is required in preparation for the next patch [0] which will allow
> the resource to shrink. If we do not make this change, the next patch
> will need to have complicated logic to handle shrinking the overall size
> using size and add_size.
> 
> Remove the resource from add_list, as a zero-sized additional resource
> is redundant.
> 
> Update comment in pci_bus_distribute_available_resources() to reflect
> the above changes.
> 
> [0]
> PCI: Allow extend_bridge_window() to shrink resource if necessary
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
