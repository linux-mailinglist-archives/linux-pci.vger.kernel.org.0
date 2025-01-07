Return-Path: <linux-pci+bounces-19461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C581A04B2F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C11C165C00
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A51F669F;
	Tue,  7 Jan 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1X6Fjoq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5141F37C0;
	Tue,  7 Jan 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282551; cv=none; b=GS2dkOXNTAF69qjdSGf0n82ca9D7Tdu6le95THnDLLn8boeE/IesSK33AmFe4ldDKAAW2LlxZEkTvxff5W5tY6doLuOMrf9olGTmYG/OZPj+7+RxwlbtQQPnupSlPiisDb+Gcpr5TQE3c8gMzBm9ZxaCAJufC4KkXXl8/7xNhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282551; c=relaxed/simple;
	bh=B1Ckc7g9BeYgu/ickCDB0Ca1bCjlvly28BndxYTw1HE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SRdKL7ZWBfFrJl+e4QY0Q/lqTJTixoRZdQb0v1LGXyb/Ed+LB6jnpexZknEsEWWPoUic8A58qJFa3gODWymGuJXrIT/PF5WBPo9LMzL300ghVnUzNnyo5kILup1ZKLlP+6asOXLj6ROaJ9v6FvSIOwMpfbyHIH+2u7BV96sDzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1X6Fjoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23916C4CED6;
	Tue,  7 Jan 2025 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736282550;
	bh=B1Ckc7g9BeYgu/ickCDB0Ca1bCjlvly28BndxYTw1HE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f1X6FjoqgTjt1mJZyJ+Jl8CPM0ijT8X6zotnBSQ3+iWJO2VYUwttFLuC2UIyPTAih
	 68qbHXpmh8kkKeqvLxQJPqwV3rBtzD7UuJOnmHnIIQ/JXlNovNudCiI3AiwWIi3CzL
	 h5gb+c3sKucJIKeYdp/b7r2HEDcKZvXJZ/hx4LPgJseLkKlC0yulDeh8ciIfAHdWBt
	 TAIy9K+7EqNi8q1HhQez/AJNsoYFkuXw+aE+5aA+KU3i2wUt7VE6B5KsDngi6wTso2
	 MGf1iN7lfvazmT2Gvyu69WhQfg2x/kPiysSlJwTkLrUUUKAIUy5f7QPsVwKTMjBR4d
	 YLaVUeqFa1IdQ==
Date: Tue, 7 Jan 2025 14:42:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	manivannan.sadhasivam@linaro.org, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Subject: Re: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and nfts
Message-ID: <20250107204228.GA180123@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d75827d-5285-35ff-bf9b-aec77cd8304e@quicinc.com>

On Tue, Jan 07, 2025 at 07:49:00PM +0530, Krishna Chaitanya Chundru wrote:
> On 1/6/2025 8:37 PM, Rob Herring wrote:
> > On Mon, Jan 6, 2025 at 3:33 AM Krishna Chaitanya Chundru
> > <krishna.chundru@oss.qualcomm.com> wrote:
> > > 
> > > Some controllers and endpoints provide provision to program the entry
> > > delays of L0s & L1 which will allow the link to enter L0s & L1 more
> > > aggressively to save power.
> > > 
> > > As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS)
> > > can be programmed by the controllers or endpoints that is used for bit and
> > > Symbol lock when transitioning from L0s to L0 based upon the PCIe data rate
> > > FTS value can vary. So define a array for each data rate for nfts.
> > > 
> > > These values needs to be programmed before link training.

> > Do these properties apply to any link like downstream ports on a
> > PCIe switch?
> > 
> These applies to downstream ports also on a switch.

IIUC every PCIe component with a Link, i.e., Upstream Ports (on a
Switch or Endpoint) and Downstream Ports (a Root Port or Switch), has
an N_FTS value that it advertises during Link training.

I suppose N_FTS depends on the component electrical design and maybe
the Link, and it only makes sense to have this n-fts property for
specific devices that support this kind of configuration, right?  I
don't think we would know what to do with n-fts for random plug-in
Switches or Endpoints because there's no generic way to configure
N_FTS, and we *couldn't* do it before the Link is trained anyway
unless there's some sideband mechanism.

> > > +    description:
> > > +      Number of Fast Training Sequence (FTS) used during L0s to L0 exit for bit
> > > +      and Symbol lock.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    minItems: 1
> > > +    maxItems: 5
> > 
> > Need to define what is each entry? Gen 1 to 5?
> > 
> yes there are from Gen1 to Gen 5, I will update this in next patch these
> details.

Components are permitted to advertise different N_FTS values at
different *speeds*, not "GenX" (PCIe r6.0, sec 4.2.5.6)

The spec discourages use of Gen1, etc because they are ambiguous (sec
1.2):

  Terms like "PCIe Gen3" are ambiguous and should be avoided. For
  example, "gen3" could mean (1) compliant with Base 3.0, (2)
  compliant with Base 3.1 (last revision of 3.x), (3) compliant with
  Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
  later and supporting 8.0 GT/s, ....

We're stuck with the use of genX for max-link-speed, but we should use
speeds when we can for clarity, e.g., in the description here.

