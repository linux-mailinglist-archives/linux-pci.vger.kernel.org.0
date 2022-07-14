Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414957422F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 06:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiGNEVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 00:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiGNEVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 00:21:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6DF275E6
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 21:21:18 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4DD094111D
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 04:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657772475;
        bh=gLGjvAf35BUVmn3iIkA3RJp5YnCNYkqDmKk9zXo1YLY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tuogtJFm6r+ffJ+9gFvQ0QwhIIyX8AUvfbEgtuH0UFv+TJBDYTDAiiJJwTcepb89D
         8fqTfkhJFWgjG7CkRfW6fiwzSXXvLpgIjnAaH2SNj95DKra0Avlcs9yIjsd95RBjzM
         9egsmvvRry9hIw7wYembe4o+Rgtcf/qabRyrmwqt51FwEAXojzCO6/iQczuv6PHTtD
         CQF1HsoXU4BkkPadryUdJwv/IAYwh36ryG7fWWYA/RAKDNfQ8WPQAmIZgL07Qpw0uY
         qyXwdDWXM/sPl5+zkQjeeDg1L5B7zWAHaVzXQ/ymv6zAZsKFUspI0ijOebJgwY45Te
         bz9gzt1szb6Vg==
Received: by mail-ot1-f70.google.com with SMTP id a12-20020a9d724c000000b0061c64f4f444so289579otk.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 21:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLGjvAf35BUVmn3iIkA3RJp5YnCNYkqDmKk9zXo1YLY=;
        b=Nmw4yyqOd4XRO75OQG3atsL0wFoSGlKAIbEciiBAKFYyn/fxTK60M4Wmz+xMcMKWZT
         kJJ/xy0Paw+E1dwWJlOAJ2j9af/YgiD//3BjSNmOOti+YUkfVX3Gkofm4ApVLhba5P83
         o1HacmtM2kDh8iOg2nGDpoeO9ABbUWbn1K/vgPDhxdM7lWPy5AhPEGOR+o+l4k3nbm+3
         Lt+WC9aGTqusTIw7h8w7GRwKnVQ7zj9+vegWGzdVQfKVavH/aRWoVEe0fCpw+0Vvj5L1
         114kBCJSi6/Q74lGQ8rCesuh+LTs+kJSZ1VoWPLUl8DTSgvq4IYSvJa2osbubZfiuLQj
         XxIw==
X-Gm-Message-State: AJIora/Cvu60rOWptkq9eFHj5g789ZRFZOVfQxIzIANWOSRIqWNjAZX6
        xhvv/B3t+X9q91MpPDaHQkujTdVrk9LYdpsqJTmBzLTgl4V3jB1HtC1mMEbGG9WbNcafRoV/RFV
        12VflvMWdTvmkRewpYLOOdjh69+ZyQYVGJGbkGkdNsAji5KSDVzbusA==
X-Received: by 2002:a05:6870:51ce:b0:101:c7e3:d7a5 with SMTP id b14-20020a05687051ce00b00101c7e3d7a5mr6364364oaj.176.1657772470882;
        Wed, 13 Jul 2022 21:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tKNvLh7SEIeuZkckzQOcFULrkCMGK3QBez3svkc5HKqfbQEq5mWOMzOWnY1ennttSqrq5jFcv2P2ZOCjO2dw0=
X-Received: by 2002:a05:6870:51ce:b0:101:c7e3:d7a5 with SMTP id
 b14-20020a05687051ce00b00101c7e3d7a5mr6364343oaj.176.1657772470597; Wed, 13
 Jul 2022 21:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <73afa23f-73a0-81ed-c194-fbbd864a097f@nvidia.com> <20220713181621.GA840944@bhelgaas>
In-Reply-To: <20220713181621.GA840944@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 14 Jul 2022 12:20:59 +0800
Message-ID: <CAAd53p5+te7N+E+JtCxLQU_X+0scgkuusDncCqzL1Xzhym0a6A@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        benchuanggli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 2:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kai-Heng]
>
> On Wed, Jul 13, 2022 at 11:29:42PM +0530, Vidya Sagar wrote:
> > Hi,
> > @Kenneth, Could you please verify it on your laptop one last time?
> >
> > @Bjorn, Could you please review this change in the meanwhile?
>
> Seems like this may be related to Kai-Heng's patch:
> https://lore.kernel.org/r/20220509073639.2048236-1-kai.heng.feng@canonical.com
> since he specifically mentioned L1SS.

Yes, to make L1ss restore successful on system resume this patch is also needed.

Kai-Heng

>
> I applied Kai-Heng's patch for v5.20 yesterday, but I haven't worked
> out the connection to this patch.  But if you want Kenneth to test
> this, it should probably be on top of Kai-Heng's patch so we're
> testing something close to the eventual result.
>
> > On 7/5/2022 11:30 AM, Vidya Sagar wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> > > saved and restored during suspend/resume leading to L1 Substates
> > > configuration being lost post-resume.
> > >
> > > Save the L1 Substates control registers so that the configuration is
> > > retained post-resume.
> > >
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> > > ---
> > > Hi,
> > > Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> > > on your laptop (Dell XPS 13) one last time?
> > > IMHO, the regression observed on your laptop with an old version of the patch
> > > could be due to a buggy old version BIOS in the laptop.
> > >
> > > Thanks,
> > > Vidya Sagar
> > >
> > >   drivers/pci/pci.c       |  7 +++++++
> > >   drivers/pci/pci.h       |  4 ++++
> > >   drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index cfaf40a540a8..aca05880aaa3 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> > >                  return i;
> > >
> > >          pci_save_ltr_state(dev);
> > > +       pci_save_aspm_l1ss_state(dev);
> > >          pci_save_dpc_state(dev);
> > >          pci_save_aer_state(dev);
> > >          pci_save_ptm_state(dev);
> > > @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> > >           * LTR itself (in the PCIe capability).
> > >           */
> > >          pci_restore_ltr_state(dev);
> > > +       pci_restore_aspm_l1ss_state(dev);
> > >
> > >          pci_restore_pcie_state(dev);
> > >          pci_restore_pasid_state(dev);
> > > @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
> > >          if (error)
> > >                  pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> > >
> > > +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> > > +                                           2 * sizeof(u32));
> > > +       if (error)
> > > +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> > > +
> > >          pci_allocate_vc_save_buffers(dev);
> > >   }
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index e10cdec6c56e..92d8c92662a4 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> > >   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> > >   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> > >   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > > +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > >   #else
> > >   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> > >   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> > >   static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> > >   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > > +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > > +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> > >   #endif
> > >
> > >   #ifdef CONFIG_PCIE_ECRC
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a96b7424c9bc..2c29fdd20059 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> > >                                  PCI_L1SS_CTL1_L1SS_MASK, val);
> > >   }
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
> > > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > > +       if (!aspm_l1ss)
> > > +               return;
> > > +
> > > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > > +       if (!save_state)
> > > +               return;
> > > +
> > > +       cap = (u32 *)&save_state->cap.data[0];
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
> > > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > > +       if (!aspm_l1ss)
> > > +               return;
> > > +
> > > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > > +       if (!save_state)
> > > +               return;
> > > +
> > > +       cap = (u32 *)&save_state->cap.data[0];
> > > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> > > +}
> > > +
> > >   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> > >   {
> > >          pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > > --
> > > 2.17.1
> > >
