Return-Path: <linux-pci+bounces-18659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B129F52A0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C83D1884F2A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B41F8697;
	Tue, 17 Dec 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+cw8ieG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC841F8909
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455849; cv=none; b=ay+92axxteoS511JwyK+H1moIZdNeihhtJIg77IVMs4RIrMJNc9oKxNw1YgZJtABXgR8PkpIHGCtKO65wNEHLJifc+b88TT1jys/kzDqjSocSvGyWQ417rRFbRow7YPzYNoora0JYtlU8RDzCQ0Nyqsby+Kmeph4sc11q3HOVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455849; c=relaxed/simple;
	bh=4Wju0L+ekzq44nRzcQmCPIRzf2mtM6FZNCx4PGYgx1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDLAbcgnp0Gv/re+OOB8RDMEoKKPW3WUvSWVNJ/aaoG2uTRkcGjO0qsEW7ScQLudUIk3Y3QqAPxLSC3J3tGvCfTHSIELGjLXVyJeACzY55p2HFpd5iLkJfAVSVqB/IVj6SzMD/4pSPwacCdPFA5eVGIJDmhasI2eqnfFkpUfqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+cw8ieG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21683192bf9so53122995ad.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734455846; x=1735060646; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EWKZ7yU7lz3ojV6mlmNYCITfdB0jo1tGhiz+XfLBXW4=;
        b=j+cw8ieGLqgJigm/AE6vSXZagCTWfnOvUEYLsuaSeJZo15IJjpS074jkVJSlBVMAJL
         Kuvm5rw59P1kQzp2eXu3ElneVuNxzXaNGnz5rDbuQhcYHSGR5aCVJ1jUTtHDhg6GhqC5
         rKeltQJ12dG4PZaXHs9rP8rJvRQhXqUx+znIuyBGx4sxR1wkR+aZlSncnTptsGh5et6l
         GCn4wY6fFEAfrJ899x8pCz/xyiLLpUZ68c+es37LYgWAliENRc8io6MUDuspPmkM/Yrd
         7GlJFu+uSgwSK3H6+MMcoB8rkZ3El3ECmSAM/5dfPdXvdi8kDgOGlEWltVpHwPL3reZM
         G/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455846; x=1735060646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWKZ7yU7lz3ojV6mlmNYCITfdB0jo1tGhiz+XfLBXW4=;
        b=JHdoLhZ2TDO7tiwXVNTFQpjI4RsjRXfaZFqWKI/kYr6rRF5XLhGdBfEx1LgydzwOv1
         XFSZZxeCLg7g4w/1flNeJ7HqM0Us/d/c0v3q1QJ6sIE8LBU/fKBLWy3XeVJ0mAmw/AkB
         Ny/O8+IvUEVKRYMBlFufMgp9hK2+PI9L6p23+s54LT5NIZ9eORhqKs4TVXIVtV2aQqxV
         L2E04aXDXj4LKe11j1oBkBs7aGiPaT0RFFNtFOZaFPCgqrX2HrYyAukLjY96xMIQSFaT
         g+4ldCHDYSwhfo0h8f91lv8lyGO1syawAflWvplIKdufmG/I6LIofojsxL4KOPG7FU2l
         +wVA==
X-Forwarded-Encrypted: i=1; AJvYcCUMn109yX/EV39pu3a9hc1ALSpq67vC/Nl3So18QtXtUB/UJQhfP5LmH7NKAfybZSbjI5/R9H+FMYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjfLecrAoZ853UonjeqXY2n/jOAxwJSgp3lzNS3zxC4w/Vi5C
	5KZezlhbLyL5LTpvOah1EijZo2nYGDTy5TZcl0TRf2H11GB8kL1G8cll8YP8zw==
