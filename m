Return-Path: <linux-pci+bounces-15011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C99AB037
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D51C1C22139
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9019F133;
	Tue, 22 Oct 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSnYcX0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F419F485
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605400; cv=none; b=K/K3BretHyHrxyVUtiYEyzWT2OjhK9VGKrZecIPAOz+YJElCAKbz4DFQwdiDHFuLiTP7x5kO3Ez0fY4Q5mjR6Z4g6TO/knE2Fx9i2znGAHcLj0rHK6RUBz0HHhzuBeQg7lBvEeq9SRqKD5F0OxmKAoEqZG4YQYZ0znp63LnB8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605400; c=relaxed/simple;
	bh=IrYXfjr01AsYWGDke58fAVzb6jYYRUGRFE4PeWz47mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQHAH2I17t68s654/YDTGKCSbdNxGftcaGWp8T7bU+rG9OmOoXh0GSUtG/097ykf4YrocioRns8YoQAQQ4UdYNr7Zh99tB3DFqaBEh+6ZtIEFq+bprxCSY3vumVU+fediGsauHl78njtKPEPbfY7FkPVk6v1RP1JniTyexXnHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSnYcX0s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20caccadbeeso61758165ad.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729605398; x=1730210198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDTWspOywOZ3HPMtK4sHpusjuxuRLJ4HeTrHUioH/wE=;
        b=qSnYcX0sEQIEWHBsUrAMtVqJd3QVM2MkIMjB/z36xNQ1vW0e6VRYF0fe32nC/PKcPs
         YGPO9q6VYclmrGa/lrinzQkaBH+ya6bqqYDPJ9V8mZwPvD3wIzPq2YRAeB1hYsHhmJy2
         uFJJPTEaCtBeFJyMU26evihXoJoaPbL9ToA3eiGyMj1PT+FS1p1ErgL3GeZi6Y2fXUnI
         eQeJeM4SW//HxpizbjUAegSlAo6IxsKU+XvlaAtHh7MeBBc3fwMbzNseFyUUgGMkIUuV
         dhyLEijEzKSB+c5y1HBScPtMkb11VRtg8va1YU2w875X2YeZqGUnizDaQppXbX4kDc7G
         qChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729605398; x=1730210198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDTWspOywOZ3HPMtK4sHpusjuxuRLJ4HeTrHUioH/wE=;
        b=p6PXP40qLsN/I9dcYOmihJkK6WQ+2hbYLrCzhz2bd/xadcYcyW03rwsK5UyimxS4Mo
         QbB+AvPzsTwhC8JpqiKZZ0ETU4OK+V4fgQKy+jZUlxRw/ezthSNdvwIyuYYRkfoxB+E8
         bkk8MwoNR8Wp4DQ2YWyrAtW5mvNfoEP7+JonlWlpdK/C0MSiyB6n9fQqhVO2vPSDh2yy
         fk8ADP28HZGdEqZWW6Db3cZOlIZOXQNrG71r9luXeSLWEE1qot8aCiSBcoEalpyCGLnt
         tDAJAsxI6CAyoO8UOrXQJyjrCKpQfX3cilY3gIqiWqRULMC7WvUNizLcXMvwS6zOWsBF
         g8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWubnoCWSIuFH8KqiKu65uRF/HmiGuj863ohFTqbCo7sguFdDc+5Q4RMk2emxnEXCVkU9lYutG9z1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpKcIlv+9NhOEaR/y4DSXY0c+N/yP2GL4w3J4juKo8SXwN2T/3
	BKs2joI41W51yg/4naIAsuiDWudJpO/BB6ayyiLC6LK3yqx0fQ5MDXpicECu/A==
X-Google-Smtp-Source: AGHT+IFtCSs+qNjfC6N3FE3WfD5/1saWBS81ePzOouDaF/EAz1pAtvGUOgOR96qAumF85xLf7JSE/g==
X-Received: by 2002:a17:902:76c7:b0:20c:ecd8:d0af with SMTP id d9443c01a7336-20e983f02c7mr28864705ad.9.1729605397974;
        Tue, 22 Oct 2024 06:56:37 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee62cdsm43238625ad.5.2024.10.22.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:56:37 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:26:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <20241022135631.a6ux4jzb47v7jvqr@thinkpad>
References: <20241021221956.GA851955@bhelgaas>
 <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
 <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>

On Tue, Oct 22, 2024 at 10:38:58AM +0200, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
> > On 10/22/24 07:19, Bjorn Helgaas wrote:
> > > On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> >
> > DMA transfers that can be done using dedicated DMA rx/tx channels associated
> > with the endpoint controller do not need to use this API as the mapping to
> > the host PCI address space is automatically handled by the DMA driver.
> 
> I disagree with this part. It think that it depends on the DMA controller.
> 
> Looking at the manual for e.g. the embedded DMA controller on the DWC
> controller (eDMA):
> ""
> When you do not want the iATU to translate outbound requests that are generated by the
> internal DMA module, then you must implement one of the following approaches:
> - Ensure that the combination of DMA channel programming and iATU control register
> programming, causes no translation of DMA traffic to be done in the iATU.
> or
> - Activate the DMA bypass mode to allow request TLPs which are initiated by the DMA
> controller to pass through the iATU untranslated. You can activate DMA bypass mode by
> setting the DMA Bypass field of the iATU Control 2 Register (IATU_REGION_C-
> TRL_OFF_2_OUTBOUND_0).
> ""
> 
> However, we also know that, if there is no match in the iATU table:
> ""
> The default behavior of the ATU when there is no address match in the outbound direction or no
> TLP attribute match in the inbound direction, is to pass the transaction through.
> ""
> 
> I.e. if there is a iATU mapping (which is what pci_epc_map_addr() sets up),
> the eDMA will take that into account. If there is none, it will go through
> untranslated.
> 
> 
> So for the eDMA embedded on the DWC controller, we do not strictly need to
> call pci_epc_map_addr(). (However, we probably want to do it anyway, as long
> as we haven't enabled DMA bypass mode, just to make sure that there is no
> other iATU mapping in the mapping table that will affect our transfer.)
> 

I do not recommend that. EPF driver *should* know how to isolate the address
spaces between DMA and iATU. Creating the iATU mapping for the DMA address is
just defeating the purpose of using DMA.

If any overlap mapping is present, then the EPF driver has a bug!

> However, if you think about a generic DMA controller, e.g. an ARM primecell
> pl330, I don't see how it that DMA controller will be able to perform
> transfers correctly if there is not an iATU mapping for the region that it
> is reading/writing to.
> 

I don't think the generic DMA controller can be used to read/write to remote
memory. It needs to be integrated with the PCIe IP so that it can issue PCIe
transactions.

> So the safest thing, that will work with any DMA controller is probably to
> always call pci_epc_map_addr() before doing the transfer.
> 
> 
> However, as I pointed out in:
> https://lore.kernel.org/lkml/Zg5oeDzq5u3jmKIu@ryzen/
> 
> This behavior is still inconsistent between PCI EPF drivers:
> E.g. for pci-epf-test.c:
> When using dedicated DMA rx/tx channels (epf_test->dma_private == true),
> and when FLAG_USE_DMA is set, it currently always calls pci_epc_map_addr()
> before doing the transfer.
> 
> However for pci-epf-mhi.c:
> When using dedicated DMA rx/tx channels and when MHI_EPF_USE_DMA is set,
> it currently does not call pci_epc_map_addr() before doing the transfer.
> 

Because, there are not going to be any overlapping mappings. But I agree with
the inconsistency between EPF drivers though...

- Mani

-- 
மணிவண்ணன் சதாசிவம்

