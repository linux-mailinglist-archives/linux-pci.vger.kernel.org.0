Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030395A617A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 13:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiH3LQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiH3LQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 07:16:15 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CFBE9A8D
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 04:16:07 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id i1so952016vsc.9
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=OzbYKdIRltO99+RVB91H6dr8/Wd8BfZRMvwXAImCjfk=;
        b=CY67mmPMr09V5AHBh2kdygqYUEdnk6LPjEKMxiomjVISO/UkH6MNgH1SpMHNuwFDM5
         lUozoRGuVMKTbsbvuP3LLdEBRir0aWhc2vHja28NdSvTFqdddGiiDZDuYNOCyxSZ/XDv
         HKVqIekFphWwr7nGN3h59IytG4NCkrM1ylWDQ1uw6IJsGMaeu5tuC+zsFSrfKTgyZ84j
         8FCUj1qC7NJQdScw4fZoT82XroEKiMKVkde2DH68XIFHPgAzuSC7km0S+uM7P5V/Oe1I
         baNosj1S7mHcR3zrMRyca3lxSStcvfrrU5/X+jXibMOQnJ0xenjXs/4mJR07YTXqmn7F
         xd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=OzbYKdIRltO99+RVB91H6dr8/Wd8BfZRMvwXAImCjfk=;
        b=xgc/QF0fBBggVtPP+2xjzL200HXfyhOhIlpoG41PierQbHjT1oM5QCDqarbvngbQIo
         c5DtvkgWaE4NeDGQLRYvuzOUVDV8+q9DGcY317iCZaTTgewRf+7mJzI0vsSwQK9EhmAK
         R4UzkKCLcPd75xEmfEcKXQTFLCJkitReHWy4bfU0GzjgGsvkAdXb9hLCt99VG6Z0miS7
         AaLa1hMMl3+rP2AIrDp9fFFh4Ub79CAivgonIg3ASF36Wd4IM9SAYY7laAMCU+qpOF8P
         v5KU6cTf8AY4YXivdC9IUIx5ITm5fRIDVZg2V0gt4P5WHmM59asVIvJkb8vRKxNivmY2
         YvdA==
X-Gm-Message-State: ACgBeo06TcmO3iF8H0EeWfgtcXhfZqJ345n1Kqz5e10leHEWZRljS3Jb
        kRVl+SVzJDEzGFK2JHw/mFPAO1/jK8Y+0otAbTDUag==
X-Google-Smtp-Source: AA6agR4z24D18J3wcvCYFAYOC55ZPQwMVyHpuPtTD3HzN2pGH2xyThlGbEZoUiyHiMNoYq37QpJxFqCAXuIJWl432Sc=
X-Received: by 2002:a05:6102:1da:b0:390:e9ad:2b05 with SMTP id
 s26-20020a05610201da00b00390e9ad2b05mr2210644vsq.28.1661858165825; Tue, 30
 Aug 2022 04:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174212.GA1911979@bhelgaas> <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
 <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
 <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
 <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com> <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
 <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com> <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
 <b841fe9f-6091-ff55-cd0f-76bc6b04ff46@nvidia.com> <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
 <eb420ee1-424a-5688-8610-9d3e510d0327@nvidia.com>
