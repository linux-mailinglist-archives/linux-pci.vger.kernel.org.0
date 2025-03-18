Return-Path: <linux-pci+bounces-24017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEF3A66D4E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A735E164FEC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03591C84B1;
	Tue, 18 Mar 2025 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYeZngaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581421A08A8
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284993; cv=none; b=FU/PVUgYp27qUQtp8avYMGIyPshyLMLpvGktgHls9hWNhkpTxvFjiRGOujPZr50bLR8miPAHyzxV7C9TCd11bgemTjzvkh83eSpRNAKzXEqod7PMzX/+6+SMRWEM7pGffFEhnLXaYvrKAvkryGbXMYXXX3RKCwh4X9E/npIFvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284993; c=relaxed/simple;
	bh=oPq+d71Iufy56/UZaCHSTNp7Y6uM8EA9OXViFdwCyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu//rtUw68g1wcC7iduuwk4CdJbhE87cjV7PE+Gu2O1Ch2kqep/bb814/WhgdQKJNZTTup1JRnWzWL7tUup+39Zkm6Sc7DxQZMgYZDXfDbjuDSSbuXrtYrnQNWdnxo4QhVnRwWt5do88KVUcday4rr0b2l56bav8UBtE6jcg6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYeZngaC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225df540edcso70899465ad.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742284991; x=1742889791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zATNOB+RN3GRdRq8GAz0vH7sY1Yh90UPf+hvtUwtFk=;
        b=JYeZngaCrwqCXIUh9R+MuiHFdmMsx8A6+rRBrfTE+9f6E5LAEMfM110JoGbaJbvTx0
         0M64/ZLb+vlCBmA4VB2gSxtELDDfLaSbhCeEwRfZoNfapZ0kQ6c4SYl9PhgmcDWzCx7S
         +/5gvNWri+zOT8f7G3PkcDK10PIB+orJlfuPM0GFVSB/r3uxz9CehvayG6DjjLpeylNv
         MbFWrnSAqYZSClu7UpyCZIseq2+olRAblT5mD5B0Er8232PVRsuUU7q2vFeIlartOM8S
         l8AAjWkRVRyijhmYDRfca8ROU/2VFlMMcfew3Ebslh92JToNmRSbvJocqKaYBYAhjZKm
         giaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284991; x=1742889791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zATNOB+RN3GRdRq8GAz0vH7sY1Yh90UPf+hvtUwtFk=;
        b=hJUcPZUwXAMRyW30iDe1AjlM0FGhdaGJo/1xxltcHYtp7oFG7yPPxpklWEdbG9TcwX
         2J/3ylQQDhSucjAqjbqAcIghi9WVUTCnIm3KFw2b0BuZg+YcPa2hGVrOpJKyAXDo3I1z
         59BMqr8kok9M/L+PDbGhOgZ++eeHs8WhairTAOKuyqvoh0h0CwpOgJzooyQ8jJQQ021Q
         KvBXBVlZYXP6g8Y2aJut62vIOESS/XmQEcK8+tB0bqkhsbaV6G8jWpAyAm9myCWGuilN
         V2V/IEFnjDGVdF0Fi9wCxGtR/W5tAyXQB9/7osssFE/TF5bAZcx8fBP4T17PCX+BcNnj
         HyFg==
X-Forwarded-Encrypted: i=1; AJvYcCWAQaJpsJuRSM5BWlK/A87k/W+RlAJkXtnw+0sogZOWZxdBUsLmL+pE4LDkBh7FJauN5EB51jT0gOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXFVL28ot6lF9a5KWCKKSyzF7VGO2vT92TeUohyr2mT1Rm/Yd
	rJdGqZr0ZzvRzNCJmDIgUdu5FCatF6LVgWcs/Y1VCsjbUHTWs/RQSgpUVSJTtA==
X-Gm-Gg: ASbGncvs4OnWxny93zrFlKaxSeV0Kq5IhOBiyOm/tuUcKKhzjnmAsPM1tVncdZNrx5x
	SPM4ipcUz/QBJCJgQKyyZjVbPT3zUYXQ8ugikOmceEFE7L63SgTLdfD2sOJUYtmZtaTPSuechHb
	nl5u9QgALDOVyKxKk4i3FV598LszcpW8/qXe/NUAlalQ+EnKYERtvkUph0BnR5xYx8dSWGTiWCE
	++UrvLUd7/UaBawVRxwXKXX8qcjqZG5DR6P5hF0pISE8hG5M8LKq7WTtFYGnXkzZlygBtceB+AB
	qy2B29f5i+dQQDj5a3dME+1WPOTwJC0apnw0H796g6/oDGHVK8V+g0V/
X-Google-Smtp-Source: AGHT+IFQI50pcGaomE3YOZGMmALp0D+8DIQDQoTe6NaI/OMfzJ9nJAe8ts6tZPm5ugXC7xjglM9V7A==
X-Received: by 2002:aa7:9902:0:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-73757932a76mr2891234b3a.9.1742284991535;
        Tue, 18 Mar 2025 01:03:11 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1103sm8934019b3a.167.2025.03.18.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:03:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:33:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <20250318080304.jsmrxqil6pn74nzh@thinkpad>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307103128.3287497-4-s-vadapalli@ti.com>

On Fri, Mar 07, 2025 at 04:01:27PM +0530, Siddharth Vadapalli wrote:
> Introduce the helper function cdns_pcie_ep_disable() which will undo the
> configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> to cleanup on their exit path.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index eeb2afdd223e..85bec57fa5d9 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>  	.get_features	= cdns_pcie_ep_get_features,
>  };
>  
> +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> +{
> +	struct device *dev = ep->pcie.dev;
> +	struct pci_epc *epc = to_pci_epc(dev);
> +

pci_epc_deinit_notify()

- Mani

-- 
மணிவண்ணன் சதாசிவம்

