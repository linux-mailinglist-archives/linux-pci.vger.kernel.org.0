Return-Path: <linux-pci+bounces-39199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C151DC034A4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 21:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A33054E020F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C9262815;
	Thu, 23 Oct 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="FAx83wLm"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4434DB4F
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249592; cv=none; b=pPrYmUFgmCAkkbW/TNNxVAzE3ptng2WuLqN2+NPON7lQnv9Ajf3fKCn7KXxLzRZFDmcjhj+5vf5qLI/PooFQ/UD80PzNaF9/ReR3/CO6p5HvmGTRJO8ykNuZexn70llnWaoESHhuFHfjkVGgOuYtYFze2i9fj3dsNmHN9I/bs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249592; c=relaxed/simple;
	bh=KPzIcFnwhY+ZYXg92oZmg5eJtfaSYWhkN9sEGWv35nA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DIQr+CCqMIqLKZQS/GFuAD9bAbsb3Hxye8PU0Nq7quWSv/eef+vt7LPxlLwqXpDPZo+I3yd1QQeu5kUomhM9LCjKf4iH+QjGqL7+OevIqVblRRvZT99WC/8c3dLa/1D/Q+kQGg8JHnHr/ORIIsMBUJrm/oBERmtqNZHRrjIXRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=FAx83wLm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761249586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgxdqITMBs00FQyE9iN8057v5JaTnH//cBeV6brPCVM=;
	b=FAx83wLmSxmeeIh8xhbvx7NV8H8ME4sOm04wFh3yX8CqoDb+JR3rVgdw9ByzAc5dcW2uuw
	sWHbz82IkCTUIT6NDRiwI2ip6gppXSBenLAoXg47wiiB3GzrNEVbexknCYvbeKU1vuFAJ7
	QbA0Lnf8gVovdiudJUXytMghBck2gu+emD1Sxzpom7YRfJQ3F6Cn0SAyn0QHMc9TdvQfIW
	jSWzWYX3bwoMY+QUNW5XByBQTh7eu0rk/rhDkFPVRbC52T63eHoZFZWrLVWeef3SY0nDQn
	60A5YIkLV8furs5XZ9kZHtjzkaHURWLlMoppLrW0dQs+dP1bIsua4w/xJ9+0Xw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 21:59:41 +0200
Message-Id: <DDPYVBSYR01V.1OSGKL2X8LT82@cknow-tech.com>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>,
 "Christian Zigotzky" <chzigotzky@xenosoft.de>, "FUKAUMI Naoki"
 <naoki@radxa.com>, "Herve Codina" <herve.codina@bootlin.com>, "Diederik de
 Haas" <diederik@cknow-tech.com>, "Dragan Simic" <dsimic@manjaro.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-rockchip@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree
 platforms
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20251023180645.1304701-1-helgaas@kernel.org>
 <20251023182525.GA1306699@bhelgaas>
In-Reply-To: <20251023182525.GA1306699@bhelgaas>
X-Migadu-Flow: FLOW_OUT

Hi Bjorn,

Thanks for the patch :-)

On Thu Oct 23, 2025 at 8:25 PM CEST, Bjorn Helgaas wrote:
> On Thu, Oct 23, 2025 at 01:06:26PM -0500, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>=20
>> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetr=
ee
>> platforms") enabled Clock Power Management and L1 PM Substates, but thos=
e
>> features depend on CLKREQ# and possibly other device-specific
>> configuration.  We don't know whether CLKREQ# is supported, so we should=
n't
>> blindly enable Clock PM and L1 PM Substates.
>>=20
>> Enable only ASPM L0s and L1, and only when both ends of the link adverti=
se
>> support for them.
>>=20
>> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for d=
evicetree platforms")
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xen=
osoft.de/
>> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
>> Closes: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-98=
18-3bb2b311da0b@radxa.com/
>> Reported-by: Herve Codina <herve.codina@bootlin.com>
>> Link: https://lore.kernel.org/r/20251015101304.3ec03e6b@bootlin.com/
>> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
>> Link: https://lore.kernel.org/r/DDJXHRIRGTW9.GYC2ULZ5WQAL@cknow-tech.com=
/
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
>
> Provisionally applied to pci/for-linus, hoping to make v6.18-rc3.
>
> Happy to add any testing reports or amend as needed.

