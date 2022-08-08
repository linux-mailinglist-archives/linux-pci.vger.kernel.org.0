Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090F658CA25
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbiHHOIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiHHOIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 10:08:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298FFD1C
        for <linux-pci@vger.kernel.org>; Mon,  8 Aug 2022 07:08:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e127so13756008yba.12
        for <linux-pci@vger.kernel.org>; Mon, 08 Aug 2022 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNmEjIVRvBEWw0tRkkl5BO0yA5HgWRI9cTMGOBASDfk=;
        b=m0t5q4XiK6/ClYcfRyQwgZeYoar3EYax76OQa+cjcjYxDQVqX25Cf3sQ7duu7o6Zw6
         W6ikL9MP7LLWnIPniWQAOOg+7gJbXw+PZDW5ZG4KJ4RuXwKFl3XZ16DNExITYZCq1VEp
         u4fyROrDLjUH/tstz0PFNXzt4Byo8e0AGVksu/W3ldw3WdCLc67p9TFieK9iGQCNyW8F
         dktXQpEEpkzoaQY81uI7JFM1xsiaiKXsR9y5L/98xwZR3GgwCvbXt3uGdPlfiK4+k8QS
         iFYpOfZcKZYTeSYWuR5ynDjJlR+KeneXiMPapZ8AJYbupbG98jQ0fEcIkn3IXhLxOoVI
         a+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNmEjIVRvBEWw0tRkkl5BO0yA5HgWRI9cTMGOBASDfk=;
        b=HqdzDnRjCIckXBuFsspBGwCnRC97jCyKED7/Euddx5UigkTye8UDEPgDGWtUqof/WB
         QUg6IScpSAk5TdD0PagF6uRe7S/KFm06mCOdmh0o7XhbPUoYdMQKvvpEq/dSe+nuwJ+h
         ZKgiZ5ZeH3UPVvhzkkN/a475eyF7kOiufzIHJsS1AaNU77wvsB4+5ABTU1pBBp596iZl
         XX3qjD2rQPWT1hbpooLWFdquJ82+jloJb+/M9XTi9a+elcCND+UePuq5diMUELpF4qpU
         zSGSbXSnqE94j2rMHPE6qOtLnoqlKoB25JVeHUtLCRGCtshmLFLPpw/13pbVGPOl4raJ
         tbyw==
X-Gm-Message-State: ACgBeo10JZYCvTut83AJj4p7WZuRPyJwm32IPUTE6epNWDRMhclNbtvT
        7hGyEKVM7KFGp5EP1S4DHJf8jhq9x4ah6QVBsVixjA==
X-Google-Smtp-Source: AA6agR42c5X9WiPoQL9EMf9LkWkVb5ywiSNSXzSSp0XtuhI1yYY5/n+jzxb/iNe5TAcT5cImh6yfRYQ4qUTf77HBtfw=
X-Received: by 2002:a25:250:0:b0:673:e6c5:27bf with SMTP id
 77-20020a250250000000b00673e6c527bfmr16582565ybc.258.1659967687999; Mon, 08
 Aug 2022 07:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174212.GA1911979@bhelgaas> <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
 <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
 <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
 <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com> <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
 <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com>
In-Reply-To: <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Mon, 8 Aug 2022 16:07:56 +0200
Message-ID: <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Rajat Jain <rajatja@google.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=C5=9Br., 3 sie 2022 o 14:55 Vidya Sagar <vidyas@nvidia.com> napisa=C5=82(a=
):
>
> Thanks Lukasz for the logs.
> I still that the L1SS capability in the root port (00:14.0) disappeared
> after resume.
> I still don't understand how this patch can make the capability register
> itself disappear. Honestly, I still see this as a HW issue.
> Bjorn, could you please throw some light on this?
>
> Thanks,
> Vidya Sagar
>
> On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisa=C5=82(a=
):
> >>
> >> Hi Lukasz,
> >> Thanks for sharing your observations.
> >>
> >> Could you please also share the output of 'sudo lspci -vvvv' before an=
d
> >> after suspend-resume cycle with the latest linux-next?
> >> Do we still see the L1SS capabilities getting disappeared post resume?
> >>
> >> Thanks,
> >> Vidya Sagar
> >>
> >> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisa=C5=
=82(a):
> >>>>
> >>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisa=C5=
=82(a):
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wr=
ote:
> >>>>>>
> >>>>>> Agree with Bjorn's observations.
> >>>>>> The fact that the L1SS capability registers themselves disappeared=
 in
> >>>>>> the root port post resume indicates that there seems to be somethi=
ng
> >>>>>> wrong with the BIOS itself.
> >>>>>> Could you please check from that perspective?
> >>>>>
> >>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. Th=
is
> >>>>> is a shallower sleep state that preserves more state than, for e.g.=
 S3
