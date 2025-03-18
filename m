Return-Path: <linux-pci+bounces-24021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B5A66F23
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32C0166F8F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D61FF7DD;
	Tue, 18 Mar 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlHHTXpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56921A3029
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288224; cv=none; b=ndRwSOmomnwXw9Aa+3dBaFskSdyVHNn1pXvzulVNY7jxoYbrPVHBBD7Xx05OmHkl3RV3wu52UtzScYZYCbz+1WnqqpMat49XjtpTeJXlck7HChCNRl23L0Yck1/q4rX2uqNRAEH3CZI4rmHT6bOVAkCddkdhI9VqEjGQtjTHkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288224; c=relaxed/simple;
	bh=yzqoSdtacP331IPFDR48SRPeulAEZloGWFrs2N0Nca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCcqW/3WTMayzpRTyAwsFLrVUd+pC1LLIWOndMZAV+JHISHh2qC1KQbrk07d9tMehqGrv3l5Udteng3PJPJ90knD4hAr+HSCXPkJgmRG07l/9xtNH4rOxQCZ7Dqqgwd7rLqk/VyKKE1ysTPg4su83C1vl471D5gaOIqFq668EFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KlHHTXpU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240b4de12bso1598625ad.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742288221; x=1742893021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bc6OtCE5QlxdkVOulGE84hlPoI8tM5EiNpw6KSAX/w8=;
        b=KlHHTXpUTNAs7ck9bAGinmc1jXPA+nVYR5o22oiRS5PSf6HVb+yNdxrE8cRWNyWeOV
         CetTke0hP7JSrWW8Sol1Nisqic9k4kwu7nZ7fweiEH9ACqAbeHU/xB3Yo9jHLLJGK9UL
         9AQfCVjWjxq56SXOUGHz6vg3564QdsjqUellF8HuWtort9nv8xSPyLwcW2f2LMB252KE
         8LfNd2wk+2Eyixhu0gtd8w5s0f5ILimNeLiZb1kbLgHK7c6aCgaQebumAC5b3ZARLXwE
         7onZKhMwtuWlrhM9uPTmw+KRmOHMwiqgk/SUi+JXFw/1m5Pk48obBTOppN75EP6Hl+Nd
         dJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742288221; x=1742893021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc6OtCE5QlxdkVOulGE84hlPoI8tM5EiNpw6KSAX/w8=;
        b=xA2s0yr+xdD3Xb56ER5lJxaD6Jd6ZR1TmOTHcXGpvFkHFJFMQwFNc/IwfqYJtcQjUK
         Tke31WVQ7e7tlva6urIfq7q0arDVQIRaqWj4BS93F+aIpAs5wBbbIHE+LnIUq90Rps79
         DqDxJsq5lBttppYa44uhi12lglEkTXBVg7xpMxnGippplov2frEXKoIZ9CYLufDYLus4
         h4/Zh3bVTkB/2JxFV80LTkn7xg8Hl329Ww4aMUcz4Fd7eG0IV7SMVVclwVyXZXVC02QE
         4bP6SR6LZNKp0VZm39PziClR3NSbvPhTNTJEoQMW7L5F1NdUuePHqwzZPBWcewjKHQy3
         e2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8w1GNUJUZVNIIiuxsnAMxX87fHAAvA+elsugRa1pyTGIbTjXMOJFuRWACgLn8qriwhSs/EcTKf8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2wV4g8HTjCJvCgZg+mF7apLMI/geLHqpCP/jbpFwYy5Y+0kQ
	ErEMHS53jHZUAZKbO/8SP1BOKWrKvsjeyjEKlZrBguQ8uPyA+wrCXjZDAuAqxA==
