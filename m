Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139A063F140
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiLANKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 08:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiLANKK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 08:10:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6F9E46F
        for <linux-pci@vger.kernel.org>; Thu,  1 Dec 2022 05:10:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so1968410pjd.5
        for <linux-pci@vger.kernel.org>; Thu, 01 Dec 2022 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7Y2FkbIVTKFtl+HxieOmsxNGhmLoxEmtYJ88v/cdgw=;
        b=Sxbi0cvSliG9a00Ry4hRL3209ix85X2kIBcjhC5k1nEv5BOdHhFeI7Ixds0JdL6dZ6
         7K72xHH++bcFQ6L4GeTVOnVIGmY3VxFsiE1PwDgAbEFd1Qg/8JsKJA/ZZABySB5cfN5I
         rXB/aOLFPlnEkVyBmH4j/VAB0BH/L38J6evN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7Y2FkbIVTKFtl+HxieOmsxNGhmLoxEmtYJ88v/cdgw=;
        b=2mYvfyK8cOj3WmJtkwS86j6YZCZbYyALkT4mEknTTtVPxyJ1fIyQ8Y9H4GP8L90y3H
         baA/rEURIeGm+3PSLD92etvO2TAwtbKBI8UD7kYuy0KntKi6eTVCeFQ0h/IzLqiVY57f
         0u5gQx2mfMX4tq1qms8kqLHFC3DH740JaWReCZS4LBSU0JdaB9qbKPQkC6//Lso+zuLR
         EO4Iw95kcsrleVR1kfDGaJThd8JpyjDMKHg+3C3JTbcbSrROMROSMeAHsq/uETPWtnql
         aVnZL4iQ1Zy1mZk0IprDO4Er7dGUGSJEWKRaeYGBWbw2ABBA9+T3U76EVVfu8UQfUuJy
         +Nqw==
X-Gm-Message-State: ANoB5pkXPa5iFnjvTYgL240V9C3P7M3hiVlZfaiujyPOCy1hSSBGMkca
        buF58/sNJIR3/IuW1uLgjAwn/jwRNZzrn5XK
X-Google-Smtp-Source: AA0mqf4njiNnQpRffOLGHeEgfnyWbRKbn1Dbxyk3pkZjWmAzaLXhwm/r9MI58zlWjtTJ7g8ykiuskA==
X-Received: by 2002:a17:90a:bd86:b0:213:8cf1:4d9d with SMTP id z6-20020a17090abd8600b002138cf14d9dmr71447317pjr.5.1669900205653;
        Thu, 01 Dec 2022 05:10:05 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b00189b2b8dbedsm1585476plh.228.2022.12.01.05.10.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:10:05 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id 21so1821248pfw.4
        for <linux-pci@vger.kernel.org>; Thu, 01 Dec 2022 05:10:05 -0800 (PST)
X-Received: by 2002:a05:6e02:66d:b0:303:1196:96c7 with SMTP id
 l13-20020a056e02066d00b00303119696c7mr9848943ilt.133.1669899845427; Thu, 01
 Dec 2022 05:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
 <20221127-snd-freeze-v8-3-3bc02d09f2ce@chromium.org> <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
In-Reply-To: <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 1 Dec 2022 14:03:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com>
Message-ID: <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>,
        Chromeos Kdump <chromeos-kdump@google.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Oliver

Thanks for your review

On Thu, 1 Dec 2022 at 13:29, Oliver Neukum <oneukum@suse.com> wrote:
>
> On 01.12.22 12:08, Ricardo Ribalda wrote:
> > If we are shutting down due to kexec and the userspace is frozen, the
> > system will stall forever waiting for userspace to complete.
> >
> > Do not wait for the clients to complete in that case.
>
> Hi,
>
> I am afraid I have to state that this approach is bad in every case,
> not just this corner case. It basically means that user space can stall
> the kernel for an arbitrary amount of time. And we cannot have that.
>
>         Regards
>                 Oliver

This patchset does not modify this behaviour. It simply fixes the
stall for kexec().

The  patch that introduced the stall:
83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers
in .shutdown")

was sent as a generalised version of:
https://github.com/thesofproject/linux/pull/3388

AFAIK, we would need a similar patch for every single board.... which
I am not sure it is doable in a reasonable timeframe.

On the meantime this seems like a decent compromises. Yes, a
miss-behaving userspace can still stall during suspend, but that was
not introduced in this patch.

Regards!
>


-- 
Ricardo Ribalda
