Return-Path: <linux-pci+bounces-6571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B78AE775
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952F2B25E6C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B2134735;
	Tue, 23 Apr 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ting4AdE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997271353F2
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877692; cv=none; b=AINCp49wiblP7U9baJG2+C76+KjDBYCHJ8Vl3T+AIID2fjg4QbNSJLXSkZGd65DIJywmdT0OyWPhAnwiKOrj56mbxnCjemVMNcJ14K3VWy+H0jOF+KPDaibb9Z1pT3Rvf+9mn2DImGu2iYm0RJKC4/DVbU+HeTOxbP5mhR4khxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877692; c=relaxed/simple;
	bh=BeIUqQAJFNDOpF7ht1GQmR6wVW1LPDbJ/XROhUKljBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/kWKmU+Qr/FRKOz1eomJJ2KDsiSmyZ46iidk4n2Lxr+P021D5ve+GoEI5rFdIBDZ9rnizZ33JzK+NbUrFr3iUomgMupNRZz1XHChYvhMiJN2h4/rYpVVQIrYPWPBUcf0ZRg3IL5KxU4pL478UJjBdRkke+RMFDEdW/ldglNVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ting4AdE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso85257621fa.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713877689; x=1714482489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeIUqQAJFNDOpF7ht1GQmR6wVW1LPDbJ/XROhUKljBc=;
        b=ting4AdEyo60Uc45ePzamwPNjTyqc0LE1KIsTEOF4E8J8XTRjgyqRMupeNTLrsspru
         duR4fu9Yt2rGDCsmuyjcY6bLaBzQvZ/rDwWnGSRT+zXw7yeLXBcGomgUcOjoFA3oqjNA
         /RU3J+nfgZ1yf2UY4ah/ZjrwJ2CQpdiy4vi25NfFFXec0Yk/qCOTAJrOp26mps3g9B12
         Cf8jvqxtBLz5II6o9xIImf1zYLVbFcqjP87cLbDzHflAt9p6N7PfUQ0o41vTK5Af74yO
         5RA9OuivQ0SIC8mBBnyS4B7S7d6tIHgY3tuCUXEMLE6Djgqpi/ilJu4bxTB65lLecdB1
         wARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877689; x=1714482489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeIUqQAJFNDOpF7ht1GQmR6wVW1LPDbJ/XROhUKljBc=;
        b=noDTrEgOlL7Yt2vcs9kU98KN1KM5C8t4c/jSA8X0MvaG8AuY/2n93bNCA9k4n2ScNd
         j5V2/fhoTjjF5Sehz3iTn/xV9a6DSc+GKdIHIbuocyb33ZpIO9Q8CLKyPBGYztl3Xehp
         nn/MXvYFWH2zGGRQLcVfkQwbV6aiitLo5KuyRf+Wk/eFp1T9PW3OriYf5XGTvqxnkSBZ
         UzLSe5tmcAtYglQx8QbUqnZmFM6AI+SfFtE9rDClNrf6nnF6/+O12anp04AA+mO2OHfG
         qGbV6vzfqy9lhocHah7ygcv3V8NX0U1n0NbS7mAXQHLzYt7tiiVOFqHPiWpk8yL5ioF0
         qa/A==
X-Forwarded-Encrypted: i=1; AJvYcCUCbzTmLZpF8V4uvbbAJzQzPTxnIcVGzZvU8f7WTu7yWMZNFtRw4pO+f2/l2awQSbUWyOogp0wG7kq08z9ZJyWygb8Y84O1433C
X-Gm-Message-State: AOJu0YzIPJsLLaF5SKV4V+R1Vf1029uB1RzHQmkem652jgCf5x3kqXDy
	PBpF74By0voKHVHbwHfQRoa6Y2TWvkkpdE9k8N/IZEVVP9/mHhMY768iTh5RB1Q=
X-Google-Smtp-Source: AGHT+IE63dqBihv/nXAaphUKhm4QoRx8cccrUbZIncSaNE5pK7FBZ6/h8B/ymrmWiFGABv0uHgk0Og==
X-Received: by 2002:a05:651c:1a06:b0:2d8:34ec:54e6 with SMTP id by6-20020a05651c1a0600b002d834ec54e6mr9435410ljb.33.1713877688746;
        Tue, 23 Apr 2024 06:08:08 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k11-20020a2e888b000000b002dd92e1ae00sm542013lji.26.2024.04.23.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 06:08:08 -0700 (PDT)
Message-ID: <8cdcfa2f-7a8f-4f63-b919-df0afde7d9de@linaro.org>
Date: Tue, 23 Apr 2024 15:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] PCI: qcom-ep: Add support for SA8775P SOC
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
 quic_schintav@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com>
 <1711725718-6362-3-git-send-email-quic_msarkar@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1711725718-6362-3-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 16:21, Mrinmay Sarkar wrote:
> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> driver. Adding new compatible string as it has different set of clocks
> compared to other SoCs.

So is it the only change after all? What did we conclude on the NO_SNOOP
saga?

If the difference is only in the consumed clocks (and they're only supposed
to be "on" with no special handling), I don't think a separate compatible
is necessary at all

Konrad

