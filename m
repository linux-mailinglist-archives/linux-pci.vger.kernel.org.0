Return-Path: <linux-pci+bounces-2203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651D82ED20
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 11:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57981F2377F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1E19447;
	Tue, 16 Jan 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/siWHr/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D918ED4;
	Tue, 16 Jan 2024 10:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01973C433C7;
	Tue, 16 Jan 2024 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402335;
	bh=BpbxDcIY7558bHQDUuyuGyNMq+oP8ZHFVNuaKBYpl5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/siWHr/EtfTYBSZGrMUixPO2QBiptnFHYjLQBr5LUvxrxyXz3BlOhinXJ4TE8w0N
	 1Y327yig1QkwHLajIcsJePKdi752w8xm1aZrrC4Ge5ijT2a9BgTrv8hh0JgzmSeF/+
	 58GadoI3bn7VV6u5xfgV4qUTtVOQxjrza4YtsS+/Dei5SnoGt6wciahu96xVjDioch
	 fzSY4/Za0lY023dsWvm9kOFtzUeTqR4gAMUNc2s/aIm4nn523DK9Lr+CcO7j7BSdfa
	 XqseLTVloahJwwqWXjNr06aZSHCkKJfXWrgyDJUq1Veh2SRH5cV+Ov7U5B2LRhORpq
	 zAeOIKsleeZLg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rPh3I-0005Z7-38;
	Tue, 16 Jan 2024 11:52:17 +0100
Date: Tue, 16 Jan 2024 11:52:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Message-ID: <ZaZf4EyX5oADXG9N@hovoldconsulting.com>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <fecfd2d9-7302-4eb6-92d0-c2efbe824bf4@linaro.org>
 <f9a177e0-3698-4865-9463-220c65c653fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a177e0-3698-4865-9463-220c65c653fb@linaro.org>

On Fri, Jan 12, 2024 at 11:33:15PM +0100, Konrad Dybcio wrote:
> On 12.01.2024 16:17, Bryan O'Donoghue wrote:
> > On 12/01/2024 14:22, Krishna chaitanya chundru wrote:
> >> CPU-PCIe path consits for registers PCIe BAR space, config space.
> >> As there is less access on this path compared to pcie to mem path
> >> add minimum vote i.e GEN1x1 bandwidth always.
> >>
> >> In suspend remove the cpu vote after register space access is done.
> >>
> >> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> > 
> > If this patch is a Fixes then don't you need the accompanying dts change as a parallel Fixes too ?
> > 
> > i.e. without the dts update - you won't have the nodes in the dts to consume => applying this code to the stable kernel absent the dts will result in no functional change and therefore no bugfix.
> 
> The Fixes tag denotes a bug fix, its use for backport autosel is just
> a nice "coincidence".
>
> Fixing a lack of a required icc path and having to rely on BL leftovers
> / keepalive bus settings is definitely worth this tag in my eyes.

An incomplete implementation can sometimes be considered a bug, but not
always. If this is needed to enable a new use case, then it's hard to
argue that the original omission was a bug.

And as I just mentioned to Krishna, the above Fixes tag is not correct
as that commit did not *introduce* any issue. It solved the bit that was
strictly needed for sc8280xp, but now it seems you may need something
more for an even newer platform (even if no details and motivation was
included in the commit message as it should have been).

Johan

