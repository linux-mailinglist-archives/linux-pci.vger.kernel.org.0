Return-Path: <linux-pci+bounces-28577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C766AC7A3B
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9AB9E0B0E
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D120C478;
	Thu, 29 May 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSopG+v7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D82DCBE3
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748507414; cv=none; b=HJiyUSI8L7LA9UGgq3PKXx319sLFDpt0QP2JEI3UdtAI6BbgQZtOlNpTlb7saQtzJloTXcxWDRYTD2AwIyCGjKzC8ct77UfM6BrtmkID22RKH9QFnzjjzxxQ0sUbVK5Uta9F6lhPM9sfPz1GO45cILwTNVGldy8iefYKLYCJ0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748507414; c=relaxed/simple;
	bh=kfsuMESY2OE1UyKGcsANzA0OF+hSEhjV6FnEPgmohRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mroNXLlAxMJvnQXxemW3KPWPHO0Wx+EY1tBKzcKZZnaZhx5qHzqHZDiEpOiY0WMpyEdbOVYYpsATO8zCrutRZGjOhyKZinmnyptcpjueNGkSlApWDWdyZa6M2Ch08nMaaNHHIE2ZXl7eSrYyYECivZKNN9+OXF80b8f2xmya45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSopG+v7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c73f82dfso393816b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748507412; x=1749112212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sefdUaHctF5zUkiiv0Nf2lC1NZKFwYYRdayYoyFIgE=;
        b=hSopG+v7DeCSoUjHIAfroXT99yr9bJ3hD8e3ZTdqJbLOx2OY5O10jPkVKxdNDZD5Rq
         kQXQMny9iTP9AH/pQrKW2orJE3NDYu/oOopaz0dLOZCJufYBBTzxd5Dxpc88DX5C0nFX
         2nT1evju+mUN0oh5rJV6MzTrvIU8aWmwE6LpEcsCCJrxYCEIkeLWxxyjB4qj2SmsUwyt
         k4Q6d89ZuNq6OMFN4XpjgYyi0Rh3xsEl6L8H54OA8OskrWXh0Z+Ms1hqdZKQMMAByX+P
         wfNr+btQ1hca5WBkzXZUkUD5eQG+DutrOZubmMP41NM4C/5LNAHaXc4DyeES17VtDUBk
         6/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748507412; x=1749112212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sefdUaHctF5zUkiiv0Nf2lC1NZKFwYYRdayYoyFIgE=;
        b=IgPclpMmxp3Gql65sEEELS9r0fqHwxaVz72lvZhdElLC/tdOWUKQbRGdVr1h0Zn6DP
         WpQcflGc/jBHilWojkuApxp6pBeMBSPddr5q1mhcWR5BKsuXPqwYJQjPZIrP3hqLCe4v
         qM/7A3CM3LOPKPW3Ureq07qFeD+GYCuC1S6vrz6hiBbHClV40wAS6cIWT6boNFketPtk
         KbcfHjdIJC76dZ5o6Ub1Nr/ICG/z8GaSPfheHvgqG+pm4KuRoGe/FgH4LkBT8EaC6NjP
         YRCZXF+/d4Z6a6JoDI88rhU5Hd/3gVRevRjOMW4BAzQhVRdhdV40LXhZKDDzy5Vq0oek
         TeQw==
X-Forwarded-Encrypted: i=1; AJvYcCX9VlZe0GifRzIcX55mXOn6xnPfx2CKH3gWwmQeASrv1I4LY26buWJs+2Ye5sPwjRk7+33rIFDnwDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDx/d4QFixija8tRMYhzMLqlyBi+OwQliz7z0e/avvZTH+s6I
	lA8BsVS8uozJTUZ42BOM8WTo1vrJVYnWxw3rGIa3eH5nFPHIl5b18QUxW/9JNd7NbQ==
X-Gm-Gg: ASbGncuntkyNjhpVy0hlvohuM/lWBWWkQqcbehIR+mF4mTN2vxu3mBAl6Ow/JwyNR46
	lB/Ra9KMgl/FJSEqTAxpoShT1YR1k6YoH2oG78CybzDsXDLNljf/d3kD3fTS8h0r89Nt6q7gcJO
	iEttKlQ+bihzIEgASPN5cl7WWNtUG58bUAAUKxGcghFDnxLdLcisJX8sa5l6laQFkI4M061OzwC
	pZWKqN+DkGJ1SC97rHcUGVPH5WkWFGBJSgaI2iuy1CawBUEjnHt+HKOVahwYwfUUizcnPQ/9H5c
	kEbG99jdbV2MrGpABVzTt5xeIxJysI/3ywhcFjM9mLgDGIs0JO9WndctwOBivA==
X-Google-Smtp-Source: AGHT+IF6wbdIM8c2CjcX/ocU3SdYeIxoMjW1IacP2Y1Yyeyofoj9C++nm+2SB3Ttqixw0fc2TFEcVA==
X-Received: by 2002:a05:6a20:c909:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-2188c210411mr31111245637.8.1748507412113;
        Thu, 29 May 2025 01:30:12 -0700 (PDT)
Received: from thinkpad ([120.60.62.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff727bsm828466b3a.161.2025.05.29.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 01:30:11 -0700 (PDT)
Date: Thu, 29 May 2025 14:00:07 +0530
From: 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "kw@linux.com" <kw@linux.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "cassel@kernel.org" <cassel@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Delay link training after hot reset in
 EP mode
Message-ID: <hd5jw7d2n6kblxmyowvbikhrngbwmca4vh6wft4g56wfayiwo3@ygfap7z5lbdm>
References: <20250522123958.1518205-2-cassel@kernel.org>
 <93692bd09d8515da1506fe89b82caf91ea1012f2.camel@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93692bd09d8515da1506fe89b82caf91ea1012f2.camel@wdc.com>

On Thu, May 29, 2025 at 08:22:51AM +0000, Wilfred Mallawa wrote:
> On Thu, 2025-05-22 at 14:39 +0200, Niklas Cassel wrote:
> > 
> [snip]
> >  	/*
> Gentle ping :)
> 

Please give atleast 2 weeks of time before pinging the maintainers. Also,
the merge window is now open, so there won't be much activity until -rc1 is out.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

