Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A847575F79
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiGOKiq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiGOKio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 06:38:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D1B864;
        Fri, 15 Jul 2022 03:38:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r3so7798925ybr.6;
        Fri, 15 Jul 2022 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77setI/aCvIxmwU3/uf3d2g0UqERdK9DBvX+cb0nE6o=;
        b=EGpZAVD4jFbrlQenlRaB5thrd5rFU3HNdAhCtO5OsKgxZUv6DI9dbYZMS2zXiczaAw
         6gcleshXH0kgLrgnYUE1oUXDT08ATT8Kp0oIn263Op0H1HaTtlKOFQKrSGEtnJp4rQdA
         tXTuq0Ne/7WZWWJbL0btgM9YHJXtVNJv7yEBeNVOI29ZphPW7jcJyh7MZJ6GmSJIqWRB
         lr8SV704ek1g0oyvtXh1IdmGPF3E+InO85jMttafVmxUwNJSj5hDM3N72/SRBiMCS7oF
         0hMWOCGSVUR3emnBbwZ7REF18+0J5gkmr0duKP6jMKfYltPB8rGDYq0ljWN63RTpJvFR
         TufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77setI/aCvIxmwU3/uf3d2g0UqERdK9DBvX+cb0nE6o=;
        b=NWXmVZTr5A6pSGAULzSQB99y3ym4mgHVOmrj0kmk3OVEHYjAH4H1JcyzGfKFJ1FuwI
         MkPboZjCmfqmOwD4IUNBjoHlyG5cSmZIO+OgnXV8wFweJR7TL3bKsFcwKZkU7yXhL537
         +nzXO6bjy249dEhM6ssvWRqvjH9PHkihcPjiLE1ku0wtvrOba8elf/g24YI7Ss7TFn6Q
         wDXN7JEjEI03ZiCjF7uOQqd+oksgm9oVY0hBGrass8FcEg9UC77U+R52MfWph/WzRqat
         4tNux95U95JMY714hSldjezLBdKbrW5BlN4hLc/0Xy/As5dWnXxBCQGAziiPLPE98n/4
         2ogg==
X-Gm-Message-State: AJIora9y2oUNoeJhpbaYweOvd2KKpXk4y5xDdsPiSTxBP3LoYV7KV/Je
        2vwxmGS9hnR0SP+Uq39bph1HuKSQlhk1PCjcD0Z5oIVh
X-Google-Smtp-Source: AGRyM1uKQnmnnOxnFeNg24kTsu87noWvBo2y075OabIEw+SpDZb7G/DNic7eI6RpGmQIaVw3kYGGn67OElsSSgfsgKA=
X-Received: by 2002:a25:8892:0:b0:66e:fe43:5aa0 with SMTP id
 d18-20020a258892000000b0066efe435aa0mr12929684ybl.445.1657881521493; Fri, 15
 Jul 2022 03:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220705060014.10050-1-vidyas@nvidia.com>
In-Reply-To: <20220705060014.10050-1-vidyas@nvidia.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 15 Jul 2022 18:38:20 +0800
Message-ID: <CACT4zj8oTthEA8uEpSYQYURcc4qqp20xfw+DRaH=cS9NHGgZtw@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to L1 Substates
> configuration being lost post-resume.
>
> Save the L1 Substates control registers so that the configuration is
> retained post-resume.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>

Hi Vidya,

I tested this patch on kernel v5.19-rc6.
The test device is GL9755 card reader controller on Intel i5-10210U RVP.
This patch can restore L1SS after suspend/resume.

The test results are as follows:

After Boot:
#lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=255us
PortTPowerOnTime=3100us
                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                           T_CommonMode=0us LTR1.2_Threshold=3145728ns
                L1SubCtl2: T_PwrOn=3100us


After suspend/resume without this patch.
#lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=255us
PortTPowerOnTime=3100us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us


After suspend/resume with this patch.
#lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=255us
PortTPowerOnTime=3100us
                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                           T_CommonMode=0us LTR1.2_Threshold=3145728ns
                L1SubCtl2: T_PwrOn=3100us


Tested-by: Ben Chuang <benchuanggli@gmail.com>

Best regards,
Ben Chuang


> ---
> Hi,
> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> on your laptop (Dell XPS 13) one last time?
> IMHO, the regression observed on your laptop with an old version of the patch
> could be due to a buggy old version BIOS in the laptop.
>
> Thanks,
> Vidya Sagar
>
>  drivers/pci/pci.c       |  7 +++++++
>  drivers/pci/pci.h       |  4 ++++
>  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a8..aca05880aaa3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>                 return i;
>
>         pci_save_ltr_state(dev);
> +       pci_save_aspm_l1ss_state(dev);
>         pci_save_dpc_state(dev);
>         pci_save_aer_state(dev);
>         pci_save_ptm_state(dev);
> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>          * LTR itself (in the PCIe capability).
>          */
>         pci_restore_ltr_state(dev);
> +       pci_restore_aspm_l1ss_state(dev);
>
>         pci_restore_pcie_state(dev);
>         pci_restore_pasid_state(dev);
> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>         if (error)
>                 pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>
> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +                                           2 * sizeof(u32));
> +       if (error)
> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> +
>         pci_allocate_vc_save_buffers(dev);
>  }
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e10cdec6c56e..92d8c92662a4 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>  #endif
>
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc..2c29fdd20059 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>                                 PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +       int aspm_l1ss;
> +       struct pci_cap_saved_state *save_state;
> +       u32 *cap;
> +
> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!aspm_l1ss)
> +               return;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!save_state)
> +               return;
> +
> +       cap = (u32 *)&save_state->cap.data[0];
> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> +}
> +
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +       int aspm_l1ss;
> +       struct pci_cap_saved_state *save_state;
> +       u32 *cap;
> +
> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!aspm_l1ss)
> +               return;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!save_state)
> +               return;
> +
> +       cap = (u32 *)&save_state->cap.data[0];
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> +}
> +
>  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  {
>         pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> --
> 2.17.1
>
