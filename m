Return-Path: <linux-pci+bounces-7626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECEA8C8A79
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96A02827E3
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B113D8BC;
	Fri, 17 May 2024 17:05:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6312F5A3;
	Fri, 17 May 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965503; cv=none; b=aun2bsP7wLeprPcirlVtLEvTxyhFvhxwZrPrfwd09AykzSyuBV79AgcxD4WLH5zl9pn356sFpRJgUvk/IiJzx2ZVCb2tiJuFrxnoPofPkllGg+mLScsErwWqu+a6bCsTNg1k6p9qokvYHYn7J182sBcLAyisk8qtnHVvgpPaMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965503; c=relaxed/simple;
	bh=2saU97BMp6H+PskEfO8ECL2dYQUoDkmrv2Pt6mDwnvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuL1glGh52t1JnTkqK/TtuiT3wJ5Ak+9yZ832QxBhPwTrMD9QutHfUl9zeXvtPDGFw0M0y/qC4cNIQpLzS+8qVxNaNyXz7Cu2LLYcJzKudHu24iiej4PEMItsaCYEqF1BY54oZlGK3tKLyav+MIsFWdD+gyEDelp847K0xb4z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f43ee95078so1207177b3a.1;
        Fri, 17 May 2024 10:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965501; x=1716570301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAF2nClB9tdRe2nZvO7iQeg/IDzJ4PErDPhyqSEtfbs=;
        b=DSJxJQebzWu5xSgI6UnReibZT/cbSLtcO7vjcMtmv6SAYggz7hUGggTuwrrLQQzP3C
         tedQf9tOtSJKALUj+oIFuR6IbZvWtiqM0H1IsDe1qTxQtEXiv/bw5FY+91rkb/Crij+m
         C63833qMtVdnRiCo1zXYZNncW04Q6pnz97C2x8Sn4xZWz4XKA3V/ZpDtCLEonmrQU52C
         HK+CfXMzujTv4NSymJ4ceXCCZzGyCc+qC+hmcEdTG8fawG3N9PSEnO6FUoV6e2TDQxWq
         hMDlGWBUL+9ijCpaKpwMQb09MPhMov8yod1ZUGGQP5LzGxkB0vqT58fbOZPp+uIfGMPO
         50kw==
X-Forwarded-Encrypted: i=1; AJvYcCWwnI9FrHb9P2V1Tt/Mlo+skvseXbrUYIWFwcT4Ai1ofbdFT0iQdfp44mL0kucH4d9X8e7AMGyV2FWm/bCgnAqQgycl3+VRXthgYZAEiWIGbf9I77V5pmtgKO16NgLCiUZtWlitQFdBvMsyqzW76u69rTEL+t3WSv9N1vSGW+7bpXNfpnIR8GRIoN6bpSYpfhkxgjD8LhCXE/pkQQiQNe5xyrkW14oTjBBlak02CK0WD99yZp0Eqlbok2ZJxGEIKjNN+yXYGn6cTO018iRepc+zLJ0l/KHJSFKEoNvKh1aL4jDl
X-Gm-Message-State: AOJu0YwDLnAW0dRTbZfHhstbo3bIqRm7W/7scm02X1604Jqb7vLmpbgn
	9Yqo786Hzg0niJ36B98IjvJxEVQAZWXzECkMLvPfkdT+n5pWpjak
X-Google-Smtp-Source: AGHT+IGDk5wz8T58ydDnsgGbyCZmHKCAeGjDn9utiYyGXMhzVl4Lcok/JS9rF8CQMUTTLF/lj2nWEQ==
X-Received: by 2002:a05:6a00:238b:b0:6ea:afdb:6d03 with SMTP id d2e1a72fcca58-6f4e02d3ef9mr24111615b3a.19.1715965501417;
        Fri, 17 May 2024 10:05:01 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f68c7d3651sm1904783b3a.183.2024.05.17.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:04:59 -0700 (PDT)
Date: Sat, 18 May 2024 02:04:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
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
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v12 0/8] PCI: dwc: ep: Fix DBI access failure for drivers
 requiring refclk from host
Message-ID: <20240517170458.GA1947919@rocinante>
References: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>


Hello,

> This series is the continuation of previous work by Vidya Sagar [1] to fix the
> issues related to accessing DBI register space before completing the core
> initialization in some EP platforms like Tegra194/234 and Qcom EP.
> 
> Since Vidya is busy, I took over the series based on his consent (off-list
> discussion).
> 
> NOTE
> ====
> 
> Based on the comments received in v7 [2], I've heavily modified the series
> to fix several other issues reported by Bjorn and Niklas. One noticeable
> change is getting rid of the 'core_init_notifer' flag added to differentiate
> between glue drivers requiring refclk from host and drivers getting refclk
> locally.
> 
> By getting rid of this flag, now both the DWC EP driver and the EPF drivers
> can use a single flow and need not distinguish between the glue drivers.
> 
> We can also get rid of the 'link_up_notifier' flag in the future by following
> the same convention.
> 
> Testing
> =======
> 
> I've tested the series on Qcom SM8450 based dev board that depends on refclk
> from host with EPF_MHI driver. It'd be good to test this series on platforms
> that generate refclk locally and also with EPF_TEST driver.

Applied to controller/dwc, thank you!

[01/08] PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host
        https://git.kernel.org/pci/pci/c/869bc5253406
[02/08] PCI: dwc: ep: Add Kernel-doc comments for APIs
        https://git.kernel.org/pci/pci/c/7cbebc86c72a
[03/08] PCI: dwc: ep: Remove deinit() callback from struct dw_pcie_ep_ops
        https://git.kernel.org/pci/pci/c/b7dec6b85089
[04/08] PCI: dwc: ep: Rename dw_pcie_ep_exit() to dw_pcie_ep_deinit()
        https://git.kernel.org/pci/pci/c/c8682a3314c1
[05/08] PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API for drivers supporting PERST#
        https://git.kernel.org/pci/pci/c/570d7715eed8
[06/08] PCI: dwc: ep: Rename dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers()
        https://git.kernel.org/pci/pci/c/7d6e64c443ea
[07/08] PCI: dwc: ep: Call dw_pcie_ep_init_registers() API directly from all glue drivers
        https://git.kernel.org/pci/pci/c/df69e17ccc2f
[08/08] PCI: endpoint: Remove "core_init_notifier" flag
        https://git.kernel.org/pci/pci/c/a01e7214bef9

	Krzysztof

