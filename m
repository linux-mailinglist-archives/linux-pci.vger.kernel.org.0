Return-Path: <linux-pci+bounces-30255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51607AE1B1A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB0D4A5FB4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEE28A407;
	Fri, 20 Jun 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C17PRCZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B130E83F;
	Fri, 20 Jun 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423417; cv=none; b=BoU0xcqDQl8brzGZkBy0WwQ7WAQWYd8pxmO7G58tT8YaWJ8m12OA7Gw0MbIrifh1vb6+TjVWtqB5uqbM6Bs1gYGXGH1dlqP7G/OwOkiTnDZnwkvOrsvNThkdET0AwXCeZsqwB3nd/gv7CUikJ9nfQPn7VucC5LSi7u0sgrudupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423417; c=relaxed/simple;
	bh=ZV/HsviR9SwuT4bc15nOADULgqo/tUyI7W9lExbr+ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWiMgB1InpN+BNemw4XI2AYCbvGPAOlySBmzHFPfmWQFqtK3mqhSBYnXKs0JItaJvEnNttU8lYz0gcko3FkmYh0z5JPTskq0/nFVUOf/EtQ1DgYmbbOL02I6zZb0WtAY4TrZETCAHWD8nfR59UenIup2mnPbbRRC6Vlh/J4Fwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C17PRCZ5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so16386205ad.1;
        Fri, 20 Jun 2025 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750423415; x=1751028215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oj7aDLhck8d5+ayvvwLkGQOKkyv7fiwIxcrymm6gaWY=;
        b=C17PRCZ5E49fYzVxz+LfS4JCvFMrVfdvzQ7+0yezJH40thYjNtGCx7L7C1Inr6kyj2
         wdNG88nX3dM+VFfFZpH98eq6LLLHHKzc27rYOJXbehofI5zdVjdJk5rVMkYaPpBNKbPz
         esYxCZeEHNKLW1v0fBRQqItQiCVmDInfPMcDlkABswtSRDckZFX7TBCoIe+yAm8Ku9H0
         sCD5nYQIfhzLM0jE3fVlSLLup3Ua4k2M8+oEZDDgLax33JJeclVkc1gUfUA2v+6IQw+4
         R25b/KbO+NRZHK+T3N9aGCnBU9A2WmuZWrs9QmBNtexuGTO573qjxaB5f/6M6WFwMuIY
         dpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750423415; x=1751028215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj7aDLhck8d5+ayvvwLkGQOKkyv7fiwIxcrymm6gaWY=;
        b=O0pOkO59ghaQXrdtmwRf+usYfww1VPLCp9ZMiFcvtIfWvy+PPHjM1r/k+80Pa9Fbet
         +2RWGMz91If0selgMJshGf6POb/G0PDkgDjrI6ZMsT7Wuad294zo+U+GvPtFesFW/lhe
         EtyUrkjLdO/PKW0Bzu5jgnoPwGvA8mcc/dnZkdGOvrv8ceMoHWsqllgJCcrtPmjpSPho
         Y5uZIJBy33md2rt4ODSC60MhyLxSCvXW6QmgE8FqUa5NncnbHCMx8lMwfmAyCHbGfMxg
         3peJI1DzH3xITqBbXTvZ/RM64DxgcXdvDbPlIigrOmifsF1nrqSm5FbbEOL/smsQzEqR
         HMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2jzEPB8qjUBCqjEFbeQZlAbWc4t7kZFwooP5cK9Yc/1c42KTxOygDqFBwbocH5WurbXoO9Nn/TIocwrY=@vger.kernel.org, AJvYcCWkxKFsy5LnhPRvgdzU0EkWA04L/1iH0Ga0CDlEHWDep6JXXSJ40WZaozHALA3dW8w35d8znUPA5X3h@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GhjBcKs2MwDO+fe/23X6c5+7ZVG2bGUR6uCkoQPhRKzK5bBk
	63qeSCvmHBMRw6DKjcjxc2omF5pINz4aL16M6MUbGyiTjUZm/wt8X2n6
X-Gm-Gg: ASbGncvSlG9mbCqelC3m7KVOcE761VQqLD+L/mul+/wGWSrSWHxNKzelLKtcmR5/TFg
	1oqplroEICr97G5JCmI8jh+kRoqYUuwI30/PMaWI+Eh/khP2Ker1l77QShpfLbCz65ccrADSHD4
	VoIS43LmL19KkXZ4Sim933TiimphMY/52BvxRZOf1dIshoF9RVDWkr20UbmDDhC+EpYkdfF9+nt
	ZarCNrmzQG8fLS69Tqiwo8ifbkULzVdoJv5vDa0MdFx4FSjhgxD9qZJ2NFsSqPdbF6FoOFfK7SV
	dy4j0A2PrmphtyxM4OwbNQt8QNit40O3v5aQXkIoqne7C2Fz6Q==
X-Google-Smtp-Source: AGHT+IEuD3H+HAfeXs9W/BR6wxzL9h2mEYrXblCAc4qefsZX7SSfF2y9fHbF07Keq6sv02/yWTML7w==
X-Received: by 2002:a17:903:3201:b0:229:1619:ab58 with SMTP id d9443c01a7336-237d99f4420mr46670075ad.43.1750423415114;
        Fri, 20 Jun 2025 05:43:35 -0700 (PDT)
Received: from geday ([2804:7f2:800b:cab9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8674544sm17204025ad.167.2025.06.20.05.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:43:34 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:43:28 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/4] PCI: rockchip: Set Target Link Speed before
 retraining
Message-ID: <aFVXcIGHC9aeSuAF@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <1966f8ddc4a81426b4f1f48c22bea9b4a6e6297c.1749833987.git.geraldogabriel@gmail.com>
 <562662d4-69ca-4d0e-ad0d-fd8cece417e0@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562662d4-69ca-4d0e-ad0d-fd8cece417e0@arm.com>

On Fri, Jun 20, 2025 at 01:33:11PM +0100, Robin Murphy wrote:
> On 2025-06-13 6:03 pm, Geraldo Nascimento wrote:
> > Current code may fail Gen2 retraining if Target Link Speed
> > is set to 2.5 GT/s in Link Control and Status Register 2.
> > Set it to 5.0 GT/s accordingly.
> 
> I have max-link-speed overridden to 2 in my local DTB, and indeed this 
> seems to make my NVMe report a 5.0 GT/s link where previously it was 
> still downgrading to 2.5, so:
> 
> Tested-by: Robin Murphy <robin.murphy@arm.com>
>

Hi Robin,

thanks for the testing, I'll include the tag in v6 once Bjorn gets back
to me on the 16-bit adjacent registers problem.

Geraldo Nascimento

