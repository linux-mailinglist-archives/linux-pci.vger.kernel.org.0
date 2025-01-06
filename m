Return-Path: <linux-pci+bounces-19360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B4A03356
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44A0163FA8
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 23:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70E1DEFFC;
	Mon,  6 Jan 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv1DSwK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B84A04;
	Mon,  6 Jan 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206369; cv=none; b=k208Zp71vH8mx/+8eghkAJpacXRlC7GFuSqwLwmD0oilyPDJe0ckIGgYPxnmmcIrPQW3fOpywBI9WJOSiYp1BgJ5YXwl4AHkxE3ynHxdxvE9ZRdVCFluG7cDAv7Vby7bD5juBx1A5KrBNcG8mMxAdH6JVLP7KSzBcnamezrSbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206369; c=relaxed/simple;
	bh=eeMQqExnDirKLWFXQEWznjA1b/1/ng+r1w7U0NJCPrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dcQnJ1tlMB0Qs/0pryjE2YqOkHcCxZ9/Sk5v5b8Q6G4OL2OgRQ+fgNolhTrIh4fimZeTE//CR0GYjgGcYvfIYptqGDL1G+RaP5IunqtgCeHb9ROn9H8HPp7tRREKEaDJea0kYYp1F540A4GmGlPkp7CoJXfu/aose1zqYhRbCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv1DSwK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35751C4CED2;
	Mon,  6 Jan 2025 23:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736206368;
	bh=eeMQqExnDirKLWFXQEWznjA1b/1/ng+r1w7U0NJCPrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nv1DSwK6k2zpzNAbPpGm5uDQMY7iKKu2mInE/Kg4oqhY9qsZI1NNo2dQLKkCFbLJb
	 EbGnkKYVHcQOGDnUDtfgFg0vbkkZYdGa1krWt/ZkX90iQbGN3OLxnL/r6fxHgYAxUI
	 dYY4S5FvyIOodelpiMXz4lkXNYfX+aeNmZZb5akDUJxJO5SE1KT193o0cELWOJoYn7
	 16krPSvZKlLlNIKvF5oYCpOERfcYXXCzWQbkFTpJweonCeM7afKheZpq00w4umIL5K
	 tudCkfVoy7A3/R5mDXs/5LH0K4QBghL3w14k4o3xH7Y6WpvwYmb++P7dhSx5pjq6Q0
	 LotRGXfa4l12Q==
Date: Mon, 6 Jan 2025 17:32:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
	manivannan.sadhasivam@linaro.org, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Subject: Re: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and nfts
Message-ID: <20250106233246.GA116572@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106093304.604829-1-krishna.chundru@oss.qualcomm.com>

On Mon, Jan 06, 2025 at 03:03:04PM +0530, Krishna Chaitanya Chundru wrote:
> Some controllers and endpoints provide provision to program the entry
> delays of L0s & L1 which will allow the link to enter L0s & L1 more
> aggressively to save power.

Although these are sort of related because FTS is used during L0s->L1
transitions, I think these are subtle enough that it's worth splitting
this into two patches.

> As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS)
> can be programmed by the controllers or endpoints that is used for bit and
> Symbol lock when transitioning from L0s to L0 based upon the PCIe data rate
> FTS value can vary. So define a array for each data rate for nfts.
>
> These values needs to be programmed before link training.

IIUC, the point of this is to program the N_FTS value ("number of Fast
Training Sequences required by the Receiver" as described in PCIe
r6.0, sec 4.2.5.1, tables 4-25, 4-26, 4-27 for TS1, TS2, and Modified
TS1/TS2 Ordered Sets).

During Link training, all PCIe components transmit the N_FTS value
they require.  Sec 4.2.5.6 only describes the Fast Training Sequence
from a protocol perspective.  The fact that the N_FTS value of a
device may be programmable is device-specific.

Possible text:

  Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
  captures the N_FTS value it receives.  Per 4.2.5.6, when
  transitioning the Link from L0s to L0, it must transmit N_FTS Fast
  Training Sequences to enable the receiver to obtain bit and Symbol
  lock.

  Components may have device-specific ways to configure N_FTS values
  to advertise during Link training.  Define an n_fts array with an
  entry for each supported data rate.

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> - This change was suggested in this patch: https://lore.kernel.org/all/20241211060000.3vn3iumouggjcbva@thinkpad/
> ---
>  dtschema/schemas/pci/pci-bus-common.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index 94b648f..f0655ba 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -128,6 +128,16 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [ 1, 2, 4, 8, 16, 32 ]
>  
> +  nfts:
> +    description:
> +      Number of Fast Training Sequence (FTS) used during L0s to L0 exit for bit
> +      and Symbol lock.

I think it's worth using the "number of Fast Training Sequences
required by the Receiver" language from the spec to hint that these
values will be used to program a component with the number of FTSs
that it requires as a Receiver, and the component will advertise this
number as N_FTS during Link training.

  n_fts:
    description:
      The number of Fast Training Sequences (N_FTS) required by the
      Receiver (this component) when transitioning the Link from L0s
      to L0; advertised during initial Link training

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      maximum: 255
> +
>    reset-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -150,6 +160,12 @@ properties:
>      description: Disables ASPM L0s capability
>      type: boolean
>  
> +  aspm-l0s-entry-delay-ns:
> +    description: Aspm l0s entry delay.
> +
> +  aspm-l1-entry-delay-ns:
> +    description: Aspm l1 entry delay.

s/Aspm/ASPM/
s/l0s/L0s/
s/l1/L1/

(I mentioned these earlier in the conversation you pointed to above,
but they got missed)

Also, to match surrounding items:
s/\.$//

>    vpcie12v-supply:
>      description: 12v regulator phandle for the slot
>  
> -- 
> 2.34.1
> 

