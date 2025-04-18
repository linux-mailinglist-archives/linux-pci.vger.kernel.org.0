Return-Path: <linux-pci+bounces-26241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB8FA93B94
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AA44758C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94EE215047;
	Fri, 18 Apr 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUxoVppg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1B215782
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995688; cv=none; b=CuuVE0daJG8UR324T2nvxvpsPLfng8i92YMNfGNw6qbN/Hi28PW460xnbWdvojINS+WW9SHVjIyGpY2q/URMxYPCsKxJ5v2nrU/Jm3mICV+3K6mfP+3RaE8P6NyyhwdsQS3M7BghZVDJ67j8XgZ4x0oyb53dyqCcVEPoJWs8e1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995688; c=relaxed/simple;
	bh=gO8UuUnEL0GdMWSU7mYBXHTLEBePuhrA4Yw2uBuWr2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmfEvAKHf3EwTxK683R3znXHbTp+8X06b2zatHlaVpjFTsnt101pNLxzLGyK2wAU4g8NWQkuP/T9CFzkqTCYWTvAGpLz9gWWU0Aeruec7gyyiyecqovXacZeEcx9ZYxGxnApxdIE1+aMohj5blxcy5Pn4/qVDErqklEWGmWENVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CUxoVppg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22622ddcc35so31826475ad.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744995686; x=1745600486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fs+FbSr25h62ESmDLvM+DIV5SDJW0JK2umLWA74NAL4=;
        b=CUxoVppgsjWzbqu5DK7X36o10BpcIOEQ9CefD+xSqrL1mmFplHOTNIoRGIKn0edttL
         563JYG5LMoMYQDOpf7HhhkMzQmBGs1kQDS6X8X3q2QhYj8ROaZlklKEJ4LnjPkzTd3Ht
         nBUSgV0v9MdeId3Rz8s3RgIQR3q1AudPUSOrT7ldZjnNB3Hb+baB3se11MJlO4K/lIHm
         Pr5HT8CEu7ROUS9xDkoYpL7SJ5/NS/9n8cKtgYnP9lj632IveqSGlxFDp5zoKxRSr6sN
         BwxkH2qJ6aFrOSstSSS1svkNYkkZZh0G3tPp9Qc5d9xBAOKE0WL+W7BQ/dlrnzc7dEGP
         ev1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995686; x=1745600486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs+FbSr25h62ESmDLvM+DIV5SDJW0JK2umLWA74NAL4=;
        b=NVK05V4BE025UgLUszf82Unlj5+ZErqc5MoNRYsMpiZas01xdvsbhVGi1mA4cosUK5
         9asFaczfKgIQVUJA1zEP2yGCDwJq1Gy00rUUX/vceQSLZSuuNhsRYeIerBmLeHH1s5xB
         5DuN3daXYLB0iyIyoMXOSaZ4au8mnwEASccWmt/4Q1dcO461Rb3iUBB0aYMf0BvKNqKo
         NkteP6+zafR+Cxbjs6fzj0iubitErwJvHQdsX7tRL7RExYg3/KRDBM9yNJ4Q9y9AXdP7
         s8Q6rbq8svYpyTyseiqqJwhcqdFqrrvG9bbwZK5BrXxBWZuUbc0x9wrGlm27E01SYvmm
         paLg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRI+6+xaV9s3QQbyV6gXsYlCLlhKQIMP+rCFqkD6B49hgrJbH1O505SSN4Uk4MX7Bo2DAJxh5qrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8oIZoMoX+VsjXKUAAeNrLcQT0rJogx5vF/o35MywFbUlfJKw
	ldl6L3k0D+L4j6q9guvDhNwOMCm0vNWYTp3HDw+SEL/X2oyF1jR2Yhsy2mWW0w==
X-Gm-Gg: ASbGncvwGs7sosbJddc2Cx7+/4zXE+ZPvhlOZPdbmmEQHD+WvQvMVI5f3X6nFoYi/qT
	/d2R1sJ1gafOLCLCF7ruxdiESV14OCg5WvN77jVIh1RWI2o40lCcuzeI9aWyQE53QnPQGOUQkHI
	VGnpO93NOx8PTpGn4E0UDKYShlLxHmlG8JTzNr9GWe9TQZtiC6jPUyzXgtXVamkqsRaHgb/ajNj
	TNfynT9GudCN0Giz++cy82udO9465+T+fsj/VbM3vEMbjVrXE+QUQY5hbfihg9+PPLvfYmm3qCq
	4thrKnCMm9KtAfpVg+lsW4+ZjN3oIK/sM6bQJj0P6fBi5sVjqaY=
X-Google-Smtp-Source: AGHT+IEnFAQ5ZdAVrVFVrdvYt5L9ZjZCuO9Da8Y6K9EjBgw5KyuHMkIHZ0L6Nkwt9mqFlQeiQfcWzQ==
X-Received: by 2002:a17:903:990:b0:223:f408:c3dc with SMTP id d9443c01a7336-22c5357a703mr52536975ad.9.1744995686287;
        Fri, 18 Apr 2025 10:01:26 -0700 (PDT)
