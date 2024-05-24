Return-Path: <linux-pci+bounces-7809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027DE8CE22E
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FC11C2164A
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35CF1292C1;
	Fri, 24 May 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="asy8Zhyx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC94823BF;
	Fri, 24 May 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538638; cv=none; b=FN32z03rFqRR/Z9bJS7xSAFRNd+EBRCtFONeL72BxuL+Juq6BLvBDZda3Z9Wvc+a5hXijkjOIcKZ+IqfWSUPiK4wdXQGc/BbD3MRSTboVkJgCgGK5B1dyhfWBZooyFCYb9nf1mdTK/FeDQfJfc2aFU+liYKRvLm8Tm5yrFgGVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538638; c=relaxed/simple;
	bh=MxVQUC14yschSSMleujjxz9d8txwkDZPaW0ma//Zd/4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VwwfU41954olfhDIJ0Ft8PHfz+k9lQ/QPVzpa55OEsgnPqjrIRjbdCxrWKfE/mxGMw6Bf9wjlSuWuhQrjBQt9oF0FoYH2KlA1VxiOqiLZ6xXETDOF9a/dMCWuQXsU4iqPsUlh343SThyrmCSIgFJc+Qf9dNEaPly2UJbox2wwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=asy8Zhyx; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716538601; x=1717143401; i=markus.elfring@web.de;
	bh=LRPr7yjZvhwm7ZLpTstw9sTNj/eN71td1oPbmzelILU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=asy8ZhyxYGB+uRRwYY6s+TGZzAti3roXldrGgbTA9rvExSzYv7MT9Q99zKjk+lUI
	 G1Co2taD2EhV6x58W6mcucbbdBN4yUe3TQ1CySVQzMVxKKSUJC1mqt+YhlYT0BCzI
	 HN1W+8dxiPCuZYF7g5FS0oWlcSCLt2bvtZ2NtE95+tGor05xvahMeUtlAFJCyNhaO
	 zSEeuAohaQsvW9ygZvcIRa3O8VM5bGo2bVt0f4BLrAwP6nPisEBgEcq3N9OWAl9vo
	 Zykj9aj9z2LU96VHYy0oJigvCjNXEwZVznSiIC7OcQBdwt8iWAJJlN1AXpbAv2pt+
	 VtkVelNwT54jZnWeuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqXM-1s5QOt28MA-00UNap; Fri, 24
 May 2024 10:16:41 +0200
Message-ID: <89d6acd5-5008-4db3-927c-d267be7b9302@web.de>
Date: Fri, 24 May 2024 10:16:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Anderson <sean.anderson@linux.dev>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-7-sean.anderson@linux.dev>
Subject: Re: [PATCH v3 6/7] PCI: xilinx-nwl: Add phy support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240520145402.2526481-7-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cE4BK/TlEIWznR0yJJG1Mw+1L/RvLYJpbxs5JJibDf8v7I4j1xq
 qtWAG8K0r13kdXIyb0dbR32q+FjS6ztm5L9L3V05pq18A2TRdQnBgChivDZIs/LHo0nDh8g
 n5KUmmSJTL9IxMbSK77kVHPJmhoTtOp+6kN6AYkrC/Gpf3cYaG8NtPWKPAAREec+9Clvofv
 Chp3luokxr4/MS23rIpNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PN1gnFD9Q7Y=;tVJwVm/MenJkE3GK4r0Z5NzJ9vE
 /kRwKidoUc3CPlt0JlzsngMpQWWHmYQdrPrvXgau8aeU25/xL7t1TEUX0C1p7bKnyPD0tU/gP
 o7rk/0RtmOM91vQR1+U4D3cwt/eQalo4dHzPI6Amio8kkgpx6m3q6fa+9lffjBGrlLISjEHSw
 /YzjWmiPDb+g5K3OkYjrZBhBbYDyyXMPc6kITl0EhwshPCHGmqpHYPfKsDMRmuR/g7fWB8wD4
 9lbiZY1+FEnow9ZnRuCeGNtKW671tY0rlYj5V30wyz3Slg+1LTq56zjGNgH40DPNg6qSaymke
 Oh2XQj2RgJCFv0jQGe18Zr3mvF9woULE3kSUheXq9OG2Bw/P5b9pAt/XAxnm+5NxY8M3dJhpU
 yJTWXAmmbFbJ7XT8WwMjaxWnjrJ1pM/+prMQBjewMtxkrOSr+NW9ENfL3YqDOjR2HajazIzD2
 fLGBdITrZT4zxXftsuT5AEUk/Y5ijoY6zJvNxyZbUUY2OP4em5tlLZeZtXqyd8tdDa71ikMQK
 xhtmQBOhtUU/bcuvxRXbbwm/T+Ur77XvCy9Rcp6B/izskWUVE8KTN91NDCiXhau1J8gBggXrn
 +Z0bVgb+ICmdhOp4MOEFnVKRLht+1XuZeTNzP7wr0eGkIrXwPLK28gGnn2mK8gqAhatRGx2Bk
 iJpGEjoidsy7eANSmmQBoK6G0N33d88UYQi9UnGLdNhcySvcd8XWFnu5DoS3mtfgc9O7ajBUt
 GVFBgYGFvRQhd3rr9wejSmrKowkPQmlWCMkvUgTU7mE8tUcKA0FDfG584CD4tPBu2VfffUMNn
 8fWkQei5QWyecRJ2z0OfQwtk6f91Ttr1or7h59G23USmQ=

> Add support for enabling/disabling PCIe phys. We can't really do
> anything about failures in the disable/remove path, so just warn.
=E2=80=A6
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
=E2=80=A6
> @@ -818,12 +876,15 @@ static int nwl_pcie_probe(struct platform_device *=
pdev)
>  		err =3D nwl_pcie_enable_msi(pcie);
>  		if (err < 0) {
>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
> -			goto err_clk;
> +			goto err_phy;
>  		}
>  	}
>
>  	err =3D pci_host_probe(bridge);
>
> +err_phy:
> +	if (err)
> +		nwl_pcie_phy_disable(pcie);
>  err_clk:
>  	if (err)
>  		clk_disable_unprepare(pcie->clk);

I got the impression that some source code adjustments should be performed
in another separate update step for this function implementation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n81

You propose to extend the exception handling here.
Does such information indicate a need for another tag =E2=80=9CFixes=E2=80=
=9D?

How do you think about to increase the usage of a corresponding goto chain=
?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Would you become more interested in the application of scope-based resourc=
e management?

Regards,
Markus

