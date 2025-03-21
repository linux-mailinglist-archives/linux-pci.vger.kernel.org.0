Return-Path: <linux-pci+bounces-24346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC62A6BB9E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E422116300C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814FA227EA3;
	Fri, 21 Mar 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5f+qcoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F81F4181
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563094; cv=none; b=RLdsbcubzfY8NY0tn8EMbo/k2hCZqqN+Rb4Sw4GwdXtvhwje9FJ07pKrziG8rJjIoN5Uqp9XsESLJgIqeLDmipSHuUleawXT4V/SwSbq4u2fHAnKFdJBFPYJz8lxpD4IeLkALHi8qE4rVTKmXiRCedc7nuHsl++xx6X7fYJbfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563094; c=relaxed/simple;
	bh=NombQves/w/CJOPVeBM13rWw3dr3xC5H9bM41iFYTEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePiKblR2pjWW8Ew6S9bnp2fFEnF7CdJqBioR3a6jUtnLDacuuPpVEpUUw/9AE4yuMHfLopRYcQ5JclOW6b0Zlj0ROX61JlcGi8JZflllcbJDap7JlJxA9kcwUUjMqKRrcy4ew004n+QpuvYcXEF/UORAeHZSvXTGSRiINgvNaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5f+qcoy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224100e9a5cso36710415ad.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742563092; x=1743167892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=slNX4cCQBrcrmq6L11WIT4xDIUcpyPfGH047qS7ymg8=;
        b=O5f+qcoy6pn7s7T3wkUGym9dULmLucRCmI0DzO4803Kvao5C7hvtu170ckB8vMw+Q1
         VIBzCvnMQpSr/vjM6e5NDflauLvNMiDEHkcJD5xNQPF3PPRFzlGbr/7p5gi59exE0d3D
         ND9AT3vGBgWdsPYeX168WMUadfblHMCXUl9KOKOTgU5fbhdVQfrSiCYVqC8CEY4WxZ0Z
         QBXRwxXuX8h2EJd91mQX5JZ9/CvpM5KOb9dJQ1Uq8yWkGM3locWwwJtNmyAKyPeIY6O+
         ry1l+ArX61hlWLKOmB6wOtPRIPVUFzMQqCRbZ2Ao/CAhRcR5E8Ddo+TYLVfT9+FSe6Fq
         AQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742563092; x=1743167892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slNX4cCQBrcrmq6L11WIT4xDIUcpyPfGH047qS7ymg8=;
        b=g+ty5shNWMyt1Oq3jVoK7Ipmq/Ozp9kN2kX6dgrFboHB6LSSSUBlmNRlhr8N0yuxDR
         rU8+LQ9Pe22r4UOt/mYXmsd2hJVz/WjcrqFvN5AfxWnlTLB+aMcuOkb/9L7wpNJDPr68
         A5kxv22PZgqHNcHi7WQb4SgfLrtrs+9fD/fB2dd7TDdqvopH1QLE9GBxWpGvGM82W2I4
         00dLsQBI3D6M+NBUb4P5Ni5yznSYbkHBQDaRotnEmfE0lPcaOhb58e7rmLvfT+qYHg6K
         RXgs7L1NBJnRTEVKL0drVJVkuouFr1haDA5Wv5tjHqZuz+JI4O0WmgQ/yMCSY1rDnrqr
         ctnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpWZT6IgjsYGHPBpX2XEtKxNiZh1Fosc02fUMFGv7yV9N2zMUAs+l5eUbZ/tslM9HlUHNYrz2BJ50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoG9t/zEGOSE6DQ4PqFt4uGvoYfoTdKIaz8pq6BvnoNvaJY94d
	3kjXQ/PqlVGmJRRBWKKM6NkmKUNw0RJnqEJ3fjG8wXtEM3EsLlxxuClpHH9KhQ==
X-Gm-Gg: ASbGncsaL4wveOyuTJbREdeSnQppA/2jG8g/8H7J5If0jQl7tXc8GouzsotbsIXsZFq
	pmACFbgbDqCFgSt7bedKf2r8oqwSkNUY0cse16XWOAVaeR2Hb6E8yfwCTcq51QSn/eJgm8NUvql
	nTbdSNv2DYTRPhRuhQBfIftPZHfdArepTMLO8Vzn1g1fRFulszkMUCRBDFMBoeZQkTddoqSPW4F
	Myi5GBsRyNcGS/eJAGaHTnGpePKeVipTFMzlkpb4OdpGfqUGLwTzUowWgtlYZ1GwoRNp86iTBwO
	33eE/K18Aq/AS5GVGjk1GojF3Sf4UzwDOZMiHHWfQeE3x+wyLFJt5vwHNsj/EeZDCEgA
X-Google-Smtp-Source: AGHT+IF0+4ERgFeq9+JcDVf8/T/R07dw+GX864DNjg2M5q6sj+GkUQquyUh5pHbg8Y7H/8aIEkJYtw==
X-Received: by 2002:a05:6a21:101:b0:1f5:8eec:e500 with SMTP id adf61e73a8af0-1fe42f08e54mr5667492637.9.1742563091943;
        Fri, 21 Mar 2025 06:18:11 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a284888bsm1645367a12.46.2025.03.21.06.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:18:11 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:48:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v4 4/4] PCI: cadence: Use cdns_pcie_find_*capability to find
 capability offset instead of hardcore
Message-ID: <20250321131806.34xeuaw2itl6gilj@thinkpad>
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-5-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321101710.371480-5-18255117159@163.com>

On Fri, Mar 21, 2025 at 06:17:10PM +0800, Hans Zhang wrote:
> The offset address of capability or extended capability designed by
> different SOC design companies may not be the same. Therefore, a flexible
> public API is required to find the offset address of a capability or
> extended capability in the configuration space.
> 

The PCIe capability/extended capability offsets are not guaranteed to be
the same across all SoCs integrating the Cadence PCIe IP. Hence, use the
cdns_pcie_find_{ext}_capability() APIs for finding them.

This avoids hardcoding the offsets in the driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

