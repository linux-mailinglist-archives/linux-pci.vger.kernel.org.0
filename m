Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4179CB3C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjILJML convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjILJMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 05:12:10 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED2170D;
        Tue, 12 Sep 2023 02:12:07 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5733d11894dso1155639eaf.0;
        Tue, 12 Sep 2023 02:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509926; x=1695114726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnBKGyRSUKcxckQc3XRY6QVkUrcVLqMdIRsgoISjA1s=;
        b=a6ic7U1j9GLMmGRYt62JbaGNpnUNS/cM4y5wgI6HAO806sZtwcwCLi/bDsa3aUzOrj
         D3M6uYKNOXkUhcO9/LWgTIlWP5xMBgW8EgRDq6nBwkYKX2dgyAPtgUTm4ImvJMxxRgCZ
         4Qofg/3HK5GwsRQSpWc8MFpv7VJLYovmAfPQFfoY9W8ENW61bRLMhrkWlm3nMJyQo2mH
         Ha+vr1PHCkJ3EUsEtCx4TJ0U9jz4jhHMcUI9xRpIGFFGeAWEsHjjtR/ZeD7XEWInZs4z
         s6VysjLLr33xT64VnxM+mng6Go6oxHGqTnzd+/p5x0ibn35HEh0cL8enWFFp7/4Xop3H
         vRRA==
X-Gm-Message-State: AOJu0YyzoL4MEGP84Cox9OxH0yKXLc1Hk+w8hi3D0QDO3MML2lCkXm/p
        oBJKjOdZ9CsR3wMGSuYVT1fCtzrTHNmMKXLaEBE3bkAtj1M=
X-Google-Smtp-Source: AGHT+IGGZJyReIDgrMZtiubQRbMwIKbiT4QSpHxhHeKHsqnI25JjR/27HBwLNz1LdOK9tuR5yIy/TSHHfrPL+PDzg7Q=
X-Received: by 2002:a05:6820:81f:b0:573:3a3b:594b with SMTP id
 bg31-20020a056820081f00b005733a3b594bmr13187897oob.1.1694509926275; Tue, 12
 Sep 2023 02:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230906184354.45846-1-mario.limonciello@amd.com>
 <20230906184354.45846-3-mario.limonciello@amd.com> <CAJZ5v0jgGOPcFMfRObAM1St1KLjZS0tEki4f32Rbr3ZXwFyFzA@mail.gmail.com>
 <0cd6648d-21f1-445d-95f6-20f580bbcfd1@amd.com>
In-Reply-To: <0cd6648d-21f1-445d-95f6-20f580bbcfd1@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Sep 2023 11:11:55 +0200
Message-ID: <CAJZ5v0h0LN1W5Q6Wp-jSJA4QE4ZGurf8Ye26ST5j6W2P+xHCFg@mail.gmail.com>
Subject: Re: [PATCH v17 2/4] PCI: Add support for drivers to register optin or
 veto of D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 10:23 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/11/2023 13:34, Rafael J. Wysocki wrote:
> > On Wed, Sep 6, 2023 at 9:16 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>

[cut]

> >
> > IMV, the underlying issue all boils down to the platform firmware
> > inadequately describing the behavior of the system to the OS.
> > Specifically, had it provided a _S0W returning 0 for the Root Port(s)
> > in question, wakeup signaling would have worked (or else there would
> > have been a defect in the kernel code to be addressed).
>
> I think you're right.  I'll try and get BIOS guys to provide a test BIOS
> to prove this direction is correct.
>
> It wouldn't help all the machines already in the field but if it can be
> done without harm to Windows maybe future SoCs could use it.
>
> > Instead, it
> > decided to kind-of guide Windows in the "right" direction through PEP
> > constraints which doesn't have the same effect on Linux and honestly
> > I'm not even sure if it is a good idea to adjust Linux to that.
> >
>
> What is the worry with bringing Linux in this direction (using constraints)?

First off, ostensibly the purpose of the constraints is to indicate to
Windows when it can attempt to put the system into the deepest power
state.  Specifically, AFAICS, Windows is not expected to do so when
the current power state of a given device is shallower than the
relevant constraint.  Consequently, a constraint of D0 means that
effectively Windows is expected to ignore the given device as far as
Modern Standby goes.

In any case, this has no bearing on the behavior of suspend-to-idle in Linux.

Now, there may be other undocumented side-effects of setting a
constraint of D0 in Windows, but it is generally risky to rely on such
things.

Second, it is not entirely clear to me whether or not the future
versions of Windows will continue to use the constraints in the same
way.

> My main hope is that by generalizing this fundamental difference in how
> Windows and Linux handle Modern Standby / suspend-to-idle we can avoid
> other future bugs.

There is a fundamental difference between Modern Standby and
suspend-to-idle already, as the former is opportunistic and the latter
is on-demand.  They can both follow the exact same set of rules.
