Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE26584E32
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiG2Jjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiG2Jjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 05:39:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C30863C0
        for <linux-pci@vger.kernel.org>; Fri, 29 Jul 2022 02:39:30 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-322b5199358so42947137b3.6
        for <linux-pci@vger.kernel.org>; Fri, 29 Jul 2022 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CwH/d/sIqHDYK5xsWZYd5yGSd6KgMnTUiTsIbTqcNwY=;
        b=DJBeadA9lQb88BmBHiwZ0rLr/ECqbKiAIoVpPNp8/4KO8eARYXroYH/Sv8p6budTa4
         LmFiD8jNxsAFneGBLYVxjYZYUPHJu9+Wb+LM3JEdX2iKSm+JDWxCgwwSMIHWN5rGBIxQ
         DIhAQ0j1idrcR8M2aVU9hfeYUvxn6jaYsA/pct20LeIX1JbNLpSAGUdwVRRvBhhAzAPK
         kq8SHCiOl5yzIdC81ky9WckcI4cOccXNazKoMK8jxQAI6OKo216TjrxmKaamXubfz29F
         iwBy10QB0Z3OSRWl55mSAQ2zlLlhYQRyZAgzBw3En9nO1pRhKVdgTK5fm/RkpJxkJzsY
         xlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CwH/d/sIqHDYK5xsWZYd5yGSd6KgMnTUiTsIbTqcNwY=;
        b=0HZt6k3CXnTVZv+TMIJEe7APYifrqI496i7/vUMsQy7uMp2bRr04zNteo22HUIjokd
         xj+FHYchlDgeW4di8g+QWpP8fWNly2oSdbTnuQYzXAL7Oj8dYVkVDbwbMSD4peWVliNz
         4cdXqxEQMQxEAM+Lcrerr6IeRiIihnX++KFCJ3HeGw2ZExFCOILW6Q1X26qQ5YnZDRVW
         uedwRt0rTTikg8O4lEGg6cT/VpL/q+xonLPJMAcpg4KKgf4v7pbY+qrMDTJ0xvHqVRn9
         MoxVm/jBOgSzIRmeHlope6Qo4/CwFJsoPF9lJO46e14SjFZMDiET/By4kHRsQP6/6UG1
         OjPQ==
X-Gm-Message-State: ACgBeo0ERG3CMb137eVjdJAL223E7p0d5wdHBvjjSyVXGv2ByxdE2cen
        /+lvc+Ju04lV9KAGVpeQlZPFdkgNSZt170eatkxolAcpw1uTYA==
X-Google-Smtp-Source: AA6agR5g+6baB5lguK1ym1ZY5rqNDhBHGHUBXr/kfZUyYODC7fOjSo+PbS8fu7HJINLZkU1hH6fq5oOd/3g/9zv2pvc=
X-Received: by 2002:a0d:d085:0:b0:31e:dc35:ef9a with SMTP id
 s127-20020a0dd085000000b0031edc35ef9amr2427200ywd.453.1659087569643; Fri, 29
 Jul 2022 02:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174212.GA1911979@bhelgaas> <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com> <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
In-Reply-To: <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Fri, 29 Jul 2022 11:39:18 +0200
Message-ID: <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Rajat Jain <rajatja@google.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
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

wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisa=C5=82(a):
>
> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisa=C5=82(a):
> >
> > Hello,
> >
> > On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > >
> > > Agree with Bjorn's observations.
> > > The fact that the L1SS capability registers themselves disappeared in
> > > the root port post resume indicates that there seems to be something
> > > wrong with the BIOS itself.
> > > Could you please check from that perspective?
> >
> > ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. This
> > is a shallower sleep state that preserves more state than, for e.g. S3
> > (suspend-to-RAM). When we use S0ix, then BIOS does not come in picture
> > at all. i.e. after the kernel runs its suspend routines, it just puts
> > the CPU into S0ix state. So I do not think there is a BIOS angle to
> > this.
> >
> >
> > >
> > > Thanks,
> > > Vidya Sagar
> > >
> > >
> > > On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
> > > >> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.co=
m> napisa=C5=82(a):
> > > >>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.co=
m> wrote:
> > > >>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> w=
rote:
> > > >>>>>
> > > >>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) =
weren't
> > > >>>>> saved and restored during suspend/resume leading to L1 Substate=
s
> > > >>>>> configuration being lost post-resume.
> > > >>>>>
> > > >>>>> Save the L1 Substates control registers so that the configurati=
on is
> > > >>>>> retained post-resume.
> > > >>>>>
> > > >>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > >>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> > > >>>>
> > > >>>> Hi Vidya,
> > > >>>>
> > > >>>> I tested this patch on kernel v5.19-rc6.
> > > >>>> The test device is GL9755 card reader controller on Intel i5-102=
10U RVP.
> > > >>>> This patch can restore L1SS after suspend/resume.
> > > >>>>
> > > >>>> The test results are as follows:
> > > >>>>
> > > >>>> After Boot:
> > > >>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> > > >>>>          Capabilities: [110 v1] L1 PM Substates
> > > >>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > >>>> ASPM_L1.1+ L1_PM_Substates+
> > > >>>>                            PortCommonModeRestoreTime=3D255us
> > > >>>> PortTPowerOnTime=3D3100us
> > > >>>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+=
 ASPM_L1.1+
