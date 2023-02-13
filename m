Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E0695222
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBMUra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 15:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMUr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 15:47:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A544E83FB
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 12:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CFF38CE1D28
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 20:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F1AC433EF;
        Mon, 13 Feb 2023 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676321244;
        bh=CxKp7DdRpIHLjyKvK/8EagwtvA0dnNmDwSHqDGmAmwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ijPd2PKP+TMC7+P+NjEuiTm/Xko37dYQGHOYIwUvdyrPqNZhHk0AFGgO6F2k0TM7o
         ioS89gBKo368/y1po2aQidhAEu3/QR+vtaf+A+JE1lhaLfHyMzLx3k1c9A3xJoj+vM
         blAl7XLQnM9AlGq5+IaTu5fXxrkRy8yPz+8PutJXFoWDUmadezKiVPz9qGJkcc2SkN
         D6b2Jo10o/Xwo4Kv7VfztFUo/CGrugTgqtPpA4vftg7DPDgCt9d40wi6G+AnnZ4kzN
         kobvP2nuT2FrNqfDlj3+ReUFIZoAc37dOeXfDBIguvw7AHPHALEBVzn2vpQVom3ZY5
         e5ABk69JqVjag==
Date:   Mon, 13 Feb 2023 14:47:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     regressions@lists.linux.dev
Cc:     linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] [Bug 216859] New: PCI bridge to bus boot hang at
 enumeration
Message-ID: <20230213204722.GA2929794@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201232750.GA1908996@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 01, 2023 at 05:27:50PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 26, 2023 at 06:11:24AM -0600, Bjorn Helgaas wrote:
> > [+cc folks from 145eed48de27 and framebuffer folks, regression list]
> > 
> > On Thu, Jan 12, 2023 at 02:08:19PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 28, 2022 at 06:02:48AM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > > 
> > > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > > >     Kernel Version: 6.1-rc1
> > > > > ...
> > > > 
> > > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > > see attachments.
> > > > > 
> > > > > The enumeration works fine with Kernel 6.0 and below.
> > > > > 
> > > > > Same problem still exists with v6.1. and v6.2.-rc1
> > 
> > This is a regression between v6.0 and v6.1-rc1.  Console output during
> > boot freezes after nvidiafb deactivates the VGA console.
> > 
> > It was a lot of work for Zeno, but we finally isolated this console
> > hang to 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus").
> > 
> > The system actually does continue to boot and is accessible via ssh, 
> > but the console appears hung, at least for output.  More details in
> > the bugzilla starting at
> > https://bugzilla.kernel.org/show_bug.cgi?id=216859#c47 .
> 
> #regzbot introduced: 145eed48de27
> #regzbot dup: https://lore.kernel.org/all/D41A3A42-2412-4722-9090-01565058E525@gmail.com/

#regzbot fix: 04119ab1a49f ("nvidiafb: detect the hardware support before removing console.")
