Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087CE59E757
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiHWQdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiHWQcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 12:32:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4428E06
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 07:55:20 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5864740ABC
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661266515;
        bh=rLCrWOJxLKLbIRQocbDZ7iuDBoRRdE46Z6DB5cm9Ooo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GQMmDT+GXa9wW5kX8g7LTtBCL7GBpLp6EGbdCf6PS7/30Cr0zOg2RySW/2ea0D0uG
         CX0t0MnJOwLTPFEll4VNN50vYwhBSX8+5WRmjEWOW/r293LBkbg3VzOH0yLMN2foWi
         ttpInwG/RVBrcOH5ET5T87BYU5bu95IlEogIP0IdYZRcEGDzlSFTYguPLdvkSCGMvY
         cXrCbV/pB+ab9mWvUQTBLHc/+J9wYH/1REyytjVRPybEfYAHKiEnFUYovvPk/W/QO/
         P2r6/OOKpBtCVWl41lvpT7uJYFj8t12GXsnSqjw1eceAjWnxD7bGnDvfHiGz6FR9sp
         qy3gwRf4WBA4w==
Received: by mail-oi1-f200.google.com with SMTP id w7-20020a0568080d4700b003457457c168so1358371oik.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 07:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rLCrWOJxLKLbIRQocbDZ7iuDBoRRdE46Z6DB5cm9Ooo=;
        b=AWJSUy7ALpWfAXmD3zj4tdwh82HIG4iavpGs6PhtQ0xxO0GVYgorez5FzTBF+oN4P4
         Bc36IoGpi60e1AuNn2OOHaa7xa6x0nlPUcLJt2TIhL0GnLztKG0vPWADJ1JmEgDzMzlW
         23+i2YBiK5Ceawf91N0Yy7gBDh1gp1+41r/LiOSL8jjKvyq8WXepf//Rs51Ec8sdbMBq
         V+8OPxZhCoMCPke1uE3WgWwTBRxmm3eGDsVbhxqw5Raf3zsC0NxcYBecTVLt2EvJKPEt
         49SEMUaAqdtaUsRqnf3oPhbfozQYq5fi4e2y6iz/xmUREArMWeKecr5C/PT5ezjAHa1S
         EpkQ==
X-Gm-Message-State: ACgBeo1nJwLpszefgMN0NBQWizsNoa2reh6VbNTIIIuutd1C1d/YqJ9k
        VJ37UZ7zT2PMhEayh8fetR34yAiedpljr1r2v+652kTrLu2M8JO6r6T9kFghG/ZcGhltDeCFF8H
        pwXlFZuFplxondphKpIkJOHddwFnwJk5F7e4q2XhrVaChvCAJUz+y+g==
X-Received: by 2002:a05:6830:56:b0:639:bbb:f0cf with SMTP id d22-20020a056830005600b006390bbbf0cfmr6987764otp.161.1661266513206;
        Tue, 23 Aug 2022 07:55:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7KwJ3XFodaLrAcW2JQ62MeAdUhsCrs6pwnT/94XV1fVG7gGoPbMMRdWcpu8cSIIMLSHZxV+Zo7jHmyGfHBsek=
X-Received: by 2002:a05:6830:56:b0:639:bbb:f0cf with SMTP id
 d22-20020a056830005600b006390bbbf0cfmr6987731otp.161.1661266512696; Tue, 23
 Aug 2022 07:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174212.GA1911979@bhelgaas> <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
 <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
 <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
 <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com> <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
 <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com> <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
 <b841fe9f-6091-ff55-cd0f-76bc6b04ff46@nvidia.com>
In-Reply-To: <b841fe9f-6091-ff55-cd0f-76bc6b04ff46@nvidia.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 23 Aug 2022 22:55:01 +0800
Message-ID: <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lukasz Majczak <lma@semihalf.com>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Thanks Lukasz for the update.
> I think confirms that there is no issue with the patch as such.
> Bjorn, could you please define the next step for this patch?

I think the L1SS cap went away _after_ L1SS registers are restored,
since your patch already check the cap before doing any write:
+       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+       if (!aspm_l1ss)
+               return;

That means it's more likely to be caused by the following change:
+       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
+       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);

So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2,
like what aspm_calc_l1ss_info() does?

Kai-Heng

