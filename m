Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672282296D7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGVLBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 07:01:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:11667 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgGVLBv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 07:01:51 -0400
IronPort-SDR: UReT7caanMw9IHtcaEd87zqu8/s3REOF84lWI53fpCuoQVCNlXJL3/49A7S4nPHAfoKh9ra8S4
 vuCkb262bJfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="211850855"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="211850855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 04:01:50 -0700
IronPort-SDR: fZ6SHTvlHEVgZkFC8IVm371dDSplTZvMaC1Ev2OyawvRSN3MATnVwd7nbi0DVmj583oEBWGavv
 /7Iw3ESiI8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="487951806"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2020 04:01:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jyCVO-003F9Z-48; Wed, 22 Jul 2020 14:01:46 +0300
Date:   Wed, 22 Jul 2020 14:01:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, bp@alien8.de, james.morse@arm.com,
        lenb@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        zhangliguang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, linuxarm@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Message-ID: <20200722110146.GW3703480@smile.fi.intel.com>
References: <20200722103952.1009-1-shiju.jose@huawei.com>
 <20200722103952.1009-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722103952.1009-2-shiju.jose@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 11:39:51AM +0100, Shiju Jose wrote:
> CPER records describing a firmware-first error are identified by GUID.
> The ghes driver currently logs, but ignores any unknown CPER records.
> This prevents describing errors that can't be represented by a standard
> entry, that would otherwise allow a driver to recover from an error.
> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> version 2.8).
> 
> Add a notifier chain for these non-standard/vendor-records. Callers
> must identify their type of records by GUID.
> 
> Record data is copied to memory from the ghes_estatus_pool to allow
> us to keep it until after the notifier has run.
> 
> Co-developed-by: James Morse <james.morse@arm.com>

Co-developed-by: is going _in conjunction with_ SoB tag which is missing here.

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

-- 
With Best Regards,
Andy Shevchenko


