Return-Path: <linux-pci+bounces-8255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239C8FBA26
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137AA1F20B53
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCD14388D;
	Tue,  4 Jun 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXk7AHJQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B39013DDAA;
	Tue,  4 Jun 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521593; cv=none; b=sCjs5HO4bjbBGnzU/gMRTiUlbXh0/Y4kqZwoA0us+l10iEYLm/WZQx/BXTU667Ty+jm+e6bttaefQ3dJI0/7vaT16+wVXgJFRoEqZZY00qoKw11IleK1x4BIYVfhKoH/xFWy+28dfNnkqMDXAY8OHKuTUiSpUoXIEFW8JTmbquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521593; c=relaxed/simple;
	bh=ahgtXc4qQiXa8mwemiBOfb1WhBE5WcSDQDlT80ff1yw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a0O9KQWvSgTD12/LAQFLXILCKhScMxX16fVHAWra6BVyikiuVNOTHU+MJ1owirKi9zoXwnZJpZjWeTAueS3V13zfsq0IwIOQtQu+2KNKomicnCm/kmgHSqAl95EzMy0XZHozGj6a8CrVligvNITnxV+LX+08ny9jwopo3icc0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXk7AHJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5358DC2BBFC;
	Tue,  4 Jun 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717521592;
	bh=ahgtXc4qQiXa8mwemiBOfb1WhBE5WcSDQDlT80ff1yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BXk7AHJQZhWMGA5FR5N42VZ4YfP1FBB4v/UHDo/4Q2sz1BqFhtW9bOeDkoS7kyLjH
	 RETUQsjJOPfZvJdgRglyAIUsdlwJRJGWB9leiecxMdfJp4QNKGQ/YxwEnru5aV421G
	 OTHjZHQwph9R/p4Rt8KXAeI4/vjvIj/nHGfcalXJg0eG36v54xh0bx5HCNf+OGbldW
	 w4djORfUXitP26HFUAa2Fp5HDu4Px3SXAjoTSMcRgXl3nKAcDGy1hc6DxDSQBP1/UA
	 3VH9EXdVJL8B7uw7ZQQHBXO1hvWfi2DAwah0DrDoLQhxDHipKevtC/mAkKAEXA7u33
	 98SvIYye8ALng==
Date: Tue, 4 Jun 2024 12:19:50 -0500
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
Message-ID: <20240604171950.GA731649@bhelgaas>
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
> ...

> ---
> base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
> change-id: 20240527-pwrseq-76fc025248a2

What does this apply to?  I don't know what 6dc544b66971 is; it
doesn't seem to be in upstream or linux-next.

