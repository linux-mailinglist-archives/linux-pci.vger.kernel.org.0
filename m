Return-Path: <linux-pci+bounces-22363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1BEA447CE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB9119E37D1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630019E98D;
	Tue, 25 Feb 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rm+HC3RI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26419E7F9
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503711; cv=none; b=TAsEGx9of/VGa387p9uT2bC7eYCjtjqqmf0+JYl2plSrexhPw4rD1Ax6Pybd/JUw8ybf1Yksk/Cnowvw45kxSeGRAiI2AwvzVe4Z3ncXY3HqlrXeDbtiROKD+RXIRecgU55GHzZa7slx8Jx9N5NTB5pMr21qqQ/Cz75cQioD6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503711; c=relaxed/simple;
	bh=bL79cNVobOr1HRq/LkKge12+uGo654Ifd9y3+CyTMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxqtt8D95IE3CCwJbTVrFVi7Ln6xMaAC5+5rLQ9gxklBH57d5RMxQL0W/CyYlajSAOrOA7fZX4u355GrWYukegX9oJFnjiWTMW9JiN3POKflBEBLM/HFelH+2ABaLbfp8Ou4C+yEHCZb23NIM1LItnp4O25uNazbmcAv/GYbod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rm+HC3RI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so9064864a91.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503709; x=1741108509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FF54yqkuvwX1pBRnFH8QcIU5TxlTBf1rKceF/MbIVBs=;
        b=rm+HC3RIaWhCKUU89MCfoXEI2TGwnmgKO51HfnF1iTpYVF0H4GGjviL3KN7tRo1l4h
         JRJ5F8PN6ae2vnrjZwyyfGdWcg8GILEOHtjMSZsoXEzHvLESsa7SZ3rylZRVHtIseFtz
         ectkD2rkofFa05sDoG8T2lQgUznRmu76psdkObr5Wh/M7hMgtpr9bcVAjbrp9hnpuJY0
         zIpJBVGt2aTHVuy/bLk6TxgU4n2RUrAxaRqShqie0IEOn6ApSZM1kQHGj/VaYziqs/Fs
         mtv4C6C5F/BneqSc++UIB2Gn2kgMOO9affc/aT0BGRmYYwHpIygb1g/Cs5SFdYDayFfj
         0Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503709; x=1741108509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FF54yqkuvwX1pBRnFH8QcIU5TxlTBf1rKceF/MbIVBs=;
        b=QXHw6QD0ndtTvxsR8ubhvIvWL1Y14+uwaYsS2/LQwu6l3dKbs2N8RANMKLGE1Gd28N
         m9b9/kwV9O9weT8IkPyY7VepJwJcN4WMwUaLq8w8cr8iPPIeQOncfz7tJJqWuWqy/DMr
         PityoZCqZ9ox6rFGaZVmAF30jy1Lc6Hp0K+4/gvyZQNRzplgGLU2VFLVJhmEwF2PRC0Y
         aEzZpKRRd/8J97B9dEW6qz9mo8qRNDWF4/dHXEWNuVwrsPClDQhDEpgJYyac9zUqFYxi
         9KIp3eIcL2etsJlnsfibFzPnh8Yvj4zEwsrm/JoZq0frz9gI5uy4hHeKopnnF5MnaE4y
         5atQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwmOpxaAlPc1PD1bvvTeWJKZXFzPeJv6xjIrC0MaGO8nvj5KUzm04GldzxQGtRlqjnG1AhDL2Prqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsEeBVUGtt5lRzN0o8STzEZco7EvJKg+uvneCO07rVGfn/K7D
	aE3FRXPU4k4RlALPb16BJLVb+to4hRveChNJPIF974U39PQIAi+9Zwcc7Rshbw==
X-Gm-Gg: ASbGnct1pvfZ9bPchHoseFTEcdq6KIzdcf2IQRg2XzSS2sFD09QdkDJQjkfW3YySkIw
	vhFcYfEUK1Jjewkuc3XautFYTChAlrevFaE1WDlRFjQATcHcUvPBBBGXHDi94hnU+h51jLM4LFx
	OJOf2iDdHHPaXI4Wal7wVJ0RBoJDVvX9AW27HsDETCHx784F0uXoRaz/vYSBdW33PH/kP2/d5vt
	+HEBPTtuHcQdnq9D6nbfvIYKY2/osus0zNvXZ4Blv0jAmw96gIVDmfoPliQUw3XxIjQeFmfQh2L
	N5tsdQ3hbl+DAAQVr1oATB9nRBX33g+iZVFp
