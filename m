Return-Path: <linux-pci+bounces-12402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A679639D8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 07:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C991F23173
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 05:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110C149011;
	Thu, 29 Aug 2024 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlI9PySF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C25148FF0
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908971; cv=none; b=avnfVlKzf7c3/gnDHbIO9Vuj3i/nhvhWomMnGLmMoqg34Vp4vKrd9j4KLgbNIlM/yi+dpOjOjOY3vddOm2lpcbqoychbVzmMdKKITsPCkdYrJZ39eF/BobeqQNABi/QA5bArGaUsGQCc4qty5FmViBo8oFYCbSZmzBhGmM2MkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908971; c=relaxed/simple;
	bh=P7HOOEvtNGDAiMJzLRD2WDAyfVxZnPo3dCEuHop7FfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7rbF1X8W56FwtYKHRROocTs3fjj4k7C9c/560Lf9gDWxmcaGq4sA05XtTuKRBE5i+J9c66BlISKVkV6ZkAx4TydMixkJqaEX71Qtz44guaqGo6+K+J2sJ3IzU0O5DpUO+vs/6ZynzThK+1gPooqQFsUL5SLt7e1rbebzOI+s3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlI9PySF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202089e57d8so1683195ad.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 22:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724908969; x=1725513769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZDgdHWYH1oig4dSwiHeHzpXMKQW0khYZoM6E0qTtEXo=;
        b=vlI9PySFgkawCCIeOlfvcl4bM1ZgUbOkbSoD8pVlTC2jn90KrxFkUkCkagAKP9hkko
         UCxmh6YReJbD87WqLnE1le3qivHFwPlpQDYx7Peleepr32ru/OKfpM3crTZZCKbd0uUd
         +vfFVA0Ulh5mVAkpeuVEppFUA3H9F2zwh/ayIdzbJTSr+JsiUY1QzvkuHZS36uk6+vp6
         Hyb43h8L6lce7ZqiPFG3x9vYojpkxz9NCL8SsFpyaxkVPR3hEM+JkYN6XbzGdjoIzC1l
         Dn42NobOnVz+ni0XAMQcOcnpxPg7P9c+dv7+wtVKvEMuz3QBq/YBckp+gVlsdjwICujW
         Ll4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908969; x=1725513769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDgdHWYH1oig4dSwiHeHzpXMKQW0khYZoM6E0qTtEXo=;
        b=nfA0QB3+BeKO573t8bn3BAsvRm9CrsYNjxEueYwROWeJssoeiQncM5Ul8WvfNF/Psb
         jA9xI4c5VVCYBUf5m1WZM8FznZRgEX8j2FhjNPRC2N3aYTPiYOPdd2kQxSCGZeAqYZAo
         CgLoQ+t4C2vqcD/icasyTvMmeXGhcJgxLTwzkdOiBJdJLfgTPGoKDxdXB7SDarnDXT9w
         sCRoqQUM9mIFo6z0tUuKTNzZ68tt1ysfzHSXUcUqze0vqPgw7WGQjylnskeSkHFiuObZ
         TAQ7WDr1dUPXvgXdQJFF9JhfvgPpCqS1WqZhGFn4LZc++tnrR/OZjvZqlGJerDaTidM+
         dDgw==
X-Forwarded-Encrypted: i=1; AJvYcCUiGkrF77/Vt8jHoWUcasrUUmTHo55qn5AYjhY7huQ7pBV1U6DFt2UJiqDKX0OX6jWncmf0uMpMVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbaqNIyxCiTLoAkBY2mzlmFkbctFJfVURx0vKaylBEK/3pdC9
	GE8IXXr3HSC/Aj59rpxsp1XQyoj3yDL4P5A9t0lG9yQq6oAlRRJrNcZE6CcLrA==
X-Google-Smtp-Source: AGHT+IGFYqZRfiCAN5Gu8li5QXL0zz3A9Z9M4Ui2rLUctazsHD5wv1P4f8Dq5/JP9OmBK4gw1xQOUA==
X-Received: by 2002:a17:902:e952:b0:1fc:4acb:3670 with SMTP id d9443c01a7336-20516734701mr5981245ad.12.1724908969104;
        Wed, 28 Aug 2024 22:22:49 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155560e9sm3467045ad.282.2024.08.28.22.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 22:22:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:52:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240829052244.6jekalgshzlbz5hp@thinkpad>
References: <20240828155217.jccpmcgvizqomj4x@thinkpad>
 <20240828210705.GA37859@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828210705.GA37859@bhelgaas>

On Wed, Aug 28, 2024 at 04:07:05PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 28, 2024 at 09:22:17PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Aug 20, 2024 at 08:45:59PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 02, 2024 at 11:25:02AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > Currently, there is no proper distinction between D3Hot and D3Cold while
> > > > handling the power management for PCI bridges. For instance,
> > > > pci_bridge_d3_allowed() API decides whether it is allowed to put the
> > > > bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
> > > > is allowed in a scenario. This often leads to confusion and may be prone
> > > > to errors.
> > > > 
> > > > So let's split the D3Hot and D3Cold handling where possible. The current
> > > > pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
> > > > and pci_bridge_d3cold_allowed() APIs and used in relevant places.
> > > 
> > > s/So let's split/Split/
> > > 
> > > > Also, pci_bridge_d3_update() API is now renamed to
> > > > pci_bridge_d3cold_update() since it was only used to check the possibility
> > > > of D3Cold.
> > > > 
> > > > Note that it is assumed that only D3Hot needs to be checked while
> > > > transitioning the bridge during runtime PM and D3Cold in other places. In
> > > > the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
> > > > allowed for the bridge.
> > > > 
> > > > Still, there are places where just 'd3' is used opaquely, but those are
> > > > hard to distinguish, hence left for future cleanups.
> > > 
> > > The spec does use "D3Hot/D3Cold" (with Hot/Cold capitalized and
> > > subscripted), but most Linux doc and comments use "D3hot" and
> > > "D3cold", so I think we should stick with the Linux convention (it's
> > > not 100%, but it's a pretty big majority).
> > > 
> > > > -	if (pci_dev->bridge_d3_allowed)
> > > > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> > > 
> > > Much of this patch is renames that could be easily reviewed.  But
> > > there are a few things like this that are not simple renames.  Can you
> > > split out these non-rename things to their own patch(es) with their
> > > own explanations?
> > 
> > I can, but I do not want these cleanups/refactoring to delay merging
> > the patch 4. Are you OK if I just send it standalone and work on the
> > refactoring as a separate series?
> 
> You mean to send patch 4/4 standalone, and do the rest separately?
> That sounds reasonable to me.

Ack, thanks.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

