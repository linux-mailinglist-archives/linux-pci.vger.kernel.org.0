Return-Path: <linux-pci+bounces-20828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80595A2B150
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A603A35A9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07647239563;
	Thu,  6 Feb 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfZGlCVX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530255897;
	Thu,  6 Feb 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866897; cv=none; b=qvX54Z2/3S+C1X88PiEZtzcorm3iUgw01FgsJV1Sk9iSuPVNZxw5snB6tOpNyHiXIN8S4p+fVCjRJgT+QSYa0A1jM1O7f+k3KTY2CS0KJAQLIWyVpC9WRfor4pFVp1Wn4GSxhbZz+724HMsMdBoLnEGgQbg0YoJHJ20B6FHn8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866897; c=relaxed/simple;
	bh=07vDG66ev83p01zAaMT8kEqDUlGghdgthMVYXHknZ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NNGWdvQq4pLoVbUO+/l+QDEyPwzKZBZUQom7R6qbAyHS6/h+VzdIQ61sO8JIrAC1JtcfKSxdynKeUjwCcism+ovc3EiiEYzP6OEcPk+GccYSk5e01yHBDR+mIoQCk+MTITC5lOWfK9wtYYk/9I4OJR8FI7Xa/H6YXNaUv5Z4BKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfZGlCVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F280DC4CEDD;
	Thu,  6 Feb 2025 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866897;
	bh=07vDG66ev83p01zAaMT8kEqDUlGghdgthMVYXHknZ9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bfZGlCVXrdk7w4t/8iKv9a/DiBQN+DvjO915t3HY6MQufd2NZVp+N4GP4WBt6Khob
	 NLngTWmxmAfI4U71bmPGuAnq6lB8mPtZ/AnpVlwKWR97rW0O0l+SbpV/Exs6enToHV
	 ONLJtr37mxuT3Kr0UGbYYiayecdgBxMXFNiVCs/XCBeQP2AHr+DH1HyxYu6rYzFV6m
	 Q4HLPAudirfbIaX2XdGVLx0zcfjYkjaaP9OfYmCaAjhFI1CYr4TsgtHVwFpP0dHLVw
	 r5cGkmtqOLJJisal+M3cYRcwAiKb+79H4JCPDenlEVI5ofFDOuNm+IruoZ2JafGW/p
	 Eeso3Isa4at0g==
Date: Thu, 6 Feb 2025 12:34:55 -0600
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
Subject: Re: [PATCH v1 2/6] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250206183455.GA994612@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwws3On9-VJ-vF55o5LwKYpOHtfRYLtoQ5=bh7uGTfYkg@mail.gmail.com>

On Thu, Feb 06, 2025 at 01:22:54PM -0500, Jim Quinlan wrote:
> On Thu, Feb 6, 2025 at 12:29 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Feb 05, 2025 at 02:12:02PM -0500, Jim Quinlan wrote:
> > > If regulator_bulk_get() returns an error, no regulators are
> > > created and we need to set their number to zero.  If we do
> > > not do this and the PCIe link-up fails, regulator_bulk_free()
> > > will be invoked and effect a panic.
> > >
> > > Also print out the error value, as we cannot return an error
> > > upwards as Linux will WARN on an error from add_bus().

> > > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index f8fc3d620ee2..bf919467cbcd 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1417,7 +1417,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
> > >
> > >               ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > >               if (ret) {
> > > -                     dev_info(dev, "No regulators for downstream device\n");
> > > +                     dev_info(dev, "Did not get regulators; err=%d\n", ret);
> > > +                     sr->num_supplies = 0;
> > >                       goto no_regulators;
> >
> > I think it might have been better if we could do the
> > regulator_bulk_get() separately, before pci_host_probe(), so that if
> > this error happens, we can deal with it more easily.
> 
> Keep in mind that brcm_pcie_add_bus() cannot return a non-zero error
> code, as it will get a WARN() from the caller if it does.
> 
> Would you  accept deallocating the "sr" array and setting it to NULL
> like the following error condition does?  In that way we would not be
> invoking any regulator_bulk_xxxx() functions with nr==0.  I'm really
> wary of moving things around...

Yeah, don't move anything around right now.  My wondering is just
about whether the alloc and bulk_get() could be done earlier, leaving
only the bulk_enable() to be done in brcm_pcie_add_bus().

The alloc and bulk_get() depend on DT things and it's nice to catch
those errors earlier.

Bjorn

