Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EA42CED1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJMWr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 18:47:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:57284 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhJMWr3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 18:47:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="313756570"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="313756570"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 15:45:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="717515064"
Received: from sjchris1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.156])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 15:45:24 -0700
Date:   Wed, 13 Oct 2021 15:45:23 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
Message-ID: <20211013224523.rxyt2mg75ebxismi@intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-10-09 09:44:34, Dan Williams wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> In preparation for moving parts of register mapping to cxl_core, split
> cxl_pci_setup_regs() into a helper that finds register blocks,
> (cxl_find_regblock()), and a generic wrapper that probes the precise
> register sets within a block (cxl_setup_regs()).
> 
> Move the actual mapping (cxl_map_regs()) of the only register-set that
> cxl_pci cares about (memory device registers) up a level from the former
> cxl_pci_setup_regs() into cxl_pci_probe().
> 
> With this change the unused component registers are no longer mapped,
> but the helpers are primed to move into the core.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: rebase on the cxl_register_map refactor]
> [djbw: drop cxl_map_regs() for component registers]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

[snip]

Did you mean to also drop the component register handling in cxl_probe_regs()
and cxl_map_regs()?

