Return-Path: <linux-pci+bounces-30253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56DAE1AE6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE1B1776FE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAE257AF2;
	Fri, 20 Jun 2025 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd9PF8Dd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F22080E8;
	Fri, 20 Jun 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422398; cv=none; b=dXz9iPMA5TdJeK/WSsVRq9jHxRXe/VbGSDojL+o0O9Tfl/DuB79kTHIlPAIl7n1ScVYOuZXb0ILxlpY9I0kxDgWC5W3GCT6fjxDN/FPSQLaxHj0fg8AHMbXaI9mVluxFaz3NG9AH7jrLzxvNj9wEW0Ka/TSHexXdDLZ7h+EeDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422398; c=relaxed/simple;
	bh=fgzYl4aH6iI0tjTv9jxNK75vM6b9nLzYeirPJhe6RsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/fNhKGPeWCCmo7JVtdHvN+hvDDbeZiAskCMZ1IYu+QejRpMgALKDlkkCueg1mhYSMRwGvw25rFVjAMMGf1Pir9LmTzFbI8i2R3OWCwIETTYRiANgh9ZFFNfg7OBKp4xg6pYEYDIo5Cde4G8GjRfSfOemHnFgucUB9uFJDkPYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd9PF8Dd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fba9f962so1291047b3a.0;
        Fri, 20 Jun 2025 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750422396; x=1751027196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7ARiXudRcsVDm3GaWtxNNIcJ4AykF/rfMCwYdzsnKw=;
        b=Sd9PF8Ddtl5TXdydfPjRAy5MIaZwM41j6nYO9CaslL6rqj6p9q9uhVtxfR077fTdCC
         3/UZN1x3xRIt5P4vDbAg130qRjr4yRmFoUj8pghzPgAITh3Lao+MoCR1I5lonOVP5PRQ
         HQXdpdzutZkHifySfB0shmayIb/uMudwk/AUevjp1roGddo5hxCrEJ+GGPfaoEROVV9H
         j77IDFJknIQTeeXTGpMD7lhgLvWGCe7GBjyGvN17cNsqKjfW+vq9WXRE11SFTqrjJl0t
         6F9wrab7/S2NP2HFH+ZKhBwOwxeuRPHLCKzndtbb+FgwqdwlJ/lna03Wh0gAvVG5geg3
         c2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750422396; x=1751027196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7ARiXudRcsVDm3GaWtxNNIcJ4AykF/rfMCwYdzsnKw=;
        b=Sdvd2yp4+KbIoRObTS64mQLa+FilU0uRlt3ln0j2Il/niLv+ZqbDZGIEeamCMBkCmO
         XocIfq7dJyryQfN9Gz8sVE1ooU7pUjnkDhQj07cPiKVwtkMYMs3Fh5PoBBxJrniaM4Xo
         PULPCzMzPQuGIpCUBg42bk4dsDgVQkwoNJimNzAHNdH9/I8qm6aJaMbS9wqJvc6AqpLU
         28Ikmhxa3pF5UZTmvoGtjZdTUk2fE3eCCx9RubEJJjkkgq7r+4dK0NDxpGfbP/JrvqB/
         KdV1nDYVg15Js+Y5cCgEi7utIYn6Gj9ECjTsZbWwbtXvppjcUZ+LxD7jNmWirw+tC5qn
         Tq2A==
X-Forwarded-Encrypted: i=1; AJvYcCVIHjst02YcDLfS1bE8II/cWrsyc7V0Cgclkb9/CrEhsFN+VWZEPrAKmdVBy4RORUibPl2mqbvaY6vS@vger.kernel.org, AJvYcCVIiS6AcDIjJPuLQ6DawZVD08CE+nmKuLBGXbdNvqQeTfGY7+1hVO3O59SJ2IljKqn2tuNnZcb7s5YHZoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG38jqPF652FZ4Ufg4qf41zh3j0InoTSWpuFPHCB4P9/S71NtS
	4cmE/REOO/zjhU4yjNn9toZTneTu2iUeLc2lV8xEviA7xtFuaKM6gvES
X-Gm-Gg: ASbGnctfu99pvvTXMW/8b2wBckprsAzWFxUlbj2Nrk9rQFACOlJlBvNJCBnOresxD9C
	5MgPVk2SeU0unDuQ6HKLjfXywRqunPtBZcx1WA2uregItpamPyvO8zB9x/s70UDBZHlq/El03By
	IMhAJXfb/Os68jw0YysNcM06/LSPrLWFOJRfxFj+XR3qqS7eejItexNM1WmRR6Z204HSwrS/9T3
	q/Vkwbb6d/9RLeQP06sYFo70W8yG8CnUwYfFC1p5W3UO1DOuhfQysZIeetU8YK/yHHglvEHS+ey
	4Jh3YNCWv6fsip8mMfOPlG9836fXvFIyQBeWyysPyVVb+8gyqg==
X-Google-Smtp-Source: AGHT+IHnSxrJDupZ3OPyegK3Fz6jZqTNQdZvWSKyqjh1BSv5jMmoQ/P/ubeKmDuHCyMxy9L2ZLnnvg==
X-Received: by 2002:aa7:9f05:0:b0:742:b928:59cb with SMTP id d2e1a72fcca58-7490f572337mr2605669b3a.7.1750422396458;
        Fri, 20 Jun 2025 05:26:36 -0700 (PDT)
Received: from geday ([2804:7f2:800b:cab9::dead:c001])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118f2basm1364196a12.9.2025.06.20.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:26:35 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:26:29 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 3/4] phy: rockchip-pcie: Enable all four lanes
Message-ID: <aFVTdYWxuq9YzVQR@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <ce661babb3e2f08c8b28554ccb5508da503db7ba.1749833987.git.geraldogabriel@gmail.com>
 <4c2c9a15-50bc-4a89-b5fe-d9014657fca7@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2c9a15-50bc-4a89-b5fe-d9014657fca7@arm.com>

On Fri, Jun 20, 2025 at 01:04:46PM +0100, Robin Murphy wrote:
> On 2025-06-13 6:03 pm, Geraldo Nascimento wrote:
> > Current code enables only Lane 0 because pwr_cnt will be incremented
> > on first call to the function. Use for-loop to enable all 4 lanes
> > through GRF.
> 
> If this was really necessary, then surely it would also need the 
> equivalent changes in rockchip_pcie_phy_power_off() too?
> 
> However, I'm not sure it *is* necessary - the NVMe on my RK3399 board 
> happily claims to be using an x4 link, so I stuck a print of inst->index 
> in this function, and sure enough I do see it being called for each 
> instance already:
> 
> [    1.737479] phy phy-ff770000.syscon:pcie-phy.1: power_on 0
> [    1.738810] phy phy-ff770000.syscon:pcie-phy.2: power_on 1
> [    1.745193] phy phy-ff770000.syscon:pcie-phy.3: power_on 2
> [    1.745196] phy phy-ff770000.syscon:pcie-phy.4: power_on 3
> 

Hi Robin, and thanks for caring, it's excellent to rely on your
extensive expertise on ARM in general and RK3399 specifically!

However, on my board I'm positive it does not work without proposed
patch and I get stuck with x1 link without it.

There are currently very similar patches applied downstream to Armbian
and OpenWRT so at least I'm confident that is not only my board which is
quirky and other people experienced the same problem.

Thanks,
Geraldo Nascimento

> Thanks,
> Robin.