> >>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in pict=
ure
> >>>>> at all. i.e. after the kernel runs its suspend routines, it just pu=
ts
> >>>>> the CPU into S0ix state. So I do not think there is a BIOS angle to
> >>>>> this.
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Vidya Sagar
> >>>>>>
> >>>>>>
> >>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> >>>>>>> External email: Use caution opening links or attachments
> >>>>>>>
> >>>>>>>
> >>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
> >>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.=
com> napisa=C5=82(a):
> >>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.=
com> wrote:
> >>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com>=
 wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2=
) weren't
> >>>>>>>>>>> saved and restored during suspend/resume leading to L1 Substa=
tes
> >>>>>>>>>>> configuration being lost post-resume.
> >>>>>>>>>>>
> >>>>>>>>>>> Save the L1 Substates control registers so that the configura=
tion is
> >>>>>>>>>>> retained post-resume.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> >>>>>>>>>>
> >>>>>>>>>> Hi Vidya,
> >>>>>>>>>>
> >>>>>>>>>> I tested this patch on kernel v5.19-rc6.
> >>>>>>>>>> The test device is GL9755 card reader controller on Intel i5-1=
0210U RVP.
> >>>>>>>>>> This patch can restore L1SS after suspend/resume.
> >>>>>>>>>>
> >>>>>>>>>> The test results are as follows:
> >>>>>>>>>>
> >>>>>>>>>> After Boot:
> >>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>            Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1=
.2+
> >>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>                              PortCommonModeRestoreTime=3D255us
> >>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>                    L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L=
1.2+ ASPM_L1.1+
> >>>>>>>>>>                               T_CommonMode=3D0us LTR1.2_Thresh=
old=3D3145728ns
> >>>>>>>>>>                    L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> After suspend/resume without this patch.
> >>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>            Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1=
.2+
> >>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>                              PortCommonModeRestoreTime=3D255us
> >>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>                    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L=
1.2- ASPM_L1.1-
> >>>>>>>>>>                               T_CommonMode=3D0us LTR1.2_Thresh=
old=3D0ns
> >>>>>>>>>>                    L1SubCtl2: T_PwrOn=3D10us
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> After suspend/resume with this patch.
> >>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>            Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1=
.2+
> >>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>                              PortCommonModeRestoreTime=3D255us
> >>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>                    L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L=
1.2+ ASPM_L1.1+
> >>>>>>>>>>                               T_CommonMode=3D0us LTR1.2_Thresh=
old=3D3145728ns
> >>>>>>>>>>                    L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
> >>>>>>>>>
> >>>>>>>>> Forgot to add mine:
> >>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Best regards,
> >>>>>>>>>> Ben Chuang
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> ---
> >>>>>>>>>>> Hi,
> >>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify =
this patch
> >>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
> >>>>>>>>>>> IMHO, the regression observed on your laptop with an old vers=
ion of the patch
> >>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>> Vidya Sagar
> >>>>>>>>>>>
> >>>>>>>>>>>     drivers/pci/pci.c       |  7 +++++++
> >>>>>>>>>>>     drivers/pci/pci.h       |  4 ++++
> >>>>>>>>>>>     drivers/pci/pcie/aspm.c | 44 ++++++++++++++++++++++++++++=
+++++++++++++
> >>>>>>>>>>>     3 files changed, 55 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
> >>>>>>>>>>> --- a/drivers/pci/pci.c
> >>>>>>>>>>> +++ b/drivers/pci/pci.c
> >>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> >>>>>>>>>>>                    return i;
> >>>>>>>>>>>
> >>>>>>>>>>>            pci_save_ltr_state(dev);
> >>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
> >>>>>>>>>>>            pci_save_dpc_state(dev);
> >>>>>>>>>>>            pci_save_aer_state(dev);
> >>>>>>>>>>>            pci_save_ptm_state(dev);
> >>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *=
dev)
> >>>>>>>>>>>             * LTR itself (in the PCIe capability).
> >>>>>>>>>>>             */
> >>>>>>>>>>>            pci_restore_ltr_state(dev);
> >>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
> >>>>>>>>>>>
> >>>>>>>>>>>            pci_restore_pcie_state(dev);
> >>>>>>>>>>>            pci_restore_pasid_state(dev);
> >>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(str=
uct pci_dev *dev)
> >>>>>>>>>>>            if (error)
> >>>>>>>>>>>                    pci_err(dev, "unable to allocate suspend b=
uffer for LTR\n");
> >>>>>>>>>>>
> >>>>>>>>>>> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_CA=
P_ID_L1SS,
> >>>>>>>>>>> +                                           2 * sizeof(u32));
> >>>>>>>>>>> +       if (error)
> >>>>>>>>>>> +               pci_err(dev, "unable to allocate suspend buff=
er for ASPM-L1SS\n");
> >>>>>>>>>>> +
> >>>>>>>>>>>            pci_allocate_vc_save_buffers(dev);
> >>>>>>>>>>>     }
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
> >>>>>>>>>>> --- a/drivers/pci/pci.h
> >>>>>>>>>>> +++ b/drivers/pci/pci.h
> >>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct p=
ci_dev *pdev);
> >>>>>>>>>>>     void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >>>>>>>>>>>     void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >>>>>>>>>>>     void pcie_aspm_powersave_config_link(struct pci_dev *pdev=
);
> >>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>     #else
> >>>>>>>>>>>     static inline void pcie_aspm_init_link_state(struct pci_d=
ev *pdev) { }
> >>>>>>>>>>>     static inline void pcie_aspm_exit_link_state(struct pci_d=
ev *pdev) { }
> >>>>>>>>>>>     static inline void pcie_aspm_pm_state_change(struct pci_d=
ev *pdev) { }
> >>>>>>>>>>>     static inline void pcie_aspm_powersave_config_link(struct=
 pci_dev *pdev) { }
