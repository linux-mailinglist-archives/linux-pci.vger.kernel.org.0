Return-Path: <linux-pci+bounces-12198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503595F016
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B76286CDB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769114D28A;
	Mon, 26 Aug 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N99IvR4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969213CFAA;
	Mon, 26 Aug 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672773; cv=none; b=G4/sKUaj0iskjP6L0ybVml5zGTyPzZZBZ7Z9vjpR3nEGh/Dfqz3kXN0iWLHcvRuQ6KRd4cl76tNHM2zq3nNuY5bxcu5ajy9eby7/Ep9dIadR8ozQru8Sl0hDDEAjgj9eC5/xkc9UM3fv4jLe90aihwJSfLyrvMIK8e5e52jghpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672773; c=relaxed/simple;
	bh=ViYtp/ls2jsHCvrRsFhG6/zsebLRkcjZ6GthyyqwuLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAf729hTzuoGQqtE511VpFOzEe8DPnfT0tkcnNqwpwMo8Y75zl5diDr5jX+Uti6XrLCDCBU07wE61Cyg/yFSAKJTVFkRt7HdzeSZS9Cq8OE9csnVZlZ3Omiw4V3LLBS5+T/ZgWK6d+K7ljnn9M+7UcKIeWv85uaViiiXP+1Zwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N99IvR4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4794DC4AF16;
	Mon, 26 Aug 2024 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724672773;
	bh=ViYtp/ls2jsHCvrRsFhG6/zsebLRkcjZ6GthyyqwuLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N99IvR4RfGEjWTwUxlnD+dYzzl5vn4X9FVU6R3shDAiQeBSfiUYRzX0FxygqyeH2t
	 i4SyS6VGcpZFi0m60hP3rmrOuKK/0iFV7Datciip3vz/KyhQ3g6Zik7TRRyn7HT9Y2
	 x/rtkxZhLMfChlB2RkulXDJFTFLafHXJ6ILplGwld1SFeRlaJplP0MHkKu7HV1ntLH
	 enf2eHyy2X1IF3dmcGh6eM2r0G4i5zvzHicH2t47miy4OP0YLGdqBzqux8sKlhdpAb
	 ugKRZCAhP9Ba+lYsPfM303m7kWtr7/W++pGMlAMpt4Z05G7w3boBlgklV2Jv03D0mB
	 RiPh7NWasTwVQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1siYAw-0000000024w-3qtd;
	Mon, 26 Aug 2024 13:46:22 +0200
Date: Mon, 26 Aug 2024 13:46:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 0/3] pci: qcom: Add 16GT/s equalization and margining
 settings
Message-ID: <ZsxrDmtMcrimszue@hovoldconsulting.com>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821170917.21018-1-quic_schintav@quicinc.com>

On Wed, Aug 21, 2024 at 10:08:41AM -0700, Shashank Babu Chinta Venkata wrote:
> Add 16GT/s specific equalization and rx lane margining settings. These
> settings are inline with respective PHY settings for 16GT/s 
> operation. 
> 
> In addition, current QCOM EP and RC drivers do not share common
> codebase which would result in code duplication. Hence, adding
> common files for code reusability among RC and EP drivers.
> 
> v4 -> v5:
> - Added additional parameter bandwidth to accommodate new icc path.
> - Fixed typo.
> - Picked up Reviewed-by tags.

First, make sure to CC people that help reviewing your patches.

Second, you don't mention that your previous series were completely
broken as I pointed out here:

	https://lore.kernel.org/all/ZpDlf5xD035x2DqL@hovoldconsulting.com/

You apparently fixed that in v5 but conveniently forgot to mention it in
the change log. Don't do that. Own your mistakes and learn from them.

Third, don't send untested crap upstream. You clearly did not test your
previous series properly and now v5 does not even build.

Seriously, this is completely unacceptable and you're just wasting other
people's time.

> v3 -> v4:
> - Addressed review comments from Mani and Konrad.
> - Preceded subject line with pci: qcom: tags
> 
> v2 -> v3:
> - Replaced FIELD_GET/FIELD_PREP macros for bit operations.
> - Renamed cmn to common.
> - Avoided unnecessary argument validations.
> - Addressed review comments from Konrad and Mani.
> 
> v1 -> v2:
> - Capitilized commit message to be inline with history 
> - Dropped stubs from header file.
> - Moved Designware specific register offsets and masks to
>   pcie-designware.h header file.
> - Applied settings based on bus data rate rather than link generation.
> - Addressed review comments from Bjorn and Frank.

Johan

