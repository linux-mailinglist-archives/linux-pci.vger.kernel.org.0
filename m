Return-Path: <linux-pci+bounces-7830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999808CF4A0
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2024 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D3B281238
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A916419;
	Sun, 26 May 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cckBrXwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AD17C72;
	Sun, 26 May 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716734752; cv=none; b=K5SbZw8pyj2ri5ONlgiVPxEpYyiJ7sa6FnzpHcz9MUNtQp+xrYUljqnGOcLeAqgwY5SicjcKn/BxzHWVYJiKPy3G02B3KALXdJYfpDG3+C32ESXemDLb2ms6phpi9IN/ufx56MFvicO9RwISwLBhPnO6PsZP2TF1WwGbetuaxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716734752; c=relaxed/simple;
	bh=ZlQaGFLsWgK/IQ4mDeumheHUefmrW+eLzLuRalsap/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pC317MDPAmq8g1dc13t38jvvzKhsBugLqp3sMLjTpGPzOAOLTnkTj2MVD7ZxegSLShpjH2GYVlrft8+IvGQmmi9aujt3ZbdAH7Ja8jhUMJGTfl9p+4a0OIqQpai1Nb4YpG/RSs3hNKS1N/Q02wZSkuwSAYpav0KBraTp+rl7bWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cckBrXwF; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716734739; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=PXxPXglWm8XATSaQ0NFCFC3asxv7XPwSdYw6ZgYO648=;
	b=cckBrXwFAsScaszIBZ+LZtnSNtPZa8qlozDXt5/xeN97UOEZn5EF+84tfYUS82PLaSfdWSD69vt3CxwiQ8x8boaybZuktIhN0b8JR//kp5W2YsBVWCr9PSMhDDzW95kiyXu4lxQRMD/4SGU/LW2Z8N8ETPEF5LVdaEM+P//dRA8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7Bp-mL_1716734737;
Received: from smtpclient.apple(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W7Bp-mL_1716734737)
          by smtp.aliyun-inc.com;
          Sun, 26 May 2024 22:45:39 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
From: yaoma <yaoma@linux.alibaba.com>
In-Reply-To: <ZlBHjbmjjSEnXCMp@wunner.de>
Date: Sun, 26 May 2024 22:45:36 +0800
Cc: yaoma <yaoma@linux.alibaba.com>,
 bhelgaas@google.com,
 weirongguang@kylinos.cn,
 kanie@linux.alibaba.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7855600C-4BB6-417B-8F91-24F4F7E0820E@linux.alibaba.com>
References: <20240524063023.77148-1-yaoma@linux.alibaba.com>
 <ZlBHjbmjjSEnXCMp@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)

Hi,

> 2024=E5=B9=B45=E6=9C=8824=E6=97=A5 15:53=EF=BC=8CLukas Wunner =
<lukas@wunner.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, May 24, 2024 at 02:30:23PM +0800, Bitao Hu wrote:
>> The values of 'present' and 'link_active' have similar meanings:
>> the value is %1 if the status is ready, and %0 if it is not. If the
>> hotplug controller itself is not available, the value should be
>> %-ENODEV. However, both %1 and %-ENODEV are considered true, which
>> obviously does not meet expectations. 'Slot(xx): Card present' and
>> 'Slot(xx): Link Up' should only be output when the value is %1.
> [...]
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -276,10 +276,10 @@ void =
pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 =
events)
>> 	case OFF_STATE:
>> 		ctrl->state =3D POWERON_STATE;
>> 		mutex_unlock(&ctrl->state_lock);
>> -		if (present)
>> +		if (present > 0)
>> 			ctrl_info(ctrl, "Slot(%s): Card present\n",
>> 				  slot_name(ctrl));
>> -		if (link_active)
>> +		if (link_active > 0)
>> 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>> 				  slot_name(ctrl));
>> 		ctrl->request_result =3D pciehp_enable_slot(ctrl);
>=20
> We already handle the "<=3D 0" case immediately above this code =
excerpt:
>=20
> 	if (present <=3D 0 && link_active <=3D 0) {
> 	...
> 	}
I'm not sure if the following scenarios would occur in actual production =
environment,
but from the code level, there is the possibility of =E2=80=9Cpresent <=3D=
 0 && link_active > 0=E2=80=9D
or =E2=80=9Cpresent > 0 && link_active <=3D 0=E2=80=9D. In these cases, =
the =E2=80=9C<=3D 0=E2=80=9D conditions will
not be properly handled, and =E2=80=9Cctrl_info=E2=80=9D will output =
incorrect prompt messages.
> So neither "present" nor "link_active" can be < 0 at this point.
>=20
Best Regards,

	Bitao Hu=