>
> Thanks,
> Vidya Sagar
>
> On 8/8/2022 7:37 PM, Lukasz Majczak wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > =C5=9Br., 3 sie 2022 o 14:55 Vidya Sagar <vidyas@nvidia.com> napisa=C5=
=82(a):
> >>
> >> Thanks Lukasz for the logs.
> >> I still that the L1SS capability in the root port (00:14.0) disappeare=
d
> >> after resume.
> >> I still don't understand how this patch can make the capability regist=
er
> >> itself disappear. Honestly, I still see this as a HW issue.
> >> Bjorn, could you please throw some light on this?
> >>
> >> Thanks,
> >> Vidya Sagar
> >>
> >> On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisa=C5=82=
(a):
> >>>>
> >>>> Hi Lukasz,
> >>>> Thanks for sharing your observations.
> >>>>
> >>>> Could you please also share the output of 'sudo lspci -vvvv' before =
and
> >>>> after suspend-resume cycle with the latest linux-next?
> >>>> Do we still see the L1SS capabilities getting disappeared post resum=
e?
> >>>>
> >>>> Thanks,
> >>>> Vidya Sagar
> >>>>
> >>>> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
> >>>>> External email: Use caution opening links or attachments
> >>>>>
> >>>>>
> >>>>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisa=
=C5=82(a):
> >>>>>>
> >>>>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisa=C5=
=82(a):
> >>>>>>>
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> =
wrote:
> >>>>>>>>
> >>>>>>>> Agree with Bjorn's observations.
> >>>>>>>> The fact that the L1SS capability registers themselves disappear=
ed in
> >>>>>>>> the root port post resume indicates that there seems to be somet=
hing
> >>>>>>>> wrong with the BIOS itself.
> >>>>>>>> Could you please check from that perspective?
> >>>>>>>
> >>>>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. =
This
> >>>>>>> is a shallower sleep state that preserves more state than, for e.=
g. S3
> >>>>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in pi=
cture
> >>>>>>> at all. i.e. after the kernel runs its suspend routines, it just =
puts
> >>>>>>> the CPU into S0ix state. So I do not think there is a BIOS angle =
to
> >>>>>>> this.
> >>>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Vidya Sagar
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> >>>>>>>>> External email: Use caution opening links or attachments
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
> >>>>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonica=
l.com> napisa=C5=82(a):
> >>>>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmai=
l.com> wrote:
> >>>>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.co=
m> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and CT=
L2) weren't
> >>>>>>>>>>>>> saved and restored during suspend/resume leading to L1 Subs=
tates
> >>>>>>>>>>>>> configuration being lost post-resume.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Save the L1 Substates control registers so that the configu=
ration is
> >>>>>>>>>>>>> retained post-resume.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hi Vidya,
> >>>>>>>>>>>>
> >>>>>>>>>>>> I tested this patch on kernel v5.19-rc6.
> >>>>>>>>>>>> The test device is GL9755 card reader controller on Intel i5=
-10210U RVP.
> >>>>>>>>>>>> This patch can restore L1SS after suspend/resume.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The test results are as follows:
> >>>>>>>>>>>>
> >>>>>>>>>>>> After Boot:
> >>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>             Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM=
_L1.2+
> >>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>                               PortCommonModeRestoreTime=3D25=
5us
> >>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>                     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASP=
M_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>                                T_CommonMode=3D0us LTR1.2_Thr=
eshold=3D3145728ns
> >>>>>>>>>>>>                     L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> After suspend/resume without this patch.
> >>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>             Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM=
_L1.2+
> >>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>                               PortCommonModeRestoreTime=3D25=
5us
> >>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>                     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASP=
M_L1.2- ASPM_L1.1-
> >>>>>>>>>>>>                                T_CommonMode=3D0us LTR1.2_Thr=
eshold=3D0ns
> >>>>>>>>>>>>                     L1SubCtl2: T_PwrOn=3D10us
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> After suspend/resume with this patch.
> >>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> >>>>>>>>>>>>             Capabilities: [110 v1] L1 PM Substates
> >>>>>>>>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM=
_L1.2+
> >>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>>>>                               PortCommonModeRestoreTime=3D25=
5us
> >>>>>>>>>>>> PortTPowerOnTime=3D3100us
> >>>>>>>>>>>>                     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASP=
M_L1.2+ ASPM_L1.1+
> >>>>>>>>>>>>                                T_CommonMode=3D0us LTR1.2_Thr=
eshold=3D3145728ns
> >>>>>>>>>>>>                     L1SubCtl2: T_PwrOn=3D3100us
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
> >>>>>>>>>>>
> >>>>>>>>>>> Forgot to add mine:
> >>>>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Best regards,
> >>>>>>>>>>>> Ben Chuang
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verif=
y this patch
> >>>>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
> >>>>>>>>>>>>> IMHO, the regression observed on your laptop with an old ve=
rsion of the patch
> >>>>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>> Vidya Sagar
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>      drivers/pci/pci.c       |  7 +++++++
> >>>>>>>>>>>>>      drivers/pci/pci.h       |  4 ++++
> >>>>>>>>>>>>>      drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++=
++++++++++++++++
> >>>>>>>>>>>>>      3 files changed, 55 insertions(+)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
> >>>>>>>>>>>>> --- a/drivers/pci/pci.c
> >>>>>>>>>>>>> +++ b/drivers/pci/pci.c
> >>>>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *de=
v)
> >>>>>>>>>>>>>                     return i;
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>             pci_save_ltr_state(dev);
> >>>>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
> >>>>>>>>>>>>>             pci_save_dpc_state(dev);
> >>>>>>>>>>>>>             pci_save_aer_state(dev);
> >>>>>>>>>>>>>             pci_save_ptm_state(dev);
> >>>>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev=
 *dev)
