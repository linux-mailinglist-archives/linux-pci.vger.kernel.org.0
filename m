Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFC4AC93A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 20:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiBGTLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 14:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiBGTFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 14:05:07 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 11:04:57 PST
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF49C0401E5;
        Mon,  7 Feb 2022 11:04:56 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 5dd7a95bd39484f6; Mon, 7 Feb 2022 19:58:15 +0100
Received: from kreacher.localnet (unknown [213.134.187.66])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4F2E166B39E;
        Mon,  7 Feb 2022 19:58:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Abhishek Sahu <abhsahu@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Date:   Mon, 07 Feb 2022 19:58:13 +0100
Message-ID: <2249802.ElGaqSPkdT@kreacher>
In-Reply-To: <20220204233219.GA228585@bhelgaas>
References: <20220204233219.GA228585@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.66
X-CLIENT-HOSTNAME: 213.134.187.66
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekjedrieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrieeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprggshhhsrghhuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
 khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
> [+cc Rafael, hoping for your review :)

+Mika

> Wonder if we should add something like this to MAINTAINERS so you get
> cc'd on power-related things:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..3d9a211cad5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15422,6 +15422,7 @@ F:	include/linux/pm.h
>  F:	include/linux/pm_*
>  F:	include/linux/powercap.h
>  F:	kernel/configs/nopm.config
> +K:	pci_[a-z_]*power[a-z_]*\(

It seems so, but generally PM patches should be CCed to linux-pm anyway.

>  
>  DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
>  M:	Daniel Lezcano <daniel.lezcano@kernel.org>
> ]
> 
> On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
> > Consider the following sequence during PCI device runtime
> > suspend/resume:
> > 
> > 1. PCI device goes into runtime suspended state. The PCI state
> >    will be changed to PCI_D0 and then pci_platform_power_transition()
> >    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.

You mean PCI_D3hot I suppose?

> > 2. Parent bridge goes into runtime suspended state. If parent
> >    bridge supports D3cold, then it will change the power state of all its
> >    children to D3cold state and the power will be removed.
> > 
> > 3. During wake-up time, the bridge will be runtime resumed first
> >    and pci_power_up() will be called for the bridge. Now, the power
> >    supply will be resumed.
> > 
> > 4. pci_resume_bus() will be called which will internally invoke
> >    pci_restore_standard_config(). pci_update_current_state()
> >    will read PCI_PM_CTRL register and the current_state will be
> >    updated to D0.
> > 
> > In the above process, at step 4, the ACPI device state will still be
> > ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
> > invoked.

I'm not quite following.

I'm assuming that this description applies to the endpoint device that was
previously put into D3_hot.

Since its current state is D3_hot, it is not D0 (in particular) and the
pci_set_power_state() in pci_restore_standard_config() should put int into
D0 proper, including the platform firmware part.

> > We need call the pci_platform_power_transition() with state
> > D0 to change the ACPI state to ACPI_STATE_D0.
> > 
> > This patch calls pci_power_up() if current power state is D0 inside
> > pci_restore_standard_config(). This pci_power_up() will change the
> > ACPI state to ACPI_STATE_D0.
> > 
> > Following are the steps to confirm:
> > 
> > Enable the debug prints in acpi_pci_set_power_state()
> > 
> > 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
> > 
> > Before:
> > 
> > 0000:01:00.0: power state changed by ACPI to D3hot
> > 0000:00:01.0: power state changed by ACPI to D3cold
> > 0000:00:01.0: power state changed by ACPI to D0
> > 
> > After:
> > 
> > 0000:01:00.0: power state changed by ACPI to D3hot
> > 0000:00:01.0: power state changed by ACPI to D3cold
> > 0000:00:01.0: power state changed by ACPI to D0
> > 0000:01:00.0: power state changed by ACPI to D0
> > 
> > So with this patch, the PCI device ACPI state is also being
> > changed to D0.
> > 
> > Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> > ---
> >  drivers/pci/pci-driver.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 588588cfda48..64e0cca12f16 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
> >   */
> >  static int pci_restore_standard_config(struct pci_dev *pci_dev)
> >  {
> > +	int error = 0;
> >  	pci_update_current_state(pci_dev, PCI_UNKNOWN);
> >  
> >  	if (pci_dev->current_state != PCI_D0) {
> > -		int error = pci_set_power_state(pci_dev, PCI_D0);
> > -		if (error)
> > -			return error;
> > +		error = pci_set_power_state(pci_dev, PCI_D0);
> > +	} else {
> > +		/*
> > +		 * The platform power state can still be non-D0, so this is
> > +		 * required to change the platform power state to D0.
> > +		 */

This really isn't expected to happen.

If the device's power state has been changed to D3hot by ACPI, it is not in D0.

It looks like the state tracking is not working here.

> > +		error = pci_power_up(pci_dev);
> >  	}
> >  
> > +	if (error)
> > +		return error;
> > +
> >  	pci_restore_state(pci_dev);
> >  	pci_pme_restore(pci_dev);
> >  	return 0;
> 




