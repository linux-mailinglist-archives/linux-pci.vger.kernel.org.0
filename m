Return-Path: <linux-pci+bounces-34228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A03B2B48D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 01:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553284E6544
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 23:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956FB1A3166;
	Mon, 18 Aug 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBT5oOXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC21A238F
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559085; cv=none; b=q5OzEH3cYXcvEYlVJ7c0sF6ltmtYiFJVMD3ova9BUsvv3P6aWcRITeWhGOmmZ7c2+kD3YvxiN9iGL1PvVl+/gAkwIuyjf1DmHxsX4ptoY15neW/d+2raLoKpp8aoOmlPfeiK0fcpeClwLFwZi+PWir3Pk0iLkVn93YaFC5UyL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559085; c=relaxed/simple;
	bh=MGOEOcxzrBqz3r/IMrJzjzXdp0k9ipI6eK6vqi+FzqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OA7neZf7mhzzFBlUzHFP1onkgbw0J3lttu7mwZ0E0QSkisOIZ3gvgi0UfJcTuPUSRglp3LRDVUazczwF5gIILzhNIR3cXtfHlou8Ah54Lo23ZYu620IE819RKF6DERN4BLFLjj7JW5digHC13yzxsnELDx++XetUEzvpsk3I/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBT5oOXw; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61bd4e24ac7so1513062eaf.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755559083; x=1756163883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1b+2mp/yigIIHVfdgVDB2QpdrFZcohdIV7tToHX2gNY=;
        b=JBT5oOXwQLhh4+hg3XlGSLJCPWYvTClZMxbGWoWtrBX6xSZsTl7xwgT9xVLHTCE3JP
         Juj+I4HVav8j2V4YKdExHJn1zKhT3YUnhblbkkD6LtZjNbz3xud21eLVJrFvPIsx8Mm8
         qPnEcyCyTIWZPjvTvszpwf7I03794utV3cmZbMrWeVp3nJmUMvFzi5rFqxkON9BK3nxY
         ETD5IhUPgtbl39jOJRhWN+sKLyG/vhZEkv1Z51H9/VCp4n1sM96XvEyIixst2Ud1WUi3
         FKEJnsbvF1ABcbEdl+xe7hnV05/PqKYNXH1FkSbNCYNgfTfimueNQIcAvafh2e4tf/Wg
         MBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755559083; x=1756163883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1b+2mp/yigIIHVfdgVDB2QpdrFZcohdIV7tToHX2gNY=;
        b=b8UbvGfVkMcYYt+mwQCSOORzw4vz+Wmlblh6nFZmtHVPxPRocJrQBIRabIbhRdyBFz
         P8zLhU1dnLry1ZoVOEV9zwEtYA0to08sgJYWgjRQaqpIwjOoVkt82ARhn83a/2x9oobG
         vI+sde7kA7yHJj9+YjxaMjnxCDQ+SW67WCRhGvA8G1qDij3C36iLRcIoUi3v8UGjt79Q
         4OCU7E4RWlwLi/S54Gb4FW1uW6RBs166S6bNeNwhoCuprFyznxmFD3CZPTOgzsU+LjV3
         6+wAaqtKfddUsXrOHWUTFaPN6b+/mslSP5oLuaNLqm2nZpYZJmrGFQ3ZS//f5UFuWFGY
         dlQA==
X-Forwarded-Encrypted: i=1; AJvYcCX5cc7XzBuSMhmQTBjEKk9lbBlfwjzB9cLps6YtxTm+RUiMq6USFiDnteeSIML81tfTobU84wyumwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4TpMXVcs6gUvpYdTuxXbN0qCO1H+HD+6+t5UxZUnlZ4F9KVc
	rXU9hpsNUQlJTHc06g3XjoyDIm8D91NJgBCXTLFQy9LHdOytW56e5M9YVo4e7XOK1O6wTr52pzN
	72vMkarRmhb0WhMz+AD0NrRklOwDwZOxUVA==
X-Gm-Gg: ASbGncs3gx6pQp4yqJw6UCojmeyRiFgvMVykWGaNXITEOeLePx3NRrfY5CmBV1J2+rS
	PfKuzzMAtc8MXjmLTH10W86Iw6NhyGYN+i0rv2xW+YIF9PpFL/ZsR7bd9aZHFJs8JhlXnPyZyDU
	XRlt1buRR3bmiS9tkM85KFZdjMZb4AodxNijcLhdg+pFhFmHCRhvjv/LjafMkbb4/bcxcJYIc6h
	ppsXPvQ79W5IaKm
