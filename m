Return-Path: <linux-pci+bounces-12756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8196C116
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB39B2679E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3231D88C3;
	Wed,  4 Sep 2024 14:46:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625A22071;
	Wed,  4 Sep 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461168; cv=none; b=MRhTtje2uIgc9EkfmxgzfuVqIbMcgTucPxz2DzQDs/TN67D11mW8uz88s0osbuc4502tHAmU9vof+/Wz6sIrefRgS0hVyjouYW8USfO5wgzb+9N1gassm4rBCXxGGQ+SatYlUm5nVpNhimVrbDSAS3zq98c3uvvk7go4c/MY36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461168; c=relaxed/simple;
	bh=tZ4zoQ7+fGa7qXkuJICtHotCFwlzcQ2J7vhk5NZh5kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oudnW9p9dXpYR80FB63wZIn272unmvm+Jrglw1+b62JEPNlB8ZN8if+m6iiMnygJIYLzK8VLvSjLMKcpvy4tKeEwFRzCE3JOglCEe49Qwxf6vP3pLpeEgEgYCIU73YHlUQWEn5N4CkKtQzcqpiuZXC8Ji+SOghCsAuU5bvK8N48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so2876117a91.1;
        Wed, 04 Sep 2024 07:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461167; x=1726065967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/gRRuRqrbg0AurY1sJ7Xea56DowsKJuBt1BAJTfT7E=;
        b=deqGhfwTJd35sR6Kip+WJoS18k3Jhkz7+ND3nVrtw5w3GY/nNDGg40xfAgi5zMhotQ
         HIyxWz218VYgLom6a5pdp4u3GKPx0lkBiZCqP3ZXv8lHJ6tHqkvS4wvYdIGYREjNF9Jk
         ehYzq76tvoHsnFPdCfKvyS22XtmOTy1ZOvZmlgeyd1olc5itkVYjSvYRYtH54On2X4zt
         4lq7siF3q5+9KCkITGK5xk4gDmH8Tv1c0Iqq/8IfXkPKUiDComikzc0zhihuvSVfK4sZ
         J+um3S2W3ZAu2Z7N9bxcObVslcJ9mMhofWDs94xGf7G1F3Ri33kwH2VT1s1Z1pem+fKM
         zCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4MdQ0zOfxfzDqebjxhmimi1VMiiF62XjrOaXcJLbJRlQoV+1nDHb4XUxiSNN5hZIX1ydXmf4f/1YFyafG@vger.kernel.org, AJvYcCWMiEK1qoiEgWgdkktbFpi7LeW8DY7+7o6zpgulwtii4KxP/VvXgWD+v2cUSKchSp0AoSfxck9e+Ueo@vger.kernel.org, AJvYcCXwHe62eBZqjyjD0QgWjeVKYhDN8Q54MoxRxm9DzbTCKv6cjVbJozSAYtsfCnnPj7EssPwKYMpsIMSI@vger.kernel.org
X-Gm-Message-State: AOJu0YwX726Wa6iy/qLH0T4rNDP22KTGwt8LmQr6FlN+uvfIaj14OMlU
	1v9d+gAwvcIjaLgyNxkSDp73HCNXqXe1XVyhzkwqu9510W+HlgZy
X-Google-Smtp-Source: AGHT+IEFMGUmWkfIoTMckkMOZIt5S/YmaX0JZJtpZBVyk/WvpQWvlu8kAsbTAAvWVLa6jsYzlr7VSA==
X-Received: by 2002:a17:90b:4a48:b0:2c9:9643:98f4 with SMTP id 98e67ed59e1d1-2da55924209mr7514672a91.5.1725461166596;
        Wed, 04 Sep 2024 07:46:06 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462afb6sm16048198a91.33.2024.09.04.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:46:06 -0700 (PDT)
Date: Wed, 4 Sep 2024 23:46:04 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/3] dt-bindings: PCI: layerscape-pci: Replace
 fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
Message-ID: <20240904144604.GB3032973@rocinante>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-1-106340d538d6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-2160r2-v1-1-106340d538d6@nxp.com>

Hello,

> fsl,lx2160a-pcie compatible is used for mobivel according to
> Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> 
> fsl,layerscape-pcie.yaml is used for designware PCIe controller binding. So
> change it to fsl,lx2160ar2-pcie and allow fall back to fsl,ls2088a-pcie.
> 
> Sort compatible string.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: layerscape-pci: Replace fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
      https://git.kernel.org/pci/pci/c/1a1bf58897d2

	Krzysztof

