Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44A34A6222
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiBARRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 12:17:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49504 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiBARRN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 12:17:13 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id b96f82b7671223d4; Tue, 1 Feb 2022 18:17:11 +0100
Received: from kreacher.localnet (unknown [213.134.162.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 82F5966B3C6;
        Tue,  1 Feb 2022 18:17:10 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vidya Sagar <vidyas@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc:     rafael.j.wysocki@intel.com, keith.busch@intel.com, hch@lst.de,
        bhelgaas@google.com, mmaddireddy@nvidia.com, kthota@nvidia.com,
        sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
Date:   Tue, 01 Feb 2022 18:17:09 +0100
Message-ID: <2616042.mvXUDI8C0e@kreacher>
In-Reply-To: <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com> <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.64
X-CLIENT-HOSTNAME: 213.134.162.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeefgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudeivddrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlhdrjhdrfiihshhotghkihesihhnthgvlhdrtghomhdprhgtphhtthhopehkvghithhhrdgsuhhstghhsehinhhtvghlrdgtohhmpdhrtghpthht
 ohephhgthheslhhsthdruggvpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmmhgrugguihhrvgguugihsehnvhhiughirgdrtghomhdprhgtphhtthhopehkthhhohhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshgrghgrrhdrthhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, February 1, 2022 5:30:54 PM CET Keith Busch wrote:
> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
> > Hi Rafael & Christoph,
> > My query is regarding the comment and the code that follows after it at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
> > What I understood from it is that, there is an underlying assumption
> > that the power to the devices is not removed during the suspend call.
> > In the case of device-tree based platforms like Tegra194, power is
> > indeed removed to the devices during suspend-resume process. Hence, the
> > NVMe devices need to be taken through the shutdown path irrespective of
> > whether the ASPM states are enabled or not.
> > I would like to hear from you the best method to follow to achieve this.
> 
> Since platform makers can't converge on how to let a driver know what
> it's supposed to do, I suggest we default to the simple shutdown suspend
> all the time. We can add a module parameter to let a user request nvme
> power management if they really want it. No matter what we do here,
> someone is going to complain, but at least simple shutdown is safe...

Agreed.



