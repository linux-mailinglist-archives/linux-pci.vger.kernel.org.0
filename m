Return-Path: <linux-pci+bounces-16730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33489C8324
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 07:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD951F236BB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89F1E9060;
	Thu, 14 Nov 2024 06:28:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2B1632E7;
	Thu, 14 Nov 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565728; cv=none; b=BK/UsoGAIaYtSy1kh3l0gQUHj1Qy76LqWLWAoPrRRddRe9ICLhbrrlfxS2CagwLu+diKwL7YCOjKVG70yKWpyKoZPoeiqFkvltNchYD2ETuNCClFftWX3O/Kd0j9o+EqeG4nsuSxnzNHeCJUSs8xuioKBjeTZSNMgTqVAA+RcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565728; c=relaxed/simple;
	bh=vlBoSOwvXilp2dG7d2LFG604okbAkj9QIiGpkrwdLEY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ULzWoiWiIQXe5cwwNd0PXc92REN85jkbhRwoE46ZChp2MsQeCk+OelZ2RwAO3HYfpOtS5RA23+YlY32AAYaBDTyBZgLikdWNuJx5SxX/ViT59Fy7aZNUNzZbqAz2tvjxwlqZbpmANTYjIoEB77dYoDp0tbBD1bGRssi4cvNqhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1731565677td9i2fx4
X-QQ-Originating-IP: MQFf11WvFEzut+oeB4G2ojO/800rQ6j2cC39VE37dvA=
Received: from smtpclient.apple ( [115.200.246.212])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Nov 2024 14:27:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3780668568037727963
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH PCI] PCI: Add ACS quirk for Wangxun FF5XXX NICS
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20241112174821.GA1849315@bhelgaas>
Date: Thu, 14 Nov 2024 14:27:44 +0800
Cc: linux-pci@vger.kernel.org,
 netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D914272-CFAE-4B37-A07B-36CA77210110@net-swift.com>
References: <20241112174821.GA1849315@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NRLj+a+1JRyJKtew8dwzP3Cy7HfiEXivvg7X3Kv5wdBSRfxOtEAvh4gW
	7Ov+EW5p59fE2VcAY0Raoxz/HfB3lNtgES53JRIHz9H17BSsRBmc6xpHtZo/AfhrenL8M27
	mDP5w0X1zPo9UsnzqWq5kc3eDvopTK1nGzRXSQRbgrVR2FOCrkAUgUG1aOS4nM+Tp2wYCJR
	trghrcqJkp/Hf/yxLfKwcAJLIrqTr5gza/jfmpBaByL/5Bzq7E85/HqFTltRBf5xaRsfhzX
	2FXW+fUjAcIYtxQFpEBXLHS80oP2RRs1QlpPcHdiT5zoyBkSPBIbN4Xx77pNsLA6Ur57H0M
	/oXnMWJz0uZaDoH4CZlwAjPyN0MuIvIuaFtdMNV0jDicBqVycX3ie99FC+4kEBOXZj1Amnp
	OzrloRAdO5tyxGMWitN9W26R+xzmab6f7s+VGSR5P3u/7Upzs9rBF/kRuoUjssqaz6NEyAK
	d7aaQwoePNAX/ADl42EYnQ+mmdmPNFTaN17OZ4fIbjCe0i7h/yy2Ccav9/KLxQBwHTITMfK
	/NTuYZkMODq1uVmNwfIfrV/feI3TzG+Ve9UYpeKehpwapeFfrq8UYaX+61wF+X/XgDLszsf
	ut5qtauSTxWUdrEFRgDykOqDsO+6E+buxCzoUnVMMfqUYPplwbAGAc2EIOCYuIFQ4pIlrxv
	m2RaxxrzIsm4kEm2mQLMnkdSTioqDt/1g5kbZBJhSviTIxa273oAROOROyT8ETA50yRuAp+
	DXtg8s2EjZn3c3LugkPIL+vhKsb+tWvR7mDomKnHd9/NEeUMADlC6mcdCnNiIxHO38OCnLs
	Dbqn8IVzCnBSTQSBosg6uYFD/VMjWUDSqytoRQsMVGvvvpP1IMLYEVSTc/IHCgfoz+JnB6+
	fSzMQWDXfFfBrEH4yeYgWahIaySwWK3CvwScAEVP1j1GiMpbGrIEXGN5WnqEVbH36Ope3AW
	FnNATbN/tP+rzpTE5QN0poS7z1vbJ3jbLJqDEzdqzPRcAIXSbJ7/c6PNLjDaPB5o1aRw=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0


Thanks for your review. It is indeed accurate.

> 2024=E5=B9=B411=E6=9C=8813=E6=97=A5 01:48=EF=BC=8CBjorn Helgaas =
<helgaas@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Nov 12, 2024 at 07:18:16PM +0800, Mengyuan Lou wrote:
>> Wangxun FF5XXX NICs are same as selection of SFxxx, RP1000 and
>> RP2000 NICS. They may be multi-function devices, but the hardware
>> does not advertise ACS capability.
>>=20
>> Add this ACS quirk for FF5XXX NICs in pci_quirk_wangxun_nic_acs
>> so the functions can be in independent IOMMU groups.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>=20
> I propose the following commit log and comment updates to be clear
> that the hardware actually enforces this isolation.  Please
> confirm that they are accurate.
>=20
>  PCI: Add ACS quirk for Wangxun FF5xxx NICs
>=20
>  Wangxun FF5xxx NICs are similar to SFxxx, RP1000 and RP2000 NICs.
>  They may be multi-function devices, but they do not advertise an ACS
>  capability.
>=20
>  But the hardware does isolate FF5xxx functions as though it had an
>  ACS capability and PCI_ACS_RR and PCI_ACS_CR were set in the ACS
>  Control register, i.e., all peer-to-peer traffic is directed
>  upstream instead of being routed internally.
>=20
>  Add ACS quirk for FF5xxx NICs in pci_quirk_wangxun_nic_acs() so the
>  functions can be in independent IOMMU groups.
>=20
>> ---
>> drivers/pci/quirks.c | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index dccb60c1d9cc..d1973a8fd70c 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4996,18 +4996,20 @@ static int pci_quirk_brcm_acs(struct pci_dev =
*dev, u16 acs_flags)
>> }
>>=20
>> /*
>> - * Wangxun 10G/1G NICs have no ACS capability, and on multi-function
>> + * Wangxun 40G/25G/10G/1G NICs have no ACS capability, and on =
multi-function
>>  * devices, peer-to-peer transactions are not be used between the =
functions.
>>  * So add an ACS quirk for below devices to isolate functions.
>=20
>  Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
>  multi-function devices, the hardware isolates the functions by
>  directing all peer-to-peer traffic upstream as though PCI_ACS_RR and
>  PCI_ACS_CR were set.
>=20
>>  * SFxxx 1G NICs(em).
>>  * RP1000/RP2000 10G NICs(sp).
>> + * FF5xxx 40G/25G/10G NICs(aml).
>>  */
>> static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 =
acs_flags)
>> {
>> switch (dev->device) {
>> - case 0x0100 ... 0x010F:
>> - case 0x1001:
>> - case 0x2001:
>> + case 0x0100 ... 0x010F: /* EM */
>> + case 0x1001: case 0x2001: /* SP */
>> + case 0x5010: case 0x5025: case 0x5040: /* AML */
>> + case 0x5110: case 0x5125: case 0x5140: /* AML */
>> return pci_acs_ctrl_enabled(acs_flags,
>> PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>> }
>> --=20
>> 2.43.2