X-Gm-Gg: ASbGncspjK33gOU1B4vs6yWP7KMlvym6HpZO+Ub65Oe0U7gDjoIauCfWBwPEdQt+H7b
	CLQSDY+reFhPtN86B0mUm0RP6Hg05Ms98LgVINQ+BxpqPm9JD8aIbwbjWmiA7ffMghCMePqH3LH
	MYRrj98IaoqT21ZJOgw/i2eLfjMGMpg7hrk+V4qCY6u6QzlDqcpGuaEL8z5f9Wv9ccI90Mo10Wq
	Zp50q44f6jiVCbyZkFCVEYf//ax+c/jtICwdsXsXC4W5gkNyse9tHPEWVpvEX8OE7414MMIqk+s
	x6F+/0iqQ3sguJ+OGm1gKrBc6wHIDqhgFV0T3tqekQhE0GyRcjSnOVaF
X-Google-Smtp-Source: AGHT+IEBVc7HukU3vn7fwAiS73I4sFRXvRCdPyRE7AWe/JfbsKu5fchm92tZxynyTXwGgvVLuJxw/Q==
X-Received: by 2002:a05:6a00:4f82:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-737223b9711mr18737446b3a.14.1742288221020;
        Tue, 18 Mar 2025 01:57:01 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167db05sm9329571b3a.92.2025.03.18.01.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:57:00 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:26:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 7/7] misc: pci_endpoint_test: Add support for
 PCITEST_IRQ_TYPE_AUTO
Message-ID: <20250318085656.q4aohbdvidhzn6af@thinkpad>
References: <20250310111016.859445-9-cassel@kernel.org>
 <20250310111016.859445-16-cassel@kernel.org>
 <20250314124548.inffbk3c4kw22rwb@thinkpad>
 <Z9Rmoh_vtrXzFG0X@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9Rmoh_vtrXzFG0X@ryzen>

On Fri, Mar 14, 2025 at 06:25:54PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Fri, Mar 14, 2025 at 06:15:48PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 10, 2025 at 12:10:24PM +0100, Niklas Cassel wrote:
> > > For PCITEST_MSI we really want to set PCITEST_SET_IRQTYPE explicitly
> > > to PCITEST_IRQ_TYPE_MSI, since we want to test if MSI works.
> > > 
> > > For PCITEST_MSIX we really want to set PCITEST_SET_IRQTYPE explicitly
> > > to PCITEST_IRQ_TYPE_MSIX, since we want to test if MSI works.
> > > 
> > > For PCITEST_LEGACY_IRQ we really want to set PCITEST_SET_IRQTYPE explicitly
> > > to PCITEST_IRQ_TYPE_INTX, since we want to test if INTx works.
> > > 
> > > However, for PCITEST_WRITE, PCITEST_READ, PCITEST_COPY, we really don't
> > > care which IRQ type that is used, we just want to use a IRQ type that is
> > > supported by the EPC.
> > > 
> > > The old behavior was to always use MSI for PCITEST_WRITE, PCITEST_READ,
> > > PCITEST_COPY, was to always set IRQ type to MSI before doing the actual
> > > test, however, there are EPC drivers that do not support MSI.
> > > 
> > > Add a new PCITEST_IRQ_TYPE_AUTO, that will use the CAPS register to see
> > > which IRQ types the endpoint supports, and use one of the supported IRQ
> > > types.
> > > 
> > 
> > If the intention is to let the test figure out the supported IRQ type, why can't
> > you move the logic to set the supported IRQ to
> > pci_endpoint_test_{copy/read/write} functions itself?
> 
> If you look at how things were before your commit 392188bb0f6e ("selftests:
> pci_endpoint: Migrate to Kselftest framework"):
> 
> echo "Read Tests"
> echo
> 
> pcitest -i 1
> 
> pcitest -r -s 1
> pcitest -r -s 1024
> pcitest -r -s 1025
> pcitest -r -s 1024000
> pcitest -r -s 1024001
> echo
> 
> echo "Write Tests"
> echo
> 
> pcitest -w -s 1
> pcitest -w -s 1024
> pcitest -w -s 1025
> pcitest -w -s 1024000
> pcitest -w -s 1024001
> echo
> 
> echo "Copy Tests"
> echo
> 
> pcitest -c -s 1
> pcitest -c -s 1024
> pcitest -c -s 1025
> pcitest -c -s 1024000
> pcitest -c -s 1024001
> 
> 
> All three test cases were using MSI.
> 
> 
> However, there was no error handling, so for a platform only supporting
> MSI-X, the call to "pcitest -i 1" could fail, and the tests were still
> going to use MSI-X (or whatever supported by the platform), and pass.
> 
> 
> 
> After your commit 392188bb0f6e ("selftests: pci_endpoint: Migrate to
> Kselftest framework"):
> 
> 
> TEST_F(pci_ep_data_transfer, READ_TEST)
> {
> 	struct pci_endpoint_test_xfer_param param = {};
> 	int ret, i;
> 
> 	if (variant->use_dma)
> 		param.flags = PCITEST_FLAGS_USE_DMA;
> 
> 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
> 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
> 
> 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
> 		param.size = test_size[i];
> 		pci_ep_ioctl(PCITEST_READ, &param);
> 		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
> 					 test_size[i]);
> 	}
> }
> 
> TEST_F(pci_ep_data_transfer, WRITE_TEST)
> {
> 	struct pci_endpoint_test_xfer_param param = {};
> 	int ret, i;
> 
> 	if (variant->use_dma)
> 		param.flags = PCITEST_FLAGS_USE_DMA;
> 
> 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
> 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
> 
> 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
> 		param.size = test_size[i];
> 		pci_ep_ioctl(PCITEST_WRITE, &param);
> 		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
> 					 test_size[i]);
> 	}
> }
> 
> TEST_F(pci_ep_data_transfer, COPY_TEST)
> {
> 	struct pci_endpoint_test_xfer_param param = {};
> 	int ret, i;
> 
> 	if (variant->use_dma)
> 		param.flags = PCITEST_FLAGS_USE_DMA;
> 
> 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
> 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
> 
> 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
> 		param.size = test_size[i];
> 		pci_ep_ioctl(PCITEST_COPY, &param);
> 		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
> 					 test_size[i]);
> 	}
> }
> 
> 
> Each test case explicitly calls ioctl(PCITEST_SET_IRQTYPE, 1); to use MSI,
> and unlike before, will fail the test case if PCITEST_SET_IRQTYPE fails.
> 

