Return-Path: <linux-pci+bounces-12687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D096A69B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 20:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C508B216C2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83072192587;
	Tue,  3 Sep 2024 18:32:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A02192582;
	Tue,  3 Sep 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388335; cv=none; b=s2A724UnrtTPtEFFluSXbDoBoXP/MycVfr541UfGlVSi/LS8I4K4gQ6bY9rKaQQ0Ls9fv08s7XaBvtb0J36BFruYQwBNicg4AlFC7vCIh3q3V93mrHVKPuzBLUvO9xoVgnV0BxtHzy8ouaAnMSegQ+bAGShCb7LTHUSfsBz3M4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388335; c=relaxed/simple;
	bh=Y1fRnzB290jA91OvNqAJhDBKnrTAgbR42jL7Xd9rRvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuyWQROzF/kc2wqUTlDTu1FVMI3gZ5NFUvgmecCymBQW6RXCsvu5PrFX5SH3XpU2cejOsynrkP5JbMrmmT5X5T3wRqazQX/VFGmELRhsqpH0eUPuUjGtle7ucUtZJCJyR0pfc0EIP0E0UaFdgMw6OM0rO+q6X0cgZ2sdNxcNG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4077082b3a.1;
        Tue, 03 Sep 2024 11:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725388333; x=1725993133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dda/AAk1MExKHoXad6EwhYDQNLYDjU0OVlZdSY5EX0=;
        b=adgh3xlwGiO+RMYxzcqLUV+JlEqD7XC4h7qiWy7qDP6zbCa0CZYQRqW22W2KJjm2Yg
         KiSUQfYObpJ78hO7RZSMXhWBbA2hwdjBviG5xoQulzx2nr57QD5kjQZzlGWfFZG8xF2T
         Z1eQJv4SiXd22wHzv5GXahdiJwjeg125znY6/WxFnTEqqKIoWjbwyhhyK5Rt8p++RaI1
         8cGQ+a3FkFoRILayKLTxD+jK/CO4WR9pJcpyYNrFVk/ChjTBFrBtlooYwwBsriGjx3JA
         fpfGLLBdVmArFZPmWepHlGCwfz4xijFlNnOp6ofGYtqfXSAsxr7rWvpkNuBnmosw6GOA
         KK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN0cdpi60C0L2/NwIFN7padDhZp2rXX49y0gI5SeOfUBcQmk1mImW/HZTGk/9IxLKY/dKte9wdn7epZQ==@vger.kernel.org, AJvYcCVtKnU1pRnbuSZ+zsuIceI+GI+ilbAb/bRXtFOEyiQ8Q/As43zmffax2MD3kCBqSIBHdG0fabhauE+Q@vger.kernel.org, AJvYcCWw2KVHxLM7Y5I/yGRlbZMxCTFFIl5rpGYersO7qRgvUtligfuy80nzQNEuJ0nhnwfL3lz9DP1+g4lUJ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9z7GPpBxh90Awml/XyzUA55e0Bo8UY08Xtep6c3ig8/JS8Rt
	1kPzRsi5I+9Edvs10yQR2QEW6cF0xeUIEvgsHGeWn8zU3yGwuyM6
X-Google-Smtp-Source: AGHT+IGjyCoRatHCREo1h+pUKVDNv6QamtDZwsbofr5tMz5hVf7mO7IBuO9bchZxv9lQTZz8bYEQHw==
X-Received: by 2002:a05:6a21:6b0a:b0:1ce:d1b0:bc5e with SMTP id adf61e73a8af0-1ced1b0bcb6mr13918729637.27.1725388333108;
        Tue, 03 Sep 2024 11:32:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177852108esm187751b3a.33.2024.09.03.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:32:12 -0700 (PDT)
Date: Wed, 4 Sep 2024 03:32:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v7 0/7] Add suspend to ram support for PCIe on J7200
Message-ID: <20240903183211.GB3272142@rocinante>
References: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
 <78be1cb2-a6c6-44e3-8974-06731dd055f2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78be1cb2-a6c6-44e3-8974-06731dd055f2@bootlin.com>

Hello,

> This series has no remaining comment to address.

No, nothing.  Everything looks good.

> Is there any chance to get this series merged ?

Yes.  Apologies for the delay.

Bjorn, should be able to pull it for 6.12, hopefully.

	Krzysztof

