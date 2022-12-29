Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F36590B9
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 20:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiL2THb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 14:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiL2THb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 14:07:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDD14D21;
        Thu, 29 Dec 2022 11:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0007B81A2F;
        Thu, 29 Dec 2022 19:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167A1C433EF;
        Thu, 29 Dec 2022 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672340847;
        bh=0E6p9Y5SUL0q5D3aWHHGlDH8Djpftwh4QIhYzeoCmCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j2rj6t6H8AvOpUSkCfcPqquH0DJX+5k1veIzBZlYJ2X6nAcYObFDa42CAoCmvLxz1
         ZGUTnzDUlehkDKO4T1Xp+MUqwSUadC4vCD6eDiKjeWPnKuiIAlPthNf0dCXt/V9ur3
         YnLiIB75leaL//cH09r+5dOezAlj4xeu0upL1f0tDAT2pKJbgqGSHpC7BFhl/gNwFt
         uHFmMDnlzEbhYPj8p/W99+VIiH3ZGVCt+zAw1QL8GBJZUwNmLvaqL41XCUpJGCE1lz
         Zw3Mduk5o8+KxJhJNQ/jk4PSt7mkh27tOOSfeX30gvc0cNJi8h6oroFzPIstwsPofZ
         Cf5xJE1ZI+6fQ==
Date:   Thu, 29 Dec 2022 13:07:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Lee, Ron" <ron.lee@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lmajczak@google.com" <lmajczak@google.com>,
        "Jain, Rajat" <rajatja@google.com>,
        Ron Lee <ron.lee.intel@gmail.com>
Subject: Re: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Message-ID: <20221229190725.GA620646@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3457C04B0BF3E0F06A8607F2FEEA9@BL0PR11MB3457.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022 at 09:11:31AM +0000, Lee, Ron wrote:
> > On Fri, Dec 16, 2022 at 04:29:39PM +0000, Lee, Ron wrote:
> > > > On Thu, Dec 15, 2022 at 05:13:57PM +0800, Ron Lee wrote:
> > Even if you haven't seen a battery life issue, I suspect you might be 
> > able to measure a power consumption difference if you looked for it 
> > and likely could see issues with manual ASPM enable/disable using 
> > sysfs.  That might be a legitimate reason for this quirk, and if
> > it is, we should mention it here.
>
> We can arrange the power measurement, but I doubt this quirk has
> correlation to power consumption.  My point is that the ASPM
> behavior is not changed with or without this quirk.

Makes sense.

> ...
> I agree that, I ever try to recover the link by traversing list, but
> it didn't work and the capability list have no method to do reverse
> traversal.  One approach may save the whole capability list before
> suspend, and check each capability link then restore the missing one
> after resume.  Do you think it's practical ? It is appreciated if
> you could recommend a practical solution for this issue.

The issue being "lspci doesn't show L1SS after suspend/resume"?

Is the point of this basically to fix lspci output after
suspend/resume?  Or is there something else this fixes?

It sounds like ASPM and L1SS works correctly after suspend/resume
even without this patch?

Bjorn
