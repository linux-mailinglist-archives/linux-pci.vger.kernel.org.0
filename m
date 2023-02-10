Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF596924D0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBJRsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjBJRr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:47:59 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFB1CAE3;
        Fri, 10 Feb 2023 09:47:57 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k4so6457549vsc.4;
        Fri, 10 Feb 2023 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWwH1JAR3/yBFmztr9hK1WsxNApqfqNUPTqo0p82+RQ=;
        b=prZc4fnbAMbbyiecNrD+0SOSDnFDYmpyRHbyhabCJW2aotHegsaxJMGX5sZ1dP79PB
         eHp24EdLj9k/aQlJGaJQR/DU6HSRHu5yRc3s0Lb8Tj4FzaaHi5AIHmb60WO1jJSohjuP
         RDq/EylMJjpMmG4OxSyKsGns4YdcH+lCD2peDRZfuGTi9RBn8Etxi/qE6KYIWf4hLKq3
         wdTnmmJkhB2tXIppvC7WsK7OxJSEEGUgKNPea61W7WfGcZD1Nv+yJZar+DjsveQf27t6
         +4XrJwIvgRtSid/6zDyRa6d3fdqfG18jtQe1SVJBWac/5rDsTkSQL5AeWQLbWnbHeLmE
         pH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWwH1JAR3/yBFmztr9hK1WsxNApqfqNUPTqo0p82+RQ=;
        b=WjAhc4kLA3zS5qkNyZ6pAIxprtvsweU20znIUwDcPOnQjcFLIxSxo26kNdDHnorukc
         oXtIlYSxMaSll31eNzTrc9j/sB4BA4Q9iXLOmK8WaF0AL+U7IcA1hB0q6Igwmj7G+uwl
         Ygl+f3dH2/QyyNkJirbJ0PkVP9cljGa1067sxCyHlwfBQUihwoAUw/gvD8Mh84FNY2MM
         227Wfv0K3Qf+Tz4758QbjvRl4PodGekN7LEvOb0Wo+P49B3ApNFNOHwGLYsuSwPIOFL/
         8flQe8Y+GwYH9kYBkYG1kHwBg3SoqtqXLasvs4RHebUnlwNaCnhXIbsccQZUanZ6uEyB
         Jz9g==
X-Gm-Message-State: AO0yUKXjQ7SEgDnpcGT6r0bKLIgCyXdi5r0CWcrYuzI1JgGKAhadd/A4
        4EvzFzS1erhMVI3A40SmHF21CJ6Nl7FI23gGmJI=
X-Google-Smtp-Source: AK7set+EFOjcDE54uysaJhwLkIUbqGoPKM+B1zUawkNQ1Dq1RAQFPXm8UOOKVYfAbUccI25NRZT+23mrjEFHXvJfnmw=
X-Received: by 2002:a05:6102:299b:b0:3d0:a4bf:8c9c with SMTP id
 dl27-20020a056102299b00b003d0a4bf8c9cmr3797584vsb.15.1676051276888; Fri, 10
 Feb 2023 09:47:56 -0800 (PST)
MIME-Version: 1.0
References: <CAKd_mfSgzb5Zwb-_hjXMuiFfOw=ZoZn0GrC37=s8DraQTXVRhw@mail.gmail.com>
 <20230210135654.GA2673896@bhelgaas>
In-Reply-To: <20230210135654.GA2673896@bhelgaas>
From:   Mark Enriquez <enriquezmark36@gmail.com>
Date:   Sat, 11 Feb 2023 01:47:45 +0800
Message-ID: <CAKd_mfRk5o-7AGnCuzOGt4x86ysYbgLuywhG1ieywUkNQx9mNQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        tasev.stefanoska@skynet.be, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, Thomas Witt <kernel@witt.link>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I recompiled with this on v6.1 and tested twice
(still with all user space power saving tools disabled)
on ASPM policy default and powersupersave. The suspend/resume works.

Retried the tests on top of v6.2-rc7 and suspend/resume still works.

It's kind of sad that L1SS will have to be set aside for now.
Though, to be honest, I wasn't really able to measure any power savings from it.

