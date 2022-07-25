Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1635807CE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiGYWvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiGYWvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 18:51:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B854BE0E
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 15:51:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y1so3666452pja.4
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oQl3b0Y0OWQGmD6OeMqO+0BUbxh+KUZ2h2bIFwKAGfs=;
        b=MAkWfzvzy0or3fzfzgFlB5B4RGO9w2MonCI/Dficd1Z7TdT7VeOP9IZRP0Bjcp6F1F
         1i0Kuzab82YMpJ0sGTEzS4HgKdT9Xsx0/dEM3lXa2Qsk96q2+a5MCgbHM0auTmLyqOcw
         X3f9psGzSobeIdZ1g6gjEOropBeP3uyAQIQv9PNiPJM3HOf7ZOmIHbRCLunB7IZLDxF6
         oyNMMSsTO9ZM4XHhrA5HCEqmctldYlp/gjpxhARp7a1m6OPwCNRuIkqZKeL/QsX+tIgg
         Z4JRCOGTcedPRVUYyESzBt5wG9RFFeWkZRHDMPRHgbE7CfcKAUY3DWyigrm9VuVqDWb+
         lvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oQl3b0Y0OWQGmD6OeMqO+0BUbxh+KUZ2h2bIFwKAGfs=;
        b=4+x6cJLwQsoKz7UwEz5U7dvcLYGzq99eWiT+9M2FytBWk06YfgeBX1xAq+ap2LTilB
         GeeYX8jrXO8in9bal0Os0A6bpbzWI4zFCeoKGzsSHI4hQBlXQI8Cecp7vb6GakMpa42s
         P2RBDeQ5uSqpu2fuUE6WZcodddfDSkL8r2mBnPnvTkdvqA4heLG/BBivf2xLg6eyVuYc
         LeXIbuV9Z3Y3hc0tjgs1a2jQCzhE096GouKf6sKaovqycCfBxnwQd1OeUD4BfL2zBQbO
         CvpYj7EN3nTa/0X+bNaKHDhOgJrJIQuKm96c3zms1YKO5GlrhwVQ9H4JPxRzusyKkVXY
         i1KQ==
X-Gm-Message-State: AJIora9Y/pNbuhzrDPyQ7T2hk7/Wzt/nnbUoObbE+Hv5Cf+teahRXTAk
        xKgANndIlGNupogLC+yGk4ILO0Zv1tLNnMZ1sMRfZg==
X-Google-Smtp-Source: AGRyM1tH+6fD4PAN8XDs+R7sKRL32DENvehHlyIk1TIM3YZmZdHuN0ePTaPnjepCxP30H8zWdWadqXTtTo5u+dZYYxw=
X-Received: by 2002:a17:902:ead2:b0:16d:e8c:ddd5 with SMTP id
 p18-20020a170902ead200b0016d0e8cddd5mr13921830pld.99.1658789480369; Mon, 25
 Jul 2022 15:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174212.GA1911979@bhelgaas> <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
In-Reply-To: <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 25 Jul 2022 15:50:44 -0700
Message-ID: <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lukasz Majczak <lma@semihalf.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Agree with Bjorn's observations.
> The fact that the L1SS capability registers themselves disappeared in
> the root port post resume indicates that there seems to be something
> wrong with the BIOS itself.
> Could you please check from that perspective?

ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. This
is a shallower sleep state that preserves more state than, for e.g. S3
(suspend-to-RAM). When we use S0ix, then BIOS does not come in picture
at all. i.e. after the kernel runs its suspend routines, it just puts
the CPU into S0ix state. So I do not think there is a BIOS angle to
this.


