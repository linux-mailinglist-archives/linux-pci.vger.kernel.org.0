Return-Path: <linux-pci+bounces-40951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09C8C50706
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 04:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B353A535F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A0223339;
	Wed, 12 Nov 2025 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="D+OuScvD";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="UbEXx0xc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E4218AAB
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919190; cv=pass; b=X5rLn+Jp+kKU60tYoHStFnBs0+dTK7NAOfsXFUv9x2QdtVYkGw4I9wWS5yFUZy3kz4rDkM0WAHFSOfKXC9qu8ZnBnMfZ3drG65EMqHzOejTm+ooMUZJ91MSadgIRUr6sCG27mdohbZUAU2RemlINFCmOVCEJUziv4PLQ6JIIWBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919190; c=relaxed/simple;
	bh=t7rkG3lT9ZzvS7cQEKmxC841oIHj5JrAW+87CHBUqtE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JFAUlIHFJNnfurChhzll7RCNKreW65YyM0bbkyxgVDYJ6nYIPGzfs68cN9rr1d8sjCximxKICv2cENFamMNOsepPqm12E+DR32qTbJsZmGireC+KzoQYWmduoL9OCa6B1D9cJk7cI1cE9GHIvA/hGs0L+vFuxz3iYym61vZdwyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=D+OuScvD; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=UbEXx0xc; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1762918834; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eS5Lzl9fspGwjk/nXmyeVtzr8EGd3IJdwfIH14lyxKNUWt0q9JbIj+5oaCm7pZ+oV+
    ppxOuWEVhJnhAHeAgQrI4l0tz7k1T4bLDChBfvCkppDE7kD7/VMl+t63xPNFtfDNWeUq
    VFFfxFX9TLU72ZgfJzO9p81jQbptAhFDa41vgJNX25nxkLQsRnyuIBFReF+D0tE/iIqx
    BFpiHTCHsphnI1pSYFkpvLFFMA+zPWCkO2V2p4sSZxmpnh3rZwvvz81KgI8wi+Ev5k4V
    va60Ckw9rIKP9z8oHnRmXYfB669W9mswdhSSCRIbf7XBXn0fjr3KB2b3das8tt8IZrZW
    eayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762918834;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZQePqx4mWAl3Z1zpzCfWWnyfUVkvM3CdO85q2oQ087c=;
    b=FHz9IYLYjHziMZYne7lCvYR02d5a9Snf3G4JVh5F/udneWSwq5icFZUkKy3SJK4Zrl
    T6gmZK7S28w2Qm53UOIiZvK/VlClSmudqLM7vcOxhJxz+SFBwHzW0+zow0TG5K57LHxx
    b8KVrALQBMEyw444ZFhDYTiVGRAtjyz8v9VuTAunNfXWsmBxlqYy+ojAXe0KftxpyjWr
    6nJAL538MSdTFv1OzYzOiAMMooye12E5nMZmiV/mVXFJCyxJ+jw7qU54L9jF/wy6oQSS
    44vpOUOI1r9sKVfUzq1m9Ef63YOqSgFbj1MF60ZRc2Gbo7VUJxxgCkVtpR+hiilnhgpd
    RLqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762918834;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZQePqx4mWAl3Z1zpzCfWWnyfUVkvM3CdO85q2oQ087c=;
    b=D+OuScvDFbJDSsvrcE9IcF1gPA2DwMTGaFWZMvwTCDXdagWHuQTc5wv2o5NjZMp/8l
    PFyzQk2ED4GlmJ2/HC1JfArXbUnhCJ+ugAOnhpsfMu3LtSPUj034oIBs4SmdjCkGtJ7Z
    jdZzbOVju5Uc0WYOzTJdJaSMMoFj4iQUn73ggTmcN7J0z+YXn5cUcdF5b0v8Xbo9CFqn
    yFglpCvCiZlcoCI4nxcONGcwOkdgDHwwIKgJNIQqG8RTInwmUvxzj+V8/CLvWBivFeBP
    OJo7U6wU3Ae6CoK2jro6uJWDybTYkmBkxiZIqLoLDr+nTQUWhkOJRJeXeBZ0NouZjFsG
    Of7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762918834;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZQePqx4mWAl3Z1zpzCfWWnyfUVkvM3CdO85q2oQ087c=;
    b=UbEXx0xcmZ8s9zBKzkeis4LCG0d1siHusvvL9P+inPfwxXx/AYjaBSb0noTC4VUqc7
    YzFs+jEn7qPx1dz/K/BQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+l6x7g"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id ed69d81AC3eWIrv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 12 Nov 2025 04:40:32 +0100 (CET)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev,
 luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>
References: <20251111122001.GA2168158@bhelgaas>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <f4331d1c-8695-19c3-608b-210b3242aaf0@xenosoft.de>
Date: Wed, 12 Nov 2025 04:40:18 +0100
X-Mailer: BrassMonkey/33.9.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251111122001.GA2168158@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/11/2025 01:20 PM, Bjorn Helgaas wrote:
 > On Tue, Nov 11, 2025 at 06:15:20AM +0100, Christian Zigotzky wrote:
 >> On 11/07/2025 06:06 AM, Christian Zigotzky wrote:
 >>> On 11/05/2025 11:09 PM, Bjorn Helgaas wrote:
 >>>>> I tested your patch with the RC4 of kernel 6.18 today. Unfortunately
 >>> it
 >>>>> doesn't solve the boot issue.
 >>>>
 >>>> Thanks for testing that.  I see now why that approach doesn't work:
 >>>> quirk_disable_aspm_l0s_l1() calls pci_disable_link_state(), which
 >>>> updates the permissible ASPM link states, but pci_disable_link_state()
 >>>> only works for devices at the downstream end of a link.  It doesn't
 >>>> work at all for Root Ports, which are at the upstream end of a link.
 >>>>
 >>>> Christian, you originally reported that both X5000 and X1000 were
 >>>> broken.  I suspect X1000 may have been fixed in v6.18-rc3 by
 >>>> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
 >>>> platforms"), but I would love to have confirmation of that.
 >>>
 >>> Hello Bjorn,
 >>>
 >>> I will enable CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT for the 
RC5 of
 >>> kernel 6.18 and test it with the X1000.
 >>
 >> I tested the RC5 of kernel 6.18 with CONFIG_PCIEASPM and
 >> CONFIG_PCIEASPM_DEFAULT enabled on my X1000 today. Unfortunately the 
boot
 >> problems are still present.
 >
 > Thanks.  Can you post a dmesg somewhere so I can see what the relevant
 > device IDs are?  Can be with any kernel, doesn't have to be v6.18.  We
 > need the Vendor and Device IDs to add a quirk.
 >

X1000 kernel 6.18.0-rc5 dmesg: 
https://github.com/user-attachments/files/23491291/dmesg_x1000.txt

-- 
Sent with BrassMonkey 33.9.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)


