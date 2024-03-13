Return-Path: <linux-pci+bounces-4792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B33887B07C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 19:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FF228D1A2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFC13EFF6;
	Wed, 13 Mar 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8zvQJOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9B13DB9B
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352431; cv=none; b=qrZaJZNYAJ66itj/BtLNIDY/yUbLjWKGN8zlMzcDKekm/pFTTOGQrxTgP/o3MxOWa0MAhdVaKS92O0CBGhZMC31/4SSjxxmuiqjpD0lg4z7HbwU48hUiQUXTq3ghpaPjmGdzuc7OrJY9HX7aWO69hBnXYf0Oc1v9cSpI0+AAcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352431; c=relaxed/simple;
	bh=ikP1SQZvK81WwtXopq3dHhyUueLGCn0F9tCceqEbyeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryF9tGxDcwfh5wdIe6n/dPmuRwMBEEGQKsH2Y6C0qs35938UPHICLdlXZDWitGGK2q+FtegIbUAl60GWv46CucFis5A6yx3ZE2MA8WMezMpfXCnFy1GCTfK1W81yQ0Uxrgodu2jfaHKO8UCMJnpcKn6ZFqAvYcTeAybWsy3SOEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8zvQJOD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ac58fceaso197938b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710352429; x=1710957229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P42L0V1byhnm9xVh8nwf+gtaXnbnBXKB7y3o50DEnDg=;
        b=D8zvQJODpgv7AIuJtS6cE34ZEwNLkubA98YOSqTLCzC69KQKzO2f3zGeK+Z5DUDzxi
         o+MhH1fXsTzC5+MTFYVzZwM9TKWdDIfSl1AGH4LSzvVuBGbMD9jG+UhqXrHUxeFvsP3d
         9TbKrEZk62XKsAq5v22pZCQ97JzVgSroarKzmG+MUpGNK6RQn37mVHRtnV5W2hzV27QY
         PmCrm+BjGNdDurv7SBFLacgCV6vRcD2ofQILGoRLKueVEbpbDvkB323zb0PN2kMXj9gt
         xqGrrJBdBocY31UygcoLPWUorr0DO9CcXcsP4/rt5f53tS9eMDhWoE2TfEfjPvuLDUo/
         vIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352429; x=1710957229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P42L0V1byhnm9xVh8nwf+gtaXnbnBXKB7y3o50DEnDg=;
        b=pshVoFbkifUcvPQxqsNEgfsvpAMcQqT8fSm84j+X0BmOJMcUBOOlIS8MHMpy20jkNZ
         ew1jzijf7Nh9Hw0zZer6qBLYxAVudZA3fXChbi+ZavEBvhv7ltEO5IBcdk6JPO04be5E
         OjWKSrd7ksO+NusU0ZJSHdDmFJ6lmeBjPAG8AHT1nGlVP0aSazsh/1cohBXm+/uciy1A
         bfxoZOLJyu642c4lt7SVkVSmt7DnLWqShn1KQfBRLXuhxcH69+OMRcMFsjuD+SMSDynK
         RcwHbKV7AqfMm6MUkCa4rxs3OIFE/3SZXlRly9DRsuU4EEMkDreeFfwkZKve/U05VU7+
         X6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV+2cZDzEpKv4kdKMaE393IRmUpMH2+wZR2jnabtrGay/e0BoyLQ9/JQ5jSXUXLT9y0tpbUM4wZH2yIADtI66Uq+OLDW0G5p+jM
X-Gm-Message-State: AOJu0YzpE/rc1Xlp5NQWpf3c4SyzQYg+gb1FiQSzZeKvlu4DPU/PiGLe
	RjRzGsQ0QvvCFz0b8njknoDOih8UbWlhXkuysR4RK90MoxCSpY607sje4M8hTQ==
X-Google-Smtp-Source: AGHT+IFcf5q7ruVnxD8hAPCs04EkAgFwMtLJq7WsD337HPZnA1JczKQ1xXu4AYtawACMGMb2l439Qw==
X-Received: by 2002:a05:6a20:12c9:b0:1a3:113a:bbd5 with SMTP id v9-20020a056a2012c900b001a3113abbd5mr5892663pzg.40.1710352428857;
        Wed, 13 Mar 2024 10:53:48 -0700 (PDT)
Received: from thinkpad ([117.213.99.94])
        by smtp.gmail.com with ESMTPSA id r6-20020a63e506000000b005dbd0facb4dsm7803062pgh.61.2024.03.13.10.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:53:48 -0700 (PDT)
Date: Wed, 13 Mar 2024 23:23:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <20240313175333.GA126027@thinkpad>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>
 <ZesRk5Dg4KEASD3U@ryzen>
 <20240311144559.GA2504@thinkpad>
 <Ze99lLhe2GqIqMgl@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze99lLhe2GqIqMgl@ryzen>

On Mon, Mar 11, 2024 at 10:54:28PM +0100, Niklas Cassel wrote:
> On Mon, Mar 11, 2024 at 08:15:59PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > I would say that it is the following change that breaks things:
> > > 
> > > > -	if (!core_init_notifier) {
> > > > -		ret = pci_epf_test_core_init(epf);
> > > > -		if (ret)
> > > > -			return ret;
> > > > -	}
> > > > -
> > > 
> > > Since without this code, pci_epf_test_core_init() will no longer be called,
> > > as there is currently no one that calls epf->core_init() for a EPF driver
> > > after it has been bound. (For drivers that call dw_pcie_ep_init_notify() in
> > > .probe())
> > > 
> > 
> > Thanks a lot for testing, Niklas!
> > 
> > > I guess one way to solve this would be for the EPC core to keep track of
> > > the current EPC "core state" (up/down). If the core is "up" at EPF .bind()
> > > time, notify the EPF driver directly after .bind()?
> > > 
> > 
> > Yeah, that's a good solution. But I think it would be better if the EPC caches
> > all events if the EPF drivers are not available and dispatch them once the bind
> > happens for each EPF driver. Even though INIT_COMPLETE is the only event that is
> > getting generated before bind() now, IMO it is better to add provision to catch
> > other events also.
> > 
> > Wdyt?
> 
> I'm not sure.
> What if the EPF goes up/down/up, it seems a bit silly to send all those
> events to the EPF driver that will alloc+free+alloc.
> 
> Do we know for sure that we will want to store + replay events other than
> INIT_COMPLETE?
> 
> And how many events should we store?
> 
> 
> Until we can think of a good reason which events other than UP/DOWN we
> can to store, I think that just storing the state as an integer in
> struct pci_epc seems simpler.
> 

Hmm, makes sense.

> 
> Or I guess we could continue with a flag in struct pci_epc_features,
> like has_perst_notifier, which would then require the EPC driver to
> call both epc_notify_core_up() and epc_notify_core_down() when receiving
> the PERST deassert/assert.
> For a driver without the flag set, the EPC core would call
> .epc_notify_core_up() after bind. (And .epc_notify_core_down() would never
> be called, or it could call it before unbind().)
> That way an EPF driver itself would not need any different handling
> (all callbacks would always come, either triggered by an EPC driver that
> has PERST GPIO irq, or triggered by the EPC core for a driver that lacks
> a PERST GPIO).
> 

For simplicity, I've just used a flag in 'struct pci_epc' to track the core_init
and call the callback during bind().

But the series has grown big, so I decided to split it into two. One to address
the DBI access issue and also remove the 'core_init_notifier' flag and another
one to make EPF drivers more robust to handle the host reboot scenario.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

