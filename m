Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020764A5FD7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiBAPRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 10:17:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:30131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233666AbiBAPRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 10:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643728650; x=1675264650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tIGpzUyBPxdI3loQTBtXN9Wxy9wBUXW3CNk5G5rWMs0=;
  b=oKQ1xhtMnB9lNDWBrgX7BtcAIzg0lLLQjaHTrHrsq3C2oJUCFeTaXGRE
   NfScpz/R+mUFDw+9PgVnjkuKEvmTcaeNwfV/joCVEWbGM7+SrUigNFmhI
   uiPvC64ADUrxgIxHUbdAsfXM1IcDsKKbEKJfnu9e4WTqevKcnUmfa0YQo
   PnciepFzervmGWv4/g8tqnOTuZC5yEq8NDXk+qrFH4iiaC+S1nBTuDBi/
   oiCSX7I3kMl8XnjeBdJWeYiVyOdapqkBW3LTkJ1wdY3b0zvc1k+9rqMLw
   okag+wq7qrCewvpYCVlI+y8d07YxRavl8laz6f8BxNIEgIUuP6hz6BETP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247928334"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247928334"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:17:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="676109537"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:17:30 -0800
Date:   Tue, 1 Feb 2022 07:17:28 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 25/40] cxl/core/port: Remove @host argument for dport
 + decoder enumeration
Message-ID: <20220201151728.zgc55ckks672gedz@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298425201.3018233.647136583483232467.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298425201.3018233.647136583483232467.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:30:52, Dan Williams wrote:
> Now that dport and decoder enumeration is centralized in the port
> driver, the @host argument for these helpers can be made implicit. For
> the root port the host is the port's uport device (ACPI0017 for
> cxl_acpi), and for all other descendant ports the devm context is the
> parent of @port.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I really like removing @host as much as possible everywhere.
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]

