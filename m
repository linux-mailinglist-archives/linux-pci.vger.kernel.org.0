Return-Path: <linux-pci+bounces-11654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06316950DC2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 22:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA611C224DE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F21A3BB5;
	Tue, 13 Aug 2024 20:23:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50130187F;
	Tue, 13 Aug 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580619; cv=none; b=aN/M82DrHaqxcYy1LKZlULf5IPSlYcrsQwXZALPKPr0YZ1kcFTo9BNEePqT0QZJrxT/sy2MTOyg9ErnzhukNMEiTSEbetuy1ugdNnGjPGRSI6LskxKS+33Gmp0el0Nak6gwbIMnckyb32XKBkgEQYPsg8ZZ2ut4ao6vRkNhjzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580619; c=relaxed/simple;
	bh=6Kr99bcD/9fwEH78w5OwOXth9UkwtIYTLCOGAJGNaz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5eAX7OR95n6YG9ac4Zc4P0Rz9JouBbI8HtamZmy19Cz73crVLd3+U5T2xtkD0qNpKbQcurJZxj/1ALfjr1gqSWbMjrWLWSqYyawRyV2PHhhfxsIjzKq4EkWhUlwOYV0miRrmHQtfZqJroifE1oRVj1zS+h/XoR3ABiW3Dgk8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso4576413a91.1;
        Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580617; x=1724185417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcG0SYjGqu0jrqrGfWM9lUBKkd6m5DKkBO69qAVQmg4=;
        b=dGXT0piendMy4ojcDbtUgkLKXjj4vXHq0YFvApigCLcmz6Jx+HQvO5n9OTZXLgsCVA
         VnEuvdImTH5h13eXvzkNPfqEwddins4FAIrql6cv/SBy/zIBeuD166RJVeRbOBzpgkIn
         LP3klQwYCCT+jLzk9LIiLqeZ5VxRs0R9TWi1tcO6PSF0l/0BIYPUv22O44q+8jMNf0RJ
         wVGXifHn1pMA6wRB4xwMX59dbzdO06amXdWmk44RnlRjJrkfY5R2yVnr+NVZzBiun0n/
         1JukHMb40x8rEio7c795zqne4uNzYp/7BVuA3HxUvxDcmoIo5aNFYN7YpFaxR87HhKi4
         BnSA==
X-Forwarded-Encrypted: i=1; AJvYcCUwIh9kyG9XgsoqE0kx/xNBTF/VbO2aQbg+gPbSfmM/aThy5mGi7YAY+fa9BvfcyQKflp8aSVjlbx0bW3pSsMMVrNIS7oFGxJ12Wi4qEP4rZlJqiBso+5Ebx2ELD8GRc+H8OTAtaFpmJjOqKry6Zr/0hKNEc3K/29C4RnngzXrF5YsrksL56bvY
X-Gm-Message-State: AOJu0YyW2OWhyx6g2d8tX6z5bkdYo8jQv7fDKx5/hIcf0SxjUGsBjVSQ
	0h4U69FN5Hl6lf5fdfFhQEj2vksjhRzbnFbylz+Wjb/xOUXg8JuA
X-Google-Smtp-Source: AGHT+IGBw4yD8ZcwfBTXb9FJZKFfdmYVvXwf5k78HRUiS9nNsoReNinDW9lCwwpnio/ryM2p310WgQ==
X-Received: by 2002:a17:90a:6501:b0:2c9:63e9:845b with SMTP id 98e67ed59e1d1-2d3aaae4e4cmr705594a91.9.1723580617395;
        Tue, 13 Aug 2024 13:23:37 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcf102b4sm7855609a91.28.2024.08.13.13.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:23:36 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:23:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix && vs || typo
Message-ID: <20240813202334.GA1922056@rocinante>
References: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>

Hello,

> This code accidentally uses && where || was intended.  It potentially
> results in a NULL dereference.

Applied to controller/keystone, thank you!

[1/1] PCI: keystone: Fix if-statement expression in ks_pcie_quirk()
      https://git.kernel.org/pci/pci/c/6188a1c762eb

	Krzysztof

