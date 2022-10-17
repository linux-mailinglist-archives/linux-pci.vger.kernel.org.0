Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3066005C3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 05:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiJQD14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Oct 2022 23:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiJQD1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Oct 2022 23:27:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7894E401
        for <linux-pci@vger.kernel.org>; Sun, 16 Oct 2022 20:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B32B80E88
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2022 03:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB98BC433B5;
        Mon, 17 Oct 2022 03:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665977268;
        bh=B76Md1fsTGmGZEpKfLKdzasNVKDHaB6HjL2LGNQfVio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QNacxIevMZSpnr9RlN1GUIUqrs459HE9k9j3QaoJNh7Q8Y+Z9QZMHDw6OMaqdc6uR
         fpIeJhaowu6M4wxjQE+SoPc4O8RJ50hMkLzZpxrJ4BhiWk90MEE2ILiSbBkCI9ZdHU
         V9WgaIPoKk4BsrG450lar3XunbEqdaAv9vag4Epa5V3/GYX+vKMNlpBTuxMOnvpgql
         OGso2ikvNkKmV+6EeWrZtcwfhc9V9/qbAHkWFXwNv5z41Zr1QQdK+F745yJ7ZnfrCT
         dTg/KYLtBPzyWX/oldXjukmRfpHCUkhszyuAteubYbR4Y5wMDJwmYKPrCTE6LMdLvT
         K2gOJCwOzVrsw==
Date:   Sun, 16 Oct 2022 22:27:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeffrey <tzeng015@gmail.com>
Cc:     bjorn@helgaas.com, Michael Walle <michael@walle.cc>,
        linux-pci@vger.kernel.org
Subject: Re: [Bug 211105] i210 doesn't work and triggers netdev watchdog
Message-ID: <20221017032746.GA3668382@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-211105-41252-6XGmOSrDLX@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 01:30:43AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=211105
> 
> --- Comment #3 from jeffreytseng (tzeng015@gmail.com) ---
> Here is my question.
> My platform : imx8mm
> Ethernet Control : Intel I210
> Linux version 5.10.72-lts-5.10.y+g22ec7e8cbace (oe-user@oe-host)
> (aarch64-poky-linux-gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2. UTC 2011
> 
> I follow this 
> https://lore.kernel.org/linux-pci/20201230185317.30915-1-michael@walle.cc/
> to add the patch in my platform.
> 
> The issue and problem is still there. Anyone can give me a hand ?
> 
> thank you
> 
> jeffrey

The patch actually merged was slightly different than the one you
mentioned.  The patch 500b55b05d0a ("PCI: Work around Intel I210 ROM
BAR overlap defect") [1] appeared in v5.17.

The best thing (if possible) would be to use a current kernel, e.g.,
v6.0.

If you can't use a current kernel, backport 500b55b05d0a to your v5.10
kernel and test that.

If you still see the problem, there's likely something more going on
that might be a different issue, so please open a new bugzilla and
attach the complete dmesg log and "sudo lspci -vv" output.

Bjorn

[1] https://git.kernel.org/linus/500b55b05d0a