Thanks for spotting the breakage!

> 
> Then take Kunihiko commit 9240c27c3fdd ("misc: pci_endpoint_test: Remove
> global 'irq_type' and 'no_msi'")
> 
> Before your and Kunihiko commits, a platform that did set the kernel module
> parameter 'irq_type' would, if 'pcitest -i 1' failed,  use the value set by
> that kernel module parameter for the read/write/copy test cases.
> 
> There is no guarantee that an EPC supports MSI, it might support only legacy
> and INTx, so I was trying to restore use cases that were previously working.
> 
> 
> 
> I guess one option would be to remove the
> "pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);" calls from the test cases that you
> added, and then let the test cases themselves set the proper irq_type in
> the BAR register. But, wouldn't that be an API change? READ/WRITE/COPY
> test ioctls have always respected the (a successful) PCITEST_SET_IRQTYPE,
> now all of a sudden, they shouldn't?
> 

This makes no difference IMO. The previous behavior which you explained above,
ignored the result of 'pcitest -i 1'. And it was not user configurable. I think
the original intention was to use MSI for tests if available, else use whatever
the platform supports.

If you want to restore the original behavior, you should remove the ASSERT_EQ()
from READ/WRITE/COPY tests first. Then to ensure that the tests make use of the
supported IRQ type, you can have the logic in the READ/WRITE/COPY tests itself.
If test->irq_type != PCITEST_IRQ_TYPE_UNDEFINED, then just use whatever the
test->irq_type is. Otherwise, use whatever the platform supports.

I don't see a necessity to add a new IRQ_TYPE and then getting it passed to the
host, if the host can figure out the IRQ_TYPE on its own.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

