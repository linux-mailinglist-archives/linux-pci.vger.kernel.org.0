Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89155657647
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 13:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiL1MDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 07:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiL1MCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 07:02:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E391117C;
        Wed, 28 Dec 2022 04:02:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAC56136E;
        Wed, 28 Dec 2022 12:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64417C433D2;
        Wed, 28 Dec 2022 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672228970;
        bh=5Bd3zMjZAewW/p8wjYOYc0CriDNUHTxPbfCTyOTPMLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LOyITuzVxs0x4RH2AteBsnoqIsUuxB0AML0WMGf2Pz8/4mpKjfXtjAlTqTKwEMZay
         H8HyVU+Vds/JcILXsQ7fk9qug8Q+8rk0WemQGbQtUTm2eW/PWvWVsVbJWdbskIcvS3
         6ja76Kh/HjaRfifc6lHXs6u1L1ToGulOb7lB14Cf234CXaJBbElPan+QugfY4JHeMf
         YcF2nxxtSKglqBmjejRuS5FrVZQUaKSJ3kU7n48R2ekGPbS5SQvwRTeVfmnpYcofPj
         qrfkXSSv3Lt2xMfynI1KCo55RDwci4rSRdrBXlLXWsJaBTZj9aQZeF7IMLlQgsJbJI
         6rQNvVMeh9s1g==
Date:   Wed, 28 Dec 2022 06:02:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Zeno R.R. Davatz" <zdavatz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
Message-ID: <20221228120248.GA508080@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216859-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, linux-kernel]

On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216859

>            Summary: PCI bridge to bus boot hang at enumeration
>     Kernel Version: 6.1-rc1
> ...

> With Kernel 6.1-rc1 the enumeration process stopped working for me,
> see attachments.
> 
> The enumeration works fine with Kernel 6.0 and below.
> 
> Same problem still exists with v6.1. and v6.2.-rc1

Thank you very much for your report, Zeno!

v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
"ignore_loglevel initcall_debug" kernel parameters and taking a photo
when it hangs?

How did you conclude that the hang is related to a PCI bridge?  I see
recent PCI messages in the photo, but it looks like the last message
is from NFS, so I'm wondering if I'm missing some context.  The v6.0
dmesg shows several other ntfs, fuse, JFS, etc messages before more
PCI-related things.  Anyway, the "initcall_debug" might help us narrow
it down a bit.

Bjorn
