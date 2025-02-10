Return-Path: <linux-pci+bounces-21052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EA7A2E5E0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E3B3A4A86
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1121B6CE0;
	Mon, 10 Feb 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzI7IWnK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F72F2A
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174301; cv=none; b=uJBewqPCnvAzVS9eYaV2y7azIGNk+THOpLjT1S/Qnr6mRzEDIK2abqKq5BsY+cPodGhdijFUqJzlC8YAyuS/2xphshXaofTERfeOrh+KM4I1sMTwkpX10ozgtAVWQhnriw6YrSNI4wZSJT5wqdDBkZilig0+IWcQYeZaIRg67aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174301; c=relaxed/simple;
	bh=gnGDbLYY9S99/MhM+tP6MsY0Pol/FvitZFE5mLzuAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQLvlMwhHAGKtYFGogW922zCvKtZdTPhF/3xNz46TXZQ/CI2slwYO9RFGBtFYM2ARXaECgG8lINPYhJL9yKNJYE/cmZ4Kg0ki4OGbw42EBbp+AM11NSOy7xuIaS4hyhxK19vRx0YHlyVaaj2PA07Bm0JdYqQdt/wE3ex9RRs5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzI7IWnK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa2eb7eb45so3599103a91.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Feb 2025 23:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739174299; x=1739779099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75IagIKAPrMoDpUuDxO6PwlHpck9jQTlHEYVQHHHKGw=;
        b=DzI7IWnKR7LmzPw10sY/3nsLAywHHI+xxIVgH1JcoKf4yhURkR6+s26V1bK0GcoJJe
         FvGRP3UBRfJ2mDcPlzc7WVG0/qmnmEk2lK3QClTYdHKQWaEqksuBUlDYi/iZS/jCQZQa
         09WUxIlDiUvOi0Z9cCHmwi211GUYIX0qpMMJ1azEX3/BjzpodMVkAANFHdasQEkR5Q20
         3CO6vBhn3CsUF3iEtY7Ngzy7ZZKgjxbZLtX3JnmTDBcHm5BvZjeL5KYZhXknqjcDlUHu
         ZZfHrS1gdcRALaZ498GMo+DvNbWRjt1VHh4unxJqmqClGcE+qkWjdzNGSqWHpGAIgH/w
         CVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739174299; x=1739779099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75IagIKAPrMoDpUuDxO6PwlHpck9jQTlHEYVQHHHKGw=;
        b=fqrh2FzTgdM/3+WcQ0t5BArQLW5TsjH0OuNGTCuFq7ZWAfSwjNgf61AOZV71KzF5M4
         yemHjttysqdaX7C2MaeNKnapdou5/cn73kPZ/aGNxfBlxqvpQje3wmnVk8f/1RrIUh9t
         9ayiZsEvlo1yl8+AvtF9wL+/f1fsfiZdrXwKhQvI+6jQM6yFJ8u3yVhfEKfT4mnrGSjy
         4hYhWjFgDHP3ZPTF+iwvE7brEvryAK+lF8+XHsn8IqNljxw6mvbbOQfF3MbaGwZYUbBl
         pwccfsEZzbENXtDF+CJvGKeZzpiEVYrTLRWFbqun1yVOwmBqFGGuN7ZCkldXXw+U1xj0
         1LBg==
X-Forwarded-Encrypted: i=1; AJvYcCXB+of73wVQ0zY6UG8o3NQPKqsUlHmpJZFMhPQm852GFjWeBNQ5ZdR78Rk76zgA5mI6qn7lIl7BdGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjQlEhJDkZtUmT4kMZMYzRj/RF+WMXv+ZtCGDUxdDs0pKKFC6C
	gfofhHqe/JeQQDZ3yq6lTju7WH8nULVB6ZuwajAHG61MXFcPrzD9o+Aw8LFukA==
X-Gm-Gg: ASbGnctUus2p1+4O7YvXarU3hcwAG71j8+HAUj6vsXa3nXLgMfAYK435hpvt7vejxvH
	DPP24abd/5118AYU53WXKS8H/LrVDnFi/RQA3/+AmBamTcNRzn4ZXnzjEr9yM2B1kknLIH/K/6g
	XOK6XClKpAdr7N2cVTE2gQ8TkBb4sU9pfHxPerTdYExiU62HfkCZn+UQWq8NoyBbvtyT9K675UM
	g/dPcqa3rFO35DOHJlfuK6G2AaAI8dUlE5o76yZYLZ3YbLoxVOOSpxeFFGT6KsWlFrQtxw0dSjD
	VOgsVzY1jkURWSYgPqnqT/U8onc1
X-Google-Smtp-Source: AGHT+IFXCqnihRnQEqbNo6scGWyOrBRT8N9zvJv00jiqKl9tKNAjF7bOCkjzidfq+LpykV9q3SQh6A==
X-Received: by 2002:a17:90b:1946:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-2fa247f9fcdmr20291441a91.2.1739174299431;
        Sun, 09 Feb 2025 23:58:19 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683eb02sm71082845ad.153.2025.02.09.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:58:19 -0800 (PST)
Date: Mon, 10 Feb 2025 13:28:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, andersson@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Message-ID: <20250210075813.c2wvr3bozndi2ice@thinkpad>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>
 <20241230182201.4nem2dvg4lg5vdjv@thinkpad>
 <d4019981-1df2-0946-d093-7dc97c2d0ffe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4019981-1df2-0946-d093-7dc97c2d0ffe@quicinc.com>

On Tue, Jan 07, 2025 at 07:58:17PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/30/2024 11:52 PM, Manivannan Sadhasivam wrote:
> > On Mon, Dec 23, 2024 at 08:57:37PM +0200, Dmitry Baryshkov wrote:
> > 
> > [...]
> > 
> > > > This switch allows us to configure both upstream, downstream ports and
> > > > also embedded Ethernet port which is internal to the switch. These
> > > > properties are applicable for all of those.
> > > > > > +
> > > > > > +    allOf:
> > > > > > +      - $ref: /schemas/pci/pci-bus.yaml#
> > > > > 
> > > > > pci-pci-bridge.yaml is more specific and closer to what this device is.
> > > > > 
> > > > I tried this now, I was getting warning saying the compatible
> > > > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > > > pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching the
> > > > given schema
> > > >          from schema $id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> > > > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > > > pcie@0,0: Unevaluated properties are not allowed ('#address-cells',
> > > > '#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)
> > > > 
> > > > I think pci-pci-bridge is expecting the compatible string in this format
> > > > only "pciclass,0604".
> > > 
> > > I think the pci-pci-bridge schema requires to have "pciclass,0604" among
> > > other compatibles. So you should be able to do something like:
> > > 
> > > compatible = "pci1179,0623", "pciclass,0604";
> > > 
> > 
> > Even though a PCIe switch is supposed to be a network of PCI bridges, using
> > PCI bridge fallback for this switch is not technically correct IMO. Mostly
> > because, this switch requires other configurations which are not applicable to
> > PCI bridges. So the drivers matching against the bridge compatible won't be able
> > to use this switch.
> > 
> > - Mani
> Rob,
> 
> Using pci-pci-bridge expects to use compatible as pciclass,0604, we
> can't  use as this switch is doing other configurations which are
> applicable to PCI bridges. can we continue to use pci-bus.yaml.
> 

Let's put it the other way. What are the blockers in using the
pci-pci-bridge.yaml other than the fallback compatible? If the compatible is the
only blocker, you can add it even though the drivers cannot make use of it
(that's one of the reason why I was against adding it).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

