Return-Path: <linux-pci+bounces-17012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E19D072B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 01:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F13281EAF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696C42AB3;
	Mon, 18 Nov 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FRvxydlV"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic316-12.consmr.mail.bf2.yahoo.com (sonic316-12.consmr.mail.bf2.yahoo.com [74.6.130.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4A175BF
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888015; cv=none; b=taEb17CG2IxgeWoD27uEEjLLcVIkxICAOTlvP44/XkwpGfpx6aN/h73n/kmrqU1Wzx6lQSZM1TyZG3Jl6cnCKtrMzK9ZpL+ckDMo3tdjiXwiCPk7HSOZmDSbt6ZB4Uu8iOdDLsjPevtsOJwtVHlrQI2AzMZqRWfpvUDDiJ1NDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888015; c=relaxed/simple;
	bh=YUce759kQ7h05bVUbjxEdZsIcSJvZgYa1EEcx85iesg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMkxXZgzdozuLZ7xyeb4cfeKDoNk88dfIAlh6YS2AGzWzo4Ty6t8UTs9tAN1bdNUISMF1EKD/RIiJzi0Eu0TbMOJh20fvkG757aeSu2Km9t85+MIiMg7q5ULvdJDxtQwEL4G+EwgNzdD33Xj5Yjrxw1VQ5GqCvjDbhz8m8yVpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FRvxydlV; arc=none smtp.client-ip=74.6.130.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731888013; bh=sRhtt7tAu+00jSTS4pSlYyOtlC3u9JS4ZajQtj5R2sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FRvxydlVb9DnHyEB0Qd/+Jdbm0txBdhQGXsrLlDLRK934aF5HsgdrG9p5Hh/GxMw5Yo9xlnyoS0IEHTeu8JDsRpa0eg1BK2T9cvd8JrVMnM31a/DYYVKTaahOw9TjRziqTLBtpPCkIZ4Rsdkve22qSlSHmPTRLZBLHKte/1UkUJoad1vRDRLo3T2nmEC2SPfEoC/ar0ZxDIVosPX/smOrb5LdsN0WeOf9atLEXHtfDvxCbO2MpgA32BzFpEP7s4UImM4XX+8S7dMSh7sEMaydLfGNkehiFEAg/iOtTdzqBxdFzuI9M/JSwqItn4yu3HvlG/P904NUnpKdPIjxiI+Dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731888013; bh=iNM8TD3D9nI+vG6p9brqNjwdvCAZkAvV/d2rGhw2bgd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=leEdwhLTqtnh0XSGeF5pBxCSb9jTB7lfEgZRPSvYqvxiNVJjsY3vIOUIwJBXEaRGSxgI4AYy0DOoFlzdnbixpzzREWwmbIMyHthkDxgrsF2aZ81Znqx0cjhv4JgMJMYWKvPhUvBExLsunOAcUBj/gcyxPs3mj53POAAFT6W+eI6VzdUP5JkkbNmHu+nrfPnZF0cejZ2G+Mt1d3itRRObMGMHlJd3qJC+lUgPPNiEXBUJt6FWP666iPOL9+BZ1MxbmcNUAOCqdGGpQ5bfqr1OoPCQHoVhSNJ4zTjhFk4d2VEQ5QyPr8uth1WIr0mTNtD9z7DgOD3gwccusFwzPJw+qQ==
