Return-Path: <linux-pci+bounces-6048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EA89FD84
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0AF1F217F7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2515B151;
	Wed, 10 Apr 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feBZRsBQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693211552F7;
	Wed, 10 Apr 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768312; cv=none; b=bBtRoRhXCSW7y60xj5VUiWAxbFha5ilLBRWagT4stsY5wRHOW7uicKIxt9P9iugZwC2iX1SL7dPrzZQuLOaO7TVKfmfcjwegq33H7zD+S8p7IGb+0wYPaiuc4WJROrF0wMrX/xCviiZBXjsTEoHe4ZuMhM1LxubS21nSYE9Mmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768312; c=relaxed/simple;
	bh=qclzrS6NsZXz3AIVjRhCh6Kq817U/fsiAXFdu2DM+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFnBiIbllSer5igAvHmQ7tXZvPsgBqq03FiDn34aVbVBoVb/JykIVkjZgCXfd2IZFlui9RfOkYQgN8fxJ2LawKxB2QyDyzJkHZgHZO4E1hfy/ftZ0upLqpfPar3mxTH3Tnjz9E9Nrh+bsbN2mky5q33/YO8HF1tKkWt6VSohe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feBZRsBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BC0C433F1;
	Wed, 10 Apr 2024 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768312;
	bh=qclzrS6NsZXz3AIVjRhCh6Kq817U/fsiAXFdu2DM+2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feBZRsBQazOE6ZZBdOKoboh7JrOW6aek/GUaYR7dibew/1RRPQ+QlMdQMYjwrDRlu
	 PKTL5EK6QYNZ3PvYV6jdaYyB/MiuTRftX6a+V9XhW312hvZAfYodrIMykgVTswjlb1
	 7gzAAO0ZKM+3xV7bh06WKoTPcSA1Rs45f5EPXICAdLoFZC2Mt4d2HZOwsSWhfPh6/4
	 PPs/n/prhRtisIxJesesolYIQTcgTeT0RJh+FCS5rXePDHxWBgmM+pq2JkZ/r5442P
	 85eoS32Ta36f2Q8QV9n3OctHj6rgqlyu9Sh8201hu0c+CWNKt1D19iiWWGkQcjFFtm
	 rQh1y95qKGlKw==
Date: Wed, 10 Apr 2024 11:58:29 -0500
From: Rob Herring <robh@kernel.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
	quic_nitegupt@quicinc.com
Subject: Re: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
Message-ID: <20240410165829.GA418382-robh@kernel.org>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
 <20240405052918.GA2953@thinkpad>
 <e2ff3031-bd71-4df7-a3a4-cec9c2339eaa@quicinc.com>
 <20240406041717.GD2678@thinkpad>
 <0b738556-0042-43ab-80f2-d78ed3b432f7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b738556-0042-43ab-80f2-d78ed3b432f7@quicinc.com>

On Mon, Apr 08, 2024 at 11:57:58AM -0700, Mayank Rana wrote:
> Hi Mani
> 
> On 4/5/2024 9:17 PM, Manivannan Sadhasivam wrote:
> > On Fri, Apr 05, 2024 at 10:41:15AM -0700, Mayank Rana wrote:
> > > Hi Mani
> > > 
> > > On 4/4/2024 10:30 PM, Manivannan Sadhasivam wrote:
> > > > On Thu, Apr 04, 2024 at 12:11:24PM -0700, Mayank Rana wrote:
> > > > > On some of Qualcomm platform, firmware configures PCIe controller into
> > > > > ECAM mode allowing static memory allocation for configuration space of
> > > > > supported bus range. Firmware also takes care of bringing up PCIe PHY
> > > > > and performing required operation to bring PCIe link into D0. Firmware
> > > > > also manages system resources (e.g. clocks/regulators/resets/ bus voting).
> > > > > Hence add Qualcomm PCIe ECAM root complex driver which enumerates PCIe
> > > > > root complex and connected PCIe devices. Firmware won't be enumerating
> > > > > or powering up PCIe root complex until this driver invokes power domain
> > > > > based notification to bring PCIe link into D0/D3cold mode.
> > > > > 
> > > > 
> > > > Is this an in-house PCIe IP of Qualcomm or the same DWC IP that is used in other
> > > > SoCs?
> > > > 
> > > > - Mani
> > > Driver is validated on SA8775p-ride platform using PCIe DWC IP for
> > > now.Although this driver doesn't need to know used PCIe controller and PHY
> > > IP as well programming sequence as that would be taken care by firmware.
> > > 
> > 
> > Ok, so it is the same IP but firmware is controlling the resources now. This
> > information should be present in the commit message.
> > 
> > Btw, there is an existing generic ECAM host controller driver:
> > drivers/pci/controller/pci-host-generic.c
> > 
> > This driver is already being used by several vendors as well. So we should try
> > to extend it for Qcom usecase also.

I would take it a bit further and say if you need your own driver, then 
just use the default QCom driver. Perhaps extend it to support ECAM. 
Better yet, copy your firmware setup and always configure the QCom h/w 
to use ECAM.

If you want to extend the generic driver, that's fine, but we don't need 
a 3rd.

> I did review pci-host-generic.c driver for usage. although there are more
> functionalityneeded for use case purpose as below:
> 1. MSI functionality

Pretty sure the generic driver already supports that.

> 2. Suspend/Resume

Others might want that to work as well.

> 3. Wakeup Functionality (not part of current change, but would be added
> later)

Others might want that to work as well.

> 4. Here this driver provides way to virtualized PCIe controller. So VMs only
> talk to a generic ECAM whereas HW is only directed accessed by service VM.

That's the existing driver. If if doesn't work for a VM, fix the VM.

> 5. Adding more Auto based safety use cases related implementation

Now that's just hand waving.

> Hence keeping pci-host-generic.c as generic driver where above functionality
> may not be needed. 

Duplicating things to avoid touching existing drivers is not how kernel 
development works.

Rob