>
> Thanks,
> Vidya Sagar
>
>
> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
> >> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> n=
apisa=C5=82(a):
> >>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> w=
rote:
> >>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote=
:
> >>>>>
> >>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) were=
n't
> >>>>> saved and restored during suspend/resume leading to L1 Substates
> >>>>> configuration being lost post-resume.
> >>>>>
> >>>>> Save the L1 Substates control registers so that the configuration i=
s
> >>>>> retained post-resume.
> >>>>>
> >>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> >>>>
> >>>> Hi Vidya,
> >>>>
> >>>> I tested this patch on kernel v5.19-rc6.
> >>>> The test device is GL9755 card reader controller on Intel i5-10210U =
RVP.
> >>>> This patch can restore L1SS after suspend/resume.
> >>>>
> >>>> The test results are as follows:
> >>>>
> >>>> After Boot:
> >>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>          Capabilities: [110 v1] L1 PM Substates
> >>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> >>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>                            PortCommonModeRestoreTime=3D255us
> >>>> PortTPowerOnTime=3D3100us
> >>>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASP=
M_L1.1+
> >>>>                             T_CommonMode=3D0us LTR1.2_Threshold=3D31=
45728ns
> >>>>                  L1SubCtl2: T_PwrOn=3D3100us
> >>>>
> >>>>
> >>>> After suspend/resume without this patch.
> >>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>          Capabilities: [110 v1] L1 PM Substates
> >>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> >>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>                            PortCommonModeRestoreTime=3D255us
> >>>> PortTPowerOnTime=3D3100us
> >>>>                  L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASP=
M_L1.1-
> >>>>                             T_CommonMode=3D0us LTR1.2_Threshold=3D0n=
s
> >>>>                  L1SubCtl2: T_PwrOn=3D10us
> >>>>
> >>>>
> >>>> After suspend/resume with this patch.
> >>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>          Capabilities: [110 v1] L1 PM Substates
> >>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> >>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>                            PortCommonModeRestoreTime=3D255us
> >>>> PortTPowerOnTime=3D3100us
> >>>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASP=
M_L1.1+
> >>>>                             T_CommonMode=3D0us LTR1.2_Threshold=3D31=
45728ns
> >>>>                  L1SubCtl2: T_PwrOn=3D3100us
> >>>>
> >>>>
> >>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
> >>>
> >>> Forgot to add mine:
> >>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>
> >>>>
> >>>> Best regards,
> >>>> Ben Chuang
> >>>>
> >>>>
> >>>>> ---
> >>>>> Hi,
> >>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this p=
atch
> >>>>> on your laptop (Dell XPS 13) one last time?
> >>>>> IMHO, the regression observed on your laptop with an old version of=
 the patch
> >>>>> could be due to a buggy old version BIOS in the laptop.
> >>>>>
> >>>>> Thanks,
> >>>>> Vidya Sagar
> >>>>>
> >>>>>   drivers/pci/pci.c       |  7 +++++++
> >>>>>   drivers/pci/pci.h       |  4 ++++
> >>>>>   drivers/pci/pcie/aspm.c | 44 ++++++++++++++++++++++++++++++++++++=
+++++
> >>>>>   3 files changed, 55 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>> index cfaf40a540a8..aca05880aaa3 100644
> >>>>> --- a/drivers/pci/pci.c
> >>>>> +++ b/drivers/pci/pci.c
> >>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> >>>>>                  return i;
> >>>>>
> >>>>>          pci_save_ltr_state(dev);
> >>>>> +       pci_save_aspm_l1ss_state(dev);
> >>>>>          pci_save_dpc_state(dev);
> >>>>>          pci_save_aer_state(dev);
> >>>>>          pci_save_ptm_state(dev);
> >>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> >>>>>           * LTR itself (in the PCIe capability).
> >>>>>           */
> >>>>>          pci_restore_ltr_state(dev);
> >>>>> +       pci_restore_aspm_l1ss_state(dev);
> >>>>>
> >>>>>          pci_restore_pcie_state(dev);
> >>>>>          pci_restore_pasid_state(dev);
> >>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pc=
i_dev *dev)
> >>>>>          if (error)
> >>>>>                  pci_err(dev, "unable to allocate suspend buffer fo=
r LTR\n");
> >>>>>
> >>>>> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L=
1SS,
> >>>>> +                                           2 * sizeof(u32));
> >>>>> +       if (error)
> >>>>> +               pci_err(dev, "unable to allocate suspend buffer for=
 ASPM-L1SS\n");
> >>>>> +
> >>>>>          pci_allocate_vc_save_buffers(dev);
> >>>>>   }
> >>>>>
> >>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>> index e10cdec6c56e..92d8c92662a4 100644
> >>>>> --- a/drivers/pci/pci.h
> >>>>> +++ b/drivers/pci/pci.h
> >>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev=
 *pdev);
> >>>>>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >>>>>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >>>>>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> >>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> >>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>   #else
> >>>>>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev=
) { }
> >>>>>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev=
) { }
> >>>>>   static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev=
) { }
> >>>>>   static inline void pcie_aspm_powersave_config_link(struct pci_dev=
 *pdev) { }
> >>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) {=
 }
