Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551F96427FE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLEMFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiLEMFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 07:05:53 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B8DF55
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 04:05:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f9so10301391pgf.7
        for <linux-pci@vger.kernel.org>; Mon, 05 Dec 2022 04:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=je642uC/QM2q2uiJ455cWQgJTQZ2s2VIKEuHkYSqLSY=;
        b=FEmiEyAfYIdpKkVVrcM2myJBq9Gd26hAz6+4yOpADnvfMVE0aPesCBgx342rXF08lp
         TCQyXF8GkzmtS6Z9YrWkolPOItK1xsEU+96tzXEDb1AlyAmzgDCo23jDO4Kl30xB1XIr
         tkvIYPgXOQR4RxorORzC5LorpFYswRYs8vLVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je642uC/QM2q2uiJ455cWQgJTQZ2s2VIKEuHkYSqLSY=;
        b=BbAVPdJBDsZj61mwXfCnCS0WIBc8NkE80lPMJtoEYVOkEy+irwoVRqBjuhYsjxy/EN
         AWqspjAJA5geDfWy9OGDxYN2r0woJ1J59kqPg6yjkYYEF//1YtqcTVlIQYKV0Ectf+Ny
         GqKSL+0x1mzckdzrlP7HMR2J19CHjNTRiW9lHIV8ke67mqDMzcFOl8ZbU/KeV/Wqpz/U
         DRkCXEPsfnjxHIxln0x83AK7q3Cumq9b62J0E14LvSPjbaJLEReBFl2DBzXIDGIPJmAK
         LbBw2TlziOu1h0nQw2EeZS9zBokgVzqnfcwk1jSwwI5R4J2TdzH3n1+XMSoku3wuVbJJ
         kGGg==
X-Gm-Message-State: ANoB5pnjjBLoDChmpyskpW/NzdiBFlvyX+qHVrga/02MNWoppAZtt85i
        ib+qAPlJsdOYxrvNWrWNn8MlzTK0hKDR9sRJ
X-Google-Smtp-Source: AA0mqf4klNLB96IOX0K2ZFxfwCWv+NDL2lBdX/2hhH5CGbmnYQajuUyR47n2zz8oYRNqqBE25IzXsQ==
X-Received: by 2002:a05:6a00:22ca:b0:56e:64c8:f222 with SMTP id f10-20020a056a0022ca00b0056e64c8f222mr86036094pfj.71.1670241952278;
        Mon, 05 Dec 2022 04:05:52 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001891b01addfsm10369740plg.274.2022.12.05.04.05.51
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 04:05:52 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3302558pjj.4
        for <linux-pci@vger.kernel.org>; Mon, 05 Dec 2022 04:05:51 -0800 (PST)
X-Received: by 2002:a17:902:7d93:b0:186:9cf4:e53b with SMTP id
 a19-20020a1709027d9300b001869cf4e53bmr68703080plm.50.1670241940337; Mon, 05
 Dec 2022 04:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
 <20221127-snd-freeze-v8-2-3bc02d09f2ce@chromium.org> <CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn=-Om5QP2-7ocuGdq8R9w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn=-Om5QP2-7ocuGdq8R9w@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 5 Dec 2022 13:05:29 +0100
X-Gmail-Original-Message-ID: <CANiDSCt2+2EQpXvgQqTA3VwbfwDb=BsXn_YNcc05GK9xdTpVkA@mail.gmail.com>
Message-ID: <CANiDSCt2+2EQpXvgQqTA3VwbfwDb=BsXn_YNcc05GK9xdTpVkA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] freezer: refactor pm_freezing into a function.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>,
        Chromeos Kdump <chromeos-kdump@google.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Takashi Iwai <tiwai@suse.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        kexec@lists.infradead.org, alsa-devel@alsa-project.org,
        stable@vger.kernel.org, sound-open-firmware@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael

On Fri, 2 Dec 2022 at 18:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 1, 2022 at 12:08 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Add a way to let the drivers know if the processes are frozen.
> >
> > This is needed by drivers that are waiting for processes to end on their
> > shutdown path.
> >
> > Convert pm_freezing into a function and export it, so it can be used by
> > drivers that are either built-in or modules.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Why can't you export the original pm_freezing variable and why is this
> fixing anything?

Because then any module will be able to modify the content of the variable.

The Fixes: is because the last patch on the set is doing a real fix.
If you only cherry-pick the last patch on a stable branch, the build
will fail. (Also, the zero-day builder complains)

