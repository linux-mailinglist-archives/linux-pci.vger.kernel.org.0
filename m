Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B757A5254F2
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiELSft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiELSfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 14:35:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C4E624C;
        Thu, 12 May 2022 11:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C298B82AA1;
        Thu, 12 May 2022 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37E8C385B8;
        Thu, 12 May 2022 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652380544;
        bh=/6OvTrMR64xa6QlQFhhNcewJHYWfLGdipO2bUXwjyHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SmLswOHxEYUyMTEd3YEvR/vk2M1YGtsLHGlu5L1K282kM/7aaN5bDoTXKYg9I+bwc
         Qu4PeXvNLSmGUSkSxAolmWo1TWGJmyLRr3vWbaxX4v7fu+MAkjiHbHv8IoUXrCvqHn
         kV3YZkECOdtV1+74VQFAgMkEwabcebTo8IUXYxLNM7BaMSHPn1loU8TAzoXYGMIIgx
         MQeygjRC7MJWc0ugLKhRgXs6uFQdTD5r4gbBsekcIp+0XbyOtyWqwu8LaHc3Igszsm
         GoTIHMzE6CzmMVBOFja1vJZ7G3yLsNeAqrpSQqwVOpC8Up40QHakmR/7tLiQAkHx1n
         jWUKGOXCN382Q==
Date:   Thu, 12 May 2022 13:35:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Message-ID: <20220512183540.GA859016@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_p+Yb-VLo8b6-SYU17=GQOqZh2E5-52dkq-3rzU=57A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:

> > > Something like this should suffice IMV:
> > >
> > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > >
> > >         pci_disable_ptm(pci_dev);
> >
> > It makes sense to me that we needn't disable PTM if the device is in
> > D3cold.  But the "!dev_state_saved" condition depends on what the
> > driver did.  Why is that important?  Why should we not do the
> > following?
> >
> >   if (pci_dev->current_state != PCI_D3cold)
> >     pci_disable_ptm(pci_dev);
> 
> We can do this too.  I thought we could skip the power state check if
> dev_state_saved was unset, because then we would know that the power
> state was not D3cold.  It probably isn't worth the hassle though.

Ah, thanks.  IMHO it's easier to analyze for correctness if we only
check the power state.

Bjorn
