Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39F89A69
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfHLJuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 05:50:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbfHLJub (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 05:50:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F9FEAECA;
        Mon, 12 Aug 2019 09:50:30 +0000 (UTC)
Date:   Mon, 12 Aug 2019 11:50:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        "x86@kernel.org" <x86@kernel.org>, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Crash kernel with 256 MB reserved memory runs into OOM condition
Message-ID: <20190812095029.GE5117@dhcp22.suse.cz>
References: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon 12-08-19 11:42:33, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell PowerEdge R7425 with two AMD EPYC 7601 (total 128 threads) and
> 1 TB RAM, the crash kernel with 256 MB of space reserved crashes.
> 
> Please find the messages of the normal and the crash kernel attached.

You will need more memory to reserve for the crash kernel because ...

> [    4.548703] Node 0 DMA free:484kB min:4kB low:4kB high:4kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:568kB managed:484kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    4.573612] lowmem_reserve[]: 0 125 125 125
> [    4.577799] Node 0 DMA32 free:1404kB min:1428kB low:1784kB high:2140kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:15720kB writepending:0kB present:261560kB managed:133752kB mlocked:0kB kernel_stack:2496kB pagetables:0kB bounce:0kB free_pcp:212kB local_pcp:212kB free_cma:0kB

... the memory is really depleted and nothing to be reclaimed (no anon.
file pages) Look how tht free memory is below min watermark (node zone DMA has
lowmem protection for GFP_KERNEL allocation).

[...]
> [    4.923156] Out of memory and no killable processes...

and there is no task existing to be killed so we go and panic.
-- 
Michal Hocko
SUSE Labs
