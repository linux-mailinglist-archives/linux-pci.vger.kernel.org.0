Return-Path: <linux-pci+bounces-37116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893ACBA4C2A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA391189FA12
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3630CB52;
	Fri, 26 Sep 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNGR1qfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026030CB50;
	Fri, 26 Sep 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906879; cv=none; b=Bi/O+gEx/2C+HpxYXtwWYF5qXWiSBog+LkLcUJS5BTnJzIR21eqUUrqDxCBLByA5O2Pkm7MsL5UHEI2yLKYhGTcX5CwdaMCUPOxfiDbWPMMw0JeAHcovECh5lzS7YvTJxwusdZ3lcqHjM6YmyJARg0m/lUY9fepHvXfGovWaN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906879; c=relaxed/simple;
	bh=ACLLyTH6WzBUIy6EmJzPFE4VsZS26yNgY1PV+Hi3dKY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D3LW1Nxs9rz/0s9qkpznoNFUO1ZMGquH4oKev+gyZLavwfAeQoXQvswrGy5sLtHRSTo4tlWfW13wxJjQnCQF0NDexCILhoBROMNrcrZ/bp/XjlwEwv9sujq7hmZzA8aHryWEEby/aCw4b/OTe8NgSPsQeBWCi/vl7wDtcr4w9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNGR1qfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E54C4CEF4;
	Fri, 26 Sep 2025 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758906878;
	bh=ACLLyTH6WzBUIy6EmJzPFE4VsZS26yNgY1PV+Hi3dKY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sNGR1qfG42JFYCO5k/n7dorfGNrwgbW3MmFZpb9Bh9LRS0VuauOd+I8wsQI055OJ5
	 0+USKbkaWUCDwGKK/ytGyq6CdleSufXYI47qWpWuVptTTjWVJFVLMgoAHtcPQomU1K
	 j/zEtcH2r6x8k1F0VfjzYHyMkj6Db8CJ+5awYzyRRP+HW/3wkHqAUxF0mmwvUtJtyG
	 ZY1yEIy1hsMp+lOMFX48jaWUGvKKyshAPbU9S1PUwUp1l8Idqo02JVsEZhXwB0wswL
	 ttDs7oQx2yu6TLYdAh/5u1eA1n+DSo6OK0qKBA3TjC71rlacqDcwscaYFjUWu8f8va
	 fPjiQa5UVfOAw==
Date: Fri, 26 Sep 2025 19:14:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
CC: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
 imx@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_PCI=3A_endpoint=3A_Add_help?=
 =?US-ASCII?Q?er_function_pci=5Fepf=5Fget=5Fbar=5Frequired=5Fsize=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <aNbI+KrPJW4kgy4e@lizhi-Precision-Tower-5810>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com> <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com> <aNaHrj0rwLTtSRS3@ryzen> <aNaprpfaeXIcqeGD@lizhi-Precision-Tower-5810> <aNauaSVs5ytzsVFt@ryzen> <aNbI+KrPJW4kgy4e@lizhi-Precision-Tower-5810>
Message-ID: <924D03A9-0206-4FCA-AE83-4724643561C2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26 September 2025 19:10:16 CEST, Frank Li <Frank=2Eli@nxp=2Ecom> wrote:
>On Fri, Sep 26, 2025 at 05:16:57PM +0200, Niklas Cassel wrote:
>> On Fri, Sep 26, 2025 at 10:56:46AM -0400, Frank Li wrote:
>> > On Fri, Sep 26, 2025 at 02:31:42PM +0200, Niklas Cassel wrote:
>> > > On Thu, Sep 25, 2025 at 01:01:47PM -0400, Frank Li wrote:
>> > > > Introduce pci_epf_get_bar_required_size() to retrieve the require=
d BAR
>> > > > size and memory size=2E Prepare for adding support to set an MMIO=
 address to
