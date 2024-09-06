Return-Path: <linux-pci+bounces-12876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5BD96EABC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFDE1C20E89
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAEC13D899;
	Fri,  6 Sep 2024 06:31:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2657F48C;
	Fri,  6 Sep 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604274; cv=none; b=J335gI10qkiRTzgiqgAOTGTHyczJ25P5gneYZjGo/zsH/vygohUCDg2WVD6AVKYPDjx6f/fhFAshJZjUDunkDdScenfqlBVncdkjpoa98LJjf4d3kVDRLFqxqfqm4Db9UrupIYRxhPq6B3GCKqAfhGuibv/tIPK59TynKEpZOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604274; c=relaxed/simple;
	bh=EAEXrS3ujlWSIv1zD3lw1caH9nctH2DdMNjEoPs+GTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF6sFWNCZcSvjblfA4ehezy/hGxMS+mHGus3+FRsqt+iPwtgzH/f4GGDvnQVYGYQBmZhj2I7/kwB7XkHKdbXhpF6nBTdSjv3ViwDG+uvSwfTg4cQ6yTXlPYnXwwC1auUGx3VjaAm37FIibgkgh3OldAZ6Fe/64DX5LLSVDukwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20543fdb7acso13376795ad.1;
        Thu, 05 Sep 2024 23:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725604273; x=1726209073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUlqUwaLIWNbsVjRhWvuXLWwMr5ykeNKJnP9nNXvjaA=;
        b=SgLCkXjJoCyIHcjM43+r9hS2BG0LXN/l9qbzhsJOv/Zc/yioKJK3c3g4YThUn8axyZ
         4XkKW3TUG94LRsA5DsGG6UJRfhDT23OewxxFLpA+gnhyqLF18uzjg5Wwb4R2drl+H7fh
         uhbcoGngpuFv/fdcte4JXRO/Tn10hWw6wDlUyXXXSn6ltSdExOINw3dM4zznH1cNQ2mS
         f2lorTrZap0YikxTs6U3Jwnse9iGl+5r0OUCgzRTvVkBtOdwJnWWeEg6K+QH/srB04po
         R1/3k7MnO65/8mai4j+IgCO8NevFesoptJEEWbAh+Imk6iie/ilOj887W90E8e09hviA
         jafA==
X-Forwarded-Encrypted: i=1; AJvYcCV/3cXs9l1K3alqqyLtxODE0PuiCnf5ovWKRj4p1Xh5ZnGOqeORt27lkwY0hJwPf6n2LNfw7Kihwr17@vger.kernel.org, AJvYcCV/BKizBEJ90qcjOGNdg8tiM1+kxew/w3wlWBms42v1LmvXDb7AUQ9VbZ1JJ+eijjUVbvtlR8antdNtOPgM@vger.kernel.org, AJvYcCVR1Bvq92MitTEIL6NFhyVhSGy/JHRJ60gUiTbkjcbNk7LXzw6uc9pxqzQ+lN9vbCWq0dc7XFFU5KCk@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHo/zRecQDXsEox8Pl0Nk69xGjUz1l5CnTDJGagg489m/dCfx
	NHsI4PXjSDWSvjWHKnJ0ai6Rs5DHtmnWYBsv2vNT5EngOk9m1VUt26wCrLk/Af0=
X-Google-Smtp-Source: AGHT+IFDFoOk1bH5c4RXh8ffMzQ0h3Mv865nSfiJ+AC1ztLE71RolJQdzxnMQJba93jTnE+ady0DAw==
X-Received: by 2002:a17:902:e80e:b0:206:d6ac:854f with SMTP id d9443c01a7336-206f049d45amr15829625ad.3.1725604272744;
        Thu, 05 Sep 2024 23:31:12 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea38c31sm37371035ad.151.2024.09.05.23.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:31:12 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:31:10 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <20240906063110.GA679795@rocinante>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>

Hello,

> Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> 
> For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
> driver. This method is not good.
> 
> In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
> Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
> preparation to do that for i.MX8M PCIe EP.
> 
> These changes wouldn't break driver function. When "dbi2" and "atu"
> properties are present, i.MX PCIe driver would fetch the according base
> addresses from DT directly. If only two reg properties are provided, i.MX
> PCIe driver would fall back to the old method.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint
      https://git.kernel.org/pci/pci/c/2f309c988b7c

	Krzysztof