In-Reply-To: <eb420ee1-424a-5688-8610-9d3e510d0327@nvidia.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Tue, 30 Aug 2022 13:15:54 +0200
Message-ID: <CAFJ_xbpNLvnWe9uEFxSEPb3mch--Ukf24wUAS9b5kuCxSr8p5A@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pt., 26 sie 2022 o 15:00 Vidya Sagar <vidyas@nvidia.com> napisa=C5=82(a):
>
>
>
> On 8/23/2022 8:25 PM, Kai-Heng Feng wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Hi Vidya,
> >
> > On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> >>
> >> Thanks Lukasz for the update.
> >> I think confirms that there is no issue with the patch as such.
> >> Bjorn, could you please define the next step for this patch?
> >
> > I think the L1SS cap went away _after_ L1SS registers are restored,
> > since your patch already check the cap before doing any write:
> > +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS)=
;
> > +       if (!aspm_l1ss)
> > +               return;
> >
> > That means it's more likely to be caused by the following change:
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> >
> > So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2,
> > like what aspm_calc_l1ss_info() does?
>
> I posted a new patch
> https://patchwork.kernel.org/project/linux-pci/patch/20220826125526.28859=
-1-vidyas@nvidia.com/
> keeping L1.2 disabled while restoring the rest of the fields in
> Control-1 register and restoring the L1.2 enable bits later. Could you
> please try this new patch on your setup and update your observations?
>
> Thanks & Regards,
> Vidya Sagar
>
> >
> > Kai-Heng
> >
> >>
> >> Thanks,
> >> Vidya Sagar
> >>
> >> On 8/8/2022 7:37 PM, Lukasz Majczak wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> =C5=9Br., 3 sie 2022 o 14:55 Vidya Sagar <vidyas@nvidia.com> napisa=
=C5=82(a):
> >>>>
> >>>> Thanks Lukasz for the logs.
> >>>> I still that the L1SS capability in the root port (00:14.0) disappea=
red
> >>>> after resume.
> >>>> I still don't understand how this patch can make the capability regi=
ster
> >>>> itself disappear. Honestly, I still see this as a HW issue.
> >>>> Bjorn, could you please throw some light on this?
> >>>>
> >>>> Thanks,
> >>>> Vidya Sagar
> >>>>
> >>>> On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
> >>>>> External email: Use caution opening links or attachments
> >>>>>
> >>>>>
> >>>>> pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisa=C5=
=82(a):
> >>>>>>
> >>>>>> Hi Lukasz,
> >>>>>> Thanks for sharing your observations.
> >>>>>>
> >>>>>> Could you please also share the output of 'sudo lspci -vvvv' befor=
e and
> >>>>>> after suspend-resume cycle with the latest linux-next?
> >>>>>> Do we still see the L1SS capabilities getting disappeared post res=
ume?
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Vidya Sagar
> >>>>>>
> >>>>>> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
> >>>>>>> External email: Use caution opening links or attachments
> >>>>>>>
> >>>>>>>
> >>>>>>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisa=
=C5=82(a):
> >>>>>>>>
> >>>>>>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisa=
=C5=82(a):
> >>>>>>>>>
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com=
> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Agree with Bjorn's observations.
> >>>>>>>>>> The fact that the L1SS capability registers themselves disappe=
ared in
> >>>>>>>>>> the root port post resume indicates that there seems to be som=
ething
> >>>>>>>>>> wrong with the BIOS itself.
> >>>>>>>>>> Could you please check from that perspective?
> >>>>>>>>>
> >>>>>>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend=
. This
> >>>>>>>>> is a shallower sleep state that preserves more state than, for =
e.g. S3
> >>>>>>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in =
picture
> >>>>>>>>> at all. i.e. after the kernel runs its suspend routines, it jus=
t puts
> >>>>>>>>> the CPU into S0ix state. So I do not think there is a BIOS angl=
e to
> >>>>>>>>> this.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>> Vidya Sagar
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> >>>>>>>>>>> External email: Use caution opening links or attachments
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrot=
e:
> >>>>>>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canoni=
cal.com> napisa=C5=82(a):
> >>>>>>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gm=
ail.com> wrote:
> >>>>>>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.=
com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and =
CTL2) weren't
> >>>>>>>>>>>>>>> saved and restored during suspend/resume leading to L1 Su=
bstates
> >>>>>>>>>>>>>>> configuration being lost post-resume.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Save the L1 Substates control registers so that the confi=
guration is
> >>>>>>>>>>>>>>> retained post-resume.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>>>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Hi Vidya,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I tested this patch on kernel v5.19-rc6.
> >>>>>>>>>>>>>> The test device is GL9755 card reader controller on Intel =
i5-10210U RVP.
> >>>>>>>>>>>>>> This patch can restore L1SS after suspend/resume.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The test results are as follows:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> After Boot:
> >>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>>>              Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ A=
SPM_L1.2+
> >>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>>                                PortCommonModeRestoreTime=
=3D255us
> >>>>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>>>                      L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ =
ASPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>>>                                 T_CommonMode=3D0us LTR1.2_=
Threshold=3D3145728ns
> >>>>>>>>>>>>>>                      L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> After suspend/resume without this patch.
> >>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>>>              Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ A=
SPM_L1.2+
> >>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>>                                PortCommonModeRestoreTime=
=3D255us
> >>>>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>>>                      L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- =
ASPM_L1.2- ASPM_L1.1-
> >>>>>>>>>>>>>>                                 T_CommonMode=3D0us LTR1.2_=
Threshold=3D0ns
> >>>>>>>>>>>>>>                      L1SubCtl2: T_PwrOn=3D10us
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> After suspend/resume with this patch.
> >>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>>>              Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ A=
SPM_L1.2+
> >>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>>                                PortCommonModeRestoreTime=
=3D255us
> >>>>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>>>                      L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ =
ASPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>>>                                 T_CommonMode=3D0us LTR1.2_=
Threshold=3D3145728ns
> >>>>>>>>>>>>>>                      L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Forgot to add mine:
> >>>>>>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Best regards,
> >>>>>>>>>>>>>> Ben Chuang
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please ver=
ify this patch
> >>>>>>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
> >>>>>>>>>>>>>>> IMHO, the regression observed on your laptop with an old =
version of the patch
> >>>>>>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>> Vidya Sagar
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>       drivers/pci/pci.c       |  7 +++++++
> >>>>>>>>>>>>>>>       drivers/pci/pci.h       |  4 ++++
> >>>>>>>>>>>>>>>       drivers/pci/pcie/aspm.c | 44 ++++++++++++++++++++++=
+++++++++++++++++++
> >>>>>>>>>>>>>>>       3 files changed, 55 insertions(+)
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>>>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
> >>>>>>>>>>>>>>> --- a/drivers/pci/pci.c
> >>>>>>>>>>>>>>> +++ b/drivers/pci/pci.c
> >>>>>>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *=
dev)
> >>>>>>>>>>>>>>>                      return i;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>              pci_save_ltr_state(dev);
> >>>>>>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
> >>>>>>>>>>>>>>>              pci_save_dpc_state(dev);
> >>>>>>>>>>>>>>>              pci_save_aer_state(dev);
> >>>>>>>>>>>>>>>              pci_save_ptm_state(dev);
> >>>>>>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_d=
ev *dev)
> >>>>>>>>>>>>>>>               * LTR itself (in the PCIe capability).
> >>>>>>>>>>>>>>>               */
> >>>>>>>>>>>>>>>              pci_restore_ltr_state(dev);
> >>>>>>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>              pci_restore_pcie_state(dev);
> >>>>>>>>>>>>>>>              pci_restore_pasid_state(dev);
> >>>>>>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers=
(struct pci_dev *dev)
> >>>>>>>>>>>>>>>              if (error)
> >>>>>>>>>>>>>>>                      pci_err(dev, "unable to allocate sus=
pend buffer for LTR\n");
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EX=
T_CAP_ID_L1SS,
> >>>>>>>>>>>>>>> +                                           2 * sizeof(u3=
2));
> >>>>>>>>>>>>>>> +       if (error)
> >>>>>>>>>>>>>>> +               pci_err(dev, "unable to allocate suspend =
buffer for ASPM-L1SS\n");
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>              pci_allocate_vc_save_buffers(dev);
> >>>>>>>>>>>>>>>       }
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>>>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
> >>>>>>>>>>>>>>> --- a/drivers/pci/pci.h
> >>>>>>>>>>>>>>> +++ b/drivers/pci/pci.h
> >>>>>>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(stru=
ct pci_dev *pdev);
> >>>>>>>>>>>>>>>       void pcie_aspm_exit_link_state(struct pci_dev *pdev=
);
> >>>>>>>>>>>>>>>       void pcie_aspm_pm_state_change(struct pci_dev *pdev=
);
> >>>>>>>>>>>>>>>       void pcie_aspm_powersave_config_link(struct pci_dev=
 *pdev);
