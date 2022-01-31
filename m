Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73D4A5283
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiAaWkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 17:40:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:58604 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234386AbiAaWkI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 17:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643668808; x=1675204808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssB0iV/cMxck25dO81DeYUJAunxOtDWbLOabp/wUCZA=;
  b=e62z4Yw1UM7Y10+wueEIIctu2xlFqrYAyGaZ642s5TvfXG/ZXDhp4tqu
   F35cyrCErxvOpNZ/GEPn0mBxA/N+ncBQRBXDUvN0tt7o5jVWY0SDnuoKV
   sAvmctWzuBKog28BQBdNl5DvrTThIZGp0Ng6pzEq4xIS41AU6FbRxihwh
   7W1GyMxaic/puizTys7qoc0xXHLuDIXcdR4pLJyYAQZZbkXgZyHKVBxFj
   /UT200p04IefoZla5Ea/m7fe8snguHo53uW3LRl+ngaiIz7UkqMoeBMlZ
   tjY/OcLfXttgGvbkoo70juiX9lirI1VJH8E8vNyenC9TdeimvfajVt3IB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246399177"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="246399177"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:40:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="626525085"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:40:01 -0800
Date:   Mon, 31 Jan 2022 14:39:59 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 12/40] cxl/core: Fix cxl_probe_component_regs() error
 message
Message-ID: <20220131223959.l4uvkjwzu2t3k5lt@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298418268.3018233.17790073375430834911.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298418268.3018233.17790073375430834911.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:29:42, Dan Williams wrote:
> Fix a '\n' vs '/n' typo.
> 
> Fixes: 08422378c4ad ("cxl/pci: Add HDM decoder capabilities")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Ben Widawsky <ben.widawsky@intel.com

[snip]
