Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA5E5AA763
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 07:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiIBFtZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 01:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIBFtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 01:49:25 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8EB7EDF
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 22:49:22 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o123so1051778vsc.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Sep 2022 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=BW7DdlSekgKI7bmU9+X6HIBy4PdrQiq5hvTK44Ywm3w=;
        b=T7wdT/dQ3HtwAgevbbNs9ptd1PMTfAIw2peZGc7viP6g6yGrpwy77iJqmvy6Fh/i+O
         rpD6/4X7pUJuUBREqGWK6nj3yyG2BlTnuOJ/FMWXvIYT7dimQDmzne974fxE/dJ9o5pg
         KOVLR/Dpf1mzFKsE13o+cveS06eSyUN2Zna02oPMa6xCSllx03Usvfy1s8AQV1WcG979
         rL4XNhGY0I22E+v5gTKMK/j7Zx6nH6nxWDz1UKq47jnpJyyyETakbLA7z1IaV8zEXNwL
         5nujd6x0bMhm+ERnADAdbP4WMCZhSUvEE0I+mOAYpbZJo7LD3c3Btjjyw0elXDNfsrKB
         NP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BW7DdlSekgKI7bmU9+X6HIBy4PdrQiq5hvTK44Ywm3w=;
        b=bNBxmGKbIX+gYzCDLul7xxqyNar6gJjtTZrttwh+sFYdmoHftmB3AMduttgxqfezln
         b4GBiAri8afcUZxZGI52jvV2E2ESHHxe7WLo/5zHWL61U5zITs3C4GPBNeY/KY4kQ0dI
         fsThwPLoEj4Bm8Asaow6RUOemGNmvkvQnV5h3Xuwo63SZqIgy3Ln2HRtJRv72eNV5++q
         HTywAbqD1pVrzts7S31FGHIC67B3yoSsj+5P8bMOMFg4nU8CR4azuLvxSEi5gf28RYLF
         G/iCLGeV7cPwcArxpnP7OOwuSkMwksCMPn+UIBMLFTgY8bdbMBRNZYnSNirldUwHdK5M
         TBqA==
X-Gm-Message-State: ACgBeo3md9KICQW1+u1Gpq/TFDg6mS5hNejCTBAUeXD6GrBNAQ4t7FYO
        H6y0F7ju4KtiSV/xNiXVfRtoKDaW1T8iDW/vLhiPRA==
X-Google-Smtp-Source: AA6agR47XYxZu4TvD4ckKzlwD0Jdufz8AUfvO/eV0edopAR5lOYW6I5AzF+3igVcSOyjnoELWB2ffdi5qq2WegiF2MA=
X-Received: by 2002:a67:ac44:0:b0:38a:b369:f562 with SMTP id
 n4-20020a67ac44000000b0038ab369f562mr10696792vsh.14.1662097761634; Thu, 01
 Sep 2022 22:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174212.GA1911979@bhelgaas> <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
 <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
 <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
 <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com> <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
 <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com> <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
 <b841fe9f-6091-ff55-cd0f-76bc6b04ff46@nvidia.com> <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
 <eb420ee1-424a-5688-8610-9d3e510d0327@nvidia.com> <CAFJ_xbpNLvnWe9uEFxSEPb3mch--Ukf24wUAS9b5kuCxSr8p5A@mail.gmail.com>
 <1bacfad9-b90f-1d74-bd06-8f01bd2f9396@nvidia.com>
In-Reply-To: <1bacfad9-b90f-1d74-bd06-8f01bd2f9396@nvidia.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Fri, 2 Sep 2022 07:49:10 +0200
Message-ID: <CAFJ_xbqhQndqfOAbPizQ3Cuyi1WthbNN3DQuObvWYR3ky4C6DA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

