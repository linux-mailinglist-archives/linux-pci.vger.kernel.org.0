Return-Path: <linux-pci+bounces-31271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B32AF5AAD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA2B188FED3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C372BDC04;
	Wed,  2 Jul 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzVfcQmI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734F2BD5B5
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465529; cv=none; b=CH3LMY6L8iWu0i7ANk8pjKMo4dszqZkQGufLQC9O7kXm/x0V05dLpZXDaWR3/L7t5b+dQkyYIJwVoaWdR7KJPte4cH+bB2CywUs1LxwYfCA/w6yg0iaE8Qii+PN5FGQay2jTu4VBHgJFX30vlpcari908S6Rp4J2j/OM69j34OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465529; c=relaxed/simple;
	bh=JRJPH4m3gHOL8iOAGjaKdf0GbC0HHnVxh4Krznoo3KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBD/C1SFejNDBrpLOLkCFrxuRSpxoiJcl+VMrfJZqc70FuHMtPPzhDvaeOrOdc9FPrWulQGAG1yeOGGt5pkA3mj2BOlHkG1pzhZ3nC3XIQyoMoID9VRQAVfiuoe/y99ZQJ1RaFzIv7EMK5ogJxkQsipQSQiL4b3sbK83C1a0GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzVfcQmI; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8259b783f6so3831301276.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751465526; x=1752070326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1mPoU1UCDxjl6IWc+jKm50U28f8v3ln7LdhgS9xFHd8=;
        b=JzVfcQmIhRCBHkY7YMzvyyFHMH69W22USFiAIMlmWmJViWurdbP3UXDxOUX/ZB56DH
         hriNNwFVMwhrsnyiXPsNHLdpwjXlAG2x+RN9Q44qwoBOFBbdXt1KEqsvlGpS550s0Xk9
         wCrC1VKfTa4IMjvM3dLfwA/PYLwedmkAUXB+xPSJBbLsBAfjM9n+qNtzysq6H1G/qPix
         +OruNqP2iKwIQPLiWDoDjNFmDj7wxRhmOqn/8b4FqR27y7826azVnBmT4XnY/JcXfYrM
         sN08NyOhntVoojALkTFFZERbXodeU2OqZN9wWLhfwJOHfzn43EZRRv+nTDnxxxKdzA+N
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465526; x=1752070326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mPoU1UCDxjl6IWc+jKm50U28f8v3ln7LdhgS9xFHd8=;
        b=oBbIXU/c42GkuBfcIHc9vMVjOx9mIlzP5VxN0dBGmNwvjIxUMniIQVrBR3KqFJGogz
         7LH5yDagk1nGUeq7+j/slDtfPEx2TEM4NpAZMuuL2MSvnYJ+PvYKTcvG86kCh87RH615
         tKmn4LzDm0Dmps8laV1w0UFpE7NQ1AhhG/NCrrsjTFzM56JwWRKLUN9RIgBlRoiaVuUL
         aoLHLkKqnlMxca+Xl2Z/QjUR8OxAWx4Rk6U44uZhpvkllfTY9BByCd4rCr2rNleB+phg
         6O7NqH4JqS9bR8PNFYcYvOx+Ac5liJ9J1NswjAGDvDEjZr66Htgn7g2MQCb90Zsj4Al5
         koAg==
X-Forwarded-Encrypted: i=1; AJvYcCVgG8dngUb1wDtmm+v626uEEOoylWBzJq/+F6f/rLsmkrP0eBM3OyEWJDo+7xx+SLfS1wYIg2Sfpfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczcNEizNi47THRaIWhDWYJAynez4WG4uCwJuAebiFs23E7PsW
	k2tkCPAqKOtdBWMYrj+MqJlOo8sKsPp9UUMjs/S82g3NG1/6/eXA/i973pYS0jfE6KYEBSwmPK1
	VipSaxqbB51iAo6lhArprNqjioTU2YOi+dqjkSZu4Tg==
X-Gm-Gg: ASbGncvpf++gRRfutZFjOscaYizvr+TruSV+nKo4/JvKHMgNOj/aCNL21O1upCqY+TX
	yQENi9fsAf4Op3AyC+4cgnDcJ1YTH/jOWoHIqc4s93KyOWbqSNegdt+g94fhlwrSJSOfO33EX37
	soDH4su6swhEMZJQgsL5LAaKaxhmuo1zdtGBpqxiRpPTCM
X-Google-Smtp-Source: AGHT+IHPaXrxmHFVKX7Eql3EMD5x4On0T3oI0issqDZiJ0MoiOv4sD7i0/jMP72156cYMAUC8axQa4qkX4Dj4M+kpkU=
X-Received: by 2002:a05:690c:6213:b0:70e:7882:ea91 with SMTP id
 00721157ae682-7164d4b88d2mr41815867b3.35.1751465525819; Wed, 02 Jul 2025
 07:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5018768.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <5018768.GXAFRqVoOG@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Jul 2025 16:11:30 +0200
