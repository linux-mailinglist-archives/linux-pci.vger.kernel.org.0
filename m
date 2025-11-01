Return-Path: <linux-pci+bounces-40004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E2C27898
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 06:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA634E03DE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 05:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86B286415;
	Sat,  1 Nov 2025 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="RvoF42sR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75195C2E0
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761975786; cv=pass; b=EWnVaOSyumUH1n4tawSMh6vx75HhwCriQlsk/rFxiXg8xOCpnlY2ijWkCo44Fa4ckrhWor801L/4h1dUcJOE9TSpfrlcoZGzySEd6CNlImRks8EUxbLkLV/2kYHa2URa5eIM6SNR7+Dr9981V3rv7qIl532hHvaNRptTk4qyDfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761975786; c=relaxed/simple;
	bh=x7VIr14dHAcUpHQ0SlH90MU1I5WxucUHcRqgCRRebzM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xr04kQebuqT3a/+HkKNrFet5GAjVWjuIzTYVBSZjwiKZCMnCCLi1q+oyXCV16+oG5eMiWb2XdRRuVIHSlnPnelmZF0offSDMzgzfpJFQ4L3sgUj12SywkTNumazZMcg9zkbYVkSuLJfuT9cH5ia9+gX3lon0zOrB5pHHUdbhB3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=RvoF42sR; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1761975598; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nIa14/CT/+D8+pApFaXlrOvTyoFV7EFb5j97TpcupG3QVsMcD6ovVZmoLgatQk3DgY
    VOPbnQou2Y4faf4U3TixfVlV3GhB8sHlPuueNren6a9guqbWVxUTLdv4MlGWEXgxAsq8
    WdjLb8lcAUVYg/AcWtZprOrwJMCSz+A8PFx1elN+s01cMGegWTVLmKBh8bwYxcVLRJVT
    mPVm4BB8urRpPgjktDcIsA31NNx+9acHNquBrOv4xt1KAWaAgQpinx0gdc65vo+HXjGS
    OXYGDUUr7LORcxoIIJy4pwbWPTECsw5+x0V3bym5gNOALEvZWBXieFPkzOz8aJY0qG4e
    VDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761975598;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GF4ohs13vWVVo07uWo2mZ+yvO9ChORyA1Qr2aqT6rH4=;
    b=bAsVwZCioue77OJAshYDrDWEUjphx/m6Nap7OrCMeIT23LSdjtWaj+kF19TnX/EEa0
    AKZcQ+znQRh9rO2WBHgRoEOJ3KISO3YovVCPTbjGJ6gJ7Gnpwn9ZIKrFE+AZmbsqDjYu
    kacTAN0Mp0dNUFEo39Ts5nyx0vce5zevdl1dNoTuxKN0EZW6e4i2bRjrshtsoUGikLIY
    vv6pW6syWNsm6RhEBX2cCI29eVaRIJq31gTXgN8DhL58OiQCGHD3u2l8ITSRK2kmyk0E
    HoWctiEmhZkUd2IBz+HcJPBrNZ6Q9K9CW3SCNelumTqJ5XMpzoC0cp+tiqVX3OwazwCR
    scSw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761975598;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GF4ohs13vWVVo07uWo2mZ+yvO9ChORyA1Qr2aqT6rH4=;
    b=RvoF42sRzfGNwow1QEwFDhTFHEt6yPxh0S2hotrojb1mfvcdJ75ALcUefJS/jfhkva
    NRx7FsvzZqbuHCj3K08Xoa71ccpNpnjKuHoFHJqGxbxrdtopCm0jSX+CTYESzF4gXBtS
    kqSk9HJGMgIGCM9UoKcLLOH9CoBPHNIKyWlaRexhCOqM+/7/oXPZzFF4VDPsJdOBusUU
    KBmRBgzyFvsnMBPFz1bnigjMW7sbox6sCAPSEAso0spD7tOorNiDqSpfetx4OSluLXSt
    47LGvopycyOThtmayZcSn1gbZelM6sGGjn7E44Vd389bpoVedKCzlL13pJg/thwSTG4n
    ZQ5g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+m6Bvg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e288661A15dvVv0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Nov 2025 06:39:57 +0100 (CET)
Subject: [PPC] Boot problems after the pci-v6.18-changes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam <mani@kernel.org>,
 regressions@lists.linux.dev
References: <20251030221156.GA1656310@bhelgaas>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <545ac5c9-580c-5cf7-dd22-10dd79e6aabf@xenosoft.de>
Date: Sat, 1 Nov 2025 06:39:56 +0100
X-Mailer: BrassMonkey/33.9.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030221156.GA1656310@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


 > Bjorn Helgaas <helgaas@kernel.org> wrote:
 >
 > Oops, I made that fixup run too late.  Instead of the patch above, can
 > you test the one below?
 >
 > You'll likely see something like this, which is a little misleading
 > because even though we claim "default L1" for 01:00.0 (or whatever
 > your Radeon is), the fact that L0s and L1 are disabled at the other
 > end of the link (00:00.0) should prevent us from actually enabling it:
 >
 >  pci 0000:00:00.0: Disabling ASPM L0s/L1
 >  pci 0000:01:00.0: ASPM: default states L1
 >
 > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
 > index 214ed060ca1b..27777ded9a2c 100644
 > --- a/drivers/pci/quirks.c
 > +++ b/drivers/pci/quirks.c
 > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct 
pci_dev *dev)
 >  * disable both L0s and L1 for now to be safe.
 >  */
 > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, 
quirk_disable_aspm_l0s_l1);
 > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, 
quirk_disable_aspm_l0s_l1);
 >
 > /*
 >  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

Hi Bjorn,

Thanks for your patch. I patched the RC3 of kernel 6.18 with your new 
patch and compile it again. Unfortunately the FSL Cyrus+ board doesn't 
boot with your new patch.

Sorry,

Christian

-- 
Sent with BrassMonkey 33.9.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)


