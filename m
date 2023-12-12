Return-Path: <linux-pci+bounces-787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035780E4BF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 08:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B0D1F22E11
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029115AF5;
	Tue, 12 Dec 2023 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fvdwpOB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CAFAB;
	Mon, 11 Dec 2023 23:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702365553; x=1733901553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FwL1bjl3La/z2hdLOLQSFIeckgQy3cBdqrBM5hz0Dlk=;
  b=fvdwpOB0tylEptlygvqcuJHQs/p7WCpHfuyadl662U6qFXiCsGWRdk9T
   rTbWZBMLYAjnmWNhqFkN9xnbuze9FUt1Fdb0z/CDjhvnStYI7MgQElqcD
   aPBaAReoK56C54qv4Fa4MfRltW8G2rCf1Cvb4IFj0pi5z1r/IkQqIqiP8
   Gy+llRuTefHGYzq89kdyxK3B1s77wVd/IMV5kNVHg/B6xsJB+UdRATRQb
   ZIyPZFtT3PKK82aeaHZ5ZpLTm7PXp1loosKMAIKTkcUpRQWNJqr3ayfRQ
   GlxUgh/hepf/PAxtc9Z0fPOHJLKZYQcee8+rVKJwJb+JGLgHYrth4fnja
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,269,1695679200"; 
   d="scan'208";a="34447107"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Dec 2023 08:19:10 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 55326280075;
	Tue, 12 Dec 2023 08:19:10 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: ssengar@linux.microsoft.com, decui@microsoft.com
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Date: Tue, 12 Dec 2023 08:19:11 +0100
Message-ID: <5736414.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
References: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Saurabh,

thanks for the patch.

Am Samstag, 9. Dezember 2023, 04:46:16 CET schrieb Saurabh Sengar:
> Currently there is a race in calling pci_create_resource_files function
> from two different therads, first therad is triggered by pci_sysfs_init
> from the late initcall where as the second thread is initiated by
> pci_bus_add_devices from the respective PCI drivers probe.
>=20
> The synchronization between these threads relies on the sysfs_initialized
> flag. However, in pci_sysfs_init, sysfs_initialized is set right before
> calling pci_create_resource_files which is wrong as it can create race
> condition with pci_bus_add_devices threads. Fix this by setting
> sysfs_initialized flag at the end of pci_sysfs_init and direecly call the

Small typo here: direecly -> directly

> pci_create_resource_files function from it.
>=20
> There can be an additional case where driver probe is so delayed that
> pci_bus_add_devices is called after the sysfs is created by pci_sysfs_ini=
t.
> In such cases, attempting to access already existing sysfs resources is
> unnecessary. Fix this by adding a check for sysfs attributes and return
> if they are already allocated.
>=20
> In both cases, the consequence will be the removal of sysfs resources that
> were appropriately allocated by pci_sysfs_init following the warning belo=
w.

I'm not sure if this is the way to go. Unfortunately I can't trigger this=20
error on my imx6 platform at the moment (apparently timing is off).
But reading [1] again, the most expressive way is that pci_bus_add_devices(=
)=20
needs to wait until pci_sysfs_init() has passed.

Best regards,
Alexander

[1] https://lore.kernel.org/lkml/a1cca367-52b6-a6b1-fb01-890cad39fd29@suse.=
com/

>=20
> [    3.376688] sysfs: cannot create duplicate filename
> '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/47505500-=
00
> 01-0000-3130-444531454238/pci0001:00/0001:00:00.0/resource0' [    3.38510=
3]
> CPU: 3 PID: 9 Comm: kworker/u8:0 Not tainted 5.15.0-1046-azure
> #53~20.04.1-Ubuntu [    3.389585] Hardware name: Microsoft Corporation
> Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018 [    3.394663]
> Workqueue: events_unbound async_run_entry_fn
> [    3.397687] Call Trace:
> [    3.399312]  <TASK>
> [    3.400780]  dump_stack_lvl+0x38/0x4d
> [    3.402998]  dump_stack+0x10/0x16
> [    3.406050]  sysfs_warn_dup.cold+0x17/0x2b
> [    3.408476]  sysfs_add_file_mode_ns+0x17b/0x190
> [    3.411072]  sysfs_create_bin_file+0x64/0x90
> [    3.413514]  pci_create_attr+0xc7/0x260
> [    3.415827]  pci_create_resource_files+0x6f/0x150
> [    3.418455]  pci_create_sysfs_dev_files+0x18/0x30
> [    3.421136]  pci_bus_add_device+0x30/0x70
> [    3.423512]  pci_bus_add_devices+0x31/0x70
> [    3.425958]  hv_pci_probe+0x4ce/0x640
> [    3.428106]  vmbus_probe+0x67/0x90
> [    3.430121]  really_probe.part.0+0xcb/0x380
> [    3.432516]  really_probe+0x40/0x80
> [    3.434581]  __driver_probe_device+0xe8/0x140
> [    3.437119]  driver_probe_device+0x23/0xb0
> [    3.439504]  __driver_attach_async_helper+0x31/0x90
> [    3.442296]  async_run_entry_fn+0x33/0x120
> [    3.444666]  process_one_work+0x225/0x3d0
> [    3.447043]  worker_thread+0x4d/0x3e0
> [    3.449233]  ? process_one_work+0x3d0/0x3d0
> [    3.451632]  kthread+0x12a/0x150
> [    3.453583]  ? set_kthread_struct+0x50/0x50
> [    3.456103]  ret_from_fork+0x22/0x30
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> There has been earlier attempts to fix this problem, below are the patches
> for reference of these attempts.
> 1.
> https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.stei=
n@
> ew.tq-group.com/T/#u 2.
> https://lwn.net/ml/linux-kernel/20230316091540.494366-1-alexander.stein@e=
w.
> tq-group.com/
>=20
> Bug details: https://bugzilla.kernel.org/show_bug.cgi?id=3D215515
>=20
>  drivers/pci/pci-sysfs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index f2909ae93f2f..a31f6f2cf309 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1230,6 +1230,10 @@ static int pci_create_resource_files(struct pci_dev
> *pdev) if (!pci_resource_len(pdev, i))
>  			continue;
>=20
> +		/* Check if resource already allocated and proceed no=20
further */
> +		if (pdev->res_attr[i] || pdev->res_attr_wc[i])
> +			return 0;
> +
>  		retval =3D pci_create_attr(pdev, i, 0);
>  		/* for prefetchable resources, create a WC mappable file=20
*/
>  		if (!retval && arch_can_pci_mmap_wc() &&
> @@ -1411,9 +1415,8 @@ static int __init pci_sysfs_init(void)
>  	struct pci_bus *pbus =3D NULL;
>  	int retval;
>=20
> -	sysfs_initialized =3D 1;
>  	for_each_pci_dev(pdev) {
> -		retval =3D pci_create_sysfs_dev_files(pdev);
> +		retval =3D pci_create_resource_files(pdev);
>  		if (retval) {
>  			pci_dev_put(pdev);
>  			return retval;
> @@ -1423,6 +1426,8 @@ static int __init pci_sysfs_init(void)
>  	while ((pbus =3D pci_find_next_bus(pbus)))
>  		pci_create_legacy_files(pbus);
>=20
> +	sysfs_initialized =3D 1;
> +
>  	return 0;
>  }
>  late_initcall(pci_sysfs_init);


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