> >>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev=
) { }
> >>>>>   #endif
> >>>>>
> >>>>>   #ifdef CONFIG_PCIE_ECRC
> >>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >>>>> index a96b7424c9bc..2c29fdd20059 100644
> >>>>> --- a/drivers/pci/pcie/aspm.c
> >>>>> +++ b/drivers/pci/pcie/aspm.c
> >>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_=
link_state *link, u32 state)
> >>>>>                                  PCI_L1SS_CTL1_L1SS_MASK, val);
> >>>>>   }
> >>>>>
> >>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> >>>>> +{
> >>>>> +       int aspm_l1ss;
> >>>>> +       struct pci_cap_saved_state *save_state;
> >>>>> +       u32 *cap;
> >>>>> +
> >>>>> +       if (!pci_is_pcie(dev))
> >>>>> +               return;
> >>>>> +
> >>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L=
1SS);
> >>>>> +       if (!aspm_l1ss)
> >>>>> +               return;
> >>>>> +
> >>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L=
1SS);
> >>>>> +       if (!save_state)
> >>>>> +               return;
> >>>>> +
> >>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++=
);
> >>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++=
);
> >>>>> +}
> >>>>> +
> >>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> >>>>> +{
> >>>>> +       int aspm_l1ss;
> >>>>> +       struct pci_cap_saved_state *save_state;
> >>>>> +       u32 *cap;
> >>>>> +
> >>>>> +       if (!pci_is_pcie(dev))
> >>>>> +               return;
> >>>>> +
> >>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L=
1SS);
> >>>>> +       if (!aspm_l1ss)
> >>>>> +               return;
> >>>>> +
> >>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L=
1SS);
> >>>>> +       if (!save_state)
> >>>>> +               return;
> >>>>> +
> >>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap=
++);
> >>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap=
++);
> >>>>> +}
> >>>>> +
> >>>>>   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> >>>>>   {
> >>>>>          pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> >>>>> --
> >>>>> 2.17.1
> >>>>>
> >>
> >> Hi,
> >>
> >> With this patch (and also mentioned
> >> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@can=
onical.com/)
> >> applied on 5.10 (chromeos-5.10) I am observing problems after
> >> suspend/resume with my WiFi card - it looks like whole communication
> >> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
> >> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff=
22911109dfb91ab0fc0e3
> >>
> >> I played a little bit with this code and it looks like the
> >> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
> >> why, not a PCI expert).
> >
> > Thanks a lot for testing this!  I'm not quite sure what to make of the
> > results since v5.10 is fairly old (Dec 2020) and I don't know what
> > other changes are in chromeos-5.10.

Lukasz: I assume you are running this on Atlas and are seeing this bug
when uprev'ving it to 5.10 kernel. Can you please try it on a newer
Intel platform that have the latest upstream kernel running already
and see if this can be reproduced there too?
Note that the wifi PCI device is different on newer Intel platforms,
but platform design is similar enough that I suspect we should see
similar bug on those too. The other option is to try the latest
ustream kernel on Atlas. Perhaps if we just care about wifi (and
ignore bringing up the graphics stack and GUI), it may come up
sufficiently enough to try this patch?

Thanks,

Rajat


> >
> > Random observations, no analysis below.  This from your dmesg
> > certainly looks like PCI reads failing and returning ~0:
> >
> >    Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
> >    iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff =
ffffffff ffffffff ffffffff ffffffff
> >    iwlwifi 0000:01:00.0: Device gone - attempting removal
> >    Hardware became unavailable upon resume. This could be a software is=
sue prior to suspend or a hardware issue.
> >
> > And then we re-enumerate 01:00.0 and it looks like it may have been
> > reset (BAR is 0):
> >
> >    pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
> >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> >
> > lspci diffs from before/after suspend:
> >
> >     00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/A=
tom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode]=
)
> >       Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D64
> >    -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ Au=
xPwr+ TransPend-
> >    +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- Au=
xPwr+ TransPend-
> >    -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- Com=
mClk+
> >    +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommC=
lk+
> >    -               LnkSta2: Current De-emphasis Level: -6dB, Equalizati=
onComplete- EqualizationPhase1-
> >    +               LnkSta2: Current De-emphasis Level: -3.5dB, Equaliza=
tionComplete- EqualizationPhase1-
> >    -       Capabilities: [150 v0] Null
> >    -       Capabilities: [200 v1] L1 PM Substates
> >    -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_=
L1.1+ L1_PM_Substates+
> >    -                         PortCommonModeRestoreTime=3D40us PortTPowe=
rOnTime=3D10us
> >    -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM=
_L1.1+
> >    -                          T_CommonMode=3D40us LTR1.2_Threshold=3D98=
304ns
> >    -               L1SubCtl2: T_PwrOn=3D60us
> >
> > The DevSta differences might be BIOS bugs, probably not relevant.
> > Interesting that ASPM is disabled, maybe didn't get enabled after
> > re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
> > disappeared.
> >
> >     01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59=
)
> >                    LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- Com=
mClk+
> >    -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWIn=
t-
> >    +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWIn=
t-
> >            Capabilities: [154 v1] L1 PM Substates
> >                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_=
L1.1+ L1_PM_Substates+
> >                              PortCommonModeRestoreTime=3D30us PortTPowe=
rOnTime=3D60us
> >    -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM=
_L1.1+
> >    -                          T_CommonMode=3D0us LTR1.2_Threshold=3D983=
04ns
> >    +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM=
_L1.1-
> >    +                          T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >
> > Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
> > get reinitialized after re-enumeration?  Looks like we didn't restore
> > L1SubCtl1.
> >
> > Bjorn
> >
