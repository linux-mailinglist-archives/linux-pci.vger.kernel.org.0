Return-Path: <linux-pci+bounces-40799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C9C49CB0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 00:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CF73AF2F4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9852F7471;
	Mon, 10 Nov 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U0xyIRec"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651F2F744B
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817881; cv=none; b=jrooRNJXEZhPKCyv3L/aMwaR3HSNUhjCx0jyCnIS+hxA0dICQppK63MkIrOSW3tVtsDjXP5ZzB62fnDySBf/ty7UUohRUnNPF/zR3z5LDS9dbZS1DRLN6ZftYWDOAZYG7QauKaSvcRccMvu7iDKEng3EXWThZVyc/mym1Il5+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817881; c=relaxed/simple;
	bh=odPTQHqCk/AknyMQCUhv0A0QcmH6YIldSa1T8WY4Ets=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5Dm7HBVl/VPuIEr2++Zpm4p0oVX6J28jN5/graHck8thrJe2Vw6GBbbF4YwKzuJiGaQmuSdruaSLfsdh548/iPcY9ZLL9ullisEtjVojYH+NVYilAxYrx6ZT7Ssun+F6Xuszar60uM/dPzr8ZAO4TVhhZ+5M+ktsglFzUIFiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U0xyIRec; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3eb5379f-c7ad-4aea-ab9a-20e07b7f34d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762817866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5NdZ3Il1D+l8lwQLcK5dXwNIadjasDY9t8ilnV/mV0=;
	b=U0xyIRecUBR+iYd+jFcmevJu/4H+A2bbNJnN96yfE0hlgn9ZMrH3LxAIKYqZS4s3cJ1uvm
	+7WK+gk43pd/VuQQ8rDReqm1AlKlWm8GBWmK3v11GgPPZIdbI1RU8LPuoyCqW5EbUBDj5d
	3Ou4TSlLX99wMRUdq/vNAC0vrqSI3Ow=
Date: Mon, 10 Nov 2025 23:37:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 19/23] ptp: ocp: Switch to use %ptSp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corey Minyard <corey@minyard.net>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Matthew Brost <matthew.brost@intel.com>, Hans Verkuil <hverkuil@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Calvin Owens <calvin@wbinvd.org>, Sagi Maimon <maimon.sagi@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Karan Tilak Kumar <kartilak@cisco.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
 Max Kellermann <max.kellermann@ionos.com>, Takashi Iwai <tiwai@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-staging@lists.linux.dev, ceph-devel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Satish Kharat <satishkh@cisco.com>,
 Sesidhar Baddela <sebaddel@cisco.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
 <20251110184727.666591-20-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251110184727.666591-20-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/2025 18:40, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> While at it, fix wrong use of %ptT against struct timespec64.
> It's kinda lucky that it worked just because the first member
> there 64-bit and it's of time64_t type. Now with %ptS it may
> be used correctly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index a5c363252986..a0bb8d3045d2 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3261,7 +3261,7 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
>   			   signal->duty, signal->phase, signal->polarity);
>   
>   	ts = ktime_to_timespec64(signal->start);
> -	count += sysfs_emit_at(buf, count, " %ptT TAI\n", &ts);
> +	count += sysfs_emit_at(buf, count, " %ptS TAI\n", &ts);
>   
>   	return count;
>   }
> @@ -4287,11 +4287,9 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
>   		ns += (s64)bp->utc_tai_offset * NSEC_PER_SEC;
>   		sys_ts = ns_to_timespec64(ns);
>   
> -		seq_printf(s, "%7s: %lld.%ld == %ptT TAI\n", "PHC",
> -			   ts.tv_sec, ts.tv_nsec, &ts);
> -		seq_printf(s, "%7s: %lld.%ld == %ptT UTC offset %d\n", "SYS",
> -			   sys_ts.tv_sec, sys_ts.tv_nsec, &sys_ts,
> -			   bp->utc_tai_offset);
> +		seq_printf(s, "%7s: %ptSp == %ptS TAI\n", "PHC", &ts, &ts);
> +		seq_printf(s, "%7s: %ptSp == %ptS UTC offset %d\n", "SYS",
> +			   &sys_ts, &sys_ts, bp->utc_tai_offset);
>   		seq_printf(s, "%7s: PHC:SYS offset: %lld  window: %lld\n", "",
>   			   timespec64_to_ns(&ts) - ns,
>   			   post_ns - pre_ns);
> @@ -4499,9 +4497,8 @@ ptp_ocp_phc_info(struct ptp_ocp *bp)
>   		 ptp_clock_index(bp->ptp));
>   
>   	if (!ptp_ocp_gettimex(&bp->ptp_info, &ts, NULL))
> -		dev_info(&bp->pdev->dev, "Time: %lld.%ld, %s\n",
> -			 ts.tv_sec, ts.tv_nsec,
> -			 bp->sync ? "in-sync" : "UNSYNCED");
> +		dev_info(&bp->pdev->dev, "Time: %ptSp, %s\n",
> +			 &ts, bp->sync ? "in-sync" : "UNSYNCED");
>   }
>   
>   static void

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

