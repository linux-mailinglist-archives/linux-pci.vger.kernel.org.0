Return-Path: <linux-pci+bounces-21051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC4A2E5C8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9391647E0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8C1B6CE5;
	Mon, 10 Feb 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSQjYFTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10571ADC93
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173923; cv=none; b=F+7KVQ2dRjkj/Z/Ew3IbGo4VYQpPLUNQtFM5Kg9+LgJeWsWl28hWJsbYZz2r1MuRHa+3WYUsTfB3JbusKwYVYLros8gROChCW2c48z9gucHPGd+CQujl8IHvxUuSH49V5ojrEdXLTcwutpUMYqL6zY0zKcmUNS73ySrRZbm/Mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173923; c=relaxed/simple;
	bh=SbiBsePgUUDw8ub83Bn9h4Z6Q+/Z2UG671GLzYjIXHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWUdjJfiPsd18+GQ7ESxWme3UDLMEt52jbT7cT25IqtfMw+Ac0b93HpMgtB8kt9yxY1B7R3i+l621oUWwUY65N5G3hvdb4/wh5l9n2WksB5Sq0LR1w2CGY/+pccf3Tm/vqXdpZl9NnG2/Qhpr8X+nz14htmWloMveSrxtDwStCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iSQjYFTE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f40deb941so81247745ad.2
        for <linux-pci@vger.kernel.org>; Sun, 09 Feb 2025 23:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739173921; x=1739778721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRRm29wGMApxPz8FgRvy/J5UYrL30LQ9avtohjE2Q3o=;
        b=iSQjYFTEgU3v8EvCcFO3B+QjnAAKJ1ZbmdtTVyoKGUzI7wXHD2OkIa36cAIaBumphT
         jt4ogZKCR05t3a3mKZr0FWRfw9QC/IYdutS1NuSMKGgI6tJaOrFPDbE3IpNvsZdk+9cB
         vREc+c1aCclli/Oxd1zZJN45E4f6G4HbKm6tMnqbVFVmvlOHkKFQvBthhhErTcX0iJFh
         KOfRscX8Vxze3TcHl+C7CZYB4iKb/nOmTjvUnGJxxHy3iO+7iRCCKsn4HhBU0lRROw7R
         bz3cXP1hcoS/aAYrhnHDhyK+vNR81R2dLeJ3r6++94FD5fxm8d1iMIW9ch1tFvcVasKi
         dBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173921; x=1739778721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRRm29wGMApxPz8FgRvy/J5UYrL30LQ9avtohjE2Q3o=;
        b=QXRojpYnVV2dWmcETXE4ZF6yXyYJkiqR5EaPupjjKDsYgDogcW4oR9LEKegONWUs4B
         AgjukKmN4oVrOP9FJAKESLyOuNPb3vNDf/XSZ19eUac4MqPT+L5x4c4wanR3SrbE3riP
         DV3MNbbV3oTCsGHpJ/fmo3ZfplMAtNZkDfkM6u+8vpV9w+QIlrHkZPx81S4Vvo7s5GV+
         WbTBhfsUffQigeq53jdivaqFvwc5dY0F3PC3cXLeoOwRU5OFbgny0d9SmfpRQOqJNtAK
         dxHQ/KO6CG8Zlr8Enlgg+n1SqBddrfuwti5ywmXpZqn6Ae/wwnM4KMeux+FB9v30sTQo
         Yu5w==
X-Forwarded-Encrypted: i=1; AJvYcCVPCGt1HU/4v9d6AauUx7YKWWMFHzOmYJQfKrkEi4QUBaqH2hvEdlLAUId9ZMB2PEDxIAyik/mJjOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnCRtsxPyYTukmB91ook/AUlfykT0QLruQJea+IyYAz3fbN4j
	TkmVbWvr572z5oRVMrQpaqx8cMGkzB1XPkx4DiMD3DIhvXHOgdLLwq4bkkW3qQ==
X-Gm-Gg: ASbGncu66oz3L6uMpkfEVsZLks7HEjgppjzi/FCggGNDJ99OTV1/5YN9CSAWji/siFP
	Hka8do11wwRcF8rl+bjLCbftRoAwExYhgoojwpr1mNicxz18SmlFAkXe6zFQZZLWYZnL+n2PsKx
	AJxztHwIr1QL532Q6L7N/2zL49hqu9D8oSXq4OV9X0jHgyqgSOhrsiVcv8K/QBwQ910rOGeF1vt
	cF3TpnejYVIzlMT+yV1lRyLKNPS/xQqaPzQCiuPctiqSX/EOws6SNVL2jJsx7vQH3WMV2pifdmh
	TExMQ/Lp4rP6dasw5OxMd9MWAqeU
X-Google-Smtp-Source: AGHT+IFiBhqV22C5q8pOwc0SqHNUPt/CKAPUfMB5p7rCsPdXXm7wz9qVBmWTaac8lz1b+Tnnpgp3rQ==
X-Received: by 2002:a17:902:f806:b0:21f:dc3:8901 with SMTP id d9443c01a7336-21f4e7985c6mr166681905ad.34.1739173921291;
        Sun, 09 Feb 2025 23:52:01 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6cbsm72256895ad.40.2025.02.09.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:52:00 -0800 (PST)
Date: Mon, 10 Feb 2025 13:21:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, andersson@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <20250210075155.ka3fy3xiptyy3w6i@thinkpad>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <83337e51-6554-6543-059d-c71a50601b09@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83337e51-6554-6543-059d-c71a50601b09@quicinc.com>

On Wed, Dec 04, 2024 at 02:19:56PM +0530, Krishna Chaitanya Chundru wrote:

[...]

> > > > +                pcie@3,0 {
> > > > +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> > > > +                    #address-cells = <3>;
> > > > +                    #size-cells = <2>;
> > > > +                    device_type = "pci";
> > > > +                    ranges;
> > > > +                    bus-range = <0x05 0xff>;
> > > > +
> > > > +                    qcom,tx-amplitude-millivolt = <10>;
> > > > +                    pcie@0,0 {
> > > > +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
> > > > +                        #address-cells = <3>;
> > > > +                        #size-cells = <2>;
> > > > +                        device_type = "pci";
> > > 
> > > There's a 2nd PCI-PCI bridge?
> > This the embedded ethernet port which is as part of DSP3.
> > 
> Hi Rob,
> 
> Can you please check my response on your queries, if you need
> any extra information, we can provide to sort this out.
> 

I believe Rob was pointing the 'device_type' property which is not needed for
PCI device nodes but only for nodes implementing PCI bus (like host bridge, PCI
bridge).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

