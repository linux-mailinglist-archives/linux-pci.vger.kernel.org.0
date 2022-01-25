Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0A49B282
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 12:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380086AbiAYLBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 06:01:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:30554 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379968AbiAYK7D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jan 2022 05:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643108343; x=1674644343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SYDGkXed9Zpe3q3nrJrWXDYeh3RYZIJ5yQozPlmXdts=;
  b=CkFQR20liFfzU4JzRkZyKtkEhEUsxhe2zgIayeii8uQaa7/5IuIYYHw/
   JTTud31uXukQQrLThCWfPAeI/nJAJXcuLNR0MfhKmbeBk9emoaVc4byGw
   uBuog6/VgMax43fJjzWlFtaBwcdjSiuGEKHgLDQlkkG4fhalIpfGZq8Hh
   rZUktTwC79zI+ej7GegxYFsP7Frp+S+RNwspMJfc/oXeB/8XnilXEW73n
   Ta9AWkOlmJgNJwRi/0O7NvnUVZQEtpDHC84O79BOkbe3F9gWpbLTulyjo
   exttbBIIJ+/HOzWqV2B50UfhGKeo7F8/2xY7SEFp2RhNr/rJVt5MbT6dc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226947058"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="226947058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 02:59:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="562997636"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 02:58:55 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jan 2022 12:58:52 +0200
Date:   Tue, 25 Jan 2022 12:58:52 +0200
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
Message-ID: <Ye/X7E2dKb+zem34@lahna>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye5GvQbFKo+CFtRb@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > This patch introduces a new "UntrustedDevice" property that can be used
> > > by the firmware to mark any device as untrusted.
> 
> I think this new property should be documented somewhere too (also
> explain when to use it instead of ExternalFacingPort). If not in the
> next ACPI spec or some supplemental doc then perhaps in the DT bindings
> under Documentation/devicetree/bindings.

Actually Microsoft has similar already:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection

I think we should use that too here.
