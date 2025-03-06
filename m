Return-Path: <linux-pci+bounces-23063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B8A550B4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 17:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697F03B383F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85715213249;
	Thu,  6 Mar 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhNTTJhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9E1F4188;
	Thu,  6 Mar 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278284; cv=none; b=XCcGWYd2Q8Vk5N+Vu2raT58AbIsSR/HAna+ees0gAKIjaq+KcVnpI6HMB382KF/NZOwI41t/ssyyOBLMa+GuYPBpKOgdOLWwTxnMidblaUg6g4N8z7hGuf/KnB6zq+lXCQSOEAZ0a2dUGFpMgBXOkLJIEV4KOQ2fhlIjkI3hC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278284; c=relaxed/simple;
	bh=+kNbwlJsG0d5knwFU8XMrHfRrzZxy6Vq25nHdxqvRjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MSkIetlw0iQFRNPLAH6RN9HVIBYsohnd9VQ++6SgNwc2eQ4REhqA/6aFqGABJG5pcT9QNJKwxVdR/QLPDLU91fQkh8/U51W6XaMJOgKQqtUqdRX1LcHhbH3Dd4ofyK3Bv1fou6BGHq7Y80aIWU6wjJhuNtfArGjZmy/H6wk6VHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhNTTJhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886B0C4CEE0;
	Thu,  6 Mar 2025 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278282;
	bh=+kNbwlJsG0d5knwFU8XMrHfRrzZxy6Vq25nHdxqvRjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JhNTTJhyjWlAbu4BZhAXyZuXHFR/dSZu1Tfv00+OsXDcMVd+NHEF5iuf3O3flLXZk
	 7L67uVL2vsWmXUzX3WyRYJ5A4dkIBzEASjc3dwmLQN5ljvYSRmwEfF0N/s2KQ4WARH
	 pXeK6gloj2qFlulAjIA0lk90CQM/1Z5WuRch8xxESaY4xyu2CTvxu06wOf48w4zYSA
	 ZJeWRzvIAXw312j1L26TM/TuecV/2YfGiDwUvB9gEc//O4j2v459NZKGIx6z0IkTBc
	 cC4rhmwDDRR+c2iRMsXhpJluWYcnWOhLOb2sUPGzjQGipwtzuzWM7qlOGy2SkfkRqP
	 eatxxgQ1Oakng==
Date: Thu, 6 Mar 2025 10:24:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250306162441.GA344031@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyXeXhqzwbV+pcizpyXg-c-gihcLEtPv1s1uczdNN_VOQ@mail.gmail.com>

On Thu, Mar 06, 2025 at 10:24:56AM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 9:49 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > On Mon, Mar 3, 2025 at 1:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> > > > If regulator_bulk_get() returns an error, no regulators are created and we
> > > > need to set their number to zero.  If we do not do this and the PCIe
> > > > link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> > > >
> > > > Also print out the error value, as we cannot return an error upwards as
> > > > Linux will WARN on an error from add_bus().
> > > >
> > > > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > > index e0b20f58c604..56b49d3cae19 100644
> > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
> > > >
> > > >               ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > > >               if (ret) {
> > > > -                     dev_info(dev, "No regulators for downstream device\n");
> > > > +                     dev_info(dev, "Did not get regulators; err=%d\n", ret);
> > > > +                     pcie->sr = NULL;
> > >
> > > Is alloc_subdev_regulators() buying us something useful?  It seems
> > > like it would be simpler to have:
> > >
> > >   struct brcm_pcie {
> > >     ...
> > >     struct regulator_bulk_data supplies[3];
> > >     ...
> > >   };
> > >
> > > I think that's what most callers of devm_regulator_bulk_get() do.
> 
> Manivannan stated that this series has already been merged.  So shall
> I implement your comments with a commit sometime in the future?

Sorry, I should have mentioned this would be something possible for
the future.  This current series is all set to go.

Bjorn