X-Gm-Features: Ac12FXynITunG4rG5UQO1EB1vzYUCxa7rAXh-RE6XqfZ0CLPy3V92JuMPVtw6hI
Message-ID: <CAPDyKFp35SjpQmEQ02u7ZbsaFftaett_rBBf-7hbsBpGWH08hw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 21:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This is an update of the series the v2 of which was posted yesterday:
>
> https://lore.kernel.org/linux-pm/5015172.GXAFRqVoOG@rjwysocki.net/
>
> and the v1 is here:
>
> https://lore.kernel.org/linux-pm/22759968.EfDdHjke4D@rjwysocki.net/
>
> This update reorders the patches (again), updates the changelogs of some of
> them and changes the subject of one patch slightly.  It also adds a kerneldoc
> comment to a new function in patch [5/9].
>
> This part of the cover letter still applies:
>
> "This series addresses a couple of issues related to the integration of runtime
> PM with system sleep I was talking about at the OSMP-summit 2025:
>
> https://lwn.net/Articles/1021332/
>
> Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> pm_runtime_force_suspend/resume() due to some conflicting expectations
> about the handling of device runtime PM status between these functions
> and the PM core.
>
> Also pm_runtime_force_suspend/resume() currently cannot be used in PCI
> drivers and in drivers that collaborate with the general ACPI PM domain
> because they both don't expect their mid-layer runtime PM callbacks to
> be invoked during system-wide suspend and resume.
>
> Patch [1/9] is a preparatory cleanup changing the code to use 'true' and
> 'false' as needs_force_resume flag values for consistency."
>
> Patch [2/9] (which was [3/9] in v2) puts pm_runtime_force_resume() and one
> other function that is only used during system sleep transitions under
> CONFIG_PM_SLEEP.
>
> Patch [3/9] (which was [5/9] in v2) causes the smart_suspend flag to be taken
> into account by pm_runtime_force_resume() which allows it to resume devices
> with smart_suspend set whose runtime PM status has been changed to RPM_ACTIVE
> by the PM core at the beginning of system resume.  After this patch, drivers
> that use pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND
> which may be useful, for example, if devices handled by them are involved in
> dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
>
> Since patches [1,3/9] have been reviewed already and patch [2/9] should not
> be particularly controversial, I think that patches [1-3/9] are good to go.
>
> Patch [4/9] (which was [2/9] in v2), makes pm_runtime_reinit() clear
> needs_force_resume in case it was set during driver remove.
>
> Patch [5/9] (which was [4/9] in v2) makes pm_runtime_force_suspend() check
> needs_force_resume along with the device's runtime PM status upfront, and bail
> out if it is set, which allows runtime PM status updates to be eliminated from
> both that function and pm_runtime_force_resume().  I recalled too late that
> it was actually necessary for the PCI PM and ACPI PM to work with
> pm_runtime_force_suspend() correctly after the subsequent changes and that
> patch [3/9] did not depend on it.  I have also realized that patch [5/9]
> potentially unbreaks drivers that call pm_runtime_force_suspend() from their
> "remove" callbacks (see the patch changelog for a bit of an explanation).
>
> Patch [6/9] (which has not been changed since v2) makes the code for getting a
> runtime PM callback for a device a bit more straightforward, in preparation for
> the subsequent changes.
>
> Patch [7/9] introduces a new device PM flag called strict_midlayer that
> can be set by middle layer code which doesn't want its runtime PM
> callbacks to be used during system-wide PM transitions, like the PCI bus
> type and the ACPI PM domain, and updates pm_runtime_force_suspend/resume()
> to take that flag into account.  Its changelog has been updated since v2 and
> there is a new kerneldoc comment for dev_pm_set_strict_midlayer().
>
> Patch [8/9] modifies the ACPI PM "prepare" and "complete" callback functions,
> used by the general ACPI PM domain and by the ACPI LPSS PM domain, to set and
> clear strict_midlayer, respectively, which allows drivers collaborating with it
> to use pm_runtime_force_suspend/resume().  The changelog of this patch has been
> made a bit more precise since v2.
>
> That may be useful if such a driver wants to be able to work with different
> PM domains on different systems.  It may want to work with the general ACPI PM
> domain on systems using ACPI, or with another PM domain (or even multiple PM
> domains at the same time) on systems without ACPI, and it may want to use
> pm_runtime_force_suspend/resume() as its system-wide PM callbacks.
>
> Patch [9/9] updates the PCI bus type to set and clear, respectively, strict_midlayer
> for all PCI devices in its "prepare" and "complete" PM callbacks, in case some
> PCI drivers want to use pm_runtime_force_suspend/resume() in the future.  They
> will still need to set DPM_FLAG_SMART_SUSPEND to avoid resuming their devices during
> system suspend, but now they may also use pm_runtime_force_suspend/resume() as
> suspend callbacks for the "regular suspend" phase of device suspend (or invoke
> these functions from their suspend callbacks).  The changelog of this patch has
> been made a bit more precise since v2, like the changelog of patch [8/9].
>
> As usual, please refer to individual patch changelogs for more details.
>
> Thanks!
>

For the v3 series, please add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

