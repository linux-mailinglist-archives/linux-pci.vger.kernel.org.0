Return-Path: <linux-pci+bounces-34711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA36B353CA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB581790DC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1202F3C2C;
	Tue, 26 Aug 2025 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diRSEvYx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABA2D3A80
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188412; cv=none; b=dEXI7fZOAmZHrdouWIZTPVfmFBFB4f/V8psG1dIQqsaTsnquSICTR6BhPeiVHX1TOn0EcpTa4vIy1sl71DXR+dzeqM10HJcGR/3Fxo+0Hj/bPFwrPV5fQaGGdjAfMcQIvpEVeDsP88QksbADhbBIS3P2JInOmuB252FZl3wBlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188412; c=relaxed/simple;
	bh=Xh3x3gGKDKpq037wNy+zR+uq9xiA+/wxHihatid3RG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDEXRoMAkaHBhtJcSeGNgtm3ZweqZLWkySBuFo1aK+/5YYwqmvLtbLQqeAhcnRwsaFr1xiwvPgKkgXEr9DFh1Xx99EcFkCmFZZxQBRnOjW7NckvMPu5qGvAuQL53gQt2WC7gYb/koPosMVhib7TjH/RJYb6Qkng+vTXGXaG8IiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=diRSEvYx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4bafe2e538so1909102a12.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756188410; x=1756793210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gmGkcUqKd7ltlehuxqJXBzOCmhH4pFIgOLfMRrjOKVc=;
        b=diRSEvYxSmcA9hkMtqrqJAte3OUwrxnA2h4Y5/wFLXh9b1WM5EMsDGGmxLDt0XilN+
         MwGQSZcDDTRltx3/kSqVyl6QgJbD4XObK+9r+rWCUei8BwRiBmxMvMuWohGH9kFjDWfA
         BWjB8fde8h0peaJYgmSxG1obaecCQvw9x/IacuuuPrjgkOC6gV5ezQClt7ydPNkqJb4G
         Ua95AGmXPHeeQGaXWlhNK5mq5Qls0h77LGOGRerGttnKeoD12Cd1HraLVt5QW+TlLob/
         W0YFt9GdFCsbUtjSRkCaBIj4qKa0zyxAlhzwXTXLLCzBEGtN7osIGrfM7iDIcixZcCBz
         ZNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188410; x=1756793210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmGkcUqKd7ltlehuxqJXBzOCmhH4pFIgOLfMRrjOKVc=;
        b=fRDfRJbevTcoCAkME2RcEAjo0ZnYK/sNKMCjEY8LbWCrMIJnfi2B/gbxFkJ/R78Qz6
         4YxgPfy31iNRsNiRLY9jCcanrCqs9lf/QKAcG8OTlAwYxfdritEIdJLCl94lL7/7Eh7+
         3KLhleEOyAk1KoVbbFIKQBDyb3RLhN68b2DaLfl51Mt6X1cUL+jtbOY55ue/VsSkfnKw
         lUjrNyfoZkGI9UJ36Ps9uT5hP2cnjtzTgWWc66NeZ3QWAyb/qtUJF7T9R5rG/klgn3FG
         g25adQiw3AD/6PMLVxvr0AulgDiSHOYgTBCri6fmlrLl677SF1oXmlMYctsCOjab7N5B
         Pntw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Fe18VPOUQc9HItPIi7LyiE1aLpik+wML4apHsmFJ9hXh68zWPqRXuQVdQ1B1Wy60AnROjqTDEd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2k1pQJEWb8mJHS2fIijpplUZYMq9q48JzJ8FQhyivm+v4HFw3
	4HFThsNfTIsJnAdLWWMt23rw8enTz557CBDWFPLjPsfOIfjCnj7KTrvfpww+rk1wWiw=
