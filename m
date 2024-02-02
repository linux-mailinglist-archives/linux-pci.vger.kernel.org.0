Return-Path: <linux-pci+bounces-3002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE60846D2D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 11:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E95A1C2737D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F077652;
	Fri,  2 Feb 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9Lxm4OQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2FA65191
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868049; cv=none; b=g9uLKbdBdyI0UUbKjy1txaUUdRfOji4HRunY/9cfgPCok/+MDbYhZeHlVNM2I9ytk24VT3BgfOCzltokg41OKep0qlNR2+SdanXEV8UpI6VIOq6Zks5vG/w0yh4pIxDXCi80bR6JH4x8bnkoog69FsC+OpvDZtgGbogV0S13TWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868049; c=relaxed/simple;
	bh=/46XmXS6WHLjojvBp7vJRWo/zydF4oNVEb5JMR3H5M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtws9wbVw6mXe2zoa31S12H8qAFB3ZTrknLMkBWVEEUWDSrjp5XQuGhKA2ZoLy/uS+S8H95911uWG1OP2rWSgYYSXpvjyyfg04oXn79ImSg8opznl26GwLyzCcMjp/zKvzqP31JirItakTu+EXJ0ItJzKOgdZoit0IU6GctWtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9Lxm4OQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6de28744a46so1460454b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706868047; x=1707472847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Icnw/ylZjZ47F0p04CO9FlDlgDGuhe99H7DfZw8POCQ=;
        b=r9Lxm4OQEVI/myqobiieUg4FvvJwNk6FEj9F1VQql9sEQyWYTRFaUnyR98ycq5I6nW
         XFqGFMEa79wZq9PW3+u96jOJTvb3vYapS4OylaRHfDt9tEqgIpaivh1bTQOIsYrIZnKr
         otNZMG/4zyaB51r87BgVkbrD0jL1WyPXyk8YWk7/dyyylmAHFQoiIkFiD3LfD0g+DxrS
         3gJOZg4SpGDkcq4LncHyTxH0YDAxf6RvQfvseCI4BXGaji4ilhlVKDWZxsKo4zdsM/Fe
         6Vz06pWTWgFCHxv9YohS58zFra100u47qfBne++BASkNnAj3U5ezF2DakaRCg/IUXWlp
         KG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868047; x=1707472847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Icnw/ylZjZ47F0p04CO9FlDlgDGuhe99H7DfZw8POCQ=;
        b=SxevfetOy8M/Ulza1/OB1TtSA4eLC0uw9JUaaRrXnuseueUKEDeCbaAkCcP9p5OorY
         wW0Gl214Lqx9Ksb3A5kn0i8+lYgzCR3RXSYhCpvyKHb9kTIJFH6IqAMMDIx6cowSjrsp
         6TS1ngLEhpmNeFHo/77bj3IvPUIUQwkB5oKQllS3CK/0Ndw6Spack59OONXtXRGqKZps
         kn8MxdfrlgGo3hrXMMywp4I5vLdKUW1lSiBR2Gpj1sV+TJ6Q6k4Vm3iq3nK4qEfGnlXj
         YQsKxL9ipdN3gkKFQeBom0Vk4NI0RtybnWYN9tWUEYn+6PVOcUyfkYpElyIm/JVyufCK
         PXWg==
X-Gm-Message-State: AOJu0Yz0t7pgpfZtOMi1Mm0zVMR8dbi/0b/BP+/xEMvQHbnLRKKi6ShU
	FOjfHUEk+z7EqEvSsx+p0Esx/KHoifZI3Qc5/l+c2Xt+5duSxUbP/8YZrG4pmw==
X-Google-Smtp-Source: AGHT+IHEt0kqIdqil1OgUDS40VaxvT9QbF43kZ4LxpIrez5UaGbV0J9rZjexZfFLSiGus9niF1lsJg==
X-Received: by 2002:aa7:8203:0:b0:6df:dde5:6029 with SMTP id k3-20020aa78203000000b006dfdde56029mr6142650pfi.19.1706868046681;
        Fri, 02 Feb 2024 02:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXh6Eq8x89cUSKh8IzQd23bvhoSyshOLH8GA4DX6LdUtwEborxEGvJv5IeECHC3LTitGVn/cFce5p1acGuY2zkexgLdseYZAdoS6A5Q2HmRgTqUTa1uiposYCpTUmQI62YGnjtFXXedHtHQ0brmsnIGVPDAbCB/8inZ3uVGuZ2Rdp2M7p8ft443rrTm+/zcg6NjS34AeoNfcvXcWASrgEbs8VLa0ohYAS7JXaVkF3pnwVAwvz39mQxSwE82qrHEkWveCr25ltyrYoxbntN39uE5NkAoiXDMAKeSA8D9Nt+xL7QzO6XqnEV4LSnISrbPg6JEQ/CzSqI4XJl5gKp7Ta4zahUxjPI93enkMfo02XXOsx1glAy7F1TzE9K1+vZiwF88HCbv+fW7
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b005cee9115cb3sm1240400pgc.0.2024.02.02.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:00:46 -0800 (PST)
Date: Fri, 2 Feb 2024 15:30:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable D3 support for Qualcomm bridges
Message-ID: <20240202100041.GB8020@thinkpad>
References: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
 <20240202090033.GA9589@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202090033.GA9589@wunner.de>

On Fri, Feb 02, 2024 at 10:00:33AM +0100, Lukas Wunner wrote:
> On Fri, Feb 02, 2024 at 12:24:16PM +0530, Manivannan Sadhasivam wrote:
> > This series enables D3 support for PCI bridges found in Qcom SoCs. Currently,
> > PCI core will enable D3 support for PCI bridges only when the following
> > conditions are met:
> > 
> > 1. Platform is ACPI based
> > 2. Thunderbolt controller is used
> > 3. pcie_port_pm=force passed in cmdline
> > 
> > While options 1 and 2 do not apply to Qcom SoCs, option 3 will make the life
> > harder for distro maintainers. Due to this, runtime PM is also not getting
> > enabled for the bridges.
> > 
> > Ideally, D3 support should be enabled by default for the recent PCI bridges,
> > but we do not have a sane way to detect them. So this series adds a new flag
> > "bridge_d3_capable" to "struct pci_dev" which could be set by the bridge
> > drivers for capable devices. This will allow the PCI core to enable D3
> > support for the bridges during enumeration.
> 
> I think the right way to do this is to use the existing call to
> platform_pci_bridge_d3() in pci_bridge_d3_possible().
> 
> Please amend platform_pci_bridge_d3() to call a new of_pci_bridge_d3()
> function which determines whether D3 is supported by the platform.
> 
> E.g. of_pci_bridge_d3() could contain a whitelist of supported VID/DID
> tuples.  Or it could be defined as a __weak function which always
> returns false but can be overridden at link time by a function
> defined somewhere in arch/arm/, arch/arm64/ or in some driver
> whose Kconfig option is enabled in Qualcomm platforms.
> 

Hmm. If we go with a DT based solution, then introducing a new property like
"d3-support" in the PCI bridge node would be the right approach. But then, it
also requires defining the PCI bridge node in all the DTs. But that should be
fine since it will help us to support WAKE# (per bridge) in the future.

Thanks for the review.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

