Return-Path: <linux-pci+bounces-42120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5DC8A1B8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2763AFD09
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48797328263;
	Wed, 26 Nov 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXGloj68"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB053242B6;
	Wed, 26 Nov 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165268; cv=none; b=KNMVUWRXMNjJOhfGd3eoR7g0N/nb8nvwam+Folh6RCVqLatyEveCgiFvY8HEaU1RnXuJlCWTEgCRsNHXzcLJ9I+kEC6SmoB7jOSdWVc6slqqR/wnd9cj5l6Wm6hwOj4gNLQSjCCb2SEYQ/FMhCbU/kel6nZ4lp2bas2FHwNDLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165268; c=relaxed/simple;
	bh=65eP/lbRfzZhiS3efIMJ0dY3HA+WW/ppdXfaAdFXkXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuRD+vac4RQkNmFYvbYuUBLcRl/neuYJs/yobqIlGSaaW6H6b4syTCmB3eMJZ+aggkfRMqKM8rL/nUbiHHxQ99WOZS6zQYIZSG7AvdtKkwjJMbfAFTw2UAu2H6IAuhR5q0OPlxDnxOI+SN6HPF4INnNh3xttHO926FdClNq69/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXGloj68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F0C4CEF7;
	Wed, 26 Nov 2025 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764165267;
	bh=65eP/lbRfzZhiS3efIMJ0dY3HA+WW/ppdXfaAdFXkXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXGloj682brw4JG9ho9TLCbP6OZOgbIAdWrbM83Y1+iW88vaXKENgqq87df2en3mV
	 +8zv1bQG2I92tKoSuoDzMUTC0uzlqs0tFHYm/1G4Q8R80bu9glzVIUJxoT5dOhHSgA
	 TosUxL9eSMeVVtz+265ZiVNcigHqDJYGsIJgVhaBN+YRQazc37LvJi244kGJgE+0do
	 vdj919xaDkRYIVCDIA9ty+Uf7wRSuDV4neXBF3SF85fUW4cKfwiJpuhQDAGVKrHMJd
	 hFHbaWSq0DUpb50dhfWyT2CVMJgqqBm9mLuUTVxa0+kaELIPv4FxRmvul8D5zk2ZXt
	 +fbUEcZH5JRvw==
Date: Wed, 26 Nov 2025 19:24:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <pbcemex3hdu4ryw2r7iy6xxt3chwaytlm2eina7mm4ukjfcagt@x4777z7ral26>
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
 <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>

On Wed, Nov 26, 2025 at 10:30:06PM +0900, FUKAUMI Naoki wrote:
> Hi Niklas,
> 
> I apologize for the delayed response.
> 
> On 11/24/25 23:02, Niklas Cassel wrote:
> > On Mon, Nov 24, 2025 at 06:07:44PM +0530, Manivannan Sadhasivam wrote:
> > > While I suggested to revert the link up IRQ patch for rockchip earlier, I didn't
> > > expect to drop the support for Qcom. The reason is, on Qcom SoCs, we have not
> > > seen a case where people connect a random PCIe switch and saw failures. Most of
> > > the Qcom usecases were around the M.2 and other proprietary connectors. There is
> > > only one in-house PCIe switch that is being actively used in our products, but
> > > so far, none of the bootloaders have turned them ON before kernel booting. So
> > > kernel relies on the newly merged pwrctrl driver to do the job. Even though it
> > > also suffers from the same resource allocation issue, this series won't help in
> > > any way as pwrctrl core performs rescan after the switch power ON, and by that
> > > time, it will be very late anyway.
> > > 
> > > So I'm happy to take the rockhip patches from this series as they fix the real
> > > issue that people have reported. But once the pwrctrl rework series gets merged,
> > > and the rockchip drivers support them, we can bring back the reverted changes.
> > 
> > FUKAUMI Naoki, just to confirm:
> > 
> > Neither my suggested approach:
> > https://lore.kernel.org/linux-pci/aRHdeVCY3rRmxe80@ryzen/
> > 
> > nor Shawn's suggested approach:
> > https://lore.kernel.org/linux-pci/dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com/
> > 
> > worked for you?
> 
> Yes, I re-tested the two methods mentioned above, separately, on v6.18-rc7,
> but neither of them resolved the issue in my environment (ROCK 5C +
> ASM2806).
> 
> > If so, I don't see many alternative but for Mani to apply patch 1 and
> > patch 2 from this series.
> 
> I believe applying patch 1 and patch 2 should be sufficient.
> 
> ----
> 
> Incidentally, (probably) while applying patch 1 and patch 2, I have
> encountered the following issue several times:
>

Do you see the below issue *after* applying the patches? I don't know how to
interpret "while applying".
 
> [    1.709614] pcieport 0004:41:00.0: of_irq_parse_pci: failed with rc=134
> [    1.710208] pcieport 0004:41:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> 

Looks like the device was seen during bus scan, but then it went down
afterwards.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

