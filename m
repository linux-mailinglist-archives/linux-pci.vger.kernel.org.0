Return-Path: <linux-pci+bounces-16580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F579C5EFE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751012847F6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96F212F00;
	Tue, 12 Nov 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIwU9wI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B22123FD;
	Tue, 12 Nov 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432593; cv=none; b=LdGQGyall74LLRFYQEN/szqSZFiyNESzW0rIlMUDqN+NNJdVBYs9bDecVmmBn/XS8dpEMu8iaXr+z/8y6ZCJvEqoOd1agt+bSdXatSVeNf3sf9P89AXOdG537PrqbaTl6ujWB7Q9uQhby99qEGn4bLeT0I/RraV4xWZjWB5uX6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432593; c=relaxed/simple;
	bh=KtuHsvBkXKyb4/BS1eV+SQXhdNFVGLr8frMmDpXLEes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSNbQctPUkKTLb1bzguXJUj9OvAqcxQLNNds3SlNyeKwK/f7PciGblSODvgntkF099VwcCYIr6q+yAXYwd+1OTXO3JZMR3xT5/+Qu7OmU1CJeZcWiewpz/WW9OXvJLSVdfR98GIIY7qxBlKzuXOKLVeYFMIixdBo9qSMJD1yAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIwU9wI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09109C4CECD;
	Tue, 12 Nov 2024 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731432593;
	bh=KtuHsvBkXKyb4/BS1eV+SQXhdNFVGLr8frMmDpXLEes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIwU9wI/63KEVgKlLB5MPJHrTlsfAgH2RsYY7yKRUbcanp83jQjDd0ro1ZLLICxyo
	 I2ZoEO6Lll2jXNrlfxCh5MpkCD+hc8uHdRULw5dvtAF2N73qY/Dq7jBFk0quc6ghh8
	 JovS+ZBSKjIyvJdM1e1rKhlv+gtw4kNZV3s7Cp7IrUvIr5+eOvXRltASoAWm5dnV8+
	 MMyxs9ZjjF2PputR56oBSXNxOAwRoBjB2yGtmQ5mbXLc4GMDRXwjeo9sOKzgq1Vw7n
	 z6d8EhY8rcpKGQ9g9iWEacB1krNiB3CI/Q7/bqgYHpHb9+GWR2YHr9KaLrCKr4e1n9
	 k9Va/SiGaZxyw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tAui3-000000007ti-2RDk;
	Tue, 12 Nov 2024 18:29:48 +0100
Date: Tue, 12 Nov 2024 18:29:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <ZzOQi0PpRZYts-B0@hovoldconsulting.com>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-6-quic_qianyu@quicinc.com>
 <ZyjbrLEn8oSJjaZN@hovoldconsulting.com>
 <de5f40ab-90b7-4c75-b981-dd5824650660@quicinc.com>
 <c558f9eb-d190-4b77-b5a3-7af6b7de68d8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c558f9eb-d190-4b77-b5a3-7af6b7de68d8@quicinc.com>

On Mon, Nov 11, 2024 at 11:44:17AM +0800, Qiang Yu wrote:
> On 11/5/2024 1:28 PM, Qiang Yu wrote:
> > On 11/4/2024 10:35 PM, Johan Hovold wrote:
> >> On Thu, Oct 31, 2024 at 08:09:02PM -0700, Qiang Yu wrote:

> >>> +            ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 
> >>> 0x100000>,
> >>> +                 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 
> >>> 0x3d00000>,

> >> Can you double check the size here so that it is indeed correct and not
> >> just copied from the other nodes which initially got it wrong:
> >>
> >>     https://lore.kernel.org/lkml/20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org/

> BTW, regions of PCIe6a, PCIe4, PCIe5 are 64MB, 32MB, 32MB, respectively.
> Why range size is set to 0x1d00000 for PCIe6a, any issue is reported on 
> PCIe6a?

Thanks for checking. It seems the patch linked to above was broken for
PCIe6a then.

We did see PCIe5 probe breaking due to the overlap with PCIe4 but the
patch predates PCIe5 support being posted and merged so it was probably
just based on inspection.

Could you send a fix for PCIe6a?

Johan

