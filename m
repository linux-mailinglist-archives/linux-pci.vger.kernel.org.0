Return-Path: <linux-pci+bounces-15834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752D9B9FCB
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2482829A3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98818A6DB;
	Sat,  2 Nov 2024 11:51:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DEC189F5E;
	Sat,  2 Nov 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548282; cv=none; b=PUFMhxAdmwvIjMub54HdyCgLfmpf7WR3IC/mhPpd7Z1BXLOHid67OMdiifQI/bGbDwH9esmgbFFJvq5COp6B3pRgQ2KQkpmRrjDFqfg3SFnWtdiBXY/V1PaoyEa730ntEgM2WeXnn+Egl5QoVcevTYM6iy00DESGmujxg41gcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548282; c=relaxed/simple;
	bh=oiz+jF+Tex7OFlfZ+O46xPdUNRyGWopqfVvizAuUWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7dNrdilRf1HM1GP+QMejxVXAenq3OTrNH4c30JPhelFHRCgc2l2PAi7LG+0eQXzsXLf2LonmZAJ5ruN0NgCgshqr30DCzNVPU1IC5PgM/JpUNvgrDVjl5Gg+q3jc7Ac81LZkCXVzsQrwYeTo7PBTUKY8UFnxwknqLn1lBffDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c77459558so24468665ad.0;
        Sat, 02 Nov 2024 04:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548279; x=1731153079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SumbS2GlLN6Ge4KobuqZ4Ta6vn1tA8zUMD7vy4+oyGA=;
        b=aQe3bn6ybimMC54+wdt6zFGizFj63IC/lx3HJQIPaiM9EP/+pW3ToL29KbHlwsYpzN
         8gRDfMTNWX1qVqqMsUMxInbeQqvwZ3w2g51fQ/FuIHnCBPtqp+vglODBvh70snjvdhuj
         gOq6LVOnLEp7qRdLp2/svg2H5zg8+jgE/eLtaUKJ2Rc0zUa3+eK/4z7lTSO8ymjV/tid
         nTj6JiaduPRzqhF+FvaXQrubzcmRGIOhy60MNgE+ZCef2jLoe8QPQ9OMhJ9r0s4H0Vgz
         C2ib2JdxKTQ52aNrbEi3J9n39FlMJuIZ1v9hE3L7q5KZLInUi3lgulja3oQsJLZGWgQN
         KTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxDcf02bAdL01NPBokO0+SJs6lM9DQ6SuZNBPOBjiuLTH3/Ct07OvTm8nkQmVJ/2LkGcMgUJ+ZBN74@vger.kernel.org, AJvYcCUxRRyF6Bu3CeVUADwd9hmxOJgwG6x/Jfk4kbJibn4IuUKVElylFVszbuqurw0fa/u3Qjb1vnzwGsfHwtxM@vger.kernel.org
X-Gm-Message-State: AOJu0YzKV1oerjm+30BeIGHTTI+jtXu8YR8qwpeAm97wQcjPAbhtr/K/
	55B4qb7gh2h9S76oWd81Tbyi8r+6KT7MjlbqFy5FVOoQpAuYBYex
X-Google-Smtp-Source: AGHT+IH6jVuGSDDb5B4lDu4bF7D71MjlMGLUoBzzLb13+ySFPYr3w6Q7+xKM1bHXJ8Sh4Ihl+rI/UQ==
X-Received: by 2002:a17:902:e741:b0:20c:cf39:fe2d with SMTP id d9443c01a7336-210f74f48e4mr184327185ad.5.1730548279202;
        Sat, 02 Nov 2024 04:51:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2723sm32849345ad.178.2024.11.02.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:51:18 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:51:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/2] PCI: microchip: support using either instance 1
 or 2
Message-ID: <20241102115117.GD2260768@rocinante>
References: <20240814-setback-rumbling-c6393c8f1a91@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-setback-rumbling-c6393c8f1a91@spud>

Hello,

> The current driver and binding for PolarFire SoC's PCI controller assume
> that the root port instance in use is instance 1. The second reg
> property constitutes the region encompassing both "control" and "bridge"
> registers for both instances. In the driver, a fixed offset is applied to
> find the base addresses for instance 1's "control" and "bridge"
> registers. The BeagleV Fire uses root port instance 2, so something must
> be done so that software can differentiate. This series splits the
> second reg property in two, with dedicated "control" and "bridge"
> entries so that either instance can be used.

Applied to controller/microchip, thank you!

[01/02] PCI: dt-bindings: PCI: microchip,pcie-host: Fix reg properties
        https://git.kernel.org/pci/pci/c/ae5ebdb405dd
[02/02] PCI: microchip: Rework reg region handing to support using either instance 1 or 2
        https://git.kernel.org/pci/pci/c/e071e6bd9940

	Krzysztof

