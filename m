Return-Path: <linux-pci+bounces-25924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A9A89F81
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242DD188C2CB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C01537DA;
	Tue, 15 Apr 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdVPHELa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF21531E1
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724006; cv=none; b=Mf56ouDinz0XsXKOIYMXHuDnk6PJ9AZTaFRlqXd8FB4mJqDl19Q1fgMXGcuOP0n2fKbQAkCEAbT2Zg0QyezgTp0tnKWPGL2ODTyMhE1l3TPrHtODdsH2tw7KACRCzh1t4WMIHIJ2jzmruVLGC9L+gW7lVutfLHZVG73/sc6dU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724006; c=relaxed/simple;
	bh=ek3xtokJGLel1uaqoh04AFgye1w5Sn7lMzo5cXs8j9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGhnosjd4FRcOvA/goAQGaNkav0OCmVWukkiN+ZXnMoFQCfDtAIqM77t8A12BP7koX6W5QlFOXgrRRsdU7NECGP2TYw5ZFnB2chwrOIgfC/GBVJrsHa+YEuZ89/IElGGx+lvSL4Kx0/3oTMRprZ/qKeym6PhI2QNNCgv0bP985k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdVPHELa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2255003f4c6so56978575ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744724004; x=1745328804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kb+FJnw86VvRtE36N+d+X7ug1k6Yvpc1Ae1wFjKr7M=;
        b=rdVPHELastes4u4eSCnFjKQw7B7P1s0RLzwNZABoObyN90lgUr5+TurKQ69r8n2uXn
         MHfg47nAbXTfsR5LSyIwD1VE8xH+d3zDPpD2ftrh6x4rmzAt9GS5lYrfHTFI0GP+MSXs
         iiz+QIzVLYV1dh3p7zlsUdG8PBly9+putZ3XLh5TuK+Hr4FwPcprVneTuvCB78am3MEU
         14kclh2tkbfi05PNLtYeT9P8qihEI01jMm5iSyDogKOM6vjD3fv8PWcQcu6I2t3o4fPU
         oPZ4CNqjtSUHj34t/d6mOxgOn6KLFXI5fgfno2DhBmqZ/wB2M2ykRhUB3oHaeJMZ09eY
         GTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724004; x=1745328804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kb+FJnw86VvRtE36N+d+X7ug1k6Yvpc1Ae1wFjKr7M=;
        b=CChfusMn86+lS8SU8t2ULzcI1YESP7xNPgIjmxgBaeKNSRrs7FG8tdfN3QlbjWkfZr
         Z3vNMuAnlOafRcYvqZvFJxaJB2EBeymV9LAAgDSfy5AmxMRcpqdNuhn99MqyPXotzSte
         NAvyaP4wH/B3Qhls6vhR0EPRyE5CKBtREv78AKs3p1NuLj1IpEApvwzgL+nU+KGv4au7
         nhpKVfeUaE16n9p2p+0VLBnJxDz+cPHgQAc5aVw6bzPD+rQezHvUmekFUVvn49NDzQPT
         4e3xkVcm3Bx+h6imxHmJBVxhfEzrBjusYtzKC7Au3NFfHEJAjqnQjEvAMnTH0gTZgYYy
         Crtg==
X-Forwarded-Encrypted: i=1; AJvYcCX/8ow+TTZC/5QDTOkDUu1uvehqkdnK3IiPD+dMfwGYVLMsqCp+LzZTjAMkAvtC3mm3QgBIPoht5WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8OkzD1kE5ogihT4BN8UikbgssAMtBwBTmd7jbdMY9C8P43aT
	7fWjujxiaRDB+yqOssPJT/tKvZnu/ipozlbbkHjRi/GYMfV8WccriTaHoUgEuA==
X-Gm-Gg: ASbGncuF7rYoAIE32c9ackDg8uXD0PicYBCQasDYq68hVIxhfvi47jQ4qQDiWF+4cg8
	r7zU+CEs/G3ETqOENIo8v8nRtfT/Yx5dxvspLLAcinqgxkbscK7ib+6cblMQEupuBG5scQQWrRD
	AVBCRwUz2fHQ1QFYeQKuYdXvCdl9YOi8ybIsb6SeyHVA/iYeM8M9y98sy5UUilnPVojuQZwBjG/
	mG1P70femVaRzI26MR9pDQKBI+l5lrEO16//70CEvnPH2YjzDR2IEetO6UrT+xGhth6DwDDnjN5
	Hb3d1cbLuUIFTJlCkSxsFNntp3fdTs6nFGtktW7oK7UfxgERnw==
X-Google-Smtp-Source: AGHT+IH6VniJgzO2ge6ikLonScHc+/MusL7v3em7u0V8pMku3ZWCkwH976lsW0jgobFIzeciiAD5CQ==
X-Received: by 2002:a17:902:f705:b0:220:e9ac:e746 with SMTP id d9443c01a7336-22bea4fdc7amr267687405ad.53.1744724004231;
        Tue, 15 Apr 2025 06:33:24 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6876sm117199985ad.181.2025.04.15.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:33:23 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:03:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, dingwei@marvell.com, cassel@kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/ERR: Add support for resetting the slot in a
 platforms specific way
Message-ID: <3dokyirkf47lqxgx5k2ybij5b5an6qnceifsub3mcmjvzp3kdb@sm7f2jxxepdc>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
 <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>
 <Z--cY5Uf6JyTYL9y@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--cY5Uf6JyTYL9y@wunner.de>

On Fri, Apr 04, 2025 at 10:46:27AM +0200, Lukas Wunner wrote:
> On Fri, Apr 04, 2025 at 01:52:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > When the PCI error handling requires resetting the slot, reset it using the
> > host bridge specific 'reset_slot' callback if available before calling the
> > 'slot_reset' callback of the PCI drivers.
> > 
> > The 'reset_slot' callback is responsible for resetting the given slot
> > referenced by the 'pci_dev' pointer in a platform specific way and bring it
> > back to the working state if possible. If any error occurs during the slot
> > reset operation, relevant errno should be returned.
> [...]
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -234,11 +234,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	}
> >  
> >  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> > -		/*
> > -		 * TODO: Should call platform-specific
> > -		 * functions to reset slot before calling
> > -		 * drivers' slot_reset callbacks?
> > -		 */
> > +		if (host->reset_slot) {
> > +			ret = host->reset_slot(host, bridge);
> > +			if (ret) {
> > +				pci_err(bridge, "failed to reset slot: %d\n",
> > +					ret);
> > +				status = PCI_ERS_RESULT_DISCONNECT;
> > +				goto failed;
> > +			}
> > +		}
> > +
> 
> This feels like something that should be plumbed into
> pcibios_reset_secondary_bus(), rather than pcie_do_recovery().
> 

I did consider that, but didn't go for it since there was no platform reset code
present in that function. But I will try to use it as I don't have a strong
preference to do reset slot in pcie_do_recovery().

> Note that in the DPC case, pcie_do_recovery() doesn't issue a reset
> itself.  The reset has already happened, it was automatically done
> by the hardware and all the kernel needs to do is bring up the link
> again.  Do you really need any special handling for that in the
> host controller driver?
> 

I haven't tested DPC, so I'm not sure if reset slot is needed or not.

> Only in the AER case do you want to issue a reset on the secondary bus
> and if there's any platform-specific support needed for that, it needs
> to go into pcibios_reset_secondary_bus().
> 

Ok. I'm trying out this right now and will see if it satisfies my requirement
(for both AER fatal and Link Down recovery).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

