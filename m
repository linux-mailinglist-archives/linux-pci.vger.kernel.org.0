Return-Path: <linux-pci+bounces-5628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC698897482
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 17:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454CD1F288F0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7A14A62A;
	Wed,  3 Apr 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRMHnn/1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67914A4F4
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159515; cv=none; b=rb5Hgnmf3DbgO9bxIKvHuqSYXClf18n0pSIJKYEYHc3yH5GcNkHXh/Q6SMeADSGIsL7zGaCyY9fbn8y4uvUM3i4sTI2G1qhj7ziM5ZIlfbGKpbniW9K+3HF7QBlmk0+lg19z7U+H7iwdHFAMUG/hG1Monp82Gz2Jv5vJQjdxyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159515; c=relaxed/simple;
	bh=qgIhgArIyknrMhYKo0pXG7L2hPF5611r14caIQJvQ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsY+lQCn+z5ZkLEZSPgElwNrrf02ol2D9KjKb+TJKhk9S8Z/K2v4kE1oU0ZaJ5zpxjCUvqn/ckstcVFvdzEzBt/ETybZjEBxBzIILdJcsBj773fv0JXCfECYRL38sEoCYcG8Uv6Z+P/J6Vr7ZN7wEAqYU6qf8UihuutxF+h/wfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRMHnn/1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so5367565b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712159513; x=1712764313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RxAX3IORBZmyZAmqt7k7cbWr6HJgfjLBGIug35aDNFY=;
        b=DRMHnn/12hCEZ+EzEWkSqaeg3Kh/NKXno8djLNTpANfiRYgJ70crpONfAk9RPZiirF
         ym4+eIlbnGzB4QlFFQNVkfJkmPCPhG1OxGDBvdBny6Se9dLEfXso7WpduMDWmNDSdQPX
         R7lUMIBExyPDI8RJIxLrlb60MXKhb4MDhPkO9ZkWhDgKfEQkc7Be5ZM7Tkm0UdTjwMrf
         AG3JtGao5TTxfFlTMEN5A6x8IvNL5RBJzDvylXEznCEajyb3jpvx5U1V+hMcPpcz91RA
         wydNWp4nDOGPSqVypb3HxkuUEK4/kTwgYFtwuIVgb70X8qwZ8SjDaaoGs0JVa4YWWet0
         RBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159513; x=1712764313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxAX3IORBZmyZAmqt7k7cbWr6HJgfjLBGIug35aDNFY=;
        b=F8VHWfiNkZJb1X56HKqZ/r479xZpACp/wKhjSVx7K61J/HzHFcZ3Sv5sNEDzeVo+MD
         MN/2m65I7kX+K/5kI6sUdATbY7HKjMznn7sbyNf5nxQAyTbA1T35tI/ugJoYEYeO4Q4U
         78vDuo1xhwonsvsF59Yfkzmxg0zDburp6HN7BdzQE3x60KVpXlluZWSWNi84aZTPDyn3
         pmLACQbMMQbywPfDc9Dgm3AiMsGHpQVTnzvBrQHblgfE3jPnNcS7MePgzI76gL369ASs
         4KvFM2J/FacsK8zcV3Z/+gW21w1IYw+t4fLxb3m6fxByERC4JRNO2rZQG1+Zcvfx637s
         QrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4goNLzj72GTrQn+xlDL6iLM72Xqw0t1S++t2bpdBXDktgy/Q7BfuCeXn9dDBqz4/9gHmRouRZnBZ5E37wAmkeLSpbC3CDjLO3
X-Gm-Message-State: AOJu0Yw3CyEmuRmlkpAwmsWClpnwPdOZt8SpfT+kbRPbRE//hi5cxvQ5
	Xibxi00m1b88rELaQBwLZIn72n+bT75bmVoj4LbrAVVz7/qdCBnp10gz9ldiLg==
X-Google-Smtp-Source: AGHT+IFZ8An9frbeOoCjHLGX+h10+JkFjjcUHp5RZHkQCtQER4IRh2CUT8rqcKsB9n/M1uUV2ezDxQ==
X-Received: by 2002:a05:6a20:6114:b0:1a3:e23d:6003 with SMTP id m20-20020a056a20611400b001a3e23d6003mr21825pzb.62.1712159512806;
        Wed, 03 Apr 2024 08:51:52 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id a17-20020aa78e91000000b006e535bf8da4sm11747015pfr.57.2024.04.03.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:51:52 -0700 (PDT)
Date: Wed, 3 Apr 2024 21:21:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 03/10] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to init()
Message-ID: <20240403155147.GA85162@thinkpad>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-3-970dbe90b99d@linaro.org>
 <ZgvjWtC0f1CY6DJs@ryzen>
 <20240403134600.GL25309@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403134600.GL25309@thinkpad>

On Wed, Apr 03, 2024 at 07:16:05PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 12:52:10PM +0200, Niklas Cassel wrote:
> > On Mon, Apr 01, 2024 at 09:20:29PM +0530, Manivannan Sadhasivam wrote:
> > > core_init() callback is used to notify the EPC initialization event to the
> > > EPF drivers. The 'core' prefix was used indicate that the controller IP
> > > core has completed initialization. But it serves no purpose as the EPF
> > > driver will only care about the EPC initialization as a whole and there is
> > > no real benefit to distinguish the IP core part.
> > > 
> > > So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
> > > just init() to make it more clear.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  4 ++--
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |  4 ++--
> > >  drivers/pci/endpoint/pci-epc-core.c           | 16 ++++++++--------
> > >  include/linux/pci-epf.h                       |  4 ++--
> > >  4 files changed, 14 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > index 280863c0eeb9..b3c26ffd29a5 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > @@ -716,7 +716,7 @@ static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
> > >  	epf_mhi->dma_chan_rx = NULL;
> > >  }
> > >  
> > > -static int pci_epf_mhi_core_init(struct pci_epf *epf)
> > > +static int pci_epf_mhi_epc_init(struct pci_epf *epf)
> > >  {
> > >  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > >  	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> > > @@ -897,7 +897,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
> > >  }
> > >  
> > >  static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
> > > -	.core_init = pci_epf_mhi_core_init,
> > > +	.init = pci_epf_mhi_epc_init,
> > >  };
> > >  
> > >  static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 973db0b1bde2..abcb6ca61c4e 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -731,7 +731,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
> > >  	return 0;
> > >  }
> > >  
> > > -static int pci_epf_test_core_init(struct pci_epf *epf)
> > > +static int pci_epf_test_epc_init(struct pci_epf *epf)
> > 
> > On V1 you agreed that it is better to remove 'epc' from the naming.
> > (For both pci-epf-test and pci-epf-mhi).
> > You seem to have forgotten to address this for V2.
> > 
> 
> Oh yeah, sorry about that. I tried to address comments for both series and
> apparently this one got missed.
> 

Ok, now I remember that I kept the prefix intentionally. The module init
functions are already named as pci_epf_{test/mhi}_init(), so cannot use the same
name for the callback also. And using some other name didn't fit, so I kept
'epc' as the prefix since the callback acts on the EPC initialization event
anyway.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

