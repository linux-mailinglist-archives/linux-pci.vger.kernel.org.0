Return-Path: <linux-pci+bounces-37720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3372BC6131
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F44A4E1C0F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C313A244;
	Wed,  8 Oct 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="NP5HyNjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224225FA2D
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942231; cv=pass; b=kWI1gZekrCYWI00E7/ko5hZiYYLMOOoYaBGx5TRnFcwX2pxhiAdj5XxbNKvYbQR9deryBOH+6HnZkUPElljah7vL/BiBPXhj8mnxRtYHwxd5FB4Gn0ehFn3p6dEgmdpTA5af2Tm/DEMRxKsEYmhJRLBnsbiwCPRzI/Z7B9w8C80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942231; c=relaxed/simple;
	bh=HATMSaW4Oxu5q1JXtyZ8PUzJePZIEwKjUNzsQOzjMoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7iRvWfqwp0gcljCpbyJH7Jd0oEdrLasx0MSpeKxUPME95wpjRQDdrPf+gSsl8BwJfE9KRRRdihGP5Lt5ydiUnXzIKhTzF2QwXA6sZV3PgrYfpTDFqcc12QjiLhtA+jMkbqR0cjTEYDwMbEgVxvh3cb25j/uYNRo8JOLnOsgmvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=NP5HyNjL; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1759942042; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bnb49V6XM//2DAgoQWO1YfgXMg2KI1AblgBp2b01/US24Kb5smn8aJtZOMhs4ij0J5
    QhgLKPQ1E6jhAeyhEHEJUBrft5SX3dCi7l2HEyur8zDi4fkvRWOVuSNxSg5T5ghYn0n0
    l0LGNzCJsa2I9ZGZW4ouejtUP9V9kwGxKOM4UvWkfBA+Y0GfdNQM2C3WPLkqYylNj/RJ
    prNyMtqJwUZ2X1i0HNN8VncXiwjaKzZIR1Q3cdttSlaiu0wMYS2oW5ZvjJO9NVnBjS6a
    s1tPMRVGjwkTYDFe44m4GGGgwoFxMU7W0gAlRXbfRYDJK7CgkskeE7vrhYjmEONSzDLZ
    CuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1759942042;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FEGPIVQdAIwtHVZOdavnb/1ru+OaKX6ONG+H/kTCp5U=;
    b=knzKEBfLT+nJ2Yyu715li4/Pv1Zrop6BD7EtkY9RWTHrsPKZ+ObsN1R51n/DZFiB7M
    5B/tBoRdqNRWFkbZKS2HBipxzEtU6a2gRuK6s2zjjnVM26Bj3HHIlr79CTe0Y3YLOu/A
    Sk89L4J4JciUEYvYrH2jYX00LgoUs3Av4Snbs9k4coztN3s4ny0QXdr5TNdZnSPr97yz
    u6rsNJFyDOKIZvXDhX6sfz7w81S1+DlpO83tmLpQLeqteyaW8ktiCaFu02H1AcDQHcRK
    J0uksbekxIrRC9oFDRdgaL6b3w9B1oM6e+okePeZHkc6tMVWUXEbnZ0DgD4WgQMqQ3MF
    NVAA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1759942042;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FEGPIVQdAIwtHVZOdavnb/1ru+OaKX6ONG+H/kTCp5U=;
    b=NP5HyNjL2wY+iBeCD/SsNTr3/zxzVAYn0v2Y3I3MXeo98YVF7qr1duwv6cUQdewp82
    Q3n8uxcmG9ah8GsAOA6nH77eYVwZ73rtK7DRAhAN69cGb8ppsa8Q2Yq9Q5JQPD3UWAXf
    /+uUntGAJ8zpUk7x+Dm0c1rAT6q228bupY0lapoRjXiuI5QAzYMuPXFYRi1NbxHBXwRc
    2/7zKQyp/g6+65N3qEjJbFJlJqb0L1dizmXhNzn9Oo+hxxuLwOJAdZweKtaDcIeGIU1I
    67iGgdqH7Tyq2dwmNLrPA168pcb3WFVpbe5I5CsTSOgkHJFyZfz14C8s/JjSjJvdfJ5D
    wrJA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m7hjg"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e28866198GlM2HJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Oct 2025 18:47:22 +0200 (CEST)
Message-ID: <5c73197c-5c27-4ce1-bf3b-28c248103c74@xenosoft.de>
Date: Wed, 8 Oct 2025 18:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <15731ad7-83ff-c7ef-e4a1-8b11814572c2@xenosoft.de>
 <17e37b22-5839-0e3a-0dbf-9c676adb0dec@xenosoft.de>
 <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
 <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
 <87mtma8udh.wl-maz@kernel.org>
 <c95c9b58-347e-d159-3a82-bf5f9dbf91ac@xenosoft.de>
 <87lf1t8pab.wl-maz@kernel.org>
 <a02c370d-1356-daac-25c4-02d222c91364@xenosoft.de>
 <87ilwx8ma5.wl-maz@kernel.org>
 <d044e62f-c7f8-4ec7-dbc6-ce61767e295f@xenosoft.de>
 <0baf0f26-ab82-ca19-ea9f-7f461ce32aa5@xenosoft.de>
 <db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de>
 <3574beaa3ae41167f8a7f3f32b862288e7410d1f.camel@physik.fu-berlin.de>
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <3574beaa3ae41167f8a7f3f32b862288e7410d1f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian,

On 08 October 2025 at 06:40 pm, John Paul Adrian Glaubitz wrote:
> Hi Christian,
>
> On Wed, 2025-10-08 at 18:35 +0200, Christian Zigotzky wrote:
>> Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
>>
>> Without the pci-v6.18-changes, the PPC boards boot without any problems.
>>
>> Boot log with error messages:
>> https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
>>
>> Further information: https://github.com/chzigotzky/kernels/issues/17
>>
>> Please check the pci-v6.18-changes. [2]
> Can you try bisecting this issue? The commit you are referring to is a merge
> commit and contains a lot of changes, so tracking down the problem is not
> easy unless we know the exact commit that has introduced the problem.
>
> Thanks for testing!
>
> Adrian
>
Unfortunately, I don't have time for bisecting because my main work 
needs more time currently.

Christian

