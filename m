Return-Path: <linux-pci+bounces-20926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D399A2CAB6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050A73AA268
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DD19C540;
	Fri,  7 Feb 2025 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1coZQHe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA5197A7E
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951356; cv=none; b=bznx7w+vrAH1rcjXUJ548pBH+XKsrXlC6M7LcvlBtWIMos9+DHlGI5IhFow1aW5gfc/8UkM9Hw6nCpMkUrTYuX8AWzmIssuQbu8lG/p6HIT5UISumM4e+gwgS0Ml/GrNXascjwEemXKQAvzBY8wWPT1gTXsiqJUT6tSkRnn4WrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951356; c=relaxed/simple;
	bh=NqO84F5NE3IruG8NzDQwSjSD66JsGmPQu/jDgpqvrq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI5kYthccpEqln23CVDUfW6wd5ZtZj8yMieURwIgUrd71yi5EGEE80n0y9P6B6YYc1uz+hd59j4fPHZIHDLCTdDRsj0+clfSykdjymNe8dFm3Y+rkTHbPfP4/K5VDCOEzf1KPan1pXlzXmeQ3qVmr+CWHbzpHFnpyKD7OPbFbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v1coZQHe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f49bd087cso25901455ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738951354; x=1739556154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQdSGNCLdU+KmXShB0HTnMPELeU+rmc5NBZ/BzRGGz4=;
        b=v1coZQHew8/RaTeerT/OFrbF0C07wJjDE4H1kZdUvlspV0pWjWL9w5yi9ciAYsL5hQ
         Fgn1DAXHAsa5Uk155ALURnx4rBV02Q8cythvko8JEZxSkFojoBv1g0epOo2bqD3Tz3bR
         XClQrrhUBrBoUat5FXFSPB7QTGEcLKLE/bghMhtNyKT5N0jsJSgKJyam2BZGkeKOU8Xg
         ivchvBohqYVEyaa1ULmSom/roBFTpDEdV4d2EwfDtqtqyNSMUQNagcrhKN6FQXaLlEvG
         vAQsNGAkaJTYRhsGguf815rzHTkXRvwbOmFJ0BEZdIfNsLwwJMrfHhObzbWHPunD3Ot8
         sXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951354; x=1739556154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQdSGNCLdU+KmXShB0HTnMPELeU+rmc5NBZ/BzRGGz4=;
        b=TnuA2C7C5Q20t6QLucRaYXnBLXVBnh/Zj0497BegPvhijla+IRC7RMKzNl2mjQ89Zz
         ndtWkHtxL9fTwC+yWUmIaS6Zb7kFPv5Os9vF7zH8lCMd5CX7G/iy0NVlRa0fq7x2pNwe
         O+Axd3RQh3SvKJXtBEbueNaolTCsJMLpLUc5HadkvWmMHQyZMPc+csvz5uH7sr4nb1jt
         rz9EB779tQ5neLlY+X5wEBpEcBjf8AGKoEBOGZK+9SOUKxpCFBvFXo1wruAhbaJQtZU9
         XSF+G50e3qgizB4Mn6/vBO2hXfr9c63TDrrM3NLNNnupWu72lj0rho8FBVhuL06xmN7g
         +RKg==
X-Forwarded-Encrypted: i=1; AJvYcCUW2vCskQz+seN4b2KBpjLA8+4vmV/oUs8QLcyTEIyEXujbOJPmX53r1CUEKZBPsTkB0PSeoN1Rcss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKYuHifDl2kukMnSNndXjQzGIFpa02QH/GDGl0VKfmYS+sVk2
	Wa1dD05vr3csiFF3tjoixR1Ln0LDjfvrZttpKp2Sl261E0OrXGIs3nse2dGazA==
X-Gm-Gg: ASbGnctBmfNWZlLkH1ZL7Pl8ZxzdYwT/o6sEilX7ENzRl85M+HCZ735ht4tKHnQCtRD
	UCsBQ6Bkjn9uVzCJagLjM9ZUaiXi9Z0RuTafEF3rYlYhUHJ6LAoCELUoqR4X+1JX0kR4TTpwsBL
	EVSS6U7VSrrFHnUfKeQvZshnTX6Iu7gBE/S3pasO8piKLshbfPIdDiFFMTwTonc4Z9jQ1NxVMHq
	O89LYEvTPZKvUf/dE3P2eiXpp8hn4AM+rbej+ktUvxVwKy7OsMstDbBL32O4wsHEGjUjb1dl9sX
	FsQJK/BNdIhpbmK0VI2EhaIELQ==
