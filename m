Return-Path: <linux-pci+bounces-8996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF490F644
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C5B22924
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95244156C69;
	Wed, 19 Jun 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fx0sCGta"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F41BF37;
	Wed, 19 Jun 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822737; cv=none; b=lm1nteGgoFuqg6BqfIt3Jq9g8mBznEe9HrHgEX12FPsQ6DFCeNmu6x0tlzmpEMswHipawVoeS70qwsHMbJUYrCXgsAE7aauCyNuDoF2gGr8D8RvMo0Bl+mKEsir3ehMoZwfQMHsT/sFP69Rqn2KNre+tWsVmT5NImfQu64IWCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822737; c=relaxed/simple;
	bh=Ia3hqiNFJjrEXiQLZriShD9u1T5BdMwUVMDQ+Wmny2k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kFBBKgnrStCHGrTnbDHbt93jbnqEnECysVDejS+grjVZ4zYdj4QZWtifvlVSwEYzWWhD7bb1ll0hu6g/GE8i+HRjgArvvtwwmp8YuyPS1HzvmVjnxh/jAeAv0Q4zxo4QOG1rSZQFYT89MnNUs2FlpkodpKsoiYkLqE3h8Om5ROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fx0sCGta; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718822711; x=1719427511; i=markus.elfring@web.de;
	bh=Ia3hqiNFJjrEXiQLZriShD9u1T5BdMwUVMDQ+Wmny2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fx0sCGta6wM1+wii9V3eUgyxCtjBUIfUM5OxdgpvpkUc3R3AHQglTFwm1T9qzFQN
	 F+vAsB6Yo654bs/oJdh7KmmoX5po1zi+B6lwOY0JGnJ3SDFlBte7G+qkmiK555htg
	 xUfM4JpH0lG0MWjrwIRPbwv6TlbzmYCnrpY/ZvVWcggJOT9bTXL2CnNwyLTIZtX/t
	 n5b103luIz00AtrNIzKG6G9+6FZYuQM7uSYCSZl1KCSDnccXmvkrlM1rIl7Jo4Fk0
	 KYbnkFTERFShM2hI3yQkbyoHgoBrvBrLDWCUBR/Us7FQPvvEqtosX2sobZVnCnbIq
	 hXnvLN7Opg6xBwwk/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgNS-1s6EeC3v5m-006zeE; Wed, 19
 Jun 2024 20:45:10 +0200
Message-ID: <053f4c3b-6eb4-43cc-b424-e91c047c90d5@web.de>
Date: Wed, 19 Jun 2024 20:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mario Limonciello <mario.limonciello@amd.com>, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessos.org>,
 Gary Li <Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20240613054204.5850-3-mario.limonciello@amd.com>
Subject: Re: [PATCH 2/4] PCI: Verify functions currently in D3cold have
 entered D0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240613054204.5850-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnNxF5G4QYP/6L2i8MaVyV9+0yWW+TyhrKaYj7hua4EV7HPhGFV
 nrlAKJl4EWi8uK/xARtFI1NBQjoLF7CrC/PKeYNs+i2PIvKcxOX/H7TTjlTObGij8r7UAFa
 RncsdbG3nwVSNfm00Thj7kyPAinVdm7XIqKugi3JnNWKL22TVgsSCddacyQyIVbq5gMkCh8
 J68ze+R/t3kMo6ShM0f8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IuDUojp5BH8=;lBcI3nKy3SGwl7xI+quO+0HdJ+Z
 +OSVW8Vpc+QsEmy5TvgVh91UPrXmGd2+CJjomn4s4ABEr62uTX/aSIENZe3+3rAsbasLCkVAa
 VbcoCfVorpcyBiVPD5+yDgV6owlDMuPfSmUgn2bJPl2asQI1BcKj37W6oimJ5cvoJ1O0c0xPU
 VEmZ83NZgBlD4onucJgRmpZvEenlJ369E0nIssRUeqQHymTXcXZCNa7JHWb14+V+NHKulJa4I
 cAwSX5AukXGktOEXE6z/peJ4p6sbF5ecpQln/cGYhQxmzMeWZqHFpd9tfz61R9wHv08iZhy41
 /ewTEKDVkavQWCdxfp9EVjAUjzo1K6Gy5pPrt/eAhwoMFhnE80Qv9UmUBs/DMVuuinfdFd5q/
 uB7M8IRNoRJEME4cmQQg1NO1ekKdeVtSTYuosnq5EDuKLuHYPNj6ls+arxlleSoarR63MiTHs
 aoguk1xv08ZLootMHb4EYGw5IGIWxnFJgCaP9nqLHozNEnG7WkultX4VWOWAHaZbO4Rr7CDn9
 yRuiukVf8QuxLGErdOFcH85K2yKJSipg4NH8uQoN/ZgMtXGMtCqKlfpZDbzgIIplwezI0voRu
 idaI5/N5PYmk1T20pW2De5rIc4xKF1vLYsTTn+JMLLHFaEorQ4LBTOsex+ny8z3ruhvjdFAYX
 3IOEXQ+yefewZMgSb15ctqrd8gLL8HvhUdz4s5QTrL9SveuyBTDf/2BtCsrz8Kxz1gs+cl+XN
 OFegjdPiv/d5bA75ORweTmtOMP+iwnjfuyg1kSMFdxQP/W2V/E2JxZApBaiDxzREMZ8z2Vk/O
 hKAsJ1m6MTfO+p1n79c/LhUxJhE6lkNwwl1vBr45cQ3m/SSomMLdXGcXXeDOf4dtrA

=E2=80=A6
> As PCIe r6.0 sec 5.8 specifies that the device will have gone
> through a conventional reset it may take some time for the
> device to be ready.
>
> Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
> in D3cold to return to D0.

Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

Regards,
Markus

