Return-Path: <linux-pci+bounces-9120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D699134B2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418A62836CA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067F8156227;
	Sat, 22 Jun 2024 15:14:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B163155CBD
	for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069245; cv=none; b=AfsQgvb23K+ZCxkF75kLb5xNSAJLMkrE4LFIL84DIg0Ai1CcPFYpkKdK/tJKcLLn4TaEGYo4AUWVHilHRrDA5tMPUsO16jBFvdDafddeTiyX1O155KCGzMc5bBWqnxeifYRWSZo47e3SBXT3JnvU5siZynMLRnXWrnNmftAf4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069245; c=relaxed/simple;
	bh=QP2QaIiubuLdtB8zOEB1ff0HFJNpaUp3S0JWJd/jPYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bigfNE/tzlajB1muVcuYeeK3AdErTRDbBEL1nIfTVxJAz7qZbnwoUU7P0Za4ei9/CbQozIUTItBjxyDmyhrA4o9r7BDecNNsGckyH3ZCoITCSy52q6P3fCvPpdD0N6+OUlJtdAjhaKlRZqNZ6BeTB3nquezmvWeGi3pZI0eokj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-71884eda768so677449a12.1
        for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2024 08:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719069244; x=1719674044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO5PuN4wq5B0n05Wpt0WfrhR94xtZbfNGgCNETz0nH4=;
        b=tsAf7xzkmHpc5Pgf4zDIckMBGyNNG2oko2FeMjNOnuqSRSu+Gal4rA5u/CsKeOXOdL
         S6RmO5lKawHWVYos+SDE07E0nuOlKL5Ra3U15Z7NBE0KpkGY9tEXkVIO89vK3GIk2YYX
         rRNTvBbjebLTUQlkMwssqIvMMlyT02GfBwoy1UR1i+njIxjpqOEG7RsDHRPSeLdvSRX4
         ornJR1cHDTS07zrQ2YIqR/dLL2umSED0bHnXVKbptT3lVcNFfykXlfeo5M62z2t9+UmH
         HARUOkS3cCKTk+ZlNqHORQuwS1vnS5L0XpdbmelaOvHaixw/V761WcD5lFAHp2SMbJIj
         b6lw==
X-Forwarded-Encrypted: i=1; AJvYcCUXTmwxvgNiD/VZO8VL8ZKkYbcqw0vL+m+47Oj5vzQk+QKqoOntQLbUFAdOkCAQpmkBSe9qFZMl220hAn+5gi0rgyV/hkzIMRg2
X-Gm-Message-State: AOJu0YwJEqHcj5ehtTIChAWKPL1V2iaBKaC2Og+VzwAPP9FkW3uy+BHw
	gj6KSVDltWW4rS5wUsfktHL8XmdxSvshUlP8pqUeTqWaVXnnu1Zy
X-Google-Smtp-Source: AGHT+IFzdBoJnBk9O8C8z68+YR6Xs1YwPWH28vkjGb0smIvJxb8fWhIPUnkx/43Kk+KYpyLDmtFJvA==
X-Received: by 2002:a05:6a20:2da0:b0:1b6:e885:1bc8 with SMTP id adf61e73a8af0-1bcf7eb5403mr71392637.28.1719069243633;
        Sat, 22 Jun 2024 08:14:03 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065129633esm3197736b3a.153.2024.06.22.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 08:14:03 -0700 (PDT)
Date: Sun, 23 Jun 2024 00:14:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Use pci_epc_init_notify() directly
Message-ID: <20240622151401.GA379697@rocinante>
References: <20240622132024.2927799-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622132024.2927799-2-cassel@kernel.org>

Hello,

> Commit 9eba2f70362f ("PCI: dwc: ep: Remove dw_pcie_ep_init_notify()
> wrapper") removed the dw_pcie_ep_init_notify() wrapper, and changed
> the DWC glue drivers to instead use pci_epc_init_notify() directly.
> 
> The endpoint support for the dw-rockchip had not been merged at that
> point in time, so commit 9eba2f70362f ("PCI: dwc: ep: Remove
> dw_pcie_ep_init_notify() wrapper") did not update dw-rockchip.
> 
> Do the same change for dw-rockchip, so that the driver will not try
> to use a function that has now been removed.

Applied to controller/rockchip, thank you!

[1/1] PCI: dw-rockchip: Use pci_epc_init_notify() directly
      https://git.kernel.org/pci/pci/c/246afbe0f6fc

	Krzysztof

