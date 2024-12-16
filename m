Return-Path: <linux-pci+bounces-18534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91469F3800
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD439188F447
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE57206F09;
	Mon, 16 Dec 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiQ2VrgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB22066DC
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371549; cv=none; b=oeA+r6V4QkB5xpArKWqJd2ZJtXc4udP+W1ONTfnh8FL32Rziv9PwlUdO7Ywl1BDxFDRUI9lk+wg4Mc04WUwwdPUzxbtQaLBzlnvrZeh4vsv8Rwm/UdNmrECHWG29sHx1KYMWSd0ptagBusHrM6pjGJl7tHDkC20oGyE3M25TmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371549; c=relaxed/simple;
	bh=iQRgE9Rcu1KUs6xXY8YfJ2nds9R5OXRboroFHyRVbao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTAZdlT/rhsj+K/oPE1fnQIv0Rcos7rvBao8tvq0T2/etAuNXfsHHrmItMfKCTeq+pOsi7p0p05ALpmFCU9TA4RobIGP/4FrNpkiAvHFk+fa4z+pJTbHP0cKY1eK/vdBEfw8Eiwl28TIRZuvdbCH8HJrLvfRmWMbko0hOpgDERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiQ2VrgG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21683192bf9so41606095ad.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734371547; x=1734976347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGS1MlFpafeO/WKDSXrB+UcdagNLniFx8svINS1DDrg=;
        b=JiQ2VrgGhjfu8N+ZKprGnywp2Q+Pmmucifes9BMAOq4+YdXYVVfDX+xNgHneRohy4k
         IC0TG6fG/DeTCQyjzPnHlQ4B3f7qOF3qW1h/xnqaAjwi5ZspCSnNyYo/bzmVKkiIL/T5
         z43g4YF8+QLbohb2I3uKjZmNwVZpVLzpT3ZKATthqZAENOscPrhRlBJlHRV8j6RxwRR2
         eaEY2lThwACcVULG6elxGWsMCf0YE6y0qdV6E8euEattv/8FOehS7ohH/V4SKk9r5wt5
         dV+YGiAJtgYXfu2HfyvxxxY7U/vZIJNW69+c4C2TPPHP0HcxqxQ/4ZJWwZwQqsBcVtQh
         Wzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371547; x=1734976347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGS1MlFpafeO/WKDSXrB+UcdagNLniFx8svINS1DDrg=;
        b=bKsL2qTXzp3azcvScpTXjwOPbjaR+pDeT43uncV50gv7Mn2Lu8QP65qGMkw3MUMHNF
         KUuivs01FL4TkWiroMv6750MeqxJnlqhLV4/8A+VEZzJ5Tk0WvxaLoy3LySi9si/iCr0
         hQ2Yeu1Um8rxoIb4SZp6N07cb+Cy6pZLDGfWN3yzQsP3VBj5Abmd0S6aBuR4sUbpWKP3
         EQv3JnIh+FcZW/vPml3uVdQ111/MCB/Z9WA6N54jFmhW+NXUdUp7Lupne9SY+0/Ks0OH
         RIliniDyAzvRbcHFDHuuMVcCWU0XVLq9JK+nubE1rcOPPhx5+svFqJMZZ89Mv5vxmLlc
         BGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq5PQ7m9b8gzW/UUvVJL7Z3ut/aSwko7sodQ6ElN5QDbWjHmotLnpg5JeczMfezwzjrIQBtBPkkNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVotjTH4BQHBDtj+wCz+fiX1CZzbAfj+HhRdR9IkkI2bCulbMx
	hOpooFh3oG5pcnuw8AwD4mzYJHNlxcAjzGfshgRwnLGFAD5K6wTaIThCW5HaxA==
