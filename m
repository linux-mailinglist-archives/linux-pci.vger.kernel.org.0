Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594BF15B603
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 01:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgBMAor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 19:44:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34533 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgBMAor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 19:44:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id h12so3171382qtu.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2020 16:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u/6MFP9YOEsoapPuPEAkscXNOmReVYxNjGun2VjH9P0=;
        b=W4toW2VgjUNPXVVDlFpXbL7E9/aDZHVDp7zw3NXRdQ6Dr35ZhaONGLndtpkQm43TFO
         qt02mpatz4afEzKHkBsZiRSC0Dzn/95xLVN7eIIU5xG+lE+7/2k2J4kdtIMZ1t/IUNa8
         fkJrDNXa1c+OvSRYu/aLsiTnK55mu9KaYOa5ZRvOS8AuAc6GsQvsATddo8N2PecXHbgG
         Nk0Sskjfm/tw5Gf6dL1QddtvCeYoEjWIUwDItZoMdGVLBx4axQsBf/GgfC7MUOfjgGd/
         zsLw/4u/Bb5yukSET8uzrs3ZN6KDQ9h0HKxup+ladTX6lbScWePokyVMMNWAZYuzAiPi
         li/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u/6MFP9YOEsoapPuPEAkscXNOmReVYxNjGun2VjH9P0=;
        b=F4a7Zv0ocW++bZAVM1171E909sUipMlJUakDk7dm20jU0Sgo/oio1bmX88IFcTI+u/
         /5oT6ARjAgcsu6MEFU9mprCTB8DUanBs1QlQVfQi7X4wjFpdoAuHDeoqTCMoly1gRxXs
         dhSTQGSG3uLPjcqy03Q3wWixFqzjgpH0CL90ON6QJ68XJ+gH+g45RrvV+LclohTbl2uW
         dGGg3iwMZbX3GZqIxBZhDoVryFbejwAms1/fFlKxwvxDPBhxvjZjIoq97rKltvaXl62K
         UHSs5iFQ2bsH13O/4+SbbwRvbGBpym/+QfvdYTCLuBxX9UAzix69jR2UYHY4diHqS5F5
         ySlQ==
X-Gm-Message-State: APjAAAXEvJrEJnRelKCtLRGSmjhODGfyZkEnJQLG+yyJPa12y4knSvow
        /daQx5N+3XdQJUq8+CM84C34jg==
X-Google-Smtp-Source: APXvYqyuqQvmdVFdw9iOcWXuzcI/hg93mx03FTzDcdmPum3Wu1/Aoh7z0ek3puN/R9AO225vo+AlCA==
X-Received: by 2002:ac8:4886:: with SMTP id i6mr9423904qtq.160.1581554685730;
        Wed, 12 Feb 2020 16:44:45 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g9sm375908qkl.11.2020.02.12.16.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 16:44:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: "Plug non-maskable MSI affinity race" triggers a warning with CPU
 hotplugs
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <878sl8xdbm.fsf@nanos.tec.linutronix.de>
Date:   Wed, 12 Feb 2020 19:44:43 -0500
Cc:     Evan Green <evgreen@chromium.org>, Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A54AABBD-F712-423B-8B60-3D3B8176D2FC@lca.pw>
References: <FE2AA412-40A7-4FA2-A9E8-C7FA2919BD1D@lca.pw>
 <878sl8xdbm.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Feb 12, 2020, at 6:19 AM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>=20
