Return-Path: <linux-pci+bounces-8027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F668D38F4
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E61F285F96
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA22154C0E;
	Wed, 29 May 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dL40eosk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B803154450
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992182; cv=none; b=IoS3vUOsST4GXUIC+LoZLI8NZzCtI4eudLcRVJMuoxBNz9cxqolZdjhmNsSgiVZ3D4llIAYpVGNXHeslbG6oDOLjhrLY2w5kYbqjT24ypF5aSQqDQzyS1EeHv3deEpEuC//qt0CqkzhEWbE4aWePt07h+iCutqjhUB15yymf+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992182; c=relaxed/simple;
	bh=5MDlTUA7cb2DBJS+WMGThH9tNvdPf3iB+HEXk4/hGUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQR7Jm4FFGnNtiOSmHaIsce1CTZ8L2VSYM8xDn5hxstJlovImCWuxDQG28z/bBKcj5JYKdv7WbuUUHc4+mmhT0v4alP2Fg9Epe+Bq2jOlmy/oox+7vIOyN5hYOjz/dsNG0WXgeWgHw/P4EMfmPQXN/dtY7TSC/OEAL0LXm9I6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dL40eosk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso708259b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716992180; x=1717596980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8lupj8DUU7HK2RifE4NxLJsU0KDPF2GMvEgKNxeZzxU=;
        b=dL40eoskEfQv4SLRcn2tNfdPayhcP41PEUZ/sqvqhk3u/h6mHXygDCBCcW7vzOeoLk
         GlWxKQvEfbyLKfdcVYPDlSUYC2zmVHTZJ3nP9iPA8Wsptpg4CD6EDC2O4qqbNm3ANAad
         JnlhsqpZx25eHmidbZrPSppVoMeAfaWBHs42mu6vSnUQKbBhmzpupRnlMpSXb+PFWMAz
         mKgG7Av3ueB0utUMxAqmO1U6diX6IyEmBmdXpUhZOAFaQOoki2C6nb4T+A3/IT6WLC1F
         arMfVD+nAHKHDwKUBAR9kiCBXwYAN076b7/9oyxSg0DUUHHmTM4WoC0qZVBFNphJyUo6
         YC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992180; x=1717596980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lupj8DUU7HK2RifE4NxLJsU0KDPF2GMvEgKNxeZzxU=;
        b=OSMGYbsUB0WV28AUZ82JZbcyTGadmX2bzoNSxk1Ng0U0Q/fAjq3ej5F8BQpfdzlhP8
         tO+x7LO2yhislTuREY79SocSTilS8xkxvq530hIMXpWBVa7Ah+jTdmWn9yPood79NwPT
         t3V9G5lu+oSC8AaJcMs73EUnwCugqXgV5q9z0xkHDfOVwA9nLM91ZEYpgCp0kKThvDyY
         gmHctXupC3jaEjtMDO8bPal90SxuKvqY8zDOnCaWpy01QIxwcLtp2/nqGNLcraltxFln
         ZA2u9uI8QZGTlcw27ri83V+IhaFXgk9tL8LQHu/HhmWFB6+dkKqPNW52TXSOna0feuHp
         o4rw==
X-Forwarded-Encrypted: i=1; AJvYcCVI4+8gfKQQVDBii+zOY9PDlFJFODcCxAFEHfKbBcyPPZrYvAqkUZhPriGzcQKXi9J3abEKL6UVD+po9B9qZkzUyMybO3Q5cWFi
X-Gm-Message-State: AOJu0YwCizeLIfCCuPdl7hew0nRJUGWHO20LEOrk1fcZsdnbPV1d/d5R
	XRIPYwaIQ1vNtsuX6b7hSNw7L4z3wD4DhWjiIi40U3oxqTXYclFfTZH8OQlksQ==
X-Google-Smtp-Source: AGHT+IEO5bck8dn6+iUW9M0grmub3Vo66+bXiAAIKVnibyBc5nmSL3Zhw+KPRmP93vFwZrw/SMzlRg==
X-Received: by 2002:a05:6a00:17a8:b0:701:cfd4:ab43 with SMTP id d2e1a72fcca58-70202f6cdf5mr4302395b3a.16.1716992180249;
        Wed, 29 May 2024 07:16:20 -0700 (PDT)
