Return-Path: <linux-pci+bounces-8243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353268FB760
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA15284F60
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F916148304;
	Tue,  4 Jun 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUpcoIh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013E1482FD;
	Tue,  4 Jun 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515035; cv=none; b=BSvap6pa9ByFpLkO4cAVqU+Hxc/0ch3P/zfgLIDLcg+j3dl7yhKmm4f7P0ANEMnhHW0quABqGIMqLZYXdsjuzgwx0ss/A+vtL5MI9zr0132FhOt6N/WMzDzyr9qcJ8VYDUia8W6kg89nlOwp6/WSpkwBZwVTi+uPK2LdZ9LUHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515035; c=relaxed/simple;
	bh=u9K203DT7q3+ekRSWvUlR+Y9s6vwYEo9Le/NC4TtiN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnQZGLaNnTFtjmiYe9PMtUIjWBgody3QluxUXDmxstIQS+Uc4ixhnDFN2OO1K1WjmB67hngrxV9X1NHUKcKZ15h2l0LQrJSvYeK1oQaNenek+KDo72hglG5UuuLUVN3XLLFxBjS3yBbVIO6WSrOSPn23kcnZGq4cleqw6gYK0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUpcoIh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7CDC4AF08;
	Tue,  4 Jun 2024 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717515034;
	bh=u9K203DT7q3+ekRSWvUlR+Y9s6vwYEo9Le/NC4TtiN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUpcoIh7jBNWzNEULN+DknncEDnocOAB3IU8XexYFsZOT4cy9MpmkKlJdCBuhtON3
	 qE7PkgUmc/Kig6KrFA1ViA0TJpRV+t/ZFgnsl29xGTi0C4H/MIarY61fde15w8dJM1
	 6L5NeRAfByk+hNF2YM/ThZXNfJlp5rUhoZqSMGZIE2KrZCzkrtYyqWodyaKMFpe1ZQ
	 kwaw8m7JsH/XTIlHHl6IfgdwGFVpei9UeQNUjUicB5iDpoJmgaM8bjsqUtEl9Kn9ld
	 imMMKF2zHSo36ZZ0Tysl369TcgrR3FNVAU97dpguqy3GinrW7bY6k/pLEqsIcXOVIb
	 OLn0PYcCoqcbA==
Date: Tue, 4 Jun 2024 16:30:28 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, bagasdotme@gmail.com
Subject: Re: [PATCH V2 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Message-ID: <20240604153028.GU491852@kernel.org>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
 <20240531213841.3246055-7-wei.huang2@amd.com>
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
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>

...

> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c

...

> +static bool invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
> +		       u8 target_type, bool cache_ref_valid,
> +		       u64 cache_ref, union st_info *st_out)
> +{
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
> +
> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
> +				    ST_DSM_FUNC_INDEX, &in_obj);

Hi Wei Huang, Eric, all,

This seems to break builds on ARM (32bit) with multi_v7_defconfig.

  .../tph.c:221:39: error: use of undeclared identifier 'pci_acpi_dsm_guid'
  221 |         out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
      |

I suspect a dependency on ACPI in Kconfig is appropriate.

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

...

