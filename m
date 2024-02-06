Return-Path: <linux-pci+bounces-3164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6EE84B9A0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D0A2932CD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C08B1332B9;
	Tue,  6 Feb 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB8r44SO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99E132C3E;
	Tue,  6 Feb 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233527; cv=none; b=PbRylqqvs34VMjjpAId6xBoMfnjs1e/sS14TK9oX+g1h2PjZctx6nL4UGeslVUjsyVB7glqmjetSeO4ZKZ5pkf0k3FqIXFv7N3wUWuf5AV9/8VC3uf4LM2cH/hpmXDIfIH0Khci/B1ePy847IcYUIWIwdfOIqfMr4Je+wfedFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233527; c=relaxed/simple;
	bh=adqj0rvLx6dUnNPm8VQXCTdQ6CPnE2MNoTeYzdrXCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QceH9ciakGkXRh0yHWr/NNoVAgoONI1BH51e0XeSB5QADNnp0NQmjMIFf4+G+DwSBuf+mAnUqkRQ1OnaGHUoOERPgbwcRb5mmaI7y+ZnbMyhN/hbuzUg83ckp3eLNe8C2FG6jn94feK3gOdZXEEBCaaxfBIfpjjiKf6LcSuCI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB8r44SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA45C433C7;
	Tue,  6 Feb 2024 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233526;
	bh=adqj0rvLx6dUnNPm8VQXCTdQ6CPnE2MNoTeYzdrXCCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XB8r44SOOA7MhA2w0L/9UHK7PDUNke/XV4Gohw3i2Zm5z94RzlBoGTgJ9NkTjctnP
	 /fINxugc8LjwhikLCfMn/Na19KVn8KMcDNwCRUCZTjqm5oitjMg+IKq0UTk+pbJuwQ
	 qbPMdbp5FYu2bE6sm7NvA9Xe7S04T34a5p6npttT31BG2X+XtyrFRypIAEv1yBjR13
	 TtCfljU9hZMjACnPKGQ3p/H0h7ozT2U+ETIPiTLbxpoJRHIAHVoBkRPGouDNJmmcCI
	 L2kfAqC526nqiUUNEbxsxB0DdAO+ZR4j7lsHUfgf0bfus3TNctfPKN3bZmcu0Emrhi
	 bRBiU/l2rJ/ug==
Date: Tue, 6 Feb 2024 09:32:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com
Subject: Re: [PATCH 1/2] drivers: acpi: use %pe for better readability of
 errors while printing
Message-ID: <20240206153204.GA866166@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051120.4173475-1-onkarnath.1@samsung.com>

On Tue, Feb 06, 2024 at 10:41:19AM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
> 
> As %pe is already introduced, its better to use it inplace of (%ld) for
> printing errors in logs. It would enhance redability of logs.

s/its/it's/
s/inplace/in place/
s/redability/readability/

In the subject line, run "git log --oneline drivers/acpi" and pick
something that fits with the history instead of just encoding the file
path.  Same for the sched patch.

Bjorn

