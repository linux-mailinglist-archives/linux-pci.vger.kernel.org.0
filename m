Return-Path: <linux-pci+bounces-38210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E39BDE76D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB62D4E1FB0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137B324B30;
	Wed, 15 Oct 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="i+gKJIIn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831C326D4B
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531264; cv=pass; b=sc4iPPQKemfToaOdXrCVoqkB4Z7jwAq1uBNMhMBPVT6bz7w9sv0wfB8h8ZDEEFiP9n5lWiCjkRQEDJAsFp7bwqtMwuisqZKH60f5I+FRgCk8OtUsswmlrAYHRcE4z5hFPQ94CWyrw+njjtg5bcy/9RrpH7biYlIuPNidK1bOBKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531264; c=relaxed/simple;
	bh=AxcEjiJk/nLRBRUs29IgChn2InSitRsumkXV7EWRkEo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QFnwQ1WMCqeTB8qRWKQeChURhvY66TAjCk73bwVbkUANpCH61T6w6sR4YjrhBH5SHyEyVulL7genCsZu9Sv2EMn0Sh9TxeRpu4pexRDpICwaOlpuVDSUwxdYgypLbbaVDWsU3RxVtxTrrXJqvM+qg1k4/ozdAmOuJYK3HKVpmQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=i+gKJIIn; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760531231; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HsaHGJnPBY5KeT2Q922JkuHmn32tGWgktfHa+mYVSaSQFtj21quZt+7p5K8vj3njz0
    30bToP7153RpL7Ju7kW/YZcGp5BohjMHqh9yUi8kcgu4RUolx6jaepJTlYKC4SZQ3GGI
    xIPkFz1NfRUjTrCi21CIveaecuTMVKFjHnvb+6RQnADj6d2f/NKmcxXQ4IENyXRPccsO
    CsPFRpd/K32IrcdwJ3nKOzLvCcNN8i1wpXYpKHXeWFYJTiDV6TZjH/GOmIFK4/LM7bZJ
    F7EiDf85kai7Zc5Irg9mqaUok1wZBcaaw022okWUbFGo2rZQbFNeFHlXjxq3WVu5Kohn
    DB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760531231;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=tnWL0EzTYcQKOAeh8uiCBudXcH8KwCu92OpKrg/ytAU=;
    b=LiY5ZwFMSXZzLr+uyjFA5B8O1xG1iA/Q4Xt9vxmx5G40ov3K4O8fGZKAis9DLE0WOA
    /4k/3TPNciISgKo3UhI406yCsnyn3QHwo6KhWDZOt22YWIvPvqN3d9Mxk8ZkfbU27uWG
    JqWQUaxe6AjSLbQMF0WQCOOor1Ld7/xjM/5p4Lzqj7F8tdmOqO/VY5/CWI0A25hAiKr6
    8zL+9G11vACP5GpSFyXdGod2zZdP65U83r4UT/tUyNPMeW4MzoAJWGjQqMuzr3aT8b2a
    uxWYMdd4oAygg9NIJJNp6QsoSP4q2BASVaDvMBu1+VWMTA9Bcae6/MuT9oiJclU7/4Uh
    0AvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760531231;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=tnWL0EzTYcQKOAeh8uiCBudXcH8KwCu92OpKrg/ytAU=;
    b=i+gKJIIn6Dd+1mdS/xOri0W5DpfltH1fY00wJ5XwslvsXPnW7EuzfRnjhdgMQ3T/rP
    sO67KvPzn378ozoWOX5nyYjIc93VYtqr2QPTStKw6bUbISc5RCDgGvcOyPPDHI2Ow8qn
    7iNPkahTYgG7tKm6ngLlMa3d0A/OpzDjXQxtsJST0B/Za6Q4063Bf1P927RKUFqAN9X/
    GHBlyto2f9LynUs6eiq/A/mc/WsJZwxlboTBgDc/PnvIUlwjA3CVw15DA+Xf82tPxsb8
    Ac5SMwk1/zaR4+ti69oAAu75I+a9jrFPbcNbzhvq9ZbBQLw1tSKGKe7KaPv34bBLJ/8a
    RUCA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qwsy/HXXax+ofCi2ru+NWolPb67sCbW3uT"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619FCRBXHg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 14:27:11 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Date: Wed, 15 Oct 2025 14:27:00 +0200
Message-Id: <EF4D5B4B-9A61-4CF8-A5CC-5F6A49E824C1@xenosoft.de>
References: <20251015135811.58b22331@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20251015135811.58b22331@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
X-Mailer: iPhone Mail (23A355)


> On 15 October 2025 at 01:58 pm, Herve Codina <herve.codina@bootlin.com> wr=
ote:
>=20
> =EF=BB=BFHi Christian,
>=20
>> On Wed, 15 Oct 2025 13:30:44 +0200
>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>=20
>> Hello Herve,
>>=20
>>>> On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>>>=20
>>> =EF=BB=BFHi All,
>>>=20
>>> I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable a=
ll
>>> ClockPM and ASPM states for devicetree platforms") =20
>>=20
>> Thanks for reporting.
>>=20
>>>=20
>>> Also tried the quirk proposed in this discussion (quirk_disable_aspm_all=
)
>>> an the quirk also fixes the timing issue. =20
>>=20
>> Where have you added quirk_disable_aspm_all?
>=20
> --- 8< ---
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..a3808ab6e92e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_de=
v *dev)
>  */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_=
l0s_l1);
>=20
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +/* LAN966x PCI board */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, quirk_disable_aspm_al=
l);
> +
> /*
>  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>  * Link bit cleared after starting the link retrain process to allow this
> --- 8< ---
>=20
> Best regards,
> Herv=C3=A9

It is the same patch, I use for my AMD Radeon cards.

In my point of view we have to add a lot of other devices.

But if the computer does not boot, will the average user know that there is a=
 problem with the power management and their graphics card?
I am unsure whether I can deliver the kernel to average users later on.

Thanks,
Christian=


