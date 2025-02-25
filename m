Return-Path: <linux-pci+bounces-22296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66DAA4379F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18297173D8C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAC25E47D;
	Tue, 25 Feb 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYLm3EZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6F152196
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472124; cv=none; b=jdH9nJqa44dgpDRHMepN3Dhzy2K35BrDVD8HFVLBE3GvJc1W20xOVyJQW4QBVm+XTwI9dS9N16KWDufN6tOQhkm7bvGnVpdACIvWDwmWaZvxaTiVI/ctKeRUu2B030Bj7dZNvfslHEWvmjSGoTPDvet/n78iXtEwyg8P8WWZWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472124; c=relaxed/simple;
	bh=ZBu2O8F+O0lq76BGmqBcGCD16yBaXXF7E8cefYSt1yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF9nzkOoMBAOMgGN+hMC2PZx5l8CKuetygM0kAgALutIw10Tnu1tmv0Kyl2QIygMu0f3Q6HdTefNZ32k3zqR3cv6z1bLdUPqCrWNkJwQPiXieYYmP18XZmYRi8smn28vqpWzCE1Pkyu5dHt5DnL3YaQ/uyg5vffHhxOJsYJEYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYLm3EZe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8f38febso111824945ad.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 00:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740472122; x=1741076922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQhuTT3keTFG3C8+wYIEtpMC3dYXL5RKzFQ+SXkD8fQ=;
        b=HYLm3EZeD/MmeUVxZ7CioUtHLoI7BIEWTtNXhk2bCFMFdHX2CebG5hVKO4zwQ+YsyF
         C5i+aj1XyFKPTxInqu2MZxsFRvPJ7lKWqi8iEGuKAdbwfS2rTupRcJc1d9iwHQGjThwx
         idLvDzpjlCopdG82NljaHYquIwY/cW3S2d2ngu62sB/BPpZ0Ca0Ckk3Fx9bqTRCjPGpX
         nH000uWxiAPjoQqbUOZBIDA5+AalAV0I7djcbWDMPgzOozR37qU0mjcIEEwGZaB5fvJa
         BGhFEupvedjUmdLOT0LJJyM7XfHyd3BZ3/u+IL1AGac/Qjav5AJ5FqkGvYdaQHoOtMvj
         HlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472122; x=1741076922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQhuTT3keTFG3C8+wYIEtpMC3dYXL5RKzFQ+SXkD8fQ=;
        b=r29/VKagS+NrQSoi6NZmxFgp51Hi5K7s9kFLeqUiwqH9//25k9bwLs1oxL1WPXbb9e
         rju+SqUKdGeCE/M+O5jRqBdSfnd2oC25/Mz1XGLSPe1WvDBy5TnZvrmuez+PGlKYp/Wg
         8ZGhzwDfMxfX556Bf8YmslhUz079ZkPHc66HrHexDpE9tS12eqCinGWW0OPgdvu/ww03
         O8dz6F6Nsg8UFpi/WIH4Dtd37n8LdySueCzk0iR8glQSgESaaK/JmfwsjF78eUK1ZMrh
         w2vvl6GYZ5uaEIzziuslBMfFrVLtUMKUmTDYbIh0ftKxKn2KrcoIJFsNVuXXh8FK7h/Q
         5oJw==
X-Forwarded-Encrypted: i=1; AJvYcCWK7CTgtEFd1dEmd/miWGdQ7PZ1+jjhz/7PXFR0rlKYcYe406mTRt/uP7bxs+kmO821hvByxBtOzjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgpvfRptyfcnb7oF3FQWKwEnIImWCjFFMFnI7svnJwLmX1PKn
	h/Nuswh4o8pSwOwA3XSZwgXP+eYMbAlGCvNgFW+e8OjlGy6KPcRRKPxMzcTwEA==