Received: from thinkpad ([220.158.156.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd1d2006sm8320971b3a.172.2024.05.29.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:16:19 -0700 (PDT)
Date: Wed, 29 May 2024 19:46:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <20240529141614.GA3293@thinkpad>
References: <ZlYt1DvhcK-ePwXU@ryzen.lan>
 <20240528195539.GA458945@bhelgaas>
 <Zlba0OfNCGecFYj8@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlba0OfNCGecFYj8@ryzen.lan>

Hi Niklas,

On Wed, May 29, 2024 at 09:35:44AM +0200, Niklas Cassel wrote:
> On Tue, May 28, 2024 at 02:55:39PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 28, 2024 at 09:17:40PM +0200, Niklas Cassel wrote:
> > > 
> > > > What if we added stubs to pci-epc.h pci_epc_init_notify(),
> > > > pci_epc_deinit_notify(), pci_epc_linkup(), and pci_epc_linkdown() for
> > > > the non-CONFIG_PCI_ENDPOINT case instead?  Then we might be able to
> > > > drop all these DWC-specific wrappers.
> > > 
> > > The PCI endpoint subsystem currently does not provide any stubs at all,
> > > so that would be a bigger change compared to this small patch.
> > > (And considering that the pci/endpoint branch does not build, I opted
> > > for the smaller patch.)
> > 
> > > Your suggestion would of course work as well, but if we go that route,
> > > then we should probably add stubs for all functions in both
> > > include/linux/pci-epc.h and include/linux/pci-epf.h.
> > > As long as the DWC glue drivers use the same "API layer" for init and
> > > deinit notification, I'm happy :)
> > 
> > The cadence, rcar, and rockchip drivers use pci_epc_init_notify() with
> > no wrapper.
> > 
> > A bunch of DWC-based drivers (artpec6, dra7xx, imx6, keembay, ks, ls,
> > qcom, rcar_gen4, etc) use the dw_pcie_ep_init_notify() wrapper.
> > 
> > ls and qcom even use *both*: pci_epc_linkdown() but
> > dw_pcie_ep_linkup().
> > 
> > Personally I would drop the dw_*() wrappers.  It's a bigger patch but
> > not any more complicated, and the result is consistency across both
> > DWC and the non-DWC drivers.
> > 
> > I don't know if we need to add stubs for *all* the functions.  I'd
> > probably defer that until we trip over them.
> 
> Hello Mani,
> 
> considering that:
> 
> 1) Bjorn dropped the commit:
> "PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers"
> which means that you will need resubmit your patch.
> 
> 2) Any changes I would do would conflict with your patch.
> (It probably makes most sense put your patch as the final patch in a series.)
> 
> 3) You are the PCI endpoint maintainer, so you are most suited to decide
> which functions to stub (if any).
> 
> 4) Your patch only affects tegra and qcom, and I don't have the hardware
> for either, so I wouldn't be able to test.
> 
> Thus, I do not intend to respin this series.
> I hope that is okay with you.
> 

That's fine. Thanks a lot for stepping in to fix the build issue. I was on
vacation, so couldn't act on your query/series promptly.

Let us conclude the fix here itself as we have more than 1 threads going on.
I did consider adding the stubs to pci-epc.h, but only the deinit API requires
that. So I thought it will look odd to add stub for only one function, that too
for one of the two variants (init/deinit).

So I went ahead with the ugly (yes) conditional for the deinit_notify API.

Ideally, I would've expected both dwc and EP subsystem to provide stubs for the
APIs used by the common driver (host and EP). But since the controller drivers
were using the conditional check to differentiate between host and EP mode,
compilers were smart enough to spot the dead functions and removes them. So
there were no reports so far.

But in this case, the pci_epc_deinit_notify() is called in a separate helper and
hence the issue.

So to conclude, I think it is best if we can add stub just for
pci_epc_deinit_notify() in pci-epc.h and get rid of the dummy
dw_pcie_ep_init_notify() wrapper to make the init/deinit API usage consistent.

Also I do not want to remove the wrapper for dw_pcie_ep_linkup() since its
conterpart dw_pcie_ep_linkdown() is required.

Let me know what you think! I will submit a new series with the left over
patches.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

