Return-Path: <linux-pci+bounces-718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14EC80AF9F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971181F21129
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4F58AD8;
	Fri,  8 Dec 2023 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX42zSkU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FB46BB3
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 22:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35700C433C8;
	Fri,  8 Dec 2023 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702074270;
	bh=fmaA6134tzh6YjH1CJuoTJWpk0EPkk58Tyc/4DC1M2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RX42zSkUTQRLrbVZRM7unpmVK7OMXI/PYerEKfFG4PON+bj11mTPpVcI94CvLdwB3
	 ZdKS/CkIuIt+CsLTnkDVSB9OclxMiGZUTZzQWvbgTz+h+U9YqlsgdkJOhkm2P+tRJS
	 vscVs7Rm5C8DXsnzAU37t01+jmrdcHhevw0FiuEHCsGLcaAdwgruY3iqW8enzEn/5O
	 i6kH3+fxLxrRUU0O7tUY8bEvt+JYqaeJNtqmIC4aJgPUeA25k1l73eKtO2Cjkq6fvo
	 3QieOYAUDXVd7w9ek3ScV9uQLzN9rQagE6Tlx3fP9tnq2sT33a6pyDoZCCsU13Vbk/
	 M76xLfOwHXd1g==
Date: Fri, 8 Dec 2023 16:24:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sanath S <Sanath.S@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Message-ID: <20231208222428.GA808407@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816051923.2287912-1-Sanath.S@amd.com>

[+cc Mika, Maciej]

On Wed, Aug 16, 2023 at 10:49:23AM +0530, Sanath S wrote:
> In the case of Thunderbolt, it contains a PCIe switch and one or
> more hotplug-capable PCIe downstream ports where the daisy chain
> can be extended.
> 
> Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
> System BIOS allocates a very minimal number of buses for bridges and
> hot-plug capable PCIe downstream ports to enumerate the dock during
> boot. Because of this, we run out of bus space pretty quickly when
> more PCIe devices are attached to hotplug downstream ports in order
> to extend the chain.
> 
> Before:
>            +-04.0
>            +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
>            |                               +-01.0-[66]--
>            |                               +-02.0-[67]--
>            |                               +-03.0-[68]--
>            |                               \-04.0-[69]--
>            +-08.0

Looks like a clear issue here because there's no other use for
buses 70-c1.  But what would happen if there were more hotplug-capable
downstream ports, e.g., assume one at 08.1 leading to [bus c2-c7]?

The 04.1 bridge has a lot of space, but 08.1 has very little.  With
this patch, would we distribute it more evenly across 04.1 and 08.1?
If not, I think we'll just have the same problem when somebody plugs
in a similar hierarchy at 08.1.

> In case of a thunderbolt capable bridge, reconfigure the buses allocated
> by BIOS to the maximum available buses. So that the hot-plug bridges gets
> maximum buses and chain can be extended to accommodate more PCIe devices.
> This fix is necessary for all the PCIe downstream ports where the daisy
> chain can be extended.
> 
> After:
>            +-04.0
>            +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
>            |                               +-01.0-[66-84]--
>            |                               +-02.0-[85-a3]--
>            |                               +-03.0-[a4-c0]--
>            |                               \-04.0-[c1]--
>            +-08.0

This doesn't look like anything specific to Thunderbolt; it's just
that we don't do a good job of reassigning bus numbers in general,
right?  We shouldn't just punt and say "BIOS should have done
something" because not all machines *have* BIOS, and the OS can
reconfigure bus numbers as needed.  The patch certainly isn't
Thunderbolt-specific.

I guess this patch is on hold for now because the kernel test robot
complained:
https://lore.kernel.org/r/202308232106.50c8f492-oliver.sang@intel.com
and this hasn't been resolved or explained yet.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> ---
>  drivers/pci/probe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8bac3ce02609..ab7e90ef2382 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1263,6 +1263,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	bool fixed_buses;
>  	u8 fixed_sec, fixed_sub;
>  	int next_busnr;
> +	int start = bus->busn_res.start;
> +	int end = bus->busn_res.end;
>  
>  	/*
>  	 * Make sure the bridge is powered on to be able to access config
> @@ -1292,6 +1294,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		broken = 1;
>  	}
>  
> +	/* Reconfigure, If maximum buses are not allocated */
> +	if (!pass && start != 0 && end != 0xff && subordinate != end) {

I don't quite understand the test here.  In the "Before" example
above, I think bus->busn_res is [bus 63-c1], and subordinate is 69.
That certainly makes this condition true, but wouldn't you also want
to reallocate bus numbers if bus->busn_res were [bus 63-ff] and
subordinate were 69?

> +		pci_info(dev, "Bridge has subordinate 0x%x but max busn 0x%x, reconfiguring\n",

Most other logging here starts with lower-case, e.g., "bridge has ..."
Print the bus numbers in the typical format ("%02x").  Maybe use "%pR"
and &bus->busn_res for the first part.

> +			 subordinate, end);
> +		broken = 1;
> +	}
> +
>  	/*
>  	 * Disable Master-Abort Mode during probing to avoid reporting of
>  	 * bus errors in some architectures.
> -- 
> 2.34.1
> 