> >>>>>>>>>>>>>              * LTR itself (in the PCIe capability).
> >>>>>>>>>>>>>              */
> >>>>>>>>>>>>>             pci_restore_ltr_state(dev);
> >>>>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>             pci_restore_pcie_state(dev);
> >>>>>>>>>>>>>             pci_restore_pasid_state(dev);
> >>>>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(s=
truct pci_dev *dev)
> >>>>>>>>>>>>>             if (error)
> >>>>>>>>>>>>>                     pci_err(dev, "unable to allocate suspen=
d buffer for LTR\n");
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_=
CAP_ID_L1SS,
> >>>>>>>>>>>>> +                                           2 * sizeof(u32)=
);
> >>>>>>>>>>>>> +       if (error)
> >>>>>>>>>>>>> +               pci_err(dev, "unable to allocate suspend bu=
ffer for ASPM-L1SS\n");
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>             pci_allocate_vc_save_buffers(dev);
> >>>>>>>>>>>>>      }
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
> >>>>>>>>>>>>> --- a/drivers/pci/pci.h
> >>>>>>>>>>>>> +++ b/drivers/pci/pci.h
> >>>>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct=
 pci_dev *pdev);
> >>>>>>>>>>>>>      void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >>>>>>>>>>>>>      void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >>>>>>>>>>>>>      void pcie_aspm_powersave_config_link(struct pci_dev *p=
dev);
> >>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >>>>>>>>>>>>>      #else
> >>>>>>>>>>>>>      static inline void pcie_aspm_init_link_state(struct pc=
i_dev *pdev) { }
> >>>>>>>>>>>>>      static inline void pcie_aspm_exit_link_state(struct pc=
i_dev *pdev) { }
> >>>>>>>>>>>>>      static inline void pcie_aspm_pm_state_change(struct pc=
i_dev *pdev) { }
> >>>>>>>>>>>>>      static inline void pcie_aspm_powersave_config_link(str=
uct pci_dev *pdev) { }
> >>>>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev=
 *dev) { }
