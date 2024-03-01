Return-Path: <linux-pci+bounces-4329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA186E3DA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63C51C21CC9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C13AC12;
	Fri,  1 Mar 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha+sPQ87"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8E3987C;
	Fri,  1 Mar 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305270; cv=none; b=mgfqmNe6nJfgAy4LbduYA6Iq2CnHZr16Ju6R27gyN+86usk8IokprogwgcM4EamTSPa4Hl7VzpEJtpe0csGPaZG2X6yK2ffp4a44y4ZJcG3Ti2qJxh8WKpMl6JboQ1gO0df6vEcIHF9xKWe8eyyJnXFS3zONeWh/egx0i66w4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305270; c=relaxed/simple;
	bh=tHAFlcvz0AL6ZnBgVLqJf9VI78SZ372MIUyTON7zBw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh7mvcucr6hkjn2McZJm53We0+pUVzWuObtA1KR+7AhO3XMDXwyS4KpD1ml/MqMH+vfih+gLtswC59yFZTx08x5CTHJrIRDw1XsFQmOobo1+RMmrrw9YuuUYxFCIbh+CnAdXsIa6SJf0EIsM+Ycm75yA54MbwC2Pz73u59jaaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha+sPQ87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3DBC433F1;
	Fri,  1 Mar 2024 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709305270;
	bh=tHAFlcvz0AL6ZnBgVLqJf9VI78SZ372MIUyTON7zBw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ha+sPQ87jZDLawJKK6IVH5+h9r1NK29RAlN7I555n9m126A5sF1cWQHqnbkktjUnR
	 RwVM0WaZml4HMsv7bXt5ixl0rNXovx7QTYp6tJ6shboC+nmEYvyw8UIjyDUkPYlaeN
	 S7fmOPfXNRh5MzW2czOI6iLipuxCQZWFWwc2oAxvkUVdbgOjzLN/1pUI7cUXXP8kfu
	 M5PC5GH+G5OZD0Z8ietqhocY9eI6P/C64ZSHvxSMx4vtpA4PDEmDJJ9rmvMR9/kcO1
	 XuBspaD1x9ZIwbOj9w9KrqWFCL1tER3MVydW7z9k+7gAfDiQjAyKMpGSxVYDtL8X3M
	 RNHg+N+yCdfJQ==
Date: Fri, 1 Mar 2024 09:01:06 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <e5xhwfvqod6dtrlhftzbno5ktezpfmr32alnd4nvkscaackj7e@vd5c24cbwzuy>
References: <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229205240.GA361626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229205240.GA361626@bhelgaas>

On Thu, Feb 29, 2024 at 02:52:40PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:
> > On Thu, Feb 29, 2024 at 05:54:16PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Feb 29, 2024 at 11:25:48AM +0100, Johan Hovold wrote:
> > 
> > > > As I mentioned, the 'required-opps' binding update is needed to
> > > > fix the missing OPP vote so blocking the binding patch would
> > > > block merging the DT fix which could otherwise go into 6.8.
> > 
> > > I agree that the fix gets the priority. But some maintainers
> > > perfer to merge fix patches _only_ if they are fixing the issue
> > > introduced in the ongoing release.  But if Bjorn has no issues in
> > > merging these for 6.8, then it is fine.
> 
> I do prefer to merge only regression and important fixes after the
> merge window, so I want to be able to provide justification.
> 
> > It also depends on the severity of the issue and to some extent the
> > complexity of the fix. These binding fixes are certainly low risk.
> > :)
> 
> IIUC we're talking about:
> 
>   arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP

I'd prefer to take this one through my tree. I will double check the
hardware documentation (there are differences in sc8280xp here) and
decide how to proceed...

>   dt-bindings: PCI: qcom: Allow 'required-opps'

Picking this for v6.9 is fine, no practical badness ensues. We would
temporarily have a few additional DeviceTree validation warnings in the
v6.8 release...

Regards,
Bjorn

> 
> These don't look like a regression fix (correct me if I'm wrong), and
> I can't tell whether they fix a user-visible problem, since
> sc8280xp.dtsi does already contain 'required-opps' for ufs_mem_hc,
> usb_0, and usb_1, which are mentioned in the commit log as covering up
> the issue.
> 
> If these patches wait until v6.9, what badness ensues?
> 
> Bjorn

