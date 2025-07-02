Return-Path: <linux-pci+bounces-31306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C340AF62E0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 21:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9367A5EC8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D22F5C2F;
	Wed,  2 Jul 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6L0xqg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1D2D9496
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486078; cv=none; b=rFTXQwIYAgneAoTTxf8ZQYNX7zdLUL4ud4qJvxbVdL5wq0U9rRvgl1b6OmGnlM+9fwxZNN9uhJa49x4BktCICvFzfDwRSGBjqJnl5qbwCx+q5HqzYAcpW/sr15ZSUeqrP85G4jDEZeHj5rMEOY2ZxOW+x0RLARFndwpmHBAt6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486078; c=relaxed/simple;
	bh=WKSnMSttL8oH8Oe5vAQfNUn0TlrCgh4B+Anf0JHHdZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJYMi7iHTs4iFMspuRSVLWiEbn6SfOdAKMuYJx2uzx0Ny1qBfO1/WsJiy84XAGpuEAjLALdy2QLP0Qoe1iwY40XLGpzgyxYiTyZSR1/JMclFLQQok+TIsmjCwujtx6qK9bdmCZbdUTcOwePBGhvPkia3MXry8x2k5s+04SERJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6L0xqg+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-610cbca60cdso2997322eaf.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751486074; x=1752090874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=giyunrX2+D6X+A6e6UeKZhe7Cg6ipMHEWvo2VSb9DY0=;
        b=a6L0xqg+Fj+4LSnhDzSC9IEEBI76Mhy1BCiNVMD1oqt+CHAbPhXXne5zOBLGBCIjwg
         cwKDIh7RWrBuArlNvAEL7CtaWoxucNgPlAwGk3oH9E9IfG+uNOIA+JGqnFRduYNnZlkV
         mz8MYcjChXvESizfEsolqhSPyiA4qcNDFC0wkTxVZ0qc7CsIbeoRSsLyqgIl6hO+plKu
         DZLKPcOuaclSVODlh7xZVjuakHPIn5UvKPbV0EWG0xI8EuYEztgO1A/XkOuQGJN+1win
         zEv/YDfPCMLwadPwwgnRzXC/z7G50xi/cPTXwX/Fq0JuJyKpqV2EnLJDea69blV6xMk4
         FwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751486074; x=1752090874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giyunrX2+D6X+A6e6UeKZhe7Cg6ipMHEWvo2VSb9DY0=;
        b=Ya5dPc/AiycyjtfHnvT0xMoikhtXxwi4z9GuLeQKXbtLlBtjy6/R5aQkLYWhamUxru
         +l1vbd0UKnnFiAAukf+GpRwnItY61qFqyODPDy/fmqCj71wHMPv6gmiznjhFbxKXYGOj
         +VT7gNHgH8yMa2SBIhETfaP+IHav2ktHnDpqOjms7D31SmyHWyQ8tL66mTNlv7/4ysfQ
         6nn5flJ4IA2M2pXujw5ywxb1N1g/ZbrEzLONjF4I6k+VDXtFU2akJLTzR/VY/UrtHPek
         EEyGCp+ND+XmBUOT3c+VYKAMYF0mfErulMr81bALxxUacdM1w3zByW+bQYZK8iPvTE3Z
         TPsw==
X-Forwarded-Encrypted: i=1; AJvYcCXahihHLjjDTfbTABiKA9Ea804cbAVAXkiSKmhd+6jfv47Wxnu/ExoPVosS7c6VGk8KvGvcP5rmZy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcpyIhDsGRvIwZD3CpV8lLEr+JbALLzBCGs48Ah7fsRsSVNEV
	yUBwnuQuZPFmzd66DoZqx87ueYSemmsnzR/2V7ygU08nFjy9jtYFYCN9B3zMnZ/GSSY=
X-Gm-Gg: ASbGncvxqayx1mTy+Ym6QIYYn04bHtPwNrc6XHrlxNgpWLcWwqNoFPHtOub4isa8K3b
	gScLGizzAag0ebf8t4zMnvWljajvDyeVJCJAv7XaoRRxaXUlB6V1zqTAWvjhkx6l7r4BsG1ZtsI
	DIAQOWW8KzgLwNMjVwo4zHKODKIvzws9m8vRQGzCh3Cc1AsuttR3s62uyvhpIyA6cHTyQOcgif1
	JGWGmGgiiVBXhdu6vfYbIpa30iyN+iCyLP3KzTjP2X1Kv7qXnltweNbFzbkU7HJtCAvcJPjBNe1
	7FG9TWXe9bugOGKLnVRgVkanMinMU7+JGw25udNldchbOrVaWZLLtIcgtz+4uKFZSm80qA==
X-Google-Smtp-Source: AGHT+IFfXZBSnWI+uH/87ZyqSk3q7Ci+q/p9P0dxU0KgN0/eFw5XVndfUZwPsNbWV/HmbRCS/xowMQ==
X-Received: by 2002:a05:6820:3093:b0:611:bbad:7ce1 with SMTP id 006d021491bc7-612011c000bmr3140143eaf.4.1751486074430;
        Wed, 02 Jul 2025 12:54:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:7056:ddb5:3445:864f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b848d77fsm1793343eaf.14.2025.07.02.12.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 12:54:33 -0700 (PDT)
Date: Wed, 2 Jul 2025 22:54:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Message-ID: <c5dce0c6-ef8c-44fe-a0cf-aa8fcb856745@suswa.mountain>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-6-terry.bowman@amd.com>
 <20250627112429.00007155@huawei.com>
 <a76be312-9f27-491a-99d2-79815ed98d3e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76be312-9f27-491a-99d2-79815ed98d3e@amd.com>

On Wed, Jul 02, 2025 at 11:21:20AM -0500, Bowman, Terry wrote:
> 
> 
> On 6/27/2025 5:24 AM, Jonathan Cameron wrote:
> > On Thu, 26 Jun 2025 17:42:40 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >
> >> CXL error handling will soon be moved from the AER driver into the CXL
> >> driver. This requires a notification mechanism for the AER driver to share
> >> the AER interrupt with the CXL driver. The notification will be used
> >> as an indication for the CXL drivers to handle and log the CXL RAS errors.
> >>
> >> First, introduce cxl/core/native_ras.c to contain changes for the CXL
> >> driver's RAS native handling. This as an alternative to dropping the
> >> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
> >> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
> >> conditionally compile the new file.
> >>
> >> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> >> driver will be the sole kfifo producer adding work and the cxl_core will be
> >> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> >>
> >> Add CXL work queue handler registration functions in the AER driver. Export
> >> the functions allowing CXL driver to access. Implement registration
> >> functions for the CXL driver to assign or clear the work handler function.
> >>
> >> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
> >> will contain the erring device's PCI SBDF details used to rediscover the
> >> device after the CXL driver dequeues the kfifo work. The device rediscovery
> >> will be introduced along with the CXL handling in future patches.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Hi Terry,
> >
> > Whilst it obviously makes patch preparation a bit more time consuming
> > for series like this with many patches it can be useful to add a brief
> > change log to the individual patches as well as the cover letter.
> > That helps reviewers figure out where they need to look again.
> >
> > A few trivial things inline.
> >
> > With those fixed up
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >
> > Jonathan
> 
> Hi Jonathan,
> 
> Do you have an example you can point me to with a change log in the
> individual patch? I want to make certain I change correctly.
> 

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Just put a:
---
v2: white space changes

or whatever.

regards,
dan carpenter


