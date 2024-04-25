Return-Path: <linux-pci+bounces-6659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662F8B1AA0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 08:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AAC1C20F2B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9493CF4F;
	Thu, 25 Apr 2024 06:06:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C83C47C
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025159; cv=none; b=f60dVZjjU83Dv6Gi1TOJEANhreVtkJcinNSyS0XpJ4hk5pDC+99Fl6N9Zs09wQB0YkVS0ZQpjXJx4lG1DB88jSRxJPc4M58hdr1E+t7lFm7gdnIdTGXEYDSGgn4zBLR2apb3lCyKc/1qw1i9jKmu+3pLzYxYw0nS7W1U4onZRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025159; c=relaxed/simple;
	bh=bwjgRWm3Z5rMINIjUf7ueD3qe7IgAzoHbz5fYhib/L4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UXiqIR4K40WZPXLVYJOls85ZYL3xEmNOQ9NPk9KWElzffw9bZOwzdLR8cmbE2ENwVEXiRgpokZ2fFMtc9boiIdiHhMxFDcFzVmbiI+h3iZKiFG6V9BD0L5wkmYIHBsDgtcsVyODE0Qur8gL/XglNI6/x+P4eck/OONVxijmmPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43P62aHtA3240386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43P62aHtA3240386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:02:37 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:02:37 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:02:36 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Thu, 25 Apr 2024 14:02:36 +0800
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
Thread-Index: AdqKP+LQtoSsBN9ZRz2XBQWf3XU8AwAq/q8AAAon9QAC8Ap+oA==
Date: Thu, 25 Apr 2024 06:02:36 +0000
Message-ID: <8c3d00850e7449c184e4c45a3c9b9dfa@realtek.com>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de> <ZhapFF3393xuIHwM@wunner.de>
In-Reply-To: <ZhapFF3393xuIHwM@wunner.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback


Hi Lukas,

I tested this patch and the result looks good, but if the two SSD has same =
VID, PID and capacity it still has problem.
So I think add S/N to compare is necessary if it can do

And I also tested SD7.0 card the result is same with M.2 SSD

> > --- a/drivers/pci/hotplug/pciehp_core.c
> > +++ b/drivers/pci/hotplug/pciehp_core.c
> > @@ -152,6 +152,25 @@ static int get_adapter_status(struct hotplug_slot
> *hotplug_slot, u8 *value)
> >       return 0;
> >  }
> >
> > +static bool pciehp_device_replaced(struct controller *ctrl) {
> > +     struct pci_dev *pdev;
>=20
> I've realized this needs to be
>=20
> +       struct pci_dev *pdev __free(pci_dev_put);
>=20
> to avoid leaking a ref on the child device.  For testing purposes, the pa=
tch
> should still be fine without this change, but I'll have to fix this up if=
/when
> submitting a proper patch.
>=20
> > +     u32 reg;
> > +
> > +     pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0,=
 0));
> > +     if (!pdev)
> > +             return true;
> > +
> > +     if (!pci_bus_read_dev_vendor_id(ctrl->pcie->port->subordinate,
> > +                                     PCI_DEVFN(0, 0), &reg, 0))
> > +             return true;
> > +
> > +     if (reg !=3D (pdev->vendor | (pdev->device << 16)))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  /**
> >   * pciehp_check_presence() - synthesize event if presence has changed
> >   * @ctrl: controller to check
> > @@ -172,7 +191,8 @@ static void pciehp_check_presence(struct
> > controller *ctrl)
> >
> >       occupied =3D pciehp_card_present_or_link_active(ctrl);
> >       if ((occupied > 0 && (ctrl->state =3D=3D OFF_STATE ||
> > -                       ctrl->state =3D=3D BLINKINGON_STATE)) ||
> > +                           ctrl->state =3D=3D BLINKINGON_STATE ||
> > +                           pciehp_device_replaced(ctrl))) ||
> >           (!occupied && (ctrl->state =3D=3D ON_STATE ||
> >                          ctrl->state =3D=3D BLINKINGOFF_STATE)))
> >               pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

