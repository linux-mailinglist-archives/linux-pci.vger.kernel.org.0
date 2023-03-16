Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1267D6BCA91
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCPJSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 05:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCPJS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 05:18:29 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A38166CC;
        Thu, 16 Mar 2023 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678958308; x=1710494308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KnU1CBs/9Ztt7Fl1w/j7u3PijUSa3M0QZ2a6XJXWpI=;
  b=RvryscsEsrsijPvtFaVVuFa8qMY3JuMGCb5hFN08/L1DFuqVDZAzoqkK
   hLifNzl5b8lZZPTZnLkG//C2j1128xG71z68DJQ498KBpUiK9NQdbtz4u
   zB9kML9D5lEBY54h7jw7UM7pD+WiG0yXBymDP38oP3ZSukmFy4N6ivi2Z
   l3SmJFTKrsVEgxB2BI/cP4ZY6U5B87tQ2VuIhKgaJz32+AN2PwXpcXksg
   XUYPims9OrHvFq6w7sz9cQPFaz85keCIisw8dqwGizOV68Rw8vSjrQGPf
   VgK5sl0k1hPUacU/7NwbLxFJ9TWFLk/nJihJ7a6KOBQ2wK3R/k/YwLld3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29730588"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 10:18:25 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 10:18:25 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 10:18:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678958305; x=1710494305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KnU1CBs/9Ztt7Fl1w/j7u3PijUSa3M0QZ2a6XJXWpI=;
  b=WMDyhLeUqPTsjF+GyGhvPzJMuO8aS63jAfZ7SPiroSTlmRVHL/U2LAw/
   g91B/tGZI2J1xhdp3riYI+BYxxOLTpjtbZZbFIpA3CZYFmavvsyJyzG2J
   iv1kLqb+ms5XmmD+am9TkzXjdid2Y44WbaTPeCG3BLi94kCDF0fqHomn4
   4x7F0XYT7QBiJBuGEP3mglkZtEDqNQgO6iMXGRA+ivgV53/27vk9U2yFS
   zdFDW8N+hrPaJgkaxcbU++hvBzLHquRbEk399UTIfVUOb6c04N0zPYliE
   RvtppFSyU7KZv4aJXnkPaSAOQKqwO64HrC2v5n8b90diW5g7TcsQBptM3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29730585"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 10:18:24 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id ADFC2280056;
        Thu, 16 Mar 2023 10:18:24 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 16 Mar 2023 10:18:22 +0100
Message-ID: <4335627.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

for some reason my additional info was missing. See below.

Am Donnerstag, 16. M=E4rz 2023, 10:15:40 CET schrieb Alexander Stein:
> From: Korneliusz Osmenda <korneliuszo@gmail.com>
>=20
> On Gateworks Ventana there is a number of PCI devices and:
>   - imx6_pcie_probe takes longer than start of late init
>   - pci_sysfs_init sets up flag sysfs_initialized
>   - pci_sysfs_init initializes already found devices
>   - imx6_pcie_probe tries to reinitialize device
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215515
>=20
> Signed-off-by: Korneliusz Osmenda <korneliuszo@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Changes in v2:
* Rebased to next-20230323
* checkpath.pl fixes

I'm hitting the same issue on TQMa6x+MBa6x. There is a race in
pci_sysfs_init late initcall and pci_bus_add_device due to regular PCIe
bus probing. Having some debug output 'sysfs_initialized' is set to 1
while pci_bus_add_devices is still adding PCIe devices.
Having this patch applied my PCIe device using several bridges is detected
fine.

My PCIe bus looks like thi (using this patch):
root@tqma6-common:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
02:01.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
02:02.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411
PCI Express Gigabit Ethernet Controller (rev 0c)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411
PCI Express Gigabit Ethernet Controller (rev 0c)

root@tqma6-common:~# lspci -t
=2D[0000:00]---00.0-[01-ff]----00.0-[02-04]--+-01.0-[03]----00.0
                                           \-02.0-[04]----00.0

Best regards,
Alexander

>  drivers/pci/pci-sysfs.c | 6 ++++++
>  include/linux/pci.h     | 2 ++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index dd0d9d9bc509..998e44716b6f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1497,6 +1497,9 @@ int __must_check pci_create_sysfs_dev_files(struct
> pci_dev *pdev) if (!sysfs_initialized)
>  		return -EACCES;
>=20
> +	if (atomic_cmpxchg(&pdev->sysfs_init_cnt, 0, 1) =3D=3D 1)
> +		return 0;		/* already added */
> +
>  	return pci_create_resource_files(pdev);
>  }
>=20
> @@ -1511,6 +1514,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pde=
v)
>  	if (!sysfs_initialized)
>  		return;
>=20
> +	if (atomic_cmpxchg(&pdev->sysfs_init_cnt, 1, 0) =3D=3D 0)
> +		return;		/* already removed */
> +
>  	pci_remove_resource_files(pdev);
>  }
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b50e5c79f7e3..024313a7a90a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -467,6 +467,8 @@ struct pci_dev {
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called=20
*/
>=20
> +	atomic_t	sysfs_init_cnt;	/* pci_create_sysfs_dev_files has been=20
called */
> +
>  	u32		saved_config_space[16]; /* Config space saved at=20
suspend time */
>  	struct hlist_head saved_cap_space;
>  	int		rom_attr_enabled;	/* Display of ROM attribute=20
enabled? */


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


