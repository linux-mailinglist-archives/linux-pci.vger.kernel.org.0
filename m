Return-Path: <linux-pci+bounces-2204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFBC82ED30
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 11:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02331C231C3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18805199CC;
	Tue, 16 Jan 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkibayD3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355A1946A;
	Tue, 16 Jan 2024 10:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2429C433F1;
	Tue, 16 Jan 2024 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402474;
	bh=/TPtCyoAj2paX8eC4HnNYeTrC2FQGolk8jnOVJ8gIv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkibayD3nkZ6flLmYjvkpiDDMSNhJ6bsH4iI5jBfozOGIlVv4NFG96Avn6FuypmNe
	 LyURk6NvYS5ptoKaN04vXcxi3rwhXwcmIfiCS22xl4S/Gfbq5XXcIQsrIe1oBnOApw
	 Ax44UY8Mdi9/eved8OsMDNFlRLAr1CrtE+K7OkieDG3eCyWPH5Wgy/z58EGNSqCKQW
	 1KnI0K4KhrRcwErjEnbKDnZF1NKjgs8yyNjUQ8wO9+hI0CIVbgxeRoQiXdIkkYOJzD
	 7u3NRwdlBS2SAeYNgRSFyxLOorDwox4jvaqfMZTAZpwf8fHC9EEGq7UKWNHDm2aflO
	 P8OQMk3y9kBBA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rPh5Z-0005ZS-1a;
	Tue, 16 Jan 2024 11:54:37 +0100
Date: Tue, 16 Jan 2024 11:54:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
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
Message-ID: <ZaZgba6wSMtuHz7i@hovoldconsulting.com>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
 <c278d89d-4eba-4ea7-8cf5-6b1de90dedbe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c278d89d-4eba-4ea7-8cf5-6b1de90dedbe@linaro.org>

On Fri, Jan 12, 2024 at 11:37:03PM +0100, Konrad Dybcio wrote:
> On 12.01.2024 16:59, Johan Hovold wrote:
> > On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
> >> CPU-PCIe path consits for registers PCIe BAR space, config space.
> > 
> > consits?
> > 
> >> As there is less access on this path compared to pcie to mem path
> >> add minimum vote i.e GEN1x1 bandwidth always.
> > 
> > gen1 bandwidth can't be right.
> > 
> >> In suspend remove the cpu vote after register space access is done.
> >>
> >> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> >> cc: stable@vger.kernel.org
> > 
> > This does not look like a fix so drop the above.
> > 
> > The commit you refer to explicitly left this path unconfigured for now
> > and only added support for the configuring the mem path as needed on
> > sc8280xp which otherwise would crash.
> 
> I only sorta agree. I'd include a fixes tag but point it to either 8450
> addition or original driver introduction, as this is patching up a real
> hole (see my reply to Bryan).

Right, the above Fixes tag is not correct in any case.

And with a complete commit message it may be possible to tell whether
a Fixes tag is warranted or not.

Johan

