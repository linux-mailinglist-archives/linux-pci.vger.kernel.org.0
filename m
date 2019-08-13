Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E08ACCE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHMCqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 22:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfHMCqI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 22:46:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74F6CC0022F1;
        Tue, 13 Aug 2019 02:46:08 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D3A7E466;
        Tue, 13 Aug 2019 02:46:04 +0000 (UTC)
Date:   Tue, 13 Aug 2019 10:46:00 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-pci@vger.kernel.org,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, kasong@redhat.com,
        lijiang@redhat.com, Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Crash kernel with 256 MB reserved memory runs into OOM condition
Message-ID: <20190813024600.GA2944@dhcp-128-65.nay.redhat.com>
References: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
 <20190812095029.GE5117@dhcp22.suse.cz>
 <20190813024317.GA2862@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813024317.GA2862@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 13 Aug 2019 02:46:08 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add more cc.
On 08/13/19 at 10:43am, Dave Young wrote:
> Hi,
> 
> On 08/12/19 at 11:50am, Michal Hocko wrote:
> > On Mon 12-08-19 11:42:33, Paul Menzel wrote:
> > > Dear Linux folks,
> > > 
> > > 
> > > On a Dell PowerEdge R7425 with two AMD EPYC 7601 (total 128 threads) and
> > > 1 TB RAM, the crash kernel with 256 MB of space reserved crashes.
> > > 
> > > Please find the messages of the normal and the crash kernel attached.
> > 
> > You will need more memory to reserve for the crash kernel because ...
> > 
> > > [    4.548703] Node 0 DMA free:484kB min:4kB low:4kB high:4kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:568kB managed:484kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > > [    4.573612] lowmem_reserve[]: 0 125 125 125
> > > [    4.577799] Node 0 DMA32 free:1404kB min:1428kB low:1784kB high:2140kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:15720kB writepending:0kB present:261560kB managed:133752kB mlocked:0kB kernel_stack:2496kB pagetables:0kB bounce:0kB free_pcp:212kB local_pcp:212kB free_cma:0kB
> > 
> > ... the memory is really depleted and nothing to be reclaimed (no anon.
> > file pages) Look how tht free memory is below min watermark (node zone DMA has
> > lowmem protection for GFP_KERNEL allocation).
> 
> We found similar issue on our side while working on kdump on SME enabled
> systemd.  Kairui is working on some patches.
> 
> Actually on those SME/SEV enabled machines, swiotlb is enabled
> automatically so at least we need extra 64M+ memory for kdump other
> than the normal expectation.
> 
> Can you check if this is also your case?

The question is to Paul,  also it would be always good to cc kexec mail
list for kexec and kdump issues.
