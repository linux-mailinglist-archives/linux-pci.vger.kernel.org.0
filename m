Return-Path: <linux-pci+bounces-7479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9C8C61C7
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56706281779
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA543AD2;
	Wed, 15 May 2024 07:36:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783855661
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758569; cv=none; b=RMwUlrpg0A4ikHhvlbJ0DdXDf0rsRMAxK265gYMfGQZH1Eakjr+qENxE8nnoWJqSzKQZWRUDGiGGjnwECiS9RSY6kRE8xFLkKrMWWR4+XiQ/EhNbypXOWy5mzdm4/qorsU+ecj+7poZ8qk44u3sebefdad/HSwOuX5i1Bua3dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758569; c=relaxed/simple;
	bh=cm7FnOeWmDvgThbiyn5xQ+TyhEiH9yyYAfcQLfEplis=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=fISA0wcbw186cX5u1AhaGi1MUxd5p35dp51mU+BT2Qz6/naCdLBkLXyXayQs+kTSET4W7QzF2eifhHNhLb4iLwdQebDXaxQWMuTFbTOjrU9WUVTN4jAr2RPtmL6qxOIFODVQ9olVL0bFfLXRTiqEMdcsWbQNshCSmTgzu2HxRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44F7V6dO43831178, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44F7V6dO43831178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 15:31:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 15:31:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 15:31:05 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Wed, 15 May 2024 15:31:05 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Lukas Wunner <lukas@wunner.de>
CC: "scott@spiteful.org" <scott@spiteful.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Mika
 Westerberg" <mika.westerberg@linux.intel.com>
Subject: RE: [bug report] nvme not re-recognize when changed M.2 SSD in S3 mode
Thread-Topic: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Thread-Index: AdqKP+LQtoSsBN9ZRz2XBQWf3XU8AwAq/q8AAAon9QAC8Ap+oAPxATpw
Date: Wed, 15 May 2024 07:31:05 +0000
Message-ID: <7cd910060f3d4951ac0edd92910a55c2@realtek.com>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de> <ZhapFF3393xuIHwM@wunner.de> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Hi Lukas,

May I know the related patch has upstream schedule? =20
or this patch not go to kernel?

> Hi Lukas,
>=20
> I tested this patch and the result looks good, but if the two SSD has sam=
e VID,
> PID and capacity it still has problem.
> So I think add S/N to compare is necessary if it can do
>=20
> And I also tested SD7.0 card the result is same with M.2 SSD
>=20
> > > --- a/drivers/pci/hotplug/pciehp_core.c
> > > +++ b/drivers/pci/hotplug/pciehp_core.c
> > > @@ -152,6 +152,25 @@ static int get_adapter_status(struct
> > > hotplug_slot
> > *hotplug_slot, u8 *value)
> > >       return 0;
> > >  }
> > >
> > > +static bool pciehp_device_replaced(struct controller *ctrl) {
> > > +     struct pci_dev *pdev;
> >
> > I've realized this needs to be
> >
> > +       struct pci_dev *pdev __free(pci_dev_put);
> >
> > to avoid leaking a ref on the child device.  For testing purposes, the
> > patch should still be fine without this change, but I'll have to fix
> > this up if/when submitting a proper patch.
> >
> > > +     u32 reg;
> > > +
> > > +     pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(=
0,
> 0));
> > > +     if (!pdev)
> > > +             return true;
> > > +
> > > +     if (!pci_bus_read_dev_vendor_id(ctrl->pcie->port->subordinate,
> > > +                                     PCI_DEVFN(0, 0), &reg, 0))
> > > +             return true;
> > > +
> > > +     if (reg !=3D (pdev->vendor | (pdev->device << 16)))
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >  /**
> > >   * pciehp_check_presence() - synthesize event if presence has change=
d
> > >   * @ctrl: controller to check
> > > @@ -172,7 +191,8 @@ static void pciehp_check_presence(struct
> > > controller *ctrl)
> > >
> > >       occupied =3D pciehp_card_present_or_link_active(ctrl);
> > >       if ((occupied > 0 && (ctrl->state =3D=3D OFF_STATE ||
> > > -                       ctrl->state =3D=3D BLINKINGON_STATE)) ||
> > > +                           ctrl->state =3D=3D BLINKINGON_STATE ||
> > > +                           pciehp_device_replaced(ctrl))) ||
> > >           (!occupied && (ctrl->state =3D=3D ON_STATE ||
> > >                          ctrl->state =3D=3D BLINKINGOFF_STATE)))
> > >               pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

