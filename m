Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928594E510D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 12:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiCWLNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 07:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbiCWLNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 07:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0278076;
        Wed, 23 Mar 2022 04:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E39361301;
        Wed, 23 Mar 2022 11:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C421BC340E8;
        Wed, 23 Mar 2022 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648033894;
        bh=zlaBNpkF/VGrPKC2PE4NKtCrr5fUiWij0ZGpyUDyFcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DRt85wTbu9I1Sr4nDptU85t8jRy78Y2Cyg5xIOnzqaCERoO+AdjExza5L5xE+lZ2O
         G8IxY7qoB3wHH8JPu34EWgtRywi59ZojSxqEq/+DZXTHh8rco51Na91BNbqEro4uiU
         eqI0/YBWQaf0Qz0wTnIvXRxajK1T7qyH80IEtqXKtznraRrky2pAZT7qjWCx9dLXyx
         m7A1aozWceC4+lgm7yBonnxFXn6rtjvdhKE2XRAnBbOvge//ubFm4P1lCS33XwJ2hp
         UZZ1rusZwzghxBlUWBd8JQH13iuqCsv4fpd9Vac6KVasPg4o9YA7uyn8SqFcHN9zz0
         Sk8+IcQdGsSSw==
Date:   Wed, 23 Mar 2022 06:11:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
Message-ID: <20220323111131.GA1272756@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfdoAbSTkO7eaor94pkmN0ttLXstc1DS_Sa7i45Dt5GAA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 10:03:38AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 23, 2022 at 4:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Mar 21, 2022 at 01:34:46PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
> > > setting PCI_COMMAND_INTX_DISABLE,
> 
> > > MSI doesn't work either.
> 
> I think this is not correct.

I'd like to make it correct.  What would make this better?  I was
trying to say the same as your original commit log:

  ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is
  disabled.

Bjorn
