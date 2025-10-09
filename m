Return-Path: <linux-pci+bounces-37780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D7BCAE60
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1242803C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA08272E41;
	Thu,  9 Oct 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcEGfi8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759D257435;
	Thu,  9 Oct 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044661; cv=none; b=hDplpjQnpMBlNk41SI7TP9Bl52F+XdiJjc3Z7n5HPlmY69iJbxJTD4d46jC+CLJKPWf8HSAwxw/H+SDg8ju4sju4x+vbcFpi1M6XXkNyUE9P9XMnM0wggdv9oyUPwhrlTtEU0GCEV7ZpvEniQzjAnBIMvb5dZg3DcpVNtmpQmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044661; c=relaxed/simple;
	bh=BwfkkEiFr4e+h6S366Ayqap5n/PtIOVr+0J9Egmvctk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYywR7CxL6ZN9h9IBBAHLBjLVVINUH4Xk1OFrLcNp0d9CnKv2bs/WeOB+oqC89Qtkx/q78aVz1+engKweb1Me5yPY7xiJKcdfwqadXk8iFV3gtTGwpCC04YGHhUZ49qZ7vNjmHvKU26jq6dL++aDU0FAq4kZ+JgPHDt33tMhcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcEGfi8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0255FC4CEE7;
	Thu,  9 Oct 2025 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044660;
	bh=BwfkkEiFr4e+h6S366Ayqap5n/PtIOVr+0J9Egmvctk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcEGfi8nDHxY/uC+cgam4j6BFs/9ffPNVcn0PDCaI8jkxPIbncNb80PrwxYomeCxQ
	 Jjl0VzGddVQhD+L4kN06AZBaljDQ/oK10TTx3ZfoVgWx1eyDZjh2+VsWf/IJWAbOx2
	 4lsUPg0IkSv9bIzdx95Bt6eS2//1JRRrblLTvMTQOkXKfHmwXBPHnu2VME4AuqrgQk
	 XgRG7oloaBgrW01tH7xoGCpETiIIXGhlWpMbeefKctGNy4MHbhewA6EZMiCiFdthpC
	 hJXO8CUOGeptvYDPH7J+xkHVBSUfAvmoPAltf8JJ3y/0XbvWBZ5C4yRuxDugZlipry
	 m9k0oIMQPqwBg==
Date: Thu, 9 Oct 2025 14:17:38 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Message-ID: <iy7wdlhiavqm5bffyo53rqm636cxyy3xdg463sda6aomgsslkc@j4h6cqtpibkw>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
 <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
 <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
 <qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3>
 <b5538a86-c166-4f20-9c3a-8170d3596660@oss.qualcomm.com>
 <53wepdhpn3fgvq5fum7u6n75su77dligfjtnxkfdh4r723a7yf@6u43pwkwt4yw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53wepdhpn3fgvq5fum7u6n75su77dligfjtnxkfdh4r723a7yf@6u43pwkwt4yw>

On Thu, Oct 09, 2025 at 07:42:37PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 09, 2025 at 10:35:52AM +0200, Konrad Dybcio wrote:
> > On 10/8/25 9:08 PM, Dmitry Baryshkov wrote:
> > > On Wed, Oct 08, 2025 at 11:11:43AM +0200, Konrad Dybcio wrote:
> > >> On 10/8/25 10:00 AM, Konrad Dybcio wrote:
> > >>> On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
> > >>>>
> > >>>>
> > >>>> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
> > >>>>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
> > >>>>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> > >>>>>> and x2 lane.
> > >>>>>>
> > >>>>>
> > >>>>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
> > >>>>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
> > >>>>> is crashing during boot as PCIe is being probed.
> > >>>>>
> > >>>>> Is this a known problem? Is there any workaround/changes in flight that
> > >>>>> I'm missing?
> > >>>>>
> > >>>> Hi Bjorn,
> > >>>>
> > >>>> we need this fix for the PCIe to work properly. Please try it once.
> > >>>> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/
> > >>>
> > >>> This surely shouldn't cause/fix any issues, no?
> > >>
> > >> Apparently this is a real fix, because sm8750.dtsi defines the PCIe
> > >> PHY under a port node, while the MTP DT assigns perst-gpios to the RC
> > >> node, which the legacy binding ("everything under the RC node") parsing
> > >> code can't cope with (please mention that in the commit message, Krishna)
> > >>
> > >> And I couldn't come up with a way to describe "either both are required
> > >> if any is present under the RC node or none are allowed" in yaml
> > > 
> > > What about:
> > > 
> > > oneOf:
> > >   - required:
> > >      - foo
> > >      - bar
> > >   - properties:
> > >      foo: false
> > >      bar: false
> > 
> > Oh yeah, this works.. would you mind submitting a patch like this, with a
> 
> I'd prefer it it comes from somebody who is actually working on PCIe so
> that the explanations are not ridiculous. Mani?
> 

Will do.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

