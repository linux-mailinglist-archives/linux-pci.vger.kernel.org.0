Return-Path: <linux-pci+bounces-4184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C9386B24F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10774B218E5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04D15A4B0;
	Wed, 28 Feb 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwfT6wxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7E1534F6;
	Wed, 28 Feb 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131854; cv=none; b=iKCvfKaA56a1dngmr81vWddcfatzBCjgEyKwgkczYRngk6vceLRVj805Iu7lE4A5rmGjHSIfkmJXqn7ATpTkuiwWXbPgnR1Ia2vExJsb3nO1k61nzzRH/58Kz5fEYFp8Kn0fFald/gG6lYt+Y3TCwvm0CKHELSPMObFAUp7ndWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131854; c=relaxed/simple;
	bh=fna4MQU9f3A2IFC6gWPkzynAoifEttlaxN1EutFrS7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jHrH2OtYHt67xbpH8+Ob5QU5MhkTazrmzD2I+QILOCFdm7K0kkT0xY7j3I1TG69BW+6S70hTEgqiA2imSSZGk0qmvbrT3Mj0MlZIiemYB/61WtYQaRYu7SyAMR+LJn0MlPepnwkIm/jeSUphuR7rWLUYwohzNwfdwu4+x9a48S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwfT6wxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F85EC433F1;
	Wed, 28 Feb 2024 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131853;
	bh=fna4MQU9f3A2IFC6gWPkzynAoifEttlaxN1EutFrS7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kwfT6wxl3XmgOQais2blrTh0rr0ZqtHeEEOgcHRtTYP46rNgNOAZaiTNlmE4PdW5B
	 3verXGpvzbrCuS1D4/9e1l9R+3jDKKdGooNmqsivlqM9TIBgSVh2ZubYeFmpT2JQ2F
	 H4nr6+8xNxpTuKnG09uuudsx7+/RipGTxVU0PQoOHMp5nCEfgT1GQOfMPpe0iNiF2c
	 d5OEsh0PwggzGzOzxFVGdoKE3morOv49tosu3GbpiXlYIXT+AUBV6GySly15A3ao1k
	 dPKzSxkR+jFdZlw1BuBRsgpsNZR+lWmeWqiqi+83P/R/odzAjSMf/aBZKfPAbnnhCq
	 klLk6XYbOB78w==
Date: Wed, 28 Feb 2024 08:50:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Message-ID: <20240228145051.GA271533@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e136ba-a7fd-ee8d-e71a-dce1442ada03@quicinc.com>

On Wed, Feb 28, 2024 at 12:08:37PM +0530, Krishna Chaitanya Chundru wrote:
> On 2/28/2024 4:52 AM, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2024 at 08:18:00PM +0530, Krishna chaitanya chundru wrote:
> > > To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
> > > ICC(interconnect consumers) path should be voted otherwise it may
> > > lead to NoC(Network on chip) timeout. We are surviving because of
> > > other driver vote for this path.
> > > As there is less access on this path compared to PCIe to mem path
> > > add minimum vote i.e 1KBps bandwidth always.

> > > +	 * The config space, BAR space and registers goes through cpu-pcie path.
> > > +	 * Set peak bandwidth to 1KBps as recommended by HW team for this path all the time.
> > 
> > Wrap to fit in 80 columns.

> We have limit up to 100 columns in the driver right, I am ok to change to 80
> but just checking if I misunderstood something.

I should have said "wrap to fit in 80 columns to match the rest of the
file."  I looked at pcie-qcom.c, and with a few minor exceptions, it
fits in 80 columns, and maintaining that consistency makes it easier
to browse.  Sometimes exceptions make sense for code, but for
comments, having some that fit in 80 columns and some that require 100
just makes life harder.

Bjorn

