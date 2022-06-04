Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75A053D895
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jun 2022 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiFDU7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241691AbiFDU7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 16:59:52 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC0C2EA02;
        Sat,  4 Jun 2022 13:59:51 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m82so14718677oif.13;
        Sat, 04 Jun 2022 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI6RGgIhUb5YBMG55dVRTWwDyzqgJYFjmLT32LzTyec=;
        b=RiacRFTuIoy4aVBfEZrTyG66uLRmj9OfCmEl/WuQwTeFWFmZ4Mxro4WNyWuLyV2EPx
         S75BJVmJqFX8ukcsTmAoWQt90Z/50rhY3/nlbHq6pGx6qmE0uL71WOpZCV3irLXgwIKN
         55bq0njQaVnM8q6/Kao0GedXeCqtyHm19X842+J+ExQJpLQZcab2tRB9iNfJ2PeDMB+0
         fzY4Uzp27QUefOdaGCOscgnKEzFGzj8c/JO+7v9ARQGTtzKd5Ixpccnrn3vbb+f2ODOd
         KA3VEqwrOg2ZSMHPhLWuKzikO/boV8bJOuZxoAw8lTUgO/zK3C852XwfSVoU01JLjTHH
         EeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI6RGgIhUb5YBMG55dVRTWwDyzqgJYFjmLT32LzTyec=;
        b=u2MSxJvZRFcWfzXnZgnGcljLRXqCYrlmVZcmPhr73viKAot3BhZa46Yudngl8VQ3Td
         qjqTqg7sAgzKvVF/uiejniEXjbeeLZzoqQNRSPl33nIiiRaoGJZeo94SQz3tL1DQIG2D
         jfUNqbDd+ZeQEYjcVlqx2yRscOqNDbUzJsBsCkEiLZm5B2q2mEhPi0m7j5HcUIfnE6mp
         96HGc2hZGf50rAaPg6Cegj8pPt+hNQyCHFHPhJGasniWP8YaaVzjZBvDFn+5gpFewOVM
         DKEEndvK4Pg/tR3xy2J6MjMlosSUMacsHaDWGvR0nivSh/Z6o2b6Ps1MCduIl3lKlZ37
         wLwA==
X-Gm-Message-State: AOAM530timdxC7TybJ4crnk+oyxK3efJl4XeXv8U2dCoIjgHuz9i78v5
        Kxplmvi13tkjBGHUtyckdfd3IRa7OMLYgliZ1Iw=
X-Google-Smtp-Source: ABdhPJyS9SfYWhqaqd9DsHNCl2ttCA2tBW6F6m6Ie8I696MCMDnp3HkpP5GVvz/LETbkY4wRdLJz3WN+i/XBOxt6ywU=
X-Received: by 2002:a54:4688:0:b0:325:9a36:ecfe with SMTP id
 k8-20020a544688000000b003259a36ecfemr9982724oic.96.1654376390812; Sat, 04 Jun
 2022 13:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220528224423.7017-1-jim2101024@gmail.com> <20220528224423.7017-2-jim2101024@gmail.com>
 <20220529011526.4lzuvkv5zclwntce@mraw.org> <d7a5a0d8-5d27-548f-bc94-0e7d116cc3f2@i2se.com>
 <20220602191757.pqictbfarmvlf72f@mraw.org>
In-Reply-To: <20220602191757.pqictbfarmvlf72f@mraw.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Sat, 4 Jun 2022 16:59:39 -0400
Message-ID: <CANCKTBvvm-1TOKh1akzAYoiOeu5cTKLXyy6PPRkWbOAOtpjARA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 2, 2022 at 3:18 PM Cyril Brulebois <kibi@debian.org> wrote:
>stm32mp157c-ev1.dts
> Hi Stefan,
>
> Stefan Wahren <stefan.wahren@i2se.com> (2022-05-30):
> > i think we should better trust the results based on the v5.18 tag. During
> > the merge window, regressions from other subsystems are possible.
>
> Alright, that looks like a great plan.
>
> Before getting your answer, I had tried taking the reboot part out of
> the equation, but I found out that even cold boots might fail with the
> mmc storage.

Hi Cyril,

FWIW, I can deliberately reproduce the errors you observed by using an
incorrect "interrupts" property for
the sdhci device's DT node.  It can also be triggered by removing its
"clocks" property.

However, if I do one of the above,  the error will occur on every
boot, but in your case (I think) you are seeing it
sporadically.  So that is peculiar.  I've looked at the recent
upstream commits for changes in the  sdhci driver
and also the relevant DT node and do not see anything obvious that
might cause this.

BTW,  when you observe this error, can you please do a  "cat
/proc/interrupts" and post the results?

Thanks & regards,
Jim Quinlan
Broadcom STB


>
> I haven't been able to conduct a systematic testing of the patch on top sdhci driver or the relevant
DT node
> of the v5.18 tag yet (say, 10 or 20 cold boots, and the same with
> reboots) due to strong work constraints these past few days, but that's
> definitely still on my short term todo list (hopefully before the end of
> the week).
>
> Sorry I didn't manage to get that lined up before Bjorn's pull request.
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant
