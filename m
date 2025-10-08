Return-Path: <linux-pci+bounces-37718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA7BC60BE
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 18:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EF134E2C4B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D6221DB1;
	Wed,  8 Oct 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="WexDtBT0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA192BDC27
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941539; cv=pass; b=kOfLTI+ajsON2OK8rAlx+yeWVPiSc21bLG0JxC9gK8/yD95Ca587DsfRcCbV5AwVrK4fmrM+8mcZ4AszMt2YuELeAguHK/4feb2Ue3skTG9Ty7sg6qPXyC9ozumn9LTjBs0UEIOFuiTUKroKLE24gzJopW1Dpz0Gm/Wwb20ZrOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941539; c=relaxed/simple;
	bh=iGXTTA/VRrER2H1zdff6GUVCk0cJ6um/NGhgQMfWAsY=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:To:
	 In-Reply-To:Content-Type; b=oD6pzJXi1XXEYaZqq0DIqUvzLZ6VJhUdazzWQr3lodHDNDzjUlvhcpx3bWjvuRx27PGZ4I4GswLq/5XUqu6EWKxOHQPyvwvZ5LgD3+8YmQfrR/+LosdbecfrF3oIzOzmh5bnELJVboP0AiXAIKZNR1mQH64aLlkoxbIaacBXqBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=WexDtBT0; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1759941343; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kSPZ41FRCnz9M0verzRrPJPBNP4I6pXCrP0PcKXoIZPA7kKq5lxclBo/Oa8mg+ZF9S
    VSjEtYpI2ofvSTi7O0mxgyGIM+Eqm8LbWdGi2NfVF1tdjAZaYlHkyY94aUIDkEa8LJE4
    80Ia+RdhQsuqbgz1SwJArf6BUD92f467pTpuWyPtzlKD9PHVZsyTQJ56UJ8wHIz1E3uB
    At9xUkSK2bz/W2IWPyQH5VV6bHH2lJx1xfulrRMUO/gzY4oQobEBLAVNihs6Ej5edYfx
    3h0rcH3PWxXJivfUNae4yJ2sxlXCf+t6kxDcgFUUuwN01auV/VXgSwl14E2aisF66BzX
    NUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1759941343;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:To:References:Cc:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YtMFp6hk0KZtRuvIuBOISOMZNCRxLqDo914yFlgZ7qc=;
    b=rHLRPvOvlH9pZ7cPEEG7hTgqTElKqOtUQFbrwqvhJQNkkkbtH5VxZfihN6fz1haXhA
    hWQqjVZfyb6lkQjSEPQBG18OqX6oyXgOet7mPcya/0mXwh4cW0YW5iREXjpdgbchJOHH
    MgsRUeI2R41O9snWRhMqbcJFYVveUySS0/o96pghrWatCI1DHQFGIzia/FwoWb8NGzmd
    rsju45zUWOjYlrltSbAiQoy2VOAY4fAlIGEJ+45bpz313P0bF0IlnkF+DLqjCRpXvN1G
    O/gatmCefchezEZMhDipkU4Hsck+3JuU6oA5kjlIeZo1igf+zCXbNMsJMYZmQMv9wEgX
    Ku6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1759941343;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:To:References:Cc:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YtMFp6hk0KZtRuvIuBOISOMZNCRxLqDo914yFlgZ7qc=;
    b=WexDtBT02414yWTb5YOODocdEC/B46AXE8dqvkOTXyWeK3Z/lC/Rnic7CaoGwy0/3t
    aGnmlMcKqzrs1eG66ss7PFUNc/2Md8i21AVCVYwQgoe8DjXWK2UiYJWRC62h9vbFoVo1
    YRKbXzzkDWg6Xwz/T2/qUMnXn1O+JKKxo6Rz3TIARE5srijFs5vkEoS+msT2pvp0JGmb
    P8B4S1gBVjUto2Oo9AzU92HtPmAM+SSDow3JkO3PyguwsdCdrYW39SBUx8kPFfeshXuN
    mGTVOIxusRlKBv8I/zmfUDmEdE/UIKajNCsMB7JlZPoxxpdSjisJN5ExORZ/lGrQ7dXm
    kSAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m7hjg"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e28866198GZg2G9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Oct 2025 18:35:42 +0200 (CEST)
Message-ID: <db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de>
Date: Wed, 8 Oct 2025 18:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Content-Language: de-DE
To: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <0baf0f26-ab82-ca19-ea9f-7f461ce32aa5@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]

Without the pci-v6.18-changes, the PPC boards boot without any problems.

Boot log with error messages: 
https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log

Further information: https://github.com/chzigotzky/kernels/issues/17

Please check the pci-v6.18-changes. [2]

Thanks,
Christian


[1]
- https://wiki.amiga.org/index.php/X5000
- https://en.wikipedia.org/wiki/AmigaOne_X1000

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92






