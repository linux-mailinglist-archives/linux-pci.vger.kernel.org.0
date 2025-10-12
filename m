Return-Path: <linux-pci+bounces-37850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B604ABD0085
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 10:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE592342F3D
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 08:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D011FDA89;
	Sun, 12 Oct 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="cv9xUd0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7C79F2
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760257965; cv=pass; b=N8fp8hpsA4sUkor7eVumbGeiMybGR1HmdtPikGr8KBpvrgHlkbRdcy7I0txfrNQytcikzmM0q4Ij6D3eRnZF8fuf8kSp2bogsX+Nh4opJNQNbg56IxcHwXd9DEMLO8ugbHXcN/kcYjY87f4Zei95aKW7n0EccvKG3NoS2Or2skw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760257965; c=relaxed/simple;
	bh=F9XvATEDL7Zktng3lFff/xNNgCupDLgL+/n/eUD5dTM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jhy/c5QwDy6GKlGGRZ2jAT1C+ezTrK/yIKQeSkOi6a6uWnkJ84uHu/WYjF09+GONIuYkrXUj+JYTyHZt5eguyainQdd2GmE9IlPnzFvKDR+tIQLDsi+zSk4+wbinwscZzKHl7QoR4LLhE1KFS8yCthBBAvZONeY+sh14gIVI/Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=cv9xUd0U; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760257593; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e20jC772tPtOhzcydNtV1vv10wpT7jPlARmKXu60u1jc72cB4s8brtRfV8AvEgVOTh
    QYnRcMYug0PPzzItrqy+DCsrvvwXaJasSlaKpztuoGomma0dClvFBC735QwqBWAAoBy+
    Rmo8k5I+5TLl6E34uCE11TPHpKtJx2kvR+YQPRl7XZX47CNBGbs2gctyjDbaKRFnO5o8
    8b3Y67Pz1aw5ilYG2pTWMqqoHU+h6VgSw7b/pqrz4ikDArvkN/nhthvx8BDUYvzh6+x+
    aEGFXYKjYNC+ejp3rep2V7O7RD4wu+T36Fn6HQhAMRTAsPJAx1L5P2AyM3iTT5qWX/Wp
    AY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760257593;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9c0sKfGS7NQ99KLDwQHBbXcZ94VEUGg5GDwz27796Mw=;
    b=rGonAidCoY0ZM8Bx4zfHqVVzAJ5LNjVvdaJFfJjohAb6aQO/WeaB3JS8dC6LrIHU/z
    jT/aKQ9i9ThyxJlTgFfAQdYJOBaXh4pq06r6JyRqsi6ZM2ToHG9nH2xuotI3bdtPfAab
    uUszcVYLXa4fWNG0/ZhPlCdpxZnefJOJTkjr99Up/luHxrVFf0WFvgJARuw90MyNq7iX
    91XdGeOTghlOJDWTHOzKGAfCogznOSLmORM/lAkZfTNmY3sGJEChSn7vYAAS5fBZg85S
    T/sX+Wpq5ehoIucc6zGr/OWqDQsHK7tN2/GEtNFWRbU27sOJ4QhkU74xjDdFKxEeFoDO
    3oDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760257593;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9c0sKfGS7NQ99KLDwQHBbXcZ94VEUGg5GDwz27796Mw=;
    b=cv9xUd0UkCQGc1sojCJJLsZyK4RGULQBmc4Pn+nFKKa1AnwDoxmpPSmiTrWMbFgkIs
    8I7qvjF987TIyzExnpEsGZYfqZbhlV0fWjgO6kOrqUOVyhC2xJw4zPhMKtSePjOFCAOQ
    hqvWo0EhtCxITnA0hLPGQ6o289EbV7lyKjCWQXmrljNcNnvTgXKaplkNa6T8w4WtLIci
    OTGrVfvPpcod2fOpR5lm5ay7IEjzcr+0ccOeTvzTAm7OtKfNsk6LWof0fq2U5O6AIzQ1
    qUD8WSC6YB2kPfmFO9aa9+8gxfd23h+iR+jc+2Y1KqfXWBFk1lpqrRQOGKN4vpRWpRfN
    SzOA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m6Xc="
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619C8QXIPX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 12 Oct 2025 10:26:33 +0200 (CEST)
Message-ID: <53520ba7-c97e-4622-ba75-a827f9a28ae4@xenosoft.de>
Date: Sun, 12 Oct 2025 10:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org
References: <iv63quznjowwaib5pispl47gibevmmbbhl67ow2abl6s7lziuw@23koanb5uy22>
 <10994220-B194-4577-A04B-EBC5DF8F622F@xenosoft.de>
 <6ed8f4f0-8c8f-435e-a8df-2dc51773d9fe@xenosoft.de>
Content-Language: de-DE
In-Reply-To: <6ed8f4f0-8c8f-435e-a8df-2dc51773d9fe@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12 October 2025 at 09:47 am, Christian Zigotzky wrote:
> On 11 October 2025 at 09:34 pm, Christian Zigotzky wrote:
>> Hello Mani,
>>
>>> On 11. October 2025 at 07:36 pm, Manivannan Sadhasivam 
>>> <mani@kernel.org> wrote:
>>>
>>> Hi Lukas,
>>>
>>> Thanks for looping me in. The referenced commit forcefully enables 
>>> ASPM on all
>>> DT platforms as we decided to bite the bullet finally.
>>>
>>> Looks like the device (0000:01:00.0) doesn't play nice with ASPM 
>>> even though it
>>> advertises ASPM capability.
>> It’s the XFX AMD Radeon HD6870.
>>
>>> Christian, could you please test the below change and see if it 
>>> fixes the issue?
>> I will test it tomorrow.
>>
>> Thanks,
>> Christian
> I compiled the latest git kernel with your patch but unfortunately it 
> doesn't solve the boot issue.
>
I have created a reverting patch for the RC1: 
https://github.com/chzigotzky/kernels/commit/88150a30aeaf903d5ed44b8514350232666de715 


