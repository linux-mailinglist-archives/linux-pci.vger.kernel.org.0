Return-Path: <linux-pci+bounces-8477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64446900BFB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E1C1C21614
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBC13F440;
	Fri,  7 Jun 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvClyOjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CA1CD02;
	Fri,  7 Jun 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785804; cv=none; b=DmC4Zp0G5fs0h1wSHLM0fbObLtG6ztOS+69UzSORrP+QM4gXKZp5hW9o5oId7yyH4720ZqUDuriDZTjXFtd6hG3v9+MvUzJJJAssN8fqkhTbapVk52YjA+nIyOUoWe/ceSQpcrN0+ci2PwMOvK1HnADHTlqK3cOMtf7SwQUEUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785804; c=relaxed/simple;
	bh=OCTLuk/DIpZjCuMdEwXD4ZYH2rU5XWljSDnPfquC+XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A3cODvTYj5se672LrLHBqRByxqbI9jDql5JxpDuZE55g97YucYTta71OIxGuuMZ6FhBUMezFy0QXvF+7leSailW+ZpICwsxomtm621MWTxRID0bb+cZhG+A3kw/TskSi++NIUxxvmiFuTT6SPfS49kBwQE9o5FhLi/EirwHMTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvClyOjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482B5C2BBFC;
	Fri,  7 Jun 2024 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717785803;
	bh=OCTLuk/DIpZjCuMdEwXD4ZYH2rU5XWljSDnPfquC+XQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lvClyOjfiMvMLVUxa9M8Ra8v/0slconYbv+YKmVtK3DEaJ+0XlVZ1a5ZNQbMhHrV/
	 zUkvlgZvjmAmvvNSKaLHuWsCmi+pIUZx/wj33h+5ulghxjxjhg2xwhgntLWGFRcQqs
	 G0rqi3F5z8MCKS8h4laqhVbFRgZQaNHSGIMpUhZlmKUWXYTvFKtfzinZ/EuIHxMA/A
	 fX4IwZmlBp1ZXPBM7HPFLb9MoOTUKH5zBcp9xH7ghMEiaqA1ejvioVeozxUZKIQKZb
	 94pUicfCZMhWv8y/ln/FTP5v1WENEIgF9IP3kZ24kcj9yDWk30AKZOGH9DNs9R014x
	 MWxhjTgsSMHCQ==
Date: Fri, 7 Jun 2024 13:43:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH V2 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Message-ID: <20240607184320.GA853474@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-7-wei.huang2@amd.com>

On Fri, May 31, 2024 at 04:38:38PM -0500, Wei Huang wrote:
> According to PCI SIG ECN, calling the _DSM firmware method for a given
> CPU_UID returns the steering tags for different types of memory
> (volatile, non-volatile). These tags are supposed to be used in ST
> table entry for optimal results.

Cite PCI Firmware spec if possible.  If it hasn't been incorporated
yet, at least include the exact name of the ECN and the date it was
approved.

Say what the patch does in the commit log (in addition to the subject
line).

> +#define MIN_ST_DSM_REV		7

No useful value in this #define.  If the value ever changes, code
changes will be required too.

> +#define ST_DSM_FUNC_INDEX	0xf

Move to the list in pci-acpi.h with name similar to others.

> +static bool invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
> +		       u8 target_type, bool cache_ref_valid,
> +		       u64 cache_ref, union st_info *st_out)
> +{

Return 0 or -errno.  "invoke_dsm" is not a predicate with an obvious
true/false meaning.

> +	union acpi_object in_obj, in_buf[3], *out_obj;
> +
> +	in_buf[0].integer.type = ACPI_TYPE_INTEGER;
> +	in_buf[0].integer.value = 0; /* 0 => processor cache steering tags */
> +
> +	in_buf[1].integer.type = ACPI_TYPE_INTEGER;
> +	in_buf[1].integer.value = cpu_uid;
> +
> +	in_buf[2].integer.type = ACPI_TYPE_INTEGER;
> +	in_buf[2].integer.value = ph & 3;
> +	in_buf[2].integer.value |= (target_type & 1) << 2;
> +	in_buf[2].integer.value |= (cache_ref_valid & 1) << 3;
> +	in_buf[2].integer.value |= (cache_ref << 32);
> +
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = ARRAY_SIZE(in_buf);
> +	in_obj.package.elements = in_buf;

Must check whether this _DSM function is implemented first, e.g., see
acpi_enable_dpc().

> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
> +				    ST_DSM_FUNC_INDEX, &in_obj);
> +
> +	if (!out_obj)
> +		return false;
> +
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		pr_err("invalid return type %d from TPH _DSM\n",
> +		       out_obj->type);
> +		ACPI_FREE(out_obj);
> +		return false;
> +	}
> +
> +	st_out->value = *((u64 *)(out_obj->buffer.pointer));
> +
> +	ACPI_FREE(out_obj);
> +
> +	return true;
> +}

