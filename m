Return-Path: <linux-pci+bounces-28395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A49AC396B
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 07:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D0170114
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 05:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C41C84BF;
	Mon, 26 May 2025 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WM/Bq9Or"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F31C3BF7
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748238797; cv=none; b=oAfYYMG6tdR6Fzzm9zbepQXZI+2o1Xqbz16SWkx93P2GgmL5XnxnjiKXO4qY9M7okIt7K1r/3QsApHNLEBQuDU/ylv5awvfmPvO7buOYWqs0COHqcjiPx9MWwQdWu6GTG+TOKWRoAa9XCt3pPcaqHvgx43jYEiGVqv16PF+dtX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748238797; c=relaxed/simple;
	bh=kmyubVlunoIUiEKvSOIf5A+2whmj3s42M06AcmAhLsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7ptD79lTayPL4bw4yTeT+2zAQP09dVq3+o5So7d4bNq6nwpKzBrvUHAleqy2wOqobv/162PCfIBcYa04t1g4DHcRVmBN2Ix4nwcO0PxL/lNzgGeF/9LP2jleWvfY9N5TZfLtZAqgo2HMhbFqwZtLIE64ti8AQgeMyvXNgNlOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WM/Bq9Or; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30f0d8628c8so1840634a91.0
        for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 22:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748238795; x=1748843595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZ91f7dL2KrSUC6ZCQ76XjXZbCOo3Qh60BX2sHpVW4o=;
        b=WM/Bq9OrgoQ+/LEMZVrGLzThu1fB5CoGfseukGa4srXBexOpTgaB4M9Me3Gi6DzQL+
         FUZAlQ1dnpfsSr1NdLFRRfK5uYmnvoZGys2iGI+6VBd4LzrtfP/kYixaDrSNTXgWd7PJ
         4bydNdqCBQKjvDs8GieOEpSY1oeEosPa66iTuOldJQ6I/7f7C6jeylIQkcwDRgvv+knj
         MvswvnQZrQUO0BpdR0fuMa6LYUPTq/6T6zsV2Ald2PFpal2Msch4g9FoTr3XhrHp2kS2
         tas24SZc7+aq+YMgXLWYYVZUHYk4v/6WGnF8Pv5GWB2FnHEFtkkVH6HG+g3mq6E0ZhjA
         FFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748238795; x=1748843595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ91f7dL2KrSUC6ZCQ76XjXZbCOo3Qh60BX2sHpVW4o=;
        b=pwSiVhS/n+LP7bjZwuYbLYwupd7x7vHZcgsI5IzYxvUdN3A2CdYYpZvIJlZhqv1aeu
         Iw9RICgL9GY6KDQ66FDkrRizeayEvj6vL2kej9baasFnpxXKDYwP42rDsToGcuPj3UiN
         lzsk5JLX1Xa2Rpz5D8LGAhsRa8vHIQfTtmlAHc4HMxUEcvbKOnG/eC8ObWz0imlXXUmp
         KqVu12SXhOUK4f3l6buFcSoNIiBcz4d+5jkn+mgDv6dH0VHptKTPA6EOsYe21cxQcoNP
         2NY0i+evwaAdL2LPpqTvxagiwMM/CY/aooRxT67eIcPJA1VbM4+vIgAItH5RRFlvKPzD
         gy6Q==
X-Gm-Message-State: AOJu0YyaHcce6PjBK71v7sB2icp1fzLxCJFWmXydFQ7TmugtueUwC5X7
	FgRp3MnYGpWlU8wLbJz7+Iyhp2eMxFkxV7eHcvb5Kdd3excX5ij4mPR/9zEmWdN39A==
X-Gm-Gg: ASbGnctCSSJJDrlkyhibBoypplPjCv+ZqtmAFD6NW2ymoVInK8rGrXhexkedBW0ev18
	KumpDoM6KYlsCq/pvMAepR/k07uOu/+STCJehAoG/cBdDvYD0wQwFMR6T41qw+dsvshf+pyEWCU
	iGcZH6e1plvELLyg32Aq1QeOwd4Lcz4bhmEl//lTbW9uOnPpOTTNVQ0cnJ+1suS7gWu1MqlIgvy
	B5bNvDc6f8u81DDFY1/I/OqsaMzU6Ea3kTqUPoaiZrcJVEooZCuhKtainJ5Q6Rl1OesMGBPyUgA
	43FCYyAWZffVlMJ2UkoTJegkTH1P36jFlhFWFuXIFY4sg3+IHwtY2W9/U63yLpo=
X-Google-Smtp-Source: AGHT+IGnHfzhN3nQjnh6URSDPC7YA6MxsMC2oe5i0GekUNsUAvcMub/70E3JjwBAb9SXaVgpwTPaSw==
X-Received: by 2002:a17:90b:4c50:b0:30e:6a9d:d78b with SMTP id 98e67ed59e1d1-3110b7a51c7mr11722634a91.12.1748238794701;
        Sun, 25 May 2025 22:53:14 -0700 (PDT)
Received: from thinkpad ([120.56.207.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385b68sm11490336a91.11.2025.05.25.22.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 22:53:14 -0700 (PDT)
Date: Mon, 26 May 2025 11:23:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cassel@kernel.org, wilfred.mallawa@wdc.com
Subject: Re: [PATCH 0/2] PCI: Slot reset fixes
Message-ID: <5zm6no23j7dakjqksb6b4vwwe4ef6iewc4nl4sjvc6nyjnafbh@jcc6im6ydgwi>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>

On Sun, May 25, 2025 at 12:23:02AM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series fixes the issues reported for the slot reset feature merged for
> v6.16.
> 
> This series is on top of dw-rockchip branch where the slot reset patches are
> merged. The patches in this series can be squashed into the respective commits
> since they are not merged into mainline.
> 

Squashed to dw-rockchip!

- Mani

> - Mani
> 
> Manivannan Sadhasivam (2):
>   PCI: Save and restore root port config space in
>     pcibios_reset_secondary_bus()
>   PCI: Rename host_bridge::reset_slot() to
>     host_bridge::reset_root_port()
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-qcom.c        |  8 ++++----
>  drivers/pci/controller/pci-host-common.c      | 20 +++++++++----------
>  drivers/pci/pci.c                             | 15 +++++++++++---
>  include/linux/pci.h                           |  2 +-
>  5 files changed, 31 insertions(+), 22 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

