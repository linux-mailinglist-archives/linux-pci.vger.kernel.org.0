Return-Path: <linux-pci+bounces-23022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD2A53E87
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 00:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4217716EDB3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 23:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A2206F0C;
	Wed,  5 Mar 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKu5JW2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D71E7C20;
	Wed,  5 Mar 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217645; cv=none; b=Iey+vUJLFAaHfvWb7cgmlz9PgyPkYj6/szy4+6a0dSI8Rsj+GtBLsYnZ5XdptVq1/Fb/2W26Ydq7vshCA+3Ck7RPnZ0PKtPvjYSk65VnCVuGGAx5BFsyyKkRnDW5UuFTyJyBM53se/my616lmy2VEAHr1e+UvpE1plyXrY+vDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217645; c=relaxed/simple;
	bh=DiKVcqBbLlw3mubl16bRt1UkW+LqGANXthkKmwrrGrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oWLRQDV6rZGkIB7MN+sEm+B1ZVhxrRzvffRACkv023C/d3RKYQe0uUjQPKwvMrA9p8gFcCDWr8rmFwUpQEXjfGrUWq37FVb57bk2OfotQdJ4dNi7ndYQGSZJDOveXFuXNZF6mEfMdJ2NHFO/WuDKLQ1i4c4aeBHXdqO1Y7vc+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKu5JW2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73D3C4CED1;
	Wed,  5 Mar 2025 23:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741217644;
	bh=DiKVcqBbLlw3mubl16bRt1UkW+LqGANXthkKmwrrGrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VKu5JW2eIjpYHmRqAOvlCUGemsBEfqnhgrE9VoXNJAOuyv29rO29Ghe9WsLESvgUv
	 LltXa0uu13f2JDDAp+pZhUmGtzIV4rrIvxilZlpET9q7aar2Ba7m25m3/3BTHYfrw1
	 nVX+WFTPWRRUvBaPmWJu9jbyKKWkRTvOWcdMMfQFNOUQHF8r+4CnIVYCRRzxa1tpUG
	 6Sby+OzFIK81bXhAXeMGNsjqmELv7p73AibCVSO+nQYTGaO65eIUTLcIVTHrwt39HE
	 P6YJNXu60xoLlTZ6quUuIvpJ0YcNI09BnEQV4/29G3/XHoDZAMSKSlArHIFGbCDeec
	 an+UW+lSljGsw==
Date: Wed, 5 Mar 2025 17:34:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, yazen.ghannam@amd.com, avadhut.naik@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
	leoliu@zhaoxin.com
Subject: Re: [PATCH v5 1/4] ACPI: APEI: Move apei_hest_parse() to apei.h
Message-ID: <20250305233403.GA322933@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226121838.364533-2-LeoLiu-oc@zhaoxin.com>

On Wed, Feb 26, 2025 at 08:18:35PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Remove static from apei_hest_parse() so that it can be called in another
> file.

> +++ b/drivers/acpi/apei/hest.c
> @@ -134,7 +134,7 @@ static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
>  
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
> -static int apei_hest_parse(apei_hest_func_t func, void *data)
> +int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
>  	struct acpi_hest_header *hest_hdr;
>  	int i, rc, len;
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524..b79976daa4bb 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -33,6 +33,8 @@ void __init acpi_ghes_init(void);
>  static inline void acpi_ghes_init(void) { }
>  #endif
>  
> +int apei_hest_parse(apei_hest_func_t func, void *data);

Series doesn't build after this patch because we lack the
apei_hest_func_t typedef:

  $ make drivers/acpi/apei/
    CC      drivers/acpi/apei/apei-base.o
  In file included from drivers/acpi/apei/apei-base.c:30:
  ./include/acpi/apei.h:36:21: error: unknown type name ‘apei_hest_func_t’
     36 | int apei_hest_parse(apei_hest_func_t func, void *data);
	|                     ^~~~~~~~~~~~~~~~

The kernel must build and function correctly after each and every
patch in the series.

