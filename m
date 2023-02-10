Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D370691FEC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 14:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBJNkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 08:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBJNkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 08:40:11 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E894920D0F;
        Fri, 10 Feb 2023 05:40:08 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 30so20729uab.8;
        Fri, 10 Feb 2023 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzbyB3LiJ8c5CebrK9xhr+trI7e1xdJXNHnki05qVQA=;
        b=j7jVPYffRwKk3x+KRfLVr0KZM+Eg65OllQB1VxPUtuJg2sH00c/t3LX0rMS4Ve6lJR
         Czvx7zAyPNgmtPgoCnnOpQ0NjlmWP0FsvskL/gKOFVhwkQxozvlyav+a9eWqHZqX7qnt
         +MbVqAJaEqXMcIVwcWhMHXzYZNpaLm3DbOYSF7GBgp3mnZbkoF2Zt+D6xyL/DTwMMjpr
         h6Y+gnrmOyi0P/iFw2MYxW11KsuaGNAfmO651BgZBHUofk1DWUd/7Wi21mra1WCIhHrW
         YgHXWP62PtPJ+BSNqozGFX/6tArjvZ/bOhFUsl7nfhDnlV9YNrY99/niJv6NBTw+DTQb
         w/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzbyB3LiJ8c5CebrK9xhr+trI7e1xdJXNHnki05qVQA=;
        b=cMlqHsEkpQzs3DMUQUozICcvN0wr7JxSxoH1rcUrQaMoPQ+v9/qzLYDG0gGCNTF5VC
         Hk+HMUJ/Maxhbh06yIA4TGk4L9VtOoPUS6W/VaJX4jhUXSRycZaKRnS7jiHkqXvbemeG
         VuBmuHDXVfkyzy4C6chQW5dkKNv0HJuyxDun3ZpZxci16paj9bSsEZeUguK18S883jGW
         DpqwgmZOolUO68Q86bFw6lQE4sT3HjBnwbeKSQWNRu8JB/XotIiYQkbXkScQRot+Zycj
         1cVyxET7lO4g9eyf0tz9IjIxiKKa314d0HHDwjnL0W+u9A5V1dRZStOhpJ6vacUp4fub
         ObKg==
X-Gm-Message-State: AO0yUKXi7kNqghzex0+SeruANMWivhHSxGVS3hJOGMGdafTOKjUHV7Oa
        iYjH7/M/U2GidSqWY2ERFObikC9wZvC6yq0dS2S1kSBXF0DWBw==
X-Google-Smtp-Source: AK7set/Tw09LMpYA+jNld7/Th5YCO4FEbukjL+QroqLMcndCO8mW/VNbSdcadzicpgxvlQyxucHHajuMJ2h4sPNFTvA=
X-Received: by 2002:ab0:341a:0:b0:5f7:89e9:d714 with SMTP id
 z26-20020ab0341a000000b005f789e9d714mr3212309uap.0.1676036407949; Fri, 10 Feb
 2023 05:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20230208234229.GA2496794@bhelgaas> <20230210001845.GA2630328@bhelgaas>
 <CAKd_mfQyZ4fePBH4Rtg94g00mRoqUcmukWX1EgzwowNLzdhcSg@mail.gmail.com>
In-Reply-To: <CAKd_mfQyZ4fePBH4Rtg94g00mRoqUcmukWX1EgzwowNLzdhcSg@mail.gmail.com>
From:   Mark Enriquez <enriquezmark36@gmail.com>
Date:   Fri, 10 Feb 2023 21:39:56 +0800
Message-ID: <CAKd_mfSgzb5Zwb-_hjXMuiFfOw=ZoZn0GrC37=s8DraQTXVRhw@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        tasev.stefanoska@skynet.be, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, Thomas Witt <kernel@witt.link>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Resending this in plaintext mode.
I apologize for the duplicate mail.

Sorry,
Mark Francis
----------------------
Hello,

I tried the test patch with the "ASPM: can't restore L1SS while L1
enabled" message on the v6.1 tag.

