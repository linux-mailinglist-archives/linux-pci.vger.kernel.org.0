Return-Path: <linux-pci+bounces-18473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315F9F2975
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659DE1644EC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 05:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879041BE854;
	Mon, 16 Dec 2024 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABAZYtdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9107101DE
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734326131; cv=none; b=YTgsEQFv4lMe/6OD1Y/WeulL1p+UWfzHFPFNW7AbrbhGqXv012AGSJl6kcIJEtwVRs1yEWHnF7mQfuUi31Rb5x9fRBBWXqVp46rUgI8AfUZN/OacHLL1gaxdPtkjbWYcGZpjTSa1YgAx9H7sPZaG4KAKNie6jpjDmhRGWGqHPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734326131; c=relaxed/simple;
	bh=PwhcJa/TmnY399+VVjeEk9qTIf31eA07uj1mutyX3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d69N0aOXFv4wN4qfobJAhVIIhmkI+A2C6EyxWNgVVg62FPtYhypCX1EH4hHx/hryP8+9V0jDAvphrHmm4ERVAZRIN3B6EiZdcpl6FvvUBl5GPCNMEvoSkcwCvn/B434A1wmbuStCmEiEKt6K1sea046DLdYYpdNRkO0POM7XH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABAZYtdR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b1f05caso32812025ad.3
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734326128; x=1734930928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2EN8z4yfQzDg2ZyL+ahpPhOPA947/EvCJNjKFK6oUQo=;
        b=ABAZYtdRrEbLvBiqlbUXhiFwLTVSn2hDelefZCXF2W8hRQM42WUcFAUXWHkxYibx5c
         X6Qa0vStdIiKE9HKGS4INCQrXCIQkYwcHOmbEJ7RNrtjdP6OxzlZojcKIhhk9LwpSCFf
         yM0kRLqE2xRn3lPh4UJXXgUQg77BcnPAOVQ5Ol0Bpvc3rRqQFEKXb2a/PzTrKFapojOj
         aDp6zO/doXqDtVG5LYPBkfNjdIHL4LAMXuFlE6NmD/AYg7SPb5bKeJOH3WBAanm95SMu
         HEK2Xu/CwofqPMLsGwIyS6QJXa0Jk2I2K0PWk6A3s3PAq5muM7E9dCXm/AVbe/eNp0Yo
         pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734326128; x=1734930928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EN8z4yfQzDg2ZyL+ahpPhOPA947/EvCJNjKFK6oUQo=;
        b=aMnh9q0ClF62pWNT8/fZnvbgoBxpb7zq1ENSm8FSpqVXtbqRgL0Us9GxbtTnSnKsWO
         DSDXLiINw9ALiWb3GChnR8Qf9yXq4I2fvsjRFTCeuSNKPCHJVfBrHTX12zC1F0FHai2b
         sB5pJLKdB77q7TbI4douUamH1FEudHJvWFW3gQXx18fNoW/QYRYF2Lf+rxvpYM2AaGCq
         HXYGBaz+I7bmtT1IGPhTvnfq3ZUa+eVNp0aTT5s8nlaaMvcF4K2gN5NbLV5e7W9NBm4v
         PbDA6JDkT8J1fwwbNa/4cWLt3wcXTC3/pZxAxcv77B66Mt7SPd6B1BREezmxt0h8fXCj
         tIuw==
X-Forwarded-Encrypted: i=1; AJvYcCWi2fjby2pNXRFMT++BgMD6+HV2XEWY2FI2sb5P2TOLzq2rOUPQFJt6PIFQp0UjcVJL2PLMY+xK5RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUauZ0GiM2ITY2kC0bVeeMCmGv77KuJJbx/vFvoa2GlimtpyhK
	b8f5tVVkxzbW4t0kbis98qpEkfFU9Wc83W0V/9I6YEQgKdPiaPB4SYBaLdYrUw==
X-Gm-Gg: ASbGncsmXxgvcLdh63Gw7HLk8xEydoURKyMAuabaQR451dU+imGDPxwdappdgXd7xld
	dZK+ZW7iZcWF7/zxWVUso6WTJ6e8ryBxISbtDmUqDmprigCW9cDyGs2OukTXelKgl+2TwDkT+CH
	7ZnKGG1JgaYgMBkcSYPcW4l4NWNLSmD+B/Imajtn43POgD2DVG3r6QN/fq2KQckar3ny16R+mub
	JYbmnG1BXX3UX3748XwhYMcuKiWvLVAKeL8vuy17jzgoZlkKcX9mgIE+fnP8BdiwRM=
X-Google-Smtp-Source: AGHT+IEMP8YM6TuL6qVyh58qxEkJbFtc4o/lf1lSrWgzvSZJy9EuiwBZNZVTksyPMD0w6gMN1nKY3g==
X-Received: by 2002:a17:902:e804:b0:211:efa9:a4e6 with SMTP id d9443c01a7336-218929cae30mr161611955ad.23.1734326128114;
        Sun, 15 Dec 2024 21:15:28 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50a97sm34234645ad.149.2024.12.15.21.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:15:27 -0800 (PST)
Date: Mon, 16 Dec 2024 10:45:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Move creation of pwrctrl devices to
 pci_scan_device()
Message-ID: <20241216051521.riyy5radru6rxqhg@thinkpad>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-1-eae45e488040@linaro.org>
 <Z18Pmq7_rK3pvuT4@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z18Pmq7_rK3pvuT4@wunner.de>

On Sun, Dec 15, 2024 at 06:19:22PM +0100, Lukas Wunner wrote:
> On Tue, Dec 10, 2024 at 03:25:24PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2446,6 +2448,36 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  }
> >  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> >  
> > +/*
> > + * Create pwrctrl devices (if required) for the PCI devices to handle the power
> > + * state.
> > + */
> > +static void pci_pwrctrl_create_devices(struct pci_bus *bus, int devfn)
> 
> Nit:  AFAICS this only creates a *single* platform device, so the
> "devices" (plural) in the function name and in the code comment
> doesn't seem to be accurate anymore.
> 

I missed it, thanks for pointing out.

> 
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 2fb174db91e5..9cc7e2b7f2b5 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -44,7 +44,7 @@ static void rescan_work_func(struct work_struct *work)
> >  						   struct pci_pwrctrl, work);
> >  
> >  	pci_lock_rescan_remove();
> > -	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
> > +	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
> >  	pci_unlock_rescan_remove();
> >  }
> 
> Remind me, what's the purpose of this?  I'm guessing that it
> recursively creates the platform devices below the newly
> powered up device, is that correct?  If so, is it still
> necessary?  Doesn't the new approach automatically create
> those devices upon their enumeration?
> 

If the pwrctrl driver is available at the time of platform device creation, this
is not needed. But if the driver is not available at that time and probed
later, then we need to rescan the bus to enumerate the devices. This is pretty
much needed for platforms lacking hotplug support (most of the DT ones).

> Overall it looks like a significant improvement, thanks for doing this!
> 

Thanks a lot for your inputs too!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

