Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0644C5C3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 18:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKJRRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 12:17:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4079 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhKJRR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 12:17:29 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HqBKR4RSrz67yyF;
        Thu, 11 Nov 2021 01:14:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 10 Nov 2021 18:14:39 +0100
Received: from localhost (10.52.121.123) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 10 Nov
 2021 17:14:39 +0000
Date:   Wed, 10 Nov 2021 17:14:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/10] cxl/pci: Split cxl_pci_setup_regs()
Message-ID: <20211110171437.00007160@Huawei.com>
In-Reply-To: <163434053788.914258.18412599112859205220.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163434053788.914258.18412599112859205220.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.123]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Oct 2021 16:30:42 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

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
> [djbw: drop cxl_map_regs() for component registers]
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: rebase on the cxl_register_map refactor]
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Ben / all,

This is probably the best patch to comment on for this
(note it is not a comment about this patch, but more the state we end up
in after it).

cxl_map_regs() is a generic function, but with the new split approach
as a result of this patch, we now always know at the caller which of
the types of map we are doing.

I think it would be clearer to embrace that situation and drop cxl_map_regs()
in favor of directly calling the relevant specific versions such as
cxl_map_device_regs().  I can't immediately see how the generic cxl_map_regs()
will be useful to us going forwards.

Jonathan
