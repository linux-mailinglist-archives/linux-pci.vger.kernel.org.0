Return-Path: <linux-pci+bounces-34663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E7B342B4
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A335F1B22800
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717C2F39C3;
	Mon, 25 Aug 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H/QoveyH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33212F39B7
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130384; cv=none; b=Z43aHnIsJNyrcIAsr+Ju64rNRPUYxIgIRG+HnonTRSy29Isqkvr7c5NT4CiVdo3BVkBvKIpVGMcnJznCRVLrWGkoGBtv578bUvAaNA2/RfxlCQuE8tubeAR4vIP+EXvAji4I++8tXW06v+yNX9idRZoel6LLoxy0x0IB8MJldXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130384; c=relaxed/simple;
	bh=v3Gi5YTVW/Cp+kTwx9Yt+qf7HZfn+UuKaA8V/d2uE4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=p45hVUJrbJaD0lGd9xnsajDdAvCQwnfRQOTg/W8mhsk8QBU8M0qvtJfuy1VpC0eqzvws/GMC0+c/+W+P6ZT/PLN3+OFIheoVouycyYW8cqxAXrIxhGc0pcuZEyyr70YK+smG82AWooE1TZdtOUcnoSXpuAquikQLhrnVFLMbWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H/QoveyH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250825135940euoutp029489ea72e669b36bd98b173017263859~fB0a8W1zj2466424664euoutp02N
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 13:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250825135940euoutp029489ea72e669b36bd98b173017263859~fB0a8W1zj2466424664euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756130380;
	bh=3cyM1i33QvECmO3VGKlA/wlGJx1DA9pp0W8lw/26QYE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=H/QoveyHvcQzgAot0x+iV8pueXg2ZF17RltiPR+t9D4LGAbmuTUpK/i5J4E4k2rEw
	 4kfZJa7nIgD93f+cROxKac2b6uv7VgEXVwaOUIgnLL/iW3Tx1P/csXm9SpPglW4QnL
	 TXqsmgkHfSM6bOpECYJwGnrLu0flq/wiDZOyyKDw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c~fB0ajcpg01631516315eucas1p2u;
	Mon, 25 Aug 2025 13:59:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250825135937eusmtip155667559731c29c009ae9b30c1a36298~fB0Y2twp60569705697eusmtip1V;
	Mon, 25 Aug 2025 13:59:37 +0000 (GMT)
Message-ID: <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
Date: Mon, 25 Aug 2025 15:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for
 readability in _opp_table_find_key()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Viresh
	Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Manivannan
	Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c
X-EPHeader: CA
X-CMS-RootMailID: 20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
	<20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
	<CGME20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c@eucas1p2.samsung.com>

On 20.08.2025 10:28, Krishna Chaitanya Chundru wrote:
> Refactor _opp_table_find_key() to improve readability by moving the
> reference count increment and key update inside the match condition block.
>
> Also make the 'assert' check mandatory instead of treating it as optional.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

This patch landed in today's linux-next (20250825) as commit 
b5323835f050 ("OPP: Reorganize _opp_table_find_key()"). In my tests I 
found that it causes regressions on my test boards. Reverting this 
change on top of linux-next fixes booting of all the affected boards.

Here are kernel logs with lockdep enabled:

1. Exynos4412-based Odroid-U3 board (ARM 32bit):

============================================
WARNING: possible recursive locking detected
6.17.0-rc3-next-20250825 #10901 Not tainted
--------------------------------------------
kworker/u16:0/12 is trying to acquire lock:
cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_notifier_call+0x30/0x124

