Return-Path: <linux-pci+bounces-22281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F341BA43384
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097173A79EE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33A13632B;
	Tue, 25 Feb 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEsheRDi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64174C6E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453547; cv=none; b=WoCk/TxPcLQvFyWmlvAMh0cvGLEXp7ag6cNoX84pJsbYZPSPokJBxV84G9q67BQ7aRPxlvixGDr0v936zEBYjewKgMnKh/bknjQaewRYAuc5SmP1nlKbHnjNRKdVUwkHtjfg/g8w0ZKfm+jSxg1b94/aydKdTllG05IQEXSzesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453547; c=relaxed/simple;
	bh=LXriQkLQBqACs+UUX231RySTgvUDN3sB/8WC0n+zxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUQXD1zR8lKc7dJ9uGzxuiUygW3cvyLb6Nww1RPHAOqx8XZ87Qnkw0CaVT+EPQTW2L5TSJjbkxeitfiql3UBvmiej+nYu0/F6Zf3l7MLfeITzoIKDHtLd9gcKIxhuT05qye3vvQAMnCQ6mYM7fTKOJfBE/+2gUZ76NeZ9LU6+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEsheRDi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30762598511so46716991fa.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 19:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740453544; x=1741058344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3wJvzg+EU3gQmUwHBxZTu/YhhwWOTXDIc1qEOHLA1GI=;
        b=GEsheRDiKvTW5UGY5oMdD4j3cHWZmnuGXfH0WdpEUui9ziA7gXLoxUQJtoVct3cby0
         r8xpUtzNXHibZj039vrElDkLfM0vHoyBnw4+MvoPDUTcV+wTNn+1ti+BEZQ4zcVsQwYM
         XT1+/UnwHj3o36ll6REL9yjd9yZooS8M/JKNSdsKXOlR7pXxllBy3FFruBDurBgYvv9x
         G5UQO1CuFTVLBHm94X1PmI70SWEWsKYimpp190r0sDci5NbmXnynD6Y+2S54goFOB4oy
         6wVhRr+h0V3A9CxpfYS7d6euFBwRULhXghSMdwtI/5ERQ05utH/CaRNGT24af5VBPz99
         +8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453544; x=1741058344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wJvzg+EU3gQmUwHBxZTu/YhhwWOTXDIc1qEOHLA1GI=;
        b=J0Gtcnj8BgRAlxKMPPvWMPkWhqY8UTBt6oY6Lok3bSBOETM8536llBbhfTWPweGrUx
         U6FVOpB+Xs8g+yPw09ajXzUv5oIV173cZr4dt/wtvLYmnuTGPBzlYkZjs5cIn8m4PoV/
         rei15I05RSYfC9/Q0RAA253ovuQuZoBCztdFf495PBcpBNW07S941zQbK9Hahv+Z2Yf4
         PMtn3RnlXaIehCE4NP6AZKfHU5EFJ4kQtsHYTHAwi92YQpqjFNBnoM+7qd1om241DccD
         QHTSTF2NIryC/PTDwB2T4xZhtPRAn5zo/CdGoA90j4Tw/cf1FhVHsxZeGfH3xot8oQ7i
         PF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGtOXEcB/IjxG1vuxPxKazkkOHkQy/OCyIsGZQpWLZ6gTVWtHPxDuP6caGwgf3SUa/jrc9wJNeZY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3Agag5tEfDolH1e2F1zbERO9RloAJYWxkqii/NY6oqK9+Mav
	8MolhZ6HNukggtIy5Fb9P+cbfe/AnFSD80eVz4etgFVqDz1wgScyBYwJE2Ef060=
X-Gm-Gg: ASbGncsXglo0bQgsh8HXaPqNnZ/rG8UL64yLvJuGX1Sk8SSZSl8zH9QZd8VefiDZkAs
	RsG2cR72vVGRPPNzW+VTqhzRLvdA8OC6tt7giMnbPRM+gIrlP7qKKBFavXZLyhBmN48d5b05oVe
	rQSEyP0TOdy4aqXDCTBC6iUvMOzZURuGB4/vhMQgDlq1Wsp18RXOJab5kQsWWO8bwWgADoggsE0
	ziLc8dHbZeYDHnqhUUwkoIpi8vPaLn18d0gulBhQ4fyD5KTFhQK+yGHP24p7v1BH7z1MP1G6bhT
	t2iW03HrE60M66jSttRvlHaCZtzZL66fALv+FcLhPD5ILC39KcbbVDvkHBcU1dWa2DurqlImEn5
	ds1MlbQ==
X-Google-Smtp-Source: AGHT+IEZniH1FzhhvKaVQCy4ZQVmyCCKtfOu45L/HvpfS/1QY1oCFaF/I7jKonrJjG/ygY3iYBxiKg==
X-Received: by 2002:a2e:8891:0:b0:308:f84b:6b34 with SMTP id 38308e7fff4ca-30a80c41a74mr5593791fa.20.1740453543984;
        Mon, 24 Feb 2025 19:19:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f48e2sm971371fa.48.2025.02.24.19.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:19:02 -0800 (PST)
Date: Tue, 25 Feb 2025 05:19:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI: qcom-ep: add support for using the EP on
 SAR2130P and SM8450
Message-ID: <au4nvnszoqx6mof6aqejcbq2viosqfzb6pj3lf2t5nzogsywqf@u4rrx5kgulm6>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250222143657.GA3735810@rocinante>
 <20250224183620.GA2064156@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224183620.GA2064156@rocinante>

On Tue, Feb 25, 2025 at 03:36:20AM +0900, Krzysztof Wilczyński wrote:
> > > Update the incomplete SM8450 support and bring in SAR2130P support for
> > > the PCIe1 controller to be used in EP mode.
> > 
> > Applied to controller/qcom, thank you!
> 
> I updated the branch with "Reviewed-by" tags from Mani.

Thanks!

-- 
With best wishes
Dmitry