X-Gm-Gg: ASbGnctHc9T90oMSd8gUBUN9G8zKjK3bfg2pS7Sa+mp5sy+w0Kg9wtRYlCGM+K5DA2s
	Vryrb7yHFtyHbG2wuDpfY81Gp1TcUmcu2EzMAZDJbHE7RfKPMpPdnRAqC/3aOyPPLmovLusvsig
	1/uBE2yWzHyMJKW29Rxchwtz8r1a/kR14WupD/dzIdvnXubakBV21Ki/j/S4mcMxyZRrPdA5B5j
	8qj5eVn0i05YfKEtdtefBbKGQ5YwCoqxOuhT50NblpBypJ3AQHdZ/OWxHY8c5sKHfKh3ywy96A9
	tuUfBFdD/IeMFdQVrF9gAM68bJVgl/mjHaE0xK4EHC+VTmDcDDAEDkUb70374z0Isz8ss2cJLlw
	6o2Haes8vQQg/7rftlVdPz7L1
X-Google-Smtp-Source: AGHT+IE8TYjRI5h9GAJfzIIDlxGxwizCKVGf0+3bJMv0W5OvPkHRdmBovsnmHdZzK3GqLa6rbQdcsw==
X-Received: by 2002:a17:902:cccd:b0:246:4fd8:1983 with SMTP id d9443c01a7336-2464fd81ceemr160227745ad.17.1756188409894;
        Mon, 25 Aug 2025 23:06:49 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2487928c46dsm1071725ad.68.2025.08.25.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:06:49 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:36:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Message-ID: <20250826060647.7eerg5blx3xho27p@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
 <CGME20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c@eucas1p2.samsung.com>
 <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>

Marek,

Thanks for the detailed logs. I would need a little more help from
you.

Can you give this a try over your failing branch (I have already
dropped the patch from my tree for now):

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 81fb7dd7f323..5b24255733b5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
-                               *key = read(opp, index);
-
-                               /* Increment the reference count of OPP */
-                               dev_pm_opp_get(opp);
+                               if (!IS_ERR(opp)) {
+                                       *key = read(opp, index);
+                                       dev_pm_opp_get(opp);
+                               }
                                break;
                        }
                }