> > > >>>>                             T_CommonMode=3D0us LTR1.2_Threshold=
=3D3145728ns
> > > >>>>                  L1SubCtl2: T_PwrOn=3D3100us
> > > >>>>
> > > >>>>
> > > >>>> After suspend/resume without this patch.
> > > >>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> > > >>>>          Capabilities: [110 v1] L1 PM Substates
> > > >>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > >>>> ASPM_L1.1+ L1_PM_Substates+
> > > >>>>                            PortCommonModeRestoreTime=3D255us
> > > >>>> PortTPowerOnTime=3D3100us
> > > >>>>                  L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2-=
 ASPM_L1.1-
> > > >>>>                             T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > > >>>>                  L1SubCtl2: T_PwrOn=3D10us
> > > >>>>
> > > >>>>
> > > >>>> After suspend/resume with this patch.
> > > >>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> > > >>>>          Capabilities: [110 v1] L1 PM Substates
> > > >>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > >>>> ASPM_L1.1+ L1_PM_Substates+
> > > >>>>                            PortCommonModeRestoreTime=3D255us
> > > >>>> PortTPowerOnTime=3D3100us
> > > >>>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+=
 ASPM_L1.1+
> > > >>>>                             T_CommonMode=3D0us LTR1.2_Threshold=
=3D3145728ns
> > > >>>>                  L1SubCtl2: T_PwrOn=3D3100us
> > > >>>>
> > > >>>>
> > > >>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
> > > >>>
> > > >>> Forgot to add mine:
> > > >>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > >>>
> > > >>>>
> > > >>>> Best regards,
> > > >>>> Ben Chuang
> > > >>>>
> > > >>>>
> > > >>>>> ---
> > > >>>>> Hi,
> > > >>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify th=
is patch
> > > >>>>> on your laptop (Dell XPS 13) one last time?
> > > >>>>> IMHO, the regression observed on your laptop with an old versio=
n of the patch
> > > >>>>> could be due to a buggy old version BIOS in the laptop.
> > > >>>>>
> > > >>>>> Thanks,
> > > >>>>> Vidya Sagar
> > > >>>>>
> > > >>>>>   drivers/pci/pci.c       |  7 +++++++
> > > >>>>>   drivers/pci/pci.h       |  4 ++++
> > > >>>>>   drivers/pci/pcie/aspm.c | 44 ++++++++++++++++++++++++++++++++=
+++++++++
> > > >>>>>   3 files changed, 55 insertions(+)
> > > >>>>>
> > > >>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > >>>>> index cfaf40a540a8..aca05880aaa3 100644
> > > >>>>> --- a/drivers/pci/pci.c
> > > >>>>> +++ b/drivers/pci/pci.c
> > > >>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> > > >>>>>                  return i;
> > > >>>>>
> > > >>>>>          pci_save_ltr_state(dev);
> > > >>>>> +       pci_save_aspm_l1ss_state(dev);
> > > >>>>>          pci_save_dpc_state(dev);
> > > >>>>>          pci_save_aer_state(dev);
> > > >>>>>          pci_save_ptm_state(dev);
> > > >>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *de=
v)
> > > >>>>>           * LTR itself (in the PCIe capability).
> > > >>>>>           */
> > > >>>>>          pci_restore_ltr_state(dev);
> > > >>>>> +       pci_restore_aspm_l1ss_state(dev);
> > > >>>>>
> > > >>>>>          pci_restore_pcie_state(dev);
> > > >>>>>          pci_restore_pasid_state(dev);
> > > >>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struc=
t pci_dev *dev)
> > > >>>>>          if (error)
> > > >>>>>                  pci_err(dev, "unable to allocate suspend buffe=
r for LTR\n");
> > > >>>>>
> > > >>>>> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_=
ID_L1SS,
> > > >>>>> +                                           2 * sizeof(u32));
> > > >>>>> +       if (error)
> > > >>>>> +               pci_err(dev, "unable to allocate suspend buffer=
 for ASPM-L1SS\n");
> > > >>>>> +
> > > >>>>>          pci_allocate_vc_save_buffers(dev);
> > > >>>>>   }
> > > >>>>>
> > > >>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > >>>>> index e10cdec6c56e..92d8c92662a4 100644
> > > >>>>> --- a/drivers/pci/pci.h
> > > >>>>> +++ b/drivers/pci/pci.h
> > > >>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci=
_dev *pdev);
> > > >>>>>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> > > >>>>>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> > > >>>>>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > > >>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > > >>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > > >>>>>   #else
> > > >>>>>   static inline void pcie_aspm_init_link_state(struct pci_dev *=
pdev) { }
> > > >>>>>   static inline void pcie_aspm_exit_link_state(struct pci_dev *=
pdev) { }
> > > >>>>>   static inline void pcie_aspm_pm_state_change(struct pci_dev *=
pdev) { }
> > > >>>>>   static inline void pcie_aspm_powersave_config_link(struct pci=
_dev *pdev) { }
> > > >>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *de=
v) { }
> > > >>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev =
*dev) { }
> > > >>>>>   #endif
> > > >>>>>
> > > >>>>>   #ifdef CONFIG_PCIE_ECRC
> > > >>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > >>>>> index a96b7424c9bc..2c29fdd20059 100644
> > > >>>>> --- a/drivers/pci/pcie/aspm.c
> > > >>>>> +++ b/drivers/pci/pcie/aspm.c
> > > >>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct p=
cie_link_state *link, u32 state)
> > > >>>>>                                  PCI_L1SS_CTL1_L1SS_MASK, val);
> > > >>>>>   }
> > > >>>>>
> > > >>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> > > >>>>> +{
> > > >>>>> +       int aspm_l1ss;
> > > >>>>> +       struct pci_cap_saved_state *save_state;
> > > >>>>> +       u32 *cap;
> > > >>>>> +
> > > >>>>> +       if (!pci_is_pcie(dev))
> > > >>>>> +               return;
> > > >>>>> +
> > > >>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_=
ID_L1SS);
> > > >>>>> +       if (!aspm_l1ss)
> > > >>>>> +               return;
> > > >>>>> +
> > > >>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_=
ID_L1SS);
> > > >>>>> +       if (!save_state)
> > > >>>>> +               return;
> > > >>>>> +
> > > >>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> > > >>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, c=
ap++);
> > > >>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, c=
ap++);
> > > >>>>> +}
> > > >>>>> +
> > > >>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> > > >>>>> +{
> > > >>>>> +       int aspm_l1ss;
> > > >>>>> +       struct pci_cap_saved_state *save_state;
> > > >>>>> +       u32 *cap;
> > > >>>>> +
> > > >>>>> +       if (!pci_is_pcie(dev))
> > > >>>>> +               return;
> > > >>>>> +
> > > >>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_=
ID_L1SS);
> > > >>>>> +       if (!aspm_l1ss)
> > > >>>>> +               return;
> > > >>>>> +
> > > >>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_=
ID_L1SS);
> > > >>>>> +       if (!save_state)
> > > >>>>> +               return;
> > > >>>>> +
> > > >>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> > > >>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, =
*cap++);
> > > >>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, =
*cap++);
> > > >>>>> +}
> > > >>>>> +
> > > >>>>>   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 va=
l)
> > > >>>>>   {
> > > >>>>>          pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCT=
L,
> > > >>>>> --
> > > >>>>> 2.17.1
> > > >>>>>
> > > >>
> > > >> Hi,
> > > >>
> > > >> With this patch (and also mentioned
> > > >> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng=
@canonical.com/)
> > > >> applied on 5.10 (chromeos-5.10) I am observing problems after
> > > >> suspend/resume with my WiFi card - it looks like whole communicati=
on
> > > >> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/re=
sume
> > > >> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa=
2eff22911109dfb91ab0fc0e3
> > > >>
> > > >> I played a little bit with this code and it looks like the
> > > >> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't kno=
w
> > > >> why, not a PCI expert).
> > > >
> > > > Thanks a lot for testing this!  I'm not quite sure what to make of =
the
> > > > results since v5.10 is fairly old (Dec 2020) and I don't know what
> > > > other changes are in chromeos-5.10.
> >
> > Lukasz: I assume you are running this on Atlas and are seeing this bug
> > when uprev'ving it to 5.10 kernel. Can you please try it on a newer
> > Intel platform that have the latest upstream kernel running already
> > and see if this can be reproduced there too?
> > Note that the wifi PCI device is different on newer Intel platforms,
> > but platform design is similar enough that I suspect we should see
> > similar bug on those too. The other option is to try the latest
> > ustream kernel on Atlas. Perhaps if we just care about wifi (and
> > ignore bringing up the graphics stack and GUI), it may come up
> > sufficiently enough to try this patch?
> >
> > Thanks,
> >
> > Rajat
> >
> >
> > > >
> > > > Random observations, no analysis below.  This from your dmesg
> > > > certainly looks like PCI reads failing and returning ~0:
> > > >
> > > >    Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
> > > >    iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff fffff=
fff ffffffff ffffffff ffffffff ffffffff
> > > >    iwlwifi 0000:01:00.0: Device gone - attempting removal
> > > >    Hardware became unavailable upon resume. This could be a softwar=
e issue prior to suspend or a hardware issue.
> > > >
> > > > And then we re-enumerate 01:00.0 and it looks like it may have been
> > > > reset (BAR is 0):
> > > >
> > > >    pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
> > > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> > > >
> > > > lspci diffs from before/after suspend:
> > > >
> > > >     00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N42=
00/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal dec=
ode])
> > > >       Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-late=
ncy=3D64
> > > >    -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq=
+ AuxPwr+ TransPend-
> > > >    +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq=
- AuxPwr+ TransPend-
> > > >    -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled-=
 CommClk+
