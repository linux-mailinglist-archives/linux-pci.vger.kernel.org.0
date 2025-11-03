Return-Path: <linux-pci+bounces-40135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E7C2DAC2
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 19:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F964E0643
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57728BAB9;
	Mon,  3 Nov 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZayjRdX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11928C5A3
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194525; cv=pass; b=pQAyVS45VDccMWbBPNt9UzsMSmAownVnCqUqwkZoJXb6TExbmm5tYREr9p2WCPBO08nH55CHf1DbgovDnJ2tJxsrWO+h8dpCJBRnsl0lcjbfqMkevTDB0GisYK3EXdWTVIHAPVtWVbp9jbx7ep9Y97TQySBt4Lc3DGDSB7u3kLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194525; c=relaxed/simple;
	bh=lRbzVCs+21KTjiME0geIk/7FeCxmcuLemfuEVlGODUM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Dm0bMFmMLCCFBtySoLxu66ii/9cjkpr2eRDSQe9fXuPkpjJ5x0InejoB+/pN/1YbqYV7NKVchEbY2+NUFAOJ0+GICfz0zcQRVRH0ANOPyjaMuSVyI8Fc0fxCeZUNK4+VIWClzWpqlNVlnbpm6JP7uqP0eX0HH53FSboW84JWSzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=ZayjRdX4; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1762194501; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AU4sy1rW+8LT55IEiSdEhOox/nGGdwtEIgBEx/VWOpxC7gv/6IHVTbMGH9GTa4Pkpw
    UcORh/wMC2L+caR+WRNufihMy28FTGtrmVRQKU15aypqb5WB0LEkWT0F510e5nSae1Hh
    MgqhyufKrOULj1CfFOQHgPZXyFsgPkYb94w31g9HQhkzR58/AHgATLADDr6qjK8FY85m
    p1gpxEOOD737r2wcQL/inQCIErvPF7LDDC8LWclzb25j2p7n7grtWC22fPIVFB8M9NdG
    IYHy31JglrxacdKxQ5SZrhk26i9HhIRwHxtaqUVif8qMznk5g8DE5Cmm2usJ98zy6/aN
    VWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762194501;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=o7mmj4miEk5uHrPbENwgiOkK+B4AYKwPEzssaLhx+ns=;
    b=TR6GYXtcjPr+Z+XT7P0QkLcqM5oZtZn2FLXPHZFeE/s32VbZkOfoN0Oz0IBOTpbijJ
    TYc3UIE38Ki1QUGNKJacfsHGnxNC3CRqgd+B7Wcav64bMA6562x11lU3am/u+aIzdFDu
    r6DV/MLKWSe9EWxdeto3RUAKtP3b57PjiusxHTIIOqtLZ77lw9GORMDeRQbdP14Ij9xb
    eDieTH96QfM2JYMHbwxi6kwqBgH7BKNWKF1PnQkRRgWPDZ0zcC0Ad4x/6JNuKzIpWh7y
    3QpqE6Z3n1k5vylu2YphMjJys4vk1FEVAhuQf3dQirE+29CA6Z7EskO/AYwW40D1z+2s
    9bAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762194501;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=o7mmj4miEk5uHrPbENwgiOkK+B4AYKwPEzssaLhx+ns=;
    b=ZayjRdX4ltx9V2Lvo2hCi/dnVYykNv66H3B0rrEwErP2mBtDvBf1oUPVFxrOSngBqp
    2kYpWzMPrUlmW0mYblk/CB4QYD/VuGOqCfhnPtZ2kT/48MgiG+YhQgSyXnIDCUHBk2kC
    65nMv6Ke6SM6ZuV+euqQbAiZRHTaxcJWz2hFJSbj45DFTTotuOypehe6GZXIif2jO1jM
    8WkBFV6daljnPg3EVr7ql6qatXLjl+K6S1sH3sMPejeiRqTTmW5Oz7x0ayv5ECagMLsb
    ub7kHinKTX/sRhJTfONYU3hDDz0m5JNOB8QhAuNozbSQxL4IFgtqsRqq9Fvxcc/2ILKz
    AR5g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+mgQ=="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e288661A3ISKeHk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 3 Nov 2025 19:28:20 +0100 (CET)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev
