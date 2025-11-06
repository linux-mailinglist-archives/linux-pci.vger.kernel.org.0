Return-Path: <linux-pci+bounces-40455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB2C39434
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E86C188E7B4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D12D8796;
	Thu,  6 Nov 2025 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWKpKvhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C292D73AD;
	Thu,  6 Nov 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410072; cv=none; b=fQ9rXuadsDo+QE0oHCLhhD1oGQ1wOKl5MbcqQq5c5SicjTmihvsdO9X9jp/HF0SL8z8S+oz1qX1swKNdJS2yy/zi8Jwu3j9PbPF2w2cy7g48KpiKDO2seuvbAIPe1AOOPNymyCjttFNXhqcwdbOuaB9/fK0wzycQUg5XZYgj8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410072; c=relaxed/simple;
	bh=vV/ErRejkb+XSOk84LMIbZxiLpkolrasUDAWCHCwpjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzoI2Sc8Hv8Iu3t4F4xIuZQzC0Z+njW8KzIreuSY30p8MX9dIz0rjZh4BzKZZqjlgmZOAQQLp1V1qEKaeycZ2EwoeHaIzFGQbsgyff1eUZPxeqETzywr+87YNX5ciV4xiwMkRWeHc4b91238B+gUI1IP0nm50B0qwmZHUkeu7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWKpKvhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD3DC4CEF7;
	Thu,  6 Nov 2025 06:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762410070;
	bh=vV/ErRejkb+XSOk84LMIbZxiLpkolrasUDAWCHCwpjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWKpKvhJ4Y/4gqcGrvoldzHnieYvRinLCJ0GrFt/C/EbZaeXhCWrfXLPKaYSHrgeX
	 Qr1eyHj7jhvYfaW1ts+iDGM6hRZLh6YbR3KNayc83vMaLTxPei7+QELWbkD9sc4P52
	 fzPf/ZwIzYYfcs1LWhIFvu1vGa5fnbgUIW0195z1J7mdir7pbwvIJheCECu7HF0RuK
	 A0P7N4goq2qjYZKfs2zKejb9HyBPKxJ0c9vHXiKj/yDS1t2/Wi2/9dyo5RqCTlJUnE
	 lUxzJZ7ybzEBf6g628cloui/raPz7H3wS1g2D2tY57O4v1fwbO6YvOMZ3+Ad1/X6aJ
	 OhzW8EHBGHgTQ==
Date: Thu, 6 Nov 2025 11:51:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2
 exit timing
Message-ID: <tecoemfjvcuwrvhiqxla2e7b27tgsmkahrbe2msr6vlh65alvp@vhlklrfasjd5>
References: <20251104175657.GA1861670@bhelgaas>
 <e459b4de-52f1-4c20-be84-07efdc9fed93@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e459b4de-52f1-4c20-be84-07efdc9fed93@oss.qualcomm.com>

On Thu, Nov 06, 2025 at 10:30:44AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 11/4/2025 11:26 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 04, 2025 at 05:42:45PM +0530, Krishna Chaitanya Chundru wrote:
> > > The T_POWER_ON indicates the time (in μs) that a Port requires the port
> > > on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
> > > asserted before actively driving the interface. This value is used by
> > > the ASPM driver to compute the LTR_L1.2_THRESHOLD.
> > > 
> > > Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
> > > capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
> > > This can result in improper L1.2 exit behavior and can trigger AER's.
> > > 
> > > To address this, program the T_POWER_ON value to 80us (scale = 1,
> > > value = 8) in the PCI_L1SS_CAP register during host initialization. This
> > > ensures that ASPM can take the root port's T_POWER_ON value into account
> > > while calculating the LTR_L1.2_THRESHOLD value.
> > I think the question is whether the value depends on the circuit
> > design of a particular platform (and should therefore come from DT),
> > or whether it depends solely on the qcom device.
> Yes it depends on design.
> > PCIe r7.0, sec 5.5.4, says:
> > 
> >    The T_POWER_ON and Common_Mode_Restore_Time fields must be
> >    programmed to the appropriate values based on the components and AC
> >    coupling capacitors used in the connection linking the two
> >    components. The determination of these values is design
> >    implementation specific.
> > 
> > That suggests to me that maybe there should be devicetree properties
> > related to these.  Obviously these would not be qcom-specific since
> > this is standard PCIe stuff.
> 
> Yes Bjorn these are PCIe stuff only, I can go to Device tree route if we
> have different values for each target, as of now we are using this same
> value in all targets as recommended by our HW team. If there is at least one
> more target or one more vendor who needs to program this we can take
> devicetree property route.
> 
> I am ok to go with devicetree way also if you insists. - Krishna Chaitanya.
> 

Since this is a PCI generic value, using devicetree property makes sense to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

