Return-Path: <linux-pci+bounces-22199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1FA42053
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32163A7EF0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B73221F22;
	Mon, 24 Feb 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAxJ2rvb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D621931D
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403119; cv=none; b=KN9CFrNnqFz7SiJqRAZDaxuwyCIBUvM6z3hajss9bRUCrqhj6pVzSItFuvTZe+e258bPVFEAdGc0h3oxtQPrdqEkjzEhe72cF4tqk8vx0b9fqxRB39yiTKow3T6dSPzQp08+LAmYla6APHKqs3uWK0Z/+dcVBMsVAn5mqb6AlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403119; c=relaxed/simple;
	bh=fNa+Fje4u5U4kKO96MlUIKlJ1Y06MQa74J2F7X8Hquo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1YrBoly4LqCf9yUnMx/D2s03uE4gybOD7LTVg0g7c4kyPAkFBsVd/k1nMkTqcp5AkZu6DEVuikftVY8Iio2493/r575j299R5H3WXA1o2s0eFb8SjDqroeV7yOERTGjGw8u7pLJx1TPV5UhSC/rKI0wUVjSV/dDUyt0/khaBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aAxJ2rvb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8f38febso90893185ad.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 05:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740403117; x=1741007917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k/zBjsZQTLhBnhqIaIhHUuRmEg89TnatJo/+jGRcKh4=;
        b=aAxJ2rvbz07jAWAoa4VX7OACaupmfEvrCjnYyQe2ZEnCmt2GF0EM3JtkbasbdJ40zv
         rF3lbzbEkz/lBYDRRciv9vIaXXyGgcy/NyOwZtB6lzyy8gIFLUkYJbje0eErOZYHW9um
         bs26DL+2s403f5mz5cFbr5FUAi/LKTItHomdCF4LsaWPvcdjLmubyVlTiRqZp7j7AEBo
         JmlUQlKmgQ0c4T9Z6X7tdyjLfIwl0wfRCY0Tu2ZczH6ncoYATwmE8gmfO6QgNMgQ/lCt
         YbXlA9HvPFZrPEdZGb63EZjb3ha06VCqZCXTjaOnmfMIW2oyEHl8ykZwduh1FL/rdSm7
         Jakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403117; x=1741007917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/zBjsZQTLhBnhqIaIhHUuRmEg89TnatJo/+jGRcKh4=;
        b=ckdeNGHjaeoTAja0nqr3mKl2uDZ8OM+c6LDinA/ihOoqkwIo4QOHUYNjVkck6Y0u9y
         0ACHA1PZix2V04/cBFv/7qTVsyaUYOvWIlMn+X8htEsOEhvua42AGLD00n7L4jEAAbVR
         AZnXVWpyaQg11CfzpiQuXZFg3tETwvu5ljxrqOZZm7/FG5mt4nPLcZhQsvPu5jvCgO3P
         W+9JWtTZVfQalgm3V488CdvZDr6jcnNkGou40ZiCuTx5LszMtfYqwweMIsy3TG2nlIyZ
         pg8Gc1qCPcd0UXVadnbJkQ6L2GqOCltF5cB58rVWY3RRYCSj85tDIf4xvumiVPNAcVUk
         JRfg==
X-Forwarded-Encrypted: i=1; AJvYcCVsOeGQuRyfGIXTVNh/XXhxtDalPNSaZ7pMkZEvVcyeLe9wsLJ1YN5LeVNmZXb/DdK4QC6RS5Fp2F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSoErs//YeG99NwXdwpZzRotq/93b8SqkJSkN68WOe82rtoS6
	wpdbuDXDBKGt7MfOJan48KXPlkcfKrTOjWZWSFe/lseXQlfFkwRMXwNH6SuBtQ==
X-Gm-Gg: ASbGncv6ZRPe03MILCDIOc93jenl8MgKDeNKsZK6yp2zONeXMpwwa5wsu/tjWGmCpVD
	89Ols11ZqHCWhBN8x2Az67+z1Wu2czwWATnN47JWVQQM3ABEQjLzHhdIqKvWlDN0VRe0tblLI+S
	lSDmRiD6r1m4hR07FmfSJiNPpxAUpwQH1KD8mlXQfLgDZ0fY1oC3EvK2t3DGnncgDl7ISf+GZHH
	Wl4A1tn4rWqalRbYH2FfV/+v1jU671GWfeInr4glc8xOtdOYPT4g5fhUxKYaK5oxQRLEuyKA3Th
	MDRvkaB4WzHh1QdCj613tzrGX7F4x38a5IFE
X-Google-Smtp-Source: AGHT+IGabpVbV+NHEQQXp8goqoKQe7jD7WPvleiiGHZZp7DZfPzcQ3EsMcTqWh3vQp+USwIPD1O+RA==
X-Received: by 2002:a05:6a21:7882:b0:1ee:cd18:d400 with SMTP id adf61e73a8af0-1eef3c883ecmr24664532637.11.1740403116989;
        Mon, 24 Feb 2025 05:18:36 -0800 (PST)
Received: from thinkpad ([36.255.17.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325b03f169sm18621755b3a.63.2025.02.24.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:18:36 -0800 (PST)
Date: Mon, 24 Feb 2025 18:48:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <20250224131831.jqut4hpvv7tf7vzy@thinkpad>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
 <20250222-en7581-pcie-pbus-csr-v3-2-e0cca1f4d394@kernel.org>
 <20250224055216.o23dzwimrghbr2ow@thinkpad>
 <Z7xEZPpWLQjTMnIz@lore-desk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7xEZPpWLQjTMnIz@lore-desk>

On Mon, Feb 24, 2025 at 11:05:24AM +0100, Lorenzo Bianconi wrote:
> > On Sat, Feb 22, 2025 at 11:43:45AM +0100, Lorenzo Bianconi wrote:
> 
> [...]
> 
> > > +
> > > +	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
> > > +	if (!entry)
> > > +		return -EINVAL;
> > 
> > -ENODEV or -ENOMEM
> 
> ack, I will fix it in v4
> 
> > 
> > > +
> > > +	addr = entry->res->start - entry->offset;
> > > +	err = regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
> > > +	if (err)
> > 
> > MMIO write is not supposed to fail.
> 
> ack, I will fix it in v4
> 
> > 
> > > +		return err;
> > > +
> > > +	size = lower_32_bits(resource_size(entry->res));
> > > +	mask = size ? GENMASK(31, __fls(size)) : 0;
> > 
> > Size of MEM region could be 0?
> 
> I added this check since we consider just lower_32_bits().
> Do you think we should remove it?
> 

Yes please.

> > 
> > > +	err = regmap_write(pbus_regmap, args[1], mask);
> > > +	if (err)
> > 
> > MMIO write is not supposed to fail.
> 
> ack, I will fix it in v4
> 
> BTW I will remove your Reviwed-by tag since the patch has changed
> with respect to the one you added it. Please let me know if you
> prepfer to keep it.
> 

Sure, fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

