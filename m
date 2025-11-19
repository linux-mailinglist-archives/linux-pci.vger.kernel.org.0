Return-Path: <linux-pci+bounces-41654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73567C7008B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE4284FC3D5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46776377EB3;
	Wed, 19 Nov 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Laj4zYxh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F717D2;
	Wed, 19 Nov 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567408; cv=none; b=N99xdWoVmgJVUllSYTTA7BGdMb2DR4/hVsLE0SKsEwhmYiWcbmnTg2FBaw4oSH0Wpz9OmnwETME6TrgkIcQDJa2xzp6Kk8Ornk/ym2EYpn6QW5UZODFO2iLFpqIMrjSymDGgSWYmHp7hZffjJv4NLnrzklNM34hTPgNzchkRzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567408; c=relaxed/simple;
	bh=mtl+IHM/JXtrCO8ISnitiGZcya/g9fsTYHXlgtCEzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyO14AnYKT/4hutPCI9e4BRS+TXDQ5aKcVakc2mhYGXqSyAUBVNeeuM0auo2DpH9ITtkvwBLVHb4hHoAUd6rL2Y3xNaR16hjxAYkHbBcDiqmM9CTK3C7vD7l06DJ8/BcIZG3b2UFYJxzk4VM31opoIc6bVw57CWSnRZ1RKwfwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Laj4zYxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A51C2BCB0;
	Wed, 19 Nov 2025 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567407;
	bh=mtl+IHM/JXtrCO8ISnitiGZcya/g9fsTYHXlgtCEzjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Laj4zYxhFW+Cyz8oEoGr4IEUQkfwUMdLv7HRG6pEmMXhq+vvRB62wNZAYyCBhwMgW
	 ydZ26okaryoinvEE8tIJbLlJoY1/cMOVAl5gZWnUjbENpW2a9mfRw+vAlvoqjU3euP
	 pbkZQ00ScKclvx/Fc7+VWCtde1BoO4ZllGxuhaaQ6oHWiJx30xfmdUGu2l8xqahHsp
	 T+hG+IPeCO3xnQsYkJ7VatBdtqrEHMzKKg55/4DdSBYnYup2E2b5/XfowD8zPoAvGV
	 SUjpmYocHoRKpWNGz1Ow4h6dPUUWYAJv0jrXiCMFF0CA6h8rz5TtzNJHhRm6MSXZFU
	 PqBSfmBBhtEiA==
Date: Wed, 19 Nov 2025 21:19:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Alex Deucher <alexander.deucher@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Matthew Brost <matthew.brost@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Sagi Maimon <maimon.sagi@gmail.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Karan Tilak Kumar <kartilak@cisco.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Max Kellermann <max.kellermann@ionos.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Gustavo Padovan <gustavo@padovan.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rodolfo Giometti <giometti@enneenne.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Satish Kharat <satishkh@cisco.com>, 
	Sesidhar Baddela <sebaddel@cisco.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 15/21] PCI: epf-test: Switch to use %ptSp
Message-ID: <wuyn4v625xw4n2jm4eiullfrprmjiw4aiwo4zudcp4ppd2yeva@s7vzfoinnavt>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-16-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113150217.3030010-16-andriy.shevchenko@linux.intel.com>

On Thu, Nov 13, 2025 at 03:32:29PM +0100, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index b05e8db575c3..debd235253c5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -331,9 +331,8 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>  		rate = div64_u64(size * NSEC_PER_SEC, ns * 1000);
>  
>  	dev_info(&epf_test->epf->dev,
> -		 "%s => Size: %llu B, DMA: %s, Time: %llu.%09u s, Rate: %llu KB/s\n",
> -		 op, size, dma ? "YES" : "NO",
> -		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
> +		 "%s => Size: %llu B, DMA: %s, Time: %ptSp s, Rate: %llu KB/s\n",
> +		 op, size, dma ? "YES" : "NO", &ts, rate);
>  }
>  
>  static void pci_epf_test_copy(struct pci_epf_test *epf_test,
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்