X-Google-Smtp-Source: AGHT+IHe/f9KD656VF5FTEn+fPeF5J+ymlf3SJrqMrR9FwfOwdt7DDF0gjoAwjmn64h1LMoh94vgmw==
X-Received: by 2002:a17:903:2309:b0:215:6b4c:89fa with SMTP id d9443c01a7336-21f4e1ced38mr60598315ad.8.1738951354335;
        Fri, 07 Feb 2025 10:02:34 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653bfb2sm33901175ad.67.2025.02.07.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:02:33 -0800 (PST)
Date: Fri, 7 Feb 2025 23:32:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] misc: pci_endpoint_test: Avoid issue of
 interrupts remaining after request_irq error
Message-ID: <20250207180229.klwodx7m3rmmopnq@thinkpad>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-2-hayashi.kunihiko@socionext.com>
 <20250128141242.pog2tuorvqmobain@thinkpad>
 <2cdb5e43-47e0-43ba-ba17-87e8d5dc602d@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cdb5e43-47e0-43ba-ba17-87e8d5dc602d@socionext.com>

On Wed, Jan 29, 2025 at 04:54:46PM +0900, Kunihiko Hayashi wrote:
> Hi Manivannan,
> 
> On 2025/01/28 23:12, Manivannan Sadhasivam wrote:
> > On Wed, Jan 22, 2025 at 11:24:44AM +0900, Kunihiko Hayashi wrote:
> > > After devm_request_irq() fails with error,
> > > pci_endpoint_test_free_irq_vectors() is called to free allocated vectors
> > > with pci_free_irq_vectors().
> > > 
> > 
> > You should mention the function name which you are referring to. Here it is,
> > pci_endpoint_test_request_irq().
> 
> I see. I'll make the commit message more clear.
> 
> > > However some requested IRQs are still allocated, so there are still
> > 
> > This is confusing. Are you saying that the previously requested IRQs are not
> > freed when an error happens during the for loop in
> > pci_endpoint_test_request_irq()?
> 
> Yes, after jumping to "fail:" label, it just prints an error message and
> returns the function.
> 
> The pci_endpoint_test_request_irq() is called from the following functions:
> - pci_endpoint_test_probe()
> - pci_endpoint_test_set_irq()
> 
> Both call pci_endpoint_test_free_irq_vectors() after the error, though,
> requested IRQs are not freed anywhere.
> 

You should not use the word 'allocated' since that has a different meaning
and the source of confusion.

> > > /proc/irq/* entries remaining and we encounters WARN() with the following
> > > message:
> > > 
> > >      remove_proc_entry: removing non-empty directory 'irq/30', leaking at
> > >      least 'pci-endpoint-test.0'
> > >      WARNING: CPU: 0 PID: 80 at fs/proc/generic.c:717 remove_proc_entry
> > >      +0x190/0x19c
> > 
> > When did you encounter this WARN?
> 
> Usually request_irq() can successfully get an interrupt.
> If request_irq() returned an error, pci_endpoint_test_free_irq_vectors() was
> called and the following call-trace was obtained:
> 
> [   18.772522] Call trace:
> [   18.773743]  remove_proc_entry+0x190/0x19c
> [   18.775789]  unregister_irq_proc+0xd0/0x104
> [   18.777881]  free_desc+0x4c/0xcc
> [   18.779495]  irq_free_descs+0x68/0x8c
> [   18.781325]  irq_domain_free_irqs+0x15c/0x1bc
> [   18.783502]  msi_domain_free_locked.part.0+0x184/0x1d4
> [   18.786069]  msi_domain_free_irqs_all_locked+0x64/0x8c
> [   18.788637]  pci_msi_teardown_msi_irqs+0x48/0x54
> [   18.790947]  pci_free_msi_irqs+0x18/0x38
> [   18.792907]  pci_free_irq_vectors+0x64/0x8c
> [   18.794997]  pci_endpoint_test_ioctl+0x7e8/0xf40
> [   18.797304]  __arm64_sys_ioctl+0xa4/0xe8
> [   18.799265]  invoke_syscall+0x48/0x110
> [   18.801139]  el0_svc_common.constprop.0+0x40/0xe8
> [   18.803489]  do_el0_svc+0x20/0x2c
> [   18.805145]  el0_svc+0x30/0xd0
> [   18.806673]  el0t_64_sync_handler+0x13c/0x158
> [   18.808850]  el0t_64_sync+0x190/0x194
> [   18.810680] ---[ end trace 0000000000000000 ]---
> 

Please add this info to the patch description.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

