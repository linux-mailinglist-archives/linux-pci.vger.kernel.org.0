Return-Path: <linux-pci+bounces-4384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFD86F9CD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7C11F2113C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8752C127;
	Mon,  4 Mar 2024 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvGekBUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3AD52A
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532018; cv=none; b=ZoeSIFyzx3t4aVu7wPXRThximxGYgH7aZXYi6TKeCvAzI2jQIfYklj3AFbMDBSCqkCfIe1fBYpAhxCqmLXMVh3qj4WYVl+cDXMoLn8u1nzOU9MNrpH7Z5sduUJNgLVRiUzPQrYCoHXUmDErXHFDDcGcTsWKCckyWaeUWw+Caz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532018; c=relaxed/simple;
	bh=UGOmFzbbkfwPZKSTqOElixK/QRZ5kcrZ8M8m8y/uwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr9TZxF246QsUNQpedrVXLuEiPPAQRAbTW4uEA9RnQD1wa5EZiWn8k6ekZg1DbndfQs4OI+0yBnX3xsk3P7OPfLBDFfhaXvtqbVIFMDI7mPYiewOpV9LP45gY0DwAw+TP779MpXXm7kyFJ+MnrDc2C+tAWTmakh+uRqy9uQjeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KvGekBUM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a378040daso2618300a91.1
        for <linux-pci@vger.kernel.org>; Sun, 03 Mar 2024 22:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709532016; x=1710136816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqGUHDmTmfYdU8YoMexes2hmqreC7OnG94633d6wZnk=;
        b=KvGekBUMmlt1hcad8Q2qFUVrqI/gUQZMor/EJ87GHg5BWQuCCH2u/t8jcOD/4COM3O
         AoBfboy6GKUdVpWIqkv0FwUmOaqPc3/qWQvW6CjGkelql5v6a/d7KJja/lmm7CTBXwMj
         3GvpCZRE0aZje6xcb5ewdbdX959Ge2n0XuTvuYX2PQSV6ohByCCSMfXc2cR8N/aN43DN
         CMuV/4ChaVl2e01YnCc4tMXmhgUDn3YHHEUQwRAqGFdnpX7vDHutJ/WSYROONqT5aXmX
         Gtg0b1PArtVDP63TINAfL3CEAB9AymIojZgJYzgPj66BZb4GWJj3k9w0s5+H3g8q0vuL
         OFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709532016; x=1710136816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqGUHDmTmfYdU8YoMexes2hmqreC7OnG94633d6wZnk=;
        b=LYAXXycsbjvwr5o28JFTAoJC1jcJfCK/o4TRVK6kw9U4WkNz81Vi14XDoCYRfrJLma
         yVFFjSnV9lC3LqhA2MQgUfe1E0H4ntaQFBXCmbqv3+0E9B9vfx07URLfSirTljPbvyXN
         d/u7iYjutvbU6hGlyeMzwEV8vv1Vw8htE75LHHOlcWbDg3VvXJI+lDPWJUp6Jo78GxRk
         ymEOULl6j6f+jCbzCFxL9jLIOtEr1bK2iJhPpRhqjA7zcOXx7de8PnCzz2WiOaY+M3W2
         HJ2g7rcbXCDDACIGsEOVZsWMSmc/Wrj78qJuzHDoQlHMBep6C8hYHUjCflmJxaY0PQOA
         FcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTGAIJ4tavD4g+URAvOcx0fKApAdyryEqjKncxYvxpgvzmdufnw6vyH9SPRU1jjrUI/BxRXc5Ur68os75KcXngWAXHgQG/Z/7A
X-Gm-Message-State: AOJu0Yzk1P2mX9IwEN+gF5N1c+l1q8u76ccGtRDQdliZzKhmXqQ5tz0z
	pSnBqOSwAv2W228bKE27QDmr/RSZmP6NxPt0vj3GdyzZWhq1eTwrpGs19ugORA==
X-Google-Smtp-Source: AGHT+IGQY2Xl+hKY7iTBM++5HPZXUkH01yVGrMcG82EKlSmNlIX1pgGpAq9eOSDYSy8DAINg5WTtIA==
X-Received: by 2002:a17:90a:f68e:b0:29b:4b7e:a016 with SMTP id cl14-20020a17090af68e00b0029b4b7ea016mr1482986pjb.8.1709532015680;
        Sun, 03 Mar 2024 22:00:15 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id pw15-20020a17090b278f00b0029930881068sm9278528pjb.49.2024.03.03.22.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:00:15 -0800 (PST)
