Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2B4978EB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiAXG1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 01:27:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:43034 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241551AbiAXG1R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jan 2022 01:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643005637; x=1674541637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gn34ABxcSee+wgnEIT0hQPLTIw0wZvixz3QrsRcRHEs=;
  b=B4oEodK3Ck8lRt03nWPzBiCPgUYOG4fI0RCDf7j+JhLpiQfu6REiERj5
   sHJs284gFoZawaEYudKvW/iSadpSlXThxVyApGZDswU/J4AwvK7yQ/J2O
   jIBtWHeFrzvp0b0YZGBusN4ILfD4Y6FiSKRCyFboLvcpCTh3l/gft3/Ux
   6fWt5esZfHHvctnDdLeJYahSX1OpjEPzjLnS/6N4vi1FqHVvk8WL7jSoc
   d6d1Pqsft52IqloICaGU3Gt3lOZCPwsZs3vm2Z61Qt1Xg6w/HY7+Gw7mq
   Hr60HMuUIXI3O3Z651o8jD883sfGvUQ8JfmCML5Oi5HYGZcX4VOa1gSdJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225953974"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="225953974"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 22:27:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534089171"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 22:27:12 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Jan 2022 08:27:09 +0200
Date:   Mon, 24 Jan 2022 08:27:09 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <Ye5GvQbFKo+CFtRb@lahna>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121214117.GA1154852@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 03:41:17PM -0600, Bjorn Helgaas wrote:
> [+cc Greg, Jean-Philippe, Mika, Pavel, Oliver, Joerg since they
> commented on previous "external-facing" discussion]
> 
> On Wed, Jan 19, 2022 at 04:04:09PM -0800, Rajat Jain wrote:
> > Today the pci_dev->untrusted is set for any devices sitting downstream
> > an external facing port (determined via "ExternalFacingPort" property).
> > This however, disallows any internal devices to be marked as untrusted.
> 
> This isn't stated quite accurately.  "dev->untrusted" is currently set
> only by set_pcie_untrusted(), when "dev" has an upstream bridge that
> is either external-facing or untrusted.
> 
> But that doesn't disallow or prevent internal devices from being
> marked as untrusted; it just doesn't implement that.
> 
> > There are use-cases though, where a platform would like to treat an
> > internal device as untrusted (perhaps because it runs untrusted
> > firmware, or offers an attack surface by handling untrusted network
> > data etc).
> > 
> > This patch introduces a new "UntrustedDevice" property that can be used
> > by the firmware to mark any device as untrusted.

I think this new property should be documented somewhere too (also
explain when to use it instead of ExternalFacingPort). If not in the
next ACPI spec or some supplemental doc then perhaps in the DT bindings
under Documentation/devicetree/bindings.
