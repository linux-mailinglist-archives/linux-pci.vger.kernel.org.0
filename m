Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4C57DEF4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiGVJq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiGVJqC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 05:46:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921CB6E
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 02:41:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i14so7164272yba.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ycm+e+uAb5Qzvt79A/I5jn2CMOtivv09bxdwgVxuNho=;
        b=nuPbVUJ2h5IkopZ2wsiKtrnKSrdpA/kpT6VdQq3XDPNe3tUplH99hLC7GMmXUxQUAl
         we9hc7Nhq9Wc1jCwkKsqV6YTc/SnGw+BhBD+LeldOWf/zc/YT5UEMYAiIKODOi5+Z5if
         Q13GSxH+uutZ3CWusGRYjgjCV2FeHuTFlOoHefsUhvNh6jD7tJmYMzUGTb8urhWLISXM
         spQuo/e1rz3e4SGDbbYIkY7df8I/3cbBML3J87uBSDGD8mbLyOYy6Kpy3C/rVgDvQFox
         ET9aV0ah2UtGgaMsZ3M9MCNN2u/6gwH2LAIK7zLtBzPUqauF/Aa0zCE+AnMpx/NL37rg
         iAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ycm+e+uAb5Qzvt79A/I5jn2CMOtivv09bxdwgVxuNho=;
        b=j7rgkmdrjo8jFWvX9gmJSXe+RqDhDgP7eqL9X2wKfzdkb3sxGV29MMNWlvc1SgMYjt
         iOchkH3dkrZRLv1/Jpy6M6QbsPX3Y2DawwaLksg7gwrZKyeZn0g1itlRixh1jBgenhBm
         pZf/XkVJtxoDosRYAbdA0+sf4ZP9PRNi1nxc7F7MFwP2cZDazjcSeuDQf1uFOWJGLAf4
         dzqCjwIG2Vy7+D5MDv2pOPnu/tIqTjYmdrv4orNTUUZQ1WSsZYAMcUeDf2cpFgicq7dZ
         ABI9Uvlzht5AFFknhRwQVYGtVY3ki0QJiWtX/QLiT6xTCyg27t1Nbz0D3mmtN4KDpSZz
         03eA==
X-Gm-Message-State: AJIora8al+DlVYXRDzvaIUUi9dBowPwj1+ut3PDG7n3YY/4Ps14V3JJi
        TAnKlzNIUH6SsQYf/5tM7PdLfexVCNtmEN65JJrTMw==
X-Google-Smtp-Source: AGRyM1vYtA1iLdFcCvKRU5CjBWV8sFMkJtG9HlvobiYsw3i+wW6WBAesmbCNjROZoOgra/bx3UMtVDh86/0F/E+JjEI=
X-Received: by 2002:a25:d9d4:0:b0:670:7b19:92cd with SMTP id
 q203-20020a25d9d4000000b006707b1992cdmr2020397ybg.223.1658482885374; Fri, 22
 Jul 2022 02:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220705060014.10050-1-vidyas@nvidia.com> <CACT4zj8oTthEA8uEpSYQYURcc4qqp20xfw+DRaH=cS9NHGgZtw@mail.gmail.com>
 <CAAd53p6RQ6GPkwWBTeqhOx_WXNLL8jrTe9n-zogaA_02QiDeUw@mail.gmail.com>
