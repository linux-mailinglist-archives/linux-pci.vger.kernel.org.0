Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8746B1350
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 21:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCHUnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 15:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCHUnd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 15:43:33 -0500
X-Greylist: delayed 154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 12:43:31 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FC61A91;
        Wed,  8 Mar 2023 12:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678308027; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YgowSXrom5WwV7B45gWdMJRXFWlYKNpYf+Hy/KzgLFIN83eVySlMI1WMzD0zQGu2XS
    +1o/oNejqlsU1JD1zEkCJs0ht6YvADqTJCkHXoLGyoZbECxaMkM+kY4gsic4GKFycuKM
    aBktSirMTrQVPDqS/Xkat5IuzLdWCnLyGkD6LPNcX6oymDDcGcwePbdF0GJEGAAkt8YJ
    4gDRMANCqdOgRWIonR8ZCR2e4T4ZUZ7hDTaFw9pOfAhtNBhqo71ozpsq8n8VWselQdbI
    zpA3wpGiQRxiid1zV7TvqENswUJMyubTtOzVenf/oALNEVVKoAj8jei9SLbv6kPZGLlF
    8YxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678308027;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kjAQuB16QsfMqN5tZgipL/ufr1uTGkxUDACx/ckEBHU=;
    b=drSlIX9q6GXTEvegqdo4cu9SpYrD8ijArRv5d4tvZpt7PrvRoLXUOQS/EURRqHHOKA
    Zg2vuldP6D3ZL7TGZiw/4LYV+Yeyhz+H9n36GurZTAoje46chC62olz+/iMMkTOz82EN
    F6zo+100cS+FitSOhC0S5Tl0/r7GJj/1llUI+EczTHJK3bj+zB5M4cw0Kh64/fpLoZN5
    gZelke8H/9a2V3r/hxz+jdcSiB06zEVSumcgOMsYn9hVfOg+nxwNDZ7Mk1yvXwb1LS9I
    yj3YMYyRv4dqgb35SbrHbD71ZmQyTKBLFVGcB9AVd88TCeG14r+PBEJf5jyft204eMDb
    5nkw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678308027;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kjAQuB16QsfMqN5tZgipL/ufr1uTGkxUDACx/ckEBHU=;
    b=RNTDsmVOQXAgSvAhPChT7lUFOnt6QtBgu3hVN2POlkpmzKYBpcNwBKU3CJrbFrBzeW
    P8l5vhFUPoJPL4MXc17+w2iA1OAXNEJNRYsEzp3LZli1BIPDe0tITEt69nY2GVLsc2nh
    2/J88R9P0JR21pkpn3ePkyy1c7iLxVy6fooxrRwM+1eZmNuEAhul9cvRfmHS40zeXDBs
    4KIMr3XksobJsayxkhGZ9ue3MxLLcx5rxgJeNiY0sPRqwfbeRI6zN0OYsZbREjYkWQf1
    ce7KIFhIXWRHm/ZhjvyhsBU1S4dAMvjrxoUYWaldW1CIDQh28mT7LQK4nSVeSp94Vxq6
    /M0g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qviAxtjc3ymhuD5oSzMYuxMPoGwe4b9Z+4n4bTnzkNPvoI="
Received: from [IPv6:2001:9e8:a5f3:7900:ecb2:2fbf:174b:7809]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id 2faf7dz28KeQY4y
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 8 Mar 2023 21:40:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] PCI: imx6: install the fault handler only if we are
 really running on a compatible device
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230308184922.GA1029723@bhelgaas>
Date:   Wed, 8 Mar 2023 21:40:25 +0100
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C68A70F3-00C1-4F43-A7C4-8E0386410140@goldelico.com>
References: <20230308184922.GA1029723@bhelgaas>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> Am 08.03.2023 um 19:49 schrieb Bjorn Helgaas <helgaas@kernel.org>:
>=20
> On Tue, Feb 28, 2023 at 09:43:54AM +0100, H. Nikolaus Schaller wrote:
>> commit bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe =
controller")
>> added a fault hook to this driver in the probe function. So it was =
only
>> installed if needed.
>>=20
>> commit bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
>> moved it from probe to driver init which installs the hook =
unconditionally
>> as soon as the driver is compiled into a kernel.
>>=20
>> When this driver is compiled as a module, the hook is not registered
>> until after the driver has been matched with a .compatible and
>> loaded.
>>=20
>> commit 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
>> extended the fault handling code.
>>=20
>> commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
>> added some protection for non-ARM architectures, but this does not
>> protect non-i.MX ARM architectures.
>=20
> Are *all* these commits relevant?

