Return-Path: <linux-pci+bounces-41385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1DC63AFF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DF8D328D6C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027130DD13;
	Mon, 17 Nov 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="id4994FU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57821CC79
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377277; cv=none; b=NP5HVoVd0uNpTutqeD5WEd6xq8MFK2JQoPJA69wL1brWUzifsGOUd7Drv+S7TxEKtN/IOkYV8lFNf26Ls7Ibp3slC9hvT3SBw8ORzF18Rg/TmZaZdjvMfe8htnFrN9OEDryL++dRbrRC+IYmaeUYCbw7KhTGbhMNLDrXP/GjpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377277; c=relaxed/simple;
	bh=7DAQpoB3R+EJpl7MbBOx5A+ZlzdqP6pGt/EDi4xzIlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQWGGjt0utb/9eAcIDxy08JFGX/2X6WTvUUlRxruDZtyg9SZsGD6cAf8Gmy5PVSe8EG5yzYNpwHwMcvF8T6o5Pb3Dxn0CElXcbGY0YiZb5n/8irjJHEB7Sz7dx7gNn0fipVuAD8VJzeY+HFtILkWSV9HmcIEi5n2w3bwjpf999s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=id4994FU; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6420c0cf4abso296364d50.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 03:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763377274; x=1763982074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/RSfdrwfxNJQiZz80hQXf9twz6yOQXKrW5ZfA5HxaxE=;
        b=id4994FUPu51IRxHSspL9L3GiejmCAA8gq+5m8V5Qy/ts2ASYoQqTsF8SrZu1qJCqD
         GUQLU1kAdP494s0MaMxk3g+bRWbLLQ5BPI6XIxP0wC9S3V9humxsjMA8QeCi1B/LHm5w
         AXkpQrcUklRFpcssfQSH+obec9yFZUY19vuPSsAFftk2+3eEeuw6/DJGcfvHxXox61cA
         i/3/UzvFQ9JdBpOWPQhGbPX5FT90aWLV8Y+ch9DgbpdNXYBbMtOxJibX6lfYdgRopu1w
         tz3NewpHxpPpKQS3POc517AagIYVuMrvQtXQ5yFz/1WKQ5Nws47JvpRs7mMY5pTSnsWK
         jK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763377274; x=1763982074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RSfdrwfxNJQiZz80hQXf9twz6yOQXKrW5ZfA5HxaxE=;
        b=mpFCRs4dHzHZYdKg9lodZDquG/ZRtxwoCWIcd2Gngu0DbduqDQoRevEHMhsdWeFGu8
         YdLSe5eat0gVVujWLcG2B+VajBYti6whG2svPaxT62yG0O/3B3ST9+hTTqrbJcLFqFgU
         zNX9lhtcsgEQLpBFWgcIPwzKWDEKEzIwLKZ42e/U1p60+O4NqyATPqAcS1wh+t8LNQch
         BiBDXjApLyE6Vutpr66EfMzcq5rAQQuc2+7AtTmX8yAhgeXkMcjKciMPjkNDuO7B/Alp
         vIHM2Bqqi8X3swX5OsGyNU/oty6bAfaIMjxGMBF6xTQPFzy0Nc0vkyOLKLhKwClWXr2O
         j7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbJCKEMbgQvHpXpoYRd8bxOqXMlSRJEsx1XD3xOYjODj0JTAYLfSZNtBttBGqrPHh9uJgcF7zvuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxruEoZG+Wyo31yIOu23VOJB4NQ8/jW1+paG3qn6iJDgfj0n0HU
	WMx36Qi9LrZeQmTba99SRL6ERs+pVR1/fFvIbM+iG5X6wUIUryFlIi9NI6dJaXjFWR5T9vHheQ8
	qntlK8nat0i4rAZF+p1dN5zl2b3XSJPlRsXUsnFlW2w==