X-YMail-OSG: S28iDfEVM1noTl7odYQW8JPO9sf.F5u2nsp1airlMe9S31uaNGAvXgAoPzFtXl2
 9oreKtx2ZNdofskNJIu0WZljQNYwzhygrkTHY5g8DJZsyKtGo2raK96QhLbzl5VB28hNq0UM5jx8
 lv2HRD8Z3osIA.8BuJxQcA9QGmfk0CuOF5v3aUJ2OcsuRTX7iRMyTdYIkeymh57FChaJmuZwgiaz
 0f6_mt9q88AKc7VsTGeP_XW7kqDJGozfxHARHvfoUExqntQLN0bazkeVlovBDEBB_UxVtWz2Q5hR
 0MJTeSgFtqmEVkuMqp.5tjTU2SBaQKsWFTJ65td9Uw7vchjijpWk6fBlxFNrg8i3tsyGz9fclVBx
 3fmaCiSw5KbO5nGsEJks7e0l.Qr4i85KlAMMNY8HPHzKaRhMdbRsdWGanmjyq4DuxGXGtgX4tZmj
 WGv1_9IFEdLBFqBGj3rVlLfpY.eanMlhO797o7gmt4f.IuNiIvcnxbP2ZWGWG0YOZRtQPC9eLE5k
 aJuXjk6d3X6IijGIgU9sgAfSciL44AKmmLdeXX1UHO7c8QBNfBDmbXKlDyDfjQFqxtUp2ibH3HBR
 Z4qJcfOXj.e81R9GepBCF2nWR8Gxdn6xW3jEfdwjUF3ZNEl1O8QsZU1TZuDQODO0HWXkvYw5fBTb
 4cvN1wUwMfDYZRx4rdYb0d9IvrA9D3d21HELuFyzj3EDyPLXZO14Rxi.B4NQAhW1Nt4wX6A6J6k3
 0ilK3uxcLgxQl8iMh0DqHhrAukgYo4hqzP5efJr9yHfhu3xTCpOQweWx1i4yCB2Uu0vqlmqjXZi4
 5cWExHRl0sNKpdfYBAct151Yd0n7Pj7CMYw8EBpRMpzLdePq2ZcW6uo6UZOr2C6oR30.4lvO17vm
 eiJKGVoyTJBYHfRatc3ZMgw837N901d0mE1pgcEq0.4h2rK9.i9MAK78WSkVQkJyqBLFWyDAsp14
 zG8y.QsjShfTfGUHRXXoCn0N6U1Cw90sLwns.y4HBfoR3MClQE28TzfQT0a9D6mql2sE0wfsK6m7
 nABNdMInrALemE.1uVi1cFpZps6ERtwfZex7PmUH98bTOxwSGp8jntiZNNvOQpjFPcnSEZz97PrQ
 MFTcLoOQsRosjb9YSLTYmvKhwdEWzIWDUOaxRuPAmbtea883Ym17fFiwxNVQt.iVHv4TWgnOXLNI
 XMfz9tR8zuyuZ8j7Y_QlgL3buZz1jkDuUyeqSDDUtJvRmPblofwgVh5_A.eI8p1YAFRJDp1C9Jn0
 m1eS4JP_tvo.9fxMPb.Cv0rdkemmIE1EDaFTHKztmNRPa093hlvaVGGyzjEfHXm5T0WJ3rdH0xFq
 IhtcpSH0Gki3jtNstYV_fRoSp9fCUinBgMVbW5oeMA3RU4blhIXpqSrasNXyLfiGycoycoKSeQXn
 1rj8_gHDr1MPo3yP9vE4gIlj3CeS6rjJFyc.xflvEMqcb8rQ7GDV4.1T8rbiVCjMJEPDioBU0aoW
 xB9WQEUzkvHowvEfeVPjpWdLFMg26pYgEKcFOCQ4N.zwqtnuRMK22sTaf.8mAxLahnsUSJ7YNIW9
 Zqv9aBFPxiQBXeMZAILz94g5WYD_OcrgSmhxohUvYlvSfCWSdl7d07YRG70CVujSn9h434ztDjpN
 qzPIMkMsZsI33vZv2mnXEsfzleQm3xH.L3I5vJ.WlLeMhIF3qnIQMytOCNKk3QUPvEBEW0TJvSq1
 ZiIjZy_iz2YKAxfaEaQdRbfqdikczKpfSr7IGJTGJW6zStGnW0r_jitPVkpTEkaOjjG_A8ngAQix
 7KWViNCkjTiZuZzFyZ6KC_3gR3FfoTEUyfkGLlUgNXJ.OHxn4QdWqS.TT6uSqc0YYEIC70RcUVSt
 EleH3VWBJ4m6eIIuB8sRtrkYjzK3a15Dwkf95yRZAGwQO7lrcQHGjnNtbp_ARLB3Usp5_9gd0VmN
 1rUq_MlwV2m3.dl_wdsuKz76IMGZmlJROtSKrFw3eJcJviun1EIPh0gvUb.WSey.W4MKDHgDYnDG
 mZC0AIx0.vS6_c5LaZfuBTgbjVs2T2QZ8EuD6M255ovBVxKFJFIG7bFPEkpGWdCc9F1EAMoxKO3a
 voaFOv3amheJ9SPlp4oVcAL0VsZXRGeStRabj_tOOq.OnmN66NgA.iYQoYJj70bwiwtnnq912SSB
 XdH7kZ0HrmNz2V4GLvyEm0jNIKAVoOoZirS_MVWB896H1WqY9yLdJUkJ_1o73VEIf4VmyUxJ86Fb
 Na5SOQDQIkhj5DHSgwGTV5R967U4dzs.dTUPuj3XIfsGx8fYGU8Ie6d3XbuSu0CNedazwqlzDaov
 cC.aNhpdN
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: fdd3bdbc-4c3b-4a06-a8ff-2ca1c6d1e07c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 18 Nov 2024 00:00:13 +0000
Received: by hermes--production-ne1-bfc75c9cd-n46s2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c49c6779fa1a016527bc8d82f3fd465e;
          Sun, 17 Nov 2024 23:50:01 +0000 (UTC)
