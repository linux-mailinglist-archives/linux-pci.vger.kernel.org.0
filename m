Return-Path: <linux-pci+bounces-15895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A89BA833
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 22:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372691F21970
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B37189BB2;
	Sun,  3 Nov 2024 21:04:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCD155392;
	Sun,  3 Nov 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667855; cv=none; b=dGoQGr+TzTlIahZYUriAnzJn6Mhmn3+LE/axXE8GTB5HN91u3ZCnpX0g6f1JRs6YlVF9DjRR90T4kSeXz3+dM+twBDf+Vl5jAJpCtwD2LFeRMwFaEDs0SXSfH5Vp3gvt4TTI0vhE6krRKI/FZZdA2RGbi8P/IN6X1cit5kiRnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667855; c=relaxed/simple;
	bh=q6OOaED5zvRfnbaltrJMmwCUXdYdGlzn7Gzj+ZaEkNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0p8Ic9h08Uys+rYuEKYou3djqtmPLNfwK01RDqHxe0nTPV0lx1RiBdLJsq14fx9JXWWwtqDifuqLDDPruvaTO/+XzzYMxj56CaXIKBqMwGSPVvJvDTRkpsWhf0uvvYYehJv/7GuQApXetU/vf0lWUivOeBSDIv5g/xQSwDbdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdda5cfb6so34052435ad.3;
        Sun, 03 Nov 2024 13:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667852; x=1731272652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyk/tHp3wM7ZJ+kBBA3UsNzDpyC6CZHEFHkxEbaxlrA=;
        b=H9j1XcXSwtZ66Z3tLk9YtGscTM6+NG3100Yn09QKhZqhEkckPwDksp5GlIn+Pwa7JZ
         qIb7z0O5wFHz6oVaZHDfOFr2fMWzuwec2MZ2EBPjicVsdf7xzdTvD28Dlbjycu8XXrei
         /WNfDvmTEPwcMtlAv0z7IexXUCWkR3qxbk7uBh2T4A+Gxf/4qeuhORjYqdZ4X1W+dMsw
         XsBUG9R2c1BQkQM2WQf2uvmqBZj5717hM/rLX3Z2K4Dsim/uy+nJzGqwqhk6O9EL4kph
         eFXwX1jvH02lLeO2cTHD89mOQlBz3XaFSduRw97+BLZzCPqFjzSZcmP4xCAP1ojh3gu3
         9BhA==
X-Forwarded-Encrypted: i=1; AJvYcCW6+Y3nid3NA+vWeaM9yzn+Rlb9+nBp6ijaNiRGUD804zf3EWIifgdXsUNopTvtRshhj9zz8dPejjK2z2IC@vger.kernel.org, AJvYcCWHdr5br+Cmof3/m5s4lnWUat3QVkeuYLuyIGSt+B6xMAH0vwmFGCfq7X406ETRiMn7OR1iEJeqd1Ua@vger.kernel.org, AJvYcCWbMjucPk9/jIKIt7E3BeY+v4DDc/d8yQhEhTiE2VIwxwRzNaE5KjPpIWztM1176XgloRcVF/6zPLa2@vger.kernel.org, AJvYcCXgJ7oJyHFPqcVelUsoYhiYyMqHYpxJNfR2p2G85u1vRqOrfxcGsm9mprkztthnPNRrUFoGoFwlbPJDXKZqCg==@vger.kernel.org, AJvYcCXjN6eEbNNV/pByuOpUWICW56toFjJXe3iWv08ganLgSR0cDuEcIeMIuEc7NqVfW+EjB64xkY6+DEbT@vger.kernel.org
X-Gm-Message-State: AOJu0YywrAtUW37WkxmIhLV8x60x+W0mge50OfHkgrLl39z1UMzvk+qi
	VMEVdUq32OEmHNmz5Ai87UY2Xu+oIWT/NpXTdbpSaInl/9Aw82ZW
X-Google-Smtp-Source: AGHT+IEuBWJcoxFyodqaLltsAgGc1DHq3aBd4Exho6fhd7kC5UnQpnx06MfS33ABD5bBS6JPZdF+Yw==
X-Received: by 2002:a17:902:e850:b0:20b:6d8c:463 with SMTP id d9443c01a7336-21103b34f6dmr193025595ad.35.1730667852188;
        Sun, 03 Nov 2024 13:04:12 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2ec3sm49960975ad.140.2024.11.03.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:04:11 -0800 (PST)
Date: Mon, 4 Nov 2024 06:04:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v8 0/5] Add support for PCIe3 on x1e80100
Message-ID: <20241103210409.GK237624@rocinante>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101030902.579789-1-quic_qianyu@quicinc.com>

> This series add support for PCIe3 on x1e80100.
> 
> PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
> PHY configuration compare other PCIe instances on x1e80100. Hence add
> required resource configuration and usage for PCIe3.

Applied to controller/qcom, thank you!

[01/04] dt-bindings: PCI: qcom: Move OPP table to qcom,pcie-common.yaml
        https://git.kernel.org/pci/pci/c/39a06b55df6c

[02/04] dt-bindings: PCI: qcom,pcie-x1e80100: Add 'global' interrupt
        https://git.kernel.org/pci/pci/c/66dc205962c5

[03/04] PCI: qcom: Remove BDF2SID mapping config for SC8280X family SoC
        https://git.kernel.org/pci/pci/c/66cc06169fcf

[04/04] PCI: qcom: Disable ASPM L0s for X1E80100
        https://git.kernel.org/pci/pci/c/fc69fb202beb

	Krzysztof

