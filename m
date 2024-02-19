Return-Path: <linux-pci+bounces-3710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAB859E48
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 09:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45FC1F215C1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26201D6A6;
	Mon, 19 Feb 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tol60US4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0214C9D;
	Mon, 19 Feb 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331555; cv=none; b=UyjL4hOrZUsR3pJFXdCZZyAS4DyUC+yqFOlN+LB+VDItS0OM50D/jVReKHIfowM8tcRfXjb2ptMH+qPTnUc88HJG0hv6FU+1u5X33OPqd8ZcNtCcLCb7AJcpLR6sCCrEeXDyL3SzVJ3tZIunGH5UfjNNZ2WI+6wBEOJdF3kLjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331555; c=relaxed/simple;
	bh=mzagyX0s00DuFga1OEspDrD7QlaYPTc6QQLSYid+wmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDHM4K3/V4uHdowGtb6nIsJOLxEZSzmT4wTllUGB1U21GDV5NoVFZStxOIMDP3zLwqBFRMUvJMxhw3foQKlzp3DibyoXdH03RYsV7PKAAuX4YZPtZ1Ijvq9MaXZ60+BgtufP29omhCWD1vv7p+yar10ZaqdkOGgFGJ1gFUOxl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tol60US4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3BBC433C7;
	Mon, 19 Feb 2024 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708331555;
	bh=mzagyX0s00DuFga1OEspDrD7QlaYPTc6QQLSYid+wmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tol60US4baCbJG5fCN3uEhGriEOUOYWBYHl269+fX+R+Er5iSS88SX83aWXsgKtar
	 TT8pQEt+YM3WkRQ+1+knktgRTOXFpfeliyG2/trJclp1x8K6oVQTgUYk+V0jMFKTtF
	 zNtG/nT7YxKkBmHxfY6nXhT7m6Ckd/3NO+tL383q5fBxmdNGpje5iBCeO/uFKtzr6D
	 K1fc5Rp2FtKB/GHFf1U5VS4+4aUAqp+IRv+7HmngiQXqkqC2R37kGYxhKnMD0F6OOF
	 ceExrtnn3r2jaqvzWa2xDh9WCwshPs2w3sSySQ/lXO2rtchedL7KtjbtvFIdSIzaPj
	 dOV4NmnqMrrMQ==
Date: Mon, 19 Feb 2024 14:02:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, robh+dt@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
	robh@kernel.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: qcom: Enable cache coherency for SA8775P RC\
Message-ID: <20240219083220.GA3281@thinkpad>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
 <20231130052116.GA3043@thinkpad>
 <a9c2532a-eaa6-4019-8ce9-5a58b1b720b2@linaro.org>
 <20231130110909.GQ3043@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130110909.GQ3043@thinkpad>

On Thu, Nov 30, 2023 at 04:39:09PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 30, 2023 at 11:09:59AM +0100, Konrad Dybcio wrote:
> > On 30.11.2023 06:21, Manivannan Sadhasivam wrote:
> > > On Tue, Nov 21, 2023 at 08:08:11PM +0530, Mrinmay Sarkar wrote:
> > >> In a multiprocessor system cache snooping maintains the consistency
> > >> of caches. Snooping logic is disabled from HW on this platform.
> > >> Cache coherency doesn’t work without enabling this logic.
> > >>
> > >> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> > >> platform. Assign no_snoop_override flag into struct qcom_pcie_cfg and
> > >> set it true in cfg_1_34_0 and enable cache snooping if this particular
> > >> flag is true.
> > >>
> > > 
> > > I just happen to check the internal register details of other platforms and I
> > > see this PCIE_PARF_NO_SNOOP_OVERIDE register with the reset value of 0x0. So
> > > going by the logic of this patch, this register needs to be configured for other
> > > platforms as well to enable cache coherency, but it seems like not the case as
> > > we never did and all are working fine (so far no issues reported).
> > 
> > Guess we know that already [1]
> > 
> 
> Bummer! I didn't look close into that reply :/
> 
> > The question is whether this override is necessary, or the default
> > internal state is OK on other platforms
> > 
> 
> I digged into it further...
> 
> The register description says "Enable this bit x to override no_snoop". So
> NO_SNOOP is the default behavior unless bit x is set in this register.
> 
> This means if bit x is set, MRd and MWd TLPs originating from the desired PCIe
> controller (Requester) will have the NO_SNOOP bit set in the header. So the
> completer will not do any cache management for the transaction. But this also
> requires that the address referenced by the TLP is not cacheable.
> 
> My guess here is that, hw designers have enabled the NO_SNOOP logic by default
> and running into coherency issues on the completer side. Maybe due to the
> addresses are cacheable always (?).
> 
> And the default value of this register has no impact on the NO_SNOOP attribute
> unless specific bits are set.
> 
> But I need to confirm my above observations with HW team. Until then, I will
> hold on to my Nack.
> 

I had some discussions with the hardware folks and clarified my concerns with
them. Here is the summary:

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute in its TLP
for all the PCIe controllers. NO_SNOOP attribute when set, the requester is
indicating that there no cache coherency issues exit for the addressed memory
on the host i.e., memory is not cached. But in reality, requester cannot assume
this unless there is a complete control/visibility over the addressed memory on
the host.

And worst case, if the memory is cached on the host, it may lead to memory
corruption issues. It should be noted that the caching of memory on the host is
not solely dependent on the NO_SNOOP attribute in TLP.

So to avoid the corruption, this patch overrides the NO_SNOOP attribute by
setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not needed for
other upstream supported platforms since they do not set NO_SNOOP attribute by
default.

Mrinmay, please add above information in the commit message while sending v2.
I'm taking by NACK back.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

