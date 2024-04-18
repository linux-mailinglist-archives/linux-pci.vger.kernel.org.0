Return-Path: <linux-pci+bounces-6394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED78A92F5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D86E281364
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A26A340;
	Thu, 18 Apr 2024 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJ6GF1zn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A915B208
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421218; cv=none; b=GvHxPqNJ18ZrBy1gYH7fizS/KXegjta8v1ER4rX3pGOquugnPY7Aairc8j/gfOlHIzyA7UabE9RLl/RXvwv2AuWo+nEsAY9Fkp+QqPxSE9TwL9PjznTbigzyr+6Ql/5tG6w44OYZr9FYT7H4UGdvnuH3WwxulJ7O+V0hPOCb3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421218; c=relaxed/simple;
	bh=ioUowZ4DOFzP0N/qgT9D4k4N1wRxG9niaft+g/nCSIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRsjK50i1MDxlNWwOO8Hrgi5eF9PZbAY2uw45dbZrBUYJVBWG/M//TmiY+wGsxi5nqKXbjjf9sRBpNJ7jyUI3/d0n5SlxdJ2G0gRtWegVt4YNqOeAKghO2ByQ/bpg0CJgj5YOdh49SvwIXrItGjXMlIDl25MHBIIlnDk/43vyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJ6GF1zn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e504f58230so4594145ad.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 23:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713421217; x=1714026017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eC0jjvQDPobd97rKZ4kcPj9ytdXbP5Fo1R6tB5tlq9k=;
        b=gJ6GF1znWZyEuwRDdA+uya92POSmz5n6eodlWz4RiooNiYXEDy43kceiWN1kvS2+vV
         ElUKnjYvBAAW+cLlwZxn8R34QwaiRvrJOuodDZrukurQVJFLVlxzVn/wSI1nshz2xS8U
         nBRtNjNEMmfRq8diyz0anD5geW1/WAKKJT/QNt2ad7jxp4PJt3JMS1E5bRr0fSq302VY
         cYGGEu/h+O7b5LWV1E472PEirnUZ5nht7RXeAK29fgcXD3PsiBRcvr02RkPLbPq0Pm2r
         KTro1HLU07bNh7ScLV3Qt2y9Ve7S1P1TSw3xN9dXdN28Tn33ewTxA2ksOAD7cyKwTVkL
         tU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421217; x=1714026017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC0jjvQDPobd97rKZ4kcPj9ytdXbP5Fo1R6tB5tlq9k=;
        b=F5M8xbuU3ibvsX2Z3mf0B5BxJ89cJHkmLjDoutHmEeoq0NYmGCH6/zJoZxdNbQgU1m
         o9LcNUwJ5u8LAzF2kNO5gXNx3WWOo/2cHc2ZPx4ilR/UrdSDC4ViNgmcrcrqoRGgto5K
         HpmLC5dfMqtqptALJvkcyUaaUNdHzxE3fFMMAtU6ZwaggzqNetZLoBW3+W9MSq5i6bEL
         iUUP6YBD9Q6gHrJByx7wKd6T9Hg7Tgu946nthUhsmTIcU3+eLBfdSTKZf+c4H9PY8g+w
         qbFVetZwCS1Jij+jcTDsiiMQ9JVUxAoNE/Tc71w4LnvVTKj6VeWyUVYCZGxddRNgr0n9
         OZuA==
X-Forwarded-Encrypted: i=1; AJvYcCWccm4K5naWAhvaHGV+hDotssJ/7xa/bItY3hBzVMk5A282cjS7zPxOuzR0N5blDv2aqsbC/ZtKBvkVtMsqYl4gu46Iquinm9SK
X-Gm-Message-State: AOJu0Yz9bBZe/GGldsyQB+MhTRqZ550S20CYcXiL5/vmpWp12WkC5qod
	j3AmCB5wn7et8h27Ub7t225UasqDHuA4MNbJEJe3NVjbq9zgOtH9MF0QEVfb+g==
X-Google-Smtp-Source: AGHT+IGdfM7ZRhJKbLTZ3yVa5ET1b0iJCVoUvItzdBrd7Ol9ksqn1v2z6enDdZegm9UydZGVy5biZQ==
X-Received: by 2002:a17:903:48f:b0:1e4:24bc:426e with SMTP id jj15-20020a170903048f00b001e424bc426emr1861087plb.28.1713421216842;
        Wed, 17 Apr 2024 23:20:16 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902b94a00b001e088a9e2bcsm691770pls.292.2024.04.17.23.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:20:15 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:50:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Message-ID: <20240418062009.GD2861@thinkpad>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
 <20240417-pme_msg-v7-4-9c6208cda90f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417-pme_msg-v7-4-9c6208cda90f@nxp.com>

On Wed, Apr 17, 2024 at 12:59:42PM -0400, Frank Li wrote:
> Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
> PME_Turn_Off messages.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/pci.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 02f46875fe2d9..36381fc7ebd32 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -30,6 +30,9 @@
>  #define PCIE_MSG_TYPE_R_LOCAL	4
>  #define PCIE_MSG_TYPE_R_GATHER	5
>  
> +/* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
> +#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
> +
>  /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
>  #define PCIE_MSG_CODE_ASSERT_INTA	0x20
>  #define PCIE_MSG_CODE_ASSERT_INTB	0x21
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