My build with your patch (on top of 6.18-rc2) just finished, so I
installed it and rebooted into it.
Happy to report that everything seems to be working fine and I can't
find any errors, warnings or other messages with 'nvme' in dmesg that
indicate sth could be wrong. IOW: it does indeed fix the issue I
reported earlier. So feel free to add my:

Tested-by: Diederik de Haas <diederik@cknow-tech.com>

Cheers,
  Diederik

>> ---
>> I intend this for v6.18-rc3.
>>=20
>> I think it will fix the issues reported by Diederik and FUKAUMI Naoki (b=
oth
>> on Rockchip).  I hope it will fix Christian's report on powerpc, but don=
't
>> have confirmation.  I think the performance regression Herve reported is
>> related, but this patch doesn't seem to fix it.
>>=20
>> FUKAUMI Naoki's successful testing report:
>> https://lore.kernel.org/r/4B275FBD7B747BE6+a3e5b367-9710-4b67-9d66-3ea34=
fc30866@radxa.com/
>> ---
>>  drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
>>  1 file changed, 9 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 7cc8281e7011..79b965158473 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -243,8 +243,7 @@ struct pcie_link_state {
>>  	/* Clock PM state */
>>  	u32 clkpm_capable:1;		/* Clock PM capable? */
>>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
>> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
>> -					   override */
>> +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>>  };
>> =20
>> @@ -376,18 +375,6 @@ static void pcie_set_clkpm(struct pcie_link_state *=
link, int enable)
>>  	pcie_set_clkpm_nocheck(link, enable);
>>  }
>> =20
>> -static void pcie_clkpm_override_default_link_state(struct pcie_link_sta=
te *link,
>> -						   int enabled)
>> -{
>> -	struct pci_dev *pdev =3D link->downstream;
>> -
>> -	/* For devicetree platforms, enable ClockPM by default */
>> -	if (of_have_populated_dt() && !enabled) {
>> -		link->clkpm_default =3D 1;
>> -		pci_info(pdev, "ASPM: DT platform, enabling ClockPM\n");
>> -	}
>> -}
>> -
>>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int black=
list)
>>  {
>>  	int capable =3D 1, enabled =3D 1;
>> @@ -410,7 +397,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
>>  	}
>>  	link->clkpm_enabled =3D enabled;
>>  	link->clkpm_default =3D enabled;
>> -	pcie_clkpm_override_default_link_state(link, enabled);
>>  	link->clkpm_capable =3D capable;
>>  	link->clkpm_disable =3D blacklist ? 1 : 0;
>>  }
>> @@ -811,19 +797,17 @@ static void pcie_aspm_override_default_link_state(=
struct pcie_link_state *link)
>>  	struct pci_dev *pdev =3D link->downstream;
>>  	u32 override;
>> =20
>> -	/* For devicetree platforms, enable all ASPM states by default */
>> +	/* For devicetree platforms, enable L0s and L1 by default */
>>  	if (of_have_populated_dt()) {
>> -		link->aspm_default =3D PCIE_LINK_STATE_ASPM_ALL;
>> +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>> +			link->aspm_default |=3D PCIE_LINK_STATE_L0S;
>> +		if (link->aspm_support & PCIE_LINK_STATE_L1)
>> +			link->aspm_default |=3D PCIE_LINK_STATE_L1;
>>  		override =3D link->aspm_default & ~link->aspm_enabled;
>>  		if (override)
>> -			pci_info(pdev, "ASPM: DT platform, enabling%s%s%s%s%s%s%s\n",
>> -				 FLAG(override, L0S_UP, " L0s-up"),
>> -				 FLAG(override, L0S_DW, " L0s-dw"),
>> -				 FLAG(override, L1, " L1"),
>> -				 FLAG(override, L1_1, " ASPM-L1.1"),
>> -				 FLAG(override, L1_2, " ASPM-L1.2"),
>> -				 FLAG(override, L1_1_PCIPM, " PCI-PM-L1.1"),
>> -				 FLAG(override, L1_2_PCIPM, " PCI-PM-L1.2"));
>> +			pci_info(pdev, "ASPM: default states%s%s\n",
>> +				 FLAG(override, L0S, " L0s"),
>> +				 FLAG(override, L1, " L1"));
>>  	}
>>  }
>> =20
>> --=20
>> 2.43.0
>>=20


