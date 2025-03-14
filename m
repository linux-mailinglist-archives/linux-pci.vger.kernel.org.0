Return-Path: <linux-pci+bounces-23750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088FAA611B1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 13:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AF14620B8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1A1F4191;
	Fri, 14 Mar 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zholJ99n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6341FDA94
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956355; cv=none; b=r5X+YpQC/ovsgCy9EyEAQ8j7sjSRGG/zbfaOGc6Kce9pK4NQ/IsTMzNeq/ciA6DE0S6wbwXcrpdIV0SKaueKaiqaLbY7HBTxq5lK9hHUOqfqbB+HvMgjnjPiEPc3ixxzQPYD35ImjOU3lakWtyGq7sB68E4OO11QsHydZZ4lxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956355; c=relaxed/simple;
	bh=UQUXQqNabTghwJRQj4GAd3/DZZwmn8vCS3OQkI53bfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqStu2NtUjvq9WICF6SxerFQ4vQY2aMYV5CTrpRXheDCNNPkDjVPOx5r7m4db9TmFKHXXQkJrqfW8Dcvi6hCVYLmWIPzI5T2ubbNDy17UgxqaNod7B1BMAXN31lnXIwPFZyNZY7m3WzKIXjlMMDZE6RITfFvWQch90cGZZLx3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zholJ99n; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223959039f4so43148525ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741956353; x=1742561153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6J5eMIngEfEmeDpLgQnTm3LVrYur/owiIMRPRvll+O8=;
        b=zholJ99nx84c6oDmFDdUp0kvDI5zJryl5B0ZusBMoXngSY/lLmrKnlfoelcSjbauhm
         OKE4zXq1lZevLzoI4PfeRCx9EuhSbFTgn6cBzXDL60vgKovhavE/ar0r85b1PFw92ULx
         jm3buXIIcSL1aUd9tndwyBwXD2AnLWq+LMlb2SEt9kj9dHKCYOMXHsVDRs/PqgqxvfsF
         yXLVGINKFVv2lUredeReufBPmvlmUCRy3RSQMLkA3kreSoIijSNZehBy1UaKehYT1Xib
         ZAr1mlqH65gNktrIs6fE56tmTtoQAHX1/gWouJvESUw8xHjG5POKI+KxgW1v12WFf5a/
         RB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956353; x=1742561153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J5eMIngEfEmeDpLgQnTm3LVrYur/owiIMRPRvll+O8=;
        b=W8hOIC9aoRsMn+lSk0CSu7I5lvUxb9JS05sOCQ+dIubPRpyb5DEJeT3dliRpN//P/m
         1XByzFHJKSWjhvA8r3k+JI02T0Y+ZiyM59iUKEcQEXLdFLiAfp1o871CMmpgU3uz/zDO
         1OHajgVfH8AxTYbHZzc8xKLvt9tmyGgrJrlJkEIfaHjrwuP3Kh9UpPHGPqD/fi7cEsVN
         6WFLcsbyJP7TksSOlm4VamSK1C0bAoJNAuHkjxMpfUjzKxbJnJtuKHBJsYrzgW3EbhCR
         t5T3SZOzoBB8UmeI0w0Lfu2XUH7ksKMZ///xTeP3H6cMD9vwUk6Uz98ZYBtk90LJ85F1
         QuvA==
X-Forwarded-Encrypted: i=1; AJvYcCVGqygNL9NsXMUB9zTRxe8NQcrEus7q5+walMOjHEOY7EeH04/IuNCDY2XvdGKxy6LS5Zlw17EMjXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRwRI7VcBUQZlyvQrk3imBHeUQhRjoVfg92xOBZzcPOLFRcRb
	L/Ho5Vus7EqbphmWR4m95oyz/KE1/p2Y9a71uso+/nHwCzItMmnxwVaPakPslw==
X-Gm-Gg: ASbGncuw3MHRn47ZkvGJzPyUt1v5SCDaiHxEf2YXifo+GdYyaeVz9/LmJYRtrBKVQKp
	VD2r6HHBU4B36upWKxKLWXxQkHPNQo7IlfGYg61Il+e9pJaax7ABT1sLK1CzvbI+VbPhsDF5NRj
	vo5jpUzt3f5Ro4zbagGgY/JOT7vfd1NSQxzS36gtCwVId+1bo6oquKXhUvffeoeIAYbBmQOqbbk
	GtH6TkOgUt5MU1wkmLLwjrayQU4uayZzx/EdTipk/QYlQOdmeYP3e0Xm1NQIBpxw/igu1JiroRJ
	+mYKTRAV0pQym5YAy9g32Kw20Flzg0n/GLY5E4olDlZwqL8rtw00SPf6
X-Google-Smtp-Source: AGHT+IFMGESijNtlarw09KvBYSn+GIaNrM1DgNgo3a2C5soAeCT6Ww9C7j5knQXFF55TE1vIL/wG3A==
X-Received: by 2002:a05:6a00:2e85:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-73722352b77mr3006397b3a.6.1741956352748;
        Fri, 14 Mar 2025 05:45:52 -0700 (PDT)
Received: from thinkpad ([120.56.195.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371157369bsm2800970b3a.75.2025.03.14.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:45:52 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:15:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 7/7] misc: pci_endpoint_test: Add support for
 PCITEST_IRQ_TYPE_AUTO
Message-ID: <20250314124548.inffbk3c4kw22rwb@thinkpad>
References: <20250310111016.859445-9-cassel@kernel.org>
 <20250310111016.859445-16-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310111016.859445-16-cassel@kernel.org>

On Mon, Mar 10, 2025 at 12:10:24PM +0100, Niklas Cassel wrote:
> For PCITEST_MSI we really want to set PCITEST_SET_IRQTYPE explicitly
> to PCITEST_IRQ_TYPE_MSI, since we want to test if MSI works.
> 
> For PCITEST_MSIX we really want to set PCITEST_SET_IRQTYPE explicitly
> to PCITEST_IRQ_TYPE_MSIX, since we want to test if MSI works.
> 
> For PCITEST_LEGACY_IRQ we really want to set PCITEST_SET_IRQTYPE explicitly
> to PCITEST_IRQ_TYPE_INTX, since we want to test if INTx works.
> 
> However, for PCITEST_WRITE, PCITEST_READ, PCITEST_COPY, we really don't
> care which IRQ type that is used, we just want to use a IRQ type that is
> supported by the EPC.
> 
> The old behavior was to always use MSI for PCITEST_WRITE, PCITEST_READ,
> PCITEST_COPY, was to always set IRQ type to MSI before doing the actual
> test, however, there are EPC drivers that do not support MSI.
> 
> Add a new PCITEST_IRQ_TYPE_AUTO, that will use the CAPS register to see
> which IRQ types the endpoint supports, and use one of the supported IRQ
> types.
> 

If the intention is to let the test figure out the supported IRQ type, why can't
you move the logic to set the supported IRQ to
pci_endpoint_test_{copy/read/write} functions itself?

PCITEST_IRQ_TYPE_AUTO is not really an IRQ type. So adding it doesn't look right
to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

