Return-Path: <linux-pci+bounces-22040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA50A40262
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6776860403
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEA253F2E;
	Fri, 21 Feb 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anOKXzdN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D817CA17;
	Fri, 21 Feb 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174887; cv=none; b=dKOP74cNZzjXOxYtGo59gRL/EWhTWr2jrE4/dKFRC7a9NEZasA4QbdYLD2Lr88/4MhBCSMFR6Bk7HdiPDw9Gr/HBBpnoHOgppJuOKRerVdWUf6hIzxELwnm/F87SKgWxVg/lwJcxRbH3Xcqzg7CYCwwHMd2WNDPa6O4GiPMfkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174887; c=relaxed/simple;
	bh=8p6+VP4B9zMLJumDh9LV1cR9GZpIPZw1eSXwG+FYe4s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PxLLWUA1Ej544IYqRGVZip52raOP6+p8F2bdj7oz5Q6yFmB7ycagbERkd6mns/0AWAzO9vsMaX7+/RjFcYQhlPoPIkH5rAqI6hMnir3rrO1jzjCp2l5762cRie/cyGAoIuaOMe9IK1cOSfjTqXDh1yFBIgYYXNanTdTZf0XyPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anOKXzdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E164C4CED6;
	Fri, 21 Feb 2025 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740174886;
	bh=8p6+VP4B9zMLJumDh9LV1cR9GZpIPZw1eSXwG+FYe4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=anOKXzdNXhBEqdQyq0A0musZeCWjzR8suonvaKAKoQs835lURYqKZoGst/eZw3UB9
	 IS7arcyNPytAhghdSGEkyUVp7RcZn7OxHCtWAjurRvQe8Xf+JP0at8pNpyupIp9pzW
	 zl5cZIb/tznVUevu0dOYcyP2THw7ndq1aQ9jvrfsogBAjCpSNrql1P2QG4yx0e4NXP
	 Z/4F3p4ZFuxdW1bdLhUp7loLd8lnAQAK9WWA7RqtDSScoVaPk4RsvGWM6yM/8Jv+e5
	 OFU6qakOps+txZX+Fjh2elstR7e4ubE97gOeI01iE1Mv+XYRd7GeD9JhOaMoijiMfd
	 ShB5019xa3I8g==
Date: Fri, 21 Feb 2025 15:54:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	manivannan.sadhasivam@linaro.org, quic_shazhuss@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_nitegupt@quicinc.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Slark Xiao <slark_xiao@163.com>, Qiang Yu <quic_qianyu@quicinc.com>,
	Mank Wang <mank.wang@netprisma.us>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] pci_generic: Add supoprt for SA8775P target
Message-ID: <20250221215445.GA363532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221060522.GB1376787@rocinante>

On Fri, Feb 21, 2025 at 03:05:22PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > This patch series add separate MHI host configuration to enable
> > only IP_SW channel for SA8775P target.
> > 
> > And also update the proper device id for SA8775P endpoint.
> 
> Applied to epf-mhi, thank you!

I see "[2/2] PCI: epf-mhi: Update device id for SA8775P" on
pci/epf-mhi, but I don't see patch [1/2].  Where did that go?
They seem related, so I would think we'd want to merge them together.

Also, in [2/2], I guess the .deviceid change is known not to break
anything that's already in the field?

Bjorn

