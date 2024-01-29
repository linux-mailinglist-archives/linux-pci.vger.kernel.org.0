Return-Path: <linux-pci+bounces-2696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E783FF93
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F41D1F23153
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393DA17991;
	Mon, 29 Jan 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztgz2dm7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FB524CD
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515504; cv=none; b=qP08FX2zq13aPtYgVMPInVZuTXG5i1/zT4JwvStakjHJiUPtjmzuSkh8dQxo+hWrTL5PqmiiUZ+Eyj9DbnBfK1E4ONrHWbJXlYG1IdbRrjX3H/a6MqRr8MjnYZEJ0WCj1Nh5db70s/3D1EzGYsfwWrOs4Sz6Ww+nfgUXcAcftYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515504; c=relaxed/simple;
	bh=IUmWDMy5udBbPDb/cX1IskjhanUnLIb0tf/W6Q9pJbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSZr85KHTpFs/CTg9dWeOeQenYVPlMuz9U3yJ2e5E+H9Ma86DkpKa7RlN0A3qra10VE051YfN45aP+wX97zGk02MfnccsNU6ojf9ZOuS7B2FVuf0g9jNuAb6qdoypXq7enppBd1h9da9tS4ucJ0qb3dBYog4BJepAiLOvI10D2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztgz2dm7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d8e7ebbbadso1554925ad.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 00:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706515502; x=1707120302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNxzhXty0giymLpXrYH77O7jWTFY4W0gxavbYgEJJ5k=;
        b=ztgz2dm7zRZp5d/qO3glvFOG/onSRBDmHBECPgWvHk3fA4l3XQDM0Jtzzw7kkPYO22
         q1y3r3RNwRu4B1EsX+X8+kiHrT3159XzkBLJtRdaGYTNTwh07e6JVRwppk+MjONcibdo
         SxoQPj/mhwHYqTHHnras6KU+GrSWAwxwFxXM+wxgzieS6ZuHFtOkC77Wqvte+O2azkEp
         LS+HEnjFJ/B3mrygAaLegagzzIlmUra09ACHAjHPzAtlAlikT7m49kXbxfCqkuUWAPGW
         LtKnFeuBxRTkMWdvLu+3fgJTNKx7hOBgAOGUmhRYSpAMQ9f517NFuBOxpPV8E/nZhWJY
         oJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706515502; x=1707120302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNxzhXty0giymLpXrYH77O7jWTFY4W0gxavbYgEJJ5k=;
        b=YJexdNovaaDuj37Vi4eLNqGz7xlNaCjZCGPa0IMT7OXYmkBj9LWgB2d/SkgOh8vw87
         S6HgfWua9739wXXQ9fYq+onPDq7KqUk3kAmYIT5uj+OuRKtt3Dk/xdmUWWkNE2XI7ahB
         fTR515rR6fsdncGeiiSqpfyoqJ74VzbugLQnkJtO1s+R8sJpop/5m8q22GfZUbcQLHrC
         uO28iCF1HPPL/rHfqqtUQk4729aXglHUrR0ky9O7hN0+0l326piNjZBuifjRvLDto0V7
         6XdWH/OeKdMqeBhaY/T7Re9tnz674uclem+nLdS4+D+fYeVW9m/bEhSTmp3h/hOUEO8D
         w8tg==
X-Gm-Message-State: AOJu0Yy6lLM9/WZxk2dEesDmj/0AtmzxLoZ1nIZO6DgSNjQsb5lhZjGk
	BHlARCYGy5k/+XDGJhnaOuBXki6bVI1gwUWWMFNXh7fWNlofk91yFWDmNrsohg==
X-Google-Smtp-Source: AGHT+IGzpUcvIYLk5R1lj1a1LsqNgJmRz2oYQdLfzrPrk5F15D4Y6WpalkVilN4QBNfpByzNuvsynw==
X-Received: by 2002:a17:902:bcc9:b0:1d7:16a2:b771 with SMTP id o9-20020a170902bcc900b001d716a2b771mr2780972pls.121.1706515501771;
        Mon, 29 Jan 2024 00:05:01 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id lg5-20020a170902fb8500b001d7859ea961sm4780502plb.272.2024.01.29.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:05:01 -0800 (PST)
Date: Mon, 29 Jan 2024 13:34:52 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZbdcJDWcZG3Y3efJ@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129071025.GE2971@thinkpad>

On Mon, Jan 29, 2024 at 12:40:25PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 29, 2024 at 12:21:51PM +0530, Ajay Agarwal wrote:
> > On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > > > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > > started or not, the code waits for the link to come up. Even in
> > > > > > cases where start_link() is not defined the code ends up spinning
> > > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > > gets called during probe, this one second loop for each pcie
> > > > > > interface instance ends up extending the boot time.
> > > > > > 
> > > > > 
> > > > > Which platform you are working on? Is that upstreamed? You should mention the
> > > > > specific platform where you are observing the issue.
> > > > >
> > > > This is for the Pixel phone platform. The platform driver for the same
> > > > is not upstreamed yet. It is in the process.
> > > > 
> > > 
> > > Then you should submit this patch at the time of the driver submission. Right
> > > now, you are trying to fix a problem which is not present in upstream. One can
> > > argue that it is a problem for designware-plat driver, but honestly I do not
> > > know how it works.
> > > 
> > > - Mani
> > >
> > Yes Mani, this can be a problem for the designware-plat driver. To me,
> > the problem of a second being wasted in the probe path seems pretty
> > obvious. We will wait for the link to be up even though we are not
> > starting the link training. Can this patch be accepted considering the
> > problem in the dw-plat driver then?
> > 
> 
> If that's the case with your driver, when are you starting the link training?
> 
The link training starts later based on a userspace/debugfs trigger.

> > Additionally, I have made this patch a part of a series [1] to keep the
> > functional and refactoring changes separate. Please let me know if you
> > see a concern with that.
> > 
> 
> I have responded to this series with my concerns.
> 
> - Mani
>
Sure, I will check there and respond. Thanks.

> -- 
> மணிவண்ணன் சதாசிவம்

