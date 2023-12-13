Return-Path: <linux-pci+bounces-917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD581236F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7265D1C211D1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094879E3A;
	Wed, 13 Dec 2023 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDh8fRtH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3AD10DE;
	Wed, 13 Dec 2023 15:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702510920; x=1734046920;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=658FEJlu8iPbmeFy2fG1Ncs6XwLiyF4+NhBOJaUrxWI=;
  b=eDh8fRtHEn4fbwgOb4ATn8MB0MkwaekdMWOSRwWyXOu1fmdDXXPe9BBq
   TBtdgHFYfejAFVWHneEweGJkTouWWa6ze9ERWdU3BE845QhWs97qGD0XV
   SamLc0guLmzk3w3YXwn1swZVod7w55ZXDk//Ko6qmNQseKSjQ9vSQ5Oqa
   yReLeFcmvf7yAz15maEHASelaWlpAQSe0KrImQ7COwocE4fc1Mh1QWhEy
   4JdARxlxyaMUqhNO7/N/xpoe+jDjm8R+NLkCWnFqYaDGnRvBmWkndOVah
   IIscIjw59Ppl7feQ1XP8nHBX4XCJrYr6wuvMFpV92RGTgsFey69EC8FnW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8402768"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8402768"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021305090"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1021305090"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:39:25 -0800
Received: from acharris-mobl.amr.corp.intel.com (unknown [10.255.228.183])
	by linux.intel.com (Postfix) with ESMTP id C5161580DAA;
	Wed, 13 Dec 2023 15:39:24 -0800 (PST)
Message-ID: <eb42db34f456c3a157cc574893fd73d877b85b75.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Johan Hovold
 <johan+linaro@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Date: Wed, 13 Dec 2023 15:39:24 -0800
In-Reply-To: <20231213204512.GA1056289@bhelgaas>
References: <20231213204512.GA1056289@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 14:45 -0600, Bjorn Helgaas wrote:
> On Wed, Dec 13, 2023 at 11:48:41AM -0800, David E. Box wrote:
> > On Tue, 2023-12-12 at 15:27 -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 12, 2023 at 11:48:27AM +0800, Kai-Heng Feng wrote:
> > > > On Fri, Dec 8, 2023 at 4:47=E2=80=AFAM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > ...
> > >=20
> > > > > I hope we can obsolete this whole idea someday.=C2=A0 Using pci_w=
alk_bus()
> > > > > in qcom and vmd to enable ASPM is an ugly hack to work around thi=
s
> > > > > weird idea that "the OS isn't allowed to enable more ASPM states =
than
> > > > > the BIOS did because the BIOS might have left ASPM disabled becau=
se it
> > > > > knows about hardware issues."=C2=A0 More history at
> > > > > https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.he=
ng.feng@canonical.com/T/#u
> > > > >=20
> > > > > I think we need to get to a point where Linux enables all support=
ed
> > > > > ASPM features by default.=C2=A0 If we really think x86 BIOS assum=
es an
> > > > > implicit contract that the OS will never enable ASPM more
> > > > > aggressively, we might need some kind of arch quirk for that.
> > > >=20
> > > > The reality is that PC ODM toggles ASPM to workaround hardware
> > > > defects, assuming that OS will honor what's set by the BIOS.
> > > > If ASPM gets enabled for all devices, many devices will break.
> > >=20
> > > That's why I mentioned some kind of arch quirk.=C2=A0 Maybe we're for=
ced to
> > > do that for x86, for instance.=C2=A0 But even that is a stop-gap.
> > >=20
> > > The idea that the BIOS ASPM config is some kind of handoff protocol i=
s
> > > really unsupportable.
> >=20
> > To be clear, you are not talking about a situation where
> > ACPI_FADT_NO_ASPM or _OSC PCIe disallow OS ASPM control, right?
> > Everyone agrees that this should be honored? The question is what to
> > do by default when the OS is not restricted by these mechanisms?
>=20
> Exactly.=C2=A0 The OS should respect ACPI_FADT_NO_ASPM and _OSC.
>=20
> I think there are a couple exceptions where we want to disable ASPM
> even if the platform said the OS shouldn't touch ASPM at all, but
> that's a special case.
>=20
> > Reading the mentioned thread, I too think that using the BIOS config
> > as the default would be the safest option, but only to avoid
> > breaking systems, not because of an implied contract between the
> > BIOS and OS. However, enabling all capable ASPM features is the
> > ideal option. If the OS isn't limited by ACPI_FADT_NO_ASPM or _OSC
> > PCIe, then ASPM enabling is fully under its control.=C2=A0 If this
> > doesn't work for some devices then they are broken and need a quirk.
>=20
> Agreed.=C2=A0 It may not be practical to identify such devices, so we may
> need a broader arch-based and/or date-based quirk.
>=20
> I'd be shocked if Windows treated the BIOS config as a "do not exceed
> this" situation, so my secret hope is that some of these "broken"
> devices are really caused by defects in the Linux ASPM support or the
> driver, and that we can fix them if we find out about them.
>=20
> But I have no details about any of these alleged broken devices, so
> it's hard to make progress on them.=C2=A0=C2=A0

I don't have a sense of the scope either. But I could see BIOS not enabling
features that would provide no added power savings benefit. We use ASPM to
manage package power. There are Intel devices that certainly don't require =
L1SS
for the SoC to achieve the deepest power savings. L1 alone is fine for them=
. I
don't know what the test coveragae is for unenabled features. I've sent the=
se
questions to our BIOS folks.

> Maybe we should log a debug note
> if the device advertises ASPM support that BIOS didn't enable.

Good idea.

David

>=20
> Bjorn