wt., 30 sie 2022 o 16:02 Vidya Sagar <vidyas@nvidia.com> napisa=C5=82(a):
>
>
>
> On 8/30/2022 4:45 PM, Lukasz Majczak wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > pt., 26 sie 2022 o 15:00 Vidya Sagar <vidyas@nvidia.com> napisa=C5=82(a=
):
> >>
> >>
> >>
> >> On 8/23/2022 8:25 PM, Kai-Heng Feng wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> Hi Vidya,
> >>>
> >>> On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote=
:
> >>>>
> >>>> Thanks Lukasz for the update.
> >>>> I think confirms that there is no issue with the patch as such.
> >>>> Bjorn, could you please define the next step for this patch?
> >>>
> >>> I think the L1SS cap went away _after_ L1SS registers are restored,
> >>> since your patch already check the cap before doing any write:
> >>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1S=
S);
> >>> +       if (!aspm_l1ss)
> >>> +               return;
> >>>
> >>> That means it's more likely to be caused by the following change:
> >>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++=
);
> >>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++=
);
> >>>
> >>> So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2=
,
> >>> like what aspm_calc_l1ss_info() does?
> >>
> >> I posted a new patch
> >> https://patchwork.kernel.org/project/linux-pci/patch/20220826125526.28=
859-1-vidyas@nvidia.com/
> >> keeping L1.2 disabled while restoring the rest of the fields in
> >> Control-1 register and restoring the L1.2 enable bits later. Could you
> >> please try this new patch on your setup and update your observations?
> >>
> >> Thanks & Regards,
> >> Vidya Sagar
> >>
> >>>
> >>> Kai-Heng
> >>>
> >>>>
> >>>> Thanks,
> >>>> Vidya Sagar
> >>>>
> >>>> On 8/8/2022 7:37 PM, Lukasz Majczak wrote:
> >>>>> External email: Use caution opening links or attachments
> >>>>>
> >>>>>
> >>>>> =C5=9Br., 3 sie 2022 o 14:55 Vidya Sagar <vidyas@nvidia.com> napisa=
=C5=82(a):
> >>>>>>
> >>>>>> Thanks Lukasz for the logs.
> >>>>>> I still that the L1SS capability in the root port (00:14.0) disapp=
eared
> >>>>>> after resume.
> >>>>>> I still don't understand how this patch can make the capability re=
gister
> >>>>>> itself disappear. Honestly, I still see this as a HW issue.
> >>>>>> Bjorn, could you please throw some light on this?
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Vidya Sagar
> >>>>>>
> >>>>>> On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
> >>>>>>> External email: Use caution opening links or attachments
> >>>>>>>
> >>>>>>>
> >>>>>>> pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisa=
=C5=82(a):
> >>>>>>>>
> >>>>>>>> Hi Lukasz,
> >>>>>>>> Thanks for sharing your observations.
> >>>>>>>>
> >>>>>>>> Could you please also share the output of 'sudo lspci -vvvv' bef=
ore and
> >>>>>>>> after suspend-resume cycle with the latest linux-next?
> >>>>>>>> Do we still see the L1SS capabilities getting disappeared post r=
esume?
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Vidya Sagar
> >>>>>>>>
> >>>>>>>> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
> >>>>>>>>> External email: Use caution opening links or attachments
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napi=
sa=C5=82(a):
> >>>>>>>>>>
> >>>>>>>>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napis=
a=C5=82(a):
> >>>>>>>>>>>
> >>>>>>>>>>> Hello,
> >>>>>>>>>>>
> >>>>>>>>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.c=
om> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Agree with Bjorn's observations.
> >>>>>>>>>>>> The fact that the L1SS capability registers themselves disap=
peared in
> >>>>>>>>>>>> the root port post resume indicates that there seems to be s=
omething
> >>>>>>>>>>>> wrong with the BIOS itself.
> >>>>>>>>>>>> Could you please check from that perspective?
> >>>>>>>>>>>
> >>>>>>>>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspe=
nd. This
> >>>>>>>>>>> is a shallower sleep state that preserves more state than, fo=
r e.g. S3
> >>>>>>>>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come i=
n picture
> >>>>>>>>>>> at all. i.e. after the kernel runs its suspend routines, it j=
ust puts
> >>>>>>>>>>> the CPU into S0ix state. So I do not think there is a BIOS an=
gle to
> >>>>>>>>>>> this.
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks,
> >>>>>>>>>>>> Vidya Sagar
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> >>>>>>>>>>>>> External email: Use caution opening links or attachments
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wr=
ote:
> >>>>>>>>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@cano=
nical.com> napisa=C5=82(a):
> >>>>>>>>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@=
gmail.com> wrote:
> >>>>>>>>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidi=
a.com> wrote:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 an=
d CTL2) weren't
> >>>>>>>>>>>>>>>>> saved and restored during suspend/resume leading to L1 =
Substates
> >>>>>>>>>>>>>>>>> configuration being lost post-resume.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Save the L1 Substates control registers so that the con=
figuration is
> >>>>>>>>>>>>>>>>> retained post-resume.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>>>>>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Hi Vidya,
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I tested this patch on kernel v5.19-rc6.
> >>>>>>>>>>>>>>>> The test device is GL9755 card reader controller on Inte=
l i5-10210U RVP.
> >>>>>>>>>>>>>>>> This patch can restore L1SS after suspend/resume.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> The test results are as follows:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> After Boot:
> >>>>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>>>>>               Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>>>>>                       L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1=
+ ASPM_L1.2+
> >>>>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>>>>                                 PortCommonModeRestoreTim=
e=3D255us
> >>>>>>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>>>>>                       L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.=
1+ ASPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>>>>>                                  T_CommonMode=3D0us LTR1=
.2_Threshold=3D3145728ns
> >>>>>>>>>>>>>>>>                       L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> After suspend/resume without this patch.
> >>>>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>>>>>               Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>>>>>                       L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1=
+ ASPM_L1.2+
> >>>>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>>>>                                 PortCommonModeRestoreTim=
e=3D255us
> >>>>>>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>>>>>                       L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.=
1- ASPM_L1.2- ASPM_L1.1-
> >>>>>>>>>>>>>>>>                                  T_CommonMode=3D0us LTR1=
.2_Threshold=3D0ns
> >>>>>>>>>>>>>>>>                       L1SubCtl2: T_PwrOn=3D10us
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> After suspend/resume with this patch.
> >>>>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>>>>>               Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>>>>>                       L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1=
+ ASPM_L1.2+
> >>>>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>>>>                                 PortCommonModeRestoreTim=
e=3D255us
> >>>>>>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>>>>>                       L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.=
1+ ASPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>>>>>                                  T_CommonMode=3D0us LTR1=
.2_Threshold=3D3145728ns
> >>>>>>>>>>>>>>>>                       L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Forgot to add mine:
> >>>>>>>>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Best regards,
> >>>>>>>>>>>>>>>> Ben Chuang
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please v=
erify this patch
> >>>>>>>>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
> >>>>>>>>>>>>>>>>> IMHO, the regression observed on your laptop with an ol=
d version of the patch
> >>>>>>>>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>>>> Vidya Sagar
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>        drivers/pci/pci.c       |  7 +++++++
> >>>>>>>>>>>>>>>>>        drivers/pci/pci.h       |  4 ++++
> >>>>>>>>>>>>>>>>>        drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++=
++++++++++++++++++++++
> >>>>>>>>>>>>>>>>>        3 files changed, 55 insertions(+)
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>>>>>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
> >>>>>>>>>>>>>>>>> --- a/drivers/pci/pci.c
> >>>>>>>>>>>>>>>>> +++ b/drivers/pci/pci.c
> >>>>>>>>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev=
 *dev)
