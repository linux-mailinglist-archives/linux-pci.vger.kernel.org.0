Return-Path: <linux-pci+bounces-10664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC0A93A489
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B45283C35
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD8157E9F;
	Tue, 23 Jul 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBIssWQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B6157E82;
	Tue, 23 Jul 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753313; cv=none; b=YMfAeRDN5zegn6cMyOfyorwiVucInDXobmIqy/ii8ewuD0jqYYv0d+pScWvjfjNUleXidsSyomCsDWT31q4QnRtMnTHghf9iCbK4Hv22+QLwdECPSAep/wPw2SRc8Fc0Lh88kmTF2LdmALwxkgfc4A12CRC5w4CX44aljauFFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753313; c=relaxed/simple;
	bh=8Hy8pF3WCuIwrpElFCaU60GJnSjQi+h3DxZ8tBufKZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNDKrEFxr7HqKhC8wTpzWbFG4WyC+EI9g+A1UNuQ5rGYvLqpc3TE+iFOiX17lBo2pJ001Z2bwjg1xmEzRKiT6X+9KW8c0G8pXy8WkJ72+qU91eNQiBTS9opex7aBvAqfU8eC/QlJXC0dDY1s24gn0TM+kjIu487Mfur60qAl8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBIssWQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498DFC4AF09;
	Tue, 23 Jul 2024 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721753312;
	bh=8Hy8pF3WCuIwrpElFCaU60GJnSjQi+h3DxZ8tBufKZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBIssWQHsUc9ihkSZKAB5Hc6FoC2QyjSYwTIdNxakSU1zh8VbdL5CDuvdB25JQZRA
	 miyZ9TkgSTTsQxKbxNZ/cnjStZt1U9Ff6LarHKHVDy2b4CL6NLfvdF406NuwIaTqqQ
	 o3M1V2jPaPoTAfwyM/J4o55v4LXYBX9QPhrBz2JOUbuLCmMfmiInRmVnFZaHRWBfSp
	 ljOdPbd4i1D2j5sBJDeTw8Rv2BnNpxpyuQt6SY2h1mhYrBxszRiR/FbkP25ktqivmy
	 rWe1Yf3iF+CKx76PIdkC3Fh2eeOoeRipfz9T3Y/o+rGV29ow9vKoTLuOlDbUnK5PUM
	 GA7AfJi4/x1CQ==
Date: Tue, 23 Jul 2024 18:48:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>

Hello Rick,

On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> >
> > But like you suggested in the other mail, the right thing is to merge
> > alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
> > currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
> > instead.)
> >
> 
> Yes, if we merge both, the code will need to be in the EPC code
> (because of the set_bar), and then the pci_epf_alloc_space (if needed)
> would be called internally in the EPC code and not in the endpoint
> function code.
> 
> The only downside, as I said in my other mail, is the very niche case
> where the contents of a BAR should be moved and remain unchanged when
> rebinding a given endpoint function from one controller to another.
> But this is not expected in any endpoint function currently, and with
> the new changes, the endpoint could simply copy the BAR contents to a
> local buffer and then set the contents in the BAR of the new
> controller.
> Anyways, probably no one is moving live functions between controllers,
> and if needed it still can be done, so no problem here...

I think we need to wait for Mani's opinion, but I've never heard of anyone
doing so, and I agree with your suggested feature to copy the BAR contents
in case anyone actually changes the backing EPC controller to an EPF.
(You would need to stop the EPC to unbind + bind anyway, IIRC.)

Converting pci-epf-test to a new alloc_and_set_bar() API/helper which is
done at .epc_init()-time instead of at .bind()-time shouldn't be too hard.

pci-epf-ntb and pci-epf-vntb looks a lot less trivial, but perhaps it is
okay to convert pci-epf-test, and let the other more complex EPF drivers
continue to use the lower-level APIs.


Kind regards,
Niklas

