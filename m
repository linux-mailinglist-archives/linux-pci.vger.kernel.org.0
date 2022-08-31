Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CCF5A7EA0
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiHaNXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHaNXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 09:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57570A2211;
        Wed, 31 Aug 2022 06:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28D261ABD;
        Wed, 31 Aug 2022 13:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E0C433D6;
        Wed, 31 Aug 2022 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661952183;
        bh=tfMwNPtQLlX+SnAmAHcp4e9lcD14DH5x+PNXHRaF5Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tCFsvhzsLWW6kCGY3+i4jK/tTu3xmqJdqTJL94dqn8qRfB0lEhq5QIsse049NH2tl
         ssOzp2t+EfzKyNIz/PgU+3SiEVjffEi67w8nuzmUZV/7/4cfjiiCe1hZ11URzy86bf
         YThlRzmA7vlKp4FJN3BIC5vgKSoOsDglUFi/WOMUm+ttRM5H37JZYowQCllNsFJzZE
         AAKL9y2sG2wsor3U/6aT6dp7HGx2FtnLCS93T4hVfCNKnrYVdK1oMPj6/pwFmq8LOg
         D3tKYDWFyziV/wovfJJBJdz2noWulH5CVCdT6Qz9UE/SfasXWHBwh1YgrvCASugPQJ
         KQcMOSlTj73ag==
Date:   Wed, 31 Aug 2022 08:23:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable PTM on Upstream Ports during suspend
Message-ID: <20220831132301.GA177609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw8vgYeqY6a79HDR@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Rajvi, linux-pm]

On Wed, Aug 31, 2022 at 12:53:05PM +0300, Mika Westerberg wrote:
> On Tue, Aug 30, 2022 at 10:52:24AM -0500, Bjorn Helgaas wrote:
> > +	type = pci_pcie_type(dev);
> > +	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
> > +	      type == PCI_EXP_TYPE_UPSTREAM ||
> > +	      type == PCI_EXP_TYPE_ENDPOINT))
> > +		return;
> 
> Perhaps switch () instead?
> 
> switch (pci_pcie_type(dev)) {
> case PCI_EXP_TYPE_ROOT_PORT:
> case PCI_EXP_TYPE_UPSTREAM:
> case PCI_EXP_TYPE_ENDPOINT:
> 	break;
> default:
> 	return;
> }
> 
> Either way,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!  I dropped this patch for now.  I think Rajvi's similar
patch [1] is much better because we only need this kind of check in
one place -- where we enable PTM.

Also, we need to tighten this up so we *always* disable PTM [2].  The
patch I posted still calls pci_disable_ptm() from
pci_prepare_to_sleep(), which means we only do it when
!pdev->state_saved, so we leave PTM enabled if the driver saves its
own state.

Bjorn

[1] https://lore.kernel.org/r/20220830104913.1620539-2-rajvi.jingar@linux.intel.com
[2] https://lore.kernel.org/r/CAJZ5v0iHckqia4OywKzSNWFCaq7eOkJcm5yXJdT2_sNdd36gDw@mail.gmail.com
