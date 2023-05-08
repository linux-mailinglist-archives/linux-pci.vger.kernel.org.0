Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5A6FB17E
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjEHN2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjEHN22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 09:28:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FBC33FCC;
        Mon,  8 May 2023 06:28:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so3106387a91.0;
        Mon, 08 May 2023 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683552485; x=1686144485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJL7on47Y+qnReWK+RN8hsZ4/lRT/GdxonZVZJkZNFc=;
        b=L0wSaMX47AxHW+5mwIPiPG/LQyY070h6LJllIePcS0Sv63IYnmEKAxprG7ulLTB+bH
         Bi04krbmZ+1+aUPcvtl38Rf+WNUx2fuZje/fD6QlJ67/Kc5/1U6kkA7vqW/KJ//OBLHV
         bwKg2UF6Gl5ahTvzQSjbAi3IpW0EGnxZ27tXmzgk8bokLmeEZTQitq+Yf30EBJ65kBqC
         pMytV3CruCfrvMZWAx4uGdYJYC75WEjWjnUQZN6eqf4f79g68YqPLCOBfMBuFwfALXr+
         m+CSnYPXFzT2O8djZ58xoWOKYQM0gYAssrTjzx23YiE2o4aiiUxGjrsLsVIVHNLsKnwj
         xf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552485; x=1686144485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJL7on47Y+qnReWK+RN8hsZ4/lRT/GdxonZVZJkZNFc=;
        b=D6/WkAGlDAmmxQFoAGTucFpX48Cb0Y8Qj7V5NfL93PWKpm8WuwixNm35bKSx6nesq0
         h3QFXQw4xcKrVXGNwqI2ZSP8zvK/kV+wwuJH4PEn28EBMCVYooxJkjaekSHC4v21LLPx
         EQGUcwOXEcP5RWWQkaBYVz0wJHXQo7ShxQNuu61/2Hk0AOFkn79/2FsfePwB7aweB0/q
         wlKVbhInSudAqZlsikgkGJjx9dc8VIsziF0HaxnXTigvH+BFHpaiY7ahBeB1U9GP7o7r
         BBIzbF8jplqJ5d+ctH3xoSBiWWlosg2EKIpfoMcAi+Di94pUJUJUxXtBpjJjTiFl8S10
         fRlw==
X-Gm-Message-State: AC+VfDx16dhtlHpdiuvLBvVTiKoO0Le2xnF8bVkd3yGjCftWItuCQXo5
        1hD6EXmYoJ9uuYkW6/26TcM=
X-Google-Smtp-Source: ACHHUZ7SfPi65V3zWt309n46kENPv3m7W6VlKo6duJegzYEYg4ZrHDn5RTJrY1k/8sJlgWcvVxtxpg==
X-Received: by 2002:a17:90b:a48:b0:24d:f2f5:f571 with SMTP id gw8-20020a17090b0a4800b0024df2f5f571mr10606107pjb.36.1683552485567;
        Mon, 08 May 2023 06:28:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fs9-20020a17090af28900b002470f179b92sm9869455pjb.43.2023.05.08.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:28:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 May 2023 06:28:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Mario Limonciello <mario.limonciello@amd.com>,
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
Message-ID: <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
 <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 01:25:43PM +0200, Borislav Petkov wrote:
> On Mon, May 08, 2023 at 01:13:14PM +0200, Thorsten Leemhuis wrote:
> > Which afaics means that users of -rc1 are now affected by this and might
> > waste time bisecting a known issue that could easily have been fixed
> > already. :-/ That doesn't feel right. Or am I missing something?
> 
> -rc1 is pretty much the most broken tree there is. And it is not an
> officially released tree but a, well, the first release candidate. So
> fixes are trickling in, there's lag between what gets found, when the
> maintainers pick it up and when it ends up upstream and so on and so on.
> 
> Some fixes need longer testing because there have been cases where a fix
> breaks something else.
> 
> And yes, maintainers can always expedite a fix or Linus will pick it up
> directly if it breaks a lot of boxes in a nasty way.
> 
> So, long story short, I don't think you should track -rcs. You are
> tracking the reports already and you're tracking where their fixes land
> so I guess that's good enough.
> 

I absolutely disagree. Without Thorsten's tracking, Linus would have no
idea what the status of the kernel is.

> > /me wonders I he should start tracking regressions more closely during
> > the merge window to catch and prevent situations like this...
> 
> I don't see a "situation" here. rcs can be broken for some use cases and
> that is fine as long as that breakage doesn't get released.
> 

Again, I disagree. The whole point of testing release candidates is to get
problems fixed. If issues are not fixed timely, they just pile up on top
of each other and make it difficult to identify new issues (and, in many
cases, to test the kernel in the first place).

I find it quite annoying that problems are identfied, often even in -next,
the patch intoducing them is applied to mainline anyway, and then
it sometimes takes until -rc5 or even later to get the fix applied (even if
the fix has been known for weeks or even months). It sometimes even takes
Linus' intervention to get fixes applied to the upstream kernel. That
really should not be necessary. Telling those who track regressions
to stay away from release candidates is absolutely the wrong thing to do
and would only serve to make release candidates quite pointless.

v6.4-rc1 is a good example. Fixes for all build breakages were published
before the commit window opened, yet at least one of them did not make
it into -rc1. Together with this patch there are now at least two
regressions if -rc1 whch could have been avoided and may impact testability
on affected systems.

Guenter
