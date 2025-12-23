Return-Path: <linux-pci+bounces-43617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABCCDA6FA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 21:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F7130076B5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B92C0F83;
	Tue, 23 Dec 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEX8tN3J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A052877FC;
	Tue, 23 Dec 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766520016; cv=none; b=VCn6FsZ/VqJIPJJ2qw5fQjdIpi2lmRNR7bQWp2ej2xZ2uLoUETp6ad47d2rqDORJRGlLZZmp6zVY7VLppQF+4Gh9K4QRiwOBofYP4qzo2CfE9dl2bwoSB/xJahqql0rrsHalNjrT74xYM83ftSPbnq3s2S5mL24ubSqmwGNsQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766520016; c=relaxed/simple;
	bh=Xm9+LAJPK0xuTQS0mkCgzhy0hJCsTsSdHEC//fNpzIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dWoiKLmxEqTKrVC84/8zpJ14jPJ5b7kTEeHh9dx/bsv/DjIY4kk4Fp7duwti7vo44KAXd85AdyMM9sV0pDogmBnVf78ODqcCds6Odog8cByUPOldEoZsjQyHjS+Op/7zxwuQTcE1BWT+N0iKx3LSLzPFF43Kctnm/SJIUfTbfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEX8tN3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98639C113D0;
	Tue, 23 Dec 2025 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766520015;
	bh=Xm9+LAJPK0xuTQS0mkCgzhy0hJCsTsSdHEC//fNpzIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MEX8tN3JidtVh+i2BI4b9M40CxztQTDpb7JDxnaYajo7Y96n5IFqf7GS99YMGRRMw
	 lbbxYj7v12PscpIyNG8h/lI/FZi00BkJ8JPB5MuK95TBNogbBeGk1ZjgQFYizqvuGx
	 19NlpkigNDr2Aw5OXqZeutl5I0Og1H9vypAFiX+69+U0Pjh3NsaFkhlHJdVnl1xZz0
	 djXDkZD8P5SrOrm8lnV+8GGatQYrvnXSZN9nkbC6ddNzcmEjMO05fvmny59h3FPceN
	 hKyC8DCqTfDVZEvOK4zqD8z27EfsfzoUVKvc7iSuAG3pvQMosDWUcZ97JMpF0GzVHK
	 4+egx2XiQcaXg==
Date: Tue, 23 Dec 2025 14:00:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: liu.xuemei1@zte.com.cn
Cc: kishon@kernel.org, liu.song13@zte.com.cn, linux-pci@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: endpoint: Avoid creating sub-groups
 asynchronously
Message-ID: <20251223200014.GA4028559@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710143845409gLM6JdlwPhlHG9iX3F6jK@zte.com.cn>

On Thu, Jul 10, 2025 at 02:38:45PM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Liu Song <liu.song13@zte.com.cn>
>=20
> The asynchronous creation of sub-groups by a delayed work could lead to an
> null-pointer-dereference exception when the driver directory gets
> removed before the work completes.
>=20
> The crash can be easily reproduced with the following commands.
>=20
>  # mkdir test && rmdir test
>=20
> Fixes this by using configfs_add_default_group() which does not have the
> deadlock problem as configfs_register_group().

Above you say the problem is a null pointer dereference.  It's fairly
easy to see how delayed work is executed asynchronously and may race
with another thread and result in a null pointer dereference.

So I expected to read details here about the two threads that race and
how you removed the race by doing something synchronously instead of
asynchronously.  But here you mention a deadlock.  Can you elaborate
on how deadlock is relevant?

