Return-Path: <linux-pci+bounces-31322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99CEAF6660
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 01:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58694E0EF2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E9247298;
	Wed,  2 Jul 2025 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e6rk9EdS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80279242D64
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499893; cv=none; b=lf/eq3NIdezAoY+6uAk/lZRL1gMyS9QHV0CdQi+HA7AvMi/UH2k8xNe/nudSGSBAw9skdJkISmeXdJKF/uUSu+dt6YKxuRvllzKlyNND40uWZD8T3ZicnsftEESdkPRnHDcgnFC4PjNBjv9JAyHFekSWWas90dy0iEUcu3e4RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499893; c=relaxed/simple;
	bh=a2SRtuVRS/HLPzU8Ge04SiDKs+8BwbnIB5UtLtui59k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+XqS2EHp/wQNoVTdZyB0eGw0sFgk4PlPlQIWUHHUHcslBiiQX6ZvZe1bIG/eGbHcz9jiRWJdNDbW3QHTpWNamZ62xNipZ/MlI405RG1tNYo7zTv2UT/3Ek6YhOGAts3xIbU0GVuvXOzf/Tam8TGvyeTC8IslyDtCZ3YkWa4hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e6rk9EdS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so46553745ad.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751499891; x=1752104691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vanWsN1emZdC7WvHI8auaA9LR0vVsRUHovcfBS3pZr0=;
        b=e6rk9EdSxkELCPhrMpzn7NTEwUzVBAUlSA1V9fVkDoJgUPYEfFA6EC+UQSpyMbewrp
         atDcunlI1vYIv/Tx/cVrRFkHzy5iX5bBb3nIoYOyPzAkVPRJcyCm3u34qBfoWYl+hOHt
         TxxXwc6GgLYpeChSI72Dsz39GBy/S2Ihk/xak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751499891; x=1752104691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vanWsN1emZdC7WvHI8auaA9LR0vVsRUHovcfBS3pZr0=;
        b=mVyMwmL5p24Kx+8myDnmcJ5HopWhSaupFIxJaRRBtxsCGBTSAr1GbGq7/qKrpjXXlh
         A3+94nDpTxSFcN7v3phdNrDRL5Z+XX+HYLY7+AMChDWjGVfWtbo3nVhMZGfaKQueNN4c
         lk5TymMid64VzVtVsDvYZmdQvsBDNLHpM+hdOodww/r+StiQItSFtyYrpW/DDfUZD5zr
         KgAvCscL4XbMcI754r0dA9ZcvCdcGv10nrZJscWHlL4EyHNYPabinLsD2nX+MyTNMzqv
         W9dtU2kLOe+G4oiRXwzLWKPe2iHPVrPTWtVn863MAMloYenZt3vRJ0EaDRIHj4WSNJbg
         9VKg==
X-Forwarded-Encrypted: i=1; AJvYcCVmSZ2LXUnVcjZUEF1gkX/ksc2MZ5+3a9alWSRrc/hLLEtQnldWGkreLAGoCJznEwt9Dzt1BW/FNYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF785KRdySV/ZSYRUC4qU47FezK0nhOKt/xWVv+I0YetDeJmMs
	vDVguCstNw+UyvTkseT2qnIbY8+ymIFx7/TV0Ef+2aPPTQWQX/8rFySmPSK2iUOC8A==
X-Gm-Gg: ASbGncudBWWb77CUqsYOLDM09Uo2FRhVW56k83cjwLWhcAfIYq+fy2iZ+q39lkwrPww
	58iyBm17LHkGUS5eGb/iDvhcpvNLEy56qp7CUIKtMIpTHwzFES2Tz3VWn5ZgfAP7xaaH3fgXqSw
	ep3bjquY9XWtNHQOXzyFOSEHlKHOvtTqz1nHUuAfVk9yTNyvOI6rJg/sVBMKzXXI+qtT2BrIvWi
	LMnU/PG4chpzHE5Em4bSauONYZTHUZg5u/06NkUMt8fOYNogPGfrePlmHoaPG3MoCzaPP2rC/df
	fR+FFR1g7ynOPDmt1D3LBwEulz7OjRM1dCKSu4XvAqx7KS6sX3JcjoSJWhEQdO+wrywLeQC3RE4
	SasecO+ZRlNu7dnysQX9yS+4=
X-Google-Smtp-Source: AGHT+IHAbh7yfBcGE4yDekozSUVOzD8QebMbZWphEoS8ksZ7G3iEiRoD5zJ4t1CNF4QF5162Eg9V3Q==
X-Received: by 2002:a17:903:8c6:b0:236:6f43:7047 with SMTP id d9443c01a7336-23c6e4d316bmr63201095ad.9.1751499890733;
        Wed, 02 Jul 2025 16:44:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a88f:fae1:55b0:d25])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f3541sm146949875ad.88.2025.07.02.16.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 16:44:49 -0700 (PDT)
Date: Wed, 2 Jul 2025 16:44:48 -0700
From: Brian Norris <briannorris@chromium.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aGXEcHTfT2k2ayAj@google.com>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>

Hi Frank,

On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > Does the AER driver actually work on these platforms?
...
> There are several attempts to upstream customer Aer irq support in past years.
> 
> For example:
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1161848.html
> 
> some change port drivers.
> 
> If you think it is valuable to support customer AER IRQ support, I can restart
> this work.

Interesting thread. I read through it, but I'm still not convinced about
one detail:

Are you sure that AER can't possibly work over MSI? Even today, the
Synopsys manuals say that their integrated MSI receiver "terminate[s]
inbound MSI requests (received on the RX wire)" and after terminating,
"an interrupt is signaled locally through the msi_ctrl_int output."

That means that their msi_ctrl_int signal only handles MSI requests from
downstream functions, and it implies that the default
drivers/pci/controller/dwc/pcie-designware-host.c
dw_pcie_msi_domain_info implementation will not actually see MSIs from
the root port (such as PME and AER). So yes, it *appears* that AER does
not work over MSI.

But crucially, it does *not* mean that the port will not generate valid
MSI requests, if you have some kind of logic that will receive it. So
for instance, I pointed out in another reply that some SoCs choose to
hook up GIC ITS:

 commit 9c4cd0aef259 ("arm64: dts: qcom: x1e80100: enable GICv3 ITS for
 PCIe")

"""
    Note that using the GIC ITS on x1e80100 will cause Advanced Error
    Reporting (AER) interrupts to be received on errors unlike when using
    the internal MSI controller. Consequently, notifications about
    (correctable) errors may now be logged for errors that previously went
    unnoticed.
"""

And in fact, your arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi seems
to be doing the same. I'd be surprised if these port MSIs still don't
work after that.

OTOH, I do also believe there are SoCs where DWC PCIe is available, but
there is no external MSI controller, and so that same problem still may
exist. I may even have such SoCs available...

Brian

