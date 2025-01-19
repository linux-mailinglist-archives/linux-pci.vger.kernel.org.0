Return-Path: <linux-pci+bounces-20120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D3A162A1
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0317B3A4F41
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990241DF747;
	Sun, 19 Jan 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaVBpdMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDE1DF731
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737300425; cv=none; b=a+MqvThYSQId98uxx0uWYzJMJ4xHjGhKNmhGmQ5qoSaJb+Axzb4J0Ee860j1ZsevckvTveJseASBQHzppbVtaCawaLL07arz43JS8Gfl0/d6X7HzhThOc+/gJ1H3aiFQWm6JU5u042PS7bZasmTDop+k6r9E5Xy9dLzwR5gd2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737300425; c=relaxed/simple;
	bh=PWQpcLhH7Zeo4/EFrlP2gfivfal9zzDPsCLUkRO16zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXDrDycT7m7tYQdkDGdPIyw+Wfi+hN4CodgpNUWcK7YY7noFVKty+otfGwsJX3wPBgb9zS1Zzk5H654b4mBA9l63weV+Pd49R5Slce+TFF8/4EQDRsyPr6CnaiKrorNfvyO9lcgIUxTfkcM8ZH3zdFd3vYWF2ICxC4RoTeSqAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NaVBpdMZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4712135a91.1
        for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737300423; x=1737905223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWLJNtDh2M0LrWGMJ4uX5maH7/SrzMNwJbKx9WRcHPQ=;
        b=NaVBpdMZI071+K9NmczBY5/PxLIwgGaruZottqEB8NFCgAq8RhXj954FscI2pRExkb
         p0LSrisa6Mg/UaptV6v3Sgh7rcGu9AEm5ycGJP4ibVVsWolIVH8Z6fByE96OWSvUqTiR
         +G6ErRdgHBotP7cPXALTm1IjdCusqq9IdvglxWMvw/Ehhh8noMJAQ+Y5VdJoJpgrUuJb
         zwaQQgwQqff+35EoUXqqZbwUpq9sWOcu0y9QPi1yjt5uxJN9LVYlqnkHwk7mQnFtpTHp
         ay94PoY4+VX3Zy29LJF7gpyVa9G63ljcrOzXXx+khLrbjQOhcWjOj+lIkE0bgHNTXfm1
         AIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737300423; x=1737905223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWLJNtDh2M0LrWGMJ4uX5maH7/SrzMNwJbKx9WRcHPQ=;
        b=CCu+YgDVOfCFHuxhITYY+iTpVPxD5kc14QVFAeSi82zqbfg6lrjXKx08wqC/E02CJo
         vOFmwJ2S4RQ/pnGa27ws68Fsm/pfVO7g+NVhr+s0cAdE02bshLBZBV3WgBkiFF5zGaFi
         i2HAdCMK9uqN5+fjwmjzmfNj6dGSN2vWrTFGOFqGKpEG85IJkrfX0gErEIUTE/nxF2kk
         Agn0qqyi6V0ed6+yhXkkJdtuFoF9iubDM6ilokQh2MuDZ0dSqun9uNQnCUeKLS/T/n99
         knVZblVgjQktPwxT+WITkL6C3JpA4ZFTbsjYnr6cS3BQwRDia1/Uo651T56LdafHaHhz
         qmWg==
X-Forwarded-Encrypted: i=1; AJvYcCWkW4nbJwABbd7NLtYR31/pDYUVmHBWWZ+E5ZygiO54W6//eVU4JQLq3JoMepMDLk/EQ9pSSerQHi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKz+XIl9HeHLt2xD01kLE9Dgs7+cfxMAvfZYYT7TPblVdUYhUh
	0kU1HQvRFRo/i0MHdaeF/FuCSeNs1OWmPo0lu4aXhllpC2R/61OTXdToc0UDeQ==
X-Gm-Gg: ASbGnctinFfFY+LF9zpjNOAV03yqTQaWPg4WQu5OZ0I3h1EjQSC8PGhoaqaxh8+Zwer
	uT5HV5MmNBQIoZXI2guPQdoJaCEgPtneO3aeVLmLGsKn30H7zA4F2ir1uLlaiKX1UkeBs1ZQj7p
	dXhPMpFLrC+zYt1KHjZ3XrxE3mjEFJXAZxqrF2gsXvYHmZMZKmQw7vKbXHLGichd2+JPfXekZwQ
	0ZHmsbF0mr78/FKPEVHgtP0CrSxWA7zVHPgjsjum+KevsYsLJk0ak7vOLogAJd63FytvwDU7zlJ
	fyMEqQ==
X-Google-Smtp-Source: AGHT+IENWqIH7vPK9qo4kAByRAYKRm1YyPEDyBpffvJczNdBlZH+Y7lmOf7IJkBmPUxBttv2OPLC8A==
X-Received: by 2002:a17:90a:7141:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f782c70237mr16844568a91.12.1737300423171;
        Sun, 19 Jan 2025 07:27:03 -0800 (PST)
Received: from thinkpad ([120.56.195.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a162sm5861697a91.2.2025.01.19.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 07:27:02 -0800 (PST)
Date: Sun, 19 Jan 2025 20:56:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: qcom-sm8[56]50: document and add 'global'
 interrupt
Message-ID: <20250119152655.g2w4evteqqastil2@thinkpad>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:48AM +0100, Neil Armstrong wrote:
> Following [1], document the global irq for the PCIe RC and
> add the interrupt for the SM8550 & SM8650 PCIe RC nodes.
> 
> Tested on SM8550-QRD, SM8650-QRD and SM8650-HDK.
> 
> [1] https://lore.kernel.org/all/20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Neil Armstrong (3):
>       dt-bindings: PCI: qcom,pcie-sm8550: document 'global' interrupt
>       arm64: dts: qcom: sm8550: Add 'global' interrupt to the PCIe RC nodes
>       arm64: dts: qcom: sm8650: Add 'global' interrupt to the PCIe RC nodes
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml |  9 ++++++---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 12 ++++++++----
>  arch/arm64/boot/dts/qcom/sm8650.dtsi                        | 12 ++++++++----
>  3 files changed, 22 insertions(+), 11 deletions(-)
> ---
> base-commit: adc218676eef25575469234709c2d87185ca223a
> change-id: 20241126-topic-sm8x50-pcie-global-irq-712d678b5226
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

