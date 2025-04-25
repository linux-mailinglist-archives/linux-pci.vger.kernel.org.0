Return-Path: <linux-pci+bounces-26765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF63A9CD80
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ACF4C8905
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE028E618;
	Fri, 25 Apr 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j05UV5dP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710127932E
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595979; cv=none; b=e2/p1IrJcaY3dZah0nDp4UyykSzZ0XEbRDvhtqhpihezKp9Q3a2WNnTKew7BQCujsClKUWIqoTyahdTtlvyqzNQ8ZzAymv2VbwBxUdRJ347wiD5bFhh/WgLmTJTc9c6PAoltjTIJsdX8z9ZWOvChFSa7HkCO0EJ/eIJ4gIDQ3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595979; c=relaxed/simple;
	bh=OEN/M7xAkfDtjvNwKlr/jucG4cQOWcjtHRGd69J9SGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDi7KLQMjP1P63JMbU+UaqFskm1b1lIuEkkkiAyJOdbD+ZnL24tW6kofYkZeHI59GSSlgagdpAS2u0GGYQQ45q6SShNEOHFBgvvQfDfIb1tGfwfxq3PbDn1Mi2klDI+Dse+1Gu5ANW5EVcP/ZYaFnOgDhoVhOnXOE8ckvdX9peQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j05UV5dP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso2615262b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745595976; x=1746200776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0yjiKObWEJiwO02DaOrPmXbmFq+eaftYKKT34xnJk0=;
        b=j05UV5dPOBy43iHV+sWZT+yAPem7J7c/EFHZyA9g/WbDbkdHA4L4U5mlWTvXyZ/pya
         1KZJEJJM8+mH1KufUe/KDFW17zAkJGGDWvnFdxr/+IdzMlfmg5rBFAfZppMbD+pPs9yq
         SAfquee+kxH36o3IUKPzBN/PKsk66fQnTs8ouVt0hYQXar0wscnL7c+zFIrOgInHwI47
         ImAPwxXq8Vj0/1RdLNd8DkqhtEZ4UrDL0MKceZzGhd3rnQfEMWKIoFYF/bhPuhYyOK7v
         2GB9WWtKRTUxIOGhVnuVdqzrkCR4ab6v+RC47jbQWN2hoxuAdbFyqMcGs6N3jJHUEt9Z
         wVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595976; x=1746200776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0yjiKObWEJiwO02DaOrPmXbmFq+eaftYKKT34xnJk0=;
        b=nR2fCEyj2DVJESN2ZC+orDAnjaY8K7ZBdRrx8+Y/kfFVusVU4xOi7bcAD6I/GmlaWg
         JgwzUNlrTwUjV8w+n2O8B6lk7Z8uu40Tsj2Afxf63OJGVLLcMmIJMdl56e9xQxf1KmBY
         ysmv4pvgOwb3Mzy8fYkCNticQbUw3lgWOYuz2vdjlRMHB/s+AP3yg2OctyRQpwpd/el+
         iZMlR852WjCvAVATanR2+RdWKh82U+PfywceO3yXP8A5rVvStqy5zU/P4GBBiYijEF0d
         pBP96yEbPfeIDxH3N5AfAGuDJm9W0FRaFuahmHp8abDUsyiUCkZ70hiSby6PCveqTGYi
         VsWg==
X-Forwarded-Encrypted: i=1; AJvYcCWv+GLu8+7OvmudBeTUT2NtwaBsRbgxHdTmUXlnsQO66zlJgIVla95m1zcq6lbN3Zbiz7UKhtRgFws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0OMZDONN77V/YsLi6uEtM9E/q8+j4IgIl2vj57u6FnYcsVZ5
	mQdg2DWSjB0ND0NicK1SXnuZpv8jRf7GBgZ8Duq1DUXvfQ35YEEoSqQc1Bq2CQ==
X-Gm-Gg: ASbGncu6TwFiYred8hyWs5czi+vkD7DeLZiOMuRfmBOWK8u1ReZ99TO18wg4qOqVduq
	Wzg9lh4TIfI/yd8pv45iMWOTZ3xYh+n6t+w84bKWGrb4tp9f4nqkvhNAsds27DLBNrb8EAZnhKV
	gCkgok7ZYcI9BU4DaozT2T1fqV9VgRm2aM3zvGLFGschoNh27FeQ8O9ePeEAkGk9XJZGfhT2RrN
	5ieFxfEY62obO5HEJLCIeNE9UtapAhtDEGsQtXfbCEadzDH3q0eILEnOO8DTfoXYibHjVWcjQuM
	Bab0nyFppOMOOo0U+AXsnUrqa1qf3UxzZPOkdl4BKRMjQ7cNTga0
X-Google-Smtp-Source: AGHT+IGs6qXZbOiWmzBGdrbn2GeizUSvYWBYF7LQu+E/gHowSvXPMU/F/cIhQAuYikQ05w1s5IHkLg==
X-Received: by 2002:a05:6a00:e1b:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73e268ee7b6mr11186888b3a.11.1745595976351;
        Fri, 25 Apr 2025 08:46:16 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25967608sm3316408b3a.81.2025.04.25.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:46:15 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:16:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 01/10] PCI: update current bus speed as part of
 pci_bus_add_devices()
Message-ID: <azxdhgvf6vo6eilmdmxa2ryir33h5uqwuru2a7jrgjuunyncrb@q3fdjhcaskjm>
References: <20250313-mhi_bw_up-v2-1-869ca32170bf@oss.qualcomm.com>
 <20250313170001.GA738398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313170001.GA738398@bhelgaas>

On Thu, Mar 13, 2025 at 12:00:01PM -0500, Bjorn Helgaas wrote:
> [+cc Bartosz since this is related to pwrctrl]
> 
> On Thu, Mar 13, 2025 at 05:10:08PM +0530, Krishna Chaitanya Chundru wrote:
> > If the link is not up till the pwrctl drivers enable power to endpoints
> > then cur_bus_speed will not be updated with correct speed.
> > 
> > As part of rescan, pci_bus_add_devices() will be called and as part of
> > it update the link bus speed.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  drivers/pci/bus.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 98910bc0fcc4..994879071d4c 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -432,6 +432,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
> >  	struct pci_dev *dev;
> >  	struct pci_bus *child;
> >  
> > +	if (bus->self)
> > +		pcie_update_link_speed((struct pci_bus *)bus);
> 
> Why the cast?  I guess to discard "const"?  I would prefer to avoid
> that if we can.
> 
> The only existing callers of pcie_update_link_speed() are from bwctrl,
> where it obviously makes sense because bwctrl manages link speed, and
> from pci_set_bus_speed() in the pci_alloc_child_bus() path.
> 
> If we call pcie_update_link_speed() here, do we still need the
> pci_set_bus_speed() in pci_alloc_child_bus()?
> 
> Bartosz, so you have any suggestions?  Is there a point in pwrctrl
> where it would make sense to do this, similar to what bwctrl does?
> 

I'm not Bartosz, but I could speak for pwrctrl.

This should really be part of pci_pwrctrl_notify() in pwrctrl driver. Pwrctrl
driver is already getting notified with device additions and removals. So the
update can be performed once the device addition happens.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