> >>>>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_=
dev *dev) { }
> >>>>>>>>>>>>>      #endif
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>      #ifdef CONFIG_PCIE_ECRC
> >>>>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/asp=
m.c
> >>>>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
> >>>>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
> >>>>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
> >>>>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(stru=
ct pcie_link_state *link, u32 state)
> >>>>>>>>>>>>>                                     PCI_L1SS_CTL1_L1SS_MASK=
, val);
> >>>>>>>>>>>>>      }
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>>>> +{
> >>>>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_=
CAP_ID_L1SS);
> >>>>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_=
CAP_ID_L1SS);
> >>>>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL=
2, cap++);
> >>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL=
1, cap++);
> >>>>>>>>>>>>> +}
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> >>>>>>>>>>>>> +{
> >>>>>>>>>>>>> +       int aspm_l1ss;
> >>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
> >>>>>>>>>>>>> +       u32 *cap;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
> >>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       aspm_l1ss =3D pci_find_ext_capability(dev, PCI_EXT_=
CAP_ID_L1SS);
> >>>>>>>>>>>>> +       if (!aspm_l1ss)
> >>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_=
CAP_ID_L1SS);
> >>>>>>>>>>>>> +       if (!save_state)
> >>>>>>>>>>>>> +               return;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       cap =3D (u32 *)&save_state->cap.data[0];
> >>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CT=
L2, *cap++);
> >>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CT=
L1, *cap++);
> >>>>>>>>>>>>> +}
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>      static void pcie_config_aspm_dev(struct pci_dev *pdev,=
 u32 val)
> >>>>>>>>>>>>>      {
> >>>>>>>>>>>>>             pcie_capability_clear_and_set_word(pdev, PCI_EX=
P_LNKCTL,
> >>>>>>>>>>>>> --
> >>>>>>>>>>>>> 2.17.1
> >>>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> With this patch (and also mentioned
> >>>>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.=
feng@canonical.com/)
> >>>>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems after
> >>>>>>>>>> suspend/resume with my WiFi card - it looks like whole communi=
cation
> >>>>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspen=
d/resume
> >>>>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb3=
6dfa2eff22911109dfb91ab0fc0e3
> >>>>>>>>>>
> >>>>>>>>>> I played a little bit with this code and it looks like the
> >>>>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't=
 know
> >>>>>>>>>> why, not a PCI expert).
> >>>>>>>>>
> >>>>>>>>> Thanks a lot for testing this!  I'm not quite sure what to make=
 of the
> >>>>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know w=
hat
> >>>>>>>>> other changes are in chromeos-5.10.
> >>>>>>>
> >>>>>>> Lukasz: I assume you are running this on Atlas and are seeing thi=
s bug
> >>>>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a new=
er
> >>>>>>> Intel platform that have the latest upstream kernel running alrea=
dy
> >>>>>>> and see if this can be reproduced there too?
> >>>>>>> Note that the wifi PCI device is different on newer Intel platfor=
ms,
> >>>>>>> but platform design is similar enough that I suspect we should se=
e
> >>>>>>> similar bug on those too. The other option is to try the latest
> >>>>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (and
> >>>>>>> ignore bringing up the graphics stack and GUI), it may come up
> >>>>>>> sufficiently enough to try this patch?
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>>
> >>>>>>> Rajat
> >>>>>>>
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>> Random observations, no analysis below.  This from your dmesg
> >>>>>>>>> certainly looks like PCI reads failing and returning ~0:
> >>>>>>>>>
> >>>>>>>>>       Timeout waiting for hardware access (CSR_GP_CNTRL 0xfffff=
fff)
> >>>>>>>>>       iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff fffffff=
f ffffffff ffffffff ffffffff ffffffff ffffffff
> >>>>>>>>>       iwlwifi 0000:01:00.0: Device gone - attempting removal
> >>>>>>>>>       Hardware became unavailable upon resume. This could be a =
software issue prior to suspend or a hardware issue.
> >>>>>>>>>
> >>>>>>>>> And then we re-enumerate 01:00.0 and it looks like it may have =
been
> >>>>>>>>> reset (BAR is 0):
> >>>>>>>>>
> >>>>>>>>>       pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
> >>>>>>>>>       pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64=
bit]
> >>>>>>>>>
> >>>>>>>>> lspci diffs from before/after suspend:
> >>>>>>>>>
> >>>>>>>>>        00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pent=
ium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Nor=
mal decode])
> >>>>>>>>>          Bus: primary=3D00, secondary=3D01, subordinate=3D01, s=
ec-latency=3D64
> >>>>>>>>>       -               DevSta: CorrErr- NonFatalErr+ FatalErr- U=
nsupReq+ AuxPwr+ TransPend-
> >>>>>>>>>       +               DevSta: CorrErr+ NonFatalErr- FatalErr- U=
nsupReq- AuxPwr+ TransPend-
> >>>>>>>>>       -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Di=
sabled- CommClk+
> >>>>>>>>>       +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disa=
bled- CommClk+
> >>>>>>>>>       -               LnkSta2: Current De-emphasis Level: -6dB,=
 EqualizationComplete- EqualizationPhase1-
