Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D634F6B63
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiDFU3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiDFU2v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 16:28:51 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14159A5C;
        Wed,  6 Apr 2022 11:49:53 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id e48b1e147d45a240; Wed, 6 Apr 2022 20:49:51 +0200
Received: from kreacher.localnet (unknown [213.134.186.238])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9343966BD10;
        Wed,  6 Apr 2022 20:49:50 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Date:   Wed, 06 Apr 2022 20:49:49 +0200
Message-ID: <2648053.mvXUDI8C0e@kreacher>
In-Reply-To: <e5fd300b-1ec5-934f-cd98-611ce81aa19c@nvidia.com>
References: <20220204233219.GA228585@bhelgaas> <11967527.O9o76ZdvQC@kreacher> <e5fd300b-1ec5-934f-cd98-611ce81aa19c@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.238
X-CLIENT-HOSTNAME: 213.134.186.238
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfduteeiueegtefgieetteffveehhefgieelkedujeekhfettdfgvdelveevkeegnecuffhomhgrihhnpehouhhtlhhoohhkrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekiedrvdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeeirddvfeekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprggshhhsrghhuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgv
 rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, April 6, 2022 8:43:19 PM CEST Abhishek Sahu wrote:
> On 4/6/2022 5:36 PM, Rafael J. Wysocki wrote:
> > On Wednesday, April 6, 2022 7:32:45 AM CEST Abhishek Sahu wrote:
> >> On 4/5/2022 10:20 PM, Rafael J. Wysocki wrote:
> >>> On Tuesday, April 5, 2022 6:36:34 PM CEST Abhishek Sahu wrote:
> >>>> On 2/8/2022 4:00 PM, Abhishek Sahu wrote:
> >>>>> On 2/8/2022 12:28 AM, Rafael J. Wysocki wrote:
> >>>>>> On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
> >>>>>>> [+cc Rafael, hoping for your review :)
> >>>>>>
> >>>>>> +Mika
> >>>>>>
> >>>>>>> Wonder if we should add something like this to MAINTAINERS so you get
> >>>>>>> cc'd on power-related things:
> >>>>>>>
> >>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>>>>> index ea3e6c914384..3d9a211cad5d 100644
> >>>>>>> --- a/MAINTAINERS
> >>>>>>> +++ b/MAINTAINERS
> >>>>>>> @@ -15422,6 +15422,7 @@ F:    include/linux/pm.h
> >>>>>>>  F:   include/linux/pm_*
> >>>>>>>  F:   include/linux/powercap.h
> >>>>>>>  F:   kernel/configs/nopm.config
> >>>>>>> +K:   pci_[a-z_]*power[a-z_]*\(
> >>>>>>
> >>>>>> It seems so, but generally PM patches should be CCed to linux-pm anyway.
> >>>>>>
> >>>>>>>
> >>>>>>>  DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
> >>>>>>>  M:   Daniel Lezcano <daniel.lezcano@kernel.org>
> >>>>>>> ]
> >>>>>>>
> >>>>>>> On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
> >>>>>>>> Consider the following sequence during PCI device runtime
> >>>>>>>> suspend/resume:
> >>>>>>>>
> >>>>>>>> 1. PCI device goes into runtime suspended state. The PCI state
> >>>>>>>>    will be changed to PCI_D0 and then pci_platform_power_transition()
> >>>>>>>>    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.
> >>>>>>
> >>>>>> You mean PCI_D3hot I suppose?
> >>>>>>
> >>>>>
> >>>>>  Yes. It should be PCI_D3hot here.
> >>>>>
> >>>>>>>> 2. Parent bridge goes into runtime suspended state. If parent
> >>>>>>>>    bridge supports D3cold, then it will change the power state of all its
> >>>>>>>>    children to D3cold state and the power will be removed.
> >>>>>>>>
> >>>>>>>> 3. During wake-up time, the bridge will be runtime resumed first
> >>>>>>>>    and pci_power_up() will be called for the bridge. Now, the power
> >>>>>>>>    supply will be resumed.
> >>>>>>>>
> >>>>>>>> 4. pci_resume_bus() will be called which will internally invoke
> >>>>>>>>    pci_restore_standard_config(). pci_update_current_state()
> >>>>>>>>    will read PCI_PM_CTRL register and the current_state will be
> >>>>>>>>    updated to D0.
> >>>>>>>>
> >>>>>>>> In the above process, at step 4, the ACPI device state will still be
> >>>>>>>> ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
> >>>>>>>> invoked.
> >>>>>>
> >>>>>> I'm not quite following.
> >>>>>>
> >>>>>> I'm assuming that this description applies to the endpoint device that was
> >>>>>> previously put into D3_hot.
> >>>>>>
> >>>>>
> >>>>>  Yes. This is applicable for endpoint devices which was previously put
> >>>>>  into D3hot.
> >>>>>
> >>>>>> Since its current state is D3_hot, it is not D0 (in particular) and the
> >>>>>> pci_set_power_state() in pci_restore_standard_config() should put int into
> >>>>>> D0 proper, including the platform firmware part.
> >>>>>>
> >>>>>
> >>>>>  The pci_restore_standard_config() for endpoint devices are being called
> >>>>>  internally during wake-up of upstream bridge.
> >>>>>
> >>>>>  pci_power_up(struct pci_dev *dev)
> >>>>>  {
> >>>>>       ...
> >>>>>       if (dev->runtime_d3cold) {
> >>>>>         /*
> >>>>>          * When powering on a bridge from D3cold, the whole hierarchy
> >>>>>          * may be powered on into D0uninitialized state, resume them to
> >>>>>          * give them a chance to suspend again
> >>>>>          */
> >>>>>         pci_resume_bus(dev->subordinate);
> >>>>>     }
> >>>>>     ...
> >>>>>  }
> >>>>>
> >>>>>  For the upstream bridge, the above code will trigger the wake-up of
> >>>>>  endpoint devices and then following code will be executed for the
> >>>>>  endpoint devices:
> >>>>>
> >>>>>  pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> >>>>>  {
> >>>>>     if (platform_pci_get_power_state(dev) == PCI_D3cold ||
> >>>>>         !pci_device_is_present(dev)) {
> >>>>>         dev->current_state = PCI_D3cold;
> >>>>>     } else if (dev->pm_cap) {
> >>>>>         u16 pmcsr;
> >>>>>
> >>>>>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >>>>>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> >>>>>     } else {
> >>>>>         dev->current_state = state;
> >>>>>     }
> >>>>>  }
> >>>>>
> >>>>>  In the above code, the current_state will be set to D0 for the
> >>>>>  endpoint devices since it will go into second block where
> >>>>>  it will read the PM_CTRL register.
> >>>>>
> >>>>>>>> We need call the pci_platform_power_transition() with state
> >>>>>>>> D0 to change the ACPI state to ACPI_STATE_D0.
> >>>>>>>>
> >>>>>>>> This patch calls pci_power_up() if current power state is D0 inside
> >>>>>>>> pci_restore_standard_config(). This pci_power_up() will change the
> >>>>>>>> ACPI state to ACPI_STATE_D0.
> >>>>>>>>
> >>>>>>>> Following are the steps to confirm:
> >>>>>>>>
> >>>>>>>> Enable the debug prints in acpi_pci_set_power_state()
> >>>>>>>>
> >>>>>>>> 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
> >>>>>>>>
> >>>>>>>> Before:
> >>>>>>>>
> >>>>>>>> 0000:01:00.0: power state changed by ACPI to D3hot
> >>>>>>>> 0000:00:01.0: power state changed by ACPI to D3cold
> >>>>>>>> 0000:00:01.0: power state changed by ACPI to D0
> >>>>>>>>
> >>>>>>>> After:
> >>>>>>>>
> >>>>>>>> 0000:01:00.0: power state changed by ACPI to D3hot
> >>>>>>>> 0000:00:01.0: power state changed by ACPI to D3cold
> >>>>>>>> 0000:00:01.0: power state changed by ACPI to D0
> >>>>>>>> 0000:01:00.0: power state changed by ACPI to D0
> >>>>>>>>
> >>>>>>>> So with this patch, the PCI device ACPI state is also being
> >>>>>>>> changed to D0.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/pci/pci-driver.c | 14 +++++++++++---
> >>>>>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >>>>>>>> index 588588cfda48..64e0cca12f16 100644
> >>>>>>>> --- a/drivers/pci/pci-driver.c
> >>>>>>>> +++ b/drivers/pci/pci-driver.c
> >>>>>>>> @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
> >>>>>>>>   */
> >>>>>>>>  static int pci_restore_standard_config(struct pci_dev *pci_dev)
> >>>>>>>>  {
> >>>>>>>> +   int error = 0;
> >>>>>>>>     pci_update_current_state(pci_dev, PCI_UNKNOWN);
> >>>>>>>>
> >>>>>>>>     if (pci_dev->current_state != PCI_D0) {
> >>>>>>>> -           int error = pci_set_power_state(pci_dev, PCI_D0);
> >>>>>>>> -           if (error)
> >>>>>>>> -                   return error;
> >>>>>>>> +           error = pci_set_power_state(pci_dev, PCI_D0);
> >>>>>>>> +   } else {
> >>>>>>>> +           /*
> >>>>>>>> +            * The platform power state can still be non-D0, so this is
> >>>>>>>> +            * required to change the platform power state to D0.
> >>>>>>>> +            */
> >>>>>>
> >>>>>> This really isn't expected to happen.
> >>>>>>
> >>>>>> If the device's power state has been changed to D3hot by ACPI, it is not in D0.
> >>>>>>
> >>>>>> It looks like the state tracking is not working here.
> >>>>>>
> >>>>>
> >>>>>  The state setting to D0 is happening due to the current logic present in
> >>>>>  pci_update_current_state(). If we can fix the logic in
> >>>>>  pci_update_current_state() to detect this condition and return state D3hot,
> >>>>>  then it should also fix the issue.
> >>>>>
> >>>>>  Thanks,
> >>>>>  Abhishek
> >>>>>
> >>>>
> >>>>  Hi Rafael/Mika,
> >>>>
> >>>>  Could you please help regarding the correct way to fix this issue.
> >>>>  I can update the patch accordingly.
> >>>
> >>> I think you can try one of the patches posted recently:
> >>>
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F3623886.MHq7AAxBmi%40kreacher%2F&amp;data=04%7C01%7Cabhsahu%40nvidia.com%7C87470c4f30f14871bcc708da17c5e913%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637848436478123578%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=USJs87Fmm0Vcjm1YWszZCBTpcNQED3InOuOdGgE3f88%3D&amp;reserved=0
> >>>
> >>> Thanks!
> >>>
> >>>
> >>>
> >>
> >>  Thanks Rafael.
> >>  I have applied both the changes and still the issue which I mentioned is happening.
> >>
> >>  Following are the prints:
> >>
> >>  0000:01:00.0: power state changed by ACPI to D3hot
> >>  0000:00:01.0: power state changed by ACPI to D3cold
> >>  0000:00:01.0: power state changed by ACPI to D0
> >>
> >>  So ACPI state change is still not happening for PCI endpoint devices.
> >>
> >>  Also, the I checked the code and the pci_power_up() will not be called
> >>  for endpoint devices. For endpoints, pci_restore_standard_config() will
> >>  be called first where the current state will come as D0.
> > 
> > OK, I see.
> > 
> > The problem is that if the PCI device goes to D0 because of the bridge power-up,
> > it's ACPI companion's power state may not follow, which means that we really
> > want to do a full power-up in there.
> > 
> > Please test the appended patch with the patch from
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F3623886.MHq7AAxBmi%40kreacher%2F&amp;data=04%7C01%7Cabhsahu%40nvidia.com%7C87470c4f30f14871bcc708da17c5e913%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637848436478123578%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=USJs87Fmm0Vcjm1YWszZCBTpcNQED3InOuOdGgE3f88%3D&amp;reserved=0
> > 
> > still applied.
> > 
> > ---
> >  drivers/pci/pci-driver.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-driver.c
> > +++ linux-pm/drivers/pci/pci-driver.c
> > @@ -1312,7 +1312,7 @@ static int pci_pm_runtime_resume(struct
> >          * to a driver because although we left it in D0, it may have gone to
> >          * D3cold when the bridge above it runtime suspended.
> >          */
> > -       pci_restore_standard_config(pci_dev);
> > +       pci_pm_default_resume_early(pci_dev);
> > 
> >         if (!pci_dev->driver)
> >                 return 0;
> > 
> 
>  Thanks Rafael.
>  With the above code change, the issue is getting fixed and the
>  PCI endpoint power state is also changing to D0.
> 
>  0000:01:00.0: power state changed by ACPI to D3hot
>  0000:00:01.0: power state changed by ACPI to D3cold
>  0000:00:01.0: power state changed by ACPI to D0
>  0000:01:00.0: power state changed by ACPI to D0

Thanks for testing!



