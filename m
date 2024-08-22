Return-Path: <linux-pci+bounces-12037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22A95BEF1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397611C22C06
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC201D1724;
	Thu, 22 Aug 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5kCDyUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748F1D0DFF;
	Thu, 22 Aug 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354921; cv=none; b=R3PwlzALcyipMsUpRjaxXIAasZcxjJ1kcfrWlDrvbasXtOy+qZSkWFYzDi+HUivPxRyx0q1nOxxbwgHCtigb1RFog51ZQk7XCRNLt3dcpZDSAdGg/zKaSriC6k+uVkkGmOJpPcc0T7RvWrU9ZOJbcS6AkbV+ZDTnx2u0jZioxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354921; c=relaxed/simple;
	bh=fGRxk6UbXKFSx34H54JxOG55A9SXa9LNifaF9L2xmls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QJNVQxvS7RBVvzodzco5b9dViFAxulcGlpknYjXiYFSVYY4GYc6VUeXHlYCuY63/vUR8fic/ReXXQdXzzynSnH/OtVj3WfjppvJNnj6q3SdMEHz9sO6II64prB8qpJkIaXGXHcd8QYr3rJ7w3S+hc2XrICgpTC0Ais3mYvfZnYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5kCDyUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07DBC32782;
	Thu, 22 Aug 2024 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354921;
	bh=fGRxk6UbXKFSx34H54JxOG55A9SXa9LNifaF9L2xmls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y5kCDyUw+6QFk1lEpiWdG4V2cjaCcSKGrSuUBoZdE+pyvjc0Q5kSQw4QTvgEhZcE4
	 31tnowmTAt+LqlmqyHv0kxsqBt4V8fD3oxRdbbj8Gj5e552dtFU+8K796nS4nvLVVT
	 +BbeeDvWVKc18k2kJkbN7LdNxPK+ZHhbECyvJoUEAsETLp+Z79k9i0pqfzh/BaeN5T
	 HERU41Da+JIGFMT2Grjm88Ft+fu1kZ261a2bqvCxtUwnZqml1eFAQC94AELqehux+Q
	 D+SVlMiRZ9L34O/obBekjjpfqCqy96VBR9s1ShPH2bU88gzUpqfh+KxFsn/UGpIFaH
	 Y+jSfNZvksYIA==
Date: Thu, 22 Aug 2024 14:28:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent
 pcie hierarchy
Message-ID: <20240822192838.GA346474@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeWFs+M+2kpotRqmcbPgXx8xCWEa-DqatGxWUAcixQb2g@mail.gmail.com>

On Tue, Aug 13, 2024 at 09:15:06PM +0200, Bartosz Golaszewski wrote:
> On Sat, Aug 3, 2024 at 5:23 AM Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
> >
> > Currently the pwrctl driver is child of pci-pci bridge driver,
> > this will cause issue when suspend resume is introduced in the pwr
> > control driver. If the supply is removed to the endpoint in the
> > power control driver then the config space access by the
> > pci-pci bridge driver can cause issues like Timeouts.
> >
> > For this reason change the parent to controller from pci-pci bridge.
> >
> > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> 
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Bjorn,
> 
> I think this should go into v6.11 as it does indeed better represent
> the underlying logic.

Is this patch independent of the rest?  I don't think the whole series
looks like v6.11 material, but if this patch can be applied
independently, *and* we can make a case in the commit log for why it
is v6.11 material, we can do that.

Right now the commit log doesn't tell me enough to justify a
post-merge window change.

Bjorn