X-Gm-Gg: ASbGncs+lFY4aCs8TAEdtZTVWuJwKHc5Ee2jst+dZyfcpWk9ooVxNPRo87dKPMZ3VrQ
	O+cbWLDKWj9J1Pw5glNcvZRDXVFE9cXGIELcOaPzbFye47RHeYuLCrcHY+7XgIXZ/p6mW8kyal8
	5LlDdnmpkOp7zqqHpY/ioOzp7p29BGYrHG3YIHTxuwCk/15D/mHtVE6gqmYFQh0T7ZukyKxu+k4
	Sa1kU011jkF61ctgUJfecO4HH0pMuDdgEqtHQEkJ48YgFMWfFzLA7m2wilnUSMK1Gce
X-Google-Smtp-Source: AGHT+IGvWV6mfCj2/Ercn+vVqs5fNl4+6j1t5Xlmhx+sET9hOWmhhuc1oXLoQDebjet3XKapMZVhsw==
X-Received: by 2002:a17:902:ec89:b0:215:7421:27c with SMTP id d9443c01a7336-21892a01fddmr196614925ad.29.1734371547288;
        Mon, 16 Dec 2024 09:52:27 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50299sm45812965ad.143.2024.12.16.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:52:26 -0800 (PST)
Date: Mon, 16 Dec 2024 23:22:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241216175210.mnc5kp6646sq7vzm@thinkpad>
References: <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>

On Mon, Dec 16, 2024 at 06:35:52PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 6:11 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 05:24:40PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Dec 14, 2024 at 7:30 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Dec 12, 2024 at 4:14 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > > >
> > > > > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > > > > Right. This seems to somewhat work for ACPI types of systems, because
> > > > > > > ACPI is controlling the low power state for all the devices. Based on
> > > > > > > the requested system wide low power state, ACPI can then decide to
> > > > > > > call pm_set_suspend_via_firmware() or not.
> > > > > > >
> > > > > > > Still there is a problem with this for ACPI too.
> > > > > > >
> > > > > > > How does ACPI know whether it's actually a good idea to keep the NVMe
> > > > > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > > > > > > only for S2R and S2disk!?)? Especially when my laptop only supports
> > > > > > > s2idle and that's what I will use when I close the lid. In this way,
> > > > > > > the NMVe storage will certainly contribute to draining the battery,
> > > > > > > especially when I won't be using my laptop for a couple of days.
> > > > > > >
> > > > > > > In my opinion, we need a better approach that is both flexible and
> > > > > > > that dynamically adjusts based upon the use case.
> > > > > >
> > > > > > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > > > > > but I don't really know enough about the PM core to drive it
> > > > > > (as the reply from Rafael to my mail makes pretty clear :))
> > > > >
> > > > > I'm here to help.
> > > > >
> > > > > Let me know what exactly you want to achieve and we'll see how to make it work.
> > > >
> > > > I'll try to summarize the requirement here since I started this thread:
> > > >
> > > > Problem statement
> > > > =================
> > > >
> > > > We need a PM core API that tells the device drivers when it is safe to powerdown
> > > > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > > > applicable to other devices as well.
> > > >
> > > > Drivers are relying on couple of options now:
> > > >
> > > > 1. If pm_suspend_via_firmware() returns true, then drivers will shutdown the
> > > > device assuming that the firmware is going to handle the suspend. But this API
> > > > is currently used only by ACPI. Even there, ACPI relies on S2R being supported
> > > > by the platform and it sets pm_set_suspend_via_firmware() only when the suspend
> > > > is S2R. But if the platform doesn't support S2R (current case of most of the
> > > > Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe won't be
> > > > powered down draining the battery.
> > >
> > > So my question here would be why is it not powered down always during
> > > system-wide suspend?
> > >
> > > Why exactly is it necessary to distinguish one case from the other
> > > (assuming that we are talking about system-wide suspend only)?
> > >
> >
> > To support Android like usecase with firmware that only supports
> > suspend-to-idle (Qcom platforms). This usecase is not applicable right now, but
> > one can't just rule out the possibility in the near future.
> 
> This doesn't explain anything to me, sorry.
> 
> > And the problem is that we need to support both Android and non-Android systems
> > with same firmware :/
> 
> So what technically is the problem?
> 

