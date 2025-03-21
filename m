Return-Path: <linux-pci+bounces-24414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B8A6C58A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381D048489C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705C232792;
	Fri, 21 Mar 2025 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/JdsjOf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279B235374
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594123; cv=none; b=O7el9L24VMZI4dKe9UyCDySka9oSfQbA4uPNyu6FR7m5LWh48UjBYEe8sxWjhGHGslZpmAeiLHK+6mDJsRRiLOdy5qeDETDA5wVk/a9csLpAivOhbq8ZTxja3S6z5tTibIp1rxFGS11cztejvWzfWFWhaPawTYcdeyO20Sov5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594123; c=relaxed/simple;
	bh=o02ThnHVViLPFR0gsKFoPkl3k9IRTnPEnUsetKSH/w0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=htpvb5MGXTGELvh04RZB872SOJbSeapQBK6LSf1AHjBwemqK1NPu8Hmdd4AsBjeyke/94fUyu/42DCkdMYp8YBJT0/Yg2quA0nUFGyDT25UfXyZrea6BLr9D19rYNVlUkJUS3rLwLCrz6YKyhUZmUveRThfnhSWVy1o0Mdv62Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/JdsjOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29590C4CEE3;
	Fri, 21 Mar 2025 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742594122;
	bh=o02ThnHVViLPFR0gsKFoPkl3k9IRTnPEnUsetKSH/w0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=W/JdsjOfdX81MJ82NNS7tiQ5dWm5mDA7RyDTHv9IwjJfOmG1jPYLYIF6SujMvyLR2
	 kpM+nAtfxVHLnC8GLV73ES6S3xXw6o/6fMu5x9/yAR2/r4q++iuliUxXfrML+mW5Sz
	 wEUGl8arqSrRFi2QTvo+ha8qvOgYdNSiwZodOLXRQxsErGnXI8ke3exv5HtNegtrjn
	 79NmeLGH3+tJY1CNU88ZaLcQhEdGjpleN6eM0CRoFN+K8z0YvyfVUqso25FDaOa20s
	 MATmBojjeV/xNgxR7AV2Pr+Sg6xv78hPon2DuT4/F10fbAqG7qFrRRrcvk4yFqy9lL
	 643WCNS1zeMRA==
Date: Fri, 21 Mar 2025 22:55:22 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org,
 linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 4/7] PCI: endpoint: Add intx_capable to epc_features
User-Agent: K-9 Mail for Android
In-Reply-To: <20250321215034.GA1169728@bhelgaas>
References: <20250321215034.GA1169728@bhelgaas>
Message-ID: <0B197218-4163-4344-8D99-0A90EA6B3CD0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21 March 2025 22:50:34 CET, Bjorn Helgaas <helgaas@kernel=2Eorg> wrote:
>On Mon, Mar 10, 2025 at 12:10:21PM +0100, Niklas Cassel wrote:
>> In struct pci_epc_features, an EPC driver can already specify if they
>> support MSI (by setting msi_capable) and MSI-X (by setting msix_capable=
)=2E
>>=20
>> Thus, for consistency, allow an EPC driver to specify if it supports
>> INTx interrupts as well (by setting intx_capable)=2E
>>=20
>> Since this struct is zero initialized, EPC drivers that want to claim
>> INTx support will need to set intx_capable to true=2E
>>=20
>> Signed-off-by: Niklas Cassel <cassel@kernel=2Eorg>
>> ---
>>  include/linux/pci-epc=2Eh | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/include/linux/pci-epc=2Eh b/include/linux/pci-epc=2Eh
>> index 9970ae73c8df=2E=2E5872652291cc 100644
>> --- a/include/linux/pci-epc=2Eh
>> +++ b/include/linux/pci-epc=2Eh
>> @@ -232,6 +232,7 @@ struct pci_epc_features {
>>  	unsigned int	linkup_notifier : 1;
>>  	unsigned int	msi_capable : 1;
>>  	unsigned int	msix_capable : 1;
>> +	unsigned int	intx_capable : 1;
>
>Kernel-doc warning:
>
>  $ find include -name \*pci\* | xargs scripts/kernel-doc -none
>  include/linux/pci-epc=2Eh:239: warning: Function parameter or struct me=
mber 'intx_capable' not described in 'pci_epc_features'

I will send a fix=2E


>
>I'm actually not sure why we merged this, since there's nothing in the
>tree that sets intx_capable to anything other than false=2E  Maybe
>there's something coming?

See
https://web=2Egit=2Ekernel=2Eorg/pub/scm/linux/kernel/git/pci/pci=2Egit/co=
mmit/?h=3Dendpoint-test&id=3D5ce641b3ddb8aec9be4bea72e0cd97d2c0ff54a4


>
>Bjorn