From: dullfire@yahoo.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Marc Zyngier <maz@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Jonathan Currier <dullfire@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] net/niu: niu requires MSIX ENTRY_DATA fields touch before entry reads
Date: Sun, 17 Nov 2024 17:48:43 -0600
Message-ID: <20241117234843.19236-3-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117234843.19236-1-dullfire@yahoo.com>
References: <20241117234843.19236-1-dullfire@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Currier <dullfire@yahoo.com>

Fix niu_try_msix() to not cause a fatal trap on sparc systems.

Set PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST on the struct pci_dev to
work around a bug in the hardware or firmware.

For each vector entry in the msix table, niu chips will cause a fatal
trap if any registers in that entry are read before that entries'
ENTRY_DATA register is written to. Testing indicates writes to other
registers are not sufficient to prevent the fatal trap, however the value
does not appear to matter. This only needs to happen once after power up,
so simply rebooting into a kernel lacking this fix will NOT cause the
trap.

NON-RESUMABLE ERROR: Reporting on cpu 64
NON-RESUMABLE ERROR: TPC [0x00000000005f6900] <msix_prepare_msi_desc+0x90/0xa0>
NON-RESUMABLE ERROR: RAW [4010000000000016:00000e37f93e32ff:0000000202000080:ffffffffffffffff
NON-RESUMABLE ERROR:      0000000800000000:0000000000000000:0000000000000000:0000000000000000]
NON-RESUMABLE ERROR: handle [0x4010000000000016] stick [0x00000e37f93e32ff]
NON-RESUMABLE ERROR: type [precise nonresumable]
NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
NON-RESUMABLE ERROR: insn effective address [0x000000c50020000c]
NON-RESUMABLE ERROR: size [0x8]
NON-RESUMABLE ERROR: asi [0x00]
CPU: 64 UID: 0 PID: 745 Comm: kworker/64:1 Not tainted 6.11.5 #63
Workqueue: events work_for_cpu_fn
TSTATE: 0000000011001602 TPC: 00000000005f6900 TNPC: 00000000005f6904 Y: 00000000    Not tainted
TPC: <msix_prepare_msi_desc+0x90/0xa0>
g0: 00000000000002e9 g1: 000000000000000c g2: 000000c50020000c g3: 0000000000000100
g4: ffff8000470307c0 g5: ffff800fec5be000 g6: ffff800047a08000 g7: 0000000000000000
o0: ffff800014feb000 o1: ffff800047a0b620 o2: 0000000000000011 o3: ffff800047a0b620
o4: 0000000000000080 o5: 0000000000000011 sp: ffff800047a0ad51 ret_pc: 00000000005f7128
RPC: <__pci_enable_msix_range+0x3cc/0x460>
l0: 000000000000000d l1: 000000000000c01f l2: ffff800014feb0a8 l3: 0000000000000020
l4: 000000000000c000 l5: 0000000000000001 l6: 0000000020000000 l7: ffff800047a0b734
i0: ffff800014feb000 i1: ffff800047a0b730 i2: 0000000000000001 i3: 000000000000000d
i4: 0000000000000000 i5: 0000000000000000 i6: ffff800047a0ae81 i7: 00000000101888b0
I7: <niu_try_msix.constprop.0+0xc0/0x130 [niu]>
Call Trace:
[<00000000101888b0>] niu_try_msix.constprop.0+0xc0/0x130 [niu]
[<000000001018f840>] niu_get_invariants+0x183c/0x207c [niu]
[<00000000101902fc>] niu_pci_init_one+0x27c/0x2fc [niu]
[<00000000005ef3e4>] local_pci_probe+0x28/0x74
[<0000000000469240>] work_for_cpu_fn+0x8/0x1c
[<000000000046b008>] process_scheduled_works+0x144/0x210
[<000000000046b518>] worker_thread+0x13c/0x1c0
[<00000000004710e0>] kthread+0xb8/0xc8
[<00000000004060c8>] ret_from_fork+0x1c/0x2c
[<0000000000000000>] 0x0
Kernel panic - not syncing: Non-resumable error.

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/net/ethernet/sun/niu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 41a27ae58ced..f5449b73b9a7 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9058,6 +9058,8 @@ static void niu_try_msix(struct niu *np, u8 *ldg_num_map)
 		msi_vec[i].entry = i;
 	}
 
+	pdev->dev_flags |= PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST;
+
 	num_irqs = pci_enable_msix_range(pdev, msi_vec, 1, num_irqs);
 	if (num_irqs < 0) {
 		np->flags &= ~NIU_FLAGS_MSIX;
-- 
2.45.2