NVMe wear out is the problem.

> > > There are drivers that use pm_suspend_via_firmware() to check whether
> > > or not something special needs to be done to the device because if
> > > "false" is returned, the platform firmware is not going to remove
> > > power from it.
> > >
> > > However, you seem to be talking about the opposite, so doing something
> > > special to the device if "true" is returned.  I'm not sure why this is
> > > necessary.
> > >
> >
> > Because, since 'false' is returned, drivers like NVMe are assuming that the
> > platform won't remove power on all DT systems and they just keep the devices in
> > low power state (not powering them down). But why would I want my NVMe in DT
> > based laptop to be always powered in system suspend?
> 
> Because it causes the system to use less energy when suspended.
> 

But the NVMe driver would be still operational. Powering it down would cause the
system to use much less energy. There is also a case where some devices like
(Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to be
powered down in order for the SoC to reach its low power state (CX power
collapse in Qcom terms). If not, the SoC would continue to draw more power
leading to battery draining quickly. This platform is supported in upstream and
we keep the PCIe interconnect voted during suspend as the NVMe driver is
expecting the device to retain its state during resume. Because of this
requirement, this platform is not reaching SoC level low power state with
upstream kernel.

> > > > If the platform is using DT, then there is no entity setting
> > > > pm_set_suspend_via_firmware().
> > >
> > > That's true and so the assumption is that in this case the handling of
> > > all devices will always be the same regardless of which flavor of
> > > system suspend is chosen by user space.
> > >
> >
> > Right and that's why the above concern is raised.
> 
> And it is still unclear to me what the problem with it is.
> 
> What exactly can go wrong?
> 
> > > > So NVMe will be kept in low power state all the
> > > > time (still draining the battery).
> > >
> > > So what would be the problem with powering it down unconditionally?
> > >
> >
> > I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
> > will wear out the NVMe devices if used in Android tablets etc...
> 
> I understand the wear-out concern.
> 
> Is there anything else?
> 

No, that's the only concern.

> > > > There were attempts to set this flag from
> > > > PSCI [1], but there were objections on setting this flag when PSCI_SUSPEND is
> > > > not supported by the platform (again, the case with Qcom SoCs). Even if this
> > > > approach succeeds, then there are concerns that if the platform is used in an
> > > > OS like Android where the S2Idle cycle is far more high, NVMe will wear out
> > > > very quickly.
> > >
> > > I see.
> > >
> > > > So this is where the forthcoming API need to "dynamically adjusts
> > > > based upon the use case" as quoted by Ulf in his previous reply. One way to
> > > > achieve would be by giving the flexibility to the userspace to choose the
> > > > suspend state (if platform has options to select). UFS does something similar
> > > > with 'spm_lvl' [2] sysfs attribute that I believe Android userspace itself makes
> > > > use of.
> > >
> > > Before we're talking about APIs, let's talk about the desired behavior.
> > >
> > > It looks like there are cases in which you'd want to turn the device
> > > off completely (say put it into D3cold in the PCI terminology) and
> > > there are cases in which you'd want it to stay in a somewhat-powered
> > > low-power state.
> > >
> > > It is unclear to me what they are at this point.
> > >
> >
> > I hope that my above explanation clarifies.
> 
> Sorry, but not really.
> 
> > Here is the short version of the suspend requirement across platforms:
> >
> > 1. D3Cold (power down) - Laptops/Automotive
> > 2. D3hot (low power) - Android Tablets
> 
> Where do the above requirements come from?
> 

In my case, it is coming from the SoC vendor, Qcom.

> > FWIW, I did receive feedback from people asking to just ignore the Android
> > usecase and always power down the devices for DT platforms. But I happen to
> > disagree with them. Let me know if I was wrong and I should not worry about
> > Android usecase as it is for the future.
> 
> I'm not sure what you mean by the "Android usecase" TBH.  Do you mean
> the wear-out concern in the Android usage scenario or is there more to
> it?

No, just the wear out concern in Android usecase.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

