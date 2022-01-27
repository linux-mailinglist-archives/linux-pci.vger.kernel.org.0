Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2475749DA96
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 07:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiA0GZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 01:25:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:12501 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbiA0GZ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 01:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643264756; x=1674800756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q180AkUP3S1CxofaKRpXRwm4rXghnLdUEzNh6MBM9Bs=;
  b=cC36qqsLGI0yweXH8086NuvEr/RaAeQjCKcv4/0IgP9+aHuxYP9gRiG4
   QMbr71cqrd9v1GiU5LxqPSfe9OmLpaPY1km35FgD/nfmT/Qy5aBpneGUG
   JdXkj+fcFeNuPz/pROrggvsqxNlvAKawEiEibm5r0/b3olVarbCWokZjV
   Z3KI7NT9HRTjlcjBiafuZ9cDT91LE/z/gcA+9hKE6CcYvRH9NnxpN/Eyr
   Q05OIAoZo1dKtN8z2XRCHyvI1foTMavAS/OJtu6WtPPMuJqMrwPDzCxb1
   QAWEhyuUBTvWnRlYAIIKFP+3naxI3Zdgnil8Cvs5zNYSvytmcNyJdMdPE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245601846"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="245601846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:25:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="767395742"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:25:54 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 27 Jan 2022 08:25:51 +0200
Date:   Thu, 27 Jan 2022 08:25:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: ACPI: Replace acpi_bus_get_device()
Message-ID: <YfI67/wPNPS8spNR@lahna>
References: <11930209.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11930209.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 12:40:13AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
