Return-Path: <linux-pci+bounces-1998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF8829D87
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE83C1C225E1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BEB4BA84;
	Wed, 10 Jan 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzVq7XT5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D64C3A8
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ceb02e2a56so1939567a12.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704900480; x=1705505280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oy1BsPNrWNFyTJIe0CjvWuVfcQBjFJjZvYEeoC45cD8=;
        b=zzVq7XT5WQ14sIpafkknaAafuKpwF+XamdHCbgksiqH/AFjQPMx4pnWeR+JDzrWc92
         k6lZatjf1MPWsQkwZPBlHPmIWdQOUlyxjkhzYfe/GQ/2cSFic0GWnVx3ANvPgOhNmipf
         XQfEQ6rH37dIhQdGCDECWVPY033NweZBP9P3AbzkMEY50mMSVHRPbMSJpkpNEnQ7asH8
         sVdlE8JUnaG8WV1L0LyXyMgplJbShIMEFS6O+oPt0B2Wez5v11AezqpSZWNN7AuwrMoP
         B+NwGqJEDg8tQx51wIEZqrjj1x9t3GcsdaTxez5CTccCBxDED6dcAdZcwBaiYd+6jaeJ
         WF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704900480; x=1705505280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy1BsPNrWNFyTJIe0CjvWuVfcQBjFJjZvYEeoC45cD8=;
        b=D4eE93Ee6Wvp7k03+YKS0vF7kUikDY1vp4AemRcshHBSAzQRXBcvndF9yYhH52TwBp
         BFCOYgBk8PAS8vzrCb3mnycjMh+2wafL/Jic977FXbkFkBeGr2KjLCoYvBdVAQJrb/mR
         xTJzBqTAzvYIjCIRupGeYDiqmxGWuFVrfpFK38lSG9Xh2Z8n/XXXi0FNA98CglNoQDJU
         v11DtBFYaiq8wtPyRgfx2Pts1X38kiEQP9UezyfL+GZWI6OMOF3MvIpejf6IRbySbSXT
         YX55Zdl3RLsbzdqi0hn5SqrSe+hCsyLBMpsDqLji8PGiCygGqffY0CbFe6vVxKpuaCvX
         4H5w==
X-Gm-Message-State: AOJu0Yz+xXrtU+Cy++znKbTVFdx22TgjCAVNZjZnO4tB2pfFkBrFGdnU
	LY6QDY0nOJB4JuJSkihu3Fjgk0U0XfFW
X-Google-Smtp-Source: AGHT+IGGjrEGNOoCswUBhk7hYcKbxkcFUbdpLqPI7aRZSbFa1coLC7kZZjw7nGCPwkHUONpiYSHoRw==
X-Received: by 2002:a05:6a20:428d:b0:19a:3187:37c6 with SMTP id o13-20020a056a20428d00b0019a318737c6mr592293pzj.27.1704900479877;
        Wed, 10 Jan 2024 07:27:59 -0800 (PST)
Received: from thinkpad ([202.131.159.18])
        by smtp.gmail.com with ESMTPSA id fm18-20020a056a002f9200b006d9a1812e35sm3623145pfb.119.2024.01.10.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:27:58 -0800 (PST)
Date: Wed, 10 Jan 2024 20:57:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
	"vidyas@nvidia.com" <vidyas@nvidia.com>
Subject: Re: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240110152752.GA12324@thinkpad>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
 <20240107072707.GC3450972@rocinante>
 <ZZ2JXMhdOI1Upabx@x1-carbon>
 <20240110031137.GA2630@thinkpad>
 <ZZ5q4oPEj0N1mQED@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZ5q4oPEj0N1mQED@x1-carbon>

On Wed, Jan 10, 2024 at 10:01:08AM +0000, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Jan 10, 2024 at 08:41:37AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 09, 2024 at 05:58:53PM +0000, Niklas Cassel wrote:
> > > On Sun, Jan 07, 2024 at 04:27:07PM +0900, Krzysztof Wilczyński wrote:
> > > 
> > > Considering that we know that this series introduces new problems
> > > for drivers with a .core_init_notifier (i.e. tegra and qcom), see:
> > > https://lore.kernel.org/linux-pci/ZWYmX8Y%2F7Q9WMxES@x1-carbon/
> > > 
> > > Do we really want to apply this series as is?
> > > 
> > > 
> > 
> > Niklas, I think I explained it in this thread itself. Let me reiterate here
> > again.
> > 
> > The fact that you are seeing the dmaengine warnings is due to function drivers
> > not releasing the channels properly. It is not the job of the DWC driver to
> > release the channels. The channels are requested by the function drivers [1]
> > and they _should_ release them when the channels are no longer required.
> 
> Sure, the function driver should release the channels.
> 
> 
> > 
> > I know that the PCI_EPF_TEST driver is not doing so and so you are seeing the
> > warnings. But I do not have a device to test that function driver. Qcom
> > platforms use a dedicated function driver and that releases the channels when it
> > gets the LINK_DOWN event from EPC [2].
> > 
> > So my conclusion is that the issue is there even without this series. If you
> > still want me to fix the EPF_TEST driver, I can submit a change, but someone has
> > to test it.
> 
> That conclusion is not fully correct.
> 
> Let's take e.g. these error messages that this series introduces:
> [ 1000.714355] debugfs: File 'mf' in directory '/' already present!
> [ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already present!
> [ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already present!
> [ 1000.716061] debugfs: Directory 'registers' with parent '/' already present!
> 
> These come from dw_edma_core_debugfs_on(), which is called by dw_edma_probe().
> 
> This is a direct result from your patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-ep&id=9ab5c8bb7a305135b1b6c65cb8db92b4acbef79d
> 
> Which moves dw_pcie_edma_detect() from dw_pcie_ep_init_complete() to
> dw_pcie_ep_late_init() (since dw_pcie_edma_detect() calls dw_edma_probe()).
> 
> So without your patch, those debugfs error messages are not seen.
> 
> Thus, I do not think that it is sufficient to only modify the pci-epf-test
> driver to release the dma channels, as I don't see how that will avoid e.g.
> the debugfs error messages introduced by this patch.
> 

Ah, sorry I overlooked the warnings from the edma core. I think adding
dw_pcie_edma_remove() to the perst_assert() function would fix this issue. But
I'm traveling this week, so couldn't verify it on the device.

Bjorn, Krzysztof feel free to drop this series for 6.8. I will modify this
series to address some other issues discussed so far and resubmit it for 6.9.

- Mani

> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