but task is already holding lock:
cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_monitor+0x1c/0x1a4

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&devfreq->lock);
   lock(&devfreq->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

4 locks held by kworker/u16:0/12:
  #0: c289d0b4 ((wq_completion)devfreq_wq){+.+.}-{0:0}, at: 
process_one_work+0x1b0/0x70c
  #1: f0899f18 
((work_completion)(&(&devfreq->work)->work)#2){+.+.}-{0:0}, at: 
process_one_work+0x1dc/0x70c
  #2: cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_monitor+0x1c/0x1a4
  #3: c2e78c4c (&(&opp_table->head)->rwsem){++++}-{3:3}, at: 
blocking_notifier_call_chain+0x28/0x60

stack backtrace:
CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted 
6.17.0-rc3-next-20250825 #10901 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: devfreq_wq devfreq_monitor
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from print_deadlock_bug+0x370/0x380
  print_deadlock_bug from __lock_acquire+0x1428/0x29ec
  __lock_acquire from lock_acquire+0x134/0x388
  lock_acquire from __mutex_lock+0xac/0x10c0
  __mutex_lock from mutex_lock_nested+0x1c/0x24
  mutex_lock_nested from devfreq_notifier_call+0x30/0x124
  devfreq_notifier_call from notifier_call_chain+0x84/0x1d4
  notifier_call_chain from blocking_notifier_call_chain+0x44/0x60
  blocking_notifier_call_chain from _opp_kref_release+0x3c/0x5c
  _opp_kref_release from exynos_bus_target+0x24/0x70
  exynos_bus_target from devfreq_set_target+0x8c/0x2e8
  devfreq_set_target from devfreq_update_target+0x9c/0xf8
  devfreq_update_target from devfreq_monitor+0x28/0x1a4
  devfreq_monitor from process_one_work+0x24c/0x70c
  process_one_work from worker_thread+0x1b8/0x3bc
  worker_thread from kthread+0x13c/0x264
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0899fb0 to 0xf0899ff8)

...


2. Exynos5422-based Odroid-XU3 board (ARM 32bit):

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 
00000000 when read
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 7 UID: 0 PID: 68 Comm: kworker/u34:1 Not tainted 
6.17.0-rc3-next-20250825 #10901 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: devfreq_wq devfreq_monitor
PC is at _opp_compare_key+0x30/0xb4
LR is at 0xfffffffc
pc : [<c09831c4>]    lr : [<fffffffc>]    psr: 20000013
sp : f0a89de0  ip : cfb0e94c  fp : c1574880
r10: c14095a4  r9 : f0a89e44  r8 : c2a9c010
r7 : cfb0ea80  r6 : 00000001  r5 : cfb0e900  r4 : 00000001
r3 : 00000000  r2 : cfb0e900  r1 : cfb0ea80  r0 : cfaf5800
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
Register r0 information: slab kmalloc-1k start cfaf5800 pointer offset 0 
size 1024
Register r1 information: slab kmalloc-128 start cfb0ea80 pointer offset 
0 size 128
Register r2 information: slab kmalloc-128 start cfb0e900 pointer offset 
0 size 128
Register r3 information: NULL pointer
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-128 start cfb0e900 pointer offset 
0 size 128
Register r6 information: non-paged memory
Register r7 information: slab kmalloc-128 start cfb0ea80 pointer offset 
0 size 128
Register r8 information: slab kmalloc-1k start c2a9c000 pointer offset 
16 size 1024
Register r9 information: 2-page vmalloc region starting at 0xf0a88000 
allocated at kernel_clone+0x58/0x3c4
Register r10 information: non-slab/vmalloc memory
Register r11 information: non-slab/vmalloc memory
Register r12 information: slab kmalloc-128 start cfb0e900 pointer offset 
76 size 128
Process kworker/u34:1 (pid: 68, stack limit = 0x050eb3d7)
Stack: (0xf0a89de0 to 0xf0a8a000)
..
Call trace:
  _opp_compare_key from _set_opp+0x78/0x50c
  _set_opp from dev_pm_opp_set_rate+0x15c/0x21c
  dev_pm_opp_set_rate from panfrost_devfreq_target+0x2c/0x3c
  panfrost_devfreq_target from devfreq_set_target+0x8c/0x2e8
  devfreq_set_target from devfreq_update_target+0x9c/0xf8
  devfreq_update_target from devfreq_monitor+0x28/0x1a4
  devfreq_monitor from process_one_work+0x24c/0x70c
  process_one_work from worker_thread+0x1b8/0x3bc
  worker_thread from kthread+0x13c/0x264
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0a89fb0 to 0xf0a89ff8)
...
---[ end trace 0000000000000000 ]---


3. Qualcomm Technologies, Inc. Robotics RB5(ARM 64bit):

ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find 
vdd-hba-supply regulator, assuming enabled
ufshcd-qcom 1d84000.ufshc: Failed to find OPP for MIN frequency
ufshcd-qcom 1d84000.ufshc: ufshcd_pltfrm_init: OPP parse failed -34
ufshcd-qcom 1d84000.ufshc: error -ERANGE: ufshcd_pltfrm_init() failed
ufshcd-qcom 1d84000.ufshc: probe with driver ufshcd-qcom failed with 
error -34



> ---
>   drivers/opp/core.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index a36c3daac39cd0bdd2a1f7e9bad5b92f0c756153..bf49709b8c39271431772924daf0c003b45eec7f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -544,24 +544,22 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>   	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>   
>   	/* Assert that the requirement is met */
> -	if (assert && !assert(opp_table, index))
> +	if (!assert(opp_table, index))
>   		return ERR_PTR(-EINVAL);
>   
>   	guard(mutex)(&opp_table->lock);
>   
>   	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>   		if (temp_opp->available == available) {
> -			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
> +			if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
> +				/* Increment the reference count of OPP */
> +				*key = read(opp, index);
> +				dev_pm_opp_get(opp);
>   				break;
> +			}
>   		}
>   	}
>   
> -	/* Increment the reference count of OPP */
> -	if (!IS_ERR(opp)) {
> -		*key = read(opp, index);
> -		dev_pm_opp_get(opp);
> -	}
> -
>   	return opp;
>   }
>   
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


