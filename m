Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B37E1695
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403879AbfJWJrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 05:47:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:53366 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403892AbfJWJrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 02:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="209891035"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 02:47:44 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Oct 2019 12:47:43 +0300
Date:   Wed, 23 Oct 2019 12:47:43 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Message-ID: <20191023094743.GU2819@lahna.fi.intel.com>
References: <PSXP216MB01833367A1A154AEB816AE4E806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB01833367A1A154AEB816AE4E806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 08:37:48AM +0000, Nicholas Johnson wrote:
>  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> -				pci_hotplug_mem_size = memparse(str + 10, &str);
> +				pci_hotplug_mmio_size =
> +					memparse(str + 10, &str);
> +				pci_hotplug_mmio_pref_size =
> +					memparse(str + 10, &str);

Does this actually work correctly? The first memparse(str + 10, &str)
modifies str so the next call will not start from the correct position
anymore.

Otherwise the patch looks good to me.
