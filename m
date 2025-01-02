Return-Path: <linux-pci+bounces-19166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0149FF94E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 13:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31C97A12C6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FCA1891A9;
	Thu,  2 Jan 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9nkCk2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C23FE4;
	Thu,  2 Jan 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735820491; cv=none; b=Odii5nF2+P4kDn7jcYsoTK2X23Bhtt52+EgbOHb0srVrtSlMH/fw6CqpmgkMCd088dp5t0dr5rWVQ3qFGnzi83fQ4s34rMhGS0z1B9r1PnyLiD8bNQoqHEAaNrIm+UnzA4HlfbamJ/1UvsbkEY2q5jNuIn8MaALo+n8cmjcf+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735820491; c=relaxed/simple;
	bh=oqkSvs2k26FJ4lrvacULZMq6k0SvpdeWvss0OVeNY2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2hhECe+0OuziU6nhh/Du7tGN5jpx5JczzZGWNUc43EpzbSBCNMgTsAohliVA+RUQGeB/Fo3OFsWpOzwBf7cCPzcybrvD2y99/YA94dOVRSmjbphN13nzc4465EB9idiD8J+yrlQilRxL7O6gPFHAU4AQC8MnXAbvGizSJivsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9nkCk2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34514C4CED0;
	Thu,  2 Jan 2025 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735820491;
	bh=oqkSvs2k26FJ4lrvacULZMq6k0SvpdeWvss0OVeNY2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9nkCk2O221LuTpz9OE9LcFcmJ9BB7wG5QMkbu/zgZDZ+sC1Wcg9se64Unj8xcVRb
	 vYyR9qAmRWS57NDpEsMPlPFPxAxnetilyGzbQKVPau1RRKMkfJh5LCUaXVE1RG6+0y
	 t9xG3qTC9hwI/TYPWhvlj0EfrLd0C1nn4AH0IlrYpXyRfsCF+nfVt7Ah5vThqdKyl1
	 DfQfYZcb7nW2aUXs7R3cb+dWMN7KNokgPwqOaftIMVqMv/wN69jZVtch6Sz5iYNHOV
	 gmDWobJESj7utX10noAG2ZbCdSqZKiCqgJprN5Q6cYCqAisK6b4E/40h9nMp4BtBGd
	 bXGShiGLOp6Zw==
Date: Thu, 2 Jan 2025 13:21:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [v6] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z3aExibQ4jPEX3Ib@ryzen>
References: <20250102120222.1403906-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102120222.1403906-1-18255117159@163.com>

On Thu, Jan 02, 2025 at 08:02:22PM +0800, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
>
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> Change the data type of bar_size from integer to resource_size_t, to fix
> the above issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501021000.7Cwcopot-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202501011917.ugP1ywJV-lkp@intel.com/

Note that you do not need "Reported-by" and "Closes" tags in this case,
see the earlier text from the kernel test bot:

"""
If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501011917.ugP1ywJV-lkp@intel.com/
"""

In your case, you are fixing it in a new version of the same patch/commit,
so no need to add the tags.


> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>

Remove the stray new line above.

> ---
> Changes since v4-v6:
> https://lore.kernel.org/linux-pci/20241231065500.168799-1-18255117159@163.com/
>
> - Fix undefined reference to `__udivmoddi4`
>
> Changes since v3:
> https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
>
> - The patch subject were modified.
>
> Changes since v2:
> https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/
>
> - Fix "changes" part goes below the --- line
> - The patch commit message were modified.
>
> Changes since v1:
> https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
>
> - The patch subject and commit message were modified.
> ---
>  drivers/misc/pci_endpoint_test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..df34b742f2de 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
>	void *write_buf __free(kfree) = NULL;
>	void *read_buf __free(kfree) = NULL;
>	struct pci_dev *pdev = test->pdev;
> +	int j, buf_size, iters, remain;
> +	resource_size_t bar_size;
>
>	if (!test->bar[barno])
>		return false;
> @@ -307,13 +308,13 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>	if (!read_buf)
>		return false;
>
> -	iters = bar_size / buf_size;
> +	remain = do_div(bar_size, buf_size);
> +	iters = bar_size;
>	for (j = 0; j < iters; j++)
>		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>						 write_buf, read_buf, buf_size))
>			return false;
>
> -	remain = bar_size % buf_size;
>	if (remain)
>		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
>						 write_buf, read_buf, remain))
>
> base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
> --
> 2.25.1
>

Changes themselves look good to me.


Kind regards,
Niklas

