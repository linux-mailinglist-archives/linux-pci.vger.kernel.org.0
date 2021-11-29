Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC931462358
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 22:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhK2VdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 16:33:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:46903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232771AbhK2VbS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 16:31:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="322318957"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="322318957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:24:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="594837751"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO intel.com) ([10.252.141.244])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:23:59 -0800
Date:   Mon, 29 Nov 2021 13:23:57 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 14/23] cxl: Introduce topology host registration
Message-ID: <20211129212357.6fnqn4vaoowo4vpq@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-15-ben.widawsky@intel.com>
 <CAPcyv4inKyG7biUh6nxhq9Y22-D5Pg4FgJeZw7mbhSrfwqxGcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4inKyG7biUh6nxhq9Y22-D5Pg4FgJeZw7mbhSrfwqxGcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-24 17:09:03, Dan Williams wrote:
> On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The description of the CXL topology will be conveyed by a platform
> > specific entity that is expected to be a singleton. For ACPI based
> > systems, this is ACPI0017. When the topology host goes away, which as of
> > now can only be triggered by module unload, it is desirable to have the
> > entire topology cleaned up. Regular devm unwinding handles most
> > situations already, but what's missing is the ability to teardown the
> > root port. Since the root port is platform specific, the core needs a
> > set of APIs to allow platform specific drivers to register their root
> > ports. With that, all the automatic teardown can occur.
> 
> Wait, no, that was one of the original motivations, but then we
> discussed here [1] that devm teardown of a topology can happen
> naturally / hierarchically.
> 
> [1]: https://lore.kernel.org/r/CAPcyv4ikVFFqyfH2zLhBVJ28N1_gufGHd2gVbP2h+Rv2cZEpeA@mail.gmail.com
> 
> No, the reason for the cxl_topology_host is as a constraint for when
> CXL.mem connectivity can be verified from root to endpoint. Given that
> endpoints can attach at any point in time relative to when the root
> arrives CXL.mem connectivity needs to be revalidated at every topology
> host arrival / depart event.

Oops. I forgot to update the commit message, I will take what you wrote with
slight modification.


