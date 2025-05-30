Return-Path: <linux-pci+bounces-28695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656BEAC8706
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 05:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257B27A2246
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6D188CCA;
	Fri, 30 May 2025 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5ZTjYkU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D7A92E
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748576830; cv=none; b=h42zTZuFP06AJ+UWD2Txc1rJ17EaLiCq98LQxFe1k8fpO4HVcnR4dQeh0sqpwKeczhaCUwMaDASuJ18EO3JUL+lTFrsHW02VxoUIhs+edKPyW7Xq022ojRweXSRKJsGPa7ImB08sCKW8wMTjANE42crOG/lN5WiKBbT1vrpa2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748576830; c=relaxed/simple;
	bh=c3oROZAnmot2cTBZHDWM/GZvhkiifzhaYpmj0YJf/qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfBEnkDDDBGMHcsofxVzObaBcfFrJWVs+K4KpLUVO1m66LgcX9SOd/jOT8iO9lw1AWuY80+fTymop1KCj5Q9t2skgjvIch7smvkvwJiHnCOcQ2Jj44aIz49+YyJ9gvpBVR3bWDYIR8oObf9KiDFzQ4WXBFd/46bAJgEu/HPpHqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5ZTjYkU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231e8553248so16019745ad.1
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 20:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748576828; x=1749181628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zYT+yS9DtEtNjftxWM62aj+gh1F4QDHmOM8kYqFz3TY=;
        b=Y5ZTjYkUqM0sAka0QBTlw1e8PjTchvMbArvtvC0NNzlyiZ6jHLkxfeN+wKPMpCZbyv
         DD0/88ISc8ZrIJdG5C+waHncCkxBa5UMlk1a5XEnRjbivugUXzw2QZgx0RepPtawrrfO
         0ws9MBOJp5mrsfO//q/dxDHDEfL/6vnLQszggjRcr5J8KUpp5RZjuIXZKb5fiC80UGoY
         7zxlnvBjrccpZPGmiApSxBtn5vjDPMJuxBBExgj2vq1LsyjkBmr1bIs9s89hvurJHktZ
         SftkG0XEhrJSaSlRelwAsHWphRmPuThhaVlsJZQb8BiAywEytE0uD5p6M73RY1g2ZlTM
         0/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748576828; x=1749181628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYT+yS9DtEtNjftxWM62aj+gh1F4QDHmOM8kYqFz3TY=;
        b=HLduCwoK1c/y0+d4L4lD1qiY0s7wRPC5MIQKREnizMg6S4jzV09JLHEmKYlZIK3mnO
         7HpShmuBvdBMr273snyVTFNDQa+zJc8dhvJmAMu9aDba0PsH7KXMe4pAIDSVOKeGfKJx
         kCO6dd0ibxFzrDsjlwJAqThI7tRON5UuCvfwP/6btcYnL7UtIR8D3XKB8+Vk1ERo2rZl
         V+CXSCnk8yTCtJKbpffZCaI+LTxjxgGFoc3dc1S+MeTfc53FkZjHI7aCyMTGsHXlkd3F
         DHoMh9Bawn7QmN4U9n+T0mlMMMs5yoi/uqbl+B25I/01VxtRqpnK844maB11w2M4kfkW
         dVXA==
X-Forwarded-Encrypted: i=1; AJvYcCW+yU77YarwHnTETfLhcuUiu3n5qKF5YNaTslspEhU4q179sie9ktSntikIppvVn0F88l7aYL591Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTp9zvIkF5+lvc2kSyqXGj45szgy9krFInDsZMgTeRSlS/ikK8
	R5t82bBc/mU1CSOBRsD8SZ001Ao5k3p6ekyntI6pndJ1RllNIMcKr7HpmbbpPeXA3g==
X-Gm-Gg: ASbGncviUcyJrY8hO/VrRP0KAMCIkW8lrXBq0cj+3aDb7IwAp3JAIR7LyPm0mukD401
	wa2KKcUXiBldKr2wyeQSTJcHq3/c779li/+YErekFwD26+1OU4NJScszqMaaIikoFuwqKuSEGL8
	PqqeSGLgcGcl7ZXiMuDjdSvYuet/UKnoKG7/gUkH3shXuhXAZX1H5z18VATH60NPmG8P6p73TWf
	lohaYy8aRGI6ziyBxTpmvNG8GkdB7ufdIt66qOsug1NdlpgP676CgGoFmEWp1L0ZxGQyxAtNfJD
	mQNS5A2oSbpfMLbI7QSpOX4s5iqy/QR8TbVZRYwQrkx4ttpAJjbvhmPkRY7Upw==
X-Google-Smtp-Source: AGHT+IHUystiPvDn8wtXmAxatZwAwM/wyWA7RAF5uIDmvCTdpWPCHf/AgW9Un8RMnzAXGJkMNGGi/A==
X-Received: by 2002:a17:902:f711:b0:235:1962:1c13 with SMTP id d9443c01a7336-23539563146mr10695205ad.14.1748576828510;
        Thu, 29 May 2025 20:47:08 -0700 (PDT)
Received: from thinkpad ([120.60.139.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3c236asm327042a91.42.2025.05.29.20.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:47:08 -0700 (PDT)
Date: Fri, 30 May 2025 09:16:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <fr6orvqq62hozn5g3svpyyazdshv4kh4xszchxbmpdcpgp5pg6@mlehmlasbvrm>
References: <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
 <20250528223500.GA58129@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528223500.GA58129@bhelgaas>

On Wed, May 28, 2025 at 05:35:00PM -0500, Bjorn Helgaas wrote:
> On Thu, May 08, 2025 at 12:40:33PM +0530, Manivannan Sadhasivam wrote:
> > The PCI link, when down, needs to be recovered to bring it back. But that
> > cannot be done in a generic way as link recovery procedure is specific to
> > host bridges. So add a new API pci_host_handle_link_down() that could be
> > called by the host bridge drivers when the link goes down.
> > 
> > The API will iterate through all the slots and calls the pcie_do_recovery()
> > function with 'pci_channel_io_frozen' as the state. This will result in the
> > execution of the AER Fatal error handling code. Since the link down
> > recovery is pretty much the same as AER Fatal error handling,
> > pcie_do_recovery() helper is reused here. First the AER error_detected
> > callback will be triggered for the bridge and the downstream devices. Then,
> > pci_host_reset_slot() will be called for the slot, which will reset the
> > slot using 'reset_slot' callback to recover the link. Once that's done,
> > resume message will be broadcasted to the bridge and the downstream devices
> > indicating successful link recovery.
> 
> Link down is an event for a single Root Port.  Why would we iterate
> through all the Root Ports if the link went down for one of them?

Because on the reference platform (Qcom), link down notification is not
per-port, but per controller. So that's why we are iterating through all ports.
The callback is supposed to identify the ports that triggered the link down
event and recover them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

