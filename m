Return-Path: <linux-pci+bounces-40121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68720C2CE32
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C761896489
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3E3164C7;
	Mon,  3 Nov 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgjN6fex"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2582313E01;
	Mon,  3 Nov 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184363; cv=none; b=fPkcqetHOHcVD/oMkqdmEba2nJejA6IPyftjvK/yNvbnzT4Zw0aZL8bFgvgrG13O4lnumNP6EqFCOKWPFYZQ8I2MyCMiz/u64SGaQ1SKMIQ8uj+o92IIb5Fpo9rNO5DAfpaZpiYgLLZLpMJnoVFD2GD2Gk8UuoJKAq+9cd0uJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184363; c=relaxed/simple;
	bh=tdr1Y9hWD+HuCU/m5CGAw+x/qLjxPumW0AhXTl4KYG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e02Zig0pq1sj28ge2Ypm96u9RD81XBw6pI9t2nyDQg8w1GP+XbsoIuMFJfAFrsw1t277sjY0CmiYjX/TC6qLsJ6Zkv8pO1tS85BL5ghOALTdUnkJzep60vlZkusJN0qA3r18SQdMDm/w62W9ef6+XDU2bvxXltIYk0LSatXeALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgjN6fex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69326C4CEE7;
	Mon,  3 Nov 2025 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184363;
	bh=tdr1Y9hWD+HuCU/m5CGAw+x/qLjxPumW0AhXTl4KYG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SgjN6fexNbDgchvx9QB87LReICkpTsUQbl48i0HVhsUhUJrQtRVm10xWHDwC8GJ2V
	 ++cURxC6Do7leBJ6ezwKhKs0uipuETJOgUixbjmY2Eey1AONM4/XbSJVS0wZYYqg+v
	 F/8zwzUZWBksWD29Kg3H0zIt871q1EeGpfTvc6AXrInSC1ajU9aVCiJKS16gkkmbz9
	 XAvgee0F2g4jC9xsp9fnjJ5CmKdYq6yy/DW/3A/PqVYwE9fCbi2fYROU1VWF4taMLi
	 0RDEYvbPfMlITeBy9bHxAkVn7FFWbaaPcWSjj8Hiqp1OIUYxclc+o/0H2L0CY/0Fgt
	 Pg15RnkRNf0PA==
Date: Mon, 3 Nov 2025 09:39:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PCI: Add macro for link status check delay
Message-ID: <20251103153922.GA1806421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101160538.10055-3-18255117159@163.com>

On Sun, Nov 02, 2025 at 12:05:36AM +0800, Hans Zhang wrote:
> Add PCIE_LINK_STATUS_CHECK_MS macro for link status check delay.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 86449f2d627b..b57d8e4c3a48 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -77,6 +77,8 @@ struct pci_pme_device {
>   */
>  #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
>  
> +#define PCIE_LINK_STATUS_CHECK_MS 1
> +
>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {
>  	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
> @@ -4632,7 +4634,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>  		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>  		if ((lnksta & lnksta_mask) == lnksta_match)
>  			return 0;
> -		msleep(1);
> +		msleep(PCIE_LINK_STATUS_CHECK_MS);

Doesn't seem worth it to me.

>  	} while (time_before(jiffies, end_jiffies));
>  
>  	return -ETIMEDOUT;
> -- 
> 2.34.1
> 

