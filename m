Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017096FB0B8
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjEHNAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHNAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 09:00:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14B335B2C;
        Mon,  8 May 2023 06:00:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-64384c6797eso3607679b3a.2;
        Mon, 08 May 2023 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683550816; x=1686142816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8dlsQ2CwmNO7wfwJytQqAVyx7gIUYGLIcScY05pJUU=;
        b=NyWAEC0fnznRXTC4DtRIIkKzkIm/1m7MLZYu7hkwFiZfu3TJcwv/ghlR1ZGi3KAEXi
         i3pyhB0QyRq383PB3jJBae8v/RLPWd2TmPUyL+Um4O3Eh7CKm+ImQcdWyOgWUBfK3ePL
         v81os/n/d8cr1PqvEaDrfaG/E3w2EueJLFCi5caLkNInssVvkz1yvnxdK5NsZmlZ775N
         HENZvYx90UgR0CFpOON3swIvLhXgnT6i3/ncd3NQh6hsIo2aWDn/ePqaVykZCHJw0Xnt
         Kw8nRYSECqQXNeZzBF0K8odGEjdO14bJnK1xMX/WacD1niF5Ic21yWBtibzwACcqQTTU
         9Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550816; x=1686142816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8dlsQ2CwmNO7wfwJytQqAVyx7gIUYGLIcScY05pJUU=;
        b=ZpVog3VcSS2iRv4Q7lXzo3XhQ4RDrR/wmDn0Xx7EdrNiRJUxzAmGGxuHDptKmhKKrS
         6xl8oqIhBletT1LOba5gA1Uz6AK+GO8tJFJACR7TfvJr9SfsTywDeERz7N9nkwkoBvRS
         xpW39pw9MgRo74/1In40EyPFIzIr7bs57gYy0mskQ8nE3nBjVtmdzqxYrg53mUBLvJd5
         uo70sZlOOf1CXVLHqK3s/Wrbo8VYgPv+lRpLGQ2cHzz2sW+ZdPQpoWThwfczZomZrQt7
         Xat9CRXBSxqXaC607BBg+45yBivwA1HCm5ATjZ6PDksfJGKP3Fd3RWsS0cwuWKYtZTgs
         /o3g==
X-Gm-Message-State: AC+VfDx4G9ItDR4e/bTP0LXcMbuxXQC9IX9QY3RG2lmnOEG21islUtAN
        CgQ9h6/r6QiQWf2svwoD8AHrWUs599yskyMG2/Q=
X-Google-Smtp-Source: ACHHUZ5BlhTTpgXl7d19lzo59cLz8865HsCq/XLKKxmwEt6g82Je8ChFuu2vk29C8N48WYQ4iLf9IIRGL0N+vDblejc=
X-Received: by 2002:a05:6a00:190e:b0:646:2ec8:3360 with SMTP id
 y14-20020a056a00190e00b006462ec83360mr2972330pfi.23.1683550816074; Mon, 08
 May 2023 06:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEm4hYUdkoZkdVg9tQ=fZoCk-1DYrNrDxmPc=+ZyRJaSnGOxwA@mail.gmail.com>
 <20230505160759.GA955334@bhelgaas>
In-Reply-To: <20230505160759.GA955334@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Mon, 8 May 2023 21:01:31 +0800
Message-ID: <CAEm4hYU5o43UqXT69o-uUYEu8k0jbtSbeVUO214VWo+gM+d+Zg@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: vmd: Add the module param to adjust MSI mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
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

