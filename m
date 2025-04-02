Return-Path: <linux-pci+bounces-25192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891AA79350
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F4217173F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2492AEE9;
	Wed,  2 Apr 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WryUlco5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2A186287
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611676; cv=none; b=tN/UKbJXONaii+oG4loejdRJjtrTALAaFgy+EYBavZoVgxUUvYDEqhuxp22dLRyaYbEdRhMowVAcBcl2CmeiHxNNIwW6Ykmkkdu/mFvkLFlbBTFohwxXZJkrUwuWRes5MQsIqHNe1IRUjNEpzI0cPgSbRkUgJsJNsZTnrKhe2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611676; c=relaxed/simple;
	bh=94iAnc9Shr1KNMRlohviLeg6vbCIV52UqCqvGoY6Pz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccyZkiHzJjhUaUYl1/MUywUNK4wA4a4huAB9wM9BpIkBUJnfvqeGFGmANdpmpKehBhvJyuLP2dvpHUw1SlAbJW+rVbIVQplyBEAIc3iViVNvYPM72VJYuczY+UZd4/mbxh93MucguhCgoXiG7feY5mYZOyNYftLXJCgLUUJMQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WryUlco5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af548cb1f83so36940a12.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743611674; x=1744216474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eZdpy6Ml0Pui2AhkBW6h3RbvRJAyHYCFyqCZJKTd7F0=;
        b=WryUlco5klYSzHJfymsrOmYzaO6WCTJUOgVuVRr4yBbEyaF+Pbezy27dlOS8yfUxZX
         D2Z/I70x4+8tkPr3s6ueavbGmrgLD6VYDu4v8e79cIEpP6bE2wnsLuSH/fFDYLDA3I7F
         t4MK8io8nYaGbwfQbtKzwGyBrWO41/KEkNIRO90QWx2xEl3HsZ3up2Zon/rexd6RAXJk
         geuqbnHgqz7KFrcWRQsvAA/4YqmqpjJCBzmU5NGkZJhrTpXRZadzpck35bLLBBK4QG3K
         2CamkGp1LrC2uxwkYEZAkfoyOj01GVH3NsZVQY0lYa0yb6kwbjQeoTSoYT/6mEMGt9SA
         NnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611674; x=1744216474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZdpy6Ml0Pui2AhkBW6h3RbvRJAyHYCFyqCZJKTd7F0=;
        b=S93k0tuiY1kjcxNv3ljEGInbbl6WaqBo9TH1u0mmyBvXhiiEJ8nBKEPrrDSpsamSde
         o9oBICf839kZtAx6D0RJ/nbthhF1WkDJPw6weGpnhyS/wKmZLTvIQ6ZbNsvL6oGc6b5m
         Au4IiRYAhy57BQnhxF/j94/YdxZ2HWWZ4n7JrXJjfYG0iUSHdTtqQ1DJpYrOUvlm9SVT
         4iEDHnfqsbYp/Vs0mWCgfraofSihW7v3lPdIOR/+0co4Op/Jg5jfe+FBIRnjf3L8gKbu
         6zXVSzfbf0LKpdXYZ5S/ePAo8As7tABQHUgucDGqItUu6gs6AjJXcXgOs7s9h6NSlCQz
         ueVA==
X-Forwarded-Encrypted: i=1; AJvYcCWtQzZi9OvxvauIDi/bbdRIbbOpuasSPXflDwPnhPZFSiOFtpbw1CSpWOQ1UzMvSESsdOVw/8b9yps=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQWhI9Ze6rraPSmncyqRqXh9mpzx6S1uRmaMtivg3kPmx1Zuo
	TNKZJf+dJnSFXFaxDsTLHtEtkO02YWm4FCFGwi+gKoMVX7CsKaGTnVaagNQH5Q==
X-Gm-Gg: ASbGncsDLsK7upG2wKW9h/KKYjiYjnJe0TD9D6Obr/OOTcxymTCv1C/DVqQshH8WIF6
	RnodLtVfm8eaUdWEVPHzImXTXfjhEAH0cj7sH3lY2XROgIfNFSNtkQP7F7GFo56kyiy+X5do8Vn
	oWLhai8ffKiURstNrngqAmzaIM8UtRq8ne+Jg0dPMm2yAHqaiTD+whMH1pGzn71V6X5znkD9//6
	BDGOiggkDerBzQmBRCWN6NReZoTwcKZaxHt/Q5BM3bdeC+VB0/qx326jm2DVj1ogUVOZFW34Rg4
	LSUFnl87ybDO0VOJUxwywTJahG4AzO/5KV1BCGNMVSXTmPhB1pyD23wT
X-Google-Smtp-Source: AGHT+IE/CzlAT3gO9ai3KbEGAzW5CvaCu5880YJUcNp+BFAEgWNGWwwMz45bkA+8xVzcrlD0wVuvWw==
X-Received: by 2002:a05:6a20:6f8f:b0:1f5:8678:183d with SMTP id adf61e73a8af0-2009f608c2dmr28766038637.14.1743611674073;
        Wed, 02 Apr 2025 09:34:34 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b67e828sm10156208a12.4.2025.04.02.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 09:34:33 -0700 (PDT)
Date: Wed, 2 Apr 2025 22:04:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Set intx_capable in epc_features
Message-ID: <rkdzsql5vqk36wea5mvr34jz5t32jwleep7brigrgkuir3jlxy@qcbdb3pty7iq>
References: <20250402091628.4041790-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402091628.4041790-2-cassel@kernel.org>

On Wed, Apr 02, 2025 at 11:16:28AM +0200, Niklas Cassel wrote:
> While I do not have the technical reference manuals, the qcom-ep
> maintainer assures me that all compatibles support generating INTx IRQs.
> 

Yes, all Qcom EP controllers do support INTx.

> Thus, set intx_capable to true in epc_features.
> 

Hmm, this, I do not want to do atm. Qcom endpoints cannot raise INTx due to lack
of the driver support. So setting this flag would imply that the INTx is
functionally supported by the endpoint, but it is not.

Atleast, 'pci_epc_features' is not a devicetree configuration, that it has to
match what the hw supports instead of the driver support availability :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