I tried setting the ASPM policy to default rather than powersupersave.
Tested twice.
The result is I get to see the messages in the kernel log. The system
resumed successfully in all tests.
[  330.438136] ACPI: PM: Waking up from system sleep state S3
[  330.445959] ACPI: EC: interrupt unblocked
[  330.446174] pcieport 0000:00:1c.0: ASPM: can't restore L1SS while
L1 enabled (0x0042)
[  330.446177] pcieport 0000:00:1c.6: ASPM: can't restore L1SS while
L1 enabled (0x0002)
[  330.448354] r8169 0000:03:00.0: ASPM: can't restore L1SS while L1
enabled (0x0142)
[  330.448368] sdhci-pci 0000:04:00.0: ASPM: can't restore L1SS while
L1 enabled (0x0102)
[  330.448672] pcieport 0000:00:06.0: ASPM: can't restore L1SS while
L1 enabled (0x0042)
[  330.448965] nvme 0000:02:00.0: ASPM: can't restore L1SS while L1
enabled (0x0042)
[  330.449814] pcieport 0000:00:01.0: ASPM: can't restore L1SS while
L1 enabled (0x0042)
[  330.577111] pci 0000:01:00.0: ASPM: can't restore L1SS while L1
enabled (0x0142)
[  330.580820] ACPI: EC: event unblocked
[  330.581066] sd 0:0:0:0: [sda] Starting disk

I also noticed that these messages also pop out when activating a
userspace powersave tool (i.e., tlp).
(I was restoring my machine after the test, that is, re-enabling
services like tlp.
 Then, I accidentally knocked off the wall plug with my foot causing
tlp to activate its battery profile)
[ 4065.786154] pcieport 0000:00:1c.0: ASPM: can't restore L1SS while
L1 enabled (0x0042)
[ 4065.799553] r8169 0000:03:00.0: ASPM: can't restore L1SS while L1
enabled (0x0142)
[ 4065.969703] r8169 0000:03:00.0 enp3s0: Link is Down

I really wish I could also try and speculate other solutions but I am
ignorant with respect to the PCIe specifications.

Nevertheless, Hope this helps.
Let me know if I also need to test the case where the commits are reverted.

Thanks,