X-Google-Smtp-Source: AGHT+IGRJXLntANEfq69fBWLU4IJo5Sovp0hsSpwPWXOm4Y8/hfOeFbowvnUWBRIYgeHJZFRZ4J33wlV1SVvt6TELAY=
X-Received: by 2002:a05:6808:3c44:b0:435:f7a2:8ff with SMTP id
 5614622812f47-436cdc938f8mr381698b6e.12.1755559082607; Mon, 18 Aug 2025
 16:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755008151.git.lukas@wunner.de> <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
 <7c545fff40629b612267501c0c74bc40c3df29e2.camel@linux.ibm.com>
In-Reply-To: <7c545fff40629b612267501c0c74bc40c3df29e2.camel@linux.ibm.com>
Reply-To: linasvepstas@gmail.com
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Mon, 18 Aug 2025 18:17:49 -0500
X-Gm-Features: Ac12FXwvCNef1lGTrHQMtgrxrH734r9DdIijklrZKJzvHuzfvTB-RsjbXGpXUJU
Message-ID: <CAHrUA37+0UBYDNzwsU1p8xYCpRypt_e_=ASC2e5QxT1z+D=YJQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI/AER: Allow drivers to opt in to Bus Reset on
 Non-Fatal Errors
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, 
	Riana Tauro <riana.tauro@intel.com>, 
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, 
	"Sean C. Dardis" <sean.c.dardis@intel.com>, Terry Bowman <terry.bowman@amd.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:56=E2=80=AFAM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Wed, 2025-08-13 at 07:11 +0200, Lukas Wunner wrote:
> > When Advanced Error Reporting was introduced in September 2006 by commi=
t
> > 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver"),=
 it
> > sought to adhere to the recovery flow and callbacks specified in
> > Documentation/PCI/pci-error-recovery.rst.
> >
> --- snip ---
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/pcie/err.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index de6381c690f5..e795e5ae6b03 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -217,15 +217,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =
*dev,
> >       pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
> >
> >       pci_dbg(bridge, "broadcast error_detected message\n");
> > -     if (state =3D=3D pci_channel_io_frozen) {
> > +     if (state =3D=3D pci_channel_io_frozen)
> >               pci_walk_bridge(bridge, report_frozen_detected, &status);
> > -             if (reset_subordinates(bridge) !=3D PCI_ERS_RESULT_RECOVE=
RED) {
> > -                     pci_warn(bridge, "subordinate device reset failed=
\n");
> > -                     goto failed;
> > -             }
> > -     } else {
> > +     else
> >               pci_walk_bridge(bridge, report_normal_detected, &status);
> > -     }
> >
> >       if (status =3D=3D PCI_ERS_RESULT_CAN_RECOVER) {
> >               status =3D PCI_ERS_RESULT_RECOVERED;
>
> On s390 PCI errors leave the device with MMIO blocked until either the
> error state is cleared or we reset via the firmware interface. With
> this change and the pci_channel_io_frozen case AER would now do the
> report_mmio_enabled() before the reset with nothing happening between
> report_frozen_detected() and report_mmio_enabled() is MMIO enabled at
> this point? I think this callback really only makes sense if you have
> an equivalent to s390's clearing of the error state that enables MMIO
> but doesn't otherwise reset. Similarly EEH has eeh_pci_enable(pe,
> EEH_OPT_THAW_MMIO).

The original intent was that if the channel locked up e.g. due to some
uncorrectable ECC error or some transient errors due to electrical
problems on the bus (bad reflection of some pulse off some poorly
terminated connector) then such an error would almost surely be
transient and very very unlikely to repeat.

Thus it would be OK to re-enable the MMIO (without otherwise resetting
any channel controller state) and let the device driver examine the PCI
config registers. If they all look good, don't contain any scrambled addrs
or bitflags, then completely normal operations could be resumed without
any further messing around, resetting, invalidating etc.

But first, the device driver needs to examine the config registers and
that cannot be done unless MMIO is enabled.  If MMIO is enabled,
and the PCI config regs appear to contain garbage, then that garbage
can be logged in some error report or crash dump. After this
got done, the device driver would invalidate any pending i/o (for example,
half-finished blocks in some s390 orb, irb, schib, ioccw, whatever)
make sure that assorted channel subsystems are actually halted,
and then attempt  a reset of the bus, the bus controllers (390 channel
or subchannel) and probably the device as well. If that reset succeeds,
then the device driver can restart with a fresh, clean device and a working
channel.  And maybe, if we're lucky, start handling any pending i/o request=
s.

In practice, this worked great for network adapters. However, if the affect=
ed
device was some storage controller for e.g. some mounted filesystem then
(way back when) it was hopeless, because the Linux block subsystem did
not know how to deal with transient errors like this.  Trying to figure out=
 how
to unscramble the block subsystem, and keep mounted filesystems shielded
from this chaos was the one thing I couldn't figure out how to solve.  It s=
eemed
important.  But we've come a long way since then, so I dunno.

-- Linas

