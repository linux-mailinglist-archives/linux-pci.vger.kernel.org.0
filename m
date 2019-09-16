Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E813EB3943
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfIPLWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 07:22:53 -0400
Received: from foss.arm.com ([217.140.110.172]:43560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfIPLWw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 07:22:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DC761000;
        Mon, 16 Sep 2019 04:22:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F75F3F59C;
        Mon, 16 Sep 2019 04:22:51 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:22:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hillf Danton <hdanton@sina.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: pci: endpoint test BUG
Message-ID: <20190916112246.GA6693@e121166-lin.cambridge.arm.com>
References: <20190916020630.1584-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916020630.1584-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 10:06:30AM +0800, Hillf Danton wrote:
> 
> On Sun, 15 Sep 2019 09:34:37 -0700
> > 
> > Kernel is 5.3-rc8 on x86_64.
> > 
> > Loading and removing the pci-epf-test module causes a BUG.
> > 
> > 
> > [40928.435755] calling  pci_epf_test_init+0x0/0x1000 [pci_epf_test] @ 12132
> > [40928.436717] initcall pci_epf_test_init+0x0/0x1000 [pci_epf_test] returned 0 after 891 usecs
> > [40936.996081] ==================================================================
> > [40936.996125] BUG: KASAN: use-after-free in pci_epf_remove_cfs+0x1ae/0x1f0
> > [40936.996153] Write of size 8 at addr ffff88810a22a068 by task rmmod/12139
> 
> Fix fb0de5b8dcc6 and ef1433f717a2 if the current group::group_entry
> used by pci epf does not break how configfs uses it.
> 
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -153,9 +153,11 @@ static void pci_epf_remove_cfs(struct pc
>  		return;
>  
>  	mutex_lock(&pci_epf_mutex);
> -	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
> +	list_for_each_entry_safe(group, tmp, &driver->epf_group,
> +							group_entry) {
> +		list_del_init(&group->group_entry);
>  		pci_ep_cfs_remove_epf_group(group);
> -	list_del(&driver->epf_group);
> +	}
>  	mutex_unlock(&pci_epf_mutex);
>  }

Thank you Hillf. Kishon, can you confirm that's the proper fix for
this bug please ? I would like to turn this into a patch and merge
it in the upcoming merge window PR so it ought to be fairly quick,
please let me know asap.

Lorenzo
