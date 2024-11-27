Return-Path: <linux-pci+bounces-17388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB28C9DA240
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A38B167E85
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD45148310;
	Wed, 27 Nov 2024 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLyBYW2G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B24145FE4
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688421; cv=none; b=PmtJ0i4hla2BjazjtgEc4JyoewaHuQcFi/uAmdPhjxJPkDfa39cPTd2xpEmt0uPq4fLiOgrqhuI048AcTmDiIK5zDwTH4DmeZcwjowuS2IF71Qpe/arnWndWoNohUNI7q5U/vF3bSfVgeKMOdWd4d+tbMRSdtKFs3nvRmKCvJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688421; c=relaxed/simple;
	bh=w/D8fsQPcNEG6MIfpMgWgqvfnTdWrpFGSFDTBCPsVec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRutfhFxK7ZA+CzRUtBI0hoPkx0zeD9d5Y3TQQd34mwujNXaxS+9Zf1nI17LhfgKx9GikKnds4c4tkBzc//Fwx38JvptFNSSnrFHrQ5kj4xZ00XyLqI2X9hUzqKu+MLdHbcmLmJ1EIkKAudDnjXaHBoqYIgByhUXR6v+Je82ZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLyBYW2G; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724f41d550cso2539773b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 22:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732688419; x=1733293219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLuEvPFQ6kcM1n0FkkyOUV7NsMkiebhxF8YqLhaowtw=;
        b=wLyBYW2G4b2TFiIupMHb9I6+Xpi6Qo+9/uJGTc8WqwzStwhiacQP7Q0mVcO9AtdkDa
         SiQWOLCSLpyu7AGwTrBG+wQMC3Y9AMeMEycywTZENgfHa6HCgwmZWQzLEZ0qQVcv8AR/
         hIO+mmF8L9f6RLFwsmxnOCFrQDcreI2IE80lzrhEtLFgOHouYPym38kXxnoiKHSTFCPc
         TbdA1HNH9/OyloqrQgSSN4OOH5JiOsDETVvTjWdHNj5aRL68m72RwSvYbsRyjjU2oOON
         mhbnQ0CYUUpmXaIQkcUBKOcyOOvMeu66npOAY04QRx5/nXJ+HCmHPeIFYsg6CALrpjkF
         q1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732688419; x=1733293219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLuEvPFQ6kcM1n0FkkyOUV7NsMkiebhxF8YqLhaowtw=;
        b=wBdsO7L9pFmxAcK3Feubqqz1zZWwkxb10JPOSweKTNHUfnb+cytHcU2QsoGyXipe96
         yf3lwpULO/uilnbeIbl4OohFEXq5LAaSG+wJvudMtjVg+NOuwe1M2l6RNmLnXhG/qp1+
         G3oEWsm2GhqC2EKe1hw2LVsbsp6ahuz4D0qgLnc6UvO/gyp/zcsDWOVvJhbXAPpBORa7
         9iVL1ufRQdtwoZfron4pOq7Hba+ZFe/aGLz8nGyatVcSkz4lkFZ5UTl2ScA7/X50IbfW
         dIQyZyaBYZfZMD//vnAg7Wx4+mF60OB7RG7zQ1NzWgsVPr3L+8enhkXabV0Twuw6/DU6
         J1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWQTrF1Zx9CkIZR1KJrNYTLlyukx3JpL1YOTkwV9DpOTYtQ9tvX2ala7daZMH4DTOCV9np3ttF7y2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa232413QGeQwRvZVOdh5/YsVzYfdC6ONINt7HJxGLunwHnM65
	j2l/gZxi4x71zb/3G+1LJpIfl6KmOxl6G63ALcOuDUOy0x1YRC5Y2+wHgPu4OA==
X-Gm-Gg: ASbGnctp2ScB4aq5OcMyqBoS8kKI4K9ZTiNwc9ChMMOo3Bt7uQWe2SAzD2w/1syLKrg
	hbkU2ov8khx+UEcWv/JBDbnTCavoOniPuNSQcyx/FhS1Ywfgy3qfH35vJywVxnqMZe7/YLe9Ngj
	AexhXROR7UzSMHfT2X5v33pp9pJsji4xhTxnTvobtu7JiPXh7xlHrGOhooM/jNGYFEhlBVnAdjU
	VqWDJfjA9rPjgPquoIQYtYhyTIDVa+U1qSwG1a/GRl1oy4hRWP5odqurBAc
X-Google-Smtp-Source: AGHT+IGMQz7BH6QCsJCOIshdD5nGI4ii2ks2kgkA1lV0ck1baioPhXJl9j4dkpEkR7e4LinD/4buOA==
X-Received: by 2002:a05:6a00:ccf:b0:724:de1c:bac9 with SMTP id d2e1a72fcca58-7253007749fmr2753689b3a.13.1732688418746;
        Tue, 26 Nov 2024 22:20:18 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724eb65d2adsm8372423b3a.159.2024.11.26.22.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:20:18 -0800 (PST)
Date: Wed, 27 Nov 2024 11:50:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <20241127062004.oruhwkhj4zrvjx25@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com>
 <20241124071100.ts34jbnosiipnx2x@thinkpad>
 <Z0S7+U5W2DOmzdJL@lizhi-Precision-Tower-5810>
 <20241126041449.qouyatajd5rie5o2@thinkpad>
 <Z0YAChEOnmezCBcU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0YAChEOnmezCBcU@lizhi-Precision-Tower-5810>

On Tue, Nov 26, 2024 at 12:19:01PM -0500, Frank Li wrote:

[...]

> > > > > +	/* Only support one EPF for doorbell */
> > > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > >
> > > > Why don't you impose this restriction in pci_epf_alloc_doorbell() itself?
> > >
> > > This is callback from platform_device_msi_init_and_alloc_irqs(). So it is
> > > actually restriction at pci_epf_alloc_doorbell().
> > >
> >
> > I don't know how to parse this last sentence. But my question was why don't you
> > impose this one EPF restriction in pci_epf_alloc_doorbell() before allocating
> > the MSI domain using platform_device_msi_init_and_alloc_irqs()? This way if
> > someone calls pci_epf_alloc_doorbell() multi EPF, it will fail.
> 
> Yes, it is limitation for current platfrom msi framework. It is totally
> equal.
> 
> call stack is
> 	pci_epf_alloc_doorbell()
> 	     platform_device_msi_init_and_alloc_irqs()
> 		...
> 		pci_epc_write_msi_msg()
> 
> 
> 
> It is totally equal return at pci_epc_write_msi_msg() or return before
> platform_device_msi_init_and_alloc_irqs().
> 

No, these two are not the same. pci_epc_write_msi_msg() will only be called
when enabling the MSI, which is too late IMO. Why are you insisting in
calling platform_device_msi_init_and_alloc_irqs() for multi EPF? I don't quite
understand.

If the platform cannot support it, then it should not be called in first place.

> why check epf in pci_epc_write_msi_msg() is because it use epf in here.
> pci_epf_alloc_doorbell() never use epf variable. If check unused variable
> in pci_epf_alloc_doorbell(), user don't know why and what's exactly
> restrict it.
> 

This is not a good argument and doesn't make sense, sorry. You should not call
platform_device_msi_init_and_alloc_irqs() for multi EPF.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

