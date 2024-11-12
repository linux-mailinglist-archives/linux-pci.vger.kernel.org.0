Return-Path: <linux-pci+bounces-16509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9729C4F85
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4089E2833F0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7C20ADD7;
	Tue, 12 Nov 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXfoUJwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB820B20B
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396966; cv=none; b=aAqPRy4W/hoaSZvE246RAfbyJmZLZ7VG6PT+XMpMUxQp+QjoqaBaCa003LptMPxy5mWYXJySUHpZIqMwAxxKQOGpOcws03q276LP/kTCfXfewA14fQBZBTvYfclnCtwLy58mUHwnmbGbUeFB1Ql+SZUQMwcLXvlNWH7dgDer61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396966; c=relaxed/simple;
	bh=cQLQVxsI2PezBMH0R9KgG1QekZtyZGbTki7LvdK5sLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4DGxjjzZ/GRGH4qzJvJ6mfkM+qGhzRaTJQF749ce3p2XOb/lWKRMhGptQcGs++deJHKe6PSd+p7wI8nrXjU5BqOI8YsykpvZpDB0pKD1xMM4kP551OvhK/U/+L7ivxZ+jnDJn/NhJRW9XNAk0BUXGghw/t63MUo5mx9qmPMs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FXfoUJwq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so3894070a12.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 23:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731396962; x=1732001762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wz2Xll3k6PrE80Ti+u6oUdCAXTR3EqoFjFkrEaeKDLQ=;
        b=FXfoUJwqi3Wb3lM4jjfLXkaTavmdF6TXBIYUeYBihtH6kLkF7AtvvaBGwo5VabDgHw
         i/cPt3ejFKg+fsWFfQ17nQU2NxH600CBmr/0JIF+vC4NwI3pk6AskqfxZCMZe7sZMhbU
         n7CsUAZYUzZrHImCgcNiXWr7yqzC5XRGK+DA5EWnOgNC/MY/niSzWMcyF0GK/Rj/hgX8
         LQ6FeXnGG7PINhhH39aTTQKJY45xc8xJsqVMrUUFYmAWu5adWmir03INm8wO/Z2eLA4X
         Jhq9SYA2TC8J2h+KL895TgBgCI3K9Ecq6vve6E+6Qh6gC9n2OKO8NbR+PAWbXHn0lfsu
         uqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731396962; x=1732001762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz2Xll3k6PrE80Ti+u6oUdCAXTR3EqoFjFkrEaeKDLQ=;
        b=imNWZ1U3oO3X0Jt9VQw0egZHNZNihNA8DKlNoZVqLHRetP+KYEz0Jzc14vwzsdEq+s
         F70DJ4kLZrIPwIOWrZ2CdBuoIG3x9xYT4j8E2IrJoPwDGkFAl02rLBRKREGr01LH7D8o
         38yN7O6k2hf9BYwSDwrtEs+EN0D5Gaf9eFFjSt+p6BwD6qHwzCaZWmWgq8CvHRPbmOv9
         bwXFZw2PLhtNHE11o+MMK8ptbTylps1afcN6w7TmySBnzM64dQ6udCtibhDLRGSnM1Cy
         LR954J0VnhIomxf1oT43NTgg4HI5cnOWlZZF6RGQJRVpyS6/8oOZLlZ8nOzCn8J/9Faz
         SmJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgAEJ2BliM8TjpEqySp91IPQZmjXjc10EtWErQszhQRSWwWbAnqMqGPc56IcpXiCv/kVGEL44qGr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rAszIvWuQrv27KeIvqms+/TlzoVI2DnwPe7e7MpTcPddzruk
	B0Ja9KmNt2+r+4+pVaF9G8w+FikJFX7raSjECeQ/kok05TmZOMQp8oAZFBvNSA==
X-Google-Smtp-Source: AGHT+IFxOmOq64lXg5Fe+uFtEajww8dyWjj1b2gl9w/hnQ4Zgtjj8DdggtCcycfHVqp6iQQC9ZemGA==
X-Received: by 2002:a05:6a20:7f92:b0:1db:92be:1276 with SMTP id adf61e73a8af0-1dc228ebf86mr22461366637.6.1731396962481;
        Mon, 11 Nov 2024 23:36:02 -0800 (PST)
Received: from thinkpad ([117.213.103.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078641a2sm10757715b3a.20.2024.11.11.23.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:36:01 -0800 (PST)
Date: Tue, 12 Nov 2024 13:05:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: endpoint: fix bugs for both API
 pci_epc_destroy() and pci_epc_remove_epf()
Message-ID: <20241112073552.kbzx557ebdbqe5ax@thinkpad>
References: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>

On Thu, Nov 07, 2024 at 08:53:07AM +0800, Zijun Hu wrote:
> This patch series is to fix bugs for below 2 APIs:
> pci_epc_destroy()
> pci_epc_remove_epf()
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Applied to pci/endpoint!

- Mani

> ---
> Changes in v2:
> - Correct title and commit messages, and remove RFC tag
> - Link to v1: https://lore.kernel.org/r/20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com
> 
> ---
> Zijun Hu (2):
>       PCI: endpoint: Fix API pci_epc_destroy() releasing domain_nr ID faults
>       PCI: endpoint: Fix API pci_epc_remove_epf() cleaning up wrong EPC of EPF
> 
>  drivers/pci/endpoint/pci-epc-core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> ---
> base-commit: ad5df4a631fa7eeb8eb212d21ab3f6979fd1926e
> change-id: 20241102-epc_rfc-e1d9d03d5101
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

