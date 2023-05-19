Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0983709419
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjESJwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjESJwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 05:52:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282C19A;
        Fri, 19 May 2023 02:52:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7576deacbd6so157946785a.3;
        Fri, 19 May 2023 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684489922; x=1687081922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYlFoKtA5IkPlUC08PPhE1HRAZ9SjNGPuMwfpP8csYw=;
        b=nYxSjSYcaXL9wBLYYxr18nPzFhoS6t/XMYh9wWv4olQ5Ajdh0ltDPhpnV6tMT0kw2L
         7PVzfD8g+760Xthp7t3msGPUjuZ59gQw4rwzaEmCtQ8hyGpsue8N+xUoLitFBMGgdB9W
         jVGc5vSq1XyykVvXwliYjJhs52PRT3SjBYJ7iwE5d7/KP6vVYRumAVbxhCiJ5soKreN4
         brAcrHDbctTGfUlLlmhxftAZM3pPIDGyFEnEQC4iY77FwsJnKWjlVhqa4CFYiyr2O4Qf
         7YR2QIMjUYV5AhK5aiXR9mtSexGX2S4hbthpMwYW3yJ58fFaMoJ96fz6odyG79IA5mY6
         tJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489922; x=1687081922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYlFoKtA5IkPlUC08PPhE1HRAZ9SjNGPuMwfpP8csYw=;
        b=jzs4CRdNuMvvpVjlEsvABhNf/hd/SQOozSPbu7zEhjHJsXaSTgEY1NVRbcn32kQVMd
         r4NFT0N+Z83rCfQpL5qrTdFS0whkD9GLpXf7XiUoG58wLRwNNlJSH7jnMw1R7u5ORLB0
         /kDjQQE31Dj1VHUQX3OLnVUtXlFH82OExycj41hUIgpM2JhBdkljk2p4FplgcdYNKGVd
         x8AjpaJp1kXbkyBVRSXUBZNS2kfT/vZUEQwoUVOs5NXR/dF1qQdfdnDNSlXj9qy5imk5
         T47F8d44zEI0STbX4bHKeWqxRCWmuK1sZhVLOurVn73nWCO1dXxqsXlHlpq1VeB83vLf
         fARQ==
X-Gm-Message-State: AC+VfDzvpE66CBK9U06xNWbHF+UNFIqy7k5DzX4f4eW6dacblK2nG5wQ
        +JbBo/BM8JtE3UqJkjyDyPtvk0pewktLgM8BZqos4ia5u/wBBQ==
X-Google-Smtp-Source: ACHHUZ5LXB2GGpTth50QwGaF1r9ATLp3VHmm5/m7EW57RPp9upvSN9LQS14BGDeYC2Kr+/Vi0wX8BeWxerm5Q629S9k=
X-Received: by 2002:a05:6214:5183:b0:61a:fe65:4481 with SMTP id
 kl3-20020a056214518300b0061afe654481mr2595650qvb.51.1684489921968; Fri, 19
 May 2023 02:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516193549.544673-1-arnd@kernel.org> <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
In-Reply-To: <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 May 2023 12:51:25 +0300
Message-ID: <CAHp75VeX9=1+apLMZsidudUziO_s4WUb=HOd0mraRHL17DN+cw@mail.gmail.com>
Subject: Re: [PATCH 00/20] x86: address -Wmissing-prototype warnings
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 12:56=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
> On 5/16/23 12:35, Arnd Bergmann wrote:

> I picked up the ones that were blatantly obvious, but left out 03, 04,
> 10, 12 and 19 for the moment.

Btw, there is series that went unnoticed

https://lore.kernel.org/all/20211119110017.48510-1-andriy.shevchenko@linux.=
intel.com/

I dunno why.

--=20
With Best Regards,
Andy Shevchenko