X-Google-Smtp-Source: AGHT+IFbyIk/t2FBVqbowzwmc33Cu/Xhw0HHnO9qzMEv+9/uViTPYk/jm8Aw+qCax7VxnPMgSI0asg==
X-Received: by 2002:a17:90b:3506:b0:2ee:dcf6:1c77 with SMTP id 98e67ed59e1d1-2fe7e33b210mr241444a91.16.1740503708928;
        Tue, 25 Feb 2025 09:15:08 -0800 (PST)
Received: from thinkpad ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceae302e7sm8889686a91.0.2025.02.25.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:15:08 -0800 (PST)
Date: Tue, 25 Feb 2025 22:45:01 +0530
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
Message-ID: <20250225171501.ahjmawunnpyc7wwa@thinkpad>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
 <Z7yniizCTdBvUBI0@ryzen>
 <20250225082835.dl4yleybs3emyboq@thinkpad>
 <Z73VLYudJVPkdbGN@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z73VLYudJVPkdbGN@ryzen>

On Tue, Feb 25, 2025 at 03:35:25PM +0100, Niklas Cassel wrote:
> On Tue, Feb 25, 2025 at 01:58:35PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 24, 2025 at 06:08:26PM +0100, Niklas Cassel wrote:
> > > Hello Shradha,
> > > 
> > > On Fri, Feb 21, 2025 at 06:45:43PM +0530, Shradha Todi wrote:
> > > > DesignWare controller provides a vendor specific extended capability
> > > > called RASDES as an IP feature. This extended capability  provides
> > > > hardware information like:
> > > >  - Debug registers to know the state of the link or controller. 
> > > >  - Error injection mechanisms to inject various PCIe errors including
> > > >    sequence number, CRC
> > > >  - Statistical counters to know how many times a particular event
> > > >    occurred
> > > > 
> > > > However, in Linux we do not have any generic or custom support to be
> > > > able to use this feature in an efficient manner. This is the reason we
> > > > are proposing this framework. Debug and bring up time of high-speed IPs
> > > > are highly dependent on costlier hardware analyzers and this solution
> > > > will in some ways help to reduce the HW analyzer usage.
> > > > 
> > > > The debugfs entries can be used to get information about underlying
> > > > hardware and can be shared with user space. Separate debugfs entries has
> > > > been created to cater to all the DES hooks provided by the controller.
> > > > The debugfs entries interacts with the RASDES registers in the required
> > > > sequence and provides the meaningful data to the user. This eases the
> > > > effort to understand and use the register information for debugging.
> > > > 
> > > > This series creates a generic debugfs framework for DesignWare PCIe
> > > > controllers where other debug features apart from RASDES can also be
> > > > added as and when required.
> > > > 
> > > > v7:
> > > >     - Moved the patches to make finding VSEC IDs common from Mani's patchset [1]
> > > >       into this series to remove dependancy as discussed
> > > >     - Addressed style related change requests from v6
> > > 
> > > I tested this series, and one thing that I noticed:
> > > 
> > > # for f in /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/counter_enable; do echo 1 > $f; done
> > > 
> > > # grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/ctl_skp_os_parity_err/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/deskew_uncompleted_err/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/framing_err_in_l0/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/margin_crc_parity_err/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_1st/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_2nd/counter_enable:Counter Disabled
> > > 
> > > that there are some events that cannot be enabled when testing on my platform,
> > > rk3588, perhaps this is because my version of the DWC IP does not have these
> > > events.
> > > 
> > > (Because all the other events can be enabled successfully:
> > > # grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Enabled | wc -l
> > > 29
> > > )
> > > 
> > > 
> > > So the question is, how do we want to handle that?
> > >
> > 
> > This is a really good question.
> >  
> > > E.g. counter_enable_write() could theoretically read back the
> > > dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > > register after doing the
> > > ww_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> > > 
> > > to actually check if it could enable the event.
> > > 
> > > If counter_enable_write() could not enable the specific event, should it
> > > perhaps return a failure to user space?
> > > 
> > 
> > Yes, it would be appropriate to return -EOPNOTSUPP in that case. But I'd like to
> > merge this series asap. So this patch can come on top of this series.
> 
> I agree that returning an error is probably the nicest thing.
> 
> However, this series has been picked up already :)
> 
> Is there anyone who volunteers on implementing the proposed feature?
> 

I did and submitted the fix [1].

> If you have time, it would be interesting to see if you see the same behavior
> on QCOM SoCs. (Assuming that your DWC PCIe controller does not implement all
> events that Samsung DWC PCIe controller does.)
> 

Yeah, I observed the same behavior on the Qcom platform, though only 2 counters
were not supported. But I also noticed a null ptr dereference due to refclk
dependency, so submitted a fix for that also.

- Mani

[1] https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sadhasivam@linaro.org/

-- 
மணிவண்ணன் சதாசிவம்

