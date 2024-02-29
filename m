Return-Path: <linux-pci+bounces-4237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D635D86C6CD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778E01F21AE7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A46351F;
	Thu, 29 Feb 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSZwf0pJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319860BA7;
	Thu, 29 Feb 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202341; cv=none; b=gZMdzNojXlpLMi1tuQhuPv5jUYv/Id0dDFKeS6hCTxNtFa0SwnN+5/pkswtf0NfmnlDPGocdxIjK916NhfrGxIbkXEGdUDFh13Hcc3pPphK/U861BuOobBAWFXmCUAgKC97pMvA/hoAEDWj446p7ljIrNhDiMWncS542Pg+xAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202341; c=relaxed/simple;
	bh=Jy/7w7KEnfQklosMbmnBXq3PIa9EaMOSK5qguujWYHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojRuVTcRwhfVEMSI6uDi1+M1jsCXEc+DNxtlVngYHZNjPmWY57pMrTpRP0M5C3WxsMrQ7JWYQSHJNUGqtPxRGpqi7Y05QUR0FGvAw4VAWC7x+hpRMFlcdJLsCynI9sCEVF2hH+k1SBEbOsKScdop299q71WweIim5ZtcK6lhStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSZwf0pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38338C433F1;
	Thu, 29 Feb 2024 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709202341;
	bh=Jy/7w7KEnfQklosMbmnBXq3PIa9EaMOSK5qguujWYHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSZwf0pJg3JOSpFylltxG0i+NQp5EjBAyeI6hEtkmnqYcmGVzLyLHsf711+x1bigJ
	 chu1NMkhr+3ZYAmetg+itT3WLsGvd7Fca3qmNyTZLk36TQK0U7Cbqh+jULZ/4yMhna
	 0LIuZEPrjCtKrE1Syt9or8s9icOfgoVkXmug/Tzzu0jxESoWUxeCisRC2jNpPP+0Wl
	 Qjs5HKReD93uJ/ZR+d6nHyFF6gP10oVeHYGyKV9DeL9w0leLrr+HHxHGwnnPBNLGZU
	 dxjcj3ikVdnWI/7AuuOzjqhykU8xV5gJ1HMT8kBOSUpVcRzxbKeo1o7T9eBgbvcfJS
	 8PnGZhj3ELtrA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfdbo-000000000xS-3Hnm;
	Thu, 29 Feb 2024 11:25:49 +0100
Date: Thu, 29 Feb 2024 11:25:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeBbrJhks46XByMD@hovoldconsulting.com>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229100853.GA2999@thinkpad>

On Thu, Feb 29, 2024 at 03:38:53PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 28, 2024 at 04:08:43PM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2024 at 04:21:12PM +0100, Johan Hovold wrote:

> > > Johan Hovold (12):
> > >   dt-bindings: PCI: qcom: Allow 'required-opps'
> > >   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
> > >   dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
> > >   PCI: qcom: Add support for disabling ASPM L0s in devicetree
> > 
> > The ASPM patches fix a v6.7 regression, so it would be good to fix
> > that in v6.8.
> > 
> > Mani, if you are OK with them, I can add them to for-linus for v6.8.  
> > 
> > What about the 'required-opps' and 'msi-map-mask' patches?  If they're
> > important, I can merge them for v6.8, too, but it's late in the cycle
> > and it's not clear from the commit logs why they shouldn't wait for
> > v6.9.
> > 
> 
> I'm checking with Qcom HW team on the ASPM behavior. So please hold off the ASPM
> related patches until I get an answer. But 'required-opps' and 'msi-map-mask'
> patches can be applied for 6.9 (not strictly fixing anything in 6.8).

As I mentioned, the 'required-opps' binding update is needed to fix the
missing OPP vote so blocking the binding patch would block merging the
DT fix which could otherwise go into 6.8.

The 'msi-map-mask' is arguably a fix of the binding which should never
have had that property, but sure, it's strictly only needed for 6.9.

And Bjorn A has already checked with the Qualcomm PCI team regarding
ASPM. It's also been two weeks since you said you were going to check
with your contacts. Is it really worth waiting more for an answer from
that part of the team? We can always amend the ASPM fixes later when/if
we learn more.

Note that this is also a blocker for merging ITS support for 6.9.

Johan

