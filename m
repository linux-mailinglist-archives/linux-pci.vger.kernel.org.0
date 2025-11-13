Return-Path: <linux-pci+bounces-41075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE3C56C9C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AB4E9B9C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15362FF648;
	Thu, 13 Nov 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dx4L72BG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vRMchbv0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C85305044;
	Thu, 13 Nov 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028807; cv=none; b=hAcst7SQkai1NiaUg1iMEI9Qa1pXE/+8RMoRAREHLzJf7lZLLDnKNpFKNO+yusslKLpUT5tZXbLpn7idQYXtsBL89QOPTdFw8ldsxsG1/2NHK3onWFs3FhbEFkNbcjJwjpEFv7cTj5HgyVCNgs7SmM3eQFnxRTsodIIpoDQm4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028807; c=relaxed/simple;
	bh=3wdKEAz/9cBOlM86QatywL0i7JyUxxjh85cq7JJLyi4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SOfmRHqbSR3v6SBjBFU80MHzU6bXOPkCwPkuDC10XKbW6kR44uDrSRYjUAc/ijAjs1xeBQj1g7f55TmtYvk6M91eYoNHTYV17zo8w68VUAcq43g4jTCpzW8NojUjAHEpDvV/ECOKO7FyaDXOMlJ722YC1w0I03iibnuajNrZvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dx4L72BG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vRMchbv0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E525A140016D;
	Thu, 13 Nov 2025 05:13:23 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 05:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763028803;
	 x=1763115203; bh=eBsaFtA2xBcklMBM2lcRD3QQiiT0+IpJhfUOqJ08udk=; b=
	dx4L72BG/Weyjy69zTnbObR32UfXg1Kw8iNWEtEAsc5ctiYB9KiV+Y5KHXKAAFyV
	znTtPr97A7XPqUq6kqTG0t4x99wH0CL0wo/+Io92jdFb+M9ltLQjRLpoPtFnMpab
	uIharEfdRj55SEfwSiacBpy1LhsYiikhOnXYysamSQrk6+RqhNZh/VfIEkVDpPoV
	Ggsu1ixpcpYPec3hKZJ+kqvRxsC81YJ1j7EyK61SKZ6djuLHixpcJ6NjlGzhqBwB
	ySqAiolMiio8+z/7Sw085mu9UwA88QaYT9qIpnhwIEHk+BTOPQgbvv4X0SUjvwlE
	HBmXzg//bKE7FUKziXnKIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763028803; x=
	1763115203; bh=eBsaFtA2xBcklMBM2lcRD3QQiiT0+IpJhfUOqJ08udk=; b=v
	RMchbv0sISLH4MACLD2Xur8OemJoKpH/lrUkmb2bd06oHzddVHR9Jh6Y7wTEf9SV
	UPl9b5NoPy8Ud9grx8HXjADs9RFvs45cR0/bBzgELXkdBdMwsN0chXusr646LhlM
	Z0jF7I4izj996Y5tUh4VJkhdqyQM1Tco/J8Fy/eWwZCkdT0ghxcnkhAzmQgr0Kcj
	iEQagtz9GgaB3r1kojoaWWUXGl1BiIhu08/vJTUKCMm9HlI7f4neW2N6YjORV3G0
	EssG57zQTapGcEaNqzv0uFAzGMc9U1MO652ZRYRBtn1zyLOTYaofyYjIe7RHe91+
	Uim604CkGUgpDyJ0j1JIw==
X-ME-Sender: <xms:Q68VaSHBnABlehvIB8HPLW1ZPP6tZIr4l4xh6kr1kC9kKKzEywDbgA>
    <xme:Q68VaeK0PJywiAn5sO0QtCbhWtpa4C6k-C1LKuTzyX5bfrjrBpD7MgOsquQjAGuPh
    7xBxjzgvlJBGWEjJYhsmwvos-8QjSPCa460qPCjU7sHm8CzpWV0UcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvghlghgrrg
    hssehgohhoghhlvgdrtghomhdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhifihhltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhpihgvrhgrlhhishhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghniheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehunhhitghorhhnpgifrghnghesohhuth
    hlohhokhdrtghomhdprhgtphhtthhopehsqdhvrggurghprghllhhisehtihdrtghomh
X-ME-Proxy: <xmx:Q68VafAHyv8bK6Ia8xhwRSoZVJZ-23YfWweBZ8eMyvWbXODYpACFVg>
    <xmx:Q68VaatI5w3AsYwXW5HDHo4k-RdK6zja_vVWsVXJ8gWGFG6YFWdmGg>
    <xmx:Q68Vad8a0h3ovFMUiJiwnhwyAPdtiKYPFGlTB08M6a7RPOIDx1Rfdw>
    <xmx:Q68VaRQKTDzHimbKtlnbdrZjMFhicrKweFiiliNmy2Ndb_wdL1U8LQ>
    <xmx:Q68Vaevt84g7sRauZ_invuhu7qkg2Yo7dhzae9iFqMsr3pCTZAV471Hv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02C82700054; Thu, 13 Nov 2025 05:13:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO4N9SNPwumV
Date: Thu, 13 Nov 2025 11:13:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Chen Wang" <unicorn_wang@outlook.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
Message-Id: <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
In-Reply-To: <20251113092721.3757387-1-s-vadapalli@ti.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from tristate
 to bool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 13, 2025, at 10:27, Siddharth Vadapalli wrote:
> The drivers associated with the PCIE_CADENCE, PCIE_CADENCE_HOST AND
> PCIE_CADENCE_EP configs are used by multiple vendor drivers and serve as a
> library of helpers. Since the vendor drivers could individually be built
> as built-in or as loadable modules, it is possible to select a build
> configuration wherein a vendor driver is built-in while the library is
> built as a loadable module. This will result in a build error as reported
> in the 'Closes' link below.
>
> Address the build error by changing the library configs to be 'bool'
> instead of 'tristate'.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

I really think there has to be a better solution here, this is not
an unusual problem.

> @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
>  	depends on PCI
> 
>  config PCIE_CADENCE
> -	tristate
> +	bool
> 
>  config PCIE_CADENCE_HOST
> -	tristate
> +	bool
>  	depends on OF
>  	select IRQ_DOMAIN
>  	select PCIE_CADENCE
> 
>  config PCIE_CADENCE_EP
> -	tristate
> +	bool
>  	depends on OF
>  	depends on PCI_ENDPOINT
>  	select PCIE_CADENCE

I think the easiest way would be to leave PCIE_CADENCE as
a 'tristate' symbol but make the other two 'bool', and then
adjust the Makefile logic to use CONFIG_PCIE_CADENCE as
the thing that controls how the individual drivers are built.

That way, if any platform specific driver is built-in, both
the EP and HOST support are built-in or disabled but never
loadable modules. As long as all platform drivers are
loadable modules, so would be the base support.

     Arnd

