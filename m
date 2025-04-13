Return-Path: <linux-pci+bounces-25727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15351A87239
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C2F1894796
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C741C5D59;
	Sun, 13 Apr 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2nGBI08"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82B134CF
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744554276; cv=none; b=X3UqAKGZgQMRnmJlCaiKqwmkq6jYekNfL+cRccsD0IZEw6+k+CWW56zJzJnjzHPLqtlnvJ0QMN620mRIRcsvCrk76fo5nmnu+oRJb2EpPcadE+VHoejDpyXWcA2s8y04AO4D58jMcVR5TOpiXd/9LJ/TvUsTuNUU/dA3AlXejVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744554276; c=relaxed/simple;
	bh=AhC5haPQFj3COVXG0x34Zc0YL8gTnP+Gg5/HIQpmgZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBvFQpvHrpTJfsVyjpEPuh+bxLwuQSJE+SDD+HfsUAJ4jK10hI6Hbojn2Sd+dk7ofyeF/m31H4xw1tFPIJYOvBwwaoXwE58cu/r7y9UlkHNZ7jkuw+xLXsktX9odmQUXoErorZT1ZovLtsDSMRIV+TAjKV2rmnGZcGUMLfoaPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2nGBI08; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2243803b776so49517585ad.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744554274; x=1745159074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1HrAk684WJxvGVi+ClfydabBEME3gjs95+HZox1kC4Q=;
        b=s2nGBI08+3ZdBJYgGaICVVydRe8O4cNuVqZUeUA1H6z+LuwOKn5ix+hnIuqjaPXx5S
         MM6hLIZu+vl03TYJmv0yzSPgXxRtiG7nYzmgqp6n94lilKUMmXor+WVWPZDc8rA+p4ES
         dy9j+1fKdG7jjWsYULM2I9YCf5B5JaHcT10L7zNxA75FLoQQNLL6msDCdWpXrg6/YXrQ
         hoaAAlQNtShTPYEgosA94ozN0wCQnvZ+InPKJJP+ILQ4x9prdpx9BXcgEznZjIK+M/BP
         P4apMLbMk01X/KofeYE7i6Wi2JeEeTCmJPMtYU86TMjktwHfUC3PmQ2GTyMgenywa0Rf
         S62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744554274; x=1745159074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HrAk684WJxvGVi+ClfydabBEME3gjs95+HZox1kC4Q=;
        b=O6ZsZph5xW82xJxjdAOaVtEDk/sSHpuzxGlV21MK/oS+KC26pBL+Es/Ji9Z11S4C7C
         BhJWGZUPIZsfz9UPz8d31ngZafBI72a3q/M8oS/Fy6G+DtLz8leQPncLo4N3prdCy3Jz
         oM5wYTAQCd8bAAIFyju2NLTad9a3lImPEb8MykqAv+3e/k/7aLn0gM+g1kfj7+lCl9yY
         NoOa0XqayC4BmjAMlIDwomLUCtQ49WVlzoNlwSySV93wQO1s6hlaGmyWYIOl+8jHYmwj
         ZopYilCHAG9Gxv+5zOg3ijm5rhk8qCg9eaT1ZXfQbTiCN0L+nlStuD8iPYORnxT541dm
         bnDA==
X-Forwarded-Encrypted: i=1; AJvYcCV8l8YYGi4/SxGoierSgYV8Se3Nvrx8f3Q3cXtcI+Fvpn5+oFHZqNqsh/vLMI+WEW6X4LY1nBbJJzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+leLCES3K7vK4XwiO4uxNmUMj8RmqwlKRj2gHlUTVDJVhYVk
	g2orOciY1XgZf0l4EB9shu0a18kmVFhwfNdLVLuyym00RvGRkJQKaH7dg9XjHA==
X-Gm-Gg: ASbGncur2bnuWMOoC68mYLZSjeSmzDKsr4DJ9LxX6dcwh6hdEUrNDDIuTBlnHd78Jl6
	0GvTa4CpUNN76Q4E682EHsOdE6oBNRNHrqL/IZ3DI4cZs56TaykWV22n3poyos1pdXyHoL0m0Tc
	ehughatvNB1p/l+x6OIwgf+waYCG+tqO52UqhPhPpaxqlScVNNXGKsJqUGew2W/ilsN0wlGmub+
	j+pjLomM1UkX1Gr6UjAbXaBShOWvyNQBRU8yn+b57MShNR5CbJ/cCcbncY5ZQScREwqQCt1Crzw
	+5+dzQmpynnh7bLBb6pR4W4JvhgqzX1aea1q+xln7t4KwyhAfLY/
