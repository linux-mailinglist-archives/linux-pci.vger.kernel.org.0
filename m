Return-Path: <linux-pci+bounces-1763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2C82634D
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 08:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11A41C20CA3
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 07:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E9125DD;
	Sun,  7 Jan 2024 07:35:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A012B6E;
	Sun,  7 Jan 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so768331b3a.0;
        Sat, 06 Jan 2024 23:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704612901; x=1705217701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm5Mf9kCNlKUfd/TrO0Ism8YwZiQYC1lXtW9MWAgam8=;
        b=BBx4HMw3XjlZz/2O6wxqPcTt4DY/3XBFh4pi5UPMjosIUBfDh4JLqycNB7W+32cxob
         PjVyOzGHqBkqyO7I+4GYMiY0CnQ/yxYhMXTLtDYsRFeVNTWG1gp8RGbV+vIoF1exIFz/
         D2jKMH6grggCyvPVQMuYQiIVow7Or5AuslJU2Lnxt8SLAff6unz6eSS51e5DZ/lYz+wX
         1xAemCdb9I6RSMXbMEOZBcoOj0WJPA8n/mnjE0uclIfWWMaLOe3o3X+WqAfRC5Gb1m50
         6F/ZMFhg4643BrKbSJjV03PzN++hkhubhQOzMGCiBpcagi41a9SfQ2LFEh9NtfKxsLvk
         hBDA==
X-Gm-Message-State: AOJu0Yy01iOZgIv+/euvydUlyRkx9WNOjR0JFYDpE3rWH6LM/g+sabh+
	ctfGRra6J2omRQn/oo3HV0Q=
X-Google-Smtp-Source: AGHT+IGmg9vJWqpqO6pmY3DdwwyXKe6ID5FHYr8gqLB0HGPj/gyXJpD0AjTDkqTj2DiNul9rruQm7g==
X-Received: by 2002:a05:6a21:6da9:b0:199:276c:37c4 with SMTP id wl41-20020a056a216da900b00199276c37c4mr2358489pzb.1.1704612900911;
        Sat, 06 Jan 2024 23:35:00 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78195000000b006da13eda169sm4073657pfi.141.2024.01.06.23.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 23:35:00 -0800 (PST)
Date: Sun, 7 Jan 2024 16:34:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_bjorande@quicinc.com,
	fancer.lancer@gmail.com, vidyas@nvidia.com
Subject: Re: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240107073459.GD3450972@rocinante>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
 <20240107072707.GC3450972@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107072707.GC3450972@rocinante>

Hello,

> > This series is the continuation of previous work by Vidya Sagar [1] to fix the
> > issues related to accessing DBI register space before completing the core
> > initialization in some EP platforms like Tegra194/234 and Qcom SM8450.
> 
> Applied to controller/dwc-ep, thank you!
> 
> [01/02] PCI: designware-ep: Fix DBI access before core init
>         https://git.kernel.org/pci/pci/c/d3d13b00a2cf
> [02/02] PCI: designware-ep: Move pci_epc_init_notify() inside dw_pcie_ep_init_complete()
>         https://git.kernel.org/pci/pci/c/a171e1d60dad

Manivannan, I applied this series to "controller/dwc-ep" rather than
"controller/dwc" so that I can have a look at the conflicts we have
between this series and the current "controller/dwc" branch.

There have been changes from both Shimoda-san and Frank Li that both
changed some things and moved some things around within the code base,
so this series no longer cleanly applies.

However, I wanted the CI system to pick the branch for testing, as the
sooner, the better.

Hopefully, we can resolve the conflicts before Bjorn sends his Pull
Request with 6.8 changes.

	Krzysztof