Received: from thinkpad ([36.255.17.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb64fbsm19040645ad.158.2025.04.18.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:01:25 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:31:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, mrana@quicinc.com
Subject: Re: [PATCH] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
Message-ID: <gnpoekmyk4elg53xabcsvj6sqacttby6dpryxcdepws3fpt2xj@y7efnnszvpem>
References: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>
 <t7urbtpoy26muvqnvebdctm7545pllly44bymimy7wtazcd7gj@mofvna4v5sd3>
 <72e7ec4e-6a14-4a09-8498-42c2772da4fb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72e7ec4e-6a14-4a09-8498-42c2772da4fb@quicinc.com>

On Mon, Apr 14, 2025 at 04:45:26PM +0800, Qiang Yu wrote:
> 
> On 4/8/2025 1:51 AM, Manivannan Sadhasivam wrote:
> > On Thu, Dec 12, 2024 at 04:19:12PM +0800, Wenbin Yao (Consultant) wrote:
> > > PORT_LOGIC_LINK_WIDTH field of the PCIE_LINK_WIDTH_SPEED_CONTROL register
> > > indicates the number of lanes to check for exit from Electrical Idle in
> > > Polling.Active and L2.Idle. It is used to limit the effective link width to
> > > ignore broken or unused lanes that detect a receiver to prevent one or more
> > > bad Receivers or Transmitters from holding up a valid Link from being
> > > configured.
> > > 
> > > In a PCIe link that support muiltiple lanes, setting PORT_LOGIC_LINK_WIDTH
> > > to 1 will not affect the link width that is actually intended to be used.
> > Where in the spec it is defined?
> As per DWC registers data book, NUM_OF_LANES is referred to as the
> "Predetermined Number of Lanes" in section 4.2.6.2.1 of the PCI Express Base
> 3.0 Specification, revision 1.0.
> Section 4.2.6.2.1 explains the condtions need be satisfied for enter
> Poll.Configuration from Polling.Active.
> The original statement is
> 
> "Next state is Polling.Configuration after at least 1024 TS1 Ordered Sets
> were transmitted, and all Lanes that detected a Receiver during Detect
> receive eight consecutive training sequences (or
> their complement) satisfying any of the following conditions:
> ...
> Otherwise, after a 24 ms timeout the next state is:
> Polling.Configuration if
> ...
> (ii) At least a predetermined set of Lanes that detected a Receiver during
> Detect have detected an exit from Electrical Idle at least once since
> entering Polling.Active.
>     Note: _*This may prevent one or more bad Receivers or Transmitters from
> holding up a valid Link from being configured*_, and allow for additional
> training in Polling.Configuration. *_The exact set of predetermined Lanes is
> implementation specific_*. Note that up to the 1.1 specification this
> predetermined set was equal to the total set of Lanes that detected a
> Receiver.

Ok, this is the most relevant part of the spec. It says that atleast the
predetermined set of lanes that detected a receiver during Detect.Active state
should detect an exit from Electrical Idle at least once. So this condition can
only be false if one or more lanes are faulty (not unused or broken). If the
lanes are unused or broken, then they should not have detected the Receivers in
the Detect.Active state itself.

So this was the source of confusion.

>     Note: Any Lane that receives eight consecutive TS1 or TS2 Ordered Sets
> should have detected an exit from Electrical Idle at least once since
> entering Polling.Active."
> > 
> > > But setting it to a value other than 1 will lead to link training fail if
> > > one or more lanes are broken.
> > > 
> > Which means the link partner is not able to downsize the link during LTSSM?
> Yes, According to the theory metioned above, let's say in a 8 lanes PCIe
> link, if we set NUM_OF_LANES to 8, then all lanes that detect a Receiver
> during Detect need to receive eight consecutive training sequences,
> otherwise the LTSSM can not enter Poll.Configuration and linktraing will
> fail.

Correct. This information should be part of the patch description.

> > 
> > > Hence, always set PORT_LOGIC_LINK_WIDTH to 1 no matter how many lanes the
> > > port actually supports to make linking up more robust. Link can still be
> > > established with one lane at least if other lanes are broken.
> > > 
> > This looks like a specific endpoint/controller issue to me. Where exactly did
> > you see the issue?
> Althouh we met this issue on some Modem platforms where PCIe port works in
> EP mode. But this is not a specific endpoint/controller issue. This register
> will be set to 1 by default after reset in new QCOM platform. But upstream
> kernel will still program it to other value here.

Yeah, now it makes sense to me and I agree that there is no need to set it to
MLW lanes.

Please reword the patch description to change 'broken or unused lanes' to
'faulty lanes', add reference to relevant sections of the PCIe and DWC specs
and also add above mentioned paragraph.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

