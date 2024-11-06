Return-Path: <linux-pci+bounces-16154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22C9BF3A6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DE1C23324
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF712064E3;
	Wed,  6 Nov 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A82ix3l5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E566205E33;
	Wed,  6 Nov 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911995; cv=none; b=mcr87bRtz3Mon1ERTvpKUdA6DFSU7Ot4ye1ZpIwmA4MPSuVHY3N8DO9ymug8aYPDXkSjvN/psFMvFEnXJY3iYMcVfmqHauLQq8LJ1IYYsOJ0NV+YQu36ge18uHWl8RmtRUP/nLQ/gKng909cALAAJ0YBNPzZ/A7N63CCp1pBIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911995; c=relaxed/simple;
	bh=OzUAI9y2vdwmmvCD+XJYm4cHA0A6WZjIJsfN0+pkEiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aaXhCebJbxCqKCuqfZvP09Gddz2kDhBWp0YbT81lzhkN8hk4VHrMyN3MSeE/5FkcetV+2U6M5MltzvO92QhetQIsduIack0OQwNlbyGkQrSMdjic17MAgiQMH7LFilkCCST8gXd+UEFO97erw+9xpNI1M8f6+CXlA8Pw+GO0kwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A82ix3l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77AFC4CED6;
	Wed,  6 Nov 2024 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730911994;
	bh=OzUAI9y2vdwmmvCD+XJYm4cHA0A6WZjIJsfN0+pkEiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A82ix3l5i8JXXCa8Ly4NI6GqAfXg70yCSN47GvTf2odoIqanT1OQSxtYQs9+EeyaO
	 eIBz0LfxgEeQMRoq6Doq/0gu6P/tJvZPeTtHX/YLvVLjYn0h0ecehgO0i8hGW/uyL8
	 yuZV0JKwLbKZt5/ElHWq2wkuTDzigiaa9p0aC0D4IJAq4OkzhhW7X5ACtGSXSlh4A3
	 IoBw8U50Gm337WwW5Lb1zK781XjKvsVduYNrkM57Wb8GQn3rtUErE07jPCo6l4iWxs
	 dFSMonjOfImmIMg5xTyHI+/KGrHBWfhB1h6wfj7vZvlquBozDtB9cMEQM950Vb2x9P
	 +IH478GRWoebQ==
Date: Wed, 6 Nov 2024 10:53:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Sricharan R <quic_srichara@quicinc.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 4/4] PCI: qcom: Add support for IPQ9574
Message-ID: <20241106165312.GA1528877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106145615.25tc7n4zcdkp47jr@thinkpad>

On Wed, Nov 06, 2024 at 02:56:15PM +0000, Manivannan Sadhasivam wrote:
> On Tue, Nov 05, 2024 at 07:40:24PM -0600, Bjorn Helgaas wrote:
> > On Thu, Aug 01, 2024 at 11:18:03AM +0530, Sricharan R wrote:
> > > From: devi priya <quic_devipriy@quicinc.com>
> > > 
> > > The IPQ9574 platform has four Gen3 PCIe controllers:
> > > two single-lane and two dual-lane based on SNPS core 5.70a.
> > > 
> > > QCOM IP rev is 1.27.0 and Synopsys IP rev is 5.80a.
> > > Reuse all the members of 'ops_2_9_0'.
> > 
> > Wow, this is confusing.
> > 
> > "Based on SNPS core 5.70a", but "Synopsys IP rev is 5.80a."
> > Are those supposed to match?  Or is it 5.70a of one thing but 5.80a of
> > a different thing?
> 
> Hmm, I'm not sure why 5.70a is mentioned here. It seems irrelevant
> (even if it is the base).
> 
> > And where does ops_2_9_0 come in?  The code comment says:
> > 
> >   /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
> >   static const struct qcom_pcie_ops ops_2_9_0 = {
> > 
> > which doesn't match 1.27.0 or 5.70a or 5.80a.  In fact there's nothing
> > in the file that matches 1.*27.*0
> > 
> > Honestly, I don't really care if you have all the versions here in the
> > commit log.  But if the versions *are* here, can we make them make
> > sense?
> 
> We name the 'ops' structure based on Qcom IP revision. And we reuse
> it across the SoCs which are compatible. That's why ops_2_9_0 is
> used for this SoC which has Qcom IP rev 1.27.0.

Got it.  So a family of compatible Qcom IP starts with 2.9.0 and newer
members are 1.27.0 etc.  With no hint in the source about what the
members of the family are.  Perfect sEnSe.

Bjorn