X-Google-Smtp-Source: AGHT+IHz8KFcMndBsaWjeHAnKge9iDzq51I0lR4nXYH5jlXhc1fMIqB8kkjeuXzLM3IOTths9xwogQ==
X-Received: by 2002:a17:902:d4cd:b0:224:1609:a747 with SMTP id d9443c01a7336-22bea4bd2c0mr120185085ad.31.1744554274314;
        Sun, 13 Apr 2025 07:24:34 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb4fa9sm82852175ad.179.2025.04.13.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 07:24:33 -0700 (PDT)
Date: Sun, 13 Apr 2025 19:54:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
Message-ID: <gogw24yg4lfq77ime7qyurvkef5yvmkkwjxo6xch52fbszibax@diaxredvtcrh>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_YwNt6WUuijKTjt@ryzen>
 <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>
 <Z_Y7h1vzVCCEiXK6@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_Y7h1vzVCCEiXK6@ryzen>

On Wed, Apr 09, 2025 at 11:19:03AM +0200, Niklas Cassel wrote:
> Hello Shawn,
> 
> On Wed, Apr 09, 2025 at 05:09:38PM +0800, Shawn Lin wrote:
> > 在 2025/04/09 星期三 16:30, Niklas Cassel 写道:
> > > On Wed, Apr 09, 2025 at 02:40:33PM +0800, Shawn Lin wrote:
> > > 
> > > Is there any advantage of using a rockchip specific way to read link up,
> > > rather than just reading link up via the DWC PCIE_PORT_DEBUG1 register?
> > 
> > This is a very good question which we tried but made real products
> > suffer from it for a long time, and finally we found the reason and
> > discarded it.
> > 
> > Quoted from DWC databook, section 8.2.3 AXI Bridge Initialization,
> > Clocking and Reset:
> > 
> > "In RC Mode, your AXI application must not generate any MEM or I/O
> > requests, until the host software has enabled the Memory Space Enable
> > (MSE), and IO Space Enable (ISE) bits respectively. Your RC application
> > should not generate CFG requests until it has confirmed that the link is
> > up by sampling the smlh_link_up and rdlh_link_up outputs."
> > 
> > Quoted from DWC databook, section 5.50 SII: Debug Signals
> > "[36]: smlh_link_up: LTSSM reports PHY link up or LTSSM is in
> > Loopback.Active for Loopback Master" which refers to
> > PCIE_PORT_DEBUG1_LINK_UP per code.
> > 
> > The timing in dwc core is drving smlh_link_up->L0->rdlh_link_up->FC
> > init(a fixed delay) from IC simulation when linking up.
> > 
> > The dw_pcie_link_up() wasn't reliably work as expected by massive test.
> > The problem is clear from our ASIC view, that cxpl_debug_info from DWC
> > core is missing rdlh_link_up. cxpl_debug_info[32:63] is indentical to
> > PCIE_PORT_DEBUG1, So reading PCIE_PORT_DEBUG1 and check
> > smlh_link_up isn't enough.
> > 
> > The problem was introduced by commit 1 and fixed by commit 2 but not to
> > the end. And finally commit 3 rename the register but not fix anything.
> > 
> > It was broken from the first time. Any dwc controllers should not be use
> > the buggy default method to check link up state from our view.
> > So this's the whole story for it, which may help you understand the
> > indeed problem and why we reinvent rockchip_pcie_link_up() here.
> > 
> > [1]. commit dac29e6c5460 ("PCI: designware: Add default link up check if
> >     sub-driver doesn't override")
> > 
> > [2]. commit 01c076732e82 ("PCI: designware: Check LTSSM training bit
> >     before deciding link is up")
> > 
> > [3]. commit 60ef4b072ba0 ("PCI: dwc: imx6: Share PHY debug register
> >     definitions")
> 
> Thank you for the detailed answer.
> 
> It seems like we should really add a warning and a comment in
> dw_pcie_link_up(), so that others don't get hit by this hard to debug issue!
> 

Right. But I'm also wondering if we should use the 'Data Link Layer Link Active'
bit in PCI Express Capability for checking link up. Qcom driver has been using
it from the start and there are no reported issues. We could add this as the
first fallback if the link_up callback is not provided.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