On Fri, Feb 10, 2023 at 9:35 PM Mark Enriquez <enriquezmark36@gmail.com> wrote:
>
> Hello,
>
> I tried the test patch with the "ASPM: can't restore L1SS while L1 enabled" message on the v6.1 tag.
>
> I tried setting the ASPM policy to default rather than powersupersave. Tested twice.
> The result is I get to see the messages in the kernel log. The system resumed successfully in all tests.
> [  330.438136] ACPI: PM: Waking up from system sleep state S3
> [  330.445959] ACPI: EC: interrupt unblocked
> [  330.446174] pcieport 0000:00:1c.0: ASPM: can't restore L1SS while L1 enabled (0x0042)
> [  330.446177] pcieport 0000:00:1c.6: ASPM: can't restore L1SS while L1 enabled (0x0002)
> [  330.448354] r8169 0000:03:00.0: ASPM: can't restore L1SS while L1 enabled (0x0142)
> [  330.448368] sdhci-pci 0000:04:00.0: ASPM: can't restore L1SS while L1 enabled (0x0102)
> [  330.448672] pcieport 0000:00:06.0: ASPM: can't restore L1SS while L1 enabled (0x0042)
> [  330.448965] nvme 0000:02:00.0: ASPM: can't restore L1SS while L1 enabled (0x0042)
> [  330.449814] pcieport 0000:00:01.0: ASPM: can't restore L1SS while L1 enabled (0x0042)
> [  330.577111] pci 0000:01:00.0: ASPM: can't restore L1SS while L1 enabled (0x0142)
> [  330.580820] ACPI: EC: event unblocked
> [  330.581066] sd 0:0:0:0: [sda] Starting disk
>
> I also noticed that these messages also pop out when activating a userspace powersave tool (i.e., tlp).
> (I was restoring my machine after the test, that is, re-enabling services like tlp.
>  Then, I accidentally knocked off the wall plug with my foot causing tlp to activate its battery profile)
> [ 4065.786154] pcieport 0000:00:1c.0: ASPM: can't restore L1SS while L1 enabled (0x0042)
> [ 4065.799553] r8169 0000:03:00.0: ASPM: can't restore L1SS while L1 enabled (0x0142)
> [ 4065.969703] r8169 0000:03:00.0 enp3s0: Link is Down
>
> I really wish I could also try and speculate other solutions but I am ignorant with respect to the PCIe specifications.
>
> Nevertheless, Hope this helps.
> Let me know if I also need to test the case where the commits are reverted.
>
> Thanks,
>
> On Fri, Feb 10, 2023 at 8:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+cc Thomas]
>>
>> On Wed, Feb 08, 2023 at 05:42:29PM -0600, Bjorn Helgaas wrote:
>> > On Fri, Jan 20, 2023 at 02:45:40PM +0530, Vidya Sagar wrote:
>> > > Skip save and restore of ASPM L1 Sub-States specific registers if they
>> > > are not already enabled in the system. This is to avoid issues observed
>> > > on certain platforms during restoration process, particularly when
>> > > restoring the L1SS registers contents.
>> > >
>> > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
>> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> > > ---
>> > > v2:
>> > > * Address review comments from Kai-Heng Feng and Rafael
>> > >
>> > >  drivers/pci/pcie/aspm.c | 17 ++++++++++++++++-
>> > >  include/linux/pci.h     |  1 +
>> > >  2 files changed, 17 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> > > index 53a1fa306e1e..bd2a922081bd 100644
>> > > --- a/drivers/pci/pcie/aspm.c
>> > > +++ b/drivers/pci/pcie/aspm.c
>> > > @@ -761,11 +761,23 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>> > >  {
>> > >     struct pci_cap_saved_state *save_state;
>> > >     u16 l1ss = dev->l1ss;
>> > > -   u32 *cap;
>> > > +   u32 *cap, val;
>> > >
>> > >     if (!l1ss)
>> > >             return;
>> > >
>> > > +   /*
>> > > +    * Skip save and restore of L1 Sub-States registers if they are not
>> > > +    * already enabled in the system
>> > > +    */
>> > > +   pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
>> > > +   if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
>> > > +           dev->skip_l1ss_restore = true;
>> > > +           return;
>> > > +   }
>> >
>> > I think this fix is still problematic.  PCIe r6.0, sec 5.5.4, requires
>> > that
>> >
>> >   If setting either or both of the enable bits for ASPM L1 PM
>> >   Substates, both ports must be configured as described in this
>> >   section while ASPM L1 is disabled.
>> >
>> > The current Linux code does not observe this because ASPM L1 is
>> > enabled by PCI_EXP_LNKCTL (in the PCIe Capability Link Control
>> > register), while ASPM L1 PM Substate configuration is in PCI_L1SS_CTL1
>> > (in the L1 PM Substates Capability), and these two things are not
>> > integrated:
>> >
>> >   pci_restore_state
>> >     pci_restore_aspm_l1ss_state
>> >       aspm_program_l1ss
>> >         pci_write_config_dword(PCI_L1SS_CTL1, ctl1)         # L1SS restore
>> >     pci_restore_pcie_state
>> >       pcie_capability_write_word(PCI_EXP_LNKCTL, cap[i++])  # L1 restore
>> >
>> > So I suspect the problem is that we're writing PCI_L1SS_CTL1 while
>> > ASPM L1 is enabled, and the device gets confused somehow.
>> >
>> > I think it would be better change this restore flow to follow that
>> > spec requirement instead of skipping the save/restore like this.
>>
>> A revert of 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability
>> for suspend/resume") has been in linux-next starting with Feb 6.
>>
>> I originally reverted 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM
>> Substates Control Register programming") because it broke
>> suspend/resume differently [1].
>>
>> I had to revert 4ff116d0d5fd at the same time because 5e85eba6f50d
>> added aspm_program_l1ss(), which was used by 4ff116d0d5fd.
>>
>> I don't think Tasev or Mark have directly tested reverting
>> 4ff116d0d5fd to see if it resolves the problem *they* are seeing.  But
>> that would be good to know so I can update the commit logs.
>>
>> Bjorn
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216877
