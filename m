Return-Path: <linux-pci+bounces-40556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC96FC3E7BD
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 06:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5730D4E140D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22951DA60D;
	Fri,  7 Nov 2025 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="jEiPtVLq";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Pumvlu3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AE220687
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762491998; cv=pass; b=QlelGTUmOahTc0IQHqlRPOh9wqCH/X2C3ymbbhpS+aGTM10Zaxe6PaPHos133Xga1y2X2uu6B7pk2xxqSgpXYSCjp4STOQWWsYjq6ojXrH5CDeF5ihDOpYrqmgDdBtxd6qkM1Imgr2erAhj58ZKRdpoUfEE3Dm2IgSVNqv9mSkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762491998; c=relaxed/simple;
	bh=a8IeRctoRQBGsBIptHHB6HIefYInfid56jmBFlfVPJg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZtPH45yrw1upNSo1r9ITge9j2LwTFesGoK2IpJd9NrvLwxaYM2Vn6E9+yn0SugRd+lUqdWpdTtASOv45Iay+6E2YzcLolkom5n/pvlSQm8MsVSUM9J1XqB3YVydvwYY8AQr37LM+fHCojpIQlUd++AP8dYHwlmqpTNHTvE2FKQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=jEiPtVLq; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=Pumvlu3R; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1762491975; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lr2Fvd9EGlaeuldpTTFHmLOSIU0QtaFBCZrLEwTS33Egie4G5YZQNXW1Pox45Ua4Lh
    ePACm0cn4sZMDpqs+wzuPMGw7DNP/7wvTShxdDNnT33KBgkiNGt6YXPI3+Zt6eQiRmtP
    HnpoEijBBbw9EfUGNdi2CW7BApfDCedipgufEpKHsx1IMeZObipX2K7ozlvWy1XLOu7o
    YNuy5cdK6KfXHfk2xbhuU9fSb5Ha992Wttm6c3m4qScO2Uh5WAtPMSCuVATY7iLkdRnj
    eFS0gECYeQgKJ9wH9qrfQAhLuNeZhTFM0URO+jX+/D7CqoG3DqY3juaNiDnxryq26CyR
    V8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762491975;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AF11/LwkMwcLn6mwkC0qykIVuDRjIhfU25/98vK8keY=;
    b=GbRGcPimjVYqDoLd1zTme/apAG3sx+rHlrimBcyC1NNqO50nM28xqPJ2cLQdJk3sPG
    xaMk2cc7uYmcDbnrXirdG1kH9qqtdH4tNgcvE/pYik5lukF4ALs1Tk4F3Zn+ar1F/ZNx
    Ejv0p3uHWHMQdc5x/ZXDsZUKA1My/aNVNVUq/Gj7RBFdgOYBORwdBi/03iqS5V+mgeob
    dq3ODVxx3EM1OOscdVQ/xrAU8NtIRf1Z64FxXb3CHdLHze8jcsuja7iPq7LXxaowfdE9
    2UkBfcx8Xy4qqLYglTKKVtAfTUn1SUcle2sH+45N4QuPs7VIuxA5M+337JycK1Opu8eN
    8SPQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762491975;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AF11/LwkMwcLn6mwkC0qykIVuDRjIhfU25/98vK8keY=;
    b=jEiPtVLq3ixrh2Ixvwitei+s0o2akvpzJZGMsnugXnXNaUfeiN4QM9Lf6bhSrphFaw
    SFRYOBU+jIVdUwAINkqGK27meV2y2sTshNxknH/qPN/D8b+HRXGUta9Ch/iza/bvKT9y
    X/pGc/cjde3n1kDqFTN4ZbMLPdaWb2If7C0u5JuKEdzAtTo24R2fXhJ/jHgYveRTqS83
    wXXTWc27tV7+IaNPkMSA2f3SS6SpyTDE/Nqwn8sm5lnYCijJmbBgVR1uLC3v7igkR4EM
    AT2xXT9Pgdjbm8r6flUHE2+r+ZZlI/CxJo5IPOcuplmlLdnxXQ6rp1EK5obOhgmSDsWa
    CprQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762491975;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AF11/LwkMwcLn6mwkC0qykIVuDRjIhfU25/98vK8keY=;
    b=Pumvlu3RJclVgi7MOETj8jXqJpURZWC9b94ueriQ3E79KUgC9qq2ScZuqsnQqGzDOc
    Wl5SeOy8m3jw9QgwkJBw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m7hLg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 54.0.0 DYNA|AUTH)
    with ESMTPSA id ed69d81A756D1vN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 7 Nov 2025 06:06:13 +0100 (CET)
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
 luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
 Roland <rol7and@gmx.com>
References: <20251105220925.GA1926619@bhelgaas>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <3a384a25-0256-e827-2d66-9efc5723965d@xenosoft.de>
Date: Fri, 7 Nov 2025 06:06:12 +0100
X-Mailer: BrassMonkey/33.9.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251105220925.GA1926619@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/05/2025 11:09 PM, Bjorn Helgaas wrote:
 >> I tested your patch with the RC4 of kernel 6.18 today. Unfortunately it
 >> doesn't solve the boot issue.
 >
 > Thanks for testing that.  I see now why that approach doesn't work:
 > quirk_disable_aspm_l0s_l1() calls pci_disable_link_state(), which
 > updates the permissible ASPM link states, but pci_disable_link_state()
 > only works for devices at the downstream end of a link.  It doesn't
 > work at all for Root Ports, which are at the upstream end of a link.
 >
 > Christian, you originally reported that both X5000 and X1000 were
 > broken.  I suspect X1000 may have been fixed in v6.18-rc3 by
 > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
 > platforms"), but I would love to have confirmation of that.

Hello Bjorn,

I will enable CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT for the RC5 of 
kernel 6.18 and test it with the X1000.

Thanks,
christian

-- 
Sent with BrassMonkey 33.9.1 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)

