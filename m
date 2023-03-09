Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A610A6B3180
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCIWzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 17:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjCIWzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 17:55:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0908279B3
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 14:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0E20B81FBF
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 22:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909EBC433D2;
        Thu,  9 Mar 2023 22:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402504;
        bh=AkOvu9LcEwc+YqMlebz2cGPWc3eeP/jhPYKflGPGKNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TeaTtsiAtXo9x4Ls/bhbRhHBvtVf8+aYv+x2bsFtsRKD6q0i8tNQBrWl6qT7vfGLk
         mINXTwOSBcGz8Dz/+qbyUirS6uQqjQUfUPnvrf9TcXcg9CgMuqJ8VFG1+/abI9kvKF
         GpVif1slcPaAhLxdWU1cdU5waccnB07Px6qtuElz2XH8jIozMNN/72WoRmIb9gt5sq
         aBRGRht/U+34fUjSrdHovYz9Vu0Fn0PqkxNU6IQDqGRSmZg3H94x0D7hvWJQ0H4XjP
         JQVRHPe9A8nbItdDvO7x/f8sQ2Gc19v+54VRAi2HkrY1Amzfn+Qx2IfkwHHM9kh79z
         /K3lMc/GZ/adQ==
Date:   Thu, 9 Mar 2023 16:55:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     rec <gael.seibert@gmx.fr>
Cc:     linux-pci@vger.kernel.org
Subject: Re: The MSI Driver Guide HOWTO
Message-ID: <20230309225503.GA1183984@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MLARBPED.KOE2RCSK.CBFLK3MD@C6JAKXCV.NCSTNY5B.ZJHT73MJ>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 09, 2023 at 10:57:51AM +0100, rec wrote:
> On 09/03/2023 00:03:04, Bjorn Helgaas wrote:
> > On Tue, Mar 07, 2023 at 12:22:44PM +0100, rec wrote:
> > > Like asked in : https://www.kernel.org/doc/html/latest/PCI/msi-howto.html#disabling-msis-globally
> 
> > Thanks for the report!  I assume this means your system has problems
> > with MSIs, and booting with "pci=nomsi" makes it work better?
> 
> You are welcome,
> The system doesn't boot completely without the "pci=nomsi" option.

What exactly do you mean by "it doesn't boot completely"?  I compared
the two dmesg logs, and I see that the "with MSI" log also has the
"single" parameter, so it will only boot to single-user mode.

The "pci=nomsi" log does not have "single", so it will boot normally.

But I guess if you omit both "single" and "pci=nomsi", something still
goes wrong?  Do you have a log for that case?

Bjorn