X-Gm-Gg: ASbGncsz+y30hcgjzZ22ULo9vD9+G7PC3LGewfkv3vTjEBiZ72sgLwUk2T80lz/BFz4
	OElT7H/Jbyz6ZNulYJ3CAT/1ypqCJhAFqyaKmGsSG8lX/tKSOP9N6frGUUtNrIGyWI75XHA9LzD
	OyMW+Tgm4Z6J/sHXKMW+IBMDsuwvWIf5k5J9LP92MJswKdTucdguivW1L8420ka7wJGi5jzrxrA
	M6rtoDuUL42XzvhTB2QL0Msl8iuveTa46LVcIwpWmtSK8yExzZGfDmConChxDcT2UWe35aDaBJ7
	W7F2sI035cSapanxPcfVuxi8zsJnTtrfuK8z
X-Google-Smtp-Source: AGHT+IHEpwYAv8u3qb59FV+xDfGctwCas/kzce4Z4IGvei21yGE+B1pj/P69NtHMGX6VmXsFeRHsJg==
X-Received: by 2002:a17:903:1c1:b0:216:3466:7414 with SMTP id d9443c01a7336-221a0025b25mr313420375ad.44.1740472122399;
        Tue, 25 Feb 2025 00:28:42 -0800 (PST)
Received: from thinkpad ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b7790sm8728625ad.254.2025.02.25.00.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:28:41 -0800 (PST)
Date: Tue, 25 Feb 2025 13:58:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <20250225082835.dl4yleybs3emyboq@thinkpad>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
 <Z7yniizCTdBvUBI0@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7yniizCTdBvUBI0@ryzen>

On Mon, Feb 24, 2025 at 06:08:26PM +0100, Niklas Cassel wrote:
> Hello Shradha,
> 
> On Fri, Feb 21, 2025 at 06:45:43PM +0530, Shradha Todi wrote:
> > DesignWare controller provides a vendor specific extended capability
> > called RASDES as an IP feature. This extended capability  provides
> > hardware information like:
> >  - Debug registers to know the state of the link or controller. 
> >  - Error injection mechanisms to inject various PCIe errors including
> >    sequence number, CRC
> >  - Statistical counters to know how many times a particular event
> >    occurred
> > 
> > However, in Linux we do not have any generic or custom support to be
> > able to use this feature in an efficient manner. This is the reason we
> > are proposing this framework. Debug and bring up time of high-speed IPs
> > are highly dependent on costlier hardware analyzers and this solution
> > will in some ways help to reduce the HW analyzer usage.
> > 
> > The debugfs entries can be used to get information about underlying
> > hardware and can be shared with user space. Separate debugfs entries has
> > been created to cater to all the DES hooks provided by the controller.
> > The debugfs entries interacts with the RASDES registers in the required
> > sequence and provides the meaningful data to the user. This eases the
> > effort to understand and use the register information for debugging.
> > 
> > This series creates a generic debugfs framework for DesignWare PCIe
> > controllers where other debug features apart from RASDES can also be
> > added as and when required.
> > 
> > v7:
> >     - Moved the patches to make finding VSEC IDs common from Mani's patchset [1]
> >       into this series to remove dependancy as discussed
> >     - Addressed style related change requests from v6
> 
> I tested this series, and one thing that I noticed:
> 
> # for f in /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/counter_enable; do echo 1 > $f; done
> 
> # grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Disabled
> /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/ctl_skp_os_parity_err/counter_enable:Counter Disabled
> /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/deskew_uncompleted_err/counter_enable:Counter Disabled
> /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/framing_err_in_l0/counter_enable:Counter Disabled
> /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/margin_crc_parity_err/counter_enable:Counter Disabled
> /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_1st/counter_enable:Counter Disabled
> /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_2nd/counter_enable:Counter Disabled
> 
> that there are some events that cannot be enabled when testing on my platform,
> rk3588, perhaps this is because my version of the DWC IP does not have these
> events.
> 
> (Because all the other events can be enabled successfully:
> # grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Enabled | wc -l
> 29
> )
> 
> 
> So the question is, how do we want to handle that?
>

This is a really good question.
 
> E.g. counter_enable_write() could theoretically read back the
> dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> register after doing the
> ww_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> 
> to actually check if it could enable the event.
> 
> If counter_enable_write() could not enable the specific event, should it
> perhaps return a failure to user space?
> 

Yes, it would be appropriate to return -EOPNOTSUPP in that case. But I'd like to
merge this series asap. So this patch can come on top of this series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

