Return-Path: <linux-pci+bounces-38218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4735BDEA69
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAC3AD925
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D8321421;
	Wed, 15 Oct 2025 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="jquVtm2T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA92DE1E6
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533674; cv=pass; b=gYHv4mll/tW1LgBv6lZST/VGrtfYjWXE7Gvm5F8JbGap1kcv96fwOP8AunzM2Fx4MmI6bphmY9Te89asFVuCiKcunmIbLhwbVJL7anGWHJxIgPdj3rT1XfrpjWPRPpSLnJx2NClaND+0muIZO8A2iBstFKJ2NMN64R0t3ZC0BfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533674; c=relaxed/simple;
	bh=KSjQXcloVbIPZcMIOl6lnJVrP3ToONwUDyX6EzMHxYM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SFrykaxH//D7qEkzwm2Rmvzyle4AB+iWSE+RwgPAN6yF7bDdgLWq6fe5gWENDeEQpIABjtfbInI1qWNaLii/f4cIvp6VUDQ2O0Gs/w1dAuvtjwTVTH+OxHRg4OXdfOVT9XAGrT9KMB42K23Ie1oZoox8YGYEdmWdWg7eVDkjmdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=jquVtm2T; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760533642; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=D7bTacsp2v5ox8lZubln24gC6mbqnC5dd411lfdWl8dbb/rxq3ckiJd3CG4bWjzzUi
    1KyorWLBNpMuUR1GGOW775pe1mcJsbmGwvF32h8ZPR6xtuHz1aKPJRrG6IAvZ0RhRyAH
    xuHwSTivqip8Ivw4T/P2HnY2ijUGxCJN0xsp34Owo9JyuS9sGwfkBQGvCYbiMS1DlcPt
    ZbZdLFRqTtchVW1twik3lt1CQnUKN/5a2YQgUoKXpMV8kaJe+Cwp8ygS6vZ42nN1r0KZ
    MmXYYd6dkfVmb7ehtWc+9o88BiXIcih1tlslJfVanfs27Ts14uQJmIPJzO/O7Z92vFBu
    HGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760533642;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=v1C7tk4STIJuR6Ka/hKAWwPTTRpGtWDlQ5rgR26tzTM=;
    b=UPEtm///WRDt1tUUc0+GTr4+0Dk7oqDhP/89M6vPeD6jJk4D55n6W93PVYEUgCKsEa
    afxxpDVV1iZdP2AIJGs+UskzzrFvUGqs9oMqEUIWIznhFXfPB+JqI/097kpjI7M3l5i5
    jtUHEncKH+J2O4TeAEYmc9jHCok+r5oc9XMqjLn6KwswwutkM3ILzviVjgnoVOOUZi3I
    vRRE2Lt9glaZU854cole9PI1D1vBEiqdWr/u8YpJonNq2+08SH8ElKW6BFODmnYAJauT
    UtlwVAjPSD2bi5Krl4xiabwQzvSKEo+eqpH0r614B3U8dLAKIDPEPJ9tbB5DTKS/rmfO
    vhuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760533642;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=v1C7tk4STIJuR6Ka/hKAWwPTTRpGtWDlQ5rgR26tzTM=;
    b=jquVtm2T62hOL5WnOoH9g3vc+jmy9g60WGIQPO+JFzSIThDlv4oFA2tt3jFW0t/nwU
    j7wNPc8fjGsJ8OvAgif40eA4CcnZmm3qGzVSGCRmiShuo29IDVHM9RmrNOhRKWzzrs7V
    GpNKgzaPZRjeB/r+OagjeN9SsAK3NRS7UdlsvOvfadIOnMDQsLeqyl0TkQ64XAA6IxtE
    muKXScF/555XquaLlBWq8dkf61GnjQM2O/apJffB7hBybyHz9BsElolmLmXODllsROMl
    vVSIHyUE7zgdTcSA5zOJsNp78v0Mk+oRB5nIgJbU93WpzTqIxcXha4Z1S0d02km8PQUz
    Qdkg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qwsy/HXXax+ofCi2ru+NWolPb67sCbW3uT"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619FD7LXTK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 15:07:21 +0200 (CEST)
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
Date: Wed, 15 Oct 2025 15:07:09 +0200
Message-Id: <CA1ADCB8-17B8-4903-8E1E-6451B8944657@xenosoft.de>
References: <EF4D5B4B-9A61-4CF8-A5CC-5F6A49E824C1@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <EF4D5B4B-9A61-4CF8-A5CC-5F6A49E824C1@xenosoft.de>
To: Herve Codina <herve.codina@bootlin.com>
X-Mailer: iPhone Mail (23A355)


> Am 15 October 2025 um 02:27 pm, Christian Zigotzky <chzigotzky@xenosoft.de=
> wrote:
>=20
> =EF=BB=BF
>> On 15 October 2025 at 01:58 pm, Herve Codina <herve.codina@bootlin.com> w=
rote:
>>=20
>> =EF=BB=BFHi Christian,
>>=20
>>> On Wed, 15 Oct 2025 13:30:44 +0200
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>=20
>>> Hello Herve,
>>>=20
>>>>>> On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.co=
m> wrote:
>>>>>=20
>>>>> =EF=BB=BFHi All,
>>>>>=20
>>>>> I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable=
 all
>>>>> ClockPM and ASPM states for devicetree platforms") =20
>>>=20
>>> Thanks for reporting.
>>>=20
>>>>=20
>>>> Also tried the quirk proposed in this discussion (quirk_disable_aspm_al=
l)
>>>> an the quirk also fixes the timing issue. =20
>>>=20
>>> Where have you added quirk_disable_aspm_all?
>>=20
>> --- 8< ---
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 214ed060ca1b..a3808ab6e92e 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_d=
ev *dev)
>> */
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm=
_l0s_l1);
>>=20
>> +static void quirk_disable_aspm_all(struct pci_dev *dev)
>> +{
>> +       pci_info(dev, "Disabling ASPM\n");
>> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
>> +}
>> +
>> +/* LAN966x PCI board */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, quirk_disable_aspm_a=
ll);
>> +
>> /*
>> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>> * Link bit cleared after starting the link retrain process to allow this
>> --- 8< ---
>>=20
>> Best regards,
>> Herv=C3=A9
>=20
> It is the same patch, I use for my AMD Radeon cards.

I use

+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_disable_aspm_a=
ll);

in this patch.

>=20
> In my point of view we have to add a lot of other devices.
>=20
> But if the computer does not boot, will the average user know that there i=
s a problem with the power management and their graphics card?
> I am unsure whether I can deliver the kernel to average users later on.
>=20
> Thanks,
> Christian


