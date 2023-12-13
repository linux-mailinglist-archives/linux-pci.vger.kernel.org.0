Return-Path: <linux-pci+bounces-915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8A5812029
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748911F21883
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BF7E569;
	Wed, 13 Dec 2023 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU0biiVw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65A5C084;
	Wed, 13 Dec 2023 20:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0203C433C8;
	Wed, 13 Dec 2023 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702500314;
	bh=CctU/GXFsJ6lkzjLDWKmTw9Q8WHFXHMPsA3fF1u3ins=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jU0biiVwBqqCmMPRcXhKvCDlf5/4gMNy06byWaEFkVgA+mOoYcSVBKhWycLe60QTE
	 dPvQSQLQjGzSLvS8QGPNwrQeuVTpyPReHAkMKGJHFmX3rdhvv+dELhJDUMEAfJ+HLk
	 GfQEns7Arnq4/Oi6o4IGLO3QDuXI/fTGO4yFdypXzodmQkGQ9fsdMFqWZxhmnRbq4G
	 kqD/6D/kkoyBkuYABDuS1FFHFSZVuQ9ijv9eyXeC9LaJF++Bh6LghOcFJNzH783MG3
	 TAmWPGpxmnmCqlnxz7pJfrPrJYSqJ1EnfQw2WlUR5D2ABvELju644Ai3BM7nvbUoc+
	 NiS6BH/jeSW0g==
Date: Wed, 13 Dec 2023 14:45:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>,
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231213204512.GA1056289@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <970144d9b5c3d36dbd0d50f01c1c4355cd42de89.camel@linux.intel.com>

On Wed, Dec 13, 2023 at 11:48:41AM -0800, David E. Box wrote:
> On Tue, 2023-12-12 at 15:27 -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 12, 2023 at 11:48:27AM +0800, Kai-Heng Feng wrote:
> > > On Fri, Dec 8, 2023 at 4:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > ...
> > 
> > > > I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
> > > > in qcom and vmd to enable ASPM is an ugly hack to work around this
> > > > weird idea that "the OS isn't allowed to enable more ASPM states than
> > > > the BIOS did because the BIOS might have left ASPM disabled because it
> > > > knows about hardware issues."  More history at
> > > > https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/T/#u
> > > > 
> > > > I think we need to get to a point where Linux enables all supported
> > > > ASPM features by default.  If we really think x86 BIOS assumes an
> > > > implicit contract that the OS will never enable ASPM more
> > > > aggressively, we might need some kind of arch quirk for that.
> > > 
> > > The reality is that PC ODM toggles ASPM to workaround hardware
> > > defects, assuming that OS will honor what's set by the BIOS.
> > > If ASPM gets enabled for all devices, many devices will break.
> > 
> > That's why I mentioned some kind of arch quirk.  Maybe we're forced to
> > do that for x86, for instance.  But even that is a stop-gap.
> > 
> > The idea that the BIOS ASPM config is some kind of handoff protocol is
> > really unsupportable.
> 
> To be clear, you are not talking about a situation where
> ACPI_FADT_NO_ASPM or _OSC PCIe disallow OS ASPM control, right?
> Everyone agrees that this should be honored? The question is what to
> do by default when the OS is not restricted by these mechanisms?

Exactly.  The OS should respect ACPI_FADT_NO_ASPM and _OSC.

I think there are a couple exceptions where we want to disable ASPM
even if the platform said the OS shouldn't touch ASPM at all, but
that's a special case.

> Reading the mentioned thread, I too think that using the BIOS config
> as the default would be the safest option, but only to avoid
> breaking systems, not because of an implied contract between the
> BIOS and OS. However, enabling all capable ASPM features is the
> ideal option. If the OS isn't limited by ACPI_FADT_NO_ASPM or _OSC
> PCIe, then ASPM enabling is fully under its control.  If this
> doesn't work for some devices then they are broken and need a quirk.

Agreed.  It may not be practical to identify such devices, so we may
need a broader arch-based and/or date-based quirk.

I'd be shocked if Windows treated the BIOS config as a "do not exceed
this" situation, so my secret hope is that some of these "broken"
devices are really caused by defects in the Linux ASPM support or the
driver, and that we can fix them if we find out about them.

But I have no details about any of these alleged broken devices, so
it's hard to make progress on them.  Maybe we should log a debug note
if the device advertises ASPM support that BIOS didn't enable.

Bjorn

