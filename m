Return-Path: <linux-pci+bounces-9810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EAD92780C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C1228536E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AAD1AEFE9;
	Thu,  4 Jul 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mipZ7g1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE661AEFE7;
	Thu,  4 Jul 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102641; cv=none; b=ag8JXqF3PgzZ0phbU21W1Fgip+Noj6fH5SYe4FncAcCkfDL0ZrIXAP70RI/hd/LCJnV9NnuepHv2+zDovNDVj4FeVGBVKLxRzxUAtVp5D/2WouOGUDJoR6l18nYuM0bj766S/OVUpjH+ZKg2z/CkEvhnSkOTKkFGSUZrc7vl/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102641; c=relaxed/simple;
	bh=NTEkeVWFX9WMfFqfduEV0Oz357OTuGc2THuDt0lLwiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmFbgWg+HjZ0cej05oSQGuUnGBRjJjombZrYf1Hl+rzuun7CAcUmtq30q1/HJVmrUV1YKqdzH6EOJpMlH2FF3k+NMNNMLWfFX1sTZV7Sf1Xg1XnnXOVTONYU+cg0REXwHnQmkJwMjjr9mbfGDl0WTueBj79DJEv84AAY5fpV6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mipZ7g1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD826C3277B;
	Thu,  4 Jul 2024 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102641;
	bh=NTEkeVWFX9WMfFqfduEV0Oz357OTuGc2THuDt0lLwiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mipZ7g1mOE4nImWzjY6Jzs0DNKVjtia5LK8idfImTPMbRGI3rwJJb8f6mRL3/8svP
	 NjMTS8AZ0AjD+LVPgOQsIGNNzfJd8KjJ1/MuYwRdm0QIvglkLQv0NDEAgWBpEVcGCy
	 kvTtc46rpRFY0aFyb6JS4QSx3x7+0dsxcuZVoM0d3EbhSK4JmYceZNOdQmg9HOj9SR
	 t5O1pDeVrafIM47fE9GG4UaKctcUZhl4aI+alsLW+au9fon1fqIkyTV6vYhWNGvp5G
	 FGKoYwTqG61HiBswwwSBb21f1D9lEk75Yyz0OTyEd2Nt542d+yH1eWKVoeN1Avk2QC
	 L2mTVCGeNEZKQ==
Date: Thu, 4 Jul 2024 23:17:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Philip Li <philip.li@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	kernel test robot <lkp@intel.com>, Abel Vesa <abel.vesa@linaro.org>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:dt-bindings 10/11]
 arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 29327360,
 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0,
 1879052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
Message-ID: <20240704141719.GA1215610@rocinante>
References: <202407041154.pTMBERxA-lkp@intel.com>
 <20240704072006.GA2768618@rocinante>
 <bd96c9e5-9342-41b8-aa14-2db4828e37f3@kernel.org>
 <20240704073908.GA2877677@rocinante>
 <ZoZjKN1N8QfRYn7n@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoZjKN1N8QfRYn7n@rli9-mobl>

Hello,

> > > > I removed this patch from the dt-bindings branch for the time being.

I will add this patch back to the branch.

> > > These reports are useless. I suggest ignore all of them...
> > 
> > I see.  Just a lot of noise then...
> 
> Sorry about this, we will skip these reports in future as discussed in [1]
> to avoid false positive.
> 
> [1] https://lore.kernel.org/oe-kbuild-all/ZoZhvjDsHSHtvpP3@rli9-mobl/

No worries.  Thank you for taking care of this!  Much appreciated.

	Krzysztof

