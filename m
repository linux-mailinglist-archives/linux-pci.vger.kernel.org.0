Return-Path: <linux-pci+bounces-16175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E729BF947
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5E91F228F2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42420CCE7;
	Wed,  6 Nov 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SwVTNY+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic317-27.consmr.mail.bf2.yahoo.com (sonic317-27.consmr.mail.bf2.yahoo.com [74.6.129.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9220823B
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932092; cv=none; b=YDqCDjTAGAce7sLRkXD3cXdnQLvpaITWqLLwk5YOmgA689a1BEXCj5B5MIX1RXj4ptlSeFGAui9t5FXSE1kVysWEHsLrmu46HaH/C+WpWHTt20TNiSxyNZJUoE0sKntXm/5GopybxszTVmjPMbn1mES45nVRJXNRAnNQNM1mzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932092; c=relaxed/simple;
	bh=EA/lPnH9otYvl6FzA9VYaQsrRcEk6OlWnGxMmdvL1iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIZxTjLun3K7HdUh1YJ0P1pNSV4V9nZWwhyMiUqIJ5/BINChEp1K6Qb4I/1t9aCusKMoaTX87AbFhewTGlqhFh++NVhLnAapiWx1NI/ldqMq3xcdlOdRuBolB5BuwR3sLT6fvmtg72Vfwa32RfIKhnMvaopENuHz3gDeCh/vB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SwVTNY+t; arc=none smtp.client-ip=74.6.129.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730932084; bh=DOcyxH1IqBNtp7YaPG/qJu/pI2g+2zU5YxvnVc7S7F4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SwVTNY+tuQEypjxDwyajrITEyORypK/7D1MsHvxEzW35/2mz1i7g9uM3RhU6fBQrOCAP16CLMU9teKGnu9IGm/KgZJ7nwXVHd1rQVxEfeFMiK8/bVCLyTMPNxRx6YRPwuzBnueGP/1Bir17hQnHyXrRB6BWQHdlEvCO/SBn/mXx7Q4DapBIcX3EfHH/oUYgcf1KqwZOkapSLdm9tXelFmYSyVFhNBWmKRcRiyrYtOUfYW9jZPyR5RhrEL5Jeuc337p6jAIliqQB6+wwpyDvcVe2J23E+2IrBJlOpZ9dRb/sdWQZfSFxZZ9tRG0yTYN9dFI5aYtjTsncsU9GRay0M5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730932084; bh=0k0gNQHepEzXS2AJpinzGANb3JwLvwujlOkmR8fiR9c=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=f1IPgPBLe6ulCmgGzN3F5BcI4COpxk8yzFVRRIeODXFX5FcipBfB7RDd6qlzWtY4pGDeso1A1XMH/kzIw5ffZ6l0f/2b2VToE86DtxJJTuiEyYrDGB9hz7b2S2J2dyc0G5l2H0PUeRkbREo9RUBE8H5VGBWqE7lOLL72lJGQZt9OMiVVYBO1rh1+fuzdp24bVBt4y+CzM64mPlVWYtz3gsjq03l/hRv4Nuo7TT6RYfp1MEo4NSjcwN5MNv8ByZLGvXDn+F8Ufai8KEkMSaEEnHApszXw6Gv8C5QL0Ylvk/uZ13oa7lu/aWw2CTeDbjePx2DHKF/K1/QGHLfPshb3iQ==
X-YMail-OSG: QK3bPe8VM1nBD3IkcVqKcE1CeEqkoBbcQD_g2dlMLxvI3pEPFr_qgTEq6GKr8zI
 njy2XlzfXG6Do.RT4iLWQAUNUIQcO660FpFaIIcmQaaheSJ8Uo29F72_BZrXFaPdc9cQYBLKCy2P
 KIhhY4SDX2jI2dC.BK__OlNwCd7iC4KCg1xYZRrGsxK_yyHM_aElRBdu0vOL3AHxHWQ80xfyGr5t
 AedjrCQ9lF4Qove.jnkzT544XUZXYkFM.uh0wVy4q59YtqcgQkNLR81YdJljXyVhE_U5XVgWEC.a
 uA8D4PN1JgbnB7fwSktM06VRjWIjFIV4hNOv9bth848uHF4J7IOUyRqus4QrKcSQRKXxrgeXDRYB
 vZtH13Fusz9.3s7aGtZsq1ubKFPcMFEeKfScQ5oRBJhTZvqYKUHlNgWZlgMrVWZ0DuXxqlpmHE55
 tlNL6aejuyoFjpSza0R8f8VHPhLTrRXYx_vmE.8Wy4aIsweASHVnViLHNwHRZbt1kpuJieXhC40J
 8zPmW23XcgEjia9LX1.JHGjeGqF55NHpClzSKvtn.mS.UagBEDcrOMzclHIYTNX6l2EH0YQlWURE
 PwdTsZfAIUZ7AChHR6J2JyTkZlPUk5A1CE9P6udd9PX.7SzOpDO6fPnP61no_yxXstWfaOY2cHIK
 iYfT29l2m1Z9Sl3luokeN3drzN419QJKl1vd6oXkKDHraqBZpbABVqQSuVFYmW6Ehslq3ug5Z3UV
 7bAH4qBC9N0B8W801Rmsh4LxkUKJ8HoQYOP9Ls4LH6D.Bx6TQ_K1a6L7_S0azqDbtgiZbOJ.9HTO
 V4GbNS7AAN.syhqah2o0hR_DAQ.zxX.6o9iF2nt0mUhJR5Wn7AgcHCUsci.jJDaAMWvdT6HHb5eP
 mkUfQYpaf096ekIDcvEBv3p3Av2N_S3gDqvQOzXHUKnY92wKDoDR9ZcVoeiaNVqUa.QkVVUecVTU
 peNrNGFXAYajjq9V17vtkUmbII_MG7MtQkgnd4QkBuQBPRiRcgmZ6Elz0VONitZtZ1oatKr7x5K1
 ARcHSi82YDLwy4rSAAdn1I2sF1vMIA5UzOCzsS6uuQPos4GEAgm6uzVEXTfCaBgdC7GUrOnLawTS
 gBJhsRzeuiyctoLQTatOxvPu9QdlbutSpy1ICqvAkWYLmg6ufFC4U.1fbSZ6IT66sd34gb2D0f39
 qmxhNpTEYeu1LWCr8vaHmHCfu4jTMIZdXmXlhzNGoHNAApL2Q7s7icyJ3vYMQOZwyMNN7.SSQIwP
 O2DYMnXw8mEcZq6HbkigHtRn.5kDYLTRZlrRoZd3LGFT52I8SwifchIGMt_cK1K0p4BDMVNMmxA0
 9_PcSb2aO2r8SOGZ2oIW_TikmX7BAbwp8qaA4qHTTnw3S9AC.00RjZD5VpBQpS7Q9Bx3NROiA3YX
 0s0gfMjodmRPlBWrAf09ZiLq0FFU_yx1TdSOPOhrGM20s6D4qAfjkO4.6YlRRxFHwO_y4Yd4v5rO
 0AbZk5SlQ9UD03gHvHiZul.Qoi9jjUEABx6ZibUCi50Udrimc.bI0A4L4_UYmx0HU4bOcHZU9WFc
 x7xBjaShENG2Bk7U2ePgRt41DBn24hgKfIQoTqzw0SNmTtlkLRq2G9T_VQ1Qm3F_vcmh3mqBIsXG
 A_KSwwHgg2YUGHZ7Jh217RrT7od_v0bMZdDm2sOS84M_nTpDjVqwHyhJrQ7V8K17HEAHmcmIgJCF
 n.RJHTwvNFG3AUgsqgx_XPjUYP6AIYjxKeSg3N4sVKfaS_QyPZmAgO5LCb6NXi5Hk42SeaYKtZ5D
 8efjOjA70m962uLQengNIpvQTllkH3ji6YLEgXe8OAlnEhxLjXdaGvVA46.Xzb_hB7O9y038XRhx
 fZbqmXVgp8TjhxHSe.iUMfOur79c1H1ixe2bYWVhJseDYVjTNPtgSSLNjq5la5BT2QJIS6gBxBDM
 5Aqwrh7DfX_nMyS5MyYXK0P187gIWY0DyoCcPCB_taBbfb6tYLRqpED1KMKn_Edo3Cd495rapaXp
 602OiOLKNdBnmMv9N8Cdoc6J0bybpI0PYNiIrLORQTCYDLbqnIhYt2DgDLwgsK3WZWPyDfic2KPU
 IpF47J6DHuVc.rgg96CvowFYZHnjAF6kROS9zqK0B3k2YpsgjjfX7643H4jgH5jmJ9FRyeCsQuSH
 dvAmqzX_huQF3WesQ1j3220hNFazYm5aG2EFeYkzql3A0XABUmHEdRLX4FRowQ.bTTpXgO5Z2RWm
 P5o43Abd9viKjJ._TJqpQNojELUTwtB.h55KarLT5hBbHyjVaeGdJbTcciTEnzqbaxw--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: cb7628ac-bc01-4a3e-b309-f3da2994350c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 6 Nov 2024 22:28:04 +0000
Received: by hermes--production-ne1-bfc75c9cd-7d68l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1b186cb4fb272125cf52ebbf6efc75e0;
          Wed, 06 Nov 2024 22:28:03 +0000 (UTC)
Message-ID: <7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com>
Date: Wed, 6 Nov 2024 16:12:48 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic with niu module
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20241104234412.GA1446170@bhelgaas> <87fro4pe6i.ffs@tglx>
 <973e2e20-51d9-4fe4-a361-0e07bcf95bab@yahoo.com> <87cyj8p8tq.ffs@tglx>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <87cyj8p8tq.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/6/24 11:32, Thomas Gleixner wrote:
> On Wed, Nov 06 2024 at 10:04, dullfire@yahoo.com wrote:
>>> 7d5ec3d36123 had the mask_all() invocation _before_ setting up the the
>>> entries and reading back the descriptors. So that commit cannot break
>>> the niu device when your problem analysis is correct.
>>
>> In 7d5ec3d36123 (and later) msix_mask_all() only writes to
>> PCI_MSIX_ENTRY_VECTOR_CTRL. I have tried all the MSIX registers, and only
>> writes to PCI_MSIX_ENTRY_DATA were able to prevent a fatal trap on a read.
>> However the only write to PCI_MSIX_ENTRY_DATA I see is in
>> __pci_write_msi_msg() for 7d5ec3d36123, or pci_write_msg_msix(), in 6.11.5.
>
> Yuck. They really went a great lenght to make this hard to handle.
>
> Something like the obviously uncompiled below should work.
>
> Thanks,
>
>         tglx
> ---
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -611,6 +611,8 @@ void msix_prepare_msi_desc(struct pci_de
>  	if (desc->pci.msi_attrib.can_mask) {
>  		void __iomem *addr = pci_msix_desc_addr(desc);
>
> +		if (dev->dev_flags & PCI_MSIX_TOUCH_ENTRY_DATA_FIRST)
> +			writel(0x0, addr + PCI_MSIX_ENTRY_DATA);
>  		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  	}
>  }
>
Great. Thanks for the recommendation. That is similar to my first patch
approach. I had see struct pci_dev's bit field members, but missed the
dev_flags member. I'll probably have a patch set out in the next few days,
mostly pending my schedule, and reviewing the patch submission process.


Regards,
Jonathan Currier

