Return-Path: <linux-pci+bounces-1762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D582634A
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 08:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E21F21D2A
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B058125DD;
	Sun,  7 Jan 2024 07:27:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199712B69;
	Sun,  7 Jan 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d45f182fa2so7328465ad.3;
        Sat, 06 Jan 2024 23:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704612430; x=1705217230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAbooWGGqO3YU/raFuW014rEvbq4pt1OPTznUPxdqfs=;
        b=jv0CfOlRGOd7JJrD6PCszU7CN68xCVTLpGuzedIhcOHnd+G/qtQnqbahfYBuZ6kWhx
         K7+EPX50rsPb4lspxvquVhqPlyrHhrcDc4Z0+zoiHt+nzjzPxYUPO8UBjkvOzxNt9aNq
         wsDgMCMmtblq70f+yR2RtAS45zoGa1Gfjx5eole6s3qJ1p9PkEKfKLyGd9/W4ybNioMw
         WFesvOytjrgOehPPMZV1puJ3+udOKDiWecumf5KnyJDuFN3ZOYHzb4q7W9AhI1dp+nD5
         cgSbwT6UPRlzfk1SxgwLdcD4YM+EohMi8nztBxCEkQBkXLCX7fjt2Di6OJD6/nOpnbFr
         4y3A==
X-Gm-Message-State: AOJu0Yy9kjNWZfwWTC2SQ4XSSyQkE83G56yaWDQvjuGtvfskwddrOuW6
	MljsM4OT8tO9u3JqnX9Gbxs=
X-Google-Smtp-Source: AGHT+IH9ptqXjFPejQbCYueIiAnfKYXceow6pCN+ZMj1pCKT56mcPWtkz4iqg1zF4Q4C/0TQzqKLIQ==
X-Received: by 2002:a17:903:22ce:b0:1d3:c21b:db5a with SMTP id y14-20020a17090322ce00b001d3c21bdb5amr2571379plg.34.1704612429836;
        Sat, 06 Jan 2024 23:27:09 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001d09c5424d4sm3978380plf.297.2024.01.06.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 23:27:08 -0800 (PST)
Date: Sun, 7 Jan 2024 16:27:07 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_bjorande@quicinc.com,
	fancer.lancer@gmail.com, vidyas@nvidia.com
Subject: Re: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240107072707.GC3450972@rocinante>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>

Hello,

> This series is the continuation of previous work by Vidya Sagar [1] to fix the
> issues related to accessing DBI register space before completing the core
> initialization in some EP platforms like Tegra194/234 and Qcom SM8450.

Applied to controller/dwc-ep, thank you!

[01/02] PCI: designware-ep: Fix DBI access before core init
        https://git.kernel.org/pci/pci/c/d3d13b00a2cf
[02/02] PCI: designware-ep: Move pci_epc_init_notify() inside dw_pcie_ep_init_complete()
        https://git.kernel.org/pci/pci/c/a171e1d60dad

	Krzysztof

