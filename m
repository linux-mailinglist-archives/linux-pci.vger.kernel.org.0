Return-Path: <linux-pci+bounces-41206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4EDC5B474
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 05:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F110D3B1630
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 04:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D327FB26;
	Fri, 14 Nov 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcdvIvc3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S6ehArPl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99162797AC
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763093555; cv=none; b=rdAjW6kHovZ+eV0BBZCIOZwi23iscikXlgkqZpKndvVBLmxV6NuTZcqWs36BeuFr5ENmYVFc33Io3LtN5hXg+QY843fTGV7/nl6hvrg+dspwEUwztSmc+M4MzcN4YkIf5ODqAwTacOkNZ7ksA1/lzYwsBapnZ2EC3F/qRnThY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763093555; c=relaxed/simple;
	bh=vqxQ3dK7VdFS3PT/6Q6WjwlGkrU2MdtNuweZl3H6mBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By4DkUr9Ha15vK/WDpL6Y6YOKnp34+CnDbJu6iiUsly4xVit1yRR4pthvp7oA8CEg/Tl8Ti6mVQrbLohzowH1iDU+oChpCu+h+mwvxNNVT8hwXZ7k/AtMW5yXqXxl7cBmBNpnbyvqHOYBast+gMgvb9CX/qofX5ldN0v8CjMOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WcdvIvc3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S6ehArPl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMavDb1585454
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 04:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l9FUBbeUidxIV00pdQyQahKH
	PpoxkuEk9fyNczKyhZ4=; b=WcdvIvc3sMDYJHBly1X7GlPj50GGKCEK4vrDj8k0
	5eaZ80++Ws3b6M4a/w2eVgp5fBZPqpReXJ6xcZvCuGqlyHQVAUPNMJplXDtRkmjR
	y6847o+zGxT2XJUEtVt8QOs1dNpy77MXiVZuOJgYMs0BamIgUtjw2hTVBYrDWjPI
	ByZ746JdSL8Gv5MgaoTNMk2yzeUNW4jCf/D2j643Vd/vNt+46rBlvy+jz4Ihw0Z+
	fTd/SLbn6SPCPWVriGZp93nSNSFJRad1vxT6ksE51c5WW0OqhiOxjWbi0pFY79Eh
	201wVoknTjIeNpA4GWGoZTCf94s18YBclqS5YUrFYMV7Vg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9frs4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 04:12:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24383b680so727364485a.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763093552; x=1763698352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9FUBbeUidxIV00pdQyQahKHPpoxkuEk9fyNczKyhZ4=;
        b=S6ehArPlA6Y4Y2WhGL5tW8g9/P+SLUq8P/kEOUNHMBNtktCmPsFqnHMd7TRn04iPvO
         3UXvPPUHTZFrNRaz15CaNWcEokgpflDA4lHpPu+L9wZx06AZC8GrhZtLXNVTJk+CMbdu
         11zsB1uyN//YAxP5Y6B6mKG39c9o8KpIfLjHmkBiFb3K71khvkuwX4igh8z8to2voa3p
         zeYb6yua1xQrJTcS/hZVKWsHoARpHWPg+pAKO80q7A1M9sFReG2WhdDHevHZdxs/91T0
         ILNhpfgX4oj303aRnl5T51TBtUVEF1XALli3nQ25MOMx2STZunr5JokL0gQauX1zO4qz
         pY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763093552; x=1763698352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9FUBbeUidxIV00pdQyQahKHPpoxkuEk9fyNczKyhZ4=;
        b=cLlQBJQtzUhakL/lp1XRC8OSwCjf/xK9aCEK5I0cNpwyqlD/s/cxPH091xwAthe9I4
         j4xVG1zWu2vhUpCwVxMx6iEVplF2BIZKGn+eJDTHdJKMwTdd1QtCB+0EzyJ50oa8TP6K
         GopY1VOZL7a+eB0S7rl+QpqWCIcKPz+jhwOUN8b5PjzOvJOXFN4a6/wSZvi2/KgOUnwn
         SeNzpi0pYJB2Xw92unSECEwcezELBcx5gyqKA4shv/FxcwTHxsPqNJv2Kb+OxDqM2wcE
         KKCsGw1yNvlofsyTD7fmLic2RDY32nl0PuCG/aoVUMmMAbj9jtCg6dqvYNOo/pZQtdLD
         Ex/g==
