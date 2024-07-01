Return-Path: <linux-pci+bounces-9530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834F91E8EC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0361283FA9
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B216F908;
	Mon,  1 Jul 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQCq2cf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971116F0C2;
	Mon,  1 Jul 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863685; cv=none; b=EYALHYUgRoZHxcI7853pw3l6g3j/0BCQyxTmQnODB7IasVPtyoCmC55VBMUSFDMRiIhWIzc/JjaksKbnuH2Gl2u+3DqgOx+q5LbzXcNw7H0WRaCuWbgLBTfNzav/V8TkV10/p6ZKWpq1AKNc+bbLO2ypxxasfWGH4kr12QZS1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863685; c=relaxed/simple;
	bh=w+IwRyDf2gcSLquuXMXHhJOg/e5P+XyOdiaWytVCB1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LBCir+HsFN5s4D/X16XclA4hZBCG+rHgTdsAdHGmCuxMiU8ftUbKF8+OnuEmK9qr7OhG8cv208uN8kBlWZqp0gyqkhWvtp1hKDjCvQdC3ZFgru/xipiLd3Z1kKbXX0KIxgkQlKMuVuzakgruBZ1DA3hDhJC0feiOQBAs63xCyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQCq2cf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38725C116B1;
	Mon,  1 Jul 2024 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719863684;
	bh=w+IwRyDf2gcSLquuXMXHhJOg/e5P+XyOdiaWytVCB1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XQCq2cf6ueTua29TV8Hbzc7SkMdAxxj34WJUYXIx1Q2P3u3FAaWGY9oHXezkPkkBN
	 A4HE8Tf4FfFMCaLZshD6ODMMIEhANmbF8rME+qDgrmtNos/T61EBMN+HdzD57gBNhQ
	 Z6HJQ8+ivJTAuA+5s9wtFOW2UwTbYv4DY8MdLzxo5dq5AEhtxtzPodxrX0ZljCExFW
	 34LHogp5dK3C7nBExXVdhAIAPv0rv7X8RrhJBjelGqzCn1WYCF573L3m68xUZsBPfg
	 sbGTUVUEVZerYJznen/oebUVGbcZwUGUCE058ywjZlWEDpPr2iLOYLC7G3Y2BfSXIL
	 DXscPsPJQRAnQ==
Date: Mon, 1 Jul 2024 14:54:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] pci: pwrctl: Add power control driver for qps615
Message-ID: <20240701195442.GA14596@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:55PM +0530, Krishna chaitanya chundru wrote:
> QPS615 switch needs to configured after powering on and before
> PCIe link was up.

s/need to configured/needs to be configured/

> As the PCIe controller driver already enables the PCIe link training
> at the host side, stop the link training.

Add blank line between paragraphs or rewrap into a single paragraph.

> Otherwise the moment we turn on the switch it will participate in
> the link training and link may come before switch is configured through
> i2c.

s/link may come before/link may come up before/ ?

> The switch can be configured different ways like changing de-emphasis
> settings of the switch, disabling unused ports etc and these settings
> can vary from board to board, for that reason the sequence is taken
> from the firmware file which contains the address of the slave, to address
> and data to be written to the switch. The driver reads the firmware file
> and parses them to apply those configurations to the switch.

s/to address and data/the address and the data/ ?
s/and parses them/and parses it/ (I assume you parse the file?)

