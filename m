Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED357DB4A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiGVHbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiGVHbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 03:31:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B99965A
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 00:31:42 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D9163F130
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658475101;
        bh=swWJKkGWRAT8EJ5gzXnLH40E4VFH/JvOdSTySX5AyCI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MV+XyadybzQ4s9pUa4OyB37ukGYLLIm6Q/YzweqGYZU9DJigf53hN+APqe2YyVQQF
         mm2Ev0szoxvEsYKZ6L2LA+wZmLVZCjflMJoUBjD4WZQncrZyeQG7nWqbxCvd6kTqAX
         oTSX4noVji9AYrbIIJdetdj49agNmYXnFQ++RSIkdGVyF1BZwEqh9fHtgJEN8SGYzJ
         OPkC1ZfGAfb9Lfnk/QNn0tO47CqX4I9YZ2iFfk787dPbhOrkte3XWKwayFH2XmX0wP
         ZN6aPXX4o7sAGB3c9pay/qOBBhcrRKq7cphFjTT6hiUmmGy07DuEwlNVq0Ym1WeTVP
         FPNEgvOvEnAKw==
Received: by mail-oi1-f198.google.com with SMTP id bx14-20020a0568081b0e00b0033a6f2395aaso1943577oib.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 00:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swWJKkGWRAT8EJ5gzXnLH40E4VFH/JvOdSTySX5AyCI=;
        b=7HZqNBr7ug3Q4G93PTjf3XPRlKmrdLeus4FKywTv/SYWR+rmtv5PpcTuJvSklU9jii
         2aPWbKK12LD9wcJDzgIjukcfkPKta25vShGfydw7AHSRue3sMI0zhLh5t8Dgjut5v7PQ
         7BS0LeYv6nMapDvuozJDKquHDjSGxrv50ZyWNMV3JhukJSkBPsfV/IZFW23ZY5qYnrLv
         bPfaHaPhJKs8E6RB2Tnvpvkqddyt0w54N+zv4NOpFHCzLzlOQ0qtz07Z8BVcmCqUS1gT
         9V6rCSEPn217eznpDCtPH0HWBeN1r3+uGX79viBnepW9+k+hUrTvxk8w/Y0gHRVtHWu7
         8AdA==
X-Gm-Message-State: AJIora9d4dsiFAKyCbo1O6tieWlI/PB9RXrj/6W6Vl5AZl2x+oaQbZTL
        yOD3llYD5MQpXF2hW206NT38YKkJKBO9SvOR0umRtVb1oL11OV18jyOtO3iEN/iTFs2XHAAeLqi
        I/2nlDpeiPv5wVzOsfepHABKXRPlHl5sw9Rx3G3uIa0VxMUqd6mDAxA==
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id f17-20020a056870211100b000e680268651mr1014539oae.42.1658475099787;
        Fri, 22 Jul 2022 00:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vF6XuwGGBJdjebfFuLWgYPrcXmooyt9LQMz5+AKvdNuQdNsbLQpsDa/4L6DzBfwF/5/QfyWKfBFVmNhoRIK0Y=
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id
 f17-20020a056870211100b000e680268651mr1014523oae.42.1658475099481; Fri, 22
 Jul 2022 00:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220705060014.10050-1-vidyas@nvidia.com> <CACT4zj8oTthEA8uEpSYQYURcc4qqp20xfw+DRaH=cS9NHGgZtw@mail.gmail.com>
In-Reply-To: <CACT4zj8oTthEA8uEpSYQYURcc4qqp20xfw+DRaH=cS9NHGgZtw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Jul 2022 15:31:27 +0800
Message-ID: <CAAd53p6RQ6GPkwWBTeqhOx_WXNLL8jrTe9n-zogaA_02QiDeUw@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
> >
> > Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> > saved and restored during suspend/resume leading to L1 Substates
> > configuration being lost post-resume.
> >
> > Save the L1 Substates control registers so that the configuration is
> > retained post-resume.
> >
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>
> Hi Vidya,
>
> I tested this patch on kernel v5.19-rc6.
> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
> This patch can restore L1SS after suspend/resume.
>
> The test results are as follows:
>
> After Boot:
> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us
> PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=3145728ns
>                 L1SubCtl2: T_PwrOn=3100us
>
>
> After suspend/resume without this patch.
> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us
> PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=0us LTR1.2_Threshold=0ns
>                 L1SubCtl2: T_PwrOn=10us
>
>
> After suspend/resume with this patch.
> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us
> PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=3145728ns
>                 L1SubCtl2: T_PwrOn=3100us
>
>
> Tested-by: Ben Chuang <benchuanggli@gmail.com>

Forgot to add mine:
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> Best regards,
> Ben Chuang
>
>
> > ---
> > Hi,
> > Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> > on your laptop (Dell XPS 13) one last time?
> > IMHO, the regression observed on your laptop with an old version of the patch
> > could be due to a buggy old version BIOS in the laptop.
> >
> > Thanks,
> > Vidya Sagar
> >
> >  drivers/pci/pci.c       |  7 +++++++
> >  drivers/pci/pci.h       |  4 ++++
> >  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a8..aca05880aaa3 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> >                 return i;
> >
> >         pci_save_ltr_state(dev);
> > +       pci_save_aspm_l1ss_state(dev);
> >         pci_save_dpc_state(dev);
> >         pci_save_aer_state(dev);
> >         pci_save_ptm_state(dev);
> > @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> >          * LTR itself (in the PCIe capability).
> >          */
> >         pci_restore_ltr_state(dev);
> > +       pci_restore_aspm_l1ss_state(dev);
> >
> >         pci_restore_pcie_state(dev);
> >         pci_restore_pasid_state(dev);
> > @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
> >         if (error)
> >                 pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> >
> > +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> > +                                           2 * sizeof(u32));
> > +       if (error)
> > +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> > +
> >         pci_allocate_vc_save_buffers(dev);
> >  }
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index e10cdec6c56e..92d8c92662a4 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >  #else
> >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> >  #endif
> >
> >  #ifdef CONFIG_PCIE_ECRC
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b7424c9bc..2c29fdd20059 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> >                                 PCI_L1SS_CTL1_L1SS_MASK, val);
> >  }
> >
> > +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> > +{
> > +       int aspm_l1ss;
> > +       struct pci_cap_saved_state *save_state;
> > +       u32 *cap;
> > +
> > +       if (!pci_is_pcie(dev))
> > +               return;
> > +
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> > +
> > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = (u32 *)&save_state->cap.data[0];
> > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> > +}
> > +
> > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> > +{
> > +       int aspm_l1ss;
> > +       struct pci_cap_saved_state *save_state;
> > +       u32 *cap;
> > +
> > +       if (!pci_is_pcie(dev))
> > +               return;
> > +
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> > +
> > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = (u32 *)&save_state->cap.data[0];
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> > +}
> > +
> >  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> >  {
> >         pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > --
> > 2.17.1
> >
