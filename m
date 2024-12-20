Return-Path: <linux-pci+bounces-18909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060D59F9243
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 13:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF3E7A152B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BD215195;
	Fri, 20 Dec 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncsKx/7y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AED2153C6
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697952; cv=none; b=n5swAWgHhQaQCYX6Heskj5Dpt+ovKIGmO0ahIAbazRZLhNZnndnqxcye21XgoTJ82DRcggFlFN3tRTQpv17bP7I2lQysKBlWnPkWmeDXaQowCOtkmT5u2iT0GzQVZ1xVZmAho6OObqNL2Emhil7FwPtV2CnierlW+8/varpXybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697952; c=relaxed/simple;
	bh=vk07zozYwtpe1+cPc2KclignhFvzpMNco127jRDNi0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bva03VZsjJQbxSjfJScLvAxIX/AXNPOSceF879BTNB08HTISzQtz9YvkODsQkHdXOXi4OugWgXKoOYhzPhekloU5oJL72Ij88jW18EjLuc9uz4CWD12OfaHQPW4+H17Nr79J4bSCMB/ExtUfGgSl52IlpU6JK0/0zZzC4NBq4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncsKx/7y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728f1525565so2214648b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 04:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734697950; x=1735302750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZQLvxQfbQ2yfFsFhMBSf4jBM/n8hKFCqlH/yM+9TIA=;
        b=ncsKx/7ymKXevAcY0rGy/CfuvzxFy2X+gq9TgrpRd7SNNO2OGEyrNeiLcwOoo+je+n
         bDEbP4fzEtW4aTItPh5QrPsi9J+OAZ+KCrBiPlj6sJtjEifhBHEalko0vEFPE2go0VVj
         opxIDTSfO9Gk6rCE7oBnFIxddDin3x+V56mQhYQFI7758cYIvzp0inDYU1oFCrsGjWuM
         7m2mQYzHqCwpQqaaWYwQwCwbn93ezjftqPUODpHmxVvbowzgPKaGWY38aUhIof4cqQ2A
         iKXayZFvtThcb/QYVIoNekUYuePwXGZeV/zWzRAimJv1Cagzb4kWUQkZoSGvXymTE8ym
         n+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697950; x=1735302750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZQLvxQfbQ2yfFsFhMBSf4jBM/n8hKFCqlH/yM+9TIA=;
        b=eV1tdFdmhhz20IGeIXqYAjLu37bLoq5jTUAiripD+EQT59KeP2TG9AyIDfGAzDMM7V
         nje2LlAB71/BzV5ve72bmBRs9+FN8RY2P76q6hMJOekWi9ecXddWkvqE32ghHEiHnMVr
         b1/h25Yn2x6wX+lZRva2m2MGwPnvbaHP+Ht4GogZlXFl5gdQekpiT+sgdhsWTTCtPxpE
         m3k2bXaJZ5mtHPolGq5CwadtOCA1+QmMQn7hX7jIO/VW8X6nsANgEhrfoI3CyRKRDEoU
         OlUi7d88ugxViXGt//nul46W25FELbqyhVFhYaNoVBGT90wGKOemWyYlUvFeSSb7RY5y
         X5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWqqaXNl5aC5auP5AsgALHazrLePqbbxwXZxLYSmeB/N21Iw4okUtJHdICsetG3uUQ+Fa20ywGXvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIQXXTLqdsau/nZQsESF/IB1icEE0jjzABBBElneesIFHS2ev
	XuuHa1KYeRkI4ixIbbP2lamWS6z3K1OYg/k0NULaylcx4RmO1p6KgawmGkc1fg==
X-Gm-Gg: ASbGnctK6scR7iEWXCz4X8zqjqOI/N9o0AAY4sfOKCS/eHWE+OV6Nqw7XqyYygYq9Sy
	sv8LaUvie4Q7FB4tGmRzlUbX1bSUXg7hcb6jHH9/oOn+tGZioUPWXhyy36RDO3wdDDSarg8MY7I
	L1X3Vn80inCMmY9xhU54Zsm087bi212nmQNi7xjo9dgAeb6nDd1/FQNnGhcixULgUL7KIdZ0dXj
	uFNP7wRTE0PLCkx8k2uYxV0XrTAD5Ucx1pyezMePogrKqAfyjCi3UdE4NYGCcvsIdhoVw==
X-Google-Smtp-Source: AGHT+IEW0uspGj9Ws2R06d8k4ZCODLKGf1OyTjKYW1LTMgGOGZCWO4oWUqfBgHV7yU8/7KeFiFsbKw==
X-Received: by 2002:a05:6a20:244a:b0:1db:ff76:99d7 with SMTP id adf61e73a8af0-1e5e07ef1afmr6053387637.35.1734697950010;
        Fri, 20 Dec 2024 04:32:30 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81641esm2970472b3a.3.2024.12.20.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:32:29 -0800 (PST)
Date: Fri, 20 Dec 2024 18:02:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Message-ID: <20241220123216.za6kzma4q2kyfhln@thinkpad>
References: <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
 <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
 <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>
 <20241219112051.pjr3a4evtftlpxau@thinkpad>
 <3bbb298a-6f84-6be7-69c6-eaeaa088cc0e@163.com>
 <20241219133545.jiyqdzbkpwfu2rcv@thinkpad>
 <44c74561-a4db-4550-a07e-67f51556dd03@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44c74561-a4db-4550-a07e-67f51556dd03@163.com>

On Fri, Dec 20, 2024 at 03:27:22PM +0800, Hans Zhang wrote:
> 
> 
> On 12/19/24 08:35, Manivannan Sadhasivam wrote:
> 
> > > We have 5 PCIe controllers, and if a few of them are not connected to the
> > > device. And it will affect the boot time.
> > > 
> > 
> > Why are you enabling all controllers? Can't you just enable the ones you know
> > the endpoints are going to be connected? I'm just trying to see if we can avoid
> > having a quirk.
> 
> Our SOC has a PC product situation, and there may be PCIe slots on the PCB,
> but the device may not be plugged in. So we need to enable all ports.
> 

Since you are trying to fail probe for the unused slots, your hardware is not
supporting hotplug as well I hope.

> > If you do not know, then you need to introduce a quirk for your platform.
> > But that requires your controller driver to be upstreamed. We cannot provide
> > hooks for downstream drivers in upstream.
> 
> Our controller driver currently has no plans for upstream and needs to wait
> for notification from the boss.
> 

Then the quirk patch has to wait until your driver is submitted upstream.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

