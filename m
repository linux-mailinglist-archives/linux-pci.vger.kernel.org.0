Return-Path: <linux-pci+bounces-19265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE01A0100E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 23:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D4C164170
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EC1ABEC7;
	Fri,  3 Jan 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOe0A3sA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D01547E4;
	Fri,  3 Jan 2025 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735941723; cv=none; b=Gp3TExLX5lZ8OLhIT8rmdx4840bRueMAsANR2wK7xPpybR7rhFsTrDVZE6z1gOLOZFm74+ST/glMdtKYzZOqEs7qRMqTCd04W56GhRbcGA3o41YUw4yMI2v0wMhyeDSQ0hzstEhXpOvfgyMpJzf0m8CTimrNDrYqaPa6F4ebKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735941723; c=relaxed/simple;
	bh=bvuCIvHyPgfqltWA5nG3E2pKJEibpXca+bRvQYrly/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s6BJOLUDcitJ5GjewgJdcNuFBmru9JLAvA/npKlZLSN51GzHoKmjng+N+ps+cTt6pZ++qjMra/Vc7U8Qb9sngJpzuuAh2LN0UW82dOrAc17h9wkzA/b1BJ8slBRTNPe5PvS2sG8N8MpOovrimVBXG7atDcLXEfan35hB6WLSLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOe0A3sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4F2C4CECE;
	Fri,  3 Jan 2025 22:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735941722;
	bh=bvuCIvHyPgfqltWA5nG3E2pKJEibpXca+bRvQYrly/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FOe0A3sAnwgMRXwI2P2oToefh+OZ03QQwdIFDbTtd4T4JSUOc4GDOfKu4qkXbTrYj
	 opZqEgRRsXda6NzkliCYMKBrbvuh947Omf1Hyebi64hdvUGLcNHSSaXY1c47Hx7di8
	 s1GB+6uVKNNwnOTLPQZpMsTcUQ5xxsd58yQXLI9vQhXLQnTxXMKOoDFIhcBMrQlBaq
	 BCJmg+V50Pa/BhXs19Q8M2F8J9NUt1RsOM8wFZupj2bKkuYq4VTJ5M1GsVTlOnjrzs
	 3qr0KyH0dNlM2baWvG7v7Y7ARH0s9IjuhMgNVrHuF5DbrwgNO+k+XcLs6u4avrn6n9
	 T6OFIj7OuvIQw==
Date: Fri, 3 Jan 2025 16:02:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, kernel test robot <lkp@intel.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v5] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <20250103220200.GA9636@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101151509.570341-1-18255117159@163.com>

On Wed, Jan 01, 2025 at 11:15:09PM +0800, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> Change the data type of bar_size from integer to resource_size_t, to fix
> the above issue.

Add blank lines between paragraphs.

Looks good to me.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501011917.ugP1ywJV-lkp@intel.com/
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> ---
> Changes since v4:
> https://lore.kernel.org/linux-pci/20241231065500.168799-1-18255117159@163.com/
> 
> - add base-commit.
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
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..414c4e55fb0a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int j, buf_size, iters, remain;
> +	resource_size_t bar_size;
>  
>  	if (!test->bar[barno])
>  		return false;
> 
> base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
> -- 
> 2.25.1
> 