On 25-08-25, 15:59, Marek Szyprowski wrote:
> 1. Exynos4412-based Odroid-U3 board (ARM 32bit):
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.17.0-rc3-next-20250825 #10901 Not tainted
> --------------------------------------------
> kworker/u16:0/12 is trying to acquire lock:
> cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_notifier_call+0x30/0x124
> 
> but task is already holding lock:
> cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_monitor+0x1c/0x1a4
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&devfreq->lock);
>    lock(&devfreq->lock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 4 locks held by kworker/u16:0/12:
>   #0: c289d0b4 ((wq_completion)devfreq_wq){+.+.}-{0:0}, at: 
> process_one_work+0x1b0/0x70c
>   #1: f0899f18 
> ((work_completion)(&(&devfreq->work)->work)#2){+.+.}-{0:0}, at: 
> process_one_work+0x1dc/0x70c
>   #2: cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_monitor+0x1c/0x1a4
>   #3: c2e78c4c (&(&opp_table->head)->rwsem){++++}-{3:3}, at: 
> blocking_notifier_call_chain+0x28/0x60
> 
> stack backtrace:
> CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted 
> 6.17.0-rc3-next-20250825 #10901 PREEMPT
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: devfreq_wq devfreq_monitor
> Call trace:
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x68/0x88
>   dump_stack_lvl from print_deadlock_bug+0x370/0x380
>   print_deadlock_bug from __lock_acquire+0x1428/0x29ec
>   __lock_acquire from lock_acquire+0x134/0x388
>   lock_acquire from __mutex_lock+0xac/0x10c0
>   __mutex_lock from mutex_lock_nested+0x1c/0x24
>   mutex_lock_nested from devfreq_notifier_call+0x30/0x124
>   devfreq_notifier_call from notifier_call_chain+0x84/0x1d4
>   notifier_call_chain from blocking_notifier_call_chain+0x44/0x60
>   blocking_notifier_call_chain from _opp_kref_release+0x3c/0x5c
>   _opp_kref_release from exynos_bus_target+0x24/0x70
>   exynos_bus_target from devfreq_set_target+0x8c/0x2e8
>   devfreq_set_target from devfreq_update_target+0x9c/0xf8
>   devfreq_update_target from devfreq_monitor+0x28/0x1a4
>   devfreq_monitor from process_one_work+0x24c/0x70c
>   process_one_work from worker_thread+0x1b8/0x3bc
>   worker_thread from kthread+0x13c/0x264
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0899fb0 to 0xf0899ff8)

I guess there is some issue with devfreq here which showed up because
we tried to do a dev_pm_opp_get() for an invalid opp (which very well
could have been valid here anyway). This was always done with the OPP
table's lock anyway, nothing changed after the commit AFAICT.

> 2. Exynos5422-based Odroid-XU3 board (ARM 32bit):
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000000 when read
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 7 UID: 0 PID: 68 Comm: kworker/u34:1 Not tainted 
> 6.17.0-rc3-next-20250825 #10901 PREEMPT
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: devfreq_wq devfreq_monitor
> PC is at _opp_compare_key+0x30/0xb4
> LR is at 0xfffffffc
> pc : [<c09831c4>]    lr : [<fffffffc>]    psr: 20000013
> sp : f0a89de0  ip : cfb0e94c  fp : c1574880
> r10: c14095a4  r9 : f0a89e44  r8 : c2a9c010
> r7 : cfb0ea80  r6 : 00000001  r5 : cfb0e900  r4 : 00000001
> r3 : 00000000  r2 : cfb0e900  r1 : cfb0ea80  r0 : cfaf5800
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000406a  DAC: 00000051
> Register r0 information: slab kmalloc-1k start cfaf5800 pointer offset 0 
> size 1024
> Register r1 information: slab kmalloc-128 start cfb0ea80 pointer offset 
> 0 size 128
> Register r2 information: slab kmalloc-128 start cfb0e900 pointer offset 
> 0 size 128
> Register r3 information: NULL pointer
> Register r4 information: non-paged memory
> Register r5 information: slab kmalloc-128 start cfb0e900 pointer offset 
> 0 size 128
> Register r6 information: non-paged memory
> Register r7 information: slab kmalloc-128 start cfb0ea80 pointer offset 
> 0 size 128
> Register r8 information: slab kmalloc-1k start c2a9c000 pointer offset 
> 16 size 1024
> Register r9 information: 2-page vmalloc region starting at 0xf0a88000 
> allocated at kernel_clone+0x58/0x3c4
> Register r10 information: non-slab/vmalloc memory
> Register r11 information: non-slab/vmalloc memory
> Register r12 information: slab kmalloc-128 start cfb0e900 pointer offset 
> 76 size 128
> Process kworker/u34:1 (pid: 68, stack limit = 0x050eb3d7)
> Stack: (0xf0a89de0 to 0xf0a8a000)
> ..
> Call trace:
>   _opp_compare_key from _set_opp+0x78/0x50c
>   _set_opp from dev_pm_opp_set_rate+0x15c/0x21c
>   dev_pm_opp_set_rate from panfrost_devfreq_target+0x2c/0x3c
>   panfrost_devfreq_target from devfreq_set_target+0x8c/0x2e8
>   devfreq_set_target from devfreq_update_target+0x9c/0xf8
>   devfreq_update_target from devfreq_monitor+0x28/0x1a4
>   devfreq_monitor from process_one_work+0x24c/0x70c
>   process_one_work from worker_thread+0x1b8/0x3bc
>   worker_thread from kthread+0x13c/0x264
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0a89fb0 to 0xf0a89ff8)

I don't fully understand why this happened yet.

> ---[ end trace 0000000000000000 ]---
> 
> 
> 3. Qualcomm Technologies, Inc. Robotics RB5(ARM 64bit):
> 
> ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
> ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find 
> vdd-hba-supply regulator, assuming enabled
> ufshcd-qcom 1d84000.ufshc: Failed to find OPP for MIN frequency
> ufshcd-qcom 1d84000.ufshc: ufshcd_pltfrm_init: OPP parse failed -34
> ufshcd-qcom 1d84000.ufshc: error -ERANGE: ufshcd_pltfrm_init() failed
> ufshcd-qcom 1d84000.ufshc: probe with driver ufshcd-qcom failed with 
> error -34

This too.

-- 
viresh