On Sat, May 6, 2023 at 12:08=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> > I am fine with these two ways naming of the param. Adjusting from
> > enable_msi_remaping to disable_msi_bypass was aimed to trying address
> > your comment about dealing with the device not supporting bypass.
> > And in vmd drivers, the vmd bypass feature is enabled by adding the fla=
g
> > "VMD_FEAT_CAN_BYPASS_MSI_REMAP".  Therefore, I think disabling
> > bypass seems more appropriate. This patch aims to provide a convenient
> > way to remove that flag in a specific case.
>
> Users don't care about the name of VMD_FEAT_CAN_BYPASS_MSI_REMAP.  I
> don't think that's a very good name either (in my opinion
> "VMD_FEAT_MSI_REMAP_DISABLE" would be more descriptive, and
> VMCONFIG_MSI_REMAP is even worse since setting it *disables* MSI
> remapping), but in any case these are internal to the driver.
>
> > On Sat, Apr 29, 2023 at 2:40=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > The "disable_msi_bypass" parameter name also leads to some complicate=
d
> > > logic.  IIUC, "disable_msi_bypass=3D0" means "do not disable MSI rema=
p
> > > bypassing" or, in other words, "do not remap MSIs."  This is only
> > > supported by some VMDs.  Using "disable_msi_bypass=3D0" to *enable* t=
he
> > > bypass feature is confusing.
> >
> > However, as you said, it does lead to some complicated logic.  So, I
> > also believe that these two approaches have their own pros and cons.
> >
> > > I still don't understand what causes the performance problem here.  I
> > > guess you see higher performance when the VMD remaps child MSIs?  So
> > > adding the VMD MSI-X domain interrupt handler and squashing all the
> > > child MSI vectors into the VMD MSI vector space makes things better?
> > > That seems backwards.  Is this because of cache effects or something?
> >
> > > What does "excessive pressure on the PCIe node" mean?  I assume the
> > > PCIe node means the VMD?  It receives the same number of child
> > > interrupts in either case.
> >
> > What I mean is that there will be performance issues when a PCIe domain
> > is fully loaded with 4 Gen4 NVMe devices.  like this:
> >  +-[10002:00]-+-01.0-[01]----00.0  device0
> >  |                     +-03.0-[02]----00.0  device1
> >  |                     +-05.0-[03]----00.0  device2
> >  |                      \-07.0-[04]----00.0  device3
> >
> > According to the perf/irqtop tool, we found the os does get the same
> > counts of interrupts in different modes. However, when the above
> > situation occurs, we observed a significant increase in CPU idle
> > time. Besides, the data and performance when using the bypass VMD
> > feature were identical to when VMD was disabled. And after the
> > devices mounted on a domain are reduced, the IOPS of individual
> > devices will rebound somewhat. Therefore, we speculate that VMD can
> > play a role in balancing and buffering interrupt loads. Therefore,
> > in this situation, we believe that VMD ought to not be bypassed to
> > handle MSI.
>
> The proposed text was:
>
>   Use this when multiple NVMe devices are mounted on the same PCIe
>   node with a high volume of 4K random I/O. It mitigates excessive
>   pressure on the PCIe node caused by numerous interrupts from NVMe
>   drives, resulting in improved I/O performance. Such as:
>
> The NVMe configuration and workload you mentioned works better with
> MSI-X remapping.  But I don't know *why*, and I don't know that NVMe
> is the only device affected.  So it's hard to write useful guidance
> for users, other than "sometimes it helps."
>
> Straw man proposal:
>
>   msi_remap=3D0
>
>     Disable VMD MSI-X remapping, which improves interrupt performance
>     because child device interrupts avoid the VMD MSI-X domain
>     interrupt handler.  Not all VMD devices support this, but for
>     those that do, this is the default.
>
>   msi_remap=3D1
>
>     Remap child MSI-X interrupts into VMD MSI-X interrupts.  This
>     limits the number of MSI-X vectors available to the whole child
>     device domain to the number of VMD MSI-X interrupts.
>
>     This may be required in some virtualization scenarios.
>
>     This may improve performance in some I/O topologies, e.g., several
>     NVMe devices doing lots of random I/O, but we don't know why.
>
> I hate the idea of "we don't know why."  If you *do* know why, it
> would be much better to outline the mechanism because that would help
> users know when to use this.  But if we don't know why, admitting that
> straight out is better than hand-waving about excessive pressure, etc.
>
I completely agree with you. I discovered this issue using the bisect metho=
d.
Based on the observed data and experiments, I drew the above conclusions.
We deduced the cause from the observed results. However, I have not yet
been able to determine the precise cause of this issue.

> The same applies to the virtualization caveat.  The text above is not
> actionable -- how do users know whether their particular
> virtualization scenario requires this option?
>
I will add a note to make it clear that bypass mode will not work in guest
passthrought mode, only remapping mode can be used.

Thanks
