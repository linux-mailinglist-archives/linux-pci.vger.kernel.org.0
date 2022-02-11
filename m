Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E244B29DE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbiBKQOL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:14:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiBKQOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:14:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8221D
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 08:14:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392E660F15
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 16:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45745C340E9;
        Fri, 11 Feb 2022 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644596048;
        bh=XREO/vHXAOv2lzh893fJ6xMwvKK3WUm+gggcHq0vKp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LXLOGAMvDQ33vZawEwa4mVqilZaLr10bwMntw+1iw3exUxZInn2n/T9lrXNvNwrrL
         0zxjqbjSHBCvX5Qf/cjMnNasn7nEMRR6XIJlozJLOgdvuQwBY5faHSO0ChxR4eM8Y2
         Zb6Oy7q//i9FNdhShP5ZSQz2qE8becZOH4isLfLfrKnILrOlYCAB2uBFl2KKgPeTgG
         6EeD25WCeAFQxCoTM4QE4eEV+MDz/TmCDoH7jyJ+Avnl/WwyFcfKdWStIOKZwZODnS
         V/r3Ep9MHnCnA9v5b6Gi912vRAnBdCEghvLpcTguoxK28EN7NWcraUkB1tW8BWyfEi
         vH8CM9fS9dRlw==
Date:   Fri, 11 Feb 2022 10:14:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Josef Johansson <josef@oderland.se>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI/MSI: msix_setup_msi_descs: Restore logic for
 msi_attrib.can_mask
Message-ID: <20220211161406.GA714343@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d705f3-8e0d-31b7-9a80-4413b8dbe7a3@oderland.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 01:10:22AM +0100, Josef Johansson wrote:
> On 2/11/22 00:55, Bjorn Helgaas wrote:
> > On Sat, Jan 22, 2022 at 02:10:01AM +0100, Josef Johansson wrote:
> >> From: Josef Johansson <josef@oderland.se>
> >>
> >> PCI/MSI: msix_setup_msi_descs: Restore logic for msi_attrib.can_mask
> > Please match the form and style of previous subject lines (in
> > particular, omit "msix_setup_msi_descs:").
> Would this subject suffice?
> PCI/MSI: Correct use of can_mask in msi_add_msi_desc()

Looks good to me!

Bjorn
