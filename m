Return-Path: <linux-pci+bounces-44855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B704BD2126F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B532301E1A9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34F430F92D;
	Wed, 14 Jan 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atTc3oxy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4E32B991;
	Wed, 14 Jan 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421983; cv=none; b=ieDsrCTgTMYV9y+mGHbPYmUURDD1Ue9QpskkpJMFws6slhZlUKO1rLP4vFRoSjsEQcn+5nY/uOMlJhxHwVYSCNZ7K1rHOEzMlgalZ9TKJymzNO6BZGvMc5SM3QIsQvmfENBgxdB0UHc2RuUQAmG+nT6RsdMRzkAJjcWQzlPzAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421983; c=relaxed/simple;
	bh=3bBRNO/DZD2q8tmTYU6yb/d4RB4rCHU+aLQ/hYtUSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=COLRvAHcpIJUzhY2nS63a7vXojUWlZjfpQn0iELZU/7v1MsV3Z5xWnq9TfYdr5ZX/XIeiop5FcWlwXAhu1NYLi8zfLCVPGLHeuvfQuS5TJ7NCr/8GaPKbFNlzTfkBgxAoRS3JPk8JdfLZhta8DLLwK2tZTT2Dwb/DZYtP4EqVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atTc3oxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16176C4CEF7;
	Wed, 14 Jan 2026 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768421983;
	bh=3bBRNO/DZD2q8tmTYU6yb/d4RB4rCHU+aLQ/hYtUSeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=atTc3oxygJsuydlLq+jkyB4ynUI8H2lfS1q2dU2ih5Xikv1kWI1C/QWlX8Qg2yApn
	 OjCL4RxUnGjLydjOj9NB34JzPETh120lf0ea6kCtYD1c4dk9EuNc5e+3OJoLMK1lhb
	 Fn1iaos/BzuAqxl6kn8ZTTza45H+g07CD3HATVgnjziwE9sx4UFxvJ/Nd1cf6xuzeZ
	 MgDGRi1yUSC0kPJSV+FPY+g9a5RY1er6fy0xCKZJm3ftgJFRPluDcP8NNfQ8Y8IR+/
	 F1rDNfiGiRbRyIHigvcCNZfJNmzIDX8krNu1a5SWrbswwHCQzZBwCNMfOCru7Vc44T
	 GoO6P22Vnmd1Q==
Date: Wed, 14 Jan 2026 14:19:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, rodrigo.vivi@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com, karthik.poosa@intel.com,
	matthew.auld@intel.com, sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v6 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <20260114201941.GA832768@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114195516.GA830795@bhelgaas>

On Wed, Jan 14, 2026 at 01:55:17PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 13, 2026 at 10:12:03PM +0530, Badal Nilawar wrote:
> > From: Anshuman Gupta <anshuman.gupta@intel.com>
> > 
> > Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10, to request
> > fixed delay in timing between the time the PME_TO_Ack message is received
> > at the PCI Express Downstream Port that originated the PME_Turn_Off
> > message, and the time the platform asserts PERST# to the slot during the
> > corresponding Endpoint’s or PCI Express Upstream Port’s transition to
> > D3cold while the system is in an ACPI operational state.
> > Host platform supporting this feature ensures that device is observing
> > this delay in every applicable D3Cold transition.
> ...

> Sec 4.6.11 also says we should track this per Downstream Port and
> request the maximum of delays requested by any child.  So I think we
> need to:
> 
>   - add a perst_delay in struct pci_dev

If you do this, name it "perst_delay_us" so we know the units.

>   - when we find this _DSM, set
>     bdev.perst_delay = max(bdev.perst_delay, delay_us)
> 
>   - pass bdev.perst_delay to the _DSM instead of delay_us

