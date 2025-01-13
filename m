Return-Path: <linux-pci+bounces-19682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DECA0BF06
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 18:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE9F169C88
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01024022F;
	Mon, 13 Jan 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jamJJ+2X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD224022E;
	Mon, 13 Jan 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790038; cv=none; b=pXpv2hrndZ6p7+gw3AOMhQpcqObiHlea4ciuMQrD7GpbgXBf1J9TnEUraZtO2sAI3jtCbcapNtIBC2v9jjzxDsurKehiY0i45DMmAXHKNvNjykDIh75QIde+nU+XSZubOMC0e6Vws+dy/PjR3baf89CODbnfQ/wLXLDq+6zSgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790038; c=relaxed/simple;
	bh=ySRV7DeVVqG6159rIEcQVRu6kmqPv0c0PZtBy0854Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P135ivYKVGRX6ML3doHuqtes1AZiUoRR6E1s1vNMGgmC1/9tg8uMu4+yKwR44cMYPYHMOUwzAlDWcsBmTk+dUa1pyaI4sAyJgmOUwqP+yiU0ghvYZJyuO/2Z8KgL3Kq7LhXUDlHUi6r0FOkgdbmKszTNaEQqru2fto5C6AE899M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jamJJ+2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9894DC4CEE2;
	Mon, 13 Jan 2025 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736790037;
	bh=ySRV7DeVVqG6159rIEcQVRu6kmqPv0c0PZtBy0854Zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jamJJ+2X/frR3nL5ESQIjVEY4xu74F8SMJNG4ICR8uRcRnFDPFiIW+BMcYUgMeEAn
	 ou+bzjhtEuImsPFH110/y6XdxYyfpfHXwOpeUiKfe8QHGtag0L7OJeu6ty6JVk0NsX
	 RA3wK7n+0Q5dJ/1toVwNfXy2V/Y+GVBNE18v3wsEDoTpSJTN2NnTf6RHidV3BUv0/p
	 pOZeVKq5MX8VRdCMOYy8l1qn+D7pGUpn5uMmv3tUOIgybes/Tt87QHJnCtMIyB+5R1
	 azUJwStUr5sig8DUbpGAFo5tivd4F+VG7VKEb6FGX8Qkp5PnDOrwWA7RW74PNlaJYW
	 MWDnsu0maH+Lg==
Date: Mon, 13 Jan 2025 11:40:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Tushar Dave <tdave@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH] Documentation: Fix config_acs= example
Message-ID: <20250113174035.GA408797@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>

[+cc folks from related discussion at
https://lore.kernel.org/r/20241213202942.44585-1-tdave@nvidia.com]

On Sun, Sep 15, 2024 at 10:36:58AM +0900, Akihiko Odaki wrote:
> The documentation used to say:
> > For example,
> >   pci=config_acs=10x
> > would configure all devices that support ACS to enable P2P Request
> > Redirect, disable Translation Blocking, and leave Source Validation
> > unchanged from whatever power-up or firmware set it to.
> 
> However, a flag specification always needs to be suffixed with "@" and a
> PCI device string, which is missing in this example. It needs to be
> suffixed with "@pci:0:0" to configure all devices that support ACS in
> particular.

Thanks for the patch.  Krzysztof added a bit to the commit log at:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=57722057d762

but I think we should also include the flags template:

  config_acs =
                Format:
                <ACS flags>@<pci_dev>[; ...]

so the commit log includes a hint about what "flag specification"
means.

Also, I think the "pci_dev" documentation is poor and should be
improved in a second patch.  The only current mention I see is here:

        pci=option[,option...]  [PCI,EARLY] various PCI subsystem options.

                                Some options herein operate on a specific device
                                or a set of devices (<pci_dev>). These are
                                specified in one of the following formats:

                                [<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
                                pci:<vendor>:<device>[:<subvendor>:<subdevice>]

                                Note: the first format specifies a PCI
                                bus/device/function address which may change
                                if new hardware is inserted, if motherboard
                                firmware changes, or due to changes caused
                                by other kernel parameters. If the
                                domain is left unspecified, it is
                                taken to be zero. Optionally, a path
                                to a device through multiple device/function
                                addresses can be specified after the base
                                address (this is more robust against
                                renumbering issues).  The second format
                                selects devices using IDs from the
                                configuration space which may match multiple
                                devices in the system.

where I guess "pci_dev" means the second format:

  pci:<vendor>:<device>[:<subvendor>:<subdevice>]

and apparently "pci:0:0" means all devices with vendor==0 and
device==0, and it's not completely obvious to me that this means "all
devices".

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ee2984e46c06..5611903c27a9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4604,7 +4604,7 @@
>  				  '1' – force enabled
>  				  'x' – unchanged
>  				For example,
> -				  pci=config_acs=10x
> +				  pci=config_acs=10x@pci:0:0
>  				would configure all devices that support
>  				ACS to enable P2P Request Redirect, disable
>  				Translation Blocking, and leave Source
> 
> ---
> base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> change-id: 20240911-acs-3043a2737cc9
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>
> 

