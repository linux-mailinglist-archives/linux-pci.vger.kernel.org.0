Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E735141207
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgAQUB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 15:01:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34366 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQUB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 15:01:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so23287044oig.1;
        Fri, 17 Jan 2020 12:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtLR19hFs+LsyK9KKDc5U1EMy+Rsoybh1tO8OYgc20U=;
        b=OBErEIy85vDSePoCzZvgSPRQLShCO3QAVhGIorrjIQXQN/W3AgaJYZrvDmALxj4MbA
         Uw0PmB5IwUsueDXgJNCyGqyAacdZOhWyZgQN1ClMsxqfiTLBR+KnCa9bi3Ertbd2T5Gr
         v6+zgoh+1cUbZGTYnGmzd5bB7H/5m9yMF8cMoKZ5YBg+cCCLxq2ApcvP/iGvDERe6t0W
         f1eAgsSuU9IqxX1ULYiSsX7BxdGJX7nt6sjwVuIn8+rlA94p8x6vkiht2g0v+d3eZdrC
         655KhkwVDK6tm6mpu0Thw0DgCmSCixG6LDG9VRYGAcbo5qza5gsrIUWG7f+VNFs1a1eL
         NK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtLR19hFs+LsyK9KKDc5U1EMy+Rsoybh1tO8OYgc20U=;
        b=CdgvWk3Aae8IgC34xS389kIIkM1VdfTBerSjNQnlXsbTOkdKqZ2K/0EaozLeyZhJwk
         4qnvrR0snfNmxjEhkzE5aJ8ZvAJJ1ef17a0sj/0WXXW2nwg1Xh0nSBmxvWj5UVrZrYEA
         JxiGQhkIPJDHELk/EYY81+FFczle4SW3OCXCh78bEJ7eohnyP850PIOXyx3f0MpiHPED
         cDjHPmzUY/VbTu1+PXgVnExl0hs3VhE3UtkytPBdL3yWwzgRcwt/bCSJHWzoqukX97Jd
         PaDpwQZnqSHg7WbmQ+NiM45dUvIouig3Up7jlGIHiUtS/ItVx/ieUfL/MgAPV617t7tQ
         0o+A==
X-Gm-Message-State: APjAAAWLFENyelYC1FRc5BrBsAluym0Hqa+ooJoV44RNoE2Pt/9yJc1A
        FPRum4ax0AwH6ZCGYc0rV4kd2ix9AuLCC9ntq5o=
X-Google-Smtp-Source: APXvYqzXYn0R1MrARhtw0Zzdl4A6iUzyS/fuzDCq78U6xoYH+5CYlGdxPMNLOZiK05XHZLs6exSGl14/VzdzXQjAI9Q=
X-Received: by 2002:a54:4713:: with SMTP id k19mr4664423oik.113.1579291286913;
 Fri, 17 Jan 2020 12:01:26 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
 <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
 <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
 <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com>
 <87pnfjwxtx.fsf@nanos.tec.linutronix.de> <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com>
 <87zhem172r.fsf@nanos.tec.linutronix.de> <CAGi-RUJkr0gPbynYe+Gkk-JoeyCHdSvd9zdgCv4Hij5vfGVMEA@mail.gmail.com>
 <87sgke1004.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sgke1004.fsf@nanos.tec.linutronix.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Fri, 17 Jan 2020 22:01:15 +0200
Message-ID: <CAGi-RUJTGMA2VuhxA--0hvYgEPJydBPT9uHXD2YBToKgf3Zmbg@mail.gmail.com>
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 17, 2020 at 7:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ramon,
>
> Ramon Fried <rfried.dev@gmail.com> writes:
> > On Fri, Jan 17, 2020 at 4:38 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> This is wrong. MSI is edge type, not level and you are really mixing up
> >> the concepts here.
> >>
> >> The fact that the MSI block raises a level interrupt on the output side
> >> has absolutely nothing to do with the type of the MSI interrupt itself.
> >>
> >> MSI is edge type by definition and this does not change just because
> >> there is a translation unit between the MSI interrupt and the CPU
> >> controller.
> >>
> >> The actual MSI interrupts do not even know about the existance of that
> >> MSI block at all. They do not care, as all they need to know is a
> >> message and an address. When an interrupt is raised in the device the
> >> MSI chip associated to the device (PCI or something else) writes this
> >> message to the address exactly ONCE. And this exactly ONCE defines the
> >> edge nature of MSI.
> >
> > OK, now I understand my mistake. thanks.
>
> :)
>
> >> A proper designed MSI device should not send another message before the
> >> interrupt handler which is associated to the device has handled the
> >> interrupt at the device level.
> >
> > By "MSI device" you mean the MSI controller in the SOC or the endpoint
> > that sends the MSI ?
>
> The device which incorporates the MSI endpoint.
This is not how the MSI specs describe it, so I'm confused.
According to spec, MSI is just an ordinary post PCIe TLP to a certain
memory on the root-complex.
The only information it has whether to send an MSI or not is the
masked/pending register in the config space.
So, basically, back to my original question, without tinkering with
these bits, the device will always send the MSI's,
it's just that they will be masked on the MSI controller on the host. right ?

Thanks,
Ramon.
>
> Thanks,
>
>         tglx