> Qian,
>=20
> Qian Cai <cai@lca.pw> writes:
>=20
>> The linux-next commit 6f1a4891a592 (=E2=80=9Cx86/apic/msi: Plug =
non-maskable
>> MSI affinity race=E2=80=9D) Introduced a bug which is always =
triggered during
>> the CPU hotplugs on this server. See the trace and line numbers =
below.
>=20
> Thanks for the report.
>=20
>> WARNING: CPU: 0 PID: 2794 at arch/x86/kernel/apic/msi.c:103 =
msi_set_affinity+0x278/0x330=20
>> CPU: 0 PID: 2794 Comm: irqbalance Tainted: G             L    =
5.6.0-rc1-next-20200211 #1=20
>> irq_do_set_affinity at kernel/irq/manage.c:259
>> irq_setup_affinity at kernel/irq/manage.c:474
>> irq_select_affinity_usr at kernel/irq/manage.c:496
>> write_irq_affinity.isra.0+0x137/0x1e0=20
>> irq_affinity_proc_write+0x19/0x20
> ...
>=20
> I'm glad I added this WARN_ON(). This unearthed another long standing
> bug. If user space writes a bogus affinity mask, i.e. no online CPUs
> then it calls irq_select_affinity_usr().
>=20
> This was introduced for ALPHA in
>=20
>  eee45269b0f5 ("[PATCH] Alpha: convert to generic irq framework =
(generic part)")
>=20
> and subsequently made available for all architectures in
>=20
>  18404756765c ("genirq: Expose default irq affinity mask (take 3)")
>=20
> which already introduced the circumvention of the affinity setting
> restrictions for interrupts which cannot be moved in process context.
>=20
> The whole exercise is bogus in various aspects:
>=20
>    1) If the interrupt is already started up then there is absolutely
>       no point to honour a bogus interrupt affinity setting from user
>       space. The interrupt is already assigned to an online CPU and it
>       does not make any sense to reassign it to some other randomly
>       chosen online CPU.
>=20
>    2) If the interupt is not yet started up then there is no point
>       either. A subsequent startup of the interrupt will invoke
>       irq_setup_affinity() anyway which will chose a valid target CPU.
>=20
> So the right thing to do is to just return -EINVAL in case user space
> wrote an affinity mask which does not contain any online CPUs, except =
for
> ALPHA which has it's own magic sauce for this.
>=20
> Can you please test the patch below?

Yes, it works fine.

>=20
> Thanks,
>=20
>        tglx
>=20
> 8<---------------
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index 3924fbe829d4..c9d8eb7f5c02 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -128,8 +128,6 @@ static inline void =
unregister_handler_proc(unsigned int irq,
>=20
> extern bool irq_can_set_affinity_usr(unsigned int irq);
>=20
> -extern int irq_select_affinity_usr(unsigned int irq);
> -
> extern void irq_set_thread_affinity(struct irq_desc *desc);
>=20
> extern int irq_do_set_affinity(struct irq_data *data,
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 3089a60ea8f9..7eee98c38f25 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -481,23 +481,9 @@ int irq_setup_affinity(struct irq_desc *desc)
> {
> 	return irq_select_affinity(irq_desc_get_irq(desc));
> }
> -#endif
> +#endif /* CONFIG_AUTO_IRQ_AFFINITY */
> +#endif /* CONFIG_SMP */
>=20
> -/*
> - * Called when a bogus affinity is set via /proc/irq
> - */
> -int irq_select_affinity_usr(unsigned int irq)
> -{
> -	struct irq_desc *desc =3D irq_to_desc(irq);
> -	unsigned long flags;
> -	int ret;
> -
> -	raw_spin_lock_irqsave(&desc->lock, flags);
> -	ret =3D irq_setup_affinity(desc);
> -	raw_spin_unlock_irqrestore(&desc->lock, flags);
> -	return ret;
> -}
> -#endif
>=20
> /**
>  *	irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 9e5783d98033..af488b037808 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -111,6 +111,28 @@ static int irq_affinity_list_proc_show(struct =
seq_file *m, void *v)
> 	return show_irq_affinity(AFFINITY_LIST, m);
> }
>=20
> +#ifndef CONFIG_AUTO_IRQ_AFFINITY
> +static inline int irq_select_affinity_usr(unsigned int irq)
> +{
> +	/*
> +	 * If the interrupt is started up already then this fails. The
> +	 * interrupt is assigned to an online CPU already. There is no
> +	 * point to move it around randomly. Tell user space that the
> +	 * selected mask is bogus.
> +	 *
> +	 * If not then any change to the affinity is pointless because =
the
> +	 * startup code invokes irq_setup_affinity() which will select
> +	 * a online CPU anyway.
> +	 */
> +	return -EINVAL;
> +}
> +#else
> +/* ALPHA magic affinity auto selector. Keep it for historical =
reasons. */
> +static inline int irq_select_affinity_usr(unsigned int irq)
> +{
> +	return irq_select_affinity(irq);
> +}
> +#endif
>=20
> static ssize_t write_irq_affinity(int type, struct file *file,
> 		const char __user *buffer, size_t count, loff_t *pos)

