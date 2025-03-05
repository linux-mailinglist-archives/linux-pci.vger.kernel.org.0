Return-Path: <linux-pci+bounces-22954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB71A4F84A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DE918887CB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98601DA617;
	Wed,  5 Mar 2025 07:53:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EF17555;
	Wed,  5 Mar 2025 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161186; cv=none; b=mTWzXMtNYXANNa7FjnlMvq8TSYfYbZteojrRm1jG2mai+SLJJ4HNy3jQuMvIa+vYm8Y6NxrcPFlwCwI1BjhJ/NIahOe7b2o/oQPFueActPewQZfQuZWdVkKObX2etk6DdHe7YRSHOjgUfUnpzoEbg5CP2mqq0ESZ2bQ8CpsUoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161186; c=relaxed/simple;
	bh=Sq/v/OM/1qS45H4g0YlraJb50W42tf5JVWHwZD4MlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvOIqVtA9VK5BzKJnwOaO9LpgypWIGwat94q9xRdztFXXOGdoZnGBRZ+k8ZLgAYB3fyf4VeQX0ukNw/pQeJ0MH46u3vDlHvMar6sqSjnvaDWPk4TQifHecBx7VgfBxWIuqbeLopzajTxSZoWzYDL25JQPBbZkp0/t0VyGqtQlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2239aa5da08so57775275ad.3;
        Tue, 04 Mar 2025 23:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741161185; x=1741765985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUsr/iCnKd/GZUSiPP0qg3YZq8O3ABD8811wmqc6RIE=;
        b=KbVG2M9Rz+DMzGUsAtv5UvxiHokzg70Y+2JMuNOoP8ZUT9ZYbspFot/HtkQqdaMjVv
         5UwWQQSx/HiZFGLJknyXMRfJfZWhKDFe9BPpX9aUuqbbzsawnpQbNgQ+knMIsq5RtKLg
         uGOndaxoK5sjO+hIQrPEaPhxShGuNohpo2WC16DFn+DaTCiQI/Ez/2LVR8yK/zDm6aa3
         O3VB82TMTfkkYcRoq3rphjVJIHRETwXVQVcK0Plm2np0qq8eczVLoh2IZIZgyTfob77e
         ZyWbvHQviJrDqKaWeVF5dU7blZrzbbM2bU7Gus3RK2fagQ/wTE7pL+VK7eJU1OjJJQ6o
         eKWg==
X-Forwarded-Encrypted: i=1; AJvYcCUpnlwk7VPzNhZ5zwYBi2z51kQQ/QwMnCtOxaozNxBzeFNu5B0sXpTQBj1SdPg7T+/6sDjYASwLTfPx9ns=@vger.kernel.org, AJvYcCW0BKaQqVqJOs/j0VLuL3MoSP38tw89GweM9gyOwtsRHuD5R2LPf8LjLyA2FAHSHePAJhtLvYujBQQs@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVtiEIaALTITAcbydJRrbyE7Ze8OapcAii5W4R6npkUbUMFVk
	3ucEriv40tc1XVHKnvISU1+6XbEnpCAM5UQMKEOrdMtw7RL5CAc3
X-Gm-Gg: ASbGncvtjG47ToUQ/CARWyU8+IB+NqK0RjpEaxO0HzXok3eCC3/4sfEN3n5lvwLGkrI
	U/9tDSKSEbpPpQABQaISI5PAI687qPukhwAxn5Z6JfoSxbeV2Jg/Tdhv7mKXDIpiey+pVTRnDNv
	1bWorLXuZ+apGqbtpXH5wZbO97U5iJ8b0oGmctdFpqCPHG2R1MLUF5siOWa8FQfsfW6AgzxU8sR
	JXSuR4aAQcHpGK5b8bXW1drHMJGmaUgth2LmvKmEgsHCXEsYGVcx3MT+DBgylukvWShtLAlOzyV
	LHndRDie2zNmLzvtniiHoysSYmxueUpShjv3gqE4BKbWYpLzNlftuOyt29S1IKwWf64QCI6pHEj
	CaEc=
X-Google-Smtp-Source: AGHT+IGc/QGITU1VyyG2bR8BE8zXWKg2nLipJcMYsipV+Ey8nHltBSogWbamh50FAZrr7Q2bpkYmww==
X-Received: by 2002:a17:903:1987:b0:21f:85d0:828 with SMTP id d9443c01a7336-223f1d6cd19mr34190085ad.41.1741161184651;
        Tue, 04 Mar 2025 23:53:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fd276sm107054275ad.104.2025.03.04.23.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:53:04 -0800 (PST)
Date: Wed, 5 Mar 2025 16:53:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: fix inconsistent indenting warning
Message-ID: <20250305075302.GD847772@rocinante>
References: <20250305070022.4668-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305070022.4668-1-hanchunchao@inspur.com>

Hello,

> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/pci/controller/pcie-mediatek-gen3.c:922 mtk_pcie_parse_port() warn: inconsistent indenting

Applied to controller/mediatek, thank you!

	Krzysztof