> Backtraces of the crash:
>  BUG: kernel NULL pointer dereference, address: 0000000000000088
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0
>  Oops: Oops: 0002 [#1] SMP NOPTI
>  CPU: 4 UID: 0 PID: 371 Comm: kworker/4:1 Kdump: loaded Tainted: G       =
     E       6.16.0-rc3 #2 PREEMPT(lazy)
>  Tainted: [E]=3DUNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Workqueue: events pci_epf_cfs_work
>  RIP: 0010:mutex_lock+0x1c/0x30
>  Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 =
00 53 48 89 fb 2e 2e 2e 31 c0 65 48 8b 15 5e 4c 29 02 31 c0 <f0> 48 0f b1 1=
3 75 06 5b e9 97 8a 00 00 48 89 df 5b eb b1 90 90 90
>  RSP: 0018:ff64babb4111fdf0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000088 RCX: 0000000000000000
>  RDX: ff2de9c80f5d3080 RSI: ffffffffb9e58559 RDI: 0000000000000088
>  RBP: ff2de9c8269df9c0 R08: 0000000000000040 R09: 0000000000000000
>  R10: ff64babb4111fdf0 R11: 00000000ffffffff R12: ff2de9c80f753e88
>  R13: ff2de9c80f753e00 R14: 0000000000000000 R15: ff2de9c80f753f98
>  FS:  0000000000000000(0000) GS:ff2de9d78069f000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000088 CR3: 0000000ac782c003 CR4: 0000000000773ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   configfs_register_group+0x3d/0x190
>   pci_epf_cfs_work+0x41/0x110
>   process_one_work+0x18f/0x350
>   worker_thread+0x25a/0x3a0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xfc/0x240
>   ? __pfx_kthread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x14f/0x180
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in: pci_epf_test(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_f=
ib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E=
) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_def=
rag_ipv6(E) nf_defrag_ipv4(E) rfkill(E) ip_set(E) nf_tables(E) intel_rapl_m=
sr(E) intel_rapl_common(E) intel_uncore_frequency_common(E) qrtr(E) isst_if=
_common(E) skx_edac_common(E) nfit(E) libnvdimm(E) sunrpc(E) kvm_intel(E) v=
fat(E) fat(E) kvm(E) irqbypass(E) rapl(E) iTCO_wdt(E) 8139too(E) intel_pmc_=
bxt(E) iTCO_vendor_support(E) 8139cp(E) virtio_gpu(E) mii(E) virtio_input(E=
) virtio_dma_buf(E) i2c_i801(E) pcspkr(E) lpc_ich(E) i2c_smbus(E) virtio_ba=
lloon(E) joydev(E) loop(E) dm_multipath(E) nfnetlink(E) vsock_loopback(E) v=
mw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E) zr=
am(E) lz4hc_compress(E) vmw_vmci(E) lz4_compress(E) xfs(E) polyval_clmulni(=
E) ghash_clmulni_intel(E) sha512_ssse3(E) sha1_ssse3(E) serio_raw(E) scsi_d=
h_rdac(E) scsi_dh_emc(E)=20
>  scsi_dh_alua(E) fuse(E)
>   qemu_fw_cfg(E)
>  Unloaded tainted modules: intel_uncore_frequency(E):1 i10nm_edac(E):1 in=
tel_cstate(E):1 intel_uncore(E):1 hv_vmbus(E):1
>  CR2: 0000000000000088
>  ---[ end trace 0000000000000000 ]---
>=20
> Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate=
 two EPCs with EPF")
> Signed-off-by: Liu Song <liu.song13@zte.com.cn>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci=
-ep-cfs.c
> index ef50c82e647f..43feb6139fa3 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -23,7 +23,6 @@ struct pci_epf_group {
>  	struct config_group group;
>  	struct config_group primary_epc_group;
>  	struct config_group secondary_epc_group;
> -	struct delayed_work cfs_work;
>  	struct pci_epf *epf;
>  	int index;
>  };
> @@ -103,7 +102,7 @@ static struct config_group
>  	secondary_epc_group =3D &epf_group->secondary_epc_group;
>  	config_group_init_type_name(secondary_epc_group, "secondary",
>  				    &pci_secondary_epc_type);
> -	configfs_register_group(&epf_group->group, secondary_epc_group);
> +	configfs_add_default_group(secondary_epc_group, &epf_group->group);
>=20
>  	return secondary_epc_group;
>  }
> @@ -166,7 +165,7 @@ static struct config_group
>=20
>  	config_group_init_type_name(primary_epc_group, "primary",
>  				    &pci_primary_epc_type);
> -	configfs_register_group(&epf_group->group, primary_epc_group);
> +	configfs_add_default_group(primary_epc_group, &epf_group->group);
>=20
>  	return primary_epc_group;
>  }
> @@ -570,15 +569,13 @@ static void pci_ep_cfs_add_type_group(struct pci_ep=
f_group *epf_group)
>  		return;
>  	}
>=20
> -	configfs_register_group(&epf_group->group, group);
> +	configfs_add_default_group(group, &epf_group->group);
>  }
>=20
> -static void pci_epf_cfs_work(struct work_struct *work)
> +static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
>  {
> -	struct pci_epf_group *epf_group;
>  	struct config_group *group;
>=20
> -	epf_group =3D container_of(work, struct pci_epf_group, cfs_work.work);
>  	group =3D pci_ep_cfs_add_primary_group(epf_group);
>  	if (IS_ERR(group)) {
>  		pr_err("failed to create 'primary' EPC interface\n");
> @@ -637,9 +634,7 @@ static struct config_group *pci_epf_make(struct confi=
g_group *group,
>=20
>  	kfree(epf_name);
>=20
> -	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
> -	queue_delayed_work(system_wq, &epf_group->cfs_work,
> -			   msecs_to_jiffies(1));
> +	pci_epf_cfs_add_sub_groups(epf_group);
>=20
>  	return &epf_group->group;
>=20
> --=20
> 2.27.0

