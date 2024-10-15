Return-Path: <linux-pci+bounces-14513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DF99DDDE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83D42856AB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 06:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78D16F0EC;
	Tue, 15 Oct 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eI16IcRj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48471EC5
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972068; cv=none; b=gMsEfMPJZj4fjxlfAJBDjt8ZcR2a472YHwaSpWnbh312+cVAeRMQRpjkqUdDVOhpWgu4Rj9QZoJLadTt2DHzLZLiT7SmxzICp5ZEo6He9sKTzg/ENlLJcOag6dBxK7bMN0oz7u1MUoHtNx4Ukpe//hCEH9Ama1tb/JnYH2EP9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972068; c=relaxed/simple;
	bh=OCZF+ogb2gFJ0Bl/bkyA2jV14682B1nBpxJUHoiauSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R68pwo5BHMlsIOPXFlfNQgSlLko2y9jhdsFISDFJY/wURtQN4uLIreeJr8zBK23oEWYlcW1Jl950d65B8l4V6Hxq1qHy8rscBEciPq8r3cvQ2FnDjH+x+DTtvpYFvkeFF7wo3MtsVvqZpFa/OmPoodBeFXZzsA0F6uF8VSncNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eI16IcRj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso3139453a12.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 23:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728972066; x=1729576866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Ek0kKp36+dCaL9+v77MGUZt4oQavlbqq5pWMXw8Vu0=;
        b=eI16IcRjQP38SHMQHor1/4clhQGYWmpBgjwp6jhuq4GwBysMXpHWTTBbbQmpuLmsgP
         p8P1fBt9jEHo+PUbVY+p/uyD08ZuSoSl8f/qJ3BAo7x3uO9lRdvfMYiu8d2SY0dIROVy
         u8/FB9NhYvzHjQz+waDtiZsLKF0Lq5bQ0wFOeX9Z/jxdVym38Pb7s3SRdu4nzkeOgVDH
         J6y2ORqPe3T4H7xBtTwSZPjN0shvuunTlCJSjhDQL3QHmVli8J4nS1llVqsH5WXoiAjU
         FWMm4bg86/pre9+gHEU2gc3IlY/ODY9xwkaR4Go6kvRnGQgIP0Cw2v59f171rdqy8g6S
         j/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728972066; x=1729576866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ek0kKp36+dCaL9+v77MGUZt4oQavlbqq5pWMXw8Vu0=;
        b=bo34xwvxZ4AgIjLTYx/rZeeYJ2FtIX1yBI5KAJmJZSZ4+jlaYNcfFrYPRW4ftfJY7m
         7cpbEEGjQBLPGam0Buxs9j1MVEoPBALvQWbjybx5J6wnhPYeTC7UMGZYGy7lFd2FQBbr
         /B9kCR70AK2sNetm1ZUZyYR549UBXmTX+/T39WB3ikhwP0q3dlYVF9YG8eyNeNXkgS9f
         ecw8DVlZMsdYJK8UwJe3Rf09b+vsn5GWczscZSXq5Psk2PxloDqxjjS3P9Ni397CWNfg
         D9fTQRp6A1zTP35J3yh5/mKtSKaZLxbITcDDaDCYounIaFfXZKebsx18T6rxCgOemH+i
         WyKg==
X-Forwarded-Encrypted: i=1; AJvYcCWUniRvnPo5nZIVDBJ4GgpBMxxqcpDmaEjSa6icCSsOr0ep93/p1xHOK7bNzezRn0bwt90amMxHuME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjWJ1m7zZGqzV9Jb3yBGf8xHseTf7JjKrH2hRdSPCpNWp2flFL
	0q23MKsNGaszs6M6bra27zEJsoAKXOQuUwsg3H/qYZgpuGd78awic6NA/9NFOg==
X-Google-Smtp-Source: AGHT+IF7DvcQz3KWfA5YDflWesLCWqoXgd7MJN7YAuPU0ZcZGc9DXmQFXHfHfffYl0G046u/bk2DEA==
X-Received: by 2002:a05:6a20:d81a:b0:1cf:3c60:b8dc with SMTP id adf61e73a8af0-1d8c96906a8mr14215378637.34.1728972066465;
        Mon, 14 Oct 2024 23:01:06 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c71320bsm535828a12.77.2024.10.14.23.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:01:05 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:31:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v6 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Message-ID: <20241015060100.kvqw6jzrdf2fdro6@thinkpad>
References: <20241012113246.95634-1-dlemoal@kernel.org>
 <20241012113246.95634-4-dlemoal@kernel.org>
 <ZwuNjwdRLKsaM1Sd@ryzen.lan>
 <5a770af8-d901-4376-ae5b-2ea28893a7cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a770af8-d901-4376-ae5b-2ea28893a7cc@kernel.org>

On Mon, Oct 14, 2024 at 10:09:23PM +0900, Damien Le Moal wrote:
> On 10/13/24 18:06, Niklas Cassel wrote:
> >>   * @map_addr: ops to map CPU address to PCI address
> >>   * @unmap_addr: ops to unmap CPU address and PCI address
> >>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> >> @@ -61,6 +93,8 @@ struct pci_epc_ops {
> >>  			   struct pci_epf_bar *epf_bar);
> >>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>  			     struct pci_epf_bar *epf_bar);
> >> +	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
> >> +				  size_t *size, size_t *offset);
> > 
> > This functions returns an aligned PCI address.
> > Making it return a phys_addr_t for someone used to reading code in
> > drivers/pci is very confusing, as you automatically assume that this is
> > then the "CPU address" (which is not the case here).
> > 
> > Please change the return type (basically the same as my first comment in
> > this reply) in order to make the API more clear.
> 
> Sure I can send an incremental patch to change this to use u64 like other
> operation s (e.g. map_addr) for the pci address.
> 
> Mani,
> 
> Are you OK with that ?
> 

Sounds good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

