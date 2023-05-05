Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD206F8008
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEEJb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjEEJb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 05:31:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB710F3;
        Fri,  5 May 2023 02:31:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6436e075166so1205806b3a.0;
        Fri, 05 May 2023 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683279116; x=1685871116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qg71EK7t/X7qYG/IDsY7XCRHA6DQu7mwSQWZQzVvXr8=;
        b=l0EK2PlpTe8xkeUi2TJ83LVFur70912Am4wyOCiFvOkpwkB5DVdeyktYQdluAsYxjm
         kBUNzuwkMVggfWTaqZLFuholroWIaD7xjTB9109O2WCKIpsyS3Yq2YFujL/u0iStFqRl
         RbkKlLak3dyol6vyxlyOB4ymrTc1/4tBQBsLt0sfin9f3kowzHWtv5fMLRGh283JbZEq
         uW8n78ShON0dHXQjcFBM8k10YpnwNHeneL9coxYiwJv6RLnSUTSRfQ8Lje4gf4ah9Tin
         hG8/HzZ1LvQRhKE2CYHQvL0DS3cL97JB6OkYtRnK4Qlx4K6ksxZeoZ5aPSUyMHQiEmL8
         F9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683279116; x=1685871116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qg71EK7t/X7qYG/IDsY7XCRHA6DQu7mwSQWZQzVvXr8=;
        b=kzGFLUvRHq3uNgylhUtTaTM8tnS7iK02W7lfU+O9Eznjp6MYFliLk2XvIJg6p+JzZu
         gHiq4vXQoq48TjHTNJFYURWpJWBGSZsCYmS2q0oScCkZSpsLMmChVDmGy1hM0a0de/C8
         /JMwQ98NPgbRx84XUIs++uL7cmFX8PCE5X7L0zdTJirIy/6OPTTPBYbqOJIpMHV9ZpMP
         23B1gg5FP/yqoLSg5W1DsrmRORBADyTeJekUH+vchovrR7qy+yBkW/RzDmZXFdMPvg4s
         kNQ/npLxFxk+t9C2Kl2uFVOMWihV4v3fxRTm6IvwzSuo8d6qLN7N8vxE7ZhqIFrmiwWX
         UWdw==
X-Gm-Message-State: AC+VfDzVtANBiEoqhwi1U1ofCRxqMu8+NYL7p37cUHOcF0z5qKE94pK9
        RXe3fKYQKtFBu6hWhxr87ElaN48wPlq97GHGiss=
X-Google-Smtp-Source: ACHHUZ5qcrT/n5rgcTanwKHWdGOX5CcaXpiPdbnt6TCvhOFOrumPiJdaYssUrbfg0ndbJwahPfO7RrosWjyeHOiYgTQ=
X-Received: by 2002:a05:6a20:7d8d:b0:ed:1355:f88b with SMTP id
 v13-20020a056a207d8d00b000ed1355f88bmr1101163pzj.26.1683279115536; Fri, 05
 May 2023 02:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230428184036.GA298937@bhelgaas> <20230428195822.GA361074@bhelgaas>
In-Reply-To: <20230428195822.GA361074@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Fri, 5 May 2023 17:31:44 +0800
Message-ID: <CAEm4hYUdkoZkdVg9tQ=fZoCk-1DYrNrDxmPc=+ZyRJaSnGOxwA@mail.gmail.com>
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

