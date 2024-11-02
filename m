Return-Path: <linux-pci+bounces-15843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97399BA0B4
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B231C20FCA
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C119CC27;
	Sat,  2 Nov 2024 14:19:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466D18A925;
	Sat,  2 Nov 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557161; cv=none; b=urONHNihTj4xFkxCYMKFGET1Ybx3Hr0C53TjB+96NKlm1TWwqAPCfN7US/DYHj4aZRsJ7tX2SJOT8oiEROVG1njMABKbcwT7HR4zpDZQZYb3DKqSxTEhsZ+OhJP+RuLufTj5h6DuX1xLPe8C1XeJ3g5EF4XygK1xU3Gz+ni4rhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557161; c=relaxed/simple;
	bh=i4VUhHPhcihVwDXVjt1X6R/W0FnDjTq2LIn5IcgTqe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJFIGgSCi30AxsZAIJ9NPYC4MoBEbqzc367YCIF0pIUy5Ma+Kn5EdkUnzgSVn87UMT4PpOnK4Cwik0K4AFi57hZ6mOdtrie68OvMA7PtUUgXmwy6BLmEcYpUmeTLgcUpvl0qXm7l0n9kgtN40tej8RgM3SPCYU4KcU0hm77mN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e983487a1so2456399b3a.2;
        Sat, 02 Nov 2024 07:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730557157; x=1731161957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoNhd3PU7MNVWI+sf1DSija4VTsLivchGzEQ82Up2A4=;
        b=cPmrYyIa55ThLP4WAwzIA2ce5QvaJjOvLZ7TBc/WR/dLgAzCe7f2toPst2d03hOO8x
         9ZBultzA7uMjKnTV8Tk+McEi1V57zJR2siW0K7F1yI2JoW4H3xWhEYyl+4d5tS8O/YcE
         ibrPTWOrur/XcKjedUmUibOKl3CvIRsvsxa8J/Mk9pvSjN+M/ApbFXzQTqOBDQO3FcVt
         aLas0EIOMihXR56tGSkgPU/kjU9ph1fKS2T6+C+dtx2Lx/wQvI0Bj9jz2BqVsHIARykV
         P37kDaPx0R2y3e2CKaOUO3C4/l9L9BAaZe2cIFZPgVXR46sJknrzW9REAijcuLi7WPj6
         /D9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHrqbBCKNcQf+OEunbRuBztdZO4szLk2IZ6ptw9QrrU+t+YZq8I9gZDjAull5EDZ4gIoE2kXVC6y7l@vger.kernel.org, AJvYcCWZoWAxn1kB+JtiuG8aceeybOgsvddqRPWFhrEU00ATPB1F9QtlixNwQIpRYQoUgawDvDuAHl6rNjQyw6M=@vger.kernel.org, AJvYcCXIkD3XmMhdGskFxsrMhuy4GDBlFbt7edZNlQnc/0SSPg1jPgg/WPSvzHiWljEzxFnQEs+aRGfXKUyBsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IbRvdCVJ+YCTGH+ohfLDNrPqhfU8Kt9x/WpBd5r9Bey1JgrF
	hl/oDqmi4BG7/NiSB9SON/nIJHsOUHiF+XyuSsc9rF6E/mvSLZmS
X-Google-Smtp-Source: AGHT+IHPcKNMt6OSC6S/K2FJ3EposZZ5TOsaoIOHKw561pjEChI1kIfOypmeQ6NBttJJZ5y0zs9rDw==
X-Received: by 2002:a05:6a00:2ea5:b0:71e:82b4:6e6e with SMTP id d2e1a72fcca58-720b9bb3edbmr14950575b3a.4.1730557157041;
        Sat, 02 Nov 2024 07:19:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3902sm4096567b3a.136.2024.11.02.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 07:19:16 -0700 (PDT)
Date: Sat, 2 Nov 2024 23:19:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
	thomas.richard@bootlin.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Deassert PERST# after a delay of
 PCIE_T_PVPERL_MS ms
Message-ID: <20241102141914.GA3440781@rocinante>
References: <20241022083147.2773123-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022083147.2773123-1-s-vadapalli@ti.com>

Hello,

> According to Section 2.2 of the PCI Express Card Electromechanical
> Specification (Revision 5.1), in order to ensure that the power and the
> reference clock are stable, PERST# has to be deasserted after a delay of
> 100 milliseconds (TPVPERL). Currently, it is being assumed that the power
> is already stable, which is not necessarily true. Hence, change the delay
> to PCIE_T_PVPERL_MS to guarantee that power and reference clock are stable.
[...]
> This patch is based on commit
> c2ee9f594da8 KVM: selftests: Fix build on on non-x86 architectures
> of Mainline Linux.

Why KVM?  Do you have the link to this commit handy?

[...]
>  		if (pcie->reset_gpio) {
> -			fsleep(PCIE_T_PERST_CLK_US);
> +			msleep(PCIE_T_PVPERL_MS);

fsleep() with the same macro and for the same reason is also used in the
j721e_pcie_probe() callback.  I think, we would want both changed.

	Krzysztof

