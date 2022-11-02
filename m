Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9869E617168
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKBXJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBXJG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893049598;
        Wed,  2 Nov 2022 16:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31E5961C83;
        Wed,  2 Nov 2022 23:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6902CC433D6;
        Wed,  2 Nov 2022 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667430544;
        bh=KQVVvJul3e+LIRCa1krQLfyrxLZ8eSmofw8+KlVwyfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KW4pmUZxgeEgHwtbwqAp7z2VpcFJa7XuBKVRpqn3H2HrM7AIBRSDocPrtxzRM65of
         yANiQGN6Ok3eqH/tGg9eOSNq0FB5FoMVuIAdQ3C758gdwc0Cp9UPynE75lYjnp9l39
         cfqKqMAErQRRmw09KfLVK8PnYAVRMFcLKi0dOXtrzKoNbB60jECxjpMorkwifL1blo
         B/crLZP6oDzNZ0uTYzrCQz0/H4oAIl9flIX3BSjNULso0pOERcLiQdreoADa1PVr3q
         tW2L4PvwFCTfIB5tKIPuTOFcI6h8ALGtTYCWcbUqjkvFpDjII/Szyr1yfqQ73mP7ZG
         Z3EQ3SaWfaZDw==
Date:   Wed, 2 Nov 2022 18:09:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pci-epf-test: Register notifier if only
 core_init_notifier is enabled
Message-ID: <20221102230902.GA6576@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faa0138-ae2b-42e0-d378-665527f0b660@socionext.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 06:31:07PM +0900, Kunihiko Hayashi wrote:
> Hi Bjorn,
> 
> On 2022/10/29 2:06, Bjorn Helgaas wrote:
> > On Thu, Aug 25, 2022 at 06:01:01PM +0900, Kunihiko Hayashi wrote:
> > > Need to register pci_epf_test_notifier function event if only
> > > core_init_notifier is enabled.
> > > 
> > > Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core
> > initialization")
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > Acked-by: Om Prakash Singh <omp@nvidia.com>
> > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > >   drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > This patch is a part of series "PCI: endpoint: Fix core_init_notifier
> > feature".
> > > The rest of the patches have been withdrawn.
> > > 
> > > Changes since v2:
> > > - Add Acked-by lines
> > > 
> > > Changes since v1:
> > > - Add Acked-by lines
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> > b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 36b1801a061b..55283d2379a6 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -979,7 +979,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> > >   	if (ret)
> > >   		epf_test->dma_supported = false;
> > > -	if (linkup_notifier) {
> > > +	if (linkup_notifier || core_init_notifier) {
> > >   		epf->nb.notifier_call = pci_epf_test_notifier;
> > >   		pci_epc_register_notifier(epc, &epf->nb);
> > 
> > Why does pci_epc_register_notifier() even exist?  It's not used at all
> > except for this test code.
> > 
> > It would be better if infrastructure like this were connected with
> > some user of it.
>
> This call was added by the commit 5779dd0a7dbd
> ("PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF").
> 
> I haven't followed the discussion, however, this commit say: "This
> will also enable to add more events (in addition to linkup) in the
> future."

5779dd0a7dbd was 2.5 years ago.  It was probably a mistake to merge it
then.  Usually we add infrastructure when we have a user for it,
either in the very same patch or at least in a subsequent patch of the
series.  

But Lorenzo has already merged this, so I guess this is moot.

He probably wouldn't object to a second patch that removes the fixed
infrastructure if nobody uses it.  We can easily resurrect it if a
need arises, and if that happens, we'll be glad that it has been
fixed!

Bjorn
