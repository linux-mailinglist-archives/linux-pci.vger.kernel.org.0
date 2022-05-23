Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0053178E
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiEWStc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbiEWSsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306AAB0C1;
        Mon, 23 May 2022 11:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D91C60EBC;
        Mon, 23 May 2022 18:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A7FC385A9;
        Mon, 23 May 2022 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653330760;
        bh=6x15FAaWRfuRB2uOgjXHOEP2szbRD1ja9LAbFtWkp6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G8O0GvzI1AoHu3KGYVes5OExmxN1O9NVzfr8AYwOBZ+FWufKii5XfDGBLvkcZadVP
         n6WVbYoQKXHb9Goq89weUIc40nIfmaBTGeUiTKH6Zwg55S/wbeu1PCzK69wUPYE3SC
         Vk5fOgB9by2BPWavu0Y08TO1+v7Kf9uoC5Tmjl+DiiEg/YghYu2CGYjtQbsNEcNmwf
         kZ1Q019hARbXEHmT2m1OZCSWEhKIBRGTEz3uuRVYLyXexzhEFGwoEqs8ewZFFEtBwj
         17qIF2dJChZ/ss4Yv4kXocsJ9BzIVhIewZkchCQObubE58V+PCDI1fFRHE6epyhAZ8
         x7pJf5jgtO1KA==
Date:   Mon, 23 May 2022 13:32:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     David Box <david.e.box@linux.intel.com>,
        "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Message-ID: <20220523183238.GA174199@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iHgtTpW+ox=wK68cnuG6D+KvFiOCh2UF96dxq08Z3BSA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 09:01:27PM +0200, Rafael J. Wysocki wrote:
> ...

> In the meantime, I think that it would make sense to pick up the first
> patch in this series which is a good cleanup regardless.
> 
> Bjorn, could you do that, please?

As far as I know, this series has never actually made it to
linux-pci@vger.kernel.org, so I haven't seen the 1/2 patch.  This
query:

  https://lore.kernel.org/linux-pci/?q=f%3Arajvi.jingar

finds only a couple responses.  I did mention this to Rajvi, but
haven't heard anything yet.

Bjorn
