Return-Path: <linux-pci+bounces-6398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9068A938C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8C91C20C37
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 06:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E52C86A;
	Thu, 18 Apr 2024 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXomSYYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45759200DD
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423194; cv=none; b=Jvgv4Izf9qa4vuJz++rUcETRfwOC4q1+gPcJXDmqswLF6rjnZZaX0shdn7K3ZLnLThZabgYhdSA3dUhbylbQ+TY8Cdyv0EXUf2Jvhi0YxPcid3fXUIXBB7MuRmVKCVL3dUURYEuIoJOsk+yhCSmuiZyIW6GsqyhgaeUYYdVr16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423194; c=relaxed/simple;
	bh=pl0E0/CPNvyU7tX7pTfKZh9cVPJsQcytPBidCAR/NJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9D/YsV85ezrob93E9IoML+Rww/2/xx2FReqahekHFAll94Pn6vDVtyxP2PBofU7HcFIfRX9+2TRlA78dSiZ1uaJwnk6LwKFAD3plO17DEeznfvHnNPtdoY3T+yQ3JcTVf9p1ijkL/3Atu4W//xgXtIzISkmvWakvi7bs2KIh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXomSYYh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so567621b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713423192; x=1714027992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qC0zbqS3FQ+Zn4xV4lRWFo3BO0VRfJLwRrQ9QuGIorY=;
        b=HXomSYYhKH6YcsukxcbuyFVExmZbki9R/E9JdlcJPVWF75621Bua/owT40IYgrNOVT
         LTkXTyg17UVy6EpOku2KyTUqqQ8bucS16wogHMAOV92RR5K5ZRYk8pmgbcogGlL2bpVh
         VMiBIUk39Z2JWzGXnTA9f6SoCHotHC4Fm73dzK3xbK/5v5UwzrXnA7MgWGTfEiYIcwnv
         9JZvSbUlQSrdntKJv5LXTuM0KQ3NO8O+xlMR8nfGxhnQwDk7Z5q1sZXh5DexATu26W82
         CioYaSoNpf3H/OeyNR1lLKQ6/I1bV3yRpaJ5joHeUBXQN3v7BBpr9oxL1Mhr/S6JPOwz
         4I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423192; x=1714027992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC0zbqS3FQ+Zn4xV4lRWFo3BO0VRfJLwRrQ9QuGIorY=;
        b=kPH/CS8mWUEY5G96xi25PzRYyQZS1pnNm3ooIDy+6Bm2Bv+mNEJTWVw2w+HGprEKvo
         rYPK+NSxZLh3BvGTsjgJveQByqyLOhfKRVzgYIPkveHaEOnUtWx9PW6kPzPpFIrv+Gk6
         6H6bHE+mnk6ct6Bo5vAyDDnS0a+jZr/EVq8xoTQLNAnbMQIrLNt7q0orhqIME6iq2waD
         L4LDHfJLtUxU5iskpoDAhjsQNbnguWVerUQil0huTo+uiPrNE3iMPc6NOV4ckDN0Yag7
         2oJ3BPmJkafgCGpcaNMpWhrAo/8QbnxHY2TDJFWlopC7KyQ+HLd7S0NeklJhcw0huX7W
         z7EA==
X-Forwarded-Encrypted: i=1; AJvYcCXZnd4+W07wBprBRR9JC0hhn/Fky9QIQdfaJ07sDXjHMHMkI3ppjQbatGhFMS8QG3ulE157mSOhbTyboLXnel94BDPJ8iaqNSaG
X-Gm-Message-State: AOJu0YwgMJvdl7Jg/dni8HQPHlBh+8XDwLRoe6tS4/5FkCOT5xFClnEO
	7iuhd7XIw0BnP87sjVXgk/Nrxyx+CfpAaCoR4jeSvvFMFddcTwqhlL5uzfKncA==
X-Google-Smtp-Source: AGHT+IGjCdWHFS5SAG//RjXHhury0Bmks00ilQi7+/67t3HVtZgtedJYa8UQ7HA8XSK5FTOavG52Ow==
X-Received: by 2002:a05:6a21:1f27:b0:1aa:5d76:1916 with SMTP id ry39-20020a056a211f2700b001aa5d761916mr2203144pzb.34.1713423192398;
        Wed, 17 Apr 2024 23:53:12 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id fj32-20020a056a003a2000b006eac4297ed3sm766902pfb.20.2024.04.17.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:53:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:23:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240418065308.GG2861@thinkpad>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <20240418054319.GB2861@thinkpad>
 <ZiDB18w4bnUCSH7D@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiDB18w4bnUCSH7D@ryzen>

On Thu, Apr 18, 2024 at 08:46:47AM +0200, Niklas Cassel wrote:
> On Thu, Apr 18, 2024 at 11:13:19AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > > hit the NULL pointer dereference. This also leads to the following smatch
> > > > warning:
> > > > 
> > > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > > 
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > I think you forgot:
> > > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > > 
> > 
> > No, that's not the correct fixes tag I suppose. This redudant check is
> > introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
> > core initialization") and this commit removes the redundant check (fixing smatch
> > warning is a side effect). So if the fixes tag needs to be added, then this
> > commit should be referenced.
> 
> Well, you have a Closes: tag that links to a bug report about a smatch
> warning that was introduced with 5e50ee27d4a5 ("PCI: pci-epf-test: Add
> support to defer core initialization").
> 
> So if you want to reference another commit, then you should probably
> drop the Closes: tag.
> 

Then checkpatch will complain... But I think I can keep the two tags? One is for
fixing the redudant check and another is for the smatch warning reported.

> 
> > 
> > > 

[...]

> > > That way, we assign msi_capable/msix_capable just before the if-statement
> > > where it is used. (Which matches how we already assign msix_capable just
> > > before the if-statement in pci_epf_test_alloc_space().)
> > > 
> > 
> > Ok, if we go with this pattern, then pci_epf_test_set_bar() also needs to be
> > updated.
> 
> pci_epf_test_set_bar() ? I presume that you mean pci_epf_test_alloc_space().
> 

Oops. I referred from an old branch.

> How about a 1/2 patch that modifies pci_epf_test_core_init() and Closes: the
> bug report, and a 2/2 patch that modifies pci_epf_test_alloc_space() ?
> 

Yes, that's the plan.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

