Return-Path: <linux-pci+bounces-37868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B87BD16EC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 07:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DFB3B351B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 05:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F25434BA34;
	Mon, 13 Oct 2025 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="MK1YpM8u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6F17597
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333012; cv=pass; b=lkwi8tiA9Zu5P7Poz2lqsJ7RvlA94YLbJ893R0sabU6izugqjWfuikrzCNoxl2wUHJOTWrzXorhnikVSw6wyRBaJkeb0qm9pafbmgmm+Pp9q2XyIotc+3y2RUsoTyzQyZ/AZCHMgQzQu//7KenzQIiKedfBfeSuTOKtLcptj/Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333012; c=relaxed/simple;
	bh=fK0kC+MJpwQh+2I4nZSkV/8b6cSnVbrSqAArg8QC2tY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=MMbKcIDy+hC0I9ZlFEextlVp+KuePFIu5P51ACV1sRiRImRqXp2AIC/trqWALB7hv2fawVSMhf6ZQSLDJzkcFqEvCx+Af06V9L299eVsatoo/iyYPThfGdbQFYwW0hlbs8RCWjufhNbIlWz0s/UfO+LgG/nZMDHKtv+2MHWjdY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=MK1YpM8u; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760332991; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=T0a1VJ97tS9rLBZqm5UShvFwdcTqh3p/u05fEBKzTa4pu2zkLlBKY6+y+ZG80ol53W
    D91dG521BMz+OJqLhGUMbxx0uLAeY8FDy+H4tyMRxlJ8Q0CZw0g2sJjQC+6vFVqKBAq6
    xXEGzAyewzeuWvOIHb++k7G0cuZZX16zg4V68jGC7TJ+boM9y4MqL/DC91So3gCPKgEy
    0n4W26eQ+MWUpuDN7hqksWEitopI/zPQrkOeL3fMZA8QKxjb4OkaDrsW0MXPeWP2m/OJ
    i7BHrUrsCinSZH2lW1wI0eYBeKNSm4t+OMY5nRWcG2p9RQh1OeU5u3FoG5Tul9NpSAra
    54yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760332991;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=39jo6iHhEeNQVQFqXrBMkJyiskAoFnE5eOk14VPginY=;
    b=BrdfKZ0FH4dzzOtlfIvRu0jctkhB5F/Bkj0N3bDRZcHqtYTglt9B9XCEp3JBo6URhJ
    HD5V4ZWYl0IRUpgWwp+YNXWAUtbaK86QYJmADdUKOLeIk0d+SHDNAfN263vPnRG3kCUj
    oz+jEQg3BUO33Cq8gYXhCM9F9b50oyM0TC2wa8D2Be8luYYGLvKMZW5Pif+ANS3nKNep
    DXahy3RNPCarfbwVI/DsH7w/mSu2JTvXAYtC1YY0drJRpUcF/vozEnL5VnAn5qFT5CNG
    V72VnGeqT69jOp2WKyt/6CoxTPXPiuaRosGssI3+EpJfECjec2R/40NSTqsKu7icqm/x
    SAHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760332991;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=39jo6iHhEeNQVQFqXrBMkJyiskAoFnE5eOk14VPginY=;
    b=MK1YpM8uXesh31A9HhikWQ5XvRFUpUi9Epkgk83Cb31tap6FMHf9rE+jptDvhYy0UB
    qfv5jEoV0iKmezpT+wJPrkOVXmLJQ3uz6voBpCiTq5WfnV7ESLQW0KpQnl2cv4ZCPJ+3
    z5tlECvOpfx+8oY9sfEi5YQ8+7WYgctqqLnWgB6gsuTLlTAVJxG7PYDl+FQJQqc36hNI
    txkcaa39iT6e1l9GtcY320X3qHJMRLfCYHdqiqYOlYtbbWfFZ/pb9XdeQwW12SwwIvvX
    zc9u8ZcBTNdhQeDjXTZGYtzBK5csBo4CuHNSutnyUicp4Ej3qEReIKUIk3oBugm0Ep/+
    tUgg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5mws3+VAS+pQfdGEfuOCOWETzj1zszWa107enM="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619D5NBKT6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Oct 2025 07:23:11 +0200 (CEST)
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
Date: Mon, 13 Oct 2025 07:23:00 +0200
Message-Id: <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
References: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org
In-Reply-To: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: iPhone Mail (23A355)



> On 13. October 2025 at 07:03 am, Christian Zigotzky <chzigotzky@xenosoft.d=
e> wrote:
>=20
> =EF=BB=BF
>=20
>> On 13 October 2025 at 06:47 am, Christian Zigotzky <chzigotzky@xenosoft.d=
e> wrote:
>>=20
>> =EF=BB=BF
>>>> On 11 October 2025 at 07:36 pm, Manivannan Sadhasivam <mani@kernel.org>=
 wrote:
>>>=20
>>> Hi Lukas,
>>>=20
>>> Thanks for looping me in. The referenced commit forcefully enables ASPM o=
n all
>>> DT platforms as we decided to bite the bullet finally.
>>>=20
>>> Looks like the device (0000:01:00.0) doesn't play nice with ASPM even th=
ough it
>>> advertises ASPM capability.
>>>=20
>>> Christian, could you please test the below change and see if it fixes th=
e issue?
>>>=20
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 214ed060ca1b..e006b0560b39 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_=
dev *dev)
>>> */
>>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_asp=
m_l0s_l1);
>>>=20
>>> +
>>> +static void quirk_disable_aspm_all(struct pci_dev *dev)
>>> +{
>>> +       pci_info(dev, "Disabling ASPM\n");
>>> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
>>> +}
>>> +
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_a=
ll);
>>> +
>>> /*
>>> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain=

>>> * Link bit cleared after starting the link retrain process to allow this=

>>>=20
>>>=20
>>> Going forward, we should be quirking the devices if they behave erratica=
lly.
>>>=20
>>> - Mani
>>>=20
>>> --
>>> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=
=AF=8D
>>=20
>> Hello Mani,
>>=20
>>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_al=
l);
>>=20
>> Is this only for my AMD Radeon HD6870?
>>=20
>> My AMD Radeon HD5870 is also affected.
>>=20
>> And I tested it with my AMD Radeon HD5870.
>>=20
>> What would the line be for all AMD graphics cards?
>>=20
>> Thanks,
>> Christian
>=20
> I see. 0x6738 is for the AMD Radeon HD 6800 series.
>=20
> It could be, that your patch works because I tested it with an AMD Radeon H=
D5870 instead of an AMD Radeon HD6870. Sorry
>=20
> This could be the correct line for the HD5870:
>=20
>>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6898, quirk_disable_aspm_al=
l);
>=20
> There are some more id numbers for the HD5870.
>=20
> Correct:
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..e006b0560b39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_de=
v *dev)
> */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_=
l0s_l1);
>=20
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all=
);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6898, quirk_disable_aspm_all)=
;
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6899, quirk_disable_aspm_all)=
;
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x689E, quirk_disable_aspm_all)=
;
> +
> /*
> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> * Link bit cleared after starting the link retrain process to allow this

Better for testing (All AMD graphics cards):

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..e006b0560b39 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *=
dev)
*/
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0=
s_l1);

+
+static void quirk_disable_aspm_all(struct pci_dev *dev)
+{
+       pci_info(dev, "Disabling ASPM\n");
+       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_disable_aspm_a=
ll);
+
/*
* Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
* Link bit cleared after starting the link retrain process to allow this=


