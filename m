Return-Path: <linux-pci+bounces-22508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C10A473BC
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC417A37D5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042AA170A0B;
	Thu, 27 Feb 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvHVlJ3L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75A187332
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628145; cv=none; b=VJf2bSx+xbWosUIdtKwMtvXolqk7bw+MN/35DJUvqHQKWRhfbRmzkXBhZCdVAZD22Vg/WvVdmHKWKt2d1+E79RvaazvQYbeB+EkMfrYnXTbOHyN3wfivFGUe5nAfopetiWjwIMuuwdLWNnML6kHdx1bOyKQ/wrH6B6/tEiyNWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628145; c=relaxed/simple;
	bh=oi+m9gpixAFvi5EpPAxx46lrS+MPBn6RaE9ZtWVWGk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omLQA6nJLt3jneGHBESVMT3c7rMHwwjvXoqRZvEIqBijulvjdVqoDnQD6nilAokJ7kUn1n9tqgNzjSuybahTmyA+LxKHYIPPNaiJZrQx1c8Wjba+p1PGnZNiscSxypaJ7Ae63F1xYEdYLV7CpjFyoKoZHz7doi9LV/wGknsaCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SvHVlJ3L; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so1050122a91.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740628143; x=1741232943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fO7EiubiHLOGU2rtl1Xwvp+D0Vg5HuoflpxbDTrARsY=;
        b=SvHVlJ3Ly9dVJSOgV7LQnsnZ0xz/4RsVIdbRfTeKnV4EV8FgkJTJlxBoZlvnr6vVPc
         jBKtpqnaOTxv1C8idIq73c7Mj654uEbgSjnqL7cPAPF/f0W8llGI2G0y5ATlxgFgYZjf
         NK9hSmnzzlolk4N+1j7SW74o1Akzx7Sy/Vj8gTCnodCKMajfoyhwFMI4n8B8vd5HEiKm
         BPOJBzQt8AozMQu1ewueWKqQOP58K/+u+0upXbKzbiNiZs6WiNdPIQrR7fRgzonkk+Xg
         lYLjQ9QtRwihutPH9zIcIUynyPDK7qIAsANBT4bq1lSONlGqTAYYHKp1bmIp2uj9HhhE
         RqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740628143; x=1741232943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fO7EiubiHLOGU2rtl1Xwvp+D0Vg5HuoflpxbDTrARsY=;
        b=oN5InwQp3ozW8SLBwyueispyVLF7Sy3T/W/y4aajyGZdAe+y2M+JaE6xLTNH9c/rxW
         QFUQJAwNRodxYqR7rLbQv6xK1vLXf7qc36vi8NbAAxfQReOnd7q1Xdwvrl3ji19a7Pxw
         sqR482dObYVWjE0kcM6TXMrYoegzLEVP7Pu3XhUp5g3TemPuhOexrAwdOsbN+jKA2xVr
         fEznQQf8wvxipraoNeBvZPhrVTXejTLJEn3i1pugILe53kA5VW6NwETXCSE4rt0HdLH6
         OXeWRqptOMjvaWxQpj7ONQyEhtq08qlb7xBThDGMCZShyKivq/LmDI1U7NAi2rfRawpg
         yyYg==
X-Forwarded-Encrypted: i=1; AJvYcCUvukIM5bWeJuwV14TClSq/9wO5hiwMhMkrb57EqMnpA4H2OejweULz9FFAWk31y3pW1f7DCG+YxLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBpbF3qEvNbHkTR0wckzQKaf2kg/dSH4QaWpBYYxJFM+mbX4w
	6AAL1lmvtoHZzaXXjjCdstdHy+S9yKNGyWbzNjyalo3nyDKzL+k2wp+Wc7AyeA==
X-Gm-Gg: ASbGncv18i8yEUs5OiR9Mmotixz4rz4pk30yMTF7S6POZQrGwbd+PtY5ma/pL+z/bxh
	8/s1AG27Mmiq0aasBAUb3ipW/NTysBKtETIHgAOIokklZv4PLRVOqGdmdYCURDEbQqERqInKf8I
	PEsrGfKME6r+L0VAekVpEB306WjjSQH49LTB+yKbTxpOTBRMNDMNhfwCjmQR5PZJFdIazkpE5Vu
	t8ICVq+oawPAodUqFMAi32ymNi7aTJqLQHqmmwnay6RkrhpS567HjJHGw+D1iw5tQCU+qML22vQ
	owUKhE3S2DP/oFxonONJLPHrKe9eHDh71Qmh
X-Google-Smtp-Source: AGHT+IEcysD2mq0oTW6yavadIZ+Dy03Ac/OJWfv0J/mF/FDiTNU3vFb7Q5X25mkxRJS7teNSdDqlAg==
X-Received: by 2002:a05:6a20:2d09:b0:1ee:e2ac:516d with SMTP id adf61e73a8af0-1eef5560808mr44946908637.30.1740628143509;
        Wed, 26 Feb 2025 19:49:03 -0800 (PST)
Received: from thinkpad ([120.60.51.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1a4ebsm278779a12.23.2025.02.26.19.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 19:49:03 -0800 (PST)
Date: Thu, 27 Feb 2025 09:18:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, dmitry.baryshkov@linaro.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 09/10] dt-bindings: PCI: qcom,pcie-sc7280: Add
 'global' interrupt
Message-ID: <20250227034855.orrwu32mlnn5mjfk@thinkpad>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-9-e08633a7bdf8@oss.qualcomm.com>
 <20250226-enlightened-chachalaca-of-artistry-2de5ea@krzk-bin>
 <t34rurxh5cb7hwzvt6ps3fgw4kh4ddwcieukskxxz5mo3pegst@jkapxm6izq7p>
 <e83bc594-5500-4f76-b3d1-96f669515c24@kernel.org>
 <dd16f56b-f066-44b7-b5ff-baf608e0f87e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd16f56b-f066-44b7-b5ff-baf608e0f87e@oss.qualcomm.com>

On Thu, Feb 27, 2025 at 09:09:38AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/27/2025 3:03 AM, Krzysztof Kozlowski wrote:
> > On 26/02/2025 17:29, Bjorn Andersson wrote:
> > > > > @@ -54,7 +54,7 @@ properties:
> > > > >     interrupts:
> > > > >       minItems: 8
> > > > > -    maxItems: 8
> > > > > +    maxItems: 9
> > > > >     interrupt-names:
> > > > >       items:
> > > > > @@ -66,6 +66,7 @@ properties:
> > > > >         - const: msi5
> > > > >         - const: msi6
> > > > >         - const: msi7
> > > > > +      - const: global
> > > > 
> > > > Either context is missing or these are not synced with interrupts.
> > > > 
> > > 
> > > I think the patch context ("properties") is confusing here, but it looks
> > > to me that these are in sync: interrupts is defined to have 8 items, and
> > > interrupt-names is a list of msi0 through msi7.
> > 
> > interrupt-names has minItems 9 in this case, so they are not synced.
> > That's my concern
> > 
> Ok I will update the minItems to 9 as suggested.
> 

You got it backwards. interrupt-names should have minItems as 8. Otherwise, old
DTS will break.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

