Return-Path: <linux-pci+bounces-20211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE32A18616
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F8A3A5DCE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 20:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAB1F707D;
	Tue, 21 Jan 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyzBC3dy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B61F5614;
	Tue, 21 Jan 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490994; cv=none; b=k/Y80/U4kfdyP3Fy8hHWUlU1c1IwXQ61W6lq1uUE+aWojgRsA33mZbIgcpXWI0/4dYGiEg4nJoDaXX0wO5B7JqH6b7sEjasnaefQsNOISg6RNfnUbdytORPvMF+J5e9pFtIu4xzoVobClfkQhng8AhFfoDyvmYflZpaLrnGuHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490994; c=relaxed/simple;
	bh=nuaalhW0jpPUOyqKzjbiV4YkyqBzIjJbLc5NvbsiwWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a48fpnkLOkeStcmHBkADgF7OFo0kX/o/f+rGROG9dLKBEz/50UBBv4vYXbl+ESi6A6LYIUxTJ9AToOZFjInf7px5Ykl4aH+W43orhRxPKyea2eklx0V6rXxTvR2U/7ni6rtrxaXZL2aIzVT7dFHR78htDIXuzs6IPZr4/gUGcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyzBC3dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499CCC4CEE2;
	Tue, 21 Jan 2025 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737490992;
	bh=nuaalhW0jpPUOyqKzjbiV4YkyqBzIjJbLc5NvbsiwWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AyzBC3dyXM3Np6BAGQI7fIrw8wUOZ/BhxwMHqH6v8E52kAmVcyWvAfMqaD8/E9h4W
	 UK+UFis+djkpHWL/doK889Cx3OjCy31NYdt38AvPgJM9Y/y4yvFeMkXt46cwRLXJ4T
	 kLUTN8r1NcSaVG/oudSN+EXtCAO14gkxCN8+dW0C2exbKCcmg/7B2PiAyvf57nQU+K
	 DSV1wneIzT2qfa9dNLydhheXFVv5bP/hpr+txSaN4zhOaAIdGIjAMcJ1SOt0NGYVQ3
	 RtCr/73lCyD+KIfX4O9BhIOTkP6e69IVNoXXL4C5CrqGMUjZxACO6KtgJT0qEme9L2
	 i/9PMTimbp/kA==
Date: Tue, 21 Jan 2025 14:23:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Niklas Cassel <cassel@kernel.org>,
	linux-tegra@vger.kernel.org
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <20250121202310.GA979442@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>

On Tue, Jan 21, 2025 at 05:46:43PM +0000, Jon Hunter wrote:
> On 09/01/2025 09:45, Hans Zhang wrote:
> > With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> > 
> > The return value of the `pci_resource_len` interface is not an integer.
> > Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> > overflow.
> > 
> > Change the data type of bar_size from integer to resource_size_t, to fix
> > the above issue.
> > 
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Suggested-by: Niklas Cassel <cassel@kernel.org>
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v10:
> > https://lore.kernel.org/linux-pci/20250108080951.1700230-3-18255117159@163.com/
> > 
> > - Replace do_div with the div_u64 API.
> > 
> > Changes since v8-v9:
> > https://lore.kernel.org/linux-pci/20250104151652.1652181-1-18255117159@163.com/
> > 
> > - Split the patch.
> > 
> > Changes since v4-v7:
> > https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
> > 
> > - Fix 32-bit OS warnings and errors.
> > - Fix undefined reference to `__udivmoddi4`
> > 
> > Changes since v3:
> > https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
> > 
> > - The patch subject were modified.
> > 
> > Changes since v2:
> > https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/
> > 
> > - Fix "changes" part goes below the --- line
> > - The patch commit message were modified.
> > 
> > Changes since v1:
> > https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
> > 
> > - The patch subject and commit message were modified.
> > ---
> >   drivers/misc/pci_endpoint_test.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index f78c7540c52c..0f6291801078 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> >   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >   				  enum pci_barno barno)
> >   {
> > -	int j, bar_size, buf_size, iters;
> > +	int j, buf_size, iters;
> >   	void *write_buf __free(kfree) = NULL;
> >   	void *read_buf __free(kfree) = NULL;
> >   	struct pci_dev *pdev = test->pdev;
> > +	resource_size_t bar_size;
> >   	if (!test->bar[barno])
> >   		return false;
> > @@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >   	if (!read_buf)
> >   		return false;
> > -	iters = bar_size / buf_size;
> > +	iters = div_u64(bar_size, buf_size);
> >   	for (j = 0; j < iters; j++)
> >   		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> >   						 write_buf, read_buf, buf_size))
> 
> 
> This change breaks building the kernel with GCC v7 and I see ...
> 
> ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko]
> undefined!
> ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko]
> undefined!
> 
> I know that this is an old GCC version, but this is a farm builder and the
> kernel still indicates that GCC v5.1 is still supported [0].
> 
> Jon
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/changes.rst

Dropping from pci/endpoint-test for now until this gets sorted out.

For reference, the current iteration (the one I'm dropping) is below:

commit c6e73776c0c4 ("misc: pci_endpoint_test: Prevent bar_size overflow")
Author: Hans Zhang <18255117159@163.com>
Date:   Thu Jan 9 17:45:56 2025 +0800

    misc: pci_endpoint_test: Prevent bar_size overflow
    
    Running 'pcitest -b 2' fails with "TEST FAILED" when the BAR2 size
    exceeds 4GB.
    
    The return value of the pci_resource_len() macro can be larger than that
    of a signed integer type. As such, for example, when using 'pcitest'
    with an 8GB BAR2, the bar_size of the integer type will overflow.
    
    Change bar_size from integer to resource_size_t to prevent integer
    overflow for large BAR sizes with 32-bit compilers.  Similarly, use
    div_u64() to perform 64-bit division in that situation.
    
    Link: https://lore.kernel.org/r/20250109094556.1724663-3-18255117159@163.com
    Signed-off-by: Hans Zhang <18255117159@163.com>
    [kwilczynski: commit log]
    Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
    [bhelgaas: pick up commit log update from
    https://lore.kernel.org/r/Z4jTEkznMUcApzbe@ryzen]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Niklas Cassel <cassel@kernel.org>
    Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index be0c7c870e6a..abe6c8f03fca 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -283,10 +283,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters;
+	int j, buf_size, iters;
 	void *write_buf __free(kfree) = NULL;
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
+	resource_size_t bar_size;
 
 	if (!test->bar[barno])
 		return false;
@@ -310,7 +311,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (!read_buf)
 		return false;
 
-	iters = bar_size / buf_size;
+	iters = div_u64(bar_size, buf_size);
 	for (j = 0; j < iters; j++)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
 						 write_buf, read_buf, buf_size))