On Sat, Apr 29, 2023 at 3:58=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Apr 28, 2023 at 01:40:36PM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 20, 2023 at 03:09:14PM +0800, korantwork@gmail.com wrote:
> > > From: Xinghui Li <korantli@tencent.com>
>
> > What if you made boolean parameters like these:
> >
> >   no_msi_remap
> >
> >     If the VMD supports it, disable VMD MSI-X remapping.  This
> >     improves interrupt performance because child device interrupts
> >     avoid the VMD MSI-X domain interrupt handler.
> >
> >   msi_remap
> >
> >     Remap child MSI-X interrupts into VMD MSI-X interrupts.  This
> >     limits the number of MSI-X vectors available to the whole child
> >     device domain to the number of VMD MSI-X interrupts.
>
> I guess having two parameters that affect the same feature is also
> confusing.  Maybe just "msi_remap=3D0" or "msi_remap=3D1" or something?
>
> I think what makes "disable_msi_bypass=3D0" hard is that "MSI bypass" by
> itself is a negative feature (the positive activity is MSI remapping),
> and disabling bypass gets us back to the positive "MSI remapping"
> situation, and "disable_msi_bypass=3D0" negates that again, so we're
> back to ... uh ... let's see ... we are not disabling the bypass of
> MSI remapping, so I guess MSI remapping would be *enabled*?  Is that
> right?
>
> Bjorn
I am fine with these two ways naming of the param. Adjusting from
enable_msi_remaping to disable_msi_bypass was aimed to trying address
your comment about dealing with the device not supporting bypass.
And in vmd drivers, the vmd bypass feature is enabled by adding the flag
"VMD_FEAT_CAN_BYPASS_MSI_REMAP".  Therefore, I think disabling
bypass seems more appropriate. This patch aims to provide a convenient
way to remove that flag in a specific case.

On Sat, Apr 29, 2023 at 2:40=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> The "disable_msi_bypass" parameter name also leads to some complicated
> logic.  IIUC, "disable_msi_bypass=3D0" means "do not disable MSI remap
> bypassing" or, in other words, "do not remap MSIs."  This is only
> supported by some VMDs.  Using "disable_msi_bypass=3D0" to *enable* the
> bypass feature is confusing.
However, as you said, it does lead to some complicated logic.  So, I
also believe
that these two approaches have their own pros and cons.

> I still don't understand what causes the performance problem here.  I
> guess you see higher performance when the VMD remaps child MSIs?  So
> adding the VMD MSI-X domain interrupt handler and squashing all the
> child MSI vectors into the VMD MSI vector space makes things better?
> That seems backwards.  Is this because of cache effects or something?

> What does "excessive pressure on the PCIe node" mean?  I assume the
> PCIe node means the VMD?  It receives the same number of child
> interrupts in either case.
What I mean is that there will be performance issues when a PCIe domain
is fully loaded with 4 Gen4 NVMe devices.  like this:
 +-[10002:00]-+-01.0-[01]----00.0  device0
 |                     +-03.0-[02]----00.0  device1
 |                     +-05.0-[03]----00.0  device2
 |                      \-07.0-[04]----00.0  device3

According to the perf/irqtop tool, we found the os does get the same counts
of interrupts in different modes. However, when the above situation occurs,
we observed a significant increase in CPU idle time. Besides, the data and
performance when using the bypass VMD feature were identical to when VMD
was disabled. And after the devices mounted on a domain are reduced, the
IOPS of individual devices will rebound somewhat. Therefore, we speculate
that VMD can play a role in balancing and buffering interrupt loads. Theref=
ore,
in this situation, we believe that VMD  ought to not be bypassed to handle =
MSI.

> > Besides, this parameter does not affect the MSI-X working mode in
> > guest.

> I don't understand what you're saying here.  From the patch, I think
> that "disable_msi_bypass=3D1", i.e., "always remap child MSIs", means we
> pretend this VMD doesn't support the VMCONFIG_MSI_REMAP bit.  In that
> case MSI remapping always happens.

> If the user may need to use "disable_msi_bypass=3D1" (or "msi_remap") in
> some virtualization scenarios, we should mention that and maybe give a
> hint about what happens *without* that parameter.
I apologize for the confusion, I think I missed the keyword 'passthrough mo=
de'.
In the virtualization scenarios, VMD doesn't support bypassing MSI-X when i=
t is
set to passthrough mode.
  PCI: vmd: Disable MSI-X remapping when possible(commit ee81ee8):
+  /*
+  * Currently MSI remapping must be enabled in guest passthrough mode
+  * due to some missing interrupt remapping plumbing. This is probably
+  * acceptable because the guest is usually CPU-limited and MSI
+  * remapping doesn't become a performance bottleneck.
+  */
This patch will not change this point, I just wanted to mention it again~

Thanks for your reviewing. I hope this reply can address your points.
