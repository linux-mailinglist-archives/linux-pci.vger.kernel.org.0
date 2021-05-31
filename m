Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4AE396743
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhEaRj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 13:39:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43512 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhEaRj2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 13:39:28 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id e732ecc29d476c8b; Mon, 31 May 2021 19:37:46 +0200
Received: from kreacher.localnet (89-64-82-42.dynamic.chello.pl [89.64.82.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A98F966980A;
        Mon, 31 May 2021 19:37:45 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Target PM state is D3cold if the upstream bridge is power manageable
Date:   Mon, 31 May 2021 19:37:45 +0200
Message-ID: <4650685.31r3eYUQgx@kreacher>
In-Reply-To: <20210531133435.53259-1-mika.westerberg@linux.intel.com>
References: <20210531133435.53259-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.42
X-CLIENT-HOSTNAME: 89-64-82-42.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdelfedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeelrdeigedrkedvrdegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrgedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuhhtkhgrrhhshhdrhhdrphgrthgvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehkohgsrgdrkhhosegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohep
 rhgrjhgrthhjrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, May 31, 2021 3:34:35 PM CEST Mika Westerberg wrote:
> Some PCIe devices only support PME (Power Management Event) from D3cold.
> One example is ASMedia xHCI controller:
> 
> 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>   ...
>   Capabilities: [78] Power Management version 3
>   	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> 	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> With such devices, if it has wake enabled, the kernel selects lowest
> possible power state to be D0 in pci_target_state(). This is problematic
> because it prevents the root port it is connected to enter low power
> state too which makes the system consume more energy than necessary.

But this is not the only case affected by the patch AFAICS.

> The problem in pci_target_state() is that it only accounts the "current"
> device state, so when the bridge above it (a root port for instance) is
> transitioned into D3hot the device transitions into D3cold.

Well, as designed, pci_target_state() is about states the the device can
be programmed into, which cannot be D3cold if the device has not platform PM.

> This is because when the root port is first transitioned into D3hot then the
> ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
> the root port and the device are in D3cold). If the root port is kept in
> D3hot it still means that the device below it is still effectively in
> D3cold as no configuration messages pass through. Furthermore the
> implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
> expect to be transitioned into D3cold soon after its link transitions
> into L2/L3 Ready state.

That's true, but the prerequisite is to put the endpoint device into D3hot
and not to attempt to put it into D3cold.

> Taking the above into consideration, instead of forcing the device stay
> in D0 we look at the upstream bridge and whether it is allowed to enter
> D3 (hot/cold). If this is the case we conclude that the actual target
> state of the device is D3cold. This also follows the logic in
> pci_set_power_state() that sets power state of the subordinate devices
> to D3cold after the bridge itself is transitioned into D3cold.

IMO what needs to be fixed is what happens when the "wakeup" argument is "true"
and that simply needs to special-case D3hot.

Namely, if wakeup from D3hot is not supported, D3hot should still be returned
if wakeup from D3cold is supported and the upstream bridge supports D3cold.

Returning D3cold from pci_target_state() for devices that cannot be programmed
into D3cold would be confusing IMV.

> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Tested-by: Koba Ko <koba.ko@canonical.com>
> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Previous version of the patch can be found here:
> 
>   https://patchwork.kernel.org/project/linux-pci/patch/20210510102647.40322-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Added Ack from Kai-Heng
>   * Reworked the commit log according to Bjorn's comments (I tried my best
>     to answer the questions and explain the issue).
>   * Expanded the comment to mention why the target state is D3cold.
> 
>  drivers/pci/pci.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..71c6a6437406 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2578,8 +2578,21 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  		return target_state;
>  	}
>  
> -	if (!dev->pm_cap)
> +	if (!dev->pm_cap) {
>  		target_state = PCI_D0;
> +	} else {
> +		struct pci_dev *bridge;
> +
> +		/*
> +		 * Look at the upstream bridge and whether it is allowed to
> +		 * enter D3hot (or D3cold). In both cases this device is
> +		 * not accessible anymore and its effective power state
> +		 * becomes D3cold.
> +		 */
> +		bridge = pci_upstream_bridge(dev);
> +		if (bridge && pci_bridge_d3_possible(bridge))
> +			target_state = PCI_D3cold;
> +	}
>  
>  	/*
>  	 * If the device is in D3cold even though it's not power-manageable by
> 




