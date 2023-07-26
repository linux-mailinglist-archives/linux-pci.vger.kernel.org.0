Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C028763527
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjGZLif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjGZLib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 07:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557D271C;
        Wed, 26 Jul 2023 04:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0579D61A9C;
        Wed, 26 Jul 2023 11:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CA7C433C7;
        Wed, 26 Jul 2023 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690371506;
        bh=CHprntFsUW0Tpu+h/NGAWXoYhfcj0+JfF4AI7ZXGsPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKCtsZ1RsbBj4ruef3bITkBwWNl4v8DkD9WiP/2l5vSdboMlHwHYU03CFXv4Ryvu7
         4cwB5z9au7SqFgXzqfArJJgVjUVlHULHb18M60wlyiluQKAVnmCbb9uyJuiZRyAPId
         z6dKUaLxwcumkCFA82/XYM2+D0eyc7l3zRgoY4Rc=
Date:   Wed, 26 Jul 2023 13:38:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Message-ID: <2023072657-unloved-magma-8cf2@gregkh>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
 <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
 <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
 <61bbb2e6-8c18-d2fc-ce1e-78d462ac1bba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bbb2e6-8c18-d2fc-ce1e-78d462ac1bba@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 10:54:01PM +0800, Jiaqing Zhao wrote:
> On 2023-07-20 18:40, Marc Kleine-Budde wrote:
> > On 20.07.2023 10:28:59, Jiaqing Zhao wrote:
> >> Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
> >> Controller to pci_ids.h for its serial and parallel port driver
> >> support in subsequent patches.
> > 
> > Sorry, I haven't noticed the change in "include/linux/pci_ids.h", that
> > the other patches depend on. How to coordinate among the subsystems?
> > 
> > I don't mind taking the entire (v1) series with the Acks from the
> > tty/serial and parport maintainers, or give my Acked-by to upstream
> > via their trees.
> 
> Add tty and parport maintainers to this thread.
> 
> I'd like to ask other maintainers' opinion as I'm not sure which option
> is better and I had no similar experience before. 

Either is fine with me, I can just take them all through my tty tree as
that's simplest for me :)

thanks,

greg k-h
