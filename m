Return-Path: <linux-pci+bounces-20789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2DA2A32F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E66D7A07D4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D92253F1;
	Thu,  6 Feb 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="vuKM3SuC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060E224AF6
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830814; cv=none; b=IiuN5zBWqQkrJiNtC3QOmlt3WqEuwWSXkdsAYqWrKW/NCZHiR2MGKOdfow6PNA1K7TVTEHl9yZjJtm2HKlavY9Pn+EYl6Ep9UQ0qdSDXpAZH4UJ/l5fuNv6koZCQ6mRU8OJiNutMSjFwjlXsHb4cuDejPoWHcW2IS36Qr+b6LJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830814; c=relaxed/simple;
	bh=9g9b7hVg1k4pXSTZtAUsL9yHZfplVe0rwP+E/mjt+6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoXdlTO4KVzO4SdzyaU19LmXDzYad/Y4zH0VqDQ4IEBHQtg9HxEjP/t9cbkSV/wpxX500uopUL+0GW4NkPtxKbkhIsCL2b1hiofDNjLPlNNFGD8WJqd4swFqwFAHm1EKKDdB7r9VX6wdA/8Ai4MyPrjuNSJFTzsIYxNKD7sGkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=vuKM3SuC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f2339dcfdso9201895ad.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1738830812; x=1739435612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFa4VDutdaAqwxVE7IcEmL8yhkUm6WYSGjjVCCVP30o=;
        b=vuKM3SuCH75Yd3OYODa8Q9XgL5gE3G2nCFl4g3YGf39Yxvty/KeQx8hwhHThWoV0iW
         XLXAv14cd2Vga8hfDa0krw871yijOV6ziYxlOJJl7MI1D5XT30Uz6yRUVkCgXKkpmOa9
         gla1/fMNOyqD+R8JXmJouHWO1JmVbQl//Aa94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830812; x=1739435612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFa4VDutdaAqwxVE7IcEmL8yhkUm6WYSGjjVCCVP30o=;
        b=jQk2iAoxqNIhIFayhrQEDbkLpXe7jhWA44oNJ6pW2oS8Z+qfRF7yomRDUXVPTCQvPN
         ypdT+XsM1nE/hjvs8So8d4HFNWDJq3XVEA2g7gFk0+dFqyCgJR4FfCO6wt3L30RqIE3B
         xfi1F51NP/FIy20r9f1Ew/GxVD2czjnbCui4iVMpz6HZehDMHciHJTqfjg52soQPIJct
         YaObG1syGpmoVJ6CgUTsbNDHbwkBwfNxWr4HLMt6Xs2IZ+3Qogz1tLk2lKYljP9DZwQB
         pAo08eX22c6MrLmyvCbUHvbj7ekMcU4yfT7mRYcXfSn79KW0ej3A2zcPSfVisD8V5w2n
         Us7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMiECNfR5PvRPiV4ZOLrhW4rirahVOEUR9L2d+bkTqr2zZeqHg95Xmr2Awfnvi1WTqiYDkHnewLyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cd5pKx2cQO0p60qaVRF3xv69wfiIdTL5wbQwLGQmgtZfNnLf
	pI5bj6+7B+9x9ZHu/BJTwfgh+wUAraKWYvhG1Zrbi/2X7Bg6iGvZ0EGghmYEZCM=
X-Gm-Gg: ASbGnctxxaNjqBfJ0dTLMW8G+RTpUNG6QaQI3Q1QPVm81tkW/l9rypLA3HR9JZFWEWx
	a52gu5C+ibt3Dx7vY+g/p5HkZgC1ubOxzyKrCiOSBPuEA1BpTjpdvWHL4T84dWGTT+RMU4LEzUa
	i3MwhwE4lTxY+e3F9WjcGFlQwM78DUotga+8ZFN7TM6uIInVEtHGzQ5ZoVLq06JvZ+yBcTHDVDh
	3M9eGE1WNlD4Wi1PV1SFJe8b8IB31Ij0IJb0yyDupOOw2ry8S/3yKT2lYc85cIuqmdVRWP4TsoH
	Ak/Sa/tmBkn1R9miCef3
X-Google-Smtp-Source: AGHT+IF+K06oAWXkF0s7xGk9CXHkZ3d4umQ124gCDvUWBbfXf2qnmgVpjF06/0gYCP3LpXrycYtCTg==
X-Received: by 2002:a17:902:e80a:b0:215:6c5f:d142 with SMTP id d9443c01a7336-21f2f1b4759mr41887255ad.20.1738830812389;
        Thu, 06 Feb 2025 00:33:32 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da60bsm7040865ad.258.2025.02.06.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 00:33:31 -0800 (PST)
Date: Thu, 6 Feb 2025 09:33:26 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/3] pci/msi: remove pci_msi_ignore_mask
Message-ID: <Z6Rz1o3CnnuUiaoI@macbook.local>
References: <20250114103315.51328-4-roger.pau@citrix.com>
 <20250205151731.GA915292@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205151731.GA915292@bhelgaas>

On Wed, Feb 05, 2025 at 09:17:31AM -0600, Bjorn Helgaas wrote:
> Please run git log --oneline and match the subject line capitalization
> style, i.e.,
> 
>   PCI/MSI: Remove ...
> 
> But it doesn't look like this actually *removes* the functionality, it
> just implements it differently so it can be applied more selectively.
> 
> So maybe the subject should say something like "control use of MSI
> masking per IRQ domain, not globally"

What about:

PCI/MSI: convert pci_msi_ignore_mask to per MSI domain flag

Which is slightly shorter?

> 
> On Tue, Jan 14, 2025 at 11:33:13AM +0100, Roger Pau Monne wrote:
> > Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both
> > MSI and MSI-X entries globally, regardless of the IRQ chip they are using.
> > Only Xen sets the pci_msi_ignore_mask when routing physical interrupts over
> > event channels, to prevent PCI code from attempting to toggle the maskbit,
> > as it's Xen that controls the bit.
> > 
> > However, the pci_msi_ignore_mask being global will affect devices that use
> > MSI interrupts but are not routing those interrupts over event channels
> > (not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
> > bridge.  In that scenario the VMD bridge configures MSI(-X) using the
> > normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
> > bridge configure the MSI entries using indexes into the VMD bridge MSI
> > table.  The VMD bridge then demultiplexes such interrupts and delivers to
> > the destination device(s).  Having pci_msi_ignore_mask set in that scenario
> > prevents (un)masking of MSI entries for devices behind the VMD bridge.
> > 
> > Move the signaling of no entry masking into the MSI domain flags, as that
> > allows setting it on a per-domain basis.  Set it for the Xen MSI domain
> > that uses the pIRQ chip, while leaving it unset for the rest of the
> > cases.
> > 
> > Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
> > with Xen dropping usage the variable is unneeded.
> > 
> > This fixes using devices behind a VMD bridge on Xen PV hardware domains.
> > 
> > Albeit Devices behind a VMD bridge are not known to Xen, that doesn't mean
> > Linux cannot use them.  By inhibiting the usage of
> > VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
> > bodge devices behind a VMD bridge do work fine when use from a Linux Xen
> > hardware domain.  That's the whole point of the series.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Needs an ack from Thomas.

Thanks, moved him to the 'To:' field.

Regards, Roger.