Anyway, I think we can hold this patch for a bit. The snd people are
discussing if this the way to handle it, or if we should handle
.shutdown in a different way.

Thanks!


>
> > ---
> >  include/linux/freezer.h |  3 ++-
> >  kernel/freezer.c        |  3 +--
> >  kernel/power/process.c  | 24 ++++++++++++++++++++----
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > index b303472255be..3413c869d68b 100644
> > --- a/include/linux/freezer.h
> > +++ b/include/linux/freezer.h
> > @@ -13,7 +13,7 @@
> >  #ifdef CONFIG_FREEZER
> >  DECLARE_STATIC_KEY_FALSE(freezer_active);
> >
> > -extern bool pm_freezing;               /* PM freezing in effect */
> > +bool pm_freezing(void);
> >  extern bool pm_nosig_freezing;         /* PM nosig freezing in effect */
> >
> >  /*
> > @@ -80,6 +80,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
> >  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
> >  static inline void thaw_processes(void) {}
> >  static inline void thaw_kernel_threads(void) {}
> > +static inline bool pm_freezing(void) { return false; }
> >
> >  static inline bool try_to_freeze(void) { return false; }
> >
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index 4fad0e6fca64..2d3530ebdb7e 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -20,7 +20,6 @@ EXPORT_SYMBOL(freezer_active);
> >   * indicate whether PM freezing is in effect, protected by
> >   * system_transition_mutex
> >   */
> > -bool pm_freezing;
> >  bool pm_nosig_freezing;
> >
> >  /* protects freezing and frozen transitions */
> > @@ -46,7 +45,7 @@ bool freezing_slow_path(struct task_struct *p)
> >         if (pm_nosig_freezing || cgroup_freezing(p))
> >                 return true;
> >
> > -       if (pm_freezing && !(p->flags & PF_KTHREAD))
> > +       if (pm_freezing() && !(p->flags & PF_KTHREAD))
> >                 return true;
> >
> >         return false;
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index ddd9988327fe..8a4d0e2c8c20 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -108,6 +108,22 @@ static int try_to_freeze_tasks(bool user_only)
> >         return todo ? -EBUSY : 0;
> >  }
> >
> > +/*
> > + * Indicate whether PM freezing is in effect, protected by
> > + * system_transition_mutex.
> > + */
> > +static bool pm_freezing_internal;
> > +
> > +/**
> > + * pm_freezing - indicate whether PM freezing is in effect.
> > + *
> > + */
> > +bool pm_freezing(void)
> > +{
> > +       return pm_freezing_internal;
> > +}
> > +EXPORT_SYMBOL(pm_freezing);
>
> Use EXPORT_SYMBOL_GPL() instead, please.
>
> > +
> >  /**
> >   * freeze_processes - Signal user space processes to enter the refrigerator.
> >   * The current thread will not be frozen.  The same process that calls
> > @@ -126,12 +142,12 @@ int freeze_processes(void)
> >         /* Make sure this task doesn't get frozen */
> >         current->flags |= PF_SUSPEND_TASK;
> >
> > -       if (!pm_freezing)
> > +       if (!pm_freezing())
> >                 static_branch_inc(&freezer_active);
> >
> >         pm_wakeup_clear(0);
> >         pr_info("Freezing user space processes ... ");
> > -       pm_freezing = true;
> > +       pm_freezing_internal = true;
> >         error = try_to_freeze_tasks(true);
> >         if (!error) {
> >                 __usermodehelper_set_disable_depth(UMH_DISABLED);
> > @@ -187,9 +203,9 @@ void thaw_processes(void)
> >         struct task_struct *curr = current;
> >
> >         trace_suspend_resume(TPS("thaw_processes"), 0, true);
> > -       if (pm_freezing)
> > +       if (pm_freezing())
> >                 static_branch_dec(&freezer_active);
> > -       pm_freezing = false;
> > +       pm_freezing_internal = false;
> >         pm_nosig_freezing = false;
> >
> >         oom_killer_enable();
> >
> > --
>
> --
> You received this message because you are subscribed to the Google Groups "Chromeos Kdump" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-kdump+unsubscribe@google.com.
> To view this discussion on the web, visit https://groups.google.com/a/google.com/d/msgid/chromeos-kdump/CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn%3D-Om5QP2-7ocuGdq8R9w%40mail.gmail.com.



--
Ricardo Ribalda
