Return-Path: <linux-pci+bounces-28317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD2EAC1D2A
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 08:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1AA3B0E1B
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2679137C37;
	Fri, 23 May 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E02NE652"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296EB2DCBE6
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747982353; cv=none; b=CPB3a99jvoFTY3+n95S83c41FlASqnyxD3b6QHSX6QR5La4ocLgDZzbVj+++pHy1yAnZOgxd9JqAm3q54P2Fw3kjW5sMZUeRJfeIhqOWnBzn4E18w1favIejQGcNjkZ0nmBgy3Xh7n4byUcC8wWrfjoJAhcipubh4iM5YBrh4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747982353; c=relaxed/simple;
	bh=0pxLF26Jo9DIFeKCrZ7GRQVjK6Xr/+re3dCOYxd87H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cba+o8nm0teXT2wXDIWRkgX7FVx+LUFUtLQT8DI8zpwv4aDFjSZDXDjlM0Fgtco1mVnEX5WHssG9xTHIhDMQ6tfYLcTsKRoP/xilQso7p+wwM4bRDswB/sre+F2N3FJa6ofmjJgR6Dsd1Sa0myBuGhBNJLfc4PMi6AnJKMPqWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E02NE652; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c336fcdaaso70327535ad.3
        for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747982351; x=1748587151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brshj0gseXW2CV5izusxFpOzrDXqf5/wn8E3ItjH0mI=;
        b=E02NE652UUs3bpZtCMTq3KJ1nkvo8zxPNhj85XwxU9vK2OUFr0KRsYcciAaM2S0S9a
         NtRti3yrqlxe7DTWzwbXBJB4UXcOCwG2y9kG5wvpjRsFuRty/qc4UEW/S8/EdSYsJaXw
         zW0Aqu7eAnR9XoqOSZHlB85848rjSpJM4c0Yzz9fXXTUyK/PbPdSSwBOPu5rYpCrHNAv
         gc++5lrqkrkrI1Am4jTP7Niycq0h7JH2/67CvMTjRtUxVGI+TNqmHLlcUcdbj13hX2KG
         GGpBD8etiDVoRO/awXWGb7qFBQXR6N/77nyERIE5vxdknuetFhGZJ2qhb3H9LOOjO1CN
         kvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747982351; x=1748587151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brshj0gseXW2CV5izusxFpOzrDXqf5/wn8E3ItjH0mI=;
        b=U/S37Ks8haFRiwENnBF+9fxAmMRQXoJ6N5uPBVVhTWwsAe+Sm6jFQ7jf+YeuMpoiAg
         jGxl+sNVqfMg8+WFmQINqSVhI/5GspMc1FvLmmL4YTTJjjewm9B3Lr6ttN/VVkUsLI3V
         PlHA1QUgxkOa6vBjyQ0FVyBZTONDsW9ASlKWqhY0ejOZQ+dTNAPAn066hiBAWq/p2XPY
         77fxlWoELXqrGzMrWzx/Wpo0fscv1+5OlAtAy3NpbYZBODgXZOywWS76Y+jPc6BwCQID
         y4eMZTgITPc9lfrrYhO1zqsv7jip2gRauKscGsXVuq8cJlvD9lKZ5nXL6KE9Syv0PnRI
         KjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Fe/V1BL8evL2iVHTzbPMzYl4RXEjULGII3NzNIrPwcCZI7dlVotfrzxinThky8q6hugYWNc1IuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Gqvblqa+fHVlxN9otyzYKIfexPSFNMog2Ah/dfLzHGhABGba
	Aap4sUH3IlzcZs3NC5IGcvmg2Zn4J5YC9oyFTHHb9Q0ROzPVhNbpUs+mJtMeoPr9rg==
X-Gm-Gg: ASbGnctZCBKKlI43rYh65lg0A6MGqZ0kb5LflCE6+L8DMvGSCvcpwie24bHxNmtnFJk
	OQRHcEyLCdZQAeF1obnSoYnpnu4oBKgMkERKod9wDIFJhRHFhS2tHNiIAdMJMwgPG7BU71Xwf60
	8cKzyminoViVBRWffB2lylQdNVPMB4KrmxX4CNiCD7+k0tIvqEJrCrDF9/Sc9GR9RHGEs1AbH03
	6CFqFPGV6z9f/6mxvJtYAGQyM/rO2NT/RvVK3VPRu7KQ2SwnZ1lbTtdakmntbl956fjlPVUlSh8
	hw/RtM7XbXeQIleoJGGFlzM9TECAw/NhZHU9y3uX23dz+BY5FN27kWt/q2fOS+U=
X-Google-Smtp-Source: AGHT+IGro3SvahJ32aGTIZk8tdsp4xH/p4DFn51ZTPElvHR9K2hMZpqaddrYeTN1doCL7gjRY5M6dA==
X-Received: by 2002:a17:903:2343:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-233f21be87cmr26405065ad.2.1747982351310;
        Thu, 22 May 2025 23:39:11 -0700 (PDT)
Received: from thinkpad ([120.56.203.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adaff9sm117298335ad.58.2025.05.22.23.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:39:10 -0700 (PDT)
Date: Fri, 23 May 2025 12:09:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <hqdp64mksr6whmncm5dhrjima32v5oyng4ov6hdklcamqtm4ib@prsatdutb5oj>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDAInK0F0Qh7QTiw@wunner.de>

On Fri, May 23, 2025 at 07:33:16AM +0200, Lukas Wunner wrote:
> On Thu, May 22, 2025 at 06:19:56PM +0200, Niklas Cassel wrote:
> > As you know the reset_slot() callback patches were merged recently.
> > 
> > Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
> > reset_slot() callback has been invoked. The issue is reproduced when MPS
> > configuration is set to performance, but might be applicable for other
> > MPS configurations as well. The problem appears to be that reset_slot()
> > feature does not respect/restore the MPS configuration.
> 
> The Device Control register (and thus the MPS setting) is saved via:
> 
>   pci_save_state()
>     pci_save_pcie_state()
> 
> So either you're missing a call to pci_restore_state() after reset,
> or you're missing a call to pci_save_state() after changing MPS,
> or MPS is somehow overwritten after pci_restore_state().
> Which one is it?
> 

I think the issue is that the PCI bridge is getting reset while trying to reset
the PCI device. And in the reset path, we only save the config space of the
*device*, not the bridge.

As seen from the lspci output shared by Niklas, the content of the PCI bridge
seem to be diverged. Since the slot_reset() callback resets the whole Root
Complex (if there is a single Root port), then the config space of the Root
port/bridge needs to be saved and restored as well.

I believe pcibios_reset_secondary_bus() is not supposed to change the config
space of the root port. As per the definition of the "Secondary Bus Reset" field
in the Bridge Control Register, r3.0, sec 7.5.3.6:

"Port configuration registers must not be changed, except as required to update
Port status."

So pci_reset_secondary_bus() is not changing the config space, but slot_reset()
does. Are we plugging slot_reset() at the wrong place?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

