Return-Path: <linux-pci+bounces-12878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D496EAD7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21A41F2551D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433D3B1A2;
	Fri,  6 Sep 2024 06:42:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307905B216;
	Fri,  6 Sep 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604938; cv=none; b=gj2FgklomAklS9WhfwDT8Ip7WvKoFjtxBHbvHlLSW2dTEOTh0MVPZuM1L5xi9Zo82LIantE7tjZ3HnJQKKgcNjpXC26TKlWClX6ihLuyK70uFUBuZoKXSv+vqp2/aznJezLgdKKb7fBB3rBd/VD1ETwghEwzvahxj7D5myhaunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604938; c=relaxed/simple;
	bh=+IJEH69gOISTWlvg3zPU/w1epIilrKjZbaz5D7bgZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwqrIQ7nZlV/aR8CnClwrmbmqGDaqm+cUoxiHGYZ+BkSEdWSFgK84w2W4+0ipXKoiOt/u6dHN3GQHk9xixJtrEeC/K6mc/2dXxVk4x29mP5GrlD3dVTRIkDlDMMZpS6GzDRcC1NOlAJX5CJcMXzq0XoLsc+2fWPbnnCOze7tB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551e2f1f8so16641915ad.2;
        Thu, 05 Sep 2024 23:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725604936; x=1726209736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLCwuYJ2jIQ7AX7cjzt4YWvFkOdwbanLmpVnFzyu7nI=;
        b=iOuvb3u5uoZeoVJnvbYH85lisH/zznONCQ9fW+OVEwvag4FnxXz1jZJcCvI38Xslje
         Wf/BSJovNJegajtBiHnQxciMbUo5b2GwrlWUENAzTRSxEzvqosVAIOWvjzho+qg7ePFR
         bq48jLqpqjsUw7rPmPJxmzTPwhBiff/h8lA5amy/n+wj8xYu0i4pdZesu2K0kWSHwuEW
         Fg7Tvykuu0B2Xsft6dBdN0DEnsaakumPsUvoa2NjkW55Q0L0NGyhiXMebwJ7lIfGYb6y
         wPSoZR+I77kStyoPy50wE0J30WI8wU3sHV/PD+AH1DcK+2CtvsM39KMAfF5JQGaWif5k
         XGgg==
X-Forwarded-Encrypted: i=1; AJvYcCU1MGODuQNET0SwBrhlqO/MdYSgYl22kktdKhJQooL6bAgA9JT5audQoSTEl4akypzg386zDOIxu2MObrk=@vger.kernel.org, AJvYcCXBR5/cfoeJ3ZxoM10tcQv2coFjbOHdx4KUi3uV71Gd2bE2TWdpvZa85fc09SxmhmE+2BXmpiTWkugp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZaHzMvFIZoRnOYL0Yda0Tplh8jSZ6tJoFQvB1IHvuXxi2z9Y
	b8fBfESO6Z90i7Fd1+aQ+eQwoiQY/jKnfH9cwoW68BTm1Q2MBDOD
X-Google-Smtp-Source: AGHT+IFhcKxn4gucXi1dxpFusTJmODNkq5R1NnJNsOzTXcINwffJplrx2JVql7aUmLFMrAtY4UvA/g==
X-Received: by 2002:a17:903:2409:b0:206:a162:e1bd with SMTP id d9443c01a7336-206f05361e6mr20283585ad.34.1725604936445;
        Thu, 05 Sep 2024 23:42:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea38389sm37333465ad.137.2024.09.05.23.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:42:16 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:42:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI: kirin: Fix buffer overflow
Message-ID: <20240906064214.GC679795@rocinante>
References: <20240903115823.30647-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903115823.30647-1-adiupina@astralinux.ru>

Hello,

By the way, this would be v2, technically, but not to worry.

> In kirin_pcie_parse_port() pcie->num_slots is compared to
> pcie->gpio_id_reset size (MAX_PCI_SLOTS). Need to fix
> condition to pcie->num_slots + 1 >= MAX_PCI_SLOTS and move
> pcie->num_slots increment lower to avoid out-of-bounds
> array access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Applied to controller/kirin, thank you!

[1/1] PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()
      https://git.kernel.org/pci/pci/c/c500a86693a1

	Krzysztof