> >>>>>>>>>>>>>>>>>                       return i;
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>               pci_save_ltr_state(dev);
> >>>>>>>>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
> >>>>>>>>>>>>>>>>>               pci_save_dpc_state(dev);
> >>>>>>>>>>>>>>>>>               pci_save_aer_state(dev);
> >>>>>>>>>>>>>>>>>               pci_save_ptm_state(dev);
> >>>>>>>>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci=
_dev *dev)
> >>>>>>>>>>>>>>>>>                * LTR itself (in the PCIe capability).
> >>>>>>>>>>>>>>>>>                */
> >>>>>>>>>>>>>>>>>               pci_restore_ltr_state(dev);
> >>>>>>>>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>               pci_restore_pcie_state(dev);
> >>>>>>>>>>>>>>>>>               pci_restore_pasid_state(dev);
> >>>>>>>>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffe=
rs(struct pci_dev *dev)
> >>>>>>>>>>>>>>>>>               if (error)
> >>>>>>>>>>>>>>>>>                       pci_err(dev, "unable to allocate =
suspend buffer for LTR\n");
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_=
EXT_CAP_ID_L1SS,
> >>>>>>>>>>>>>>>>> +                                           2 * sizeof(=
u32));
> >>>>>>>>>>>>>>>>> +       if (error)
> >>>>>>>>>>>>>>>>> +               pci_err(dev, "unable to allocate suspen=
d buffer for ASPM-L1SS\n");
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>               pci_allocate_vc_save_buffers(dev);
> >>>>>>>>>>>>>>>>>        }
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>>>>>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
> >>>>>>>>>>>>>>>>> --- a/drivers/pci/pci.h
> >>>>>>>>>>>>>>>>> +++ b/drivers/pci/pci.h
> >>>>>>>>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(st=
ruct pci_dev *pdev);
> >>>>>>>>>>>>>>>>>        void pcie_aspm_exit_link_state(struct pci_dev *p=
dev);
> >>>>>>>>>>>>>>>>>        void pcie_aspm_pm_state_change(struct pci_dev *p=
dev);
> >>>>>>>>>>>>>>>>>        void pcie_aspm_powersave_config_link(struct pci_=
dev *pdev);
> >>>>>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>>>>>>>        #else
> >>>>>>>>>>>>>>>>>        static inline void pcie_aspm_init_link_state(str=
uct pci_dev *pdev) { }
> >>>>>>>>>>>>>>>>>        static inline void pcie_aspm_exit_link_state(str=
uct pci_dev *pdev) { }
> >>>>>>>>>>>>>>>>>        static inline void pcie_aspm_pm_state_change(str=
uct pci_dev *pdev) { }
> >>>>>>>>>>>>>>>>>        static inline void pcie_aspm_powersave_config_li=
nk(struct pci_dev *pdev) { }
> >>>>>>>>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci=
_dev *dev) { }
> >>>>>>>>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct =
pci_dev *dev) { }
> >>>>>>>>>>>>>>>>>        #endif
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>        #ifdef CONFIG_PCIE_ECRC
> >>>>>>>>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie=
/aspm.c
> >>>>>>>>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
> >>>>>>>>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
> >>>>>>>>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
> >>>>>>>>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(=
struct pcie_link_state *link, u32 state)
> >>>>>>>>>>>>>>>>>                                       PCI_L1SS_CTL1_L1S=
S_MASK, val);
> >>>>>>>>>>>>>>>>>        }
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_=
EXT_CAP_ID_L1SS);
> >>>>>>>>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_=
EXT_CAP_ID_L1SS);
> >>>>>>>>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS=
_CTL2, cap++);
> >>>>>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS=
_CTL1, cap++);
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_=
EXT_CAP_ID_L1SS);
> >>>>>>>>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_=
EXT_CAP_ID_L1SS);
> >>>>>>>>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1S=
S_CTL2, *cap++);
> >>>>>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1S=
S_CTL1, *cap++);
> >>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>        static void pcie_config_aspm_dev(struct pci_dev =
*pdev, u32 val)
> >>>>>>>>>>>>>>>>>        {
> >>>>>>>>>>>>>>>>>               pcie_capability_clear_and_set_word(pdev, =
PCI_EXP_LNKCTL,
> >>>>>>>>>>>>>>>>> --
> >>>>>>>>>>>>>>>>> 2.17.1
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> With this patch (and also mentioned
> >>>>>>>>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.h=
eng.feng@canonical.com/)
> >>>>>>>>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems af=
ter
> >>>>>>>>>>>>>> suspend/resume with my WiFi card - it looks like whole com=
munication
> >>>>>>>>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before su=
spend/resume
> >>>>>>>>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz=
/fb36dfa2eff22911109dfb91ab0fc0e3
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I played a little bit with this code and it looks like the
> >>>>>>>>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (d=
on't know
> >>>>>>>>>>>>>> why, not a PCI expert).
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks a lot for testing this!  I'm not quite sure what to =
make of the
> >>>>>>>>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't kn=
ow what
> >>>>>>>>>>>>> other changes are in chromeos-5.10.
> >>>>>>>>>>>
> >>>>>>>>>>> Lukasz: I assume you are running this on Atlas and are seeing=
 this bug
> >>>>>>>>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a=
 newer
> >>>>>>>>>>> Intel platform that have the latest upstream kernel running a=
lready
> >>>>>>>>>>> and see if this can be reproduced there too?
> >>>>>>>>>>> Note that the wifi PCI device is different on newer Intel pla=
tforms,
> >>>>>>>>>>> but platform design is similar enough that I suspect we shoul=
d see
> >>>>>>>>>>> similar bug on those too. The other option is to try the late=
st
> >>>>>>>>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (=
and
> >>>>>>>>>>> ignore bringing up the graphics stack and GUI), it may come u=
p
> >>>>>>>>>>> sufficiently enough to try this patch?
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>>
> >>>>>>>>>>> Rajat
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Random observations, no analysis below.  This from your dme=
sg
> >>>>>>>>>>>>> certainly looks like PCI reads failing and returning ~0:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>         Timeout waiting for hardware access (CSR_GP_CNTRL 0=
xffffffff)
> >>>>>>>>>>>>>         iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff f=
fffffff ffffffff ffffffff ffffffff ffffffff ffffffff
> >>>>>>>>>>>>>         iwlwifi 0000:01:00.0: Device gone - attempting remo=
val
> >>>>>>>>>>>>>         Hardware became unavailable upon resume. This could=
 be a software issue prior to suspend or a hardware issue.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> And then we re-enumerate 01:00.0 and it looks like it may h=
ave been
> >>>>>>>>>>>>> reset (BAR is 0):
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>         pci 0000:01:00.0: [8086:095a] type 00 class 0x02800=
0
> >>>>>>>>>>>>>         pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001=
fff 64bit]
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> lspci diffs from before/after suspend:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>          00:14.0 PCI bridge: Intel Corporation Celeron N335=
0/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 0=
0 [Normal decode])
> >>>>>>>>>>>>>            Bus: primary=3D00, secondary=3D01, subordinate=
=3D01, sec-latency=3D64
> >>>>>>>>>>>>>         -               DevSta: CorrErr- NonFatalErr+ Fatal=
Err- UnsupReq+ AuxPwr+ TransPend-
> >>>>>>>>>>>>>         +               DevSta: CorrErr+ NonFatalErr- Fatal=
Err- UnsupReq- AuxPwr+ TransPend-
> >>>>>>>>>>>>>         -               LnkCtl: ASPM L1 Enabled; RCB 64 byt=
es, Disabled- CommClk+
> >>>>>>>>>>>>>         +               LnkCtl: ASPM Disabled; RCB 64 bytes=
, Disabled- CommClk+
> >>>>>>>>>>>>>         -               LnkSta2: Current De-emphasis Level:=
 -6dB, EqualizationComplete- EqualizationPhase1-
