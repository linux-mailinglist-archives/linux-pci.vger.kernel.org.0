Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CCF6C2FC4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 12:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCULHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCULHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 07:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9423D0AD
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 834F061AF8
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDEC433EF;
        Tue, 21 Mar 2023 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679396868;
        bh=tuJB9JhZY1AzhMb7HRztyFndBRHCJYMxufVn3du0MpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TqEsYzq8PnYLmo0Ld4RSuGyghJa7SfQGhDYW5d/svaRQSrG8OGqNQHhpny2rzGpfQ
         PO9xsIYUgDe0MNj6bPmwLfov1mR5AyD+itj7lOULnpKno4mtvH4GZiSjXmiUB/LpFE
         WRMxKo4ok6QA4qhYj0RfPeoqEe2UB3uJCbyAM9Y5WlICoKUuPJU+jLb09fiopilg9v
         tr4kowPhlQZttoH/7UwNc4fJMAwZmqcPxmwrUV2uaua5Ut+b2T5OPAhbf9g6KG26UW
         rV2+s7+ee5oDuOQ1e2uzVV9mwOZk9ql3HMyVJKMdVK1J+Y5kKKeR0IB5GQ9a+OvHNl
         db+5M7VxfcdRQ==
Date:   Tue, 21 Mar 2023 06:07:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230321110747.GA2368837@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb0b977-be26-bf28-7bf1-b4e1b83f33c7@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 05:52:58PM -0500, Mario Limonciello wrote:
> > If Linux *could* do this one-time initialization, and subsequent
> > D0/D3hot transitions worked per spec, that would be awesome
> > because we wouldn't have to worry about making sure we run the
> > quirk at every possible transition.
> 
> It can be changed again at runtime.
> 
> That's exactly what we did in amdgpu for the case that the user
> didn't disable integrated GPU.
> 
> We did the init for the IP block during amdgpu's HW init phase.
> 
> I see 3 ways to address this:
> 
> 1) As submitted or similar (on every D state transition work around
> the issue).
>
> 2) Mimic the Windows behavior in Linux by disabling MSI-X during D3
> entry and re-enabling on D0.
>
> 3) Look for a way to get to and program that register outside of
> amdgpu.
> 
> There are merits to all those approaches, what do you think?

Without knowing anything about the difficulty of 3), that seems the
most attractive to me because we never have to worry about catching
every D state transition.

Bjorn
