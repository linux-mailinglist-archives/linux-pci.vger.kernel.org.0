Return-Path: <linux-pci+bounces-15231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFB9AEF89
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E4A1C23D43
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECB200BA2;
	Thu, 24 Oct 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh6jwWlf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D921ABEC5;
	Thu, 24 Oct 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793793; cv=none; b=SnkoL9zkFHr8XFIS/SZ9Uj7avKWZlTVHBE9JWHX6/zYEaeNX0yvVv7zNnN3RsyMxI5nNZKpxNzQ0CuwSKPd/U9WU5nSTvkaS/+RSIenzq0odn6NAUOfb5+A/lkRsQSHQiy4XGVVhAU+BFKEcVMGxZeja9LGV8ySIymzhWZugAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793793; c=relaxed/simple;
	bh=wLQMy1fODAkR42k9k6/+Wm4LDF7pthKYgpT1trqgyOw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f7f+AsqWmGpl50Ub80pl3SKNVLQrhgsSKMJxINv9OD6zjBV8fSk3JUDhwtupTytrJ88mghNuA1sur1rU9hZNxg4A7OPUkq6aNsMW3F5JZTqVuxQt7sXqiDJkC4vZWk216IucN7xxIxJz0Yc4NbYOAg1L5SlX66W3cJYecJTU5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh6jwWlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBD6C4CEC7;
	Thu, 24 Oct 2024 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793792;
	bh=wLQMy1fODAkR42k9k6/+Wm4LDF7pthKYgpT1trqgyOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Vh6jwWlfQPZQfjGlftsi17vLLxsL5zZfNiCQJA2ugdrSPwdnao4cYzJyH0fJ6SOtW
	 EF4BpJJSaW/azYChmUCGPgtF60kJ5Ga+F4UOY8t7jAnOrlLrMyGn4oouunBZzHCT1M
	 fvE8QLJsWMtwAf8CzmBC9u+E5eiOfJXEK1ooBb+gyXZpVlB5b8noHv+zXIw2wVG1Fu
	 XrKE3eaAMgLNmhlgI+83nsVQldtJ8ATNVcV1uV+zZQgJ4B4p/0iP//CxA9VKOft6Q7
	 moGu1Ut3ybCF+ODoRccN/cyOjJDWUAM3zQPUSl1hfdEOGZ0XB0t7lJ2ZVYWaUK8Knr
	 YtTARepCr42mQ==
Date: Thu, 24 Oct 2024 13:16:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 08/13] PCI: Add NXP NETC vendor ID and device
 IDs
Message-ID: <20241024181630.GA966301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-9-wei.fang@nxp.com>

On Thu, Oct 24, 2024 at 02:53:23PM +0800, Wei Fang wrote:
> NXP NETC is a multi-function RCiEP and it contains multiple functions,
> such as EMDIO, PTP Timer, ENETC PF and VF. Therefore, add these device
> IDs to pci_ids.h.
> 
> Below are the device IDs and corresponding drivers.
> PCI_DEVICE_ID_NXP2_ENETC_PF: nxp-enetc4
> PCI_DEVICE_ID_NXP2_NETC_EMDIO: fsl-enetc-mdio
> PCI_DEVICE_ID_NXP2_NETC_TIMER: ptp_netc
> PCI_DEVICE_ID_NXP2_ENETC_VF: fsl-enetc-vf
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please drop my ack.  I don't think these meet the spirit of the
guidance in pci_ids.h, which is there to minimize churn in that file
and make backports easier:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

PCI_DEVICE_ID_NXP2_NETC_TIMER and PCI_DEVICE_ID_NXP2_ENETC_VF aren't
used at all by this series, so they shouldn't be added to pci_ids.h.

PCI_DEVICE_ID_NXP2_NETC_EMDIO is used only by
drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c, so it should be
defined there, not in pci_ids.h.

PCI_DEVICE_ID_NXP2_ENETC_PF is used by enetc.c and enetc4_pf.c, but
it looks like those are basically part of the same driver, and it
could be defined in enetc4_hw.h or similar.

> ---
> v5: no changes
> ---
>  include/linux/pci_ids.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4cf6aaed5f35..acd7ae774913 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1556,6 +1556,13 @@
>  #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
>  #define PCI_DEVICE_ID_PHILIPS_SAA9730	0x9730
>  
> +/* NXP has two vendor IDs, the other one is 0x1957 */
> +#define PCI_VENDOR_ID_NXP2		PCI_VENDOR_ID_PHILIPS
> +#define PCI_DEVICE_ID_NXP2_ENETC_PF	0xe101
> +#define PCI_DEVICE_ID_NXP2_NETC_EMDIO	0xee00
> +#define PCI_DEVICE_ID_NXP2_NETC_TIMER	0xee02
> +#define PCI_DEVICE_ID_NXP2_ENETC_VF	0xef00
> +
>  #define PCI_VENDOR_ID_EICON		0x1133
>  #define PCI_DEVICE_ID_EICON_DIVA20	0xe002
>  #define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
> -- 
> 2.34.1
> 

