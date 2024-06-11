Return-Path: <linux-pci+bounces-8614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79891904739
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC001C20DB3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA415573E;
	Tue, 11 Jun 2024 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghY50bs0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAD9475;
	Tue, 11 Jun 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146471; cv=none; b=FQ+jQDXu25vjg9NlBRPHhoD8RVhujZ991EPaQuILWfX/PfBqo1dYh3FUEQKJxR7M8XJMVhmJ6Mn3Ci7j9IFszoT74DzlKrMdcxP6xgbBRjgSrPYdXgASXsdSSk9eQL2j0IsXT6fBPXzhowFZGw8B4vXPPG9iFjd+3Ub3SOfPm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146471; c=relaxed/simple;
	bh=Qk1xtp+Y0CsC+cGSX2bvsS9KRtEFezREYHk2nrDR1VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jnZaeujYSo+BM7lBTaFeI7x+/qLaz+1xkry4NJMZ8Va7ujeNXUB1CPKuW/ES5D3WB/h+1HcwTqoqN/RKyHgfiKNxeFw+lQsLldoxk58cO6PGzUUtXklADTRCdcqGAaHDvSxAXlWGdcB017pEwHTW9BWxoZshyu9z6Ok7ntgiZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghY50bs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207EC3277B;
	Tue, 11 Jun 2024 22:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146470;
	bh=Qk1xtp+Y0CsC+cGSX2bvsS9KRtEFezREYHk2nrDR1VA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ghY50bs0RlmiaNDSZwjEm0OI3iVK0UG5GkXzkYk8Z2fu2SwC23ID3ccJ7KaxqUc7Z
	 J3MCwzZZrcfHEsyzWIanidlCVT1T7Yu6Ur/Uhrls66GtuXhEdWkHV63z0Ho8HXRJo5
	 ZhyK1sdLS17ioINSFHQnMZAjfnS5XKlxRUgEsAfGzOpaa+k2Za4sPHbYho0cpJBNWc
	 LbWRItPHXJHKW0fcccqgY/fcov1umU2R9sNliNvFCHK1eFi+hholPLR0aTYcR9xETD
	 oW0pnaqqFoYbZjge1UzN6manRXLNxrYbrtjRk851t0ENdwsZUdmcCp4nGCWVaiymqM
	 kV4e15f3vqfdw==
Date: Tue, 11 Jun 2024 17:54:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 00/17] power: sequencing: implement the subsystem and
 add first users
Message-ID: <20240611225428.GA1005695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:08PM +0200, Bartosz Golaszewski wrote:
> Note: I am resending this series in its entirety once more for
> discussions and reviews. If there won't be any major objections, I'll
> then start sending individual bits and pieces to appropriate trees.
> 
> Merging strategy: The DT binding and DTS changes are a no-brainer, they
> can go through the wireless, regulator and arm-msm trees separately. The
> bluetooth and PCI changes have a build-time dependency on the power
> sequencing code. The bluetooth changes also have a run-time dependency on
> the PCI pwrctl part. In order to get it into next I plan to pick up the
> power sequencing code into my own tree and maintain it. I can then
> provide an immutable tag for the BT and PCI trees to pull. I wouldn't
> stress about the BT runtime dependency as it will be fixed once all
> changes are in next.

The PCI changes are very self-contained and any conflicts will be
trivial, so rather than messing with an immutable tag, how about if I
just ack them and you can include them in your tree directly?

