Return-Path: <linux-pci+bounces-29125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D42AD0C4F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1117059C
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98910217679;
	Sat,  7 Jun 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ns5odZjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3D1C7009;
	Sat,  7 Jun 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290253; cv=none; b=ZLA+Tie91C6ATo6vcVFsrJSoccIhH8E3Q7VZvyv7VySr5/3RsW1bhHL1a2mOuvbigBRYAeQo/Mhba4CshQwaSV3Tr1eK6F6MmV6ipbLrkUiTrFFGZK575Kgcu54YnZwQ5tbF6fQH2KbV86+0dFEs7iwcI1DSkt7PImn2pNbYZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290253; c=relaxed/simple;
	bh=VzdmqcMNvBqE3KC0zj0VVYLrni/GN1NT9ay8sXX/Oms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj0oi/LbvHZI7r5eQGahBQII8Qvs+PndsW3ukFxpubAP/aSRXuoFng5K5ughyo07OlCg18i8OrVV66OQgG7SgQ5OBtJu/FbiLk6t3bR0sd6hlmaM7H+FnICNEuVoONWE15r2N6XcxpntJsFn6HadBh6tO01I55XIJeEKzsrvP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ns5odZjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C51C4CEE4;
	Sat,  7 Jun 2025 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290252;
	bh=VzdmqcMNvBqE3KC0zj0VVYLrni/GN1NT9ay8sXX/Oms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ns5odZjJt6lhUyX0pMfYyXcMLXpOPa+xQACBahwgKkqgsMf5wo087OjgjS6NihT75
	 eshtaC6q6950Gjl+0Pt8Dzg1KrBozq2Dvkksjd+1Ucy9dxqUrawcZ1BwRuDZc8Acpt
	 NXGi66sE4YW1tZhPCCsJ9IfxzvxTyt0sm30jVFrw=
Date: Sat, 7 Jun 2025 11:57:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Daniel Stodden <daniel.stodden@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Deren Wu <Deren.Wu@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
Subject: Re: [PATCH 6.11 1/1] PCI/ASPM: Disable L1 before disabling L1 PM
 Substates
Message-ID: <2025060702-deviate-faceted-bd57@gregkh>
References: <20250606015738.2724220-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606015738.2724220-1-macpaul.lin@mediatek.com>

On Fri, Jun 06, 2025 at 09:57:38AM +0800, Macpaul Lin wrote:
> From: Ajay Agarwal <ajayagarwal@google.com>
> 
> [ Upstream commit 7447990137bf06b2aeecad9c6081e01a9f47f2aa ]
> 
> PCIe r6.2, sec 5.5.4, requires that:
> 
>   If setting either or both of the enable bits for ASPM L1 PM Substates,
>   both ports must be configured as described in this section while ASPM L1
>   is disabled.
> 
> Previously, pcie_config_aspm_l1ss() assumed that "setting enable bits"
> meant "setting them to 1", and it configured L1SS as follows:
> 
>   - Clear L1SS enable bits
>   - Disable L1
>   - Configure L1SS enable bits as required
>   - Enable L1 if required
> 
> With this sequence, when disabling L1SS on an ARM A-core with a Synopsys
> DesignWare PCIe core, the CPU occasionally hangs when reading
> PCI_L1SS_CTL1, leading to a reboot when the CPU watchdog expires.
> 
> Move the L1 disable to the caller (pcie_config_aspm_link(), where L1 was
> already enabled) so L1 is always disabled while updating the L1SS bits:
> 
>   - Disable L1
>   - Clear L1SS enable bits
>   - Configure L1SS enable bits as required
>   - Enable L1 if required
> 
> Change pcie_aspm_cap_init() similarly.
> 
> Link: https://lore.kernel.org/r/20241007032917.872262-1-ajayagarwal@google.com
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> [bhelgaas: comments, commit log, compute L1SS setting before config access]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/pci/pcie/aspm.c | 92 ++++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 42 deletions(-)

6.11.y is long end-of-life, sorry.  See the front page of www.kernel.org
for the list of currently supported kernels.

thanks,

greg k-h