> >>>>>>>>>>>>>         +               LnkSta2: Current De-emphasis Level:=
 -3.5dB, EqualizationComplete- EqualizationPhase1-
> >>>>>>>>>>>>>         -       Capabilities: [150 v0] Null
> >>>>>>>>>>>>>         -       Capabilities: [200 v1] L1 PM Substates
> >>>>>>>>>>>>>         -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+=
 ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>         -                         PortCommonModeRestoreTime=
=3D40us PortTPowerOnTime=3D10us
> >>>>>>>>>>>>>         -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1=
+ ASPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>>         -                          T_CommonMode=3D40us LTR1=
.2_Threshold=3D98304ns
> >>>>>>>>>>>>>         -               L1SubCtl2: T_PwrOn=3D60us
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The DevSta differences might be BIOS bugs, probably not rel=
evant.
> >>>>>>>>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled=
 after
> >>>>>>>>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates c=
apability
> >>>>>>>>>>>>> disappeared.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>          01:00.0 Network controller: Intel Corporation Wire=
less 7265 (rev 59)
> >>>>>>>>>>>>>                         LnkCtl: ASPM L1 Enabled; RCB 64 byt=
es, Disabled- CommClk+
> >>>>>>>>>>>>>         -                       ExtSynch- ClockPM+ AutWidDi=
s- BWInt- AutBWInt-
> >>>>>>>>>>>>>         +                       ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-
> >>>>>>>>>>>>>                 Capabilities: [154 v1] L1 PM Substates
> >>>>>>>>>>>>>                         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+=
 ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>>                                   PortCommonModeRestoreTime=
