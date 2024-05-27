Return-Path: <linux-pci+bounces-7843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F98CFD5A
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1881A284562
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2B13AA4E;
	Mon, 27 May 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HhAdJh5E"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00213A41F;
	Mon, 27 May 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803017; cv=none; b=VFbTy/zfc8SLASX81TMz8nwoJvsTEwklnaETLki2C/GaVGD1aMScdTcjGbPNnV+tDOVzFubkogtVIJxdwjkRzgsJopSQixdzC2wsdv34alwjBd8zagv34v9gqFuzZIEsk8X0f7kURprTt2zaAGoL8j5BxtG8SKx+FrEqBP6ybMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803017; c=relaxed/simple;
	bh=fR/7T0+UMrJxQIZjcCXXJxLYwy8xIHBULjjM6TiMdVc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j75TQJ9QiUxHvflHEEolvSx8sUztu3X2HTWSBrtyga0C+WyGDmBdTCf+5Jez3y8yfwj7O/1JoAwfqT1wafaf9HrkBoTqjt8vW68RqbdKBt2akFXLbHdmyFh6WegFLVrfRPQmlDLMk152xu06e9EmRBNlf51TLo7pUeNxipvU4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HhAdJh5E; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716803011; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=7W1h1ik6qEQ2iCv0XMWvvUeCypjHJwVIOEdS4xSBGuU=;
	b=HhAdJh5E1WJm1KUgUaK8y699Wc1SyVdfkxFG3428pt0r0b8KjQGeRgJ+pwzTaLpdZihdhrDDSDjmDcQbW2wd4IhlQJ6xNPMX7rvHFCHoFOAT5OxsF/ylpAu5mAbwyCDHGxYcqZpF/dto3R6sY355jyZl0xQc03fr87ZiaE40KbQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7J2E4N_1716803009;
Received: from smtpclient.apple(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W7J2E4N_1716803009)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 17:43:31 +0800
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
In-Reply-To: <ZlRJaEEGEMsyxXqm@wunner.de>
Date: Mon, 27 May 2024 17:43:29 +0800
Cc: yaoma <yaoma@linux.alibaba.com>,
 bhelgaas@google.com,
 weirongguang@kylinos.cn,
 kanie@linux.alibaba.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D917498A-BF19-42EF-8E15-CDB25B96254D@linux.alibaba.com>
References: <20240524063023.77148-1-yaoma@linux.alibaba.com>
 <ZlBHjbmjjSEnXCMp@wunner.de>
 <7855600C-4BB6-417B-8F91-24F4F7E0820E@linux.alibaba.com>
 <ZlRJaEEGEMsyxXqm@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)

Hi,

> 2024=E5=B9=B45=E6=9C=8827=E6=97=A5 16:50=EF=BC=8CLukas Wunner =
<lukas@wunner.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, May 26, 2024 at 10:45:36PM +0800, yaoma wrote:
>>> 2024 5 24 15:53 Lukas Wunner <lukas@wunner.de>
>>> On Fri, May 24, 2024 at 02:30:23PM +0800, Bitao Hu wrote:
>>>> The values of 'present' and 'link_active' have similar meanings:
>>>> the value is %1 if the status is ready, and %0 if it is not. If the
>>>> hotplug controller itself is not available, the value should be
>>>> %-ENODEV. However, both %1 and %-ENODEV are considered true, which
>>>> obviously does not meet expectations. 'Slot(xx): Card present' and
>>>> 'Slot(xx): Link Up' should only be output when the value is %1.
>>> [...]
>>>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>>>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>>>> @@ -276,10 +276,10 @@ void =
pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 =
events)
>>>> 	case OFF_STATE:
>>>> 		ctrl->state =3D POWERON_STATE;
>>>> 		mutex_unlock(&ctrl->state_lock);
>>>> -		if (present)
>>>> +		if (present > 0)
>>>> 			ctrl_info(ctrl, "Slot(%s): Card present\n",
>>>> 				  slot_name(ctrl));
>>>> -		if (link_active)
>>>> +		if (link_active > 0)
>>>> 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>>>> 				  slot_name(ctrl));
>>>> 		ctrl->request_result =3D pciehp_enable_slot(ctrl);
>>>=20
>>> We already handle the "<=3D 0" case immediately above this code =
excerpt:
>>>=20
>>> 	if (present <=3D 0 && link_active <=3D 0) {
>>> 	...
>>> 	}
>>=20
>> I'm not sure if the following scenarios would occur in actual =
production
>> environment, but from the code level, there is the possibility of
>> "present <=3D 0 && link_active > 0" or "present > 0 && link_active <=3D=
 0".
>> In these cases, the "<=3D 0" conditions will not be properly handled,
>> and "ctrl_info" will output incorrect prompt messages.
>=20
> I see, that makes sense.
>=20
> "present" and "link_active" can be -ENODEV if reading the config space
> of the hotplug port failed.  That's typically the case if the hotplug
> port itself was hot-removed, which happens all the time with
> Thunderbolt/USB4.
>=20
> E.g. pciehp_card_present() may return 1 and pciehp_check_link_active()
> may return -ENODEV because the hotplug port was hot-removed in-between
> the two function calls.  In that case we'll emit both "Card present"
> *and* "Link Up".  The latter is uncalled for and is supressed by your
> patch.
>=20
> So your code change is
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>=20
> ...but it would be good if you could respin the patch and explain the
> rationale of the code change in the commit message more clearly.
> Basically summarize what you and I have explained above.
>=20
> Also, the percent sign % in front of 0, 1, -ENODEV is unnecessary in
> commit messages. It only has special meaning in kernel-doc.
>=20

Thanks for your analysis. I will make the the rationale of the code =
change
more clearly in next patch.

Best Regards,

	Bitao Hu


