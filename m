Return-Path: <linux-pci+bounces-9121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225A99134E5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59051F21E74
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF5D16FF3D;
	Sat, 22 Jun 2024 15:43:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD416F286;
	Sat, 22 Jun 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719071008; cv=none; b=fIKDQ705Fa8iYy2EoGXA8im+gJflZzzBgPMSGaHDiJ8R5jbsTLb60LFxSN+GoMfE75RWyE8DxY4d0UDU/wTWOL5dJh2ossJ0j8akaoIUAGVOb2KanMtHZD8UWAuN47vAkOKAiXHtXKzsyr4oGxCkMxNZ1CxCWz3Wi30DjmvT1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719071008; c=relaxed/simple;
	bh=gLJ5+cVco3zzhNfu9rHyY18hslSCLkFf6EhGm/tluww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFEZRaYG+eNbxYFwftvJLdKMhTMuNk2aXg+CfUXKqKrRcH/kI5YhZRq9Ci/zQ3ewTQgfZ5p5ovxU5o/ity/LDgiNrcaDWOd3VArCKu2NspA8cs2nuB89t9Gz07wxbKKPfpdVXUP34b9ilv/PiRUlDsvFCPCviTClNYnKluy7x8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b45d6abso23764785ad.0;
        Sat, 22 Jun 2024 08:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719071006; x=1719675806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tr32xZGVVaqv7jAiwzmOcZLqHSUA0J9mSCiEtEoaTQ=;
        b=R3buFEBwZr993BZk3xcwFGD0Has0UJSdbd16WRmkVObkTeFlzaznhx191vjW+p3Auq
         NPWhV1z+RaLmGOKeJsYGgMkT93GzmRjkJp3cIBDrpgQquyLakQca40smsS+IXiShU4eE
         ci+YXJ0bknYoiPKfW8/6PPsBla+12l2LFuHdTn7gjGu2e6qcMWMbv+Sj13tslF35S/Ga
         /s/afYFU/Ne4xHB3Kvj6lgUU/MpeecPQUUuL7AXaZzruHghEgQ9O4vR6ZA4L6CaxYNZn
         PN8UQP7JR80tejgTaj/9wUkmM5p8BolqrqwgMpN+gUpPlk8xrZzlKuaapobujqbgNhOu
         fjaw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7BJ3eYT+1wI8iWtRzwtmfxZo2ZoxZpoMxzCxC0UbXMUtlt8eOFfU4r6WrrI0LUR4plraEb3FHny2gBRApw+Xd47S779HKYdlzgTwaqzdu7mMWYdbVnarqGMtSGxmEnneb4s7KA==
X-Gm-Message-State: AOJu0YwTR3MxjyVB9PHb2GSjNa9I8nnr1t1eKYZJLB0HGZVzjbHzCfOq
	s8XxcCz/PX4bJCya6RViJEWXE9rVNKogJFeJ3K80RBmgiP1Wha4Y
X-Google-Smtp-Source: AGHT+IGUXVafMgf2JONHoy51XKuI3VfKD5p9JBYhQqxen0O92HROgW6FcusfSXMkgP0V9Vf4JstoWw==
X-Received: by 2002:a17:903:18d:b0:1fa:2001:d8ff with SMTP id d9443c01a7336-1fa2001dad7mr6104195ad.52.1719071006450;
        Sat, 22 Jun 2024 08:43:26 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3206a1sm32466645ad.77.2024.06.22.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 08:43:25 -0700 (PDT)
Date: Sun, 23 Jun 2024 00:43:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <20240622154324.GA391376@rocinante>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
 <Zm_tGknJe5Ttj9mC@ryzen.lan>
 <20240621193937.GB3008482@rocinante>
 <ZnbUHI5GEMCmaK2V@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnbUHI5GEMCmaK2V@ryzen.lan>

Hello,

[...]
> Could you possibly include the commit:
> 3d2e425263e2 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event")
> from the controller/dwc branch in the controller/rockchip as well,
> or rebase the controller/rockchip branch on top of the controller/dwc branch,
> or merge the controller/dwc branch to the controller/rockchip branch?
> 

Done.

> Additionally, since you picked up Mani's series which removes
> dw_pcie_ep_init_notify() on the controller/dwc branch:
> 9eba2f70362f ("PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper")
> 
> You will need to pick up this patch as well:
> https://lore.kernel.org/linux-pci/20240622132024.2927799-2-cassel@kernel.org/T/#u
> Otherwise there will be a build error when merging the controller/dwc
> and the controller/rockchip branch to for-next.
> The patch that I sent out can be picked up to the controller/rockchip right
> now (since the API that Mani is switching to already exists in Linus's tree).

Done.

Hopefully, this settles things for a bit.

> May I ask why all the branches for the different DWC glue drivers are not
> based on the controller/dwc branch?

No worries.

> They are obviously going to be tightly related.

Normally, we prefer to apply things to specific topic branches, but I will
revisit this approach going forward, since changes between Endpoint, DWC
and specific controller drivers are often tightly coupled, as you noted,
which can make things a bit of a mess, unnecessarily.

We are going to do some clean up once Bjorn sends his Pull Request.

	Krzysztof