X-Gm-Gg: ASbGncslw1kH15PJlsvLLFe/f3IcCyWzpAh6Xz8LaWkkkLkwXRlxEcuuZc7qFiQXAMD
	NU3UnLYtyDrw57Q4qJLCrFqE85GJ7kQIyRanAhG9KWh/2Uxxdgxql/p4/+LmzlnjqnWSvvkRO6P
	EschVYbhi0rZGSDeKj7VFCqpMtaGz4OR6TPOhCQBDbEq7q3s3zcpIyu+SKAD1EwgPMWDgJ6rxtF
	yYnrtKsxrAdpSxlhD9B8zWdxfGRTzc7AtB9VDVoiZqXTuJzUcTnXcLBp3P6AwBBZlU6
X-Google-Smtp-Source: AGHT+IHw0j4waZkD5AOaUOZbUb/afL8zOjtN94gaSgY9b1aG30bn7rZvne7ekkCLaJV9utR7RGn4Ig==
X-Received: by 2002:a17:902:e88e:b0:216:386e:dd8 with SMTP id d9443c01a7336-218d4f76563mr4328115ad.17.1734455845878;
        Tue, 17 Dec 2024 09:17:25 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5011bsm61959185ad.152.2024.12.17.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:17:25 -0800 (PST)
Date: Tue, 17 Dec 2024 22:47:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241217171715.wqawrrk3c7bdmxtn@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
 <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
 <20241217164149.vuqwtthlykn7bobj@thinkpad>
 <cab48574-503b-48dd-9fe4-71e5c4c86d4e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cab48574-503b-48dd-9fe4-71e5c4c86d4e@kernel.org>

On Tue, Dec 17, 2024 at 09:03:08AM -0800, Damien Le Moal wrote:
> On 2024/12/17 8:41, Manivannan Sadhasivam wrote:
> >>>> +	/* Create the target controller. */
> >>>> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
> >>>> +	if (ret) {
> >>>> +		dev_err(&epf->dev,
> >>>> +			"Create NVMe PCI target controller failed\n");
> >>>
> >>> Failed to create NVMe PCI target controller
> >>
> >> How is that better ?
> >>
> > 
> > It is common for the error messages to start with 'Failed to...'. Also 'Create
> > NVMe PCI target controller failed' doesn't sound correct to me. But I am not a
> > native english speaker, so my views could be wrong.
> 
> I do not think this is true for all subsystems. But sure, I can change the message.
> 
> >>> Why these are coming from somewhere else and not configured within the EPF
> >>> driver?
> >>
> >> They are set through the nvme target configfs. So there is no need to have these
> >> again setup through the epf configfs. We just grab the values set for the NVME
> >> target subsystem config.
> >>
> > 
> > But in documentation you were configuring the vendor_id twice:
> > 
> > 	# echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
> > 	...
> >         # echo 0x1b96 > nvmepf.0/vendorid
> > 
> > And that's what confused me. You need to get rid of the second command and add a
> > note that the vendor_id used in target configfs will be reused.
> 
> vendor_id != subsys_vendor_id :) These are 2 different fields. subsys_vendor_id
> is reported by the identify controller command and is also present in the PCI
> config space. vendor_id is not reported by the identify controller command and
> present only in the PCI config space.
> 

I know the difference between vendor_id and subsys_vendor_id :) But as I quoted,
you are using the same vendor id value in 2 places. One in nvmet configfs and
another in epf configfs. But internally, you just reuse the nvmet configfs value
in epf. And this is not evident in the documentation.

> For the config example, I simply used the same values for both fields, but they
> can be different. NVMe PCIe specs are a bit of a mess around these IDs...
> 
> >>>> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
> >>>> +{
> >>>> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
> >>>> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
> >>>> +
> >>>> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");
> >>>
> >>> These prints are supposed to come from the controller drivers. So no need to
> >>> have them here also.
> >>
> >> Nope, the controller driver does not print anything. At least the DWC driver
> >> does not print anything.
> >>
> > 
> > Which DWC driver? pcie-dw-rockchip? But other drivers like pcie-qcom-ep have
> > these prints already. And this EPF driver is not tied to a single controller
> > driver. As said earlier, these prints are supposed to be added to the controller
> > drivers.
> 
> The DWC driver for the rk2588 (drivers/pci/controllers/dwc/*) is missing this
> message.
> 

Yeah, maybe you should add it later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