> >>>>>>>>>       +               LnkSta2: Current De-emphasis Level: -3.5d=
B, EqualizationComplete- EqualizationPhase1-
> >>>>>>>>>       -       Capabilities: [150 v0] Null
> >>>>>>>>>       -       Capabilities: [200 v1] L1 PM Substates
> >>>>>>>>>       -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_=
L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>       -                         PortCommonModeRestoreTime=3D40u=
s PortTPowerOnTime=3D10us
> >>>>>>>>>       -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM=
_L1.2+ ASPM_L1.1+
> >>>>>>>>>       -                          T_CommonMode=3D40us LTR1.2_Thr=
eshold=3D98304ns
> >>>>>>>>>       -               L1SubCtl2: T_PwrOn=3D60us
> >>>>>>>>>
> >>>>>>>>> The DevSta differences might be BIOS bugs, probably not relevan=
t.
> >>>>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled aft=
er
> >>>>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates capab=
ility
> >>>>>>>>> disappeared.
> >>>>>>>>>
> >>>>>>>>>        01:00.0 Network controller: Intel Corporation Wireless 7=
265 (rev 59)
> >>>>>>>>>                       LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Di=
sabled- CommClk+
> >>>>>>>>>       -                       ExtSynch- ClockPM+ AutWidDis- BWI=
nt- AutBWInt-
> >>>>>>>>>       +                       ExtSynch- ClockPM- AutWidDis- BWI=
nt- AutBWInt-
> >>>>>>>>>               Capabilities: [154 v1] L1 PM Substates
> >>>>>>>>>                       L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_=
L1.2+ ASPM_L1.1+ L1_PM_Substates+
> >>>>>>>>>                                 PortCommonModeRestoreTime=3D30u=
s PortTPowerOnTime=3D60us
> >>>>>>>>>       -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM=
_L1.2+ ASPM_L1.1+
> >>>>>>>>>       -                          T_CommonMode=3D0us LTR1.2_Thre=
shold=3D98304ns
> >>>>>>>>>       +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM=
_L1.2- ASPM_L1.1-
> >>>>>>>>>       +                          T_CommonMode=3D0us LTR1.2_Thre=
shold=3D0ns
> >>>>>>>>>
> >>>>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASPM =
didn't
> >>>>>>>>> get reinitialized after re-enumeration?  Looks like we didn't r=
estore
> >>>>>>>>> L1SubCtl1.
> >>>>>>>>>
> >>>>>>>>> Bjorn
> >>>>>>>>>
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> Thank you all for the response and input! As Rajat mentioned I'm u=
sing
> >>>>>> chromebook - but not Atlas (Amberlake) - in this case it is Babyme=
ga
> >>>>>> (Apollolake)  - I will try to load most recent kernel and give it =
a
> >>>>>> try once again.
> >>>>>>
> >>>>>> Best regards,
> >>>>>> Lukasz
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>>     I have applied this patch on top of v5.19-rc7 (chromeos) and I'=
m
> >>>>> still getting same results:
> >>>>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d67=
11b2030ea34b9
> >>>>>
> >>>>> Best regards,
> >>>>> Lukasz
> >>>>>
> >>> Hi Vidya,
> >>>
> >>> Sorry for the long delay, I have retested your patch on top of
> >>> linux-next/master (next-20220802) - the results for my device remain
> >>> the same.
> >>> Here are the logs (lspci -vvv before suspend, lspci -vvv after resume=
 and dmesg)
> >>> https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f232780340=
56a8002b3ef
> >>> Let me know if you need any more logs and/or tests.
> >>>
> >>> Best regards,
> >>> Lukasz
> >>>
> > Hi Vidya,
> >
> > After your last email, I've re-tested my setup and (without your
> > patch)  the capability register also disappears - so it looks there is
> > - in fact - some problem in my setup and your patch just brings it to
> > the top as after resume tries to write to a register that is no longer
> > present. I'm very sorry for the confusion here and I've not notice
> > that at the very beginning.
> >
> > Best regards,
> > Lukasz
> >
