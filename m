Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA15B350A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIIKUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIIKU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 06:20:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4E6F25F;
        Fri,  9 Sep 2022 03:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD575B82485;
        Fri,  9 Sep 2022 10:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712FEC433D7;
        Fri,  9 Sep 2022 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718826;
        bh=8Sn8WrNoUZJkKYo6rTUp7rYpe1gjGfheWMeOFH/9gwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OR7JgDg7bdffNymnK5Ogz4vTx4lz76/qHZsuCZ80REXdSETL5vt5nKzl8YAV/hzUI
         fXqIwBRjzwbf5bq+MVx812yeQG4W8001z+ML1zRBiPO8ZCBhaXeB8j04MwlSSxDa00
         rOY4yCDnT8uK+eJRPRsYwon77m2OW5UURaWMYVS9867PlRjUhjIsoU5eXbWW3RKJRs
         iLfLuzp8yGAcfl0vbzg89BTU9HOAMr2XBK8AJkGQeQz4lx2FS+ORLn3tv0Zoq0oN/j
         lJd4AmC1IaMInJ3ddDOcHJt9Zj9oqlGyF8wFsNhiC4UL9p1xBf9mEw/vXKBU3h0heH
         6u399K72zzGrg==
Date:   Fri, 9 Sep 2022 12:20:19 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, bhelgaas@google.com,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Use link_up() callback in place of
 LINK_UP notifier
Message-ID: <YxsTYzGkfzFiBIsq@lpieralisi>
References: <20220811094237.77632-1-manivannan.sadhasivam@linaro.org>
 <20220811094237.77632-3-manivannan.sadhasivam@linaro.org>
 <c200a544-31fe-b660-82bb-4bbed5acf135@ti.com>
 <20220831082025.GC5076@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831082025.GC5076@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 01:50:25PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 25, 2022 at 03:47:10PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Mani,
> > 
> > On 11/08/22 15:12, Manivannan Sadhasivam wrote:
> > > As a part of the transition towards callback mechanism for signalling the
> > > events from EPC to EPF, let's use the link_up() callback in the place of
> > > the LINK_UP notifier. This also removes the notifier support completely
> > > from the PCI endpoint framework.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
> > >  drivers/pci/endpoint/pci-epc-core.c           |  8 +++--
> > >  include/linux/pci-epc.h                       |  8 -----
> > >  include/linux/pci-epf.h                       |  8 ++---
> > >  4 files changed, 18 insertions(+), 39 deletions(-)
> > > 
> > 
> > .
> > .
> > <snip>
> > .
> > .
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index 805f3d64f93b..a51ba9f158c3 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -690,10 +690,15 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> > >   */
> > >  void pci_epc_linkup(struct pci_epc *epc)
> > >  {
> > > +	struct pci_epf *epf;
> > > +
> > >  	if (!epc || IS_ERR(epc))
> > >  		return;
> > >  
> > > -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> > > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > > +		if (epf->event_ops->link_up)
> > > +			epf->event_ops->link_up(epf);
> > > +	}
> > 
> > how do you ensure there is no race while invoking the call back
> > functions during add/remove of epf?
> > 
> 
> Good catch! These should be guarded by epf->lock.

I shall wait for v2 then and mark this one as "Changes requested".

Lorenzo
