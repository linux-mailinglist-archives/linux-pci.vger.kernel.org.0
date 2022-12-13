Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF62964BE94
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 22:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiLMVhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 16:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiLMVhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 16:37:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC654F587;
        Tue, 13 Dec 2022 13:37:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68C72B815BE;
        Tue, 13 Dec 2022 21:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE099C433F0;
        Tue, 13 Dec 2022 21:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670967469;
        bh=HcXX0RARN3I+UoWquQo+DGm5xVSzYdRpmI93ak8n568=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=icQ7Gn7gzrap9RUm5z5buouvFxdzmPCrLnoJ5EANFRXsHHTbyyl1Ax50IF2hpJCsP
         J4s4I0zdHTd9AJw+BhKgk3yqriEqfYK5gK3kNE9Jpddqe5whUQLdhmL1UUR1vuT5nK
         9js58GAaGVtQZAQD64k1229c+yRKJFndnZTxBetcrYxvYR7H7s0nvTStXzJe8TOAv3
         2vDCyfL+8lqj64cgUg+Vqn34M5ziBXYgeGQLJEXKFJoHMOcSifl+07lPWOeD8Hd35K
         9aS08FvHtDFWpIIPm89ubLUvH5kwQnqy9PzhgBvqetVIluQF3hvIbZCHr0qzbn00v2
         tlHNApqLmgVQQ==
Date:   Tue, 13 Dec 2022 15:37:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports &
 RCECs
Message-ID: <20221213213747.GA209007@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5bqU0rc44NtYJXl@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 12, 2022 at 12:46:11AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 09, 2022 at 06:29:22PM -0600, Bjorn Helgaas wrote:
> > +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> > +	    dev->aer_cap && pci_aer_available() &&
> >  	    (pcie_ports_native || host->native_aer))
> 
> Eww, this is really hard to follow.  Can you split this out into
> a little helper, that actually documents the decisions based
> on some of the wording you have in the current comit message?

I completely agree.  We have basically the same sort of thing for
PCIE_PORT_SERVICE_HP (also added this cycle), PCIE_PORT_SERVICE_AER,
PCIE_PORT_SERVICE_PME, and PCIE_PORT_SERVICE_DPC.  I'd really like to
figure out a way to centralize the check for pcie_ports_native,
host->native_aer, etc., because they clutter a lot of places.

I didn't have time to work on that this cycle, but maybe next time.

Bjorn
