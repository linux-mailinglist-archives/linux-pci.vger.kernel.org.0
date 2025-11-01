Return-Path: <linux-pci+bounces-40000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32801C27821
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 06:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 019A24E26ED
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 05:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAE22FDFF;
	Sat,  1 Nov 2025 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgyhM0lz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8521B9C0;
	Sat,  1 Nov 2025 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973512; cv=none; b=boDsS39bRq5pznto/wembg6CjcrBd0JirQQPiIWhjhBCb2lvs5mp1w5qqWg3XM7F0wJabDi/LdJEB6+CW4TmKK5XujNT1EGBk+uWr1tFmb1SHobhdzX0pUDKHq4s6VvE6RqayiSK4ryFlmjpD2wgeb2WCQhpP2g3Dg0Z5XMbbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973512; c=relaxed/simple;
	bh=LeiFkNCDRAuejMGKT/dWBbvRfSXK4gUKUaZjvynezAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM+s5Yhfe+LC7XIsKejpf68lcepvJ7pdRVa8e4iHp5ShRkVrZjzqVEaOIUA2+vcF3RVHjE1yOTbkV1bbR090Tpf4Yv0Ct9+XBa+Re+wIxI5w3GKt1kK01TyO6m5VeNLfk8dgjgd7sdVNo23amouPFZQZsnhoDFZj6+a/AVlnY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgyhM0lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F3DC4CEF1;
	Sat,  1 Nov 2025 05:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761973511;
	bh=LeiFkNCDRAuejMGKT/dWBbvRfSXK4gUKUaZjvynezAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgyhM0lzKupdYYW7pR50+Ms59lrPZYwfGOjZftvoVOnEnGjcaQ2AuUMjAOeg4ZX84
	 //40GEC//ZWQ+tPQXCih7Fr/0YiRPFoosBxz+z31mRzNosWjgaAolCrz3oTG9bY2Xs
	 +Py8A4jd6dvEGBiBxKl2m70m2nlvROe60+51swpExO+Qsg3YolJmINEzapYlKkRjsE
	 OTDUqHn26jSYtZmFjnSNJ+HbOhqOtwv5vQCh76P0mlumE+teDkLH1i/qazrO8xYQtG
	 3X0E7LOR5D6PQIa3nJRd8iX7DF4mihqWmdAgRGNOmk2MKnrJJe3jeGnZxHhODSWd5h
	 zbJQxRiWRQh2w==
Date: Sat, 1 Nov 2025 10:34:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 2/7] PCI: Add assert_perst() operation to control PCIe
 PERST#
Message-ID: <prngl7yl7rveyp76ksmskzgv2oigayrhz4s5fnlz7iycae3kkp@v6fn54ybwrec>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
 <20251101-tc9563-v9-2-de3429f7787a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251101-tc9563-v9-2-de3429f7787a@oss.qualcomm.com>

On Sat, Nov 01, 2025 at 09:29:33AM +0530, Krishna Chaitanya Chundru wrote:
> Controller driver probes firsts, enables link training and scans the
> bus. When the PCI bridge is found, its child DT nodes will be scanned
> and pwrctrl devices will be created if needed. By the time pwrctrl
> driver probe gets called link training is already enabled by controller
> driver.
> 
> Certain devices like TC9563 which uses PCI pwrctl framework needs to
> configure the device before PCI link is up.
> 
> As the controller driver already enables link training as part of
> its probe, the moment device is powered on, controller and device
> participates in the link training and link can come up immediately
> and may not have time to configure the device.
> 
> So we need to stop the link training by using assert_perst() by asserting
> the PERST# and de-assert the PERST# after device is configured.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..ed5dac663e96e3a6ad2edffffc9fa8b348d0a677 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -829,6 +829,7 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +	int (*assert_perst)(struct pci_bus *bus, bool assert);
>  };
>  
>  /*
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