>> > > > a specific BAR=2E
>> > > >
>> > > > Use two variables 'aligned_bar_size' and 'aligned_mem_size' to av=
oid
>> > > > confuse=2E
>> > >
>> > > s/confuse/confusion/
>> > >
>> > >
>> > > >
>> > > > No functional changes=2E
>> > > >
>> > > > Signed-off-by: Frank Li <Frank=2ELi@nxp=2Ecom>
>> > > > ---
>> > > > change in v3
>> > > > - change return value to int=2E
>> > > > - use two pointers return bar size aligned and memory start addre=
ss aligned
>> > > > - update comments about why need memory align size=2E Actually iA=
TU require
>> > > > start address match aligned requirement=2E Since kernel return al=
ign to
>> > > > size's address=2E
>> > > > - use two varible aligned_bar_size and aligned_mem_size to avoid =
confuse
>> > > > use 'size'=2E
>> > > >
>> > > > change in v2
>> > > > - new patch
>> > > > ---
>> > > >  drivers/pci/endpoint/pci-epf-core=2Ec | 84 +++++++++++++++++++++=
++--------------
>> > > >  1 file changed, 53 insertions(+), 31 deletions(-)
>> > > >
>> > > > diff --git a/drivers/pci/endpoint/pci-epf-core=2Ec b/drivers/pci/=
endpoint/pci-epf-core=2Ec
>> > > > index d54e18872aefc07c655c94c104a347328ff7a432=2E=2E2cd0257831f98=
85a4381c087ed8f3326f5960966 100644
>> > > > --- a/drivers/pci/endpoint/pci-epf-core=2Ec
>> > > > +++ b/drivers/pci/endpoint/pci-epf-core=2Ec
>> > > > @@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf=
_pf, struct pci_epf *epf_vf)
>> > > >  }
>> > > >  EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
>> > > >
>> > > > +static int
>> > > > +pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
>> > > > +			      size_t *aligned_bar_size,
>> > > > +			      size_t *aligned_mem_size,
>> > > > +			      enum pci_barno bar,
>> > > > +			      const struct pci_epc_features *epc_features,
>> > > > +			      enum pci_epc_interface_type type)
>> > > > +{
>> > > > +	u64 bar_fixed_size =3D epc_features->bar[bar]=2Efixed_size;
>> > > > +	size_t align =3D epc_features->align;
>> > > > +
>> > > > +	if (size < 128)
>> > > > +		size =3D 128;
>> > > > +
>> > > > +	/* According to PCIe base spec, min size for a resizable BAR is=
 1 MB=2E */
>> > > > +	if (epc_features->bar[bar]=2Etype =3D=3D BAR_RESIZABLE && size =
< SZ_1M)
>> > > > +		size =3D SZ_1M;
>> > > > +
>> > > > +	if (epc_features->bar[bar]=2Etype =3D=3D BAR_FIXED && bar_fixed=
_size) {
>> > > > +		if (size > bar_fixed_size) {
>> > > > +			dev_err(&epf->dev,
>> > > > +				"requested BAR size is larger than fixed size\n");
>> > > > +			return -ENOMEM;
>> > > > +		}
>> > > > +		size =3D bar_fixed_size;
>> > > > +	} else {
>> > > > +		/* BAR size must be power of two */
>> > > > +		size =3D roundup_pow_of_two(size);
>> > > > +	}
>> > > > +
>> > > > +	*aligned_bar_size =3D size;
>> > >
>> > > I think this name is wrong=2E
>> > > The BAR size has not been aligned to anything=2E
>> > > The BAR size has to be a power of two, but that is a requirement of=
 the PCI
>> > > specification, so that in an inherent property of a BAR=2E
>> > >
>> > > Perhaps just name it size or bar_size?
>> >
>> > there already have 'size' for input=2E  It should match epc required'=
s size=2E
>>
>> Why do you need both "size_t size" and "size_t *bar_size"?
>>
>> Isn't it enough with "size_t *bar_size" ?
>>
>> The user can supply a value, and the function could update that value=
=2E
>
>If not 'aligned_mem_size' in list, it looks fine=2E But after add
>'aligned_mem_size', I think use difference varible for two outputs will b=
e
>clear and consistent and easy to understand=2E


What am trying to say is:
Why not make "size_t *bar_size" both an input and an output?


Kind regards,
Niklas