> >>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *=
dev) { }
> >>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_de=
v *dev) { }
> >>>>>>>>>>>     #endif
> >>>>>>>>>>>
> >>>>>>>>>>>     #ifdef CONFIG_PCIE_ECRC
> >>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.=
c
> >>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
> >>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
> >>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
> >>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct=
 pcie_link_state *link, u32 state)
> >>>>>>>>>>>                                    PCI_L1SS_CTL1_L1SS_MASK, v=
al);
> >>>>>>>>>>>     }
> >>>>>>>>>>>
> >>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>> +               return;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CA=
P_ID_L1SS);
> >>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>> +               return;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CA=
P_ID_L1SS);
> >>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>> +               return;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2,=
 cap++);
> >>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1,=
 cap++);
> >>>>>>>>>>> +}
> >>>>>>>>>>> +
> >>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>> +               return;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CA=
P_ID_L1SS);
> >>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>> +               return;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CA=
P_ID_L1SS);
> >>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>> +               return;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2=
, *cap++);
> >>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1=
, *cap++);
> >>>>>>>>>>> +}
> >>>>>>>>>>> +
> >>>>>>>>>>>     static void pcie_config_aspm_dev(struct pci_dev *pdev, u3=
2 val)
> >>>>>>>>>>>     {
> >>>>>>>>>>>            pcie_capability_clear_and_set_word(pdev, PCI_EXP_L=
NKCTL,
> >>>>>>>>>>> --
> >>>>>>>>>>> 2.17.1
> >>>>>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> With this patch (and also mentioned
> >>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.fe=
ng@canonical.com/)
> >>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems after
> >>>>>>>> suspend/resume with my WiFi card - it looks like whole communica=
tion
> >>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/=
resume
> >>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36d=
fa2eff22911109dfb91ab0fc0e3
> >>>>>>>>
> >>>>>>>> I played a little bit with this code and it looks like the
> >>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't k=
now
> >>>>>>>> why, not a PCI expert).
> >>>>>>>
> >>>>>>> Thanks a lot for testing this!  I'm not quite sure what to make o=
f the
> >>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know wha=
t
> >>>>>>> other changes are in chromeos-5.10.
> >>>>>
> >>>>> Lukasz: I assume you are running this on Atlas and are seeing this =
bug
> >>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a newer
> >>>>> Intel platform that have the latest upstream kernel running already
> >>>>> and see if this can be reproduced there too?
> >>>>> Note that the wifi PCI device is different on newer Intel platforms=
,
> >>>>> but platform design is similar enough that I suspect we should see
> >>>>> similar bug on those too. The other option is to try the latest
> >>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (and
> >>>>> ignore bringing up the graphics stack and GUI), it may come up
> >>>>> sufficiently enough to try this patch?
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Rajat
> >>>>>
> >>>>>
> >>>>>>>
> >>>>>>> Random observations, no analysis below.  This from your dmesg
> >>>>>>> certainly looks like PCI reads failing and returning ~0:
> >>>>>>>
> >>>>>>>      Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff=
)
> >>>>>>>      iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff f=
fffffff ffffffff ffffffff ffffffff ffffffff
> >>>>>>>      iwlwifi 0000:01:00.0: Device gone - attempting removal
> >>>>>>>      Hardware became unavailable upon resume. This could be a sof=
tware issue prior to suspend or a hardware issue.
> >>>>>>>
> >>>>>>> And then we re-enumerate 01:00.0 and it looks like it may have be=
en
> >>>>>>> reset (BAR is 0):
> >>>>>>>
> >>>>>>>      pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
> >>>>>>>      pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit=
]
> >>>>>>>
> >>>>>>> lspci diffs from before/after suspend:
> >>>>>>>
> >>>>>>>       00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium=
 N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal=
 decode])
