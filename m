Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4AE1C2A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391304AbfJWNSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 09:18:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:54688 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJWNSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 09:18:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="209922655"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 06:17:59 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Oct 2019 16:17:58 +0300
Date:   Wed, 23 Oct 2019 16:17:58 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v2 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Message-ID: <20191023131758.GB2819@lahna.fi.intel.com>
References: <SL2P216MB0187E4D0055791957B7E2660806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187E4D0055791957B7E2660806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:12:29PM +0000, Nicholas Johnson wrote:
> Add kernel parameter pci=hpmmiosize=nn[KMG] to set MMIO bridge window
> size for hotplug bridges.
> 
> Add kernel parameter pci=hpmmioprefsize=nn[KMG] to set MMIO_PREF bridge
> window size for hotplug bridges.
> 
> Leave pci=hpmemsize=nn[KMG] unchanged, to prevent disruptions to
> existing users. This sets both MMIO and MMIO_PREF to the same size.
> 
> The two new parameters conform to the style of pci=hpiosize=nn[KMG].
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
