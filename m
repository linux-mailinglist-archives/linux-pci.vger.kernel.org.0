Return-Path: <linux-pci+bounces-757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9F80D508
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 19:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA6BB21748
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9474F5E7;
	Mon, 11 Dec 2023 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9tGGdET"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0A4F1FD;
	Mon, 11 Dec 2023 18:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23130C433C7;
	Mon, 11 Dec 2023 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702318315;
	bh=d/QXMCGNkdm/FGe7jzUVoJUZiNL9n1uu27MJIv/ZnTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S9tGGdET6EYJ55LzwK2/6jfxwPY+v+UcpfAbKynnvMOUhoOe2P8ilqjibT0NLSTJj
	 QLidBZPKeGrLTGQxJEI53/xFK3DZJbUjj1SiZ4htdSipxIzQEejCKmQ03bAEu/lYH/
	 kjuiwJcaZM2bpjRMWAiztjJsL0kKtCc+YKeDir83oI+THSvfhgt2rTwEcll+Gz4DIV
	 uB8QbR3AUdPlEYvgSEfIrEgyfUS8HUoEfoSpZJit2hqXYcd5XR2/ghn2EWiIo3aDiI
	 sPPOdqERtbM1i6/ghc5OnEJMroC0rf3AhU3bIeZlAh5z4FP7fKS3hrabAahAgQ5Kvs
	 QpxY4WJPvK/0A==
Date: Mon, 11 Dec 2023 12:11:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <20231211181153.GA959586@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXdIcle5oKJTaQB6@hovoldconsulting.com>

On Mon, Dec 11, 2023 at 06:35:46PM +0100, Johan Hovold wrote:
> Hi Bjorn,
> 
> On Fri, Dec 08, 2023 at 11:53:12AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:
> 
> > > Johan Hovold (6):
> > >   PCI/ASPM: Add locked helper for enabling link state
> > >   PCI: vmd: Fix deadlock when enabling ASPM
> > >   PCI: qcom: Fix deadlock when enabling ASPM
> > >   PCI: qcom: Clean up ASPM comment
> > >   PCI/ASPM: Clean up disable link state parameter
> > >   PCI/ASPM: Add lockdep assert to link state helper
> 
> > Applied to for-linus for v6.7, thanks, Johan!
> 
> I've noticed that you're pretty keen on amending commit messages.
> 
> For this series, for example, I noticed that you added an American comma
> after "e.g." even though this is not expected in British English that I
> (try to) use. This risks introducing inconsistencies and frankly I see no
> reason for this kind of editing. British English is not an error. :)
> 
> You also added a plus sign after the stable kernel versions in the
> comments after the CC-stable tags even though this is not the right
> notation for this (see the stable kernel rules).

Fixed, sorry.