> >>>>>>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-=
latency=3D64
> >>>>>>>      -               DevSta: CorrErr- NonFatalErr+ FatalErr- Unsu=
pReq+ AuxPwr+ TransPend-
> >>>>>>>      +               DevSta: CorrErr+ NonFatalErr- FatalErr- Unsu=
pReq- AuxPwr+ TransPend-
> >>>>>>>      -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disab=
led- CommClk+
> >>>>>>>      +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disable=
d- CommClk+
> >>>>>>>      -               LnkSta2: Current De-emphasis Level: -6dB, Eq=
ualizationComplete- EqualizationPhase1-
> >>>>>>>      +               LnkSta2: Current De-emphasis Level: -3.5dB, =
EqualizationComplete- EqualizationPhase1-
> >>>>>>>      -       Capabilities: [150 v0] Null
> >>>>>>>      -       Capabilities: [200 v1] L1 PM Substates
> >>>>>>>      -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.=
2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>      -                         PortCommonModeRestoreTime=3D40us P=
ortTPowerOnTime=3D10us
> >>>>>>>      -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1=
.2+ ASPM_L1.1+
> >>>>>>>      -                          T_CommonMode=3D40us LTR1.2_Thresh=
old=3D98304ns
> >>>>>>>      -               L1SubCtl2: T_PwrOn=3D60us
> >>>>>>>
> >>>>>>> The DevSta differences might be BIOS bugs, probably not relevant.
> >>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled after
> >>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates capabil=
ity
> >>>>>>> disappeared.
> >>>>>>>
> >>>>>>>       01:00.0 Network controller: Intel Corporation Wireless 7265=
 (rev 59)
> >>>>>>>                      LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disab=
led- CommClk+
> >>>>>>>      -                       ExtSynch- ClockPM+ AutWidDis- BWInt-=
 AutBWInt-
> >>>>>>>      +                       ExtSynch- ClockPM- AutWidDis- BWInt-=
 AutBWInt-
> >>>>>>>              Capabilities: [154 v1] L1 PM Substates
> >>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.=
2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>                                PortCommonModeRestoreTime=3D30us P=
ortTPowerOnTime=3D60us
> >>>>>>>      -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1=
.2+ ASPM_L1.1+
> >>>>>>>      -                          T_CommonMode=3D0us LTR1.2_Thresho=
ld=3D98304ns
> >>>>>>>      +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1=
.2- ASPM_L1.1-
> >>>>>>>      +                          T_CommonMode=3D0us LTR1.2_Thresho=
ld=3D0ns
> >>>>>>>
> >>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASPM di=
dn't
> >>>>>>> get reinitialized after re-enumeration?  Looks like we didn't res=
tore
> >>>>>>> L1SubCtl1.
> >>>>>>>
> >>>>>>> Bjorn
> >>>>>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> Thank you all for the response and input! As Rajat mentioned I'm usi=
ng
> >>>> chromebook - but not Atlas (Amberlake) - in this case it is Babymega
> >>>> (Apollolake)  - I will try to load most recent kernel and give it a
> >>>> try once again.
> >>>>
> >>>> Best regards,
> >>>> Lukasz
> >>>
> >>> Hi,
> >>>
> >>>    I have applied this patch on top of v5.19-rc7 (chromeos) and I'm
> >>> still getting same results:
> >>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d6711=
b2030ea34b9
> >>>
> >>> Best regards,
> >>> Lukasz
> >>>
> > Hi Vidya,
> >
> > Sorry for the long delay, I have retested your patch on top of
> > linux-next/master (next-20220802) - the results for my device remain
> > the same.
> > Here are the logs (lspci -vvv before suspend, lspci -vvv after resume a=
nd dmesg)
> > https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f23278034056=
a8002b3ef
> > Let me know if you need any more logs and/or tests.
> >
> > Best regards,
> > Lukasz
> >
Hi Vidya,

After your last email, I've re-tested my setup and (without your
patch)  the capability register also disappears - so it looks there is
- in fact - some problem in my setup and your patch just brings it to
the top as after resume tries to write to a register that is no longer
present. I'm very sorry for the confusion here and I've not notice
that at the very beginning.

Best regards,
Lukasz
