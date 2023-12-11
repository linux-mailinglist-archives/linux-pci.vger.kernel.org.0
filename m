Return-Path: <linux-pci+bounces-755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F980D3EB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE581C214E3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548314E1A4;
	Mon, 11 Dec 2023 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgSMMg5S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E921357;
	Mon, 11 Dec 2023 17:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF17FC433C7;
	Mon, 11 Dec 2023 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702316100;
	bh=C+xcU0YxoxqS8wlJs7ViUOBkcKRqhoDYHPQNqHhIU7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgSMMg5SQJwi9ZJO7tXgJEZ8pHAb3w7OZkogzS3Vi50kwtTf5HzMgpP5nN5vWAACB
	 Pyqh7ZY1N0JJW//s5JpHyEWGivj5qKUnPZwMuMawSeLSxZfzAWUtekk03NYwWZW7fh
	 HCmTvpukqTsjl/PGl+tlwztLweC4X2P1pkS50mmfQlyq+yxRTcDqPLLuA4Wuo6GkD1
	 nUL/EFoKOQgGjFjeBMa1XyCflVMHEM/CBaI0I3ZKdIhQC7RawnnwuqhzgudYwxaj+y
	 ovVrVLkKBqLhpce2H6hxJb4GMaIilOVFDuWXqLBcoh75FfAUTqzjwrE6WBnXcJiwXl
	 KLmZ4++vOhNww==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rCkC2-0006Jn-1R;
	Mon, 11 Dec 2023 18:35:47 +0100
Date: Mon, 11 Dec 2023 18:35:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZXdIcle5oKJTaQB6@hovoldconsulting.com>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
 <20231208175312.GA803148@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208175312.GA803148@bhelgaas>

Hi Bjorn,

On Fri, Dec 08, 2023 at 11:53:12AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:

> > Johan Hovold (6):
> >   PCI/ASPM: Add locked helper for enabling link state
> >   PCI: vmd: Fix deadlock when enabling ASPM
> >   PCI: qcom: Fix deadlock when enabling ASPM
> >   PCI: qcom: Clean up ASPM comment
> >   PCI/ASPM: Clean up disable link state parameter
> >   PCI/ASPM: Add lockdep assert to link state helper

> Applied to for-linus for v6.7, thanks, Johan!

I've noticed that you're pretty keen on amending commit messages.

For this series, for example, I noticed that you added an American comma
after "e.g." even though this is not expected in British English that I
(try to) use. This risks introducing inconsistencies and frankly I see no
reason for this kind of editing. British English is not an error. :)

You also added a plus sign after the stable kernel versions in the
comments after the CC-stable tags even though this is not the right
notation for this (see the stable kernel rules).

I'm more OK with you preferring to use function names over free text in
commit messages even if that is not my preferred style.

But generally I find it a bit odd that you insist on rewriting commit
messages like this and would prefer if you did not (especially since
there's no record of you having done this in the commits themselves).

Fixing typos and grammar issues, or rewriting bad commit messages, is
another thing of course.

Johan