=3D30us PortTPowerOnTime=3D60us
> >>>>>>>>>>>>>         -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1=
+ ASPM_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>>         -                          T_CommonMode=3D0us LTR1.=
2_Threshold=3D98304ns
> >>>>>>>>>>>>>         +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1=
- ASPM_L1.2- ASPM_L1.1-
> >>>>>>>>>>>>>         +                          T_CommonMode=3D0us LTR1.=
2_Threshold=3D0ns
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe A=
SPM didn't
> >>>>>>>>>>>>> get reinitialized after re-enumeration?  Looks like we didn=
't restore
> >>>>>>>>>>>>> L1SubCtl1.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Bjorn
> >>>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> Thank you all for the response and input! As Rajat mentioned I=
'm using
> >>>>>>>>>> chromebook - but not Atlas (Amberlake) - in this case it is Ba=
bymega
> >>>>>>>>>> (Apollolake)  - I will try to load most recent kernel and give=
 it a
> >>>>>>>>>> try once again.
> >>>>>>>>>>
> >>>>>>>>>> Best regards,
> >>>>>>>>>> Lukasz
> >>>>>>>>>
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>>       I have applied this patch on top of v5.19-rc7 (chromeos) =
and I'm
> >>>>>>>>> still getting same results:
> >>>>>>>>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a375=
8d6711b2030ea34b9
> >>>>>>>>>
> >>>>>>>>> Best regards,
> >>>>>>>>> Lukasz
> >>>>>>>>>
> >>>>>>> Hi Vidya,
> >>>>>>>
> >>>>>>> Sorry for the long delay, I have retested your patch on top of
> >>>>>>> linux-next/master (next-20220802) - the results for my device rem=
ain
> >>>>>>> the same.
> >>>>>>> Here are the logs (lspci -vvv before suspend, lspci -vvv after re=
sume and dmesg)
> >>>>>>> https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f23278=
034056a8002b3ef
> >>>>>>> Let me know if you need any more logs and/or tests.
> >>>>>>>
> >>>>>>> Best regards,
> >>>>>>> Lukasz
> >>>>>>>
> >>>>> Hi Vidya,
> >>>>>
> >>>>> After your last email, I've re-tested my setup and (without your
> >>>>> patch)  the capability register also disappears - so it looks there=
 is
> >>>>> - in fact - some problem in my setup and your patch just brings it =
to
> >>>>> the top as after resume tries to write to a register that is no lon=
ger
> >>>>> present. I'm very sorry for the confusion here and I've not notice
> >>>>> that at the very beginning.
> >>>>>
> >>>>> Best regards,
> >>>>> Lukasz
> >>>>>
> >
> > Hi Vidya,
> >
> > For me (on Apollolake devices) the results remain the same, but as
> > I've mentioned earlier - it looks very much related exactly to the
> > Apollolake and is not directly related to your patch (e.g. I'm losing
> > L1SS capabilities even without your patch).
> > As a counter example, I don't  observe any issues with your patach
> > (v3) on Amberlake devices - lspci -vvv before suspend and after resume
> > are exactly the same.
>
> Thanks for the update Lukasz.
> Anyway, i sent V3 fore review. Could you please review it and also test
> it on your platform?
>
> Thanks,
> Vidya Sagar
>
> >
> > Best regards,
> > Lukasz
> >
Hi Vidya,

The results from my previous mail are for V3 of your patch;
Amberlake - works fine
Apollolake - still the same issue, but here it is not related to your
changes (we are still working on this).

Best regards,
Lukasz