> >>>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>>>>>       #else
> >>>>>>>>>>>>>>>       static inline void pcie_aspm_init_link_state(struct=
 pci_dev *pdev) { }
> >>>>>>>>>>>>>>>       static inline void pcie_aspm_exit_link_state(struct=
 pci_dev *pdev) { }
> >>>>>>>>>>>>>>>       static inline void pcie_aspm_pm_state_change(struct=
 pci_dev *pdev) { }
> >>>>>>>>>>>>>>>       static inline void pcie_aspm_powersave_config_link(=
struct pci_dev *pdev) { }
> >>>>>>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_d=
ev *dev) { }
> >>>>>>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pc=
i_dev *dev) { }
> >>>>>>>>>>>>>>>       #endif
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>       #ifdef CONFIG_PCIE_ECRC
> >>>>>>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/a=
spm.c
> >>>>>>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
> >>>>>>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
> >>>>>>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
> >>>>>>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(st=
ruct pcie_link_state *link, u32 state)
> >>>>>>>>>>>>>>>                                      PCI_L1SS_CTL1_L1SS_M=
ASK, val);
> >>>>>>>>>>>>>>>       }
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EX=
T_CAP_ID_L1SS);
> >>>>>>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EX=
T_CAP_ID_L1SS);
> >>>>>>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_C=
TL2, cap++);
> >>>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_C=
TL1, cap++);
> >>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EX=
T_CAP_ID_L1SS);
> >>>>>>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EX=
T_CAP_ID_L1SS);
> >>>>>>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_=
CTL2, *cap++);
> >>>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_=
CTL1, *cap++);
> >>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>       static void pcie_config_aspm_dev(struct pci_dev *pd=
ev, u32 val)
> >>>>>>>>>>>>>>>       {
> >>>>>>>>>>>>>>>              pcie_capability_clear_and_set_word(pdev, PCI=
_EXP_LNKCTL,
> >>>>>>>>>>>>>>> --
> >>>>>>>>>>>>>>> 2.17.1
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>> With this patch (and also mentioned
> >>>>>>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.hen=
g.feng@canonical.com/)
> >>>>>>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems afte=
r
> >>>>>>>>>>>> suspend/resume with my WiFi card - it looks like whole commu=
nication
> >>>>>>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before susp=
end/resume
> >>>>>>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/f=
b36dfa2eff22911109dfb91ab0fc0e3
> >>>>>>>>>>>>
> >>>>>>>>>>>> I played a little bit with this code and it looks like the
> >>>>>>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don=
't know
> >>>>>>>>>>>> why, not a PCI expert).
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks a lot for testing this!  I'm not quite sure what to ma=
ke of the
> >>>>>>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know=
 what
> >>>>>>>>>>> other changes are in chromeos-5.10.
> >>>>>>>>>
> >>>>>>>>> Lukasz: I assume you are running this on Atlas and are seeing t=
his bug
> >>>>>>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a n=
ewer
> >>>>>>>>> Intel platform that have the latest upstream kernel running alr=
eady
> >>>>>>>>> and see if this can be reproduced there too?
> >>>>>>>>> Note that the wifi PCI device is different on newer Intel platf=
orms,
> >>>>>>>>> but platform design is similar enough that I suspect we should =
see
> >>>>>>>>> similar bug on those too. The other option is to try the latest
> >>>>>>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (an=
d
> >>>>>>>>> ignore bringing up the graphics stack and GUI), it may come up
> >>>>>>>>> sufficiently enough to try this patch?
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>>
> >>>>>>>>> Rajat
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Random observations, no analysis below.  This from your dmesg
> >>>>>>>>>>> certainly looks like PCI reads failing and returning ~0:
> >>>>>>>>>>>
> >>>>>>>>>>>        Timeout waiting for hardware access (CSR_GP_CNTRL 0xff=
ffffff)
> >>>>>>>>>>>        iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffff=
ffff ffffffff ffffffff ffffffff ffffffff ffffffff
> >>>>>>>>>>>        iwlwifi 0000:01:00.0: Device gone - attempting removal
> >>>>>>>>>>>        Hardware became unavailable upon resume. This could be=
 a software issue prior to suspend or a hardware issue.
> >>>>>>>>>>>
> >>>>>>>>>>> And then we re-enumerate 01:00.0 and it looks like it may hav=
e been
> >>>>>>>>>>> reset (BAR is 0):
> >>>>>>>>>>>
> >>>>>>>>>>>        pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
> >>>>>>>>>>>        pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff=
 64bit]
