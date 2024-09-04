Return-Path: <linux-pci+bounces-12758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2696C1AE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D86D1F2A71C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E21DC1B1;
	Wed,  4 Sep 2024 15:03:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506761DA608;
	Wed,  4 Sep 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462222; cv=none; b=scPgffH53yZHElvIacTzv/pB+MjdpJ2zYau+bKe7Toz3mwYatF08VDvEyVWke1u37CGDB7UbR/61p0o3Xhy6aozsGkPmDEBKuwemjeq1skAeNIWQgQ8JldiVYfswtrn4qOp7bXFn/86KAurAYyaaDWuDY9kI6JwaZoTpN3aGfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462222; c=relaxed/simple;
	bh=oAtw8QLJTfDJtAImTRmUn59QUaqixqWWWJkpAI+DRXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyOuVNQmP3MYTZkhpJE/YyBFYHAeXXvNVKrNh1+Rz0zKJEdP22UaC1xQ3b9E/+NlYf7zGQE5s/CgmREQ844tJD99/AH4JB5t6HRix4sEKpp5fEwE+rtFCHOMDv6h0aBFB3gTHMrbtWGx5k9eSWewGbT23LMdRin4V+mw5XohtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1215290a12.2;
        Wed, 04 Sep 2024 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462221; x=1726067021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOC7waCCkQoMQkhqz0PBH9fJGvLRMTZyncgnFWYy3E0=;
        b=IOpwmYhsP7BkOU8JwhAVZDmdvr7XICnXXPxOsrkRGN0heZh9kFbqBEJlmwOs7zaT3Y
         q4sVQk5/XF157+DMrjR841Zvv+KL9bHXvL4XUXVOwcL4dlXT9b3ejmM+0ewWEvyhwiQD
         LFUkv/J8fsdEQZsBVuJjPm0GeY8HxVREOnQlD1tviGqhna/7U0h93uLnDIgOVhirb144
         15CWb/u00VhT9wM+vTmmXmKPQh9EDJmtQKIzPclIXbQ5Wq+VXqeRlZdxOFDiTQmQ5cKL
         gVm3wqfTj2+fKfV/FJQh4ymXAsrqQavvDZD2am8nLCdaXKnXieFfqIvEpSeC3BM05g7O
         llEA==
X-Forwarded-Encrypted: i=1; AJvYcCUEhlXWjuIL2ayDC4Ot6JXXyd9vhQJYpMv3OwRUHDies6GqvAmfZd/4rwpc6d4q6OI4AtkXUcsFDKGd@vger.kernel.org, AJvYcCVqqEMCRlhJt219RfpddcAFHKN7vI1kuBGVArxFKgdjsaIwiKKZUjzyFJNHXgGfn+s4MLekdZuaA+d1@vger.kernel.org, AJvYcCXmhxnzd4qgtineSk9fyIAOlcAYmvV2wrtQzLQpxJnkfBtcpEQXkxGbHi9dSdpmRM7y0K2YwgEFl9Od+mXg@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmfUgM10ZECj4lttJ0GTtg8uBP44p/P/S86AoDFp/o0D1YQ+x
	/4V62qSlzzlKtJpQXMvMUBtFjf13ku6XwydJIXQWKWoKauWVyJYU
X-Google-Smtp-Source: AGHT+IHyKUc0x9KM8r7gfcsXlK+gsn4eBpyS8muEMq8I3FrEpz0HjjpC7yuRyiiRAMxAoDlUNTSa1g==
X-Received: by 2002:a05:6a21:4603:b0:1cc:e500:5f30 with SMTP id adf61e73a8af0-1cece517cd4mr15437085637.24.1725462220519;
        Wed, 04 Sep 2024 08:03:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8cccfsm1774651a12.22.2024.09.04.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:03:40 -0700 (PDT)
Date: Thu, 5 Sep 2024 00:03:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: PCI: layerscape-pci: Fix property
 'fsl,pcie-scfg' type
Message-ID: <20240904150338.GD3032973@rocinante>
References: <20240701221612.2112668-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701221612.2112668-1-Frank.Li@nxp.com>

Hello,

> fsl,pcie-scfg actually need an argument when there are more than one PCIe
> instances. Change it to phandle-array and use items to describe each field
> means.
> 
> Fix below warning.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: layerscape-pci: Change property 'fsl,pcie-scfg' type
      https://git.kernel.org/pci/pci/c/f66b63ef10d6

	Krzysztof

