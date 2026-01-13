Return-Path: <linux-pci+bounces-44678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641CD1B776
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB86C302106B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9587318EFF;
	Tue, 13 Jan 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9I2bAwv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441830F922;
	Tue, 13 Jan 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340791; cv=none; b=edyWj8DqbjxVl5bfnP+e9gsVx4/GyxC2e5R+wYkRAp06ETFtUL51jsFbfKwhDziAaG5AeBSxKIw0dswp4J+50cANi7lA00T2wgQiG7LVBO2U1IBcbeL+sosHJgIO+8EDbuKHFiKQm/QPz5m9HWvsjfucnrDT/LViv+vED8ik954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340791; c=relaxed/simple;
	bh=50OooZQr+axK/WY8rkv+dFFrWBuwx26gvpQRFT62CXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TelMGjVTXK7mKoiooCwVekAyit/z10krRzj/CcuBpDbv3CdXvspwvWGsJ/4TUkev3FvnGLscFf76XHwQquBHruhOgjBqxX0jugXTGMASy1P3HFlCCGuDCroIeu8Wgx37uAYGIg+eM4vSenQWQLEV45Gr4cfE0G7zGHBUnqYJtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9I2bAwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0305CC116C6;
	Tue, 13 Jan 2026 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340791;
	bh=50OooZQr+axK/WY8rkv+dFFrWBuwx26gvpQRFT62CXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a9I2bAwvocF4kW1suM7+toDFKNO+c5bLSwY/VrywOnC3HVhTJw/HjDugF7YZHPVbI
	 BOW+3SWJ5MZ2keYKRWkVoRXunkur6PLBu3BBW+TBRGIUT2Vn/+fMadiawWt6WFZd0h
	 4JDeVAe3Msbkd5eB/iiet4Ae+zQpFr29BOMpKgKaK7Kp4a3WfJ0RrCY3FJB4wsE2MH
	 eNCSJ4EPCkT9lq9lGFRt+awIXpGcw9p4hEh1+R+DkXNEkMJx0LF7Ro50NGdsXA/AtS
	 E7+YNDzbW0C0wG1aVW3tceHDko8LooEtAIuQE5tTatEVc1Jsb/iFRXjZZt9r6xUI62
	 DInk8wxkk5Tug==
Date: Tue, 13 Jan 2026 15:46:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/IDE: Fix using wrong VF ID for RID range
 calculation
Message-ID: <20260113214629.GA781429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111080631.506487-1-ming.li@zohomail.com>

On Sun, Jan 11, 2026 at 04:06:31PM +0800, Li Ming wrote:
> When allocate a new IDE stream for a pci device in SR-IOV case, the RID
> range of the new IDE stream should cover all VFs of the device. VF id
> range of a pci device is [0 - (num_VFs - 1)], so should use (num_VFs - )
> as the last VF's ID.

s/(num_VFs - )/(num_VFs - 1)/  (I think?)

s/pci/PCI/  (or could just omit, it's obvious these are PCI devices)
s/id/ID/

> Fixes: 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/pci/ide.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 26f7cc94ec31..9629f3ceb213 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -283,8 +283,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	/* for SR-IOV case, cover all VFs */
>  	num_vf = pci_num_vf(pdev);
>  	if (num_vf)
> -		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> -				    pci_iov_virtfn_devfn(pdev, num_vf));
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf - 1),
> +				    pci_iov_virtfn_devfn(pdev, num_vf - 1));
>  	else
>  		rid_end = pci_dev_id(pdev);
>  
> -- 
> 2.34.1
> 

