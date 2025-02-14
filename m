Return-Path: <linux-pci+bounces-21471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF6A361BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F5116F2D9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECE26618E;
	Fri, 14 Feb 2025 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byETr5W9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF65266B7D;
	Fri, 14 Feb 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547079; cv=none; b=MfmncqP07/w4AsDgIWn17cKJe8IHS+36EC8PAVJuB2tfD+3c4W6/8kZp9obJCdxY1cTEWdRDjIVQunARn7dA1dmJX3nxUBj8yFw3926m0okMu6nkqjfEQRY7ZAAFeofEFpPwL8TTQCQzv6k9ohoBnyCx08QalenDQOEmbajOmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547079; c=relaxed/simple;
	bh=PlPgOjpUQNDGrv1qPEHfg/ayDOmOHC8LX2wPVVoaStk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRc2mAQdaxE89KuvBwf9z7j+vooVGBAWi2p5jmDM0/dvO+nrRVzNpILa+wYfqRqlFEXw3FZY2vX0OEvzoy02l+U+QgQwidumSTSckDAr8NzgPphcroo1G+i/5rHja0myZrM4jNqjhpHAaJXqKQJOZ30qKy6vEhSc3UYb10aaKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byETr5W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F7BC4CEDD;
	Fri, 14 Feb 2025 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547079;
	bh=PlPgOjpUQNDGrv1qPEHfg/ayDOmOHC8LX2wPVVoaStk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byETr5W9doDE1zeWMB1evIVk3+JLa4Sk3euPWAAJRNM73xXlmpRi9Mwb8LwhMGNOR
	 x9JCOAkTsqrQ7oRrIc3GcLH6u7SV9IdE4hUpWnsKwy9/VdcAR3miSsb/T7mFC7PizP
	 rUYYLm8uiBPUo3uOs8xhud6nRVZ6ua7ofDNjuIZSqECRiRXKj6Mm+UpJbRqAexRMpU
	 g6gzmDNnVliup1VtMd3E25GJsQLQnKS1Bm94w8a0LFE9e4UDSJhGcb7+6SFMpr3ZD3
	 +RnuvoPWRYcDCo3X3yC1EBvWLbOMw/iQI2DZYTG+KrbZt9WBclegnBhWgCd8jSJZ4G
	 VcNUFCKAupyaQ==
Date: Fri, 14 Feb 2025 21:01:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214153103.4cjlawksw4xobc2l@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
 <20250214132115.fpiqq65tqtowl2wa@thinkpad>
 <332ec463-ebd9-477c-8b10-157887343225@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <332ec463-ebd9-477c-8b10-157887343225@163.com>

On Fri, Feb 14, 2025 at 10:28:11PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/2/14 21:21, Manivannan Sadhasivam wrote:
> > On Fri, Feb 14, 2025 at 04:23:33PM +0800, Hans Zhang wrote:
> > > 
> > > 
> > > On 2025/2/14 15:30, Manivannan Sadhasivam wrote:
> > > > On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
> > > > > View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> > > > > In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> > > > > Registers below:
> > > > > 
> > > > > axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> > > > > 
> > > > > Signed-off-by: hans.zhang <18255117159@163.com>
> > > > > ---
> > > > > Changes since v1-v2:
> > > > > - Change email number and Signed-off-by
> > > > > ---
> > > > >    drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
> > > > >    drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
> > > > >    2 files changed, 2 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > > > index e0cc4560dfde..0bf4cde34f51 100644
> > > > > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > > > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > > > @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
> > > > >    	spin_unlock_irqrestore(&ep->lock, flags);
> > > > >    	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> > > > > -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> > > > > -		 CDNS_PCIE_MSG_NO_DATA;
> > > > > +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
> > > > >    	writel(0, ep->irq_cpu_addr + offset);
> > > > >    }
> > > > > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> > > > > index f5eeff834ec1..39ee9945c903 100644
> > > > > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > > > > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > > > > @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
> > > > >    #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
> > > > >    #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
> > > > >    	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> > > > > -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> > > > > +#define CDNS_PCIE_MSG_DATA			BIT(16)
> > > > 
> > > > Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
> > > > have reported it as malformed TLP isn't it?
> > > > 
> > > In our first generation SOC, sending messages did not work, and the length
> > > of messages was all 1. Cadence fixed this problem in the second generation
> > > SOC. And I have verified in the EMU environment that it is OK to send
> > > various messages, including INTx.
> > > 
> > > And that's what Cadence's release documentation says:
> > > axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> > 
> > I'm confused now. So the change in axi_s_awaddr bit applies to second generation
> > SoCs only? What about the first ones?
> > 
> > Are you saying that the first generation SoCs can never send any message TLPs at
> > all? This sounds horrible.
> 
> 
> Sorry Mani, I shouldn't have spread this SOC bug. This is a bug in RTL
> design, the WSTRB signal of AXI bus is not connected correctly, so the first
> generation SOC cannot send message, because we mainly use RC mode, and we
> cannot send PME_Turn_OFF, that is, our SOC does not support L2. I have no
> choice about this, I entered the company relatively late, and our SOC has
> already TO.

Ok. Just to clear my head, this patch is needed irrespective of the hw issue,
right? And with or without this patch, first revision hw cannot send any MSG
TLPs?

If so, it is fine. But is there a way we could detect those first generation IPs
and flag it to users about broken MSG TLP support? Atleast, that would make the
users aware of broken hw.

> 
> 
> This patch is to solve the Cadence common code bug, and does not conform to
> Cadence documentation.

you mean 'does'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