> >>>>>>>>>>>
> >>>>>>>>>>> lspci diffs from before/after suspend:
> >>>>>>>>>>>
> >>>>>>>>>>>         00:14.0 PCI bridge: Intel Corporation Celeron N3350/P=
entium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [=
Normal decode])
> >>>>>>>>>>>           Bus: primary=3D00, secondary=3D01, subordinate=3D01=
, sec-latency=3D64
> >>>>>>>>>>>        -               DevSta: CorrErr- NonFatalErr+ FatalErr=
- UnsupReq+ AuxPwr+ TransPend-
> >>>>>>>>>>>        +               DevSta: CorrErr+ NonFatalErr- FatalErr=
- UnsupReq- AuxPwr+ TransPend-
> >>>>>>>>>>>        -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes,=
 Disabled- CommClk+
> >>>>>>>>>>>        +               LnkCtl: ASPM Disabled; RCB 64 bytes, D=
isabled- CommClk+
> >>>>>>>>>>>        -               LnkSta2: Current De-emphasis Level: -6=
dB, EqualizationComplete- EqualizationPhase1-
> >>>>>>>>>>>        +               LnkSta2: Current De-emphasis Level: -3=
.5dB, EqualizationComplete- EqualizationPhase1-
> >>>>>>>>>>>        -       Capabilities: [150 v0] Null
> >>>>>>>>>>>        -       Capabilities: [200 v1] L1 PM Substates
> >>>>>>>>>>>        -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ AS=
PM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>        -                         PortCommonModeRestoreTime=3D=
40us PortTPowerOnTime=3D10us
> >>>>>>>>>>>        -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ A=
SPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>        -                          T_CommonMode=3D40us LTR1.2_=
Threshold=3D98304ns
> >>>>>>>>>>>        -               L1SubCtl2: T_PwrOn=3D60us
> >>>>>>>>>>>
> >>>>>>>>>>> The DevSta differences might be BIOS bugs, probably not relev=
ant.
> >>>>>>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled a=
fter
> >>>>>>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates cap=
ability
> >>>>>>>>>>> disappeared.
> >>>>>>>>>>>
> >>>>>>>>>>>         01:00.0 Network controller: Intel Corporation Wireles=
s 7265 (rev 59)
> >>>>>>>>>>>                        LnkCtl: ASPM L1 Enabled; RCB 64 bytes,=
 Disabled- CommClk+
