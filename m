Return-Path: <linux-pci+bounces-22855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD1A4E2F1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12389421F98
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0028D06B;
	Tue,  4 Mar 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYNYEgjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDD28D05E
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100974; cv=none; b=cPhRQS8pt1SQveIqOqZGy4lMbfkWHcITUnlFMcu5atPTdhcVtxm8Y98B8Vxaa9M3QzO5M6+ryF08LY4OnjtnSrGJ/cIDiPMBWpkpTRqGQGdFFYro4GcZJQsMxEkJ7UipvLZpeS9iAubQ2GScS5nCaTeY3Yjj8tvrgEwk/jn+yg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100974; c=relaxed/simple;
	bh=3Z8B5l+iGfg+3kk25clByLiUXRRdAkqAhwjlHnti/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8lefXkHE/+FY2eE/7hrW4XmttOhBaliiqUK2WRFwzcw962kUvdPMOOExeEQSp8bQGP/DcOXVk8tCwgOdhC9SaAxOx0fAvAmq5uoOXqoPExXuoNwL3jMbV3iOVmIxwfnOAtrKe/Izq+2FhOEEQJg4Oupz4YOmY3/qlQSE0waInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYNYEgjm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22339936bbfso85437575ad.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100972; x=1741705772; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eXtflJVWFreoh2RfRDMWyYTeNxkucDM+/OLgGz1etxI=;
        b=rYNYEgjmNfR2rgmVIuRYciPeCnlBtOZeDqnagTDD8wiA4kpc2QQMiu7j1dsA0QigQI
         wxdTOpuyhmI3Gr/7LbYiicYkAmqAeFWRscw6pe3K5HrvzrGuSfVfCJiBWAna0gT/1Sod
         jMWoZepAdPfPDijsCjIBJcRopuYMvV++fFFSwC8nrNTjrMe0OHnaQJOeqtp5anlBw2gE
         GAPlpqjArgSfUYb1u0ZldfhpsAAOYOEPhzhA1Vx3NT8zHUC79YTnRIMH5QV6SRv2nCvY
         UM+KP3KNiBHtxoKhFlF28V/X8jMYpetZ6brGFB2LebCox5V0r5TyOE0q4AbS9AK4jTAR
         gx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100972; x=1741705772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXtflJVWFreoh2RfRDMWyYTeNxkucDM+/OLgGz1etxI=;
        b=UnpJniqSjZykO2TsjCL0lXZblZcsAOeP8F1KoecLb23bIErTC+p89YFV7BpL5yeSDQ
         pIhP1PXuTc+gZ0ZuYWtz1FTdxqn6nRymAnEqMGgyAPnFz7SvxB85aV/KeBmo3X2hbLwg
         74Ae7y/v2If2pCE2u4szV0ays7S6q8ke6/1WTG4IF7uj7fuCmq/VkD+M/VfW5VN0y5kp
         DJVQ3qxVKreXseIwFrHPBmdTGyUpcGTW6jKy4SEHg4IGZMYXMXfU91lWgc4pwWWyQPfJ
         jTl22sGfFyCXRidS6lPFu7Y7vLsB8KnlxE2TNm/WTuqPFo5m3qaWqWAihMsaSZ1t5kKV
         LTsA==
X-Gm-Message-State: AOJu0Yz7HGC2q1LgjGi8muDi2d5OWHucJ3hrpU/uOu+R16qVBpi4zkF7
	E2GyayHD/sv6Pof9bYnJMlBActfbti2xp3qKEOSiD6RW9Jllm1WKbeYiBHoOeA==
X-Gm-Gg: ASbGncsDI8ItBuzUpw9uIKzEeNCls8+DnhwZQfnpXeShqpShbtv21w00OCPMQraLXfi
	Y52D3lxkOy6UAsG526RItMNtY8d04dow8EwXNXrJHTVIU0QBOdOUiDt8BWfOZiAXlHo/QkIG6vX
	VzdyLE38YJwspDMH3exjeD4BGA8HjXHLph2ktXBbt4x2Cb7S+VdA4zxZcVll6ezOXBH+ErOwidl
	Ea54W3jZJgqxCeFdQyNokTDv2KD7FIPsChlqvvhXhLAXNiYhcZMZEd7UE9j3l1cmU/HpwARc8qF
	vKjDZ06B5RY95rZ8jvM9gRTFd2ODkQPZU/m8ZSvU/T5WYcZETfywfrw=
X-Google-Smtp-Source: AGHT+IHH3kAeBAzG7ggYHAxEuKnNP4t+N+bzoJzUJ161LlHrI1a78f2EZCVwmMROqGLsC4q+42HbGQ==
X-Received: by 2002:a05:6a20:4310:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-1f2f4d2edf8mr31762576637.24.1741100972347;
        Tue, 04 Mar 2025 07:09:32 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1a49esm10249081a12.17.2025.03.04.07.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:09:31 -0800 (PST)
Date: Tue, 4 Mar 2025 20:39:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] PCI: brcmstb: Make two changes in MDIO register
 fields
Message-ID: <20250304150924.a6ygwzca3lwgpt7h@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-8-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-8-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:35PM -0500, Jim Quinlan wrote:
> The HW team has decided to "tighten" some field definitions in the MDIO
> packet format.  Fortunately these two changes may be made in a backwards
> compatible manner.
> 
> The CMD field used to be 12 bits and now is one.  This change is backwards
> compatible because the field's starting bit position is unchanged and the
> only commands we've used have values 0 and 1.
> 
> The PORT field's width has been changed from four to five bits.  When
> written, the new bit is not contiguous with the other four.  Fortunately,
> this change is backwards compatible because we have never used anything
> other than 0 for the port field's value.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 923ac1a03f85..cb897d4b2579 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -175,8 +175,9 @@
>  #define MDIO_PORT0			0x0
>  #define MDIO_DATA_MASK			0x7fffffff
>  #define MDIO_PORT_MASK			0xf0000
> +#define MDIO_PORT_EXT_MASK		0x200000
>  #define MDIO_REGAD_MASK			0xffff
> -#define MDIO_CMD_MASK			0xfff00000
> +#define MDIO_CMD_MASK			0x00100000
>  #define MDIO_CMD_READ			0x1
>  #define MDIO_CMD_WRITE			0x0
>  #define MDIO_DATA_DONE_MASK		0x80000000
> @@ -327,6 +328,7 @@ static u32 brcm_pcie_mdio_form_pkt(int port, int regad, int cmd)
>  {
>  	u32 pkt = 0;
>  
> +	pkt |= FIELD_PREP(MDIO_PORT_EXT_MASK, port >> 4);
>  	pkt |= FIELD_PREP(MDIO_PORT_MASK, port);
>  	pkt |= FIELD_PREP(MDIO_REGAD_MASK, regad);
>  	pkt |= FIELD_PREP(MDIO_CMD_MASK, cmd);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

