Return-Path: <linux-pci+bounces-277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A47FED86
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E557D1C20DF9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C46B3C07D;
	Thu, 30 Nov 2023 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYzBZDxD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1C3067F;
	Thu, 30 Nov 2023 11:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2070EC433C7;
	Thu, 30 Nov 2023 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701342562;
	bh=Ru4WQmcJUKrycn4IJ/0atltkGnWEKud46x+afC3D4ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYzBZDxDRw0pSYCLScCWeeGgqgDTVIqDbXAuhJIvEfYo0ielkyz2KFHq3b9qfxKGV
	 rV9EPS9Bifaidvw4JJetCCRXy7L3tfoUEDe7W5l4bdOzqiSt3YIOKJGd4TBORIZrMv
	 7lbdAYMv01VGCOIk2CgfYHVjCQnw9Wz4E170T+mnh+XQF/qD8SNfovvG8Wlh7RBaGP
	 Ee0dKV0IBoFoJ7+s7pqsBsGaxTtRqf5APKKKIvdGa2F0yPbmq6x0J9rKTD0SrZ2SlK
	 Uel90TkuVj2/IuJt8JyX3gMtk5FbTG3A75j1M/KJpdF9omBE8DrWp1QjPrU1+JDbyC
	 mb1DSAQS9rPDw==
Date: Thu, 30 Nov 2023 16:39:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Subject: Re: [PATCH v4 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20231130110909.GQ3043@thinkpad>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
 <20231130052116.GA3043@thinkpad>
 <a9c2532a-eaa6-4019-8ce9-5a58b1b720b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9c2532a-eaa6-4019-8ce9-5a58b1b720b2@linaro.org>

On Thu, Nov 30, 2023 at 11:09:59AM +0100, Konrad Dybcio wrote:
> On 30.11.2023 06:21, Manivannan Sadhasivam wrote:
> > On Tue, Nov 21, 2023 at 08:08:11PM +0530, Mrinmay Sarkar wrote:
> >> In a multiprocessor system cache snooping maintains the consistency
> >> of caches. Snooping logic is disabled from HW on this platform.
> >> Cache coherency doesn’t work without enabling this logic.
> >>
> >> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> >> platform. Assign no_snoop_override flag into struct qcom_pcie_cfg and
> >> set it true in cfg_1_34_0 and enable cache snooping if this particular
> >> flag is true.
> >>
> > 
> > I just happen to check the internal register details of other platforms and I
> > see this PCIE_PARF_NO_SNOOP_OVERIDE register with the reset value of 0x0. So
> > going by the logic of this patch, this register needs to be configured for other
> > platforms as well to enable cache coherency, but it seems like not the case as
> > we never did and all are working fine (so far no issues reported).
> 
> Guess we know that already [1]
> 

Bummer! I didn't look close into that reply :/

> The question is whether this override is necessary, or the default
> internal state is OK on other platforms
> 

I digged into it further...

The register description says "Enable this bit x to override no_snoop". So
NO_SNOOP is the default behavior unless bit x is set in this register.

This means if bit x is set, MRd and MWd TLPs originating from the desired PCIe
controller (Requester) will have the NO_SNOOP bit set in the header. So the
completer will not do any cache management for the transaction. But this also
requires that the address referenced by the TLP is not cacheable.

My guess here is that, hw designers have enabled the NO_SNOOP logic by default
and running into coherency issues on the completer side. Maybe due to the
addresses are cacheable always (?).

And the default value of this register has no impact on the NO_SNOOP attribute
unless specific bits are set.

But I need to confirm my above observations with HW team. Until then, I will
hold on to my Nack.

- Mani

> Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/cb4324aa-8035-ce6e-94ef-a31ed070225c@quicinc.com/

-- 
மணிவண்ணன் சதாசிவம்

