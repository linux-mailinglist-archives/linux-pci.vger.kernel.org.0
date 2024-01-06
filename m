Return-Path: <linux-pci+bounces-1730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F48825EDD
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 09:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79831C23493
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E7A35;
	Sat,  6 Jan 2024 08:33:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B85232;
	Sat,  6 Jan 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ea5cc137so2632835ad.0;
        Sat, 06 Jan 2024 00:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704530023; x=1705134823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WdZMaRyb9l3cpGwmVVFD+ef5l6020XuhebzUvV0uiM=;
        b=I5mpGdUvCwGQHIyukb6upfCS+kSsAVgFpNKheJUlHv4kQ3rYej82UjNopa7aqhBN7Y
         FyUpebBK8kHYplJ9wAcBuf2so9z3YvI4m0KOhIbfLG3equia+bluAVsmGrkZjNdn1VQn
         6gW1icU7K0VBJhKuPrT9Y7xND7jRVbdSOEIkpxaFa7e2/dIyWvgHIc3y4w3Bm6sLSHt+
         RFMV7wutrBC7cvNeVrn/pSCwI6CuA0hyzMhha+FpDobTo/UONo5tNyJa+Vx4V186O1wq
         XyA7cOCRmtNHn/+3z7yCqM8kkg6n957JpdLJnV1UQXqj6Jl8UMRFgHyt46aspWPCCZSu
         80aA==
X-Gm-Message-State: AOJu0Ywjpc6TMEpVLVpCyS6C67n0F62kK648+7PILm72ESGfJ6GZuwuc
	f0BqfajxpX2ik/4UzNA29UQ=
X-Google-Smtp-Source: AGHT+IHRI+FePQoxx3cIvDHA+4PIgr5FZVc7yGq5Mc63jusSY3KtXjPle/20AcCVjOB45xBXm9x4Kw==
X-Received: by 2002:a17:902:7c06:b0:1d4:1f0d:6785 with SMTP id x6-20020a1709027c0600b001d41f0d6785mr727351pll.20.1704530022841;
        Sat, 06 Jan 2024 00:33:42 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902b68900b001cfc3f73920sm2086626pls.227.2024.01.06.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 00:33:42 -0800 (PST)
Date: Sat, 6 Jan 2024 17:33:40 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	mani@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] PCI: controllers: tidy code up
Message-ID: <20240106083340.GD1227754@rocinante>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>

Hello,

> This patch series tidies the code of PCIe dwc controllers and some
> controllers up.

Applied to controller/dwc, thank you!

[01/06] PCI: dwc: Drop host prefix from struct dw_pcie_host_ops members
        https://git.kernel.org/pci/pci/c/aea370b2aec9
[02/06] PCI: dwc: Rename .ep_init to .init in struct dw_pcie_ep_ops
        https://git.kernel.org/pci/pci/c/756dcb5a820a
[03/06] PCI: dwc: Rename .func_conf_select to .get_dbi_offset in struct dw_pcie_ep_ops
        https://git.kernel.org/pci/pci/c/641f79beeebc
[04/06] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
        https://git.kernel.org/pci/pci/c/70fa02ca1446
[05/06] PCI: iproc: Fix -Wvoid-pointer-to-enum-cast warning
        https://git.kernel.org/pci/pci/c/f72896721621
[06/06] PCI: rcar-gen4: Fix -Wvoid-pointer-to-enum-cast error
        https://git.kernel.org/pci/pci/c/7682f19c3c8c

	Krzysztof

