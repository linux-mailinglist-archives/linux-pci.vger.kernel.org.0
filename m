Return-Path: <linux-pci+bounces-38249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 683A3BDFC9B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25F834E1E86
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20116338F24;
	Wed, 15 Oct 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="U+1nH5ub"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752232E74F
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547473; cv=pass; b=byl269JmCSDvshOgnezHM5dH3Fwd7CKj4iKGn7XFmPrjmBCYnbwyporK1Xx0zKsKL5Zy/ku/wK7+QAxKFJuSwZNsbgew+vtmHMvwG3gsQXnExqzWqM8oSITu6rNy80Ca8A+0fou/xr18K4Ab98efBhd0Uph5SAgYxCECxPyeTNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547473; c=relaxed/simple;
	bh=MNvswbCBbY7QC3RzoQOoCXHDwiz/HCoCnT+RJPSx19w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCFNQNWVC99dsAHXhHCRmsb2AqB9Jj+SF5o58jCEuVSw+0LyWkDQUa4PJEotmikSpTqUx7PL2TiaXb4ggfFHMyDect55ei0EjeEMADtPhfOJAyfUwHqt3N6WNJXU990Qs4yp8+nDwM3Dr62yVhRC7a+NpUnSKWwPgCBgUlJ2aVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=U+1nH5ub; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760547281; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O1HDLWgWimAUUOa87+KdygXhXCe9LzancvEM7Z6oLv+0F0agA9oVf4hk0+ua1r7vLW
    zguH6ArLsd1xcAxI4iPAhDEjgm7f8SyjIAnWU0tTwvSBBj5f3LZa5vYy00q1tu51Zcwl
    FMh/CsNHkkNoqmndeF2ZHfDJ6HxT4gnYbH+aOBKFkbakjAl/btcs4Zbm4QOguVrhPwBO
    D8PJH1RCzxZzub3HCRy6jB50++EH2216/SHRvNEQxQ7Mv8jeBEUDM8Swk9V/H6qJXSpG
    JzhI6n6bf/RebmBkXc+swM38aHkrB8YSpc3WpmNVVtXGUue/Za0qdLvwhpCXqGFwUPw5
    De9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760547281;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+bCfpk/M9DuRogcKAGcR+trCy+LbbvoWgRr/6nshqp8=;
    b=hes08i3uFs8cKMMcGwMPGuu9sFq4RbKbqGyNfnis231pcS/vHhbRVJdyi9RkLkASqM
    3xHqWxRPX5In+3RZveNoDcepnDRLiyJcMu9JNCBo4Km/iV4C71z7s+5D1yiH6smbRFzK
    s0QXWKyqc/5TVF9DD8U+bjd7xIHhS0vUWIaSZNU9/jDmxt1b5DMMfKtAcQq11y0WplAU
    xw2HTIltkx78zZWApMKKnl2VrrqugZBjey0im3Rw9DL7RqrsNxtBkiG7t4lUQtWaqM4B
    pOTH/p6s58/Sm3c4qNZPl/1rJ81eabdgwIP6lj3hGxKXnfGGQxHEpjpjBln8jWsgzU5c
    tfDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760547281;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+bCfpk/M9DuRogcKAGcR+trCy+LbbvoWgRr/6nshqp8=;
    b=U+1nH5ub2oQPVImfa/fORhv4CnHu/89YgbGEmblG+eg0xOw2cFvx3/dg90/NwHXJHY
    POdDAxX7BwEAkA/KS6W834DJLjwml9CepELQVVDk4n1l7PCKIGvNca88ipnQHUflO2LE
    +qg7C1ZyFhEThwN01v9ICHFFJAwOAMfZkz9C8a2KwIoansvcq91dbHUouY3ddo525JEg
    fCnqK2caqeiM2ynBQ7NS3XQbybgDNArXVE/r+kl6whLUGpDnDRZeVOQ61HF7l4mUCOZR
    3rPJFvxDqWJbp6NcUe5TdlgZW9WGdRtuYIOVjfs5wBNjtbASUlxC9sJ4lFgr9ztTc76B
    KdYQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+l73c="
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619FGseYW1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 18:54:40 +0200 (CEST)
Message-ID: <523e2581-9c78-4c37-9c97-578df079f008@xenosoft.de>
Date: Wed, 15 Oct 2025 18:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PPC] Boot problems after the pci-v6.18-changes
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>
References: <20251015145901.3ca9d8a0@bootlin.com>
 <76026544-3472-4953-910A-376DD42BC6D0@xenosoft.de>
 <20251015153442.423e2278@bootlin.com>
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20251015153442.423e2278@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



     Bjorn wrote:

     Sorry for the breakage, and thank you very much for the report. Can
     you please collect the complete dmesg logs before and after the
     pci-v5.16 changes and the "sudo lspci -vv" output from before the
     changes?

     You can attach them at https://bugzilla.kernel.org/ if you don't have
     a better place to put them.

     You could attach the kernel config there, too, since it didn't make it
     to the mailing list (vger may discard them -- see
     http://vger.kernel.org/majordomo-info.html).

     Bjorn



Hello,

sudo lspci -vv -> 
https://github.com/user-attachments/files/22931961/lspci_cyrus_plus.txt

Kernel config -> 
https://github.com/user-attachments/files/22932038/e5500_defconfig.txt

I have already posted some boot logs.

Further information and boot logs: 
https://github.com/chzigotzky/kernels/issues/17

Thanks,
Christian