> >>>>>>>>>>>        -                       ExtSynch- ClockPM+ AutWidDis- =
BWInt- AutBWInt-
> >>>>>>>>>>>        +                       ExtSynch- ClockPM- AutWidDis- =
BWInt- AutBWInt-
> >>>>>>>>>>>                Capabilities: [154 v1] L1 PM Substates
> >>>>>>>>>>>                        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ AS=
PM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>                                  PortCommonModeRestoreTime=3D=
30us PortTPowerOnTime=3D60us
> >>>>>>>>>>>        -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ A=
SPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>        -                          T_CommonMode=3D0us LTR1.2_T=
hreshold=3D98304ns
> >>>>>>>>>>>        +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- A=
SPM_L1.2- ASPM_L1.1-
> >>>>>>>>>>>        +                          T_CommonMode=3D0us LTR1.2_T=
hreshold=3D0ns
> >>>>>>>>>>>
> >>>>>>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASP=
M didn't
> >>>>>>>>>>> get reinitialized after re-enumeration?  Looks like we didn't=
 restore
> >>>>>>>>>>> L1SubCtl1.
> >>>>>>>>>>>
> >>>>>>>>>>> Bjorn
> >>>>>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Thank you all for the response and input! As Rajat mentioned I'm=
 using
> >>>>>>>> chromebook - but not Atlas (Amberlake) - in this case it is Baby=
mega
> >>>>>>>> (Apollolake)  - I will try to load most recent kernel and give i=
t a
> >>>>>>>> try once again.
> >>>>>>>>
> >>>>>>>> Best regards,
> >>>>>>>> Lukasz
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>>      I have applied this patch on top of v5.19-rc7 (chromeos) and=
 I'm
> >>>>>>> still getting same results:
> >>>>>>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d=
6711b2030ea34b9
> >>>>>>>
> >>>>>>> Best regards,
> >>>>>>> Lukasz
> >>>>>>>
> >>>>> Hi Vidya,
> >>>>>
> >>>>> Sorry for the long delay, I have retested your patch on top of
> >>>>> linux-next/master (next-20220802) - the results for my device remai=
n
> >>>>> the same.
> >>>>> Here are the logs (lspci -vvv before suspend, lspci -vvv after resu=
me and dmesg)
> >>>>> https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f2327803=
4056a8002b3ef
> >>>>> Let me know if you need any more logs and/or tests.
> >>>>>
> >>>>> Best regards,
> >>>>> Lukasz
> >>>>>
> >>> Hi Vidya,
> >>>
> >>> After your last email, I've re-tested my setup and (without your
> >>> patch)  the capability register also disappears - so it looks there i=
s
> >>> - in fact - some problem in my setup and your patch just brings it to
> >>> the top as after resume tries to write to a register that is no longe=
r
> >>> present. I'm very sorry for the confusion here and I've not notice
> >>> that at the very beginning.
> >>>
> >>> Best regards,
> >>> Lukasz
> >>>

Hi Vidya,

For me (on Apollolake devices) the results remain the same, but as
I've mentioned earlier - it looks very much related exactly to the
Apollolake and is not directly related to your patch (e.g. I'm losing
L1SS capabilities even without your patch).
As a counter example, I don't  observe any issues with your patach
(v3) on Amberlake devices - lspci -vvv before suspend and after resume
are exactly the same.

Best regards,
Lukasz
