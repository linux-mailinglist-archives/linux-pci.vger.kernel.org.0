Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA925B0930
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIGPuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIGPt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 11:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B9275D7;
        Wed,  7 Sep 2022 08:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BABAB81E07;
        Wed,  7 Sep 2022 15:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87BAC433D7;
        Wed,  7 Sep 2022 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662565789;
        bh=v/oUc1Z9oWyePt6Tf3C7YrHYO+HN/LNbUxfvmO2VunY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hx6HpzuMYTl5WYQx2qeUE7gB5PKOn/sn4/NOwQ3v5ODfFgqUYB0dKgYvM41uRnZ+B
         QNsjplgAMMp89o7aQwIXIIgZlEFhQBSVtebJVDdeBjoMvi2oz/RniEwSNLMPqgQLyl
         U1Q/RxYMFemiHbP82U2wlBvkiEwr4DS3t10DnqGfK5any2XmJcnp4fYkelXpYEd9PK
         EmPqu38lozdCiNDQjCFk+YfNzB4RxOEb7w2KZL0cl2f0YW0hpkE70y0QVxHMoE5H62
         fDz4+Ua2E8Nt/1qTzAs+1CJuFuAJdSNsKk0r0C+vFb/ZJZfCdLe3u0Rbq1DVnhh/rZ
         Hsp6FAn1NP+1Q==
Date:   Wed, 7 Sep 2022 10:49:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 02/10] PCI/PTM: Cache PTM Capability offset
Message-ID: <20220907154946.GA114629@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def1ed94-273a-11eb-68c3-b0b681f921ca@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 04:18:23PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 9/6/22 3:23 PM, Bjorn Helgaas wrote:

> >  void pci_disable_ptm(struct pci_dev *dev)
> >  {
> > -	int ptm;
> > +	int ptm = dev->ptm_cap;
> 
> I think you don't need to store it. Directly use dev->ptm?

True, no need, but the value is used three times in this function, so
I think the variable reduces clutter overall.

> >  void pci_restore_ptm_state(struct pci_dev *dev)
> >  {
> > +	int ptm = dev->ptm_cap;
> 
> It can be u16?

Done, thanks!  I see that in ee8b1c478a9f ("PCI: Return u16 from
pci_find_ext_capability() and similar"), I forgot to change the inline
stub from int to u16.  I'll add a patch to do that.  Probably not a
prerequisite, since the stub is for !CONFIG_PCI and this code won't
be compiled at all in that case.

> >  void pci_ptm_init(struct pci_dev *dev)
> >  {
> > -	int pos;
> > +	int ptm;
> 
> Why rename? Also ptm can be u16

"ptm" conveys more information than "pos" and I think it's worth using
the same name for all the functions.

Thank you!

Bjorn
