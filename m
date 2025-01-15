Return-Path: <linux-pci+bounces-19874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB23A1227F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B8416107A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180B248BA4;
	Wed, 15 Jan 2025 11:24:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C403248BC0
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940254; cv=none; b=Z7PSQy37iRBO+WPPGbzu0GtJH0UKoF965xU0cyjCi8g7/71sSzKegjU5nLzfp3c2PQ8uqXXgnokPWSdntjb6KVEXEqXJlpuSNMABR9yW0TSRYNYXBHzGJQct6Os0brXLV7F+rLkyXEGbIn+TNKDRSgcMEtRz/EBYobgd8VBBqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940254; c=relaxed/simple;
	bh=0gOmXL+ki/LVatk/+EH+nTYGwBWvbUoIZ7s7QeoaOkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0mYwiZDPKWJfSDBVxE6Z6SlRHmcftHWyC9rM4skEEI27waoEgcMwE8zPbwM48B9KfmDs0Czj+L7Cz0Vob/VAWIfCi9b8gQx6NX8wJJTgcZMJ2Ohy/0lDuCKCX0bfk2Bs3yW6Oe2LLAhoaJpuAXdd4AgMdqDmPd1dUJjFCqfLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21644aca3a0so144595055ad.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 03:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940252; x=1737545052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUVdm3mO8wyAEtqYf29LfYrhde2R1+PvVitYrjINl+8=;
        b=vMKTvvrmiazhB4+ttej2vAfoHgnlezteFpB8UU+bIBvHA9S5QacRFj/FkEtvlKXBHo
         14UidHO3/tjPrOiyHSkPyH8CodcfZCuJF8QDk/rErAuGQLndAXJwwzaLLai0HZtFSfNw
         O49Rud9AzUT88hQMe6loTutSpCV3qvEh/+jesYM8RpIEexRZgMm50TOTd/sQt44jEPFk
         TqWPh3gM/rRmDqOkYNMHeHn9DZOdNSJlTk+Pg6o5W4K5P84pg+KXKFmON7vVlMn+6/hb
         EUQ2jezausrDLGEbQDMvahqT1o0VEnX/pIsrPYpQ+PIxJdu6EpGJhd998QQk4d+vFAs/
         L13w==
X-Forwarded-Encrypted: i=1; AJvYcCXSspgKOJOKwjlph1+Pm9dwFln9aEGKFeG2TjgVsOSOWgoix1enuP3SOZDrelI3CF6BuNLcQFrwLyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+8zZvQp0jW+KziLXa42/lvkTIXU0RXFZdfOQr6h6EsvYGwCN
	Qv1C4RU6I+K03Ay4GcR0rPLLsIYcfOYfSL61leXMdm17DZHTLRHd
X-Gm-Gg: ASbGncswb1caJNwA7Kcqe18kT2+pjGb4d9YAibVPdvWe4EcajLgysqoJGBR+vNDjsK1
	Zd5xSjAx0193e/x7Z3aRfIfBSaFLXc1+julFgxx2xtgbDihlEVproJRE1koduu8yiRVe5iwKNvh
	xHyt5mZvU/SDMXQfUo1PsR66yegC4RPBXbqpxBqBRy/ZypJ3hRRtMUzIY9Ms0NmaeD1M8SwehS4
	qTDY/egxcv94LyBOywj9W7aIyJ+cCJklSjIV2qrqTjLoqU43nB6e1FGAElYz+DcVp6HTbrzKCId
	t9rpq90uqIjEJq4=
X-Google-Smtp-Source: AGHT+IG3kkyhYmKGbY6VuxsN/+Z98bSz6aAVdHu22iLgd+DL47pY/YmtSTlOChAckZWWlOSzVyBwqg==
X-Received: by 2002:a17:902:cec3:b0:211:ce91:63ea with SMTP id d9443c01a7336-21a83f56f9emr443236845ad.15.1736940252363;
        Wed, 15 Jan 2025 03:24:12 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d134sm80215975ad.187.2025.01.15.03.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:24:11 -0800 (PST)
Date: Wed, 15 Jan 2025 20:24:10 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Fix potential truncation in
 dw_pcie_edma_irq_verify()
Message-ID: <20250115112410.GH4176564@rocinante>
References: <20250104002119.2681246-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250104002119.2681246-2-cassel@kernel.org>

Hello,

> Increase the size of the string buffer to avoid potential truncation in
> dw_pcie_edma_irq_verify().
> 
> This fixes the following build warning when compiling with W=1:
> 
> drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
>   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
>       |                                                  ^~

Applied to controller/dwc for v6.14, thank you!

	Krzysztof

