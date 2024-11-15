Return-Path: <linux-pci+bounces-16814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5E99CD6C1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F898B23B35
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4217C7CB;
	Fri, 15 Nov 2024 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlG5/vnV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC88169397
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650037; cv=none; b=VL3QoeZQR2biybEGqrU2aa6aepIObixyjgcbpL9AIw0nMaeYZDO5oDtqWi5ynMovyf6dP7Eu8UJ4CzFUsn5bW+e6YvnuKTC2p7QMbY0XMRcWvlrTOsTbGHcYmXFrM5PFNnxs1fEFY7Y5umXjW4T22P6GBEe2hkHDi3GPb+DqtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650037; c=relaxed/simple;
	bh=bdAaHpR+nNdY6wNclWW7HgfgB0YscCkL2OoAHM6L+Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXC0iFGoSJunqyRg/toZsSbty6UaUUY98i8g26N8hQcu/643pWD2vR5KnBJJFwxp0PRdg5AxlBLVvzI3Y5+uoxuEDzPqcWDnNFO4TCBF02c5vP2x3hLuVSbRRB+n44vQSDr2K97t/GXNmPCYqUlofDgsGkZXMsaXwnRjFSaQBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlG5/vnV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72410cc7be9so1331523b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 21:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731650035; x=1732254835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1PjeRA2xF0UfYKxZqoGwYKdedIBD+c8tm1voRBlQUUw=;
        b=zlG5/vnV4fln+m3TeRU2HtiyHiYajA8DILWy9zRE6/0b0Djmxf3BdkTlQeSVjzQoDV
         MLedJ9EesaGkLYCG19nYVLL6anb6s7EnysJ8NdNWr1FeA1GpQCMMQFxqFzAsacJyLXqI
         SQ0GLxiqKcX5r56SHzeciYOPzPQztv2CRm6jzHmtykODe+TznCwELYP1CXMf+UyNcb5T
         QomOPlNKwnGdgKKc1OHyzTI7DeUi9zYl06ISd4H7hrBXfFSSx6+WaT63Fw7MWlZy97XN
         1+Ng3UJfrzOQhquuv61hQD0CHNQt/jF8+/hMP2FUDQLRCFS5rUDzaSyhXh9kHDrr44mm
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731650035; x=1732254835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PjeRA2xF0UfYKxZqoGwYKdedIBD+c8tm1voRBlQUUw=;
        b=BfhdTDkQ8FUncyOEG0eULvMmUYhrHE3VW8m4vmE9kfpD/RUX6uObekAX16PqS1k2tM
         SUBU2QKX3PQcNPrByTWUh25P031HhRiF5KIwbq+vR8Jno9E+oGyPtNp+Qt0kpADNi7fI
         tQByOGrS8bqecyOWn/eFIShaiuDpdiQQLXpZQDu0miGB3S6EuPj8NQjntMlR0TJ+Nioz
         8nsPDofFvjxaxsUXGvDsnLBQchWqWcdALj7oKWiYLM5sh80lbZ6x+4YE0r195iXwW1LB
         sAK3G56qmLuBpdlO/OznWMTGeCTYFGfRpWqgJUBcACcoKhPa8qGRMaZwnRbiOrVq7cUC
         Xrag==
X-Forwarded-Encrypted: i=1; AJvYcCW+oZHKW1faQSdHcSpTjuvQ+6FdCJODSwCiwG3/53Jysukp+sLmiDpHz/mCtq+pnoNz3T/CsRy/snc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsUxtXau9pb3gNZ48xXb2FJW1rPWCLEUEpMOZn1kGDiRDNJBd
	i71pynMKd8oyuAVTjT1CvQ1COjDYHpFyiUqwJUvGKYv6T6WQeMh9arDcH7DEnpz4cpzDgwehT+c
	=
X-Google-Smtp-Source: AGHT+IHmV0f5ACpxzanuVu8/s8lS/U9F+wX+vXwYW4uBhXPOpRx3lgl4u0soVqVsy9/dqVOSZpIM6g==
X-Received: by 2002:a05:6a00:a08:b0:71e:6489:d18 with SMTP id d2e1a72fcca58-72476d5a95fmr2213233b3a.22.1731650034748;
        Thu, 14 Nov 2024 21:53:54 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477120a13sm617854b3a.60.2024.11.14.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 21:53:54 -0800 (PST)
Date: Fri, 15 Nov 2024 11:23:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/3] PCI: rockchip: Simplify reset control handling
 by using reset_control_bulk*() function
Message-ID: <20241115055346.m2rhcb7z5hoydxsb@thinkpad>
References: <20241019060141.2489-1-linux.amoon@gmail.com>
 <20241019060141.2489-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019060141.2489-3-linux.amoon@gmail.com>

On Sat, Oct 19, 2024 at 11:31:34AM +0530, Anand Moon wrote:
> Currently, the driver acquires and asserts/deasserts the resets
> individually thereby making the driver complex to read. But this
> can be simplified by using the reset_control_bulk APIs.
> Use devm_reset_control_bulk_get_exclusive() API to acquire all
> the resets and use reset_control_bulk_{assert/deassert}() APIs to
> assert/deassert them in bulk.
> 
> Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> 
> 1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
> as Root Complex'.
> 
> 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per
> section '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> reset_control_bulk APIs.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One nitpick below. But don't need to respin as it can be fixed while applying.

> ---
> v10: Fix some typo
> v9: Improved the commit message and try to fix few review comments.
> v8: I tried to address reviews and comments from Mani.
>     Follow the sequence of De-assert as per the driver code.
>     Drop the comment in the driver.
>     Improve the commit message with the description of the TMP section.
>     Improve the reason for the core functional changes in the commit
>     description.
>     Improve the error handling messages of the code.
> v7: replace devm_reset_control_bulk_get_optional_exclusive()
>         with devm_reset_control_bulk_get_exclusive()
>     update the functional changes.
> V6: Add reason for the split of the RESET pins.
> v5: Fix the De-assert reset core as per the TRM
>     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
>     simultaneously.
> v4: use dev_err_probe in error path.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot
>     fixed checkpatch warning.
> ---
>  drivers/pci/controller/pcie-rockchip.c | 154 +++++--------------------
>  drivers/pci/controller/pcie-rockchip.h |  26 +++--
>  2 files changed, 48 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 2777ef0cb599..c17aa8ec80b9 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c

[...]

> @@ -252,31 +177,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		goto err_power_off_phy;
>  	}
>  
> -	/*
> -	 * Please don't reorder the deassert sequence of the following
> -	 * four reset pins.
> -	 */
> -	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->core_rst);
> -	if (err) {
> -		dev_err(dev, "deassert core_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->mgmt_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->pipe_rst);
> +	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> +					  rockchip->core_rsts);
>  	if (err) {
> -		dev_err(dev, "deassert pipe_rst err %d\n", err);
> +		dev_err(dev, "Couldn't deassert Core %d\n", err);

"Couldn't deassert Core resets %d"

- Mani

-- 
மணிவண்ணன் சதாசிவம்

