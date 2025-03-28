Return-Path: <linux-pci+bounces-24939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612ECA749BA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 13:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FB61796B9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9451537C6;
	Fri, 28 Mar 2025 12:21:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A151714C6
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164487; cv=none; b=GbgD+wScUPYLxkpR8HyBHLub1ZZ3M1+CBzv3FaVSQ2K5GqBndcIO3zNPHJnLM9h79keAOwd5gA6xRCk56A1bfyqSj3EoyBNY9qR97cBEN51uIGeCwWs0FN9k10/L+nj0ysdXHaPglA1NaL7mT4R47bpNHgtvKlbTuBFy0rxrXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164487; c=relaxed/simple;
	bh=onPZONaQSMs4AEMZGDMvbQ8S970SvlNZYm+bPpF35Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtUKUm2o/wr0J6oWOGOYL0kAB40eLaRPsBSm5QfKPkoDZf1eW5nsBinUy2TjkxSLYM9afSYoo3npHyGtumFm9tlrUxiL8oHuiNfUCqDNZCoP97n8a52Q4G+oTLxrMAzcMU3i9Zklw3KoWjfY45QaVREFxeN++JxtIhjexlaHTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225df540edcso62383125ad.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 05:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743164485; x=1743769285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/9N6IGO2b06XLqPK9RBGgEbBk8wQn9vBDguitaJu18=;
        b=T++G+4mamQwKZ/QbBaoGg1Ry0qK0Vj3rfb5ojIxDFvz1TrYV9nTxnarIg7hufV0v8e
         GBJSQ8g/xLE5xyG4nNQphLa3jdm4Z69FY7pcpr0H135N/efomCTNhW6PjW4lvUeU9Fd6
         hnyYSkgMQqYtLtnk3ct9DFR/E+H+Cr4zRX3rfhULmoMw95LU7nYooyNiMVp0wM1cQisd
         WS2/t6eho7DZ4EptZBSBSu667QmDkcwS4UmkOt5XiyE++VhOD/FqdIebDqnuIezEUg3O
         hFz5s5lU/WcOqLAGf6MpDyRPrTqTCaXv/AsnljHkhjx7nNjzERT5HqS8WzRBwpZRg6Dx
         aVLg==
X-Forwarded-Encrypted: i=1; AJvYcCUtb1OzGPtLlz/Jv4CP30mV6+5VvxsLFs5bTIGy/fPY0ACe0RwYfSouAzuuvptCAbhqonS6843PuYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwJuqUybTkWndvy7b3ntmWORhWpw4kQd9v/MJZTznrd60JHNH
	LSZdLJUhob+iQsTmHYUMT1SuN9/Pipi3QB3pzx+DcwPIcPOeNQjx1yDYRUL7
X-Gm-Gg: ASbGncuytI65dq+BUSMci8CG8+/uFXtcI0kLEHLDXQ1LRQMeMpEB+Htr2NQ60P4YV7N
	1GtWCsUyAdCCyuI/AQYoYFMqD3f9SKN7LTruPCLllbQOQnKXE+eNOoVj8Kg+xW4+pH9KIh0JG30
	hUPTdW5H8A48b9DjAG7dUAyFkaIuOczUYeXOz9s1PXT+t1iSgxuQjQ8UkLKKL+lXQCTmQs/1o5e
	OL6dBLO+3IWY/8nH33jPjBUchiZPRn2zu3FxSCnaIG7iCdW+ip/V26fyHhXaT0P2QIOoJ4FywTy
	+BGD+6RgJ5r58kCtiHDg6cISqzuUxThcki5Q8EQ1SFM3LxhBeux3bzIO3bWu+xdqU/OpTSXhbHg
	K/ak=
X-Google-Smtp-Source: AGHT+IEiqFnwgAfpimqiawKJtkxu/+UqZskGggMC1JBWEQJ69Smb/Nhm2zy+DwpXPUHdJzcDz3gJlg==
X-Received: by 2002:a05:6a20:9f03:b0:1fe:61a4:7210 with SMTP id adf61e73a8af0-1feb5b80d62mr4306855637.2.1743164485217;
        Fri, 28 Mar 2025 05:21:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93b52ea6bsm1271537a12.0.2025.03.28.05.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 05:21:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 21:21:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip-ep: Mark RK3399 as intx_capable
Message-ID: <20250328122123.GA1187318@rocinante>
References: <20250326200115.3804380-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326200115.3804380-2-cassel@kernel.org>

Hello,

> RK3399 can raise INTx interrupts, as can be seen by
> rockchip_pcie_ep_send_intx_irq().
> 
> This is also in line with the register description of
> PCIE_CLIENT_LEGACY_INT_CTRL, section "17.6.3 PCIe Client Detail Register
> Description" of the RK3399 TRM.
> 
> Thus, mark RK3399 as intx_capable.

Replaced the following commit:

  e55c67837a8c ("PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts")

With this one directly on the "endpoint-test" branch.  This is per the
conversation at:

  https://lore.kernel.org/linux-pci/20250318103330.1840678-6-cassel@kernel.org

Thank you!

	Krzysztof