Date: Mon, 4 Mar 2024 11:30:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20240304060006.GC2647@thinkpad>
References: <20240228184502.GC21858@thinkpad>
 <20240228193441.GA281471@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228193441.GA281471@bhelgaas>

On Wed, Feb 28, 2024 at 01:34:41PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 12:15:02AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 28, 2024 at 11:39:07AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Feb 28, 2024 at 10:44:12PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Feb 28, 2024 at 09:02:11AM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Feb 28, 2024 at 06:34:11PM +0530, Mrinmay Sarkar wrote:
> > > > > > On 2/24/2024 4:24 AM, Bjorn Helgaas wrote:
> > > > > > > On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:
> > > > > > > > Due to some hardware changes, SA8775P has set the
> > > > > > > > NO_SNOOP attribute in its TLP for all the PCIe
> > > > > > > > controllers. NO_SNOOP attribute when set, the requester
> > > > > > > > is indicating that there no cache coherency issues exit
> > > > > > > > for the addressed memory on the host i.e., memory is not
> > > > > > > > cached. But in reality, requester cannot assume this
> > > > > > > > unless there is a complete control/visibility over the
> > > > > > > > addressed memory on the host.
> > > > > > > 
> > > > > > > Forgive my ignorance here.  It sounds like the cache
> > > > > > > coherency issue would refer to system memory, so the
> > > > > > > relevant No Snoop attribute would be in DMA transactions,
> > > > > > > i.e., Memory Reads or Writes initiated by PCIe Endpoints.
> > > > > > > But it looks like this patch would affect TLPs initiated
> > > > > > > by the Root Complex, not those from Endpoints, so I'm
> > > > > > > confused about how this works.
> > > > > > > 
> > > > > > > If this were in the qcom-ep driver, it would make sense
> > > > > > > that setting No Snoop in the TLPs initiated by the
> > > > > > > Endpoint could be a problem, but that doesn't seem to be
> > > > > > > what this patch is concerned with.
> > > > > >
> > > > > > I think in multiprocessor system cache coherency issue might
> > > > > > occur.  and RC as well needs to snoop cache to avoid
> > > > > > coherency as it is not enable by default.
> > > > > 
> > > > > My mental picture isn't detailed enough, so I'm still
> > > > > confused.  We're talking about TLPs initiated by the RC.
> > > > > Normally these would be because a driver did a CPU load or
> > > > > store to a PCIe device MMIO space, not to system memory.
> > > > 
> > > > Endpoint can expose its system memory as a BAR to the host. In
> > > > that case, the cache coherency issue would apply for TLPs
> > > > originating from RC as well.
> > > 
> > > What PCIe transactions are involved here?  So far I know about:
> > > 
> > >   RC initiates Memory Read Request (or Write) with NO_SNOOP==0
> > >     ...
> > >   EP responds with Completion with Data (for Read) 
> > 
> > The memory on the endpoint may be cached (due to linear map and
> > such). So if the RC is initiating the MWd TLP with NO_SNOOP=1, then
> > there would be coherency issues because there is no guarantee that
> > the memory is not cached on the endpoint. So, not snooping the
> > caches and directly writing to the DDR would cause coherency issues
> > on the endpoint as well.
> 
> I don't know what linear map is, but I'll take your word for it that
> endpoints are allowed to cache things internally.  So I guess in the
> ideal world there might be a way for a driver to specify no-snoop for
> accesses to its device if it knows there is no caching.
> 

I referred to Linux kernel's mapping of the DDR space as "linear map". But the
endpoint may not run only Linux, but any RTOS or even bare metal. So it is
certainly possible the BAR memory could be cached.

> The commit log for this patch refers to caching on the *host*, though,
> and IIUC you're saying this patch clears NO_SNOOP on TLPs from the RC
> because of potential coherency issues on the *endpoint*.
> 

Yeah, the commit message was wrong. I shared the wording during the review of
previous version and it got duplicated for both RC and EP patches :(

This should be fixed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

