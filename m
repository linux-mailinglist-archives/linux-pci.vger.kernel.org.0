Return-Path: <linux-pci+bounces-15837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD89B9FE1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7891F1C20BBF
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAF18593A;
	Sat,  2 Nov 2024 12:04:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44E16EBE8;
	Sat,  2 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730549047; cv=none; b=AC2B6JR50p9L+x/JhuCdVQDb4DnUKxnECgxxZAtZBcvzW4zBnMl/IjJxxjdI+CvLZmQlS5VMKILnTS0kN91eJHLZgYI/ygMTiCEsBgxqbHxnGpn60fRWiqZHM/wHxwXYDIPMkiZUg1QqMnxL/ju0HqHWAVAR3eJ7OHM/i5ntX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730549047; c=relaxed/simple;
	bh=EQ8XAxpuqUA8Ez0JQdFpsCuHCg9R67pnEbTFpmmFa9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7QNYPThuX6QzxnIovaPHt1gOrSXFfySrb/09bBL8ZslKkzujRJ6oGYV+CqbUrNcF8uTFX8KzftVyDrvKF6rvkkwsA54Pc1DGLkDxzw+NCX3QsCn7GYhioZ1hyupkQi6m0hE1zP8u/ymVchOZO4n/BK6LRJoHUcWVCHoZzNYLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e681bc315so1970159b3a.0;
        Sat, 02 Nov 2024 05:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730549046; x=1731153846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF6tF/ronwtGaLPzR1Y+1eJC2THWzh90BDnwiyxyUlA=;
        b=siqfQhg8PHhkVCGQNLVxua0fmrx7sP3+YpNVEHNNgZ27JllBDbw8GpLli1oElf65B4
         mJD3SmFfGE26Fsbn90gWDAg5Ql/I4NtB+hyTQAS1Mu0NJo/UGU72GUynwO7Tz055suRX
         JZKGwlTcoX8ksrV0t8B+dc2j1KpmHaJl/XSauE1iNHD8VCTXrNzCgN/neQh1uZKeKRsB
         jCM7FnW4GqDLtaxdrWm7eBWqID6t0YSbNYsy5Mjz4H3h5uxUWl6wYhXXyBUBkp9FfIR8
         7epuH3iNnhuC6+EKr6RVgA0V1YrlO9iscf0o1WXG0zRrn13c4x0pKjA1B7iIN6T7GgRi
         /Dyw==
X-Forwarded-Encrypted: i=1; AJvYcCUE79H8t5g8XEsLPFEgY1jXnYmO8e0jyp/rg7QU09zueDdYlHr2+sHLQkcf7YrgZwQEx5h2mHz8yOW2@vger.kernel.org, AJvYcCVAD23BpBnLJTd9vQ0eMPymIXIPJAO5/QH/fkG4e8xRt8JuBlGn5HoebxzezxZULkPdFqe38APtto/DwlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xFvVz7jFr69NFfVyJ2mH6am7ZSv6YbmVSNLh7bRmGzTtahBk
	T6cmGfiaHboTofmKXkF79xW69h2TrcW616TxSWcpvfmiOrM5tyB3
X-Google-Smtp-Source: AGHT+IH3QBupALD0Xsyr4GM4EVgvwE8anNNXOVnVeSjs243gIoBttfPnD+0+H2RFRYw7KFhojBYygw==
X-Received: by 2002:a05:6a00:6386:b0:71e:427e:e679 with SMTP id d2e1a72fcca58-720c965da56mr8996435b3a.4.1730549045701;
        Sat, 02 Nov 2024 05:04:05 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ef741sm4062238b3a.82.2024.11.02.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:04:05 -0700 (PDT)
Date: Sat, 2 Nov 2024 21:04:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241102120403.GF2260768@rocinante>
References: <20241030103250.83640-1-eichest@gmail.com>
 <20241101193412.GA1317741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101193412.GA1317741@bhelgaas>

Hello,

[...]
> > Without this patch, suspend/resume will fail on i.MX6QDL devices if a
> > PCIe device is connected. Upon resuming, the kernel will hang and
> > display an error. Here's an example of the error encountered with the
> > ath10k driver:
> > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> [...]
> 
> Richard and Lucas, does this look OK to you?  Since you're listed as
> maintainers of pci-imx6.c, I'd like to have your ack before merging
> this.

If things look fine here, then I would like to pick it up.

	Krzysztof