In-Reply-To: <CAAd53p6RQ6GPkwWBTeqhOx_WXNLL8jrTe9n-zogaA_02QiDeUw@mail.gmail.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Fri, 22 Jul 2022 11:41:14 +0200
Message-ID: <CAFJ_xbqJkXK7-O_kyF=Hrqu0gwskVLUfeK9mWSB1qM8XapLgSQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisa=
=C5=82(a):
>
> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote=
:
> >
> > On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
> > >
> > > Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren'=
t
> > > saved and restored during suspend/resume leading to L1 Substates
> > > configuration being lost post-resume.
> > >
> > > Save the L1 Substates control registers so that the configuration is
> > > retained post-resume.
> > >
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> >
> > Hi Vidya,
> >
> > I tested this patch on kernel v5.19-rc6.
> > The test device is GL9755 card reader controller on Intel i5-10210U RVP=
.
> > This patch can restore L1SS after suspend/resume.
> >
> > The test results are as follows:
> >
> > After Boot:
> > #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >         Capabilities: [110 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > ASPM_L1.1+ L1_PM_Substates+
> >                           PortCommonModeRestoreTime=3D255us
> > PortTPowerOnTime=3D3100us
> >                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1=
.1+
> >                            T_CommonMode=3D0us LTR1.2_Threshold=3D314572=
8ns
> >                 L1SubCtl2: T_PwrOn=3D3100us
> >
> >
> > After suspend/resume without this patch.
> > #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >         Capabilities: [110 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > ASPM_L1.1+ L1_PM_Substates+
> >                           PortCommonModeRestoreTime=3D255us
> > PortTPowerOnTime=3D3100us
> >                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1=
.1-
> >                            T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >                 L1SubCtl2: T_PwrOn=3D10us
> >
> >
> > After suspend/resume with this patch.
> > #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >         Capabilities: [110 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > ASPM_L1.1+ L1_PM_Substates+
> >                           PortCommonModeRestoreTime=3D255us
> > PortTPowerOnTime=3D3100us
> >                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1=
.1+
> >                            T_CommonMode=3D0us LTR1.2_Threshold=3D314572=
8ns
> >                 L1SubCtl2: T_PwrOn=3D3100us
> >
> >
> > Tested-by: Ben Chuang <benchuanggli@gmail.com>
>
> Forgot to add mine:
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> >
> > Best regards,
> > Ben Chuang
> >
> >
> > > ---
> > > Hi,
> > > Kenneth R. Crudup <kenny@panix.com>, Could you please verify this pat=
ch
> > > on your laptop (Dell XPS 13) one last time?
> > > IMHO, the regression observed on your laptop with an old version of t=
he patch
> > > could be due to a buggy old version BIOS in the laptop.
> > >
> > > Thanks,
> > > Vidya Sagar
> > >
> > >  drivers/pci/pci.c       |  7 +++++++
> > >  drivers/pci/pci.h       |  4 ++++
> > >  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index cfaf40a540a8..aca05880aaa3 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> > >                 return i;
> > >
> > >         pci_save_ltr_state(dev);
> > > +       pci_save_aspm_l1ss_state(dev);
> > >         pci_save_dpc_state(dev);
> > >         pci_save_aer_state(dev);
> > >         pci_save_ptm_state(dev);
> > > @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> > >          * LTR itself (in the PCIe capability).
> > >          */
> > >         pci_restore_ltr_state(dev);
> > > +       pci_restore_aspm_l1ss_state(dev);
> > >
> > >         pci_restore_pcie_state(dev);
> > >         pci_restore_pasid_state(dev);
> > > @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_=
dev *dev)
> > >         if (error)
> > >                 pci_err(dev, "unable to allocate suspend buffer for L=
TR\n");
> > >
> > > +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1S=
S,
> > > +                                           2 * sizeof(u32));
> > > +       if (error)
> > > +               pci_err(dev, "unable to allocate suspend buffer for A=
SPM-L1SS\n");
> > > +
> > >         pci_allocate_vc_save_buffers(dev);
> > >  }
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index e10cdec6c56e..92d8c92662a4 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *=
pdev);
> > >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> > >  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> > >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > > +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > >  #else
> > >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) {=
 }
> > >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) {=
 }
> > >  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) {=
 }
> > >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *p=
dev) { }
> > > +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > > +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) =
{ }
> > >  #endif
> > >
> > >  #ifdef CONFIG_PCIE_ECRC
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a96b7424c9bc..2c29fdd20059 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_li=
nk_state *link, u32 state)
> > >                                 PCI_L1SS_CTL1_L1SS_MASK, val);
> > >  }
> > >
> > > +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> > > +{
> > > +       int aspm_l1ss;
> > > +       struct pci_cap_saved_state *save_state;
> > > +       u32 *cap;
> > > +
> > > +       if (!pci_is_pcie(dev))
> > > +               return;
> > > +
> > > +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1S=
S);
> > > +       if (!aspm_l1ss)
> > > +               return;
> > > +
> > > +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1S=
S);
> > > +       if (!save_state)
> > > +               return;
> > > +
> > > +       cap =3D (u32 *)&save_state->cap.data[0];
> > > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> > > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> > > +}
> > > +
> > > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> > > +{
> > > +       int aspm_l1ss;
> > > +       struct pci_cap_saved_state *save_state;
> > > +       u32 *cap;
> > > +
> > > +       if (!pci_is_pcie(dev))
> > > +               return;
> > > +
> > > +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1S=
S);
> > > +       if (!aspm_l1ss)
> > > +               return;
> > > +
> > > +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1S=
S);
> > > +       if (!save_state)
> > > +               return;
> > > +
> > > +       cap =3D (u32 *)&save_state->cap.data[0];
> > > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++=
);
> > > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++=
);
> > > +}
> > > +
> > >  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> > >  {
> > >         pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > > --
> > > 2.17.1
> > >

Hi,

With this patch (and also mentioned
https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonica=
l.com/)
applied on 5.10 (chromeos-5.10) I am observing problems after
suspend/resume with my WiFi card - it looks like whole communication
via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911=
109dfb91ab0fc0e3

I played a little bit with this code and it looks like the
pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
why, not a PCI expert).

Best regards,
Lukasz
