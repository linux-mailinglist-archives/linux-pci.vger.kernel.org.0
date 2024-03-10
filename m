Return-Path: <linux-pci+bounces-4709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4788777F2
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 19:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F88B1F212CE
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058643984A;
	Sun, 10 Mar 2024 18:15:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6D39AF3
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094534; cv=none; b=SxNwxKdFokdG4ere6Zu9/vPx5swNfC+VDgdLMg1HT0Qbo90yhR8diXPyGZ0mObXFw9yewBwcbN4lAE5oBabxDhl2lQZQHD/KYTvpo992CAi26WnBmwiRBKJENt7K0ffclsHeJKLTG+0DEpDiKM5kz1+AehgkcIjLrcA5bRrNPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094534; c=relaxed/simple;
	bh=mYjpvPHGhTG65gVlKkFR6jq6Mb/q8fTPvWzIuge9X8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUjlM2T8I3cWb/Jv2uc+IrpSxKwIQn+HS6iINoUQ5Uivu9Aw/AL0o9IaEbpTnpS+HznGqv/JoTyuB1WIET/V6pfu0g/a7bu6AGKSdonJ01bfUdOA0464usEOwzwnWCNKT34dYgK9kSZ0LsPiJkOd9B19rSKdtRvCGw4Xo5pLt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3221354a12.1
        for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 11:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710094533; x=1710699333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWNwc/aIACwDqSo/TYviNerLniVASRCR2UoKGHn+Oz4=;
        b=MJidheYP/0S5zblntWtsmqjfxxVozTCsrN0gqOrgZZcG/TxCBGeI9CODSxxVDO3t+6
         p3U5kvu/ffzM8r1IH9QpYGzKY+WpiWiNdP8PKL59btSwgO15SiHZcp+b2TpXMAnQ0v9G
         F4quWVZ4UlCoIQdjsfJQgcOtIV7xRDfyOv12WvMBERKnYa5OhmxTbW06KqNw/04hubVh
         BFTQlicRIqfCLJtbBXMeonQq74xEXQziOLajHX07xShX+S9fPYqpaYvbWSmllxbkykX+
         +oBoNXTJD79WGIimCdKioL+qcJK/Oe5zUtxxuFu5APZ5gA/ctFMJpE7m2T2D6tl9q0gr
         6xpg==
X-Forwarded-Encrypted: i=1; AJvYcCWWK+xyYBfHqZ/7oSSSS4lG9jfmD+WwuuppfNo6YNc46wXyfi78Rk1q9z4mKrnz5ppygKSplEHr/6+c6C68dvRiUdfBotoxxdNt
X-Gm-Message-State: AOJu0Yw3YrsoHm1DqGuSTQhISaRE9oAv+YVN6cV8nMQO+khovHfL3Wsw
	CgqRv2+7kGUoct50ahFQPTO4mP2fRrWbVhwvs3UMNp/XE3BJ4U18
X-Google-Smtp-Source: AGHT+IFV77bhafD6I0cV5/EN3kyB1EetphCwlyvNsOs/elQM5gJX7tgjaCMKZSCEZ6WgraLoXw4Rbg==
X-Received: by 2002:a05:6a20:54a8:b0:1a3:1577:a7f7 with SMTP id i40-20020a056a2054a800b001a31577a7f7mr1587227pzk.10.1710094532630;
        Sun, 10 Mar 2024 11:15:32 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090ac48400b0029bc1b21c9asm2694925pjt.9.2024.03.10.11.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:15:32 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:15:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <20240310181530.GC2765217@rocinante>
References: <20240221153840.1789979-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221153840.1789979-1-ajayagarwal@google.com>

Hello,

> There can be platforms that do not use/have 32-bit DMA addresses.
> The current implementation of 32-bit IOVA allocation can fail for
> such platforms, eventually leading to the probe failure.
> 
> Try to allocate a 32-bit msi_data. If this allocation fails,
> attempt a 64-bit address allocation. Please note that if the
> 64-bit MSI address is allocated, then the EPs supporting 32-bit
> MSI address only will not work.

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: Strengthen the MSI address allocation logic
      https://git.kernel.org/pci/pci/c/f3a296405b6e

	Krzysztof

