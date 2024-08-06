Return-Path: <linux-pci+bounces-11392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E789499DE
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F412832EB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116915C125;
	Tue,  6 Aug 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQNSmjLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91E158DCC;
	Tue,  6 Aug 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978456; cv=none; b=GfGNGs+a4YL9vmCmNHCy35xq/YhYaQyEZjbH9Ici74fjab8OVzMae8B0i56fIB3652L4V+BJBwrxZi2QV85IkXJRAzops3x+S1N45n8aUMwT8Qy7DXVQMGJleZfi2IEVHF4XNNzvveH4FTsfwAe4NzGe6ob3TDAfgL+8LJ2mv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978456; c=relaxed/simple;
	bh=fwy/hFuEzc/8Djy+Yqlwe2rdhsajP4MpZ0SQI/SH38o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l3PWOf8PfYLq+3PGKG7eySoE3MsyXz07bCQEI8ctrQ583sDZkT364STMOuF/R2fNMTSJKurx5GVqk8UoIot50drb5tgaiJPfgPawB2V5kgWEhEls7qGuLfRJMrESUIsFhWNvNTz0XMZIl0Y11MVFeIBRmZbSbfiAtvk6yZESaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQNSmjLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1E8C32786;
	Tue,  6 Aug 2024 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722978455;
	bh=fwy/hFuEzc/8Djy+Yqlwe2rdhsajP4MpZ0SQI/SH38o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TQNSmjLV9JusVY9BAK1XSqpIeWuKGPVP9IGCewCt86QoQkJy0SMvCieLUPsEiKNwG
	 x6IGRHo3Zz3xXO+ElaOyoSweVfgQhrZSNyOovkneSRvFWkrv7IX1p4G55FTovFyVMn
	 ak+DI8NztxMCkJJfUxuMZzg71/8S2fwBLhK3Q2Bjh0GLO6jB/WUmI3H2llIrxP6Iwl
	 lw+K0hwVklH0+khWFk/KdYJsDFwUw1jljbOTZckcn+rLJZntKSB3xGsAJt/qX3RhFy
	 DMuwErwo8lOHv46XQo66rGJDbKYkSFai3cHNuO/rBLdCzrjgog2Uql+cKUCSoLqLTQ
	 /wyN9P0HynyHQ==
Date: Tue, 6 Aug 2024 16:07:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] ACPI: extlog: Trace CPER Non-standard Section Body
Message-ID: <20240806210733.GA78095@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527144356.246220-2-fabio.m.de.francesco@linux.intel.com>

On Mon, May 27, 2024 at 04:43:40PM +0200, Fabio M. De Francesco wrote:
> In extlog_print(), trace "Non-standard Section Body" reported by firmware
> to the OS via Common Platform Error Record (CPER) (UEFI v2.10 Appendix N
> 2.3) to add further debug information and so to make ELOG log
> consistently with ghes_do_proc() (GHES).
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f055609d4b64..e025ae390737 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -179,6 +179,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else {
> +			void *err = acpi_hest_get_payload(gdata);
> +
> +			trace_non_standard_event(sec_type, fru_id, fru_text,
> +						 gdata->error_severity, err,
> +						 gdata->error_data_length);

Kudos for making these two paths more similar.

Not specific to *this* patch, but it's annoying to try to find
tracepoint implementations.  I guess it's
TRACE_EVENT(non_standard_event, ...) in include/ras/ras_event.h.

This has the same prototype as log_non_standard_event(), so
could extlog_print() be made a little bit more like ghes_do_proc() by
using log_non_standard_event() instead of trace_non_standard_event()
directly?

Bjorn

