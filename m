Return-Path: <linux-pci+bounces-4189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A127C86B333
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3531E28BC4C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7FC15B990;
	Wed, 28 Feb 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFqlYmdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9E2CCDF;
	Wed, 28 Feb 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134429; cv=none; b=ATAZrK3P+e5i5jfDB51J0BEbj7Fq5qIkxGx1jGipKu5N8S8RxWyXtNh2GDgqXDLcKnMeuGMMvK7zs363ww3FtXvVmv5Gs2TnJctuGx6NWLjb4RNj1Hmy0Y33kMbOq0Df6U7axydhLNWMMit0U+ibWS/JRY/abh4syTSBYV37FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134429; c=relaxed/simple;
	bh=91tc0+rrM3XNpUGlyGO1JKN285Ypnk6lyZkq1vCFxeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eqHYBAo8ZuOvnCPxisWEdA9iQB34lgbyNt+K6yIcKxcupm94blqRmvq+1cw6ZqYNwzZ3cNi86YqlzEFEO9hKMSw0TI2x0tQz7FNjabzb1fTf38I9tRuUqFdgRgpgG0+Ucjnbkn8EUqUhWXfwGtUVTbZW8YEnIaH6Ts1/oYj0rU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFqlYmdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF75C433C7;
	Wed, 28 Feb 2024 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134428;
	bh=91tc0+rrM3XNpUGlyGO1JKN285Ypnk6lyZkq1vCFxeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KFqlYmdoCW0uyVrvTMfSO5BvBxJbLdsyQyQZFjvv87X3lynZvmh9qesy2d44Vqn6E
	 QIViUu1L81NkfN3+lG6mhCsnyNUFC00eYAPY2/tbu1mxL86csldceGPwumLLWT9mhS
	 fPtyyrEcv072S5idwFmOnqSpfoMnkcBdcXY1RjrINb/+gKbdAOKrgkHm4NSlWzSfWr
	 /hHTOapeGEtrAQb7AGZIk6QOmQNPUfrOqOPcHmVgH4tnIZw0ylt0yhCqys52jmAgRH
	 bwo1W2OcNe6Lw9KWsD10dDXQ/OtFczRBMvGnvE3u3iireSB3qpK/gDB6bY915rQFRQ
	 IwmuT6X39bckA==
Date: Wed, 28 Feb 2024 09:33:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20240228153346.GA272807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c7a6a3-70d1-9964-3f34-c7ec550c379c@quicinc.com>

On Wed, Feb 28, 2024 at 08:43:53PM +0530, Krishna Chaitanya Chundru wrote:
> On 2/28/2024 7:09 PM, Johan Hovold wrote:
> > On Wed, Feb 28, 2024 at 12:08:37PM +0530, Krishna Chaitanya Chundru wrote:
> > 
> > > We have limit up to 100 columns in the driver right, I am ok to change
> > > to 80 but just checking if I misunderstood something.
> > 
> > Please take a look at Documentation/process/coding-style.rst, which
> > clearly states:
> > 
> > 	The preferred limit on the length of a single line is 80
> > 	columns.
> > 
> > 	Statements longer than 80 columns should be broken into sensible
> > 	chunks, unless exceeding 80 columns significantly increases
> > 	readability and does not hide information.
> > 
> > So generally you should stay within 80 columns, unless not doing so
> > *significantly* increases readability. (And note that making such
> > decisions requires human judgement, which is why checkpatch now only
> > warns about lines longer than 100 chars.)
>
> ok got it Johan, As checkpatch is not reporting any warnings or errors
> for I misunderstood this. I will correct the comments to fit in 80 columns
> in my next series.

Yeah, checkpatch is great and useful, but the bottom line is that it's
a tool that helps keep things relatively consistent, and a lot of that
consistency just comes down to paying attention to all the surrounding
code so the result looks coherent instead of a hodgepodge.

Bjorn

