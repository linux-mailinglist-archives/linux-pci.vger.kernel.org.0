Return-Path: <linux-pci+bounces-821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272AA80F951
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 22:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBC8B20E50
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19063C0F;
	Tue, 12 Dec 2023 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5Q7DnGG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF165A9E;
	Tue, 12 Dec 2023 21:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82447C433C7;
	Tue, 12 Dec 2023 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702416430;
	bh=dswbdDQkq9R1rqLEQPK78MDzN2SBMjw7O1v1jhL3dU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r5Q7DnGGEGhJChFt9UzIVBp28k4PNZQGG3QDcSIoEbRCqDHkk1/x+AZynmP5SKQy1
	 8sYavtfW2mETOwNUcbgsiTi7SIbNF6x5Ld7NVxdgKyyCmZN+CVgSiaXpuacBLP/D8a
	 YJSgzrt9VlXDXRA4oiQXbfmeM9SgZzYXvffVfDRGO5QsiI7Ix2HPCiCWe7IWC03RJZ
	 uyNrfJoL/abXRAV95IvqkTJHRlHFzsL+c2rKHGYdb+k0G1U8E3w9/zBGSyTRKPVe6y
	 qcqiN7g7G7hry8Y3pkrVhlnRxEp8/DdQop2rAkqd3TuohbEzDwkKzjV4k8Qbk2FYbV
	 nUEXOkCGRFvSg==
Date: Tue, 12 Dec 2023 15:27:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michael Bottini <michael.a.bottini@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231212212707.GA1021099@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p59q3D7u01ECsgRUgkDkTkchV-Gv+q=TMFcC44_tOs51Q@mail.gmail.com>

On Tue, Dec 12, 2023 at 11:48:27AM +0800, Kai-Heng Feng wrote:
> On Fri, Dec 8, 2023 at 4:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
> > in qcom and vmd to enable ASPM is an ugly hack to work around this
> > weird idea that "the OS isn't allowed to enable more ASPM states than
> > the BIOS did because the BIOS might have left ASPM disabled because it
> > knows about hardware issues."  More history at
> > https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/T/#u
> >
> > I think we need to get to a point where Linux enables all supported
> > ASPM features by default.  If we really think x86 BIOS assumes an
> > implicit contract that the OS will never enable ASPM more
> > aggressively, we might need some kind of arch quirk for that.
> 
> The reality is that PC ODM toggles ASPM to workaround hardware
> defects, assuming that OS will honor what's set by the BIOS.
> If ASPM gets enabled for all devices, many devices will break.

That's why I mentioned some kind of arch quirk.  Maybe we're forced to
do that for x86, for instance.  But even that is a stop-gap.

The idea that the BIOS ASPM config is some kind of handoff protocol is
really unsupportable.

Do we have concrete examples of where enabling ASPM for a device that
advertises ASPM support will break something?

Bjorn