Given that this specific Gigabyte laptop (G5 GD) is notoriously power
inefficient (~8 watts on complete idle), I think it should be easier to see if
L1SS is shaving off some watts.
Then again, I have no way to verify my measurements or if L1SS is truly being
achieved. It could be that the PCIe devices are just chilling on the L1 state.

In any case, thank you so much for this.
I Hope that this gets figured out in the near future.


On Fri, Feb 10, 2023 at 9:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Feb 10, 2023 at 09:39:56PM +0800, Mark Enriquez wrote:
> > I tried the test patch with the "ASPM: can't restore L1SS while L1
> > enabled" message on the v6.1 tag.
> >
> > I tried setting the ASPM policy to default rather than powersupersave.
> > Tested twice.
> > The result is I get to see the messages in the kernel log. The system
> > resumed successfully in all tests.
> > [  330.438136] ACPI: PM: Waking up from system sleep state S3
> > [  330.445959] ACPI: EC: interrupt unblocked
> > [  330.446174] pcieport 0000:00:1c.0: ASPM: can't restore L1SS while
> > L1 enabled (0x0042)
> > [  330.446177] pcieport 0000:00:1c.6: ASPM: can't restore L1SS while
> > L1 enabled (0x0002)
> > [  330.448354] r8169 0000:03:00.0: ASPM: can't restore L1SS while L1
> > enabled (0x0142)
> > [  330.448368] sdhci-pci 0000:04:00.0: ASPM: can't restore L1SS while
> > L1 enabled (0x0102)
>
> That's perfect, thank you very much!  That means we're in dangerous
> territory because v6.1 will restore the L1SS state while L1 is
> enabled, which the spec doesn't allow for.
>
> If you apply the patch below on vanilla v6.1 (or v6.2-rc, whatever is
> more convenient), my hope is that resume will work.
>
> I think we're just going to have to revert for now and give up the
> power savings we get from 4ff116d0d5fd.  We'll revisit it later, of
> course, to get the power savings back.
>
> commit a6b1e19ca489 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
> parent 830b3c68c1fb
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Feb 10 07:49:18 2023 -0600
>
>     Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"
>
>     This reverts commit 4ff116d0d5fd8a025604b0802d93a2d5f4e465d1.
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2127aba3550b..92c6f7e5ca2e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1665,7 +1665,6 @@ int pci_save_state(struct pci_dev *dev)
>                 return i;
>
>         pci_save_ltr_state(dev);
> -       pci_save_aspm_l1ss_state(dev);
>         pci_save_dpc_state(dev);
>         pci_save_aer_state(dev);
>         pci_save_ptm_state(dev);
> @@ -1772,7 +1771,6 @@ void pci_restore_state(struct pci_dev *dev)
>          * LTR itself (in the PCIe capability).
>          */
>         pci_restore_ltr_state(dev);
> -       pci_restore_aspm_l1ss_state(dev);
>
>         pci_restore_pcie_state(dev);
>         pci_restore_pasid_state(dev);
> @@ -3465,11 +3463,6 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>         if (error)
>                 pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>
> -       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> -                                           2 * sizeof(u32));
> -       if (error)
> -               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> -
>         pci_allocate_vc_save_buffers(dev);
>  }
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b1ebb7ab8805..ce169b12a8f6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -565,14 +565,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> -void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> -void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> -static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> -static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>  #endif
>
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..915cbd939dd9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -757,43 +757,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>                                 PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>
> -void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> -{
> -       struct pci_cap_saved_state *save_state;
> -       u16 l1ss = dev->l1ss;
> -       u32 *cap;
> -
> -       if (!l1ss)
> -               return;
> -
> -       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> -       if (!save_state)
> -               return;
> -
> -       cap = (u32 *)&save_state->cap.data[0];
> -       pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL2, cap++);
> -       pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, cap++);
> -}
> -
> -void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> -{
> -       struct pci_cap_saved_state *save_state;
> -       u32 *cap, ctl1, ctl2;
> -       u16 l1ss = dev->l1ss;
> -
> -       if (!l1ss)
> -               return;
> -
> -       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> -       if (!save_state)
> -               return;
> -
> -       cap = (u32 *)&save_state->cap.data[0];
> -       ctl2 = *cap++;
> -       ctl1 = *cap;
> -       aspm_program_l1ss(dev, ctl1, ctl2);
> -}
> -
>  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  {
>         pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
