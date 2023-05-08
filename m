Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430EF6FAC9B
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEHL00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjEHL0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 07:26:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D913D579;
        Mon,  8 May 2023 04:25:55 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDB8F1EC0373;
        Mon,  8 May 2023 13:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683545147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qEahm5dZvg8BbQzlkKofs7zlW9wKammczlgPYB9vg+I=;
        b=BOiPsEz7jZr10r3KOxpglblLTPrIHI+Pc9qP69CwB6q3oqJN7h3ZjlhGrw3tljBucKYYmb
        tY16fF7hlH13beJG4aN+SeluoJcwZmgdLXJbhACcPgsliHroTwPOt1w8a1HiFJWJTkXcgF
        KLxJUrMxKqPjpvgDSgdJz+NzluStpfs=
Date:   Mon, 8 May 2023 13:25:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 01:13:14PM +0200, Thorsten Leemhuis wrote:
> Which afaics means that users of -rc1 are now affected by this and might
> waste time bisecting a known issue that could easily have been fixed
> already. :-/ That doesn't feel right. Or am I missing something?

-rc1 is pretty much the most broken tree there is. And it is not an
officially released tree but a, well, the first release candidate. So
fixes are trickling in, there's lag between what gets found, when the
maintainers pick it up and when it ends up upstream and so on and so on.

Some fixes need longer testing because there have been cases where a fix
breaks something else.

And yes, maintainers can always expedite a fix or Linus will pick it up
directly if it breaks a lot of boxes in a nasty way.

So, long story short, I don't think you should track -rcs. You are
tracking the reports already and you're tracking where their fixes land
so I guess that's good enough.

> /me wonders I he should start tracking regressions more closely during
> the merge window to catch and prevent situations like this...

I don't see a "situation" here. rcs can be broken for some use cases and
that is fine as long as that breakage doesn't get released.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