References: <545ac5c9-580c-5cf7-dd22-10dd79e6aabf@xenosoft.de>
 <AEBA92BD-B46D-4D1B-A4D1-645B276E34CF@xenosoft.de>
 <emjne6l33e3hukef5ms7kubv6kkuvesqkw6ozojnzzdgvso7ma@rbpg2l5i3nno>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <d93eac4d-b382-97dd-d829-98aef6695204@xenosoft.de>
Date: Mon, 3 Nov 2025 19:28:19 +0100
X-Mailer: BrassMonkey/33.9.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <emjne6l33e3hukef5ms7kubv6kkuvesqkw6ozojnzzdgvso7ma@rbpg2l5i3nno>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/01/2025 06:06 PM, Manivannan Sadhasivam wrote:
 > On Sat, Nov 01, 2025 at 08:59:37AM +0100, Christian Zigotzky wrote:
 >>
 >> Bjorn Helgaas <helgaas@kernel.org> wrote:
 >>
 >> Oops, I made that fixup run too late.  Instead of the patch above, can
 >> you test the one below?
 >>
 >> You'll likely see something like this, which is a little misleading
 >> because even though we claim "default L1" for 01:00.0 (or whatever
 >> your Radeon is), the fact that L0s and L1 are disabled at the other
 >> end of the link (00:00.0) should prevent us from actually enabling it:
 >>
 >> pci 0000:00:00.0: Disabling ASPM L0s/L1
 >> pci 0000:01:00.0: ASPM: default states L1
 >>
 >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
 >> index 214ed060ca1b..27777ded9a2c 100644
 >> --- a/drivers/pci/quirks.c
 >> +++ b/drivers/pci/quirks.c
 >> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct 
pci_dev *dev)
 >> * disable both L0s and L1 for now to be safe.
 >> */
 >> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, 
quirk_disable_aspm_l0s_l1);
 >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, 
quirk_disable_aspm_l0s_l1);
 >>
 >> /*
 >> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
 >>
 >> —
 >>
 >> Hi Bjorn,
 >>
 >> Thanks for your patch. I patched the RC3 of kernel 6.18 with your 
new patch and compiled it again. Unfortunately the FSL Cyrus+ board 
doesn't boot with your new patch.
 >>
 >> Sorry,
 >>
 >> Christian
 >>
 >> --
 >> Sent with BrassMonkey 33.9.1 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)
 >>
 >> —-
 >>
 >> What about with
 >>
 >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, 
quirk_disable_aspm_l0s_l1);
 >>
 >
 > The issue is most likely with your Root Port rather than with the 
Radeon device.
 > So the quirk for Radeon won't fix the issue properly as it will 
affect other
 > host systems as well.
 >
 > I guess Bjorn's change didn't help because the fixup ran before
 > pcie_aspm_init_link_state(). So even though the fixup disabled the 
ASPM link
 > state for Root Port, it got enabled by the default ASPM states enabled in
 > pcie_aspm_init_link_state().
 >
 > Can you try doing fixup final as below?
 >
 > ```
 > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
 > index d97335a40193..74d8596b3f62 100644
 > --- a/drivers/pci/quirks.c
 > +++ b/drivers/pci/quirks.c
 > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct 
pci_dev *dev)
 >   * disable both L0s and L1 for now to be safe.
 >   */
 >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, 
quirk_disable_aspm_l0s_l1);
 > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0451, 
quirk_disable_aspm_l0s_l1);
 >
 >  /*
 >   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe 
Retrain
 > ```
 >
 > Sorry, I guess we are asking for too many experiments to be done 
which might be
 > of trouble for you. But without direct access to the device, we had 
to do these
 > :(
 >
 > Thanks for your help in debugging.
 >
 > - Mani
 >

I tested your patch with the RC4 of kernel 6.18 today. Unfortunately it 
doesn't solve the boot issue.

- Christian

-- 
Sent with BrassMonkey 33.9.1 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)