X-Gm-Gg: ASbGncvNYOKtecFw6u4W50fYgVSW1DR84vFF2RvXsjzNnKg65LyaN+ylD/ZWVAPm4LT
	fTsIp4OWZOULlDp9uzLi8wJNbVA5rgxrybiqjtSNLl0KbXiRE5VJ7MiWk30M7u1tfOWlYVGEotk
	Kb0rRs5ZOwtdmFGP9ef99YjJ4YbIHk4niih5FA1KsJPGlhIRgFhhseS8BFqblh0IVhp3mDkmspn
	wzKT1hJ1UxGjTepFe+aBZY07K/tUS385PdEL0ZQKRpstVEy3xdGx64dTARL1IIUqlbvGDIHTl2+
	fDWMKtA=
X-Google-Smtp-Source: AGHT+IEjvegoUIWfi8UaBD0jEKwHtT+y2Cbu5UHhJ+VHUPJu6okR0AoxTFiIq+cxtmlIxdFEnLzs3e2dtieQR/hKIVs=
X-Received: by 2002:a05:690e:d86:b0:642:84a:7ba4 with SMTP id
 956f58d0204a3-642084a7c6bmr1567493d50.85.1763377273901; Mon, 17 Nov 2025
 03:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com> <20251113150217.3030010-14-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251113150217.3030010-14-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Nov 2025 12:00:38 +0100
X-Gm-Features: AWmQ_bk2fwrMGKoLr3e8DW_NORum6cYwB-Ynf9Wgckyt3WUUk5QWFuYE7vXt0wM
Message-ID: <CAPDyKFotmQyHzBim-8nib-KVvQaQgA_ELbgdC_Q4Y95-GrvRSw@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] mmc: mmc_test: Switch to use %ptSp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Matthew Brost <matthew.brost@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Sagi Maimon <maimon.sagi@gmail.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Karan Tilak Kumar <kartilak@cisco.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Max Kellermann <max.kellermann@ionos.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-staging@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Gustavo Padovan <gustavo@padovan.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rodolfo Giometti <giometti@enneenne.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Stefan Haberland <sth@linux.ibm.com>, 
	Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 16:03, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_test.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index a74089df4547..01d1e62c2ce7 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -586,14 +586,11 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
>         rate = mmc_test_rate(tot, &ts);
>         iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
>
> -       pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
> -                        "%llu.%09u seconds (%u kB/s, %u KiB/s, "
> -                        "%u.%02u IOPS, sg_len %d)\n",
> -                        mmc_hostname(test->card->host), count, sectors, count,
> -                        sectors >> 1, (sectors & 1 ? ".5" : ""),
> -                        (u64)ts.tv_sec, (u32)ts.tv_nsec,
> -                        rate / 1000, rate / 1024, iops / 100, iops % 100,
> -                        test->area.sg_len);
> +       pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took %ptSp seconds (%u kB/s, %u KiB/s, %u.%02u IOPS, sg_len %d)\n",
> +               mmc_hostname(test->card->host), count, sectors, count,
> +               sectors >> 1, (sectors & 1 ? ".5" : ""), &ts,
> +               rate / 1000, rate / 1024, iops / 100, iops % 100,
> +               test->area.sg_len);
>
>         mmc_test_save_transfer_result(test, count, sectors, ts, rate, iops);
>  }
> @@ -3074,10 +3071,9 @@ static int mtf_test_show(struct seq_file *sf, void *data)
>                 seq_printf(sf, "Test %d: %d\n", gr->testcase + 1, gr->result);
>
>                 list_for_each_entry(tr, &gr->tr_lst, link) {
> -                       seq_printf(sf, "%u %d %llu.%09u %u %u.%02u\n",
> -                               tr->count, tr->sectors,
> -                               (u64)tr->ts.tv_sec, (u32)tr->ts.tv_nsec,
> -                               tr->rate, tr->iops / 100, tr->iops % 100);
> +                       seq_printf(sf, "%u %d %ptSp %u %u.%02u\n",
> +                                  tr->count, tr->sectors, &tr->ts, tr->rate,
> +                                  tr->iops / 100, tr->iops % 100);
>                 }
>         }
>
> --
> 2.50.1
>