> > > >    +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- C=
ommClk+
> > > >    -               LnkSta2: Current De-emphasis Level: -6dB, Equali=
zationComplete- EqualizationPhase1-
> > > >    +               LnkSta2: Current De-emphasis Level: -3.5dB, Equa=
lizationComplete- EqualizationPhase1-
> > > >    -       Capabilities: [150 v0] Null
> > > >    -       Capabilities: [200 v1] L1 PM Substates
> > > >    -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ A=
SPM_L1.1+ L1_PM_Substates+
> > > >    -                         PortCommonModeRestoreTime=3D40us PortT=
PowerOnTime=3D10us
> > > >    -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+
> > > >    -                          T_CommonMode=3D40us LTR1.2_Threshold=
=3D98304ns
> > > >    -               L1SubCtl2: T_PwrOn=3D60us
> > > >
> > > > The DevSta differences might be BIOS bugs, probably not relevant.
> > > > Interesting that ASPM is disabled, maybe didn't get enabled after
> > > > re-enumerating 01:00.0?  Strange that the L1 PM Substates capabilit=
y
> > > > disappeared.
> > > >
> > > >     01:00.0 Network controller: Intel Corporation Wireless 7265 (re=
v 59)
> > > >                    LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled-=
 CommClk+
> > > >    -                       ExtSynch- ClockPM+ AutWidDis- BWInt- Aut=
BWInt-
> > > >    +                       ExtSynch- ClockPM- AutWidDis- BWInt- Aut=
BWInt-
> > > >            Capabilities: [154 v1] L1 PM Substates
> > > >                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ A=
SPM_L1.1+ L1_PM_Substates+
> > > >                              PortCommonModeRestoreTime=3D30us PortT=
PowerOnTime=3D60us
> > > >    -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+
> > > >    -                          T_CommonMode=3D0us LTR1.2_Threshold=
=3D98304ns
> > > >    +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- =
ASPM_L1.1-
> > > >    +                          T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > > >
> > > > Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn=
't
> > > > get reinitialized after re-enumeration?  Looks like we didn't resto=
re
> > > > L1SubCtl1.
> > > >
> > > > Bjorn
> > > >
>
> Hi,
>
> Thank you all for the response and input! As Rajat mentioned I'm using
> chromebook - but not Atlas (Amberlake) - in this case it is Babymega
> (Apollolake)  - I will try to load most recent kernel and give it a
> try once again.
>
> Best regards,
> Lukasz

Hi,

 I have applied this patch on top of v5.19-rc7 (chromeos) and I'm
still getting same results:
https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d6711b2030e=
a34b9

Best regards,
Lukasz
