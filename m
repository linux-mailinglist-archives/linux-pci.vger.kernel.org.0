Return-Path: <linux-pci+bounces-21494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42808A3648F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5563F3B0AA1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055E267F4A;
	Fri, 14 Feb 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onAIE9yE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A1267AEB
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554057; cv=none; b=bSEvOQdW640XUCRjGe1LQL+M0AiZTCcitd/jE3tmGyrggHHyEoVJXuJ4Ax4yFxgLMfGqWHwAdv4+19xCFQ9BC6gVDIT3LS1Kbl/YTzIN5yvCCeHvX3JeIwaWomjcTCkF1u+2ehb6TbXgYCXApPY/6p7FpseEk1MS2WT/N91zn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554057; c=relaxed/simple;
	bh=cQ8t+tOviT72vLT9F0rQyeend8uSfiR5OEb4vEMwexQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+9DOIr9olBG/yo/D5BD37qB/gHuFeWJJWtQXiti1EUpRWcRScGy6ME87bUCXYZ4riGE59e1AD3xiSEZoH2PQ75XSB47BSbrS9ITyDdC0ftGRURRZl9KIWce6s3ajOgT4jfxP+iftwkJ5+sokJHgSPtP2DpSCJ1yIXHAVJ4MNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onAIE9yE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d398bea9so33533465ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554055; x=1740158855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1GpDHw6J3mUy22yUtyZke9IY17leDB0BRZkF2rjC414=;
        b=onAIE9yE6uN3/TFAN6M8rpGQDzZBx7WgCgIeFWCQt1kQcOS/cuIy7HKjIh7s0cUHoa
         FmmBIbuuO2x6087+i7yY7NnfDspDBt4VRnhEcQDqKko0bnBkoqkIGAZWhO4Pr2GRL5RR
         AZseXc5YwW/U0UKAOQnAJbpox7/0NbgLZyp+F1eg0H3bNNlrwKd5tSUfHvLgnFWT8xnP
         gNabYDiZcaWUVm1E50bYbimhE1aPmDRrqDT+NyA0S1cYKYQwvmeP+n/mfx0SHk4Kes2k
         ibiLy5AiconCr+gwfSGNr+0jll7qvCao8vTT6YW0z5ohLz4AVE8ZCZ3oWmbWFpRCc3hu
         qXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554055; x=1740158855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GpDHw6J3mUy22yUtyZke9IY17leDB0BRZkF2rjC414=;
        b=cNHkkHTiLFQxwuNIehrg5pEF5g93l/a6iEZDVGGhxS2zzB0rddUxOI6X/qe6ez6swJ
         Z347OBLUh7SFGox7/acEhZkXW6hKb9ZbGd/+oJCbGv8yXPGHN6IRgNJrdAP4VuExD2pB
         sUut8sjflh5ppR30E0RGCpjftceFjqLMybV0ymj8TfFH8L1KZEyvn69ablppPb6BNbq4
         icQOFTfds3nYFePL6sdXTJzS33JFVMeMAVe5ANFm3+RiqIZNuF8ZbeVUi8jpSVoZkq3P
         l4Rsu6zd3arzNokrG9vyGvayxOhGCcv0xdAJLwES3eb2msD35BhoPAsqI3LuiRJ1J1iT
         1ZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4t7SvsTgp2J/1KFMGxHTaMSzltf3LPE31z62OeMCt/2lSEkm6UybWoKI9Wbd9u254Ub1Q1n2Sgo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mX4Bm+ugwSQZPGuxL3Ln9WbUkq7lBiIoyRzE2iXfydDZ/DBZ
	iss3rznJcDdmvh5KKBlXpCy5TuILNaOkzQBJy5vTDnm7LoXSuslaezrIQjjIrw==
X-Gm-Gg: ASbGncuCP9WzqZZC9/TzD2DLGnwOc4kvuqZ7S0JZTnm5qX7BvblythD0fVkbbVjpUMR
	x+t/h0k7OO5fVPW3+eOvA6/+J8wlQ4nSHFZ/uPb4jIAmY91Sa8TouSBmh3uZtFXysBZZu1UY6K3
	bjceoSop90Q39gBoNFjl+TolH3hBP3qI0an0VQOyFEmqr4R378TbUagMGbY2DkbRRWa5KTJOHY0
	8eF9fHxeDlcew8IM6nDC24iC1oQho6rev1FXmfi/JTe75ya9mJODTk6FWuEeEEoAtEva/4YEa3L
	CCRGYbmymwnvwYjBxaZCLcOhTes=
X-Google-Smtp-Source: AGHT+IG0qxpZdABP9Ny/lA/qYPEQ22sP8szSsdMW0s5lNGbuvWIfvFPxqar16iAicbQzxIjTZOBiRg==
X-Received: by 2002:a05:6a00:92a8:b0:730:9424:ea3e with SMTP id d2e1a72fcca58-732617bfaadmr275238b3a.11.1739554055056;
        Fri, 14 Feb 2025 09:27:35 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e2dbsm3492000b3a.98.2025.02.14.09.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:27:34 -0800 (PST)
Date: Fri, 14 Feb 2025 22:57:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] misc: pci_endpoint_test: Remove global irq_type
Message-ID: <20250214172730.7xzxlmrhrznxpkw5@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-5-hayashi.kunihiko@socionext.com>
 <Z6opssGJ91MVWgRC@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6opssGJ91MVWgRC@ryzen>

On Mon, Feb 10, 2025 at 05:30:42PM +0100, Niklas Cassel wrote:
> On Mon, Feb 10, 2025 at 04:58:11PM +0900, Kunihiko Hayashi wrote:
> > The global variable "irq_type" preserves the current value of
> > ioctl(GET_IRQTYPE), however, it's enough to use test->irq_type.
> > Remove the variable, and replace with test->irq_type.
> 
> I think the commit message is missing the biggest point.
> 
> ioctl(SET_IRQTYPE) sets test->irq_type.
> PCITEST_WRITE/PCITEST_READ/PCITEST_COPY all use test->irq_type when
> writing the PCI_ENDPOINT_TEST_IRQ_TYPE register in test_reg_bar.
> 
> The endpoint function driver (pci-epf-test) will look at
> PCI_ENDPOINT_TEST_IRQ_TYPE register in test_reg_bar when determining
> which type of IRQ it should raise.
> 
> This means that the kernel module parameter is basically useless,
> since it is unused if anyone has called ioctl(SET_IRQTYPE).
> 
> Both the old pcitest.sh and the new pci_endpoint_test kselftest call
> ioctl(SET_IRQTYPE), so in practice the irq_type kernel module parameter
> is dead code.
> 

+1

> 
> > 
> > The ioctl(GET_IRQTYPE) returns an error if test->irq_type has
> > IRQ_TYPE_UNDEFINED.
> > 
> > Suggested-by: Niklas Cassel <cassel@kernel.org>
> > Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 6a0972e7674f..8d98cd18634d 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -100,10 +100,6 @@ static bool no_msi;
> >  module_param(no_msi, bool, 0444);
> >  MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
> 
> Considering that you are removing the irq_type kernel module parameter,
> it doesn't make sense to keep the no_msi kernel module parameter IMO.
> 
> The exact same argument for why we are removing irq_type, can be made for
> no_msi.
> 

Right.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