Yes, it was correct when introduced by commit bb38919ec56e for a goo =
reason.
And it was broken by bde4a5a00e76 an all attempts later made it worse.

>  Question also applies to Fixes:
> below.

It fixes all between bde4a5a00e76 and HEAD. Well, one can argue that
commit bde4a5a00e76 could be sufficient for Fixes:

I don't know if it is a problem because I have no overview over =
side-effects.

>=20
>> Since fault handlers can be triggered on any architecture for =
different
>> reasons, there is no guarantee that they will be triggered only for =
the
>> assumed situation, leading to improper error handling (i.MX6-specific
>> imx6q_pcie_abort_handler) on foreign systems.
>>=20
>> I had seen strange L3 imprecise external abort messages several times =
on
>> OMAP4 and OMAP5 devices and couldn't make sense of them until I =
realized
>> they were related to this unused imx6q driver because I had
>> CONFIG_PCI_IMX6=3Dy.
>=20
> Apparently imx6q_pcie_abort_handler() assumes it is always called
> because of a PCI abort?  If so, that sounds problematic.

>=20
> If non-PCI imprecise aborts happen on OMAP4 and OMAP5 where imx6q is
> unused and imx6q_pcie_abort_handler() is not appropriate, I assume
> similar non-PCI aborts can also happen on systems where imx6q *is*
> used.

As far as I know the reasons why imprecise aborts occur may be SoC =
specific.

So I have no experience with i.MX6 to judge this. My goal is to shield =
other
architectures from this fault handler may it be correct or wrong.

> So imx6q_pcie_abort_handler() may be trying to fixup non-PCI aborts
> when it shouldn't?

Yes, at least if it is triggered on OMAP4/OMAP5 by accessing =
non-existing
registers in some subsystems (e.g. through devmem2).

>=20
>> Note that CONFIG_PCI_IMX6=3Dy is useful for kernel binaries that are =
designed
>> to run on different ARM SoC and be differentiated only by device tree
>> binaries. So turning off CONFIG_PCI_IMX6 is not a solution.
>>=20
>> Therefore we check the compatible in the init function before =
registering
>> the fault handler.
>>=20
>> Fixes: bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
>> Fixes: 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
>> Fixes: 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c =
b/drivers/pci/controller/dwc/pci-imx6.c
>> index 1dde5c579edc8..89774aa187ae8 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1402,6 +1402,15 @@ =
DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
>> static int __init imx6_pcie_init(void)
>> {
>> #ifdef CONFIG_ARM
>> +	const struct of_device_id *reboot_id;
>> +	struct device_node *np;
>> +
>> +	np =3D of_find_matching_node_and_match(NULL, imx6_pcie_of_match,
>> +					     &reboot_id);
>=20
> Since you don't need reboot_id, I think you should use
> of_find_matching_node() instead.

Well, I used it for debugging, but for production code it has indeed no =
benefit.

of_find_matching_node it is just a static inline wrapper for
of_find_matching_node_and_match with NULL parameter, but we can save one =
stack position.

I'll send a v2 soon.

>=20
>> +	if (!np)
>> +		return -ENODEV;
>> +	of_node_put(np);
>> +
>> 	/*
>> 	 * Since probe() can be deferred we need to make sure that
>> 	 * hook_fault_code is not called after __init memory is freed
>> --=20
>> 2.38.1
>>=20

BR and thanks,
Nikolaus