X-Forwarded-Encrypted: i=1; AJvYcCVc19qQy6BsLYVzmmFR+vIVf554+htswMWm3rf+qg3dCZMTNjmFs4vp96dokWb3obSBfdoyN8NYgmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1pZzDP51krPGnN4MhPwpmkd9W7cfTuwM2G0SUbnPdjOZA7jn
	kaT/q81eiZ4G1OWUcgJDW7JSgoh60QnAHqvW8C2fqktrAYEPVcY9WRlkSRAI3Md3lEoCzKHzmxd
	6C7IiwBjlUYj4A4OX8M8qaTy0VQOhsfLcC5el3869lwpXgiaZgo4+o7+uIKDodQQ=
X-Gm-Gg: ASbGncsalVW3k/ibnkA4yC5plNmGA7rVTNds3g2padxrn8kyrb7FojZ4Ck5TnIqF4QJ
	duIi4e8udUsX8mXLVQ1Bp1FhfXABrZWdOARYIgBYd/s2UkvU5+KZDEodIROX9P5GzYc5kk0R7t3
	S38bCuvgJBjSppnSh/xDExiJo9af4p2ULDXW1uzlVgGivDP0mQe7Ensm7ZaPKg1fhlqgTOK49m9
	iU6mu7tFSo/B1htsDdVy8VHU9PYM86vVcJJX0m1eC3I2UAZ2+ifgG4WJvz3g3rTiSkx35Dc8lWF
	8gbioPEoS11E1o+lhHa8xo6b+EPTO8HZMlfpPj9au+rmqoCRCXHR1l37AH8n3QnWnK7zg0Tsc/G
	MrWIniw1ib7pl8mJuSHeP7tfwM8KiwcqAjAsJJPyRA4UYNNsf9MgnwNy8R5Hf8IvYq8vS8ILpN5
	TVhQgj9N2EnFYm
X-Received: by 2002:a05:620a:4628:b0:8b1:ed55:e4f1 with SMTP id af79cd13be357-8b2c3175d59mr235428285a.39.1763093551907;
        Thu, 13 Nov 2025 20:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRBRFxxiAD30mEJm55HBtKCBqJwVeb/nqEO1wa7PZ+U+vRFrL3SI4k/Rw4EJ92OxtkmKQ+nw==
X-Received: by 2002:a05:620a:4628:b0:8b1:ed55:e4f1 with SMTP id af79cd13be357-8b2c3175d59mr235424485a.39.1763093551352;
        Thu, 13 Nov 2025 20:12:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59580405a4esm784867e87.95.2025.11.13.20.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:12:30 -0800 (PST)
Date: Fri, 14 Nov 2025 06:12:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Sagi Maimon <maimon.sagi@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Max Kellermann <max.kellermann@ionos.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 06/21] drm/msm: Switch to use %ptSp
Message-ID: <ngzyqzrjg2msv6odahkirdipjizbpaecfscfgnic3su5fl6hs7@qgdb53svq64p>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-7-andriy.shevchenko@linux.intel.com>
X-Authority-Analysis: v=2.4 cv=SdD6t/Ru c=1 sm=1 tr=0 ts=6916ac30 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=JNz3O4sEs4oywJvo4n4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 0OE3VzlwuL_NcXL6LQhbSYZ_Y2voGMXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAyOSBTYWx0ZWRfX4t5hzVG3bCK7
 B/lZYFnniKj7LbSk9d38a00CKu0brKvzHUDlC9SnXNfOvgdtMxzA4/otfdBDR3cPxobO8fclvmo
 dm4jfJo+CVNstrWX+D7RZIXl9uL4l/vWD9ovsY0XiC2CVnnpEptX9/96aiT23j/RisJaV57xJEn
 feD+gIA84D13U1HZyoBm6pb1n1mAOjE57iZSpI43qEFbjDSLALksXnyXDFGi/aB5figzjL22N/S
 fuVV6kqPF6/6F0mz//lioYBtXnLtJWbAk/9XvReF2qri0IXBvzNoEGEQ1E/vlKW7ONc1foHYLck
 cl7PSWkpIvgWnbY8uNQ/VihNx4jkwY3KXc5HQ4DnQPJIb67bUlFdpXXPMSyYLfD27z8Ffmx1afL
 MU+gru2cn/tx71WHy/3U4/5TjvWKmg==
X-Proofpoint-ORIG-GUID: 0OE3VzlwuL_NcXL6LQhbSYZ_Y2voGMXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140029

On Thu, Nov 13, 2025 at 03:32:20PM +0100, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 3 +--
>  drivers/gpu/drm/msm/msm_gpu.c                     | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

