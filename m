Return-Path: <linux-pci+bounces-13161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B2977E10
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16381C246D5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166281D7E44;
	Fri, 13 Sep 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qu4WXre9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546533C8
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224948; cv=none; b=r+qxR0Tzftuyelkl6vTMhlJ4M/N6GA52y9l63m7vmtFciH3yTsfHjxAOjm5Hde6wZA6nk5L7+wtr61VVUN7NAwc5bfhrHar+pbvHAA7gPk8FCF29Mja2AOrIBXwVgg2Thu2ToujzwsJwi+Mkir17kQt0auwwIMEcFDiCxIiAUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224948; c=relaxed/simple;
	bh=fYYbdvb/aLGeSqsfeF0siNh1yKEhkvg10tYxpeL6lDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTM6Mgktl0p+NGWxUm4+rsCvMf56g7QFwLgUh4p9pRxdWt6/v/y7oFPTiLGYs9ss9OrJ9TCr4OGXQH2p5iQtvlvS+TVYs39TER5zCEXCspyyU+xXJ+wIzmBBDCAdxGnSbxC9PB+ZZa70+zCYqaoGPWQuH5OgGvzsOeJelGN+nPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qu4WXre9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71911585911so1737926b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726224945; x=1726829745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8QgG1ZjPqFSasoDMDuy996Qw3saF8jawBRjWtybP40=;
        b=Qu4WXre93i2GWqnYiDwLizevaZMpaVucYsf/3fNJzz56EPgWYBSfpqGqC/eWYb+84A
         0ouBALVq26Exqg/QewBw3ibNBh1IoREeOU6AOmaaLdTse1paiFFg1c7ZJjcLBCeZODbL
         sReWKjrjvr/zO/3NhvNIUIoIV5tCKPp/slTPUHTWuz8UYQRjmY4chBfRRfPf7+l4RKKQ
         sYQ0fJ2qdC8vZtB2vxHCc3NLJTquyy8NBKx5x4/y5l2MsS1lzQ9yPVB1vgSVGD3rTefs
         wlDUC6SOW/lQNw3oak7Y/wVOFwGloqOmHWIRsCvYe/sfCSCM4wZSHhYqpSPpI12Cx0fq
         dOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726224945; x=1726829745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8QgG1ZjPqFSasoDMDuy996Qw3saF8jawBRjWtybP40=;
        b=lJCFHcrlVovf2PHfYVlUPB2WEgtGljpPlmjIU+BFhejCcfT2JBsAbSFuQt1OoVumJD
         eOy6nB15bJ85Ij2JDOcflcSdHwsuthqsEm66yTYbOJbs+oLfLJQB7beB+stG9VSASwxI
         k4sTTzsWerf4EwBry/rk0ZCslqwWcV9qX/qQZo9uKzMUTXz9W396opc8+APAOoQQgdxd
         Dm6MjJmAZ/JOnvn5IUvG2SFaAK/8zqXHHAOOfduelAUpbfZ2UrWQRfHtFVTTq/bx8kt3
         D3iAtcM1DN+hYxs9Cj5oS1UAiF/YLkoVLCKG6v5pXg+zk5qDyuFUQGFnJkZ37963ApyA
         1wvA==
X-Forwarded-Encrypted: i=1; AJvYcCXeIy1jR46helyqhsM4rVVNqV/BnDqbJP9KOun/AC/tjUp6bVMC75g4Scar+r3oWTOhZfv30OJxag8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVdl6qFdL9OGztX9LOf+GXNKqVT5a0+JOEdtBZcuw4fKvpXUH
	t9Vbe7IAKByCFq2P1rRhmJnnPpa+V6aBy9SqNUrqKnqTRYASaGqWAxbW0lOSew==
X-Google-Smtp-Source: AGHT+IH2rw0qqN5c1+rpNO0lnQXMKwX7j81lV52vPqUY7fp6o0VIjif2bshwciCFv34BeAbhMJPE2A==
X-Received: by 2002:a05:6a21:390:b0:1cf:24f8:e20e with SMTP id adf61e73a8af0-1cf75eefc07mr8538067637.17.1726224945425;
        Fri, 13 Sep 2024 03:55:45 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090926f1sm5866010b3a.121.2024.09.13.03.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:55:44 -0700 (PDT)
Date: Fri, 13 Sep 2024 16:25:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org,
	paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <20240913105541.x3ccu34z5yqatmvq@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
 <20240912143657.sgigcoj2lkedwfu4@thinkpad>
 <66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
 <20240912172534.ma3jc7po3ca2ytlh@thinkpad>
 <66e32e8d5e19a_3263b29452@dwillia2-xfh.jf.intel.com.notmuch>
 <20240912121513.000054b3@linux.intel.com>
 <66e380f5c8a50_3263b294c9@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66e380f5c8a50_3263b294c9@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Sep 12, 2024 at 05:01:57PM -0700, Dan Williams wrote:
> Nirmal Patel wrote:
> > On Thu, 12 Sep 2024 11:10:21 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Manivannan Sadhasivam wrote:
> > > [..]
> > > > I don't think the issue should be constrained to VMD only. Based on
> > > > my conversation with Nirmal [1], I understood that it is SPDK that
> > > > makes wrong assumption if the device's PCI_INTERRUPT_LINE is
> > > > non-zero (and I assumed that other application could do the same).  
> > > 
> > > I am skeptical one can find an example of an application that gets
> > > similarly confused. SPDK is not a typical consumer of PCI device
> > > information.
> > > 
> > > > In that case, how it can be classified as the "idiosyncracy" of
> > > > VMD?  
> > > 
> > > If VMD were a typical PCIe switch, firmware would have already fixed
> > > up these values. In fact this problem could likely also be fixed in
> > > platform firmware, but the history of VMD is to leak workaround after
> > > workaround into the kernel.
> > 
> > This is not VMD leaking workaround in kernel, rather the patch is
> > trying to keep fix limited to VMD driver.
> 
> Oh, ok, I see that now, however...
> 
> > I tried over 10 different NVMes and only 1 vendor has
> > PCI_INTERRUPT_LINE register set to 0xFF.  The platform firmware
> > doesn't change that with or without VMD.
> 
> ...SPDK is still asserting that it wants to be the NVME host driver in
> userspace. As part of that it gets to keep all the pieces and must
> realize that a device that has MSI/-X enabled is not using INTx
> regardless of that register value.
> 
> Do not force the kernel to abide by SPDK expectations when the PCI core
> / Linux-NVME driver contract does not need the PCI_INTERRUPT_LINE
> cleared. If SPDK is taking over NVME, it gets to take over *all* of it.

In that case, we do not need a fix at all (even for VMD). My initial assumption
was that, some other userspace applications may also behave the same way as
SPDK. But I agree with you that unless we hear about them, it doesn't warrant a
fix in the kernel. Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

