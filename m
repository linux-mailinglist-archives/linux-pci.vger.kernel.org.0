Return-Path: <linux-pci+bounces-4182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76E86B097
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D275BB27A01
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DE159575;
	Wed, 28 Feb 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHfXIKnO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE714F988;
	Wed, 28 Feb 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127595; cv=none; b=KtRrHDTivrYoxBvSazeO/PKyWNEac34MLIEtcY1WKBxLOAyXkpPc6ZDHzDQePL+v9M+yQr3GiFXe/gN63NW9OvfMc+L5zdkwJDNzRLR3vF0w1BD4oaHr9IxXwO/Yohzk3fANzRJaLGsg29heKo6B6jc2voC+TZXzSbhIwZneJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127595; c=relaxed/simple;
	bh=yVJgiH4URrVSgwgUhOALQH1HGI8ZyvbMI3wAH4HuhIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ+PS1OeLWZVd6+24Qgy70WJrsW4xRpAvMaZaLgY+LEvbeayoCzttKrwYEHM15sXogPlJbvcgnuZypGw2K+9b4wRMOWm88D4TBa71uz7ivoWts/OxCiKl1pQEEJoUyufd0x1m6NI2hsTpupWrn6MjGyufRyF/1tTQPi85d+4RIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHfXIKnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC0CC43390;
	Wed, 28 Feb 2024 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127594;
	bh=yVJgiH4URrVSgwgUhOALQH1HGI8ZyvbMI3wAH4HuhIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHfXIKnOmSLqg/h+uOp23D8AkDPpjMNabVA2ZKdIX6Ex2UucsST5Sk3npqKCSQWki
	 SfwjtzeBYu0+EOXs5EJuQqFijbmrnsbhj5xo0QHtnMvpjTWSjj85YWmJ16ay3Mb6Zz
	 jybr293D1ydm+A/QTLB2/sGmUYb7pmxEt9LukD3sINjFe3yFv+BJqXE2RYz2Q2SqF4
	 IRdzQSD/V2Nm9c8zNXubpfLQFqsJeGU+ENFYvMqiU14GltTp1hr05umAIpv5ddLxty
	 /Omh6ZyozWrdF8a584bVxFz8jO+Vzv7rF1FddTbHC7i6wrTVd2a09Xu1GU+vcSGAi6
	 xCTWQQkw8AY6A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfKAB-000000006cu-31Aa;
	Wed, 28 Feb 2024 14:40:00 +0100
Date: Wed, 28 Feb 2024 14:39:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <Zd83r8Kg8aJJRBDu@hovoldconsulting.com>
References: <20240227232235.GA251235@bhelgaas>
 <b2e136ba-a7fd-ee8d-e71a-dce1442ada03@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e136ba-a7fd-ee8d-e71a-dce1442ada03@quicinc.com>

On Wed, Feb 28, 2024 at 12:08:37PM +0530, Krishna Chaitanya Chundru wrote:

> We have limit up to 100 columns in the driver right, I am ok to change 
> to 80 but just checking if I misunderstood something.

Please take a look at Documentation/process/coding-style.rst, which
clearly states:

	The preferred limit on the length of a single line is 80
	columns.

	Statements longer than 80 columns should be broken into sensible
	chunks, unless exceeding 80 columns significantly increases
	readability and does not hide information.

So generally you should stay within 80 columns, unless not doing so
*significantly* increases readability. (And note that making such
decisions requires human judgement, which is why checkpatch now only
warns about lines longer than 100 chars.)

Johan

