Return-Path: <linux-pci+bounces-14229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD999926F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12656B21EAE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D691CEE9B;
	Thu, 10 Oct 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG9zYQkV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B181CEAD5;
	Thu, 10 Oct 2024 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588882; cv=none; b=m6K8k6TFaXDfRW0GH1Q1hp9ibFsOy3FsxhydpGXpWq7vURIfnHHT1be3Mp8XjGQJl2PWTvL3oBSD2lujLsV3I8q0j3AmowkmDQHva9K7EfNWtZiinh4PFSpyDQpCIw5e4neAg1YAZIPs5awQdY05w4CtjOsfjlCFMqnaVEZhPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588882; c=relaxed/simple;
	bh=t75GofhSDibsXkq5vhS4pidBfayrClpUtE6ydgObg+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EYsvELSdHnU/R4VZnZamw0x95O95wZI85wMyqJHUfWhlIS6tMm9d8nYgCrl+yl8AoH6S9OO5d/lSUkzSGy+KdN+o38owkm+eDUdcHiRZzOrO25bUeNtjhUdooAdi3VVjBqYqw2svdNy3gLZmG5YiWNCXjc+P084M/d7t6X/O+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG9zYQkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB84C4CED3;
	Thu, 10 Oct 2024 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728588881;
	bh=t75GofhSDibsXkq5vhS4pidBfayrClpUtE6ydgObg+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iG9zYQkVZOcHqaRKOI6wrEQfjZr1z2Z1D1IvFmoQOxkYniwUQ5sAxt06tdYj8VKcU
	 xoTZ1cqyxu9E/OSihCgCRlY3narzag0HOkF5Kfxz4px/KIJZZVM2mdgN8tqPRKgNfI
	 9fP+3VMNw8pby4faKrqHqyq1mhK7EKFg3knqgEaJUzrnVkyQOk4q9ejfN+SSKNNQnu
	 fGJVvha/YpE7+9bZeOKyMSLTlmb5bADcEFNzrg/T9lNTjWMearBHlv7zKjxwBJgEo4
	 R/A6gnNUokMqGUS6b540eVyh+ESwutnNCRc/vzvqxRWg2KU9qTpjGEDlLdEW2VJsjz
	 dX2Q1jC5z6h7g==
Date: Thu, 10 Oct 2024 14:34:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] PCI: Add NXP NETC vendor ID and device IDs
Message-ID: <20241010193439.GA574630@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-8-wei.fang@nxp.com>

On Wed, Oct 09, 2024 at 05:51:12PM +0800, Wei Fang wrote:
> NXP NETC is a multi-function PCIe Root Complex Integrated Endpoint
> (RCiEP) and it contains multiple PCIe functions, such as EMDIO,
> PTP Timer, ENETC PF and VF. Therefore, add these device IDs to
> pci_ids.h
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK as-is, but if you have occasion to update this series for other
reasons:

  - Slightly redundant to say "multi-function RCiEP ... contains
    multiple functions".

  - Mention the drivers that will use these symbols in this commit log
    so it's obvious that they're used in multiple places.

  - Wrap the commit log to fill 75 columns.

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

